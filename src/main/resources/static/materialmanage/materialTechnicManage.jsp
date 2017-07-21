<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
<div class="pos-relative public-wrap ">
   <div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			    <button id="btnFileUpload" class="edit-btn button-wrap btnUpload"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></button>
				<button id="btnDownloadTemplate" class="edit-btn button-wrap btnUpload elsEdit"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="下载导入模板" /></button>
				<button id="btnSAPImport" class="button-wrap"><i18n:I18n key="i18n_upload_fromerp" defaultValue="ERP导入" /></button>
				<button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
				<%-- 
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
			    <button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
			    <button id="btnEdit" class="button-wrap"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
			    --%>
		</div>
   </div>
<div class="box-wrap pos-relative bg-common">
<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
<div class="common-box-line">
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
    <input type="hidden" name="elsAccount" value="${elsAccount}" />
    <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="i18n_common_lable_materialxx" defaultValue="材质工艺代码" />： </span><input type="text" name="technicNumber"/></div>
    <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="i18n_material_xxx" defaultValue="材质工艺描述" />： </span><input type="text" name="technicDesc"/></div> 
    <button style="margin-left: 20px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
</form>
</div>
</div>
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_material_list" defaultValue="物料列表" /></span>
         <div class="common-box-line">
             <main class="grid-container">
                 <div class="grid-100">
                      <table id="table"></table>
                      <div id="pg" style="text-align: right;"></div>
                 </div>
             </main>
         </div>
</div>
</div>
<div class="fixed-dialog">
	<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../icon/els.PNG" /> 
				<span id="dialogTitle"><i18n:I18n key="i18n_button_getfromerx" defaultValue="从ERP导入" /></span>
			</div>
			<div class="box-wrap pos-relative bg-common">
			<form id="form2" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
			<input type="hidden" name="elsAccount" value="${elsAccount}" />
			<table>
			<tbody>
			<tr style="height:30px;line-height:30px;">
			    <td align="right"><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />：</td>
			    <td align="left"><input type="text" name="materialNumber" /></td>
			</tr>
			<tr style="height:30px;line-height:30px;">
			    <td align="right"><i18n:I18n key="i18n_label_materialgroup" defaultValue="物料组" />：</td>
			    <td align="left"><input type="text" name="materialGroup" /></td>
			</tr>
			<tr style="height:30px;line-height:30px;">
			    <td align="right"><i18n:I18n key="i18n_enquiry_title_purchasegroup" defaultValue="采购组" />：</td>
			    <td align="left"><input type="text" name="purchaseGroup" /></td>
			</tr>
			<tr style="height:30px;line-height:30px;">
			    <td align="right"><i18n:I18n key="i18n_enquiry_title_plant" defaultValue="工厂" />：</td>
			    <td align="left"><input type="text" name="plant" /></td>
			</tr>
			<tr style="height:30px;line-height:30px;">
			    <td align="right"><i18n:I18n key="i18n_sampleManage_createDate" defaultValue="创建日期" />：</td>
			    <td align="left"><input type="text" name="startDate" class="Wdate" onfocus="WdatePicker()" />
					<i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" />
					<input type="text" name="endDate" class="Wdate" onfocus="WdatePicker()" />
				</td>
			</tr>
			</tbody>
			</table>
			</form>
			<div class="mt-20">
				<button id="btnFileOK1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
				<button id="btnFileCancel1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
			</div>
		    </div>
	</div>
</div>
<script type="text/javascript">
var fileUploader;
var grid;
var cols = [
            { title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />', name:'elsAccount' ,width:180, align:'center' , hidden:true},
            { title:'<i18n:I18n key="i18n_material_xxx" defaultValue="类编码" />', name:'categoryNumber' ,width:120, align:'center'},
            { title:'<i18n:I18n key="i18n_common_lable_materialxxx" defaultValue="材质工艺代码" />', name:'technicNumber' ,width:120, align:'center'},
            { title:'<i18n:I18n key="i18n_material_xxx" defaultValue="材质工艺描述" />', name:'technicDesc' ,width:400, align:'center'},
            { title:'<i18n:I18n key="i18n_title_language" defaultValue="描述语言" />', name:'language' ,width:80, align:'center' }
        ];

var blankRow = {"elsAccount":elsAccount,"categoryNumber":"","technicNumber":"","technicDesc":"","language":""};

$().ready(function(){
	init();
	initFileUploader();
});
function init(){
	var height=$(document).height()-195;
	var frm = $("#form");
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/MaterialService/queryMaterialTechnicList",
        params: frm.serializeJSON(),
        method: "POST",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:height,
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
	grid.on('loadSuccess',function(e,data) {
		if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			grid.select(0);
		}
	});
	
    $("#queryBtn").click(function(){
    	query();
    });
}
//获取数据
function query(){
	var frm = $("#form");
	grid.opts.params = frm.serializeJSON();
	grid.load({});
}

//新增
/* $("#btnAdd").click(function(){
	grid.addRow(blankRow,grid.rowsLength());
	hasChanged = 1;
	var $lastLine = $('#table tr:last');
	initRowLink($lastLine);
}); */

//删除
$("#btnDelete").click(function(){
	var selectedIndexs = grid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
		 var technicNumber = grid.row(selectedIndexs[0]).technicNumber;
		 var id = grid.row(selectedIndexs[0]).id;
		 var data = {"elsAccount":elsAccount,"technicNumber":technicNumber,"id":id};
		 $.ajax({
				url :"<%=basePath%>rest/MaterialService/deleteMaterialTechnic",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功" />');
					grid.removeRow(selectedIndexs[0]);
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});
	}});
});

$("#btnDownloadTemplate").click(function(){
	window.location.href = "${pageContext.request.contextPath}/template/材质工艺导入模板.xlsx";
});

$("#btnSAPImport").click(function(){
/* 	$(".dialog-tip").height(100);
	$(".dialog-tip").width(450);
	$(".fixed-dialog").show(); */
});

$("#btnFileOK1").click(function(){
	var frm = $("#form2");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialService/getERPMaterial",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data!=null&&data.statusCode=="-100"){
 				alert(data.message,2);
 			}else{
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				hasChanged = 0;
				//清空form2
				$(':input','#form2')
				 .not(':button, :submit, :reset, :hidden')
				 .val('')
				 .removeAttr('checked')
				 .removeAttr('selected');
				//隐藏对话框
				$(".fixed-dialog").hide();
				//重新查询
				query();
 			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				if (data.status == "401") {
					alert('<i18n:I18n key="i18n_upload_materialdupli" defaultValue="物料编号重复" />',2);
			    }else {
				    alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			    }
			}
		}
	});
});

 $("#btnFileCancel1").click(function(){
    $(".fixed-dialog").hide();
 });
 
 $('.dialog-close-btn').click(function(){
	$('.fixed-dialog').hide();
 });

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
		    server: '<%=basePath%>rest/MaterialService/uploadMaterialTechnicByExcel',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#btnFileUpload',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false
		});
		
		fileUploader.on( 'uploadAccept', function( file, response ) {
			insertMaterialTechnicList(response._raw);
		});
	}
}

function insertMaterialTechnicList(fileName){
	var paramStr={"elsAccount":elsAccount,"fileName":fileName};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialService/insertMaterialTechnicList",
		type : "post",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(paramStr),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.statusCode=="-100"){
				alert(data.message,2);
			}else{
				alert("<i18n:I18n key="i18n_alert_uploadSuccess" defaultValue="上传成功" />");
			}
			query();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
			
		}
	});
}

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('materialTechnicManage',closeCallback);
});

function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}
</script>
</body>
</html>