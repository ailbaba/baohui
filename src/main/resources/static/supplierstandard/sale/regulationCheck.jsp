<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 130px;
		padding-left: 20px;
		padding-top: 3px ;
		text-align: right;
	}
</style>
<div class="box-wrap pos-relative bg-common">
<form id="regulationCheckForm" action="" method="post"  onsubmit=" return false">
<table>
		<tr>
			<%-- <td align ="left"  style="width: 80px;"> <i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</td> --%>
			<td align ="left"><input readonly  class="" type="hidden" id="elsAccount" name="elsAccount" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align ="left"  style="width:150px;"><i18n:I18n key="test" defaultValue="准入评估单号" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="standardNumber" name="standardNumber" style="width: 130px; max-width: 180px;"/></td>
			<td align ="left"><input readonly  class="" type="hidden" id="standardItemNumber" name="standardItemNumber" style="width: 130px; max-width: 180px;"/></td>
		</tr>

		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="条例单号" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="regulationNumber" name="regulationNumber" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="条例名称 " />：</td>
			<td align ="left"><input readonly  class="" type="text" id="regulationName" name="regulationName" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="条例明细" />：</td>
			<td align ="left">
			<textArea  readonly  id="regulationDetail"  style="width: 250px; max-width: 250px;"></textArea>
			</td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="条例输入类型" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="inputType"  style="width: 130px; max-width: 180px;"/></td>
			<td><button class="button-wrap" id="uploadExcel"><i18n:I18n key="test" defaultValue="导入" /></button>
			<button class="button-wrap" id="viewReportBtn"><i18n:I18n key="test" defaultValue="查看" /></button>
			<button class="button-wrap" id="caculatorBtn"><i18n:I18n key="test" defaultValue="运算" /></button>
			</td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="输入选项" />：</td>
			<td align ="left">
			<textArea   id="inputValue"  style="width: 250px; max-width: 250px;" maxlength="60"  onchange="this.value=this.value.substring(0, 60)" onkeydown="this.value=this.value.substring(0, 60)" onkeyup="this.value=this.value.substring(0,60)"></textArea>
			<span id ="num_txt1" style="position:absolute;top: 175px;left:430px;"></span>  
			</td>
		</tr>
		<tr>
				<!-- 单选内容通过radioGroup加载对应的选项  -->
			<td colspan="2" >
				<radioGroup id = "radioGroup" hidden = "true"  disabled="true">
				</radioGroup>
				<!-- 多选内容通过checkBox加载对应的选项  -->
			<checkboxGroup id = "checkboxGroup"  hidden = "true" disabled ="true">
			</checkboxGroup>
			</td>
		</tr>
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="附件选项" />：</td>
			<!-- fbk1 为附件名称 字段 -->
			<td align ="left"><input readonly  class="" type="text" id="uploadfileName"  name = "fbk1"  style="width: 180px; max-width: 180px;" /></td>
			<td><button class="button-wrap" id="downFile"><i18n:I18n key="test" defaultValue="下载模板" /></button></td>
			<td><button class="button-wrap" id="uploadFile"><i18n:I18n key="test" defaultValue="上传模板" /></button></td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="采购方提供附件" />：</td>
			<!-- purchasefileName 为采购方附件名称 字段 -->
			<td align ="left"><input readonly  class="" type="text" id="purchasefileName"  name = "fbk20"  style="width: 180px; max-width: 180px;" /></td>
			<td><button class="button-wrap" id="purchasedownFile"><i18n:I18n key="test" defaultValue="下载" /></button></td>
