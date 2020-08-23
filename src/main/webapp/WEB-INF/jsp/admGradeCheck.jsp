<%--
  Created by IntelliJ IDEA.
  User: Native_Chicken
  Date: 2020/5/1
  Time: 0:18
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
                <li><a  href="/login/administratorPage"><span class="glyphicon glyphicon-home"></span> 主页</a></li>
                <li><a  href="/grade/admGradeView">成绩预览</a></li>
                <li class="active"><a  href="/grade/admGradeCheck">成绩审核</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> 管理员</a></li>
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<c:if test="${checkGradeCount.equals('0')}">
    <div class="container" style="margin-top:50px">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
                <img src="<%=request.getContextPath()%>/resources/img/none.png">
                <h3>暂无成绩需要审核</h3>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${!checkGradeCount.equals('0')}">
<div class="container" style="margin-top:50px;margin-bottom:50px">
    <div class="row">

        <div class="col-lg-1 col-md-12 col-sm-12 col-xs-12"></div>

        <div class="col-lg-10 col-md-12 col-sm-12 col-xs-12" style="min-width: 800px">
            <div class="well" style="background-color:white;">
                <table class="table table-striped" style="margin-bottom: 0;text-align: center">
                    <thead>
                    <tr>
                        <th style="text-align: center">学号</th>
                        <th style="text-align: center">姓名</th>
                        <th style="text-align: center">智育成绩</th>
                        <th style="text-align: center">德育成绩</th>
                        <th style="text-align: center">文体美成绩</th>
                        <th style="text-align: center">附件</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    </thead>
                    <tbody id="checkGradeList">
                    </tbody>
                </table>
                <div class="text-center">
                    <ul class="pagination" id="checkGradePage" style="margin:0"></ul>
                </div>
            </div>
        </div>

        <div class="col-lg-1 col-md-12 col-sm-12 col-xs-12"></div>

    </div>
</div>
</c:if>

<div class="modal fade" id="viewFile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">查看附件</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <tbody>
                    <tr style="height:40px">
                        <th style="width: 100px">文件说明</th>
                        <td style="width: 300px"><h5 style="white-space:pre-wrap;width:300px;max-height: 100px;overflow: auto" id="grade_reason"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th style="width: 100px;">智育加分项</th>
                        <td style="width: 300px"><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" id="intellect_file"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>德育加分项</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" id="moral_file"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>文体美加分项</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" id="art_file"></h5></td>
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

<div class="modal fade" id="checkGrade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">设置成绩</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <tbody>
                    <tr style="height:40px">
                        <th>设置智育成绩</th>
                        <td><label class="sr-only" for="intellect_score">智育成绩</label>
                            <input type="text" id="intellect_score" name="intellect_score"></td>
                    </tr>
                    <tr style="height:40px">
                        <th>设置德育成绩</th>
                        <td><label class="sr-only" for="moral_score">德育成绩</label>
                            <input type="text" id="moral_score" name="moral_score"></td>
                    </tr>
                    <tr style="height:40px">
                        <th>设置文体美成绩</th>
                        <td><label class="sr-only" for="art_score">文体美成绩</label>
                            <input type="text" id="art_score" name="art_score"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="checkGradeButton">提交</button>
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
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/jquery.easyui.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/plugins/jquery.datagrid.js"></script>
<script src="<%=request.getContextPath()%>/resources/jquery-easyui-1.7.0/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admGradeCheck.js"></script>
</html>
