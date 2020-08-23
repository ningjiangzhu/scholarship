package cn.changan.dao;

import cn.changan.entity.Publicity;

import java.util.Date;
import java.util.List;

public interface PublicityMapper {

    void insertPublicity(Publicity publicity);
    List<Publicity> selectPublicityListByScholarshipId(String scholarship_id);
    List<Publicity> selectPublicityListByTime(Date nowTime);
    int deletePublicityByScholarshipId(String scholarship_id);
}
