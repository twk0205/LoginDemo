package com.demo.serviceImpl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.bean.UserInfo;
import com.demo.repository.UserInfoRepository;
import com.demo.service.UserInfoService;

@Service
public class UserInfoServiceImpl implements UserInfoService{
	
	@Autowired
	private UserInfoRepository userInfoRepository;

	/**
	 * 
	 */
	@Override
	public List<UserInfo> findAll() {
		return userInfoRepository.findAllByOrderByIdAsc();
	}
	
	/**
	 * 
	 */
	@Override
	public UserInfo getUserInfoByAccount(String account) {
		return userInfoRepository.getUserByAccount(account);
	}

	/**
	 * 
	 */
	@Override
	public void addUserInfo(UserInfo userInfo) {
		UserInfo newUser = new UserInfo(userInfo.getName(), userInfo.getPassword(), userInfo.getAccount());
		userInfoRepository.save(newUser);
	}

	@Override
	public boolean doLogin(UserInfo user) {
		boolean loginStatus = false;
		UserInfo userData = getUserInfoByAccount(user.getAccount());
		if(userData!=null && StringUtils.equals(user.getPassword().toString(), userData.getPassword().toString())) {
			loginStatus = true;
		}
		return loginStatus;
	}

	@Override
	public List<UserInfo> findUserInfoListByAccountAndName(String account, String name) {
		if(StringUtils.isBlank(account) && StringUtils.isBlank(name)) {
			return userInfoRepository.findAll();
		} else {
			return userInfoRepository.findUserInfoListByAccountAndName(account, name);
		}
	}

	@Override
	public void updateUserInfo(UserInfo user) {
		UserInfo oldUser = userInfoRepository.getUserByAccount(user.getAccount());
		oldUser.setName(user.getName());
		oldUser.setPassword(user.getPassword());
		userInfoRepository.save(oldUser);
	}

	@Override
	public void deleteUserInfoByAccount(String deleteAccount) {
		if(StringUtils.isNotBlank(deleteAccount)) {
			UserInfo oldUser = userInfoRepository.getUserByAccount(deleteAccount);
			userInfoRepository.delete(oldUser);
		}
	}

}
