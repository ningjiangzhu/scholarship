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
        url:"/scholarship/getScholarshipListByLike",
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

                $("#addScholarship").prevAll().remove();
                for(var i = 0; i < scholarshipList.length; i++){
                    $("#addScholarship").before("<div class=\"col-lg-3 col-md-4 col-sm-5 col-xs-7\" id=\"" + scholarshipList[i].scholarship_id + "\">\n" +
                        "                <div class=\"well\" style=\"background-color:white;\">\n" +
                        "                    <table frame=\"void\">\n" +
                        "                        <thead>\n" +
                        "                        <tr style=\"height:50px\">\n" +
                        "                            <th><h4 style=\"white-space:nowrap;width:80px;overflow:hidden;text-overflow:ellipsis\" title=\"" + scholarshipList[i].scholarship_type + "\">" + scholarshipList[i].scholarship_type + "</h4></th>\n" +
                        "                            <th><h4 style=\"white-space:nowrap;width:142px;overflow:hidden;text-overflow:ellipsis\" title=\"" + scholarshipList[i].scholarship_name + "\">" + scholarshipList[i].scholarship_name + "</h4></th>\n" +
                        "                        </tr>\n" +
                        "                        </thead>\n" +
                        "                        <tbody>\n" +
                        "                        <tr style=\"height:30px\">\n" +
                        "                            <td>开始时间</td>\n" +
                        "                            <td>" + getDate(scholarshipList[i].start_time) + "</td>\n" +
                        "                        </tr>\n" +
                        "                        <tr style=\"height:30px\">\n" +
                        "                            <td>结束时间</td>\n" +
                        "                            <td>" + getDate(scholarshipList[i].end_time) + "</td>\n" +
                        "                        </tr>\n" +
                        "                        <tr style=\"height:30px\">\n" +
                        "                            <td>金额（元）</td>\n" +
                        "                            <td>" + scholarshipList[i].scholarship_money + "</td>\n" +
                        "                        </tr>\n" +
                        "                        <tr style=\"height:35px\">\n" +
                        "                            <td><button type=\"button\" class=\"btn btn-default\" onclick=\"showScholarship('" + scholarshipList[i].scholarship_id + "')\">详情</button></td>\n" +
                        "                            <td><button type=\"button\" class=\"btn btn-primary\" onclick=\"updateScholarship('" + scholarshipList[i].scholarship_id + "')\">修改</button>\n" +
                        "                                <button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteScholarship('" + scholarshipList[i].scholarship_id + "')\">删除</button></td>\n" +
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

function setScholarship(){
    $("#scholarship_name").val("");
    $("#scholarship_type").val("");
    $("#scholarship_money").val("");
    $("#scholarship_quota").val("");
    $("#scholarship_year").val("");
    $("#start_time").datetimebox("setValue","");
    $("#end_time").datetimebox("setValue","");
    $("#creation_unit").val("");
    $("#funding_source").val("");
    $("#basic_requirement").val("");
    $("#scholarship_file").val("");

    $("#setScholarshipButton").off("click");
    $("#setScholarshipButton").click(function () {
        var scholarship_name = $("#scholarship_name").val();
        var scholarship_type = $("#scholarship_type").val();
        var scholarship_money = $("#scholarship_money").val();
        var scholarship_quota = $("#scholarship_quota").val();
        var scholarship_year = $("#scholarship_year").val();
        var start_time = $("#start_time").datetimebox("getValue");
        var end_time = $("#end_time").datetimebox("getValue");
        var creation_unit = $("#creation_unit").val();
        var funding_source = $("#funding_source").val();
        var basic_requirement = $("#basic_requirement").val();
        var scholarshipFile = $("#scholarship_file")[0].files;
        if(scholarship_name && scholarship_type && scholarship_money && scholarship_quota && scholarship_year && start_time && end_time && creation_unit && funding_source){
            if(start_time > end_time){
                alert("结束时间不能小于开始时间！");
            }else{
                var scholarship_file = null;
                if(scholarshipFile.length != 0){
                    scholarship_file = uploadFiles(scholarshipFile,"奖学金","奖学金附件")
                }

                if(scholarship_file != "fail"){
                    $.ajax({
                        type:"post",
                        url:"/scholarship/setScholarship",
                        dataType:"json",
                        data:{
                            scholarship_name:scholarship_name,
                            scholarship_type:scholarship_type,
                            scholarship_money:scholarship_money,
                            scholarship_quota:scholarship_quota,
                            scholarship_year:scholarship_year,
                            start_time:start_time,
                            end_time:end_time,
                            creation_unit:creation_unit,
                            funding_source:funding_source,
                            basic_requirement:basic_requirement,
                            scholarship_file:scholarship_file
                        },
                        success:function (result) {
                            $("#addScholarship").before("<div class=\"col-lg-3 col-md-4 col-sm-5 col-xs-7\" id=\"" + result.scholarship_id + "\">\n" +
                                "                <div class=\"well\" style=\"background-color:white;\">\n" +
                                "                    <table frame=\"void\">\n" +
                                "                        <thead>\n" +
                                "                        <tr style=\"height:50px\">\n" +
                                "                            <th><h4 style=\"white-space:nowrap;width:80px;overflow:hidden;text-overflow:ellipsis\" title=\"" + result.scholarship_type + "\">" + result.scholarship_type + "</h4></th>\n" +
                                "                            <th><h4 style=\"white-space:nowrap;width:142px;overflow:hidden;text-overflow:ellipsis\" title=\"" + result.scholarship_name + "\">" + result.scholarship_name + "</h4></th>\n" +
                                "                        </tr>\n" +
                                "                        </thead>\n" +
                                "                        <tbody>\n" +
                                "                        <tr style=\"height:30px\">\n" +
                                "                            <td>开始时间</td>\n" +
                                "                            <td>" + result.start_time + "</td>\n" +
                                "                        </tr>\n" +
                                "                        <tr style=\"height:30px\">\n" +
                                "                            <td>结束时间</td>\n" +
                                "                            <td>" + result.end_time + "</td>\n" +
                                "                        </tr>\n" +
                                "                        <tr style=\"height:30px\">\n" +
                                "                            <td>金额（元）</td>\n" +
                                "                            <td>" + result.scholarship_money + "</td>\n" +
                                "                        </tr>\n" +
                                "                        <tr style=\"height:35px\">\n" +
                                "                            <td><button type=\"button\" class=\"btn btn-default\" onclick=\"showScholarship('" + result.scholarship_id + "')\">详情</button></td>\n" +
                                "                            <td><button type=\"button\" class=\"btn btn-primary\" onclick=\"updateScholarship('" + result.scholarship_id + "')\">修改</button>\n" +
                                "                                <button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteScholarship('" + result.scholarship_id + "')\">删除</button></td>\n" +
                                "                        </tr>\n" +
                                "                        </tbody>\n" +
                                "                    </table>\n" +
                                "                </div>\n" +
                                "            </div>");
                            alert("添加成功");
                        },
                        error:function () {
                            alert("请重新添加！");
                        }
                    })
                }
            }
        }else {
            alert("请将信息填写完整！");
        }
    });

    $("#setScholarship").modal('show');
}


function updateScholarship(scholarship_id) {
    $.ajax({
        type: "post",
        url: "/scholarship/getScholarship",
        dataType:"json",
        data: {
            scholarship_id: scholarship_id
        },
        success: function (result) {
            $("#scholarship_name1").val(result.scholarship_name);
            $("#scholarship_type1").val(result.scholarship_type);
            $("#scholarship_money1").val(result.scholarship_money);
            $("#scholarship_quota1").val(result.scholarship_quota);
            $("#scholarship_year1").val(result.scholarship_year);
            $("#start_time1").datetimebox("setValue",getDate(result.start_time));
            $("#end_time1").datetimebox("setValue",getDate(result.end_time));
            $("#creation_unit1").val(result.creation_unit);
            $("#funding_source1").val(result.funding_source);
            $("#basic_requirement1").val(result.basic_requirement);
            $("#scholarship_file1").val("");


            $("#updateScholarshipButton").off("click");
            $("#updateScholarshipButton").click(function () {
                var scholarship_name = $("#scholarship_name1").val();
                var scholarship_type = $("#scholarship_type1").val();
                var scholarship_money = $("#scholarship_money1").val();
                var scholarship_quota = $("#scholarship_quota1").val();
                var scholarship_year = $("#scholarship_year1").val();
                var start_time = $("#start_time1").datetimebox("getValue");
                var end_time = $("#end_time1").datetimebox("getValue");
                var creation_unit = $("#creation_unit1").val();
                var funding_source = $("#funding_source1").val();
                var basic_requirement = $("#basic_requirement1").val();
                var scholarshipFile = $("#scholarship_file1")[0].files;
                if(scholarship_name && scholarship_type && scholarship_money && scholarship_quota && scholarship_year && start_time && end_time && creation_unit && funding_source){
                    if(start_time > end_time){
                        alert("结束时间不能小于开始时间！");
                    }else {
                        var scholarship_file = null;
                        if (scholarshipFile.length != 0) {
                            scholarship_file = uploadFiles(scholarshipFile, "奖学金", "奖学金附件");
                        }

                        if (scholarship_file != "fail") {
                            $.ajax({
                                type: "post",
                                url: "/scholarship/setScholarship",
                                dataType: "json",
                                data: {
                                    scholarship_id: scholarship_id,
                                    scholarship_name: scholarship_name,
                                    scholarship_type: scholarship_type,
                                    scholarship_money: scholarship_money,
                                    scholarship_quota: scholarship_quota,
                                    scholarship_year: scholarship_year,
                                    start_time: start_time,
                                    end_time: end_time,
                                    creation_unit: creation_unit,
                                    funding_source: funding_source,
                                    basic_requirement: basic_requirement,
                                    scholarship_file: scholarship_file
                                },
                                success: function (result) {
                                    $("#"+scholarship_id).html("<div class=\"well\" style=\"background-color:white;\">\n" +
                                        "                    <table frame=\"void\">\n" +
                                        "                        <thead>\n" +
                                        "                        <tr style=\"height:50px\">\n" +
                                        "                            <th><h4 style=\"white-space:nowrap;width:80px;overflow:hidden;text-overflow:ellipsis\" title=\"" + result.scholarship_type + "\">" + result.scholarship_type + "</h4></th>\n" +
                                        "                            <th><h4 style=\"white-space:nowrap;width:142px;overflow:hidden;text-overflow:ellipsis\" title=\"" + result.scholarship_name + "\">" + result.scholarship_name + "</h4></th>\n" +
                                        "                        </tr>\n" +
                                        "                        </thead>\n" +
                                        "                        <tbody>\n" +
                                        "                        <tr style=\"height:30px\">\n" +
                                        "                            <td>开始时间</td>\n" +
                                        "                            <td>" + getDate(result.start_time) + "</td>\n" +
                                        "                        </tr>\n" +
                                        "                        <tr style=\"height:30px\">\n" +
                                        "                            <td>结束时间</td>\n" +
                                        "                            <td>" + getDate(result.end_time) + "</td>\n" +
                                        "                        </tr>\n" +
                                        "                        <tr style=\"height:30px\">\n" +
                                        "                            <td>金额（元）</td>\n" +
                                        "                            <td>" + result.scholarship_money + "</td>\n" +
                                        "                        </tr>\n" +
                                        "                        <tr style=\"height:35px\">\n" +
                                        "                            <td><button type=\"button\" class=\"btn btn-default\" onclick=\"showScholarship('" + result.scholarship_id + "')\">详情</button></td>\n" +
                                        "                            <td><button type=\"button\" class=\"btn btn-primary\" onclick=\"updateScholarship('" + result.scholarship_id + "')\">修改</button>\n" +
                                        "                                <button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteScholarship('" + result.scholarship_id + "')\">删除</button></td>\n" +
                                        "                        </tr>\n" +
                                        "                        </tbody>\n" +
                                        "                    </table>\n" +
                                        "                </div>");
                                    alert("修改成功！");
                                },
                                error: function () {
                                    alert("请重新修改！");
                                }
                            });
                        }
                    }
                }else {
                    alert("请将信息填写完整！");
                }
            });

            $("#updateScholarship").modal('show');


        }
    })
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
            $("#scholarship_name2").html(result.scholarship_name);
            $("#scholarship_name2").attr("title",result.scholarship_name);
            $("#scholarship_type2").html(result.scholarship_type);
            $("#scholarship_type2").attr("title",result.scholarship_type);
            $("#scholarship_money2").html(result.scholarship_money);
            $("#scholarship_quota2").html(result.scholarship_quota);
            $("#scholarship_year2").html(result.scholarship_year);
            $("#start_time2").html(getDate(result.start_time));
            $("#end_time2").html(getDate(result.end_time));
            $("#creation_unit2").html(result.creation_unit);
            $("#creation_unit2").attr("title",result.creation_unit);
            $("#funding_source2").html(result.funding_source);
            $("#funding_source2").attr("title",result.funding_source);
            $("#basic_requirement2").html(result.basic_requirement);

            var scholarship_file = result.scholarship_file;
            $("#scholarship_file2").html("");
            if(scholarship_file && scholarship_file != ""){
                var fileNames = getFileNames(scholarship_file);
                var fileIds = scholarship_file.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#scholarship_file2").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }


            $("#showScholarshipButton").off("click");
            $("#showScholarshipButton").click(function () {
                $("#showScholarship").modal('hide');
                updateScholarship(scholarship_id);
            });

            $("#showScholarship").modal('show');
        }
    })
}

function deleteScholarship(scholarship_id) {
    $("#deleteScholarship").modal('show');

    $("#deleteScholarshipButton").off("click");
    $("#deleteScholarshipButton").click(function () {
        $.ajax({
            type:"post",
            url:"/scholarship/deleteScholarship",
            data:{
                scholarship_id:scholarship_id
            },
            success:function () {
                $("#"+scholarship_id).remove();
                alert("删除成功！");
            },
            error:function () {
                alert("请重新删除!");
            }
        })
    });

}