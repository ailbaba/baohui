<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<div class="pos-relative public-wrap ">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<%--
			<button class="button-wrap" id="affirmBtn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
		    <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
		    --%>
			<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>

	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<div class="common-box-line">
		<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		    <input type="hidden" name="elsAccount" value="${elsAccount}" />
		    <input type="hidden" id="toElsAccountHid" name="toElsAccount" />
		    <input type="hidden" id="biddingNumberHid" name="biddingNumber" />
		    <input type="hidden" id="biddingItemNumberHid" name="biddingItemNumber" />
		    <input type="hidden" id="roundsNumberHid" name="roundsNumber" />
		    <input type="hidden" id="fbk1Hid" name="fbk1" />
		    <div class="dis-in-b input-and-tip"><span class="text-right w-72">
			    <i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />： </span>
			    <input type="text" name="materialNumber"/>
		    </div>
		    <div class="dis-in-b input-and-tip">
		    	<span class="text-right w-72"><i18n:I18n key="i18n_material_name" defaultValue="物料描述" />： </span>
		    	<input type="text" name="materialDesc"/>
		    </div>
		    <div class="dis-in-b input-and-tip">
		    	<span class="text-right w-72"><i18n:I18n key="i18n_material_name" defaultValue="物料描述" />： </span>
		    	<select id="fbk5SelQuery" name="fbk5">
				    <option value="">全部</option>
					<option value="3">中标</option>
					<option value="4">未中标</option>
				</select>
		    </div>
		</form>
		</div>
	</div>
	
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="定标详情" /></span>
		<div class="common-box-line">
			<main class="grid-container">
				<div class="grid-100">
					<table id="biddingTenderWinTable"></table>
					<%--
					<div id="materialPg" style="text-align: right;"></div>
					--%>
				</div>
			</main>
		</div>
	</div>
	
</div>

<script type="text/javascript">
var obj = getIframeData();
var toElsAccount = obj.toElsAccount;
var biddingNumber = obj.biddingNumber;
var biddingItemNumber = obj.biddingItemNumber;
var roundsNumber = obj.roundsNumber;
var fbk1 = obj.fbk1;
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";
var frameAppId ="${param.frameAppId}";
var rowIndex ="${param.rowIndex}";

var biddingTenderWinGrid;

