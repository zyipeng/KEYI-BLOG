package com.zhouyp.controller;

import com.zhouyp.dao.ReUserLabelDao;
import com.zhouyp.pojo.LabelInfo;
import com.zhouyp.pojo.ReUserLabel;
import com.zhouyp.pojo.UserInfo;
import com.zhouyp.service.LabelInfoService;
import com.zhouyp.service.ReUserLabelService;
import com.zhouyp.service.UserInfoService;
import com.zhouyp.utils.Util;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

@Controller
public class LoginController extends BaseController {

    @Autowired
    UserInfoService userInfoService;
    @Autowired
    ReUserLabelService reUserLabelService;

    @Autowired
    LabelInfoService labelInfoService;


    @RequestMapping("login")
    public String signIn(UserInfo userInfo, HttpServletRequest request) {
        //获取当前用户
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken();
        token.setUsername(userInfo.getUserName());
        token.setPassword(userInfo.getPwd().toCharArray());
        request.setAttribute("userInfo", userInfo);
        try {
            //对当前用户进行认证，授权
            subject.login(token);
            userInfo = (UserInfo) subject.getPrincipal();
            request.getSession().setAttribute("userInfo", userInfo);
            ReUserLabel reUserLabel = new ReUserLabel();
            reUserLabel.setUserId(userInfo.getId());
            List<ReUserLabel> list = reUserLabelService.findList(reUserLabel);
            if (list.size() > 0) {
                return "redirect:/index";
            }
            List<LabelInfo> labelList = labelInfoService.findAllList();
            request.setAttribute("labelList", labelList);
            return "selectLabel";
        } catch (AuthenticationException e) {
            request.setAttribute("errorMsg", "用户名或密码错误");
            return "forward:/v1/login.jsp";
        }
    }

    @RequestMapping("register")
    public String signUp(UserInfo userInfo, HttpServletRequest request) {
        if (Util.strIsEmpty(userInfo.getPwd()) || Util.strIsEmpty(userInfo.getPwd())) {
            request.setAttribute("errorMsg", "用户名和邮箱都不能为空");
        } else {
            List<UserInfo> existList = userInfoService.exist(userInfo);
            if (existList != null && existList.size() > 0) {//已存在
                request.setAttribute("errorMsg", "用户名或邮箱已被注册");
            } else {
                //注册
                userInfoService.save(userInfo);
                request.setAttribute("errorMsg", "注册成功");
            }
        }
        request.setAttribute("userInfo", userInfo);
        return "forward:/v1/login.jsp";
    }

    @RequestMapping("clklabel")
    public String clkLabel(String label,HttpServletRequest request) {
        UserInfo userInfo = (UserInfo) request.getSession().getAttribute("userInfo");
        List<String> labelList = Arrays.asList(label.split(","));
        reUserLabelService.insertReUserLabelList(userInfo.getId(), labelList);
        return "redirect:/index";
    }
}
