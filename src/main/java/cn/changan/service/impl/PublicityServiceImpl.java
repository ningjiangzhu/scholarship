package cn.changan.service.impl;

import cn.changan.dao.PublicityMapper;
import cn.changan.entity.Publicity;
import cn.changan.service.PublicityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class PublicityServiceImpl implements PublicityService{
    @Resource
    private PublicityMapper publicityMapper;

    @Override
    public void setPublicity(Publicity publicity) {
        publicityMapper.insertPublicity(publicity);
    }

    @Override
    public List<Publicity> getPublicityListByScholarshipId(String scholarship_id) {
        return publicityMapper.selectPublicityListByScholarshipId(scholarship_id);
    }

    @Override
    public List<Publicity> getPublicityListByTime() {
        Date nowTime = new Date();
        return publicityMapper.selectPublicityListByTime(nowTime);
    }
}
