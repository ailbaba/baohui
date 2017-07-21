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

.dialog-tip.judges-box {
	width: 609px;
	height: 472px;
	margin: -235px 0 0 -310px
}

.judges-box .judges-box-left {
	height: 380px;
	width: 260px;
	overflow: auto;
	border-radius: 4px;
	background-color: #f9f7f7
}

.judges-box .judges-box-middle {
	height: 380px;
	width: 68px
}

.judges-box .judges-box-right {
	height: 380px;
	width: 260px;
	overflow: auto;
	border-radius: 4px;
	background-color: #f9f7f7
}

.add-judges {
	background: #ddd;
	color: #000
}

.judges-option-btn {
	width: 46px
}

.storeJudgesData, .judges-index, .storeJudgesData-from {
	display: none
}
</style>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
				key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<button id="send" class="button-wrap">发布</button>
			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
	<form id="form" onsubmit="return false;">
		<input type="hidden" id="elsAccount" name="elsAccount" />
		<input type="hidden" id="elsSubAccount" name="elsSubAccount" /> 
		<input type="hidden" id="templateVersionNumber" name="templateVersionNumber" /> 
		
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
										<input id="assessmentTemplateNumber" name="assessmentTemplateNumber" class="findTemplate" type="text" style="width: 200px;" readonly="readonly" placeholder="请选择" title="请选择"/>
										<img src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;left: 239px;top: 46px;cursor: pointer;" class="findTemplate" title="查找模板" /><span style="color: red;">*</span>
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="评估名称:" /></td>
									<td colspan="1" align="left">
										<input id="assessmentTemplateName" name="assessmentTemplateName" type="text" style="width: 200px;" />
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="评估打分日期:" /></td>
									<td colspan="1" align="left">
					                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="beginDate" name="beginDate"/>
						                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
						                <input type="text" class="Wdate" onfocus="WdatePicker()" id="endDate" name="endDate" /><span style="color: red;">*</span>
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="评估周期日期:" /></td>
									<td colspan="1" align="left">
					                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="cycleBeginDate" name="cycleBeginDate"/>
						                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
						                <input type="text" class="Wdate" onfocus="WdatePicker()" id="cycleEndDate" name="cycleEndDate" /><span style="color: red;">*</span>
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right">
										<i18n:I18n key="test" defaultValue="考评评语:" /></td>
									<td colspan="1" align="left">
										<textarea style="width: 500px; height: 80px" name="remark"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 参评人员 -->
				    <div id="edit-line-judges">
						<div class="supplie-groud">
							<div class="bg-common judges-box">
								<div class="tip-head pos-relative">
									<span class="dialogTitle">
									    添加参评人
									</span>
								</div>
								<div class="box-wrap pos-relative bg-common">
								   <div class="common-box">
                                       <div class="dis-in-b input-and-tip"><span class="text-right w-72">ELS级别:</span>
                                          <select id="type" onchange="findJudges()">
                                             <option value="own">本级</option>
                                             <option value="parent">上级</option>
                                             <option value="child">下级</option>
                                             <option value="all">全部</option>
                                          </select>
                                       </div>
                                   </div>
									<input class="dis-in-b pos-absolute judgesEls-search" type="text"
										style="left: 16px; width: 120px;"
										placeholder="ELS号或名称" />
									<img class="dis-in-b pos-absolute" src="../../img/icon_search.png"
										style="width: 14px; left: 133px; top: 46px;" />  
									<input class="dis-in-b pos-absolute judgesSubEls-search" type="text"
										style="left: 160px; width: 96px;"
										placeholder="子账号或名称" /> 
									<img class="dis-in-b pos-absolute" src="../../img/icon_search.png"
										style="width: 14px; left: 253px; top: 46px;" /> 
									<span class="dis-in-b pos-absolute" style="left: 345px;">
									            已添加的参评人员列表：
									</span>
									<div class="fl-left judges-box-left mt-27"></div>
									<div class="fl-left judges-box-middle mt-27">
										<p class="judges-all-pre text-center">
											<button class="judges-option-btn button-wrap" title="全部右移">>></button>
										</p>
										<p class="judges-all-back text-center">
											<button class="judges-option-btn button-wrap" title="全部左移"><<</button>
										</p>
									</div>
									<div class="fl-left judges-box-right mt-27"></div>
									<div class="clear-both"></div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 受邀方 -->
					<div id="edit-line-invited">
						<div class="supplie-groud">
							<div class="bg-common contacts-box">
								<div class="tip-head pos-relative">
									<span class="dialogTitle">
									    <i18n:I18n key="i18n_common_title_addcontact" defaultValue="添加供应商" />
									</span>
