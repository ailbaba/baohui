<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>

<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="close" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
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


<script>

var fileGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
var fileNumber ="<%=request.getParameter("fileNumber") %>";
var versionNumber ="<%=request.getParameter("versionNumber") %>";

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
		val = "<i18n:I18n key="i18n_fileManage_title_onthecross" defaultValue="上传中" />";
	}else if(val == "1"){
		val = '<font color="green"><i18n:I18n key="i18n_fileManage_title_uploadedsuccessfully" defaultValue="上传成功" /></font>';
	}else if(val == "2"){
		val = '<font color="red"><i18n:I18n key="i18n_fileManage_title_uploadfailed" defaultValue="上传失败" /></font>';
	}
	return val;
}

function rendererOperation(val, item, rowIndex){
	var text = '';
	if(item.versionNumber != versionNumber){
		text += '<span class="version-rollback" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_title_rollBack" defaultValue="回退" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>&nbsp;&nbsp;'
	}
	text += '<span class="download-file" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	return text;
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

//变更文档版本
$('.version-rollback').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    parent.elsDeskTop.tip.init({type: 'confirm',message:'确认回退到当前版本？',closeEvent:function(){
     $.ajax({
		url :"<%=basePath%>rest/ElsFileCenterService/fileVersionRollback",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(item),
		success : function(data) {
			if(data.statusCode == "-100"){
				alert(data.message,3);
			}else{
				alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
			    closeWin();
			}
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
            alert(exception,3); 
        }
	  });
    }});
    
});

function closeWin(){
	parent.frames['iframeApp_fileManage'].queryFileList();
    parent.elsDeskTop.closeCurWin('fileVersionHistory');
}

var fileCols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="fileManageCenter_his"/>;


/* var fileCols = [
                   { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:150, align:'center',renderer: rendererOperation},
                   { title:'<i18n:I18n key="i18n_common_change_the_reason" defaultValue="变动原因" />', name:'cause' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:120, align:'center',hidden:true},
                   { title:'<i18n:I18n defaultValue="文档编号" key="i18n_fileManage_title_fileNumber"></i18n:I18n>', name:'fileNumber' , width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="文档版本" key="i18n_fileManage_title_versionNumber"></i18n:I18n>', name:'versionNumber' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件名" key="i18n_common_title_filename"></i18n:I18n>', name:'fileName' ,width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件大小" key="i18n_common_lable_fliesize"></i18n:I18n>', name:'fileSize' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="文件类型" key="i18n_common_lable_flietype"></i18n:I18n>', name:'fileType' , width:100, align:'center'},
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
	param = {"fileNumber":fileNumber,"elsAccount":elsAccount};
	 //初始化控件
    $('button').button();
    fileGrid=$('#table-file').mmGrid({
	    cols: fileCols,
	    url: '<%=basePath%>rest/ElsFileCenterService/findFileHisList',
	    params: param,
	    height: 320,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    checkCol:true,
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
                  , limitList: [10,20]
              })
          ]
	});
    
}

$("#close").click(function(){
	parent.elsDeskTop.closeCurWin('fileVersionHistory');
});

//列自定义
$("#columnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     'windowSubTitle': "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=fileManageCenter_his" + "&window=iframeApp_fileVersionHistory",
	     'windowMinWidth': 480,
	     'windowMinHeight': 600,
	     'windowPositionTop':10,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	});
});

</script>

</body>
</html>
