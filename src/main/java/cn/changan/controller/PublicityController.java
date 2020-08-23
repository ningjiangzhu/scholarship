package cn.changan.controller;

import cn.changan.entity.Publicity;
import cn.changan.service.PublicityService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/publicity")
public class PublicityController {

    @Resource
    private PublicityService publicityService;

    /**
     * 判断待公示奖学金是否处于公示期
     * @param scholarship_id
     * @return
     */
    @RequestMapping(value="/checkPublicity",produces = {"text/html;charset=utf-8;","application/json;"})
    @ResponseBody
    public String checkPublicity(String scholarship_id){
        List<Publicity> publicityList = publicityService.getPublicityListByScholarshipId(scholarship_id);
        Date nowTime = new Date();
        if(publicityList != null && publicityList.size() != 0){
            for (Publicity publicity:publicityList) {
                if(!nowTime.before(publicity.getStart_time()) && !nowTime.after(publicity.getEnd_time())){
                    return "此奖学金正处于公示期!";
                }
            }
        }
        return "";
    }

    /**
     * 公示奖学金
     * @param scholarship_id
     * @param start_time
     * @param end_time
     */
    @RequestMapping("/setPublicity")
    @ResponseBody
    public void setPublicity(String scholarship_id,String start_time,String end_time){
        Date startTime;
        Date endTime;
        try{
            startTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(start_time);
            endTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(end_time);
        }catch(Exception e){
            throw new RuntimeException(e);
        }

        Date date = new Date();
        String publicity_id = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(date);
        Publicity publicity = new Publicity();
        publicity.setPublicity_id(publicity_id);
        publicity.setScholarship_id(scholarship_id);
        publicity.setStart_time(startTime);
        publicity.setEnd_time(endTime);
        publicityService.setPublicity(publicity);
    }

    @RequestMapping("/getPublicityList")
    @ResponseBody
    public List<Publicity> getPublicityList(String scholarship_id){
        return publicityService.getPublicityListByScholarshipId(scholarship_id);
    }
}
