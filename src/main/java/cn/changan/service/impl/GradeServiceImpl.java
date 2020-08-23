package cn.changan.service.impl;

import cn.changan.dao.GradeMapper;
import cn.changan.entity.Grade;
import cn.changan.service.GradeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.List;

@Service
public class GradeServiceImpl implements GradeService{
    @Resource
    private GradeMapper gradeMapper;

    @Override
    public Grade getGrade(String grade_id) {
        return gradeMapper.selectGrade(grade_id);
    }

    @Override
    public void setGrade(Grade grade) {
        gradeMapper.insertGrade(grade);
    }


    @Override
    public void updateGrade(Grade grade) {
        gradeMapper.updateGrade(grade);
    }

    @Override
    @Transactional
    public void updateAllGrade(List<Grade> gradeList) {
        for (Grade grade:gradeList) {
            gradeMapper.updateGrade(grade);
        }
    }

    @Override
    public List<Grade> getAllGrade() {
        return gradeMapper.selectAllGrade();
    }

    @Override
    public int getGradeCount() {
        return gradeMapper.selectGradeCount();
    }

    @Override
    public List<Grade> getGradeList(int currentPage, int pageSize) {
        return gradeMapper.selectGradeList(currentPage,pageSize);
    }

    @Override
    public int getCheckGradeCount() {
        return gradeMapper.selectCheckGradeCount();
    }

    @Override
    public List<Grade> getCheckGradeList(int currentPage, int pageSize) {
        return gradeMapper.selectCheckGradeList(currentPage,pageSize);
    }
}