//var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="materialManage"/>;
var cols = [
         	{title:'结果',name:'result', width: 80, align: 'center',renderer: biddingTenderTargetRes},
         	{title:'供应商ELS',name:'toElsAccount', width: 120, align: 'center'},
         	{title:'供应商名称',name:'supplierDesc', width: 200, align: 'center'},
         	{ title:'项目编号' , name:'biddingProjectNumber',hidden:true, width: 80, align:'center'},
         	{ title:'招标内容行号' , name:'biddingContentItemNumber', width: 80, align:'center'},
           	{ title:'<i18n:I18n key="" defaultValue="方案/设计图纸"/>',hidden:true, name:'attachmentFile' , width:80, align:'center',
           		clickDisable:true,renderer:function(val, item, rowIndex){
           			var viewFlag = false;
           			var extendFields = item.extendFields;
           			if(extendFields){
           				extendFields = JSON.parse(extendFields);
           				var fileList = extendFields.fileList;
           				viewFlag = (fileList && fileList!="");
           			}
           			return '<span class="downloadFile-item" id="downloadFile-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
           	}},
    		{ title:'<i18n:I18n key="" defaultValue="图片"/>', name:'attachmentImage' ,hidden:true, width:100, align:'center',
           		clickDisable:true,renderer:function(val, item, rowIndex){
           			var viewFlag = false;
           			var extendFields = item.extendFields;
           			if(extendFields){
           				extendFields = JSON.parse(extendFields);
           				var imageList = extendFields.imageList;
           				viewFlag = (imageList && imageList!="");
           			}
           			return '<span class="previewImage-item" id="previewImage-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
        		    +'&nbsp;&nbsp;<span class="downloadImage-item" id="downloadImage-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
    		}},
         	{ title:'物料编号', name:'materialNumber' ,width:80, align:'center'},
         	{ title:'物料描述', name:'materialDesc' ,width:400, align:'center'},
         	{ title:'型号' , name:'materialModel' ,width:100, align:'center'},
         	{ title:'规格&性能', name:'materialSpecification', width: 80, align: 'center'},
         	{ title:'数量', name:'quantity' ,width:100, align:'center'},
         	{ title:'数量单位', name:'units', width: 70, align: 'center'},
         	{ title:'中标份额', name:'fbk7' ,width:100, align:'center', renderer : tenderItemBidddingFbk7},
         	{ title:'报价', name:'priceIncludingVat' ,width:100, align:'center',renderer : function(val, item, rowIndex) {
         		if(item.fbk1=='1'){
           		   return "不报价";
           	   	}else{
           	   		return val;
           	   	}
         	}},
         	{ title:'金额', name:'amount', width: 70, align: 'center',renderer : function(val, item, rowIndex) {
         		if(item.fbk1=='1') {
           		   return "不报价";
           	   	}else{
           	   		return val;
           	   	}
         	}},
         	{ title:'目标价', name:'fbk2' ,width:100, align:'center'},
         	{ title:'目标金额', name:'fbk2Money' ,width:100, align:'center',renderer : function(val, item, rowIndex) {
         		if(item.fbk1=='1') {
            		   return "不报价";
         		} else {
    	     		return item.fbk2 * item.quantity;
         		}
         	}},
         	{ title:'完成日期', name:'deliveryDate' ,width:160, align:'center',renderer: formatDate },
         	{ title:'备注', name:'remark', width: 200, align: 'center'}
    ];

function toNum(obj) {
   	if(!isNaN(obj) && obj>=0 && obj<=100) {
		return Number(obj);
   	}
	return 0;
}
function tenderItemBidddingFbk7(val, item, rowIndex) {
	return toNum(val).toFixed(2); 
}

function biddingTenderTargetRes(val, item, rowIndex) {
	var itemFbk5 = item.fbk5;
	if(itemFbk5 && null != itemFbk5 && "null" != itemFbk5 && itemFbk5 == "3") {
		return  '中标';
	}
	return '未中标';
}

function formatDate(date) {
   	if (date!=null&&date.length!=10) {
   		date = new Date(date).format("yyyy-MM-dd");
   	}
   	return date;
}
function formatTime(time) {
   	if (time!=null) {
   		time = new Date(time).format("yyyy-MM-dd hh:mm:ss");
   	}
	return ;
}

$().ready(function(){
	init();
});

function init(){
	var height=$(document).height()-195;
	$("#toElsAccountHid").val(toElsAccount);
	$("#biddingNumberHid").val(biddingNumber);
	$("#biddingItemNumberHid").val(biddingItemNumber);
	$("#roundsNumberHid").val(roundsNumber);
	$("#fbk1Hid").val(fbk1);
	var frm = $("#form");
	biddingTenderWinGrid = $('#biddingTenderWinTable').mmGrid({
        cols: cols,
        url : "${pageContext.request.contextPath}/rest/PurchaseEnquiryBiddingService/findTenderTargetItems",
        params: frm.serializeJSON(),
        method: "POST",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:height,
        checkCol : false <%--,
        plugins: [
            $('#materialPg').mmPaginator({
				style: 'plain' ,
				totalCountName: 'total' ,
				page: 1 ,
				pageParamName: 'currentPage' ,
				limitParamName: 'pageSize' ,
				limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />' ,
				totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />' ,
				limit:null ,
				limitList: [10,20,30,50]
            })
        ]
        --%>
    });
		
}

$("#queryBtn").click(function(){
	query();
});

