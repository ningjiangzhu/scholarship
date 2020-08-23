package cn.changan.controller;

import cn.changan.entity.Login;
import cn.changan.entity.Question;
import cn.changan.service.LoginService;
import cn.changan.service.QuestionService;
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
@RequestMapping("/question")
public class QuestionController {
    @Resource
    private QuestionService questionService;

    @Resource
    private LoginService loginService;

    @Resource
    private StudentService studentService;

    /**
     * 学生提问问题
     * @param question_name
     * @param question_content
     * @param session
     */
    @RequestMapping("/setQuestion")
    @ResponseBody
    public void setQuestion (String question_name, String question_content, HttpSession session){
        String student_id = (String)session.getAttribute("login_id");
        Question question = new Question();
        Date date = new Date();
        String nowTime = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(date);
        question.setQuestion_id(nowTime);
        question.setQuestion_name(question_name);
        question.setQuestion_time(date);
        question.setQuestion_content(question_content);
        question.setQuestion_people(studentService.getStudent(student_id).getStudent_name());
        question.setAnswer_time(null);
        question.setAnswer_people(null);
        question.setAnswer_content(null);
        question.setQuestion_state("未解答");
        questionService.setQuestion(question);
    }


    /**
     * 根据问题编号获取问题信息，返回问题详情页面
     * @param question_id
     * @param model
     * @return
     */
    @RequestMapping("/questionDetail")
    public String questionDetail (String question_id, HttpSession session, Model model){
        String login_id = (String)session.getAttribute("login_id");
        Login login = loginService.getLogin(login_id);
        String identity = login.getIdentity();

        Question question = questionService.getQuestion(question_id);

        model.addAttribute("identity",identity);
        model.addAttribute("question",question);
        if(identity.equals("学生")){
            String student_name = studentService.getStudent(login_id).getStudent_name();
            model.addAttribute("student_name",student_name);
        }
        return "questionDetail";
    }

    /**
     * 管理员回答问题后更新
     * @param question_id
     * @param answer_content
     */
    @RequestMapping("/updateQuestion")
    @ResponseBody
    public void updateQuestion (String question_id, String answer_content){

        Question question = questionService.getQuestion(question_id);
        Date date = new Date();
        question.setAnswer_time(date);
        question.setAnswer_people("管理员");
        question.setAnswer_content(answer_content);
        question.setQuestion_state("已解答");
        questionService.updateQuestion(question);
    }

    /**
     * 获取总页数
     * @return
     */
    @RequestMapping("/getTotalPages")
    @ResponseBody
    public int getTotalPages ( int pageSize){
        int questionCount = questionService.getQuestionCount();
        int totalPages;
        if(questionCount%pageSize != 0){
            totalPages = questionCount / pageSize + 1;
        }else{
            totalPages = questionCount / pageSize;
        }
        return totalPages;
    }


    /**
     * 根据当前页获取当前页内容
     * @param currentPage
     * @return
     */
    @RequestMapping("/getQuestionList")
    @ResponseBody
    public List<Question> getQuestionList (int currentPage, int pageSize){
        currentPage = (currentPage - 1) * pageSize;
        return questionService.getQuestionList(currentPage,pageSize);
    }
}
