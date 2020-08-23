package cn.changan.dao;

import cn.changan.entity.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentMapper {
    Student selectStudent(String student_id);
    int updateStudent(Student student);
    int selectStudentCount ();
    List<Student> selectStudentList(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize);
    int deleteStudent(String student_id);
    int insertStudent(Student student);
    int updatePortrait(@Param("student_id") String student_id,@Param("portrait") String portrait);
}
