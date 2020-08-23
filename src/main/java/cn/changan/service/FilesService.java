package cn.changan.service;

import cn.changan.entity.Files;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface FilesService {
    void setFiles(Files files);
    Files getFiles(String file_id);
}
