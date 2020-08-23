package cn.changan.controller;

import cn.changan.entity.Login;
import cn.changan.entity.Student;
import cn.changan.service.LoginService;
import cn.changan.service.StudentService;
import cn.changan.util.SendSmsUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Resource
    private LoginService loginService;

    @Resource
    private StudentService studentService;


    /**
     *
     * 验证用户输入的账号密码是否正确
     *
     * @param login_id 用户账号
     * @param password 用户密码
     * @return 提示
     */
    @RequestMapping("/checkLogin")
    @ResponseBody
    public String checkLogin(String login_id, String password){
        Login login = loginService.getLogin(login_id);
        if(login == null){
            return "fail";
        }else{
            if(login.getPassword().equals(password)){
                if(login.getIdentity().equals("学生")){
                    return "successStudent";
                }else{
                    return "successAdministrator";
                }
            }else{
                return "fail";
            }
        }
    }

    /**
     * 退出到登录页面
     *
     * @return login.jsp
     */
    @RequestMapping("/logout")
    public String logout(){
        return "login";
    }

    /**
     *
     * 将学号存入session，获得学生对象，返回学生主页面
     *
     * @param request request对象
     * @param session session对象
     * @param model model对象
     * @return studentPage.jsp
     */
    @RequestMapping("/studentPage")
    public String studentPage(HttpServletRequest request, HttpSession session, Model model){
        if(request.getParameter("login_id") != null){
            session.setAttribute("login_id",request.getParameter("login_id"));
        }
        Student student = studentService.getStudent((String)session.getAttribute("login_id"));
        model.addAttribute("student",student);
        return "studentPage";
    }

    /**
     * 将职工号存入session，获得session中的职工号，返回管理员主页面
     *
     * @param request request对象
     * @param session session对象
     * @param model model对象
     * @return administratorPage.jsp
     */
    @RequestMapping("/administratorPage")
    public String administratorPage(HttpServletRequest request, HttpSession session,Model model){
        if(request.getParameter("login_id") != null){
            session.setAttribute("login_id",request.getParameter("login_id"));
        }
        String login_id = (String)session.getAttribute("login_id");
        model.addAttribute("login_id",login_id);
        return "administratorPage";
    }

    @RequestMapping("/stuPassword")
    public String stuPassword(HttpSession session,Model model){
        String login_id = (String)session.getAttribute("login_id");
        Login login = loginService.getLogin((login_id));
        Student student = studentService.getStudent(login_id);
        String phone_number = login.getPhone_number();
        if(phone_number != null && !phone_number.equals("")){
            phone_number = phone_number.substring(0,3) + "****" + phone_number.substring(7);
        }else{
            return "redirect:/login/stuPhone";
        }
        model.addAttribute("student",student);
        model.addAttribute("phone_number",phone_number);
        return "stuPassword";
    }

    @RequestMapping("/stuPhone")
    public String stuPhone(HttpSession session,Model model){
        String login_id = (String)session.getAttribute("login_id");
        Login login = loginService.getLogin(login_id);
        Student student = studentService.getStudent(login_id);
        String phone_number = login.getPhone_number();
        if(phone_number != null && !phone_number.equals("")){
            phone_number = phone_number.substring(0,3) + "****" + phone_number.substring(7);
        }
        model.addAttribute("student",student);
        model.addAttribute("phone_number",phone_number);
        return "stuPhone";
    }

    @RequestMapping("/changePhone")
    public String changePhone(HttpSession session,Model model){
        String login_id = (String)session.getAttribute("login_id");
        Student student = studentService.getStudent(login_id);
        model.addAttribute("student",student);
        model.addAttribute("phone_number","");
        return "stuPhone";
    }

    @RequestMapping("/findPassword")
    public String findPassword(){
        return "findPassword";
    }

    @RequestMapping("/getCaptchaCode")
    @ResponseBody
    public void getCaptchaCode(String phone_number,HttpSession session) throws Exception{
        StringBuilder stringBuilder  = new StringBuilder();
        Random random = new Random();
        for (int i = 0;i < 6; i++){
            stringBuilder.append(random.nextInt(10));
        }
        String captchaCode = "{\"code\":\"" + stringBuilder + "\"}";
        String result = SendSmsUtil.sendSms(phone_number,captchaCode);
        if(result.equals("OK")) {
            session.setAttribute("phone_number",phone_number);
            session.setAttribute("captchaCode", stringBuilder.toString());
            final Timer timer = new Timer();
            timer.schedule(new TimerTask() {
                @Override
                public void run() {
                    session.removeAttribute("captchaCode");
                    session.removeAttribute("phone_number");
                    timer.cancel();
                }
            }, 5 * 60 * 1000);
        }
    }

    @RequestMapping(value = "/checkCaptchaCode",produces = {"text/html;charset=utf-8;","application/json;"})
    @ResponseBody
    public String checkCaptchaCode(String captchaCode,HttpSession session){
        if(session.getAttribute("captchaCode") == null){
            return "请获取验证码";
        }else{
            String s = (String)session.getAttribute("captchaCode");
            if(s.equals(captchaCode)){
                return "";
            }else{
                return "验证码错误";
            }
        }
    }

    @RequestMapping("/setPhone_number")
    @ResponseBody
    public void setPhone_number(HttpSession session){
        String phone_number = (String)session.getAttribute("phone_number");
        Login login = loginService.getLogin((String)session.getAttribute("login_id"));
        login.setPhone_number(phone_number);
        loginService.updateLogin(login);
    }

    @RequestMapping("/setPassword")
    @ResponseBody
    public void setPassword(String password,HttpSession session){
        Login login = loginService.getLogin((String)session.getAttribute("login_id"));
        login.setPassword(password);
        loginService.updateLogin(login);
    }

    @RequestMapping(value = "/checkLogin_id",produces = {"text/html;charset=utf-8;","application/json;"})
    @ResponseBody
    public String checkLogin_id(String login_id,HttpSession session){
        Login login = loginService.getLogin(login_id);
        if(login == null){
            return "1";
        }else if(login.getPhone_number() == null || login.getPhone_number().equals("")){
            return "2";
        }else{
            session.setAttribute("login_id",login_id);
            String phone_number = login.getPhone_number();
            phone_number = phone_number.substring(0,3) + "****" + phone_number.substring(7);
            return phone_number;
        }
    }


    @RequestMapping("/getPhone_number")
    @ResponseBody
    public String getPhone_number(HttpSession session){
        Login login = loginService.getLogin((String)session.getAttribute("login_id"));
        return login.getPhone_number();
    }
}
