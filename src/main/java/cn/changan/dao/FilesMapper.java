package cn.changan.dao;

import cn.changan.entity.Files;

public interface FilesMapper {
    int insertFiles(Files files);
    Files selectFiles(String file_id);
}
