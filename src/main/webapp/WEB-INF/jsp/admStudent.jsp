<%--
  Created by IntelliJ IDEA.
  User: Native_Chicken
  Date: 2020/5/5
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="common/tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>奖学金申报管理系统</title>
    <%@include file="common/head.jsp"%>
</head>
<body style="background-color: #f5f5f5">

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
                <li><a href="/login/administratorPage"><span class="glyphicon glyphicon-home"></span> 主页</a></li>
                <li class="active"><a  href="/student/admStudent">学生信息</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> 管理员</a></li>
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" style="margin-top:50px;margin-bottom: 50px">
    <div class="row">

        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="min-width: 1000px">
            <div class="well" style="background-color:white;">
                <table class="table table-striped" style="margin-bottom: 0;text-align: center">
                    <thead>
                    <tr>
                        <th style="text-align: center">学号</th>
                        <th style="text-align: center">姓名</th>
                        <th style="text-align: center">性别</th>
                        <th style="text-align: center">民族</th>
                        <th style="text-align: center">年级</th>
                        <th style="text-align: center">学院</th>
                        <th style="text-align: center">专业</th>
                        <th style="text-align: center">班级</th>
                        <th style="text-align: center;padding-top: 0;padding-bottom: 0"><button type="button" class="btn btn-primary" onclick="$('#student_file').click()">导入</button>
                                        <input type="file" name="student_file" id="student_file" accept=".xls,.xlsx" onchange="importStudent()" style="display: none"></th>
                    </tr>
                    </thead>
                    <tbody id="studentList">
                    </tbody>
                </table>
                <div class="text-center">
                    <ul class="pagination" id="studentPage" style="margin:0"></ul>
                </div>
            </div>
        </div>


    </div>
</div>


<div class="modal fade" id="deleteStudent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">确定删除与此学生有关的所有信息？</h4>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="deleteStudentButton">删除</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
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
<script src="<%=request.getContextPath()%>/resources/bootstrap-paginator/bootstrap-paginator.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admStudent.js"></script>
</html>

