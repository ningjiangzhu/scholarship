$(document).ready(function () {
    getNoticeList(1);
    getQuestionList(1);
});
var editor;
KindEditor.ready(function (K) {
    editor = K.create("#notice_content",{
        width:"100%",
        height:"300px"
    });
    editor.html("");
});

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

function getNoticeList(currentPage) {
    var totalPages = 0;
    $.ajax({
        async:false,
        url:"/notice/getTotalPages",
        data:{
            pageSize:5
        },
        success:function (result) {
            totalPages = result;
        }
    });

    $.ajax({
        url:"/notice/getNoticeList",
        type:"post",
        data:{
            currentPage:currentPage,
            pageSize:5
        },
        dataType:"json",
        success:function (result) {
            var noticeList = eval(JSON.stringify(result));
            $("#noticeList").html("");
            for(var i = 0; i < noticeList.length; i++){
                $("#noticeList").append("<tr>\n" +
                    "                        <td><h4 style=\"white-space:nowrap;width:220px;overflow:hidden;text-overflow:ellipsis;margin: 0\" title=\"" + noticeList[i].notice_name + "\"><a href='/notice/noticeDetail?notice_id=" + noticeList[i].notice_id + "'>" + noticeList[i].notice_name + "</a></h4></td>\n" +
                    "                        <td>" + getDate(noticeList[i].notice_time) + "</td>\n" +
                    "                    </tr>");
            }

            $("#noticePage").bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:currentPage,
                totalPages:totalPages,
                numberOfPages:5,
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
                    getNoticeList(page);
                }
            });

        }
    })
}


function getQuestionList(currentPage) {
    var totalPages = 0;
    $.ajax({
        async:false,
        url:"/question/getTotalPages",
        data:{
            pageSize:5
        },
        success:function (result) {
            totalPages = result;
        }
    });

    $.ajax({
        type:"post",
        dataType:"json",
        url:"/question/getQuestionList",
        data:{
            currentPage:currentPage,
            pageSize:5
        },
        success:function (result) {
            var questionList = eval(JSON.stringify(result));
            $("#questionList").html("");
            for(var i = 0; i < questionList.length; i++){
                $("#questionList").append("<tr>\n" +
                    "                        <td><h4 style=\"white-space:nowrap;width:180px;overflow:hidden;text-overflow:ellipsis;margin:0\" title=\"" + questionList[i].question_name + "\"><a href='/question/questionDetail?question_id="+ questionList[i].question_id + "'>" + questionList[i].question_name + "</a></h4></td>\n" +
                    "                        <td>" + getDate(questionList[i].question_time) + "</td>\n" +
                    "                        <td>" + questionList[i].question_state + "</td>\n" +
                    "                    </tr>");
            }


            $("#questionPage").bootstrapPaginator({
                bootstrapMajorVersion:3,
                currentPage:currentPage,
                totalPages:totalPages,
                numberOfPages:5,
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
                    getQuestionList(page);
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

function setNotice() {
    $("#notice_name").val("");

    $("#notice_file").val("");


    $("#setNoticeButton").off("click");
    $("#setNoticeButton").click(function () {
        var notice_name = $("#notice_name").val();
        var notice_content = editor.html();
        var noticeFile = $("#notice_file")[0].files;
        if(notice_name && notice_content) {
            var notice_file = null;
            if(noticeFile.length != 0){
                notice_file = uploadFiles(noticeFile,"公告","公告附件")
            }

            if(notice_file != "fail"){
                $.ajax({
                    url:"/notice/setNotice",
                    type:"post",
                    data:{
                        notice_name:notice_name,
                        notice_content:notice_content,
                        notice_file:notice_file
                    },
                    success:function () {
                        alert("发布成功!");
                        location.href="/login/administratorPage";
                    },
                    error:function () {
                        alert("请重新发布！");
                    }
                });
            }
        }else {
            alert("公告标题和正文不能为空！")
        }

    });

    $("#setNotice").modal('show');
}