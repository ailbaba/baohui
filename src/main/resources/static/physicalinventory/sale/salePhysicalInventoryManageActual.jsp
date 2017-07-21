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
                  <button id="confirmBtn" class="button-wrap"><i18n:I18n defaultValue="保存" key="i18n_button_save"/></button> 
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
            <div class="common-box-line">
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="盘点单号" key=""/>:</span>
					<input type="text" id="voucherNumber" name="voucherNumber" />
				</div>	
				 <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="计划盘点日期" key=""/>:</span>
					<input type="text" id="planStartDate" name="planStartDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>	
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="到" key="i18n_common_label_to"/>:</span>
					<input type="text" id="planEndDate" name="planEndDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>
				<br>
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="对方名称" key=""/>:</span>
					<input type="text" id="toElsDesc" name="toElsDesc" />
				</div>	
				 <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="实际盘点日期" key=""/>:</span>
					<input type="text" id="actualStartDate" name="actualStartDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>	
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="到" key="i18n_common_label_to"/>:</span>
					<input type="text" id="actualEndDate" name="actualEndDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</div>
				<br>
				 <div class="dis-in-b input-and-tip"> 
					<button id="queryHeadBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
				</div>	
            </div>
        </div>
		<form  id="form" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="盘点单头" key=""/></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="headTable"></table>
                        <div id="headPage" style="text-align: right;"></div>
                    </div>
               </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="盘点单行" key=""/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="盘点单行" key=""/></a></li>
                        <%-- <li><a href="#sheet-project-two"><i18n:I18n defaultValue="样品单文件" key=""/></a></li> --%>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container nest-table">
                        	<div class="edit-box-wrap" style="padding-top: 5px;">
				            </div>
		                    <div class="grid-100" id="reCreate">
		                        <table id="itemTable"></table>
		                        <div id="itemPage" style="text-align: right;"></div>
		                    </div>
		                </main>
                    </div>
                </div>
            </div>
        </div>
        </form>
     <!--    <div class="saying-dialog">
            <div class="fl-left left-content pos-relative">
                <div class="dis-block pos-absolute option-bar pre-active next"></div>
            </div>
            <div class="fl-left right-content pos-relative none-active">
                <div class="saying-box-wrap">
                   <iframe class="testIframe" id="chatIframe" frameborder="0" width="100%">
                   </iframe>
                </div>
            </div>
            <div class="clear-both"></div>
    	</div> -->
    </div>
