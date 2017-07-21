package com.itmuch.cloud.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.itmuch.cloud.feign.UserFeignClient;
import com.itmuch.cloud.model.User;
import com.itmuch.cloud.service.UserService;
import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;

@RestController
@RequestMapping(value = "/user", produces = "application/json; charset=utf-8")
public class UserController {

	@Autowired
	private EurekaClient eurekaClient;

	@Autowired
	private DiscoveryClient discoveryClient;

	@Autowired
	private UserService userService;
	
    @Autowired
    private LoadBalancerClient loadBalancerClient;
    
    @Autowired
    private RestTemplate restTemplate;
    
    @Autowired
    private UserFeignClient userFeignClient;

    
	@GetMapping("/eureka-instance")
	public String serviceUrl() {
		InstanceInfo instance = this.eurekaClient.getNextServerFromEureka("MICROSERVICE-PROVIDER-USER", false);
		return instance.getHomePageUrl();
	}

	@GetMapping("/instance-info")
	public ServiceInstance showInfo() {
		ServiceInstance localServiceInstance = this.discoveryClient.getLocalServiceInstance();
		return localServiceInstance;
	}

	@RequestMapping("/list")
	public List<User> list() {
		List<User> userList = userService.findAllUser();
		return userList;
	}

	@RequestMapping("/add")
	public String add(ModelMap map) {
		try {
			User user = new User();
			user.setUsername("张三");
			user.setEmail("123456789@qq.com");
			user.setCreateTime(new Date());
			int count = userService.addUser(user);
			return "新增" + count + "成功!";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "新增失败!";
	}

	@GetMapping("/delete/{id}")
	public String delete(@PathVariable Integer id) {
		try {
			int count = userService.deleteUser(id);
			return "删除" + count + "成功!";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "删除失败!";
	}

	@RequestMapping("update")
	public String update(ModelMap map) {
		try {
			User user = new User();
			user.setId(3);
			user.setUsername("张三2");
			user.setCreateTime(new Date());
			int count = userService.updateUser(user);
			return "修改" + count + "成功!";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "修改失败!";
	}
	
	@GetMapping("/feign")
    public Iterable<User> feignUser() {
		return userFeignClient.feignUser();
    }

}
