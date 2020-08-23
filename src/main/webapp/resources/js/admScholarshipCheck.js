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

function showCheckApply(scholarship_id) {
    $.ajax({
        type:"post",
        dataType:"json",
        url:"/apply/getApplyListByState",
        data:{
            scholarship_id:scholarship_id,
            apply_state:"已通过"
        },
        success:function (result) {
            var applyList = result.applyList;
            var studentList = result.studentList;
            var gradeList = result.gradeList;
            $("#"+scholarship_id+"checkApplyList").html("");
            for(var i = 0; i < applyList.length; i++){
                $("#"+scholarship_id+"checkApplyList").append("<tr id=\"" + applyList[i].apply_id + "\">\n" +
                    "                                    <td>" + studentList[i].student_id + "</td>\n" +
                    "                                    <td>" + studentList[i].student_name + "</td>\n" +
                    "                                    <td>" + studentList[i].student_year + "</td>\n" +
                    "                                    <td>" + studentList[i].major + "</td>\n" +
                    "                                    <td>" + gradeList[i].fail_number + "</td>\n" +
                    "                                    <td>" + gradeList[i].intellect_ranking + "</td>\n" +
                    "                                    <td>" + gradeList[i].total_ranking + "</td>\n" +
                    "                                    <td>" + getDate(applyList[i].apply_time) + "</td>\n" +
                    "                                    <td style=\"padding-top: 0;padding-bottom: 0\"><button type=\"button\" class=\"btn btn-default\" onclick=\"viewFile('" + applyList[i].apply_id + "')\">查看</button></td>\n" +
                    "                                    <td>" + getDate(applyList[i].check_time) + "</td>\n" +
                    "                                    <td>已通过</td>\n" +
                    "                                </tr>");
            }


            $.ajax({
                type:"post",
                dataType:"json",
                url:"/apply/getApplyListByState",
                data:{
                    scholarship_id:scholarship_id,
                    apply_state:"未通过"
                },
                success:function (result) {
                    var applyList = result.applyList;
                    var studentList = result.studentList;
                    var gradeList = result.gradeList;
                    for(var i = 0; i < applyList.length; i++){
                        $("#"+scholarship_id+"checkApplyList").append("<tr id=\"" + applyList[i].apply_id + "\">\n" +
                            "                                    <td>" + studentList[i].student_id + "</td>\n" +
                            "                                    <td>" + studentList[i].student_name + "</td>\n" +
                            "                                    <td>" + studentList[i].student_year + "</td>\n" +
                            "                                    <td>" + studentList[i].major + "</td>\n" +
                            "                                    <td>" + gradeList[i].fail_number + "</td>\n" +
                            "                                    <td>" + gradeList[i].intellect_ranking + "</td>\n" +
                            "                                    <td>" + gradeList[i].total_ranking + "</td>\n" +
                            "                                    <td>" + getDate(applyList[i].apply_time) + "</td>\n" +
                            "                                    <td style=\"padding-top: 0;padding-bottom: 0\"><button type=\"button\" class=\"btn btn-default\" onclick=\"viewFile('" + applyList[i].apply_id + "')\">查看</button></td>\n" +
                            "                                    <td>" + getDate(applyList[i].check_time) + "</td>\n" +
                            "                                    <td>未通过</td>\n" +
                            "                                </tr>");
                    }
                }
            });

        }
    });



    $("#"+scholarship_id+"checkApply").collapse('toggle');
}

function getCheckApply(scholarship_id){

    $.ajax({
        type:"post",
        dataType:"json",
        url:"/apply/getApplyListByState",
        data:{
            scholarship_id:scholarship_id,
            apply_state:"未审核"
        },
        success:function (result) {
            var applyList = result.applyList;
            var studentList = result.studentList;
            var gradeList = result.gradeList;
            $("#"+scholarship_id+"applyList").html("");
            for(var i = 0; i < applyList.length; i++){
                $("#"+scholarship_id+"applyList").append("<tr id=\"" + applyList[i].apply_id + "\">\n" +
                    "                                    <td>" + studentList[i].student_id + "</td>\n" +
                    "                                    <td>" + studentList[i].student_name + "</td>\n" +
                    "                                    <td>" + studentList[i].student_year + "</td>\n" +
                    "                                    <td>" + studentList[i].major + "</td>\n" +
                    "                                    <td>" + gradeList[i].fail_number + "</td>\n" +
                    "                                    <td>" + gradeList[i].intellect_ranking + "</td>\n" +
                    "                                    <td>" + gradeList[i].total_ranking + "</td>\n" +
                    "                                    <td>" + getDate(applyList[i].apply_time) + "</td>\n" +
                    "                                    <td style=\"padding-top: 0;padding-bottom: 0\"><button type=\"button\" class=\"btn btn-default\" onclick=\"viewFile('" + applyList[i].apply_id + "')\">查看</button></td>\n" +
                    "                                    <td style=\"padding-top: 0;padding-bottom: 0\"><button type=\"button\" class=\"btn btn-primary\" onclick=\"yesCheck('" + applyList[i].apply_id + "')\">通过</button>\n" +
                    "                                        <button type=\"button\" class=\"btn btn-danger\" onclick=\"noCheck('" + applyList[i].apply_id + "')\">不通过</button></td>\n" +
                    "                                </tr>");
            }
        }
    });

    $("#"+scholarship_id).collapse('toggle');
}



