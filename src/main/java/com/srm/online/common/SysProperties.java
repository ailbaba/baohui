package com.srm.online.common;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public enum SysProperties {
	INSTANCE;
	
	private SysProperties(){
		
	}
	
	public Properties getSysProperties(){
		InputStream propertyIn = getClass().getClassLoader().getResourceAsStream("sysconfig.properties");
		Properties properties = null;
		try {
			properties = new Properties();
			properties.load(propertyIn);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties;
	}
}
