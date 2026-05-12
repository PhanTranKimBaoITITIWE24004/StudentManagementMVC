package com.student.dao;

import com.student.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class StudentDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Baocuto102";

    private static final List<String> VALID_SORT_COLUMNS =
        Arrays.asList("id", "student_code", "full_name", "email", "major");

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
    }

    private Student mapRow(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setId(rs.getInt("id"));
        s.setStudentCode(rs.getString("student_code"));
        s.setFullName(rs.getString("full_name"));
        s.setEmail(rs.getString("email"));
        s.setMajor(rs.getString("major"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        return s;
    }

    private String validateSortBy(String sortBy) {
        return (sortBy != null && VALID_SORT_COLUMNS.contains(sortBy)) ? sortBy : "id";
    }

    private String validateOrder(String order) {
        return "desc".equalsIgnoreCase(order) ? "DESC" : "ASC";
    }

    // Existing CRUD
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY id DESC";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) students.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return students;
    }

    public Student getStudentById(int id) {
        String sql = "SELECT * FROM students WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement p = conn.prepareStatement(sql)) {
            p.setInt(1, id);
            ResultSet rs = p.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean addStudent(Student student) {
        String sql = "INSERT INTO students (student_code,full_name,email,major) VALUES(?,?,?,?)";
        try (Connection conn = getConnection();
             PreparedStatement p = conn.prepareStatement(sql)) {
            p.setString(1, student.getStudentCode());
            p.setString(2, student.getFullName());
            p.setString(3, student.getEmail());
            p.setString(4, student.getMajor());
            return p.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean updateStudent(Student student) {
        String sql = "UPDATE students SET student_code=?,full_name=?,email=?,major=? WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement p = conn.prepareStatement(sql)) {
            p.setString(1, student.getStudentCode());
            p.setString(2, student.getFullName());
            p.setString(3, student.getEmail());
            p.setString(4, student.getMajor());
            p.setInt(5, student.getId());
            return p.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement p = conn.prepareStatement(sql)) {
            p.setInt(1, id);
            return p.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Student> searchStudents(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) return getAllStudents();
        List<Student> students = new ArrayList<>();
        String pattern = "%" + keyword.trim() + "%";
        String sql = "SELECT * FROM students WHERE student_code LIKE ? OR full_name LIKE ? OR email LIKE ? ORDER BY id DESC";
        try (Connection conn = getConnection();
             PreparedStatement p = conn.prepareStatement(sql)) {
            p.setString(1, pattern); p.setString(2, pattern); p.setString(3, pattern);
            ResultSet rs = p.executeQuery();
            while (rs.next()) students.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return students;
    }

    public List<Student> getStudentsSorted(String sortBy, String order) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY " + validateSortBy(sortBy) + " " + validateOrder(order);
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) students.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return students;
    }

    public List<Student> getStudentsByMajor(String major) {
        if (major == null || major.trim().isEmpty()) return getAllStudents();
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE major = ? ORDER BY id DESC";
        try (Connection conn = getConnection();
             PreparedStatement p = conn.prepareStatement(sql)) {
            p.setString(1, major.trim());
            ResultSet rs = p.executeQuery();
            while (rs.next()) students.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return students;
    }


    //Returns the total number of students — used to calculate totalPages.
    public int getTotalStudents() {
        String sql = "SELECT COUNT(*) FROM students";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    
     //Returns one page of students.
    public List<Student> getStudentsPaginated(int offset, int limit) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY id DESC LIMIT ? OFFSET ?";

        try (Connection conn = getConnection();
             PreparedStatement p = conn.prepareStatement(sql)) {

            p.setInt(1, limit);   // how many rows
            p.setInt(2, offset);  // starting position
            ResultSet rs = p.executeQuery();
            while (rs.next()) students.add(mapRow(rs));

        } catch (SQLException e) { e.printStackTrace(); }
        return students;
    }
}