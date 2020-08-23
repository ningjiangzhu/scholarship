package cn.changan.service.impl;

import cn.changan.dao.LoginMapper;
import cn.changan.entity.Login;
import cn.changan.service.LoginService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class LoginServiceImpl implements LoginService {

    @Resource
    private LoginMapper loginMapper;

    @Override
    public Login getLogin(String login_id) {
        return loginMapper.selectLogin(login_id);
    }

    @Override
    public void updateLogin(Login login) {
        loginMapper.updateLogin(login);
    }
}
