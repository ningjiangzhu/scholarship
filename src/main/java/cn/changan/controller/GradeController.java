package cn.changan.controller;

import cn.changan.entity.Grade;
import cn.changan.entity.Student;
import cn.changan.service.GradeService;
import cn.changan.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.NumberFormat;
import java.util.*;

@Controller
@RequestMapping("/grade")
public class GradeController {

    @Resource
    private GradeService gradeService;

    @Resource
    private StudentService studentService;

    /**
     * 查询学生成绩，返回学生成绩界面
     * @param session session对象
     * @param model model对象
     * @return stuGrade.jsp
     */
    @RequestMapping("/stuGrade")
    public String stuGrade(HttpSession session,Model model){
        String student_id = (String)session.getAttribute("login_id");
        String student_name = studentService.getStudent(student_id).getStudent_name();
        Grade grade = gradeService.getGrade(student_id);

        model.addAttribute("student_name",student_name);
        model.addAttribute("grade",grade);
        return "stuGrade";
    }

    /**
     * 请求成绩预览页面
     * @return admGradeView.jsp
     */
    @RequestMapping("/admGradeView")
    public String admGradeView(Model model){
        String gradeCount = String.valueOf(gradeService.getGradeCount());
        model.addAttribute("gradeCount",gradeCount);
        return "admGradeView";
    }

    /**
     * 根据每页显示的学生成绩数得到总页数
     * @param pageSize 每页显示学生成绩数
     * @return 总页数
     */
    @RequestMapping("/getTotalPages")
    @ResponseBody
    public int getTotalPages ( int pageSize){
        int gradeCount = gradeService.getGradeCount();
        int totalPages;
        if(gradeCount%pageSize != 0){
            totalPages = gradeCount / pageSize + 1;
        }else{
            totalPages = gradeCount / pageSize;
        }
        return totalPages;
    }

    /**
     * 根据当前页数和每页学生成绩数得到该页学生成绩信息
     *
     * @param currentPage 当前页数
     * @param pageSize 每页学生成绩数
     * @return 该页学生信息及成绩信息
     */
    @RequestMapping("/getGradeList")
    @ResponseBody
    public Map<String, Object> getGradeList (int currentPage, int pageSize){
        currentPage = (currentPage - 1) * pageSize;
        List<Grade> gradeList = gradeService.getGradeList(currentPage,pageSize);
        List<Student> studentList = new ArrayList<>();
        for (Grade grade : gradeList) {
            Student student = studentService.getStudent(grade.getGrade_id());
            studentList.add(student);
        }
        Map<String, Object> stringObjectMap = new HashMap<>();
        stringObjectMap.put("gradeList",gradeList);
        stringObjectMap.put("studentList",studentList);
        return stringObjectMap;
    }


    @RequestMapping("/admGradeCheck")
    public String admGradeCheck(Model model){
        String checkGradeCount = String.valueOf(gradeService.getCheckGradeCount());
        model.addAttribute("checkGradeCount",checkGradeCount);
        return "admGradeCheck";
    }

    @RequestMapping("/getCheckTotalPages")
    @ResponseBody
    public int getCheckTotalPages ( int pageSize){
        int checkGradeCount = gradeService.getCheckGradeCount();
        int checkTotalPages;
        if(checkGradeCount%pageSize != 0){
            checkTotalPages = checkGradeCount / pageSize + 1;
        }else{
            checkTotalPages = checkGradeCount / pageSize;
        }
        return checkTotalPages;
    }

    @RequestMapping("/getCheckGradeList")
    @ResponseBody
    public Map<String, Object> getCheckGradeList (int currentPage, int pageSize){
        currentPage = (currentPage - 1) * pageSize;
        List<Grade> checkGradeList = gradeService.getCheckGradeList(currentPage,pageSize);
        List<Student> checkStudentList = new ArrayList<>();
        for (Grade grade : checkGradeList) {
            Student student = studentService.getStudent(grade.getGrade_id());
            checkStudentList.add(student);
        }
        Map<String, Object> stringObjectMap = new HashMap<>();
        stringObjectMap.put("checkGradeList",checkGradeList);
        stringObjectMap.put("checkStudentList",checkStudentList);
        return stringObjectMap;
    }

