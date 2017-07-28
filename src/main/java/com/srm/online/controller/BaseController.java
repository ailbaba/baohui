package com.srm.online.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.srm.online.common.ELSConstant;
import com.srm.online.model.User;
import com.srm.online.service.impl.FacadeServiceImpl;



@Controller
public class BaseController {
	
	protected static final String ERROR_MSG_KEY = "errorMsg";
	
	protected static final String SUCCESS = "100";
	
	protected static final String ERROR = "-100";
	
	protected static final String  REPEAT = "101";
	
	protected static final int PAGE_SIZE = 5;
	
	@Autowired
	protected FacadeServiceImpl fs;
	
	
	//get session
	protected HttpSession getSession(HttpServletRequest request) {
		return  request.getSession();
	}

	// Get save session user object
	protected User getSessionUser(HttpServletRequest request) {
		return (User) request.getSession().getAttribute(ELSConstant.USER_CONTEXT);
	}
	// ②Set user object save session
	protected void setSessionUser(HttpServletRequest request, User user) {
		request.getSession().setAttribute(ELSConstant.USER_CONTEXT, user);
	}

	// Get local applet url (absolute path)
	public final String getAppbaseUrl(HttpServletRequest request, String url) {
		Assert.hasLength(url, "url不能为空");
		Assert.isTrue(url.startsWith("/"), "必须以/打头");
		return request.getContextPath() + url;
	}
	
	public  HttpSession getSession() { 
		HttpSession session = null; 
		try { 
		    session = getRequest().getSession(); 
		} catch (Exception e) {
			return null;
		} 
		return session; 
	} 

	public  HttpServletRequest getRequest() { 
		ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder .getRequestAttributes(); 
		return attrs.getRequest(); 
	} 
	
	public User getUser() {
		return (User)this.getSession().getAttribute(ELSConstant.USER_CONTEXT);
	}
	
	public String getLoginName(){
		return getUser().getLoginName();
	}

}