<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">
<%

String assessmentTemplateNumber =request.getParameter("assessmentTemplateNumber");
String assessmentNumber =request.getParameter("assessmentNumber");

%>
html, body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
}

#flashContent {
	display: none;
}

table tbody tr td {
	padding-top: 1px;
	padding-bottom: 1px;
}
</style>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
				key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
	<form id="form" onsubmit="return false;">
		<input type="hidden" id="elsAccount" name="elsAccount" /> <input
			type="hidden" id="elsSubAccount" name="elsSubAccount" /> <input
			type="hidden" id="toElsAccounts" name="toElsAccounts" /> <input
			type="hidden" id="toElsDescs" name="toElsDescs" /> <input
			type="hidden" id="biddingNumber1" name="biddingNumber" />
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本数据</span>
			<div class="common-box-line">
				<div class="tab-wrap" id="add-enq-sheet">
					<ul>
						<li><a href="#edit-line-baseInfo">模板信息</a></li>
						<li><a href="#edit-line-judges">参评人员</a></li>
						<li><a href="#edit-line-invited">供应商</a></li>
						<li class="add-file-sheet"><a href="#edit-line-file"><i18n:I18n
									key="test" defaultValue="表单文件" /></a></li>
					</ul>
					<!-- 基本信息 -->
					<div id="edit-line-baseInfo">
						<table>
							<tbody>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="模板编号:" /></td>
									<td colspan="1" align="left">
										<input id="assessmentTemplateNumber" name="assessmentTemplateNumber" type="text" style="width: 200px;" readonly="readonly" />
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="模板名称:" /></td>
									<td colspan="1" align="left">
										<input id="assessmentTemplateName" name="assessmentTemplateName" type="text" style="width: 200px;" readonly="readonly" />
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="评估打分日期:" /></td>
									<td colspan="1" align="left">
					                	<input type="text" class="Wdate"  id="startCreateDate" name="startCreateDate" readonly="readonly" />
						                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
						                <input type="text" class="Wdate"  id="endCreateDate" name="endCreateDate " readonly="readonly" />
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="评估周期日期:" /></td>
									<td colspan="1" align="left">
					                	<input type="text" class="Wdate"  id="cycleBeginDate" name="cycleBeginDate" readonly="readonly" />
						                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
						                <input type="text" class="Wdate" id="cycleEndDate" name="cycleEndDate" readonly="readonly"  />
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test"
											defaultValue="考评评语:" /></td>
									<td colspan="1" align="left">
									<textarea id = "remark" style="width: 500px; height: 80px" name="" readonly="readonly" ></textarea>
									</td>
								</tr>
							</tbody>
						</table>
							<main class="grid-container">
						<div class="grid-100">
							<table id="baseTable"></table>
							<div id="basePage" style="text-align: left;"></div>
						</div>
						</main>
					</div>
					
					<!-- 参评人员 -->
					<div id="edit-line-judges">
						<div class="supplie-groud">
							<div class="bg-common judges-box">
					           <main class="bg-common p-6">
                    	          <div class="edit-box-wrap">
                        	      </div>
                        	      <div class="grid-100" >
                                     <table id="supplie-judges"></table>
                                     <div id="judgesPage" style="text-align: left;"></div>
                                  </div>
                              </main>
							</div>
						</div>
					</div>
					
					<!-- 受邀方 -->
					<div id="edit-line-invited">
						<div class="supplie-groud">
							<div class="bg-common contacts-box">
							
					<main class="bg-common p-6">
                    	    <div class="edit-box-wrap">
                        	</div>
                        	<div class="grid-100" >
                              <table id="supplie-enterprise"></table>
                               <div id="enterprisePage" style="text-align: left;"></div>
                               </div>
                     </main>
							</div>
						</div>
					</div>
					<!-- 表单文件 -->
					<div class="p-zero" id="edit-line-file">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line p-zero">
								<div class="pos-relative upload-wrap">
									<div class="pos-absolute file-list">
										<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="add-file-project"></table>
											<div id="filePage" style="text-align: left;"></div>
										</div>
										</main>
									</div>
									<div class="file-scan">
										<div class="file-option-zoom">
											<div class="dis-in-b text-left">
