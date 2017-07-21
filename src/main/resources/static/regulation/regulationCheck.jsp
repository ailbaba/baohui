<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

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
<form id="ForzenForm" action="" method="post"  onsubmit=" return false">
<table>
		<tr>
			<%-- <td align ="left"  style="width: 80px;"> <i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</td> --%>
			<td align ="left"><input readonly  class="" type="hidden" id="elsAccount" name="elsAccount" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align ="left"  style="width:150px;"><i18n:I18n key="test" defaultValue="准入单号" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="standardNumber" name="standardNumber" style="width: 130px; max-width: 180px;"/></td>
		</tr>

		<tr>
			<%-- <td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="条例单号" />：</td> --%>
			<td align ="left"><input readonly  class="" type="hidden" id="regulationNumber" name="regulationNumber" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="条例名称 " />：</td>
			<td align ="left"><input readonly  class="" type="text" id="regulationName" name="regulationName" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="条例输入类型" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="inputType" name="inputType" style="width: 130px; max-width: 180px;"/></td>
		</tr>
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="条例明细" />：</td>
			<td align ="left">
			<!-- <input readonly  class="" type="textArea" id="regulationDetail" name="regulationDetail" style="width: 130px; max-width: 180px;"/></td> -->
			<textArea  readonly  id="regulationDetail" name="regulationDetail" style="width: 250px; max-width: 250px;"></textArea>
			</td>
		</tr>
		
		
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="输入选项" />：</td>
			<!-- <td align ="left"><input readonly  class="" type="text" id="inputValue" name="inputValue" style="width: 130px; max-width: 180px;"/></td> -->
			<td align ="left">
			<textArea  readonly  id="inputValue" name="inputValue" style="width: 250px; max-width: 250px;"></textArea>
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
			<!-- <td><input type="checkbox"></td> -->
		</tr>
		<tr>
			<td align ="left"  style="width:100px;"><i18n:I18n key="test" defaultValue="附件选项" />：</td>
			<td align ="left"><input readonly  class="" type="text" id="fileName"  name = "fbk1"  style="width: 180px; max-width: 180px;" /></td>
			<td><button class="button-wrap" id="downFile"><i18n:I18n key="test" defaultValue="下载模板" /></button></td>
		</tr>
		
		<!-- 用于存放行项目的备用字段  -->
		<td align ="left"><input readonly  class="" type="hidden" id="fbk6" name="fbk6" style="width: 130px; max-width: 180px;"/></td>
		<td align ="left"><input readonly  class="" type="hidden" id="fbk7" name="fbk7" style="width: 130px; max-width: 180px;"/></td>
		<td align ="left"><input readonly  class="" type="hidden" id="fbk8" name="fbk8" style="width: 130px; max-width: 180px;"/></td>
		<td align ="left"><input readonly  class="" type="hidden" id="templatePath" name="templatePath" style="width: 130px; max-width: 180px;"/></td>
</table>	



</form>	
</div>

<div style="text-align: center; padding: 5px">
<%--             <button id="addSubAccountOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button> --%>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="test" defaultValue="关闭 " /></button>
        </div>
		

<script type="text/javascript">
	
	var  elsAccount='<%=session.getAttribute("elsAccount") %>';
	var regulationNumber = '<%= request.getParameter("regulationNumber") %>';
	var standardNumber = '<%= request.getParameter("standardNumber")%>';
	var standardItemNumber =  '<%= request.getParameter("standardItemNumber")%>'
	$(document).ready(function(){
		$("#standardNumber").val(standardNumber);
		$("#elsAccount").val(elsAccount);
		$("#regulationNumber").val(regulationNumber);
		initRegulation();
		initRegulationSelection();
	
	});
	
	//根据条例加载对应的条例选项
	function initRegulation(){
	var param  = {"elsAccount":elsAccount,"regulationNumber":regulationNumber};
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
	 				
	 				//判断输入类型
	 				if(data.inputType=="1"){
	 					$("#inputType").val("手工输入");
	 				}else if(data.inputType=="2"){
	 					$("#inputValue").hide();
	 					$("#inputType").val("单选");
	 					$("#radioGroup").show();
	 					
	 				}else if(data.inputType=="3"){
	 					$("#inputValue").hide();
	 					$("#inputType").val("多选");
	 					$("#checkboxGroup").show();
	 				}
	 				
	 				//判断附件属性 1 为需要 2为不需要 
	 				if(data.uploadFileFlag=="1"){
	 					
	 				}else if(data.uploadFileFlag=="2"){
	 					$("#downFile").hide();
	 					$("#uploadFileFlag").val("无");
	 					$("#uploadFileFlag").show();
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
	var param  = {"elsAccount":elsAccount,"regulationSelectID":regulationNumber};
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
							selection += '<input type = "radio" disabled = "true" id = "selection' + data.rows[i].regulationSelectValue +'"  class = "selectionValue" >'+data.rows[i].regulationSelectName +   "          ";
							checkbox += '<input type = "checkbox" disabled = "true"   id =  "checkbox'+ data.rows[i].regulationSelectValue +'"  >'+data.rows[i].regulationSelectName +   "          ";
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
	
	  $("#downFile").click(function(){
	    	var filePath = $("#templatePath").val();
	    	if(filePath==''||filePath==null){
  			alert('附件为空,不能下载!',2);
  	 		return;
  		}
		    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
		});
		
	//初始化准入单行信息的信息 
		function initStandardItemInfo(){
			var param  = {"elsAccount":elsAccount,"standardNumber":standardNumber ,"standardItemNumber":standardItemNumber};
			 $.ajax({
		 			url : '<%=basePath%>rest/SupplierStandardService/getStandardItemInfo',
		 			type : 'POST',
		 			contentType : "application/json",
		 			data : JSON.stringify(param),
		 			dataType : "json",
		 			success : function(data) {
		 				//加载附件文件路径
		 				$("#templatePath").val(data.templatePath);
		 				$("#inputValue").val(data.fbk8);
		 				$("#fileName").val(data.fbk1);
		 				//根据保存的不同内容信息初始化用户保存的不同值
		 				if(data.fbk6=="1"){
		 				//加载手工输入框信息 
			 				$("#inputValue").val(data.fbk8);
		 				}else if(data.fbk6=="2") {
		 					var value = data.fbk7;
	 						$("#selection" + value).attr("checked","true");
		 				}else if(data.fbk6=="3") {
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
	
	
	//关闭窗口 
	     $("#closeWin").click(function(){
	    	 parent.elsDeskTop.closeCurWin('regulationInfo');
	     });
	


	
</script>

</body>
</html>