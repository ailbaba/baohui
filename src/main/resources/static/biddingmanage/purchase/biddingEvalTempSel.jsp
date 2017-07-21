<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                <button class="button-wrap" id="affirmBtn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<form id="biddingEvaltempSelForm">
                	<input type="hidden" id="elsAccount" name="elsAccount">
	                <input type="hidden" id="pageSize" name="pageSize" value="10" />
			        <input type="hidden" id="currentPage" name="currentPage" value="1" />
					<div class="dis-in-b input-and-tip">
						<span >评分类别编号： </span>
						<input type="text" id="scoreTypeCodeCdn" name="scoreTypeCode" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span >评分类别名称： </span>
						<input type="text" id="sscoreTypeNameCdn" name="scoreTypeName" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span >评分模板编号： </span>
						<input type="text" id="scoreModuleCodeCdn" name="scoreModuleCode" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span >评分模板名称： </span>
						<input type="text" id="scoreModuleNameCdn" name="scoreModuleName" />
					</div>
                </form>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-biddingEvaltemp"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
		
	</div>

<script>
var evaltempGrid;
// 初始化表格后勾选的评估项
var evaltempSelected = new Array();
// 初始化表格后选中的评估项编号
var evaltempSelectedArr = new Array();
// 勾选保存的评估项
var checkedScoreItem = new Array();
// 勾选保存的评估项编号
var checkedScoreCode = new Array();
// 取消勾选的评估项
var unCheckScoreItem = new Array();
// 取消勾选的评估项编号
var unCheckScoreCode = new Array();

var elsAccount='<%=session.getAttribute("elsAccount") %>';
var frameAppId ="${param.frameAppId}";
var biddingNumber ="${param.biddingNumber}";
var biddingItemNumOne ="${param.biddingItemNumOne}";
var elsAccounta ="${param.elsAccounta}";
var evaltempGridLoaded = function(){
	var parentDoc = parent.frames['iframeApp_'+frameAppId];
	if("undefined"==typeof(parentDoc) || null == parentDoc){
		parent.elsDeskTop.closeCurWin('biddingEvalTempSel');
		return;
	}
	// 加载成功后的回选处理
	var itemArr = evaltempGrid.rows();
	var itemArrA = new Array();
	for(var ia = 0;ia<itemArr.length;ia++) {
		var itemScoreCode = itemArr[ia]["scoreModuleCode"];
		itemArrA.push(itemScoreCode);
		// 回显勾选过但实际并未保存的评估项
		if($.inArray(itemScoreCode,checkedScoreCode) != -1) {
			evaltempGrid.select(ia);
		}
	}
	var jsonArr = {
	    	'toElsAccount': elsAccount,
	    	//'elsAccount': elsAccounta,
	    	'biddingNumber': biddingNumber,
	    	//'biddingEvalTargetScoreVOs': itemArr
	};
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/checkedEvaltemp' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(jsonArr),
		dataType : "json",
		success : function(data) {
			for(var i=0;i<data.length;i++) {
				var dataScoreCode1 = data[i].scoreModuleCode;
				// 取消已去除勾选的评估项
				if($.inArray(dataScoreCode1,unCheckScoreCode) != -1)
					continue ;
				var idxSel = $.inArray(dataScoreCode1,itemArrA);
				if(idxSel>-1) {
					evaltempGrid.select(idxSel);
					evaltempSelectedArr.push(dataScoreCode1);
					evaltempSelected.push(evaltempGrid.row(idxSel));
				}
			}
		},
		error : function(data) {
			alert("加载失败",3);
		}
	});
};

var evaltempGridSelected = function(e, item, rowIndex, colIndex){
	var itemScoreCode = item["scoreModuleCode"];
	var checkedIndex = $.inArray(itemScoreCode,checkedScoreCode);
	var unCheckIndex = $.inArray(itemScoreCode,unCheckScoreCode);
	if($(e.target).parents('tr').find('.mmg-check').is(':checked')) {
		// 页面中不存在且初次勾选
		if($.inArray(itemScoreCode,evaltempSelectedArr) == -1 && checkedIndex == -1) {
			checkedScoreCode.push(itemScoreCode);
			checkedScoreItem.push(item);
		}
		// 删除取消勾选项
		if(unCheckIndex != -1) {
			unCheckScoreCode.splice(unCheckIndex,1);
			unCheckScoreItem.splice(unCheckIndex,1);
		}
	} else {
		// 页面中不存在且初次取消勾选
		if($.inArray(itemScoreCode,evaltempSelectedArr) != -1 && unCheckIndex == -1) {
			unCheckScoreCode.push(itemScoreCode);
			unCheckScoreItem.push(item);
		}
		// 删除勾选项
		if(checkedIndex != -1) {
			checkedScoreCode.splice(checkedIndex,1);
			checkedScoreItem.splice(checkedIndex,1);
		}
	}
};

$().ready(function(){
	init();
});
//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//日期格式渲染 yyyy-MM-dd
function rendererDate(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
	return val;
}

