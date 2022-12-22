package com.zhouyp.controller;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;
import com.zhouyp.pojo.UserInfo;

import javax.servlet.http.HttpServletRequest;

/**
 * 所有Controller需要做的事情通过这个实现
 */
public class BaseController {
    protected static final Logger logger = LoggerFactory.getLogger(BaseController.class);
    protected static final String headerImgPath = BaseController.class.getClassLoader().getResource("../..").getPath() + "images/header/";
    protected static final String blogImgPath = BaseController.class.getClassLoader().getResource("../..").getPath() + "images/blogs/";
    protected static final String blogArticlePath = BaseController.class.getClassLoader().getResource("../..").getPath() + "Article/";
    protected UserInfo getCurrentUserInfo(HttpServletRequest request){
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");
        return userInfo;
    }
    protected void setCurrentUserInfo(HttpServletRequest request,UserInfo userInfo){
        request.getSession().setAttribute("userInfo",userInfo);
    }
}