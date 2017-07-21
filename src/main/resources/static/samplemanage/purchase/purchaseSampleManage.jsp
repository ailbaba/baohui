<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="btnCreate"><i18n:I18n key=" " defaultValue="新建" /></button>
				<button class="button-wrap" id="btnInspect"><i18n:I18n key=" " defaultValue="送检" /></button>
				<button id="headcolumnDefineBtn" class="button-wrap">
					<i18n:I18n key="test" defaultValue="列自定义" />
				</button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<form id="form">
					<input name="elsAccount" type="hidden" value="${elsAccount}" />
					<input name="orderType" type="hidden" value="sample" />
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="供应商" />：</span><input
							id="toElsAccount" name="toElsAccount" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="物料" />：</span><input
							id="materialNumber" name="materialNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="采购组" />：</span><input
							id="purchaseGroup" name="purchaseGroup" type="text" />
					</div>
					<div id="div-fbk4" class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="采购负责人" />：</span>
						<input id="fbk4Param" name="fbk4Param" type="hidden" />
						<span id="fbk4Selector"></span>
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="订单状态" />：</span> <select
							id="orderStatusParam" name="orderStatusParam">
							<option value=""><i18n:I18n key=" " defaultValue="全部" /></option>
							<option value="0"><i18n:I18n key=" " defaultValue="未发送" /></option>
							<option value="1" ><i18n:I18n key=" " defaultValue="已发送" /></option>
						</select>
					</div>
					<div class="dis-in-b input-and-tip">
					    <span><i18n:I18n key="" defaultValue="需求日期" />：</span>
					    <input type="text" class="Wdate" onfocus="WdatePicker()" id="deliveryDateBegin" name="deliveryNoteTimeBegin"/>
					 </div>
	                <div class="dis-in-b input-and-tip">
	                    <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                    <input type="text"  class="Wdate" onfocus="WdatePicker()" id="deliveryDateEnd" name="deliveryNoteTimeEnd"/>
	                </div>
	                &nbsp;
					<button class="button-wrap" type="button" style="margin-left: 2%" id="seachBtn">
						<i18n:I18n key="i18n_common_button_query" defaultValue="查询" />
					</button>
				</form>
			</div>
		</div>
		<form id="frm" onsubmit="return false;">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key=" " defaultValue="样品订单" /></span>
				<div class="common-box-line">
					<div class="tab-wrap" id="sheet-head">
						<div id="sheet-item-one">
							<div class="grid-container">
								<div class="grid-100" id="deliveryNoteHeaderGrid">
									<table id="samplePOItemTable"></table>
									<div id="pg" style="text-align: right;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

<div class="fixed-dialog" id="selectDialog">
           <div class="dialog-tip bg-common" style="width: 602px;height: auto; margin-left: -261px;margin-top: -190px;">
               <div class="dialog-close-btn" id="selectClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="" defaultValue="提交送检" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                     <form id="selectForm" onsubmit="return false;">
                       <div class="common-box-line" >
                           <div class="input-and-tip">
                               <span>物料组别:</span>
                               <select name="materialGroup" id="materialGroup">
                                   <option value="电子">电子</option>
                                   <option value="结构">结构</option>
                                   <option value="包材">包材</option>
                               </select>
                               <span>&nbsp;承认类型:</span>
                               <select name="admitType" id="admitType">
                                   <option value="单一承认">单一承认</option>
                                   <option value="系列承认">系列承认</option>
                               </select>
                               <span>&nbsp;承认属性:</span>
                               <select name="replaceAdmit" id="replaceAdmit">
                                   <option value="新物料承认">新物料承认</option>
                                   <option value="替代料承认">替代料承认</option>
                               </select>
                               <span>&nbsp;更新信息:</span>
                               <select name="isUpdatePurchseInfo" id="isUpdatePurchseInfo">
                                   <option value="1">是</option>
                                   <option value="0">否</option>
                               </select>
                           </div>
                           <div class="input-and-tip">
                               <span>申请部门:</span>
                               <input type="text" name="applyDepartment" id="applyDepartment" style="width: 80px;">
                               <span>&nbsp;送样人:</span>
                               <input type="text" name="samplePeople" id="samplePeople" style="width: 80px;">
                               <span>&nbsp;承认需求时间:</span>
                               <input type="text" name="admitNeedDate" id="admitNeedDate" style="width: 90px;" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                           </div>
	                       <div class="mt-20 text-center">
	                          <button id="selectOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                      <button id="selectCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
	                     </form>
                       </div>
                   </div>
         </div>
