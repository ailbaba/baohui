package com.itmuch.cloud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itmuch.cloud.dao.UserMapper;
import com.itmuch.cloud.model.User;
import com.itmuch.cloud.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public List<User> findAllUser() {
		return userMapper.findAllUser();
	}

	@Override
	public int addUser(User user) {
		return userMapper.addUser(user);
	}

	@Override
	public int deleteUser(Integer id) {
		return userMapper.deleteUser(id);
	}
	
	@Override
	public int updateUser(User user) {
		return userMapper.updateUser(user);
	}


}
