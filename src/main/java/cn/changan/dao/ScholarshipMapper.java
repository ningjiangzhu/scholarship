package cn.changan.dao;

import cn.changan.entity.Scholarship;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ScholarshipMapper {

    int insertScholarship(Scholarship scholarship);
    int deleteScholarship(String scholarship_id);
    Scholarship selectScholarship(String scholarship_id);
    List<Scholarship> selectScholarshipListByTime(Date nowTime);
    List<Scholarship> selectScholarshipListByTimeLike(@Param("nowTime") Date nowTime,@Param("condition") String condition);
    List<Scholarship> selectAllScholarship();
    List<Scholarship> selectScholarshipListByLike(String condition);
}
