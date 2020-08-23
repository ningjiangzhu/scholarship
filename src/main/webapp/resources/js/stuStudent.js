function getDate(time){
    var date = new Date(time);
    var year = date.getFullYear();
    var month = date.getMonth()+1;
    var day = date.getDate();
    var hour = date.getHours();
    var minute = date.getMinutes();
    var second = date.getSeconds();

    if(month > 0 && month < 10){
        month = "0" + month;
    }
    if(day > 0 && day < 10){
        day = "0" + day;
    }
    if(hour > 0 && hour < 10){
        hour = "0" + hour;
    }
    if(minute > 0 && minute < 10){
        minute = "0" + minute;
    }
    if(second > 0 && second < 10){
        second = "0" + second;
    }
    return year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
}

function uploadFiles(filesList,uploadType,fileType) {
    var formData = new FormData();
    var uploadResult = null;
    for(var i = 0; i < filesList.length; i++){
        formData.append("filesList",filesList[i]);
    }
    formData.append("uploadType",uploadType);
    formData.append("fileType",fileType);
    $.ajax({
        url:"/files/uploadFiles",
        type:"post",
        dataType:"text",
        async:false,
        contentType:false,
        processData:false,
        data:formData,
        mimeType:"multipart/form-data",
        success:function (result) {
            uploadResult = result;
        },
        error:function () {
            alert("文件上传失败！");
            uploadResult = "fail";
        }
    });
    return uploadResult;
}

function importPortrait() {
    var studentPortrait = $("#portrait")[0].files;
    var portrait = null;
    if(studentPortrait.length != 0){
        portrait = uploadFiles(studentPortrait,"学生信息","学生头像")
    }

    if(portrait != "fail" && portrait != null){
        $.ajax({
            type:"post",
            url:"/student/updatePortrait",
            data:{
                portrait:portrait
            },
            success:function () {
                alert("上传成功");
                $("#studentPortrait").attr("src","/files/showImg?file_id="+portrait);
            },
            error:function () {
                alert("请重新上传");
            }
        })
    }
}

function checkId_card(id_card) {
    var reg = /(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    if(!reg.test(id_card)){
        $("#errorId_card").html("身份证号错误");
        return false;
    }else{
        $("#errorId_card").html("");
        return true;
    }
}

function checkPhone_number(phone_number) {
    var reg = /^1[345789]\d{9}$/;
    if(!reg.test(phone_number)){
        $("#errorPhone_number").html("手机号码错误");
        return false;
    }else{
        $("#errorPhone_number").html("");
        return true;
    }
}

function updateStudent(studentBirth) {
    if(studentBirth != null && studentBirth != ""){
        $("#birth").datebox("setValue",getDate(studentBirth));
    }

    $("#studentShow").hide();
    $("#studentUpdate").show();


    $("#studentUpdateClose").click(function () {
        $("#studentUpdate").hide();
        $("#studentShow").show();
    });

    $("#studentUpdateButton").off("click");
    $("#studentUpdateButton").click(function () {
        var birth = $("#birth").datebox("getValue");
        var id_card = $("#id_card").val();
        var native_place = $("#native_place").val();
        var politic_face = $("#politic_face").val();
        var phone_number = $("#phone_number").val();

        if(birth && id_card && native_place && politic_face && phone_number){
            if(checkId_card(id_card) && checkPhone_number(phone_number)){
                $.ajax({
                    url:"/student/updateStudent",
                    type:"post",
                    data:{
                        birth:birth,
                        id_card:id_card,
                        native_place:native_place,
                        politic_face:politic_face,
                        phone_number:phone_number
                    },
                    success:function () {
                        alert("修改成功");
                        location.href="/student/stuStudent";
                    },
                    error:function () {
                        alert("修改失败");
                    }
                })
            }

        }else{
            alert("信息不能为空");
        }
    });
}