<script>
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	var $sob;
	var fileUploader;
	var updateFile = false     ;
	
	var voucherNumber = GetQueryString("voucherNumber");

	if("undefined"!=typeof(voucherNumber) && ""!=voucherNumber && "null" != voucherNumber){
		$("#voucherNumber").val(voucherNumber);
	}
		
	//只允许数字输入框
	var initInputNumber = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"name="'+this.name+'"value="'+val+'"/>';
	};
	
    function initInputDouble(val,item,index){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
		return '<input class="nest-report" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 24px;"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
    }
    
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};

	var renderVoucherStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "新建";
		} else if("1"==val){
			return "盘点中";
		} else if("2"==val){
			return "已盘点";
		} else if("3"==val){
			return "重盘点";
		} else if("4"==val){ 
			return "差异记账";
		}
	};
	var renderSendStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "未发送";
		} else if("1"==val){
			return "已发送";
		} 
	}
	var renderConfirmStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "未确认";
		} else if("1"==val){
			return "确认中";
		} else if("2"==val){
			return "已确认";
		} 
	};
	
	var rendererIsFreeze = function(val,item,index){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "是";
		} else if("1"==val){
			return "否";
		} 
	};
	
	function rendererDate(val){
		if (!val) {
			val = "";
		}
		if (val!="") {
			val = new Date(val).format("yyyy-MM-dd");
		}
		return val;
	}
	function rendererTime(val){
		if (!val) {
			val = "";
		}
		if (val!="") {
			val = new Date(val).format("yyyy-MM-dd hh:mm:ss");
		}
		return val;
	}
	
	var headCols = [
			{ title:"<i18n:I18n defaultValue='本方ELS号' key=''/>",        name:"elsAccount",hidden:true, width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='本方名称' key=''/>",        name:"elsDesc", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='对方ELS号' key=''/>",        name:"toElsAccount",hidden:true,hidden:true,width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='对方名称' key=''/>",    name:"toElsDesc", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='盘点单号' key=''/>",  name:"voucherNumber", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='盘点年度' key=''/>",  name:"voucherYear",hidden:true, width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='凭证日期' key=''/>",   name:"voucherDate", width:100, align:"center",renderer:rendererDate},
			{ title:"<i18n:I18n defaultValue='是否冻结库存' key=''/>",  name:"freezeStock", width:100, align:"center",renderer:rendererIsFreeze},
			{ title:"<i18n:I18n defaultValue='计划盘点日期' key=''/>",   name:"planDate", width:100, align:"center",renderer:rendererDate},
			{ title:"<i18n:I18n defaultValue='实际盘点日期' key=''/>", name:"actualDate", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='过账日期' key=''/>", name:"postDate", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='单据状态' key=''/>", name:"voucherStatus", width:100, align:"center",renderer:renderVoucherStatus},
			{ title:"<i18n:I18n defaultValue='发送状态' key=''/>", name:"sendStatus", width:100, align:"center",renderer:renderSendStatus},
			{ title:"<i18n:I18n defaultValue='确认状态' key=''/>", name:"confirmStatus", width:100, align:"center",renderer:renderConfirmStatus},
			{ title:"<i18n:I18n defaultValue='本方备注' key=''/>", name:"purchaseRemark", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='对方备注' key=''/>", name:"saleRemark", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='创建人' key=''/>",  name:"createUser",hidden:true, width:100, align:"center"},
            { title:"<i18n:I18n defaultValue='创建时间' key=''/>", name:'createDate' ,width:120, align:'center',renderer:rendererTime},
	    ];
	
	var headGrid = $("#headTable").mmGrid({
		url         : "${pageContext.request.contextPath}/rest/PhysicalInventoryService/queryPhysicalInventoryHeader",
		method      : "POST",
		autoLoad    : false,
		cols        : headCols,
		root        : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText  : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
        checkCol    : true,
        indexCol    : false,
		plugins     : [
		    $("#headPage").mmPaginator({
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
	
	var renderItemStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "新建";
		} else if("1"==val){
			return "已发货";
		} else if("2"==val){
			return "已收货";
		} else {
			return "已结束";
		}
	};
	var renderItemResult = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "审核合格";
		} else if("1"==val){
			return "审核不合格";
		} else {
			return "未审核";
		}
	};
	var enquiryHandle = function(val, item, index){
		return '<span class="delItemBtn" style="color:blue;"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	var itemCols = [
			{title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />',clickDisable:true, name:'elsHandle' ,width:90, align:'center', renderer: enquiryHandle},
			{ title:"盘点单号", name:"voucherNumber", width:100, align:"center"},
			{ title:"行号", name:"voucherItemNumber", width:100, align:"center"},
			{ title:"采购方物料编号", name:"purchaseMaterialNumber", width:100, align:"center"},
			{ title:"采购方物料描述", name:"purchaseMaterialDesc", width:100, align:"center"},
			{ title:"采购方物料行规格", name:"purchaseMaterialSpec",hidden:true, width:100, align:"center"},
			{ title:"销售方物料编号", name:"saleMaterialNumber", width:100, align:"center"},
			{ title:"销售方物料描述", name:"saleMaterialDesc", width:100, align:"center"},
			{ title:"实盘数量", name:"physicalInventoryItemVOList[][actualQuantity]", width:100, align:"center",renderer:initInputNumber},
			{ title:"SRM结存数", name:"stockQuantity", width:100, align:"center"},
			{ title:"差异数", name:"stockQuantityDiff", width:100, align:"center"},
	    ];
	var itemGrid = $("#itemTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/PhysicalInventoryService/queryPhysicalInventoryItem",
	    method:  "POST",
	    autoLoad : false,
	    cols : itemCols,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    plugins: [
	        $("#itemPage").mmPaginator({
	            style: "plain",
	            totalCountName: "total",
	            page: 1,
	            pageParamName: "currentPage",
	            limitParamName: "pageSize",
	            limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	            totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	            limit:null,
	            limitList: [10,20]
	        })
	    ]
	});

	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    $("#sheet-project").tabs();
	    query();
	}
    
	function query(){
		var voucherNumber = $("#voucherNumber").val();
		var voucherStatus = $("#voucherStatus").val();
		var sendStatus = $("#sendStatus").val();
		var confirmStatus = $("#confirmStatus").val();
		var planStartDate = $("#planStartDate").val();
		var planEndDate = $("#planEndDate").val();
		var actualStartDate = $("#actualStartDate").val();
		var actualEndDate = $("#actualEndDate").val();
		
		var queryParam = {
	    	elsAccount : elsAccount,
	    	voucherNumber : voucherNumber,
	    	voucherStatus : voucherStatus,
	    	sendStatus : sendStatus,
	    	confirmStatus : confirmStatus,
	    	planStartDate : planStartDate,
	    	planEndDate : planEndDate,
	    	actualStartDate : actualStartDate,
	    	actualEndDate : actualEndDate,
	    };
		headGrid.opts.params = queryParam;
		headGrid.load({page:1});
	}
	
	function loadItem(elsAccount,toElsAccount,voucherNumber) {
		var queryParam = {
		    	elsAccount : elsAccount,
		    	toElsAccount : toElsAccount,
		    	voucherNumber : voucherNumber,
		    };
		$.extend(itemGrid.opts.params,queryParam);
		itemGrid.load();
	}
	
	function clearItemtable(){
		if(itemGrid.rowsLength() > 0){
			for(var i=itemGrid.rowsLength();i-1>=0;i--){
				itemGrid.removeRow(i-1);
			}
		}
	}
	
	headGrid.on("loadSuccess",function(e, data) {
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
    		headGrid.select(0);//默认选中第一行
			var seled=headGrid.selectedRows();
            var record = data.rows[0];
			loadItem(record.elsAccount,record.toElsAccount,record.voucherNumber);//根据头表选中项加载行项目信息
		} else {//无Head数据则将Item及File表清空
			clearItemtable();
		}
    	
    });

    headGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
    	loadItem(item.elsAccount,item.toElsAccount,item.voucherNumber);//根据头表选中项加载行项目信息
  	});
    	
	$("#queryHeadBtn").click(function(){
		query();
	});
	
	$("#confirmBtn").click(function(){
		var head = headGrid.selectedRows();
		var item = itemGrid.rows();
		if(head.length<=0){
			alert("请选择行",2);
			return;
		}
		var frm = $("#form");
		var formData = frm.serializeJSON();
		var jsonObj ={
				  "elsAccount":head[0].elsAccount,"elsDesc":head[0].elsDesc,"voucherNumber":head[0].voucherNumber,
				  "toElsAccount":head[0].toElsAccount,"toElsDesc":head[0].toElsDesc,
				  "voucherDate":head[0].voucherDate,"planDate":head[0].planDate,
				  "freezeStock":head[0].freezeStock,
				  physicalInventoryItemVOList:item
				  };
		  
		var pageData = $.extend(true,{},jsonObj,formData);
		
		if("undefied" != typeof(head) && "[]" != head && "" != head){
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/PhysicalInventoryService/saleConfirmPhysicalInventory",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(pageData),
				dataType : "json",
				success : function(data) {
					var status = data;
					if("200" == status){
						alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
		  				parent.frames['iframeApp_'+'salePhysicalInventory'].init();
		  				parent.elsDeskTop.closeCurWin('salePhysicalInventoryManageActual');
					} else {
						alert(data.message,2);
					}
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_saveFail" defaultValue="保存失败！" />',3);
				}
			});
		}
	});
	
</script>
</body>
</html>