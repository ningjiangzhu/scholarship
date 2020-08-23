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
                <li class="active"><a href="/login/stuPassword">修改密码</a></li>
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

        <div class="col-lg-6 col-md-6 col-sm-8 col-xs-10 well" style="background-color: white" id="checkPhone">
            <h4>验证手机号</h4>
            <table frame="void" style="margin:50px auto">
                <tbody>
                <tr style="height:60px">
                    <th style="padding:0 10px">手机号</th>
                    <td style="padding:0 10px">${phone_number}</td>
                    <td style="padding:0 10px"><button type="button" class="btn btn-default" onclick="getCaptchaCode()" id="getCaptchaCode" style="width: 96px">获取验证码</button></td>
                    <td style="padding:0 10px"><label id="errorPhone_number" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                </tr>
                <tr style="height:60px">
                    <th style="padding:0 10px">验证码</th>
                    <td style="padding:0 10px"><label class="sr-only" for="captchaCode">验证码</label>
                        <input type="text" class="form-control" id="captchaCode" name="captchaCode" placeholder="请输入验证码"></td>
                    <td style="padding:0 10px"><button type="button" class="btn btn-primary" onclick="checkCaptchaCode()">验证手机号</button></td>
                    <td style="padding:0 10px"><label id="errorCaptchaCode" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-8 col-xs-10 well" style="background-color: white;display: none" id="setPassword">
            <h4>设置新密码</h4>
            <h6>注意：密码长度8-16位；字符种类至少2种（数字、字母、标点符号）；不能包含中文和空格</h6>
            <table frame="void" style="margin:50px auto">
                <tbody>
                <tr style="height:60px">
                    <th style="padding:0 10px">新密码</th>
                    <td style="padding:0 10px"><label class="sr-only" for="password">新密码</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="请输入新密码"></td>
                    <td style="padding:0 10px"><label id="errorPassword" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>

                </tr>
                <tr style="height:60px">
                    <th style="padding:0 10px">确认密码</th>
                    <td style="padding:0 10px"><label class="sr-only" for="checkPassword">确认密码</label>
                        <input type="password" class="form-control" id="checkPassword" name="checkPassword" placeholder="请再次输入新密码"></td>
                    <td style="padding:0 10px"><label id="errorCheckPassword" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                </tr>
                <tr style="height:60px">
                    <th style="padding:0 10px">验证码</th>
                    <td style="padding:0 10px">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="max-width: 150px;">
                                <label class="sr-only" for="checkCode">验证码</label>
                                <input type="text" class="form-control" id="checkCode" name="checkCode" placeholder="请输入验证码">
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="max-width: 150px;">
                                <canvas  id="canvas" style="margin-right:0" width = "120" height = "34"></canvas>
                            </div>
                        </div>
                    </td>
                    <td style="padding:0 10px"><label id="errorCheckCode" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                </tr>
                <tr style="height:60px">
                    <td style="padding:0 10px"><button type="button" class="btn btn-primary" onclick="setPassword()">保存</button></td>
                </tr>
                </tbody>
            </table>
        </div>

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
<script src="<%=request.getContextPath()%>/resources/js/stuPassword.js"></script>
</html>