<%-- 			<td><button class="button-wrap" id="uploadFile"><i18n:I18n key="test" defaultValue="上传模板" /></button></td> --%>
		</tr>
		<tr>
			<td align ="right"  style="width:100px;"><input type="checkbox" id="fbk13" name="fbk13" value="0" checked="checked"/>&nbsp;<i18n:I18n key="test" defaultValue="有效期管理" />&nbsp;&nbsp;&nbsp;</td>
			<!-- purchasefileName 为采购方附件名称 字段 -->
			<td align ="left"><input type="text" class="Wdate" onfocus="WdatePicker({minDate:CurentTime(),maxDate:'2099-12-31'})" id="fbk14" name="fbk14" style="width: 100px; max-width: 100px;"/></td>
			<td align ="left"  style="width:50px;"><input type="checkbox" id="fbk15" name="fbk15" value="0" checked="checked"/>&nbsp;<i18n:I18n key="test" defaultValue="提前" /></td>
			<!-- purchasefileName 为采购方附件名称 字段 -->
			<td align ="left"><input class=""  type="text" id="fbk16"  name = "fbk16" value="30" style="width: 20px; max-width: 20px;" />天提醒</td>
		</tr>
		<!-- 用于存放行项目的备用字段  -->
		<td align ="left"><input readonly  class="" type="hidden" id="fbk6" name="fbk6" style="width: 130px; max-width: 180px;"/></td>
		<td align ="left"><input readonly  class="" type="hidden" id="fbk7" name="fbk7" style="width: 130px; max-width: 180px;"/></td>
		<td align ="left"><input readonly  class="" type="hidden" id="fbk8" name="fbk8" style="width: 130px; max-width: 180px;"/></td>
		<td align ="left"><input readonly  class="" type="hidden" id="templatePath" name="templatePath" style="width: 130px; max-width: 180px;"/></td>
		<!-- purchasetemplatePath 为采购方附件路径 字段 -->
		<td align ="left"><input readonly  class="" type="hidden" id="purchasetemplatePath" name="fbk21" style="width: 130px; max-width: 180px;"/></td>
</table>	
</form>	
</div>

<div style="text-align: center; padding: 5px">
            <button id="saveBtn" class="button-wrap" ><i18n:I18n key="i18n_common_button_save" defaultValue="保存" /></button>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>
        
        <!-- 添加文件弹出框 -->
<div class="fixed-dialog" id="addFileDialog">
           <div class="dialog-tip bg-common" style="width: 362px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <div class="input-and-tip"><span><i18n:I18n key="i18n_common_label_filename" defaultValue="文件名称" />：</span><input id="fileName" style="max-width: 248px; width: 248px;" name="fileName" type="text" /></div>
	                       <div class="input-and-tip"><span><i18n:I18n key="i18n_common_label_filepath" defaultValue="文件路径" />：</span><input id="filePath" style="max-width: 248px; width: 248px;" name="filePath" type="text" /></div>
	                       <div class="input-and-tip text-right">
		                       <span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /></div></span>
		                       <input id="fileType" name="fileType" type="hidden" />
	                       </div>
	                       <div class="mt-20 text-center">
	                          <button id="addFileBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                          <button id="addExcelBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                      <button id="addFileBtnCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>
	<div class="fixed-dialog" id="selectDialog">
		<div class="dialog-tip bg-common"
			style="width: 452px; height: auto; margin-left: -261px; margin-top: -190px;">
			<div class="dialog-close-btn" id="selectClose"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" /> <span
					class="dialogTitle"><i18n:I18n key="" defaultValue="选择考核时间范围" /></span>
			</div>
				<div class="box-wrap pos-relative bg-common"
					style="padding-bottom: 10px;">
					<form id="selectForm" onsubmit="return false;">
					<span><i18n:I18n key=""
									defaultValue="时间范围：" /> </span>
						<div class="dis-in-b">
							<input type="text" class="Wdate" onfocus="WdatePicker()"
								id="startOrderDate" name="startOrderDate" />
						</div>
						<div class="dis-in-b">
							<span><i18n:I18n key="i18n_enquiry_label_enquirydateend"
									defaultValue="到" /> </span><input type="text" id="endOrderDate"
								class="Wdate" onfocus="WdatePicker()" name="endOrderDate" />
						</div>
						<div class="mt-20 text-center">
							<button id="selectOK" class="button-wrap ">
								<i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" />
							</button>
							<button id="selectCancel" class="button-wrap ">
								<i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" />
							</button>
						</div>
					</form>
			</div>
		</div>
	</div>
		

