<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String standardNumber = request.getParameter("standardNumber"); %>
<%  String standardItemNumber = request.getParameter("standardItemNumber"); %>
<body>
	<div class="pos-relative ">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common">
			<i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" />
		</span>
		<div class="common-box-line">
			<button id="queryHeadBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query" /></button>
				<button id="addBtn"       class="button-wrap"><i18n:I18n defaultValue="新增" key="i18n_button_add" /></button>
				<button id="delBtn"       class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete" /></button>
				<button id="exitBtn"       class="button-wrap"><i18n:I18n defaultValue="退出" key="i18n_button_exit" /></button>
		</div>
	</div>
			<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<form id="queryForm">
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>电话:</span>
					<input type="text" id="telephone" name="telephone"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span>详细地址:</span>
					<input type="text" id="detailedAddress" name="detailedAddress" />
				</div>
			</div>
			</form>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				公司地址信息列表
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
	var elsAccount    = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc       = "${sessionScope.companyShortName}";
	var userName      = "${sessionScope.username}";
	var headGrid;
	var standardNumber     = '<%=standardNumber %>' ;
	var standardItemNumber = '<%= standardItemNumber%>' ;
	   var gobalStr           = {"elsAccount":elsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber} ;
	
	// 渲染   @author jiangzhidong 20160120  begin
	//只允许数字输入框
	var initInputNumber = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//企业名称
    var initCompanyName = function (val, item, index){
    	if(!val) { val = '';}
    	var name = this.name;
    	var value = this.value;
		return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
    }
	
    var initAddressInfo = function (val, item, index){
    	if(!val){
    		val ='';
    		return'<span>'+ val +'</span>';
    	}else if(val == "1"){
    		return '<span>'+ "工厂/办事处" +'</span>';
    	}else if(val == "2"){
    		return '<span>'+"办公区" +'</span>';
    	}
    }
    
    var initDefault = function (val, item, index){
    	if(!val){
    		val ='';
    		return'<span>'+ val +'</span>';
    	}
    	if(val == "1"){
    		return '<span>'+ "否" +'</span>';
    	}else if(val == "2"){
    		return '<span>'+ "是"  +'</span>';
    	}
    }
   
	// 渲染   @author jiangzhidong 20160120  end
    // var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="smsTemplateManage"/>;
	var headCols = [{title:'id', name:'communicationId', width: 120, align: 'center',hidden:true},
					{title:'ELS号码', name:'elsAccount', width: 120, align: 'center'},
					{title:'地址类型', name:'addressType', width: 120, align: 'center',renderer:initAddressInfo},
					{title:'国家', name:'countries' ,width:120, align:'center'},
					{title:'省', name:'provinces', width: 250, align: 'center'},
					{title:'城市', name:'city', width: 250, align: 'center'},
					{title:'详细地址', name:'detailedAddress', width: 250, align: 'center'},
					{title:'语言', name:'language', width: 250, align: 'center'},
					{title:'传真', name:'fax', width: 250, align: 'center'},
					{title:'电话', name:'telephone', width: 250, align: 'center'},
					{title:'是否默认', name:'isDefault', width: 250, align: 'center',renderer:initDefault},
					{title:'关联组织结构', name:'organization', width: 250, align: 'center'},
					{title:'时区', name:'timeZones', width: 250, align: 'center'},
					{title:'创建时间', name:'logtime', width: 250, align: 'center',renderer:function(val){ if (!val)  return ""; return new Date(val).format("yyyy-MM-dd hh:mm:ss");}},]; 
	
	
	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	   $("button").button();
	   var gobalStr           = {"elsAccount":elsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber} ;
	    headGrid = $("#headTable").mmGrid({
			url         : "${pageContext.request.contextPath}/rest/SupplierDataService/queryStandardCommunicationInfo/" ,
			method      : "POST",
			cols        :  headCols,
			params      :  gobalStr,
			height      : "400px",
			root        : "rows",
			loadingText : "正在载入",
			noDataText  : "暂无数据",
			checkCol    :  true,
			indexCol    :  false,
			plugins     : [
		    $("#headPage").mmPaginator({
		        style           : "plain",
		        totalCountName  : "total",
		        page            :  1,
		        pageParamName   : "currentPage",
		        limitParamName  : "pageSize",
		        limitLabel      : "每页{0}条",
		        totalCountLabel : "共<span>{0}</span>条记录",
		        limit           :  null,
		        limitList       : [10,20]
		   })]
	});
	   // headGrid.load(gobalStr);
	}
	
	$("#addBtn").click(function(){
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'supplierCommunicationInfo',
	        'windowTitle':'添加地址信息',
	        'iframSrc':'<%=basePath%>supplierstandard/data/addSupplierCommunicationInfo.jsp?standardNumber='
        		+ standardNumber + '&standardItemNumber=' +standardItemNumber,
	        windowStatus: 'regular',
	        windowMinWidth: 500,
	        windowMinHeight: 530,
	        windowPositionTop:24,
	        'windowWidth':500,
	        'windowHeight':530,
	        'parentPanel':".currDesktop"
	    });
	});
	
	
    
	$("#exitBtn").click(function(){			
		parent.elsDeskTop.closeCurWin('supplierCommunicationInfoManage');
	});
	
	$("#editBtn").click(function(){		
		 var head = headGrid.selectedRows();
		 if(head.length<=0){
			 alert("必须选择一行！",2);
			 return;
		 }
		 var rowid = head[0].communicationId;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'supplierCommunicationInfo',
	        'windowTitle':'修改地址信息',
	        'iframSrc':'<%=basePath%>supplierstandard/data/SupplierCommunicationInfoUpd.jsp?standardNumber='
        		+ standardNumber + '&standardItemNumber=' +standardItemNumber
        		+"&communicationId=" + rowid,
	        windowStatus: 'regular',
	        windowMinWidth: 500,
	        windowMinHeight: 530,
	        windowPositionTop:24,
	        'windowWidth':500,
	        'windowHeight':530,
	        'parentPanel':".currDesktop"
	    });
	});
	
	$("#queryHeadBtn").click(function(){			
		queryInfo();
	});
    
	
	//查询信息 
	function queryInfo(){
		var telephone = $("#telephone").val();
		var detailedAddress = $("#detailedAddress").val();
		gobalStr           = {"elsAccount":elsAccount,
				"standardNumber":standardNumber,
				"standardItemNumber":standardItemNumber,
				"telephone":telephone,
				"detailedAddress":detailedAddress
				} ;
		headGrid.load(gobalStr);
	}
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		var selectRow = selectRows[0];
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			parent.elsDeskTop.tip.init({type:"confirm",message:"是否确认删除?",closeEvent:function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/SupplierDataService/deleteStandardCommunicationInfo",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(selectRow),
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
			parent.elsDeskTop.tip.init({type : "alert",displayType : 2,message : "请选择删除地址信息!"});
		}
	});	
</script>
</body>
</html>