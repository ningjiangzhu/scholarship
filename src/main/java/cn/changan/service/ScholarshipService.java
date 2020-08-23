package cn.changan.service;

import cn.changan.entity.Scholarship;

import java.util.List;

public interface ScholarshipService {

    void setScholarship(Scholarship scholarship);
    void updateScholarship(Scholarship scholarship);
    void deleteScholarship(String scholarship_id);
    Scholarship getScholarship(String scholarship_id);
    List<Scholarship> getScholarshipListByTime();
    List<Scholarship> getScholarshipListByTimeLike(String condition);
    List<Scholarship> getAllScholarship();
    List<Scholarship> getScholarshipListByLike(String condition);

}
