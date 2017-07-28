package com.srm.online.common;

public class ElsErpConstant {
	
	public enum ERP_CONN_TYPE{
		SAP("SAP"),HTTP("HTTP"),SOCKET("SOCKET");
		
		private String  value;
		
		ERP_CONN_TYPE(String value){
			this. value =  value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
	public enum FUNCTION_STATUS{
		ENABLE("1"),DISABLE("0");
		
		private String value;
		
		FUNCTION_STATUS(String value){
			this.value = value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
	public enum NEED_COMMIT{
		YES("Y"),NO("N");
		
		private String value;
		
		NEED_COMMIT(String value){
			this.value = value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
	public enum UK_STATU{
		TRUE("T"),FALSE("F");
		
		private String value;
		
		UK_STATU(String value){
			this.value = value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
	public enum PARAM_TYPE{
		SIMPLE("SIMPLE"),STRUCT("STRUCT"),TABLES("TABLES");
		
		private String value;
		
		PARAM_TYPE(String value){
			this.value = value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
	public enum DATA_TYPE{
		STRING("STRING"),DATE("DATE"),TIME("TIME"),DECIMAL("DECIMAL"),BINARY("BINARY"),BINARY_PART("BINARY_PART");
		
		private String value;
		
		DATA_TYPE(String value){
			this.value = value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
	public enum DATA_FROM_TYPE{
		NORMAL("NORMAL"),SQL("SQL"),VAR("VAR"),FORMULA("FORMULA"),FUN("FUN");
		
		private String value;
		
		DATA_FROM_TYPE(String value){
			this.value = value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
	public enum VAR_DATA{
		ELSACCOUNT("#ELSACCOUNT#"),REQCODE("#REQCODE#"),CTIMESTAMP("#CTIMESTAMP#"),CDATE("#CDATE#"),CTIME("#CTIME#");
		
		private String value;
		
		VAR_DATA(String value){
			this.value = value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
	public enum RETURN_TYPE{
		SUCCESS("S"),ERROR("E"),WARNING("W"),INFORMATION("I"),SUSPEND("A");
		
		private String value;
		
		RETURN_TYPE(String value){
			this.value = value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
	
}
