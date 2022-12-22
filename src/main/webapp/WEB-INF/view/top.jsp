<%--
  Created by IntelliJ IDEA.
  User: zhouyp
  Date: 2020/5/11
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<c:set value="${sessionScope.userInfo}" var="userInfo"/>
<c:set value="${baseurl}images/header/${userInfo.headPath}" var="headerurl"/>
<c:set value="${baseurl}images/blogs/" var="blogurl"/>
<nav class="navbar navbar-inverse navbar-fixed-top" style="padding: 0.6rem 0">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" style="padding-right: 100px" href="${baseurl}index">BLOG</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class=""><a href="${baseurl}index">首页<span class="sr-only">(首页)</span></a></li>
                <li ><a href="${baseurl}classify">分类<span class="sr-only">(分类)</span></a></li>
            </ul>
            <form class="navbar-form navbar-left" action="${baseurl}search">
                <div class="input-group">
                    <input type="text" name="searchWord" class="form-control" aria-label="..." placeholder="搜索" value="${searchWord}">
                    <div class="input-group-btn">
                        <button type="submit" class="btn btn-primary">搜索</button>
                        <!-- Buttons -->
                    </div>
                </div>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <c:choose>
                    <c:when test="${sessionScope.userInfo!=null}">
                        <li class="dropdown logined">
                            <a href="#" class="dropdown-toggle" style="padding: 2px;"
                               data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <img src="${headerurl}" class="img-circle user-head-img">
                                我的
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="${baseurl}blogIndex/${userInfo.id}">个人主页</a></li>
                                <li><a href="${baseurl}personCenter">个人中心</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="${baseurl}logout">注销</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a href="${baseurl}v1/login.jsp">登录</a>
                        </li>
                        <li>
                            <a href="${baseurl}v1/login.jsp">注册</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<%--提示框开始--%>
<div class="modal fade bs-example-modal-sm" id="errorModel" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">提示</h4>
            </div>
            <div class="modal-body">
                <span id="errorModelMessage"></span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">确认</button>
            </div>
        </div>
    </div>
</div><%--提示框结束--%>
<script>
    function hint(msg) {
        $("#errorModelMessage").text(msg);
        $('#errorModel').modal('show');
    }
    function isEmpty(obj){
        if(typeof obj == "undefined" || obj == null || obj == ""){
            return true;
        }else{
            return false;
        }
    }
</script>

<script>
    // 在bootstrap中可以，可以使用如下方式实现弹出提示信息自动消失，如果没有使用bootstrap框架，可以自定义样式
    //tip是提示信息，type:'success'是成功信息，'danger'是失败信息,'info'是普通信息,'warning'是警告信息
    function ShowTip(tip, type) {
        var $tip = $('#tip');
        if ($tip.length == 0) {
            // 设置样式，也可以定义在css文件中
            $tip = $('<span id="tip" style="position:fixed;top:50px;left: 50%;z-index:9999;height: 35px;padding: 0 20px;line-height: 35px;"></span>');
            $('body').append($tip);
        }
        $tip.stop(true).prop('class', 'alert alert-' + type).text(tip).css('margin-left', -$tip.outerWidth() / 2).fadeIn(500).delay(2000).fadeOut(500);
    }

    function ShowMsg(msg) {
        ShowTip(msg, 'info');
    }

    function ShowSuccess(msg) {
        ShowTip(msg, 'success');
    }

    function ShowFailure(msg) {
        ShowTip(msg, 'danger');
    }

    function ShowWarn(msg, $focus, clear) {
        ShowTip(msg, 'warning');
        if ($focus) {
            $focus.focus();
            if (clear) $focus.val('');
        }
        return false;
    }
</script>
