<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">  
html, body   { height:100%; }  
body { margin :0; padding:0; overflow:auto ; }    
#flashContent { display :none; } 
</style> 
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="对账单头历史" key="test"/></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-busrecon-head"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="对账项目历史" key="i18n_busRecon_title_busReconItemHistory"/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="对账单行项目" key="i18n_busRecon_title_ReconLineItem"/></a></li>
                        <li><a class="scan-file-sheet" href="#sheet-project-two"><i18n:I18n defaultValue="表单文件" key="i18n_enquiry_title_formfile"/></a></li>
                        <li><a href="#sheet-project-seven"><i18n:I18n key="i18n_busRecon_title_invoiceDetail" defaultValue="发票明细" /></a></li>
                    </ul>
                    <div id="sheet-project-one" style="padding: 1px;">
                        <main class="grid-container nest-table">
                            <!-- <div class="edit-box-wrap" style="padding-top: 5px;">
                                <button id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
                            </div> -->
		                    <div class="grid-100" id="reCreate">
		                        <table id="table-busrecon-item"></table>
		                        <div id="pg-item" style="text-align: right;"></div>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two" style="padding: 1px;">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="add-file-project"></table>
											<div id="enquiryFilePage" style="text-align: right;"></div>
										</div>
									</main>
			                    </div>
				                 <div class="file-scan">
		   							 <div class="file-option-zoom">
		   							     <!-- <button id="btnAddFile" class="button-wrap"><i18n:I18n defaultValue="新增" key="i18n_common_button_addfile"/></button> -->
		   							     <button id="downloadFile" class="button-wrap"><i18n:I18n defaultValue="下载" key="i18n_common_button_download"/></button>
				                         <!-- <button id="btnDeleteFile" class="button-wrap"><i18n:I18n defaultValue="移除" key="i18n_common_button_remove"/></button>
				                         <button id="btnSendFile" class="button-wrap"><i18n:I18n defaultValue="发送" key="i18n_button_send"/></button> -->
								     </div>
								     <div class="file-display" id="file-display">
								     <a id="viewerPlaceHolder"></a>
								  </div>
								</div>
						   </div>
						</div>
                    </div>
                     <div id="sheet-project-seven" style="padding: 1px;">
                        <main class="grid-container nest-table">
                            <!--<div class="edit-box-wrap" style="padding-top: 5px;">
                                 <button id="itemColumnDefineBtn" class="button-wrap">列自定义</button> 
                            </div>-->
		                    <div class="grid-100" id="reCreateInvoice">
		                        <table id="table-busrecon-invoice"></table>
		                        <div id="pg-invoice" style="text-align: right;"></div>
		                    </div>
		                </main>
                     </div>
                </div>
            </div>
        </div>
    </div>
<script>
var headGrid;
var itemGrid;
var editFileTable;
var selectSupplierTable; 
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var userName = "<%=session.getAttribute("username")%>";
var purchaseBusReconNumber ="<%=request.getParameter("purchaseBusReconNumber") %>";
var toElsAccount ="<%=request.getParameter("toElsAccount") %>";
var rowIndexSelect=0; 
var invoiceTable;
var $sob;

$().ready(function(){
	init();
});

//日期格式渲染 yyyy-MM-dd
function rendererDate(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
	return val;
}
//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}


//渲染订单发送状态
function rendererSendStatus(val){
	if(val == 0){
		return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
	}else if(val == 1){
		return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
	}else{
		return "";
	}
}

//行项目确认状态渲染
function rendererItemStatus(val,item,rowIndex) {
	if(val == "1"){
	    return '<i18n:I18n key="i18n_common_select_confirmStatus_confirmed" defaultValue="已确认"/>';
	}else if(val == "2"){
        return '<i18n:I18n key="i18n_common_select_confirmStatus_rejected" defaultValue="已拒绝"/>'
    }else{
        return '<i18n:I18n key="i18n_common_select_confirmStatus_unconfirmed" defaultValue="未确认"/>';
    }
}


