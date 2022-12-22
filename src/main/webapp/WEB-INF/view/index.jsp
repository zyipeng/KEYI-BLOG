<%--
  Created by IntelliJ IDEA.
  User: zhouyp
  Date: 2020/5/11
  Time: 20:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<c:set var="baseurl" value="${pageContext.request.contextPath}/"/>
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
    <title>首页</title>
    <link href="${baseurl}/v1/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${baseurl}/v1/css/global.css" rel="stylesheet">
    <link href="${baseurl}/v1/css/index.css" rel="stylesheet">
    <style>
        .carousel img {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/view/top.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-8 pd05">
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="height: 350px;">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner wh100" role="listbox">
                    <div class="item wh100 active">
                        <img src="${baseurl}/v1/img/Carousel1.svg" style="height: 100%; width: 100%" alt="...">
                        <div class="carousel-caption">
                            <h4>Carousel1</h4>
                            <span>Carousel1Carousel1Carousel1Carousel1</span>
                        </div>
                    </div>
                    <div class="item wh100">
                        <img src="${baseurl}/v1/img/Carousel2.svg" style="height: 100%; width: 100%" alt="...">
                        <div class="carousel-caption">
                            ...
                        </div>
                    </div>
                    <div class="item wh100">
                        <img src="${baseurl}/v1/img/Carousel3.svg" style="height: 100%; width: 100%" alt="...">
                        <div class="carousel-caption">
                            ...
                        </div>
                    </div>
                </div>

                <!-- Controls -->
                <a class="left carousel-control" href="${baseurl}/v1/#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="${baseurl}/v1/#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <div class="panel panel-default mt10">
                <div class="panel-heading">热门博客</div>
                <div class="panel-body">
                    <ul class="media-list">
                        <c:forEach var="hotArt" items="${hotArtList}">
                            <li class="media" style="padding: 15px;border-radius: 1rem">
                                <div class="media-body">
                                    <h3 class="media-heading " style="font-size: 18px;font-weight: bold;">
                                        <a href="${baseurl}blogIndex/${hotArt.userId}?artId=${hotArt.id}">${hotArt.name}</a>
                                    </h3>
                                    ${hotArt.intro}
                                    ... ...
                                    <br>
                                    ${hotArt.createTime}
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span class="glyphicon glyphicon-eye-open"></span>${hotArt.visitCount}
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span class="glyphicon glyphicon-comment"></span>${hotArt.commentCount}
                                </div>
                                <div class="media-right">
                                    <a href="${baseurl}blogIndex/${hotArt.userId}?${hotArt.id}">
                                        <img class="media-object blog-media-img" src="${baseurl}/v1/img/temp01.png" alt="...">
                                    </a>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="media">
                        <a class="btn btn-default btn-lg" style="width: 100%" href="${baseurl}search?range=blog" role="button">查看全部</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 pd05">
            <div class="videoBox"></div>
            <div class="panel panel-default mt10">
                <div class="panel-heading">热门博主</div>
                <div class="panel-body">
                    <ul class="media-list">
                        <c:forEach var="hotUser" items="${hotUseList}">
                            <li class="media" style="padding: 5px;border-radius: 1rem">
                                <div class="media-left">
                                    <a href="${baseurl}blogIndex/${hotUser.id}">
                                        <img class="media-object user-media-img" src="${baseurl}/v1/img/temp01.png" alt="...">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="${baseurl}blogIndex/${hotUser.id}">${hotUser.userName}</a></h4>
                                    <%--<button class="btn btn-default pull-right" style="padding: 2px 5px">
                                        <span class="glyphicon glyphicon-plus"></span>关注
                                    </button>--%>
                                    <br>
                                    <span class="glyphicon glyphicon-heart"></span>100
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span class="glyphicon glyphicon-comment"></span>100
                                </div>
                        </c:forEach>
                        <%--<li class="media" style="padding: 5px;">
                            <div class="media-left">
                                <a href="#">
                                    <img class="media-object user-media-img" src="${baseurl}/v1/img/temp01.png" alt="...">
                                </a>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading">ke_yi_</h4>
                                <button class="btn btn-default pull-right" style="padding: 2px 5px">
                                    <span class="glyphicon glyphicon-plus"></span>关注
                                </button>
                                <br>
                                <span class="glyphicon glyphicon-heart"></span>100
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="glyphicon glyphicon-comment"></span>100
                            </div>
                        </li>--%>
                    </ul>
                    <div class="media">
                        <a class="btn btn-default btn-lg" style="width: 100%" href="${baseurl}search?range=user" role="button">查看全部 >></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal-footer">
    <span>power by zhouyp</span>
</div>
</body>
<!--bootstrap\jquery start-->
<script src="${baseurl}/v1/jquery/jquery-3.4.1.min.js"></script>
<script src="${baseurl}/v1/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${baseurl}/v1/js/index.js"></script>
<!--bootstrap\jquery start-->
<script>
    var danmus;/*="[\n" +
        "    {\n" +
        "        \"blogId\": \"62646fd3-99b0-11ea-9c2c-005056c00001\", \n" +
        "        \"commentId\": \"1\", \n" +
        "        \"value\": \"你好1！！！\"\n" +
        "    }, \n" +
        "    {\n" +
        "        \"blogId\": \"62646fd3-99b0-11ea-9c2c-005056c00001\", \n" +
        "        \"commentId\": \"2\", \n" +
        "        \"value\": \"你好2！！！\"\n" +
        "    }, \n" +
        "    {\n" +
        "        \"blogId\": \"62646fd3-99b0-11ea-9c2c-005056c00001\", \n" +
        "        \"commentId\": \"3\", \n" +
        "        \"value\": \"你好3！！！\"\n" +
        "    }, \n" +
        "    {\n" +
        "        \"blogId\": \"62646fd3-99b0-11ea-9c2c-005056c00001\", \n" +
        "        \"commentId\": \"4\", \n" +
        "        \"value\": \"你好4！！！\"\n" +
        "    }\n" +
        "]"*/
    function getRandomCommentDate(){
        $.get("${baseurl}randomCom",function (data) {
            danmus = JSON.parse(data);
        })
    }
    function sends() {
        danmus.forEach(function (value, index, array) {
            add(value.value,"${baseurl}blogIndex/"+value.blogId);
        });
    }
</script>
</html>