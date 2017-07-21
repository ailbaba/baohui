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
                <button id="delBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete"/></button> 
                <button id="sendBtn" class="button-wrap"><i18n:I18n defaultValue="发送" key="i18n_button_send"/></button>
                <button id="differBtn" class="button-wrap"><i18n:I18n defaultValue="盘点差异表" key=""/> </button>
                <button id="actualBtn" class="button-wrap"><i18n:I18n defaultValue="盘点实数" key=""/> </button>
                <button id="adjustmentStock" class="button-wrap"><i18n:I18n defaultValue="调整库存" key=""/> </button>
<%--                 <button id="updBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update"/></button> --%>
                <%--
                <button id="returnBtn" class="button-wrap"><i18n:I18n defaultValue="退回" key="i18n_busRecon_select_busReconStatus_reject"/></button> --%>
                 <%-- <button id="confirmBtn" class="button-wrap"><i18n:I18n defaultValue="确认" key="i18n_common_button_confirm"/></button> --%>
                <%-- <button id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button> --%>
                <button class="button-wrap" id="toErp"><i18n:I18n key="i18n_button_toERP" defaultValue="写入ERP" /></button>
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
					<span><i18n:I18n defaultValue="单据状态" key=""/>:</span>
					<select id="voucherStatus" name="voucherStatus">
						<option value="">请选择</option>
						<option value="0">新建</option>
						<option value="1">盘点中</option>
						<option value="2">已盘点</option>
					</select>
				</div>	
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="发送状态" key=""/>:</span>
					<select id="sendStatus" name="sendStatus">
						<option value="">请选择</option>
						<option value="0">未发送</option>
						<option value="1">已发送</option>
					</select>
				</div>	
				 <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="确认状态" key=""/>:</span>
					<select id="confirmStatus" name="confirmStatus">
						<option value="">请选择</option>
						<option value="0">未确认</option>
						<option value="1">确认中</option>
						<option value="2">已确认</option>
					</select>
				</div>	
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
	var updateFile = false     ;
		
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
			return "新建中";
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
			return "新建中";
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
			{ title:"采购方物料属性1", name:"purchaseMaterialAttr1",hidden:true, width:100, align:"center"},
			{ title:"采购方物料属性2", name:"purchaseMaterialAttr2",hidden:true, width:100, align:"center"},
			{ title:"采购方物料属性3", name:"purchaseMaterialAttr3",hidden:true, width:100, align:"center"},
			{ title:"采购方物料属性4", name:"purchaseMaterialAttr4",hidden:true, width:100, align:"center"},
			{ title:"采购方物料属性5", name:"purchaseMaterialAttr5",hidden:true, width:100, align:"center"},
			{ title:"采购方工厂", name:"purchaseFactory", width:100, align:"center"},
			{ title:"采购方库存地", name:"purchaseStockLocation", width:100, align:"center"},
			{ title:"采购方库存状态", name:"purchaseStockStatus", width:100, align:"center",renderer:renderItemResult},
			{ title:"采购方特殊库存标识", name:"purchaseStockTag",hidden:true, width:100, align:"center"},
			{ title:"销售方物料编号", name:"saleMaterialNumber", width:100, align:"center"},
			{ title:"销售方物料描述", name:"saleMaterialDesc", width:100, align:"center"},
			{ title:"销售方物料行规格",name:"saleMaterialSpec",hidden:true, width:100, align:"center"},
			{ title:"销售方物料属性1", name:"saleMaterialAttr1",hidden:true, width:100, align:"center"},
			{ title:"销售方物料属性2", name:"saleMaterialAttr2", hidden:true,width:100, align:"center"},
			{ title:"销售方物料属性3", name:"saleMaterialAttr3",hidden:true, width:100, align:"center"},
			{ title:"销售方物料属性4", name:"saleMaterialAttr4",hidden:true, width:100, align:"center"},
			{ title:"销售方物料属性5", name:"saleMaterialAttr5", hidden:true,width:100, align:"center"},
			{ title:"销售方工厂", name:"saleFactory", width:100, align:"center"},
			{ title:"销售方库存地", name:"saleStockLocation", width:100, align:"center"},
			{ title:"销售方库存状态", name:"saleStockStatus", hidden:true,width:100, align:"center",renderer:renderItemResult},
			{ title:"销售方特殊库存标识", name:"saleStockTag", hidden:true,width:100, align:"center"},
			{ title:"实盘数量", name:"actualQuantity", width:100, align:"center"},
			{ title:"结存数", name:"stockQuantity", width:100, align:"center"},
			{ title:"差异数", name:"stockQuantityDiff", width:100, align:"center"},
			{ title:"基本单位", name:"basicUnit", width:100, align:"center"},
			{ title:"结算金额", name:"settleAmount", hidden:true,width:100, align:"center"},
			{ title:"结算货币", name:"settleCurrency",hidden:true, width:100, align:"center"},
			
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

    headGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
    	loadItem(item.elsAccount,item.toElsAccount,item.voucherNumber);//根据头表选中项加载行项目信息
		//loadFile(item.elsAccount,item.toElsAccount,item.purchaseSampleNumber);//根据头表选中项加载文件信息
		// 动态加载聊天窗口
		var hadSelected = headGrid.selectedRows();
		if(hadSelected && hadSelected.length) {
			initChat(hadSelected);
    	}
  	});
    
    fileGrid.on("loadSuccess", function(e, item, rowIndex, colIndex){
    	reGenFileTypeSelect();
  	});
    
    fileGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
  		previewFile(filePath);
  	});
	
	$("#queryHeadBtn").click(function(){
		query();
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
	$("#delItemBtn").live("click", function() {
		var scanCol = $(this).next();
        var sanContent = scanCol.text();
		if(confirm("确认删除选中行吗")){
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/PhysicalInventoryService/delPhysicalInventoryItem",
				type : "post",
				contentType : "application/json",
				data : sanContent,
				dataType : "json",
				success : function(data) {
					var status = data;
					if("200" == status){
						alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
						var selectedIndexes = itemGrid.selectedRowsIndex();
						itemGrid.removeRow(selectedIndexes);
					} else {
						alert(data.message,2);
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",1);
				}
			});
		}
	});
	

    $("#addBtn").click(function(){
	    parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "purchasePhysicalInventoryManageAdd",
	        windowTitle : "<i18n:I18n defaultValue='新建外协盘点' key=''/>",
	        iframSrc : "${pageContext.request.contextPath}/physicalinventory/purchase/purchasePhysicalInventoryManageAdd.jsp?addFlag=s",
	        showAdv : true,
	        windowStatus : "maximized",
	        windowMinWidth : 960,
	        windowMinHeight : 700,
	        windowWidth : 960,
	        windowHeight : 700,
	        parentPanel : ".currDesktop"
	    }); 
	});
    
    $("#differBtn").click(function(){
    	var selectRows = headGrid.selectedRows();
    	var voucherNumber = selectRows[0].voucherNumber;
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		    parent.elsDeskTop.defineWin({
		        iconSrc : "icon/icon9.png",
		        windowsId : "purchasePhysicalInventoryManageDiffer",
		        windowTitle : "<i18n:I18n defaultValue='盘点差异表' key=''/>",
		        iframSrc : "${pageContext.request.contextPath}/physicalinventory/purchase/purchasePhysicalInventoryStockDiff.jsp?voucherNumber="+voucherNumber,
		        showAdv : true,
		        windowStatus : "maximized",
		        windowMinWidth : 960,
		        windowMinHeight : 700,
		        windowWidth : 960,
		        windowHeight : 700,
		        parentPanel : ".currDesktop"
		    }); 
		}
	});
    
    $("#actualBtn").click(function(){
    	var selectRows = headGrid.selectedRows();
    	var voucherNumber = selectRows[0].voucherNumber;
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		    parent.elsDeskTop.defineWin({
		        iconSrc : "icon/icon9.png",
		        windowsId : "salePhysicalInventoryManageActual",
		        windowTitle : "<i18n:I18n defaultValue='盘点实数' key=''/>",
		        iframSrc : "${pageContext.request.contextPath}/physicalinventory/sale/salePhysicalInventoryManageActual.jsp?voucherNumber="+voucherNumber,
		        showAdv : true,
		        windowStatus : "maximized",
		        windowMinWidth : 960,
		        windowMinHeight : 700,
		        windowWidth : 960,
		        windowHeight : 700,
		        parentPanel : ".currDesktop"
		    }); 
		}
	});
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		if(selectRows.length<=0){
			alert("请选择行");
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
				var headRecord = selectRows[0];
				var voucherStatus = headRecord.voucherStatus;
				if(voucherStatus == "0"){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/PhysicalInventoryService/delPhysicalInventoryHeader",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(selectRows),
						dataType : "json",
						success : function(data) {
							var status = data;
							if("200" == status){
								alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
								var selectedIndexes = headGrid.selectedRowsIndex();
								headGrid.removeRow(selectedIndexes);
								clearItemtable();
							} else {
								alert(data.message,2);
							}
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",1);
						}
					});
				} else {
					alert("<i18n:I18n defaultValue='已发送,禁止删除' key='i18n_alert_canotDel_hasSend'/>",2);
				}
			}
		}});
	});
	
	$("#confirmBtn").click(function(){
		var head = headGrid.selectedRows();
		var item = itemGrid.rows();
		if(head.length<=0){
			alert("请选择行");
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
			var headRecord = head[0];
			var voucherStatus = headRecord.voucherStatus;
			if(voucherStatus == "1"){
				$.ajax({
					url :"${pageContext.request.contextPath}/rest/PhysicalInventoryService/confirmPhysicalInventory",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(pageData),
					dataType : "json",
					success : function(data) {
						var status = data;
						if("200" == status){
							alert("<i18n:I18n defaultValue='确认成功' key='i18n_alert_confirm_success'/>",1);
							query();
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
	
	//发送
	$("#sendBtn").click(function(){
		var head = headGrid.selectedRows();
		var item = itemGrid.rows();
	    var jsonObj ={
			  "elsAccount":head[0].elsAccount,"elsDesc":head[0].elsDesc,
			  "toElsAccount":head[0].toElsAccount,"toElsDesc":head[0].toElsDesc,
			  "voucherNumber":head[0].voucherNumber,"voucherYear":head[0].voucherYear,
			  "voucherDate":head[0].voucherDate,"planDate":head[0].planDate,
			  "freezeStock":head[0].freezeStock,"createDate":head[0].purchaseRemark,
			  "saleRemark":head[0].saleRemark,"createDate":head[0].createDate,
			 "physicalInventoryItemVOList":item
			  };
	    var headRecord = head[0];
		var confirmStatus = headRecord.confirmStatus;
		if(confirmStatus=="2"){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				$.ajax({
					url 		: "${pageContext.request.contextPath}/rest/PhysicalInventoryService/saleSendPhysicalInventory",
					type 		: "post",
					contentType : "application/json",
					data 		: JSON.stringify(jsonObj),
					dataType 	: "json",
					success     : function(data) {
						var status = data;
						if("200" == status){
							alert('<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />',1);
			    			query();
						} else {
							alert(data.message,2);
						}
					},error     : function(data) {
		    			alert('<i18n:I18n key="i18n_common_sendfail" defaultValue="发送失败" />',3);
		    			parent.elsDeskTop.hideLoading() ;
		    		}
				});						
			}});		
		}else {
			alert('<i18n:I18n key="" defaultValue="未实数盘点" />',2);
		}
	});
	
	$("#adjustmentStock").click(function(){
		var head = headGrid.selectedRows();
		var item = itemGrid.rows();
		if(head.length<=0){
			alert("请选择",2);
			return;
		}
	    var jsonObj ={
			  "elsAccount":head[0].elsAccount,"elsDesc":head[0].elsDesc,
			  "toElsAccount":head[0].toElsAccount,"toElsDesc":head[0].toElsDesc,
			  "voucherNumber":head[0].voucherNumber,"voucherYear":head[0].voucherYear,
			  "voucherDate":head[0].voucherDate,"planDate":head[0].planDate,
			  "freezeStock":head[0].freezeStock,"createDate":head[0].purchaseRemark,
			  "saleRemark":head[0].saleRemark,"createDate":head[0].createDate,
			 "physicalInventoryItemVOList":item
			  };
	    var headRecord = head[0];
		var confirmStatus = headRecord.confirmStatus;
		if(confirmStatus == "2" ){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				$.ajax({
					url 		: "${pageContext.request.contextPath}/rest/PhysicalInventoryService/saleAdjustmentStock",
					type 		: "post",
					contentType : "application/json",
					data 		: JSON.stringify(jsonObj),
					dataType 	: "json",
					success     : function(data) {
						var status = data;
						if("200" == status){
							alert('<i18n:I18n key="" defaultValue="调整成功" />',1);
			    			query();
						} else {
							alert(data.message,2);
						}
					},error     : function(data) {
		    			alert('<i18n:I18n key="" defaultValue="调整失败" />',3);
		    			parent.elsDeskTop.hideLoading() ;
		    		}
				});						
			}});		
		}else {
			alert('<i18n:I18n key="" defaultValue="未确认" />',2);
		}
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
		 businessId=''+data[0].voucherNumber;
		 //costType = data[0].additionCostType;
		 var obj={};
		 obj.name = data[0].toElsDesc;
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