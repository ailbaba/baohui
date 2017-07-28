package com.srm.online.common;

/**
 * 
 * @author chenyuhua
 *
 */
public interface OrderConstants {

	//�ɹ������Ͳɹ����������۷���Ϣ֪ͨ
	public static final String PURCHASE_ORDER_NOTICE_KEY_PREFIX = "key_purchaseOrder_notice#";

	//���۷��޸Ķ���ͷ�������͵��ɹ���֪ͨ
	public static final String SALE_ORDER_NOTICE_KEY_PREFIX = "key_saleOrder_notice#";
	
	//���۷���������޸ĺ�Ķ�����Ϣ���ɹ���֪ͨ
	public static final String SALE_ORDER_ALL_NOTICE_KEY_PREFIX = "key_saleOrderall_notice#";
	
	//�ɹ����Ѿ��յ����۶���֪ͨ
	public static final String SALE_ORDER_RECEIVED_NOTICE_KEY_PREFIX = "key_saleOrderReceived_notice#";
	
	//���۷��Ѿ��յ��ɹ���������Ϣ֪ͨ
	public static final String PURCHASE_ORDER_RECEIVED_NOTICE_KEY_PREFIX = "key_purchaseOrderReceived_notice#";
	
	
	
	public enum PURCHASE_ENQUIRY_FILE_STATU {
		NOT_SEND("0"),SEND_WAIT_RECEIVE("1"),SEND_HAVE_RECEIVE("2");
		
		private String logicValue;
		
		PURCHASE_ENQUIRY_FILE_STATU(String logicValue){
			this.logicValue = logicValue;
		}
		
		public String getValue(){
			return this.logicValue;
		}
	}
}
