package com.zhouyp.controller;

import com.google.gson.Gson;
import com.zhouyp.pojo.ArticleInfo;
import com.zhouyp.pojo.CategoryNode;
import com.zhouyp.pojo.CommentInfo;
import com.zhouyp.pojo.UserInfo;
import com.zhouyp.pojo.base.Page;
import com.zhouyp.service.ArticleInfoService;
import com.zhouyp.service.CommentInfoService;
import com.zhouyp.service.UserCategoryService;
import com.zhouyp.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BlogController extends BaseController {
    @Autowired
    ArticleInfoService articleInfoService;
    @Autowired
    UserCategoryService userCategoryService;
    @Autowired
    UserInfoService userInfoService;
    @Autowired
    CommentInfoService commentInfoService;

    @RequestMapping("blogIndex/{userId}")
    public ModelAndView selfBlog(@PathVariable(value = "userId") String userId, String artId, String searchValue, String pageNo, String categoryId, HttpServletRequest request) {
        if (userId!=null&&!userId.equals("")) {
            userInfoService.updateVisitCount(userId);
        }
        if (artId != null&&!userId.equals("")) {
            articleInfoService.updateVisitCount(artId);
        }
        ModelAndView modelAndView = new ModelAndView("blog");
        modelAndView.addObject("blogUser", userInfoService.get(userId));
        Boolean showArt = false;
        UserInfo currentUserInfo = getCurrentUserInfo(request);
        if (artId == null || artId.equals("")) {//显示列表
            Page<ArticleInfo> articleInfoPage = new Page<>();
            if (pageNo == null || pageNo.equals("")) {
                //将查询路径存到session中
                request.getSession().setAttribute("url", request.getRequestURL());
                request.getSession().setAttribute("userId", userId);
                request.getSession().setAttribute("query", request.getQueryString());
            } else {
                try {
                    articleInfoPage.setPageNumb(Integer.parseInt(pageNo));
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("url", request.getRequestURL() + "?" + request.getQueryString());
                }
            }
            //获取全部博客列表，分页形式
            ArticleInfo articleInfo = new ArticleInfo();
            articleInfo.setUserId(userId);
            articleInfo.setCategoryId(categoryId);
            if (searchValue != null && !searchValue.equals("")) {
                articleInfo.setName("%" + searchValue + "%");
            }
            articleInfo.setDelFlag(0L);
            Page<ArticleInfo> page = articleInfoService.findPage(articleInfoPage, articleInfo);
            modelAndView.addObject("artPage", page);
        } else {//显示文章
            showArt = true;
            //文章内容
            ArticleInfo articleInfo = articleInfoService.get(artId);
            modelAndView.addObject("articleInfo", articleInfo);
            //文章评论树，根据文章id
            List<CommentInfo> commentTree = commentInfoService.findCommentTreeByArtId(artId);
            modelAndView.addObject("commentTree", commentTree);
            //收藏标志
            boolean artCollected = false;
            if (currentUserInfo != null) {
                artCollected = articleInfoService.haveCollect(currentUserInfo.getId(), artId);
            }
            modelAndView.addObject("artCollected", artCollected);
        }
        modelAndView.addObject("showArt", showArt);
        //获取个人热门博客列表
        List<ArticleInfo> hotArticleList = articleInfoService.findHotListByUserId(userId);
        modelAndView.addObject("hotArticleList", hotArticleList);
        //获取个人最新博客列表
        List<ArticleInfo> newArticleList = articleInfoService.findNewListByUserId(userId);
        modelAndView.addObject("newArticleList", newArticleList);
        //获取个人分类
        List<CategoryNode> userCategorieList = userCategoryService.findCategoryTreeList(userId, request.getRequestURL().toString() + "?categoryId=");//获得目录树
        //关注标志
        int attentionFlag = 1;//显示关注
        if (currentUserInfo != null) {
            if (currentUserInfo.getId().equals(userId)) {
                attentionFlag = 0;//不显示
            } else {//不是自己
                if (userInfoService.haveAttention(currentUserInfo.getId(), userId)) {//已经关注
                    attentionFlag = 2;//没有关注显示关注
                }//显示关注
            }
        }
        modelAndView.addObject("attentionFlag", attentionFlag);
        Gson gson = new Gson();
        modelAndView.addObject("userCategoryTree", gson.toJson(userCategorieList));
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("collect")
    public String collectArt(String artId, HttpServletRequest request) {
        String userId = getCurrentUserInfo(request).getId();

        boolean flag = articleInfoService.haveCollect(userId, artId);
        Long collectCount;
        if (flag) {
            collectCount = articleInfoService.deleteCollect(userId, artId);
        } else {
            collectCount = articleInfoService.updateCollectArticle(userId, artId);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("collFlag", !flag);
        map.put("collectCount", collectCount);
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    @ResponseBody
    @RequestMapping("attention")
    public String attentionUser(String userId, HttpServletRequest request) throws Exception {
        String currectUserId = getCurrentUserInfo(request).getId();
        if (userId.equals(currectUserId)) {
            throw new Exception("关注异常");
        }
        boolean flag = userInfoService.haveAttention(currectUserId, userId);
        Long attentionCount;
        if (flag){//如果已经关注，跟新粉丝数和关注数
            //取消关注
            attentionCount = userInfoService.deleteAttention(currectUserId, userId);
        }else {
            //添加关注
            attentionCount = userInfoService.addAttention(currectUserId, userId);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("attFlag", !flag);
        map.put("attentionCount", attentionCount);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
}
