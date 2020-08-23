package cn.changan.service;

import cn.changan.entity.Grade;

import java.util.List;

public interface GradeService {
    Grade getGrade(String grade_id);
    void setGrade(Grade grade);
    void updateGrade(Grade grade);
    void updateAllGrade(List<Grade> gradeList);
    List<Grade> getAllGrade();

    int getGradeCount();
    List<Grade> getGradeList(int currentPage, int pageSize);

    int getCheckGradeCount();
    List<Grade> getCheckGradeList(int currentPage, int pageSize);
}
