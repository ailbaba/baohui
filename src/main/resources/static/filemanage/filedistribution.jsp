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
			       <span><i18n:I18n key="i18n_fileManage_title_createUser" defaultValue="创建人" />:</span><input id="createUser" name="createUser" type="text" style="width:200px;"/>
		        </div>
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_fileManage_title_fileNumber" defaultValue="文档编号" />:</span><input id="fileNumber" name="fileNumber" type="text" style="width:200px;"/>
		        </div>
			   <div class="dis-in-b input-and-tip">
			    <span class="edit-sub-title"><i18n:I18n defaultValue="所属对象" key="i18n_fileManage_title_pertainObject"></i18n:I18n>:</span>
				<select class="" id="pertainObject" name="pertainObject">
						<option value=""><i18n:I18n defaultValue="全部" key="i18n_common_select_all"/></option>
						<option value="Material"><i18n:I18n defaultValue="物料" key="i18n_purchase_bargain_materialName"/></option>
						<option value="Vendor"><i18n:I18n defaultValue="供应商" key="i18n_enquiry_label_supplier"/></option>
						<option value="Customer"><i18n:I18n defaultValue="客户" key="i18n_label_customer"/></option>
						<option value="Manual"><i18n:I18n defaultValue="手册" key="i18n_label_manual"/></option>
						<option value="Purchaseorder"><i18n:I18n defaultValue="采购订单" key="i18n_label_ObjInventory"/></option>
						<option value="Quotation"><i18n:I18n defaultValue="询价单" key="i18n_businessType_bargainEnquiry"/></option>
						<option value="Salesorder"><i18n:I18n defaultValue="销售单" key="i18n_label_SalesList"/></option>
					    <option value="BusinessStatements"><i18n:I18n defaultValue="销售订单" key="i18n_title_saleOrder"/></option>
				</select>
			     </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_fileManage_title_stairObjectCode" defaultValue="一级编码" />:</span><input id="stairObjectCode" name="stairObjectCode" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n key="i18n_fileManage_title_secondObjectCode" defaultValue="二级编码" />:</span><input id="secondObjectCode" name="secondObjectCode" type="text" style="width:200px;"/>
		        </div>
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
                     <button id="edit" class="button-wrap"><i18n:I18n key="i18n_common_button_update" defaultValue="修改" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                      <button id="deleteAccountInfo" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
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
var fileUploader;
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

function rendererOperation(val, item, rowIndex){      
	var text = '<span class="version-history" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_purchase_bargain_history" defaultValue="历史" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	return text;
}

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
        'windowsId':'fileAllocationHistory',
        'windowTitle':'<i18n:I18n key="i18n_title_documentDistributionHistory" defaultValue="文件分配历史记录" />',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>filemanage/fileAllocationHistory.jsp?id='+item.id,
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

var accountCols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="fileAllocation"/>;

/* var accountCols = [
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
	$("#elsAccount").val(elsAccount);//设置当前登录账号
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#fileForm");
	 //初始化控件
    $('button').button();
    fileGrid=$('#table-file').mmGrid({
	    cols: accountCols,
	    url: '<%=basePath%>rest/ElsFileCenterService/findFileListAllocation',
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
	
    fileGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
   	    $('body').data('account',item);
    });
}

//查询
function queryFileList() {
	var frm = $("#fileForm");
	fileGrid.opts.params = frm.serializeJSON();
	fileGrid.load();
}

//查询
$("#queryFileList").click(function() {
	queryFileList();
});

//增加
$("#uploadFile").click(function() {
	parent.elsDeskTop.defineWin({
	  'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
      'windowsId':'addFiledistribytion',
      'windowTitle':'<i18n:I18n defaultValue="添加资源" key="i18n_label_add_key"/>',
      'iframSrc':'<%=basePath%>filemanage/addFiledistribytion.jsp',        
       windowStatus: 'regular',
       windowMinWidth: 350,
       windowMinHeight: 420,
       windowPositionTop:50,
      'windowWidth':450,
      'windowHeight':580,
      'parentPanel':".currDesktop"
  });
});


//删除
$("#deleteAccountInfo").click(function() {
	var selectRow = fileGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除?" key="i18n_common_alert_confirmdelete"/>',closeEvent:function(){		
		  for(var i = 0 ; i < selectRow.length; i ++){
			   var row = selectRow[i];
			   var param={"id":row.id};
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
							alert("<i18n:I18n key="il8n_common_alert_successfulOperation" defaultValue="操作成功"/>！",1);
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

//修改
$("#edit").click(function() {
	var selectRow = fileGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url='<%=basePath%>filemanage/editFiledistribytion.jsp?pertainObject='+selectRow[0].
	pertainObject+'&id='+selectRow[0].id+'&stairObjectCode='+selectRow[0].stairObjectCode+'&secondObjectCode='+selectRow[0].
	secondObjectCode+'&thirdObjectCode='+selectRow[0].thirdObjectCode+'&fourthObjectCode='+selectRow[0].
	fourthObjectCode+'&fifthObjectCode='+selectRow[0].fifthObjectCode+'&sixthObjectCode='+selectRow[0].
	sixthObjectCode+'&seventhObjectCode='+selectRow[0].seventhObjectCode+'&eighthObjectCode='+selectRow[0].
	eighthObjectCode+'&ninthObjectCode='+selectRow[0].ninthObjectCode+'&tenthObjectCode='+selectRow[0].
	tenthObjectCode+'&versionNumber='+selectRow[0].
	versionNumber+'&fileNumber='+selectRow[0].fileNumber+'&allocationDeclare='+selectRow[0].
	allocationDeclare+'&createUser='+selectRow[0].createUser+'&createDate='+selectRow[0].createDate;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'editFiledistribytion',
        'windowTitle':'<i18n:I18n defaultValue="编辑" key="i18n_label_edit_I18n"/>',
        'iframSrc':url,
         windowStatus: 'regular',
         windowMinWidth: 500,
         windowMinHeight: 580,
         windowPositionTop:24,
        'windowWidth':460,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
});

//列自定义
$("#columnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     'windowSubTitle': "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=fileAllocation" + "&window=iframeApp_filedistribution",
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