//渲染订单状态
function rendererBusReconStatus(val){
	if(val == 0){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_new" defaultValue="新建" />';
	}else if(val == 1){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_partConfirm" defaultValue="采购方部分确认" />';
	}else if(val == 2){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_allConfirm" defaultValue="采购方已确认" />';
	}else if(val == 3){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_partBilling" defaultValue="部分开票" />';
	}else if(val == 4){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_allBilling" defaultValue="全部开票" />';
	}else if(val == 5){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_invoicePartConfirm" defaultValue="发票部分确认" />';
	}else if(val == 6){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_invoiceAllConfirm" defaultValue="发票全部确认" />';
	}else if(val == 7){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_reject" defaultValue="退回" />';
	}else if(val == 8){
		return '<i18n:I18n key="i18n_busRecon_select_busReconStatus_cancelOrDelete" defaultValue="取消或删除" />';
	}
}

//发票核对状态渲染
function rendererCheckStatus(val,item,rowIndex) {
	if(val == "1"){
	    return '<i18n:I18n key="i18n_common_select_checkStatus_checked" defaultValue="已核对"/>';
	}else{
        return '<i18n:I18n key="i18n_common_select_checkStatus_unchecked" defaultValue="未核对"/>';
    }
}

//采购方对账单头信息表
var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseBusRecon_head_his_mt"/>;

var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseBusRecon_item_his_mt"/>;

