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

function showApply(apply_id) {
    $.ajax({
        type:"post",
        url:"/apply/getApply",
        dataType:"json",
        data:{
            apply_id:apply_id
        },
        success:function (result) {
            $("#apply_time").html(getDate(result.apply_time));
            $("#apply_state").html(result.apply_state);
            $("#check_time").html(getDate(result.check_time));
            $("#apply_reason").html(result.apply_reason);
            $("#fail_reason").html(result.fail_reason);

            var apply_form = result.apply_form;
            var school_report = result.school_report;
            var award_certificate = result.award_certificate;
            $("#apply_form").html("");
            $("#school_report").html("");
            $("#award_certificate").html("");


            if(apply_form && apply_form != ""){
                var fileNames = getFileNames(apply_form);
                var fileIds = apply_form.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#apply_form").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }

            if(school_report && school_report != ""){
                var fileNames = getFileNames(school_report);
                var fileIds = school_report.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#school_report").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }

            if(award_certificate && award_certificate != ""){
                var fileNames = getFileNames(award_certificate);
                var fileIds = award_certificate.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#award_certificate").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }

            $("#showApplyButton").off("click");
            $("#showApplyButton").click(function () {
                $("#showApply").modal('hide');
                deleteApply(apply_id);
            });


            $("#showApply").modal('show');
        }
    });
}


function deleteApply(apply_id) {
    $.ajax({
        type:"post",
        url:"/apply/getApply",
        dataType:"json",
        data:{
            apply_id:apply_id
        },
        success:function (result) {
            if(result.check_time && result.check_time != ""){
                alert("此申请已审核，不可取消！")
            }else{
                $.ajax({
                    type:"post",
                    url:"/apply/deleteApply",
                    data:{
                        apply_id:apply_id
                    },
                    success:function () {
                        $("#"+apply_id).remove();
                        alert("取消成功！");
                    }
                });
            }
        }
    });
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