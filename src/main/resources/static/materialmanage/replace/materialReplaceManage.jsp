<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<%
String language = "en";
if(session.getAttribute("language")!=null&&session.getAttribute("language")!=""){
	language = String.valueOf(session.getAttribute("language")).replace("_","-");
}
%>

<body>
<div class="pos-relative public-wrap ">
   <div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			    <button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
			    <button id="btnEdit" class="button-wrap"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
			    <button id="btnERPImport" class="button-wrap"><i18n:I18n key="i18n_upload_fromerp" defaultValue="ERP导入" /></button>
			    <button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
			    <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			    <div class="dis-in-b input-and-tip" style="margin-left: 20px;">K3系统替代料<span id="refurbish" style="color: red;"></span>条</div>
			    <!-- <button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
			    <button id="btnFileUpload" class="edit-btn button-wrap btnUpload"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></button>
				<button id="btnDownloadTemplate" class="edit-btn button-wrap btnUpload elsEdit"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="下载导入模板" /></button> -->
		</div>
   </div>
<div class="box-wrap pos-relative bg-common">
<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
<div class="common-box-line">
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
    <input type="hidden" name="elsAccount" value="${elsAccount}" />
    <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="test" defaultValue="替代组代码" />： </span><input type="text" name="replaceGroup"/></div>
    <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="test" defaultValue="替代组名称" />： </span><input type="text" name="replaceName"/></div>
    <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />： </span><input type="text" name="materialNumber"/></div>
    <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="i18n_material_name" defaultValue="物料名称" />： </span><input type="text" name="materialName"/></div> 
    <!-- <div class="dis-in-b input-and-tip"><span class="text-right w-72"><i18n:I18n key="test" defaultValue="创建人" />： </span><input type="text" name="createUser"/></div>
    <div class="dis-in-b input-and-tip">
		    <span><i18n:I18n key="test" defaultValue="创建时间" />：</span>
		    <input type="text" class="Wdate" onfocus="WdatePicker({lang:'<%=language%>'})" id="createDate" name="createDate"/>
	</div>
    <div class="dis-in-b input-and-tip">
        <span><i18n:I18n key="test" defaultValue="更新时间" /></span>
        <input type="text"  class="Wdate" onfocus="WdatePicker({lang:'<%=language%>'})" id="lastUpdateDate" name="lastUpdateDate"/>
    </div> -->
    <button style="margin-left: 20px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
    <button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
</form>
</div>
</div>
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_material_list" defaultValue="替代物料列表" /></span>
         <div class="common-box-line">
             <main class="grid-container">
                 <div class="grid-100">
                      <table id="replaceMateriaTable"></table>
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
				<img class="icon" src="../../icon/els.PNG" /> 
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
//标记过程行数是否变动过，如果变动过，设置审批人之前会触发保存按钮
var hasChanged = 0;
var fileUploader;
var grid;

//渲染   @author jiangzhidong 20160620 begin
//日期
var formatDate = function (val,item,index){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	   return val;
};
//物料代码
var initMaterialNumber = function (val,item,index){
	  if (!val) {val = "";}
      return val+ "<input class='materialNumber' type='hidden' value='"+val+"'/>"; 
};
//物料名称
var initMaterialName = function (val,item,index){
	  if (!val) {val = "";}
      return val+ "<input class='materialNumber' type='hidden' value='"+val+"'/>"; 
};
//物料描述
var initMaterialDesc = function (val,item,index){
	  if (!val) {val = "";}
      return val+ "<input class='materialDesc' type='hidden' value='"+val+"'/>"; 
};
//渲染   @author jiangzhidong 20160620  end

var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="materialReplaceManage_mt"/>;

/*var cols = [
            { title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS帐号" />', name:'elsAccount' ,width:80, align:'center' , hidden:true},
            { title:'<i18n:I18n key="test" defaultValue="替代组代码" />', name:'replaceGroup' ,width:120, align:'center' },
            { title:'<i18n:I18n key="test" defaultValue="替代组名称" />', name:'replaceName' ,width:120, align:'center' },
            { title:'<i18n:I18n key="test" defaultValue="物料编号" />', name:'materialNumber' ,width:150, align:'center' ,renderer: initMaterialNumber},
            { title:'<i18n:I18n key="i18n_material_name" defaultValue="物料名称" />', name:'materialName' ,width:200, align:'center' ,renderer: initMaterialName},
            { title:'<i18n:I18n key="test" defaultValue="物料描述" />', name:'materialDesc' ,width:250, align:'center' ,renderer: initMaterialDesc},
            { title:'<i18n:I18n key="test" defaultValue="创建人" />', name:'createUser' ,width:120, align:'center'},
            { title:'<i18n:I18n key="test" defaultValue="创建时间" />', name:'createDate' ,width:150, align:'center',renderer: formatDate},
            { title:'<i18n:I18n key="test" defaultValue="更新时间" />', name:'lastUpdateDate' ,width:120, align:'center',renderer: formatDate}]; */

