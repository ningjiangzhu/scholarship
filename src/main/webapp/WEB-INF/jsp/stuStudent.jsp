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
                <li class="active"><a href="/student/stuStudent">个人信息</a></li>
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

<div class="container" style="margin-bottom: 50px;">
    <div class="row">
        <div class="col-lg-1 col-md-1 col-sm-12 col-xs-12">

        </div>
        <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3">
            <img id="studentPortrait" src="/files/showImg?file_id=${student.portrait}" class="img-rounded" width="100px" height="140px">
            <h6 style="padding-left:25px;text-decoration:none;cursor:pointer"><a onclick="$('#portrait').click()">上传头像</a></h6>
            <input type="file" name="portrait" id="portrait" accept="image/*" onchange="importPortrait()" style="display: none">
        </div>

        <div class="col-lg-6 col-md-6 col-sm-9 col-xs-9" id="studentShow">
            <div class="well" style="background-color:white">
                <button class="btn btn-primary" onclick="updateStudent('${student.birth}')">编辑</button>
                <table frame="void" style="margin:0 auto">
                    <tbody>
                    <tr style="height:35px">
                        <th style="width: 100px">学号</th>
                        <td>${student.student_id}</td>
                        <td style="padding:0 10px"><label style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                    </tr>
                    <tr style="height:35px">
                        <th>姓名</th>
                        <td>${student.student_name}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>性别</th>
                        <td>${student.sex}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>出生日期</th>
                        <td><fmt:formatDate value="${student.birth}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                    <tr style="height:35px">
                        <th>民族</th>
                        <td>${student.nationality}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>身份证号</th>
                        <td>${student.id_card}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>籍贯</th>
                        <td>${student.native_place}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>政治面貌</th>
                        <td>${student.politic_face}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>年级</th>
                        <td>${student.student_year}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>学院</th>
                        <td>${student.department}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>专业</th>
                        <td>${student.major}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>班级</th>
                        <td>${student.student_class}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>手机号</th>
                        <td>${student.phone_number}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-9 col-xs-9" id="studentUpdate" style="display: none">
            <div class="well" style="background-color:white">
                <button class="btn btn-primary" id="studentUpdateButton">提交</button>
                <button class="btn btn-default" id="studentUpdateClose">关闭</button>
                <table frame="void" style="margin:0 auto">
                    <tbody>
                    <tr style="height:35px">
                        <th style="width: 100px">学号</th>
                        <td>${student.student_id}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>姓名</th>
                        <td>${student.student_name}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>性别</th>
                        <td>${student.sex}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>出生日期</th>
                        <td><label class="sr-only" for="birth">出生日期</label>
                            <input class="easyui-datebox" type="text" id="birth" name="birth"></td>
                        <td style="padding:0 10px"><label id="errorBirth" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                    </tr>
                    <tr style="height:35px">
                        <th>民族</th>
                        <td>${student.nationality}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>身份证号</th>
                        <td><label class="sr-only" for="id_card">身份证号</label>
                            <input type="text" id="id_card" name="id_card" placeholder="请输入身份证号" value="${student.id_card}"></td>
                        <td style="padding:0 10px"><label id="errorId_card" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                    </tr>
                    <tr style="height:35px">
                        <th>籍贯</th>
                        <td><label class="sr-only" for="native_place">籍贯</label>
                            <input type="text" id="native_place" name="native_place" placeholder="请输入籍贯" value="${student.native_place}"></td>
                        <td style="padding:0 10px"><label id="errorNative_place" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                    </tr>
                    <tr style="height:35px">
                        <th>政治面貌</th>
                        <td><label class="sr-only" for="politic_face">政治面貌</label>
                            <input type="text" id="politic_face" name="politic_face" placeholder="请输入政治面貌" value="${student.politic_face}"></td>
                        <td style="padding:0 10px"><label id="errorPolitic_face" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                    </tr>
                    <tr style="height:35px">
                        <th>年级</th>
                        <td>${student.student_year}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>学院</th>
                        <td>${student.department}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>专业</th>
                        <td>${student.major}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>班级</th>
                        <td>${student.student_class}</td>
                    </tr>
                    <tr style="height:35px">
                        <th>手机号</th>
                        <td><label class="sr-only" for="phone_number">手机号</label>
                            <input type="text" id="phone_number" name="phone_number" placeholder="请输入手机号" value="${student.phone_number}"></td>
                        <td style="padding:0 10px"><label id="errorPhone_number" style="color:red;font-weight:lighter;min-width: 84px;"></label></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>


        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">

        </div>
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
<script src="<%=request.getContextPath()%>/resources/js/stuStudent.js"></script>
</html>
