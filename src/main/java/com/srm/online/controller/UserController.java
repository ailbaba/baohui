package com.srm.online.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.srm.online.feign.UserFeignClient;
import com.srm.online.model.Page;
import com.srm.online.model.User;
import com.srm.online.service.UserService;

@RestController
@RequestMapping(value = "/user", produces = "application/json; charset=utf-8")
public class UserController extends BaseController{

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


	@RequestMapping("/forwarderUser") 
	public ModelAndView forwarderUser(){
		return new ModelAndView("/user/list");
	}
	
	@RequestMapping("/addUser") 
	public ModelAndView addUser(){
		return new ModelAndView("/user/add");
	}
	
	@RequestMapping("/editUser") 
	public ModelAndView editUser(@RequestParam(value="id") int id){
		User user = fs.getUserServiceImpl().selectByPrimaryKey(id);
		return new ModelAndView("/user/edit","user",user);
	}
	
	@RequestMapping("/editPassword") 
	public ModelAndView editPassword(@RequestParam(value="id") int id){
		User user = fs.getUserServiceImpl().selectByPrimaryKey(id);
		return new ModelAndView("/user/editPassword","user",user);
	}
	
	@ResponseBody
	@RequestMapping("/selectUser") 
	public String selectUser(User user){
		Page<User> page = new Page<User>();
		int count = fs.getUserServiceImpl().selectCount(user);
		if(count==0){
			return SUCCESS;
		}
		int currentPage = user.getCurrentPage();
		page.paging(currentPage, PAGE_SIZE, count);
		List<User> list = fs.getUserServiceImpl().selectUser(user);
		page.setList(list);
		return GsonUtil.GsonString(page);
	}
	
	@ResponseBody
	@RequestMapping("/selectPassowrd") 
	public String selectPassowrd(User user){
		user.setPassword(EncryptUtil.md5(user.getPassword().trim()));
		int count = fs.getUserServiceImpl().selectCount(user);
		if(count==0){
			return ERROR;
		}
		return SUCCESS;
	}
	
	@ResponseBody
	@RequestMapping(value = "/registerUser",method = RequestMethod.POST)
	public String registerUser(User user){
		if(fs.getUserServiceImpl().selectCount(user)>0){
			return REPEAT;
		}
		user.setPassword(EncryptUtil.md5(user.getPassword().trim()));
		user.setCreateDate(ElsUtil.Now());
		user.setCreateUser(this.getLoginName());
		fs.getUserServiceImpl().insertSelective(user);
		return SUCCESS;
	}
	
	@ResponseBody
	@RequestMapping("/updateUser") 
	public String updateUser(User user){
		String password = user.getPassword();
		if(password!=null&&password!=""){
			user.setPassword(EncryptUtil.md5(user.getPassword().trim()));
		}
		user.setLastUpdateDate(ElsUtil.Now());
		user.setLastUpdateUser(this.getLoginName());
		fs.getUserServiceImpl().updateByPrimaryKeySelective(user);
		return SUCCESS;
	}
	
	@ResponseBody
	@RequestMapping("/delUser") 
	public String delUser(@RequestParam(value="id")  int id){
		fs.getUserServiceImpl().deleteByPrimaryKey(id);
		return SUCCESS;
	}
}
