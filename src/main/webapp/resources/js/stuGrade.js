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
        }
    });
    return uploadResult;
}


function totalCheck(grade_id) {
    $.ajax({
        type:"post",
        dataType:"json",
        url:"/grade/getGrade",
        data:{
            grade_id:grade_id
        },
        success:function (result) {
            if(result.total_score){
                alert("您已有综合测评成绩！");
            }else{
                $("#totalCheck").modal('show');

                $("#grade_reason").val("");
                $("#intellect_file").val("");
                $("#moral_file").val("");
                $("#art_file").val("");

                $("#totalCheckButton").off("click");
                $("#totalCheckButton").click(function () {
                    var grade_reason = $("#grade_reason").val();
                    var intellectFile = $("#intellect_file")[0].files;
                    var moralFile = $("#moral_file")[0].files;
                    var artFile = $("#art_file")[0].files;
                    var intellect_file = null;
                    var moral_file = null;
                    var art_file = null;

                    if(intellectFile.length != 0){
                        intellect_file = uploadFiles(intellectFile,"综合测评加分项","智育成绩加分项");
                    }
                    if(moralFile.length != 0){
                        moral_file = uploadFiles(moralFile,"综合测评加分项","德育成绩加分项");
                    }
                    if(artFile.length != 0){
                        art_file = uploadFiles(artFile,"综合测评加分项","文体美成绩加分项");
                    }

                    if(intellect_file != "fail" && moral_file != "fail" && art_file != "fail"){
                        $.ajax({
                            type:"post",
                            url:"/grade/setGrade",
                            data:{
                                grade_reason:grade_reason,
                                intellect_file:intellect_file,
                                moral_file:moral_file,
                                art_file:art_file
                            },
                            success:function () {
                                alert("提交成功！");
                            },
                            error:function () {
                                alert("请重新提交");
                            }
                        })
                    }

                });

            }
        }
    });
}