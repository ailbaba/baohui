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
                <button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="保存" key="i18n_button_save"/> </button>
                <button id="stockBtn" class="button-wrap"><i18n:I18n defaultValue="查询库存" key=""/> </button>
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
<%-- 		                        <button id="itemDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button> --%>
<%-- 		                        <button id="addRow" class="button-wrap"><i18n:I18n defaultValue="新增行" key="test"/></button> --%>
<%-- 		                        <button id="delRow" class="button-wrap"><i18n:I18n defaultValue="删除行" key="test"/></button> --%>
				            </div>
		                    <div class="grid-100" id="reCreate">
		                        <table id="itemTable"></table>
		                        <div id="itemPage" style="text-align: right;"></div>
		                    </div>
		                </main>
                    </div>
                    <%-- <div id="sheet-project-two">
	                  <div class="box-wrap pos-relative bg-common">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<div class="file-list-head">
					                   <select class="" id="selectFileType" name="selectFileType" onchange="selectFileTypeChange();" >
						                   <option value="all"><i18n:I18n defaultValue="所有" key="i18n_common_option_all"/></option>
						                   <option value="common"><i18n:I18n defaultValue="公共" key="i18n_common_option_common"/></option>
					                   </select>
					                   <button id="fileDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
					                 </div>
									<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="fileTable" style="width: 300px;"></table>
										</div>
									</main>
			                    </div>
				                 <div class="file-scan">
		   							<div class="file-option-zoom">
					                  	<div class="dis-in-b text-left">
					                  	 	<button id="uploadFile" class="button-wrap">上传附件</button>
						         		</div>
								     </div>
								     <div class="file-display" id="file-display">
								     	<a id="viewerPlaceHolder"></a>
								     </div>
								</div>
						</div>
						</div>
					  </div>
                    </div> --%>
                </div>
            </div>
        </div>
        </form>
        <div class="saying-dialog">
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
    	</div>
    	
   <%--  		
    <!-- 	上传附件窗口 -->
		<div class="fixed-dialog">
		<div class="dialog-tip bg-common" style="width: 353px;height: 200px;margin-left: -251px;margin-top: -190px;">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span>
							<input id="fileName" name="fileName" type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload">
							<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" />
							</div></span>
							<input id="filePath" name="filePath" type="hidden" />
							<input id="fileSize" name="fileSize" type="hidden" />
						</div>
						<input id="fileType" name="fileType" type="hidden" />
					</div>
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	 --%>
        
    </div>
