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
var id ="<%=request.getParameter("id") %>";

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
	var text = '';
	return text;
}



function closeWin(){
	parent.frames['iframeApp_filedistribution'].queryFileList();
    parent.elsDeskTop.closeCurWin('fileAllocationHistory');
}

var fileCols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="fileAllocation_his"/>;


/* var fileCols = [
                   { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:150, align:'center',renderer: rendererOperation},
                   { title:'<i18n:I18n defaultValue="文档编号" key="i18n_fileManage_title_fileNumber"></i18n:I18n>', name:'fileNumber' ,width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="所属对象" key="i18n_fileManage_title_pertainObject"></i18n:I18n>', name:'pertainObject' , width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="一级编码" key="i18n_fileManage_title_stairObjectCode"></i18n:I18n>', name:'stairObjectCode' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="二级编码" key="i18n_fileManage_title_secondObjectCode"></i18n:I18n>', name:'secondObjectCode' ,width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="三级编码" key="i18n_fileManage_title_thirdObjectCode"></i18n:I18n>', name:'thirdObjectCode' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="四级编码" key="i18n_fileManage_title_fourthObjectCode"></i18n:I18n>', name:'fourthObjectCode' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="五级编码" key="i18n_fileManage_title_fifthObjectCode"></i18n:I18n>', name:'fifthObjectCode' , width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="六级编码" key="i18n_fileManage_title_sixthObjectCode"></i18n:I18n>', name:'sixthObjectCode' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="七级编码" key="i18n_fileManage_title_seventhObjectCode"></i18n:I18n>', name:'seventhObjectCode' ,width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="八级编码" key="i18n_fileManage_title_eighthObjectCode"></i18n:I18n>', name:'eighthObjectCode' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="九级编码" key="i18n_fileManage_title_ninthObjectCode"></i18n:I18n>', name:'ninthObjectCode' , width:100, align:'center'}, 
                   { title:'<i18n:I18n defaultValue="十级编码" key="i18n_fileManage_title_tenthObjectCode"></i18n:I18n>', name:'tenthObjectCode' , width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="文档版本" key="i18n_fileManage_title_versionNumber"></i18n:I18n>', name:'versionNumber' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="文档说明" key="i18n_fileManage_title_allocationDeclare"></i18n:I18n>', name:'allocationDeclare' ,width:150, align:'center'},
                   { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                   { title:'<i18n:I18n defaultValue="更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' , width:120, align:'center',renderer:rendererTime}
         ]; */

function init(){

	param = {"id":id};

    fileGrid=$('#table-file').mmGrid({
	    cols: fileCols,
	    url: '<%=basePath%>rest/ElsFileCenterService/findFileListAllocationHis',
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
	parent.elsDeskTop.closeCurWin('fileAllocationHistory');
});

//列自定义
$("#columnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     'windowSubTitle': "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=fileAllocation_his" + "&window=iframeApp_fileAllocationHistory",
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