    /**
     * 根据学号找到对应成绩
     * @param grade_id 学号
     * @return 成绩
     */
    @RequestMapping("/getGrade")
    @ResponseBody
    public Grade getGrade(String grade_id){
        return gradeService.getGrade(grade_id);
    }

    /**
     * 将成绩加分项存入数据库
     * @param intellect_file 智育加分项
     * @param moral_file 德育加分项
     * @param art_file 文体美加分项
     * @param session session对象
     */
    @RequestMapping("/setGrade")
    @ResponseBody
    public void setGrade(@RequestParam(value = "grade_reason",required = false)String grade_reason,
                         @RequestParam(value = "intellect_file",required = false)String intellect_file,
                         @RequestParam(value = "moral_file",required = false)String moral_file,
                         @RequestParam(value = "art_file",required = false)String art_file,
                         HttpSession session){
        String grade_id = (String)session.getAttribute("login_id");
        Grade grade = gradeService.getGrade(grade_id);
        grade.setGrade_reason(grade_reason);
        grade.setIntellect_file(intellect_file);
        grade.setMoral_file(moral_file);
        grade.setArt_file(art_file);
        grade.setGrade_state("未审核");
        gradeService.updateGrade(grade);
    }

    /**
     * 更新单人成绩
     * @param grade_id 学号
     * @param intellect_score 智育成绩
     * @param moral_score 德育成绩
     * @param art_score 文体美成绩
     */
    @RequestMapping("/updateGrade")
    @ResponseBody
    public void updateGrade(String grade_id, String intellect_score,String moral_score,String art_score){
        Grade grade = gradeService.getGrade(grade_id);
        grade.setIntellect_score(Double.parseDouble(intellect_score));
        grade.setMoral_score(Double.parseDouble(moral_score));
        grade.setArt_score(Double.parseDouble(art_score));
        grade.setGrade_state("已审核");
        gradeService.updateGrade(grade);
    }

    /**
     * 更新所有成绩
     * @param intellect_percent 智育占比
     * @param moral_percent 德育占比
     * @param art_percent 文体美占比
     */
    @RequestMapping("/updateAllGrade")
    @ResponseBody
    public void updateAllGrade(String intellect_percent,String moral_percent,String art_percent){
        List<Grade> gradeList = gradeService.getAllGrade();
        Number intellectPercent,moralPercent,artPercent;
        try{
            intellectPercent = NumberFormat.getPercentInstance().parse(intellect_percent);
            moralPercent = NumberFormat.getPercentInstance().parse(moral_percent);
            artPercent = NumberFormat.getPercentInstance().parse(art_percent);
        }catch (Exception e){
            throw new RuntimeException(e);
        }
        double intellect = intellectPercent.doubleValue();
        double moral = moralPercent.doubleValue();
        double art = artPercent.doubleValue();

        List<Grade> grades = new ArrayList<>();
        List<Grade> gradeResult = new ArrayList<>();

        if(gradeList != null && gradeList.size() != 0){

            gradeList.sort(new Comparator<Grade>() {
                @Override
                public int compare(Grade o1, Grade o2) {
                    if(o2.getIntellect_score() - o1.getIntellect_score() > 0){
                        return 1;
                    }else if(o2.getIntellect_score() - o1.getIntellect_score() < 0){
                        return -1;
                    }
                    return 0;
                }
            });

            for(int i = 0; i < gradeList.size();i++){
                Grade grade = gradeList.get(i);
                double intellectScore = grade.getIntellect_score();
                double moralScore = grade.getMoral_score();
                double artScore = grade.getArt_score();
                double totalScore = intellectScore * intellect + moralScore * moral + artScore * art;
                grade.setTotal_score(totalScore);
                grade.setIntellect_ranking(String.valueOf(i+1));
                grade.setGrade_state("已审核");
                grades.add(grade);
            }

            grades.sort(new Comparator<Grade>() {
                @Override
                public int compare(Grade o1, Grade o2) {
                    if(o2.getTotal_score() - o1.getTotal_score() > 0){
                        return 1;
                    }else if(o2.getTotal_score() - o1.getTotal_score() < 0){
                        return -1;
                    }
                    return 0;
                }
            });

            for(int i = 0; i < grades.size();i++){
                Grade grade = grades.get(i);
                grade.setTotal_ranking(String.valueOf(i+1));
                gradeResult.add(grade);
            }

            gradeService.updateAllGrade(gradeResult);
        }
    }
}
