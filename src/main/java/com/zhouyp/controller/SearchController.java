package com.zhouyp.controller;

import com.zhouyp.pojo.ArticleInfo;
import com.zhouyp.pojo.UserInfo;
import com.zhouyp.pojo.base.Page;
import com.zhouyp.service.ArticleInfoService;
import com.zhouyp.service.LabelInfoService;
import com.zhouyp.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SearchController extends BaseController {
    @Autowired
    UserInfoService userInfoService;

    @Autowired
    ArticleInfoService articleInfoService;

    @Autowired
    LabelInfoService labelInfoService;
    @RequestMapping("search")
    public ModelAndView search(String searchWord,String range,String pageNo, HttpServletRequest request) throws UnsupportedEncodingException {
        Page objectPage = new Page<>();
        if (pageNo == null || pageNo.equals("")) {
            //将查询路径存到session中
            request.getSession().setAttribute("allSearchUrl", request.getRequestURL());
            request.getSession().setAttribute("allSearchQuery", request.getQueryString());
        } else {
            try {
                objectPage.setPageNumb(Integer.parseInt(pageNo));
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("allSearchUrl", request.getRequestURL() + "?" + request.getQueryString());
            }
        }
        if (searchWord == null || searchWord.equals("")) {
            request.getSession().removeAttribute("searchWord");
        }else {
//            searchWord = new String(searchWord.getBytes("iso-8859-1"), "UTF-8");
            request.getSession().setAttribute("searchWord",searchWord);
            try {
                labelInfoService.addRedWord(searchWord);
            } catch (Exception e) {
                //插入失败就说明已经存在
            }
        }
        ModelAndView modelAndView = new ModelAndView("search");
        String searchWord1 = (String) request.getSession().getAttribute("searchWord");
        //通过searchWord1去查询博客列表或者博主列表
        Map<String,Object> map = new HashMap<>();

        if (searchWord1 != null) {
            searchWord1 = "%"+searchWord1+"%";
        }
        if (range==null||range.equals("blog")){//查询博客
            ArticleInfo articleInfo  = new ArticleInfo();
            articleInfo.setName(searchWord1);
            Page<ArticleInfo> page = articleInfoService.findPage(objectPage, articleInfo);
            modelAndView.addObject("page", page);
            modelAndView.addObject("range", "blog");
        }else{//查询用户
            UserInfo userInfo = new UserInfo();
            userInfo.setUserName(searchWord1);
            Page<UserInfo> page = userInfoService.findPage(objectPage, userInfo);
            modelAndView.addObject("page", page);
            modelAndView.addObject("range", "user");
        }
        //通过searchWord1去查询搜索列表
        List<String> list = labelInfoService.redWord();
        modelAndView.addObject("redWordList", list);
        return modelAndView;
    }
}
