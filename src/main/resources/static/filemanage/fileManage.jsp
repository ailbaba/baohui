<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>

<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="fileForm">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="elsSubAccount" name="elsSubAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="15">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="文档编号" key="i18n_fileManage_title_fileNumber"></i18n:I18n>:</span><input id="fileNumber" name="fileNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="文档编号" key="i18n_common_label_filename"></i18n:I18n>:</span><input id="fileName" name="fileName" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="创建人" key="i18n_common_title_createuser"></i18n:I18n>:</span><input id="createUser" name="createUser" type="text" style="width:200px;"/>
		        </div>
		        <!-- 
			      <span>附属文件:</span><input id="accessoryNumber" name="accessoryNumber" type="text" style="width:379px;max-width:379px;padding-right:20px;"/>
                 -->
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryFileList" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="uploadFile" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteFile" class="button-wrap"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
                </div>
                <!-- <div class="dis-in-b input-and-tip">
                     <button id="downloadFile" class="button-wrap">下载</button>
                </div> -->
                <div class="dis-in-b input-and-tip">
                     <button id="fileAllocation" class="button-wrap"><i18n:I18n key="i18n_common_button_fileAllocation" defaultValue="配置物料关系" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                </div>
               <!-- <div class="dis-in-b input-and-tip">
                     <button id="showFileInfo" class="button-wrap" >Test</button>
                </div> -->
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-file"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>

<div class="fixed-dialog" id="addFileDialog">
           <div class="dialog-tip bg-common" style="width: 362px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../icon/destop-icon/desktop_icon_23.gif" />
                   <span class="filedialogTitle"></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line add-option">
                           <table>
	                	         <tr class="line-height-tr">
	                		         <td ><i18n:I18n key="i18n_fileManage_title_versionDeclare" defaultValue="版本说明" />：</td>
	                		         <td><textarea id="versionDeclare" name="versionDeclare" cols="100" rows="2"></textarea></td>
	                	         </tr>
	                	         <tr class="line-height-tr">
	                		         <td><i18n:I18n key="i18n_label_remark" defaultValue="文档备注" />：</td>
	                		         <td><textarea id="remark"  name="remark" cols="100" rows="2"></textarea></td>
	                	         </tr>
	                	         <tr class="line-height-tr cause">
	                		         <td><i18n:I18n key="i18n_common_change_the_reason" defaultValue="变动原因" />：</td>
	                		         <td><textarea id="cause"  name="cause" cols="100" rows="2"></textarea></td>
	                	         </tr>
	                         </table>
	                       <div class="mt-10 text-center edit-box-wrap">
	                          <div id="btnFileUpload" class="btn btnUpload" style="height: 14px;line-height:14px;"><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></div>
		                      <button id="addFileBtnCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>

