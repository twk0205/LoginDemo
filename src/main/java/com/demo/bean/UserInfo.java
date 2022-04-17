package com.demo.bean;

import javax.persistence.*;

@Entity
@Table(name = "user_info")
public class UserInfo {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	//@GeneratedValue
	private Long Id;
	
	@Column(name="name", length=255)
	private String name;
	@Column(name="password", length=255)
	private String password;
	@Column(name="account", length=255)
	private String account;
	
	public UserInfo(String name, String password, String account) {
		this.name = name;
		this.password = password;
		this.account = account;
	}
	
	public UserInfo() {

	}
	
	public Long getId() {
		return Id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
}
