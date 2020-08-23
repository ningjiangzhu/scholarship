package cn.changan.dao;


import cn.changan.entity.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface QuestionMapper {
    int insertQuestion(Question question);
    int selectQuestionCount ();
    Question selectQuestion(String question_id);
    List<Question> selectQuestionList(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize);
    int updateQuestion(Question question);
    int deleteQuestion(String question_id);
}
