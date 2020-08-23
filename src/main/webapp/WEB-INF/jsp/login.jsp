<%--
  Created by IntelliJ IDEA.
  User: Native_Chicken
  Date: 2020/5/1
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>奖学金申报管理系统</title>
    <%@include file="common/head.jsp"%>
</head>
<body style="background-color:#f5f5f5">

<nav class="navbar navbar-inverse text-center" style="height:100px">
    <div class="container-fluid">
        <h3 class="navbar-brand" style="float:none;font-size:28px">奖学金申报管理系统</h3>
    </div>
</nav>


<div class="container" style="margin-top:50px;margin-bottom:50px">
    <div class="row">
        <div class="col-lg-1 col-md-12 col-sm-12 col-xs-12">
        </div>

        <div class="col-lg-6 col-md-7 col-sm-8 col-xs-9" style="margin-bottom:30px;min-width: 480px;">
            <div id="myCarousel" class="carousel slide">
                <!-- 轮播（Carousel）指标 -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                    <li data-target="#myCarousel" data-slide-to="3"></li>
                    <li data-target="#myCarousel" data-slide-to="4"></li>
                    <li data-target="#myCarousel" data-slide-to="5"></li>
                    <li data-target="#myCarousel" data-slide-to="6"></li>
                    <li data-target="#myCarousel" data-slide-to="7"></li>
                    <li data-target="#myCarousel" data-slide-to="8"></li>
                </ol>
                <!-- 轮播（Carousel）项目 -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="<%=request.getContextPath()%>/resources/img/长大1.jpg" alt="First slide">
                        <div class="carousel-caption">逸夫图书馆</div>
                    </div>
                    <div class="item">
                        <img src="<%=request.getContextPath()%>/resources/img/长大2.jpg" alt="Second slide">
                        <div class="carousel-caption">朝晖体育场</div>
                    </div>
                    <div class="item">
                        <img src="<%=request.getContextPath()%>/resources/img/长大3.jpg" alt="Third slide">
                        <div class="carousel-caption">明远湖</div>
                    </div>
                    <div class="item">
                        <img src="<%=request.getContextPath()%>/resources/img/长大4.jpg" alt="Fourth slide">
                        <div class="carousel-caption">大学生活动中心</div>
                    </div>
                    <div class="item">
                        <img src="<%=request.getContextPath()%>/resources/img/长大5.jpg" alt="Fifth slide">
                        <div class="carousel-caption">攀岩场</div>
                    </div>
                    <div class="item">
                        <img src="<%=request.getContextPath()%>/resources/img/长大6.jpg" alt="Sixth slide">
                        <div class="carousel-caption">实验楼</div>
                    </div>
                    <div class="item">
                        <img src="<%=request.getContextPath()%>/resources/img/长大7.jpg" alt="Seventh slide">
                        <div class="carousel-caption">树慧园</div>
                    </div>
                    <div class="item">
                        <img src="<%=request.getContextPath()%>/resources/img/长大8.jpg" alt="Eighth slide">
                        <div class="carousel-caption">校园一角</div>
                    </div>
                    <div class="item">
                        <img src="<%=request.getContextPath()%>/resources/img/长大9.jpg" alt="Ninth slide">
                        <div class="carousel-caption">教学楼</div>
                    </div>
                </div>
                <!-- 轮播（Carousel）导航 -->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>

        <div class="col-lg-4 col-md-5 col-sm-6 col-xs-6" style="min-width: 380px">
            <form class="well" role="form" method="post" style="background-color:white;">
                <div class="form-group">
                    <h3 class="text-center" style="margin-top: 10px">用户登录</h3>
                </div>
                <label id="errorLoginId" style="color:red;font-weight:lighter"></label>
                <div class="input-group input-group-lg form-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-user" ></i></span>
                    <input type="text" class="form-control"  placeholder="请输入学号/职工号" name="login_id" id="login_id"/>
                </div>
                <label id="errorPassword" style="color:red;font-weight:lighter"></label>
                <div class="input-group input-group-lg form-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                    <input type="password" class="form-control"  placeholder="请输入密码" name="password" id="password"/>
                </div>
                <div class="form-group row" style="margin-bottom:0">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <div class="checkbox" style="margin-top:5px;margin-bottom:5px">
                            <label style="font-size:12px;">
                                <input type="checkbox">记住密码
                            </label>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="text-align:right">
                        <h6><a href="/login/findPassword" style="text-decoration:none;cursor:pointer">忘记密码?</a></h6>
                    </div>
                </div>
                <label id="error" style="color:red;font-weight:lighter"></label>
                <div class="form-group">
                    <input type="button" class="btn btn-primary btn-block" value="登录" id="login"/>
                </div>


            </form>
        </div>
        <div class="col-lg-1 col-md-12 col-sm-12 col-xs-12">
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

<script src="<%=request.getContextPath()%>/resources/js/login.js"></script>
</html>