<%-- 								<button class="button-wrap sure-selct" style="position: absolute; right: 44px; top: 11px;">
										<i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" />
									</button> --%>
								</div>
								<div class="box-wrap pos-relative bg-common">
								   <div class="common-box">
									   <div class="dis-in-b input-and-tip"><span class="text-right w-72">交易单数：</span>
									      <input id="orderCount" type="text" style="width:65px;"/>
									   </div>
                                       <div class="dis-in-b input-and-tip"><span class="text-right w-72">逻辑:</span>
                                          <select id="logic">
                                            <option value="or">或</option>
                                            <option value="and">且</option>
                                          </select>
                                       </div>
                                       <div class="dis-in-b input-and-tip"><span class="text-right w-72">交易金额：</span>
                                          <input id="tradingAmount" type="text" style="width:65px;"/>
                                       </div>
                                       <div class="dis-in-b input-and-tip"><span class="text-right w-72">供应商分类:</span>
                                          <select id="supplierType">
                                          </select>
                                       </div>
                                       <button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                                   </div>
									<input class="dis-in-b pos-absolute contact-search" type="text"
										style="left: 16px; width: 220px; max-width: 220px; padding-right: 20px;"
										placeholder="输入查找关键字" /> 
									<img class="dis-in-b pos-absolute" src="../../img/icon_search.png"
										style="width: 14px; left: 244px; top: 46px;" /> 
									<span class="dis-in-b pos-absolute" style="left: 345px;">
									    <i18n:I18n key="i18n_common_title_alreadyaddcontact" defaultValue="已添加的供应商列表" />：
									</span>
									<div class="fl-left box-left mt-27"></div>
									<div class="fl-left box-middle mt-27">
										<p class="all-pre text-center">
											<button class="contact-option-btn button-wrap" title="全部右移">>></button>
										</p>
										<p class="all-back text-center">
											<button class="contact-option-btn button-wrap" title="全部左移"><<</button>
										</p>
									</div>
									<div class="fl-left box-right mt-27"></div>
									<div class="clear-both"></div>
								</div>
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
										</div>
										</main>
									</div>
									<div class="file-scan">
										<div class="file-option-zoom">
											<div class="dis-in-b text-left">
												<button id="uploadFile" class="button-wrap">上传</button>
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
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
$( '#add-enq-sheet').tabs();
var editFileTable;
var rightScroll;
var leftScroll;
var judgesRightScroll;
var judgesLeftScroll;
var uploader;
var fileUploader;
var updateFile = false;
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var templateItemList = [];   //用来存放模板行项目的列表,全局变量
var editFileTable;
var file_cols = [
{ title:'文件名称', name:'fileName' , width:100, align:'center',renderer:function(val){
	return "<input name='assessmentFileList[][fileName]' type='text'  value='"+val+"'/>";
}},

{ title:'文件路径', name:'filePath', width:100, align:'center',renderer:function(val){
	return "<input name='assessmentFileList[][filePath]' type='text'  value='"+val+"'/>";
}},
{ title:'文件类型', name:'fileType', width:100, align:'center',renderer:function(val){
	return "<input name='assessmentFileList[][fileType]' type='text'  value='"+val+"'/>";
}},
{ title:'文件大小', name:'fileSize', width:100, align:'center',renderer:function(val){
	return "<input name='assessmentFileList[][fileSize]' type='text'  value='"+val+"'/>";
}},
{ title:'备注', name:'remark', width:100, align:'center',renderer:function(val){
	return "<input name='assessmentFileList[][remark]' type='text'  value='"+val+"'/>";
}},
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
		  updateFile = true;
	});
	
	//发送
	$("#send").click(function(){
		sendBidding();
	});
	
});

//退出
$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('assessmentSupplyAdd');
	});

$("#queryBtn").click(function(){
	findFriendByOption();
});

//模板选择
$('.findTemplate').live("click", function(event) {
    //兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'findAssessTemplate',
        'windowTitle':'选择评估类型',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>supplierassessment/assesstemplate/findAssessTemplate.jsp?frameAppId=assessmentSupplyAdd',
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 500,
        'windowPositionTop':24,
        'windowWidth':960,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
});

