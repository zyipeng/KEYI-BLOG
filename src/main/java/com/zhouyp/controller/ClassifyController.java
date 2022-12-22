package com.zhouyp.controller;

import com.zhouyp.pojo.ArticleInfo;
import com.zhouyp.pojo.LabelInfo;
import com.zhouyp.pojo.base.Page;
import com.zhouyp.service.ArticleInfoService;
import com.zhouyp.service.LabelInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
public class ClassifyController {
    @Autowired
    LabelInfoService labelInfoService;
    @Autowired
    ArticleInfoService articleInfoService;
    @ResponseBody
    @RequestMapping("classify")
    public ModelAndView classify(String labelId,String pageNo,HttpServletRequest request) throws UnsupportedEncodingException {
        if (labelId != null) {
            labelId = new String(labelId.getBytes("iso-8859-1"), "UTF-8");
        }
        Page page = new Page<>();
        if (pageNo == null || pageNo.equals("")) {
            //将查询路径存到session中
            request.getSession().setAttribute("allSearchUrl", request.getRequestURL());
            request.getSession().setAttribute("allSearchQuery", request.getQueryString());
        } else {
            try {
                page.setPageNumb(Integer.parseInt(pageNo));
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("allSearchUrl", request.getRequestURL() + "?" + request.getQueryString());
            }
        }
        ModelAndView modelAndView = new ModelAndView("classify");
        List<LabelInfo> labelList = labelInfoService.findAllList();
        modelAndView.addObject("labelList", labelList);
        ArticleInfo articleInfo = new ArticleInfo();
        articleInfo.setLabelId(labelId);
        Page<ArticleInfo> artPage = articleInfoService.findPage(page, articleInfo);
        modelAndView.addObject("artPage", artPage);
        return modelAndView;
    }
}
