package com.srm.online.common;

import java.util.List;
import java.util.Map;

public class ErpFunctionReturnVO implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	private Map<String,Object> simpleMap;
	
	private Map<String,Map<String, Object>> structMap;
	
	private Map<String,List<Map<String, Object>>> tablesMap;
	
	private String runtimeException;
	
	private String type="sap";
	
	public Map<String, Object> getSimpleMap() {
		return simpleMap;
	}

	public void setSimpleMap(Map<String, Object> simpleMap) {
		this.simpleMap = simpleMap;
	}

	public Map<String, Map<String, Object>> getStructMap() {
		return structMap;
	}

	public void setStructMap(Map<String, Map<String, Object>> structMap) {
		this.structMap = structMap;
	}

	public Map<String, List<Map<String, Object>>> getTablesMap() {
		return tablesMap;
	}

	public void setTablesMap(Map<String, List<Map<String, Object>>> tablesMap) {
		this.tablesMap = tablesMap;
	}

	public String getRuntimeException() {
		return runtimeException;
	}

	public void setRuntimeException(String runtimeException) {
		this.runtimeException = runtimeException;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
