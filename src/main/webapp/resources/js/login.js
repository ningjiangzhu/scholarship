$(document).ready(function () {
    $('.carousel').carousel();
    checkForm();
});

function checkForm() {
    $("#login").click(function () {
        var login_id = $("#login_id").val();
        var password = $("#password").val();

        if(!login_id){
            $("#errorLoginId").html("请输入学号/职工号");
            if(!password){
                $("#errorPassword").html("请输入密码");
            }else{
                $("#errorPassword").html("");
            }
        }else {
            $("#errorLoginId").html("");
            if(!password){
                $("#errorPassword").html("请输入密码");
            }else{
                $("#errorPassword").html("");
                checkLogin()
            }
        }
    })
}

function checkLogin() {
    var login_id = $("#login_id").val();
    var password = $("#password").val();

    $.ajax({
        type:"post",
        dataType:"text",
        url:"/login/checkLogin",
        data:{
            login_id:login_id,
            password:password
        },
        success:function (result) {
            if(result == "fail"){
                $("#error").html("用户名或者密码错误");
            }else if(result == "successStudent"){
                $("form").attr("action", "/login/studentPage");
                $("form").submit();
            }else{
                $("form").attr("action", "/login/administratorPage");
                $("form").submit();
            }
        },
        error:function () {
            $("#error").html("请重新输入用户名和密码");
        }
    });
}