<!-- 												<button id="uploadFile" class="button-wrap">上传</button> -->
												<button id="downloadFile" class="button-wrap">下载</button>
												<button id="lookFile" class="button-wrap">在线查看</button>
											</div>
										</div>
										<div class="file-display" id="file-display">
											<a id="viewerPlaceHolder"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</form>

	<div class="fixed-dialog">
		<div class="dialog-tip bg-common"
			style="width: 353px; height: 200px; margin-left: -251px; margin-top: -190px;">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" /> <span
					id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile"
						defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
							key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename"
									defaultValue="表单文件名称" />：</span> <input id="fileName" name="fileName"
								type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload">
									<i18n:I18n key="i18n_common_button_chooseformfile"
										defaultValue="选择表单文件" />
								</div></span> <input id="filePath" name="filePath" type="hidden" /> <input
								id="fileSize" name="fileSize" type="hidden" />
						</div>
						<input id="fileType" name="fileType" type="hidden" />
					</div>
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn">
							<i18n:I18n key="i18n_common_button_ok" defaultValue="确定" />
						</button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn">
							<i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
$( '#add-enq-sheet').tabs();
var editFileTable;
var uploader;
var fileUploader;
var itemGrid;
var enterpriseGrid;
var judgesGrid;
var assessmentTemplateNumber = <%= assessmentTemplateNumber%>
var assessmentNumber = <%= assessmentNumber%>
var editFileTable;
var file_cols = [
{ title:'文件名称', name:'fileName' , width:100, align:'center'},
{ title:'文件路径', name:'filePath', width:100, align:'center'},
{ title:'文件类型', name:'fileType', width:100, align:'center'},
{ title:'文件大小', name:'fileSize', width:100, align:'center'},
{ title:'备注', name:'remark', width:100, align:'center'},
];


$().ready(function(){
	init();
	
	//显示上传弹框
	$("#uploadFile").click(function(){
		 initFileUploader(fileUploader);
		 $('.fixed-dialog').show();
	});
	
	//关闭上传弹框
	$("#btnFileCancel ,.dialog-close-btn").click(function(){
		 $('.fixed-dialog').hide();
	});
	
	//显示上传弹框
	$("#btnFileOK").click(function(){
		addFileItem();
	});
	
	//发送
	$("#send").click(function(){
		sendBidding();
	});
	
});

//退出
$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('assessmentSupplyDetail');
	});


var colsSupplie = [
                   { title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS账号"/>', name:'toElsAccount' , width:150, align:'center'},
                   { title:'<i18n:I18n key="i18n_common_title_suppliername" defaultValue="供应商名称"/>', name:'toCompanyShortName' , width:240, align:'center'}
               ];
               
var colsJudge = [
                   { title:'参评人ELS号', name:'judgeElsAccount' , width:120, align:'center'},
                   { title:'公司名称', name:'judgeCompanyName' , width:170, align:'center'},
                   { title:'参评人子账号', name:'judgeElsSubAccount' , width:120, align:'center'},
                   { title:'子账号名称', name:'judgeName' , width:120, align:'center'}
               ];

var cols_item = [ { title:'供应商', name:'toElsAccount', width: 120, align: 'center',hidden:true},
                  { title:'评估编号', name:'assessmentNumber', width: 120, align: 'center'},
         	      { title:'评估模板编号', name:'assessmentTemplateNumber' ,width:100, align:'center' },
         	      { title:'评估类型编号', name:'assessmentClassNumber' ,width:100, align:'center' },
         	 	  { title:'评估项编号', name:'fbk1' ,width:100, align:'center' },
         		  { title:'评估类型名', name:'assessmentClassName' ,width:100, align:'center' },
      	          { title:'规则名', name:'assessmentItemName' ,width:150, align:'center' },
      	          { title:'权重%', name:'share' ,width:100, align:'center' },
      	          { title:'说明', name:'remark' ,width:100, align:'center'},
      	          { title:'时间戳', name:'logtime' ,width:100, align:'center',renderer:changeDateFormate}];


//加载对应模板的信息项
function loadItemGrid(){
	debugger;
	var itemRows = enterpriseGrid.selectedRows(); 
		
	itemGrid=$('#baseTable').mmGrid({
	    cols: cols_item,
	    url: "<%=basePath%>rest/PurchaseEnquiryAssessmentService/getSupplierAssessmentTemplateContentDetail/"+ elsAccount,
	    params:{"elsAccount":elsAccount, "assessmentNumber":assessmentNumber, "toElsAccount":itemRows[0].toElsAccount},
	    width:800,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	    noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    fullWidthRows:true,
	    plugins: [
	              $('#basePage').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	                  , limit: null
	                  , limitList: [10, 30, 40, 50]
	              })
	          ]
	  });
}

