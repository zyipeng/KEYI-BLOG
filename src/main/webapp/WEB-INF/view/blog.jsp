<%--
  Created by IntelliJ IDEA.
  User: zhouyp
  Date: 2020/5/11
  Time: 20:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %><%--直接使用.../fmt的时候报错--%>
<c:set var="baseurl" value="${pageContext.request.contextPath}/"/>
<c:set var="userUrl" value="${baseurl}blogIndex/${userId}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--对移动设备友好
    不同屏幕分辨率的设备浏览,
    1:1 的比例呈现,
    只能滚动屏幕,
    禁用其缩放
    -->
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta charset="UTF-8">
    <title>博客</title>
    <link href="${baseurl}/v1/glyphicons/css/glyphicons.css" rel="stylesheet">
    <!--comment css-->
    <link rel="stylesheet" href="${baseurl}/v1/commentModel/css/style.css">
    <link rel="stylesheet" href="${baseurl}/v1/commentModel/css/comment.css">
    <!--全局-->
    <link href="${baseurl}/v1/css/global.css" rel="stylesheet">
    <!--自己-->
    <link href="${baseurl}/v1/css/blog.css" rel="stylesheet">
    <!--bootstrap css-->
    <link href="${baseurl}/v1/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!--分类-->
    <link href="${baseurl}/v1/bootstrap-treeview/bootstrap-treeview.min.css" rel="stylesheet">
    <!--editor.md css-->
    <link rel="stylesheet" href="${baseurl}/editor.md/css/editormd.preview.css"/>
    <!--jquery提前加载提供editormd.js依赖-->
    <script src="${baseurl}/v1/jquery/jquery-3.4.1.min.js"></script>

    <!--editor.md js-->
    <script src="${baseurl}/editor.md/editormd.js"></script>
    <script src="${baseurl}/editor.md/lib/marked.min.js"></script>
    <script src="${baseurl}/editor.md/lib/prettify.min.js"></script>

    <script src="${baseurl}/editor.md/lib/raphael.min.js"></script>
    <script src="${baseurl}/editor.md/lib/underscore.min.js"></script>
    <script src="${baseurl}/editor.md/lib/sequence-diagram.min.js"></script>
    <script src="${baseurl}/editor.md/lib/flowchart.min.js"></script>
    <script src="${baseurl}/editor.md/lib/jquery.flowchart.min.js"></script>
    <style>
        .media{
            padding: 15px;
            border-radius: 1rem;
        }
    </style>
