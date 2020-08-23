package cn.changan.entity;

import java.util.Date;

public class Notice {
    private String notice_id;
    private String notice_name;
    private Date notice_time;
    private String notice_people;
    private String notice_content;
    private String notice_file;

    public String getNotice_id() {
        return notice_id;
    }

    public void setNotice_id(String notice_id) {
        this.notice_id = notice_id;
    }

    public String getNotice_name() {
        return notice_name;
    }

    public void setNotice_name(String notice_name) {
        this.notice_name = notice_name;
    }

    public Date getNotice_time() {
        return notice_time;
    }

    public void setNotice_time(Date notice_time) {
        this.notice_time = notice_time;
    }

    public String getNotice_people() {
        return notice_people;
    }

    public void setNotice_people(String notice_people) {
        this.notice_people = notice_people;
    }

    public String getNotice_content() {
        return notice_content;
    }

    public void setNotice_content(String notice_content) {
        this.notice_content = notice_content;
    }

    public String getNotice_file() {
        return notice_file;
    }

    public void setNotice_file(String notice_file) {
        this.notice_file = notice_file;
    }
}