function initEnterpriseList(){
	
	enterpriseGrid=$('#supplie-enterprise').mmGrid({
 	cols: colsSupplie,
     url: "<%=basePath%>rest/PurchaseEnquiryAssessmentService/getEnterpriseList/",
 	params:{"assessmentNumber":assessmentNumber,"elsAccount":elsAccount},
	 width:400,
 	method: 'post',
	 root: 'rows',
	 loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	 noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	 plugins: [
           $('#enterprisePage').mmPaginator({
               style: 'plain'
               , totalCountName: 'total'
               , page: 1
               , pageParamName: 'currentPage'
               , limitParamName: 'pageSize'
               , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
               , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
               , limit: null
               , limitList: [10, 30, 40, 50]
           })
       ]
	});
	
	enterpriseGrid.on('loadSuccess', function(e, data) {
		if (data.total > 0) {
			enterpriseGrid.select(0);
			loadItemGrid();
		} 
	});
}

function initJudgeList(){
	judgesGrid=$('#supplie-judges').mmGrid({
 	cols: colsJudge,
    url: "<%=basePath%>rest/PurchaseEnquiryAssessmentService/getJudgeList",
 	params:{"assessmentNumber":assessmentNumber,"elsAccount":elsAccount},
	width:540,
 	method: 'post',
	root: 'rows',
	loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	plugins: [
           $('#judgesPage').mmPaginator({
               style: 'plain'
               , totalCountName: 'total'
               , page: 1
               , pageParamName: 'currentPage'
               , limitParamName: 'pageSize'
               , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
               , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
               , limit: null
               , limitList: [10, 30, 40, 50]
           })
       ]
	});
}

//初始化
function init(){
	initBaseInfo();
	initEnterpriseList();
	showFileList();
	initJudgeList();
}

//单击文件tag页时触发
$('.add-file-sheet').click(function() {
	if(!editFileTable) {
		editFileTable=$('#add-file-project').mmGrid({
		    cols: file_cols,
		    height:350,
		    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect:true,
	    	params:{"assessmentNumber":assessmentNumber,"elsAccount":elsAccount},
		});
	}
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

//在文件列表添加新添加的文件列
function addFileItem(){
	var filePath=$("#filePath").val();
	var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
	var fileName=$("#fileName").val();
	var fileSize = $("#fileSize").val();
	var fileBlackItem={fileName:fileName,fileType:fileType,filePath:filePath,fileSize:fileSize,remark:""};
	editFileTable.addRow(fileBlackItem);
	$('.fixed-dialog').hide();
}


//显示文件列表
function showFileList(){
	var fileParam = {"assessmentNumber":assessmentNumber,"elsAccount":elsAccount};
	editFileTable=$('#add-file-project').mmGrid({
	    cols: file_cols,
	    url: '<%=basePath%>rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentFilesByCondtion',
	    params: fileParam,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    fullWidthRows:true,
	    indexCol: false,
	    height: 350,
	    plugins: [
              $('#filePage').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                  , limit: null
                  , limitList: [5,10,15,20]
              })
          ]
	});
}

//添加供应商信息
function initBaseInfo(){
		$.ajax({
 			url :"<%=basePath%>rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentCheckHearderByCondtion/"+ elsAccount,
 			type :"POST",
 			contentType : "application/json",
 			dataType : "json",
 			data:JSON.stringify({"assessmentTemplateNumber":assessmentTemplateNumber,"elsAccount":elsAccount,"assessmentNumber":assessmentNumber}),
 			success : function(data) {
 				var rows = data.rows;
 				console.log(rows);
 				//将基本信息赋值
 				$("#assessmentTemplateNumber").val(assessmentTemplateNumber);
 				$("#assessmentTemplateName").val(rows[0].assessmentTemplateName);
 				$("#remark").val(rows[0].remark);
 				var startCreateDate = changeDateFormate(rows[0].createDate);
 				var endCreateDate =   changeDateFormate(rows[0].endDate);
 				var cycleBeginDate =   changeDateFormate(rows[0].cycleBeginDate);
 				var cycleEndDate =   changeDateFormate(rows[0].cycleEndDate);
 				
 				$("#startCreateDate").val(startCreateDate);
 				$("#endCreateDate").val(endCreateDate);
 				$("#cycleBeginDate").val(cycleBeginDate);
 				$("#cycleEndDate").val(cycleEndDate);
 				
 			},
 			error: function (xhr, type, exception) {//获取ajax的错误信息
                 alert(xhr.responseText, "Failed"); 
        }
 		});

}

function changeDateFormate(val){
	if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
}

//文件下载
$("#downloadFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
	    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
	
 });
 
//在线预览
$("#lookFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
		previewFile(filePath);
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
});

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
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : message});
				}
			},
			error : function(data) {
				parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
			}
		});
	} else {
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "不支持在线预览的文档类型!"});
	}
}

</script>
</body>
</html>