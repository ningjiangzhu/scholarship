function waitTime(time) {
    if(time == 0){
        $("#getCaptchaCode").removeAttr("disabled");
        $("#getCaptchaCode").html("获取验证码");
    }else{
        $("#getCaptchaCode").attr("disabled",true);
        if(time < 10){
            $("#getCaptchaCode").html("0" + time + "秒后获取");
        }else{
            $("#getCaptchaCode").html(time + "秒后获取");
        }
        time--;
        setTimeout(function(){
            waitTime(time);
        },1000)
    }
}

function getCaptchaCode() {
    var phone_number = $("#phone_number").val();
    var reg = /^1[345789]\d{9}$/;
    if(!phone_number){
        $("#errorPhone_number").html("请输入手机号");
    }else{
        if(!reg.test(phone_number)){
            $("#errorPhone_number").html("手机号码错误");
        }else{
            $("#errorPhone_number").html("");
            $.ajax({
                type:"post",
                url:"/login/getCaptchaCode",
                data:{
                    phone_number:phone_number
                }
            });
            waitTime(60);
        }
    }
}

function setPhone_number() {
    var captchaCode = $("#captchaCode").val();
    if(!captchaCode){
        $("#errorCaptchaCode").html("请输入验证码");
    }else{
        $("#errorCaptchaCode").html("");
        $.ajax({
            type:"post",
            url:"/login/checkCaptchaCode",
            dataType:"text",
            data:{
                captchaCode:captchaCode
            },
            success:function (result) {
                if(result == ""){
                    $.ajax({
                        type:"post",
                        url:"/login/setPhone_number",
                        success:function () {
                            alert("绑定成功");
                            location.href="/login/stuPhone";
                        }
                    })
                }else{
                    $("#errorCaptchaCode").html(result);
                }
            }
        })
    }
}
