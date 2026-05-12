<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
        }

        /* ── Navbar ── */
        .navbar {
            background: #2c3e50;
            color: white;
            padding: 14px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }
        .navbar h2 { font-size: 18px; font-weight: 600; }
        .navbar-right { display: flex; align-items: center; gap: 16px; }
        .user-info   { display: flex; align-items: center; gap: 10px; font-size: 14px; }
        .role-badge  {
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }
        .role-admin { background: #e74c3c; }
        .role-user  { background: #3498db; }
        .btn-nav {
            padding: 7px 16px;
            background: rgba(255,255,255,0.15);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 13px;
            transition: background 0.2s;
        }
        .btn-nav:hover { background: rgba(255,255,255,0.28); }
        .btn-logout {
            padding: 7px 16px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 13px;
            transition: background 0.2s;
        }
        .btn-logout:hover { background: #c0392b; }

        .container {
            max-width: 1200px;
            margin: 28px auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        h1 { color: #2c3e50; margin-bottom: 20px; font-size: 26px; }

        .message {
            padding: 12px 16px;
            border-radius: 5px;
            margin-bottom: 18px;
            font-size: 14px;
            font-weight: 500;
        }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error   { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        .toolbar {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: center;
            margin-bottom: 16px;
        }
        .search-box {
            display: flex;
            align-items: center;
            gap: 8px;
            flex: 1;
            min-width: 220px;
            border: 2px solid #ddd;
            border-radius: 5px;
            padding: 9px 14px;
            transition: border-color 0.3s;
        }
        .search-box:focus-within { border-color: #667eea; }
        .search-box input[type="text"] {
            flex: 1; border: none; outline: none;
            font-size: 14px; background: transparent; color: #333;
        }
        .filter-box {
            display: flex;
            align-items: center;
            gap: 8px;
            border: 2px solid #ddd;
            border-radius: 5px;
            padding: 9px 14px;
            transition: border-color 0.3s;
        }
        .filter-box:focus-within { border-color: #667eea; }
        .filter-box label { font-size: 13px; color: #555; white-space: nowrap; font-weight: 500; }
        .filter-box select {
            border: none; outline: none; font-size: 14px;
            color: #333; cursor: pointer; background: transparent;
        }
        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s;
            white-space: nowrap;
        }
        .btn-primary  { background: linear-gradient(135deg,#667eea,#764ba2); color: white; }
        .btn-primary:hover { opacity: 0.9; transform: translateY(-1px); }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-secondary:hover { background: #5a6268; }
        .btn-success  { background: #27ae60; color: white; }
        .btn-success:hover { background: #219a52; }
        .btn-danger   { background: #dc3545; color: white; }
        .btn-danger:hover { background: #c82333; }

        .active-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            align-items: center;
            margin-bottom: 14px;
            font-size: 13px;
            color: #555;
        }
        .filter-badge {
            background: #f0f1ff;
            border: 1px solid #c5cbf5;
            color: #3d4db7;
            border-radius: 20px;
            padding: 4px 12px;
            font-size: 12px;
            font-weight: 500;
        }

        /* ── Add button row ── */
        .action-bar { margin-bottom: 18px; }

        /* ── Table ── */
        table { width: 100%; border-collapse: collapse; margin-top: 8px; }
        thead { background: linear-gradient(135deg,#667eea,#764ba2); color: white; }
        th, td { padding: 13px 15px; text-align: left; border-bottom: 1px solid #e8e8e8; }
        th { font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600; }
        th a { color: white; text-decoration: none; display: inline-flex; align-items: center; gap: 5px; }
        th a:hover { text-decoration: underline; }
        tbody tr:hover { background: #f8f9fa; }

        .empty-state { text-align: center; padding: 60px 20px; color: #999; }
        .empty-state-icon { font-size: 56px; margin-bottom: 16px; }

        /* ── Pagination ── */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            margin-top: 28px;
            flex-wrap: wrap;
        }
        .pagination a, .pagination span {
            display: inline-block;
            padding: 9px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            color: #667eea;
            transition: all 0.2s;
        }
        .pagination a:hover {
            background: linear-gradient(135deg,#667eea,#764ba2);
            color: white;
            border-color: #667eea;
        }
        .pagination .active-page {
            background: linear-gradient(135deg,#667eea,#764ba2);
            color: white;
            border-color: #667eea;
        }
        .pagination .disabled { color: #ccc; border-color: #eee; pointer-events: none; }
        .pagination-info { text-align: center; margin-top: 10px; font-size: 13px; color: #888; }
    </style>
</head>
<body>

    <!-- ── Navigation Bar ── -->
    <div class="navbar">
        <h2>📚 Student Management System</h2>
        <div class="navbar-right">
            <div class="user-info">
                <span>Welcome, ${sessionScope.fullName}</span>
                <span class="role-badge role-${sessionScope.role}">${sessionScope.role}</span>
            </div>
            <a href="dashboard" class="btn-nav">Dashboard</a>
            <a href="logout"    class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h1>📋 Student List</h1>

        <c:if test="${not empty param.message}">
            <div class="message success">✅ ${param.message}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="message error">❌ ${param.error}</div>
        </c:if>

        <div class="toolbar">
            <!-- Search -->
            <form class="search-box" action="${pageContext.request.contextPath}/student" method="get">
                <input type="hidden" name="action" value="search">
                <span>🔍</span>
                <input type="text" name="keyword" value="${keyword}" placeholder="Search name, code, email…">
                <button type="submit" class="btn-sm btn-primary">Search</button>
                <c:if test="${not empty keyword}">
                    <a class="btn-sm btn-secondary"
                       href="${pageContext.request.contextPath}/student?action=list">✕ Clear</a>
                </c:if>
            </form>

            <form class="filter-box" action="${pageContext.request.contextPath}/student" method="get">
                <input type="hidden" name="action" value="filter">
                <label>🎓 Major:</label>
                <select name="major" onchange="this.form.submit()">
                    <option value="">All Majors</option>
                    <option value="Computer Science"
                            ${selectedMajor == 'Computer Science'        ? 'selected' : ''}>Computer Science</option>
                    <option value="Information Technology"
                            ${selectedMajor == 'Information Technology'  ? 'selected' : ''}>Information Technology</option>
                    <option value="Software Engineering"
                            ${selectedMajor == 'Software Engineering'    ? 'selected' : ''}>Software Engineering</option>
                    <option value="Business Administration"
                            ${selectedMajor == 'Business Administration' ? 'selected' : ''}>Business Administration</option>
                </select>
                <c:if test="${not empty selectedMajor}">
                    <a class="btn-sm btn-secondary"
                       href="${pageContext.request.contextPath}/student?action=list">✕</a>
                </c:if>
            </form>
        </div>

        <div class="active-filters">
            <c:if test="${not empty keyword}">
                <span class="filter-badge">🔎 "${keyword}"</span>
            </c:if>
            <c:if test="${not empty selectedMajor}">
                <span class="filter-badge">🎓 ${selectedMajor}</span>
            </c:if>
            <c:if test="${not empty sortBy}">
                <span class="filter-badge">↕ ${sortBy} ${order}</span>
            </c:if>
            <c:if test="${not empty totalRecords}">
                <span style="margin-left:auto; color:#888;">Total: ${totalRecords} student(s)</span>
            </c:if>
        </div>

        <c:if test="${sessionScope.role eq 'admin'}">
            <div class="action-bar">
                <a href="${pageContext.request.contextPath}/student?action=new"
                   class="btn-sm btn-success">➕ Add New Student</a>
            </div>
        </c:if>

        <!-- ── Student table ── -->
        <c:choose>
            <c:when test="${not empty students}">
                <table>
                    <thead>
                        <tr>
                            <th>
                                <a href="${pageContext.request.contextPath}/student?action=sort
                                        &sortBy=id
                                        &order=${sortBy=='id' && order=='asc' ? 'desc' : 'asc'}">
                                    ID <c:if test="${sortBy=='id'}">${order=='asc'?'▲':'▼'}</c:if>
                                </a>
                            </th>
                            <th>
                                <a href="${pageContext.request.contextPath}/student?action=sort
                                        &sortBy=student_code
                                        &order=${sortBy=='student_code' && order=='asc' ? 'desc' : 'asc'}">
                                    Code <c:if test="${sortBy=='student_code'}">${order=='asc'?'▲':'▼'}</c:if>
                                </a>
                            </th>
                            <th>
                                <a href="${pageContext.request.contextPath}/student?action=sort
                                        &sortBy=full_name
                                        &order=${sortBy=='full_name' && order=='asc' ? 'desc' : 'asc'}">
                                    Full Name <c:if test="${sortBy=='full_name'}">${order=='asc'?'▲':'▼'}</c:if>
                                </a>
                            </th>
                            <th>
                                <a href="${pageContext.request.contextPath}/student?action=sort
                                        &sortBy=email
                                        &order=${sortBy=='email' && order=='asc' ? 'desc' : 'asc'}">
                                    Email <c:if test="${sortBy=='email'}">${order=='asc'?'▲':'▼'}</c:if>
                                </a>
                            </th>
                            <th>
                                <a href="${pageContext.request.contextPath}/student?action=sort
                                        &sortBy=major
                                        &order=${sortBy=='major' && order=='asc' ? 'desc' : 'asc'}">
                                    Major <c:if test="${sortBy=='major'}">${order=='asc'?'▲':'▼'}</c:if>
                                </a>
                            </th>
                            <!-- Actions column header — admin only -->
                            <c:if test="${sessionScope.role eq 'admin'}">
                                <th>Actions</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${students}">
                            <tr>
                                <td>${student.id}</td>
                                <td>${student.studentCode}</td>
                                <td>${student.fullName}</td>
                                <td>${student.email}</td>
                                <td>${student.major}</td>
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <td>
                                        <a href="${pageContext.request.contextPath}/student?action=edit&id=${student.id}"
                                           class="btn-sm btn-primary">✏️ Edit</a>
                                        <a href="${pageContext.request.contextPath}/student?action=delete&id=${student.id}"
                                           class="btn-sm btn-danger"
                                           onclick="return confirm('Delete ${student.fullName}? This cannot be undone.');">
                                           🗑 Delete</a>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- ── Pagination ── -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:choose>
                            <c:when test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/student?action=list&page=${currentPage - 1}"><- Prev</a>
                            </c:when>
                            <c:otherwise><span class="disabled"><- Prev</span></c:otherwise>
                        </c:choose>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="active-page">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/student?action=list&page=${i}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:choose>
                            <c:when test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/student?action=list&page=${currentPage + 1}">Next -></a>
                            </c:when>
                            <c:otherwise><span class="disabled">Next -></span></c:otherwise>
                        </c:choose>
                    </div>
                    <p class="pagination-info">
                        Page ${currentPage} of ${totalPages}
                        &nbsp;·&nbsp; ${totalRecords} total records, ${students.size()} shown
                    </p>
                </c:if>
            </c:when>

            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <h3>No students found</h3>
                    <p>Try adjusting your search or filter, or add a new student.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div><!-- /container -->

</body>
</html>
