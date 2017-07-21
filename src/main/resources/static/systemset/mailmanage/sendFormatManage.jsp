<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" />
			</span>
			<div class="common-box-line">
				<button id="queryHeadBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query" /></button>
				<button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create" /></button>
				<button id="updBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update" /></button>
				<button id="delBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete" /></button>
				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom" /></button>
			</div>
		</div>

		<form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="邮件标题" key="i18n_label_smsTemplate_templateNumber" />:</span>
					<input type="text" id="templateNumber" name="templateNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="创建人" key="i18n_label_smsTemplate_templateName" />:</span>
					<input type="text" id="templateName" name="templateName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="创建时间" key="i18n_label_smsTemplate_templateDesc" />:</span>
					<input type="text" id="templateDesc" name="templateDesc" />
				</div>
			</div>
		</div>
		</form>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n defaultValue="邮箱模板列表" key="i18n_title_smsTemplate_list" />
			</span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100">
					<table id="headTable"></table>
					<div id="headPage" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>
	</div>
<script type="text/javascript">
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	
	// 渲染   @author jiangzhidong 20160314  begin
	//日期
	var formatDate = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};
	
	//邮箱类型
	var initMailType = function(val, item, index){
		if(!val) { val = '';}
		return ["POP3","IMAP","SMTP"][parseInt(val)];
	};
	// 渲染   @author jiangzhidong 20160314  end
	
	function rendererMailType(val){
		if(!val){
			return "";
		}
		if(val == "orderChange"){
			return "订单变更";
		}else if(val == "orderSend"){
			return "采购订单";
		}else if(val == "enquirySend"){
			return "询价单";
		}else if(val == "deliveryNote"){
			return "送货通知单";
		}else if(val == "deliveryNoteDel"){
			return "送货通知单删除";
		}
	}
	
	var headCols = [{title:'邮件编号', name:'formatId', width: 120, align: 'center'},
				{title:'ELS号码', name:'elsAccount', width: 120, align: 'center'},
				{title:'ELS子账号号码', name:'elsSubAccount', width: 120, align: 'center'},
				{title:'邮件类型', name:'mailType' ,width:120, align:'center' , renderer : rendererMailType},
				{title:'邮件标题', name:'mailTitle' ,width:120, align:'center'},
				{title:'邮件模板内容', name:'mailContent', width: 500, align: 'left'},
				{title:'邮件模板描述', name:'mailDesc', width: 250, align: 'center'},
				{title:'备注', name:'remark', width: 120, align: 'center'},
				{title:'创建人', name:'createUser', width: 120, align: 'center'},
				{title:'创建时间', name:'createDate', width: 250, align: 'center',renderer:formatDate}]; 
	
	var frm = $("#queryForm");
	var frmObj = frm.serializeJSON();
	frmObj["elsAccount"] = elsAccount;
	
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/MailInfoManageService/getMailSendFormatList",
		method :  "POST",
		params: frmObj,
		cols : headCols,
		height : "400px",
		root : "rows",
		loadingText : "正在载入",
		noDataText : "暂无数据",
		multiSelect : false,
	    checkCol : true,
	    indexCol : false,
		plugins : [
		    $("#headPage").mmPaginator({
		        style : "plain",
		        totalCountName : "total",
		        page : 1,
		        pageParamName : "currentPage",
		        limitParamName : "pageSize",
		        limitLabel : "每页{0}条",
		        totalCountLabel : "共<span>{0}</span>条记录",
		        limit : null,
		        limitList : [10,20]
		    })
		]
	});
	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	  	//初始化表头
	    var templateNumber = "${param.templateNumber}";
	    if("undefined"==typeof(templateNumber) || "null"==templateNumber){
	    	templateNumber="";
		} else {
			$("#templateNumber").val(templateNumber);
		}
				
		var queryParam = {
			templateNumber : templateNumber
	    };
	    headGrid.load(queryParam);
	}
	
	$("#queryHeadBtn").click(function(){
		var templateNumber = $("#templateNumber").val();
		
		var queryParam = {
			templateNumber : templateNumber
	    };
	    headGrid.load(queryParam);
	});
	
	$("#addBtn").click(function(){
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "sendFormatManageAdd",
	        windowTitle : "新建邮箱模板",
	        iframSrc : "${pageContext.request.contextPath}/systemset/mailmanage/sendFormatManageAdd.jsp",
	        showAdv : true,
	        windowStatus : "regular",
	        windowMinWidth : 900,
	        windowMinHeight : 600,
	        windowWidth : 900,
	        windowHeight : 600,
	        parentPanel : ".currDesktop"
	    });
	});
	
	$("#updBtn").click(function(){
		var head = headGrid.selectedRows();
		if(head.length<=0){
			alert("必须选择一行！",2);
			return;
		}
	 	var formatId=head[0].formatId;
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "sendFormatManageUpd",
	        windowTitle : "修改邮箱帐号",
	        iframSrc : "${pageContext.request.contextPath}/systemset/mailmanage/sendFormatManageUpd.jsp?formatId="+formatId,
	        showAdv : true,
	        windowStatus : "regular",
	        windowMinWidth : 900,
	        windowMinHeight : 600,
	        windowWidth : 900,
	        windowHeight : 600,
	        parentPanel : ".currDesktop"
	    });
	});
	
	$("#delBtn").click(function(){
		var head = headGrid.selectedRows();
		if(head.length<=0){
			alert("必须选择一行！",2);
			return;
		}
	 	var format=head[0];
		parent.elsDeskTop.tip.init({type:"confirm",message:"是否确认删除?",closeEvent:function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/MailInfoManageService/deleteMailSendFormat",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(format),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					parent.elsDeskTop.tip.init({type:"alert",displayType:1,message:"删除成功!"});
					headGrid.load({});
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					parent.elsDeskTop.tip.init({type:"alert",message:"删除失败!"});
				}
			});
		}});
	});
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"列自定义",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=smsTemplateManage&window=iframeApp_smsTemplateManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	window.purchQuery = function() {
		headGrid.load({});
	}
	
</script>
</body>
</html>