package com.zhouyp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;

@Controller("test")
public class FrontEndDevelop {
    @RequestMapping("jsp")
    public String JSP(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("getPathInfo()"+request.getPathInfo());
        System.out.println("getAuthType"+request.getAuthType());
        System.out.println("getContextPath"+request.getContextPath());
        System.out.println("getMethod"+request.getMethod());
        System.out.println("getPathTranslated"+request.getPathTranslated());
        System.out.println("getQueryString"+request.getQueryString());
        System.out.println("getRemoteUser"+request.getRemoteUser());
        System.out.println("getRequestedSessionId"+request.getRequestedSessionId());
        System.out.println("getRequestURI"+request.getRequestURI());
        System.out.println("getServletPath"+request.getServletPath());
        System.out.println("getCharacterEncoding"+request.getCharacterEncoding());
        System.out.println("getContentType"+request.getContentType());
        System.out.println("getLocalAddr"+request.getLocalAddr());
        System.out.println("getRemoteHost"+request.getRemoteHost());
        System.out.println("getScheme"+request.getScheme());
        System.out.println("getServerName"+request.getServerName());
        System.out.println("getServerPort"+request.getServerPort());
        System.out.println("getRemotePort"+request.getRemotePort());
        System.out.println("getLocalPort"+request.getLocalPort());
//        System.out.println(""+request.getContentLengthLong());
        System.out.println("getContentLength"+request.getContentLength());
        System.out.println("getRequestURL"+request.getRequestURL());
        System.out.println("getProtocol"+request.getProtocol());

        StringBuffer requestURL = request.getRequestURL();
        String m = requestURL.substring(requestURL.lastIndexOf("/")+1);
        System.out.println(m);
        return m;
    }
}
