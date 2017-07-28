package com.srm.online.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.srm.online.common.ELSConstant;
import com.srm.online.com.itmuch.cloud.util.ElsUtil;
import com.srm.online.model.ElsJob;
import com.srm.online.model.ElsJobInfo;
import com.srm.online.model.Page;
import com.srm.online.service.impl.JobsServiceImpl;
import com.srm.online.service.impl.QuartzServiceImpl;

@Controller 
public class JobsController {
	
	private final static Logger logger = LoggerFactory.getLogger(LoginController.class);
			
	@Autowired
	private JobsServiceImpl jobsServiceImpl;
	
	@Autowired
	private QuartzServiceImpl quartzServiceImpl;

	@RequestMapping("/getJobsInfo") 
	public ModelAndView getJobs(){
		logger.info("getJobsInfo  getJobs start");
		List<ElsJobInfo> list = null;
//				jobsServiceImpl.findElsJobsInfo();
		return new ModelAndView("/job/list","list", list);
	}
	
	@RequestMapping("/addJobsInfo") 
	public ModelAndView addJobsInfo(){
		List<ElsJob> jobsList = quartzServiceImpl.findJobs();
		return new ModelAndView("/job/add","jobsList",jobsList);
	}
	
	@RequestMapping("/editJobsInfo") 
	public ModelAndView editJobsInfo(@RequestParam(value="id") int id){
		ElsJobInfo elsJobInfo = null;
//				jobsServiceImpl.findElsJobsInfoById(id);
		List<ElsJob> jobsList = quartzServiceImpl.findJobs();
		return new ModelAndView("/job/edit","elsJobInfo",elsJobInfo).addObject("jobsList", jobsList);
	}
	
	@ResponseBody
	@RequestMapping("/getJobsInfoData") 
	public String getJobsInfoData(@RequestParam(value="currentPage") int currentPage){
		logger.info(" getJobsInfoData start");
		List<ElsJobInfo> listAll = null;
//		jobsServiceImpl.findElsJobsInfo();
		Page<ElsJobInfo> page = new Page<ElsJobInfo>();
		page.paging(currentPage, ELSConstant.pageSize, listAll.size());
		List<ElsJobInfo> list = null;
//		jobsServiceImpl.findElsJobsInfoPage(page);
		page.setList(list);
		Gson gson = new Gson();
		gson.toJson(page);
		return gson.toJson(page);
	}
	
	@ResponseBody
	@RequestMapping("/registerJobsInfo") 
	public String registerJobsInfo(@RequestParam(value="data")  String data){
		logger.info(" registerJobsInfo start param:"+data);
		Gson gson = new Gson();
		ElsJobInfo jobInfo = gson.fromJson(data, ElsJobInfo.class);
		jobInfo.setModifyDate(ElsUtil.Now());
//		jobsServiceImpl.registerJobsInfo(jobInfo);
		return ELSConstant.SUCCESS;
	}
	
	
	@ResponseBody
	@RequestMapping("/updateJobsInfo") 
	public String updateJobsInfo(@RequestParam(value="data")  String data){
		logger.info(" updateJobsInfo start param:"+data);
		Gson gson = new Gson();
		ElsJobInfo elsJobInfo = gson.fromJson(data, ElsJobInfo.class);
//		jobsServiceImpl.updateElsJobInfo(elsJobInfo);
		return ELSConstant.SUCCESS;
	}
	
	@ResponseBody
	@RequestMapping("/deleteJobsInfo") 
	public String deleteJobsInfo(@RequestParam(value="id")  int id){
		logger.info(" deleteJobsInfo start param:"+id);
		jobsServiceImpl.deleteJobsInfo(id);
		return ELSConstant.SUCCESS;
	}
	
	@ResponseBody
	@RequestMapping("/pauseJobsInfo") 
	public String pauseJobsInfo(@RequestParam(value="id")  int id){
		logger.info(" pauseJobsInfo start param:"+id);
		ElsJobInfo elsJobInfo = null;
//		jobsServiceImpl.findElsJobsInfoById(id);
		elsJobInfo.setStatus("0");
//		jobsServiceImpl.updateElsJobInfo(elsJobInfo);
		return ELSConstant.SUCCESS;
	}
	
	@ResponseBody
	@RequestMapping("/playJobsInfo") 
	public String playJobsInfo(@RequestParam(value="id")  int id){
		logger.info(" pauseJobsInfo start param:"+id);
		ElsJobInfo elsJobInfo = null;
//		jobsServiceImpl.findElsJobsInfoById(id);
		elsJobInfo.setStatus("1");
//		jobsServiceImpl.updateElsJobInfo(elsJobInfo);
		return ELSConstant.SUCCESS;
	}
	
	@RequestMapping("/getCPU") 
	public ModelAndView getCPU(){
		return new ModelAndView("/job/cpu");
	}
	
	@RequestMapping("/getCPU1") 
	public ModelAndView getCPU1(){
		return new ModelAndView("/job/cpu1");
	}
	
	@RequestMapping("/getCPU2") 
	public ModelAndView getCPU2(){
		return new ModelAndView("/job/cpu2");
	}
	
	@ResponseBody
	@RequestMapping("/getCPUData") 
	public String getCPUData(){
//		Sigar sigar = new Sigar();
		Map<String, Object> cpuInfo = new HashMap<String, Object>();
		Gson gson = new Gson();
		try {
//			CpuPerc perc = sigar.getCpuPerc();
//			cpuInfo.put("y",  perc.getCombined());
//			cpuInfo.put("x", new Date().getTime());
//			gson.toJson(cpuInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return gson.toJson(cpuInfo);
	}
	
}
