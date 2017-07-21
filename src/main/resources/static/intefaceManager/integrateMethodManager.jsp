<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/IntefaceService/findIntefaceMethodElsAccountList">
            <input name="elsAccount" id="elsAccount" style="display:none" type="text"/>
            <input name="integrationType" id="integrationType" style="display:none" type="text"/>
            <div class="common-box-line">
           		<button style="margin-left: 5px;" id="deleteElsAccount" class="button-wrap">删除账号配置</button>
           	 	<button style="margin-left: 5px;" id="addElsAccount" class="button-wrap">配置新账号</button>
            	<button style="margin-left: 5px;" id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
            </form>
        </div>
        <div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="ELS配置" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<main class="grid-container">
					 <form id="submitForm" onsubmit="return false;" >
					<div class="grid-100">
						<table id="table-head"></table>
						<div id="pg" style="text-align: right;"></div>
					</div>
					</form>
					</main>
				</div>
			</div>
		</div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_lable_result" defaultValue="查询结果" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                    	 <form id="submitParamForm" onsubmit="return false;" >
                    	 <button style="margin-left: 5px;" id="addRow" class="button-wrap">新增行</button>
		            	<button style="margin-left: 5px;" id="removeRow" class="button-wrap">删除行</button>
		            	<button style="margin-left: 5px;" id="saveRow" class="button-wrap">保存</button>
                        <table id="table-item"></table>
                        </form>
                    </div>
                </main>
            </div>
        </div>
<script type="text/javascript">
var headerGrid;
var itemGrid;
var selectElsAccount;
var cols=[
	        {title:'els账号', name:'elsAccount', width: 80, align: 'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<input name='integrationMethodsList[][elsAccount]' class='elsAccount'  type='text' value='"+val+"'/>";
	        } },
	        { title:'公司名称', name:'companyShortName' ,width:200, align:'center'}
	        ];
var cols_item = [
	        {title:'els账号', name:'elsAccount', width: 80, align: 'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<span>"+val+"</span><input name='integrationMethodsList[][elsAccount]' class='elsAccount' style='display:none' type='text' value='"+val+"'/>";
	        } },
	        { title:'接口类型', name:'integrationType' ,width:200, align:'center',renderer:function(val){
	        	return '<select  name="integrationMethodsList[][integrationType]" class="integrationTypeSelect" valAttr="'+val+'">'+
				'<option value="NormalMiddleTable">标准中间表</option> <option value="NormalSAP">标准SAP</option>'+
				'<option value="SAP">自定义SAP</option> <option value="WebService">自定义Web Service </option></select>';
	        } 
	        },
	        { title:'业务编码', name:'integrationCode' ,width:250, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<input name='integrationMethodsList[][integrationCode]' type='text'  value='"+val+"'/>";
	        } },
	        { title:'接口类名', name:'integrationName' ,width:250, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<span>"+val+"</span><input name='integrationMethodsList[][integrationName]' type='text' style='display:none'  value='"+val+"'/>";
	        } },
	        { title:'接口方法名', name:'mothedName' ,width:250, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<span>"+val+"</span><input name='integrationMethodsList[][mothedName]' type='text' style='display:none'  value='"+val+"'/>";
	        } },
	        { title:'SAP接口编码', name:'reqCode' ,width:200, align:'center',renderer:function(val,item,index){
	        	if (!val) {val = "";}
        	    return  "<input class='elsErpAccessConfigBtn' name='integrationMethodsList[][reqCode]' type='text' style='color:blue;' value='"+val+"'/>"+"<span style='display: none;'>"+JSON.stringify(item)+"</span>";
	        } },
	        { title:'Web Service路径', name:'urlStr' ,width:300, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<input name='integrationMethodsList[][urlStr]' type='text'  value='"+val+"'/>";
	        } }
	        ];
var blankHeaderRow={"elsAccount":""};	  
var blankRow = {"elsAccount":"","integrationType":"NormalMiddleTable","integrationCode":"","integrationCode":"","integrationName":"","mothedName":"","reqCode":"","urlStr":""};

$().ready(function(){
	init();
});

