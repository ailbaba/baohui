package com.itmuch.cloud.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itmuch.cloud.model.User;


public interface UserMapper {

	List<User> findAllUser();

	int addUser(User user);

	int deleteUser(@Param(value = "id") Integer id);
	
	int updateUser(User user);
	

}
