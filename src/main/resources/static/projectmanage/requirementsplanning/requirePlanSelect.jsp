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
				<form id="requirementsplanningSel">
	                <input type="hidden" id="elsAccount" name="elsAccount">
	                <input type="hidden" id="pageSize" name="pageSize" value="10">
			        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
	                <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_requirementsPlanning_table_demandPlanNumber" defaultValue="需求计划单号:" /></span>
				       <input id="requirementsPlanningNumber" name="requirementsPlanningNumber" type="text" style="width:200px;"/>
			        </div>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_common_title_orderitemnumber" defaultValue="项目编号:" /></span>
				       <input id="projectNumber" name="projectNumber" type="text" style="width:200px;"/>
			        </div>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_requirementsPlanning_table_projectName" defaultValue="项目名称:" /></span>
				       <input id="projectDesc" name="projectDesc" type="text" style="width:200px;"/>
			        </div>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_requirementsPlanning_table_projectStartDate" defaultValue="项目开始时间:" /></span>
				       <input class="Wdate" onfocus="WdatePicker()" id="actualStartDate" name="actualStartDate" type="text" style="width:200px;"/>
			        </div>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_requirementsPlanning_table_projectEndDate" defaultValue="项目结束时间:" /></span>
				       <input class="Wdate" onfocus="WdatePicker()" id="actualEndDate" name="actualEndDate" type="text" style="width:200px;"/>
			        </div>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_requirementsPlanning_table_projectSite" defaultValue="项目地点:" /></span>
				       <input id="projectAddress" name="projectAddress" type="text" style="width:200px;"/>
			        </div>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_requirementsPlanning_table_responsiblePerson" defaultValue="责任人:" /></span>
				       <input id="projectLeader" name="projectLeader" type="text" style="width:200px;"/>
			        </div>
			        <%-- 
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_requirementsPlanning_documentStatus" defaultValue="单据状态:" /></span>
				       <select id="status" name="status">
				           <option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
				           <option value="0"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" /></option>
				           <option value="1"><i18n:I18n key="testssst" defaultValue="审批中" /></option>
				           <option value="2"><i18n:I18n key="i18n_requirementsPlanning_select_approvalBy" defaultValue="审批通过" /></option>
				           <option value="3"><i18n:I18n key="i18n_js_close" defaultValue="关闭" /></option>
				           <option value="4"><i18n:I18n key="i18n_js_close" defaultValue="拒绝" /></option>
				       </select>
			        </div>
			         --%>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号:" /></span>
				       <input id="materialNumberQuery" name="materialNumber" type="text" style="width:200px;"/>
			        </div>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="" defaultValue="需求类型编号:" /></span>
				       <input id="requirementTypeCodeQuery" name="requirementTypeCode" type="text" style="width:200px;"/>
			        </div>
			        <div class="dis-in-b input-and-tip">
				       <span><i18n:I18n key="" defaultValue="需求类型名称:" /></span>
				       <input id="requirementTypeNameQuery" name="requirementTypeName" type="text" style="width:200px;"/>
			        </div>
                </form>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-requirementsPlanningHead"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_projectManage_title_projectDetail" defaultValue="项目管理明细" /></span>
			<div class="common-box-line">
				<main class="grid-container">
					<div class="grid-100" id="headDiv">
						<table id="itemTable"></table>
					</div>
				</main>
			</div>
		</div>
		
	</div>

<script>
var requirementsPlanningHeadGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var frameAppId ="${param.frameAppId}";
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

var renderFormatStatus = function(val,item,rowIndex){
	if("0"==val){
		return "<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />";
	} else if("1"==val){
		return "<i18n:I18n key="testssst" defaultValue="审批中" />";
	} else if("2"==val){
		return "<i18n:I18n key="i18n_requirementsPlanning_select_approvalBy" defaultValue="审批通过" />";
	} else if("3"==val){
		return "<i18n:I18n key="i18n_js_close" defaultValue="关闭" />";
	} else {
		return "";
	}
};

