CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS users;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_code VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    major VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO students (student_code, full_name, email, major) VALUES
('SV001', 'Nguyen Van A',  'a.nguyen@example.com', 'Computer Science'),
('SV002', 'Tran Thi B',    'b.tran@example.com',   'Information Technology'),
('SV003', 'Le Van C',      'c.le@example.com',     'Software Engineering'),
('SV004', 'Pham Thi D',    'd.pham@example.com',   'Business Administration'),
('SV005', 'Hoang Van E',   'e.hoang@example.com',  'Computer Science'),
('IT001', 'Do Thi F',      'f.do@example.com',     'Information Technology'),
('IT002', 'Bui Van G',     'g.bui@example.com',    'Software Engineering');

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL
);

INSERT INTO users (username, password, full_name, role) VALUES
('admin', '$2a$10$sTpH1KCTXdXIGNKgcZuglO9zCwkdeiVe8wTEN5cH0FgxAqFfvYuoy', 'Admin User', 'admin'),
('john', '$2a$10$PlkC8FTcxijLtdpjGD3jVeNesi0AOoi/1HQlXjDYUcpSD5Ak.dEQm', 'John Doe', 'user'),
('jane', '$2a$10$l0xLwa4jC3VYDkihHck9Lu89l4CAH5/05ZJynj94R.WTh.dWByF3S', 'Jane Smith', 'user');
