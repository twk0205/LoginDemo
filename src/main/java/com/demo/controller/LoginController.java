package com.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.demo.bean.UserInfo;
import com.demo.service.UserInfoService;

@Controller
@EnableAutoConfiguration
@ComponentScan("com.demo")
public class LoginController {
	
	@Autowired
	private UserInfoService userInfoService;
	
	public static void main(String[] args) {
        SpringApplication.run(LoginController.class, args);
    }

	/**
	 * 
	 * @return
	 */
	@RequestMapping("/")
	public ModelAndView login() {
		return new ModelAndView("login");
	}

	/**
	 * do login
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/dologin", method = RequestMethod.POST)
	public ModelAndView doLogin(@ModelAttribute UserInfo user, RedirectAttributes redirectAttributes) {
		boolean loginResult = userInfoService.doLogin(user);
		if(loginResult) {
			System.out.println("======login by user name : " + user.getAccount() + " success=====");
			redirectAttributes.addFlashAttribute("loginAccount", user.getAccount());
			return new ModelAndView("redirect:/userList");
		} else {
			ModelAndView result = new ModelAndView("login");
			result.addObject("account", user.getAccount());
			result.addObject("loginError", "true");
			return result;
		}
	}
	
	/**
	 * do register
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/doRegister", method = RequestMethod.POST)
	public ModelAndView doRegister(@ModelAttribute UserInfo user) {
		return new ModelAndView("user_create");
	}

}
