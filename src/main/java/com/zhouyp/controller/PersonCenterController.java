package com.zhouyp.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sun.istack.internal.NotNull;
import com.zhouyp.pojo.*;
import com.zhouyp.pojo.base.Page;
import com.zhouyp.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class PersonCenterController extends BaseController {
    @Autowired
    UserInfoService userInfoService;

    @Autowired
    UserCategoryService userCategoryService;

    @Autowired
    LabelInfoService labelInfoService;

    @Autowired
    ArticleInfoService articleInfoService;

    @Autowired
    ReUserLabelService reUserLabelService;

    @RequestMapping("personCenter")
    public ModelAndView personCenterIndex(String artId, HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        UserInfo userInfo = getCurrentUserInfo(request);
        //获取个人分类树
        List<CategoryNode> userCategorieList = userCategoryService.findCategoryTreeList(userInfo.getId(), "");//获得目录树
        Gson gson = new Gson();
        modelAndView.addObject("userCategoryTree", gson.toJson(userCategorieList));
        //获取个人标签
        List<ReUserLabel> reUserLabelList = reUserLabelService.findListByUserId(userInfo.getId());
        modelAndView.addObject("labelList", reUserLabelList);

        //获取个人分类列表
        List<UserCategory> categoryList = userCategoryService.findListByUserId(userInfo.getId());
        modelAndView.addObject("categoryList", categoryList);
        modelAndView.setViewName("personCenter");

        //获取粉丝列表
        Page<UserInfo> fansPage = userInfoService.findFansPage(new Page<>(), userInfo.getId());
        modelAndView.addObject("fansPage", fansPage);
        //获取关注列表
        Page<UserInfo> attentionPage = userInfoService.findAttentionPage(new Page<>(), userInfo.getId());
        modelAndView.addObject("attentionPage", attentionPage);
        //获取收藏列表
        Page<ArticleInfo> collectPage = articleInfoService.findCollectPage(new Page<>(), userInfo.getId());
        modelAndView.addObject("collectPage", collectPage);
        if (artId != null) {
            ArticleInfo articleInfo = articleInfoService.get(artId);
            modelAndView.addObject("articleInfo", articleInfo);
            modelAndView.addObject("tab", "t6");
        }
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("headerUp")
    public String headerUp(MultipartFile header_change, HttpServletRequest request) throws IOException {//文件上传
        HttpSession session = request.getSession();
        String originalFilename = header_change.getOriginalFilename();
        if (header_change != null && originalFilename != null && originalFilename.length() > 0) {
            String newFileName = UUID.randomUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
            File newFile = new File(headerImgPath + newFileName);
            header_change.transferTo(newFile);//保存文件
            //更新数据
            UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
            UserInfo upUserInfo = new UserInfo();
            upUserInfo.setId(userInfo.getId());
            upUserInfo.setHeadPath(newFileName);
            upUserInfo.setNewRecord(false);
            userInfoService.save(upUserInfo);
            //更新session
            userInfo.setHeadPath(newFileName);
            session.setAttribute("userInfo", userInfo);
            //返回结果
            return "头像修改成功";
        }
        return "文件修改失败";
    }

    @ResponseBody
    @RequestMapping("check/{param}")
    public String checkParam(@NotNull @PathVariable String param, String paramValue) {
        UserInfo u = new UserInfo();
        if (param.equals("userName")) {
            u.setUserName(paramValue);
        } else if (param.equals("email")) {
            u.setEmail(paramValue);
        } else {
            return "拒绝访问";
        }
        List<UserInfo> list = userInfoService.findList(u);
        if (list.size() > 0) {
            return param + "已被使用";
        }
        return "success";
    }

    @ResponseBody
    @RequestMapping("alterUserInfo")
    public String alterUserInfo(UserInfo userInfo, String birth, HttpServletRequest request) {
        UserInfo currentUserInfo = getCurrentUserInfo(request);
        userInfo.setId(currentUserInfo.getId());
        if (birth != null && !birth.isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
            Date date = null;
            try {
                date = sdf.parse(birth);
            } catch (ParseException e) {
                logger.error("用户" + currentUserInfo.getUserName() + "输入的日期有问题");
                return "修改失败输入的日期格式有问题";
            }
            userInfo.setBirthday(date);
        }
        userInfoService.save(userInfo);
        //修改成功更新session
        UserInfo userInfo1 = userInfoService.get(userInfo.getId());
        setCurrentUserInfo(request, userInfo1);
        return "修改成功";
    }

    @ResponseBody
    @RequestMapping("savecata")
    public String saveCata(UserCategory userCategory, HttpServletRequest request) {
        UserInfo userInfo = getCurrentUserInfo(request);
        userCategory.setUserId(userInfo.getId());
        /*增删改都在这里*/
        if (userCategory.getName() != null && userCategory.getName() != "") {
            //增改
            userCategoryService.save(userCategory);
        } else {
            //删除
            userCategoryService.delete(userCategory);
        }
        //更新分类列表

        //获取个人分类
        List<CategoryNode> userCategorieList = userCategoryService.findCategoryTreeList(userInfo.getId(), "");//获得目录树
        Gson gson = new Gson();
        Map<String, List> map = new HashMap<>();
        map.put("userCategoryTree", userCategorieList);
        return gson.toJson(map);
    }

    @ResponseBody
    @RequestMapping("editor/upImg")
    public String upImg(@RequestParam(value = "editormd-image-file", required = false) MultipartFile imgFile, HttpServletRequest request) {
        String originalFilename = imgFile.getOriginalFilename();
        Map<String, Object> map = new HashMap<>();
        if (imgFile != null && originalFilename != null && originalFilename.length() > 0) {
            String newFileName = UUID.randomUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));
            try {
                File newFile = new File(blogImgPath + newFileName);
                imgFile.transferTo(newFile);//保存文件
                map.put("url", request.getContextPath() + "/images/blogs/" + newFileName);
                map.put("success", 1);
                map.put("message", "上传成功！！！");
            } catch (IOException e) {
                map.put("success", 0);
                map.put("message", "上传失败！！！");
            }
        }
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    @ResponseBody
    @RequestMapping(value = {"editor/save", "editor/issue"})
    public String artSave(ArticleInfo articleInfo, String content, HttpServletRequest request) throws FileNotFoundException, UnsupportedEncodingException {

        //判断是不是第一次如果不是第一次则需要设置一个文章id
        String artId = articleInfo.getId();
        if (artId == null || artId.equals("")) {
            UUID uuid = UUID.randomUUID();
            articleInfo.setId(uuid.toString());/*id*/
            articleInfo.setCreateTime(new Date());/*创建时间*/
            articleInfo.setNewRecord(true);/*新记录*/
            if (request.getContextPath().contains("issue")) {
                //第一次发表的话需要设置发表参数
                articleInfo.setIssueFlag(1L);/*发表标志*/
                articleInfo.setIssueTime(new Date());/*发表时间*/
            }
        }
        //设置博客简介图片
        Pattern p = Pattern.compile("!\\[[^(\\]\\n\\r)]*]\\(.+?\\.(png|jpg|jpeg|gif)\\)");
        Matcher m = p.matcher(content);
        if (m.find()) {
            String str = m.group();
            articleInfo.setImgPath(str.substring(str.lastIndexOf('/') + 1, str.length() - 1));/*简介图片*/
        } else {
            //没有图片设置默认图片
            articleInfo.setImgPath("default.png");
        }
        //设置博客路径
        articleInfo.setPath(articleInfo.getId() + ".md");/*博客路径*/
        /*博客分类*/
        /*博客标签*/
        /*生成简介*/
        String intro = content.replaceAll("(!\\[[^(\\]\\n\\r)]*]\\(.+?\\.(png|jpg|jpeg|gif)\\)|\n|\r)", "");
        if (intro.length() > 70) {
            intro = intro.substring(0, 70);
        }
        articleInfo.setIntro(intro + "... ...");
        //设置用户id
        articleInfo.setUserId(getCurrentUserInfo(request).getId());
        /*保存文章到本地*/
        PrintWriter printWriter = new PrintWriter(new OutputStreamWriter(new FileOutputStream(blogArticlePath + articleInfo.getPath()), "utf-8"));
        printWriter.print(content);
        printWriter.flush();
        printWriter.close();
        /*更新数据库*/
        articleInfoService.save(articleInfo);
        request.getSession().setAttribute("artId", articleInfo.getId());
        Map<String, Object> map = new HashMap<>();
        map.put("msg", "保存成功");
        map.put("artId", articleInfo.getId());
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    @ResponseBody
    @RequestMapping("editor/refreshCata")
    public String refreshCata(HttpServletRequest request) {
        UserInfo currentUserInfo = getCurrentUserInfo(request);
        List<UserCategory> listByUserId = userCategoryService.findListByUserId(currentUserInfo.getId());
        List<Map<String,String>> list = new ArrayList<>();
        for (UserCategory userCategory : listByUserId) {
            Map<String,String> map = new HashMap<>();
            map.put("id", userCategory.getId());
            map.put("name", userCategory.getName());
            list.add(map);
        }
        Gson gson = new Gson();
        return gson.toJson(list);
    }
}