<script>
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	var $sob;
	var fileUploader;
	var updateFile = false ;
	
	var addFlag = GetQueryString("addFlag");

	if("undefined"!=typeof(addFlag) && ""!=addFlag && "null" != addFlag){
		$("#addFlag").val(addFlag);
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
	
	var headInput = function(val){
    	if(!val||val=="null"){ val="";}
    	return '<input name="physicalInventoryHeaderVO[purchaseRemark]"  type="text" value="'+val+'">';
	};
	
	var editDate = function(val, item, index){
		if("undefined"==typeof(val)){
			   val = "";
	    } else {
		   val = new Date(val).format("yyyy-MM-dd");
	    }
	    return "<input type='text' id='"+this.name+"_"+index+"' name='"+this.name+"' class='Wdate' onfocus='WdatePicker({dateFmt:\"yyyy-MM-dd\"})'  value='"+val+"' />";
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
	};
	
	var renderConfirmStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		if("0"==val){
			return "未确认";
		} else if("1"==val){
			return "对方已确认";
		} else if("2"==val){
			return "本方已确认";
		} 
	};
	
	var rendererIsFreeze = function(val,item,index){
		var name = $(this)[0].name;
		return '<select  name="'+name+'" id="'+name+'_'+index+'"  >' +' <option  value="0">是</option><option  value = "1">否</option></select>';
	};
	
	function rendererTime(){
		return new Date().format("yyyy-MM-dd");
	}
	
	var headCols = [
			{ title:"<i18n:I18n defaultValue='本方ELS号' key=''/>",   name:"elsAccount", hidden:true, width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='本方名称' key=''/>",     name:"elsDesc", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='对方ELS号' key=''/>",   name:"toElsAccount",hidden:true, width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='对方名称' key=''/>",    name:"toElsDesc", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='凭证日期' key=''/>",   name:"voucherDate", width:100, align:"center",renderer:rendererTime},
			{ title:"<i18n:I18n defaultValue='盘点年度' key=''/>",  name:"voucherYear",hidden:true, width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='盘点单号' key=''/>",  name:"voucherNumber", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='是否冻结库存' key=''/>",name:"freezeStock", width:100, align:"center",renderer:rendererIsFreeze},
			{ title:"<i18n:I18n defaultValue='计划盘点日期' key=''/>", name:"planDate", width:100, align:"center",renderer:editDate},
			{ title:"<i18n:I18n defaultValue='实际盘点日期' key=''/>", name:"actualDate", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='过账日期' key=''/>", name:"postDate", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='单据状态' key=''/>", name:"voucherStatus", width:100, align:"center",renderer:renderVoucherStatus},
			{ title:"<i18n:I18n defaultValue='发送状态' key=''/>", name:"sendStatus", width:100, align:"center",renderer:renderSendStatus},
			{ title:"<i18n:I18n defaultValue='确认状态' key=''/>", name:"confirmStatus", width:100, align:"center",renderer:renderConfirmStatus},
			{ title:"<i18n:I18n defaultValue='本方备注' key=''/>", name:"purchaseRemark", width:100, align:"center",renderer:initInputAny},
			{ title:"<i18n:I18n defaultValue='对方备注' key=''/>", name:"saleRemark", width:100, align:"center",renderer:initInputAny},
	    ];
	
	var headGrid = $("#headTable").mmGrid({
		url         : "${pageContext.request.contextPath}/rest/PhysicalInventoryService/queryPhysicalInventoryHeader",
		method      : "POST",
		autoLoad    : false,
		cols        : headCols,
		root        : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText  : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : true,
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
	
	var itemCols = [
			{ title:"<i18n:I18n defaultValue='本方ELS号' key=''/>",      hidden:true,  name:"elsAccount", width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='本方名称' key=''/>",        name:"elsDesc",hidden:true, width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='对方ELS号' key=''/>",      name:"toElsAccount",hidden:true, width:100, align:"center"},
			{ title:"<i18n:I18n defaultValue='对方名称' key=''/>",    name:"toElsDesc",hidden:true, width:100, align:"center"},
			{ title:"盘点单号", name:"voucherNumber", width:100, align:"center"},
			{ title:"行号", name:"voucherItemNumber", width:100, align:"center"},
			{ title:"库存号", name:"stockNumber", width:100, align:"center"},
			{ title:"采购方物料编号", name:"purchaseMaterialNumber", width:100, align:"center"},
			{ title:"采购方物料描述", name:"purchaseMaterialDesc", width:100, align:"center"},
			{ title:"采购方物料行规格", name:"purchaseMaterialSpec", width:100, align:"center"},
			{ title:"采购方物料属性1", name:"purchaseMaterialAttr1", width:100, align:"center"},
			{ title:"采购方物料属性2", name:"purchaseMaterialAttr2", width:100, align:"center"},
			{ title:"采购方物料属性3", name:"purchaseMaterialAttr3", width:100, align:"center"},
			{ title:"采购方物料属性4", name:"purchaseMaterialAttr4", width:100, align:"center"},
			{ title:"采购方物料属性5", name:"purchaseMaterialAttr5", width:100, align:"center"},
			{ title:"采购方工厂", name:"purchaseFactory", width:100, align:"center"},
			{ title:"采购方库存地", name:"purchaseStockLocation", width:100, align:"center"},
			{ title:"采购方库存状态", name:"purchaseStockStatus", width:100, align:"center",renderer:renderItemResult},
			{ title:"采购方特殊库存标识", name:"purchaseStockTag", width:100, align:"center"},
			{ title:"销售方物料编号", name:"saleMaterialNumber", width:100, align:"center"},
			{ title:"销售方物料描述", name:"saleMaterialDesc", width:100, align:"center"},
			{ title:"销售方物料行规格",name:"saleMaterialSpec", width:100, align:"center"},
			{ title:"销售方物料属性1", name:"saleMaterialAttr1", width:100, align:"center"},
			{ title:"销售方物料属性2", name:"saleMaterialAttr2", width:100, align:"center"},
			{ title:"销售方物料属性3", name:"saleMaterialAttr3", width:100, align:"center"},
			{ title:"销售方物料属性4", name:"saleMaterialAttr4", width:100, align:"center"},
			{ title:"销售方物料属性5", name:"saleMaterialAttr5", width:100, align:"center"},
			{ title:"销售方工厂", name:"physicalInventoryItemVOList[][saleFactory]", width:100, align:"center",renderer:initInputAny},
			{ title:"销售方库存地", name:"saleStockLocation", width:100, align:"center"},
			{ title:"销售方库存状态", name:"saleStockStatus", width:100, align:"center",renderer:renderItemResult},
			{ title:"销售方特殊库存标识", name:"saleStockTag", width:100, align:"center"},
			{ title:"结存数量", name:"stockQuantity", width:100, align:"center"},
			{ title:"实盘数量", name:"actualQuantity", width:100, align:"center"},
			{ title:"差异数", name:"stockQuantityDiff", width:100, align:"center"},
			{ title:"基本单位", name:"basicUnit", width:100, align:"center"},
			{ title:"结算金额", name:"settleAmount", width:100, align:"center"},
			{ title:"结算货币", name:"settleCurrency", width:100, align:"center"},
			
	    ];
	var itemGrid = $("#itemTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/PhysicalInventoryService/queryPhysicalInventoryItem",
	    method:  "POST",
	    autoLoad : false,
	    cols : itemCols,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
        checkCol    : true,
        indexCol    : false,
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
	
	//var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleAdditionCostManageFile"/>;
	var fileCols = [
			{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
			{ title:"对方ELS号", name:"toElsAccount", width:100, align:"center"},
			{ title:"本方样品号", name:"purchaseSampleNumber", width:100, align:"center"},
			{ title:"表单编号", name:"formId", width:100, align:"center"},
// 			{ title:"物料编号", name:"materialNumber", width:100, align:"center"},
// 			{ title:"物料描述", name:"materialDesc", width:100, align:"center"},
// 			{ title:"物料行编号", name:"materialLineNumber", width:100, align:"center"},
			{ title:"文件名称", name:"fileName", width:100, align:"center"},
			{ title:"文件大小", name:"fbk1", width:100, align:"center"},
			{ title:"文件路径", name:"filePath", width:100, align:"center"},
			{ title:"文件状态", name:"fileStatus", width:100, align:"center"},
	    ];
	var fileGrid = $("#fileTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/SaleSampleService/querySaleSampleFileByCondtion",
	    method : "post",
	    autoLoad : false,
	    cols : fileCols,
	    root : "rows",
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    fullWidthRows :true,
	    indexCol : false,
	    plugins : [
	        $("#filePage").mmPaginator({
	            style: "plain",
	            totalCountName: "total",
	            page: 1,
	            pageParamName: "currentPage",
	            limitParamName: "pageSize",
	            limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	            totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	            limit: null,
	            limitList: [10, 30, 40, 50]
	        })
	    ]
	});
	
	$(document).ready(function(){
		// 动态加载聊天窗口
		$sob = $('.saying-dialog .option-bar');
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	   $("#sheet-project").tabs();
	}
    
	headGrid.on("loadSuccess",function(e, data) {
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
    		headGrid.select(0);//默认选中第一行
			var seled=headGrid.selectedRows();
			if(seled && seled.length) {
				initChat(seled);// 动态加载聊天窗口
				if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
	            $sob.click();
			}
            //初始化聊天控制状态
            var record = data.rows[0];
			loadItem(record.elsAccount,record.toElsAccount,record.voucherNumber);//根据头表选中项加载行项目信息
			//loadFile(record.elsAccount,record.toElsAccount,record.voucherNumber);//根据头表选中项加载文件信息
		} else {//无Head数据则将Item及File表清空
			clearItemtable();
			clearFiletable();
		}
    	
    });

    /* headGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
    	loadItem(item.elsAccount,item.toElsAccount,item.voucherNumber);//根据头表选中项加载行项目信息
		//loadFile(item.elsAccount,item.toElsAccount,item.purchaseSampleNumber);//根据头表选中项加载文件信息
		// 动态加载聊天窗口
		var hadSelected = headGrid.selectedRows();
		if(hadSelected && hadSelected.length) {
			initChat(hadSelected);
    	}
  	}); */
    
    fileGrid.on("loadSuccess", function(e, item, rowIndex, colIndex){
    	reGenFileTypeSelect();
  	});
    
    fileGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
  		previewFile(filePath);
  	});
	
	$("#queryHeadBtn").click(function(){
		refreshData();
	});
	
	//新增行
	$("#addRow").click(function(){
		var headRow = headGrid.selectedRows();
		var rowIndex = headRow.length;
		if(headRow.length<=0){
			alert("请选择对应的订单头信息");
			return;
		}
		var toElsAccount = headRow[0].toElsAccount;
		var purchaseSampleNumber = headRow[0].purchaseSampleNumber;
		var row = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseSampleNumber":purchaseSampleNumber,"orderStatus":"0"};
		itemGrid.addRow(row);
	});
	
	//删除行
	$("#delRow").click(function(){
		var rowIndex = itemGrid.selectedRowsIndex();
		if(rowIndex.length<=0){
			alert("请选择行");
			return;
		}
		itemGrid.removeRow(rowIndex);
	});
	
	$("#updBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var additionCostStatus = headRecord.additionCostStatus;
			var sendStatus = headRecord.sendStatus;
			var person = headRecord.person;//subAccount_name
			var currPerson = elsSubAccount+"_"+userName;
			if((additionCostStatus == "0" && sendStatus == "0") || additionCostStatus == "3"){
				if(person == currPerson && "add" == headRecord.additionCostType){
					parent.elsDeskTop.defineWin({
				        iconSrc : "icon/icon9.png",
				        windowsId : "saleAdditionCostUpd",
				        windowTitle : "<i18n:I18n defaultValue='修改样品单' key=''/>",
				        iframSrc : "${pageContext.request.contextPath}/samplemanage/purchase/purchaseSampleUpd.jsp?"
				        		+"elsAccount="+headRecord.elsAccount
				        		+"&toElsAccount="+headRecord.toElsAccount
				        		+"&additionCostType="+headRecord.additionCostType
				        		+"&additionCostNumber="+ headRecord.additionCostNumber,
				        showAdv : true,
				        windowStatus : "maximized",
				        windowMinWidth : 960,
				        windowMinHeight : 700,
				        windowWidth : 960,
				        windowHeight : 700,
				        parentPanel : ".currDesktop"
				    });
				} else {
					alert("<i18n:I18n defaultValue='非销售负责人,禁止修改' key='i18n_alert_canotUpd_notSalePerson'/>",2);
				}
			} else {
				alert("<i18n:I18n defaultValue='已发送,禁止修改' key='i18n_alert_canotUpd_hasSend'/>",2);
			}
		}
	});
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var additionCostStatus = headRecord.additionCostStatus;
			var sendStatus = headRecord.sendStatus;
			var person = headRecord.person;
			var currPerson = elsSubAccount+"_"+userName;
			var sendStatus = headRecord.sendStatus;
			if((additionCostStatus == "0" && sendStatus == "0") || additionCostStatus == "3"){
				if(person == currPerson && "add" == headRecord.additionCostType){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/SaleAdditionCostService/delSaleAdditionCost",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(selectRows),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
							
							var selectedIndexes = headGrid.selectedRowsIndex();
							headGrid.removeRow(selectedIndexes);
							
							clearItemtable();
							clearFiletable();
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",1);
						}
					});
				} else {
					alert("<i18n:I18n defaultValue='非销售负责人,禁止删除' key='i18n_alert_canotDel_notSalePerson'/>",2);
				}
			} else {
				alert("<i18n:I18n defaultValue='已发送,禁止删除' key='i18n_alert_canotDel_hasSend'/>",2);
			}
		}
	});
	
	$("#confirmBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var additionCostType = headRecord.additionCostType;
			if("ded" == additionCostType){
				$.ajax({
					url :"${pageContext.request.contextPath}/rest/SaleAdditionCostService/confirmAdditionCost",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(headRecord),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						var status = data.statusCode;
						if("200" == status){
							alert("<i18n:I18n defaultValue='确认成功' key='i18n_alert_confirm_success'/>",1);
							refreshData();
						} else {
							alert(data.message,2);
						}
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='确认失败' key='i18n_alert_confirm_error'/>",3);
					}
				});
			}
		}
	});
	
	$("#returnBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var headRecord = selectRows[0];
			var additionCostType = headRecord.additionCostType;
			if("ded" == additionCostType){
				$.ajax({
					url :"${pageContext.request.contextPath}/rest/SaleAdditionCostService/rejectAdditionCost",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(headRecord),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						var status = data.statusCode;
						if("200" == status){
							alert("<i18n:I18n defaultValue='退回成功' key='i18n_alert_reject_success'/>",1);
							refreshData();
						} else {
							alert(data.message,2);
						}
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='退回失败' key='i18n_alert_reject_error'/>",3);
					}
				});
			}
		}
	});
	
	//发送
	$("#sendBtn").click(function(){
		var url     = "" ;
		var frm     = $("#form") ;
		var jsonObj = frm.serializeJSON()||{} ;
		
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading() ;
			//组装json开始---------------
			var headGrids = headGrid.selectedRows() ;
			jsonObj["elsAccount"]           = elsAccount ;
			jsonObj["toElsAccount"]         = headGrids[0].toElsAccount ;
			jsonObj["purchaseSampleNumber"] = headGrids[0].purchaseSampleNumber ;
			
			var saleSampleItemVOs = [] ;
			var saleSampleItemTableRows = itemGrid.rows() ;
			if(saleSampleItemTableRows != "" && saleSampleItemTableRows != null){
				for(var i = 0 ; i < saleSampleItemTableRows.length ; i ++){
					var singleRow   = saleSampleItemTableRows[i] ;
					singleRow       = inputSetValue(singleRow,i) ;
					saleSampleItemVOs.push(JSON.stringify(singleRow)) ;
				}
			}
			
			if(updateFile==true){
				//获取表单文件信息sale_bidding_file
				var saleSampleFileVOs = [];//用于存放表单文件信息
				//判断是否切换文件显示的界面，如果没有切换，则不需要更新文件信息 
				var selectRows = fileGrid.rows();
				if(selectRows.length > 0){
					for(var j = 0 ; j < selectRows.length ; j ++){
						saleSampleFileVOs.push(JSON.stringify(selectRows[j]));				
					}
				}
				jsonObj['saleSampleFileVOs']        = eval('['+saleSampleFileVOs+']'); 
			}
			
			jsonObj['saleSampleItemVOs'] = eval('['+saleSampleItemVOs+']');			
			$.ajax({
				url 		: "<%=basePath%>rest/SaleSampleService/saleReleaseSampleInfo",
				type 		: "post",
				contentType : "application/json",
				data 		: JSON.stringify(jsonObj),
				dataType 	: "json",
				success     : function(data) {
	    			alert('<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />',1);
	    			parent.elsDeskTop.hideLoading() ;
				},error     : function(data) {
	    			alert('<i18n:I18n key="i18n_common_sendfail" defaultValue="发送失败" />',3);
	    			parent.elsDeskTop.hideLoading() ;
	    		}
			});						
		}});		
	});
	
	function inputSetValue(materialLine,index){
	    //获取改行计价度量单位
	    var quantity                 = $("#quantity_"+index).val();
	    materialLine["quantity"]     = quantity;
	  
	    var unitQuantity             = $("#unitQuantity_"+index).val();
	    materialLine["unitQuantity"] = unitQuantity;
	    
	    var remark                   = $("#remark_"+index).val();
	    materialLine["remark"]       = remark;	    
	    return materialLine;
	}
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageHead&window=iframeApp_saleAdditionCostManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	$("#itemDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageItem&window=iframeApp_saleAdditionCostManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	$("#fileDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleAdditionCostManageFile&window=iframeApp_saleAdditionCostManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	function refreshData(){
		var purchaseSampleNumber = $("#purchaseSampleNumber").val();
		var createDateFrom = $("#createDateFrom").val();
		var createDateTo = $("#createDateTo").val();
		var toElsAccount = $("#toElsAccount").val();
		
		var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	purchaseSampleNumber : purchaseSampleNumber,
	    	createDateFrom : createDateFrom,
	    	createDateTo : createDateTo,
	    };
		headGrid.opts.params = queryParam;
		headGrid.load({page:1});
		//headGrid.load(queryParam);
	}
	
	//显示上传弹框
	$("#uploadFile").click(function(){
		 initFileUploader(fileUploader);
		 $('.fixed-dialog').show();
	});
	
	//初始化文件上传控件
	function initFileUploader(fileUploader){
	   if(!fileUploader){
	    //新增表单文件
	  	fileUploader = WebUploader.create({
	  	    // swf文件路径
	  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
	  	  	duplicate :true,
	  	    auto: true,
	  	    // 文件接收服务端。
	  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
	  	    // 选择文件的按钮。可选。
	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	  	    pick: '#btnFileUpload',
	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	  	    resize: false
	  	 });
	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
	  	  	if(0 == response.error){
	  	   	   var filePath = response.url;
	  	   		$("#filePath").val(filePath);
	  	   	    $("#fileName").val(response.name);
	  	   	    $("#fileSize").val(response.size);
	  	  	}else{
	  	  		alert(response.message,2);
	  	  	}
	  	});
	  }
	}
	
	//关闭上传弹框
	$("#btnFileCancel ,.dialog-close-btn").click(function(){
		 $('.fixed-dialog').hide();
	});
	
	//显示上传弹框
	$("#btnFileOK").click(function(){
		addFileItem();
   	    updateFile = true;
	});
	
	//在文件列表添加新添加的文件列
	function addFileItem(){
		var filePath=$("#filePath").val();
		var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
		var fileName=$("#fileName").val();
		var fileSize = $("#fileSize").val();
		var fileBlackItem={fileName:fileName,fileType:fileType,filePath:filePath,fbk1 :fileSize,remark:""};
		fileGrid.addRow(fileBlackItem);
		$('.fixed-dialog').hide();
	}
		
    //在线预览文件
    function previewFile(filePath){
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var param = {
				elsAccount : elsAccount,
				filePath : filePath
		};
    	
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	} else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
	    	$.ajax({
				url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
				type :"POST",
				data : JSON.stringify(param),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					var resStatus = data.statusCode;
					var message = data.message;
					if("200" == resStatus){
						var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
						var width=$("#file-display").width();
						var height=$("#file-display").height();
						$("#viewerPlaceHolder").css("width",width+"px");  
						$("#viewerPlaceHolder").css("height",height+"px");  
						$("#viewerPlaceHolder").css("display","block" );  
	
						var fp = new FlexPaperViewer(
						            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
						            'viewerPlaceHolder', 
						            {config : {
						                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
						                Scale : 1.5,//初始化缩放比例(1=100%)
						                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
						                ZoomTime : 0.5,//切换缩放比例延迟显示时间
						                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
						                FitPageOnLoad : false,//初始化时自适应页面
						                FitWidthOnLoad : false,//初始化时自适应宽度
						                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
						                ProgressiveLoading : true,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
						                MinZoomSize : 0.2,//最小缩放比例
						                MaxZoomSize : 5,//最大缩放比例
						                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
						                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
						                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
						                ZoomToolsVisible : true,//工具浪是否显示缩放工具
						                NavToolsVisible : true,//工具栏是否显示导航工具
						                CursorToolsVisible : true,//工具栏是否显示光标
						                SearchToolsVisible : true,//工具栏是否显示搜索工具
						                localeChain: 'zh_CN'//地区语言(en_US:English,)
						            	}
						            });
					} else {
						alert(message,2);
					}
				},
				error : function(data) {
					alert(data.message,3);
				}
			});
    	} else {
    		alert("<i18n:I18n defaultValue='不支持的在线预览文档类型' key='i18n_alert_fileType_notSupport'/>",2);
    	}
    }

    $("#addBtn").click(function(){
	  var head = headGrid.rows();
	  var item = itemGrid.rows();
	  if("undefined" == typeof(head[0])){
		  alert("请查询库存数量！",2);
		  return;
	  }
	  var frm = $("#form");
	  var jsonObj ={
			  "elsAccount":head[0].elsAccount,"elsDesc":head[0].elsDesc,
			  "toElsAccount":head[0].toElsAccount,"toElsDesc":head[0].toElsDesc,
			   "planDate":head[0].planDate,
			  physicalInventoryItemVOList:item
			  };
	 var formData = frm.serializeJSON();
	 var pageData = $.extend(true,{},jsonObj,formData);
	   $.ajax({
			url 		: "${pageContext.request.contextPath}/rest/PhysicalInventoryService/insertPhysicalInventory",
			type 		: "post",
			contentType : "application/json",
			data 		: JSON.stringify(pageData),
			dataType 	: "json",
			success     : function(data) {
				var status = data;
				if("200" == status){
					alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
					
	  				parent.frames['iframeApp_'+(addFlag=="s"?'sale':'purchase')+'PhysicalInventory'].init();
	  				parent.elsDeskTop.closeCurWin('purchasePhysicalInventoryManageAdd');
				} else {
					alert(data.message,2);
				}
			},error     : function(data) {
  				alert('<i18n:I18n key="i18n_common_alert_saveFail" defaultValue="保存失败！" />',3);
  				parent.elsDeskTop.hideLoading() ;
  		}
		});			 		
	});
    $("#stockBtn").click(function(){
	     parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "purchasePhysicalInventoryManageStock",
	        windowTitle : "<i18n:I18n defaultValue='查询库存' key=''/>",
	        iframSrc : "${pageContext.request.contextPath}/physicalinventory/purchase/purchasePhysicalInventoryManageStock.jsp",
	        showAdv : true,
	        windowMinWidth : 860,
	        windowMinHeight : 600,
	        windowWidth : 860,
	        windowHeight : 600,
	        parentPanel : ".currDesktop"
	    }); 
	});
    
    function setStockValue(stockList){
    	headGrid.removeRow();
    	itemGrid.removeRow();
    	for(var i = 0 ; i < stockList.length; i++ ){
    		var stock = stockList[i];
    		if(i==0){
	   		 	var stockBlackHeader={'elsAccount':stock.elsAccount,'elsDesc':stock.elsDesc,'toElsAccount':stock.toElsAccount,'toElsDesc':stock.toElsDesc};
	    		headGrid.addRows([stockBlackHeader]);
    		}
    		var stockBlackItem={
    				'elsAccount':stock.elsAccount,
    				'elsDesc':stock.elsDesc,
    				'toElsAccount':stock.toElsAccount,
    				'toElsDesc':stock.toElsDesc,
    				'stockQuantity':stock.quantity,
    				'stockNumber':stock.voucherNumber,
    				'purchaseFactory':stock.factory,
    				'purchaseMaterialNumber':stock.materialNumber,
    				'purchaseMaterialDesc':stock.materialDesc,
    				'purchaseMaterialSpec':stock.materialSpec,
    				'purchaseMaterialAttr1':stock.materialAttr1,
    				'purchaseMaterialAttr2':stock.materialAttr2,
    				'purchaseMaterialAttr3':stock.materialAttr3,
    				'purchaseMaterialAttr4':stock.materialAttr4,
    				'purchaseMaterialAttr5':stock.materialAttr5
    				};
    		if(addFlag=="s"){
    			 stockBlackItem={
    				'elsAccount':stock.elsAccount,
    				'elsDesc':stock.elsDesc,
    				'toElsAccount':stock.toElsAccount,
    				'toElsDesc':stock.toElsDesc,
    				'stockQuantity':stock.quantity,
    				'stockNumber':stock.voucherNumber,
					'saleFactory':stock.factory,
					'saleMaterialNumber':stock.materialNumber,
    				'saleMaterialDesc':stock.materialDesc,
    				'saleMaterialSpec':stock.materialSpec,
    				'saleMaterialAttr1':stock.materialAttr1,
    				'saleMaterialAttr2':stock.materialAttr2,
    				'saleMaterialAttr3':stock.materialAttr3,
    				'saleMaterialAttr4':stock.materialAttr4,
    				'saleMaterialAttr5':stock.materialAttr5
    				};
    		}
    		itemGrid.addRows([stockBlackItem]);
    	}
    }
    
	//初始化聊天窗口
	//ELS账号+订单号 作为 businessID
	//TODO: 多人聊天需要传值 peopleList
	function initChat(data) {
		var elsAccount ='<%=session.getAttribute("elsAccount") %>',
	  		elsSubAccount ='<%=session.getAttribute("elsSubAccount") %>',
			toElsAccount = '',
			toElsSubAccount ='';
		var businessId = '';
		var peopleList = [];
		var costType = "";
		if(data) {
		 toElsAccount = data[0].toElsAccount;
		 businessId=''+data[0].purchaseSampleNumber;
		 //costType = data[0].additionCostType;
		 var obj={};
		 obj.name = data[0].toCompanyShortName;
		 peopleList.push(obj);
		}
		var peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
		var url = "multiChat.jsp?type=multi&fromElsAccount=" + elsAccount
			+ "&fromElsSubAccount=" + elsSubAccount
			+ "&toElsAccount=" + toElsAccount
			+ "&toElsSubAccount="+toElsSubAccount
			+ "&businessType=sampleOrder"
			+ "&businessID="+businessId
			+ "&costType="+costType
		    + "&list="+encodeURI(peopleListString)
			+ "&t="+new Date().getTime();
		 
		 $(".testIframe").attr("src","${pageContext.request.contextPath}/"+ url);
		 //滚动条美化niceScroll
		 $(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
	}

	function loadItem(elsAccount,toElsAccount,voucherNumber) {
		var queryParam = {
		    	elsAccount : elsAccount,
		    	toElsAccount : toElsAccount,
		    	voucherNumber : voucherNumber,
		    };
		$.extend(itemGrid.opts.params,queryParam);
	    //处理列 
		itemGrid.load();
	}
	
	function loadFile(elsAccount,toElsAccount,purchaseSampleNumber) {
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	purchaseSampleNumber : purchaseSampleNumber
	    };
		$.extend(fileGrid.opts.params,queryParam);
	    fileGrid.load();
	}
	
	function clearItemtable(){
		if(itemGrid.rowsLength() > 0){
			for(var i=itemGrid.rowsLength();i-1>=0;i--){
				itemGrid.removeRow(i-1);
			}
		}
	}
	
	function clearFiletable(){
		if(fileGrid.rowsLength() > 0){
			for(var i=fileGrid.rowsLength();i-1>=0;i--){
				fileGrid.removeRow(i-1);
			}
		}
	}
	
	function reGenFileTypeSelect(){
		var itemRowSize = itemGrid.rowsLength();
		var fileTypeSelect = $("#selectFileType");
		fileTypeSelect.empty();
		$("<option value='all'><i18n:I18n defaultValue='所有' key='i18n_common_option_all'/></option>").appendTo(fileTypeSelect);
		$("<option value='common'><i18n:I18n defaultValue='公共' key='i18n_common_option_common'/></option>").appendTo(fileTypeSelect);
		for(var i=0;i<itemRowSize;i++){
			var additionCostItemNumber = itemGrid.row(i).additionCostItemNumber;
			$("<option value='"+additionCostItemNumber+"'>"+additionCostItemNumber+"</option>").appendTo(fileTypeSelect);//文件下拉列表添加行项目选项
		}
	}
	
	//表单文件tag页 文件类型更改事件
	function selectFileTypeChange(){
		var selectFileType = $("#selectFileType").val();
		if("all" == selectFileType){//显示所有
			$("#fileTable tr").each(function(index,domElement){
				$(domElement).show();
			});
		} else if("common" == selectFileType){//只显示公共文件
			$("#fileTable tr").each(function(index,domElement){
				var itemNumber = fileGrid.row(index).additionCostItemNumber;
				if("" == itemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		} else {//显示指定行项目下的文件
			$("#fileTable tr").each(function(index,domElement){
				var itemNumber = fileGrid.row(index).additionCostItemNumber;
				if(selectFileType == itemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		}
	}
</script>
</body>
</html>