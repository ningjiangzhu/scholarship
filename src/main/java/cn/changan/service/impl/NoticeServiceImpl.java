package cn.changan.service.impl;

import cn.changan.dao.NoticeMapper;
import cn.changan.entity.Notice;
import cn.changan.service.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Resource
    private NoticeMapper noticeMapper;

    @Override
    public void setNotice(Notice notice) {
        noticeMapper.insertNotice(notice);
    }

    @Override
    public int getNoticeCount() {
        return noticeMapper.selectNoticeCount();
    }

    @Override
    public Notice getNotice(String notice_id) {
        return noticeMapper.selectNotice(notice_id);
    }

    @Override
    public List<Notice> getNoticeList(int currentPage, int pageSize) {
        return noticeMapper.selectNoticeList(currentPage,pageSize);
    }
}
