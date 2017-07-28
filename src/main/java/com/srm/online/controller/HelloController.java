package com.srm.online.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HelloController {

    @RequestMapping("/")
    @ResponseBody /*添加该注解, 必然返回字符串*/
    public String toIndex(){
        return "<h1 align='center' style='color:green'>醉后不知天在水,满船清梦压星河.</h1>";
    }

    @RequestMapping("/hello")
    public ModelAndView toHello(){
        ModelAndView view = new ModelAndView();
        view.setViewName("hello");
        System.err.println("访问了hello.jsp页面.");
        System.err.println("哈哈.");
        System.err.println("呵呵.");
        return view;
    }

    @RequestMapping("/x")
    public String x(){
        //- 不添加注解 @ResponseBody，返回String时，会寻找该名称的页面
        return "hello";
    }

}
