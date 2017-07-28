package com.srm.online.common;

import org.slf4j.LoggerFactory;

public class ELSLogger {
	
	public static void error( Class<?> cls,String msg){
		LoggerFactory.getLogger(cls).error(msg);
	}
	
	public static void info(Class<?> cls,String msg){
		LoggerFactory.getLogger(cls).info(msg);
	}
	
	public static void debug(Class<?> cls,String msg){
		LoggerFactory.getLogger(cls).debug(msg);
	}
}
	