</head>
<body style="padding-top: 80px; background: #0c6e6e;">
<%@include file="/WEB-INF/view/top.jsp" %>
<div class="container" style="width: 100%">
    <div class="row">
        <div class="col-lg-3">
            <ul class="list-group">
                <li class="list-group-item">
                    <div class="media">
                        <div class="media-left">
                            <a href="#">
                                <img class="media-object img-circle user-head-img label-border-1b"
                                     src="${baseurl}images/header/${blogUser.headPath}">
                            </a>
                        </div>
                        <div class="media-body">
                            <h4 class="media-object">${blogUser.userName}</h4>
                        </div>
                        <div class="media-right">
                            <c:if test="${attentionFlag==1}">
                                <button class="btn btn-warning" id="attention_but">关注</button>
                            </c:if>
                            <c:if test="${attentionFlag==2}">
                                <button class="btn btn-warning" id="attention_but">取消关注</button>
                            </c:if>
                        </div>
                        <script>

                            $("#attention_but").click(function () {
                                var oThis = $(this);
                                var userId = "${blogUser.id}";
                                $.ajax({
                                    type: 'post',
                                    url: "${baseurl}attention",
                                    data: {"userId":userId},
                                    dataType: "json",
                                    cache: false,
                                    success: function (data) {
                                        if (data.attFlag){//修改按钮内容
                                            $("#attention_but").html("取消关注")
                                            ShowSuccess("关注成功");
                                        }else {
                                            $("#attention_but").html("关注")
                                            ShowSuccess("取消关注");
                                        }
                                        //更新关注数
                                        $("#attention_count").html(data.attentionCount);
                                    },
                                    error:function () {
                                        hint("检查是否登录，或者跟换浏览器")
                                    }
                                });
                            })
                        </script>
                    </div>
                </li>
                <li class="list-group-item" id="bdt0">
                    <table class="table mg0 text-center">
                        <thead>
                        <tr>
                            <th>原创</th>
                            <th>粉丝</th>
                            <th>关注</th>
                            <th>获赞</th>
                            <th>访问</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span>${blogUser.articleCount}</span></td>
                            <%--原创--%>
                            <td><span>${blogUser.likedUserCount}</span></td>
                            <%--粉丝--%>
                            <td><span id="attention_count">${blogUser.likeUserCount}</span></td>
                            <%--关注--%>
                            <td><span>${blogUser.likeCount}</span></td>
                            <%--获赞--%>
                            <td><span>${blogUser.visitCount}</span></td>
                            <%--访问--%>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                </li>
                <li class="list-group-item">
                    <table class="all-bd0 table mg0">
                        <tbody id="all-bd0">
                        <tr>
                            <th>等级:</th>
                            <td>1</td>
                            <th>上月排名:</th>
                            <td>1</td>
                        </tr>
                        <tr>
                            <th>总排名:</th>
                            <td>1</td>
                        </tr>
                        </tbody>
                    </table>
                </li>
            </ul>
            <div class="panel panel-default">
                <div class="panel-heading">热门</div>
                <ul class="list-group panel-body">
                    <c:forEach var="hotart" items="${hotArticleList}">
                        <li class="list-group-item">${hotart.name}</li>
                    </c:forEach>
                </ul>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">最新</div>
                <ul class="list-group panel-body">
                    <c:forEach var="newart" items="${newArticleList}">
                        <li class="list-group-item">${newart.name}</li>
                    </c:forEach>
            </div>
        </div>
        <div class="col-lg-6" style="padding: 0 0;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-6">
                            <a class="btn btn-default" href="${userUrl}">显示全部</a>
                        </div><!-- /.col-lg-6 -->
                        <div class="col-lg-6">
                            <form action="${userUrl}">
                                <div class="input-group">
                                    <input name="searchValue" type="text" class="form-control" placeholder="搜索该博主">
                                    <span class="input-group-btn">
                                <button class="btn btn-default" type="submit">搜索</button>
                                </span>
                                </div><!-- /input-group -->
                            </form>
                        </div><!-- /.col-lg-6 -->
                    </div><!-- /.row -->
                </div>
                <c:choose>
                    <c:when test="${showArt}">
                        <div class="panel-heading <%--hidden--%>">
                            <p style="font-size: 25px;margin: 10px 0px;font-weight: bold;">${articleInfo.name}</p>
                            <span class="glyphicon glyphicon-user"></span>${blogUser.userName}&nbsp;&nbsp;<!--作者-->
                            <span class="glyphicon glyphicon-time"></span>
                            <fmt:formatDate value="${articleInfo.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;<!--时间-->
                            <span class="glyphicon ${artCollected?'glyphicon-star':'glyphicon-star-empty'}" id="collect_art"></span><span id="collect_count">${articleInfo.collectCount}</span>&nbsp;&nbsp;<!--收藏-->
                            <span class="glyphicon glyphicon-thumbs-up"></span>${articleInfo.likeCount}&nbsp;&nbsp;<!--点赞-->
                            <span class="glyphicon glyphicon-thumbs-down"></span>${articleInfo.hateCount}&nbsp;&nbsp;<!--踩-->
                            <span class="glyphicon glyphicon-comment"></span><span id="comment_count">${articleInfo.commentCount}</span>&nbsp;&nbsp;<!--评论-->
                            <span class="glyphicon glyphicon-eye-open"></span>${articleInfo.visitCount}<!--访问-->
                            <c:if test="${blogUser.id.equals(userInfo.id)}">
                                <a href="${baseurl}personCenter?artId=${articleInfo.id}" class="btn btn-info btn-xs pull-right">编辑</a>
                            </c:if>
                        </div>
                        <script>
                            $("#collect_art").click(function () {
                                var oThis = $(this);
                                var artId = "${articleInfo.id}";
                                $.ajax({
                                    type: 'post',
                                    url: "${baseurl}collect",
                                    data: {"artId":artId},
                                    dataType: "json",
                                    cache: false,
                                    success: function (data) {
                                        if (data.collFlag){
                                            ShowSuccess("收藏成功");
                                            oThis.removeClass("glyphicon-star-empty")
                                            oThis.addClass("glyphicon-star")
                                        }else {
                                            ShowSuccess("取消收藏");
                                            oThis.removeClass("glyphicon-star")
                                            oThis.addClass("glyphicon-star-empty")
                                        }
                                        $("#collect_count").html(data.collectCount);
                                    },
                                    error:function () {
                                        hint("检查是否登录，或者跟换浏览器")
                                    }
                                });
                            })
                        </script>
                        <div class="panel-body <%--hidden--%>">
                            <div id="markdown-view">
                                <!-- Server-side output Markdown text -->
                                <textarea style="display:none;"></textarea>
                            </div>

                            <!--
                                此评论textarea文本框部分使用的https://github.com/alexdunphy/flexText此插件
                            -->
                            <div class="commentAll">
                                <!--评论区域 begin-->
                                <div class="reviewArea clearfix">
                            <textarea class="content comment-input" placeholder="Please enter a comment&hellip;"
                                      onkeyup="keyUP(this)"></textarea>
                                    <a href="javascript:;" class="plBtn">评论</a>
                                </div>
                                <!--评论区域 end-->
                                <!--回复区域 begin-->
                                <div class="comment-show">
                                    <c:forEach var="rootComment" items="${commentTree}">
                                        <div class="comment-show-con clearfix">
                                            <div class="comment-show-con-img pull-left">
                                                <img src="${baseurl}images/header/${rootComment.headPath}"
                                                     class="img-circle user-head-img" alt=""><%--头像--%>
                                            </div>
                                            <div class="comment-show-con-list pull-left clearfix">
                                                <div class="pl-text clearfix">
                                                    <a href="${baseurl}blogIndex/${rootComment.userId}"
                                                       class="comment-size-name">${rootComment.userName} : </a><%--用户名--%>
                                                    <span class="my-pl-con">&nbsp;${rootComment.content}</span><%--评论内容--%>
                                                </div>
                                                <div class="date-dz">
                                                    <span class="date-dz-left pull-left comment-time"><fmt:formatDate
                                                            value="${rootComment.createTime}"
                                                            pattern="yyyy-MM-dd HH:mm:ss"/></span><%--创建时间--%>
                                                    <div class="date-dz-right pull-right comment-pl-block">
                                                        <a href="javascript:;" class="removeBlock">删除</a>
                                                        <a href="javascript:;"
                                                           class="date-dz-pl pl-hf hf-con-block pull-left"
                                                           rootid="${rootComment.id}" comid="${rootComment.id}"
                                                           userid="${rootComment.userId}" username="${rootComment.userName}">回复</a>
                                                        <span class="pull-left date-dz-line">|</span>
                                                        <a href="javascript:;" class="date-dz-z pull-left">
                                                            <span class="glyphicon glyphicon-thumbs-up"></span>
                                                            赞 (<i class="z-num">${rootComment.likeCount}</i>)<%--点赞数--%>
                                                        </a>
                                                        <span class="pull-left date-dz-line">|</span>
                                                        <a href="javascript:;" class="date-dz-z pull-left">
                                                            <span class="glyphicon glyphicon-thumbs-down"></span>
                                                            踩 (<i class="z-num">${rootComment.hateCount}</i>)<%--讨厌数--%>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="hf-list-con"><%--回复列表--%>
                                                    <c:forEach var="childComment" items="${rootComment.hfList}">
                                                        <div class="all-pl-con">
                                                            <div class="pl-text hfpl-text clearfix">
                                                                <a href="${baseurl}blogIndex/${childComment.userId}"
                                                                   class="comment-size-name">${childComment.userName}
                                                                    : </a>
                                                                <span class="my-pl-con">回复<a
                                                                        href="${baseurl}blogIndex/${childComment.replyUserId}"
                                                                        class="atName">@${childComment.replyUserName}</a>:${childComment.content}</span>
                                                            </div>
                                                            <div class="date-dz">
                                                                <span class="date-dz-left pull-left comment-time"><fmt:formatDate
                                                                        value="${childComment.createTime}"
                                                                        pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                                                <div class="date-dz-right pull-right comment-pl-block">
                                                                    <a href="javascript:;" class="removeBlock">删除</a>
                                                                    <a href="javascript:;"
                                                                       class="date-dz-pl pl-hf hf-con-block pull-left"
                                                                       rootid="${rootComment.id}"
                                                                       comid="${childComment.id}"
                                                                       userid="${childComment.userId}" username="${childComment.userName}">回复</a>
                                                                    <span class="pull-left date-dz-line">|</span>
                                                                    <a href="javascript:;" class="date-dz-z pull-left">
                                                                        <span class="glyphicon glyphicon-thumbs-up"></span>
                                                                        赞 (<i class="z-num">${childComment.likeCount}</i>)<%--点赞数--%>
                                                                    </a>
                                                                    <span class="pull-left date-dz-line">|</span>
                                                                    <a href="javascript:;" class="date-dz-z pull-left">
                                                                        <span class="glyphicon glyphicon-thumbs-down"></span>
                                                                        踩 (<i class="z-num">${childComment.hateCount}</i>)<%--讨厌数--%>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <!--回复区域 end-->
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="panel-body <%--hidden--%>">
                            <ul class="media-list">
                                <c:forEach var="art" items="${artPage.result}">
                                    <li class="media" style="padding: 10px;">
                                        <div class="media-body">
                                            <a href="${userUrl}?artId=${art.id}">
                                                <h3 class="media-heading " style="font-size: 18px;font-weight: bold;">
                                                        ${art.name}
                                                </h3>
                                            </a>
                                                ${art.intro}
                                            <br>
                                            <fmt:formatDate value="${art.createTime}" pattern="yyyy-MM-dd"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <span class="glyphicon glyphicon-eye-open"></span>${art.visitCount}<%--访问--%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <span class="glyphicon glyphicon-comment"></span>${art.commentCount}<%--评论--%>
                                        </div>
                                        <div class="media-right">
                                            <a href="javascript:return 'a';">
                                                <img class="media-object blog-media-img" src="${blogurl}${art.imgPath}"
                                                     alt="...">
                                            </a>
                                        </div>
                                    </li>
                                </c:forEach>
                                    <%--
                                    <li class="media" style="padding: 10px;">
                                        <div class="media-body">
                                            <h3 class="media-heading " style="font-size: 18px;font-weight: bold;">
                                                钢铁是怎样炼成的
                                            </h3>
                                            有这么一个年轻人，他少年时就参加革命，拿枪和敌人殊死作战，
                                            留下满身伤痕。战争结束后，他拼命工作至全身瘫痪、双目失明。
                                            ... ...
                                            <br>
                                            2019-10-1
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <span class="glyphicon glyphicon-eye-open"></span>100<!--访问-->
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <span class="glyphicon glyphicon-comment"></span>100<!--评论-->
                                        </div>
                                        <div class="media-right">
                                            <a href="#">
                                                <img class="media-object blog-media-img" src="${baseurl}/v1/img/temp01.png" alt="...">
                                            </a>
                                        </div>
                                    </li>--%>
                            </ul>
                            <nav aria-label="Page navigation">
                                <ul class="pagination pull-right pd50" style="margin: 0px">
                                    <li class="<c:if test="${artPage.pageNumb<=1}">disabled</c:if>">
                                        <a href="${sessionScope.url}?pageNo=${artPage.pageNumb-1}&${sessionScope.query}"
                                           aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach var="i" begin="1" end="${artPage.totalPages}">
                                        <li class="<c:if test="${i==artPage.pageNumb}">active</c:if>"><a
                                                href="#">${i}</a></li>
                                    </c:forEach>
                                        <%--<li class="active"><a href="#">1</a></li>
                                        <li><a href="#">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#">4</a></li>
                                        <li><a href="#">5</a></li>--%>
                                    <li class="<c:if test="${artPage.pageNumb>=artPage.totalPages}">disabled</c:if>">
                                        <a href="${sessionScope.url}?pageNo=${artPage.pageNumb+1}&${sessionScope.query}"
                                           aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="panel panel-default">
                <div class="panel-heading">分类</div>
                <div id="tree" class=""></div>
            </div>
        </div>
    </div>
