package com.srm.online.common;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jettison.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author ����ƽ
 * 
 * VO ֵ���� ��Ҫ�̳и���
 *
 */
@XmlRootElement(name = "BaseVO")
@JsonIgnoreProperties(ignoreUnknown = true)
public class BaseVO implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	private String errMessage;
	
	private String reqCode;
	
	private String businessCode;//ҵ�����
	
	private String tableName;
	
	private String integrateCode;
	
	private String urlStr;

	private String statusCode;

	private String message;

	private String language;

	/**
	 * ���ڷֱ�ʱ���������
	 */
	private int pageSize;// ÿҳ��ʾ������

	private int recordCount;// �ܹ�������

	private int currentPage;// ��ǰҳ��

	private int fromIndex;

	private Date createDate;

	private String createUser;

	private Date lastUpdateDate;

	private String lastUpdateUser;

	/** ���Ȩ�޶��� */
	private String permissionObject;

	/** ���Ȩ�޶������ */
	private String permissionObjectAlia;

	private String elsAccount;

	private String elsSubAccount;

	private String companyShortName;
	
	private String sort;
	
	private String auditOpinion;
	
	private int version;
	/**
	 * ��չ�ֶ�
	 */
	private String extendFields;
	
	public BaseVO() {

	}

	public String getElsAccount() {
		return elsAccount;
	}

	public void setElsAccount(String elsAccount) {
		this.elsAccount = elsAccount;
	}

	public String getElsSubAccount() {
		return elsSubAccount;
	}

	public void setElsSubAccount(String elsSubAccount) {
		this.elsSubAccount = elsSubAccount;
	}

	public BaseVO(String statusCode, String message) {
		this.statusCode = statusCode;
		this.message = message;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

	public String getLastUpdateUser() {
		return lastUpdateUser;
	}

	public void setLastUpdateUser(String lastUpdateUser) {
		this.lastUpdateUser = lastUpdateUser;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	public String toJson() {
		ObjectMapper mapper = new ObjectMapper();
		try {
			String objectJson = mapper.writeValueAsString(this);
			return objectJson;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	// ��ҳ��
	public int getPageCount() {
		if (pageSize == 0 || recordCount == 0)
			return 0;
		int size = recordCount / pageSize;// ������/ÿҳ��ʾ������=��ҳ��
		int mod = recordCount % pageSize;// ���һҳ������
		if (mod != 0)
			size++;
		return recordCount == 0 ? 1 : size;
	}

	// ����ʼ����Ϊ0
	public int getFromIndex() {
        if (this.fromIndex != 0) {
        	return this.fromIndex;
        }
		return currentPage - 1 >= 0?(currentPage - 1) * pageSize : 0;
	}

	// ����
	public int getToIndex() {

		return Math.min(recordCount, currentPage * pageSize);
	}

	public void setFromIndex(int fromIndex) {
		this.fromIndex = fromIndex;
//		this.fromIndex = (currentPage - 1) * pageSize;
	}

	// �õ���ǰҳ
	public int getCurrentPage() {
		return currentPage - 1 >= 0?currentPage:1;
	}// ���õ�ǰҳ

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}// �õ�ÿҳ��ʾ������

	public int getPageSize() {
		return pageSize == 0?Integer.MAX_VALUE:pageSize;
	}// ����ÿҳ��ʾ������

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}// �õ��ܹ�������

	public int getRecordCount() {
		return recordCount;
	}// �����ܹ�������

	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}

	public String getPermissionObject() {
		return permissionObject;
	}

	public void setPermissionObject(String permissionObject) {
		this.permissionObject = permissionObject;
	}

	public String getPermissionObjectAlia() {
		return permissionObjectAlia;
	}

	public void setPermissionObjectAlia(String permissionObjectAlia) {
		this.permissionObjectAlia = permissionObjectAlia;
	}

	public String getCompanyShortName() {
		return companyShortName;
	}

	public void setCompanyShortName(String companyShortName) {
		this.companyShortName = companyShortName;
	}

	public String getSort() {
		if (StringUtils.isNotBlank(sort)) {
			return sort.replace(".asc", " asc").replace(".desc", " desc");
		}
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getAuditOpinion() {
		return auditOpinion;
	}

	public void setAuditOpinion(String auditOpinion) {
		this.auditOpinion = auditOpinion;
	}

	public String getExtendFields() {
		return extendFields;
	}

	public void setExtendFields(String extendFields) {
		this.extendFields = extendFields;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getReqCode() {
		return reqCode;
	}

	public void setReqCode(String reqCode) {
		this.reqCode = reqCode;
	}

	public String getUrlStr() {
		return urlStr;
	}

	public void setUrlStr(String urlStr) {
		this.urlStr = urlStr;
	}

	public String getIntegrateCode() {
		return integrateCode;
	}

	public void setIntegrateCode(String integrateCode) {
		this.integrateCode = integrateCode;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getBusinessCode() {
		return businessCode;
	}

	public void setBusinessCode(String businessCode) {
		this.businessCode = businessCode;
	}

	public String getErrMessage() {
		return errMessage;
	}

	public void setErrMessage(String errMessage) {
		this.errMessage = errMessage;
	}
	
	
}
