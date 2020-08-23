package cn.changan.service.impl;

import cn.changan.dao.ApplyMapper;
import cn.changan.entity.Apply;
import cn.changan.service.ApplyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.List;

@Service
public class ApplyServiceImpl implements ApplyService{


    @Resource
    private ApplyMapper applyMapper;

    @Override
    public void setApply(Apply apply) {
        applyMapper.insertApply(apply);
    }

    @Override
    @Transactional
    public void updateApply(Apply apply) {
        applyMapper.deleteApply(apply.getApply_id());
        applyMapper.insertApply(apply);
    }

    @Override
    public void deleteApply(String apply_id) {
        applyMapper.deleteApply(apply_id);
    }

    @Override
    public Apply getApply(String apply_id) {
        return applyMapper.selectApply(apply_id);
    }

    @Override
    public List<Apply> getApplyListByStudentId(String student_id) {
        return applyMapper.selectApplyListByStudentId(student_id);
    }

    @Override
    public List<Apply> getApplyListByState(String scholarship_id,String apply_state) {
        return applyMapper.selectApplyListByState(scholarship_id,apply_state);
    }
}
