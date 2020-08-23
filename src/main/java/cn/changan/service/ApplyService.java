package cn.changan.service;

import cn.changan.entity.Apply;

import java.util.List;

public interface ApplyService {

    void setApply(Apply apply);
    void updateApply(Apply apply);
    void deleteApply(String apply_id);
    Apply getApply(String apply_id);
    List<Apply> getApplyListByStudentId(String student_id);
    List<Apply> getApplyListByState(String scholarship_id,String apply_state);

}
