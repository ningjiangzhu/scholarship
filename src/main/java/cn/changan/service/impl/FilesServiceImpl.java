package cn.changan.service.impl;

import cn.changan.dao.FilesMapper;
import cn.changan.entity.Files;
import cn.changan.service.FilesService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service
public class FilesServiceImpl implements FilesService {

    @Resource
    private FilesMapper filesMapper;

    @Override
    public void setFiles(Files files) {
        filesMapper.insertFiles(files);
    }

    @Override
    public Files getFiles(String file_id) {
        return filesMapper.selectFiles(file_id);
    }
}
