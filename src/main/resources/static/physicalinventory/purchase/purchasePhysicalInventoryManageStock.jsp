<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" /></span>
            <div class="common-box-line">
                <button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create"/> </button>
               <%--  <button id="confirmBtn" class="button-wrap"><i18n:I18n defaultValue="确认" key="i18n_common_button_confirm"/></button>  --%>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
            <div class="common-box-line">
	           <%--  <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="库存号" key=""/>:</span>
					<input type="text" id="voucherNumber" name="voucherNumber" />
				</div>	 --%>
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="订单号" key=""/>:</span>
					<input type="text" id="purchaseOrderNumber" name="purchaseOrderNumber" />
				</div>
				 <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="对方名称" key=""/>:</span>
					<input type="text" id="toElsDesc" name="toElsDesc" />
				</div>	
				<br>
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="物料号" key=""/>:</span>
					<input type="text" id="materialNumber" name="materialNumber" />
				</div>	
				 <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="物料描述" key=""/>:</span>
					<input type="text" id="materialDesc" name="materialDesc" />
				</div>
				<br>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="工厂名" key=""/>:</span>
					<input type="text" id="factory" name="factory" />
				</div>	
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="工厂描述" key=""/>:</span>
					<input type="text" id="factoryDesc" name="factoryDesc" />
				</div>	
				 <div class="dis-in-b input-and-tip"> 
					<button id="queryBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
				</div>	
            </div>
        </div>
		<form  id="form" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="库存信息" key=""/></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="stockTable"></table>
                        <div id="stockPage" style="text-align: right;"></div>
                    </div>
               </main>
            </div>
        </div>

        
    </div>
<script>
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	
	var renderAuditStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "审批通过";
		} else if("1"==val){
			return "未审批";
		} else if("2"==val){
			return "审批中";
		} else {
			return "审批拒绝";
		}
	};
	
	//日期格式渲染 yyyy-MM-dd hh:mm:ss
	function rendererTime(val){
		return new Date().format("yyyy-MM-dd hh:mm:ss");
	}
	
	var stockCols = [
				{ title:"<i18n:I18n defaultValue='本方ELS号' key=''/>",        name:"elsAccount",hidden:true, width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='本方名称' key=''/>",        name:"elsDesc", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='对方ELS号' key=''/>",        name:"toElsAccount",hidden:true, width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='对方名称' key=''/>",    name:"toElsDesc", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='库存号' key=''/>",  name:"voucherNumber", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='物料号' key=''/>",  name:"materialNumber", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='物料描述' key=''/>",   name:"materialDesc", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='物料规格' key=''/>",   name:"materialSpec", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='物料属性一' key=''/>", name:"materialAttr1", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='物料属性二' key=''/>", name:"materialAttr2", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='物料属性三' key=''/>", name:"materialAttr3", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='物料属性四' key=''/>", name:"materialAttr4", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='物料属性五' key=''/>", name:"materialAttr5", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='工厂' key=''/>", name:"factory", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='工厂名称' key=''/>", name:"factoryDesc", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='数量' key=''/>", name:"quantity", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='订单号' key=''/>", name:"purchaseOrderNumber", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='订单行号' key=''/>", name:"purchaseOrderItemNumber", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='项目号' key=''/>", name:"projectNumber", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='项目WBS号' key=''/>", name:"projectWBSNumber", width:100, align:"center"},
				{ title:"<i18n:I18n defaultValue='审批状态' key=''/>", name:"auditStatus", width:100, align:"center",renderer:renderAuditStatus},
				{ title:"<i18n:I18n defaultValue='创建人' key=''/>",  name:"createUser", width:100, align:"center"},
	            { title:"<i18n:I18n defaultValue='创建时间' key=''/>", name:'createDate' ,width:120, align:'center',renderer:rendererTime},
	    ];
	var stockGrid = $("#stockTable").mmGrid({
		url         : "${pageContext.request.contextPath}/rest/PhysicalInventoryService/queryPhysicalInventoryStock",
		method      : "POST",
		autoLoad    : false,
		cols        : stockCols,
		root        : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText  : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : true,
        checkCol    : true,
        indexCol    : false,
		plugins     : [
		    $("#stockPage").mmPaginator({
		        style           : "plain",
		        totalCountName  : "total",
		        page            : 1,
		        pageParamName   : "currentPage",
		        limitParamName  : "pageSize",
		        limitLabel      : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
		        totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
		        limit           : null,
		        limitList       : [10,20]
		    })
		]
	}); 
	
	$(document).ready(function(){
		query();
	});
	
	$("#queryBtn").click(function(){
		query();
	});
	
	function query(){
		var voucherNumber = $("#voucherNumber").val();
		var purchaseOrderNumber = $("#purchaseOrderNumber").val();
		var materialNumber = $("#materialNumber").val();
		var materialDesc = $("#materialDesc").val();
		var factory = $("#factory").val();
		var factoryDesc = $("#factoryDesc").val();
		var queryParam = {
			elsAccount : elsAccount,
			flag : 1,
			voucherNumber :voucherNumber,
			purchaseOrderNumber :purchaseOrderNumber,
			materialNumber :materialNumber,
			materialDesc :materialDesc,
			factory :factory,
			factoryDesc :factoryDesc
	    };
	    $.extend(stockGrid.opts.params,queryParam);
		stockGrid.load();
	}
	
	$("#addBtn").click(function(){
		var selectRow = stockGrid.selectedRows();
		if(selectRow.length==0){
			alert("请选择!",2);
			return;
		}
		var bool = false;
		for(var i = 1 ; i < selectRow.length ; i ++){
			var singleRow   = selectRow[i] ;
			if(selectRow[0].toElsAccount!=singleRow.toElsAccount){
				bool = true;
				break;
			}
		}
		if(bool){
			alert("只能选择单个客户盘点!",2);
			return;
		}
		parent.frames['iframeApp_'+'purchasePhysicalInventoryManageAdd'].setStockValue(selectRow);
		parent.elsDeskTop.closeCurWin('purchasePhysicalInventoryManageStock');
	});
	
	
	
</script>
</body>
</html>