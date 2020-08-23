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
                <li class="active"><a  href="/scholarship/admScholarshipPublic">奖学金发布</a></li>
                <li><a  href="/scholarship/admScholarshipCheck">奖学金审核</a></li>
                <li><a  href="/scholarship/admScholarshipNotice">奖学金公示</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> 管理员</a></li>
                <li><a href="/login/logout"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
            </ul>
        </div>
    </div>
</nav>


<div class="container" style="margin-top:20px;margin-bottom:50px">
    <div class="row">
        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
            <input type="text" class="form-control" placeholder="请输入奖学金类型/奖学金名称" id="condition">
        </div>
        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
            <button type="button" class="btn btn-primary" onclick="search()">搜索</button>
        </div>
    </div>

    <div class="row" style="margin-top:50px;display: none;" id="searchResult">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
            <img src="<%=request.getContextPath()%>/resources/img/none.png">
            <h3>暂无搜索结果</h3>
        </div>
    </div>


    <div class="row" style="margin-top:50px;" id="scholarshipShow">
        <c:forEach var="scholarship" items="${scholarshipList}">
            <div class="col-lg-3 col-md-4 col-sm-5 col-xs-7" id="${scholarship.scholarship_id}">
                <div class="well" style="background-color:white;">
                    <table frame="void">
                        <thead>
                        <tr style="height:50px">
                            <th><h4 style="white-space:nowrap;width:80px;overflow:hidden;text-overflow:ellipsis" title="${scholarship.scholarship_type}">${scholarship.scholarship_type}</h4></th>
                            <th><h4 style="white-space:nowrap;width:142px;overflow:hidden;text-overflow:ellipsis" title="${scholarship.scholarship_name}">${scholarship.scholarship_name}</h4></th>
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
                            <td><button type="button" class="btn btn-default" onclick="showScholarship('${scholarship.scholarship_id}')">详情</button></td>
                            <td><button type="button" class="btn btn-primary" onclick="updateScholarship('${scholarship.scholarship_id}')">修改</button>
                                <button type="button" class="btn btn-danger" onclick="deleteScholarship('${scholarship.scholarship_id}')">删除</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:forEach>
        <div class="col-lg-3 col-md-4 col-sm-5 col-xs-7" style="font-size: 124px;color: #f5f5f5;text-align: center;" id="addScholarship">
            <div class="well" style="background-color:white;" onclick="setScholarship()">
                <span class="glyphicon glyphicon-plus-sign"></span>
            </div>
        </div>

    </div>
</div>

