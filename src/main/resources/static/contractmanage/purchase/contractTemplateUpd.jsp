<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>

<body>
  <div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="操作" key="i18n_enquiry_title_operation"/></span>
    <div class="common-box-line">
        <button class="button-wrap" id="saveBtn"><i18n:I18n defaultValue="保存" key="i18n_button_save"/></button>
        <button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
    </div>
</div>
<form id="saleAdditionCostForm" onsubmit="return false;">
<div class="box-wrap pos-relative bg-common">
	 <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本信息" key="i18n_common_title_baseinformation"/></span>
	 <div class="common-box-line">
	     <div class="dis-in-b input-and-tip">
			<table>
				<tr>
					<td><i18n:I18n defaultValue="合同模板编码" key="i18n_contractTemplate_templateNumber"/>:</td>
					<td><input type="text" id="templateNumber" name="templateNumber" readonly="readonly" /></td>
					<td><i18n:I18n defaultValue="合同模板名称" key="i18n_contractTemplate_templateDesc"/>:</td>
					<td><input type="text" id="templateDesc" name="templateDesc" width="200px;" /></td>
					<td><i18n:I18n defaultValue="合同模板类型" key="i18n_contractTemplate_templateType"/>:</td>
					<td>
						<select id="templateType">
							<option value="附件类"><i18n:I18n key="i18n_contractTemplate_attachmentType" defaultValue="附件类" /></option>
							<option value="条款类"><i18n:I18n key="i18n_contractTemplate_clauseType" defaultValue="条款类" /></option>
						</select>
					</td>
					<td><i18n:I18n defaultValue="业务类别" key="i18n_contractTemplate_businessType"/>:</td>
					<td><input type="text" id="businessType" name="businessType" /></td>
					<td><i18n:I18n defaultValue="语言" key="i18n_js_language"/>:</td>
					<td>
						<select id="language">
							<option value="zh_cn"><i18n:I18n defaultValue="简体中文" key="i18n_login_chinese"></i18n:I18n></option>
							<option value="en"><i18n:I18n defaultValue="English" key="i18n_common_title_en"></i18n:I18n></option>
							<option value="zh_tw"><i18n:I18n defaultValue="繁体中文" key="i18n_common_title_zh_tw"></i18n:I18n></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><i18n:I18n defaultValue="模板附件类型" key="i18n_contractTemplate_attachmentFileType"/>：</td>
					<td><input type="text" id="attachmentFileType" name="attachmentFileType" readonly="readonly" value=""/></td>
					<td><i18n:I18n defaultValue="模板附件文件名" key="i18n_contractTemplate_attachmentFileName"/>：</td>
					<td><input type="text" id="attachmentFileName" name="attachmentFileName" /></td>
					<td><i18n:I18n defaultValue="模板附件文件路径" key="i18n_contractTemplate_attachmentFilePath"/>：</td>
					<td><input type="text" id="attachmentFilePath" name="attachmentFilePath" readonly="readonly" value=""/></td>
					<td><i18n:I18n defaultValue="备注" key="i18n_label_remark"/>:</td>
					<td><input type="text" id="remark" name="remark" /></td>
					<td><input type="hidden" id="templateVersion" /></td>
					<td><button id="addFileBtn" class="button-wrap"><i18n:I18n defaultValue="上传附件" key="i18n_contractTemplate_updaloadAttachmentFile"/></button></td>
				</tr>
			</table>
		 </div>
	 </div>
</div>

