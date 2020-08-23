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
                <li class="active"><a  href="/notice/noticeDetail?notice_id = ${notice.notice_id}">公告详情</a></li>
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
            <div class="well" style="background-color:white">
                <h3 class="text-center">${notice.notice_name}</h3>
                <h6 class="text-center" style="margin-bottom:50px">发布人：${notice.notice_people} | 发布时间：<fmt:formatDate value="${notice.notice_time}" pattern="yyyy-MM-dd HH:mm:ss"/></h6>
                <h5 style="white-space:pre-wrap;margin-bottom:50px">${notice.notice_content}</h5>
                <c:if test="${not empty fileNameList}">
                <h4>公告附件</h4>
                <c:forEach var="fileName" items="${fileNameList}" varStatus="v">
                    <h5><a title="${fileName}" href="/files/downloadFiles?file_id=${fileIdList[v.count - 1]}">${fileName}</a></h5>
                </c:forEach>
                </c:if>
            </div>

        </div>
        <div class="col-lg-1 col-md-1 col-sm-12 col-xs-12">
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
</html>