var requirementsPlanningHeadCols = [
	{ title:'<i18n:I18n key="i18n_requirementsPlanning_lable_demandPlanNumber" defaultValue="需求计划编号"/>', name:'requirementsPlanningNumber' , width:120, align:'center'},
	{ title:'<i18n:I18n key="i18n_common_title_orderitemnumber" defaultValue="项目编号"/>', name:'projectNumber' , width:120, align:'center'},
	{ title:'<i18n:I18n key="i18n_quotation_itemnumber" defaultValue="行项目编号"/>', name:'projectItemNumber' , width:120, align:'center'},
	{ title:'<i18n:I18n key="i18n_requirementsPlanning_table_projectName" defaultValue="项目名称"/>', name:'projectDesc' , width:120, align:'center'},
	{ title:'<i18n:I18n key="i18n_requirementsPlanning_lable_projectItemDescription" defaultValue="项目行描述"/>', name:'projectItemDesc' , width:120, align:'center'},
	{ title:'<i18n:I18n key="i18n_requirementsPlanning_table_responsiblePerson" defaultValue="责任人"/>', name:'projectLeader' , width:120, align:'center'},
    { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_startDate" defaultValue="开始日期"/>', name:'actualStartDate' , width:120, align:'center',renderer: rendererDate},
    { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_endDate" defaultValue="结束日期"/>', name:'actualEndDate' , width:120, align:'center',renderer: rendererDate},
    { title:'<i18n:I18n key="i18n_requirementsPlanning_table_projectSite" defaultValue="项目地点"/>', name:'projectAddress' , width:120, align:'center'},
    { title:'<i18n:I18n key="i18n_requirementsPlanning_documentStatus" defaultValue="单据状态"/>', name:'status' , width:120, align:'center',renderer :renderFormatStatus},
    { title:'<i18n:I18n key="i18n_audit_lable_auditpersons" defaultValue="审批人"/>', name:'approvePerson' , width:120, align:'center'},
    { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_approvalTime" defaultValue="审批时间"/>', name:'approveDate' , width:120, align:'center',renderer: rendererDate},
	{ title:'<i18n:I18n key="" defaultValue="需求类型编码"/>', name:'requirementTypeCode' , width:120, align:'center'},
	{ title:'<i18n:I18n key="" defaultValue="需求类型名称"/>', name:'requirementTypeName' , width:120, align:'center'},
	{ title:'<i18n:I18n key="" defaultValue="方案/设计图纸"/>', name:'attachmentFile' , width:80, align:'center',clickDisable:true,renderer: itemRender},
	{ title:'<i18n:I18n key="" defaultValue="图片"/>', name:'attachmentImage' , width:100, align:'center',clickDisable:true,renderer: itemRender},
	{ title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber' , width:120, align:'center'},
	{ title:'<i18n:I18n key="" defaultValue="物料描述" />', name:'materialName' , width:120, align:'center'},
	{ title:'<i18n:I18n key="" defaultValue="数量"/>', name:'fbk1' , width:120, align:'center'},
    { title:'<i18n:I18n key="" defaultValue="建议采购价格"/>', name:'suggestPrice' , width:120, align:'center'},
	{ title:'materialItemNumber', name:'materialItemNumber' , hidden:true},
	{ title:'<i18n:I18n key="" defaultValue="物料属性"/>', name:'materialAttrs' , width:120, align:'center',renderer:itemRender}
		];

function itemRender(val, item, rowIndex){
	var thisRecord = $(this);
	var colName = thisRecord[0].name;
	if("undefined"==typeof(val) || null == val){
		val = ""; 
	}
	if("attachmentFile" == colName){
		var text = '<span class="downloadFile-item" style="display:'+((item.fileList && item.fileList!='')?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		return text;
	} else if("attachmentImage" == colName){
		var text = '<span class="previewImage-item" style="display:'+((item.imageList && item.imageList!='')?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
		    +'&nbsp;&nbsp;<span class="downloadImage-item" style="display:'+((item.imageList && item.imageList!='')?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		return text;
	}else if("materialAttrs"==colName){
		var text = '<span class="materialAttrDetail-item" style="color:blue;cursor:pointer;"><i18n:I18n key="" defaultValue="物料属性" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
		return text;
	} 
}

$('.downloadFile-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	downloadFile("file",itemRowIndex);
});

$(".previewImage-item").live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var itemRow = requirementsPlanningHeadGrid.row(itemRowIndex);
	var imageList = itemRow.imageList;
	if("undefined"!=typeof(imageList) && imageList.length > 0){
		parent.elsDeskTop.closeCurWin('showPicture');
		for(var i=0;i<imageList.length;i++) {
			imageList[i]["preViewFilePath"] = imageList[i].filePath;
		}
		var obj={
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
});

$('.downloadImage-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	downloadFile("image",itemRowIndex);
});

function downloadFile(type,rowIndex){
	var itemRow = requirementsPlanningHeadGrid.row(rowIndex);
	var filePathArrStr = '';
	if("file"==type){
		var fileList = itemRow.fileList;
		if("undefined"!=typeof(fileList) && fileList.length > 0){
			for(var i=0;i<fileList.length;i++){
				filePathArrStr += (','+fileList[i].filePath);
			}
		} else {
			alert("没有文件可下载",2);
		}
	} else if("image"==type){
		var imageList = itemRow.imageList;
		if("undefined"!=typeof(imageList) && imageList.length > 0){
			for(var i=0;i<imageList.length;i++){
				filePathArrStr += (','+imageList[i].filePath);
			}
		} else {
			alert("没有文件可下载",2);
		}
	} else{}
	convertToZipFileDown(filePathArrStr);
}

function init(){
    
	$("#elsAccount").val(elsAccount);
	if("addBiddingThree"==frameAppId) {
		// 如果是招标提取需求计划的话，直接从项目上进行查询过滤
		$("#projectNumber").val("${param.projectNumber}");
	}
	var frm = $("#requirementsplanningSel");
	
    requirementsPlanningHeadGrid=$('#table-requirementsPlanningHead').mmGrid({
	    cols: requirementsPlanningHeadCols,
	    url: '<%=basePath%>rest/RequirementsPlanningService/findSelList',
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
    requirementsPlanningHeadGrid.on("cellSelected",function(e,item,rowIndex,colIndex){
    	var colsObj = requirementsPlanningHeadGrid.opts.cols;
    	var thisColName = colsObj[colIndex].name;
    	if("materialAttrs" == thisColName){
    		materialAttrWindow(item,rowIndex);
    	}
    });
    requirementsPlanningHeadGrid.on("loadSuccess",function(e,data){
    	var rows = requirementsPlanningHeadGrid.rows();
    	if(rows != "" && typeof(rows) != "undefined" && rows.length > 0){		
    		for(var i=0;i<rows.length;i++){
    			var itemRow = rows[i];
    			if(typeof(itemRow.extendFields) != "undefined" && itemRow.extendFields != null){
    				var tempObj = JSON.parse(itemRow.extendFields);
    				if(tempObj.fileList && tempObj.fileList!=""){
    					itemRow["fileList"] = tempObj.fileList;
    				}
    				if(tempObj.imageList && tempObj.imageList!=""){
    					itemRow["imageList"] = tempObj.imageList;
    				}
    				if(tempObj.materialAttrs && tempObj.materialAttrs!=""){
    					itemRow["materialAttrs"] = tempObj.materialAttrs;
    				}
    				requirementsPlanningHeadGrid.updateRow(itemRow,i);
    			}
    		}
    	}
    });
}
//查看物料属性
function materialAttrWindow(item,rowIndex) {
    var materialNumber = item.materialNumber;
    parent.elsDeskTop.defineWin({
        iconSrc : "icon/els-icon.png",
        windowsId :"fillMaterialAtrrValue",
        windowTitle : "<i18n:I18n key='' defaultValue='物料特性' />",
        windowSubTitle: companyShortName,
        iframSrc : "${pageContext.request.contextPath}/materialmanage/fillMaterialAtrrValue.jsp?elsAccount="+elsAccount+"&materialNumber="+materialNumber+"&rowIndex="+rowIndex,
        showAdv : false,
        data : {materialAttrs : item.materialAttrs},
        windowStatus : "regular",
        windowWidth : 600,
        windowHeight : 480,
        windowPositionTop : 14,
        windowWidth : 600,
        windowHeight : 480,
        parentPanel : ".currDesktop"
    });
};
function queryRequirementsplanning() {
	var frm = $("#requirementsplanningSel");
	requirementsPlanningHeadGrid.opts.params = frm.serializeJSON();
	requirementsPlanningHeadGrid.load({page:1});
}

//查询
$("#queryBtn").click(function() {
	queryRequirementsplanning();
});


$("#affirmBtn").click(function(){
	var records = requirementsPlanningHeadGrid.selectedRows();
	if(frameAppId=="PurchaseEnquiryAdd" || frameAppId=="addBiddingThree") {
		var getData = getIframeData();
		getData(records);
	} else {
		parent.frames['iframeApp_'+frameAppId].callbackFun(records);
	}
	parent.elsDeskTop.closeCurWin('requirePlanSelect');
	
});

</script>
</body>
</html>