function selectTemplateCallbackFunc(rows){
	debugger;
	console.log(rows);
	$("#assessmentTemplateNumber").val(rows[0].assessmentTemplateNumber);
	$("#assessmentTemplateName").val(rows[0].assessmentTemplateName);
	$("#templateVersionNumber").val(rows[0].templateVersionNumber);
	//封装模板行项目
	for(var i = 0;i<rows.length;i++){
	templateItemList.push(rows[i]);
// 		var assementTemplateItem = {"assessmentClassName":rows[i].assessmentClassName,"assessmentClassNumber":rows[i].assessmentClassNumber,
// 				"assessmentItemName":rows[i].assessmentItemName,"assessmentItemNumber":rows[i].assessmentItemNumber,
// 				"assessmentRule":rows[i].assessmentRule,"assessmentTemplateItemNumber":rows[i].assessmentTemplateItemNumber,
// 				"assessmentTemplateName":rows[i].assessmentTemplateName,"assessmentTemplateNumber":rows[i].assessmentTemplateNumber,
// 				"createDate":rows[i].createDate,"createUser":rows[i].createUser,
// 				"deleteFlag":rows[i].deleteFlag,"lastUpdateDate":rows[i].lastUpdateDate,
// 				"lastUpdateUser":rows[i].lastUpdateUser,"templateVersionNumber":rows[i].templateVersionNumber,
// 				"versionNumber":rows[i].versionNumber,"weight":rows[i].weight};	
	}
}

//初始化
function init(){
	initFriend();
	initSupplierSelector();
	loadJudges();
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
	        items: []
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

//初始化联系人弹窗,将联系人的列表传人
function initContact(list, dir, had) {
	if(list && list.length) {
		var oldArr = list;
		$('body').data('cacheOldArr',oldArr);
    	var txt ="";
    	if(dir == 'left') {
    		$('.box-left').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">left</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-left').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-left').find('.contact-people').eq(ind).hide();
    			}
    		}
    		leftScroll.resize();
    		
    	} 
    	else if(dir == 'right') {
    		$('.box-right').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="display:none;margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">right</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-right').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-right').find('.contact-people').eq(ind).show();
    			}
    		}
    		rightScroll.resize();
    	}
	}else{
		$('.box-left').html('');
		$('.box-right').html('');
	}
}

//初始化参评人员列表
function initJudges(list, dir, had) {
	if(list && list.length) {
		var oldArr = list;
		$('body').data('cacheOldJudgesArr',oldArr);
    	var txt ="";
    	var title = "<thead><tr><td>ELS号</td><td>ELS名称</td><td>子账号</td><td>子账号名称</td></tr></thead>";
    	if(dir == 'left') {
    		$('.judges-box-left').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-judges" style="margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;">'+
        		      '<span class="storeJudgesData-from">left</span>'+
        		      '<span class="judges-index">'+oldArr[i].fromIndex+'</span>'+
        		      '<span class="storeJudgesData">'+ JSON.stringify(oldArr[i])+'</span>'+
        		      '<span class="judgesEls judges-elsAccount">'+oldArr[i].elsAccount+'</span>'+"_"+
        		      '<span class="judgesEls judges-companyShortName">'+oldArr[i].companyShortName+'</span>'+"_"+
        		      '<span class="judgesSubEls judges-elsSubAccount">'+oldArr[i].elsSubAccount+'</span>'+"_"+
        		      '<span class="judgesSubEls judges-name">'+oldArr[i].name+'</span>'+
        		      '</p>';
        	}
    		$('.judges-box-left').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.judges-box-left').find('.contact-judges').eq(ind).hide();
    			}
    		}
    		leftScroll.resize();
    		
    	} 
    	else if(dir == 'right') {
    		$('.judges-box-right').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-judges" style="display:none;margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;">'+
        		      '<span class="storeJudgesData-from">right</span>'+
        		      '<span class="judges-index">'+oldArr[i].fromIndex+'</span>'+
        		      '<span class="storeJudgesData">'+ JSON.stringify(oldArr[i])+'</span>'+
        		      '<span class="judgesEls judges-elsAccount">'+oldArr[i].elsAccount+'</span>'+"_"+
        		      '<span class="judgesEls judges-companyShortName">'+oldArr[i].companyShortName+'</span>'+"_"+
        		      '<span class="judgesSubEls judges-elsSubAccount">'+oldArr[i].elsSubAccount+'</span>'+"_"+
        		      '<span class="judgesSubEls judges-name">'+oldArr[i].name+'</span>'+
        		      '</p>';
        	}
    		$('.judges-box-right').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.judges-box-right').find('.contact-judges').eq(ind).show();
    			}
    		}
    		rightScroll.resize();
    	}
	}else{
		$('.judges-box-left').html('');
		$('.judges-box-right').html('');
	}
}

