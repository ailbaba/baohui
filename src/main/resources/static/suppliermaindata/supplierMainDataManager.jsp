<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String elsAccountNumber = request.getParameter("elsAccountNumber");
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style>
table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">  
				<button class="button-wrap" id="queryHeadBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				<button class="button-wrap" id="updateBtn"><i18n:I18n key="test" defaultValue="更新" /></button>
				<button class="button-wrap" id="updateBtnExtend" ><i18n:I18n key="test" defaultValue="扩展" /></button>
				<button class="button-wrap" id="ColumnDefineBtn" ><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<button id="frozenBtn" class="button-wrap">冻结</button>
<!-- 				<button id="exitBtn" class="button-wrap">退出</button> -->
				<button id="downloadBtn" class="button-wrap"><i18n:I18n key="" defaultValue="导出EXCEL" /></button>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<form id="queryForm">
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_enquiry_label_toElsAccount" defaultValue="供应商Els帐号" /></span>
					<input type="text" id="friendElsAccount" name="friendElsAccount" />
					<span><i18n:I18n key="i18n_enquiry_label_supplierName" defaultValue="供应商名称" /></span>
					<input type="text" id="companyShortName" name="companyShortName" />
					<span><i18n:I18n key="i18n_enquiry_label_ErpSupplierCode" defaultValue="ERP供应商编码" /></span>
					<input type="text" id="vender" name="vender" />
				</div>
			</div>
			</form>
		</div>
		
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="供应商主数据表" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="mainDataGrid">
							<table id="mainDataTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 对话框 -->
	<div class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="<%=basePath%>/icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_label_settings" defaultValue="设置" /></span>
			</div>
			<div class="mt-40">
				<div class="box-wrap pos-relative bg-common">
				   <form id="VenderForm">
					<table>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_label_enquiryElsAccount" defaultValue="采购方ELS帐号" />：</span></td>
							<td align="left"><input id="elsAccount" name="elsAccount" type="text"  value = "<%=session.getAttribute("elsAccount")%>"/></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_label_enquiryCompanyName" defaultValue="采购方公司名称" />：</span></td>
							<td align="left"><input id="fbk2" name="fbk2" type="text"  readonly = "readonly"   value = "<%=session.getAttribute("companyShortName")%>"/></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_enquiry_label_toElsAccount" defaultValue="供应商Els帐号" />：</span></td>
							<td align="left"><input id="toElsAccount" name="toElsAccount" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_enquiry_label_supplierName" defaultValue="供应商名称" />：</span></td>
							<td align="left"><input id="companyShortName" name="companyShortName" type="text"   readonly = "readonly"/></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_enquiry_label_ErpSupplierCode" defaultValue="ERP供应商编码" />：</span></td>
							<td align="left"><input id="vender" name="vender" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_label_ErpSystem" defaultValue="ERP系统" />：</span></td>
							<td align="left"><input id="fbk1" name="fbk1" type="text" /></td>
						</tr>
					</table>
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
	 var mainDataGrid;
	 var type="";
	 //分类1-5的存放字典
	 var class1List = [];
	 var class2List = [];
	 var class3List = [];
	 var class4List = [];
	 var class5List = [];
	 var elsAccountNumber = '<%=elsAccountNumber%>';
	 if(elsAccountNumber!='null'&&elsAccountNumber!=null&&elsAccountNumber!=''){
		 $("#friendElsAccount").val(elsAccountNumber);
	 }
	  
	 //初始化记载信息 
	$(document).ready(function(){
		$('.mmg-title:first').text('');
		//加载分类渲染数据 
			initClass1();
			initClass2();
			initClass3();
			initClass4();
			initClass5();
	});
	  
 
    //模板下载
   $("#excelModelExport").click(function(){
	    var filePath = "template/供应商关系模板.xlsx";
		window.location.href = "<%=basePath%>" + filePath;
	});
	 
    // 渲染   @author jiangzhidong 20160120  begin
	//只允许数字输入框
	var initInputNumber = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var initInputAny = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var enquiryHandle2 = function(val,item,index){
		if(!val) { val = '';}
		return '记录'+index;
	};
	//时间
	var formatDateTime = function (val,item,index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
		return val;
	};
	//单据状态
	var initStandardStatus = function (val,item,index){
		//0:未发送 1:已发送2：已撤回3：已作废 4:已回复  5:部分评分6：全部评分
		if (val == "0") {
			return '<i18n:I18n key="i18n_label_notSent" defaultValue="未发送" />';
		}else if (val == "1"){
			return '<i18n:I18n key="i18n_label_Sent" defaultValue="已发送" />';
		}else if (val == "2"){
			return '<i18n:I18n key="test" defaultValue="已撤回" />';
		}
		else if (val == "3"){
			return '<i18n:I18n key="test" defaultValue="已作废" />';
		}
		else if (val == "4"){
			return '<i18n:I18n key="test" defaultValue="已回复" />';
		}
		else if (val == "5"){
			return '<i18n:I18n key="test" defaultValue="部分评分" />';
		}
		else if (val == "6"){
			return '<i18n:I18n key="test" defaultValue="全部评分" />';
		}
	};
	//供应商分类   0-供应商  1-潜在供应商  2-陌生供应商  3-失效供应商
	var initFirstType = function (val,item,index){
		if (val == "0") return '<i18n:I18n key="test" defaultValue="供应商" />' ;
		else if (val == "1") return '<i18n:I18n key="test" defaultValue="潜在供应商" />' ; 
		else if (val == "2") return '<i18n:I18n key="test" defaultValue="陌生供应商" />' ;
		else if (val == "3") return '<i18n:I18n key="test" defaultValue="失效供应商" />' ;
	};
	// 冻结状态
	var initFrozenStatus = function (val,item,index){
		if (val == "" || val == null) return '<i18n:I18n key="" defaultValue="正常" />' ;
	}
	//准入类型  1:新增准入 2:变更准入 3:公开招投标准入
	var initStandardType = function (val,item,index){
		     if (val == "1") return '<i18n:I18n defaultValue='新增准入' key='test'/>'   ;
		else if (val == "2") return '<i18n:I18n defaultValue='变更准入' key='test'/>'     ;
		else if (val == "3") return '<i18n:I18n defaultValue='公开招标准入' key='i18n_common_title_Opentenderaccess'/>' ;
		
	};
	//审批状态
	var initAuditStatus = function (val,item,index){
		//0:审批通过  1:未审批  2:审批中  3:审批拒绝
		if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" />'
		else if (val == "1") return '<i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" />'
		else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
		else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" />';
	};
	//准入单号
	var initStandardNumber = function (val,item,index){
		if (!val) {val = "";}
		return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	
	//渲染分类1
	var class1initValue = function(val,item,index){
		if(!val) val='';
		for(var i = 0;i<class1List.length;i++){
			if(val==class1List[i].dictionaryKey){
				return '<span>  ' + class1List[i].dictionaryValue+'</span>';
			}else{
				return '<span></span>'
			}
		}
	}
	
	//渲染分类2
	var class2initValue = function(val,item,index){
		if(!val) val='';
		for(var i = 0;i<class2List.length;i++){
			if(val==class2List[i].dictionaryKey){
				return '<span>  ' + class2List[i].dictionaryValue+'</span>';
			}else{
				return '<span></span>'
			}
		}
	}
	
	//渲染分类3
	var class3initValue = function(val,item,index){
		if(!val) val='';
		for(var i = 0;i<class3List.length;i++){
			if(val==class3List[i].dictionaryKey){
				return '<span>  ' + class3List[i].dictionaryValue+'</span>';
			}else{
				return '<span></span>'
			}
		}
	}
	
	//渲染分类4
	var class4initValue = function(val,item,index){
		if(!val) val='';
		for(var i = 0;i<class4List.length;i++){
			if(val==class4List[i].dictionaryKey){
				return '<span>  ' + class4List[i].dictionaryValue+'</span>';
			}else{
				return '<span></span>'
			}
		}
	}
	
	//渲染分类5
	var class5initValue = function(val,item,index){
		if(!val) val='';
		for(var i = 0;i<class5List.length;i++){
			if(val==class5List[i].dictionaryKey){
				return '<span>  ' + class5List[i].dictionaryValue+'</span>';
			}else{
				return '<span></span>'
			}
		}
	}
	
	
	// 渲染   @author jiangzhidong 20160120  end
	
var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="supplierMainDataManage_mt"/>;
/*   var cols = [ {title:'<i18n:I18n key="i18n_common_label_elsAccount" defaultValue="ELS帐号" />', name:'elsAccount', width: 120, align: 'center',hidden:true},
    	      {title:'<i18n:I18n key="i18n_materialRelation_title_purchaseName" defaultValue="采购方名称" />', name:'fbk2', width: 120, align: 'center',hidden:true},
    	      {title:'<i18n:I18n key="i18n_enquiry_label_toElsAccount" defaultValue="供应商Els帐号" />', name:'toElsAccount' ,width:120, align:'center' },
    	      {title:'<i18n:I18n key="i18n_enquiry_label_supplierName" defaultValue="供应商名称" />', name:'companyShortName', width: 200, align: 'center'},
    	      {title:'<i18n:I18n key="i18n_enquiry_label_ErpSupplierCode" defaultValue="ERP供应商编码" />', name:'vender', width: 120, align: 'center'},
    	      {title:'<i18n:I18n key="i18n_common_label_ErpSystem" defaultValue="ERP系统" />', name:'fbk1', width: 150, align: 'center'},
    	      {title:'<i18n:I18n key="test" defaultValue="准入评估单号" />', name:'standardNumber', width: 150, align: 'center',renderer:initStandardNumber},
    	      { title:'<i18n:I18n key="i18n_common_title_Accesstype" defaultValue="单据类型" />', name:'standardType' ,width:70, align:'center',renderer:initStandardType},
    	      { title:'<i18n:I18n key="i18n_lable_deliverystatus" defaultValue="单据状态" />', name:'standardStatus' ,width:60, align:'center', renderer:initStandardStatus},
    	      { title:'<i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />', name:'auditStatus' ,width:80, align:'center', renderer:initAuditStatus},
    	      {title:'<i18n:I18n key="test" defaultValue="删除状态" />', name:'deleteStatus', width: 150, align: 'center'},
    	      {title:'<i18n:I18n key="test" defaultValue="冻结状态" />', name:'frozenStatus', width: 150, align: 'center'},
    	      {title:'<i18n:I18n key="test" defaultValue="一级类型" />', name:'firstType', width: 120, align: 'center'},
    	      {title:'<i18n:I18n key="test" defaultValue="分类一" />', name:'fbk11', width: 120, align: 'center',renderer:class1initValue},
    	      {title:'<i18n:I18n key="test" defaultValue="分类二" />', name:'fbk12', width: 120, align: 'center',renderer:class2initValue},
    	      {title:'<i18n:I18n key="test" defaultValue="分类三" />', name:'fbk13', width: 120, align: 'center',renderer:class3initValue},
    	      {title:'<i18n:I18n key="test" defaultValue="分类四" />', name:'fbk14', width: 120, align: 'center',renderer:class4initValue},
    	      {title:'<i18n:I18n key="test" defaultValue="分类五" />', name:'fbk15', width: 120, align: 'center',renderer:class5initValue},
    	      {title:'<i18n:I18n key="test" defaultValue="创建人" />', name:'', width: 150, align: 'center'},
    	      {title:'<i18n:I18n key="test" defaultValue="负责人" />', name:'fbk16', width: 150, align: 'center'},
    	      {title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />', name:'logtime' ,width:150, align:'center', renderer:formatDateTime},
    	    ];   */
 
    		var GobalparamStr={"elsAccount":elsAccount, "friendElsAccount":$("#friendElsAccount").val()};
    		var height=$(document).height()-155;
    		mainDataGrid= $('#mainDataTable').mmGrid({
    	    	 cols: cols,
    	         url: '<%=basePath%>rest/SupplierMainDataService/querySupplierMainDataReport',
    					params: GobalparamStr,
    					method: 'post',
    					height: 400,
    					root: "rows",
    					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
    			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
    					indexCol: true,
    				    checkCol:true,
    					plugins: [ $('#pg').mmPaginator({
    						style: 'plain',
    						totalCountName: 'total',
    						page: 1,
    						pageParamName: 'currentPage',
    						limitParamName: 'pageSize',
    						height:height,
    						limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />',
    			            totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />',
    						limit: null, 
    						limitList: [ 10, 20 , 30, 50]
    					}) ]
    				});

    				mainDataGrid.on('loadSuccess', function(e, data) {
    					 if (data.total > 0) {
    						mainDataGrid.select(0);
    					} 
    				});
    				
    				mainDataGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
      					$('body').data('mainDataItem',item);
    			    });
    	
		     //查询
			 $("#queryHeadBtn").click(function(){
				 	var formObj = $("#queryForm").serializeJSON();
					formObj["elsAccount"]=elsAccount;
					formObj["friendElsAccount"]=$("#friendElsAccount").val();
					formObj["companyShortName"]=$("#companyShortName").val();
					mainDataGrid.opts.params = formObj;
					mainDataGrid.load({page:1});
			  });
    				
			//扩展ERP数据
			$("#updateBtnExtend").click(function() {
				var selectRow = mainDataGrid.selectedRows();
				if(selectRow.length<=0){
					alert("请选择对应的行项目",2);
					return;
				}
				var toElsAccount = selectRow[0].toElsAccount;
				var toCompanyName = selectRow[0].companyShortName;
				var vender = selectRow[0].vender;
				if(vender==''||vender==null){
					alert("ERP供应商编码为空,不能执行操作!");
					return;
				}
				parent.elsDeskTop.defineWin({
				    'iconSrc':'icon/els-icon.png',
				    'windowsId':'supplierMainDataExtend',
				    'windowTitle':'<i18n:I18n key="test" defaultValue="供应商扩展" />',
				    windowSubTitle: "",
				    'iframSrc':'<%=basePath%>suppliermaindata/supplierMainDataExtend.jsp?elsAccount=' + elsAccount
				    		+"&toElsAccount=" + toElsAccount
				    		+"&vender=" +vender,
				    windowMinWidth: 1000,
				    windowMinHeight: 300,
				    'windowWidth':1000,
				    'windowHeight':300,
				    'parentPanel':".currDesktop"
				 });
				});
				
			//修改
			$('#updateBtn').live("click", function() {
				var selectRow = mainDataGrid.selectedRows();
				if(selectRow.length<=0){
					alert("请选择对应的行项目",2);
					return;
				}
				var toElsAccount = selectRow[0].toElsAccount;
				var toCompanyName = selectRow[0].companyShortName;
				var vender = selectRow[0].vender;
				parent.elsDeskTop.defineWin({
				    'iconSrc':'icon/els-icon.png',
				    'windowsId':'supplierMainDataUpd',
				    'windowTitle':'<i18n:I18n key="test" defaultValue="供应商更新" />',
				    windowSubTitle: "",
				    'iframSrc':'<%=basePath%>suppliermaindata/supplierMainDataUpd.jsp?elsAccount=' + elsAccount 
				    +"&toElsAccount=" + toElsAccount
		    		+"&vender=" +vender,
				    windowMinWidth: 1000,
				    windowMinHeight: 600,
				    'windowWidth':1000,
				    'windowHeight':600,
				    'parentPanel':".currDesktop"
				 });
			});
			
			//双击
			$('#mainDataGrid').on('dblclick','tr',function() {
				var mainData = $('body').data('mainDataItem');
				var toElsAccount = mainData.toElsAccount;
				var toCompanyName = mainData.companyShortName;
				var vender = mainData.vender;
				parent.elsDeskTop.defineWin({
				    'iconSrc':'icon/els-icon.png',
				    'windowsId':'supplierMainDataUpd',
				    'windowTitle':'<i18n:I18n key="test" defaultValue="供应商更新" />',
				    windowSubTitle: "",
				    'iframSrc':'<%=basePath%>suppliermaindata/supplierMainDataUpd.jsp?elsAccount=' + elsAccount 
				    +"&toElsAccount=" + toElsAccount
		    		+"&toCompanyName=" + toCompanyName
		    		+"&vender=" +vender,
				    windowMinWidth: 1000,
				    windowMinHeight: 600,
				    'windowWidth':1000,
				    'windowHeight':600,
				    'parentPanel':".currDesktop"
				 });
			});

			//确定
			$("#okBtn").click(function() {
				if(type=="add"){
					addProc();
				}else if(type=="edit"){
					editProc();
				}
			});
			
			//关闭对话框
			$("#cancelBtn,.dialog-close-btn").click(function() {
				$('.fixed-dialog').hide();
			});
			
			//初始化对话框
			function initDig(status){
				if(status==null){//添加
				    $("#elsAccount").attr({ readonly: 'true' });
				    $("#elsAccount").val(elsAccount);
					
					$("#toElsAccount").removeAttr("readonly"); 
					$("#dialogTitle").html('<i18n:I18n key="i18n_common_label_addition" defaultValue="添加" />');
					$("#toElsAccount").val("");
					//$('#companyShortName').val("");
					$('#vender').val("");
					$('#fbk1').val("");
				}else{//修改
					$("#elsAccount").attr({ readonly: 'true' });
					$("#toElsAccount").attr({ readonly: 'true' });
					var selectedRows=mainDataGrid.selectedRows();
					$("#dialogTitle").html('<i18n:I18n key="i18n_label_update" defaultValue="修改" />');
					$("#elsAccount").val(selectedRows[0].elsAccount);
					$("#toElsAccount").val(selectedRows[0].toElsAccount);
					//供应商名称
					var name = $('#companyShortName').val();
					if(name!=""&&name!=null){
						$('#companyShortName').val(selectedRows[0].companyShortName);
					}else{
						findSupplyName(selectedRows[0].elsAccount);
					}
					//采购方名称 
					var elsName = $('#fbk2').val();
					if(elsName!=""&&elsName!=null){
						$('#fbk2').val(selectedRows[0].fbk2);
					}else{
						findSupplyName(selectedRows[0].elsAccount);
					}
					$('#vender').val(selectedRows[0].vender);
					$('#fbk1').val(selectedRows[0].fbk1);
					
				}
				$('.fixed-dialog').show();
			}
			
			//加载els子帐号
