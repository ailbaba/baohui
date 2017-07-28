package com.srm.online.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.srm.online.common.ELSConstant;
import com.srm.online.model.ElsJob;
import com.srm.online.model.User;
import com.srm.online.service.impl.QuartzServiceImpl;
import com.srm.online.service.impl.UserServiceImpl;

@Controller  
public class LoginController {
	
	private final static Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private UserServiceImpl userServiceImpl;
	
	@Autowired
	private QuartzServiceImpl quartzServiceImpl;
	
	@RequestMapping(value = "/login",method = RequestMethod.POST)  
    public String login(HttpServletRequest request,HttpServletResponse response,ModelMap model,@ModelAttribute(value="user") User user,BindingResult result) throws Exception {  
		logger.info("login start-------");
         System.out.println("login " + user.getUsername());  
         if(result.hasErrors()){
        	 request.getRequestDispatcher("login.jsp").forward(request, response);
         }
         
        if(userServiceImpl.login(user)==null){
        	request.getRequestDispatcher("login.jsp").forward(request, response);
        }
         List<ElsJob> list = quartzServiceImpl.findJobs();
         model.addAttribute("list", list);
 		return "scheduler/main";
    }  
	
	@RequestMapping(value = "/welcome")  
	public String welcome(HttpServletRequest request,HttpServletResponse response,ModelMap model,@ModelAttribute(value="user") User user,BindingResult result) throws Exception {  
		logger.info("-------welcome-------"+user);
		 if(user.getLoginName() == null ||user.getPassword()==null){
			 //request.getRequestDispatcher("login.jsp").forward(request, response); 
			 return "login";
		 }
        if(userServiceImpl.login(user)==null){
        	request.setAttribute("error", "用户名密码错误！");
        	//request.getRequestDispatcher("login.jsp").forward(request, response);
        	 return "login";
        }
        request.getSession().setAttribute(ELSConstant.USER_CONTEXT, user);
		
		return "welcome";
	}  
	
	@RequestMapping(value = "/logout",method = RequestMethod.GET)  
	public String logout(HttpServletRequest request,HttpServletResponse response,ModelMap model,@ModelAttribute(value="user") User user,BindingResult result) throws Exception {  
		logger.info("-------logout-------");
		request.getSession().setAttribute("userName",null);
		//request.getRequestDispatcher("login.jsp").forward(request, response);
		return "login";
	 }  
	
}
