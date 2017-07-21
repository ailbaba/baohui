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
			       <span>文件编号:</span><input id="fileNumber" name="fileNumber" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>文件名:</span><input id="fileName" name="fileName" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>创建人:</span><input id="createUser" name="createUser" type="text" style="width:200px;"/>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryFileList" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                     <button id="selectFileOK" class="button-wrap "><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                     <button id="uploadFile" class="button-wrap"><i18n:I18n key="" defaultValue="上传" /></button>
                     <button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
                </div>
                
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
	                         </table>
	                       <div class="mt-10 text-center">
	                          <div id="btnFileUpload" class="btn btnUpload" style="height: 14px;line-height:14px;"><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></div>
		                      <button id="addFileBtnCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>

<script>

var fileGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
var userName='<%=session.getAttribute("username") %>';
var frameAppId ="<%=request.getParameter("frameAppId") %>";
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


//渲染文件上传状态
function rendererUploadStatus(val){
	if (!val) {val = "";}
	if(val == "0"){
		val = "<i18n:I18n key="i18n_fileManage_title_Onthecross" defaultValue="上传中"/>！";
	}else if(val == "1"){
		val = '<font color="green"><i18n:I18n key="i18n_fileManage_title_uploadedsuccessfully successfully" defaultValue="上传成功"/>！</font>';
	}else if(val == "2"){
		val = '<font color="red"><i18n:I18n key="i18n_fileManage_title_uploadfailed failed" defaultValue="上传失败"/>！</font>';
	}
	return val;
}


var fileCols = [
                   { title:'<i18n:I18n defaultValue="文档编号" key="i18n_fileManage_title_fileNumber"></i18n:I18n>', name:'fileNumber' , width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="文档版本" key="i18n_fileManage_title_versionNumber"></i18n:I18n>', name:'versionNumber' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件名" key="i18n_common_title_filename"></i18n:I18n>', name:'fileName' ,width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件大小" key="i18n_common_lable_fliesize"></i18n:I18n>', name:'fileSize' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件类型" key="i18n_common_title_filetype"></i18n:I18n>', name:'fileType' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="版本说明" key="i18n_fileManage_title_versionNumber"></i18n:I18n>', name:'versionDeclare' , width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="备注" key="i18n_common_title_remarks"></i18n:I18n>', name:'remark' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="上传状态" key="i18n_common_lable_Upload status"/>', name:'uploadStatus' , width:100, align:'center',renderer: rendererUploadStatus},
                   { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer: rendererTime},
                   { title:'<i18n:I18n defaultValue="最后更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="最后更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' ,width:150, align:'center',renderer: rendererTime}
            ]; 

function init(){
	$("#elsAccount").val(elsAccount);//设置当前登录账号
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#fileForm");
	
    fileGrid=$('#table-file').mmGrid({
	    cols: fileCols,
	    url: '<%=basePath%>rest/ElsFileCenterService/findFileList',
	    params: frm.serializeJSON(),
	    height: 300,
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
    
    //双击 @author jiangzhidong @20160503 begin
    fileGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
     	$('body').data('fileDataItem',item);
	});
    //双击 @author jiangzhidong @20160503 end

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

$("#selectFileOK").click(function() {
	var selectRows = fileGrid.selectedRows();
	if(selectRows.length < 1){
		alert("请选择需要添加的文件！",2);
		return;
	}
	var fileNumbers='';
	for(var i = 0 ; i < selectRows.length; i ++){
		var row = selectRows[i];
		var fileNumber = row.fileNumber;
		var versionNumber = row.versionNumber;
		var fileName = row.fileName;
		if(i==0){
			fileNumbers +=fileNumber+'@file@'+versionNumber+'@file@'+fileName;
		}else{
			fileNumbers += ';'+fileNumber+'@file@'+versionNumber+'@file@'+fileName;
		}
	}
	parent.frames['iframeApp_'+frameAppId].setFileNumbers(fileNumbers);
    parent.elsDeskTop.closeCurWin('findFileInfo');
});

//双击 @author jiangzhidong @20160503 begin
$('#table-file').on('dblclick','tr',function() {
	var row = $('body').data('fileDataItem');
	var fileNumber = row.fileNumber;
	var versionNumber = row.versionNumber;
	var fileName = row.fileName;
	parent.frames['iframeApp_'+frameAppId].setFileNumbers(fileNumber+'@file@'+versionNumber+'@file@'+fileName);
    parent.elsDeskTop.closeCurWin('findFileInfo');
});
//双击 @author jiangzhidong @20160503 end

function clearFileInput(){
	$("#versionDeclare").val("");
	$("#remark").val("");
	$("#cause").val("");
}

//添加文件
$("#uploadFile").click(function() {
	clearFileInput();
	$('body').data("operationType","create");
	$(".filedialogTitle").html("上传文件");
	initFileUploader(fileUploader);
	$("#addFileDialog").show();
});

//添加文件弹出框取消按钮
$("#addFileBtnCancel").click(function(){
	$("#addFileDialog").hide();
});
//关闭按钮处理
$("#dialogFileClose").click(function(){
	$("#addFileDialog").hide();
});

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
  		data['operationType'] = $('body').data("operationType");
  	});
  	
    //文件上传成功
	fileUploader.on( 'uploadSuccess', function( obj, response ) {
	        alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
			fileGrid.load();
			$("#addFileDialog").hide();
	});
    
	fileUploader.on('uploadError', function (file) {
	    alert("<i18n:I18n key='i18n_fileManage_title_uploadfailed failed' defaultValue='上传文件失败'/>！",3);
    });
  }
}

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('findFileInfo');
});

</script>

</body>
</html>
