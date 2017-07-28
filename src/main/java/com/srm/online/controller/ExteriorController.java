package com.srm.online.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.srm.online.common.ELSConstant;
import com.srm.online.common.ELSLogger;
import com.srm.online.service.impl.FacadeServiceImpl;

@Controller
public class ExteriorController {
	
	@Autowired
	private FacadeServiceImpl fs;
	
	@ResponseBody
	@RequestMapping(value = "/exterior/writeLog",method=RequestMethod.POST,produces="text/html;charset=UTF-8") 
	public String processReport(@RequestParam(value="returnCode") String returnCode,@RequestParam(value="message") String message){
		ELSLogger.info(getClass(), " writeLog :"+returnCode+" message:"+message);
//		fs.getCallErpServiceImpl().writeSrmLog(returnCode, message);
		return ELSConstant.MSM_RETURN_SUCCESS_CODE;
	}

}