<div class="fixed-dialog" id="fileAllocationDialog" >
	<div class="dialog-tip bg-common" style="width: 703px;height: 400px;margin-left: -251px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="fileAllocationDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../icon/destop-icon/desktop_icon_23.gif" />
	        <span class="dialogTitle"><i18n:I18n key="i18n_common_button_fileAllocation" defaultValue="配置物料关系" /></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"></span>
	            <form id="fileAllocationForm">
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
			                <td><i18n:I18n defaultValue="所属对象" key="i18n_fileManage_title_pertainObject"></i18n:I18n></td>
						            <td><select class="" id="pertainObject" name="pertainObject">
										<option value="Material"><i18n:I18n defaultValue="物料" key="i18n_purchase_bargain_materialName"/></option>
										<option value="Vendor"><i18n:I18n defaultValue="供应商" key="i18n_enquiry_label_supplier"/></option>
										<option value="Customer"><i18n:I18n defaultValue="客户" key="i18n_label_customer"/></option>
										<option value="Manual"><i18n:I18n defaultValue="手册" key="i18n_label_manual"/></option>
										<option value="Purchaseorder"><i18n:I18n defaultValue="采购订单" key="i18n_label_ObjInventory"/></option>
										<option value="Quotation"><i18n:I18n defaultValue="询价单" key="i18n_businessType_bargainEnquiry"/></option>
										<option value="Salesorder"><i18n:I18n defaultValue="销售单" key="i18n_label_SalesList"/></option>
									    <option value="BusinessStatements"><i18n:I18n defaultValue="销售订单" key="i18n_title_saleOrder"/></option>
						             </select></td>
	                		<td class="tb-p"><i18n:I18n key="i18n_fileManage_title_stairObjectCode" defaultValue="一级对象编码" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="stairObjectCode" name="stairObjectCode"/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n key="i18n_fileManage_title_secondObjectCode" defaultValue="二级对象编码" />:</td>
	                		<td><input class="easyui-textbox"  type="text" id="secondObjectCode" name="secondObjectCode"/></td>
	                		<td  class="tb-p"><i18n:I18n key="i18n_fileManage_title_thirdObjectCode" defaultValue="三级对象编码" />:</td>
	                		<td><input class="easyui-textbox"  type="text" id="thirdObjectCode" name="thirdObjectCode"/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n key="i18n_fileManage_title_fourthObjectCode" defaultValue="四级对象编码" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="fourthObjectCode" name="fourthObjectCode" /></td>
	                		<td  class="tb-p"><i18n:I18n key="i18n_fileManage_title_fifthObjectCode" defaultValue="五级对象编码" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="fifthObjectCode" name="fifthObjectCode"/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n key="i18n_fileManage_title_sixthObjectCode" defaultValue="六级对象编码" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="sixthObjectCode" name="sixthObjectCode"/></td>
	                		<td  class="tb-p"><i18n:I18n key="i18n_fileManage_title_seventhObjectCode" defaultValue="七级对象编码" />:</td>
	                		<td class="pos-relative"><input class="easyui-textbox" type="text" id="seventhObjectCode" name="seventhObjectCode"/>
	                		</td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n key="i18n_fileManage_title_eighthObjectCode" defaultValue="八级对象编码" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="eighthObjectCode" name="eighthObjectCode"/></td>
	                		<td  class="tb-p"><i18n:I18n key="i18n_fileManage_title_ninthObjectCode" defaultValue="九级对象编码" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="ninthObjectCode" name="ninthObjectCode"/></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td><i18n:I18n key="i18n_fileManage_title_tenthObjectCode" defaultValue="十级对象编码" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="tenthObjectCode" name="tenthObjectCode"/></td>
	                		<td  class="tb-p"><i18n:I18n key="i18n_common_label_describe" defaultValue="说明" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="allocationDeclare" name="allocationDeclare"/></td>
	                	</tr>
	                </table>
	            </div>
	            </form>
	            <div class="mt-20 text-center" >
	                <button id="fileAllocationOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                <button id="fileAllocationCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	            </div>
	        </div>
    </div>
</div>

<script>

var fileGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
var userName='<%=session.getAttribute("username") %>';
var fileUploader;

$().ready(function(){
	init();
});	

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

function rendererOperation(val, item, rowIndex){      
	var text = '<span class="version-history" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_purchase_bargain_history" defaultValue="历史" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	           +'&nbsp;&nbsp;<span class="version-update" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_update" defaultValue="更新" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	           +'&nbsp;&nbsp;<span class="material-allocation" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_label_materialrelation" defaultValue="对象关系" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	           /* +'&nbsp;&nbsp;<span class="file-check" style="color:blue;cursor:pointer;">查看</span><span style="display: none;">'+JSON.stringify(item)+'</span>' */
	           +'&nbsp;&nbsp;<span class="download-file" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	return text;
}
//渲染文件上传状态
function rendererUploadStatus(val){
	if (!val) {val = "";}
	if(val == "0"){
		val = "<i18n:I18n key='i18n_label_areUploading' defaultValue='正在上传' />";
	}else if(val == "1"){
		val = '<font color="green"><i18n:I18n key='i18n_fileManage_title_uploadedsuccessfully' defaultValue='上传成功' /></font>';
	}else if(val == "2"){
		val = '<font color="red"><i18n:I18n key='i18n_fileManage_title_uploadfailed' defaultValue='上传失败' /></font>';
	}
	return val;
}

//下载文件
$('.download-file').live("click", function() {
	 var scanCol = $(this).next();
	 var sanContent = scanCol.text();
	 var item = JSON.parse(sanContent);
	 var filePath = item.filePath;
	 var fileName = item.fileName+"."+item.fileType;
	 window.location.href = "<%=basePath%>" + "servlet/download4OSSServlet?filePath=" + filePath+'&fileName='+fileName;
});

//在线预览
$('.file-check').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    //兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
        'windowsId':'filePreview',
        'windowTitle':"<i18n:I18n key='i18n_title_theOnlinePreview' defaultValue='在线预览' />",
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>filemanage/filePreview.jsp?fileNumber='+item.fileNumber+'&versionNumber='+item.versionNumber,
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

