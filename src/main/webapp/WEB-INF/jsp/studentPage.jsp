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
                <li class="active"><a href="/login/studentPage"><span class="glyphicon glyphicon-home"></span> 主页</a></li>
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


        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-8">
            <h4><a href="/student/stuStudent">个人信息</a></h4>
            <div class="well" style="background-color:white;">
                <table frame="void" style="width:260px">
                    <tr>
                        <td rowspan="3"> <img src="/files/showImg?file_id=${student.portrait}" class="img-rounded" width="100px" height="140px"></td>
                        <td rowspan="3" style="width:20px"></td>
                        <td style="border-bottom:solid 2px #f5f5f5">欢迎您，${student.student_name}</td>
                    </tr>
                    <tr>

                        <td style="border-bottom:solid 2px #f5f5f5">学号：${student.student_id}</td>
                    </tr>
                    <tr>

                        <td style="border-bottom:solid 2px #f5f5f5">部门：${student.department}</td>
                    </tr>

                </table>
            </div>
        </div>


        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-8">
            <h4>推荐服务</h4>
            <div class="well row" style="background-color:white;margin-left:0;margin-right:0">
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <a class="btn btn-default" style="border:0" role="button" href="/student/stuStudent">
                        <img src="<%=request.getContextPath()%>/resources/img/student.png" class="img-rounded" width="38px" height="38px">
                        <br>
                        个人信息
                    </a>
                </div>


                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <a class="btn btn-default" style="border:0;width:80px" role="button" href="/scholarship/stuScholarshipApply">
                        <img src="<%=request.getContextPath()%>/resources/img/scholarship.png" class="img-rounded" width="38px" height="38px">
                        <br>
                        奖学金
                    </a>
                </div>

                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <a class="btn btn-default" style="border:0" role="button" href="/grade/stuGrade">
                        <img src="<%=request.getContextPath()%>/resources/img/grade.png" class="img-rounded" width="38px" height="38px">
                        <br>
                        综合测评
                    </a>
                </div>

                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <a class="btn btn-default" style="border:0" role="button" href="">
                        <img src="<%=request.getContextPath()%>/resources/img/develop.png" class="img-rounded" width="38px" height="38px">
                        <br>
                        正在开发
                    </a>
                </div>

            </div>
        </div>

        <div class="col-lg-1 col-md-1 col-sm-12 col-xs-12">
        </div>
    </div>

    <div class="row">
        <div class="col-lg-1 col-md-12 col-sm-12 col-xs-12">
        </div>


        <div class="col-lg-5 col-md-6 col-sm-8 col-xs-8" style="min-width:485px">
            <h4>通知公告</h4>
            <div class="well" style="background-color:white;">
                <table class="table table-striped" style="margin-bottom: 0">
                    <thead>
                    <tr>
                        <th>公告标题</th>
                        <th>公告时间</th>
                    </tr>
                    </thead>
                    <tbody id="noticeList">
                    </tbody>

                </table>
                <div class="text-center">
                    <ul class="pagination" id="noticePage" style="margin: 0"></ul>
                </div>
            </div>
        </div>


        <div class="col-lg-5 col-md-6 col-sm-8 col-xs-8" style="min-width:485px">
            <div class="row">
                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10"><h4>问题反馈</h4></div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2"><h5 style="text-align:right"><span title="发表咨询" class="glyphicon glyphicon-plus" onclick="setQuestion()"></span></h5></div>
            </div>
            <div class="well" style="background-color:white;">
                <table class="table table-striped" style="margin-bottom: 0">
                    <thead>
                    <tr>
                        <th>咨询标题</th>
                        <th>咨询时间</th>
                        <th>状态</th>
                    </tr>
                    </thead>
                    <tbody id="questionList">
                    </tbody>
                </table>
                <div class="text-center">
                    <ul class="pagination" id="questionPage" style="margin:0"></ul>
                </div>
            </div>
        </div>

        <div class="col-lg-1 col-md-12 col-sm-12 col-xs-12">
        </div>
    </div>
</div>

<div class="modal fade" id="setQuestion" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">发表咨询</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <tbody>
                    <tr>
                        <th style="width: 100px">咨询标题</th>
                        <td style="width: 300px"><label class="sr-only" for="question_name">咨询标题</label>
                            <textarea name="question_name" id="question_name" cols="38" rows="1"></textarea></td>
                    </tr>
                    <tr>
                        <th style="width: 100px">资询内容</th>
                        <td style="width: 300px"><label class="sr-only" for="question_content">咨询内容</label>
                            <textarea name="question_content" id="question_content" cols="38" rows="5"></textarea></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="setQuestionButton">咨询</button>
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
<script src="<%=request.getContextPath()%>/resources/js/studentPage.js"></script>
</html>
