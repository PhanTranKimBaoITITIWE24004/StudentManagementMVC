<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${student != null}">Edit Student</c:when>
            <c:otherwise>Add New Student</c:otherwise>
        </c:choose>
    </title>
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
        .user-info    { display: flex; align-items: center; gap: 10px; font-size: 14px; }
        .role-badge   {
            padding: 3px 10px; border-radius: 12px;
            font-size: 11px; font-weight: 700; text-transform: uppercase;
        }
        .role-admin { background: #e74c3c; }
        .role-user  { background: #3498db; }
        .btn-nav {
            padding: 7px 16px; background: rgba(255,255,255,0.15);
            color: white; text-decoration: none; border-radius: 5px; font-size: 13px;
            transition: background 0.2s;
        }
        .btn-nav:hover { background: rgba(255,255,255,0.28); }
        .btn-logout {
            padding: 7px 16px; background: #e74c3c;
            color: white; text-decoration: none; border-radius: 5px; font-size: 13px;
            transition: background 0.2s;
        }
        .btn-logout:hover { background: #c0392b; }

        /* ── Form card ── */
        .form-wrapper {
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }
        .form-card {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 6px 30px rgba(0,0,0,0.12);
            width: 100%;
            max-width: 580px;
        }
        h1 { color: #2c3e50; margin-bottom: 28px; font-size: 26px; text-align: center; }

        .form-group { margin-bottom: 22px; }
        label {
            display: block; margin-bottom: 6px;
            color: #555; font-weight: 500; font-size: 14px;
        }
        input[type="text"],
        input[type="email"],
        select {
            width: 100%; padding: 11px 14px;
            border: 2px solid #ddd; border-radius: 5px;
            font-size: 14px; transition: border-color 0.3s;
            font-family: inherit;
        }
        input:focus, select:focus { outline: none; border-color: #667eea; }
        .required { color: #dc3545; }
        .info-text { font-size: 12px; color: #888; margin-top: 4px; }

        /* Validation error highlight */
        .field-error { border-color: #dc3545 !important; }
        .error-msg   { color: #dc3545; font-size: 12px; margin-top: 4px; }

        .button-group { display: flex; gap: 14px; margin-top: 28px; }
        .btn {
            flex: 1; padding: 13px; border: none; border-radius: 5px;
            font-size: 15px; font-weight: 600; cursor: pointer;
            transition: all 0.2s; text-decoration: none; text-align: center;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(135deg,#667eea,#764ba2); color: white;
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .btn-cancel {
            background: #6c757d; color: white;
        }
        .btn-cancel:hover { background: #5a6268; }
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
            <a href="${pageContext.request.contextPath}/student?action=list" class="btn-nav">← Back to List</a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-nav">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="form-wrapper">
        <div class="form-card">
            <h1>
                <c:choose>
                    <c:when test="${student != null}">✏️ Edit Student</c:when>
                    <c:otherwise>➕ Add New Student</c:otherwise>
                </c:choose>
            </h1>

            <form action="${pageContext.request.contextPath}/student" method="POST">
                <input type="hidden" name="action" value="${student != null ? 'update' : 'insert'}">
                <c:if test="${student != null}">
                    <input type="hidden" name="id" value="${student.id}">
                </c:if>

                <!-- Student Code -->
                <div class="form-group">
                    <label for="studentCode">Student Code <span class="required">*</span></label>
                    <input type="text"
                           id="studentCode"
                           name="studentCode"
                           value="${student.studentCode}"
                           placeholder="e.g. SV001, IT123"
                           class="${not empty errorCode ? 'field-error' : ''}"
                           ${student != null ? 'readonly' : 'required'}>
                    <p class="info-text">Format: 2 uppercase letters + 3 or more digits</p>
                    <c:if test="${not empty errorCode}">
                        <p class="error-msg">⚠ ${errorCode}</p>
                    </c:if>
                </div>

                <!-- Full Name -->
                <div class="form-group">
                    <label for="fullName">Full Name <span class="required">*</span></label>
                    <input type="text"
                           id="fullName"
                           name="fullName"
                           value="${student.fullName}"
                           placeholder="Enter full name"
                           class="${not empty errorName ? 'field-error' : ''}"
                           required>
                    <c:if test="${not empty errorName}">
                        <p class="error-msg">⚠ ${errorName}</p>
                    </c:if>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label for="email">Email <span class="required">*</span></label>
                    <input type="email"
                           id="email"
                           name="email"
                           value="${student.email}"
                           placeholder="student@example.com"
                           class="${not empty errorEmail ? 'field-error' : ''}"
                           required>
                    <c:if test="${not empty errorEmail}">
                        <p class="error-msg">⚠ ${errorEmail}</p>
                    </c:if>
                </div>

                <!-- Major -->
                <div class="form-group">
                    <label for="major">Major <span class="required">*</span></label>
                    <select id="major" name="major"
                            class="${not empty errorMajor ? 'field-error' : ''}"
                            required>
                        <option value="">-- Select Major --</option>
                        <option value="Computer Science"
                                ${student.major == 'Computer Science'        ? 'selected' : ''}>Computer Science</option>
                        <option value="Information Technology"
                                ${student.major == 'Information Technology'  ? 'selected' : ''}>Information Technology</option>
                        <option value="Software Engineering"
                                ${student.major == 'Software Engineering'    ? 'selected' : ''}>Software Engineering</option>
                        <option value="Business Administration"
                                ${student.major == 'Business Administration' ? 'selected' : ''}>Business Administration</option>
                    </select>
                    <c:if test="${not empty errorMajor}">
                        <p class="error-msg">⚠ ${errorMajor}</p>
                    </c:if>
                </div>

                <!-- Buttons -->
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${student != null}">💾 Update Student</c:when>
                            <c:otherwise>➕ Add Student</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/student?action=list"
                       class="btn btn-cancel">❌ Cancel</a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