</div>

<script type="text/javascript">
var itemGrid;
var selector = '<base:subAccount role='purchase' elsAccount='${elsAccount }' type='multiple' id='fbk4' ></base:subAccount>';
	
var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="sampleOrderItem_mt"/>;

$().ready(function() {
		
	 $("#fbk4Selector").html(selector);
	 $("#fbk4").val(elsSubAccount + "_" + username);
	 $("#fbk4").attr("placeholder",'<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />');
	 $("#fbk4").SumoSelect({optAfter:'#div-fbk4',optCancel:'#div-fbk4 .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	 $(".SlectBox").each(function(){
			$(this).css({ "padding-top": "0",
			              "padding-bottom": "0",
			              "line-height": "20px",
			              "height": "21px",
			              "font-size": "12px",
			              "max-width": "150px",
			              "border-radius": "2px"
			              });
	 });
	 var fbk4Param = $("#fbk4").val();
	 $("#fbk4Param").val(fbk4Param);
	
	 initData();
	    //新建
		$("#btnCreate").click(function(){
			createSamplePO();
		});
		
		//查询
		$("#seachBtn").click(function(){
			query();
		});
		
		$("#createOK").click(function(){
			carateDeliverNote();
		});
});

window.query = function() {
	var fbk4Param = $("#fbk4").val();
	 $("#fbk4Param").val(fbk4Param);
	var frm = $("#form");
	itemGrid.opts.params = frm.serializeJSON();
	itemGrid.load({page:1});
}

function operation(val,item,index){
	var text = '<span class="sample-detail" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block"><i18n:I18n key="" defaultValue="详细" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	return text;
}

//行信息列自定义
$("#headcolumnDefineBtn").click(function(){
		 parent.elsDeskTop.defineWin({
		     'iconSrc':'icon/els-icon.png',
		     'windowsId':'subAccountColumnSetting',
		     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="行信息列自定义" />',
		     windowSubTitle: "",
		     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=sampleOrderItem_mt" + "&window=iframeApp_purchaseSampleManage",
		     windowMinWidth: 480,
		     windowMinHeight: 600,
		     'windowWidth':480,
		     'windowHeight':600,
		     'parentPanel':".currDesktop"
		  });
 });
 
function initAddFile(val,item,index){
	var showText='';
	if(!val){
		return "";
	}else{
		var fileArray = val.split(";");
		for(var i in fileArray){
			var file = fileArray[i];
			showText += file.substring(file.indexOf("_")+1,file.length)+";"
		}
		showText=showText.substring(0,showText.length-1);
	}
	return '<span class="click-addFile" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
}

function currentStatus(val,item,index){
	if(item && item.inspectFlag){
		return "认证中";
	}else if(val && val != "0"){
		return "已发货";
	}else if(item && (item.orderStatus == "1" || item.orderStatus == "4")){
		return "已确认";
	}else if(item && (item.orderStatus == "2" || item.orderStatus == "5")){
		return "已退回";
	}else if(item && item.orderSendStatus != "0" ){
		return "已发送";
	}else{
		return "草稿";
	}
}

function initData(){
	itemGrid= $('#samplePOItemTable').mmGrid({
		     cols: cols_item,
		     url :"<%=basePath%>rest/PurchaseSampleService/findSamplePOList",
	 	     params: $("#form").serializeJSON(),
	 	     method:  "post",
	 	     root:"rows",
		     remoteSort:true,
		     checkCol:true,
		     multiSelect : true,
			 nowrap:true,
			 height :330,
		     loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		     noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
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
		                 , limitList: [20,50,100]
		             })
		         ]
		});		
}	

	
//详细页面
$(".sample-detail").live("click", function(){
    var sanContent = $(this).next().text();
    var item = JSON.parse(sanContent);
    var purchaseOrderNumber = item.purchaseOrderNumber;
    var fbk28 = item.fbk28;
    var deliveryDate = item.deliveryDate;
    if(deliveryDate){
    	deliveryDate = new Date(deliveryDate).format("yyyy-MM-dd");
    }
    var orderSendStatus = item.orderSendStatus;
    showDetail(purchaseOrderNumber,fbk28,"样品订单明细",deliveryDate,orderSendStatus);
});

