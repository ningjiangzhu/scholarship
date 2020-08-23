package cn.changan.controller;

import cn.changan.entity.*;
import cn.changan.service.*;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/files")
public class FilesController {

    @Resource
    private FilesService filesService;

    @Resource
    private ScholarshipService scholarshipService;

    @Resource
    private ApplyService applyService;

    @Resource
    private GradeService gradeService;

    @Resource
    private StudentService studentService;

    @RequestMapping("/getFiles")
    @ResponseBody
    public Files getFiles(String file_id){
        return filesService.getFiles(file_id);
    }

    @RequestMapping("/showImg")
    @ResponseBody
    public void showImg(String file_id, HttpServletResponse response){
        Files files = filesService.getFiles(file_id);
        File file = new File(files.getFile_path());
        /*String ext = files.getFile_name().substring(files.getFile_name().lastIndexOf("."));
        if(ext.equals("jpg") || ext.equals("JPG")){
            response.setContentType("image/jpeg");
        }else if(ext.equals("png") || ext.equals("PNG")){
            response.setContentType("image/png");
        }*/
        InputStream inputStream;
        OutputStream outputStream;
        try{
            outputStream = new BufferedOutputStream(response.getOutputStream());
            inputStream = new FileInputStream(file);
            byte[] bytes = new byte[1024*10];
            int n;
            while((n = inputStream.read(bytes)) != -1){
                outputStream.write(bytes,0,n);
            }
            outputStream.flush();
            outputStream.close();
            inputStream.close();
        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }

    /**
     * 上传文件，返回拼接的文件id
     * @param filesList 文件
     * @param uploadType 上传类型
     * @param fileType 文件类型
     * @param session session对象
     * @param request request对象
     * @return 拼接的文件id
     */
    @RequestMapping("/uploadFiles")
    @ResponseBody
    public String uploadFiles(MultipartFile[] filesList, String uploadType, String fileType, HttpSession session, HttpServletRequest request){
        String login_id = (String)session.getAttribute("login_id");
        String filePath = request.getSession().getServletContext().getRealPath("/")+ "uploadFiles" + "\\" + login_id + "\\" + uploadType + "\\" + fileType;
        String fileId = "";
        for (MultipartFile file : filesList) {
            Date date = new Date();
            String file_id = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(date);
            String file_name = file.getOriginalFilename();
            String file_path = filePath + "\\" + file_name;

            Files files = new Files();
            files.setFile_id(file_id);
            files.setFile_name(file_name);
            files.setFile_path(file_path);

            try{
                File f = new File(filePath,file_name);
                if(!f.getParentFile().exists()){
                    f.getParentFile().mkdirs();
                }
                file.transferTo(f);
                filesService.setFiles(files);
                fileId += "," + file_id;
            }catch (Exception e){
                throw  new RuntimeException(e);
            }
        }
        return fileId.substring(1);
    }

    /**
     * 使用ResponseEntity类实现文件下载，将响应头文件数据、状态封装在一起交给浏览器处理。
     *
     * @param file_id 要下载的文件id
     * @return 进行下载
     * @throws IOException 抛出异常
     */
    @RequestMapping("/downloadFiles")
    public ResponseEntity<byte[]> downloadFiles(String file_id) throws IOException{
        Files files = filesService.getFiles(file_id);
        File file = new File(files.getFile_path());
        HttpHeaders headers = new HttpHeaders();
        try{
            //解决文件名中文乱码
            String fileName = new String(files.getFile_name().getBytes("utf-8"),"iso-8859-1");
            //通知浏览器以attachment(下载方式）打开文件
            headers.setContentDispositionFormData("attachment",fileName);
            //APPLICATION_OCTET_STREAM二进制流数据（最常见的文件下载）
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        } catch(Exception e){
            throw  new RuntimeException(e);
        }
        //读取二进制文件，http协议状态最好使用HttpStatus.OK代表200
        return new ResponseEntity<>(FileUtils.readFileToByteArray(file),headers, HttpStatus.OK);
    }

    /**
     * 根据拼接的文件id得到文件的名称集合
     * @param filesId 拼接的文件id
     * @return 文件名字集合
     */
    @RequestMapping(value="/getFileNameList",produces = {"text/html;charset=utf-8;","application/json;"})
    @ResponseBody
    public List<String> getFileNameList(String filesId){
        List<String> fileNameList = new ArrayList<>();
        String[] fileIds = filesId.split(",");
        for (String file_id:fileIds) {
            fileNameList.add(filesService.getFiles(file_id).getFile_name());
        }
        return fileNameList;
    }


    @RequestMapping("/importFile")
    @ResponseBody
    public void importFile(String student_file){
        List<Login> loginList = new ArrayList<>();
        List<Student> studentList = new ArrayList<>();
        List<Grade> gradeList = new ArrayList<>();


        Files files = filesService.getFiles(student_file);
        File file = new File(files.getFile_path());
        String ext = files.getFile_name().substring(files.getFile_name().lastIndexOf("."));

        if(ext.equals(".xls")){
            try{
                HSSFWorkbook workbook = new HSSFWorkbook(FileUtils.openInputStream(file));
                HSSFSheet sheet = workbook.getSheetAt(0);
                for(int i = 1;i <= sheet.getLastRowNum();i++){
                    HSSFRow row = sheet.getRow(i);
                    row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(8).setCellType(Cell.CELL_TYPE_STRING);

                    Login login = new Login();
                    login.setIdentity("学生");

                    Student student = new Student();

                    Grade grade = new Grade();
                    grade.setGrade_state("未提交");

                    login.setLogin_id(row.getCell(0).getStringCellValue());
                    login.setPassword(row.getCell(0).getStringCellValue());

                    student.setStudent_id(row.getCell(0).getStringCellValue());
                    student.setStudent_name(row.getCell(1).getStringCellValue());
                    student.setSex(row.getCell(2).getStringCellValue());
                    student.setNationality(row.getCell(3).getStringCellValue());
                    student.setStudent_year(row.getCell(4).getStringCellValue());
                    student.setDepartment(row.getCell(5).getStringCellValue());
                    student.setMajor(row.getCell(6).getStringCellValue());
                    student.setStudent_class(row.getCell(7).getStringCellValue());
                    if(row.getCell(2).getStringCellValue().equals("男")){
                        student.setPortrait("00000000000000000");
                    }else if(row.getCell(2).getStringCellValue().equals("女")){
                        student.setPortrait("00000000000000001");
                    }

                    grade.setGrade_id(row.getCell(0).getStringCellValue());
                    grade.setFail_number(row.getCell(8).getStringCellValue());
                    grade.setIntellect_score(row.getCell(9).getNumericCellValue());
                    grade.setMoral_score(row.getCell(10).getNumericCellValue());
                    grade.setArt_score(row.getCell(11).getNumericCellValue());

                    loginList.add(login);
                    studentList.add(student);
                    gradeList.add(grade);
                }
            }catch (Exception e){
                throw new RuntimeException(e);
            }

        }else if(ext.equals(".xlsx")){
            try{
                XSSFWorkbook workbook = new XSSFWorkbook(FileUtils.openInputStream(file));
                XSSFSheet sheet = workbook.getSheetAt(0);
                for(int i = 1;i <= sheet.getLastRowNum();i++){
                    XSSFRow row = sheet.getRow(i);

                    row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                    row.getCell(8).setCellType(Cell.CELL_TYPE_STRING);

                    Login login = new Login();
                    login.setIdentity("学生");

                    Student student = new Student();

                    Grade grade = new Grade();
                    grade.setGrade_state("未提交");

                    login.setLogin_id(row.getCell(0).getStringCellValue());
                    login.setPassword(row.getCell(0).getStringCellValue());

                    student.setStudent_id(row.getCell(0).getStringCellValue());
                    student.setStudent_name(row.getCell(1).getStringCellValue());
                    student.setSex(row.getCell(2).getStringCellValue());
                    student.setNationality(row.getCell(3).getStringCellValue());
                    student.setStudent_year(row.getCell(4).getStringCellValue());
                    student.setDepartment(row.getCell(5).getStringCellValue());
                    student.setMajor(row.getCell(6).getStringCellValue());
                    student.setStudent_class(row.getCell(7).getStringCellValue());
                    if(row.getCell(2).getStringCellValue().equals("男")){
                        student.setPortrait("00000000000000000");
                    }else if(row.getCell(2).getStringCellValue().equals("女")){
                        student.setPortrait("00000000000000001");
                    }

                    grade.setGrade_id(row.getCell(0).getStringCellValue());
                    grade.setFail_number(row.getCell(8).getStringCellValue());
                    grade.setIntellect_score(row.getCell(9).getNumericCellValue());
                    grade.setMoral_score(row.getCell(10).getNumericCellValue());
                    grade.setArt_score(row.getCell(11).getNumericCellValue());

                    loginList.add(login);

                    studentList.add(student);
                    gradeList.add(grade);
                }
            }catch (Exception e){
                throw new RuntimeException(e);
            }
        }

        studentService.setStudent(loginList,studentList,gradeList);
    }


    @RequestMapping("/exportFile")
    @ResponseBody
    public String exportFile(String scholarship_id,HttpServletRequest request){
        Scholarship scholarship = scholarshipService.getScholarship(scholarship_id);
        List<Apply> applyList = applyService.getApplyListByState(scholarship_id, "已通过");
        List<Student> studentList = new ArrayList<>();
        List<Grade> gradeList = new ArrayList<>();
        for (Apply apply : applyList) {
            Student student = studentService.getStudent(apply.getStudent_id());
            studentList.add(student);
            Grade grade = gradeService.getGrade(apply.getStudent_id());
            gradeList.add(grade);
        }
        String[] strings = {"学号","姓名","年级","专业","班级","挂科数","智育成绩","智育排名","综合成绩","综合排名"};

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("sheet1");
        HSSFRow row = sheet.createRow(0);
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        HSSFCell cell;

        for(int i = 0; i < strings.length;i++){
            cell = row.createCell(i);
            cell.setCellValue(strings[i]);
            cell.setCellStyle(cellStyle);
        }

        for(int i = 0; i < studentList.size(); i++){
            row = sheet.createRow(i+1);
            row.createCell(0).setCellValue(studentList.get(i).getStudent_id());
            row.createCell(1).setCellValue(studentList.get(i).getStudent_name());
            row.createCell(2).setCellValue(studentList.get(i).getStudent_year());
            row.createCell(3).setCellValue(studentList.get(i).getMajor());
            row.createCell(4).setCellValue(studentList.get(i).getStudent_class());
            row.createCell(5).setCellValue(gradeList.get(i).getFail_number());
            row.createCell(6).setCellValue(gradeList.get(i).getIntellect_score());
            row.createCell(7).setCellValue(gradeList.get(i).getIntellect_ranking());
            row.createCell(8).setCellValue(gradeList.get(i).getTotal_score());
            row.createCell(9).setCellValue(gradeList.get(i).getTotal_ranking());
        }

        String filePath = request.getSession().getServletContext().getRealPath("/")+ "uploadFiles" + "\\" + "奖学金初审名单表";

        Files files = new Files();
        Date date = new Date();
        String file_id = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(date);
        String file_name = scholarship.getScholarship_name() + "初审名单表.xls";
        String file_path = filePath + "\\" + file_name;


        files.setFile_id(file_id);
        files.setFile_name(file_name);
        files.setFile_path(file_path);

        try{
            File file = new File(filePath,file_name);
            if(!file.getParentFile().exists()){
                file.getParentFile().mkdirs();
            }
            FileOutputStream outputStream = FileUtils.openOutputStream(file);
            workbook.write(outputStream);
            outputStream.close();
            filesService.setFiles(files);

        }catch (Exception e){
            throw new RuntimeException(e);
        }

        return file_id;
    }

}
