<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%String regulationSelectID = request.getParameter("regulationNumber");   %>
<body>
 <form id  ="selectionForm" onsubmit="return false;">
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
		    <input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsSubAccount")%>"/>
		    <input type="hidden" id="regulationNumber" name="regulationNumber" value="<%=  regulationSelectID %>"/>
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button id="saveBtn" class="button-wrap" ><i18n:I18n key="i18n_common_button_save" defaultValue="保存 " /></button>
				<button id="closeWin" class="button-wrap" ><i18n:I18n key="" defaultValue="关闭 " /></button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">条例选项</span>
			<div class="common-box-line">
				<button class="button-wrap" id="addBtn"><i18n:I18n key="" defaultValue="新增选项" /></button>
                <button class="button-wrap" id="delBtn"><i18n:I18n key="" defaultValue="删除选项" /></button>
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
		</form>
			
	</div>
	
	<!-- 选项弹出框 -->
<%-- <div class="fixed-dialog" id="regulationSelectionForm" >
	<div class="dialog-tip bg-common" style="width: 400px;height: 153px;margin-left: -205px;margin-top: -170px;">
	    <div class="dialog-close-btn" id="closeForm"></div>
        <div class="tip-head">
	        <span class="dialogTitle" ><i18n:I18n key="test" defaultValue="添加选项" /></span>
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
	                	</tr>
	                	<tr class="line-height-tr">
	                	    <td  class="tb-p"><i18n:I18n key="test" defaultValue="选项值" />:</td>
	                	    <td><input class="easyui-textbox" type="text" id="regulationSelectValue" name = "regulationSelectValue"/></td>
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
</div> --%>

	<script>
	 var type = "";   //用于做添加修改操作标识 
	 var headTable;
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var regulationSelectID = <%=  regulationSelectID %> ;
	 var pid = GetQueryString("pid");
	 //初始化记载信息 
	 $(document).ready(function(){
		 $("#regulationSelectID").val(regulationSelectID);
		 $("#elsAccount").val(elsAccount);
	 });

		//允许任何字符输入框
		var initInputAny = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" name="selections[]['+this.name+']" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		
		//只允许数字输入框
		var initInputABC = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" onkeyup="value=value.replace(/[^a-zA-Z]$/g,\'\')" placeholder="请输入 英文字母" maxlength="1"  name="selections[]['+this.name+']" value="'+val+'"/>';
		};
	  //保存
	 $("#saveBtn").click(function(){
		 var frm = $("#selectionForm").serializeJSON();
		 var bool = false;
		 $("input[name='selections[][regulationSelectName]']").each(function(){
				var value = $(this).val();
				if(value==""){
					bool = true;
					return;
				}
			});
		 if(bool){
			 alert('<i18n:I18n key="" defaultValue="请输入选项名称!" />',2);
			 $("#headTable").focus();
			 return;
		 }
		 var isNull = false;
		 var isSame = false;
		 var arr = $("input[name='selections[][regulationSelectValue]']");
		 var hash = {};
		 for(var i=0;i<arr.length;i++) {
			 var value = arr[i].value.toUpperCase();
	         if(hash[value]){
	        	 isSame = true;
	              break;  
	         }
	         hash[value] = true;  
	     }   
		 if(isSame){
			 alert('<i18n:I18n key="" defaultValue="选项值不能相同!" />',2);
			 $("#headTable").focus();
			 return;
		 }
		 if(isNull){
			 alert('<i18n:I18n key="" defaultValue="选项值不能为空!" />',2);
			 $("#headTable").focus();
			 return;
		 }
		  // 保存操作 
		 $.ajax({
 			url : '<%=basePath%>rest/RegulationService/insertRegulationSelection',
 			type : 'POST',
 			async:false,
 			contentType : "application/json",
 			data : JSON.stringify(frm),
 			dataType : "json",
 			success : function(data) {
 				alert('<i18n:I18n key="test" defaultValue="操作成功" />',1);
 				closeWin();
 			},
 			error : function(data) {
 				if (!permissionError(data)) {
 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
 			},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
 		 });
	 });
	  
	 $("#addBtn").click(function(e){
		 var cols={elsAccount:elsAccount,regulationSelectID:regulationSelectID,regulationSelectName:"",regulationSelectValue:"",fbk1:""};
		 headTable.addRows([cols]);
 	 });
/* 	  
	  //新增页面
	 $("#addBtn").click(function(){
		$("#regulationSelectionForm").show();
		type = "1";
		 $("#regulationSelectValue").val("");
		 $("#fbk1").val("");
		 $("#regulationSelectName").val("");
	 }); */
	 
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
	 
		<%-- //删除
		$("#delBtn").click(function(){
			 var head = headTable.selectedRows();
			 if(head.length<=0){
				 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
				 return;
			 }
			 parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
				    parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_label_deleting" defaultValue="删除中" />');
				    var param=head[0];
			 		 $.ajax({
			 			url : '<%=basePath%>rest/RegulationService/deleteRegulationSelection',
			 			type : 'POST',
			 			contentType : "application/json",
			 			data : JSON.stringify(param),
			 			dataType : "json",
			 			success : function(data) {
			 				headTable.load({});
			 				alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
			 			},
			 			error : function(data) {
			 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="删除失败!" />',3);
			 			},complete : function(data) {
			    			parent.elsDeskTop.hideLoading();
			    		}
			 		 });
			 }});
		}); --%>
		
		$("#delBtn").click(function(e){
			var seletectIndexArr=headTable.selectedRowsIndex();
			if(seletectIndexArr.length<=0){
				alert("请选择要删除的行!",2);
				return;
			}
		 	headTable.removeRow(seletectIndexArr);
		});
		
		$("#closeWin").click(function(){
			closeWin();
		});
		
		function closeWin(){
			parent.frames['iframeApp_'+pid].queryRegulation();
	        parent.elsDeskTop.closeCurWin('RegulationSelection');
		}
	 //查询
	 $("#queryHeadBtn").click(function(){
		 var formObj = $("#queryForm").serializeJSON();
		 formObj["elsAccount"]=elsAccount;
		 
		 headTable.opts.params = formObj;
		 headTable.load({page:1});
	 });
	 
	window.purchQuery = function() {
		headTable.load({});
	};
 
	  var colst_head = [
	                 	{ title:'els帐号', name:'elsAccount' ,width:200, hidden:true,align:'center',renderer:initInputAny},
	                 	{ title:'条例编号', name:'regulationSelectID' ,width:200,hidden:true,align:'center',renderer:initInputAny},
	                	{ title:'名称', name:'regulationSelectName' ,width:200, align:'center' ,renderer:initInputAny},
	                	{ title:'选项值', name:'regulationSelectValue' ,width:200, align:'center',renderer:initInputABC},
	                	{ title:'备注', name:'fbk1' ,width:200, align:'center' ,renderer:initInputAny}
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
  			        multiSelect : true,
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
  	  
</script>
</body>
</html>