$(document).ready(function () {
    getStudentList(1);
});

function getStudentList(currentPage) {
    var totalPages = 0;
    $.ajax({
        async:false,
        url:"/student/getTotalPages",
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
        url:"/student/getStudentList",
        data:{
            currentPage:currentPage,
            pageSize:10
        },
        success:function (result) {
            var studentList = eval(JSON.stringify(result));
            $("#studentList").html("");
            for(var i = 0; i < studentList.length; i++){
                $("#studentList").append("<tr id=\"" + studentList[i].student_id + "\">\n" +
                    "                        <td>" + studentList[i].student_id + "</td>\n" +
                    "                        <td>" + studentList[i].student_name + "</td>\n" +
                    "                        <td>" + studentList[i].sex + "</td>\n" +
                    "                        <td>" + studentList[i].nationality + "</td>\n" +
                    "                        <td>" + studentList[i].student_year + "</td>\n" +
                    "                        <td>" + studentList[i].department + "</td>\n" +
                    "                        <td>" + studentList[i].major + "</td>\n" +
                    "                        <td>" + studentList[i].student_class + "</td>\n" +
                    "                        <td style=\"padding-top: 0;padding-bottom: 0\"><button type=\"button\" class=\"btn btn-danger\" onclick=\"deleteStudent('" + studentList[i].student_id + "')\">删除</button></td>\n" +
                    "                    </tr>");
            }


            $("#studentPage").bootstrapPaginator({
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
                    getStudentList(page);
                }
            });
        }
    })
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

function importStudent() {
    var studentFile = $("#student_file")[0].files;
    var student_file = null;
    if(studentFile.length != 0){
        student_file = uploadFiles(studentFile,"学生信息","学生信息表")
    }

    if(student_file != "fail" && student_file != null) {
        $.ajax({
            type:"post",
            url:"/files/importFile",
            data:{
                student_file:student_file
            },
            success:function () {
                alert("导入成功");
                getStudentList(1);
            },
            error:function () {
                alert("请重新导入");
            }
        })
    }
}

function deleteStudent(student_id) {
    $("#deleteStudent").modal('show');

    $("#deleteStudentButton").off("click");
    $("#deleteStudentButton").click(function () {
        $.ajax({
            type:"post",
            url:"/student/deleteStudent",
            data:{
                student_id:student_id
            },
            success:function () {
                $("#"+student_id).remove();
                alert("删除成功！");
            },
            error:function () {
                alert("请重新删除!");
            }
        })
    });
}