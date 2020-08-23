package cn.changan.service;

import cn.changan.entity.Notice;

import java.util.List;

public interface NoticeService {
    void setNotice(Notice notice);
    int getNoticeCount();
    Notice getNotice(String notice_id);
    List<Notice> getNoticeList(int currentPage, int pageSize);
}
