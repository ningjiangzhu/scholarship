package cn.changan.controller;

import cn.changan.entity.Student;
import cn.changan.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Resource
    private StudentService studentService;

    /**
     * 学生请求个人信息页面
     *
     * @param session session对象
     * @param model model对象
     * @return stuStudent.jsp
     */
    @RequestMapping("/stuStudent")
    public String stuStudent(HttpSession session,Model model){
        String student_id = (String)session.getAttribute("login_id");
        Student student = studentService.getStudent(student_id);
        model.addAttribute("student",student);
        return "stuStudent";
    }

    /**
     * 管理员请求学生信息页面
     *
     * @return admStudent.jsp
     */
    @RequestMapping("/admStudent")
    public String admStudent(){
        return "admStudent";
    }

    /**
     * 根据每页显示的学生数获得总页数
     *
     * @param pageSize 每页要显示的学生数
     * @return 总页数
     */
    @RequestMapping("/getTotalPages")
    @ResponseBody
    public int getTotalPages ( int pageSize){
        int studentCount = studentService.getStudentCount();
        int totalPages;
        if(studentCount%pageSize != 0){
            totalPages = studentCount / pageSize + 1;
        }else{
            totalPages = studentCount / pageSize;
        }
        return totalPages;
    }

    /**
     * 根据当前页数和每页学生数,得到该页要显示的学生信息
     *
     * @param currentPage 当前页数
     * @param pageSize 每页学生数
     * @return 当前页的学生信息
     */
    @RequestMapping("/getStudentList")
    @ResponseBody
    public List<Student> getStudentList (int currentPage, int pageSize){
        currentPage = (currentPage - 1) * pageSize;
        return studentService.getStudentList(currentPage,pageSize);
    }


    @RequestMapping("updateStudent")
    @ResponseBody
    public void updateStudent(String birth, String id_card, String native_place, String politic_face, String phone_number,HttpSession session){
        String student_id = (String)session.getAttribute("login_id");
        Student student = studentService.getStudent(student_id);

        Date date;
        try{
            date = new SimpleDateFormat("yyyy-MM-dd").parse(birth);
        }catch(Exception e){
            throw new RuntimeException(e);
        }

        student.setBirth(date);
        student.setId_card(id_card);
        student.setNative_place(native_place);
        student.setPolitic_face(politic_face);
        student.setPhone_number(phone_number);
        studentService.updateStudent(student);
    }

    @RequestMapping("deleteStudent")
    @ResponseBody
    public void deleteStudent(String student_id){
        studentService.deleteStudent(student_id);
    }

    @RequestMapping("updatePortrait")
    @ResponseBody
    public void updatePortrait(String portrait,HttpSession session){
        String student_id = (String)session.getAttribute("login_id");
        studentService.updatePortrait(student_id,portrait);
    }
}
