var canvas = document.getElementById("canvas");//演员
var context = canvas.getContext("2d");//舞台，getContext() 方法可返回一个对象，该对象提供了用于在画布上绘图的方法和属性。
var num; //定义容器接收验证码
draw();
canvas.onclick = function () {
    context.clearRect(0, 0, 120, 34);//在给定的矩形内清除指定的像素
    draw();
}
// 随机颜色函数
function getColor() {
    var r = Math.floor(Math.random() * 256);
    var g = Math.floor(Math.random() * 256);
    var b = Math.floor(Math.random() * 256);
    return "rgb(" + r + "," + g + "," + b + ")";
}
function draw() {
    context.strokeRect(0, 0, 120, 34);//绘制矩形（无填充）
    var aCode = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    ];
    // 绘制字母
    var arr = [] //定义一个数组用来接收产生的随机数
    for (var i = 0; i < 4; i++) {
        var x = 20 + i * 20;//每个字母之间间隔20
        var y = 20 + 5 * Math.random();//y轴方向位置为20-30随机
        var index = Math.floor(Math.random() * aCode.length);//随机索引值
        var txt = aCode[index];
        context.font = "bold 20px 微软雅黑";//设置或返回文本内容的当前字体属性
        context.fillStyle=getColor();//设置或返回用于填充绘画的颜色、渐变或模式，随机
        context.translate(x,y);//重新映射画布上的 (0,0) 位置，字母不可以旋转移动，所以移动容器
        var deg=45*Math.random()*Math.PI/180;//0-45度随机旋转
        context.rotate(deg);// 	旋转当前绘图
        context.fillText(txt, 0, 0);//在画布上绘制“被填充的”文本
        context.rotate(-deg);//将画布旋转回初始状态
        context.translate(-x,-y);//将画布移动回初始状态
        arr[i] = txt //接收产生的随机数
    }
    num = arr[0] + arr[1] + arr[2] + arr[3] //将产生的验证码放入num
    // 绘制干扰线条
    for (var i = 0; i < 8; i++) {
        context.beginPath();//起始一条路径，或重置当前路径
        context.moveTo(Math.random() * 120, Math.random() * 34);//把路径移动到画布中的随机点，不创建线条
        context.lineTo(Math.random() * 120, Math.random() * 34);//添加一个新点，然后在画布中创建从该点到最后指定点的线条
        context.strokeStyle=getColor();//随机线条颜色
        context.stroke();// 	绘制已定义的路径
    }
    // 绘制干扰点，和上述步骤一样，此处用长度为1的线代替点
    for (var i = 0; i < 20; i++) {
        context.beginPath();
        var x = Math.random() * 120;
        var y = Math.random() * 34;
        context.moveTo(x, y);
        context.lineTo(x + 1, y + 1);
        context.strokeStyle=getColor();
        context.stroke();
    }
}

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

    $.ajax({
        type:"post",
        url:"/login/getPhone_number",
        dataType:"text",
        success:function (result) {
            $.ajax({
                type:"post",
                url:"/login/getCaptchaCode",
                data:{
                    phone_number:result
                }
            });
        }
    });
    waitTime(60);

}

function checkCaptchaCode() {
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
                    $("#checkPhone").hide();
                    $("#setPassword").show();
                }else{
                    $("#errorCaptchaCode").html(result);
                }
            }
        })
    }
}

function checkPassword() {
    var password = $("#password").val();
    var reg = /(?!.*\s)(?!^[\u4e00-\u9fa5]+$)(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{8,16}$/;
    if(!password){
        $("#errorPassword").html("请填写新密码");
        return false;
    }else if(!reg.test(password)) {
        $("#errorPassword").html("密码格式错误");
        return false;
    }else{
        $("#errorPassword").html("");
        return true;
    }
}

function checkCheckPassword() {
    var password = $("#password").val();
    var checkPassword = $("#checkPassword").val();
    if(!checkPassword){
        $("#errorCheckPassword").html("请填确认密码");
        return false;
    }else if(password != checkPassword) {
        $("#errorCheckPassword").html("与新密码不同");
        return false;
    }else{
        $("#errorCheckPassword").html("");
        return true;
    }
}

function checkCheckCode() {
    var checkCode = $("#checkCode").val();
    if(!checkCode){
        $("#errorCheckCode").html("请填写验证码");
        return false;
    }else if(num != checkCode) {
        $("#errorCheckCode").html("验证码错误");
        return false;
    }else{
        $("#errorCheckCode").html("");
        return true;
    }
}

function setPassword() {
    if(checkPassword() && checkCheckPassword() && checkCheckCode()){
        var password = $("#password").val();
        $.ajax({
            type:"post",
            url:"/login/setPassword",
            data:{
                password:password
            },
            success:function () {
                alert("修改成功");
                location.href="/login/stuPassword";
            }
        })
    }
}