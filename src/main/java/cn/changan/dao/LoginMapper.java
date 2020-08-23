package cn.changan.dao;

import cn.changan.entity.Login;

public interface LoginMapper {
    Login selectLogin(String login_id);
    int deleteLogin(String login_id);
    int insertLogin(Login login);
    int updateLogin(Login login);
}
