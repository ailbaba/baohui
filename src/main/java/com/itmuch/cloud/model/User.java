package com.itmuch.cloud.model;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class User {

	private Integer id;
	private String username;
	private String password;
	private String email;
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;// 创建时间.

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}