<div class="box-wrap pos-relative bg-common">
    <div class="common-box-line">
		<div class="tab-wrap" id="sheet-project">
        	<ul>
            	<li><a href="#sheet-project-one"><i18n:I18n defaultValue="合同条款" key="i18n_common_title_contractterms"/></a></li>
        		<li><a href="#sheet-project-two"><i18n:I18n defaultValue="附件预览" key="i18n_title_filePreview"/></a></li>
            </ul>            
            <div id="sheet-project-one">
            	<main class="bg-common p-6">
            		<div class="edit-box-wrap" style="padding-top: 5px;">
                		<button id="queryBasicClause" class="button-wrap"><i18n:I18n defaultValue="选择条款" key="i18n_contractTemplate_selectClause"/></button>
                		<button id="clauseDelBtn" class="button-wrap"><i18n:I18n defaultValue="移除" key="i18n_common_button_remove"/></button>
            		</div>
            		<div class="grid-100" id="reCreate">
                		<table id="clauseTable"></table>
           			</div>
        		</main>
            </div>
            <div id="sheet-project-two">
               <div class="file-scan">
					<div class="file-display" id="file-display" style="height: 600px;">
						<a id="viewerPlaceHolder"></a>
					</div>
				</div>
			</div>
		</div>
	</div>        
</div>
</form>

<div class="fixed-dialog" id="addFileDialog">
	<div class="dialog-tip bg-common" style="width: 262px;height: auto; margin-left: -131px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="dialogFileClose"></div>
	    <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_title_chooseformfile"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
	               <div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n defaultValue="文件名称" key="i18n_common_label_filename"/>:</span>
							<input id="fileName" name="fileName" type="text" />
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n defaultValue="文件路径" key="i18n_common_label_filepath"/>:</span>
							<input id="filePath" name="filePath" type="text" />
						</div>
						<div class="input-and-tip text-right">                 
							<div id="btnFileUpload" class="btn btnUpload"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_button_chooseformfile"/></div>           
							<input id="fileType" name="fileType" type="hidden" />
						</div>
						<div class="mt-20 text-center">
						    <button id="addFileBtnOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
							<button id="addFileBtnCancel" class="button-wrap "><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
						</div>
	               </div>
	           </div>
	       </div>
	</div>
</div>

<div class="fixed-dialog" id="queryBasicClauseDialog" >
	<div class="dialog-tip bg-common" style="width: 830px;height: 533px;margin-left: -415px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="queryBasicClauseDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle" id="queryBasicClauseDialogTitle"><i18n:I18n defaultValue="基础条款查询" key="i18n_contractTemplate_queryBasicClause"/></span>
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查询条件" key="i18n_additionCost_queryCondition"/></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                	    <td><i18n:I18n defaultValue="条款描述" key="i18n_basicClauseManage_clauseDesc"/>:</td>
	                		<td><input type="text" id="clauseDesc" /></td>
	                	    <td><i18n:I18n defaultValue="条款大类描述" key="i18n_basicClauseManage_parentClauseDesc"/>:</td>
	                		<td><input type="text" id="parentClauseDesc" /></td>
	                		<td><i18n:I18n defaultValue="关键字" key="i18n_basicClauseManage_keyword"/>:</td>
	                		<td><input type="text" id="keyword" /></td>
							<td><button id="queryBasicClauseBtn" class="button-wrap "><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="queryBasicClauseTable"></table>
                    </div>
                    <div class="mt-20 text-right" >
	                    <button id="queryBasicClauseDialogOkBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="queryBasicClauseDialogCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<script type="text/javascript">
var elsAccount = "${elsAccount}";
var elsDesc = "${companyShortName}";
var elsSubAccount = "${elsSubAccount}";
var userName = "${username}";
var fileUploader;
var currShowFile = "";

