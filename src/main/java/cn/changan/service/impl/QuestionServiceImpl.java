package cn.changan.service.impl;

import cn.changan.dao.QuestionMapper;
import cn.changan.entity.Question;
import cn.changan.service.QuestionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService{
    @Resource
    private QuestionMapper questionMapper;

    @Override
    public int getQuestionCount() {
        return questionMapper.selectQuestionCount();
    }

    @Override
    public void setQuestion(Question question) {
        questionMapper.insertQuestion(question);
    }

    @Override
    public Question getQuestion(String question_id) {
        return questionMapper.selectQuestion(question_id);
    }

    @Override
    public List<Question> getQuestionList(int currentPage, int pageSize) {
        return questionMapper.selectQuestionList(currentPage,pageSize);
    }

    @Override
    @Transactional
    public void updateQuestion(Question question) {
        questionMapper.deleteQuestion(question.getQuestion_id());
        questionMapper.insertQuestion(question);
    }
}
