<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
			       <span id="fileName"><i18n:I18n defaultValue="文件名" key="i18n_common_title_filename"></i18n:I18n>:&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span id="versionNumber"><i18n:I18n defaultValue="文档版本" key="i18n_fileManage_title_versionNumber"></i18n:I18n>:&nbsp;</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<span id="createUser"><i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>:&nbsp;</span>
		        </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="deleteMaterialAllocation" class="button-wrap"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
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
var fileName ="<%=request.getParameter("fileName") %>";
var versionNumber ="<%=request.getParameter("versionNumber") %>";
var createUser ="<%=request.getParameter("createUser") %>";

$().ready(function(){
	init();
});	

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}            
var accountCols = [
                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:120, align:'center',hidden:true},
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
                   { title:'<i18n:I18n defaultValue="文档说明" key="i18n_fileManage_title_allocationDeclare"></i18n:I18n>', name:'allocationDeclare' ,width:150, align:'center'},
                   { title:'<i18n:I18n defaultValue="创建人" key="i18n_fileManage_title_createUser"></i18n:I18n>', name:'createUser' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="创建时间" key="i18n_fileManage_title_createDate"></i18n:I18n>', name:'createDate' ,width:150, align:'center',renderer:rendererTime},
                   { title:'<i18n:I18n defaultValue="更新人" key="i18n_common_title_lastUpdateUser"></i18n:I18n>', name:'lastUpdateUser' ,width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="更新时间" key="i18n_common_title_lastupdatedate"></i18n:I18n>', name:'lastUpdateDate' , width:120, align:'center',renderer:rendererTime}
            ];

function init(){
	$("#fileName").append(fileName);
	$("#versionNumber").append(versionNumber);
	$("#createUser").append(createUser);
	var param = {"elsAccount":elsAccount,"fileNumber":fileNumber};
    fileGrid=$('#table-file').mmGrid({
	    cols: accountCols,
	    url: '<%=basePath%>rest/ElsFileCenterService/findFileListAllocation',
	    params: param,
	    height: 250,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    checkCol:true,
	    indexCol:true,
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
                  , limitList: [10,20]
              })
          ]
	});

}

//删除文件按钮
$("#deleteMaterialAllocation").click(function(){
	var selectRows = fileGrid.selectedRows();
	if(selectRows.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确认删除选择的记录',closeEvent:function(){
	    for(var i = 0 ; i < selectRows.length; i ++){
		   var row = selectRows[i];
		   var param = {"id":row.id};
		   $.ajax({
				url :"<%=basePath%>rest/ElsFileCenterService/deleteFileAllocation",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify(param),
				success : function(data) {
					if(data.statusCode == "-100"){
						alert(data.message,3);
					}else{
						alert("<i18n:I18n key='il8n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
						fileGrid.load();
					}
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
		            alert(exception,3); 
		        }
		  });
	    }
    }});
});


$("#close").click(function(){
	parent.elsDeskTop.closeCurWin('materialAllocation');
});

</script>
</body>
</html>
