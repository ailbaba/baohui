<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath%>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath%>jsLib/webuploader/js/webuploader.js"></script>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	<form id="form" onsubmit="return false;">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_permission_rule" defaultValue="规则" /></span>
			<div class="common-box-line">
				<input type="hidden" id="ruleId" name="ruleId" />
<!-- 				<input type="hidden" id="elsAccount" name="elsAccount" /> -->
				<input type="hidden" id="elsSubAccount" name="elsSubAccount" />
				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</span><input
						type="text" id="elsAccount" name="elsAccount" readonly="readonly" />
				</div>

				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_permission_objectCode" defaultValue="对象编码" />：</span>
						<select id="objectCode" name="objectCode" readonly="readonly" ></select>
				</div>
				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_permission_ruleobject" defaultValue="规则对象" />：</span><input
						type="text" id="ruleTarget" name="ruleTarget" readonly="readonly" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_permission_ruleType" defaultValue="规则类型：" /></span><select
						id="ruleType" name="ruleType" readonly =" readonly" disabled="disabled">
						<option value="1"><i18n:I18n key="i18n_permission_rolerule" defaultValue="角色规则" /></option>
						<option value="2" ><i18n:I18n key="i18n_permission_subaccountrule" defaultValue="子账号规则" /></option>
					</select>
				</div>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_permission_ruledetail" defaultValue="规则明细" /></span>
			<div class="common-box-line">
				<div class="edit-box-wrap">
					<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="deleteBtn" class="button-wrap"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
				</div>
				<main class="grid-container">
				<div class="grid-100">
					<table id="table-item"></table>
				</div>
				</main>
			</div>
		</div>
	</form>
	<script type="text/javascript">
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var ruleId = "<%=request.getParameter("ruleId")%>";
	if(ruleId=="null"){
		ruleId="0";
	}
	$("#ruleId").val(ruleId);
	debugger;
	 var ruleType=GetQueryString("ruleType");
	 var ruleTarget=GetQueryString("ruleTarget");
	var itemGrid;
	
	var cols_item = [
	                 { title:'ruleId',name:'ruleId' ,width:150, hidden:true, align:'center', renderer:function(val){
	             	    if (!val) {val = "";}
	            	    return "<span class='showText'>" + val + "</span>" + "<input name='ruleItemList[][ruleId]' type='text' class='noEdit' style='display:none' value='"+val+"'/>";
	                 }},
	                 { title:'ruleItemId',name:'ruleItemId' ,width:150, hidden:true, align:'center',renderer:function(val){
	             	    if (!val) {val = "";}
	            	    return "<span class='showText'>" + val + "</span>" + "<input name='ruleItemList[][ruleItemId]' type='text' class='noEdit' style='display:none' value='"+val+"'/>";
	                 }},
	                 { title:'<i18n:I18n key="i18n_audit_title_connector" defaultValue="连接符" />',name:'connector' ,width:100, align:'center',renderer:function(val){
	                	  	return "<span class='showText'>" + val + "</span>" + "<select name='ruleItemList[][connector]'  value='"+val+"' id='connector' style='display:none'><option value=''></option><option value='AND' selected>AND</option><option value='OR'>OR</option></select>";
	                 }},
	                 { title:'<i18n:I18n key="i18n_audit_title_leftbracket" defaultValue="左括号" />',name:'leftBracket' ,width:100, align:'center',renderer:function(val){
	                	  	return "<span class='showText'>" + val + "</span>" + "<select name='ruleItemList[][leftBracket]'   value='"+val+"' id='leftBracket' style='display:none'><option value=''></option><option value='(' selected>(</option></select>";
	                 }},
	                 { title:'<i18n:I18n key="i18n_audit_title_propertycode" defaultValue="字段编码" />',name:'propertyCode' ,width:150, align:'center',renderer:function(val){
	                	  	return "<span class='showText' name='"+val+"'></span>" + "<select name='ruleItemList[][propertyCode]'  class='propertyCode' style='display:none'></select>";
	                 }},
	                 { title:'<i18n:I18n key="i18n_audit_title_logic" defaultValue="逻辑符" />',name:'logic' ,width:100, align:'center',renderer:function(val){
	                	  	return "<span class='showText'>" + val + "</span>" + "<select name='ruleItemList[][logic]'   class='logic' style='display:none' value='"+val+"'>'><option value='>'>></option><option value='>='>>=</option><option value='=' selected>=</option><option value='<'><</option><option value='<='><=</option><option value='like'>like</option><option value='left like'>left like</option><option value='right like'>right like</option><option value='<>'><></option></select>";
	                 }},
	                 { title:'<i18n:I18n key="i18n_audit_title_propertyvalue" defaultValue="字段内容" />', name:'propertyValue' ,width:120, align:'center' ,renderer:function(val){
	             	    if (!val) {val = "";}
	            	    return "<span class='showText'>" + val + "</span>" + "<input id='propertyValue' name='ruleItemList[][propertyValue]' type='text' style='display:none' value='"+val+"'/>"; 
	                 }},
	                 { title:'<i18n:I18n key="i18n_audit_title_rightbracket" defaultValue="右括号" />', name:'rightBracket' ,width:100, align:'center',renderer:function(val){
	                	 return "<span class='showText'>" + val + "</span>" + "<select name='ruleItemList[][rightBracket]' value='"+val+"' id='rightBracket' style='display:none'><option value=''></option><option value=')' selected>)</option></select>";
	                 }}
	             ];
	var blankRow = {"ruleItemId":"","ruleId":ruleId,"connector":"AND","leftBracket":"(","propertyCode":"","logic":"=","propertyValue":"","rightBracket":")"};
	
	
	function getAllObjectCode(){
		var paramStr='{"elsAccount":"'+elsAccount+'"}';
		$.ajax({
			url :"<%=basePath%>rest/DataRuleService/getAllObjectCode",
			type :"post",
			dataType : "json",
			contentType : "application/json",
			data :paramStr,
			success : function(data) {
				var html="<option value=''></option>";
				 if(data.length>0){
					for(var i=0;i<data.length;i++){
						 html += "<option value='" + data[i].objectCode + "'>" +  data[i].objectCode + "</option>";
					 }
				 }
				 $("#objectCode").html(html);
				
				 if(ruleId=="0"){
						fillData(null);
					}else{
						getDataRule();
					}
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	getAllObjectCode();
	
	//获取数据
	function getDataRule(){
		var data = {"ruleId":ruleId};
		$.ajax({
			url :"<%=basePath%>rest/DataRuleService/getDataRuleByRuleId",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				fillData(data);
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	
	//填充规则明细
	function fillData(data) {
		var height=$(document).height()-295;
		if(data!=null){
			$("#elsAccount").val(data.elsAccount);
			$("#ruleTarget").val(data.ruleTarget);
			$("#ruleSql").val(data.ruleSql);
			$("#ruleType").val(data.ruleType);
			$("#ruleId").val(data.ruleId);
			$("#objectCode").attr("readonly",true);
			  $("#objectCode").find("option[value='"+data.objectCode+"']").attr("selected",true);

			ruleId=data.ruleId;
			itemGrid = $('#table-item').mmGrid({
		        cols: cols_item,
		        checkCol:true,
		        height:height,
		        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
				noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        items:  data.ruleItemList
		    });
			
			itemGrid.on('loadSuccess',function(e, data) {
				if (itemGrid.rowsLength() > 0) {
					itemGrid.select(0);
				}
				bindItemEvent();
				initSelect();
			});
			
		}else{
			$("#elsAccount").val(elsAccount);
			$("#ruleTarget").val(ruleTarget);
			$("#ruleType").val(ruleType);
			$("#objectCode").attr("readonly",false);
			itemGrid = $('#table-item').mmGrid({
		        cols: cols_item,
		        checkCol:true,
		        height:height,
		        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
				noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        items: []
		    });
	    }
	}
	
	//初始化下拉框
	function initSelect(){
		$("#table-item").find("td").each(function(){
			var val=$(this).find(".showText").html();
			var selectObj=$(this).find("select");
			if(selectObj.length>0){
				var idName=selectObj.attr("class");
				if(idName=="propertyCode"){
// 					selectObj.attr(""val);
					loadProperties(selectObj);
				}else if(idName=="logic"){
					val=val.replace("&gt;",">");
					val=val.replace("&lt;","<");
					selectObj.val(val);
				}else{
					selectObj.val(val);
				}
				
			}
		});
	}
	
	
	//绑定双击事件
	function bindItemEvent(){
		$("#table-item").find("td").unbind("dblclick").bind("dblclick",function(){
			if($(this).find(".hiddenItem").length<=0){
				$(this).find(".showText").hide();
				if($(this).find("input").length>0){
					var obj=$(this).find("input");
					obj.show();
					obj.css("width",$(this).width()-15);
					obj.focus();
				}else{
					var obj=$(this).find("select");
					obj.show();
					obj.css("width",$(this).width()-15);
					obj.focus();
					if(obj.attr("class")=="propertyCode"){
						loadProperties(obj);
					}
				}
			}
		});

		$("#table-item").find("select").unbind("blur").bind("blur",function(){
			if($(this).attr("class")!="propertyCode"){
				$(this).prev(".showText").html($(this).val());
			}else{
				$(this).prev(".showText").html($(this).find("option:selected").html());
				$(this).prev(".showText").attr("name",$(this).val());
			}
			$(this).prev(".showText").show();
			$(this).hide();
		});
		
		$("#table-item").find("input").unbind("blur").bind("blur",function(){
			if($(this).attr("class")!="itemNumberInput"){
				$(this).prev(".showText").html($(this).val());
				$(this).prev(".showText").show();
				$(this).hide();
			}
		});
	}
	
	//加载规则属性
	function loadProperties(obj){
		var objectCode = $("#objectCode option:selected").val();
		if(!objectCode){
			alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
			return;
		}
		
		var data = {"objectCode":objectCode};
		$.ajax({
			url :"<%=basePath%>rest/DataRuleService/findProperties",
			type :"post",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				initPropertyCodeSelector(data,obj);
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	
	function initPropertyCodeSelector(data,obj){
		var propertyList = data.propertyList;
		$("#propertyCode").empty();
		var html = "";
		var propertyName="";
		var val=obj.parent().find(".showText").attr("name");
		
		for (var i=0;i<propertyList.length;i++){
			var code = propertyList[i].propertyCode;
			var name = propertyList[i].propertyName;
		    html += "<option value='" + code + "'>" + name + "</option>";
		    if(code==val){
		    	propertyName=name;
		    }
		}
		obj.html(html);
		obj.parent().find(".showText").html(propertyName);
		obj.val(val);
	}
	
	//现在明细
	$("#btnAdd").click(function(){
		itemGrid.addRow(blankRow,itemGrid.rowsLength());
		bindItemEvent();
	});
	
	//保存
	$("#saveBtn").click(function(){
		debugger;
		$("#ruleType").removeAttr("disabled");
		var objectCode = $("#objectCode option:selected").val();
		if(!objectCode){
			alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
		var url;
		if(ruleId=="0"){
			url = "<%=basePath%>rest/DataRuleService/addDataRule";
		} else {
			url = "<%=basePath%>rest/DataRuleService/updateDataRule";
		}
		var frm = $("#form");
		debugger;
		$.ajax({
			url :url,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				fillData(data);
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="保存成功!" />');
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
		}});
	});
	
	
	//删除
	$("#deleteBtn").click(function(){
		var selectedIndexs=itemGrid.selectedRowsIndex();
		if(selectedIndexs.length<=0){
			alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
			return;
		}
		var ruleItemId=itemGrid.row(selectedIndexs[0]).ruleItemId;
			var selectedIndexs = itemGrid.selectedRowsIndex();
			if (selectedIndexs.length == 0) {
				alert('<i18n:I18n key="i18n_label_choosethedeliveryplan" defaultValue="交货计划!" />',2);
				return;
			}
			itemGrid.removeRow(selectedIndexs[0]);
	});
	
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('editDataRule',closeCallback);
	});
	
	function closeCallback() {
		if (parent.frames["iframeApp_dataRuleManage"]) {
			parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
		}
	}
</script>
</body>
</html>