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

function getPassApply(scholarship_id){

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
            $("#"+scholarship_id+"applyList").html("");
            for(var i = 0; i < applyList.length; i++){
                $("#"+scholarship_id+"applyList").append("<tr>\n" +
                    "                                    <td>" + studentList[i].student_id + "</td>\n" +
                    "                                    <td>" + studentList[i].student_name + "</td>\n" +
                    "                                    <td>" + studentList[i].student_year + "</td>\n" +
                    "                                    <td>" + studentList[i].major + "</td>\n" +
                    "                                    <td>" + studentList[i].student_class + "</td>\n" +
                    "                                    <td>" + gradeList[i].fail_number + "</td>\n" +
                    "                                    <td>" + gradeList[i].intellect_score + "</td>\n" +
                    "                                    <td>" + gradeList[i].intellect_ranking + "</td>\n" +
                    "                                    <td>" + gradeList[i].total_score + "</td>\n" +
                    "                                    <td>" + gradeList[i].total_ranking + "</td>\n" +
                    "                                </tr>");
            }
        }
    });

    $("#"+scholarship_id).collapse('toggle');
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