</div>

</body>
<!--bootstrap start-->
<script src="${baseurl}/v1/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${baseurl}/v1/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script src="${baseurl}/v1/js/blog.js"></script>
<!--bootstrap start-->
<script type="text/javascript" src="${baseurl}/v1/commentModel/js/jquery.flexText.js"></script>

<script type="text/javascript">
    $(function () {
        var testEditormdView;
        if (${showArt}) {
            $.get('${baseurl}Article/${articleInfo.path}', function (markdown) {
                testEditormdView = editormd.markdownToHTML("markdown-view", {
                    markdown: markdown, // + "\r\n" + $("#append-test").text(),
                    // htmlDecode : true, // 开启 HTML 标签解析，为了安全性，默认不开启
                    htmlDecode: "style,script,iframe", // you can filter tags decode
                    // toc : false,
                    tocm: true, // Using [TOCM]
                    // tocContainer : "#custom-toc-container", // 自定义 ToC 容器层
                    // gfm : false,
                    // tocDropdown : true,
                    // markdownSourceCode : true, // 是否保留 Markdown 源码，即是否删除保存源码的
                    // Textarea 标签
                    emoji: true,
                    taskList: true,
                    tex: true, // 默认不解析
                    flowChart: true, // 默认不解析
                    sequenceDiagram: true, // 默认不解析
                });
            });
        }
        // var testView = editormd.markdownToHTML("markdown-view", {
        //     // markdown : "[TOC]\n### Hello world!\n## Heading 2", // Also, you can dynamic set Markdown text
        //     // htmlDecode : true,  // Enable / disable HTML tag encode.
        //     // htmlDecode : "style,script,iframe",  // Note: If enabled, you should filter some dangerous HTML tags for website security.
        // });
        // console.log(testView);
    });
