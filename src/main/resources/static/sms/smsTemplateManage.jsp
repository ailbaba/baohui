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

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="短信模板编号" key="i18n_label_smsTemplate_templateNumber" />:</span>
					<input type="text" id="templateNumber" name="templateNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="短信模板名称" key="i18n_label_smsTemplate_templateName" />:</span>
					<input type="text" id="templateName" name="templateName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="短信模板描述" key="i18n_label_smsTemplate_templateDesc" />:</span>
					<input type="text" id="templateDesc" name="templateDesc" />
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n defaultValue="短信模板列表" key="i18n_title_smsTemplate_list" />
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
	
	var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="smsTemplateManage"/>;
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/ElsSmsTemplateService/querySmsTemplate",
		method :  "POST",
		autoLoad : false,
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
	        windowsId : "smsTemplateAdd",
	        windowTitle : "新建短信模板",
	        iframSrc : "${pageContext.request.contextPath}/sms/smsTemplateAdd.jsp",
	        showAdv : true,
	        windowStatus : "maximized",
	        windowMinWidth : 960,
	        windowMinHeight : 700,
	        windowWidth : 960,
	        windowHeight : 700,
	        parentPanel : ".currDesktop"
	    });
	});
	
	$("#updBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			if(selectRows.length == 1){
				var headRecord = selectRows[0];
				var templateNumber = headRecord.templateNumber;
				if( "undefined" != typeof(templateNumber) && templateNumber != ""){
					parent.elsDeskTop.defineWin({
				        iconSrc : "icon/icon9.png",
				        windowsId : "smsTemplateUpd",
				        windowTitle : "修改短信模板",
				        iframSrc : "${pageContext.request.contextPath}/sms/smsTemplateUpd.jsp?templateNumber="+templateNumber,
				        showAdv : true,
				        windowStatus : "maximized",
				        windowMinWidth : 960,
				        windowMinHeight : 700,
				        windowWidth : 960,
				        windowHeight : 700,
				        parentPanel : ".currDesktop"
				    });
				} else {
					parent.elsDeskTop.tip.init({type : "alert",displayType : 2,message : "短信模板号为空!"});
				}
			} else {
				parent.elsDeskTop.tip.init({type : "alert",displayType : 2,message : "不能同时修改多条!"});
			}
		}else {
			parent.elsDeskTop.tip.init({type : "alert",displayType : 2,message : "请选择修改短信模板单!"});
		}
	});
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			parent.elsDeskTop.tip.init({type:"confirm",message:"是否确认删除?",closeEvent:function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/ElsSmsTemplateService/delSmsTemplate",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(selectRows),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type:"alert",displayType:1,message:"删除成功!"});
						
						var selectedIndexes = headGrid.selectedRowsIndex();
						headGrid.removeRow(selectedIndexes);
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type:"alert",message:"删除失败!"});
					}
				});
			}});
		}else {
			parent.elsDeskTop.tip.init({type : "alert",displayType : 2,message : "请选择删除短信模板单!"});
		}
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
</script>
</body>
</html>