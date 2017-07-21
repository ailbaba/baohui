<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body> 
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_create" defaultValue="新建" /></button>
				<button class="button-wrap" id="updateBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
				<button class="button-wrap" id="deleteBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
				<button class="button-wrap" id="updateStatusBtn"><i18n:I18n key="i18n_button_updateStatus" defaultValue="更改状态" /></button>
				<button class="button-wrap" id="pegging"><i18n:I18n key="i18n_basicClauseManage_peggingBtn" defaultValue="反查使用" /></button>
				<button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			</div>
		</div>
		
		<form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="条款描述" key="i18n_basicClauseManage_clauseDesc"/>：</span>
					<input type="text" id="clauseDescQuery" name="clauseDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="适用范围" key="i18n_basicClauseManage_keyword"/>：</span>
	               	<input type="text" id="keywordQuery" name="keyword" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="条款大类" key="i18n_basicClauseManage_parentClauseDesc"/>：</span>
					<input type="text" id="parentClauseDescQuery" name="parentClauseDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="语言" key="i18n_js_language"/>：</span>
					<select id="languageQuery">
							<option value=""><i18n:I18n defaultValue="请选择" key=""></i18n:I18n></option>
							<option value="zh_cn" selected="selected"><i18n:I18n defaultValue="简体中文" key="i18n_login_chinese"></i18n:I18n></option>
							<option value="en"><i18n:I18n defaultValue="English" key="i18n_common_title_en"></i18n:I18n></option>
							<option value="zh_tw"><i18n:I18n defaultValue="繁体中文" key="i18n_common_title_zh_tw"></i18n:I18n></option>
					</select>
				</div>
                <div class="dis-in-b input-and-tip">
                	<input type="radio" name="statusQuery" value="1" checked="checked" />
					<i18n:I18n defaultValue="有效" key="i18n_basicClauseManage_enabled"/>
					<input type="radio" name="statusQuery" value="0"/>
					<i18n:I18n defaultValue="无效" key="i18n_basicClauseManage_disabled"/> 
                </div><br/>
                <div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_createdate" defaultValue="创建时间" />:</span>
	                <input type="radio" name="dateArea" value="lastMonth" checked="checked"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
	                <input type="radio" name="dateArea" value="lastThreeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
	                <input type="radio" name="dateArea" value="defineDateArea"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
				</div>
                <div class="dis-in-b input-and-tip" style="display:none;">
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="fromCreateDate" name="fromCreateDate"/>
                </div>
                <div class="dis-in-b input-and-tip" style="display:none;">
	                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="toCreateDate" name="toCreateDate" />
                </div>
                <button  id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
            	<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
			</div>
		</div>
		</form>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_basicClauseManage_clauseInfo" defaultValue="条款信息" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100">
							<table id="clauseTable"></table>
							<div id="enquiryPage" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_basicClauseManage_clausePeggingInfo" defaultValue="反查使用" /></span>
			<div class="common-box-line">
				<main class="grid-container">
					<div class="grid-100">
						<table id="peggingTable"></table>
						<div id="peggingPage" style="text-align: right;"></div>
					</div>
				</main>
			</div>
		</div>
	<!-- 对话框 -->
	<div class="fixed-dialog" id="dia">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="<%=basePath%>/icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></span>
			</div>
			<div class="mt-40" >
				<div class="box-wrap pos-relative bg-common">
				   <form id="clauseForm">
				   <input type="hidden" name="selectedIndex" id="selectedIndex"/>
				    <div style="width:360px; height:225px; overflow-y:scroll;">
					<table>
						<tr style="display: none">
							<td align="right"><span><i18n:I18n key="i18n_label_elsAccount" defaultValue="ELS帐号" />：</span></td>
							<td align="left"><input id="elsAccount" name="elsAccount" type="hidden" value = "<%=session.getAttribute("elsAccount")%>"/></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_basicClauseManage_clauseNumber" defaultValue="条款编码" />：</span></td>
							<td align="left"><input id="clauseNumber" name="clauseNumber" type="text"  readonly = "readonly"/></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_basicClauseManage_language" defaultValue="语言" />：</span></td>
							<td align="left"><input id="language" name="language" type="text"/></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_basicClauseManage_parentClauseDesc" defaultValue="条款大类" />：</span></td>
							<td align="left"><input id="parentClauseDesc" name="parentClauseDesc" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_basicClauseManage_keyword" defaultValue="适用范围" />：</span></td>
							<td align="left"><input id="keyword" name="keyword" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_label_remark" defaultValue="备注" />：</span></td>
							<td align="left"><input id="remark" name="remark" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_basicClauseManage_clauseDesc" defaultValue="条款描述" />：</span></td>
							<td align="left"><textarea style="width: 148px;height: 100px;" id="clauseDesc" name="clauseDesc"></textarea></td>
						</tr>
					</table>
					</div>
				   </form>
					<div class="mt-40">
						<button id="okBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="cancelBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>

