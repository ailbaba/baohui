package com.srm.online.service;

import java.util.List;

import com.srm.online.model.User;

public interface UserService {

	List<User> findAllUser();

	int addUser(User user);

	int deleteUser(Integer id);

	int updateUser(User user);
	
	User login(User user);

	List<User> selectUser(User user);

	int selectCount(User remoteServiceVO);

	int insertSelective(User remoteServiceVO);

	int updateByPrimaryKeySelective(User remoteServiceVO);
	
	User selectByPrimaryKey(Integer id);

	int deleteByPrimaryKey(Integer id);

}
