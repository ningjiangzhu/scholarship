package cn.changan.dao;

import cn.changan.entity.Apply;
import com.sun.jersey.core.impl.provider.entity.XMLRootObjectProvider;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ApplyMapper {

    int insertApply(Apply apply);
    int deleteApply(String apply_id);
    Apply selectApply(String apply_id);
    List<Apply> selectApplyListByStudentId(String student_id);
    List<Apply> selectApplyListByState(@Param("scholarship_id") String scholarship_id,@Param("apply_state")String apply_state);
    int deleteApplyByScholarshipId(String scholarship_id);
    int deleteApplyByStudentId(String student_id);

}
