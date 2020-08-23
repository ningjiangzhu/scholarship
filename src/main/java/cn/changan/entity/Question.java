package cn.changan.entity;

import java.util.Date;

public class Question {
    private String question_id;
    private String question_name;
    private Date question_time;
    private String question_people;
    private String question_content;
    private Date answer_time;
    private String answer_people;
    private String answer_content;
    private String question_state;

    public String getQuestion_id() {
        return question_id;
    }

    public void setQuestion_id(String question_id) {
        this.question_id = question_id;
    }

    public String getQuestion_name() {
        return question_name;
    }

    public void setQuestion_name(String question_name) {
        this.question_name = question_name;
    }

    public Date getQuestion_time() {
        return question_time;
    }

    public void setQuestion_time(Date question_time) {
        this.question_time = question_time;
    }

    public String getQuestion_people() {
        return question_people;
    }

    public void setQuestion_people(String question_people) {
        this.question_people = question_people;
    }

    public String getQuestion_content() {
        return question_content;
    }

    public void setQuestion_content(String question_content) {
        this.question_content = question_content;
    }

    public Date getAnswer_time() {
        return answer_time;
    }

    public void setAnswer_time(Date answer_time) {
        this.answer_time = answer_time;
    }

    public String getAnswer_people() {
        return answer_people;
    }

    public void setAnswer_people(String answer_people) {
        this.answer_people = answer_people;
    }

    public String getAnswer_content() {
        return answer_content;
    }

    public void setAnswer_content(String answer_content) {
        this.answer_content = answer_content;
    }

    public String getQuestion_state() {
        return question_state;
    }

    public void setQuestion_state(String question_state) {
        this.question_state = question_state;
    }
}