//条款表格渲染输入框
function clauseRender(val,item,rowIndex){
	var thisRecord = $(this);
	var colName = thisRecord[0].name;
	if("undefined"==typeof(val) || null == val){
		val = ""; 
	}
	return "<input typpe='text' name='"+colName+"' class='clauseColsEdit' value='"+val+"' />";
}   
$(".clauseColsEdit").live('keyup',function(){
	var thisVal = $(this).val();
	var thisName = $(this).attr("name");
	var rowIndex = $(this).closest("tr").index();
	var rowData = clauseGrid.row(rowIndex);
	rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
});
//列
var clauseCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="contractTemplateClauseAdd"/>;
var clauseGrid = $('#clauseTable').mmGrid({
    cols : clauseCols,
    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryContractTemplateClause",
    method : 'post',
    autoLoad : false,
    fullWidthRows : true,
    root : "rows",
    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    multiSelect : true,
    checkCol : true,
    indexCol : false
});
	//初始化控件
	$(document).ready(function(){
	    $('button').button();
	    $("#sheet-project").tabs();
	    
	    initData();
	});
	
	//点击附件预览
	$("#sheet-project ul li").eq(1).click(function(){
		var filePath = $("#attachmentFilePath").val();
		if(filePath != ""){
			previewFile(filePath);
		}else{
			alert("请选择附件",2);
		}
	});
	//条款删除按钮事件
	$("#clauseDelBtn").click(function(){
		var selectedIndexes = clauseGrid.selectedRowsIndex();
		for(var i = selectedIndexes.length ; i-1 >= 0 ; i--){
			var index = selectedIndexes[i-1];
			clauseGrid.removeRow(index);//删除选中行
		}
	});
	 
	//单击添加表单文件事件
	$('#addFileBtn').click(function() {
		clearAddFileInfo();
		$("#addFileDialog").show();
		initFileUploader(fileUploader);
	});
	//清除添加文件信息
	function clearAddFileInfo(){
    	$("#fileName").val("");
    	$("#filePath").val("");
    	$("#fileType").val("");
    }
	//添加表单文件确定事件
	$("#addFileBtnOK").click(function(){
		$("#addFileDialog").hide();
		var filePath = $("#filePath").val();
		if(filePath == ""){
			alert("<i18n:I18n defaultValue='请选择上传文件！' key='i18n_please_select_a_file_to_upload'/>",1);
			return false;
		}
		addFileTableRow();
		clearAddFileInfo();
		previewFile(filePath);
	});	 
	//添加文件弹出框取消按钮
	$("#addFileBtnCancel").click(function(){
		$("#addFileDialog").hide();
		clearAddFileInfo();
	});	
	//关闭按钮处理
	$("#dialogFileClose").click(function(){
		$("#addFileDialog").hide();
		clearAddFileInfo();
	});
	//----------添加附件相关-----------end--------------------
	
	//提交保存数据
	$("#saveBtn").click(function(){
		var templateType = $("#templateType").val();
		var businessType = $("#businessType").val();
		var templateNumber = $("#templateNumber").val();
		var templateDesc = $("#templateDesc").val();
		var language = $("#language").val();
		var attachmentFileType = $("#attachmentFileType").val();
		var attachmentFileName = $("#attachmentFileName").val();
		var attachmentFilePath = $("#attachmentFilePath").val();
		var remark = $("#remark").val();
		var templateVersion = $("#templateVersion").val();
		
		var templateHead = {
				elsAccount : elsAccount,
				elsDesc : elsDesc,
				templateType : templateType,
				businessType : businessType,
				templateNumber : templateNumber,
				templateDesc : templateDesc,
				language : language,
				templateVersion : templateVersion,
				status : "1",
				attachmentFileType : attachmentFileType,
				attachmentFileName : attachmentFileName,
				attachmentFilePath : attachmentFilePath,
				remark : remark,
		};
		
		var templateClause = clauseGrid.rowsLength() == 0 ? [] : clauseGrid.rows();
		
		var data = {
			contractTemplateHead : JSON.stringify(templateHead),
			contractTemplateClause : JSON.stringify(templateClause),
		};
		var templateTypeSelect = $("#templateType").val();
		if(templateTypeSelect == "附件类"){
			var attachmentPath = $("#attachmentFilePath").val();
			if(attachmentPath == ""){
				alert("附件类必须选择附件",2);
				return;
			}
		}else{
			if(clauseGrid.rowsLength() == 0){
				alert("条款类必须选择条款",2);
				return;
			}
		}
		parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中' key=''/>");
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/ContractManageService/updContractTemplate",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存成功！' key='i18n_common_alert_savesuccess'/>",1);
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_returnParentPage" defaultValue="是否返回上级页面？" />',closeEvent:function(){
					parent.elsDeskTop.closeCurWin("contractTemplateUpd",callBack);
				}});
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存失败！' key='i18n_common_alert_saveFail'/>",3);
			}
		});
	
	});
	
	//初始化数据
	function initData(){
		var paramElsAccount = "${param.elsAccount}";
		var paramTemplateNumber = "${param.templateNumber}";
		var paramLanguage = "${param.language}";
		var paramTemplateVersion = "${param.templateVersion}";
		
		var data = {
				elsAccount : paramElsAccount,
				templateNumber : paramTemplateNumber,
				language : paramLanguage,
				templateVersion : paramTemplateVersion,
		};
		
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/ContractManageService/queryContractTemplateHead",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				var rows = data.rows;
				if(rows.length > 0){
					var head = rows[0];
					$("#templateType").val(head.templateType);
					$("#businessType").val(head.businessType);
					$("#templateNumber").val(head.templateNumber);
					$("#templateDesc").val(head.templateDesc);
					$("#language").val(head.language);
					$("#attachmentFileType").val(head.attachmentFileType);
					$("#attachmentFileName").val(head.attachmentFileName);
					$("#attachmentFilePath").val(head.attachmentFilePath);
					$("#remark").val(head.remark);
					$("#templateVersion").val(head.templateVersion);
					var queryParam = {
							elsAccount : head.elsAccount,
							templateNumber : head.templateNumber,
							language :head.language,
							templateVersion : head.templateVersion,
							pageSize : 1000
					};
					clauseGrid.load(queryParam);
				}
			},
			error : function(data) {
				alert("<i18n:I18n defaultValue='获取合同模板数据失败' key=''/>",3);
			}
		});
	}
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
	function callBack(){
		if(parent.frames['iframeApp_contractTemplateManage']) {
			parent.frames['iframeApp_contractTemplateManage'].init();
		}
	}
	    
    //增加文件到表单文件table
    function addFileTableRow(){
   		var fileName = $("#fileName").val();
   		var filePath = $("#filePath").val();
   		var fileType = $("#fileType").val();
   		$("#attachmentFileName").val(fileName);
   		$("#attachmentFilePath").val(filePath);
   		$("#attachmentFileType").val(fileType);
   	}
  	//新增表单文件
    function initFileUploader(fileUploader){
   	    if (!fileUploader) {
    	  	fileUploader = WebUploader.create({
    	  	    swf : "${pageContext.request.contextPath}/jsLib/webuploader/Uploader.swf",// swf文件路径
    	  	    auto : true,//是否选择文件后自动上传
    	  	    server : "${pageContext.request.contextPath}/servlet/UploadServlet",// 文件接收服务端。
    	  	    pick : "#btnFileUpload",//选择文件的按钮,可选.内部根据当前运行时创建,可能是input元素,也可能是flash/
    	  	    resize : false,// 不压缩image,默认如果是jpeg,文件上传前会压缩再上传.
    	  	    formData : {
    		     	elsAccount : elsAccount
    		    }
    	  	});    	  	
    	 	// 当有文件添加进来的时候
    		fileUploader.on("fileQueued",function(file){
    			var fileName = file.name;
    			$("#fileName").val(fileName);
    			$("#fileType").val(file.ext);
    		});
    	 	//文件上传成功时触发
    		fileUploader.on("uploadSuccess", function(file,response) {
    			var errorNumber = response.error;
    			if(errorNumber == 0){
					var filePath = response.url;
					$("#filePath").val(filePath);
    			} else {
	    			var errorMessage = response.message;
	    			alert(errorMessage,3);
    			}
     	  	});
    		//上传出错时触发
    		fileUploader.on( "uploadError", function( obj, reason  ) {
     	  	   	var errorMessage = response.message;
     	  	    alert(reason,3); 
     	  	});
   	    }
   	}

	//查询基础条款信息--------------begin---------------
	var renderClauseStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val) || ""==val){
			return "无效";
		} else if("1"==val){
			return "有效";
		} else {
			return "无效";
		}
	};
	var queryBasicClauseCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="selectAddBasicClause"/>;
	var queryBasicClauseGrid;
	$("#queryBasicClause").click(function(){
		$("#queryBasicClauseDialog").show();//mmgrid加载需指定宽高或知道父容器的宽高,父容器隐藏时无宽高,需先显示再加载或者指定一个宽高让mmgrid加载
		if("undefined"==typeof(queryBasicClauseGrid) || null == queryBasicClauseGrid){
			queryBasicClauseGrid = $("#queryBasicClauseTable").mmGrid({
				cols : queryBasicClauseCols,
				url : "${pageContext.request.contextPath}/rest/ContractManageService/queryBasicClause",
		        method : 'post',
		        autoLoad : false,
		        root : '',
		        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		        indexCol : true,
		        multiSelect :true,
		        checkCol : true
	     	});
		}
	});	
	$("#queryBasicClauseBtn").click(function(){
		var parentClauseDesc = $("#parentClauseDesc").val();
		var clauseDesc = $("#clauseDesc").val();
		var keyword = $("#keyword").val();
		
		var param = {
				elsAccount : elsAccount,
				parentClauseDesc : parentClauseDesc,
				clauseDesc : clauseDesc,
				keyword : keyword,
		};
		
		queryBasicClauseGrid.load(param);
	});	
	$("#queryBasicClauseDialogOkBtn").click(function(){
		var selectRows = queryBasicClauseGrid.selectedRows();
		if(selectRows.length == 0){
			alert("<i18n:I18n defaultValue='请选择条款!' key=''/>",2);
			return;
		}
		var clauseRows = clauseGrid.rows();
		if("undefined" != typeof(clauseRows) && clauseGrid.rowsLength() > 0 && "undefined" != typeof(selectRows)){
			for( var i = 0 ; i < clauseRows.length ; i ++){
				var clauseRow = clauseRows[i];
				if("undefined" != typeof(clauseRow)){
					for( var j = 0 ; j < selectRows.length ; j ++){
						var selectRow = selectRows[j];
						var rowElsAccount = clauseRow.elsAccount;
						var rowClauseNumber = clauseRow.clauseNumber;
						var rowLanguage = clauseRow.language;
						var _elsAccount = selectRow.elsAccount;
						var _clauseNumber = selectRow.clauseNumber;
						var _language = selectRow.language;
						
						if(rowElsAccount == _elsAccount && rowClauseNumber == _clauseNumber && rowLanguage==_language){
							selectRows.splice(j,1);//去重复
						}
					}
				}
			}
		}
		
		var templateNumber = $("#templateNumber").val();
		var templateDesc = $("#templateDesc").val();
		var templateType = $("#templateType").val();
		var businessType = $("#businessType").val();
		
		var clauseSize = clauseGrid.rowsLength();
		
		for(var i = 0 ; i < selectRows.length ; i++ ){ //设置初始值
			var selectRow = selectRows[i];
			var record = {
					elsAccount : elsAccount,
					templateNumber : templateNumber,
					templateVersion : $("#templateVersion").val(),
					parentClauseNumber : "",
					language : selectRow.language,
					clauseNumber : selectRow.clauseNumber,
					clauseDesc : selectRow.clauseDesc,
					parentClauseDesc : selectRow.parentClauseDesc,
					remark : selectRow.remark,
			};
			clauseGrid.addRow(record,clauseSize+i);//mmgrid添加数组时顺序是反的,指定顺序添加
		}
		$("#queryBasicClauseDialog").hide();
	});	
	//关闭窗口
	$("#queryBasicClauseDialogClose").click(function(){
		$("#queryBasicClauseDialog").hide();
	});	
	//关闭窗口
	$("#queryBasicClauseDialogCancelBtn").click(function(){
		$("#queryBasicClauseDialog").hide();
	});
	//查询基础条款信息--------------end---------------
   
   $("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=contractTemplateClauseAdd&window=iframeApp_contractTemplateAdd",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
   
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
						alert(message,3); 
					}
				},
				error : function(data) {
					alert(data.message,3); 
				}
			});
    	} else {
    		alert("<i18n:I18n defaultValue='不支持在线预览的文档类型' key='i18n_alert_filetypenotsupport'/>!",3);
    	}
    }
</script>
</body>
</html>