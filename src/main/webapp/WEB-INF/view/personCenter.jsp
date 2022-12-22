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
    <title>个人中心</title>
    <link href="${baseurl}/v1/css/global.css" rel="stylesheet">
    <link href="${baseurl}/v1/css/personCenter.css" rel="stylesheet">
    <link href="${baseurl}/v1/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!--分类-->
    <link href="${baseurl}/v1/bootstrap-treeview/bootstrap-treeview.min.css" rel="stylesheet">
    <!--editor.md css-->
    <link rel="stylesheet" href="${baseurl}/editor.md/css/editormd.css"/>
    <!--jquery提前加载提供editormd.js依赖-->
    <script src="${baseurl}/v1/jquery/jquery-3.4.1.min.js"></script>

    <!--editor.md js-->
    <script src="${baseurl}/editor.md/editormd.js"></script>
</head>
<body style="padding-top: 80px; background: #0c6e6e;">
<%@include file="/WEB-INF/view/top.jsp" %>
<div class='container'>
    <div class="row tabbable tabs-left panel panel-default" style="height: 550px">
        <ul class='nav nav-tabs col-lg-2 panel-heading' style="padding-right: 0px; height: 100%">
            <li class="active"><a href='#tab1' data-toggle='tab'>我的资料</a></li>
            <li><a href='#tab2' data-toggle='tab'>我的收藏</a></li>
            <li><a href='#tab3' data-toggle='tab'>我的关注</a></li>
            <li><a href='#tab4' data-toggle='tab'>我的粉丝</a></li>
            <li><a href='#tab5' data-toggle='tab'>分类管理</a></li>
            <li><a href='#tab6' id="t6" data-toggle='tab'>博客编辑</a></li>
            <%--<li><a href='#tab7' data-toggle='tab'>选项七</a></li>
            <li><a href='#tab8' data-toggle='tab'>选项八</a></li>
            <li><a href='#tab9' data-toggle='tab'>选项九</a></li>
            <li><a href='#tab10' data-toggle='tab'>选项十</a></li>--%>
        </ul>
        <div class='col-lg-10 tab-content panel-body' style="height: 100%">
            <div class='tab-pane container-fluid active' id='tab1'>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="row">
                            <div class="col-xs-6 col-md-3 center-block">
                                <a href="#" class="thumbnail">
                                    <img id="header_show" src="${headerurl}" alt="头像">
                                </a>
                            </div>
                            <div class="col-lg-6 col-md-3">
                                <form id="header_form" method="post" enctype="multipart/form-data">
                                    <input type="file" name="header_change" id="header_change"
                                           class="btn btn-info btn-sm btn-block">
                                    <input type="button" id="header_up" class="btn btn-success btn-sm btn-block"
                                           value="上传头像">
                                    <script>
                                        $("#header_up").click(function () {
                                            let formData = new FormData($("#header_form")[0]);
                                            $.ajax({
                                                type: 'post',
                                                url: "${baseurl}headerUp",
                                                data: formData,
                                                cache: false,
                                                processData: false,
                                                contentType: false,
                                                success: function (data) {
                                                    hint(data);
                                                },
                                                error: function (data) {
                                                    hint(data);
                                                }
                                            });
                                        });
                                        $("#header_change").on("change", function () {
                                            var objUrl = getObjectURL(this.files[0]); //获取图片的路径，该路径不是图片在本地的路径
                                            if (objUrl) {
                                                $("#header_show").attr("src", objUrl); //将图片路径存入src中，显示出图片
                                            }
                                        });

                                        function getObjectURL(file) {
                                            var url = null;
                                            if (window.createObjectURL != undefined) { //basic
                                                url = window.createObjectURL(file);
                                            } else if (window.URL != undefined) { //mozilla(firefox)
                                                url = window.URL.createObjectURL(file);
                                            } else if (window.webkitURL != undefined) { //webkit or chrome
                                                url = window.webkitURL.createObjectURL(file);
                                            }
                                            return url;
                                        }
                                    </script>
                                </form>
                            </div>
                        </div>
                        <form class="form-horizontal" id="expand_form">
                            <div class="form-group">
                                <label for="intro">个人简介：</label>
                                <textarea class="form-control userinfo_expand" name="intro" id="intro"
                                          disabled>${userInfo.intro}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="inter">兴趣</label>
                                <textarea class="form-control userinfo_expand" name="inter" id="inter"
                                          disabled>${userInfo.inter}</textarea>
                            </div>
                            <div class="form-group text-right">
                                <button type="button" id="alter_expand" class="btn btn-info btn-sm">修改扩展信息</button>
                                <button type="button" id="cancel_alter_expand" class="btn btn-info btn-sm hidden">取消
                                </button>
                                <input type="button" id="submit_alter_expand"
                                       class="btn btn-success btn-sm userinfo_expand" value="提交" disabled>
                                <script>

                                    $("#submit_alter_expand").click(function () {
                                        let formData = new FormData($("#expand_form")[0]);
                                        subMsgForm(new FormData($("#expand_form")[0]));
                                        $(".userinfo_expand").attr("disabled", "disabled")
                                        $(this).addClass("hidden")
                                        $("#alter_expand").removeClass("hidden");
                                    });
                                    $("#alter_expand").click(function () {
                                        $(".userinfo_expand").removeAttr("disabled")
                                        $(this).addClass("hidden")
                                        $("#cancel_alter_expand").removeClass("hidden");
                                    });
                                    $("#cancel_alter_expand").click(function () {
                                        $("#intro").val("${userInfo.intro}");
                                        $("#inter").val("${userInfo.inter}");
                                        $(".userinfo_expand").attr("disabled", "disabled")
                                        $(this).addClass("hidden")
                                        $("#alter_expand").removeClass("hidden");
                                    });
                                </script>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-6">
                        <form class="form-horizontal" id="base_form">
                            <div class="form-group form-group-sm">
                                <label class="col-sm-2 control-label" for="userName">昵称:</label>
                                <div class="col-sm-10">
                                    <input class="form-control userinfo_base" type="text" id="userName"
                                           placeholder="username input"
                                           name="userName" value="${userInfo.userName}" disabled>
                                </div>
                                <script>
                                    $("#userName").change(function () {
                                        if ($(this).val() != "${userInfo.userName}") {
                                            /*如果改变昵称，则判断昵称是否可以使用*/
                                            checkAjax("userName", this, "${userInfo.userName}");
                                        }
                                    });
                                    $("#email").change(function () {
                                        if ($(this).val() != "${userInfo.email}") {
                                            /*如果改变昵称，则判断昵称是否可以使用*/
                                            checkAjax("email", this, "${userInfo.email}");
                                        }
                                    });

                                    function checkAjax(param, inputVal, oldVal) {
                                        $.ajax({
                                            type: 'post',
                                            url: "${baseurl}check/userName",
                                            data: {
                                                "paramValue": $(inputVal).val()
                                            },
                                            // dataType:"json",//设置后端返回json.parse
                                            // cache: false,
                                            /*
                                            当设置为true的时候,jquery ajax 提交的时候不会序列化 data，而是直接使用data
                                            默认情况下会将发送的数据序列化以适应默认的内容类型application/x-www-form-urlencoded
                                            如果想发送不想转换的的信息的时候需要手动将其设置为false
                                            在我遇到的是传输的是blob对象的时候就是不需要将传输的数据序列化,一般的还有类似DOM树等
                                            */
                                            // processData: false,
                                            /* contentType 主要设置你发送给服务器的格式*/
                                            // contentType: false,
                                            success: function (data) {
                                                if (data != "success") {
                                                    hint(data);
                                                    $(inputVal).val(oldVal);
                                                }
                                            }
                                        })
                                    }
                                </script>
                            </div>
                            <div class="form-group form-group-sm">
                                <label class="col-sm-2 control-label userinfo_base" for="phoneCode">电话:</label>
                                <div class="col-sm-10">
                                    <input class="form-control userinfo_base" type="text" id="phoneCode"
                                           placeholder="phoneCode input"
                                           name="phoneCode" value="${userInfo.phoneCode}" disabled>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <label class="col-sm-2 control-label" for="sex">性别:</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" class=" userinfo_base" name="sex" id="sex" value="1"
                                               <c:if test="${userInfo.sex==1}">checked</c:if> disabled> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" class=" userinfo_base" name="sex" id="sex1" value="2"
                                               <c:if test="${userInfo.sex!=1}">checked</c:if> disabled> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <label class="col-sm-2 control-label" for="birthday">生日:</label>
                                <div class="col-sm-10">
                                    <input class="form-control userinfo_base" type="date" id="birthday"
                                           placeholder="sex input"
                                           name="birth"
                                           value="<fmt:formatDate value="${userInfo.birthday}" pattern="yyyy-MM-dd"/>"
                                           disabled>

                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <label class="col-sm-2 control-label" for="email">邮箱:</label>
                                <div class="col-sm-10">
                                    <input class="form-control userinfo_base" type="text" id="email"
                                           placeholder="email input"
                                           name="email" value="${userInfo.email}" disabled>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <label class="col-sm-2 control-label" for="qq">qq:</label>
                                <div class="col-sm-10">
                                    <input class="form-control userinfo_base" type="text" id="qq"
                                           placeholder="email input" name="qq"
                                           value="${userInfo.qq}" disabled>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <label class="col-sm-2 control-label" for="wechat">微信:</label>
                                <div class="col-sm-10">
                                    <input class="form-control userinfo_base" type="text" id="wechat"
                                           placeholder="wechat input"
                                           name="wechat" value="${userInfo.wechat}" disabled>
                                </div>
                            </div>
                            <div class="text-right">
                                <button type="button" id="alter_base" class="btn btn-info btn-sm">修改基本信息</button>
                                <button type="button" id="cancel_alter_base" class="btn btn-info btn-sm hidden">取消
                                </button>
                                <input type="button" id="submit_alter_base" class="btn btn-success btn-sm userinfo_base"
                                       value="提交" disabled>
                                <script>
                                    $("#submit_alter_base").click(function () {
                                        let formData = new FormData($("#base_form")[0]);
                                        subMsgForm(formData);
                                        $(".userinfo_base").attr("disabled", "disabled")
                                        $(this).addClass("hidden")
                                        $("#alter_base").removeClass("hidden");
                                    });

                                    function subMsgForm(formData) {
                                        $.ajax({
                                            type: 'post',
                                            url: "${baseurl}alterUserInfo",
                                            data: formData,
                                            cache: false,
                                            processData: false,
                                            contentType: false,
                                            async: false,
                                            success: function (data) {
                                                hint(data);
                                            },
                                            error: function (data) {
                                                hint(data);
                                            }
                                        });
                                    }

                                    $("#alter_base").click(function () {
                                        $(".userinfo_base").removeAttr("disabled")
                                        $(this).addClass("hidden")
                                        $("#cancel_alter_base").removeClass("hidden");
                                    });
                                    $("#cancel_alter_base").click(function () {
                                        $("#userName").val("${userInfo.userName}");
                                        $("#phoneCode").val("${userInfo.phoneCode}");
                                        /*使用attr设置checked无效，改用prop*/
                                        if (${userInfo.sex==1}) {
                                            $("#sex").prop("checked", true);
                                            $("#sex1").prop("checked", false);
                                        } else {
                                            $("#sex").prop("checked", false);
                                            $("#sex1").prop("checked", true);
                                        }
                                        $("#birthday").val("${userInfo.birthday}");
                                        $("#email").val("${userInfo.email}");
                                        $("#qq").val("${userInfo.qq}");
                                        $("#wechat").val("${userInfo.wechat}");
                                        $(".userinfo_base").attr("disabled", "disabled")
                                        $(this).addClass("hidden")
                                        $("#alter_base").removeClass("hidden");
                                    });

                                </script>
                            </div>
                        </form>
                    </div>
                </div>
            </div><!--信息编辑-->
            <div class='tab-pane' id='tab2'><!--我的收藏-->
                <div class="container-fluid pd0">
                    <c:forEach var="coll" items="${collectPage.result}">
                        <div class="col-lg-6 pd0" id="${coll.id}">
                            <div class="media">
                                <div class="media-body">
                                    <h4 class="media-heading">
                                        <a href="#">
                                                ${coll.name}
                                        </a>
                                    </h4>
                                    <p style="overflow: hidden;text-overflow: ellipsis;
                                white-space: nowrap;max-width: 310px;">
                                            ${coll.intro}
                                    </p>
                                    <a href="#">作者</a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <fmt:formatDate value="${coll.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </div>
                                <div class="media-right">
                                    <div class="center-block" style="height: 80px;width: 80px;">
                                        <button type="button" class="btn btn-default collect_art"
                                                style="margin-top: 25px" blogId="${coll.id}">取消收藏
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${attentionPage.totalPages>1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination pull-right" style="margin: 5px 35px;">
                            <li class="<c:if test="${attentionPage.pageNumb<=1}">disabled</c:if>">
                                <a href="${baseurl}?pageNo=${attentionPage.pageNumb-1}&${sessionScope.query}"
                                   aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach var="i" begin="1" end="${attentionPage.totalPages}">
                                <li class="<c:if test="${i==attentionPage.pageNumb}">active</c:if>"><a
                                        href="#">${i}</a></li>
                            </c:forEach>
                            <li class="<c:if test="${attentionPage.pageNumb>=attentionPage.totalPages}">disabled</c:if>">
                                <a href="${baseurl}?pageNo=${attentionPage.pageNumb+1}"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>

                <%--<ul class="media-list">
                    <li class="media center-block" style="padding: 10px;width: 650px; background-color: #d7d4f0; border-bottom: solid 1px #000;">
                        <div class="media-body">
                            <h3 class="media-heading " style="font-size: 16px;font-weight: bold;">
                                钢铁是怎样炼成的
                            </h3>
                            <br>
                            ke_yi_
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            2020-01-10 20:20:20
                        </div>
                        <div class="media-right">
                            <div class="center-block" style="height: 80px;width: 80px;">
                                <button type="button" class="btn btn-default" style="margin-top: 25px">取消收藏</button>
                            </div>
                        </div>
                    </li>
                </ul>--%>
            </div><!--我的收藏-->
            <div class='tab-pane' id='tab3'><!--我的关注-->
                <div class="container-fluid pd0">
                    <c:forEach var="att" items="${attentionPage.result}">
                        <div class="col-lg-6 pd0" id="${att.id}">
                            <div class="media">
                                <div class="media-left">
                                    <a href="#">
                                        <img class="media-object user-media-img"
                                             src="${baseurl}images/header/${att.headPath}"
                                             alt="...">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <h4 class="media-heading">
                                        <a href="${baseurl}blogIndex/${att.id}">
                                                ${att.userName}
                                        </a>
                                    </h4>
                                    <button class="btn btn-default pull-right attention_but" style="padding: 2px 5px"
                                            userId="${att.id}">
                                        <span class="glyphicon glyphicon-minus"></span>取消关注
                                    </button>
                                    <br>
                                    <span class="glyphicon glyphicon-heart"></span>${att.likeCount}
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span class="glyphicon glyphicon-eye-open"></span>${att.visitCount}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${collectPage.totalPages>1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination pull-right" style="margin: 5px 35px;">
                            <li class="<c:if test="${collectPage.pageNumb<=1}">disabled</c:if>">
                                <a href="${baseurl}?pageNo=${collectPage.pageNumb-1}"
                                   aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach var="i" begin="1" end="${collectPage.totalPages}">
                                <li class="<c:if test="${i==collectPage.pageNumb}">active</c:if>"><a
                                        href="#">${i}</a></li>
                            </c:forEach>
                            <li class="<c:if test="${collectPage.pageNumb>=collectPage.totalPages}">disabled</c:if>">
                                <a href="${baseurl}?pageNo=${collectPage.pageNumb+1}"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div><!--我的关注-->
            <div class='tab-pane' id='tab4'><!--我的粉丝-->
                <div class="container-fluid pd0">
                    <c:forEach var="fans" items="${fansPage.result}">
                        <div class="col-lg-6 pd0">
                            <div class="media">
                                <div class="media-left">
                                    <a href="#">
                                        <img class="media-object user-media-img"
                                             src="${baseurl}images/header/${fans.headPath}"
                                             alt="...">
                                    </a>
                                </div>
                                <div class="media-body">
                                    <h4 class="media-heading">
                                        <a href="${baseurl}blogIndex/${fans.id}">
                                                ${fans.userName}
                                        </a>
                                    </h4>
                                    <button class="btn btn-default pull-right attention_but" style="padding: 2px 5px"
                                            userId="${fans.id}">
                                        <c:choose>
                                            <c:when test="${!fans.attentionFlag}">
                                                <span class="glyphicon glyphicon-plus"></span>关注
                                            </c:when>
                                            <c:otherwise>
                                                <span class="glyphicon glyphicon-minus"></span>取消关注
                                            </c:otherwise>
                                        </c:choose>
                                    </button>
                                    <br>
                                    <span class="glyphicon glyphicon-heart"></span>${fans.likeCount}
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span class="glyphicon glyphicon-eye-open"></span>${fans.visitCount}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${fansPage.totalPages>1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination pull-right" style="margin: 5px 35px;">
                            <li class="<c:if test="${fansPage.pageNumb<=1}">disabled</c:if>">
                                <a href="${baseurl}?pageNo=${fansPage.pageNumb-1}"
                                   aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach var="i" begin="1" end="${fansPage.totalPages}">
                                <li class="<c:if test="${i==fansPage.pageNumb}">active</c:if>"><a
                                        href="#">${i}</a></li>
                            </c:forEach>
                            <li class="<c:if test="${fansPage.pageNumb>=fansPage.totalPages}">disabled</c:if>">
                                <a href="${baseurl}?pageNo=${fansPage.pageNumb+1}"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div><!--我的粉丝-->
            <div class='tab-pane panel panel-default' id='tab5'>
                <div class="panel-heading">
                    <div class="btn-group" role="group" aria-label="...">
                        <button type="button" id="add_cata" class="btn btn-default">添加</button>
                        <button type="button" id="alter_cata" class="btn btn-default">修改</button>
                        <button type="button" id="del_cata" class="btn btn-default">删除</button>
                        <button type="button" id="open_cata" class="btn btn-default">展开</button>
                        <button type="button" id="close_cata" class="btn btn-default">关闭</button>
                        <div class="input-group">
                            <input type="text" id="find_patten" class="form-control" placeholder="Search for...">
                            <span class="input-group-btn">
                            <button class="btn btn-default" id="find_cata" type="button">查询</button>
                          </span>
                        </div><!-- /input-group -->
                    </div>
                    <script>
                        /*不能把nodeId设进入，也不能直接获取父亲的id，只能通过getNode(父id）获取父亲的id*/
                        $("#close_cata").click(function () {
                            $('#tree').treeview('expandAll', {levels: 1, silent: true});
                        });
                        $("#open_cata").click(function () {
                            $('#tree').treeview('expandAll', {levels: 3, silent: true});
                        });
                        $("#add_cata").click(function () {
                            /*添加提交事件设置*/
                            //弹框标题
                            $("#sub_msg_input").text("添加")
                            //设置提交内容
                            $("#cata_name").val("");
                            //设置提交按钮
                            $("#sub_add_cata").removeClass("hidden");
                            $("#sub_alter_cata").addClass("hidden");
                            $("#form_modal").modal('show');
                        });
                        $("#alter_cata").click(function () {
                            try {
                                let text = $('#tree').treeview('getSelected', 0)[0]['text'];
                                console.log(text)
                                /*修改提交事件设置*/
                                //弹框标题
                                $("#sub_msg_input").text("修改")
                                //设置提交内容
                                $("#cata_name").val(text);
                                //设置提交按钮
                                $("#sub_add_cata").addClass("hidden");
                                $("#sub_alter_cata").removeClass("hidden");
                                $("#form_modal").modal('show');
                            } catch (e) {
                                hint("请先选择分类");
                            }
                        });
                        $("#del_cata").click(function () {
                            try {
                                let id = $('#tree').treeview('getSelected', 0)[0]['id'];
                                let name = $('#tree').treeview('getSelected', 0)[0]['text'];
                                if (confirm("确认删除" + name + "分类吗？")) {
                                    $.ajax({
                                        type: 'post',
                                        url: "${baseurl}/savecata",
                                        data: {
                                            "id": id
                                        },
                                        success: function () {
                                            hint("删除成功");
                                        },
                                        error: function () {
                                            hint("删除失败");
                                        }
                                    })
                                }
                            } catch (e) {
                                hint("请先选择分类");
                            }
                        });
                        $("#find_cata").click(function () {
                            $('#tree').treeview('search', [$("#find_patten").val(), {
                                ignoreCase: true,     // case insensitive
                                exactMatch: false,    // like or equals
                                revealResults: true,  // reveal matching nodes
                            }]);
                        });

                        function addCata() {
                            $("#form_modal").modal('hide');
                            let parentId, b = true;
                            try {
                                parentId = $('#tree').treeview('getSelected', 0)[0]['id'];
                            } catch (e) {
                                b = confirm("继续添加顶级分类？");
                            }
                            if (b) {
                                $.ajax({
                                    type: 'post',
                                    url: "${baseurl}/savecata",
                                    data: {
                                        "parId": parentId,
                                        "name": $("#cata_name").val()
                                    },
                                    dataType: "json",
                                    success: function (data) {
                                        $('#tree').treeview({
                                            data: data['userCategoryTree'],
                                            enableLinks: true
                                        });
                                        hint("添加成功");
                                    },
                                    error: function () {
                                        hint("添加失败");
                                    }
                                });
                            }
                        }

                        function alterCata() {
                            $("#form_modal").modal('hide');
                            $.ajax({
                                type: 'post',
                                url: "${baseurl}/savecata",
                                data: {
                                    "id": $('#tree').treeview('getSelected', 0)[0]['id'],
                                    "name": $("#cata_name").val()
                                },
                                dataType: "json",
                                success: function (data) {
                                    $('#tree').treeview({
                                        data: data['userCategoryTree'],
                                        enableLinks: true
                                    });
                                    hint("修改成功");
                                },
                                error: function () {
                                    hint("修改失败");
                                }
                            });
                        }
                    </script>
                    <!--提交表单-->
                    <div class="modal fade" id="form_modal" tabindex="-1" role="dialog"
                         aria-labelledby="exampleModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="sub_msg_input" id="exampleModalLabel"></h4>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <div class="form-group">
                                            <label for="cata_name" class="control-label">分类名:</label>
                                            <input type="text" class="form-control" name="name" id="cata_name" required>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="button" id="sub_add_cata" onclick="addCata()" class="btn btn-primary">
                                        提交
                                    </button>
                                    <button type="button" id="sub_alter_cata" onclick="alterCata()"
                                            class="btn btn-primary">提交
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--提交表单-->
                </div>

                <div class="panel-body" style="height: 450px;overflow-y:auto;">
                    <div id="tree"></div>
                </div>
            </div><!--分类管理-->
            <div class='tab-pane' id='tab6'>
                <form id="editor_from" method="post">
                    <div class="form-inline" role="group" aria-label="..." style="margin-bottom: 10px">
                        <input type="button" id="new_art" class="btn btn-danger btn-sm" value="新建博客">
                        <div class="input-group">
                            <input type="text" name="name" class="form-control" placeholder="博客标题"
                                   value="${articleInfo.name}">
                            <input type="hidden" name="id" id="art_id" value="${articleInfo.id}">
                        </div>
                        <div class="input-group">
                            <select name="labelId" id="label_id" class="form-control">
                                <option value="">选择标签</option>
                                <c:forEach var="label" items="${labelList}">
                                    <option value="${label.labelId}">${label.labelName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="input-group">
                            <div class="btn-group">
                                <select name="categoryId" id="category_id" class="form-control">
                                    <option value="">选择分类</option>
                                    <c:forEach var="cate" items="${categoryList}">
                                        <option value="${cate.id}">${cate.name}</option>
                                    </c:forEach>
                                </select>
                                <input type="button" id="refresh_cate" class="btn btn-info" value="刷新分类">
                                <script>
                                    $("#refresh_cate").click(function () {
                                        $.get("${baseurl}editor/refreshCata",function (data) {
                                            // console.log(data[i].id);
                                            let parse = JSON.parse(data);
                                            // console.log(parse)
                                            var html="<option>选择分类</option>";
                                            $.each(parse, function (n, value) {
                                                html += "<option value='"+value.id+"'>"+value.name+"</option>";
                                            });
                                            $("#category_id").html(html);

                                        });

                                    })
                                </script>
                            </div>
                        </div>
                        <div class="btn-group" style="float: right">
                            <input type="button" id="save_art" class="btn btn-info" value="保存">
                            <input type="button" id="issue_art" class="btn btn-success" value="提交">
                        </div>
                    </div>
                    <div id="editor">
                        <textarea name="content" style="display:none;" placeholder="在此处编辑博客内容"></textarea>
                    </div>
                </form>
                <script type="text/javascript">
                    $("#new_art").click(function () {
                        let formData = new FormData($("#editor_from")[0]);
                        if (!isEmpty(formData.get("name")) || !isEmpty(formData.get("id")) || !isEmpty(formData.get("content"))) {
                            if (confirm("新建博客将清空未保存编辑博客数据，是否继续新建？")) {
                                $("#art_id").val("");
                                $("#editor_from")[0].reset();
                                return;
                            }
                        }
                    })
                    $("#save_art").click(function () {
                        let formData = new FormData($("#editor_from")[0]);
                        let artName = formData.get("name");
                        let categoryId = formData.get("categoryId");
                        if (isEmpty(artName) || isEmpty(categoryId)) {
                            hint("博客标题和分类不能为空");
                            return;
                        }
                        $.ajax({
                            type: 'post',
                            url: "${baseurl}editor/save",
                            data: formData,
                            dataType: "json",
                            cache: false,
                            processData: false,
                            contentType: false,
                            async: false,
                            success: function (data) {
                                $("#art_id").val(data.artId);
                                hint("保存成功");
                            },
                            error: function (data) {
                                hint("保存失败");
                            }
                        });
                    });
                    $("#issue_art").click(function () {
                        let formData = new FormData($("#editor_from")[0]);
                        if (isEmpty(artName) || isEmpty(categoryId)) {
                            hint("博客标题和分类不能为空");
                            return;
                        }
                        $.ajax({
                            type: 'post',
                            url: "${baseurl}editor/issue",
                            data: formData,
                            dataType: "json",
                            cache: false,
                            processData: false,
                            contentType: false,
                            async: false,
                            success: function (data) {
                                $("#art_id").val(data.artId);
                                hint("发布成功");
                            },
                            error: function (data) {
                                hint("发布失败");
                            }
                        });
                    })
                </script>
            </div>
            <%--<div class='tab-pane' id='tab7'>
                我是选项卡七的内容
            </div>
            <div class='tab-pane' id='tab8'>
                我是选项卡八的内容
            </div>
            <div class='tab-pane' id='tab9'>
                我是选项卡九的内容
            </div>
            <div class='tab-pane' id='tab10'>
                我是选项卡十的内容
            </div>--%>
        </div>
    </div>

</div>

</body>

<!--bootstrap start-->
<script src="${baseurl}/v1/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${baseurl}/v1/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script src="${baseurl}/v1/js/blog.js"></script>
<!--bootstrap start-->

<script>
    $(function () {
        $("#label_id option[value='${articleInfo.labelId}'] ").attr("selected", true);
        $("#category_id option[value='${articleInfo.categoryId}'] ").attr("selected", true);
        if(${not empty tab}){
            $('#${tab}').tab('show');
        }
    });
</script>
<script>
    $(function () {
        var editor;
        if (${!empty articleInfo}) {
            $.get("${baseurl}Article/${articleInfo.path}", function (md) {
                editor = editormd("editor", {
                    width: "100%",
                    height: "480px",
                    markdown: md,     // dynamic set Markdown text
                    path: "${baseurl}editor.md/lib/",  // Autoload modules mode, codemirror, marked... dependents libs path
                    imageUpload: true, // Enable/disable upload
                    imageFormats: ["jpg", "jpeg", "gif", "png"],
                    imageUploadURL: "${baseurl}editor/upImg", // Upload url
                    toolbarIcons: function () {
                        return [
                            "undo", "redo", "|",
                            "bold", "del", "italic", "quote", "|",
                            "ucwords", "uppercase", "lowercase", "|",
                            "list-ul", "list-ol", "|",
                            "hr", "link", "reference-link", "image", "code",
                            "code-block", "table", "html-entities", "watch",
                            "preview", "search", "help"
                        ];
                    }
                })
            });
        } else {
            editor = editormd("editor", {
                width: "100%",
                height: "480px",
                // markdown: "xxxx",     // dynamic set Markdown text
                path: "${baseurl}editor.md/lib/",  // Autoload modules mode, codemirror, marked... dependents libs path

                imageUpload: true, // Enable/disable upload
                imageFormats: ["jpg", "jpeg", "gif", "png"],
                imageUploadURL: "${baseurl}editor/upImg", // Upload url
                toolbarIcons: function () {
                    return [
                        "undo", "redo", "|",
                        "bold", "del", "italic", "quote", "|",
                        "ucwords", "uppercase", "lowercase", "|",
                        "list-ul", "list-ol", "|",
                        "hr", "link", "reference-link", "image", "code",
                        "code-block", "table", "html-entities", "watch",
                        "preview", "search", "help"
                    ];
                }
            });

        }
    });
</script>
<!--分类-->
<script>
    $('#tree').treeview({
        data: ${userCategoryTree}
    });
</script>

<script>
    /*收藏按钮*/

    $(".collect_art").click(function () {
        var oThis = $(this);
        var artId = oThis.attr("blogId");
        $.ajax({
            type: 'post',
            url: "${baseurl}collect",
            data: {"artId": artId},
            dataType: "json",
            cache: false,
            success: function (data) {
                if (data.collFlag) {
                    ShowSuccess("收藏成功");
                } else {
                    ShowSuccess("取消收藏");
                    $("#" + artId + "").remove();//删除关注列表标签
                }

            },
            error: function () {
                hint("检查是否登录，或者跟换浏览器")
            }
        });
    })

    /*关注按钮*/
    $(".attention_but").click(function () {
        var oThis = $(this);
        var userId = oThis.attr("userId");
        $.ajax({
            type: 'post',
            url: "${baseurl}attention",
            data: {"userId": userId},
            dataType: "json",
            cache: false,
            success: function (data) {
                if (data.attFlag) {//修改按钮内容
                    ShowSuccess("关注成功");
                } else {
                    $("#" + userId + "").remove();//删除关注列表标签
                    oThis.html("<span class=\"glyphicon glyphicon-plus\"></span>关注")
                    ShowSuccess("取消关注");
                }
            },
            error: function () {
                hint("检查是否登录，或者跟换浏览器")
            }
        });
    });
</script>
</html>