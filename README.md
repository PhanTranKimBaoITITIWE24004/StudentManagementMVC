STUDENT INFORMATION:
- Name: Phan Tran Kim Bao
- Student ID: ITITIWE24004
- Class: Web Application Development_S2_2025-26_G02_lab01

COMPLETED EXERCISES:
- [x] Exercise 5: Search
- [x] Exercise 6: Validation
- [x] Exercise 7: Sorting & Filtering
- [X] Exercise 8: Pagination

MVC COMPONENTS:
- Model: Student.java
- DAO: StudentDAO.java
- Controller: StudentController.java
- Views: student-list.jsp, student-form.jsp

FEATURES IMPLEMENTED:
- All CRUD operations (Create, Read, Update, Delete)
- Search functionality (searches student_code, full_name, email using LIKE)
- Server-side validation (student code format, full name length, email format, major required)
- Sorting by columns (id, student_code, full_name, email, major ascending and descending)
- Filter by major (Computer Science, Information Technology, Software Engineering, Business Administration)

KNOWN ISSUES:
- Only show student list after search or filter

EXTRA FEATURES:
- mapRow() helper method in StudentDAO to eliminate duplicated ResultSet mapping code
- Sort direction toggles automatically when clicking the same column header again
- Search keyword and selected major filter are preserved in the UI after submission
- "Clear" button for search and filter appears only when they are active
- Validation errors highlight the specific input field with a red border in addition to showing the error message
- Form data is preserved when validation fails (user does not lose their input)
- getStudentsFiltered() in StudentDAO supports combined keyword + major + sort in a single safe dynamic query

TIME SPENT: Approximately 7 hours
