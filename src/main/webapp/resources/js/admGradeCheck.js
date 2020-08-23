$(document).ready(function () {
    getCheckGradeList(1);
});

function getCheckGradeList(currentPage) {
    var totalPages = 0;
    $.ajax({
        async:false,
        url:"/grade/getCheckTotalPages",
        data:{
            pageSize:10
        },
        success:function (result) {
            totalPages = result;
        }
    });

    $.ajax({
        type:"post",
        dataType:"json",
        url:"/grade/getCheckGradeList",
        data:{
            currentPage:currentPage,
            pageSize:10
        },
        success:function (result) {
            var checkGradeList = result.checkGradeList;
            var checkStudentList = result.checkStudentList;
            $("#checkGradeList").html("");
            for(var i = 0; i < checkGradeList.length; i++){
                $("#checkGradeList").append("<tr id=\"" + checkGradeList[i].grade_id + "\">\n" +
                    "                            <td>" + checkGradeList[i].grade_id + "</td>\n" +
                    "                            <td>" + checkStudentList[i].student_name + "</td>\n" +
                    "                            <td>" + checkGradeList[i].intellect_score + "</td>\n" +
                    "                            <td>" + checkGradeList[i].moral_score + "</td>\n" +
                    "                            <td>" + checkGradeList[i].art_score + "</td>\n" +
                    "                            <td style=\"padding-top: 0;padding-bottom: 0\"><button type=\"button\" class=\"btn btn-default\" onclick=\"viewFile('" + checkGradeList[i].grade_id + "')\">查看</button></td>\n" +
                    "                            <td style=\"padding-top: 0;padding-bottom: 0\"><button type=\"button\" class=\"btn btn-primary\" onclick=\"gradeCheck('" + checkGradeList[i].grade_id + "','" + checkGradeList[i].intellect_score + "','" + checkGradeList[i].moral_score + "','" + checkGradeList[i].art_score + "')\">审核</button></td>\n" +
                    "                        </tr>");
            }


            $("#checkGradePage").bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:currentPage,
                totalPages:totalPages,
                numberOfPages:10,
                shouldShowPage:true,
                itemTexts:function (type,page,current) {
                    switch (type){
                        case "first":return "<<";
                        case "prev":return "<";
                        case "next":return ">";
                        case "last":return ">>";
                        case "page":return page;
                    }
                },
                onPageClicked:function (event,originalEvent,type,page) {
                    getCheckGradeList(page);
                }
            });
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

function viewFile(grade_id) {
    $.ajax({
        type: "post",
        url: "/grade/getGrade",
        dataType:"json",
        data: {
            grade_id: grade_id
        },
        success: function (result) {
            var intellect_file = result.intellect_file;
            var moral_file = result.moral_file;
            var art_file = result.art_file;

            $("#grade_reason").html(result.grade_reason);
            $("#intellect_file").html("");
            $("#moral_file").html("");
            $("#art_file").html("");

            if(intellect_file && intellect_file != ""){
                var fileNames = getFileNames(intellect_file);
                var fileIds = intellect_file.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#intellect_file").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }

            if(moral_file && moral_file != ""){
                var fileNames = getFileNames(moral_file);
                var fileIds = moral_file.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#moral_file").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }

            if(art_file && art_file != ""){
                var fileNames = getFileNames(art_file);
                var fileIds = art_file.split(",");
                for(var i = 0; i < fileNames.length; i++){
                    $("#art_file").append("<a title=\""+ fileNames[i] +"\" href='/files/downloadFiles?file_id="+ fileIds[i]+"'>" + fileNames[i] + "</a><br>")
                }
            }

            $("#viewFile").modal('show');
        }
    });

}

function gradeCheck(grade_id,intellect_score,moral_score,art_score) {
    $("#intellect_score").val(intellect_score);
    $("#moral_score").val(moral_score);
    $("#art_score").val(art_score);

    $("#checkGradeButton").off("click");
    $("#checkGradeButton").click(function () {
        var intellect_score = $("#intellect_score").val();
        var moral_score = $("#moral_score").val();
        var art_score = $("#art_score").val();
        if(intellect_score && moral_score && art_score){
            $.ajax({
                type:"post",
                url:"/grade/updateGrade",
                data:{
                    grade_id:grade_id,
                    intellect_score:intellect_score,
                    moral_score:moral_score,
                    art_score:art_score
                },
                success:function () {
                    $("#"+grade_id).remove();
                    alert("审核成功！");
                },
                error:function () {
                    alert("请重新审核!");
                }
            })

        }else{
            alert("成绩不能为空！");
        }
    });
    $("#checkGrade").modal('show');
}