<script>
	var type="";
	var elsAccount = <%=session.getAttribute("elsAccount")%>;
	var language = "<%=session.getAttribute("language")%>";
	var jsonOperateObject = {"i":[],"u":[],"d":[]};
	var flag = true;
	//条款状态
	var showClauseStatus = function (val,item,index){
		//0:无效  1:有效
		if (val == "1"){ return '<i18n:I18n key="i18n_basicClauseManage_enabled" defaultValue="有效" />'}
		else {return '<i18n:I18n key="i18n_basicClauseManage_disabled" defaultValue="无效" />'}
	};
	//是否已使用
	var isUsedRenderer = function (val,item,index){
		//0:未使用  1:已使用
		if (val == "1"){ return '<i18n:I18n key="" defaultValue="已使用" />'}
		else {return '<i18n:I18n key="" defaultValue="未使用" />'}
	};
	//列自定义
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'subAccountColumnSetting',
	        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=basicContractClauseManage" + "&window=iframeApp_basicContractClauseManage",
	        windowMinWidth: 480,
	        windowMinHeight: 600,
	        'windowWidth':480,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	//日期
	var formatDate = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};
	//条款标题
	var clauseCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="basicContractClauseManage"/>;
	//条款表
	var clauseGrid = $("#clauseTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/ContractManageService/queryClauseByCondition",
		method :  "POST",
		height : 250,
		cols : clauseCols,
		autoLoad : false,
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
		checkCol : true,
		plugins : [ 
			$('#enquiryPage').mmPaginator({
				style: 'plain', 
				totalCountName: 'total',
				page: 1, 
				pageParamName: 'currentPage',
				limitParamName: 'pageSize',
				limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />',
				totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />', 
				limit: null,
				limitList: [10, 20, 30, 40]
			})
		]
	});
	//反查表标题
	var peggingCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="contractClausePegging"/>;
	//反查表
	var peggingGrid = $("#peggingTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/ContractManageService/clausePegging",
		method :  "POST",
		autoLoad : false,
		height : 250,
		cols : peggingCols,
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
		checkCol : true,
		indexCol : false,
		plugins : [ 
			$('#peggingPage').mmPaginator({
				style: 'plain', 
				totalCountName: 'total',
				page: 1, 
				pageParamName: 'currentPage',
				limitParamName: 'pageSize',
				limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />',
				totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />', 
				limit: null,
				limitList: [10, 20]
			})
		]
	});
	//反查使用
	$("#pegging").click(function() {
		if(flag==false){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="选择确定则修改的信息不会被保存，是否继续选择反查？" />',
				closeEvent:function(){
					refreshPeggingGird();
					refreshClauseGird();
					flag=true;
					clearJsonOperateObject();
			}});
		}else{
			refreshPeggingGird();
		}
	});
	//删除条款信息
	$("#deleteBtn").live("click", function(){
		if(clauseGrid.selectedRows()==""){
			alert("你未选中任何一行数据!");
		}else{
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认刪除？" />',closeEvent:function(){
			rowIndexSelects=clauseGrid.selectedRowsIndex();
	    	rowSelects=clauseGrid.selectedRows();
	    	alert(rowSelects);jsonOperateObject.d.push(JSON.stringify(rowSelects[0]));
			clauseGrid.removeRow(rowIndexSelects[0]);
			flag = false;
		}}); 
		}
	});
	//点击更改条款状态按钮
	$("#updateStatusBtn").live("click", function() {
		if(flag==false){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="选择确定则修改的信息不会被保存，是否继续选择更改状态？" />',
				closeEvent:function(){
					updateStatus();
					flag=true;
					clearJsonOperateObject();
			}});
		}else{
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_updateStatus" defaultValue="是否确认更改状态？" />',closeEvent:function(){
				updateStatus();	
			}});
		}
	});
	//更改条款状态
	function updateStatus(){
		var selectedClause=clauseGrid.selectedRows();
		data={
			elsAccount : elsAccount,
			clauseNumber : selectedClause[0].clauseNumber,
			language : selectedClause[0].language,
			status : selectedClause[0].status
		}
		$.ajax({
	 		url : '<%=basePath%>rest/ContractManageService/updateStatus',
	 		type : 'POST',
	 		contentType : "application/json",
	 		data : JSON.stringify(data),
	 		dataType : "json",
	 		success : function(data) {
	 			refreshClauseGird();
		 		alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功!" />',1);
	 		},
	 		error : function(data) {
	 			alert('<i18n:I18n key="i18n_label_operationfailed" defaultValue="操作失败!" />',3);
	 		},
	 		complete : function(data) {
	    		parent.elsDeskTop.hideLoading();
	    	}
	 	});
	}
	//添加
	$("#addBtn").click(function() {
		type="add";
		initDig(null);
	});
	//修改
	$('#updateBtn').live("click", function() {
		type="edit";
		initDig(1);
	});
	//初始化对话框
	function initDig(status){
		if(status==null){//添加
			$("#clauseNumber").attr({ readonly: 'true' });
		    $("#elsAccount").val(elsAccount);
		    $("#clauseNumber").val(""); 
			$("#parentClauseDesc").val("");  
			$("#clauseDesc").val("");
			$('#keyword').val("");
			$('#fbk1').val("");
			$("#language").val(language);
			$("#remark").val("");
		}else{//修改
			if(clauseGrid.selectedRows()==""){
				alert("你未选中任何一行数据!");
				return;
			}else{
				$("#clauseNumber").attr({ readonly: 'true' });
				var selectedRows=clauseGrid.selectedRows();
				var selectedIndexs=clauseGrid.selectedRowsIndex();
				$("#selectedIndex").val(selectedIndexs[0]);
				$("#elsAccount").val(elsAccount);
				$('#clauseNumber').val(selectedRows[0].clauseNumber);
				$('#language').val(selectedRows[0].language);
				$('#parentClauseDesc').val(selectedRows[0].parentClauseDesc);
				$('#clauseDesc').val(selectedRows[0].clauseDesc);
				$('#keyword').val(selectedRows[0].keyword);
				$('#fbk1').val(selectedRows[0].fbk1);
				$('#remark').val(selectedRows[0].remark);
			}
		}
		$('#dia').show();
	}
	//关闭对话框
	$("#cancelBtn,.dialog-close-btn").click(function() {
		$('#dia').hide();
	});
	//确定按钮
	$("#okBtn").click(function(){
		var elsAccount = $("#elsAccount").val();
		var language = $("#language").val();
		var clauseNumber = $("#clauseNumber").val();
		var keyword = $("#keyword").val();
	   	var fbk1 = $("#fbk1").val();
	   	var clauseDesc = $("#clauseDesc").val();
	   	var parentClauseDesc = $("#parentClauseDesc").val();
	   	var remark = $("#remark").val();
	   	var selectedIndex = $("#selectedIndex").val();//选择行下标
	   	var data = {
   			elsAccount : elsAccount,
   			language : language,
   			clauseNumber : clauseNumber,
   			keyword : keyword,
   			status : "1",
   			fbk1 : fbk1,
   			clauseDesc : clauseDesc,
   			remark : remark,
   			parentClauseDesc : parentClauseDesc,
	   	};
		if($("#clauseNumber").val()=="" || $("#clauseNumber").val()==null){
			clauseGrid.addRow(data,0);
			jsonOperateObject.i.push(JSON.stringify(data));
			$('#dia').hide();
			flag = false;
		}else{
			clauseGrid.updateRow(data,selectedIndex);
			jsonOperateObject.u.push(JSON.stringify(data));
			$('#dia').hide();
			flag = false;
		}
	});
	//保存
	$("#saveBtn").click(function(){
		if(flag==false){
		   	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
			 	$.ajax({
			 		url : '<%=basePath%>rest/ContractManageService/addUpdateDeleteClause',
			 		type : 'POST',
			 		contentType : "application/json",
			 		data : JSON.stringify(jsonOperateObject),
			 		dataType : "json",
			 		success : function(data) {
			 			refreshClauseGird();
			 			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功!" />',1);
			 			flag = true;
			 			clearJsonOperateObject();
			 		},
			 		error : function(data) {
			 			alert('<i18n:I18n key="i18n_label_operationfailed" defaultValue="操作失败!" />',3);
			 		},
			 		complete : function(data) {
			    		parent.elsDeskTop.hideLoading();
			    	}
			 	});
			}});
		}else{
			alert("没有需要保存的数据！");
		}
	});
	//清除jsonOperateObject对象
	function clearJsonOperateObject(){
		jsonOperateObject.i=[];
		jsonOperateObject.u=[];
		jsonOperateObject.d=[];
	}
	//初始化
	$(document).ready(function(){
		$("input[name='dateArea']").click(function(){//初始化创建日期条件
			var dateArea = $(this).val();
			var currDate = new Date();
			
			if("lastMonth" == dateArea){
				$("#fromCreateDate").parent().hide();
				$("#toCreateDate").parent().hide();
				
			    var currDateMill = currDate.getTime();
				var startDate = new Date();
			    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
			    var currMonthMaxDay = startDate.getDate();//本月天数
			    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
			    
				$("#fromCreateDate").val(startDate.format("yyyy-MM-dd"));
				$("#toCreateDate").val(currDate.format("yyyy-MM-dd"));
			} else if("lastThreeMonth" == dateArea){
				$("#fromCreateDate").parent().hide();
				$("#toCreateDate").parent().hide();
				
				var currDateMill = currDate.getTime();
				var startDate = new Date();
			    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
			    var currMonthMaxDay = startDate.getDate();//本月天数
			    startDate.setMonth(currDate.getMonth(), 0);//上月最后一日
			    var lastMonthMaxDay = startDate.getDate();//上月天数
			    startDate.setMonth(currDate.getMonth()-1, 0);//前第二月最后一日
			    var last2MonthMaxDay = startDate.getDate();//前第二月天数
			    
			    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay+lastMonthMaxDay+last2MonthMaxDay-1));
				$("#fromCreateDate").val(startDate.format("yyyy-MM-dd"));
				$("#toCreateDate").val(currDate.format("yyyy-MM-dd"));
			} else if("defineDateArea" == dateArea) {
				$("#fromCreateDate").val("");
				$("#toCreateDate").val("");
				$("#fromCreateDate").parent().show();
				$("#toCreateDate").parent().show();
			} else {//默认查最近一月
				$("#fromCreateDate").parent().hide();
				$("#toCreateDate").parent().hide();
				
				var currDateMill = currDate.getTime();
				var startDate = new Date();
			    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
			    var currMonthMaxDay = startDate.getDate();//本月天数
			    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
			    
				$("#fromCreateDate").val(startDate.format("yyyy-MM-dd"));
				$("#toCreateDate").val(currDate.format("yyyy-MM-dd"));
			}
		});
		flag = true;
		refreshClauseGird();
		refreshPeggingGird();
		clearJsonOperateObject();
	});
	
	//查询
	$("#queryBtn").click(function(){
		if(flag==false){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="选择确定则修改的信息不会被保存，是否继续选择查询？" />',
				closeEvent:function(){
					refreshClauseGird();
					flag=true;
					clearJsonOperateObject();
			}});
		}else{
			refreshClauseGird();
		}
	});
	//刷新条款表
	function refreshClauseGird(){
		$.extend(clauseGrid.opts.params,queryParamSelect());
		clauseGrid.load();
	}
	//刷新反查表
	function refreshPeggingGird(){
		$.extend(peggingGrid.opts.params,queryParamSelect());
		peggingGrid.load();
	}
	//查询条件
	function queryParamSelect() {
		var clauseDesc = $("#clauseDescQuery").val();
		var parentClauseDesc = $("#parentClauseDescQuery").val();
		var language = $("#languageQuery").val();
		var fromCreateDate = $("#fromCreateDate").val();
		var toCreateDate = $("#toCreateDate").val();
		var status = $('input[name="statusQuery"]:checked').val();
		var keyword = $("#keywordQuery").val();
				
		var queryParam = {
			elsAccount : elsAccount,
			clauseDesc : clauseDesc,
			keyword : keyword,
			parentClauseDesc : parentClauseDesc,
			fromCreateDate : fromCreateDate,
			toCreateDate : toCreateDate,
			keyword : keyword,
			language : language,
			status : status
	    };
		return queryParam;
		
	}
			      			 
</script>
</body>
</html>