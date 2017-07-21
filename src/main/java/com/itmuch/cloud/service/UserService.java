package com.itmuch.cloud.service;

import java.util.List;

import com.itmuch.cloud.model.User;

public interface UserService {

	List<User> findAllUser();

	int addUser(User user);

	int deleteUser(Integer id);

	int updateUser(User user);

}
