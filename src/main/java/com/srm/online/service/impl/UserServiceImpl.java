package com.srm.online.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.srm.online.com.itmuch.cloud.util.EncryptUtil;
import com.srm.online.dao.UserMapper;
import com.srm.online.model.User;
import com.srm.online.service.UserService;

@Service
public class UserServiceImpl extends BaseServiceImpl implements UserService {

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
	@Override
	public User login(User user) {
		user.setPassword(EncryptUtil.md5(user.getPassword().trim()));
		return userMapper.getUser(user);
	}

	@Override
	public List<User> selectUser(User user) {
		return userMapper.selectUser(user);
	}

	@Override
	public int selectCount(User user) {
		return userMapper.selectCount(user);
	}

	@Override
	public int insertSelective(User user) {
		return userMapper.insertSelective(user);
	}

	@Override
	public int updateByPrimaryKeySelective(User user) {
		return userMapper.updateByPrimaryKeySelective(user);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		return userMapper.deleteByPrimaryKey(id);
	}

	@Override
	public User selectByPrimaryKey(Integer id) {
		 return userMapper.selectByPrimaryKey(id);
	}

}
