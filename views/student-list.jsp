<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - MVC</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 32px;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-style: italic;
        }
        
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }
        
        tbody tr {
            transition: background-color 0.2s;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .actions {
            display: flex;
            gap: 10px;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        
        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        
        .info {
            background-color: #e8eaff;
            color: #3d4db7;
            border: 1px solid #c5cbf5;
        }

        .toolbar {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-box {
            display: flex;
            align-items: center;
            gap: 8px;
            flex: 1;
            min-width: 220px;
            border: 2px solid #ddd;
            border-radius: 5px;
            padding: 10px 14px;
            transition: border-color 0.3s;
        }

        .search-box:focus-within {
            border-color: #667eea;
        }

        .search-box input[type="text"] {
            flex: 1;
            border: none;
            outline: none;
            font-size: 14px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            background: transparent;
        }

        .filter-box {
            display: flex;
            align-items: center;
            gap: 8px;
            border: 2px solid #ddd;
            border-radius: 5px;
            padding: 10px 14px;
            transition: border-color 0.3s;
        }

        .filter-box:focus-within {
            border-color: #667eea;
        }

        .filter-box label {
            font-size: 13px;
            color: #555;
            white-space: nowrap;
            font-weight: 500;
        }

        .filter-box select {
            border: none;
            outline: none;
            font-size: 14px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            cursor: pointer;
            background: transparent;
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
            transition: all 0.3s;
        }

        .btn-sm.btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 16px;
        }

        .btn-sm.btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        th a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        th a:hover {
            text-decoration: underline;
        }

        .sort-icon {
            font-size: 11px;
            opacity: 0.9;
        }

        .active-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            align-items: center;
            margin-bottom: 16px;
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

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .pagination a,
        .pagination span {
            display: inline-block;
            padding: 10px 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            color: #667eea;
            transition: all 0.3s;
        }

        .pagination a:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
            transform: translateY(-1px);
            box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
        }

        .pagination .active-page {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
        }

        .pagination .disabled {
            color: #ccc;
            border-color: #eee;
            cursor: default;
            pointer-events: none;
        }

        .pagination-info {
            text-align: center;
            margin-top: 12px;
            font-size: 13px;
            color: #888;
        }
    </style>
</head>
<div class="container">
    <h1>📚 Student Management System</h1>
    <p class="subtitle">MVC Pattern with Jakarta EE &amp; JSTL</p>

    <c:if test="${not empty param.message}">
        <div class="message success">✅ ${param.message}</div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="message error">❌ ${param.error}</div>
    </c:if>

    <%-- Toolbar: search + filter --%>
    <div class="toolbar">
        <form class="search-box" action="${pageContext.request.contextPath}/student" method="get">
            <input type="hidden" name="action" value="search">
            <span>🔍</span>
            <input type="text" name="keyword" value="${keyword}" placeholder="Search name, code, email…">
            <button type="submit" class="btn-sm btn-primary">Search</button>
            <c:if test="${not empty keyword}">
                <a class="btn-sm btn-secondary" href="${pageContext.request.contextPath}/student?action=list">✕</a>
            </c:if>
        </form>

        <form class="filter-box" action="${pageContext.request.contextPath}/student" method="get">
            <input type="hidden" name="action" value="filter">
            <label style="font-size:13px;color:#555;white-space:nowrap;">🎓 Major:</label>
            <select name="major">
                <option value="">All Majors</option>
                <option value="Computer Science"         ${selectedMajor=='Computer Science'         ?'selected':''}>Computer Science</option>
                <option value="Information Technology"   ${selectedMajor=='Information Technology'   ?'selected':''}>Information Technology</option>
                <option value="Software Engineering"     ${selectedMajor=='Software Engineering'     ?'selected':''}>Software Engineering</option>
                <option value="Business Administration"  ${selectedMajor=='Business Administration'  ?'selected':''}>Business Administration</option>
            </select>
            <button type="submit" class="btn-sm btn-purple">Filter</button>
            <c:if test="${not empty selectedMajor}">
                <a class="btn-sm btn-gray" href="${pageContext.request.contextPath}/student?action=list">✕</a>
            </c:if>
        </form>
    </div>

    <div class="active-filters">
        <c:if test="${not empty keyword}">      <span class="badge">🔎 <strong>${keyword}</strong></span></c:if>
        <c:if test="${not empty selectedMajor}"><span class="badge">🎓 <strong>${selectedMajor}</strong></span></c:if>
        <c:if test="${not empty sortBy}">       <span class="badge">↕ <strong>${sortBy} ${order}</strong></span></c:if>
        <c:if test="${not empty totalRecords}">
            <span style="margin-left:auto;">Total: ${totalRecords} student(s)</span>
        </c:if>
    </div>

    <div style="margin-bottom:12px;">
        <a href="${pageContext.request.contextPath}/student?action=new" class="btn btn-primary">➕ Add New Student</a>
    </div>

    <c:choose>
        <c:when test="${not empty students}">
            <table>
                <thead>
                    <tr>
                        <th><a href="${pageContext.request.contextPath}/student?action=sort&sortBy=id&order=${sortBy=='id'&&order=='asc'?'desc':'asc'}">ID <c:if test="${sortBy=='id'}">${order=='asc'?'▲':'▼'}</c:if></a></th>
                        <th><a href="${pageContext.request.contextPath}/student?action=sort&sortBy=student_code&order=${sortBy=='student_code'&&order=='asc'?'desc':'asc'}">Code <c:if test="${sortBy=='student_code'}">${order=='asc'?'▲':'▼'}</c:if></a></th>
                        <th><a href="${pageContext.request.contextPath}/student?action=sort&sortBy=full_name&order=${sortBy=='full_name'&&order=='asc'?'desc':'asc'}">Full Name <c:if test="${sortBy=='full_name'}">${order=='asc'?'▲':'▼'}</c:if></a></th>
                        <th><a href="${pageContext.request.contextPath}/student?action=sort&sortBy=email&order=${sortBy=='email'&&order=='asc'?'desc':'asc'}">Email <c:if test="${sortBy=='email'}">${order=='asc'?'▲':'▼'}</c:if></a></th>
                        <th><a href="${pageContext.request.contextPath}/student?action=sort&sortBy=major&order=${sortBy=='major'&&order=='asc'?'desc':'asc'}">Major <c:if test="${sortBy=='major'}">${order=='asc'?'▲':'▼'}</c:if></a></th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${students}">
                        <tr>
                            <td>${student.id}</td>
                            <td><strong>${student.studentCode}</strong></td>
                            <td>${student.fullName}</td>
                            <td>${student.email}</td>
                            <td>${student.major}</td>
                            <td>
                                <div class="actions">
                                    <a href="${pageContext.request.contextPath}/student?action=edit&id=${student.id}" class="btn btn-secondary">✏️ Edit</a>
                                    <a href="${pageContext.request.contextPath}/student?action=delete&id=${student.id}" class="btn btn-danger"
                                       onclick="return confirm('Delete this student?')">🗑️ Delete</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${totalPages > 1}">
                <div class="pagination">

                    <%-- Previous button (disabled on page 1) --%>
                    <c:choose>
                        <c:when test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/student?action=list&page=${currentPage - 1}">Previous</a>
                        </c:when>
                        <c:otherwise>
                            <span class="disabled">Previous</span>
                        </c:otherwise>
                    </c:choose>

                    <%-- Page number links (highlight the active page) --%>
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

                    <%-- Next button (disabled on last page) --%>
                    <c:choose>
                        <c:when test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/student?action=list&page=${currentPage + 1}">Next</a>
                        </c:when>
                        <c:otherwise>
                            <span class="disabled">Next</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- Page info line --%>
                <p class="pagination-info">
                    Page ${currentPage} of ${totalPages}
                    (${totalRecords} total records, ${students.size()} shown)
                </p>
            </c:if>

        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-state-icon">📭</div>
                <h3>No students found</h3>
                <p>Try adjusting your search or filter</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