// 			$('#friendElsAccount').keyup( function() {
// 				var elsAccount = $('#friendElsAccount').val();
// 				findSupplyName(elsAccount);
// 			});
			
			
			//添加过程
			function addProc(){
				var elsAccount=$("#elsAccount").val();
				
				var toElsAccount=$("#toElsAccount").val();
				var companyShortName = $("#companyShortName").val();
				var supplierCode =$("#vender").val();
				var erpName =$("#fbk1").val();
				
				if(elsAccount==null||elsAccount.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_elsAccountNotNull" defaultValue="采购方ELS帐号,不能为空!" />',2);
					return;
				}
				if(toElsAccount==null||toElsAccount.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_toElsAccountNotNull" defaultValue="供应商Els帐号,不能为空!" />',2);
					return;
				}
				if(supplierCode==null||supplierCode.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_ErpCodeNotNull" defaultValue="ERP编码 ,不能为空!" />',2);
					return;
				}
				
				
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmAddition" defaultValue="是否确认添加?" />',closeEvent:function(){
				var paramStr = $("#VenderForm").serializeJSON();
				$.ajax({
		    		url: '<%=basePath%>rest/SupplierService/insertSupplier',
		    		type:"post",
		    		contentType: "application/json",
		    		data: JSON.stringify(paramStr),
		    		dataType: "json",
		    		success: function(data) {
						if(data.statusCode==-100){
		    				alert(data.message,3);
		    			}else{
		    				mainDataGrid.load(GobalparamStr);
		    				$('.fixed-dialog').hide();
		    				alert('<i18n:I18n key="i18n_common_alert_addsuccess" defaultValue="添加成功!" />',1);
		    			}
		    		},
		    		error: function(data) {
		    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
		    		}
		    	}); 
				}});
			}
			
			//修改过程 
			function editProc(){
				//将对应的采购id和供应商id设置为只读 
		
				var elsAccount=$("#elsAccount").val();
				var toElsAccount=$("#toElsAccount").val();
				var companyShortName =  $("#companyShortName").val();
				var vender =$("#vender").val();
				var erpName = $("#fbk1").val();
				
				if(elsAccount==null||elsAccount.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_elsAccountNotNull" defaultValue="采购方ELS帐号,不能为空!" />',2);
					return;
				}
				if(toElsAccount==null||toElsAccount.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_toElsAccountNotNull" defaultValue="供应商Els帐号,不能为空!" />',2);
					return;
				}
				if(vender==null||vender.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_ErpCodeNotNull" defaultValue="ERP编码 ,不能为空!" />',2);
					return;
				}
				
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_label_confirmmodification" defaultValue="是否确认修改?" />',closeEvent:function(){
				var paramStr = $("#VenderForm").serializeJSON();
				//var paramStr = {"elsAccount":elsAccount, "toElsAccount":toElsAccount,"companyShortName":companyShortName,"vender":vender};
				$.ajax({
		    		url: '<%=basePath%>rest/SupplierService/updateSupplier',
		    		type:"post",
		    		contentType: "application/json",
		    		data: JSON.stringify(paramStr),
		    		dataType: "json",
		    		success: function(data) {
		    			if(data.statusCode==-100){
		    				alert(data.message,3);
		    			}else{
		    				//insertTable();
		    				mainDataGrid.load(GobalparamStr);
		    				$('.fixed-dialog').hide();
		    				alert('<i18n:I18n key="i18n_common_alert_updatesuccess" defaultValue="修改成功!" />',1);
		    			}
		    		},
		    		error: function(data) {
		    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
		    		}
		    	}); 
				}});
			}
			
			//加载请求分类一的数据
			function  initClass1(){
				var param = {"elsAccount":elsAccount,"tableName":"supplier_main_data","fieldName":"fbk11"};
				$.ajax({
					url: "<%=basePath%>rest/ElsSearchDictionaryService/getDictionaryJson",
					type: "post",
					contentType: "application/json",
					dataType: "json",
					data : JSON.stringify(param),
					success: function(data) {
						class1List = data;
					}
				});
			}
			
			//加载请求分类二的数据
			function  initClass2(){
				var param = {"elsAccount":elsAccount,"tableName":"supplier_main_data","fieldName":"fbk12"};
				$.ajax({
					url: "<%=basePath%>rest/ElsSearchDictionaryService/getDictionaryJson",
					type: "post",
					contentType: "application/json",
					dataType: "json",
					data : JSON.stringify(param),
					success: function(data) {
						class2List = data;
					}
				});
			}
			
			//加载请求分类3的数据
			function  initClass3(){
				var param = {"elsAccount":elsAccount,"tableName":"supplier_main_data","fieldName":"fbk13"};
				$.ajax({
					url: "<%=basePath%>rest/ElsSearchDictionaryService/getDictionaryJson",
					type: "post",
					contentType: "application/json",
					dataType: "json",
					data : JSON.stringify(param),
					success: function(data) {
						class3List = data;
					}
				});
			}
			
			//加载请求分类4的数据
			function  initClass4(){
				var param = {"elsAccount":elsAccount,"tableName":"supplier_main_data","fieldName":"fbk14"};
				$.ajax({
					url: "<%=basePath%>rest/ElsSearchDictionaryService/getDictionaryJson",
					type: "post",
					contentType: "application/json",
					dataType: "json",
					data : JSON.stringify(param),
					success: function(data) {
						class4List = data;
					}
				});
			}
			
			//加载请求分类一的数据
			function  initClass5(){
				var param = {"elsAccount":elsAccount,"tableName":"supplier_main_data","fieldName":"fbk15"};
				$.ajax({
					url: "<%=basePath%>rest/ElsSearchDictionaryService/getDictionaryJson",
					type: "post",
					contentType: "application/json",
					dataType: "json",
					data : JSON.stringify(param),
					success: function(data) {
						class5List = data;
					}
				});
			}
			
		
			
			//查询企业名称
