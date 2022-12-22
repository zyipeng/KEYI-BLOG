package com.zhouyp.controller;

import com.google.gson.Gson;
import com.zhouyp.pojo.CommentInfo;
import com.zhouyp.service.ArticleInfoService;
import com.zhouyp.service.CommentInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
public class CommentController {
    @Autowired
    CommentInfoService commentInfoService;
    @Autowired
    ArticleInfoService articleInfoService;
    @ResponseBody
    @RequestMapping("comment")
    public String addComment(CommentInfo commentInfo, HttpServletRequest request) {
        commentInfo.setId(UUID.randomUUID().toString());
        commentInfo.setCreateTime(new Date());
        commentInfo.setNewRecord(true);
        commentInfoService.save(commentInfo);
        Long commentCount = articleInfoService.updateCommentCount(commentInfo.getArticleId());
        Map<String,Object> map = new HashMap<>();
        map.put("comid", commentInfo.getId());
        map.put("commentCount", commentCount);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
}