//新建
function createSamplePO(){
	showDetail('null','null',"新建样品订单");
}

function showDetail(purchaseOrderNumber,fbk28,title,deliveryDate,sendStatus){
	var currId=$(window.frameElement).attr('id')
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
        'windowsId':'addSamplePO',
        'windowTitle':title,
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>samplemanage/purchase/addSamplePO.jsp?currId='+currId+'&purchaseOrderNumber='+purchaseOrderNumber+'&fbk28='+fbk28+'&deliveryDate='+deliveryDate+'&sendStatus='+sendStatus,
        'showAdv': false,
        'windowStatus': 'maximized',
        'parentPanel':".currDesktop"
    });
}

//查看附件
$(".click-addFile").live("click", function(){
	var sanContent = $(this).next().text();
    var item = JSON.parse(sanContent);
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',	
        'windowsId':'showFileInfo',
        'windowTitle':'文件详情列表',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>filemanage/showFileInfo.jsp?fileNumber='+item.fbk27+'&toElsAccount='+elsAccount,
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 500,
        'windowPositionTop':20,
        'windowWidth':960,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
});

$("#selectClose").click(function(){
	$("#selectDialog").hide();
});

$("#selectCancel").click(function(){
	$("#selectDialog").hide();
});

//送检
$("#btnInspect").click(function(){
	var selectRowsIndex = itemGrid.selectedRowsIndex();
	if(selectRowsIndex.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var selectRows = itemGrid.selectedRows();//返回所选择的数据行
	var toElsAccount="";
	for(var i = 0 ; i < selectRows.length ; i ++){
		var row = selectRows[i];
		var checkElsAccount = row.toElsAccount;
		if(i == 0){
			toElsAccount = checkElsAccount;
		}else{
			if(toElsAccount != checkElsAccount){
				alert("只能针对同一个供应商做送检操作！",2);
				return;
			}
		}
		if(row.deliveryStatus == "0"){
			alert("请选择已发货记录送检！",2);
			return;
		}
	}
	$('body').data("selectRows",selectRows);
	$("#applyDepartment").val("采购部门");
	$("#samplePeople").val(username);
	$("#admitNeedDate").val("");
	$("#selectDialog").show();
});	

//送检弹出框确认操作
$("#selectOK").click(function(){
	var currId=$(window.frameElement).attr('id')
	var selectRows = $('body').data("selectRows");
	var selectItem = $("#selectForm").serializeJSON();
	var applyDepartment = selectItem.applyDepartment;
	if($.trim(applyDepartment) == ""){
		alert("申请部门不能为空",2);
		return;
	}
	var samplePeople = selectItem.samplePeople;
	if($.trim(samplePeople) == ""){
		alert("送样人不能为空",2);
		return;
	}
	var admitNeedDate = selectItem.admitNeedDate;
	if($.trim(admitNeedDate) == ""){
		alert("需求承认时间不能为空",2);
		return;
	}
	selectItem["toElsAccount"]=selectRows[0].toElsAccount;
	selectItem["supplierName"]=selectRows[0].companyShortName;
	selectItem["supplierCode"]=selectRows[0].supplierCode;
	var paramObj = {"selectItem":selectItem};
	paramObj["selectRows"] = selectRows;
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:"请确认选中的待送检清单是否属于如上同一分类，如不是，请“取消”后重新选择。",closeEvent:function(){
		$("#selectDialog").hide();
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
	        'windowsId':'samplePOInspect',
	        'windowTitle':'<i18n:I18n key="" defaultValue="物料承认送检单" />',
	        'windowSubTitle': companyShortName,
	        'iframSrc':'<%=basePath%>samplemanage/purchase/samplePOInspect.jsp?currId='+currId,
	        'showAdv': false,
	        'windowStatus': 'maximized',
	        'windowMinWidth': 960,
	        'windowMinHeight': 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop",
	        'data':paramObj
	    });
	}});
});
	
</script>
</body>
</html>