<div class="modal fade" id="setScholarship" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">添加奖学金</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <tbody>
                    <tr style="height:35px">
                        <th style="width: 100px">奖学金名称</th>
                        <td style="width: 300px"><label class="sr-only" for="scholarship_name">奖学金名称</label>
                            <input type="text" id="scholarship_name" name="scholarship_name" placeholder="请输入名称"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>奖学金类型</th>
                        <td><label class="sr-only" for="scholarship_type">奖学金类型</label>
                            <input type="text" id="scholarship_type" name="scholarship_type" placeholder="请输入类型"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>金额（元）</th>
                        <td><label class="sr-only" for="scholarship_money">金额(元)</label>
                            <input type="text" id="scholarship_money" name="scholarship_money" placeholder="请输入金额"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>名额（人）</th>
                        <td><label class="sr-only" for="scholarship_quota">名额（人）</label>
                            <input type="text" id="scholarship_quota" name="scholarship_quota" placeholder="请输入名额"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>评定学期</th>
                        <td><label class="sr-only" for="scholarship_year">评定学期</label>
                            <input type="text" id="scholarship_year" name="scholarship_year" placeholder="请输入学期"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>开始时间</th>
                        <td><label class="sr-only" for="start_time">开始时间</label>
                            <input class="easyui-datetimebox" type="text" id="start_time" name="start_time"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>结束时间</th>
                        <td><label class="sr-only" for="end_time">结束时间</label>
                            <input class="easyui-datetimebox" type="text" id="end_time" name="end_time"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>设立单位</th>
                        <td><label class="sr-only" for="creation_unit">设立单位</label>
                            <input type="text" id="creation_unit" name="creation_unit" placeholder="请输入设立单位"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>资金来源</th>
                        <td><label class="sr-only" for="funding_source">资金来源</label>
                            <input type="text" id="funding_source" name="funding_source" placeholder="请输入资金来源"></td>
                    </tr>
                    <tr>
                        <th>申请说明</th>
                        <td><label class="sr-only" for="basic_requirement">申请说明</label>
                            <textarea name="basic_requirement" id="basic_requirement" cols="38" rows="3"></textarea></td>
                    </tr>
                    <tr>
                        <th>上传附件</th>
                        <td><label class="sr-only" for="scholarship_file">上传附件</label>
                            <input type="file"  id="scholarship_file" name="scholarship_file" multiple="multiple"></td>
                    </tr>
                    </tbody>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="setScholarshipButton">提交</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<div class="modal fade" id="updateScholarship" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">修改奖学金</h4>
            </div>
            <div class="modal-body">
                <table frame="void" style="width:400px;margin:0 auto">
                    <tbody>
                    <tr style="height:35px">
                        <th style="width: 100px">奖学金名称</th>
                        <td style="width: 300px"><label class="sr-only" for="scholarship_name1">奖学金名称</label>
                            <input type="text" id="scholarship_name1" name="scholarship_name1" placeholder="请输入名称"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>奖学金类型</th>
                        <td><label class="sr-only" for="scholarship_type1">奖学金类型</label>
                            <input type="text" id="scholarship_type1" name="scholarship_type1" placeholder="请输入类型"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>金额（元）</th>
                        <td><label class="sr-only" for="scholarship_money1">金额(元)</label>
                            <input type="text" id="scholarship_money1" name="scholarship_money1" placeholder="请输入金额"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>名额（人）</th>
                        <td><label class="sr-only" for="scholarship_quota1">名额（人）</label>
                            <input type="text" id="scholarship_quota1" name="scholarship_quota1" placeholder="请输入名额"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>评定学期</th>
                        <td><label class="sr-only" for="scholarship_year1">评定学期</label>
                            <input type="text" id="scholarship_year1" name="scholarship_year1" placeholder="请输入学期"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>开始时间</th>
                        <td><label class="sr-only" for="start_time1">开始时间</label>
                            <input class="easyui-datetimebox" type="text" id="start_time1" name="start_time1"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>结束时间</th>
                        <td><label class="sr-only" for="end_time1">结束时间</label>
                            <input class="easyui-datetimebox" type="text" id="end_time1" name="end_time1"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>设立单位</th>
                        <td><label class="sr-only" for="creation_unit1">设立单位</label>
                            <input type="text" id="creation_unit1" name="creation_unit1" placeholder="请输入设立单位"></td>
                    </tr>
                    <tr style="height:35px">
                        <th>资金来源</th>
                        <td><label class="sr-only" for="funding_source1">资金来源</label>
                            <input type="text" id="funding_source1" name="funding_source1" placeholder="请输入资金来源"></td>
                    </tr>
                    <tr>
                        <th>申请说明</th>
                        <td><label class="sr-only" for="basic_requirement1">申请说明</label>
                            <textarea name="basic_requirement1" id="basic_requirement1" cols="38" rows="3"></textarea></td>
                    </tr>
                    <tr>
                        <th>上传附件</th>
                        <td><label class="sr-only" for="scholarship_file1">上传附件</label>
                            <input type="file"  id="scholarship_file1" name="scholarship_file1" multiple="multiple"></td>
                    </tr>
                    </tbody>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="updateScholarshipButton">提交</button>
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
                        <td style="width: 300px"><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" title="" id="scholarship_name2"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>奖学金类型</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" title="" id="scholarship_type2"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>金额（元）</th>
                        <td><h5 id="scholarship_money2"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>名额（人）</th>
                        <td><h5 id="scholarship_quota2"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>评定学期</th>
                        <td><h5 id="scholarship_year2"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>开始时间</th>
                        <td><h5 id="start_time2"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>结束时间</th>
                        <td><h5 id="end_time2"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>设立单位</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" title="" id="creation_unit2"></h5></td>
                    </tr>
                    <tr style="height:35px">
                        <th>资金来源</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" title="" id="funding_source2"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>申请说明</th>
                        <td><h5 style="white-space:pre-wrap;width:300px;max-height: 100px;overflow: auto" id="basic_requirement2"></h5></td>
                    </tr>
                    <tr style="height:40px">
                        <th>附件</th>
                        <td><h5 style="white-space:nowrap;width:300px;overflow:hidden;text-overflow:ellipsis" id="scholarship_file2"></h5></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="showScholarshipButton">修改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<div class="modal fade" id="deleteScholarship" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">确定删除与此奖学金有关的所有信息？</h4>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="deleteScholarshipButton">删除</button>
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
<script src="<%=request.getContextPath()%>/resources/js/admScholarshipPublic.js"></script>
</html>
