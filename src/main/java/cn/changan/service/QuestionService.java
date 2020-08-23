package cn.changan.service;

import cn.changan.entity.Question;

import java.util.List;

public interface QuestionService {
    int getQuestionCount();
    void setQuestion(Question question);
    Question getQuestion(String question_id);
    List<Question> getQuestionList(int currentPage, int pageSize);
    void updateQuestion(Question question);
}
