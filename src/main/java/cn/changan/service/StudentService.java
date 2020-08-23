package cn.changan.service;

import cn.changan.entity.Grade;
import cn.changan.entity.Login;
import cn.changan.entity.Student;

import java.util.List;

public interface StudentService {
    Student getStudent(String student_id);
    void updateStudent(Student student);
    int getStudentCount();
    List<Student> getStudentList(int currentPage, int pageSize);
    void deleteStudent(String student_id);
    void setStudent(List<Login> loginList, List<Student> studentList, List<Grade> gradeList);
    void updatePortrait(String student_id,String portrait);
}
