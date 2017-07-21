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
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/IntefaceService/findIntefaceMethodName">
            <input name="elsAccount" id="elsAccount" style="display:none" type="text"/>
            <input name="integrationType" id="integrationType" style="display:none" type="text"/>
            <div class="common-box-line">
            	<button style="margin-left: 5px;" id="addRow" class="button-wrap">新增行</button>
            	<button style="margin-left: 5px;" id="removeRow" class="button-wrap">删除行</button>
            	<button style="margin-left: 5px;" id="saveRow" class="button-wrap">保存</button>
            	<button style="margin-left: 5px;" id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
            </form>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_lable_result" defaultValue="查询结果" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                    	 <form id="submitParamForm" onsubmit="return false;" >
                        <table id="table-item"></table>
                        </form>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
<script type="text/javascript">
var IntegrateElsAccount=GetQueryString("elsAccount");;
var integrationType=GetQueryString("integrationType");
var companyName=GetQueryString("companyName");
if(companyName){
	companyName=utf8ToChar(companyName);
}
var itemGrid;
var cols_item = [
	        {title:'els账号', name:'elsAccount', width: 80, align: 'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<span>"+val+"</span><input name='integrationMothodNameList[][elsAccount]' class='elsAccount' style='display:none' type='text' value='"+val+"'/>";
	        } },
	        { title:'公司名称', name:'companyName' ,width:150, align:'center' },
	        { title:'接口类型', name:'integrationType' ,width:200, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<span>"+val+"</span><input name='integrationMothodNameList[][integrationType]' class='elsAccount' style='display:none' type='text' value='"+val+"'/>";
	      
	        } },
	        { title:'业务编码', name:'mothodCode' ,width:150, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<input name='integrationMothodNameList[][mothodCode]' type='text'  value='"+val+"'/>";
	        } },
	        { title:'方法名', name:'mothodName' ,width:200, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<input name='integrationMothodNameList[][mothodName]' type='text'  value='"+val+"'/>";
	        } },
	        { title:'方法描述', name:'mothodDesc' ,width:200, align:'center',renderer:function(val){
	        	if (!val) {val = "";}
        	    return  "<input name='integrationMothodNameList[][mothodDesc]' type='text'  value='"+val+"'/>";
	        } }
	        ];
var blankRow = {"elsAccount":IntegrateElsAccount,"companyName":companyName,"integrationType":integrationType,"mothodCode":"","mothodName":"","mothodDesc":""};

$().ready(function(){
	init();
});

function init(){
	//初始化参数
	$("#elsAccount").val(IntegrateElsAccount);
	$("#integrationType").val(integrationType);
	
	//初始化控件
    var frm = $("#queryForm");
    var height = $(document).height()-160;
	if (!itemGrid) {
		 itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        url : frm[0].action,
	        params: frm.serializeJSON(),
	        method:  frm[0].method,
	        multiSelect:true,
	        height: height,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        remoteSort:true,
	    });
	}
	
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback());
		} else {
			parent.elsDeskTop.closeCurWin('integrateMethodNameManager',closeCallback());
		}
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
	itemGrid.addRow(blankRow);
}

//删除行
function removeRow(){
	itemGrid.removeRow(itemGrid.selectedRowsIndex());
}


//保存行
function saveRow(){
		var selectRows=itemGrid.rows();
		var param={"integrationMothodNameList":selectRows};
		var submitParamForm=$("#submitParamForm").serializeJSON()
		var pageData = $.extend(true,{},param,submitParamForm);
		var param={"elsAccount":IntegrateElsAccount,"integrationMothodNameList":pageData.integrationMothodNameList};
    	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){

		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/IntefaceService/saveIntefaceMethodName",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data!=null&&data.statusCode == "-100") {
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
}
</script>
</body>
</html>