//查看文件版本历史
$('.version-history').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    //兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
        'windowsId':'fileVersionHistory',
        'windowTitle':"<i18n:I18n key='i18n_title_documentVersionHistory' defaultValue='文件历史版本记录' />",
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>filemanage/fileVersionHistory.jsp?fileNumber='+item.fileNumber+'&versionNumber='+item.versionNumber,
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

//查看文档分配关系
$('.material-allocation').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    //兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
        'windowsId':'materialAllocation',
        'windowTitle':"<i18n:I18n key='i18n_title_documentObjAllocationRelationship' defaultValue='查看文档分配对象关系' />",
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>filemanage/materialAllocation.jsp?fileNumber='+item.fileNumber+'&fileName='+item.fileName
        		    +'&versionNumber='+item.versionNumber+'&createUser='+item.createUser,
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
//变更文档版本
$('.version-update').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    $('body').data("fileNumber",item.fileNumber);
    $('body').data("versionNumber",item.versionNumber);
    $('body').data("operationType","update");
    clearFileInput();
    $(".filedialogTitle").html("<i18n:I18n key='i18n_title_VersionUpdating' defaultValue='版本更新' />:"+item.fileNumber+" "+item.versionNumber);
    initFileUploader(fileUploader);
	showVersion(true);
});

function clearFileInput(){
	$("#versionDeclare").val("");
	$("#remark").val("");
	$("#cause").val("");
}
//添加文件
$("#uploadFile").click(function() {
	clearFileInput();
	$('body').data("operationType","create");
	$(".filedialogTitle").html("<i18n:I18n key='i18n_enquiry_label_upload' defaultValue='上传' />");
	initFileUploader(fileUploader);
	showVersion(false);
});
function showVersion(cause) {
	if(cause) {
		 $('.add-option .cause').show();
		 $("#addFileDialog").show();
	} else {
		$('.add-option .cause').hide();
		$("#addFileDialog").show();
	}
}
            
            
var fileCols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="fileManageCenter"/>;
/* var fileCols = [
                   { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:150, align:'center',renderer: rendererOperation},
                   { title:'<i18n:I18n defaultValue="文档编号" key="i18n_fileManage_title_fileNumber"></i18n:I18n>', name:'fileNumber' , width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="文档版本" key="i18n_fileManage_title_versionNumber"></i18n:I18n>', name:'versionNumber' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件名" key="i18n_common_title_filename"></i18n:I18n>', name:'fileName' ,width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件大小" key="i18n_common_lable_fliesize"></i18n:I18n>', name:'fileSize' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件类型" key="i18n_common_title_filetype"></i18n:I18n>', name:'fileType' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="版本说明" key="i18n_fileManage_title_versionNumber"></i18n:I18n>', name:'versionDeclare' , width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="备注" key="i18n_common_title_remarks"></i18n:I18n>', name:'remark' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="上传状态" key="i18n_common_lable_Upload status"></i18n:I18n>', name:'uploadStatus' , width:100, align:'center',renderer: rendererUploadStatus},
                   { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                   { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer:rendererTime}
            ]; */

function init(){
	$("#elsAccount").val(elsAccount);//设置当前登录账号
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#fileForm");
	 //初始化控件
    $('button').button();
    fileGrid=$('#table-file').mmGrid({
	    cols: fileCols,
	    url: '<%=basePath%>rest/ElsFileCenterService/findFileList',
	    params: frm.serializeJSON(),
	    height: 400,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
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
                  , limitList: [15,20]
              })
          ]
	});
    
}

function queryFileList() {
	var frm = $("#fileForm");
	fileGrid.opts.params = frm.serializeJSON();
	fileGrid.load({page:1});
}


//查询
$("#queryFileList").click(function() {
	queryFileList();
});

//添加文件弹出框取消按钮
$("#addFileBtnCancel").click(function(){
	$("#addFileDialog").hide();
});
//关闭按钮处理
$("#dialogFileClose").click(function(){
	$("#addFileDialog").hide();
});

//删除文件按钮
$("#deleteFile").click(function(){
	var selectRows = fileGrid.selectedRows();
	if(selectRows.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确认删除选择的文件记录',closeEvent:function(){
	    for(var i = 0 ; i < selectRows.length; i ++){
		   var row = selectRows[i];
		   $.ajax({
				url :"<%=basePath%>rest/ElsFileCenterService/deleteFile4Center",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify(row),
				success : function(data) {
					if(data.statusCode == "-100"){
						alert(data.message,3);
					}else{
						alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
						queryFileList();
					}
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
		            alert(exception,3); 
		        }
		  });
	    }
    }});
});

