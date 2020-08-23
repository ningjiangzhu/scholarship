package cn.changan.controller;

import cn.changan.entity.Apply;
import cn.changan.entity.Grade;
import cn.changan.entity.Scholarship;
import cn.changan.entity.Student;
import cn.changan.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/apply")
public class ApplyController {

    @Resource
    private ApplyService applyService;

    @Resource
    private ScholarshipService scholarshipService;

    @Resource
    private StudentService studentService;

    @Resource
    private GradeService gradeService;


    /**
     * 根据申请编号返回申请记录
     * @param apply_id
     * @return
     */
    @RequestMapping("/getApply")
    @ResponseBody
    public Apply getApply(String apply_id){
        return applyService.getApply(apply_id);
    }

    /**
     * 看是否符合申请条件
     * @param scholarship_id
     * @param session
     * @return
     */
    @RequestMapping(value="/checkApply",produces = {"text/html;charset=utf-8;","application/json;"})
    @ResponseBody
    public String checkApply(String scholarship_id, HttpSession session){
        String student_id = (String)session.getAttribute("login_id");
        Student student = studentService.getStudent(student_id);
        if(student.getId_card() == null || student.getId_card().equals("")){
            return "请先完善个人信息！";
        }

        Grade grade = gradeService.getGrade(student_id);
        if(grade.getGrade_state().equals("未审核")){
            return "请等待综合测评审核结果！";
        }
        if(grade.getGrade_state().equals("未提交")){
            return "请先进行综合测评!";
        }
        List<Apply> applyList = applyService.getApplyListByStudentId(student_id);
        Scholarship scholarship = scholarshipService.getScholarship(scholarship_id);
        for (Apply apply:applyList) {
            String apply_state = apply.getApply_state();
            String scholarshipId = apply.getScholarship_id();
            Scholarship scholarship1 = scholarshipService.getScholarship(scholarshipId);
            if(scholarship.getScholarship_type().equals(scholarship1.getScholarship_type()) && !apply_state.equals("未通过")){
                return "您已申请过此类型奖学金！";
            }
        }
        return "";
    }

    /**
     * 管理员审核，更新申请表
     * @param apply_id
     * @param fail_reason
     * @param apply_state
     */
    @RequestMapping("/updateApply")
    @ResponseBody
    public void updateApply(String apply_id,String fail_reason,String apply_state){
        Apply apply = applyService.getApply(apply_id);
        Date date = new Date();
        apply.setCheck_time(date);
        apply.setApply_state(apply_state);
        apply.setFail_reason(fail_reason);
        applyService.updateApply(apply);
    }

    /**
     * 根据申请编号，删除某申请记录
     * @param apply_id
     */
    @RequestMapping("/deleteApply")
    @ResponseBody
    public void deleteApply(String apply_id){
        applyService.deleteApply(apply_id);
    }

    /**
     * 添加申请
     * @param scholarship_id
     * @param apply_reason
     * @param apply_form
     * @param school_report
     * @param award_certificate
     * @param session
     */
    @RequestMapping("/setApply")
    @ResponseBody
    public void setApply(@RequestParam("scholarship_id")String scholarship_id,
                         @RequestParam("apply_reason")String apply_reason,
                         @RequestParam("apply_form")String apply_form,
                         @RequestParam("school_report")String school_report,
                         @RequestParam(value = "award_certificate",required = false)String award_certificate,
                         HttpSession session){
        String student_id = (String)session.getAttribute("login_id");

        Date date = new Date();
        String nowTime = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(date);
        Apply apply = new Apply();
        apply.setApply_id(nowTime);
        apply.setStudent_id(student_id);
        apply.setScholarship_id(scholarship_id);
        apply.setApply_time(date);
        apply.setApply_reason(apply_reason);
        apply.setApply_form(apply_form);
        apply.setSchool_report(school_report);
        apply.setAward_certificate(award_certificate);
        apply.setApply_state("未审核");
        apply.setCheck_time(null);
        apply.setFail_reason(null);
        apply.setTotal_score(gradeService.getGrade(student_id).getTotal_score());
        applyService.setApply(apply);
    }


    @RequestMapping("/getApplyListByState")
    @ResponseBody
    public Map<String, Object> getApplyListByState(String scholarship_id,String apply_state){
        List<Apply> applyList = applyService.getApplyListByState(scholarship_id,apply_state);
        List<Student> studentList = new ArrayList<>();
        List<Grade> gradeList = new ArrayList<>();
        for (Apply apply:applyList) {
            String student_id = apply.getStudent_id();
            Student student = studentService.getStudent(student_id);
            Grade grade = gradeService.getGrade(student_id);
            studentList.add(student);
            gradeList.add(grade);
        }

        Map<String, Object> stringObjectMap = new HashMap<>();
        stringObjectMap.put("applyList",applyList);
        stringObjectMap.put("studentList",studentList);
        stringObjectMap.put("gradeList",gradeList);
        return stringObjectMap;
    }
}
