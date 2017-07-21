<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String elsAccount = request.getParameter("elsAccount");
String toElsAccount = request.getParameter("toElsAccount");
String companyShortName = request.getParameter("companyShortName");
String vender = request.getParameter("vender");
%>
<body>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<button id="addMainDataOK" class="button-wrap" style="width: 50px;height: 23px;"><i18n:I18n key="test" defaultValue="保存" /></button>
            <button id="uploadToERP" class="button-wrap" style="width: 50px;height: 23px;"><i18n:I18n key="test" defaultValue="提交ERP" /></button>
            <button id="exitBtn" class="button-wrap" style="width: 50px;height: 23px;"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
		
	<div class="box-wrap pos-relative bg-common">
	<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="供应商主数据" /></span>
	<div class="common-box-line" id="messesgeForm">
		<div class="tab-wrap" id="add-enq-sheet">
		<ul>
			
			<li><a href="#edit-line-account"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="企业信息" /></a></li>
			<li><a href="#supplierBankInfo"><i18n:I18n key="test" defaultValue="银行资料" /></a></li>
			<li><a href="#supplierCommunicationInfo"><i18n:I18n key="test" defaultValue="地址资料" /></a></li>
			<li><a href="#supplierCertificateInfo"><i18n:I18n key="test" defaultValue="认证资料" /></a></li>
			<li><a href="#supplierContactInfo"><i18n:I18n key="test" defaultValue="联系人资料" /></a></li>
			<li><a href="#edit-line-baseInfo"><i18n:I18n key="test" defaultValue="扩展数据" /></a></li>
			
		</ul>
		
		<!-- 基本信息 -->
		<div id="edit-line-baseInfo">
		<form id = "mainDataForm">
		<table>
			<tbody>
				<tr>
					<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="Els账号" />：</td>
	    			<td colspan="10" align="left"><input id="elsAccount" name="elsAccount" type="text" style="width: 180px; max-width: 180px;" readonly = "readonly" /><span>*</span></td>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="供应商Els账号" />：</td>
	    			<td><input id="toElsAccount" name="toElsAccount" type="text"  style="width: 180px; max-width: 180px;" readonly = "readonly"/><span>*</span></td>
			    </tr>
			    <tr>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="ERP供应商编码" />：</td>
	    			<td colspan="10" align="left"><input id="vender" name="vender" type="text"   style="width: 180px; max-width: 180px;"/><span>*</span></td>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="ERP系统"/>：</td>
	    			<td colspan="10" align="left"><input id="fbk1" name="fbk1" type="text" style="width: 180px; max-width: 180px;" /></td>
	    		</tr>
			    
			    <!-- 新增 -->
		    	<tr>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="公司代码" />：</td>
	    			<td colspan="10" align="left"><input id="companyCode" name="companyCode" type="text"   style="width: 180px; max-width: 180px;"/><span>*</span></td>
		    		<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="采购组织"/>：</td>
	    			<td colspan="10" align="left"><input id="purchaseOrganization" name="purchaseOrganization" type="text" style="width: 180px; max-width: 180px;" /><span>*</span></td>
	    		</tr>
		    	<tr>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="供应商帐户组" />：</td>
	    			<td colspan="10" align="left"><input id="supplierAccountGroup" name="supplierAccountGroup" type="text" style="width: 180px; max-width: 180px;"/><span>*</span></td>
		    		<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="行业代码" />：</td>
	    			<td colspan="10" align="left"><div class="auto-industryCode"></div><span>*</span></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="银行国家"/>：</td>
	    			<td colspan="10" align="left"><input id="bankCountryName" name="bankCountryName" type="text" style="width: 180px; max-width: 180px;" /><span>*</span></td>
		    		<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="银行名称" />：</td>
	    			<td colspan="10" align="left"><input id="bankBranch" name="bankBranch" type="text" style="width: 180px; max-width: 180px;" /><span>*</span></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="银行国家代码"/>：</td>
	    			<td colspan="10" align="left"><input id="bankCountryCode" name="bankCountryCode" type="text" style="width: 180px; max-width: 180px;" /><span>*</span></td>
		    		<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="银行编号" />：</td>
	    			<td colspan="10" align="left"><div class="auto-bankCode"></div><span>*</span></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="银行帐户号码"/>：</td>
	    			<td colspan="10" align="left"><input id="bankAccountCode" name="bankAccountCode" type="text" style="width: 180px; max-width: 180px;" /><span>*</span></td>
		    		<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="帐户持有人姓名" />：</td>
	    			<td colspan="10" align="left"><input id="bankAccountName" name="bankAccountName" type="text"   style="width: 180px; max-width: 180px;"/><span>*</span></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="统驭科目"/>：</td>
	    			<td colspan="10" align="left"><div class="auto-ledgerSubject"></div><span>*</span></td>
		    		<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="付款条件" />：</td>
	    			<td colspan="10" align="left"><div class="auto-payConditionCode"></div><span>*</span></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="付款方式"/>：</td>
	    			<td colspan="10" align="left"><div class="auto-paymentList"></div><span>*</span></td>
		    		<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="货币码" />：</td>
	    			<td colspan="10" align="left"><div class="auto-currencyCode"></div><span>*</span></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="基于收货的发票验证" />：</td>
	    			<td colspan="10" align="left"><input id="receiptInvoiceIdentify" name="receiptInvoiceIdentify" type="checkbox" value="X" checked="checked"/><span>*</span></td>
		    		<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="有关计算方案的组(供应商)"/>：</td>
	    			<td colspan="10" align="left"><div class="auto-relationCalcGroup"></div></td>
	    		</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="发生质疑事件时的责任销售员"/>：</td>
	    			<td colspan="10" align="left"><input id="dutySaler" name="dutySaler" type="text" style="width: 180px; max-width: 180px;" /></td>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="付款条件代码2" />：</td>
	    			<td colspan="10" align="left"><input id="currencyCode2" name="currencyCode2" type="text"   style="width: 180px; max-width: 180px;"/><span>*</span></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="自动产生允许的采购订单 "/>：</td>
	    			<td colspan="10" align="left"><input id="purchaseOrder" name="purchaseOrder" type="checkbox"/></td>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="采购组 " />：</td>
	    			<td colspan="10" align="left"><input id="purchaseGroup" name="purchaseGroup" type="text"   style="width: 180px; max-width: 180px;"/></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="计划的天数内交货"/>：</td>
	    			<td colspan="10" align="left"><input id="planDelivery" name="planDelivery" type="text" style="width: 180px; max-width: 180px;" /></td>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="ABC标识" />：</td>
	    			<td colspan="10" align="left"><div class="auto-abcIdentify"></div></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="供应商分类一"/>：</td>
	    			<td colspan="10" align="left"><div class="auto-getClass1"></div></td>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="供应商分类二" />：</td>
	    			<td colspan="10" align="left"><div class="auto-getClass2"></div></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="供应商分类三"/>：</td>
	    			<td colspan="10" align="left"><div class="auto-getClass3"></div></td>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="供应商分类四" />：</td>
	    			<td colspan="10" align="left"><div class="auto-getClass4"></div></td>
		    	</tr>
		    	<tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="供应商分类五 "/>：</td>
	    			<td colspan="10" align="left"><div class="auto-getClass5"></div></td>
		    	</tr>
			    	
			    
			   <!--  End -->
			    
			</tbody>
			</table>
			</form>
		</div>
		
		<!-- 结构化数据 -->
		<div id="supplierBankInfo">
		    <!-- 银行资料 -->
			<main class="grid-container">
			<div class="grid-100">
				<table id="supplierBankInfoTable"></table>
			</div>
			</main>
		</div>
		<div id="supplierCommunicationInfo">
			<!-- 地址资料 -->
			<main class="grid-container">
			<div class="grid-100">
				<table id="supplierCommunicationInfoTable"></table>
			</div>
			</main>
		</div>
		<div id="supplierCertificateInfo">
			<!-- 认证资料 -->
			<main class="grid-container">
			<div class="grid-100">
				<table id="supplierCertificateInfoTable"></table>
			</div>
			</main>
		</div>
		<div id="supplierContactInfo">
			<!-- 联系人资料 -->
			<main class="grid-container">
			<div class="grid-100">
				<table id="supplierContactInfoTable"></table>
			</div>
			</main>
		</div>
		
		<!-- 企业基本信息 -->
		<div id="edit-line-account">
			<jsp:include  page="../account/displayAccount.jsp"/>
		</div>
		
		</div>
		
		
		
	</div>
	
	</div>

	<script>
	    var fileUploader;
		var elsAccount = '<%=elsAccount%>';
		var elsSubAccount = <%=session.getAttribute("elsSubAccount")%>;
		var toElsAccount = '<%=toElsAccount%>';
		var elsAccountNumber = '<%=toElsAccount%>';
		var companyShortName = '<%=companyShortName%>';
		var vender = '<%=vender%>';
		var supplierBankInfoGrid;
		var supplierCommunicationInfoGrid;
		var supplierCertificateInfoGrid;
		var supplierContactInfoGrid;
		var gobalParams = {"elsAccount":toElsAccount}  // 更据供应商的els账号来查询对应的信息 
		//处理企业基本信息样式
		$("#updateSupplySpanId").remove();
		$('#updateSupplyTableId').unwrap();
		
		
		// 渲染   @author luokaiyao	 20160517  begin

		//只允许数字输入框
		var initInputNumber = function(val,item,index){
			if(!val) { val = '';}
			return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
		};
		//允许任何字符输入框
		var initInputAny = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		//企业名称
	    var initCompanyName = function (val, item, index){
	    	if(!val) { val = '';}
	    	var name = this.name;
	    	var value = this.value;
			return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
	    }
		
		//渲染结构化数据默认类型
	    var initDefault = function (val, item, index){
	    	if(!val){
	    		val ='';
	    		return'<span>'+ val +'</span>';
	    	}else if(val == "1"){
	    		return '<span>'+ "否"  +'</span>';
	    	}else if(val == "2"){
	    		return '<span>'+ "是"  +'</span>';
	    	}
	    }
	    
		//证书状态
	    var initCertificateInfo = function (val, item, index){
	    	if(!val){
	    		val ='';
	    		return'<span>'+ val +'</span>';
	    	}
	    	if(val == "1"){
	    		return '<span>'+ "未认证" +'</span>';
	    	}else if(val == "2"){
	    		return '<span>'+  "已认证" +'</span>';
	    	}
	    }
		
		//联系人公开模式
	    var initPublicMode = function (val, item, index){
	    	if(!val){
	    		val ='';
	    		return'<span>'+ val +'</span>';
	    	}else if(val == 1){
	    		return '<span>'+ "默认不公开" +'</span>';
	    	}else if(val == 2){
	    		return '<span>'+ "对所有公开"  +'</span>';
	    	}else if(val == 3){
	    		return '<span>'+ "仅对合作伙伴公开"  +'</span>';
	    	}else if(val == 4){
	    		return '<span>'+ "仅当前伙伴公开"  +'</span>';
	    	}
	    }
	   
		//渲染 @author luokaiyao 20160517  end
		
		var supplierBankInfoCols = [{title:'id',                 name:'bankId',             width: 120, align: 'center',hidden:true},
		        					{title:'ELS帐号',            name:'elsAccount',         width: 120, align: 'center'},
		        					{title:'standardNumber',     name:'standardNumber',     width: 120, align: 'center',hidden:true},
		        					{title:'standardItemNumber', name:'standardItemNumber', width: 120, align: 'center',hidden:true},
		        					{title:'国家',               name:'countryName',        width: 120, align: 'center'},
		        					{title:'银行名',             name:'bankName' ,          width: 120, align: 'center'},
		        					{title:'开户网点名称',       name:'bankBranch',         width: 250, align: 'center'},
		        					{title:'银行账号',           name:'bankAccount',        width: 250, align: 'center'},
		        					{title:'银行账号名',         name:'bankAccountName',    width: 250, align: 'center'},
		        					{title:'是否默认',           name:'isDefault',          width: 250, align: 'center',renderer:initDefault},
		        					{title:'银行代码',           name:'backCode',           width: 250, align: 'center'},
		        					{title:'国家银行标准账号',   name:'standardAccount',    width: 250, align: 'center'},
		        					{title:'开户网点银行地址',   name:'bankBranchAddress',  width: 250, align: 'center'},
		        					{title:'创建时间',           name:'logtime',            width: 250, align: 'center', renderer:function(val){	if (!val) return "";  return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }},
		        			       ]; 
		
		var supplierCommunicationInfoCols = [{title:'id', name:'communicationId', width: 120, align: 'center',hidden:true},
		                 					{title:'ELS帐号', name:'elsAccount', width: 120, align: 'center'},
		                 					{title:'地址类型', name:'addressType', width: 120, align: 'center'},
		                 					{title:'国家', name:'countries' ,width:120, align:'center'},
		                 					{title:'省', name:'provinces', width: 250, align: 'center'},
		                 					{title:'城市', name:'city', width: 250, align: 'center'},
		                 					{title:'详细地址', name:'detailedAddress', width: 250, align: 'center'},
		                 					{title:'语言', name:'language', width: 250, align: 'center'},
		                 					{title:'传真', name:'fax', width: 250, align: 'center'},
		                 					{title:'电话', name:'telephone', width: 250, align: 'center'},
		                 					{title:'是否默认', name:'isDefault', width: 250, align: 'center',renderer:initDefault},
		                 					{title:'关联组织结构', name:'organization', width: 250, align: 'center'},
		                 					{title:'时区', name:'timeZones', width: 250, align: 'center'},
		                 					{title:'创建时间', name:'logtime', width: 250, align: 'center',renderer:function(val){ if (!val)  return ""; return new Date(val).format("yyyy-MM-dd hh:mm:ss");}},]; 
		      
		var supplierCertificateInfoCols = [{title:'id',     name:'certificateId'     , width: 120, align: 'center' ,hidden:true},
		               			        {title:'ELS帐号',    name:'elsAccount'        , width: 120, align: 'center'},
		               			        {title:'认证类型',   name:'certificateType'   , width: 120, align: 'center'},
		               			        {title:'证书编号',   name:'certificateNumber' , width: 120, align: 'center'},
		               			        {title:'认证机构名', name:'agencyName'        , width: 250, align: 'center'},
		               			        {title:'认证状态',   name:'state'             , width: 250, align: 'center',renderer:initCertificateInfo},
		               			        {title:'认证时间',   name:'logtime'           , width: 250, align: 'center' ,renderer:function(val){ if (!val) return ""; return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }},
		                 			    {title:'证书生效期', name:'validBeginTime'    , width: 250, align: 'center' ,renderer:function(val){ if (!val) return ""; return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }},
		                			    {title:'证书失效期', name:'validEndTime'      , width: 250, align: 'center' ,renderer:function(val){ if (!val) return ""; return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }},
		               			        {title:'备注说明',   name:'remark'            , width: 250, align: 'center'},
		               			        {title:'证书附件',   name:'attachments'       , width: 250, align: 'center'},]; 
		
		var supplierContactInfoCols = [{title:'id',         name:'contactId',       width: 120, align: 'center' ,hidden:true},
		           					{title:'ELS帐号',    name:'elsAccount',      width: 120, align: 'center'},
		           					{title:'联系人角色', name:'contactRole',     width: 120, align: 'center'},
		           					{title:'联系人职务', name:'contactPosition' ,width: 120, align: 'center'},
		           					{title:'联系人姓名', name:'contactName',     width: 250, align: 'center'},
		           					{title:'电话',       name:'telephone',       width: 250, align: 'center'},
		           					{title:'手机',       name:'mobile',          width: 250, align: 'center'},
		           					{title:'传真',       name:'fax',             width: 250, align: 'center'},
		           					{title:'邮件',       name:'email',           width: 250, align: 'center'},
		           					{title:'是否默认',   name:'isDefault',       width: 250, align: 'center',renderer:initDefault},
		           					{title:'公开方式',   name:'publicMode',      width: 250, align: 'center',renderer:initPublicMode},
		           					{title:'创建时间',   name:'logtime',         width: 250, align: 'center' ,renderer:function(val){ if (!val) return ""; 	return new Date(val).format("yyyy-MM-dd hh:mm:ss");	}},]; 
		           	
		
		var itemGridLoadSuccess = function(){
			//
		}
		
		//银行信息加载成功
		var BankInfoLoadSuccess = function(){
			//加载银行的列
			var rows = supplierBankInfoGrid.rows();
			if(rows!=null&&rows!=""){
				for(var i = 0; i<rows.length;i++){
				//判断是否为默认 
				if(rows[i].isDefault=="2"){
					//如果是默认银行则对银行进行赋值 
					$("#bankCountryCode").val(rows[i].backCode);
					$("#bankAccountCode").val(rows[i].bankAccount);
					$("#bankAccountName").val(rows[i].bankAccountName);
					$("#bankCountryName").val(rows[i].countryName);
					$("#bankBranch").val(rows[i].bankBranch);
				}
			}
			}
		}
		
		$(document).ready(function(){
			$( '#add-enq-sheet').tabs();
			//初始化有数据限制输入框
			initSearchInput();
			
			init();
			
			//ERP供应商编码
			if(vender!='null' && vender !='' && vender !="““") {
		        $("#vender").attr("readonly","readonly");
		    }
			
			supplierBankInfoGrid = $('#supplierBankInfoTable').mmGrid({
				params:gobalParams,
				url : "${pageContext.request.contextPath}/rest/SupplierDataService/queryStandardBankInfo/" ,
				method :  "POST",
		        cols: supplierBankInfoCols,
		        root : "rows",
		        height: 300,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: true,
		        multiSelect: true
		    }).on('loadSuccess',BankInfoLoadSuccess);
			
			supplierCommunicationInfoGrid = $('#supplierCommunicationInfoTable').mmGrid({
				params:gobalParams,
				url : "${pageContext.request.contextPath}/rest/SupplierDataService/queryStandardCommunicationInfo" ,
				method :  "POST",
		        cols: supplierCommunicationInfoCols,
		        root : "rows",
		        height: 300,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: true,
		        multiSelect: true
		    }).on('loadSuccess',itemGridLoadSuccess);
			
			supplierCertificateInfoGrid = $('#supplierCertificateInfoTable').mmGrid({
				params:gobalParams,
				url : "${pageContext.request.contextPath}/rest/SupplierDataService/queryStandardCertificateInfo" ,
				method :  "POST",
		        cols: supplierCertificateInfoCols,
		        root : "rows",
		        height: 300,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: true,
		        multiSelect: true
		    }).on('loadSuccess',itemGridLoadSuccess);
			
			supplierContactInfoGrid = $('#supplierContactInfoTable').mmGrid({
				params:gobalParams,
				url : "${pageContext.request.contextPath}/rest/SupplierDataService/queryStandardContactInfo" ,
				method :  "POST",
		        cols: supplierContactInfoCols,
		        root : "rows",
		        height: 300,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: true,
		        multiSelect: true
		    }).on('loadSuccess',itemGridLoadSuccess);
			
			
		});
		
		function initSearchInput(){
			//行业代码
			$('.auto-industryCode').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'industryCode',
				antoClass:"auto-industryCode"
		    });
			 //银行编号
			$('.auto-bankCode').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'bankCode',
				antoClass:"auto-bankCode"
		    });
			//总帐中的统驭科目
			$('.auto-ledgerSubject').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'ledgerSubject',
				antoClass:"auto-ledgerSubject"
		    });
			//将要考虑的支付方法的清单
			$('.auto-paymentList').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'paymentList',
				antoClass:"auto-paymentList"
		    });
			//货币码 
			$('.auto-currencyCode').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'currencyCode',
				antoClass:"auto-currencyCode"
		    });
			//有关计算方案的组(供应商)
			$('.auto-relationCalcGroup').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'relationCalcGroup',
				antoClass:"auto-relationCalcGroup"
		    });
			//ABC标识
			$('.auto-abcIdentify').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'abcIdentify',
				antoClass:"auto-abcIdentify"
		    });
			//付款条件编码
			$('.auto-payConditionCode').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'payConditionCode',
				antoClass:"auto-payConditionCode"
		    });
			//分类1 
			$('.auto-getClass1').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'fbk11',
				antoClass:"auto-getClass1"
		    });
			
			//分类2 
			$('.auto-getClass2').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'fbk12',
				antoClass:"auto-getClass2"
		    });
			
			//分类3 
			$('.auto-getClass3').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'fbk13',
				antoClass:"auto-getClass3"
		    });
			
			//分类4 
			$('.auto-getClass4').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'fbk14',
				antoClass:"auto-getClass4"
		    });
			
			//分类5 
			$('.auto-getClass5').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'fbk15',
				antoClass:"auto-getClass5"
		    });
		}
		
		function init(){
			var params = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"vender":vender};
			$.ajax({
				url: "<%=basePath%>rest/SupplierMainDataService/querySupplierMainDataByCondition",
				type: "POST",
				contentType: "application/json",
				data:JSON.stringify(params),
				dataType: "json",
				success: function(data) {
					//将数据加载出来
					$("#elsAccount").val(elsAccount);
					$("#toElsAccount").val(toElsAccount);
/* 				 	$("#companyCode").val(data.companyCode);
					$("#standardType").val(data.standardType);
					$("#standardNumber").val(data.standardNumber);
					$("#standardStatus").val(data.standardStatus);
					$("#auditStatus").val(data.auditStatus);
					$("#deleteStatus").val(data.deleteStatus);
					$("#frozenStatus").val(data.frozenStatus);
					$("#standardType").val(data.standardType); 
					$("#fbk1").val(data.fbk1); */
					$("#vender").val(data.vender);
					$("#purchaseOrganization").val(data.purchaseOrganization);
					$("#supplierAccountGroup").val(data.supplierAccountGroup);
					$("#title").val(data.title);
					$("#sortValue").val(data.sortValue);
					$("#postalCode").val(data.postalCode);
					$("#countryCode").val(data.countryCode);
					$("#province").val(data.province);
					$("#city").val(data.city);
					$("#telephone1").val(data.telephone1);
					$("#fax").val(data.fax);
					$("#telephone2").val(data.telephone2);
					$("#taxRate1").val(data.taxRate1);
					$("#texRate2").val(data.texRate2);
					$("#addedValueTaxNumber").val(data.addedValueTaxNumber);
					//$("#industryCode").val(data.industryCode);
					ajaxInitSearchInput("industryCode",data.industryCode);
					$("#bankCountryCode").val(data.bankCountryCode);
					//$("#bankCode").val(data.bankCode);
					ajaxInitSearchInput("bankCode",data.bankCode);
					//$("#bankAccountCode").val(data.bankAccountCode);
					//$("#bankAccountName").val(data.bankAccountName);
					//$("#ledgerSubject").val(data.ledgerSubject);
					ajaxInitSearchInput("ledgerSubject",data.ledgerSubject);
					//$("#payConditionCode").val(data.payConditionCode);
					ajaxInitSearchInput("payConditionCode",data.payConditionCode);
					//$("#paymentList").val(data.paymentList);
					ajaxInitSearchInput("paymentList",data.paymentList);
					//$("#currencyCode").val(data.currencyCode);
					ajaxInitSearchInput("currencyCode",data.currencyCode);
					//$("#relationCalcGroup").val(data.relationCalcGroup);
					ajaxInitSearchInput("relationCalcGroup",data.relationCalcGroup);
					
					ajaxInitSearchInput("fbk11",data.fbk11);
					ajaxInitSearchInput("fbk12",data.fbk12);
					ajaxInitSearchInput("fbk13",data.fbk13);
					ajaxInitSearchInput("fbk14",data.fbk14);
					ajaxInitSearchInput("fbk15",data.fbk15);
					$("#receiptInvoiceIdentify").val(data.receiptInvoiceIdentify);
					$("#dutySaler").val(data.dutySaler);
					$("#currencyCode2").val(data.currencyCode2);
					$("#purchaseOrder").val(data.purchaseOrder);
					$("#purchaseGroup").val(data.purchaseGroup);
					$("#planDelivery").val(data.planDelivery);
					//$("#abcIdentify").val(data.abcIdentify);
					ajaxInitSearchInput("abcIdentify",data.abcIdentify);
					
					//准入
					if(data.standardSupplierHeadVO&&data.standardSupplierHeadVO!=null){
						$("#standardNumber").val(data.standardSupplierHeadVO.standardNumber);
						//准入单类型
						var standardType = data.standardSupplierHeadVO.standardType;
						if(standardType=='1') standardType='新增准入';
						else if (standardType == "2") standardType='变更准入';
						else if (standardType == "3") standardType='公开招标准入';
						$("#standardType").val(standardType);
						//准入单状态
						var standardStatus = data.standardSupplierHeadVO.standardStatus;
						if(standardStatus=='0') standardStatus='新建';
						else if (standardStatus == "1") standardStatus='填写中';
						else if (standardStatus == "2") standardStatus='评估中';
						else if (standardStatus == "3") standardStatus='审批中';
						$("#standardStatus").val(standardStatus);
						//审批状态 0:审批通过  1:未审批  2:审批中  3:审批拒绝
						var auditStatus = data.standardSupplierHeadVO.auditStatus;
						if(auditStatus=='0') auditStatus='审批通过';
						else if (auditStatus == "1") auditStatus='未审批';
						else if (auditStatus == "2") auditStatus='审批中';
						else if (auditStatus == "3") auditStatus='审批拒绝';
						$("#auditStatus").val(auditStatus);
						
					}
					
					//银行资料
					if(data.standardBankInfoVOList.length>0){
						supplierBankInfoGrid.load(data.standardBankInfoVOList);
					}
					
					//地址资料
					if(data.standardCommunicationInfoVOList.length>0){
						supplierCommunicationInfoGrid.load(data.standardCommunicationInfoVOList);
					}
					
					//认证资料
					if(data.standardCertificateInfoVOList.length>0){
						supplierCertificateInfoGrid.load(data.standardCertificateInfoVOList);
					}
					
					//联系人资料
					if(data.standardContactInfoVOList.length>0){
						supplierContactInfoGrid.load(data.standardContactInfoVOList);
					}
					
				}
			});
		}
		
		function ajaxInitSearchInput(fieldName,fieldValue){
			if(!fieldValue || fieldValue == ""){
				return;
			}
			var param = {"elsAccount":elsAccount,"tableName":"supplier_main_data","fieldName":fieldName};
			$.ajax({
				url: "<%=basePath%>rest/ElsSearchDictionaryService/getFields",
				type: "post",
				contentType: "application/json",
				dataType: "json",
				data : JSON.stringify(param),
				success: function(data) {
					var rows = data.rows;
					if(rows && rows.length > 0){
						var fieldValue = rows[0].fieldValue;
						var fieldValueText = rows[0].fieldValueText;
						$("#"+fieldName).val(fieldValue+"_"+fieldValueText);
					}else{
						$("#"+fieldName).val(fieldValue);
					}
				}
			});
		}
		
		//国家
		function showCountry(Country) {
			var country = Country;
			$.ajax({
				url: "<%=basePath%>rest/BaseInfoService/findAllCountry",
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function(data) {
					var countryCode = $("#countryCode");
					countryCode.empty();
					for (var i = 0; i < data.length; i++) {
						if(country==data[i].gj){
							var option = $("<option>").text(data[i].mc).val(data[i].gj)
							countryCode.append(option);
						}
					}
				}
			});
		}
		
		//省
		function showProvince(country,province) {
			var provinceCode = province;
			$.ajax({
				url: "<%=basePath%>rest/BaseInfoService/provices/" + country,
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function(data) {
					var province = $("#province");
					province.empty();
					for (var i = 0; i < data.length; i++) {
						if(provinceCode == data[i].aj){
							var option = $("<option>").text(data[i].mc).val(data[i].aj)
							province.append(option);
						}
						
					}
				}
			});
		}
		$("#countryCode").change(function(e) {
			//showProvince($(this).val());
		});
		
		//修改
		$("#addMainDataOK").click(function(e) {
			var vender = $("#vender").val();
			//去左右空格;
			vender = vender.replace(/(^\s*)|(\s*$)/g, "");
			
			if(vender==""||vender==null){
				alert("ERP供应商编码不能为空");
				return;
			}
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认操作?" />',closeEvent:function(){
				var form = $("#mainDataForm");
			    var formJson = form.serializeJSON();
			    console.log(formJson);
			    debugger;
// 			    var selectCompany = $('#toElsAccount  option:selected').text();
//   			var companyShortName =  selectCompany.substr(7,20);
				var companyShortName =  $('#fullName').val();
				formJson["companyShortName"]=companyShortName;
			    formJson["fbk2"]=username;
			    getCodeBySearchInput(formJson);
				$.ajax({
					url: "<%=basePath%>rest/SupplierMainDataService/updateSupplierMainData",
					type: "POST",
					contentType: "application/json",
					dataType: "json",
					data : JSON.stringify(formJson),
					success: function(data) {
						alert("<i18n:I18n key="test" defaultValue="操作成功！" />");
						parent.elsDeskTop.closeCurWin('supplierMainDataUpd',callBack);
					},error : function(data) {
						alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					}
				});
			}});
			
		});
		
		function getCodeBySearchInput(formJson){
			//行业代码
			var industryCode = formJson.industryCode;
			formJson["industryCode"]=getCode(industryCode);
			//银行编号
			var bankCode = formJson.bankCode;
			formJson["bankCode"]=getCode(bankCode);
			//总帐中的统驭科目
			var ledgerSubject = formJson.ledgerSubject;
			formJson["ledgerSubject"]=getCode(ledgerSubject);
			//将要考虑的支付方法的清单
			var paymentList = formJson.paymentList;
			formJson["paymentList"]=getCode(paymentList);
			//货币码 
			var currencyCode = formJson.currencyCode;
			formJson["currencyCode"]=getCode(currencyCode);
			//有关计算方案的组(供应商)
			var relationCalcGroup = formJson.relationCalcGroup;
			formJson["relationCalcGroup"]=getCode(relationCalcGroup);
			//ABC标识
			var abcIdentify = formJson.abcIdentify;
			formJson["abcIdentify"]=getCode(abcIdentify);
			//付款条件编码
			var payConditionCode = formJson.payConditionCode;
			formJson["payConditionCode"]=getCode(payConditionCode);
			
	
			//分类1
			var fbk11 = formJson.fbk11;
			formJson["fbk11"] = getCode(fbk11);
			
			//分类2
			var fbk12 = formJson.fbk12;
			formJson["fbk12"] = getCode(fbk12);
			
			//分类3
			var fbk13 = formJson.fbk13;
			formJson["fbk13"] = getCode(fbk13);
			
			//分类4
			var fbk14 = formJson.fbk14;
			formJson["fbk14"] = getCode(fbk14);
			//分类5
			var fbk15 = formJson.fbk15;
			formJson["fbk15"] = getCode(fbk15);
			
		}
		
		function getCode(objectValue){
			var array = objectValue.split("_");
			if(array && array.length > 1){
				return array[0];
			}else{
				return objectValue;
			}
		}
		
		//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
		function callBack(){
			if(parent.frames['iframeApp_supplierMainDataManager']) {
				parent.frames['iframeApp_supplierMainDataManager'].purchQuery();
			}

		}
		
		//回写SAP
		$("#uploadToERP").click(function(){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_title_sendToErp" defaultValue="是否确定发送ERP?" />',closeEvent:function(){
				var form = $("#mainDataForm");
			    var formJson = form.serializeJSON();
			    var selectCompany = $("#toElsAccount  option:selected").text();
				var companyShortName =  selectCompany.substr(7,20);
				formJson["companyShortName"]=companyShortName;
			    formJson["fbk2"]=username;
				parent.elsDeskTop.showLoading();
				$.ajax({
					url : '<%=basePath%>rest/SupplierMainDataService/supplierMainDataSendToERP' + "?t="+new Date().getTime(),
					type : 'POST',
					contentType : "application/json",
					data : JSON.stringify(formJson),
					dataType : "json",
					success : function(data) {
		    			parent.elsDeskTop.hideLoading();
		    			if(data.statusCode==-100){
		    				alert(data.message,3);
		    			}else{
		    				alert(data.message,1);
		    				parent.elsDeskTop.closeCurWin('supplierMainDataUpd',callBack);
		    			}
		    		},error : function(data) {
		    			alert(data.message,3);
		    			parent.elsDeskTop.hideLoading();
		    		}
				});
			}});
		});

		//城市
		function showCity(province,city) {
			var cityCode = city;
			$.ajax({
				url: "<%=basePath%>rest/BaseInfoService/citys/" + province,
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function(data) {
					var city = $("#city");
					city.empty();
					for (var i = 0; i < data.length; i++) {
						if(cityCode == data[i].aj + "_" + data[i].mc){
							var option = $("<option>").text(data[i].mc).val(
									data[i].aj + "_" + data[i].mc)
							city.append(option);
						}
						
					}
				}
			});
		}
		$("#province").change(function(e) {
			console.log($(this).val());
			//showCity($(this).val());
		});
		$("#city").change(function(e) {
			console.log($(this).val());
		});
		
		//关闭按钮处理
	     $("#dialogFileClose,#addFileBtnCancel").click(function(){
	    	clearAddFileInfo();
	     	$("#addFileDialog").hide();
	     });
		
		function  setCity(Country,province,city){
			var countryCode = Country;
			var province = province;
			var city = city;
			
			$("#countryCode  option[value='" + countryCode +"'] ").attr("selected",true);
			$("#province  option[value='" + province +"'] ").attr("selected",true);
			$("#city  option[value='" + city +"'] ").attr("selected",true);
		}
		
		//中英文长度截取
		var cutstr = function(str,len){ 
		        var newLength = 0; 
		        var newStr = ""; 
		        var chineseRegex = /[^\x00-\xff]/g; 
		        var singleChar = ""; 
		        var strLength = str.replace(chineseRegex,"**").length; 
		        for(var i = 0;i < strLength;i++) { 
		                singleChar = str.charAt(i).toString(); 
		                if(singleChar.match(chineseRegex) != null) { 
		                        newLength += 2; 
		                }else { 
		                        newLength++; 
		                } 
		                if(newLength > len) { 
		               /*  if(newLength > len) {  */
		                        break; 
		                } 
		                newStr += singleChar; 
		        } 
		        if(strLength > len) { 
		                newStr += ".："; 
		        } 
		        return newStr; 
		}
		        
		var language='<%=session.getAttribute("language") %>';
		
		if(language=="en"){
			//按钮提示
			$('table tbody tr td[align="right"]').not('.none-title').each(function(i,b){
					var txt = $(b).text();
					if(txt && txt.length) {
						b.title=b.title||$(b).text();
						$(b).text(cutstr(txt,9));
					}
			   });
		}
		
		//退出
		$("#exitBtn").click(function(){
			parent.elsDeskTop.closeCurWin('supplierMainDataUpd');
		});
		</script>

</body>
</html>