package cn.changan.service.impl;

import cn.changan.dao.ApplyMapper;
import cn.changan.dao.GradeMapper;
import cn.changan.dao.LoginMapper;
import cn.changan.dao.StudentMapper;
import cn.changan.entity.Grade;
import cn.changan.entity.Login;
import cn.changan.entity.Student;
import cn.changan.service.StudentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService{
    @Resource
    private StudentMapper studentMapper;

    @Resource
    private ApplyMapper applyMapper;

    @Resource
    private GradeMapper gradeMapper;

    @Resource
    private LoginMapper loginMapper;

    @Override
    public Student getStudent(String student_id) {
        return studentMapper.selectStudent(student_id);
    }

    @Override
    public void updateStudent(Student student) {
        studentMapper.updateStudent(student);
    }

    @Override
    public int getStudentCount() {
        return studentMapper.selectStudentCount();
    }

    @Override
    public List<Student> getStudentList(int currentPage, int pageSize) {
        return studentMapper.selectStudentList(currentPage,pageSize);
    }

    @Override
    @Transactional
    public void deleteStudent(String student_id) {
        studentMapper.deleteStudent(student_id);
        applyMapper.deleteApplyByStudentId(student_id);
        gradeMapper.deleteGrade(student_id);
        loginMapper.deleteLogin(student_id);
    }

    @Override
    @Transactional
    public void setStudent(List<Login> loginList, List<Student> studentList, List<Grade> gradeList) {
        for (Login login:loginList) {
            loginMapper.insertLogin(login);
        }
        for (Student student:studentList) {
            studentMapper.insertStudent(student);
        }
        for (Grade grade:gradeList) {
            gradeMapper.insertGrade(grade);
        }
    }

    @Override
    public void updatePortrait(String student_id, String portrait) {
        studentMapper.updatePortrait(student_id,portrait);
    }
}
