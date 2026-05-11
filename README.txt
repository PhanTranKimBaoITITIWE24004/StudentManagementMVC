STUDENT INFORMATION:
Name: Phan Tran Kim Bao
Student ID: ITITIWE24004
Class: Web Application Development_S2_2025-26_G02_lab01

COMPLETED EXERCISES:
[x] Exercise 1: Database & User Model (users table + BCrypt hashes)
[x] Exercise 2: User Model & DAO (User.java, UserDAO.java)
[x] Exercise 3: Login/Logout Controllers
[x] Exercise 4: Views & Dashboard (login.jsp, dashboard.jsp, DashboardController)
[x] Exercise 5: Authentication Filter (AuthFilter.java)
[x] Exercise 6: Admin Authorization Filter (AdminFilter.java)
[x] Exercise 7: Role-Based UI (student-list.jsp rebuilt)
[ ] Exercise 8: Change Password (not implemented)

AUTHENTICATION COMPONENTS:
- Models:      User.java
- DAOs:        UserDAO.java
- Controllers: LoginController.java, LogoutController.java, DashboardController.java
- Filters:     AuthFilter.java, AdminFilter.java
- Views:       login.jsp, dashboard.jsp, student-list.jsp (updated), student-form.jsp (updated)

TEST CREDENTIALS:
Admin:
  Username: admin / Password: password123
Regular Users:
  Username: john  / Password: password123
  Username: jane  / Password: password123

FEATURES IMPLEMENTED:
- BCrypt password hashing (UserDAO.authenticate uses BCrypt.checkpw)
- Session management: create on login, invalidate on logout, 30-min timeout
- Login/Logout with error and success messages
- Dashboard with student count and role-based quick actions
- AuthFilter: protects all URLs except /login, /logout, and static assets
- AdminFilter: blocks new/insert/edit/update/delete actions for non-admin users
- Role-based UI: Add/Edit/Delete buttons hidden for regular users
- Student list retains search, filter, sort, and pagination features from Lab 5
- Navbar with user name, role badge, Dashboard link, and Logout on all protected pages
- student-form.jsp updated with navbar and inline validation error messages

SECURITY MEASURES:
- BCrypt password hashing (never plain text)
- Session regeneration after login (old session invalidated, new one created)
- Session timeout: 30 minutes (also set in web.xml)
- PreparedStatement throughout (SQL injection prevention)
- Server-side input validation
- XSS prevention via JSTL ${...} auto-escaping
- @WebFilter annotations protect pages at servlet-container level

FILES CHANGED / ADDED FOR LAB 6:
  NEW:  src/main/java/com/student/model/User.java
  NEW:  src/main/java/com/student/dao/UserDAO.java
  NEW:  src/main/java/com/student/controller/LoginController.java
  NEW:  src/main/java/com/student/controller/LogoutController.java
  NEW:  src/main/java/com/student/controller/DashboardController.java
  NEW:  src/main/java/com/student/filter/AuthFilter.java
  NEW:  src/main/java/com/student/filter/AdminFilter.java
  NEW:  src/main/webapp/views/login.jsp
  NEW:  src/main/webapp/views/dashboard.jsp
  MOD:  src/main/webapp/views/student-list.jsp  (navbar + role-based UI)
  MOD:  src/main/webapp/views/student-form.jsp  (navbar added)
  MOD:  student_management.sql                  (users table added)

KNOWN ISSUES:
- Search and filter pages do not apply pagination (same as Lab 5)
- No CSRF token implemented

TIME SPENT: Approximately 3 hours (Lab 6 additions on top of Lab 5 base)

TESTING NOTES:
1. Login without credentials -> error message shown
2. Login as admin -> dashboard -> student list shows Edit/Delete buttons
3. Login as john (user) -> student list shows no Edit/Delete, no Add button
4. While logged in as john, open URL /student?action=new -> AdminFilter redirects with error
5. Logout -> session destroyed, login page shows success message
6. Access /dashboard directly after logout -> AuthFilter redirects to /login