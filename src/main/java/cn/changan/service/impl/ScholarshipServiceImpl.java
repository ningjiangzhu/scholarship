package cn.changan.service.impl;

import cn.changan.dao.ApplyMapper;
import cn.changan.dao.PublicityMapper;
import cn.changan.dao.ScholarshipMapper;
import cn.changan.entity.Scholarship;
import cn.changan.service.ScholarshipService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;

@Service
public class ScholarshipServiceImpl implements ScholarshipService{

    @Resource
    private ScholarshipMapper scholarshipMapper;

    @Resource
    private ApplyMapper applyMapper;

    @Resource
    private PublicityMapper publicityMapper;

    @Override
    public void setScholarship(Scholarship scholarship) {
        scholarshipMapper.insertScholarship(scholarship);
    }

    @Override
    @Transactional
    public void updateScholarship(Scholarship scholarship) {
        scholarshipMapper.deleteScholarship(scholarship.getScholarship_id());
        scholarshipMapper.insertScholarship(scholarship);
    }

    @Override
    public Scholarship getScholarship(String scholarship_id) {
        return scholarshipMapper.selectScholarship(scholarship_id);
    }

    @Override
    public List<Scholarship> getScholarshipListByTime() {
        Date nowTime = new Date();
        return scholarshipMapper.selectScholarshipListByTime(nowTime);
    }

    @Override
    public List<Scholarship> getScholarshipListByTimeLike(String condition) {
        Date nowTime = new Date();
        return scholarshipMapper.selectScholarshipListByTimeLike(nowTime,condition);
    }

    @Override
    public List<Scholarship> getAllScholarship() {
        return scholarshipMapper.selectAllScholarship();
    }

    @Override
    public List<Scholarship> getScholarshipListByLike(String condition) {
        return scholarshipMapper.selectScholarshipListByLike(condition);
    }

    @Override
    @Transactional
    public void deleteScholarship(String scholarship_id) {
        scholarshipMapper.deleteScholarship(scholarship_id);
        applyMapper.deleteApplyByScholarshipId(scholarship_id);
        publicityMapper.deletePublicityByScholarshipId(scholarship_id);
    }
}
