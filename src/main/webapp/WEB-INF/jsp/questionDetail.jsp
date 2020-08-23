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
                <c:if test="${identity.equals('学生')}">
                    <li><a  href="/login/studentPage"><span class="glyphicon glyphicon-home"></span> 主页</a></li>
                </c:if>
                <c:if test="${identity.equals('管理员')}">
                    <li><a  href="/login/administratorPage"><span class="glyphicon glyphicon-home"></span> 主页</a></li>
                </c:if>
                <li class="active"><a href="/question/questionDetail?question_id="+${question.question_id}>问题详情</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <c:if test="${identity.equals('学生')}">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <span class="glyphicon glyphicon-user"></span> ${student_name}
                        </a>
                        <ul class="dropdown-menu" style="min-width:120px">
                            <li><a href="/student/stuStudent">个人信息</a></li>
                            <li class="divider"></li>
                            <li><a href="/login/stuPassword">修改密码</a></li>
                            <li class="divider"></li>
                            <li><a href="/login/stuPhone">绑定手机</a></li>
                        </ul>
                    </li>
                </c:if>
                <c:if test="${identity.equals('管理员')}">
                    <li><a href="#"> <span class="glyphicon glyphicon-user"></span> 管理员 </a></li>
                </c:if>
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" style="margin-top:50px;margin-bottom:50px">
    <div class="row">
        <div class="col-lg-1 col-md-1 col-sm-12 col-xs-12">
        </div>
        <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
            <div class="well" style="background-color: white">
                <h3 style="margin-bottom:50px">${question.question_name}</h3>
                <h6>咨询人：${question.question_people} | 咨询时间：<fmt:formatDate value="${question.question_time}" pattern="yyyy-MM-dd HH:mm:ss"/></h6>
                <h5 style="white-space:pre-wrap;margin-bottom:50px">${question.question_content}</h5>
                <hr>
                <c:if test="${question.question_state.equals('未解答') && identity.equals('管理员')}">
                    <button type="button" class="btn btn-primary" onclick="answerQuestion('${question.question_id}')">回答</button>
                </c:if>
                <c:if test="${question.question_state.equals('已解答')}">
                    <h6>回答人：${question.answer_people} | 回答时间：<fmt:formatDate value="${question.answer_time}" pattern="yyyy-MM-dd HH:mm:ss"/></h6>
                    <h5 style="white-space:pre-wrap;">${question.answer_content}</h5>
                </c:if>
            </div>

        </div>
        <div class="col-lg-1 col-md-1 col-sm-12 col-xs-12">
        </div>
    </div>

</div>

<div class="modal fade" id="answerContent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">回答内容</h4>
            </div>
            <div class="modal-body">
                <label class="sr-only" for="answer_content">回答内容</label>
                <textarea name="answer_content" id="answer_content" cols="70" rows="3"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="answerContentButton">提交</button>
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
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/jquery.easyui.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/plugins/jquery.datagrid.js"></script>
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/questionDetail.js"></script>
</html>
