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
                <li><a  href="/login/studentPage"><span class="glyphicon glyphicon-home"></span> 主页</a></li>
                <li><a  href="/scholarship/stuScholarshipApply">奖学金申请</a></li>
                <li><a  href="/scholarship/stuScholarshipCheck">奖学金审核</a></li>
                <li class="active"><a  href="/scholarship/stuScholarshipNotice">奖学金公示</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
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
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<c:if test="${empty publicityList}">
    <div class="container" style="margin-top:50px">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
                <img src="<%=request.getContextPath()%>/resources/img/none.png">
                <h3>暂无奖学金公示</h3>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${not empty publicityList}">
<div class="container" style="margin-top:50px;margin-bottom: 50px">
    <div class="row">
        <c:forEach var="publicity" items="${publicityList}" varStatus="v">
            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-7">
                <div class="well" style="background-color:white;">
                    <table frame="void">
                        <thead>
                        <tr style="height:50px">
                            <th><h4 style="white-space:nowrap;width:80px;overflow:hidden;text-overflow:ellipsis" title="${scholarshipList[v.count-1].scholarship_type}">${scholarshipList[v.count-1].scholarship_type}</h4></th>
                            <th><h4 style="white-space:nowrap;width:142px;overflow:hidden;text-overflow:ellipsis;cursor: pointer" title="${scholarshipList[v.count-1].scholarship_name}" onclick="showScholarship('${scholarshipList[v.count-1].scholarship_id}')">${scholarshipList[v.count-1].scholarship_name}</h4></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr style="height:30px">
                            <td>开始时间</td>
                            <td><fmt:formatDate value="${publicity.start_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                        <tr style="height:30px">
                            <td>结束时间</td>
                            <td><fmt:formatDate value="${publicity.end_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                        <tr style="height:35px">
                            <td><button type="button" class="btn btn-primary" onclick="getPassApply('${scholarshipList[v.count-1].scholarship_id}')">公示名单</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:forEach>

        <c:forEach var="scholarship" items="${scholarshipList}">
            <div class="collapse col-sm-12 sol-md-12 col-lg-12 col-xs-12" id="${scholarship.scholarship_id}" style="min-width:1000px">
                <div class="panel panel-default">
                    <div class="panel-heading" style="background-color: black">
                        <h3 class="panel-title" style="color: #9d9d9d;">${scholarship.scholarship_name}公示名单</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped" style="text-align:center">
                            <thead>
                            <tr>
                                <th style="text-align: center">学号</th>
                                <th style="text-align: center">姓名</th>
                                <th style="text-align: center">年级</th>
                                <th style="text-align: center">专业</th>
                                <th style="text-align: center">班级</th>
                                <th style="text-align: center">挂科数</th>
                                <th style="text-align: center">智育成绩</th>
                                <th style="text-align: center">智育排名</th>
                                <th style="text-align: center">综合成绩</th>
                                <th style="text-align: center">综合排名</th>
                            </tr>
                            </thead>
                            <tbody id="${scholarship.scholarship_id}applyList">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</c:if>

<div class="modal fade" id="showScholarship" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">奖学金信息</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <tbody>
                    <tr style="height:35px">
                        <th style="width: 100px">奖学金名称</th>
                        <td style="width: 300px"><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" title="" id="scholarship_name"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>奖学金类型</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" title="" id="scholarship_type"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>金额（元）</th>
                        <td><h5 id="scholarship_money"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>名额（人）</th>
                        <td><h5 id="scholarship_quota"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>评定学期</th>
                        <td><h5 id="scholarship_year"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>开始时间</th>
                        <td><h5 id="start_time"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>结束时间</th>
                        <td><h5 id="end_time"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>设立单位</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" title="" id="creation_unit"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>资金来源</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" title="" id="funding_source"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>申请说明</th>
                        <td><h5 style="white-space:pre-wrap;width:300px;max-height: 100px;overflow: auto" id="basic_requirement"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>附件</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" id="scholarship_file"></h5></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
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
<script src="<%=request.getContextPath()%>/resources/js/stuScholarshipNotice.js"></script>
</html>
