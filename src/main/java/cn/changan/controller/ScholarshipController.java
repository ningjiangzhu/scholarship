package cn.changan.controller;

import cn.changan.entity.*;
import cn.changan.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/scholarship")
public class ScholarshipController {

    @Resource
    private ScholarshipService scholarshipService;

    @Resource
    private StudentService studentService;


    @Resource
    private ApplyService applyService;


    @Resource
    private PublicityService publicityService;


    /**
     * 获取所有在发布期的奖学金，返回奖学金申请页面
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("/stuScholarshipApply")
    public String stuScholarshipApply(HttpSession session, Model model){
        List<Scholarship> scholarshipList = scholarshipService.getScholarshipListByTime();
        model.addAttribute("scholarshipList",scholarshipList);
        model.addAttribute("student_name",studentService.getStudent((String)session.getAttribute("login_id")).getStudent_name());
        return "stuScholarshipApply";
    }

    /**
     * 根据session中的学生id得到该学生的所有奖学金申请记录
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("/stuScholarshipCheck")
    public String stuScholarshipCheck(HttpSession session, Model model){
        String student_id = (String)session.getAttribute("login_id");
        List<Apply> applyList = applyService.getApplyListByStudentId(student_id);
        List<Scholarship> scholarshipList = new ArrayList<>();
        for (Apply apply:applyList) {
            scholarshipList.add(scholarshipService.getScholarship(apply.getScholarship_id()));
        }
        model.addAttribute("applyList",applyList);
        model.addAttribute("scholarshipList",scholarshipList);
        model.addAttribute("student_name",studentService.getStudent(student_id).getStudent_name());
        return "stuScholarshipCheck";
    }

    /**
     * 获取处于公示期的所有奖学金信息，及每个奖学金的所有学生信息
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("/stuScholarshipNotice")
    public String stuScholarshipNotice(HttpSession session, Model model){
        List<Publicity> publicityList = publicityService.getPublicityListByTime();
        List<Scholarship> scholarshipList = new ArrayList<>();
        for (Publicity publicity:publicityList) {
            String scholarship_id = publicity.getScholarship_id();
            scholarshipList.add(scholarshipService.getScholarship(scholarship_id));
        }

        model.addAttribute("publicityList",publicityList);
        model.addAttribute("scholarshipList",scholarshipList);
        model.addAttribute("student_name",studentService.getStudent((String)session.getAttribute("login_id")).getStudent_name());
        return "stuScholarshipNotice";
    }

    /**
     * 查询所有奖学金信息，返回管理员奖学金发布页面
     * @param model
     * @return
     */
    @RequestMapping("/admScholarshipPublic")
    public String admScholarshipPublic(Model model){
        List<Scholarship> scholarshipList = scholarshipService.getAllScholarship();
        model.addAttribute("scholarshipList",scholarshipList);
        return "admScholarshipPublic";
    }

    /**
     * 查询有未审核的奖学金信息
     * @param model
     * @return
     */
    @RequestMapping("/admScholarshipCheck")
    public String admScholarshipCheck(Model model){
        List<Scholarship> scholarshipList = scholarshipService.getAllScholarship();
        model.addAttribute("scholarshipList",scholarshipList);
        return "admScholarshipCheck";
    }

    /**
     * 所有奖学金通过的人名单，返回管理员奖学金公示页面
     * @param model
     * @return
     */
    @RequestMapping("/admScholarshipNotice")
    public String admScholarshipNotice(Model model){
        List<Scholarship> scholarshipList = scholarshipService.getAllScholarship();
        model.addAttribute("scholarshipList",scholarshipList);
        return "admScholarshipNotice";
    }

    /**
     * 添加或修改奖学金信息
     * @param scholarship_id
     * @param scholarship_name
     * @param scholarship_type
     * @param scholarship_money
     * @param scholarship_quota
     * @param scholarship_year
     * @param start_time
     * @param end_time
     * @param creation_unit
     * @param funding_source
     * @param basic_requirement
     * @param scholarship_file
     * @return
     */
    @RequestMapping("/setScholarship")
    @ResponseBody
    public Scholarship setScholarship(@RequestParam(value="scholarship_id",required=false) String scholarship_id,
                                      @RequestParam("scholarship_name") String scholarship_name,
                                      @RequestParam("scholarship_type") String scholarship_type,
                                      @RequestParam("scholarship_money")String scholarship_money,
                                      @RequestParam("scholarship_quota")String scholarship_quota,
                                      @RequestParam("scholarship_year")String scholarship_year,
                                      @RequestParam("start_time")String start_time,
                                      @RequestParam("end_time") String end_time,
                                      @RequestParam("creation_unit")String creation_unit,
                                      @RequestParam("funding_source")String funding_source,
                                      @RequestParam(value="basic_requirement",required = false)String basic_requirement,
                                      @RequestParam(value="scholarship_file",required = false)String scholarship_file){
        Date startTime;
        Date endTime;
        try{
            startTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(start_time);
            endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(end_time);
        }catch(Exception e){
            throw new RuntimeException(e);
        }


        Scholarship scholarship = new Scholarship();
        scholarship.setScholarship_name(scholarship_name);
        scholarship.setScholarship_type(scholarship_type);
        scholarship.setScholarship_money(scholarship_money);
        scholarship.setScholarship_quota(scholarship_quota);
        scholarship.setScholarship_year(scholarship_year);
        scholarship.setStart_time(startTime);
        scholarship.setEnd_time(endTime);
        scholarship.setCreation_unit(creation_unit);
        scholarship.setFunding_source(funding_source);
        scholarship.setBasic_requirement(basic_requirement);
        scholarship.setScholarship_file(scholarship_file);
        if(scholarship_id == null){
            Date date = new Date();
            scholarship.setScholarship_id(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(date));
            scholarshipService.setScholarship(scholarship);
        }else{
            scholarship.setScholarship_id(scholarship_id);
            scholarshipService.updateScholarship(scholarship);
        }
        return scholarship;
    }

    /**
     * 删除所有与此奖学金有关的信息
     * @param scholarship_id
     */
    @RequestMapping("/deleteScholarship")
    @ResponseBody
    public void deleteScholarship(String scholarship_id){
        scholarshipService.deleteScholarship(scholarship_id);
    }

    /**
     * 根据奖学金编号查询奖学金
     * @param scholarship_id
     * @return
     */
    @RequestMapping("/getScholarship")
    @ResponseBody
    public Scholarship getScholarship(String scholarship_id){
        return scholarshipService.getScholarship(scholarship_id);
    }

    /**
     * 学生根据查询条件模糊查询
     * @param condition
     * @return
     */
    @RequestMapping("/getScholarshipListByTimeLike")
    @ResponseBody
    public List<Scholarship> getScholarshipListByTimeLike(String condition){
        condition = "%" + condition +"%";
        return scholarshipService.getScholarshipListByTimeLike(condition);
    }

    /**
     * 管理员根据条件模糊查询
     * @param condition
     * @return
     */
    @RequestMapping("/getScholarshipListByLike")
    @ResponseBody
    public List<Scholarship> getScholarshipListByLike(String condition){
        condition = "%" + condition +"%";
        return scholarshipService.getScholarshipListByLike(condition);
    }
}
