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
	    <div class="dis-in-b input-and-tip">
             <button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
        </div>
        <div class="dis-in-b input-and-tip">
             <button id="findBtn" class="button-wrap" ><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
        </div>
	</div>
</div>
   
<div class="box-wrap pos-relative bg-common">
<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
<div class="common-box-line">
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
    <input type="hidden" name="elsAccount" value="${elsAccount}" />
    <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />： </span><input type="text" name="materialNumber"/></div>
    <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="i18n_material_name" defaultValue="物料名称" />： </span><input type="text" name="materialName"/></div> 
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
var hasChanged = 0;
var fileUploader;
var grid;
var frameAppId ="<%=request.getParameter("frameAppId") %>";

var cols = [
            { title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />', name:'elsAccount' ,width:180, align:'center' , hidden:true},
            { title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber' ,width:180, align:'center' ,renderer:function(val){
       	        if (!val) {val = "";}
      	        return val+ "<input class='materialNumber' type='hidden' value='"+val+"'/>"; 
            }},
            { title:'<i18n:I18n key="i18n_material_name" defaultValue="物料名称" />', name:'materialName' ,width:180, align:'center' ,renderer:function(val){
       	        if (!val) {val = "";}
      	        return val+ "<input class='materialName' type='hidden' value='"+val+"'/>"; 
            }},
            { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述" />', name:'materialDesc' ,width:220, align:'center' },
            { title:'<i18n:I18n key="i18n_common_title_purchaseGroup" defaultValue="采购组" />', name:'purchaseGroup' ,width:80, align:'center' },
            { title:'<i18n:I18n key="i18n_common_title_materialgroup" defaultValue="物料组" />', name:'materialGroup' ,width:80, align:'center' },
            { title:'物料组名称', name:'fbk9' ,width:220, align:'center' },
            { title:'版次', name:'fbk8' ,width:120, align:'center' },
        ];

$().ready(function(){
	init();
});

function init(){
	var height=$(document).height()-195;
	var frm = $("#form");
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/MaterialService/queryMaterialList",
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
	grid.on('cellSelected',function(e, item, rowIndex, colIndex) {
     	$('body').data('materialDataItem',item);
	});
	
    $("#queryBtn").click(function(){
    	query();
    });
    
    $("#columnDefineBtn").click(function(){
    	parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'subAccountColumnSetting',
            'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
            windowSubTitle: "",
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=materialManage" + "&window=iframeApp_materialManage",
            windowMinWidth: 480,
            windowMinHeight: 600,
            'windowWidth':480,
            'windowHeight':600,
            'parentPanel':".currDesktop"
        });
    });
}
//获取数据
function query(){
	var frm = $("#form");
	grid.opts.params = frm.serializeJSON();
	grid.load({});
}

//初始化下拉框
function initSelect(){
	$("#table").find("td").each(function(){
		var val=$(this).find(".showText").text();
		var selectObj=$(this).find("select");
		if(selectObj.length>0)
			selectObj.val(val);
	});
}

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

$("#btnSAPImport").click(function(){
	$(".dialog-tip").height(100);
	$(".dialog-tip").width(450);
	$(".fixed-dialog").show();
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

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('materialManage',closeCallback);
});

function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}

$("#findBtn").click(function() {
	var selectRows = grid.selectedRows();
	if(selectRows.length!=1){
		alert('<i18n:I18n key="test" defaultValue="请选择一条!" />!',2);
		return;
	}
	parent.frames['iframeApp_'+frameAppId].selectMaterialCallbackFunc(selectRows[0]);
    parent.elsDeskTop.closeCurWin('findMaterialManage');
});

$('#table').on('dblclick','tr',function() {
	var row = $('body').data('materialDataItem');
	parent.frames['iframeApp_'+frameAppId].selectMaterialCallbackFunc(row);
    parent.elsDeskTop.closeCurWin('findMaterialManage');
});
</script>
</body>
</html>