var biddingEvaltempCols = [
            { title:'评分类别编号', name:'scoreTypeCode' ,width:100, align:'center'},
            { title:'评分类别名称', name:'scoreTypeName' ,width:100, align:'center'},
            { title:'评分模板编号', name:'scoreModuleCode' ,width:100, align:'center'},
            { title:'评分模板名称', name:'scoreModuleName' ,width:100, align:'center'},
            { title:'详细说明', name:'detailDesc' ,width:100, align:'center'},
            { title:'附件', name:'attachmentFile' ,width:100, align:'center',clickDisable:true,renderer:itemRender},
            { title:'最后修改人', name:'lastUpdateUser' ,width:100, align:'center'},
            { title:'最后修改时间', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime}
     ];

function itemRender(val, item, rowIndex){
	var thisRecord = $(this);
	var colName = thisRecord[0].name;
	if("undefined"==typeof(val) || null == val){
		val = ""; 
	}
	if("attachmentFile" == colName){
		var text = '<span class="downloadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		return text;
	}
}

$('.downloadFile-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var itemRow = evaltempGrid.row(itemRowIndex);
	var fileList = itemRow.fileList;
	if("undefined"!=typeof(fileList) && fileList.length > 0){
		downloadFile("file",itemRowIndex);
	} else {
		alert("没有文件可下载",2);
	}
});

function downloadFile(type,rowIndex){
	var itemRow = evaltempGrid.row(rowIndex);
	var filePathArrStr = '';
	if("file"==type){
		var fileList = itemRow.fileList;
		if("undefined"!=typeof(fileList) && fileList.length > 0){
			for(var i=0;i<fileList.length;i++){
				filePathArrStr += (','+fileList[i].annexFilePath);
			}
		}
	} else{}
	convertToZipFileDown(filePathArrStr);
}

function init(){
    
	$("#elsAccount").val(elsAccount);
	var frm = $("#biddingEvaltempSelForm");
	
    evaltempGrid=$('#table-biddingEvaltemp').mmGrid({
	    cols: biddingEvaltempCols,
	    url: '<%=basePath%>rest/BiddingEvaltempService/findSelList',
	    params: frm.serializeJSON(),
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    multiSelect:true,
	    plugins: [
	              $('#pg').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	                  , limit: null
	                  , limitList: [10,15,20,50]
	              })
	          ]
	});
    //evaltempGrid.on('loadSuccess',evaltempGridLoaded);
    //evaltempGrid.on('cellSelected',evaltempGridSelected);
    
}

function queryEvaltemp() {
	var frm = $("#biddingEvaltempSelForm");
	evaltempGrid.opts.params = frm.serializeJSON();
	evaltempGrid.load({page:1});
}

//查询
$("#queryBtn").click(function() {
	queryEvaltemp();
});


$("#affirmBtn").click(function() {
	var records = evaltempGrid.selectedRows();
	if(records.length==0) {
		alert('<i18n:I18n key="" defaultValue="请至少选择一条数据!" />!',2);
		return;
	}
	var getEvaltempData = getIframeData();
	getEvaltempData(records);
	parent.elsDeskTop.closeCurWin('biddingEvalTempSel');
});
/**
----作废
$("#affirmBtn").click(function() {
	if(evaltempSelected.length==0 && checkedScoreItem.length==0) {
		alert('<i18n:I18n key="" defaultValue="请至少选择一条数据!" />!',2);
		return;
	}
	var jsonArr = {
	    	'toElsAccount': elsAccount,
	    	'biddingNumber': biddingNumber,
	    	'biddingEvalTargetScoreVOs': checkedScoreItem
	    	
	};
	$.ajax({
		url : 'basePath rest/PurchaseEnquiryBiddingService/checkedEvaltemp' + "?t="+new Date().getTime(),
		type : 'POST',
		async: false,
		contentType : "application/json",
		data : JSON.stringify(jsonArr),
		dataType : "json",
		success : function(data) {
			for(var i=0;i<data.length;i++) {
				var spliceInsIdx = $.inArray(data[i].scoreModuleCode,checkedScoreCode);
				if(spliceInsIdx != -1) {
					checkedScoreItem.splice(spliceInsIdx,1);
					checkedScoreCode.splice(spliceInsIdx,1);
				}
			}
			jsonArr["biddingEvalTargetScoreVOs"]=checkedScoreItem;
			jsonArr["biddingItemNumOne"]=biddingItemNumOne;
			// 保存新勾选的评估项,删除取消勾选的评估项
			if (unCheckScoreItem.length > 0) {
				jsonArr["evalTargetScores"]=unCheckScoreItem;
			}
			jsonArr["elsAccount"] = elsAccount;
			$.ajax({
				url : 'basePath rest/BiddingEvaltempService/initEvalTempOne' + "?t="+new Date().getTime(),
				type : 'POST',
				async: false,
				contentType : "application/json",
				data : JSON.stringify(jsonArr),
				dataType : "json",
				success : function(data1) {
					parent.frames['iframeApp_'+frameAppId].callbackFun(data1);
				},
				error : function(data1) {
					alert("加载失败",3);
				}
			});
		},
		error : function(data) {
			alert("加载失败",3);
		}
	});
	parent.elsDeskTop.closeCurWin('biddingEvalTempSel');
});
*/
</script>
</body>
</html>
