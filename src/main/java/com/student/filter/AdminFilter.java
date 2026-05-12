package com.student.filter;

import com.student.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authorization Filter — allows only admin users to perform write operations on /student.
 */
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/student"})
public class AdminFilter implements Filter {

    private static final String[] ADMIN_ACTIONS = {
        "new", "insert", "edit", "update", "delete"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AdminFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  httpReq  = (HttpServletRequest)  request;
        HttpServletResponse httpResp = (HttpServletResponse) response;

        String action = httpReq.getParameter("action");

        if (!isAdminAction(action)) {
            // Read-only actions (list, search, sort, filter) — allow anyone
            chain.doFilter(request, response);
            return;
        }

        // Write action: verify admin role
        HttpSession session = httpReq.getSession(false);

        if (session == null) {
            // No session at all — send to login
            httpResp.sendRedirect(httpReq.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user != null && user.isAdmin()) {
            chain.doFilter(request, response);  // admin — allow
        } else {
            // Not admin — redirect with error message
            httpResp.sendRedirect(httpReq.getContextPath()
                + "/student?action=list&error=Access denied. Admin privileges required.");
        }
    }

    @Override
    public void destroy() {
        System.out.println("AdminFilter destroyed");
    }

    private boolean isAdminAction(String action) {
        if (action == null) return false;
        for (String a : ADMIN_ACTIONS) {
            if (a.equals(action)) return true;
        }
        return false;
    }
}