<script type="text/javascript">
	
	var fileUploader;
	var elsAccount='<%=session.getAttribute("elsAccount") %>';
	var toElsAccount = '<%= request.getParameter("toElsAccount") %>';
	var regulationNumber = '<%= request.getParameter("regulationNumber") %>';
	var standardNumber = '<%= request.getParameter("standardNumber")%>';
	var standardItemNumber =  '<%= request.getParameter("standardItemNumber")%>';
	var frameAppId ="<%=request.getParameter("frameAppId") %>";
	var excelUploader;
	$(document).ready(function(){
		
// 		var currDate = new Date("2020-12-31");
// 		$("#fbk14").val(currDate.format("yyyy-MM-dd"));
		$("#standardNumber").val(standardNumber);
		$("#elsAccount").val(elsAccount);
		$("#regulationNumber").val(regulationNumber);
		$("#standardItemNumber").val(standardItemNumber);
		initRegulation();
		initRegulationSelection();
		//initStandardItemInfo();
		initExcelUploader();
	});
	$(function(){   
		   $('#inputValue').on('keyup',function(){   
		      var txtval = $('#inputValue').val().length;   
		      var str = parseInt(60-txtval);   
		        if(str > 0 ){   
		          $('#num_txt1').html('剩余可输入'+str+'字');   
		      }else{   
		          $('#num_txt1').html('剩余可输入0字');   
		          $('#inputValue').val($('#inputValue').val().substring(0,60)); //这里意思是当里面的文字小于等于0的时候，那么字数不能再增加，只能是60个字   
		        }   
		    });   
		})  
	//初始化准入单行信息的信息 
	function initStandardItemInfo(){
		var param = {
			"elsAccount" : elsAccount,
			"standardNumber" : standardNumber,
			"standardItemNumber" : standardItemNumber
		};
		$.ajax({url : '<%=basePath%>rest/SupplierStandardService/getStandardItemInfo',
	 			type : 'POST',
	 			contentType : "application/json",
	 			data : JSON.stringify(param),
	 			dataType : "json",
	 			success : function(data) {
	 				debugger;
	 				if(data.fbk13 == 0){
	 						$("#fbk14").val(data.fbk14);
	 						if(data.fbk15 == 0){
	 		 				$("#fbk16").val(data.fbk16);
	 						}else{
	 							$("#fbk15").attr("checked",false);
	 							$("#fbk16").val("");
	 						}
	 					}else{
	 						$("#fbk13").attr("checked",false);
	 						$("#fbk15").attr("checked",false);
	 						$("#fbk14").attr("disabled",true);
	 						$("#fbk16").attr("disabled",true);
	 						$("#fbk14").val("");
	 						$("#fbk16").val("");
	 					}
	 				//加载附件文件路径
	 				$("#templatePath").val(data.templatePath);
	 				if(data.fbk21!=null&&data.fbk21!=""){
	 					$("#purchasetemplatePath").val(data.fbk21);
	 				}
	 				$("#inputValue").val(data.fbk8);
	 				if(data.fbk1!=null&&data.fbk1!=""){
		 				$("#uploadfileName").val(data.fbk1);
	 				}
	 				if(data.fbk20!=null&&data.fbk20!=""){
		 				$("#purchasefileName").val(data.fbk20);
	 				}
	 				//根据保存的不同内容信息初始化用户保存的不同值
	 				if($("#fbk6").val()=="1"){
	 				//加载手工输入框信息 
		 				$("#inputValue").val(data.fbk8);
	 				}else if(	$("#fbk6").val()=="2") {
	 					var value = data.fbk7;
 						$("#selection" + value).attr("checked","true");
	 				}else if($("#fbk6").val()=="3") {
	 					$("#fbk7").val(data.fbk7);
	 					var  values = $("#fbk7").val();
	 					var data = [];
	 				 	data = values.split(",");
	 					for(var i = 0;i<data.length;i++){
	 						$("#checkbox" + data[i]).attr("checked","true");
	 					} 
	 				}
	 			
	 			},
	 			error : function(data) {
	 				if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	 				}
	 			},complete : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
	 		 });
	}

	
	//根据条例加载对应的条例选项
	function initRegulation(){
		//这里需要注意的是,应该条例是采购方才有的,所以需要请求传递过来的采购方els账号去查找条例信息 
	var param  = {"elsAccount":toElsAccount,"regulationNumber":regulationNumber};
		 $.ajax({
	 			url : '<%=basePath%>rest/RegulationService/getRegulation',
	 			type : 'POST',
	 			contentType : "application/json",
	 			data : JSON.stringify(param),
	 			dataType : "json",
	 			success : function(data) {
	 				$("#regulationName").val(data.regulationName);
	 				$("#regulationDetail").val(data.regulationDetail);
	 				//$("#inputType").val(data.inputType);
	 				// 如果参与对象是采购方 隐藏保存按钮
	 				if(data.fbk11 == "1" && data.participants == "purchese"){
	 					$("#saveBtn").hide();
	 				}
	 				$("#uploadExcel").hide();
 					$("#caculatorBtn").hide();
 					$("#viewReportBtn").hide();
	 				//判断输入类型
	 				if(data.inputType=="1"){
	 					$("#inputType").val("手工输入");
	 					$("#fbk6").val("1");
	 				}else if(data.inputType=="2"){
	 					$("#inputValue").hide();
	 					$("#inputType").val("单选");
	 					$("#num_txt1").hide();
	 					$("#radioGroup").show();
	 					$("#fbk6").val("2");
	 				}else if(data.inputType=="4"){
	 					$("#inputValue").attr("readonly",true);
	 					$("#inputType").val("数据导入");
	 					$("#fbk6").val("1");
	 					$("#uploadExcel").show();
	 					$("#viewReportBtn").show();
	 				}else if(data.inputType=="3"){
	 					$("#inputValue").hide();
	 					$("#inputType").val("多选");
	 					$("#num_txt1").hide();
	 					$("#checkboxGroup").show();
	 					$("#fbk6").val("3");
	 				}else if(data.inputType=="5"){
	 					$("#inputValue").attr("readonly",true);
	 					$("#inputType").val("后台获取");
	 					$("#fbk6").val("1");
	 					$("#caculatorBtn").show();
	 				}
	 				//判断附件属性 1 为需要 2为不需要 
	 				if(data.uploadFileFlag=="1"){
	 					
	 				}else if(data.uploadFileFlag=="2"){
	 					$("#downFile").hide();
	 					$("#uploadFile").hide();
	 					$("#uploadfileName").val("不需要");
	 				}
	 				
	 			},
	 			error : function(data) {
	 				if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	 				}
	 			},complete : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
	 		 });
	}
	
	//根据条例加载对应的条例选项
	function initRegulationSelection(){
		//跟上面的同理,查询条例的选项 
	var param  = {"elsAccount":toElsAccount,"regulationSelectID":regulationNumber};
		 $.ajax({
	 			url : '<%=basePath%>rest/RegulationService/getRegulationSelectionList',
	 			type : 'POST',
	 			contentType : "application/json",
	 			data : JSON.stringify(param),
	 			dataType : "json",
	 			success : function(data) {
	 				//获取选项并且动态添加入radioGroup, checkbox里面 
	 				var selection = "";
	 				var checkbox = "";
	 				if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							//selection += '<radio value='+ data.rows[i].regulationSelectValue +'>'+data.rows[i].regulationSelectName+'</radio>';
							//初始化后的选项 id 分别为该选项的的选项值  便于从数据库读出选项值时直接设置选中状态 
							selection += '<input type = "radio" id = "selection' + data.rows[i].regulationSelectValue +'"       value='+ data.rows[i].regulationSelectValue +' name = "radioValue" >'+data.rows[i].regulationSelectName +   "          ";
							checkbox += '<input type = "checkbox" id =  "checkbox'+ data.rows[i].regulationSelectValue +'"    value='+ data.rows[i].regulationSelectValue +' name = "checkboxValue"  >'+data.rows[i].regulationSelectName +   "          ";
						}
					}
					$('#radioGroup').append(selection);
					$('#checkboxGroup').append(checkbox);
					initStandardItemInfo();
	 			},
	 			error : function(data) {
	 				if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	 				}
	 			},complete : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
	 		 });
	}
	
	//将信息保存入行项目  
	$("#saveBtn").click(function(){
		//保存单选选项 
		
		if($("#fbk6").val()==1){
			debugger;
// 			$("#inputValue").val()==null || $("#inputValue").val() == '' ||、、
			if(!($("#uploadfileName").val()!= '' && $("#uploadfileName").val()!=null)&&(!($("#inputValue").val()!=null && $("#inputValue").val() != ''))){ 			
				alert('<i18n:I18n key="test" defaultValue="请填写或上传附件！" />',2);
				return;
			}
 			else{
				$("#fbk8").val($("#inputValue").val());
			}
		}
		
		if($("#fbk6").val()==2){
			var selectedvalue = $("input[name='radioValue']:checked").val();
			if(selectedvalue==null || selectedvalue==""){
				alert('<i18n:I18n key="test" defaultValue="请选择或填写！" />',2);
				return;
			}
			$("#fbk7").val(selectedvalue);
		}
		
		
		if($("#fbk6").val()==3){
			obj = document.getElementsByName("checkboxValue");
			check_val = [];
			for(k in obj){
				if(obj[k].checked)
					check_val.push(obj[k].value);
			}
			var valuestr = "";
			if(check_val.length>0){
				for(var i =0;i<check_val.length;i++){
					valuestr = check_val[i] + "," + valuestr;
				}
				$("#fbk7").val(valuestr);
			}else{
				alert('<i18n:I18n key="test" defaultValue="请选择或填写！" />',2);
				return;
			}
		}
		
		var formJSON = $("#regulationCheckForm").serializeJSON();
		if($("#fbk13").attr("checked") == "checked"){
			formJSON['fbk13'] = $("#fbk13").val();
			formJSON['fbk14'] = $("#fbk14").val();
			if($("#fbk15").attr("checked") == "checked"){
				formJSON['fbk15'] = $("#fbk15").val();
				formJSON['fbk16'] = $("#fbk16").val();
			}else{
				formJSON['fbk15'] = "1";
				formJSON['fbk16'] = "-1";
			}
		}else{
			formJSON['fbk13'] = "1";
			formJSON['fbk14'] = "2099-12-31";
			formJSON['fbk15'] = "1";
			formJSON['fbk16'] = "-1";
		}
		 $.ajax({
	 			url : '<%=basePath%>rest/SupplierStandardService/saveStandardItemInfo',
	 			type : 'POST',
	 			contentType : "application/json",
	 			data : JSON.stringify(formJSON),
	 			dataType : "json",
	 			success : function(data) {
 					alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
 					debugger;
  					parent.frames['iframeApp_'+frameAppId].selectCallbackFunc();
 					parent.elsDeskTop.closeCurWin('regulationInfo');
	 			},
	 			error : function(data) {
	 				if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	 				}
	 				alert("保存失败");
	 			},complete : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
	 		 });
		
	});
	// 计算评分
	$("#caculatorBtn").click(function(){
		$("#selectDialog").show();
	});
	$("#selectClose").click(function(){
		$("#selectDialog").hide();
	});

	$("#selectCancel").click(function(){
		$("#selectDialog").hide();
	});
	
	$("#selectOK").click(function(){
		var selectItem = $("#selectForm").serializeJSON();
		var formJSON = $("#regulationCheckForm").serializeJSON();
		formJSON['templateNumber']=selectItem.startOrderDate;
		formJSON['templateDesc']=selectItem.endOrderDate;
		 $.ajax({
	 			url : '<%=basePath%>rest/SupplierStandardService/caculatorStandardItem',
	 			type : 'POST',
	 			contentType : "application/json",
	 			data : JSON.stringify(formJSON),
	 			dataType : "json",
	 			success : function(data) {
	 				if(data.statusCode==-100){
	    				alert(data.message,3);
	 				}else{
						alert('<i18n:I18n key="" defaultValue="计算成功!" />',1);
						parent.frames['iframeApp_'+frameAppId].selectCallbackFunc();
						parent.elsDeskTop.closeCurWin('regulationInfo');
	 				}},
	 			error : function(data) {
	 				if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	 				}
	 				alert("保存失败");
	 			},complete : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
	 		 });
	});
