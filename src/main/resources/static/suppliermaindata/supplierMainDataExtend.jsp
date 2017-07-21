<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String elsAccount = request.getParameter("elsAccount");
String toElsAccount = request.getParameter("toElsAccount");
String toCompanyName = request.getParameter("toCompanyName");
String vender = request.getParameter("vender");
%>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<button id="addMainDataOK" class="button-wrap" ><i18n:I18n key="test" defaultValue="保存" /></button>
            <button id="uploadToERP" class="button-wrap"><i18n:I18n key="test" defaultValue="提交ERP" /></button>
            <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
	
	<div class="box-wrap pos-relative bg-common">
	<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="供应商主数据" /></span>
	<div class="common-box-line" id="messesgeForm">
	<form id = "mainDataForm">
		<table>
			<tbody>
				<tr>
					<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="ELS账号" />：</td>
	    			<td colspan="10" align="left"><input id="elsAccount" name="elsAccount" type="text" style="width: 180px; max-width: 180px;" readonly = "readonly"/><span style="color: red;">*</span></td>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="供应商ELS账号" />：</td>
	    			<td><input id = "toElsAccount" name="toElsAccount" type="text" style="width: 180px; max-width: 180px;" readonly = "readonly"></input><span style="color: red;">*</span></td>
			    </tr>
			    <tr>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="ERP供应商编码"  />：</td>
	    			<td colspan="10" align="left"><input id="vender" name="vender" type="text" style="width: 180px; max-width: 180px;"  readonly = "readonly"/><span style="color: red;">*</span></td>
	     		</tr>
			    <tr>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="公司代码" />：</td>
	    			<td colspan="10" align="left"><input id="bukrs" name="bukrs" type="text"   style="width: 180px; max-width: 180px;" maxlength="4"/></td>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="总帐中的统驭科目" />：</td>
	    			<td colspan="10" align="left"><div class="auto-ledgerSubject"></div></td>
			    </tr>
			    
		    	<tr>
	    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="付款条件代码" />：</td>
	    			<td colspan="10" align="left"><div class="auto-payConditionCode"></div></td>
	    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="将要考虑的支付方法的清单"/>：</td>
	    			<td colspan="10" align="left"><div class="auto-paymentList"></div></td>
			    </tr>
			    
			</tbody>
		</table>
		</form>
		
	</div>
	
	</div>

	<script>
		//初始化控件
	    var fileUploader;
		var elsAccount = '<%=elsAccount%>';
		var toElsAccount = '<%=toElsAccount%>';
		var toCompanyName = '<%=toCompanyName%>';
		var vender = '<%=vender%>';
		
		$("#exitBtn").click(function(){
			parent.elsDeskTop.closeCurWin('supplierMainDataExtend');
		});
		
		$(document).ready(function(){
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
			//付款条件编码
			$('.auto-payConditionCode').elsAutoLoad({
				getDateUrl:'<%=basePath%>rest/ElsSearchDictionaryService/getFields',
				elsAccount:elsAccount||'',
				tableName:'supplier_main_data',
				fieldName: 'payConditionCode',
				antoClass:"auto-payConditionCode"
		    });
			init();
		});
		
		function init(){
			$("#elsAccount").val(elsAccount);
			$("#toElsAccount").val(toElsAccount);
			$("#vender").val(vender);
			
			var form = $("#mainDataForm");
		    var formJson = form.serializeJSON();
			$.ajax({
				url: "<%=basePath%>rest/SupplierMainDataService/querySupplierMainDataExtendByCondtion",
				type: "POST",
				contentType: "application/json",
				dataType: "json",
				data : JSON.stringify(formJson),
				success: function(data) {
					debugger;
					$("#bukrs").val(data.bukrs);
					ajaxInitSearchInput("ledgerSubject",data.ledgerSubject);
					ajaxInitSearchInput("paymentList",data.paymentList);
					ajaxInitSearchInput("payConditionCode",data.payConditionCode);
				},error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});
			
		}
		
		function ajaxInitSearchInput(fieldName,fieldValue){
			if(!fieldValue || fieldValue == ""){
				return;
			}
			var param = {"elsAccount":elsAccount,"tableName":"supplier_main_data","fieldName":fieldName,"fieldValue":fieldValue};
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
		
		$("#addMainDataOK").click(function(e) {
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认操作?" />',closeEvent:function(){
				debugger;
				var form = $("#mainDataForm");
			    var formJson = form.serializeJSON();
			    var selectCompany = $("#toElsAccount  option:selected").text();
				var companyShortName =  selectCompany.substr(7,20);
				formJson["companyShortName"]=companyShortName;
				getCodeBySearchInput(formJson);
				$.ajax({
					url: "<%=basePath%>rest/SupplierMainDataService/insertSupplierMainDataExtend",
					type: "POST",
					contentType: "application/json",
					dataType: "json",
					data : JSON.stringify(formJson),
					success: function(data) {
						alert("<i18n:I18n key="test" defaultValue="操作成功！" />");
						parent.elsDeskTop.closeCurWin('supplierMainDataExtend',callBack);
					},error : function(data) {
						alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					}
				});
			}});
		});

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
			    debugger;
			    var selectCompany = $("#toElsAccount  option:selected").text();
				var companyShortName =  selectCompany.substr(7,20);
				formJson["companyShortName"]=companyShortName;
			    formJson["fbk2"]=username;
			    getCodeBySearchInput(formJson);
				//parent.elsDeskTop.showLoading();
				//发送至供应商
				$.ajax({
					url : '<%=basePath%>rest/SupplierMainDataService/supplierMainDataExtendSendToERP' + "?t="+new Date().getTime(),
					type : 'POST',
					contentType : "application/json",
					data : JSON.stringify(formJson),
					dataType : "json",
					success : function(data) {
		    			alert(data.message,1);
		    			query();
		    		},error : function(data) {
		    			alert(data.message,3);
		    		},complete : function(data) {
		    			//parent.elsDeskTop.hideLoading();
		    		}
				});
			}});
		});
		
		function getCodeBySearchInput(formJson){
			//总帐中的统驭科目
			var ledgerSubject = formJson.ledgerSubject;
			formJson["ledgerSubject"]=getCode(ledgerSubject);
			//将要考虑的支付方法的清单
			var paymentList = formJson.paymentList;
			formJson["paymentList"]=getCode(paymentList);
			//付款条件编码
			var payConditionCode = formJson.payConditionCode;
			formJson["payConditionCode"]=getCode(payConditionCode);
		}
		
		function getCode(objectValue){
			var array = objectValue.split("_");
			if(array && array.length > 1){
				return array[0];
			}else{
				return objectValue;
			}
		}
		</script>
</body>
</html>