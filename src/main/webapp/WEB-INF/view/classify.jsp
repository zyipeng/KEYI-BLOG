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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
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
    <title>分类</title>
    <link href="${baseurl}/v1/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${baseurl}/v1/css/global.css" rel="stylesheet">
    <link href="${baseurl}/v1/css/search.css" rel="stylesheet">
</head>
<body>
<%@include file="/WEB-INF/view/top.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-3 pd05">
            <div class="panel panel-default">
                <div class="panel-body" style="height: 600px; overflow-y: auto">
                    <c:forEach var="label" items="${labelList}">
                        <a href="${baseurl}classify?labelId=${label.id}" class="btn btn-default">${label.id}</a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="col-lg-9 pd05">
            <div class="panel panel-default">
                <div class="panel-body">
                    <ul class="media-list">
                        <c:forEach var="blog" items="${artPage.result}">
                            <li class="media" style="padding: 15px;border-radius: 1rem">
                                <div class="media-body">
                                    <h3 class="media-heading " style="font-size: 18px;font-weight: bold;">
                                        <a href="${baseurl}blogIndex/${blog.userId}?artId=${blog.id}">${blog.name}</a>
                                    </h3>
                                        ${blog.intro}
                                    <br>
                                    <fmt:formatDate value="${blog.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span class="glyphicon glyphicon-eye-open"></span>${blog.visitCount}
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span class="glyphicon glyphicon-comment"></span>${blog.commentCount}
                                </div>
                                <div class="media-right">
                                    <a href="#">
                                        <img class="media-object blog-media-img" src="${blogurl}${blog.imgPath}" alt="...">
                                    </a>
                                </div>
                            </li>
                        </c:forEach>

                    </ul>

                    <c:if test="${artPage.totalPages>1}">
                        <nav aria-label="Page navigation">
                            <ul class="pagination pull-right pd50" style="margin: 0px">
                                <li class="<c:if test="${artPage.pageNumb<=1}">disabled</c:if>">
                                    <a href="${sessionScope.allSearchUrl}?pageNo=${artPage.pageNumb-1}&${sessionScope.allSearchQuery}"
                                       aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach var="i" begin="1" end="${artPage.totalPages}">
                                    <li class="<c:if test="${i==artPage.pageNumb}">active</c:if>"><a
                                            href="#">${i}</a></li>
                                </c:forEach>
                                <li class="<c:if test="${artPage.pageNumb>=artPage.totalPages}">disabled</c:if>">
                                    <a href="${sessionScope.allSearchUrl}?pageNo=${artPage.pageNumb+1}&${sessionScope.allSearchQuery}"
                                       aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<!--bootstrap\jquery start-->
<script src="${baseurl}/v1/jquery/jquery-3.4.1.min.js"></script>
<script src="${baseurl}/v1/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<!--bootstrap\jquery start-->
</html>