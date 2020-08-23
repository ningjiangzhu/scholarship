<%--
  Created by IntelliJ IDEA.
  User: Native_Chicken
  Date: 2020/5/5
  Time: 18:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>奖学金申报管理系统</title>
    <%@include file="common/head.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/themes/default/easyui.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/themes/icon.css"/>
</head>
<body style="background-color:#f5f5f5">

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="navbar-brand">奖学金申报管理系统</div>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="/login/studentPage"><span class="glyphicon glyphicon-home"></span> 主页</a></li>
                <li class="active"><a href="/login/stuPhone">绑定手机</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <span class="glyphicon glyphicon-user"></span> ${student.student_name}
                    </a>
                    <ul class="dropdown-menu" style="min-width:120px">
                        <li><a href="/student/stuStudent">个人信息</a></li>
                        <li class="divider"></li>
                        <li><a href="/login/stuPassword">修改密码</a></li>
                        <li class="divider"></li>
                        <li><a href="/login/stuPhone">绑定手机</a></li>
                    </ul>
                </li>
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" style="margin-top:100px;margin-bottom: 100px;">
    <div class="row">
        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2"></div>

        <c:if test="${phone_number == null || phone_number.equals('')}">
        <div class="col-lg-6 col-md-6 col-sm-8 col-xs-10 well" style="background-color: white" id="setPhone">
            <h4>绑定手机号</h4>
            <table frame="void" style="margin:50px auto">
                <tbody>
                <tr style="height:60px">
                    <th style="padding:0 10px">手机号</th>
                    <td style="padding:0 10px"><label class="sr-only" for="phone_number">手机号</label>
                        <input type="text" class="form-control" id="phone_number" name="phone_number" placeholder="请输入手机号码"></td>
                    <td style="padding:0 10px"><button type="button" class="btn btn-default" onclick="getCaptchaCode()" id="getCaptchaCode" style="width: 96px">获取验证码</button></td>
                    <td style="padding:0 10px"><label id="errorPhone_number" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                </tr>
                <tr style="height:60px">
                    <th style="padding:0 10px">验证码</th>
                    <td style="padding:0 10px"><label class="sr-only" for="captchaCode">验证码</label>
                        <input type="text" class="form-control" id="captchaCode" name="captchaCode" placeholder="请输入验证码"></td>
                    <td style="padding:0 10px"><button type="button" class="btn btn-primary" onclick="setPhone_number()">绑定手机号</button></td>
                    <td style="padding:0 10px"><label id="errorCaptchaCode" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                </tr>
                </tbody>
            </table>
        </div>
        </c:if>

        <c:if test="${phone_number != null && !phone_number.equals('')}">
        <div class="col-lg-6 col-md-6 col-sm-8 col-xs-10 well" style="background-color: white" id="showPhone">
            <h4>您已绑定手机号</h4>
            <table frame="void" style="margin:50px auto">
                <tbody>
                <tr style="height:60px">
                    <th style="padding:0 10px">手机号</th>
                    <td style="padding:0 10px">${phone_number}</td>
                    <td style="padding:0 10px"><a class="btn btn-primary" href="/login/changePhone">更换手机号</a></td>
                </tr>
                </tbody>
            </table>
        </div>
        </c:if>

        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2"></div>
    </div>
</div>


<nav class="navbar navbar-inverse navbar-fixed-bottom text-center">
    <div class="container-fluid">
        <div class="nav navbar-text" style="float:none">版权所有 违版必究</div>
    </div>
</nav>

</body>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/jquery.easyui.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/plugins/jquery.datagrid.js"></script>
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/stuPhone.js"></script>
</html>
