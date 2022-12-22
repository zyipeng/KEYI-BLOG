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
<c:set var="baseurl" value="${pageContext.request.contextPath}/"/>

<c:set var="sign" value="${param.get('sign')}/"/>
<!DOCTYPE html>
<html>
<head>
    <title>Discount Form Widget A Flat Responsive Widget Template </title>
    <link href="${baseurl}/v1/css/login.css" rel='stylesheet' type='text/css'/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <script src="${baseurl}/v1/jquery/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#horizontalTab').easyResponsiveTabs({
                type: 'default', //Types: default, vertical, accordion
                width: 'auto', //auto or any width like 600px
                fit: true   // 100% fit in a container
            });
        });
    </script>
</head>
<body  style="background: #0c6e6e;">
<div class="main-content">
    <div class="right-w3">
        <div class="sap_tabs">
            <div id="horizontalTab" style="display: block; width: 100%; margin: 0px;">
                <ul>
                    <li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>登录</span></li>
                    <li class="resp-tab-item" aria-controls="tab_item-1" role="tab"><span>注册</span></li>
                </ul>
                <div class="tab-2 resp-tab-content resp-tab-content-active" aria-labelledby="tab_item-0">
                    <form action="${baseurl}login" method="post">
                        <input placeholder="User Name" name="userName" class="username" type="text" required="" value="${userInfo.userName}">
                        <input placeholder="Password" name="pwd" class="lock" type="password" required="" value="${userInfo.pwd}">
                        <span class="checkbox1">
                                <label class="checkbox">
                                    <input type="checkbox" name="" checked="">
                                    <i></i>
                                    记住密码
                                </label>
                        </span>
                        <input type="submit" value="登录"/>
                    </form>
                </div>
                <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-1">
                    <form action="${baseurl}register" id="regform" method="post">
                        <input placeholder="User Name" name="userName" type="text" required="">
                        <input placeholder="Email Address" name="email" type="email" required="">
                        <input placeholder="Password" id="regpwd1" name="pwd" type="password" required="">
                        <input placeholder="Confirm Password" id="regpwd2" name="password" type="password" required="">
                        <span class="checkbox1">
                                <label class="checkbox"><input type="checkbox" name="" checked=""><i> </i>同意接受消息</label>
                        </span>
                        <input type="submit" value="创建账户"/>
                        <script>
                        </script>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="left-agile">
        <div class="left-text" style="color: #F4C20B;">
            <h2 style="color: #F4C20B;">
                <a href="${baseurl}index">BLOG</a>
            </h2>
            <h3 style="color: #F4C20B;">100% GOOT</h3>
            <h4 style="color: #F4C20B;">Login and Create To Get Glorious</h4>
        </div>
    </div>
    <div class="clear"></div>
</div>
<script src="${baseurl}/v1/js/login.js" type="text/javascript"></script>
<script>
    $(function () {
        if (${errorMsg!=null&&errorMsg!=""}){
            alert("${errorMsg}");
        }
    })

    $("#regform").submit(function () {
        var  regpwd1=$("#regpwd1").val();
        var  regpwd2=$("#regpwd2").val();
        if (regpwd1==regpwd2){
            return true;
        }else {
            alert("两次输入密码必须一致");
            return false;
        }
    })
</script>
</body>
</html>

