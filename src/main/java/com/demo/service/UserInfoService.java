package com.demo.service;

import java.util.List;
import com.demo.bean.UserInfo;


public interface UserInfoService {

	public UserInfo getUserInfoByAccount(String name);

	public List<UserInfo> findAll();

	public void addUserInfo(UserInfo user);

	public boolean doLogin(UserInfo user);

	public List<UserInfo> findUserInfoListByAccountAndName(String account, String name);

	public void updateUserInfo(UserInfo user);

	public void deleteUserInfoByAccount(String deleteAccount);
}
