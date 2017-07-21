<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
<%-- 	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				
			</div>
		</div>
	</div> --%>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_material_catelist" defaultValue="物料分类列表" /></span>
         <div class="common-box-line">
         		<div class="edit-box-wrap">
         		    <button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
<%-- 				<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="btnEdit" class="button-wrap"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
					 --%>
					<button id="btnSAPImport" class="button-wrap"><i18n:I18n key="i18n_upload_fromerp" defaultValue="ERP导入" /></button>
					<button id="btnFileUpload" class="edit-btn button-wrap btnUpload"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></button>
					<button id="btnDownloadTemplate" class="edit-btn button-wrap btnUpload elsEdit"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="下载导入模板" /></button>
					<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
				</div>
				<input type="hidden" name="elsAccount" value="${elsAccount}" />
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
            { title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />', name:'elsAccount' ,width:180, align:'center' , hidden:true},
            { title:'<i18n:I18n key="i18n_title_materialcatecode" defaultValue="物料分类编码" />', name:'materialCateCode' ,width:180, align:'center' ,renderer:function(val){
       	        if (!val) {val = "";}
      	        return val+ "<input class='materialCateCode' type='hidden' value='"+val+"'/>"; 
            }},
            { title:'<i18n:I18n key="i18n_title_materialcatename" defaultValue="物料分类名称" />', name:'materialCateName' ,width:180, align:'center' ,renderer:function(val){
       	        if (!val) {val = "";}
      	        return val+ "<input class='materialCateName' type='hidden' value='"+val+"'/>"; 
            }},
            { title:'<i18n:I18n key="i18n_title_materialcatenamei18n" defaultValue="物料分类名称国际化" />', name:'materialCateNameI18n' ,width:180, align:'center' , hidden:true},
            { title:'<i18n:I18n key="i18n_title_materialspecsetting" defaultValue="设置物料特性" />', name:'materialCateCode' ,width:120, align:'center' ,renderer:function(val){
        	    return "<span name='rowLink' style='color:blue;cursor:pointer'><i18n:I18n key='i18n_title_materialspecsetting' defaultValue='关联物料特性' /></span>"; 
           }}
        ];

var blankRow = {"elsAccount":elsAccount,"materialCateCode":"","materialCateName":"","materialCateNameI18n":""};

$().ready(function(){
	init();
	initFileUploader();
});
function init(){
	var height=$(document).height()-295;
	var frm = $("#form");
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/MaterialCateService/queryMaterialCateList",
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
	grid.on('loadSuccess',function(e,data) {
		if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			grid.select(0);
			//初始化每行的按钮
			initRowLink($("#table"));
		}
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

function checkVal(){
	var msg;
	var array = [];
	$("#table").find("tr").each(function(){
		var materialNumber = $(this).find("input[name='materialList[][materialNumber]']").val();
		if(materialNumber == ""){
			msg = '<i18n:I18n key="i18n_material_fillnumber" defaultValue="请填写物料编号" />';
			return;	
		}else{
			array.push(materialNumber);
		}	
	});
    if(array.length > 1){
    	var nary = array.sort(); 
    	for(var i=0;i<nary.length-1;i++){ 
    		if (nary[i]==nary[i+1]){
    			msg = '<i18n:I18n key="i18n_material_numberdupli" defaultValue="物料号重复" />'; 
    	    } 
    	} 
    }
	return msg;
}

//保存
$("#saveBtn").click(function(){
	msg = checkVal();
	if(msg){
		alert(msg,2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/MaterialService/saveMaterialList",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			hasChanged = 0;
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
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
	}});
});

$("#btnEdit").click(function(){
	var index = grid.selectedRowsIndex();
	if (index.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
	var materialNumber = grid.row(index[0]).materialNumber;
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editMaterial',
        'windowTitle':'<i18n:I18n key="i18n_material_update" defaultValue="修改物料" />',
        'iframSrc':'<%=basePath%>materialmanage/editMaterial.jsp?materialNumber=' + materialNumber,
        'windowWidth':340,
        'windowHeight':330,
        'parentPanel':".currDesktop"
    });
});

$("#btnAdd").click(function(){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editMaterial',
        'windowTitle':'<i18n:I18n key="i18n_material_add" defaultValue="新增物料" />',
        'iframSrc':'<%=basePath%>materialmanage/editMaterial.jsp',
        'windowWidth':340,
        'windowHeight':330,
        'parentPanel':".currDesktop"
    });
});

function initRowLink($obj){
	$obj.find("span[name='rowLink']").each(function(){
		$(this).click(function(){
			var materialCateCode = $(this).parent().parent().parent().find(".materialCateCode").val();
			var materialCateName = $(this).parent().parent().parent().find(".materialCateName").val();
			if(materialCateCode == null || materialCateCode == ""){
				$("#saveBtn").trigger("click");
			}else{
				//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'editMaterialSpecRelation',
			        'windowTitle':'<i18n:I18n key="i18n_title_materialspecsetting" defaultValue="关联物料特性" />',
			        'iframSrc':'<%=basePath%>materialmanage/editMaterialSpecRelation.jsp?materialCateCode=' + materialCateCode + '&materialCateName=' + materialCateName,
			         windowStatus: 'maximized',
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop"
			    });
			}
		});
	});
}

<%-- function initRowLink($obj){
	$obj.find("span[name='rowLink']").each(function(){
		$(this).click(function(){
			var materialNumber = $(this).parent().parent().parent().find("input[name='materialList[][materialNumber]']").val();
			var materialName = $(this).parent().parent().parent().find("input[name='materialList[][materialName]']").val();
			if(materialNumber == null || materialNumber == "null" || materialNumber == "" || hasChanged == 1){
				$("#saveBtn").trigger("click");
			}else{
				//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'editMaterialSpecification',
			        'windowTitle':'<i18n:I18n key="i18n_material_specificationsetting" defaultValue="设置物料规格" />',
			        'iframSrc':'<%=basePath%>materialmanage/editMaterialSpecification.jsp?materialNumber=' + materialNumber + '&materialName=' + materialName,
			        windowStatus: 'maximized',
			        windowMinWidth: 960,
			        windowMinHeight: 700,
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop"
			    });
			}
		});
	});
} --%>

//删除
$("#btnDelete").click(function(){
	var selectedIndexs = grid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
		 var materialCateCode = grid.row(selectedIndexs[0]).materialCateCode;
		 var data = {"elsAccount":elsAccount,"materialCateCode":materialCateCode};
		 $.ajax({
				url :"<%=basePath%>rest/MaterialCateService/deleteMaterialCate",
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
		    server: '<%=basePath%>rest/MaterialCateService/uploadMaterialCateByExcel',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#btnFileUpload',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false
		});
		fileUploader.on("fileQueued", function () {
			top.elsDeskTop.showLoading();
		})
		fileUploader.on( 'uploadAccept', function( file, response ) {
			top.elsDeskTop.hideLoading();
			if(response.statusCode == "-100"){
				alert(response.message,2);
			}else{
				alert("<i18n:I18n key="i18n_alert_uploadSuccess" defaultValue="上传成功" />");
			}
			query();
		});
	}
}

$("#btnDownloadTemplate").click(function(){
	window.location.href = "${pageContext.request.contextPath}/template/物料分类导入模板.xlsx";
});

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('materialCateManage',closeCallback);
});

function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}
</script>
</body>
</html>