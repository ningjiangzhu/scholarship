package cn.changan.service;

import cn.changan.entity.Login;

public interface LoginService {
    Login getLogin(String login_id);
    void updateLogin(Login login);
}
