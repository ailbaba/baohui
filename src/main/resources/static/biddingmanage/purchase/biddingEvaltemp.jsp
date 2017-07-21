<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<title>评标模板</title>
<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">条件查询</span>
            <div class="common-box-line">
               <form id="biddingEvaltempForm">
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
            <span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="query-biddingEvaltemp" class="button-wrap">查询</button>
                     <button id="add-biddingEvaltemp" class="button-wrap">新增</button>
                     <button id="save-biddingEvaltemp" class="button-wrap">保存</button>
                     <button id="delete-biddingEvaltemp" class="button-wrap">删除</button>
                </div>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
	         <span class="dis-in-b pos-absolute box-tip bg-common">评标模板列表</span>
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
                    <div class="input-and-tip"><span><i18n:I18n defaultValue="文件名称" key="i18n_common_label_filename"/>：</span><input id="fileName" name="fileName" type="text" /></div>
                    <div class="input-and-tip"><span><i18n:I18n defaultValue="文件路径" key="i18n_common_label_filepath"/>：</span><input id="filePath" name="filePath" type="text" /></div>
                    <div class="input-and-tip text-right">                 
                        <div id="btnFileUpload" class="btn btnUpload">
                            <i18n:I18n defaultValue="选择表单文件" key="i18n_common_button_chooseformfile"/>
                        </div>           
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

<script>
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var biddingEvaltempGrid;
var fileUploader;
var date = new Date().format("yyyy-MM-dd");
var blankRow = {"scoreTypeCode":"","scoreTypeName":"","scoreModuleCode":"","scoreModuleName":"","detailDesc":""};
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
function rendererInp(val,item,index) {
	var thisRecord = $(this);
	var colName = thisRecord[0].name;
	if("undefined"==typeof(val) || null == val){
		val = "";
	}
	
	if("attachmentFile" == colName){
		val = '<span class="uploadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	    var fileList = item.fileList;
	    if("undefined"!=typeof(fileList) && null!=fileList && fileList.length > 0){
			val += '&nbsp;&nbsp;<span class="downloadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
		}
		return val;
    } else {
		return "<input typpe='text' name='"+colName+"' class='itemColsEdit' value='"+val+"' />";
	}
	return val;
}
var biddingEvaltempCols = [
            { title:'评分类别编号', name:'scoreTypeCode' ,width:100, align:'center',renderer: rendererInp},
            { title:'评分类别名称', name:'scoreTypeName' ,width:100, align:'center',renderer: rendererInp},
            { title:'评分模板编号', name:'scoreModuleCode' ,width:100, align:'center',renderer: rendererInp},
            { title:'评分模板名称', name:'scoreModuleName' ,width:100, align:'center',renderer: rendererInp},
            { title:'详细说明', name:'detailDesc' ,width:100, align:'center',renderer: rendererInp},
            { title:'附件', name:'attachmentFile' ,width:100, align:'center',clickDisable:true,renderer: rendererInp},
            { title:'最后修改人', name:'lastUpdateUser' ,width:100, align:'center'},
            { title:'最后修改时间', name:'lastUpdateDate' ,width:150, align:'center',renderer: rendererTime}
     ];

function init(){
	$("#elsAccount").val(elsAccount);
	var frm = $("#biddingEvaltempForm");
    biddingEvaltempGrid=$('#table-biddingEvaltemp').mmGrid({
	    cols: biddingEvaltempCols,
	    url: '<%=basePath%>rest/BiddingEvaltempService/findList',
	    params: frm.serializeJSON(),
	    height: 400,
	    method: 'post',
	    root: 'rows',
	    loadingText: '正在载入',
        noDataText: '暂无数据',
	    indexCol: true,
	    checkCol: true,
	    multiSelect: true,
	    plugins: [
	              $('#pg').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '每页{0}条'
	                  , totalCountLabel: '共<span>{0}</span>条记录'
	                  , limit: null
	                  , limitList: [10,15,20,50]
	              })
	          ]
	});
}

function queryBiddingEvaltemp() {
	var frm = $("#biddingEvaltempForm");
	biddingEvaltempGrid.opts.params = frm.serializeJSON();
	biddingEvaltempGrid.load({page:1});
}

