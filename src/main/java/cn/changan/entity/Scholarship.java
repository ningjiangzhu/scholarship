package cn.changan.entity;

import java.util.Date;

public class Scholarship {
    private String scholarship_id;
    private String scholarship_name;
    private String scholarship_type;
    private String scholarship_money;
    private String scholarship_quota;
    private String scholarship_year;
    private Date start_time;
    private Date end_time;
    private String creation_unit;
    private String funding_source;
    private String basic_requirement;
    private String scholarship_file;

    public String getScholarship_id() {
        return scholarship_id;
    }

    public void setScholarship_id(String scholarship_id) {
        this.scholarship_id = scholarship_id;
    }

    public String getScholarship_name() {
        return scholarship_name;
    }

    public void setScholarship_name(String scholarship_name) {
        this.scholarship_name = scholarship_name;
    }

    public String getScholarship_type() {
        return scholarship_type;
    }

    public void setScholarship_type(String scholarship_type) {
        this.scholarship_type = scholarship_type;
    }

    public String getScholarship_money() {
        return scholarship_money;
    }

    public void setScholarship_money(String scholarship_money) {
        this.scholarship_money = scholarship_money;
    }

    public String getScholarship_quota() {
        return scholarship_quota;
    }

    public void setScholarship_quota(String scholarship_quota) {
        this.scholarship_quota = scholarship_quota;
    }

    public String getScholarship_year() {
        return scholarship_year;
    }

    public void setScholarship_year(String scholarship_year) {
        this.scholarship_year = scholarship_year;
    }

    public Date getStart_time() {
        return start_time;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public String getCreation_unit() {
        return creation_unit;
    }

    public void setCreation_unit(String creation_unit) {
        this.creation_unit = creation_unit;
    }

    public String getFunding_source() {
        return funding_source;
    }

    public void setFunding_source(String funding_source) {
        this.funding_source = funding_source;
    }

    public String getBasic_requirement() {
        return basic_requirement;
    }

    public void setBasic_requirement(String basic_requirement) {
        this.basic_requirement = basic_requirement;
    }

    public String getScholarship_file() {
        return scholarship_file;
    }

    public void setScholarship_file(String scholarship_file) {
        this.scholarship_file = scholarship_file;
    }
}
