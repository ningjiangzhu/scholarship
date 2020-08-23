package cn.changan.entity;

import java.util.Date;

public class Apply {
    private String apply_id;
    private String student_id;
    private String scholarship_id;
    private Date apply_time;
    private String apply_reason;
    private String apply_form;
    private String school_report;
    private String award_certificate;
    private String apply_state;
    private Date check_time;
    private String fail_reason;
    private Double total_score;

    public String getApply_id() {
        return apply_id;
    }

    public void setApply_id(String apply_id) {
        this.apply_id = apply_id;
    }

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public String getScholarship_id() {
        return scholarship_id;
    }

    public void setScholarship_id(String scholarship_id) {
        this.scholarship_id = scholarship_id;
    }

    public Date getApply_time() {
        return apply_time;
    }

    public void setApply_time(Date apply_time) {
        this.apply_time = apply_time;
    }

    public String getApply_reason() {
        return apply_reason;
    }

    public void setApply_reason(String apply_reason) {
        this.apply_reason = apply_reason;
    }

    public String getApply_form() {
        return apply_form;
    }

    public void setApply_form(String apply_form) {
        this.apply_form = apply_form;
    }

    public String getSchool_report() {
        return school_report;
    }

    public void setSchool_report(String school_report) {
        this.school_report = school_report;
    }

    public String getAward_certificate() {
        return award_certificate;
    }

    public void setAward_certificate(String award_certificate) {
        this.award_certificate = award_certificate;
    }

    public String getApply_state() {
        return apply_state;
    }

    public void setApply_state(String apply_state) {
        this.apply_state = apply_state;
    }

    public Date getCheck_time() {
        return check_time;
    }

    public void setCheck_time(Date check_time) {
        this.check_time = check_time;
    }

    public String getFail_reason() {
        return fail_reason;
    }

    public void setFail_reason(String fail_reason) {
        this.fail_reason = fail_reason;
    }

    public Double getTotal_score() {
        return total_score;
    }

    public void setTotal_score(Double total_score) {
        this.total_score = total_score;
    }
}