//查询
$("#query-biddingEvaltemp").click(function() {
	queryBiddingEvaltemp();
});
$("#add-biddingEvaltemp").click(function(){
	var row = $.extend({}, blankRow);
	row["elsAccount"] = elsAccount;
	row["toElsAccount"] = elsAccount;
	biddingEvaltempGrid.addRow(row,0);
});
//删除
$("#delete-biddingEvaltemp").click(function(){
	var selectRows = biddingEvaltempGrid.selectedRows();
	if(selectRows.length > 0) {
		parent.elsDeskTop.tip.init({type: 'confirm',message:'确定要删除评分模板吗？',closeEvent:function(){
			parent.elsDeskTop.showLoading("正在删除……");
			$.ajax({
				url :"<%=basePath%>rest/BiddingEvaltempService/delete",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify(selectRows),
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data.statusCode == "-100"){
						alert(data.message,3);
					}  else if(data.statusCode == "-200"){
						alert(data.message,2);
					}else{
						alert("操作成功！",1);
						queryBiddingEvaltemp();
					}
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
		            alert(exception,3); 
		        }
		  });
		}});
	}else{
		alert("请选择要删除的数据！",2);
	}
});
function trimStr(str) {
	return str.replace(/(^\s*)|(\s*$)/g,"");
}
$("#save-biddingEvaltemp").click(function() {
	var selectRows = biddingEvaltempGrid.selectedRows();
	var rowLength = selectRows.length;
	if(rowLength > 0) {
		var axFlag = false;
		for(var i=0;i<rowLength;i++){
			var iTmp = i+1;
			var rowI = selectRows[i];
			if(trimStr(rowI["scoreModuleCode"]).length==0) {
				alert("第"+iTmp+"行，请输入评分模板编号！",2);
				axFlag = true; break;
			}
			if(trimStr(rowI["scoreModuleName"]).length==0) {
				alert("第"+iTmp+"行，请输入评分模板名称！",2);
				axFlag = true; break;
			}
		}
		if(axFlag) return ;
		parent.elsDeskTop.tip.init({type: 'confirm',message:'确定要保存评分模板吗？',closeEvent:function(){
			parent.elsDeskTop.showLoading("正在保存中，请稍后……");
			$.ajax({
				url :"<%=basePath%>rest/BiddingEvaltempService/add",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify(selectRows),
				success : function(data) {
					if(data.statusCode == "-100"){
						alert(data.message,3);
					}  else if(data.statusCode == "-200"){
						
						alert(data.message,2);
					}else{
						alert("操作成功！",1);
						queryBiddingEvaltemp();
					}
					parent.elsDeskTop.hideLoading();
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
		            alert(exception,3); 
					parent.elsDeskTop.hideLoading();
		        }
		  });
		}});
	} else {
		alert("请选择要保存的数据！",2);
	}
});

$(".itemColsEdit").live('keyup',function(){
	var thisVal = $(this).val();
	var thisName = $(this).attr("name");
	var rowIndex = $(this).closest("tr").index();
	var rowData = biddingEvaltempGrid.row(rowIndex);
	//将值赋给mmgrid对象对应属性
	rowData[""+thisName] = thisVal;
});

<%-- ================文件操作（开始）================--%>
$("#addFileBtnOK").click(function(){
    $("#addFileDialog").hide();
    var filePath = $("#filePath").val();
    if(filePath == ""){
        alert("<i18n:I18n defaultValue='请选择上传文件！' key='i18n_please_select_a_file_to_upload'/>",1);
        return false;
    }
    var fileName = $("#fileName").val();
    
    var itemRow = biddingEvaltempGrid.row(uploadFileRowIndex);

    if("file"==uploadFileType){
        var fileList = itemRow.fileList;
        if("undefined"==typeof(fileList) || null==fileList){
            fileList = [];
        }
        fileList.push({annexFileName: fileName, annexFilePath: filePath});
        itemRow["fileList"]=fileList;
    }else{}
    clearAddFileInfo();
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

function uploadFile(){
    clearAddFileInfo();
    $("#addFileDialog").show();
    initFileUploader(fileUploader);
}

function clearAddFileInfo(){
    $("#fileName").val("");
    $("#filePath").val("");
    $("#fileType").val("");
}

function initFileUploader(fileUploader){
    //新增表单文件
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
         //上传到服务器响应后触发
        fileUploader.on("uploadAccept", function( obj, response ) {
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

$('.uploadFile-item').live("click", function() {
    var itemRowIndex = $(this).closest("tr").index();
    biddingEvaltempGrid.select(itemRowIndex);
    uploadFileType="file";
    uploadFileRowIndex=itemRowIndex;
    uploadFile();
});

$('.downloadFile-item').live("click", function() {
    var itemRowIndex = $(this).closest("tr").index();
    biddingEvaltempGrid.select(itemRowIndex);
    var itemRow = biddingEvaltempGrid.row(itemRowIndex);
    var fileList = itemRow.fileList;
    if("undefined"!=typeof(fileList) && null!=fileList && fileList.length > 0){
        downloadFile("file",fileList);
    } else {
        alert("没有文件可下载",2);
    }
});

function downloadFile(type,fileList){
	for(var i=0;i<fileList.length;i++){
		if(type=="file"){
			window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + fileList[i].annexFilePath;
		}		
	}
}

<%-- ================文件操作（结束）================--%>

function callbackFun(rows){
	alert(rows);
}

</script>

</body>
</html>