$().ready(function(){
	init();
	initFileUploader();
});
function init(){
	var height=$(document).height()-195;
	var frm = $("#form");
	grid = $('#replaceMateriaTable').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/MaterialReplaceService/queryMaterialReplaceList",
        params: frm.serializeJSON(),
        method: "POST",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:height,
        checkCol: true,
        multiSelect: true,
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
                , limitList: [10,30,50,100]
            })
        ]
    });
	grid.on('loadSuccess',function(e,data) {
		if (data.rows && data.rows.length > 0) {
			//默认选中第一行
			//grid.select(0);
			//初始化下拉框
			//initSelect();
			//初始化每行的按钮
			initRowLink($("#table"));
		}
		getERPMaterialReplaceCount();
	});
	
    $("#queryBtn").click(function(){
    	query();
    	getERPMaterialReplaceCount();
    });
    
    $("#columnDefineBtn").click(function(){
    	parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'subAccountColumnSetting',
            'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
            windowSubTitle: "",
            'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=materialReplaceManage_mt" + "&window=iframeApp_materialReplaceManage_mt",
            windowMinWidth: 480,
            windowMinHeight: 600,
            'windowWidth':480,
            'windowHeight':600,
            'parentPanel':".currDesktop"
        });
    });
}

var getERPMaterialReplaceCount = function() {
	setInterval(function() {
		// 迈腾-接口-运行中 @author jiangzhidong @date 20160810
	    var frm = $("#form2");
		$.ajax({
			url :"<%=basePath%>rest/MaterialReplaceService/getERPMaterialReplaceCount",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				if(data!=null&&data.statusCode=="-100"){
	 				alert(data.message,2);
	 			}else{
	 				$("#refurbish").text(data.message);
	 			}
			},
			error : function(data) {
				if (!permissionError(data)) {
					 //alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
    }, 5000);
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

$("#btnERPImport").click(function(){
	if(!(elsAccount == "160000" && elsSubAccount == "1001")){
		alert("仅160000/1001账户可执行同步操作",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认ERP导入？" />',closeEvent:function(){
		var btnERPImport = $("#btnERPImport");
		btnERPImport.empty().append('<span style="color: red;">同步中...</span>');
		var frm = $("#form2");
		$.ajax({
			url :"<%=basePath%>rest/MaterialReplaceService/getERPMaterialReplace",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				if(data!=null&&data.statusCode=="-100"){
	 				alert(data.message,2);
	 			}else{
					hasChanged = 0;
					//清空form2
					$(':input','#form2')
					 .not(':button, :submit, :reset, :hidden')
					 .val('')
					 .removeAttr('checked')
					 .removeAttr('selected');
					//重新查询
					query();
					btnERPImport.text("导入成功");
	 			}
			},
			error : function(data) {
				if (!permissionError(data)) {
					 alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	}});
});

 $("#btnFileCancel1").click(function(){
    $(".fixed-dialog").hide();
 });
 
 $('.dialog-close-btn').click(function(){
	$('.fixed-dialog').hide();
 });

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
	if (index.length != 1) {
		alert("<i18n:I18n key="test" defaultValue="请选择一行数据" />",2);
		return;
	}
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    var selectRows = grid.selectedRows();
    var opType = "upd";
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editMaterialReplace',
        'windowTitle':'<i18n:I18n key="i18n_material_update" defaultValue="修改物料" />',
        'iframSrc':'<%=basePath%>materialmanage/replace/editMaterialReplace.jsp?opType='+ opType,
        'windowWidth':340,
        'windowHeight':380,
        'parentPanel':".currDesktop",
        data:selectRows
    });
});

$("#btnAdd").click(function(){
	var selectRows = grid.selectedRows();
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editMaterialReplace',
        'windowTitle':'<i18n:I18n key="test" defaultValue="新增替代物料关系" />',
        'iframSrc':'<%=basePath%>materialmanage/replace/editMaterialReplace.jsp',
        'windowWidth':340,
        'windowHeight':380,
        'parentPanel':".currDesktop",
        data:selectRows
    });
});

function initRowLink($obj){
	$obj.find("span[name='rowLink']").each(function(){
		$(this).click(function(){
			var materialNumber = $(this).parent().parent().parent().find(".materialNumber").val();
			var materialName = $(this).parent().parent().parent().find(".materialName").val();
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
	var selectRows = grid.selectedRows();
	if(selectRows.length<=0){
		alert('<i18n:I18n key="test" defaultValue="请选择!" />',2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
				url :"<%=basePath%>rest/MaterialReplaceService/deleteMaterialReplaces",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(selectRows),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功" />');
					parent.elsDeskTop.hideLoading();
					query();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
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

function insertMaterialList(fileName){
	var paramStr={"elsAccount":elsAccount,"fileName":fileName};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/MaterialService/insertMaterialList",
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

$("#btnDownloadTemplate").click(function(){
	window.location.href = "${pageContext.request.contextPath}/template/物料清单导入模板.xlsx";
});

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('materialReplaceManage',closeCallback);
});

function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}
</script>
</body>
</html>