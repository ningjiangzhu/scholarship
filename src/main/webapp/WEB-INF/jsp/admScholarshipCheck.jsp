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
                <li><a  href="/scholarship/admScholarshipPublic">奖学金发布</a></li>
                <li class="active"><a  href="/scholarship/admScholarshipCheck">奖学金审核</a></li>
                <li><a  href="/scholarship/admScholarshipNotice">奖学金公示</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> 管理员</a></li>
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>


<div class="container"style="margin-top:50px;margin-bottom:50px" >
    <div class="row" id="scholarshipShow">
        <c:forEach var="scholarship" items="${scholarshipList}">
            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-7">
                <div class="well" style="background-color:white;">
                    <table frame="void">
                        <thead>
                        <tr style="height:50px">
                            <th><h4 style="white-space:nowrap;width:85px;overflow:hidden;text-overflow:ellipsis" title="${scholarship.scholarship_type}">${scholarship.scholarship_type}</h4></th>
                            <th><h4 style="white-space:nowrap;width:139px;overflow:hidden;text-overflow:ellipsis;cursor: pointer" title="${scholarship.scholarship_name}" onclick="showScholarship('${scholarship.scholarship_id}')">${scholarship.scholarship_name}</h4></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr style="height:30px">
                            <td>开始时间</td>
                            <td><fmt:formatDate value="${scholarship.start_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                        <tr style="height:30px">
                            <td>结束时间</td>
                            <td><fmt:formatDate value="${scholarship.end_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        </tr>
                        <tr style="height:30px">
                            <td>金额（元）</td>
                            <td>${scholarship.scholarship_money}</td>
                        </tr>
                        <tr style="height:35px">
                            <td><button type="button" class="btn btn-default" onclick="showCheckApply('${scholarship.scholarship_id}')">审核记录</button></td>
                            <td><button type="button" class="btn btn-primary" onclick="getCheckApply('${scholarship.scholarship_id}')">审核名单</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:forEach>



        <c:forEach var="scholarship" items="${scholarshipList}">
            <div class="collapse col-sm-12 sol-md-12 col-lg-12 col-xs-12" id="${scholarship.scholarship_id}checkApply" style="min-width:1100px">
                <div class="panel panel-default">
                    <div class="panel-heading" style="background-color: black">
                        <h3 class="panel-title" style="color: #9d9d9d">${scholarship.scholarship_name}审核记录</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped" style="text-align:center">
                            <thead>
                            <tr>
                                <th style="text-align:center">学号</th>
                                <th style="text-align:center">姓名</th>
                                <th style="text-align:center">年级</th>
                                <th style="text-align:center">专业</th>
                                <th style="text-align:center">挂科数</th>
                                <th style="text-align:center">智育排名</th>
                                <th style="text-align:center">综合排名</th>
                                <th style="text-align:center">申请时间</th>
                                <th style="text-align:center">理由及附件</th>
                                <th style="text-align:center">审核时间</th>
                                <th style="text-align:center">审核状态</th>
                            </tr>
                            </thead>
                            <tbody id="${scholarship.scholarship_id}checkApplyList">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <div class="collapse col-sm-12 sol-md-12 col-lg-12 col-xs-12" id="${scholarship.scholarship_id}" style="min-width:1000px">
                <div class="panel panel-default">
                    <div class="panel-heading" style="background-color: black">
                        <h3 class="panel-title" style="color: #9d9d9d">${scholarship.scholarship_name}审核名单</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped" style="text-align:center">
                            <thead>
                            <tr>
                                <th style="text-align:center">学号</th>
                                <th style="text-align:center">姓名</th>
                                <th style="text-align:center">年级</th>
                                <th style="text-align:center">专业</th>
                                <th style="text-align:center">挂科数</th>
                                <th style="text-align:center">智育排名</th>
                                <th style="text-align:center">综合排名</th>
                                <th style="text-align:center">申请时间</th>
                                <th style="text-align:center">理由及附件</th>
                                <th style="text-align:center">审核</th>
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



<div class="modal fade" id="viewFile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">查看申请理由及附件</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <tbody>
                    <tr style="height:40px">
                        <th style="width: 100px">申请理由</th>
                        <td style="width: 300px"><h5 style="white-space:pre-wrap;width:300px;max-height: 100px;overflow: auto" id="apply_reason"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>申请审批表</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" id="apply_form"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>成绩单</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" id="school_report"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>荣誉证书</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" id="award_certificate"></h5></td>
                    </tr>
                    <tr style="height:40px;display: none;" id="showFailReason">
                        <th style="width: 100px">反馈信息</th>
                        <td style="width: 300px"><h5 style="white-space:pre-wrap;width:300px;max-height: 100px;overflow: auto" id="fail_reason1"></h5></td>
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

<div class="modal fade" id="failReason" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">反馈信息</h4>
            </div>
            <div class="modal-body">
                <label class="sr-only" for="fail_reason">反馈信息</label>
                <textarea name="fail_reason" id="fail_reason" cols="70" rows="3"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="failReasonButton">提交</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

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
<script src="<%=request.getContextPath()%>/resources/js/admScholarshipCheck.js"></script>
</html>
