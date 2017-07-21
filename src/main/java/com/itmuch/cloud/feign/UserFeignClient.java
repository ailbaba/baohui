package com.itmuch.cloud.feign;

import java.util.List;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itmuch.cloud.model.User;

@FeignClient("microservice-provider-user")
public interface UserFeignClient {
	
	@RequestMapping(value = "/user/list", method = RequestMethod.GET)
	public List<User> feignUser();

}
