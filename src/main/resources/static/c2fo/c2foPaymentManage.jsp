<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
	<div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
        <div class="common-box-line">
            <button id="getERP" class="button-wrap"><i18n:I18n key="i18n_button_getfromerp" defaultValue="从ERP获取" /></button>
            <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
        </div>
    </div>
<form id="queryForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;" action="<%=basePath%>rest/C2foService/getPayment">
	<input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount }"/>
	<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
         <div class="common-box-line">
       		<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_additionCost_toElsAccount" defaultValue="对方ELS号" />：</span><input type="text" name="toElsAccount"/></div>
       		<button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
           	<button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
          </div>
     </div>
     <div class="box-wrap pos-relative bg-common">
          <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_purchaseOrder_head" defaultValue="采购订单头" /></span>
          <div class="common-box-line">
          	<main class="grid-container">
                  <div class="grid-100">
                      <table id="table"></table>
                      <div id="pg" style="text-align: right;"></div>
                  </div>
              </main>
       	</div>
	</div>
</form>
<script type="text/javascript">
var fileUploader;
var grid;
var cols = [
            { title:'ELS号', name:'elsAccount' ,width:180, align:'center'},
            { title:'对方ELS号', name:'toElsAccount' ,width:180, align:'center'},
            { title:'发票号/收货凭证', name:'invoiceNumber' ,width:180, align:'center'},
            { title:'支付金额', name:'totalAmount' ,width:180, align:'center'},
            { title:'支付时间', name:'planPayTime' ,width:180, align:'center'}
        ];

$().ready(function(){
	init();
// 	initFileUploader();
});
function init(){
	var height=$(document).height()-295;
	var frm = $("#queryForm");
	grid = $('#table').mmGrid({
        cols: cols,
        url : frm[0].action,
        params: frm.serializeJSON(),
        method: "POST",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:"200px",
        checkCol:true,
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
                , limitList: [10,20]
            })
        ]
    });
	 $("#queryBtn").click(function(){
	    	query();
	    });
}
//获取数据
function query(){
	var frm = $("#queryForm");
	grid.opts.params = frm.serializeJSON();
	grid.load({});
}


function initFileUploader(){
	if(!fileUploader){
		fileUploader = WebUploader.create({
		    // swf文件路径
		    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		    auto: true,
		    duplicate :true,
		    accept:{
		    	extensions:"xls,xlsx"
		    },
		    // 文件接收服务端。
		    server: '<%=basePath%>rest/MaterialService/uploadMaterialByExcel',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#btnFileUpload',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false
		});
		
		fileUploader.on( 'uploadAccept', function( file, response ) {
			insertMaterialList(response._raw);
		});
	}
}

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10));
});

</script>
</body>
</html>