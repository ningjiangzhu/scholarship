package cn.changan.service;

import cn.changan.entity.Publicity;

import java.util.List;

public interface PublicityService {
    void setPublicity(Publicity publicity);
    List<Publicity> getPublicityListByScholarshipId(String scholarship_id);
    List<Publicity> getPublicityListByTime();
}
