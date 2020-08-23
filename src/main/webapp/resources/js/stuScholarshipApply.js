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

function search() {
    var condition = $("#condition").val();
    $.ajax({
        url:"/scholarship/getScholarshipListByTimeLike",
        type:"post",
        dataType:"json",
        data:{
            condition:condition
        },
        success:function (result) {
            var scholarshipList = eval(JSON.stringify(result));
            if(scholarshipList.length == 0){
                $("#scholarshipShow").hide();
                $("#searchResult").show();
            }else{
                $("#searchResult").hide();
                $("#scholarshipShow").show();

                $("#scholarshipShow").html("");
                for(var i = 0; i < scholarshipList.length; i++){
                    $("#scholarshipShow").append("<div class=\"col-lg-3 col-md-4 col-sm-5 col-xs-7\">\n" +
                        "                <div class=\"well\" style=\"background-color:white;\">\n" +
                        "                    <table frame=\"void\">\n" +
                        "                        <thead>\n" +
                        "                        <tr style=\"height:50px\">\n" +
                        "                            <th><h4><label style=\"white-space:nowrap;width:80px;overflow:hidden;text-overflow:ellipsis\" title=\"${scholarship.scholarship_type}\">" + scholarshipList[i].scholarship_type + "</label></h4></th>\n" +
                        "                            <th><h4><label style=\"white-space:nowrap;width:142px;overflow:hidden;text-overflow:ellipsis\" title=\"${scholarship.scholarship_name}\">" + scholarshipList[i].scholarship_name + "</label></h4></th>\n" +
                        "                        </tr>\n" +
                        "                        </thead>\n" +
                        "                        <tbody>\n" +
                        "                        <tr style=\"height:30px\">\n" +
                        "                            <td>开始时间</td>\n" +
                        "                            <td>" + getDate(scholarshipList[i].start_time) + "</td>\n" +
                        "                        </tr>\n" +
                        "                        <tr style=\"height:30px\">\n" +
                        "                            <td>结束时间</td>\n" +
                        "                            <td>" + getDate(scholarshipList[i].start_time) + "</td>\n" +
                        "                        </tr>\n" +
                        "                        <tr style=\"height:30px\">\n" +
                        "                            <td>金额（元）</td>\n" +
                        "                            <td>" + scholarshipList[i].scholarship_money + "</td>\n" +
                        "                        </tr>\n" +
                        "                        <tr style=\"height:35px\">\n" +
                        "                            <td><button type=\"button\" class=\"btn btn-default\" onclick=\"showScholarship('" + scholarshipList[i].scholarship_id + "')\">详情</button></td>\n" +
                        "                            <td><button type=\"button\" class=\"btn btn-primary\" onclick=\"applyScholarship('" + scholarshipList[i].scholarship_id + "')\">申请</button></td>\n" +
                        "                        </tr>\n" +
                        "                        </tbody>\n" +
                        "                    </table>\n" +
                        "                </div>\n" +
                        "            </div>");
                }
            }

        },
        error:function () {
            alert("请重新搜索！");
        }
    });
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

function applyScholarship(scholarship_id) {
    $.ajax({
        type:"post",
        dataType:"text",
        url:"/apply/checkApply",
        data:{
            scholarship_id:scholarship_id
        },
        success:function (result) {
            if(result == ""){

                $("#apply_reason").val("");
                $("#apply_form").val("");
                $("#school_report").val("");
                $("#award_certificate").val("");


                $("#applyScholarshipButton").off("click");
                $("#applyScholarshipButton").click(function () {
                    var apply_reason = $("#apply_reason").val();
                    var applyForm = $("#apply_form")[0].files;
                    var schoolReport = $("#school_report")[0].files;
                    var awardCertificate = $("#award_certificate")[0].files;
                    if(applyForm.length != 0 && schoolReport.length != 0 && apply_reason) {
                        var apply_form = uploadFiles(applyForm,scholarship_id,"奖学金申请审批表");
                        var school_report = uploadFiles(schoolReport,scholarship_id,"成绩单");
                        var award_certificate = null;
                        if(awardCertificate.length != 0){
                            award_certificate = uploadFiles(awardCertificate,scholarship_id,"获奖证书原件及复印件")
                        }

                        if(apply_form != "fail" && school_report != "fail" && award_certificate != "fail"){
                            $.ajax({
                                url:"/apply/setApply",
                                type:"post",
                                data:{
                                    scholarship_id:scholarship_id,
                                    apply_reason:apply_reason,
                                    apply_form:apply_form,
                                    school_report:school_report,
                                    award_certificate:award_certificate
                                },
                                success:function () {
                                    alert("申请成功!");
                                },
                                error:function () {
                                    alert("请重新申请！");
                                }
                            });
                        }
                    }else {
                        alert("申请原因必须填写，申请审批表和成绩单必须上传！")
                    }

                });

                $("#applyScholarship").modal('show');


            }else{
                alert(result);
            }
        }
    });

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

            $("#showScholarshipButton").off("click");
            $("#showScholarshipButton").click(function () {
                $("#showScholarship").modal('hide');
                applyScholarship(scholarship_id);
            });

            $("#showScholarship").modal('show');
        }
    })
}