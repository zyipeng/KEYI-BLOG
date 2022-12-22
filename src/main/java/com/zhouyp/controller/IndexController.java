package com.zhouyp.controller;

import com.google.gson.Gson;
import com.zhouyp.pojo.ArticleInfo;
import com.zhouyp.pojo.CommentInfo;
import com.zhouyp.pojo.UserInfo;
import com.zhouyp.service.ArticleInfoService;
import com.zhouyp.service.CommentInfoService;
import com.zhouyp.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {

    @Autowired
    UserInfoService userInfoService;

    @Autowired
    ArticleInfoService articleInfoService;

    @Autowired
    CommentInfoService commentInfoService;

    @RequestMapping("index")
    public ModelAndView IndexFun() {
        //加载热门博客
        List<ArticleInfo> hotArtList = articleInfoService.findHotList();
        //加载热们博主
        List<UserInfo> hotUseList = userInfoService.findHotList();

        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("hotArtList", hotArtList);
        modelAndView.addObject("hotUseList", hotUseList);
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("randomCom")
    public String randomCom(){
        List<CommentInfo> commentInfos = commentInfoService.randomCommentList();
        List<Map<String,Object>> list = new ArrayList<>();
        for (CommentInfo commentInfo : commentInfos) {
            Map<String,Object> map = new HashMap<>();
            map.put("blogId", commentInfo.getUserId());
            map.put("commentId", commentInfo.getId());
            map.put("value", commentInfo.getContent());
            list.add(map);
        }
        Gson gson = new Gson();
        return gson.toJson(list);
    }
}
