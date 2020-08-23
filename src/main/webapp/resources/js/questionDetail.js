function answerQuestion(question_id) {
    $("#answerContent").modal('show');
    $("#answer_content").val("");

    $("#answerContentButton").off("click");
    $("#answerContentButton").click(function () {
        var answer_content = $("#answer_content").val();
        if(answer_content){
            $.ajax({
                type:"post",
                url:"/question/updateQuestion",
                data:{
                    question_id:question_id,
                    answer_content:answer_content
                },
                success:function () {
                    alert("提交成功!");
                    location.href="/question/questionDetail?question_id="+question_id;
                },
                error:function () {
                    alert("请重新提交!");
                }
            })
        }else{
            alert("请输入内容");
        }

    })
}