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
                <li class="active"><a  href="/grade/stuGrade">综合测评</a></li>
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

<div class="container" style="margin-top:50px;margin-bottom: 50px">
    <div class="row">
        <div class="col-lg-8 col-md-9 col-sm-10 col-xs-12">
            <div class="well" style="background-color:white;text-align: center">
                <div style="display: flex;">
                    <div style="flex: 1"><hr></div>
                    <h4>我的综合测评数据</h4>
                    <div style="flex: 1"><hr></div>
                </div>
                <table frame="void" class="table">
                    <thead>
                    <tr style="height:60px">
                        <th style="text-align: center">智育成绩</th>
                        <th style="text-align: center">德育成绩</th>
                        <th style="text-align: center">文体美成绩</th>
                        <th style="text-align: center">综合成绩</th>
                        <th style="text-align: center">智育排名</th>
                        <th style="text-align: center">综合排名</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>${grade.intellect_score}</td>
                        <td>${grade.moral_score}</td>
                        <td>${grade.art_score}</td>
                        <td>${grade.total_score}</td>
                        <td>${grade.intellect_ranking}</td>
                        <td>${grade.total_ranking}</td>
                        <td  style="padding-top:0;padding-bottom:0"><button type="button" class="btn btn-primary" onclick="totalCheck('${grade.grade_id}')">综合测评</button></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<div class="modal fade" id="totalCheck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">综合测评</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <tbody>
                    <tr>
                        <th style="width: 100px">文件说明</th>
                        <td style="width: 300px"><label class="sr-only" for="grade_reason">文件说明</label>
                            <textarea name="grade_reason" id="grade_reason" cols="38" rows="3"></textarea></td>
                    </tr>
                    <tr style="height: 40px">
                        <th>智育加分项</th>
                        <td><label class="sr-only" for="intellect_file">智育加分项</label>
                            <input type="file"  id="intellect_file" name="intellect_file" multiple="multiple"></td>
                    </tr>
                    <tr style="height: 40px">
                        <th>德育加分项</th>
                        <td><label class="sr-only" for="moral_file">德育加分项</label>
                            <input type="file"  id="moral_file" name="moral_file" multiple="multiple"></td>
                    </tr>
                    <tr style="height: 40px">
                        <th>文体美加分项</th>
                        <td><label class="sr-only" for="art_file">文体美加分项</label>
                            <input type="file"  id="art_file" name="art_file" multiple="multiple"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="totalCheckButton">提交</button>
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
<script src="<%=request.getContextPath()%>/resources/js/stuGrade.js"></script>
</html>