$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
		mask : true,
        iconSrc : 'icon/els-icon.png',
        windowsId : 'subAccountColumnSetting',
        windowTitle : '<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
        windowSubTitle : "",
        iframSrc : '${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=materialManage" + "&window=iframeApp_materialManage",
        windowMinWidth : 480,
        windowMinHeight : 600,
        windowWidth : 480,
        windowHeight : 600,
        parentPanel : ".currDesktop"
    });
});

//获取数据
function query(){
	var frm = $("#form");
	biddingTenderWinGrid.opts.params = frm.serializeJSON();
	biddingTenderWinGrid.load({});
}

//退出
$("#exitBtn").click(function(){
	top.elsDeskTop.closeCurWin('BiddingTenderWinList');
});

$('.downloadFile-item').live("click", function() {
	var rowIndex = $(this).closest("tr").index();
	var materialRow = biddingTenderWinGrid.row(rowIndex);
	var extendFields = materialRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var fileList = extendFields.fileList;
		if("undefined"!=typeof(fileList) && fileList.length > 0){
			downloadFile("file",rowIndex);
		} else {
			alert("没有文件可下载",2);
		}
	} else {
		alert("没有文件可下载",2);
	}
});

$(".previewImage-item").live("click", function() {
	var rowIndex = $(this).closest("tr").index();
	var materialRow = biddingTenderWinGrid.row(rowIndex);
	var extendFields = materialRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		if("undefined"!=typeof(imageList) && imageList.length > 0){
			parent.elsDeskTop.closeCurWin('showPicture');
			for(var i=0;i<imageList.length;i++) {
				imageList[i]["preViewFilePath"] = imageList[i].filePath;
			}
			var obj={
					mask : true,
					windowTitle: "图片预览",
					data:{
						defaultShow:"1",
						imageList : imageList
					},
					windowMaximize: false,
					windowMinimize: false,
					windowStatus: "regular",
					windowWidth: 860,
					windowHeight: 700,
					iframSrc: elsBasePath+"common/previewimg/showPicture.jsp",
					windowsId: "showPicture",//传递上一级的窗口iframe id用parentWinId,其他数据自定
				};
			parent.elsDeskTop.defineWin(obj);
		} else {
			alert("没有图片可预览",2);
		}
	} else {
		alert("没有图片可预览",2);
	}
});

$('.downloadImage-item').live("click", function() {
	var rowIndex = $(this).closest("tr").index();
	var materialRow = biddingTenderWinGrid.row(rowIndex);
	var extendFields = materialRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		if("undefined"!=typeof(imageList) && imageList.length > 0){
			downloadFile("image",rowIndex);
		} else {
			alert("没有图片可下载",2);
		}
	} else {
		alert("没有图片可下载",2);
	}
});

function downloadFile(type,rowIndex){
	var materialRow = biddingTenderWinGrid.row(rowIndex);
	var filePathArrStr = '';
	if("file"==type){
		var extendFields = materialRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var fileList = extendFields.fileList;
			if("undefined"!=typeof(fileList) && fileList.length > 0){
				for(var i=0;i<fileList.length;i++){
					filePathArrStr += (','+fileList[i].filePath);
				}
			} 
		}
	} else if("image"==type){
		var extendFields = materialRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var imageList = extendFields.imageList;
			if("undefined"!=typeof(imageList) && imageList.length > 0){
				for(var i=0;i<imageList.length;i++){
					filePathArrStr += (','+imageList[i].filePath);
				}
			}
		}
	} else{}
	convertToZipFileDown(filePathArrStr);
}

$("#affirmBtn").click(function(){
	var records = biddingTenderWinGrid.selectedRows();
	if(frameAppId=="addRequirementsPlanning" || frameAppId=="detailsRequirementsPlanning" || frameAppId=="PurchaseOrderUpdate") {
		parent.frames['iframeApp_'+frameAppId].materialCallback(records,rowIndex);
	} else {
		var getData = getIframeData();
		getData(records);
	}
	parent.elsDeskTop.closeCurWin('materialCheck');
});
</script>
</body>
</html>