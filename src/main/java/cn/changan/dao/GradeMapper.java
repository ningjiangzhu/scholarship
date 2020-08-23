package cn.changan.dao;

import cn.changan.entity.Grade;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GradeMapper {
    Grade selectGrade(String grade_id);
    int insertGrade(Grade grade);
    int updateGrade(Grade grade);
    int deleteGrade(String grade_id);
    List<Grade> selectAllGrade();

    int selectGradeCount ();
    List<Grade> selectGradeList(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize);

    int selectCheckGradeCount ();
    List<Grade> selectCheckGradeList(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize);
}
