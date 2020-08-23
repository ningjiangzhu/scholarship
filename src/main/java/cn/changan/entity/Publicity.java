package cn.changan.entity;

import java.util.Date;

public class Publicity {
    private String publicity_id;
    private String scholarship_id;
    private Date start_time;
    private Date end_time;

    public String getPublicity_id() {
        return publicity_id;
    }

    public void setPublicity_id(String publicity_id) {
        this.publicity_id = publicity_id;
    }

    public String getScholarship_id() {
        return scholarship_id;
    }

    public void setScholarship_id(String scholarship_id) {
        this.scholarship_id = scholarship_id;
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
}
