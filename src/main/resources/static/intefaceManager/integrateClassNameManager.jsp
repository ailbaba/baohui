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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/IntefaceService/findIntefaceClassName">
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72">公司名称：</span><input name="companyName" type="text"/></div>
                <span>接口类型： </span><select id="integrationType" name="integrationType">
						<option value="">全部</option>
						<option value="NormalMiddleTable">标准中间表</option>
						<option value="NormalSAP">标准SAP</option>
						<option value="SAP">自定义SAP</option>
						<option value="WebService">自定义Web Service </option>
					</select>
            	<button style="margin-left: 5px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
            	<button style="margin-left: 5px;" id="addRow" class="button-wrap">新增行</button>
            	<button style="margin-left: 5px;" id="removeRow" class="button-wrap">删除行</button>
            	<button style="margin-left: 5px;" id="saveRow" class="button-wrap">保存</button>
            	<button style="margin-left: 5px;" id="setMothodName" class="button-wrap">配置接口方法</button>
            	<button style="margin-left: 5px;" id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
            </form>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_lable_result" defaultValue="查询结果" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
<script type="text/javascript">
var itemGrid;
var cols_item = [
	        {title:'els账号', name:'elsAccount', width: 100, align: 'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<input name='integrationClassNameList[][elsAccount]' class='elsAccount' type='text' value='"+val+"'/>";
	        } },
	        { title:'公司名称', name:'companyName' ,width:200, align:'center' },
	        { title:'接口类型', name:'integrationType' ,width:200, align:'center',renderer:function(val){
	        	return '<select  name="integrationClassNameList[][integrationType]" class="integrationTypeSelect" valAttr="'+val+'">'+
				'<option value="NormalMiddleTable">标准中间表</option> <option value="NormalSAP">标准SAP</option>'+
				'<option value="SAP">自定义SAP</option> <option value="WebService">自定义Web Service </option></select>';
	        } },
	        { title:'接口类名', name:'className' ,width:300, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<input name='integrationClassNameList[][className]' type='text' class='className'  value='"+val+"'/>";
	        } }];
var blankRow = {"elsAccount":"","companyName":"","integrationType":"NormalMiddleTable","className":""};

$().ready(function(){
	init();
});

function init(){
	//初始化控件
    var frm = $("#queryForm");
    var height = $(document).height()-160;
	if (!itemGrid) {
		 itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        url : frm[0].action,
	        params: frm.serializeJSON(),
	        method:  frm[0].method,
	        height: height,
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
	
	itemGrid.on('loadSuccess', function(e, dat) {
		initSelect();
	});
	
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback());
		} else {
			parent.elsDeskTop.closeCurWin('integrateClassNameManager',closeCallback());
		}
	});
	
	//查询
	$("#queryBtn").click(function(){
		query();
	});
	
	//插入行
	$("#addRow").click(function(){
		addRow();
	});
	
	//插入行
	$("#removeRow").click(function(){
		removeRow();
	});
	
	//保存行
	$("#saveRow").click(function(){
		saveRow();
	});
	
	//进入配置方法名页面
	$("#setMothodName").click(function(){
		setMothodName();
	});
}

//返回回调函数
function closeCallback() {
}

//查询
function query() {
	var frm = $("#queryForm");
	$("#elsAccount").val(currentElsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#queryForm");
	itemGrid.opts.params = frm.serializeJSON();
	itemGrid.load({});
	initSelect();
}

//初始化下拉框
function initSelect(){
	$(".integrationTypeSelect").each(function(){
		var val=$(this).attr("valAttr");
		$(this).find("option[value='"+val+"']").attr("selected",true);
		$(this).css("width",$(this).parent().width()-15);
	});
}

//新增行
function addRow(){
	itemGrid.addRow(blankRow);
}

//删除行
function removeRow(){
	var selectRows=itemGrid.selectedRows();
	if(selectRows!=null&&selectRows.length>0){
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var param={"integrationClassNameList":selectRows};
		$.ajax({
			url :"<%=basePath%>rest/IntefaceService/deleteIntefaceClassName",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data!=null&&data.statusCode == "-100") {
					alert(data.message,2);
				} else {
					itemGrid.removeRow(itemGrid.selectedRowsIndex());
// 					query();
					alert("删除成功！");
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常' />",3);
			}
		});
    	}});
	}else{
		alert("请选择要保存的行！",2);
	}
}


//保存行
function saveRow(){
	var selectRows=itemGrid.selectedRows();
	if(selectRows!=null&&selectRows.length>0){
		var param={"integrationClassNameList":selectRows};
		var arr = new Array();
		var index=0;
		//获取修改后的数据		
		$("#table-item .selected").each(function(){
			var jsonObj={"elsAccount":$(this).find(".elsAccount").val(),"integrationType":$(this).find(".integrationTypeSelect option:selected").val(),"className":$(this).find(".className").val()};
			arr[index]=jsonObj;
			index++;
		});
		var paramInput={"integrationClassNameList":arr};
		var pageData = $.extend(true,{},param,paramInput);
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/IntefaceService/saveIntefaceClassName",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(pageData),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data!=null&&data.statusCode != "-100") {
						alert(data.message,2);
					} else {
						query();
						alert("保存成功！");
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常' />",3);
				}
			});
    	}});
	}else{
		alert("请选择要保存的行！",2);
	}
}

//进入配置方法名页面
function setMothodName(){
	var selectRows=itemGrid.selectedRows();
	var src='<%=basePath%>intefaceManager/integrateMethodNameManager.jsp?elsAccount=' + selectRows[0].elsAccount + "&integrationType="+selectRows[0].integrationType+"&companyName="+selectRows[0].companyName;
	if(selectRows!=null&&selectRows.length>0){
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'integrateMethodNameManager',
	        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	        'windowSubTitle': "",
	        'windowMinWidth': 960,
			'windowMinHeight': 700,
			'windowWidth':960,
			'windowHeight':700,
	        'iframSrc':src,
	        'parentPanel':".currDesktop"
	    });
	}else{
		alert("请选择要配置的行！",2);
	}
}
</script>
</body>
</html>