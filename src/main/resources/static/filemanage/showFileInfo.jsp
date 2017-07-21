<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>

<body>
<div class="pos-relative public-wrap">
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
var toElsAccount ="<%=request.getParameter("toElsAccount") %>";

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
		val = "上传中";
	}else if(val == "1"){
		val = '<font color="green"><i18n:I18n key="i18n_fileManage_title_uploadedsuccessfully" defaultValue="上传成功" /></font>';
	}else if(val == "2"){
		val = '<font color="red"><i18n:I18n key="i18n_fileManage_title_uploadfailed" defaultValue="上传失败" /></font>';
	}
	return val;
}

function rendererOperation(val, item, rowIndex){
	var text = '<span class="version-history" style="color:blue;cursor:pointer;">历史</span><span style="display: none;">'+JSON.stringify(item)+'</span>'
    +'&nbsp;&nbsp;<span class="download-file" style="color:blue;cursor:pointer;">下载</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
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
        'windowTitle':'文件历史版本记录',
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
            
var fileCols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="fileManageCenter"/>;

/* var fileCols = [
                   { title:'<i18n:I18n defaultValue="操作" key="i18n_enquiry_title_operation"></i18n:I18n>', name:'operation' , width:150, align:'center',renderer: rendererOperation},
                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:120, align:'center',hidden:true},
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
            ]; */

function init(){
	$("#elsAccount").val(elsAccount);//设置当前登录账号
	$("#elsSubAccount").val(elsSubAccount);
	param = {"fileNumber":fileNumber,"elsAccount":toElsAccount};
	 //初始化控件
    $('button').button();
    fileGrid=$('#table-file').mmGrid({
	    cols: fileCols,
	    url: '<%=basePath%>rest/ElsFileCenterService/findFileByNumberAndVersion',
	    params: param,
	    height: 350,
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


</script>

</body>
</html>
