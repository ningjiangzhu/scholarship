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
                <li class="active"><a href="/login/administratorPage"><span class="glyphicon glyphicon-home"></span> 主页</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> 管理员</a></li>
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" style="margin-bottom: 50px">
    <div class="row">
        <div class="col-lg-1 col-md-1 col-sm-12 col-xs-12">
        </div>


        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-8">
            <h4>个人信息</h4>
            <div class="well" style="background-color:white;">
                <table frame="void" style="width:260px">
                    <tr>
                        <td rowspan="3"> <img src="<%=request.getContextPath()%>/resources/img/man.png" class="img-rounded" width="100px" height="140px"></td>
                        <td rowspan="3" style="width:20px"></td>
                        <td style="border-bottom:solid 2px #f5f5f5">欢迎您，管理员</td>
                    </tr>
                    <tr>

                        <td style="border-bottom:solid 2px #f5f5f5">职工号：${login_id}</td>
                    </tr>
                    <tr>

                        <td style="border-bottom:solid 2px #f5f5f5">部门：管理员</td>
                    </tr>

                </table>
            </div>
        </div>


        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-8">
            <h4>推荐服务</h4>
            <div class="well row" style="background-color:white;margin-left:0;margin-right:0">
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <a class="btn btn-default" style="border:0" role="button" href="/student/admStudent">
                        <img src="<%=request.getContextPath()%>/resources/img/student.png" class="img-rounded" width="38px" height="38px">
                        <br>
                        学生信息
                    </a>
                </div>


                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <a class="btn btn-default" style="border:0;width:80px" role="button" href="/scholarship/admScholarshipPublic">
                        <img src="<%=request.getContextPath()%>/resources/img/scholarship.png" class="img-rounded" width="38px" height="38px">
                        <br>
                        奖学金
                    </a>
                </div>

                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <a class="btn btn-default" style="border:0" role="button" href="/grade/admGradeView">
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
            <div class="row">
                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10"><h4>通知公告</h4></div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2"><h5 style="text-align:right"><span title="发布公告" class="glyphicon glyphicon-plus" onclick="setNotice()"></span></h5></div>
            </div>
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
            <h4>问题反馈</h4>
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

<div class="modal fade" id="setNotice" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">发布公告</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:500px;margin:0 auto">
                    <tbody>
                    <tr style="height: 40px">
                        <th style="width: 100px">标题</th>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 500px"><label class="sr-only" for="notice_name">标题</label>
                            <textarea name="notice_name" id="notice_name" cols="66" rows="1"></textarea></td>
                    </tr>
                    <tr style="height: 40px">
                        <th style="width: 100px">正文</th>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 500px"><label class="sr-only" for="notice_content">正文</label>
                            <textarea name="notice_content" id="notice_content" style="width:500px;height:200px"></textarea></td>
                    </tr>
                    <tr style="height: 40px">
                        <th>附件</th>
                        <td><label class="sr-only" for="notice_file">附件</label>
                            <input type="file"  id="notice_file" name="notice_file"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="setNoticeButton">发布</button>
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
<script charset="utf-8" src="<%=request.getContextPath()%>/resources/kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="<%=request.getContextPath()%>/resources/kindeditor/lang/zh-CN.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/administratorPage.js"></script>
</html>

