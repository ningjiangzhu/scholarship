package cn.changan.dao;

import cn.changan.entity.Notice;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NoticeMapper {
    int insertNotice(Notice notice);
    int selectNoticeCount ();
    Notice selectNotice(String notice_id);
    List<Notice> selectNoticeList(@Param("currentPage") int currentPage, @Param("pageSize") int pageSize);
}