//显示文件列表
function showFileList(){
	var fileParam = { 'elsAccount':elsAccount, 'elsSubAccount':elsSubAccount};
	editFileTable=$('#add-file-project').mmGrid({
	    cols: file_cols,
	    url: '<%=basePath%>rest/PurchaseEnquiryBargainService/queryReceiveEnquiryFileByCondtion',
	    params: fileParam,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    fullWidthRows:true,
	    indexCol: false,
	    plugins: [
              $('#enquiryFilePage').mmPaginator({
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

//添加参评人员信息
function loadJudges(){
		$.ajax({
 			url :"<%=basePath%>rest/AccountService/findParentOrChildSubAccountList/"+elsAccount+"/own",
 			type :"GET",
 			contentType : "application/json",
 			dataType : "json",
 			success : function(data) {
 				var rows = data.rows;
 				for(var i = 0 ; i < rows.length ; i ++){
 					rows[i]["fromIndex"]=i;
 				}
 				//首次进入初始化
 				initJudges(rows,'left');
 				initJudges(rows,'right');
 			},
 			error: function (xhr, type, exception) {//获取ajax的错误信息
                 alert(xhr.responseText, "Failed"); 
        }
 		});
	judgesRightScroll=(judgesRightScroll||$('.judges-box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
	judgesLeftScroll=(judgesLeftScroll||$('.judges-box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
}

function findJudges(){
	var type = $("#type").val();
	$.ajax({
			url :"<%=basePath%>rest/AccountService/findParentOrChildSubAccountList/"+elsAccount+"/"+type,
			type :"GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var rows = data.rows;
				for(var i = 0 ; i < rows.length ; i ++){
					rows[i]["fromIndex"]=i;
				}
				//首次进入初始化
				initJudges(rows,'left');
				initJudges(rows,'right');
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
             alert(xhr.responseText, "Failed"); 
    }
		});
judgesRightScroll=(judgesRightScroll||$('.judges-box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
judgesLeftScroll=(judgesLeftScroll||$('.judges-box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
}

//添加供应商信息
function initFriend(){
		$.ajax({
 			url :"<%=basePath%>rest/FriendsService/findMyFriendsByType",
 			type :"POST",
 			contentType : "application/json",
 			dataType : "json",
 			data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
 			success : function(data) {
 				var rows = data.rows;
 				for(var i = 0 ; i < rows.length ; i ++){
 					rows[i]["fromIndex"]=i;
 				}
 				//首次进入初始化
 				initContact(rows,'left');
 				initContact(rows,'right');
 			},
 			error: function (xhr, type, exception) {//获取ajax的错误信息
                 alert(xhr.responseText, "Failed"); 
        }
 		});
    rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
    leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
}

//按条件查询供应商
function findFriendByOption(){
	var orderCount = $("#orderCount").val();
	var logic = $("#logic").val();
	var tradingAmount = $("#tradingAmount").val();
	var supplierType = $("#supplierType").val();
	var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商",
			    "orderCount":orderCount,"logic":logic,"tradingAmount":tradingAmount,"supplierType":supplierType};
	$.ajax({
			url :"<%=basePath%>rest/FriendsService/findMyFriendsByOption",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(data),
			success : function(data) {
				var rows = data.rows;
				for(var i = 0 ; i < rows.length ; i ++){
					rows[i]["fromIndex"]=i;
				}
				//首次进入初始化
				initContact(rows,'left');
				initContact(rows,'right');
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
             alert(xhr.responseText, "Failed"); 
            }
		});
rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
}

function initSupplierSelector(){
	var param = {"elsAccount":elsAccount,"tableName":"supplier_main_data","fieldName":"industryCode"};
	$.ajax({
		url: "<%=basePath%>rest/ElsSearchDictionaryService/getFields",
		type: "post",
		contentType: "application/json",
		dataType: "json",
		data : JSON.stringify(param),
		success: function(data) {
			var rows = data.rows;
			if(rows && rows.length > 0){
				$("#supplierType").empty();
				var strArray = new Array();
				strArray.push("<option value=''>不限类型</option>");
				for (var i=0;i<rows.length;i++){
					strArray.push("<option value='");
					strArray.push(rows[i].fieldValue);
					strArray.push("'>");
					strArray.push(rows[i].fieldValue);
					strArray.push("_");
					strArray.push(rows[i].fieldValueText);
					strArray.push("</option>");
				}
				$("#supplierType").append(String.prototype.concat.apply("", strArray));
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				console.log("查询供应商主数据异常");
			}
		}
	});
}

//存储临时的选择数据
var cacheData = {};
$('.contact-people').live('mouseover',function() {
	$('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact');
});
$('.contact-people').live('click',function() {
    /* $('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact'); */
    //cacheData.text = JSON.parse($(this).find('.storeData').text());
    cacheData.index = parseInt($(this).find('.people-index').text());
    cacheData.dir = $(this).find('.storeData-from').text();
    $('body').data('cachePeople',cacheData);
    var oldObj = $('body').data('cachePeople');
    if(oldObj && oldObj.dir=='left') {
    	$('.box-left').find('.contact-people').eq(oldObj.index).hide();
    	$('.box-right').find('.contact-people').eq(oldObj.index).show();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	rightScroll.resize();
   } else if(oldObj && oldObj.dir=='right') {
       	$('.box-left').find('.contact-people').eq(oldObj.index).show();
    	$('.box-right').find('.contact-people').eq(oldObj.index).hide();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	leftScroll.resize();
	}
});


//存储临时的选择数据-参评人员
var cacheJudgesData = {};
$('.contact-judges').live('mouseover',function() {
	$('.judges-box').find('p').removeClass('add-judges');
    $(this).addClass('add-judges');
});
$('.contact-judges').live('click',function() {
	cacheJudgesData.index = parseInt($(this).find('.judges-index').text());
	cacheJudgesData.dir = $(this).find('.storeJudgesData-from').text();
    $('body').data('cacheJudges',cacheJudgesData);
    var oldObj = $('body').data('cacheJudges');
    if(oldObj && oldObj.dir=='left') {
    	$('.judges-box-left').find('.contact-judges').eq(oldObj.index).hide();
    	$('.judges-box-right').find('.contact-judges').eq(oldObj.index).show();
   } else if(oldObj && oldObj.dir=='right') {
       	$('.judges-box-left').find('.contact-judges').eq(oldObj.index).show();
    	$('.judges-box-right').find('.contact-judges').eq(oldObj.index).hide();
	}
});
//选择左边全部-参评人员
$('.judges-all-pre').click(function() {
	var left =$('.judges-box-left').find('.contact-judges');
	var right =$('.judges-box-right').find('.contact-judges');
	left.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.judges-index').text();
            right.eq(showInd).show();
        }
	});
	$('.judges-box-left').find('.contact-judges').hide();
	//清空临时存储的数据
	$('body').data('cacheJudges','right');
	judgesRightScroll.resize();
});
//选择右边全部-参评人员
$('.judges-all-back').click(function() {
	var left =$('.judges-box-left').find('.contact-judges');
	var right =$('.judges-box-right').find('.contact-judges');
	right.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.judges-index').text();
            left.eq(showInd).show();
        }
	});
	$('.judges-box-right').find('.contact-judges').hide();
	//清空临时存储的数据
	$('body').data('cacheJudges','left');
	judgesLeftScroll.resize();
});
$('.judgesEls-search').keyup(function() {
	var val = $(this).val();
	var all = $('.judges-box-left').find('p').hide();
	if(!val){
		all.show();
	} else {
		all.filter(function(index,html) {
    		var oldText=$(html).find('.judgesEls').text();
    		return oldText.indexOf(val) != -1;
    	}).show();
	}
});
$('.judgesSubEls-search').keyup(function() {
	var val = $(this).val();
	var all = $('.judges-box-left').find('p').hide();
	if(!val){
		all.show();
	} else {
		all.filter(function(index,html) {
    		var oldText=$(html).find('.judgesSubEls').text();
    		return oldText.indexOf(val) != -1;
    	}).show();
	}
});

$('.contact-search').keyup(function() {
	var val = $(this).val();
	var all = $('.box-left').find('p').hide();
	if(!val){
		all.show();
	} else {
		all.filter(function(index,html) {
    		var oldText=$(html).find('.friend-name').text();
    		return oldText.indexOf(val) != -1;
    	}).show();
	}
});
//选择左边全部
$('.all-pre').click(function() {
	var left =$('.box-left').find('.contact-people');
	var right =$('.box-right').find('.contact-people');
	left.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.people-index').text();
            right.eq(showInd).show();
        }
	});
	$('.box-left').find('.contact-people').hide();
	//清空临时存储的数据
	$('body').data('cachePeople','right');
	rightScroll.resize();
});
//选择右边全部
$('.all-back').click(function() {
	var left =$('.box-left').find('.contact-people');
	var right =$('.box-right').find('.contact-people');
	right.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.people-index').text();
            left.eq(showInd).show();
        }
	});
	$('.box-right').find('.contact-people').hide();
	//清空临时存储的数据
	$('body').data('cachePeople','left');
	leftScroll.resize();
});
	