// 			function findSupplyName(elsAccount){
// 				$.ajax({
<%-- 						url:"<%=basePath%>rest/AccountService/queryPurchaseEnquirySupplyByCondtion", --%>
// 						type:"POST",
// 						contentType: "application/json",
// 						dataType: "json",
// 						data:JSON.stringify({"elsAccount":elsAccount}),
// 						success: function(data) {
// 							var option ="";
// 							if(data!=null&&data!="" ){
// 								var companyShortName = data["shortName"];
// 									$("#companyShortName").val(companyShortName);
// 							}
// 						},
// 						error: function (xhr, type, exception) {
// 			            	alert(xhr.responseText, "Failed"); 
// 			        	}
// 					});
// 			}
			
			//供应商冻结
			$("#frozenBtn").click(function(){
				var selectRow = mainDataGrid.selectedRows();
				if(selectRow.length<=0){
					alert("请选择行项目",2);
					return;
				}
				var toElsAccount = selectRow[0].toElsAccount;
				var companyShortName = selectRow[0].companyShortName;
				parent.elsDeskTop.defineWin({
				    'iconSrc':'icon/els-icon.png',
				    'windowsId':'supplierFrozen',
				    'windowTitle':'<i18n:I18n key="test" defaultValue="供应商冻结管理" />',
				    windowSubTitle: "",
				    'iframSrc':'<%=basePath%>supplierfrozen/supplierfrozenmanage.jsp?elsAccount=' + elsAccount
				    		+ "&toElsAccount=" + toElsAccount 
				    		+ "&companyShortName=" + companyShortName,
				    windowMinWidth: 1200,
				    windowMinHeight: 600,
				    'windowWidth':1200,
				    'windowHeight':600,
				    'parentPanel':".currDesktop"
				 });
				});
			
			window.purchQuery = function() {
				mainDataGrid.load({});
			}
			
			
			//列自定义
			$("#ColumnDefineBtn").click(function(){
				 parent.elsDeskTop.defineWin({
				     'iconSrc':'icon/els-icon.png',
				     'windowsId':'subAccountColumnSetting',
				     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
				     windowSubTitle: "",
				     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=supplierMainDataManage_mt" + "&window=iframeApp_SupplierMainDataManager",
				     windowMinWidth: 480,
				     windowMinHeight: 600,
				     'windowWidth':480,
				     'windowHeight':600,
				     'parentPanel':".currDesktop"
				  });
			});
			
			//导出excel
			$("#downloadBtn").click(function(){
				var formObj = $("#queryForm").serializeJSON();
				formObj["elsAccount"]=elsAccount;
				formObj["friendElsAccount"]=$("#friendElsAccount").val();
				formObj["companyShortName"]=$("#companyShortName").val();
				parent.elsDeskTop.showLoading();
				$.ajax({
					url :"<%=basePath%>rest/SupplierMainDataService/exportSupplierMainDataToExcel",
					dataType : "json",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(formObj),
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + data.message;
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						if (!permissionError(data)) {
							alert('<i18n:I18n key="" defaultValue="导出失败" />',3);
						}
					}
				});
			});
			
			//准入信息  查看
			$('.elsAccountBtn').live("click", function() {
				var editCol = $(this).next().text();
				var standardItem = JSON.parse(editCol);
				var url='<%=basePath%>supplierstandard/purchase/purchaseSupplyManagerDetail.jsp?standardNumber='+standardItem.standardNumber;
				parent.elsDeskTop.defineWin({
					'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
			        'windowsId':'purchaseSupplyManagerDetail',
			        'windowTitle':'<i18n:I18n defaultValue="准入评估信息" key="test"></i18n:I18n>',
			        'iframSrc':url,
			        windowStatus: 'regular',
			        windowMinWidth: 1000,
			        windowMinHeight: 550,
			        'windowWidth':1000,
			        'windowHeight':550,
			        windowPositionTop:25,
			        'parentPanel':".currDesktop"
			    });
			 });
			
			//退出
// 			$("#exitBtn").click(function(){
// 				parent.elsDeskTop.closeCurWin('supplierMainDataManager');
// 			});
			 
		</script>
</body>
</html>