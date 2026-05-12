package com.student.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication Filter — protects all URLs except login/logout and static assets.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    // Paths that bypass authentication
    private static final String[] PUBLIC_URLS = {
        "/login", "/logout",
        ".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".ico", ".woff"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  httpReq  = (HttpServletRequest)  request;
        HttpServletResponse httpResp = (HttpServletResponse) response;

        // Strip context path to get the relative path
        String path = httpReq.getRequestURI()
                             .substring(httpReq.getContextPath().length());

        // Always allow public resources
        if (isPublicUrl(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Check session for logged-in user
        HttpSession session  = httpReq.getSession(false);
        boolean     loggedIn = (session != null && session.getAttribute("user") != null);

        if (loggedIn) {
            chain.doFilter(request, response);  // pass through
        } else {
            httpResp.sendRedirect(httpReq.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        System.out.println("AuthFilter destroyed");
    }

    private boolean isPublicUrl(String path) {
        for (String pub : PUBLIC_URLS) {
            if (path.contains(pub)) return true;
        }
        return false;
    }
}