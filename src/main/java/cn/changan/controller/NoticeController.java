package cn.changan.controller;

import cn.changan.entity.Login;
import cn.changan.entity.Notice;
import cn.changan.service.FilesService;
import cn.changan.service.LoginService;
import cn.changan.service.NoticeService;
import cn.changan.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Resource
    private NoticeService noticeService;

    @Resource
    private StudentService studentService;

    @Resource
    private LoginService loginService;

    @Resource
    private FilesService filesService;


    /*@RequestMapping("stuNotice")
    public String stuNotice(HttpSession session,Model model){
        model.addAttribute("student_name",studentService.getStudent((String)session.getAttribute("login_id")).getStudent_name() );
        return "stuNotice";
    }*/

    /**
     * 管理员发布公告
     * @param notice_name
     * @param notice_content
     * @param notice_file
     */
    @RequestMapping("/setNotice")
    @ResponseBody
    public void setNotice (String notice_name, String notice_content, String notice_file){

        Notice notice = new Notice();
        Date date = new Date();
        String nowTime = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(date);
        notice.setNotice_id(nowTime);
        notice.setNotice_name(notice_name);
        notice.setNotice_time(date);
        notice.setNotice_people("管理员");
        notice.setNotice_content(notice_content);
        notice.setNotice_file(notice_file);
        noticeService.setNotice(notice);
    }



    /**
     * 根据公告编号获取公告信息，返回公告详情页面
     * @param notice_id
     * @param model
     * @return
     */
    @RequestMapping("/noticeDetail")
    public String noticeDetail (String notice_id, HttpSession session,Model model){
        String login_id = (String)session.getAttribute("login_id");
        Login login = loginService.getLogin(login_id);
        String identity = login.getIdentity();

        Notice notice = noticeService.getNotice(notice_id);

        List<String> fileIdList = new ArrayList<>();
        List<String> fileNameList = new ArrayList<>();
        String notice_file = notice.getNotice_file();
        if(notice_file != null && !notice_file.equals("")){
            String[] noticeFile = notice_file.split(",");
            for (String file_id:noticeFile) {
                fileIdList.add(filesService.getFiles(file_id).getFile_id());
                fileNameList.add(filesService.getFiles(file_id).getFile_name());
            }
        }

        model.addAttribute("notice",notice);
        model.addAttribute("identity",identity);
        model.addAttribute("fileIdList",fileIdList);
        model.addAttribute("fileNameList",fileNameList);

        if(identity.equals("学生")){
            String student_name = studentService.getStudent(login_id).getStudent_name();
            model.addAttribute("student_name",student_name);
        }
        return "noticeDetail";
    }


    /**
     * 获取总页数
     * @return
     */
    @RequestMapping("/getTotalPages")
    @ResponseBody
    public int getTotalPages ( int pageSize){
        int noticeCount = noticeService.getNoticeCount();
        int totalPages;
        if(noticeCount%pageSize != 0){
            totalPages = noticeCount / pageSize + 1;
        }else{
            totalPages = noticeCount / pageSize;
        }
        return totalPages;
    }


    /**
     * 根据当前页获取当前页内容
     * @param currentPage
     * @return
     */
    @RequestMapping("/getNoticeList")
    @ResponseBody
    public List<Notice> getNoticeList (int currentPage,int pageSize){
        currentPage = (currentPage - 1) * pageSize;
        return noticeService.getNoticeList(currentPage,pageSize);
    }
}