//////////////////////////////////////////////////////上传附件/////////////////////////////////////////////////////////////////////////
	
	$("#uploadFile").click(function(){
		$("#addFileDialog").show();
		$("#addExcelBtnOK").hide();
     	initFileUploader(fileUploader);
	});
	
	   function initFileUploader(fileUploader){
   	    //新增表单文件
   	    if (!fileUploader) {
   	  	fileUploader = WebUploader.create({
   	  	    // swf文件路径
   	  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
   	  	    auto: true,
   	  	    // 文件接收服务端。
   	  	    server: '<%=basePath%>servlet/UploadServlet',
   	  	    // 选择文件的按钮。可选。
   	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
   	  	    pick: '#btnFileUpload',
   	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
   	  	    resize: false,
   	  	    formData : {
   		     	elsAccount : elsAccount
   		     }
   	  	});
   	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
   	  		if(!response.error) {
   	  			var filePath = response.url;
   	    	  	   var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
   	    	       $("#filePath").val(filePath);
   	  		} else {
   	  			alert(response.message,3);
   	  		}
   	  		
   	  	   
   	  	});
   	 // 当有文件添加进来的时候
   		fileUploader.on("fileQueued",function(file){
   			var fileName = file.name;
   			$("#fileName").val(fileName);
   			$("#fileType").val(file.ext);
   			$("#uploadfileName").val(fileName);
   			$('body').data("selectedFile",true);
   		});
   	    }
   	}
	   
	   //添加文件弹出框取消按钮
	     $("#addFileBtnCancel").click(function(){
	     	$("#addFileDialog").hide();
	     	$("#uploadfileName").val("");
	     	clearAddFileInfo();
	     });
	     //关闭按钮处理
	     $("#dialogFileClose").click(function(){
	     	$("#addFileDialog").hide();
	     	$("#uploadfileName").val("");
	     	clearAddFileInfo();
	     });
	     //clear
	     function clearAddFileInfo(){
	     	$("#fileName").val("");
	     	$("#filePath").val("");
	     }

	     $("#closeWin").click(function(){
	    	 parent.elsDeskTop.closeCurWin('regulationInfo');
	     });
	     
	     //添加文件窗口确认按钮
	     $("#addFileBtnOK").click(function(){
	    	 debugger;
	    	 var flag = $('body').data("selectedFile");
	    	 if(!flag){
	    		 alert("请选择文件！",2);
	    		 return;
	    	 }
	    	$('body').data("selectedFile",false);
	     	$("#addFileDialog").hide();
	     	var filePath = $("#filePath").val();
			$("#templatePath").val(filePath);
			var fileName = $("#fileName").val();
			var reg=/[`~!@#\$%\^\&\*\+<>\?:"\{\},'\[\]]/im;
			if(reg.test(fileName)){
				$("#uploadfileName").val("");
		     	$("#filePath").val("");
				alert("文件名包含特殊字符，请重新选择或更改文件名",2);
				return;
			}
	     	clearAddFileInfo();
	     });
	     
	     //添加Excel窗口确认按钮
	     $("#addExcelBtnOK").click(function(){
	    	 var flag = $('body').data("selectedFile");
	    	 if(!flag){
	    		 alert("请选择文件！",2);
	    		 return;
	    	 }
	    	$('body').data("selectedFile",false);
	     	$("#addFileDialog").hide();
// 	     	var filePath = $("#filePath").val();
// 			$("#templatePath").val(filePath);
// 			var fileName = $("#fileName").val();
// 			var reg=/[`~!@#\$%\^\&\*\+<>\?:"\{\},'\[\]]/im;
// 			if(reg.test(fileName)){
// 				alert("文件名包含特殊字符，请重新选择或更改文件名",2);
// 				return;
// 			}
// 	     	clearAddFileInfo();
	     });
	     
	     $("#downFile").click(function(){
	    	 var filePath = $("#templatePath").val();
	    	 if(filePath==''||filePath==null){
    			alert('附件为空,不能下载!',2);
    	 		return;
    		 }
		     window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
		 });
	     
	     $("#purchasedownFile").click(function(){
	    	 var filePath = $("#purchasetemplatePath").val();
	    	 if(filePath==''||filePath==null){
    			alert('附件为空,不能下载!',2);
    	 		return;
    		 }
		     window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
		 });
	     // 有效期只能设置当前时间之后 
	     function CurentTime() {
	            var now = new Date();
	            var year = now.getFullYear();      
	            var month = now.getMonth() + 1;    
	            var day = now.getDate();          
	            var hh = now.getHours();           
	            var mm = now.getMinutes();         
	            var clock = year + "-";
	            if (month < 10)
	                clock += "0";
	            clock += month + "-";
	            if (day < 10)
	                clock += "0";
	            clock += day + " ";
	            if (hh < 10)
	                clock += "0";
	            clock += hh + ":";
	            if (mm < 10) clock += '0';
	            clock += mm;
	            return (clock);
	        }
	     //查看考核报表
	 	$("#viewReportBtn").click(function(){
// 	 		var headRows      = headTable.selectedRows();
// 	 		var headRowsIndex = headTable.selectedRowsIndex();
// 	 		var standardNumber = headRows[0].toElsAccount + "," + headRows[0].standardNumber ;
	 		parent.elsDeskTop.defineWin({
	 			'iconSrc'       : 'icon/els-icon.png' ,
	 			'windowsId'     : 'viewReportList'     ,
	 			'windowTitle'   : '<i18n:I18n key=""    defaultValue="查看导入报表" />',
	 			windowSubTitle : ""                  ,
	 			'iframSrc'      : '<%=basePath%>supplierstandard/sale/viewReportList.jsp?fbk3=1&elsAccount=' + elsAccount + '&standardNumber='+ standardNumber +'&standardItemNumber='+ standardItemNumber ,
	 			showAdv        : true                ,
	 			advArr         : ['icon/test-car.png','icon/test-car2.png'] ,
	 			windowMinWidth : 480 ,
	 			windowMinHeight: 600 ,
	 			'windowWidth'   : 1080 ,
	 			'windowHeight'  : 600 ,
	 			'parentPanel'   : ".currDesktop"
	 		});
	 	});
	     // 有效期选项选中事件
	     $("#fbk13").click(function(){
			 if($("#fbk13").attr("checked") == "checked"){
				 $("#fbk14").attr("disabled",false);
		    	 $("#fbk15").attr("checked",true);
		    	 $("#fbk16").attr("disabled",false);
		    	 var currDate = new Date("2020-12-31");
		 		$("#fbk14").val(currDate.format("yyyy-MM-dd"));
		 		$("#fbk16").val("30");
			 }else{
		    	 $("#fbk14").attr("disabled",true);
		    	 $("#fbk15").attr("checked",false);
		    	 $("#fbk16").attr("disabled",true);
		    	 $("#fbk16").val("");
		    	 $("#fbk14").val("");
			 }
			});
	     // 提醒选项选中事件
	     $("#fbk15").click(function(){
			 if($("#fbk15").attr("checked") == "checked"){
		    	 $("#fbk15").attr("checked",true);
		    	 $("#fbk16").attr("disabled",false);
		 		$("#fbk16").val("30");
			 }else{
		    	 $("#fbk15").attr("checked",false);
		    	 $("#fbk16").attr("disabled",true);
		    	 $("#fbk16").val("");
			 }
			});
	   //导入excel文件
	     function initExcelUploader(){
	     	if(!excelUploader){
	     		excelUploader = WebUploader.create({
	     		    // swf文件路径
	     		    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
	     		    auto: true,
	     		    duplicate :true,
	     		    accept:{
	     		    	extensions:"xls,xlsx",
	     		    	mimeTypes: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
// 	     		    	mimeTypes:  '.xls,.xlsx'
// 	     		    	mimeTypes:	application/vnd.ms-excel,
	     		    },
	     		    // 文件接收服务端。
	     		    server: '<%=basePath%>servlet/UploadServlet',
	     		    // 选择文件的按钮。可选。
	     		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	     		    pick:'#uploadExcel',
	     		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	     		    resize: false,
	     		    formData : {
	     		     	elsAccount : elsAccount
	     		     }
	     		});
	     		
	     		excelUploader.on( 'uploadAccept', function( obj, response ) {
	     			debugger;
	     		  	var filePath = response.url;
	     		  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
	     		  	$.ajax({
	     				url :"<%=basePath%>rest/SupplierStandardService/importExcelByPath",
	     				type :"POST",
	     				contentType : "application/json",
	     				dataType : "json",
	     				data:JSON.stringify({"fbk1":filePath,"elsAccount":elsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber}),
	     				success : function(data) {
	     					debugger;
	     					//var obj = JSON.parse(data);
	     					if(data.statusCode=="-100"){
// 	     						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_importFailure" defaultValue="导入失败！请检查文件内容！" />'});
	     						parent.elsDeskTop.hideLoading();
								alert("导入失败！请检查文件内容，异常信息："+data.message,3);
	     					}else{
	     						parent.elsDeskTop.hideLoading();
	     						alert('<i18n:I18n key="" defaultValue="导入成功!" />',1);
	     						parent.frames['iframeApp_'+frameAppId].selectCallbackFunc();
// 	     						parent.elsDeskTop.closeCurWin('purchaseSupplyManager');
	     						query();
	     					}
	     				},
	     				error: function (data) {//获取ajax的错误信息
	     					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误！" />'});
	     					parent.elsDeskTop.hideLoading();
	     	            }
	     			});
	     		});
	     	}
	     }
</script>
</body>
</html>