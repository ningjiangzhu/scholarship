package cn.changan.entity;

public class Grade {
    private String grade_id;
    private String fail_number;
    private double intellect_score;
    private double moral_score;
    private double art_score;
    private double total_score;
    private String intellect_ranking;
    private String total_ranking;
    private String grade_reason;
    private String intellect_file;
    private String moral_file;
    private String art_file;
    private String grade_state;

    public String getGrade_id() {
        return grade_id;
    }

    public void setGrade_id(String grade_id) {
        this.grade_id = grade_id;
    }

    public String getFail_number() {
        return fail_number;
    }

    public void setFail_number(String fail_number) {
        this.fail_number = fail_number;
    }

    public double getIntellect_score() {
        return intellect_score;
    }

    public void setIntellect_score(double intellect_score) {
        this.intellect_score = intellect_score;
    }

    public double getMoral_score() {
        return moral_score;
    }

    public void setMoral_score(double moral_score) {
        this.moral_score = moral_score;
    }

    public double getArt_score() {
        return art_score;
    }

    public void setArt_score(double art_score) {
        this.art_score = art_score;
    }

    public double getTotal_score() {
        return total_score;
    }

    public void setTotal_score(double total_score) {
        this.total_score = total_score;
    }

    public String getIntellect_ranking() {
        return intellect_ranking;
    }

    public void setIntellect_ranking(String intellect_ranking) {
        this.intellect_ranking = intellect_ranking;
    }

    public String getTotal_ranking() {
        return total_ranking;
    }

    public void setTotal_ranking(String total_ranking) {
        this.total_ranking = total_ranking;
    }

    public String getGrade_reason() {
        return grade_reason;
    }

    public void setGrade_reason(String grade_reason) {
        this.grade_reason = grade_reason;
    }

    public String getIntellect_file() {
        return intellect_file;
    }

    public void setIntellect_file(String intellect_file) {
        this.intellect_file = intellect_file;
    }

    public String getMoral_file() {
        return moral_file;
    }

    public void setMoral_file(String moral_file) {
        this.moral_file = moral_file;
    }

    public String getArt_file() {
        return art_file;
    }

    public void setArt_file(String art_file) {
        this.art_file = art_file;
    }

    public String getGrade_state() {
        return grade_state;
    }

    public void setGrade_state(String grade_state) {
        this.grade_state = grade_state;
    }
}