var colsfile = [       
                { title:'<i18n:I18n key="i18n_busRecon_title_purchaseBusReconItemNumber" defaultValue="对账单行项目号"/>', name:'busReconItemNumber' , width:60, align:'center'},
                { title:'<i18n:I18n key="i18n_common_title_fileSequence" defaultValue="表单文件行编号"/>', name:'fileSequence' , width:100, align:'center'},
                { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>', name:'fileName' ,width:90, align:'center'},
                { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>', name:'filePath' ,width:90, align:'center',hidden:true},
                { title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳"/>', name:'logtime' ,width:140, align:'center',renderer:rendererTime},
                { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="文件发送状态"/>', name:'sendStatus' ,width:120, align:'center',renderer:rendererSendStatus},
                { title:'<i18n:I18n key="i18n_enquiry_title_maker" defaultValue="制单人"/>', name:'maker' ,width:100, align:'center'}
         ];
         
var colsInvoice = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseBusRecon_invoice_his_mt"/>;
           
//初始化控件
function init() {
	 //初始化控件
    $('button').button();
    $( '#sheet-project').tabs();
   //对账单头列表
    var param = {'elsAccount':elsAccount,'toElsAccount':toElsAccount,'purchaseBusReconNumber':purchaseBusReconNumber,'logtime':''};
    
    //初始化对账单头信息表
    headGrid = $('#table-busrecon-head').mmGrid({
        cols: cols,
        height:<base:tableHeight tableCode="purchaseBusRecon_head_his_mt"/>,
        height: 200,
        url : '<%=basePath%>rest/PurchaseBusinessReconciliationService/findPurchaseBusReconHeadHisList',
        params: param,
        method:  'post',
        root:"rows",
        loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
        noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
        indexCol:true,
        plugins: [
            $('#pg').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                , limit:null
                , limitList: [5,10,15,20]
            })
        ]
    });
    // 加载明细项
    headGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
    	//console.log(item);
    	//加载行表
    	rowIndexSelect=rowIndex;
    	var selectRows = headGrid.selectedRows();
    	if(selectRows.length != 0 ){
    		load(item.elsAccount,item.toElsAccount,item.purchaseBusReconNumber,item.logtime);
    	}else{
    		itemGrid.removeRow();
    		editFileTable.removeRow();
    	}
    });
    headGrid.on('loadSuccess',function(e, data) {
    	if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			headGrid.select(rowIndexSelect);
			//加载:行表purchase_enquiry_item
			load(data.rows[rowIndexSelect].elsAccount,data.rows[rowIndexSelect].toElsAccount,data.rows[rowIndexSelect].purchaseBusReconNumber,data.rows[rowIndexSelect].logtime);
    	}else{
    		itemGrid.removeRow();
    		editFileTable.removeRow();
    	}
    });
    
  //加载item表
    function load(elsAccount,toElsAccount,purchaseBusReconNumber,logtime) {
        var param = {
        	'elsAccount':elsAccount,
        	'toElsAccount':toElsAccount,
        	'purchaseBusReconNumber':purchaseBusReconNumber,
        	'logtime':logtime
        };
        if(itemGrid == null){
        	//初始化对账单行信息表
            itemGrid = $('#table-busrecon-item').mmGrid({
                cols: cols_item,
                height: 330,
                url : '<%=basePath%>rest/PurchaseBusinessReconciliationService/findPurchaseBusReconItemHisList',
                params: param,
                method:  'POST',
                root:"rows",
                loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
                noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
                indexCol:true,
                plugins: [
                    $('#pg-item').mmPaginator({
                        style: 'plain'
                        , totalCountName: 'total'
                        , page: 1
                        , pageParamName: 'currentPage'
                        , limitParamName: 'pageSize'
                        , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                        , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                        , limit:null
                        , limitList: [5,10,15,20]
                    })
                ]
            });
        }else{
        	 itemGrid.opts.params = param;
             itemGrid.load({page:1});
        }
        if(editFileTable == null){
        	//初始化文件列表
            editFileTable=$('#add-file-project').mmGrid({
        	    cols: colsfile,
        	    url: '<%=basePath%>rest/PurchaseBusinessReconciliationService/findPurchaseBusReconFileHisList',
        	    params: param,
        	    height: 340,
        	    method: 'post',
        	    root: 'rows',
        	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
        	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
        	    indexCol: true,
        	    multiSelect:false,
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
                          , limitList: [10,15,20]
                      })
                  ]
        	});
            editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
          		var seled=editFileTable.selectedRows();
        		if(seled && seled.length) {
        			var filePath = item.filePath;
        			if(filePath && filePath.length) {
        				previewFile(filePath);
        			} else {
        				alert('<i18n:I18n key="i18n_enquiry_alert_notfoundfilepath" defaultValue="服务器异常，找不到文件上传的路径"/>',3);
        			}
        		}
          	}); 
        }else{
        	editFileTable.opts.params = param;
            editFileTable.load({page:1});
        }
        
        if(invoiceTable == null){
        	invoiceTable=$('#table-busrecon-invoice').mmGrid({
        	    cols: colsInvoice,
        	    height:<base:tableHeight tableCode="purchaseBusRecon_invoice_his_mt"/>,
        	    url: '<%=basePath%>rest/PurchaseBusinessReconciliationService/findPurchaseBusReconInvoiceHisList',
        	    params: param,
        	    height: 340,
        	    method: 'post',
        	    root: 'rows',
        	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
        	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
        	    indexCol: true,
        	    multiSelect:false,
        	    plugins: [
                      $('#pg-invoice').mmPaginator({
                          style: 'plain'
                          , totalCountName: 'total'
                          , page: 1
                          , pageParamName: 'currentPage'
                          , limitParamName: 'pageSize'
                          , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                          , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                          , limit: null
                          , limitList: [10,15,20]
                      })
                  ]
        	});
        }else{
        	invoiceTable.opts.params = param;
        	invoiceTable.load({page:1});
        }
    }
    
}


//---------------文件展示----begin------------------
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
//---------------文件展示----end------------------


$("#downloadFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
	    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	}else{
		alert('<i18n:I18n key = "i18n_please_select_a_file_to_download"  defaultValue="请选择要下载的文件" />',0);
	}
	
 });
</script>

</body>
</html>