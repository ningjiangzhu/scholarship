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
                <li class="active"><a  href="/grade/admGradeView">成绩预览</a></li>
                <li><a  href="/grade/admGradeCheck">成绩审核</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> 管理员</a></li>
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<c:if test="${gradeCount.equals('0')}">
    <div class="container" style="margin-top:50px">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
                <img src="<%=request.getContextPath()%>/resources/img/none.png">
                <h3>暂无学生成绩</h3>
            </div>
        </div>
    </div>
</c:if>


<c:if test="${!gradeCount.equals('0')}">
<div class="container" style="margin-top:50px;margin-bottom: 50px">
    <div class="row">

        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="min-width: 1000px">
            <div class="well" style="background-color:white;">
                <table class="table table-striped" style="margin-bottom: 0;text-align: center">
                    <thead>
                    <tr>
                        <th style="text-align: center">学号</th>
                        <th style="text-align: center">姓名</th>
                        <th style="text-align: center">挂科数</th>
                        <th style="text-align: center">智育成绩</th>
                        <th style="text-align: center">德育成绩</th>
                        <th style="text-align: center">文体美成绩</th>
                        <th style="text-align: center">综合成绩</th>
                        <th style="text-align: center">智育排名</th>
                        <th style="text-align: center">综合排名</th>
                        <th style="text-align: center;padding-top: 0;padding-bottom: 0"><button type="button" class="btn btn-primary" onclick="gradeUpdate()">更新</button></th>
                    </tr>
                    </thead>
                    <tbody id="gradeList">
                    </tbody>
                </table>
                <div class="text-center">
                    <ul class="pagination" id="gradePage" style="margin:0"></ul>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

<div class="modal fade" id="updateGrade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">更新成绩</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <caption style="text-align: center">请在成绩审核完成后再更新！</caption>
                    <tbody>
                    <tr style="height:40px">
                        <th>设置智育成绩占比</th>
                        <td><label class="sr-only" for="intellect_percent"></label>
                            <select name="intellect_percent" id="intellect_percent" style="width: 100px">
                                <option value="0%">0%</option>
                                <option value="10%">10%</option>
                                <option value="20%">20%</option>
                                <option value="30%">30%</option>
                                <option value="40%">40%</option>
                                <option value="50%">50%</option>
                                <option value="60%">60%</option>
                                <option value="70%" selected="selected">70%</option>
                                <option value="80%">80%</option>
                                <option value="90%">90%</option>
                                <option value="100%">100%</option>
                            </select>
                        </td>
                    </tr>
                    <tr style="height:40px">
                        <th>设置德育成绩占比</th>
                        <td><label class="sr-only" for="moral_percent"></label>
                            <select name="moral_percent" id="moral_percent" style="width: 100px">
                                <option value="0%">0%</option>
                                <option value="10%">10%</option>
                                <option value="20%" selected="selected">20%</option>
                                <option value="30%">30%</option>
                                <option value="40%">40%</option>
                                <option value="50%">50%</option>
                                <option value="60%">60%</option>
                                <option value="70%">70%</option>
                                <option value="80%">80%</option>
                                <option value="90%">90%</option>
                                <option value="100%">100%</option>
                            </select>
                        </td>
                    </tr>
                    <tr style="height:40px">
                        <th>设置文体美成绩占比</th>
                        <td><label class="sr-only" for="art_percent"></label>
                            <select name="art_percent" id="art_percent" style="width: 100px">
                                <option value="0%">0%</option>
                                <option value="10%" selected="selected">10%</option>
                                <option value="20%">20%</option>
                                <option value="30%">30%</option>
                                <option value="40%">40%</option>
                                <option value="50%">50%</option>
                                <option value="60%">60%</option>
                                <option value="70%">70%</option>
                                <option value="80%">80%</option>
                                <option value="90%">90%</option>
                                <option value="100%">100%</option>
                            </select>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="updateGradeButton">更新</button>
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
<script src="<%=request.getContextPath()%>/resources/js/admGradeView.js"></script>
</html>