//-----------------配置物料关系------begin------------
function clearFileAlloation(){
	$("#pertainObject").val("");
	$("#stairObjectCode").val("");
	$("#secondObjectCode").val("");
	$("#thirdObjectCode").val("");
	$("#fourthObjectCode").val("");
	$("#fifthObjectCode").val("");
	$("#sixthObjectCode").val("");
	$("#seventhObjectCode").val("");
	$("#eighthObjectCode").val("");
	$("#ninthObjectCode").val("");
	$("#tenthObjectCode").val("");
	$("#allocationDeclare").val("");
}

//分配物料关系
$("#fileAllocation").click(function(){
	clearFileAlloation();
	var selectRows = fileGrid.selectedRows();
	if(selectRows.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	$("#fileAllocationDialog").show();
});
//添加文件弹出框取消按钮
$("#fileAllocationCancel").click(function(){
	$("#fileAllocationDialog").hide();
});
//关闭按钮处理
$("#fileAllocationDialogClose").click(function(){
	$("#fileAllocationDialog").hide();
});

//关闭按钮处理
$("#fileAllocationOK").click(function(){
	var selectRows = fileGrid.selectedRows();
	if(selectRows.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var frm = $("#fileAllocationForm");
	var frmObj = frm.serializeJSON();
	var fileNumbers='';
	for(var i = 0 ; i < selectRows.length; i ++){
		var row = selectRows[i];
		var fileNumber = row.fileNumber;
		var versionNumber = row.versionNumber;
		if(i==0){
			fileNumbers +=fileNumber+'_'+versionNumber;
		}else{
			fileNumbers += ';'+fileNumber+'_'+versionNumber;
		}
	}
	frmObj['fileNumber']=fileNumbers;
	frmObj['elsAccount']=elsAccount;
	$.ajax({
		url :"<%=basePath%>rest/ElsFileCenterService/saveFileAllocation",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(frmObj),
		success : function(data) {
			if(data.statusCode == "-100"){
				alert(data.message,3);
			}else{
				alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
				$("#fileAllocationDialog").hide();
			}
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
            alert(exception,3); 
        }
   });
	
});

//-----------------配置物料关系------end------------
function initFileUploader(fileUploader){
    //新增表单文件
   if (!fileUploader) {
  	fileUploader = WebUploader.create({
  	    // swf文件路径
  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
  	    auto: true,
  	    // 文件接收服务端。
  	    server: '<%=basePath%>servlet/Upload2OSSServlet',
  	    // 选择文件的按钮。可选。
  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
  	    pick: '#btnFileUpload',
  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
  	    resize: false,
  	    formData : {
	     	elsAccount : elsAccount,
	     	userName:userName
	     }
  	});
  	
  	fileUploader.on( 'uploadBeforeSend', function( obj, data ,headers ) {
  		data['versionDeclare'] = $("#versionDeclare").val();
  		data['remark'] = $("#remark").val();
  		data['cause'] = $("#cause").val();
  		data['operationType'] = $('body').data("operationType");
  		data['fileNumber'] = $('body').data("fileNumber");
  		data['versionNumber'] = $('body').data("versionNumber");
  	});
  	
    //文件上传成功
	fileUploader.on( 'uploadSuccess', function( obj, response ) {
	        alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
			fileGrid.load();
			$("#addFileDialog").hide();
	});
    
	fileUploader.on('uploadError', function (file) {
		alert("<i18n:I18n key='i18n_fileManage_title_uploadfailed' defaultValue='上传文件失败'/>！",3);
    });
  }
}

//列自定义
$("#columnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     'windowSubTitle': "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=fileManageCenter" + "&window=iframeApp_fileManage",
	     'windowMinWidth': 480,
	     'windowMinHeight': 600,
	     'windowPositionTop':10,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	});
});

//---------------test--------
$("#accessoryNumber").click(function(){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
        'windowsId':'findFileInfo',
        'windowTitle':'查询文件列表',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>filemanage/findFileInfo.jsp?frameAppId=fileManage',
        'showAdv': true,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 550,
        'windowPositionTop':20,
        'windowWidth':960,
        'windowHeight':550,
        'parentPanel':".currDesktop"
    });
});

function setFileNumbers(fileNumbers){
	$("#accessoryNumber").val(fileNumbers);
}

$("#showFileInfo").click(function(){
	//兼容ie 冒泡事件
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
        'iframSrc':'<%=basePath%>filemanage/showFileInfo.jsp?fileNumber=201601280010000000000049_2.0v;201601270010000000000039_3.0v;201601270010000000000037_1.0v',
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


</script>

</body>
</html>