function init(){
	//初始化控件
    var frm = $("#queryForm");
    var height = $(document).height()-160;
    if (!headerGrid) {
    	headerGrid = $('#table-head').mmGrid({
	        cols: cols,
	        url : frm[0].action,
	        params: frm.serializeJSON(),
	        method:  frm[0].method,
	        root:"rows",
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        remoteSort:true,
	        plugins: [
	            $('#pg').mmPaginator({
	                style: 'plain'
	                , totalCountName: 'total'
	                , page: 1
	                , pageParamName: 'currentPage'
	                , limitParamName: 'pageSize'
	                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
	                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
	                , limit:null
	                , limitList: [10,20]
	            })
	        ]
	    });
	}
    
    headerGrid.on('loadSuccess', function(e, dat) {
    	initItemGrid();
		var rows=headerGrid.rows();
		//初始化数据
		if(rows.length>0){
			loadItem(rows[0].elsAccount);
		}
	});
    
    headerGrid.on('cellSelected', function(e, item, index) {
    	if(item.elsAccount){
    		loadItem(item.elsAccount);
    	}else{
    		var submitParamForm=$("#submitForm").serializeJSON();
    		var rows=headerGrid.selectedRowsIndex()
    		loadItem(submitParamForm.integrationMethodsList[rows[0]].elsAccount);
    	}
    });
    
    initItemGrid();
    
	itemGrid.on('loadSuccess', function(e, dat) {
		initSelect();
	});
	
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin("integrateMethodManager",closeCallback());
	});
	
	//删除账号配置
	$("#deleteElsAccount").click(function(){
		deleteElsAccountRows();
	});
	
	//添加需配置用户
	$("#addElsAccount").click(function(){
		headerGrid.addRow(blankHeaderRow);
	});
	
	//插入行
	$("#addRow").click(function(){
		addRow();
	});
	
	//删除行
	$("#removeRow").click(function(){
		removeRow();
	});
	
	//保存行
	$("#saveRow").click(function(){
		saveRow();
	});
}

function initItemGrid(){
	if (!itemGrid) {
		 itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        multiSelect:true,
	        data:[],
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        remoteSort:true,
	    });
	}
}

/**
 * 加载配置项
 */
function loadItem(elsAccount){
	selectElsAccount=elsAccount;
	var param={"elsAccount":elsAccount};
	$.ajax({
		url :"<%=basePath%>rest/IntefaceService/findIntefaceMethods",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(param),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data!=null&&data.statusCode == "-100") {
				alert(data.message,2);
			} else {
				itemGrid.removeRow();
				itemGrid.addRow(data);
				initSelect();
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常' />",3);
		}
	});
}

//初始化下拉框
function initSelect(){
	$(".integrationTypeSelect").each(function(){
		var val=$(this).attr("valAttr");
		$(this).find("option[value='"+val+"']").attr("selected",true);
		$(this).css("width",$(this).parent().width()-15);
	});
}

//返回回调函数
function closeCallback() {
}

//查询
function query() {
	var frm = $("#queryForm");
	itemGrid.opts.params = frm.serializeJSON();
	itemGrid.load({});
}

//新增行
function addRow(){
	var rows=headerGrid.selectedRowsIndex();
	if(rows.length<=0){
		alert("请选择要配置的行");
		return;
	}
	if(selectElsAccount==""||selectElsAccount==null){
		var submitParamForm=$("#submitForm").serializeJSON();
		console.log(submitParamForm);
		selectElsAccount=submitParamForm.integrationMethodsList[rows[0]].elsAccount;
	}
	blankRow.elsAccount=selectElsAccount;
	itemGrid.addRow(blankRow);
}

//删除行
function removeRow(){
	itemGrid.removeRow(itemGrid.selectedRowsIndex());
}


//保存行
function saveRow(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定保存该用户的接口配置？',closeEvent:function(){
    	parent.elsDeskTop.showLoading();
		var selectRows=itemGrid.rows();
		var param={"integrationMethodsList":selectRows};
		var submitParamForm=$("#submitParamForm").serializeJSON()
		var pageData = $.extend(true,{},param,submitParamForm);
		var param={"elsAccount":selectElsAccount,"integrationMethodsList":pageData.integrationMethodsList};
		$.ajax({
			url :"<%=basePath%>rest/IntefaceService/saveIntefaceMethods",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data!=null&&data.statusCode == "-100") {
					alert(data.message,2);
				} else {
					loadItem(selectElsAccount);
					alert("保存成功！");
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常' />",3);
			}
		});
	}});
}

function deleteElsAccountRows(){
	var rows=headerGrid.selectedRows()
	if(rows.length<=0){
		alert("请选择要配置的行",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确定删除该用户的接口配置？',closeEvent:function(){
	parent.elsDeskTop.showLoading();
	var param={"elsAccount":rows[0].elsAccount};
	$.ajax({
		url :"<%=basePath%>rest/IntefaceService/deleteIntefaceMethods",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(param),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if (data!=null&&data.statusCode == "-100") {
				alert(data.message,2);
			} else {
				headerGrid.removeRow(headerGrid.selectedRowsIndex());
				var rows=headerGrid.rows();
				//初始化数据
				if(rows.length>0){
					loadItem(rows[0].elsAccount);
				}
				alert("删除成功！",2);
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常' />",3);
		}
	});
	}});
}

//查询客户ERP系统配置  els_erp_access_config  @author jiangzhidong @date 20160611
$('.elsErpAccessConfigBtn').live("dblclick", function() {
	var editCol = $(this).next().text();
	var headRows = JSON.parse(editCol);
	var url='<%=basePath%>intefaceManager/erp/elsErpAccessConfig.jsp';
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
        'windowsId':'elsErpAccessConfig',
        'windowTitle':'<i18n:I18n defaultValue="ERP系统配置" key="test"></i18n:I18n>',
        'iframSrc':url,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop",
        data:headRows
    });
 });
 
</script>
</body>
</html>