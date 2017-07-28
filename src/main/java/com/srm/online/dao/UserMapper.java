package com.srm.online.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.srm.online.model.User;


public interface UserMapper {
	 int deleteByPrimaryKey(Integer id);

	    int insert(User record);

	    int insertSelective(User record);

	    User selectByPrimaryKey(Integer id);

	    int updateByPrimaryKeySelective(User record);

	    int updateByPrimaryKey(User record);
	    
	    User getUser(User user);
	    
	    List<User> selectUser(User user);
	    
		int selectCount(User user);
	List<User> findAllUser();

	int addUser(User user);

	int deleteUser(@Param(value = "id") Integer id);
	
	int updateUser(User user);
	

}
