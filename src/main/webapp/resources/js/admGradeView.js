$(document).ready(function () {
    getGradeList(1);
});

function getGradeList(currentPage) {
    var totalPages = 0;
    $.ajax({
        async:false,
        url:"/grade/getTotalPages",
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
        url:"/grade/getGradeList",
        data:{
            currentPage:currentPage,
            pageSize:10
        },
        success:function (result) {
            var gradeList = result.gradeList;
            var studentList = result.studentList;
            $("#gradeList").html("");
            for(var i = 0; i < gradeList.length; i++){
                $("#gradeList").append("<tr id=\"" + gradeList[i].grade_id + "\">\n" +
                    "                        <td>" + gradeList[i].grade_id + "</td>\n" +
                    "                        <td>" + studentList[i].student_name + "</td>\n" +
                    "                        <td>" + gradeList[i].fail_number + "</td>\n" +
                    "                        <td>" + gradeList[i].intellect_score + "</td>\n" +
                    "                        <td>" + gradeList[i].moral_score + "</td>\n" +
                    "                        <td>" + gradeList[i].art_score + "</td>\n" +
                    "                        <td>" + gradeList[i].total_score + "</td>\n" +
                    "                        <td>" + gradeList[i].intellect_ranking + "</td>\n" +
                    "                        <td>" + gradeList[i].total_ranking + "</td>\n" +
                    "                        <td></td>\n" +
                    "                    </tr>");
            }


            $("#gradePage").bootstrapPaginator({
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
                    getGradeList(page);
                }
            });
        }
    })
}

function gradeUpdate() {
    $("#updateGradeButton").off("click");
    $("#updateGradeButton").click(function () {
        var intellect_percent = $("#intellect_percent").val();
        var moral_percent = $("#moral_percent").val();
        var art_percent = $("#art_percent").val();
        $.ajax({
            type:"post",
            url:"/grade/updateAllGrade",
            data:{
                intellect_percent:intellect_percent,
                moral_percent:moral_percent,
                art_percent:art_percent
            },
            success:function () {
                alert("更新成功！");
                getGradeList(1);
            },
            error:function () {
                alert("请再次更新!");
            }
        })
    });
    $("#updateGrade").modal('show');
}