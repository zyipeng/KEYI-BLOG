<%--
  Created by IntelliJ IDEA.
  User: zhouyp
  Date: 2020/5/20
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="baseurl" value="${pageContext.request.contextPath}/"/>
<html>
<head>
    <!--对移动设备友好
    不同屏幕分辨率的设备浏览,
    1:1 的比例呈现,
    只能滚动屏幕,
    禁用其缩放
    -->
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta charset="UTF-8">
    <title>选择标签</title>
    <link href="${baseurl}/v1/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${baseurl}/v1/css/global.css" rel="stylesheet">
    <style>
        .label-clk{
            margin: 6px 4px 0 0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="col-lg-12">
        <form id="clkform" action="clklabel" method="post">
        <div class="panel panel-success">
                <div class="panel-heading">
                    欢迎使用，请选择个人标签，便于个性化推荐！！！
                        <input type="submit" class="btn btn-primary btn-sm" style="margin-left: 65%;" value="提交">
                </div>
                <div class="panel-body">
                    <c:forEach items="${labelList}" var="label">
                        <input type="button" class="btn btn-info btn-xs label-clk" name="label" value="${label.id}">
                    </c:forEach>
                </div>
            <div class="panel-footer">没有找到符合的标签
                <input type="button" class="btn btn-primary btn-sm" value="添加标签">
            </div>
        </div>
        </form>
    </div>
</div>
</body>
<!--bootstrap\jquery start-->
<script src="${baseurl}/v1/jquery/jquery-3.4.1.min.js"></script>
<script src="${baseurl}/v1/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<!--bootstrap\jquery start-->
<script>
    $(".label-clk").click(function (e) {

        if($(this).hasClass("btn-info")){
            let clkSuc = document.getElementsByClassName("label-clk btn-success");
            if (clkSuc.length<10){
                $(this).removeClass("btn-info")
                $(this).addClass("btn-success")
                $(this).css("checked","checked");
            }else {
                hint("最多选择10个标签");
            }
        }else{
            $(this).addClass("btn-info")
            $(this).removeClass("btn-success")
            $(this).removeAttribute("checked")
        }
    });

    $("#clkform").submit(function () {

        console.log("start");
        let labStr = '';
        $(".btn-success").each(function (key,value) {
            labStr += $(value).val()+',';
        })
        let $input = $("<input>");
        $input.attr("name", "label");
        $input.attr("type","hidden")
        $input.attr("value",labStr)
        $(this).append($input)
        return true;
    })
</script>
</html>