</script>
<!--分类-->
<script>
    $('#tree').treeview({
        data: ${userCategoryTree},
        enableLinks: true
    });
</script>
<!--评论-->

<script type="text/javascript">
    /*<!--textarea高度自适应-->*/
    $(function () {
        $('.content').flexText();
    });

    /*<!--textarea限制字数-->*/
    function keyUP(t) {
        var len = $(t).val().length;
        if (len > 139) {
            $(t).val($(t).val().substring(0, 140));
        }
    }

    /*<!--点击评论创建评论条-->*/
    $('.commentAll').on('click', '.plBtn', function () {
        var oThis = $(this);
        //获取时间
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth() + 1;
        var date = myDate.getDate();
        var h = myDate.getHours();       //获取当前小时数(0-23)
        var m = myDate.getMinutes();     //获取当前分钟数(0-59)
        if (m < 10) m = '0' + m;
        var s = myDate.getSeconds();
        if (s < 10) s = '0' + s;
        var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
        //获取输入内容
        var oSize = $(this).siblings('.flex-text-wrap').find('.comment-input').val();
        // 针对人id、用户名；通过el获取
        var replyUserId = '${blogUser.id}', replyUserName = '${blogUser.userName}';
        // 文章id；通过el获取
        var articleId = '${articleInfo.id}'
        // 当前用户id、用户名、头像；通过el获取登陆人信息
        var userId = '${userInfo.id}', userName = '${userInfo.userName}', headPath = '${userInfo.headPath}';
        //没有父id、没有根id

        console.log(oSize);
        //动态创建评论模块
        if (oSize.replace(/(^\s*)|(\s*$)/g, "") != '') {
            let formData = new FormData();
            formData.append("userId", userId);
            formData.append("userName", userName);
            formData.append("replyUserId", replyUserId);
            formData.append("replyUserName", replyUserName);
            formData.append("articleId", articleId);
            formData.append("headPath", headPath);
            formData.append("content", oSize);
            // formData.append("createTime", now);//时间不接受后台直接获取
            $.ajax({
                type: 'post',
                url: "${baseurl}comment",
                data: formData,
                dataType: "json",
                cache: false,
                processData: false,
                contentType: false,
                async: false,
                success: function (data) {
                    oHtml = '<div class="comment-show-con clearfix">' +
                        '<div class="comment-show-con-img pull-left">' +
                        '<img src="${baseurl}images/header/' + headPath + '" class="img-circle user-head-img" alt="">' +
                        '</div> ' +
                        '<div class="comment-show-con-list pull-left clearfix"><div class="pl-text clearfix"> ' +
                        '<a href="${baseurl}blogIndex/' + userId + '" class="comment-size-name">' + userName + ' : </a> ' +
                        '<span class="my-pl-con">&nbsp;' + oSize + '</span> </div> ' +
                        '<div class="date-dz"> <span class="date-dz-left pull-left comment-time">' +
                        now + '</span> <div class="date-dz-right pull-right comment-pl-block">' +
                        '<a href="javascript:;" class="removeBlock">删除</a> ' +
                        '<a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left" rootid="' +
                        data.comid + '" comid="' + data.comid + '" userid="' + userId + '" username="' + userName + '">回复</a> ' +
                        '<span class="pull-left date-dz-line">|</span> ' +
                        '<a href="javascript:;" class="date-dz-z pull-left"><span class="glyphicon glyphicon-thumbs-up">' +
                        '</span>赞 (<i class="z-num">0</i>)</a><span class="pull-left date-dz-line">|</span>' +
                        '<a href="javascript:;" class="date-dz-z pull-left"><span class="glyphicon glyphicon-thumbs-down">' +
                        '</span>踩 (<i class="z-num">0</i>)</a>' +
                        '</div><div class="hf-list-con"></div></div> </div>';
                    oThis.parents('.reviewArea ').siblings('.comment-show').append(oHtml);
                    oThis.siblings('.flex-text-wrap').find('.comment-input').prop('value', '').siblings('pre').find('span').text('');
                    ShowSuccess("评论成功");
                    $("#comment_count").html(data.commentCount);
                },
                error: function (data) {
                    // ShowFailure("评论失败");
                    hint("请先登录");
                }
            });
        }else{
            hint("内容不能为空");
        }
    });
    /*<!--点击回复动态创建回复块-->*/
    $('.comment-show').on('click', '.pl-hf', function () {
        let rootid = $(this).attr("rootid");
        let comid = $(this).attr("comid");
        let userid = $(this).attr("userid");
        let username = $(this).attr("username");
        //获取回复人的名字
        // var fhName = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        //回复@
        var fhN = '回复@' + username+':';
        //var oInput = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.hf-con');
        var fhHtml = '<div class="hf-con pull-left"> ' +
            '<textarea class="content comment-input hf-input" placeholder="" onkeyup="keyUP(this)"></textarea> ' +
            '<a href="javascript:;" class="hf-pl" rootid= "' + rootid + '" comid="' + comid + '" userid="' + userid + '" username="'+username+'">评论</a></div>';
        //显示回复
        if ($(this).is('.hf-con-block')) {
            $(this).parents('.date-dz-right').parents('.date-dz').append(fhHtml);
            $(this).removeClass('hf-con-block');
            $('.content').flexText();
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.pre').css('padding', '6px 15px');
            //console.log($(this).parents('.date-dz-right').siblings('.hf-con').find('.pre'))
            //input框自动聚焦
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.hf-input').val('').focus().val(fhN);
        } else {
            $(this).addClass('hf-con-block');
            $(this).parents('.date-dz-right').siblings('.hf-con').remove();
        }
    });
    /*<!--评论回复块创建-->*/
    $('.comment-show').on('click', '.hf-pl', function () {
        let rootid = $(this).attr("rootid");
        let comid = $(this).attr("comid");
        let userid = $(this).attr("userid");
        let username = $(this).attr("username");
        //获取时间
        var oThis = $(this);
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth() + 1;
        var date = myDate.getDate();
        var h = myDate.getHours();       //获取当前小时数(0-23)
        var m = myDate.getMinutes();     //获取当前分钟数(0-59)
        if (m < 10) m = '0' + m;
        var s = myDate.getSeconds();
        if (s < 10) s = '0' + s;
        var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
        //获取输入内容
        var oHfVal = oThis.siblings('.flex-text-wrap').find('.hf-input').val();
        // console.log(oHfVal)
        //针对用户名
        // var oHfName = oThis.parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        //添加回复前缀
        var oAllVal = '回复@' + username+':';
        if (oHfVal.replace(/^ +| +$/g, '') == '' || oHfVal == oAllVal) {
            //输入内容为空
            hint("评论内容不能为空")
        } else {
            var content;
            if (oHfVal.indexOf("@") == -1) {//没有则直接取品论内容
                content = oHfVal;
            } else {//有
                var arr = oHfVal.split(':');//分割输入内容，前面为"回复@我的名字 : ",后面为评论内容
                content = arr[1];//设置评论内容
            }
            let formData = new FormData();
            formData.append("userId", '${userInfo.id}');
            formData.append("userName", '${userInfo.userName}');
            formData.append("replyUserId", userid);
            formData.append("replyUserName", username);
            formData.append("articleId", '${articleInfo.id}');
            formData.append("headPath", '${userInfo.headPath}');
            formData.append("content", content);
            formData.append("parId", comid);
            formData.append("rootId", rootid);
            // formData.append("createTime", now);//时间不接受后台直接获取
            $.ajax({
                type: 'post',
                url: "${baseurl}comment",
                data: formData,
                dataType: "json",
                cache: false,
                processData: false,
                contentType: false,
                async: false,
                success: function (data) {
                    //生成回复的html代码
                    var oHtml = '<div class="all-pl-con">' +
                        '<div class="pl-text hfpl-text clearfix">' +
                        '<a href="${baseurl}blogIndex/${userInfo.id}" class="comment-size-name">${userInfo.userName} : </a>' +
                        '<span class="my-pl-con">' + '回复<a href="${baseurl}blogIndex/' + userid + '" class="atName">@' + username + '</a> : ' + content + '</span></div>' +
                        '<div class="date-dz"> <span class="date-dz-left pull-left comment-time">' +
                        now + '</span> <div class="date-dz-right pull-right comment-pl-block"> ' +
                        '<a href="javascript:;" class="removeBlock">删除</a> ' +
                        '<a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left"' +
                        ' rootid="' + rootid + '" comid="' + data.comid + '" userid="${userInfo.id}" username="${userInfo.userName}">回复</a> ' +
                        '<span class="pull-left date-dz-line">|</span> ' +
                        '<a href="javascript:;" class="date-dz-z pull-left"><span class="glyphicon glyphicon-thumbs-up"></span>' +
                        '赞 (<i class="z-num">0</i>)</a><span class="pull-left date-dz-line">|</span>' +
                        '<a href="javascript:;" class="date-dz-z pull-left"><span class="glyphicon glyphicon-thumbs-down">' +
                        '</span>踩 (<i class="z-num">0</i>)</a>' +
                        '</div> </div></div>';
                    //插入回复的html
                    // siblings(filter) 方法返回被选元素的所有同级元素。同级元素是共享相同父元素的元素。filter可选。规定缩小搜索同级元素范围的选择器表达式。
                    oThis.parents('.hf-con').parents('.comment-show-con-list').find('.hf-list-con').css('display', 'block').append(oHtml) //插入回复html
                    && oThis.parents('.hf-con').siblings('.date-dz-right').find('.pl-hf').addClass('hf-con-block') //应该是一个评论输入块拉起标志
                    && oThis.parents('.hf-con').remove();//收起品论输入块
                    ShowSuccess("回复成功");
                },
                error: function (data) {
                    // ShowFailure("回复失败");
                    hint("请先登录")
                }
            });
        }
    });
    /*<!--删除评论块-->*/
    $('.commentAll').on('click', '.removeBlock', function () {
        ShowWarn("该功能正在开发")
        return
        var oT = $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con');
        if (oT.siblings('.all-pl-con').length >= 1) {
            oT.remove();
        } else {
            $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con').parents('.hf-list-con').css('display', 'none')
            oT.remove();
        }
        $(this).parents('.date-dz-right').parents('.date-dz').parents('.comment-show-con-list').parents('.comment-show-con').remove();

    });
    /*点赞*/
    $('.comment-show').on('click', '.date-dz-z', function () {
        ShowWarn("该功能正在开发")
        return
        var zNum = $(this).find('.z-num').html();
        if ($(this).is('.date-dz-z-click')) {
            zNum--;
            $(this).removeClass('date-dz-z-click red');
            $(this).find('.z-num').html(zNum);
            $(this).find('.date-dz-z-click-red').removeClass('red');
        } else {
            zNum++;
            $(this).addClass('date-dz-z-click');
            $(this).find('.z-num').html(zNum);
            $(this).find('.date-dz-z-click-red').addClass('red');
        }
    });
</script>

<!--评论end-->
</html>