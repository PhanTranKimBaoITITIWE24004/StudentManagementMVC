package com.student.controller;

import java.io.IOException;
import java.util.List;

import com.student.dao.StudentDAO;
import com.student.model.Student;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/student")
public class StudentController extends HttpServlet {

    private StudentDAO studentDAO;

    private static final int RECORDS_PER_PAGE = 5;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":    showNewForm(request, response);    break;
            case "edit":   showEditForm(request, response);   break;
            case "delete": deleteStudent(request, response);  break;
            case "search": searchStudents(request, response); break;
            case "sort":   sortStudents(request, response);   break;
            case "filter": filterStudents(request, response); break;
            default:       listStudents(request, response);   break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action) {
            case "insert": insertStudent(request, response); break;
            case "update": updateStudent(request, response); break;
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parse page number (default 1)
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try { currentPage = Integer.parseInt(pageParam); }
            catch (NumberFormatException ignored) {}
        }

        // Total records to total pages
        int totalRecords = studentDAO.getTotalStudents();
        int totalPages   = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Clamp current page to valid range
        if (currentPage < 1)           currentPage = 1;
        if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;

        // Fetch one page of data
        int offset = (currentPage - 1) * RECORDS_PER_PAGE;
        List<Student> students = studentDAO.getStudentsPaginated(offset, RECORDS_PER_PAGE);

        // Set all pagination attributes for the view
        request.setAttribute("students",    students);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages",  totalPages);
        request.setAttribute("totalRecords", totalRecords);

        dispatch(request, response, "/views/student-list.jsp");
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        dispatch(request, response, "/views/student-form.jsp");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        request.setAttribute("student", studentDAO.getStudentById(id));
        dispatch(request, response, "/views/student-form.jsp");
    }

    private void searchStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        request.setAttribute("keyword",  keyword);
        request.setAttribute("students", studentDAO.searchStudents(keyword));
        dispatch(request, response, "/views/student-list.jsp");
    }

    private void sortStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sortBy = request.getParameter("sortBy");
        String order  = request.getParameter("order");
        request.setAttribute("students", studentDAO.getStudentsSorted(sortBy, order));
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("order",  order);
        dispatch(request, response, "/views/student-list.jsp");
    }

    private void filterStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String major = request.getParameter("major");
        request.setAttribute("students",      studentDAO.getStudentsByMajor(major));
        request.setAttribute("selectedMajor", major);
        dispatch(request, response, "/views/student-list.jsp");
    }

    private boolean validateStudent(Student student, HttpServletRequest request) {
        boolean isValid = true;
        String code = student.getStudentCode();
        if (code == null || code.trim().isEmpty()) {
            request.setAttribute("errorCode", "Student code is required."); isValid = false;
        } else if (!code.matches("[A-Z]{2}[0-9]{3,}")) {
            request.setAttribute("errorCode", "Use 2 uppercase letters + 3+ digits (e.g., SV001)."); isValid = false;
        }
        String name = student.getFullName();
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorName", "Full name is required."); isValid = false;
        } else if (name.trim().length() < 2) {
            request.setAttribute("errorName", "Minimum 2 characters."); isValid = false;
        }
        String email = student.getEmail();
        if (email != null && !email.trim().isEmpty() && !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("errorEmail", "Please enter a valid email address."); isValid = false;
        }
        if (student.getMajor() == null || student.getMajor().trim().isEmpty()) {
            request.setAttribute("errorMajor", "Please select a major."); isValid = false;
        }
        return isValid;
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Student s = buildStudent(request);
        if (!validateStudent(s, request)) {
            request.setAttribute("student", s);
            dispatch(request, response, "/views/student-form.jsp"); return;
        }
        response.sendRedirect(studentDAO.addStudent(s)
                ? "student?action=list&message=Student added successfully"
                : "student?action=list&error=Failed to add student");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Student s = buildStudent(request);
        s.setId(Integer.parseInt(request.getParameter("id")));
        if (!validateStudent(s, request)) {
            request.setAttribute("student", s);
            dispatch(request, response, "/views/student-form.jsp"); return;
        }
        response.sendRedirect(studentDAO.updateStudent(s)
                ? "student?action=list&message=Student updated successfully"
                : "student?action=list&error=Failed to update student");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        response.sendRedirect(studentDAO.deleteStudent(id)
                ? "student?action=list&message=Student deleted successfully"
                : "student?action=list&error=Failed to delete student");
    }

    private Student buildStudent(HttpServletRequest request) {
        return new Student(
            request.getParameter("studentCode"),
            request.getParameter("fullName"),
            request.getParameter("email"),
            request.getParameter("major")
        );
    }

    private void dispatch(HttpServletRequest req, HttpServletResponse res, String path)
            throws ServletException, IOException {
        req.getRequestDispatcher(path).forward(req, res);
    }
}
