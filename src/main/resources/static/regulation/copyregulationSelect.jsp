<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%String regulationSelectID = request.getParameter("regulationNumber");   %>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
		    <input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsSubAccount")%>"/>
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
<%-- 				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
				<button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
                <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
                <button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue=" 保存" /></button> --%>
			</div>
		</div>
			
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">条例选项</span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100">
							<table id="headTable"></table>
							<div id="enquiryPage" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
			
	</div>
	
	<!-- 选项弹出框 -->
<div class="fixed-dialog" id="regulationSelectionForm" >
	<div class="dialog-tip bg-common" style="width: 400px;height: 153px;margin-left: -205px;margin-top: -170px;">
	    <div class="dialog-close-btn" id="closeForm"></div>
        <div class="tip-head">
	       <%--  <span class="dialogTitle" ><i18n:I18n key="test" defaultValue="添加选项" /></span> --%>
	    </div>
	    <div class="" style="background-color: #fdfdfd;">
	        <div class="common-box-line">
	        <form id  ="selectionForm">
	                <table>
	                	<tr class="line-height-tr">
	                	    <td  class="tb-p"><i18n:I18n key="test" defaultValue="选项名称" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="regulationSelectName" name = "regulationSelectName" /></td>
	                	    <td><input class="easyui-textbox" type="hidden" id="elsAccount" name = "elsAccount"  value = "<%=session.getAttribute("elsAccount")%>"/></td>
	                		<td><input class="easyui-textbox" type="hidden" id="regulationSelectID"  name = "regulationSelectID"/></td>
	                		<td><input class="easyui-textbox" type="hidden" id="regulationSelectValue" name = "regulationSelectValue" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                	    <td  class="tb-p"><i18n:I18n key="test" defaultValue="备注" />:</td>
	                	    <td><input class="easyui-textbox" type="text" id="fbk1" name = "fbk1"/></td>
	                	</tr>
	                </table>
	                </form>
	          </div>
	        <div class="box-wrap pos-relative bg-common text-center" >
	                    <button id="btnAddSelection" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	        </div>
	    </div>
    </div>
</div>

	<script>
	var type = "";   //用于做添加修改操作标识 
	 var headTable;
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var regulationSelectID = <%=  regulationSelectID %> ;
	
	 //初始化记载信息 
	 $(document).ready(function(){
		 $("#regulationSelectID").val(regulationSelectID);
		 $("#elsAccount").val(elsAccount);
	 });
	 
	  //新增选项 
	 $("#btnAddSelection").click(function(){
		 if($("#regulationSelectName").val()==""){
			 alert("选项名称不能为空");
			 return;
		 }
		 //判断添加修改标准 
		 if(type == "1"){
			// 添加操作 
			var row = {"regulationSelectName":$("#regulationSelectName").val(),"regulationSelectValue":"","fbk1":$("#fbk1").val()};
			 headTable.addRow(row);
			$("#regulationSelectionForm").hide();
		 }else if(type == "2"){
			 //修改
			var selectedRowsIndex = headTable.selectedRowsIndex();
			var row = {"regulationSelectName":$("#regulationSelectName").val(),"regulationSelectValue":"","fbk1":$("#fbk1").val()};
			headTable.updateRow(row,selectedRowsIndex[0]);
			$("#regulationSelectionForm").hide();
		 }else{
			 
		 }
	 });
	  
	  //新增页面
	 $("#addBtn").click(function(){
		$("#regulationSelectionForm").show();
		type = "1";
		 $("#regulationSelectValue").val("");
		 $("#fbk1").val("");
		 $("#regulationSelectName").val("");
	 });
	 
	  //关闭弹出框
	 $("#closeForm ,#btnCancel").click(function(){
			$("#regulationSelectionForm").hide();
			 
		 });
	 
	 //修改
	 $("#updBtn").click(function(){
			var selectRow = headTable.selectedRows();
	 	    if(selectRow.length<=0){
	 	    	alert("请选择行信息",2);
	 	    	return;
	 	    }
			$("#regulationSelectionForm").show();
			type = "2";
			
			 $("#regulationSelectValue").val(selectRow[0].regulationSelectValue);
			 $("#fbk1").val(selectRow[0].fbk1);
			 $("#regulationSelectName").val(selectRow[0].regulationSelectName);
	 });
	 
		//删除
		$("#delBtn").click(function(){
			 var head = headTable.selectedRows();
			 if(head.length<=0){
				 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
				 return;
			 }
			 var selectedRowsIndex = headTable.selectedRowsIndex();
			 headTable.removeRow(selectedRowsIndex[0]);
		});
	 
	 //查询
	 $("#queryHeadBtn").click(function(){
		 var formObj = $("#queryForm").serializeJSON();
		 formObj["elsAccount"]=elsAccount;
		 
		 headTable.opts.params = formObj;
		 headTable.load({page:1});
	 });
	 
	window.purchQuery = function() {
		headTable.load({});
	}
 
	   var colst_head = [
	        	{ title:'名称', name:'regulationSelectName' ,width:200, align:'center' },
	        	{ title:'选项值', name:'regulationSelectValue' ,width:200, align:'center' },
	        	{ title:'备注', name:'fbk1' ,width:200, align:'center' },
	       ];
	   

  	  var GobalparamStr={"elsAccount":elsAccount,"regulationSelectID":regulationSelectID};
  	  var height=$(document).height()-155;
  	  headTable= $('#headTable').mmGrid({
  	    	 		cols: colst_head,
  	         		url: '<%=basePath%>rest/RegulationService/getRegulationSelectionList',
  					params : GobalparamStr,
  					method : 'post',
  					root : "rows",
  					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
  			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
  			        multiSelect : false,
  			        checkCol : true,
  			        indexCol : false,
  					plugins : [ 
 					           $('#enquiryPage').mmPaginator({
 					                style: 'plain'
 					                , totalCountName: 'total'
 					                , page: 1
 					                , pageParamName: 'currentPage'
 					                , limitParamName: 'pageSize'
 					                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
 					                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
 					                , limit: null
 					                , limitList: [10, 30, 40, 50]
 					            })
				]
  				});
  	  
  	  
  	 //回调对数据进行保存
 	 $("#saveBtn").click(function(){
 		 
 
 	 });
  	  
</script>
</body>
</html>