//发送评估信息
function sendBidding(){
	var toElsAccounts = "";
	var enterpriseVOs = [];
	$('.box-right').find(".contact-people").each(function(index ,val){
		if(jQuery(this).css("display")!="none"){ 
			var textObj = JSON.parse($(this).find('.storeData').text());
 			toElsAccounts+=","+textObj.friendElsAccount;
// 			toElsDescs+=","+textObj.friendCompanyName;
			var enterpriseVO= {"elsAccount" : textObj.friendElsAccount,"companyShortName":textObj.friendCompanyName}
			enterpriseVOs.push(enterpriseVO);
		}
	});
	
	var judgeVOs = [];
	$('.judges-box-right').find(".contact-judges").each(function(index ,val){
		if(jQuery(this).css("display")!="none"){ 
			var textObj = JSON.parse($(this).find('.storeJudgesData').text());
			var judgeVO= {"judgeElsAccount" : textObj.elsAccount,"judgeElsSubAccount":textObj.elsSubAccount}
			judgeVOs.push(judgeVO);
		}
	});
	
	 if($("#assessmentTemplateNumber").val()==''){
		 alert("模板编号不能为空!",2);
		 return;
	 }
    
     if($("#assessmentTemplateName").val()==''){
    	 alert("模板名称不能为空!",2);
    	 return;
     }
    
     if($("#beginDate").val()==''){
    	 alert("评估打分日期不能为空!",2);
    	 return;
     }
     
     if($("#endDate").val()==''){
    	 alert("评估打分日期不能为空!",2);
    	 return;
     }
     
     if($("#cycleBeginDate").val()==''){
    	 alert("评估周期日期不能为空!",2);
    	 return;
     }
     
     if($("#cycleEndDate").val()==''){
    	 alert("评估周期日期不能为空!",2);
    	 return;
     }
	
	//遍历供应商的表,将数据传入企业信息vo里面
    if(toElsAccounts.length==0) {
    	alert("请选择受邀方!",2);
    	return;
    }
	
	//上传表单文件
	if(updateFile==true){
		//获取表单文件信息sale_bidding_file
		var assessmentFileVOs = [];//用于存放表单文件信息
		//判断是否切换文件显示的界面，如果没有切换，则不需要更新文件信息 
		var selectRows = editFileTable.rows();
		if(selectRows.length > 0){
			for(var j = 0 ; j < selectRows.length ; j ++){
				assessmentFileVOs.push(JSON.stringify(selectRows[j]));				
			}
		}
		
	}
    var formObj = $("#form").serializeJSON();
    formObj["elsAccount"] = elsAccount ;
    formObj["enterpriseList"] = enterpriseVOs;
    formObj["judgeList"] = judgeVOs;
    formObj["assessmentTemplateNumber"] = $("#assessmentTemplateNumber").val();
    formObj["assessmentTemplateName"] = $("#assessmentTemplateName").val();
    formObj["assesmentFileList"]   = assessmentFileVOs;
    formObj["templateItemList"]  = templateItemList;

    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认发布？" />',closeEvent:function(){
    parent.elsDeskTop.showLoading('评估信息发布中');
	$.ajax({
		url : "<%=basePath%>rest/PurchaseEnquiryAssessmentService/CreateSupplierAssessment",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(formObj),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.statusCode=="-100"){
				alert(data.message,2);
			}else{
				alert("创建成功!");
				parent.elsDeskTop.closeCurWin('assessmentSupplyAdd',callBack);
			}
			console.log(data.statusCode+"   "+data.message);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert('<i18n:I18n key="test" defaultValue="请求出错" />',3);
		}
	});
	
    }});
}

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_assessmentSupplyManager']) {
		parent.frames['iframeApp_assessmentSupplyManager'].purchQuery();
	}

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