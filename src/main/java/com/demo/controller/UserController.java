package com.demo.controller;

import java.util.List;

import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.demo.bean.UserInfo;
import com.demo.service.UserInfoService;
import com.google.gson.Gson;

@Controller
public class UserController {
	
	@Autowired
	private UserInfoService userInfoService;
	
	/**
	 * 
	 * @param loginName
	 * @return
	 */
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public ModelAndView userList(@ModelAttribute("loginAccount") String loginAccount) {
		ModelAndView result = null;
		if(StringUtils.isNotBlank(loginAccount)) {
			result = new ModelAndView("user_list");
			List<UserInfo> userInfoList = userInfoService.findAll();
			result.addObject("loginAccount", loginAccount);
			result.addObject("userInfoList", new Gson().toJson(userInfoList));
		} else {
			result = new ModelAndView("login");
		}
		
		return result;
	}
	
	/**
	 * 
	 * @param user
	 * @return
	 */
	@PostMapping("/doSearch")
	public ResponseEntity<?> doSearch(@Valid @RequestBody UserInfo user) {
		List<UserInfo> result = userInfoService.findUserInfoListByAccountAndName(user.getAccount(), user.getName());
		return ResponseEntity.ok(result);
	}

	/**
	 * do register
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/create_user", method = RequestMethod.POST)
	public ModelAndView doCreateUser(@ModelAttribute UserInfo user) {
		ModelAndView result = new ModelAndView("login");
		UserInfo userInfo = userInfoService.getUserInfoByAccount(user.getAccount());
		String registerStatus = "true";
		
		if(userInfo!=null) {
			registerStatus = "false";
		} else {
			userInfoService.addUserInfo(user);
			System.out.println("======register new user name : " + user.getAccount() + " success=====");
		}
		
		result.addObject("registerStatus", registerStatus);
		result.addObject("userAccount", user.getAccount());
		return result;
	}
	
	/**
	 * 
	 * @param editAccount
	 * @return
	 */
	@RequestMapping(value = "/edit_user", method = RequestMethod.POST)
	public ModelAndView doEditUser(@RequestParam("editAccount") String editAccount) {
		ModelAndView result = null;
		if(StringUtils.isNotBlank(editAccount)) {
			result = new ModelAndView("user_edit");
			UserInfo userInfo = userInfoService.getUserInfoByAccount(editAccount);
			result.addObject("userId", userInfo.getId());
			result.addObject("userAccount", userInfo.getAccount());
			result.addObject("userName", userInfo.getName());
			result.addObject("userPassword", userInfo.getPassword());
			//test123
		} else {
			result = new ModelAndView("login");
		}
		
		return result;
	}
	
	/**
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/update_user", method = RequestMethod.POST)
	public ModelAndView doUpdateUser(@ModelAttribute UserInfo user, RedirectAttributes redirectAttributes) {
		userInfoService.updateUserInfo(user);
		redirectAttributes.addFlashAttribute("loginAccount", user.getAccount());
		redirectAttributes.addFlashAttribute("updateStatus", "true");
		return new ModelAndView("redirect:/userList");
	}
	
	/**
	 * 
	 * @param deleteAccount
	 * @return
	 */
	@RequestMapping(value = "/delete_user", method = RequestMethod.POST)
	public ModelAndView dodeleteUser(@RequestParam("deleteAccount") String deleteAccount) {
		ModelAndView result = new ModelAndView("login");
		userInfoService.deleteUserInfoByAccount(deleteAccount);
		return result;
	}
}