function getFileNames(filesId) {
    var fileNames = null;
    $.ajax({
        type:"post",
        url:"/files/getFileNameList",
        dataType:"json",
        async:false,
        data:{
            filesId:filesId
        },
        success:function (result) {
            fileNames = eval(JSON.stringify(result));
        }
    });
    return fileNames;
}

function viewFile(apply_id) {
    $.ajax({
        type: "post",
        url: "/apply/getApply",
        dataType:"json",
        data: {
            apply_id: apply_id
        },
        success: function (result) {
            var apply_reason = result.apply_reason;
            var apply_form = result.apply_form;
            var school_report = result.school_report;
            var award_certificate = result.award_certificate;

            var apply_state = result.apply_state;
            if(apply_state != "未审核"){
                $("#showFailReason").show();
                $("#fail_reason1").html(result.fail_reason);
            }else{
                $("#showFailReason").hide();
            }

            $("#apply_reason").html(apply_reason);
            $("#apply_form").html("");
            $("#school_report").html("");
            $("#award_certificate").html("");

            if(apply_form && apply_form != ""){
                var fileNames = getFileNames(apply_form);
                var fileIds = apply_form.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#apply_form").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id=" + fileIds[i] + "'>" + fileNames[i] + "</a><br>")
                }
            }

            if(school_report && school_report != ""){
                var fileNames = getFileNames(school_report);
                var fileIds = school_report.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#school_report").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i] +"'>" + fileNames[i] + "</a><br>")
                }
            }

            if(award_certificate && award_certificate != ""){
                var fileNames = getFileNames(award_certificate);
                var fileIds = award_certificate.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#award_certificate").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }

            $("#viewFile").modal('show');
        }
    });

}

function yesCheck(apply_id) {
    $("#failReason").modal('show');
    $("#fail_reason").val("");

    $("#failReasonButton").off("click");
    $("#failReasonButton").click(function () {
        var fail_reason = $("#fail_reason").val();
        $.ajax({
            type:"post",
            url:"/apply/updateApply",
            async:false,
            data:{
                apply_id:apply_id,
                fail_reason:fail_reason,
                apply_state:"已通过"
            },
            success:function () {
                $("#"+apply_id).remove();
                alert("审核成功!");
            },
            error:function () {
                alert("请重新审核!");
            }
        })
    })
}

function noCheck(apply_id){
    $("#failReason").modal('show');
    $("#fail_reason").val("");

    $("#failReasonButton").off("click");
    $("#failReasonButton").click(function () {
        var fail_reason = $("#fail_reason").val();
        $.ajax({
            type:"post",
            url:"/apply/updateApply",
            data:{
                apply_id:apply_id,
                fail_reason:fail_reason,
                apply_state:"未通过"
            },
            success:function () {
                $("#"+apply_id).remove();
                alert("审核成功!")
            },
            error:function () {
                alert("请重新审核!");
            }
        })
    })
}

function showScholarship(scholarship_id) {
    $.ajax({
        type: "post",
        url: "/scholarship/getScholarship",
        dataType:"json",
        data: {
            scholarship_id: scholarship_id
        },
        success: function (result) {
            $("#scholarship_name").html(result.scholarship_name);
            $("#scholarship_name").attr("title",result.scholarship_name);
            $("#scholarship_type").html(result.scholarship_type);
            $("#scholarship_type").attr("title",result.scholarship_type);
            $("#scholarship_money").html(result.scholarship_money);
            $("#scholarship_quota").html(result.scholarship_quota);
            $("#scholarship_year").html(result.scholarship_year);
            $("#start_time").html(getDate(result.start_time));
            $("#end_time").html(getDate(result.end_time));
            $("#creation_unit").html(result.creation_unit);
            $("#creation_unit").attr("title",result.creation_unit);
            $("#funding_source").html(result.funding_source);
            $("#funding_source").attr("title",result.funding_source);
            $("#basic_requirement").html(result.basic_requirement);

            var scholarship_file = result.scholarship_file;
            $("#scholarship_file").html("");
            if(scholarship_file && scholarship_file != ""){
                var fileNames = getFileNames(scholarship_file);
                var fileIds = scholarship_file.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#scholarship_file").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }

            $("#showScholarship").modal('show');
        }
    })
}
