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
			<div>
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_lable_printtemplateconfig" defaultValue="打印模板配置" /></span>
         <div class="common-box-line">
         		<div class="edit-box-wrap">
					<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
				</div>
				<input type="hidden" name="elsAccount" value="${elsAccount}" />
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                    </div>
                </main>
         </div>
 </div>
</form>
<script type="text/javascript">
var height=$(document).height()-295;
var itemGrid;
var cols = [
              { title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />', name:'elsAccount' ,width:180, align:'center', hidden:true, renderer:function(val){
       	        if (!val) {val = "";}
      	        return val + "<input name='configList[][elsAccount]' type='hidden' value='"+val+"'/>"; 
               }},
               { title:'<i18n:I18n key="i18n_label_additionCost_toElsAccount" defaultValue="对方ELS账号" />', name:'toElsAccount' ,width:180, align:'center' ,renderer:function(val){
           	    if (!val) {val = "";}
          	    return "<input name='configList[][toElsAccount]' type='text' value='"+val+"'/>"; 
               }},
               { title:'<i18n:I18n key="i18n_common_title_businesstype" defaultValue="单据类型" />', name:'businessType' ,width:150, align:'center',renderer:function(val){
              	 return "<select name='configList[][businessType]'><option value='order'>order</option><option value='delivery'>delivery</option></select>";
               }},
               { title:'<i18n:I18n key="i18n_title_printtemplateelsaccount" defaultValue="模板归属方ELS号" />', name:'templateElsAccount' ,width:150, align:'center',renderer:function(val){
              	 if (!val) {val = "";}
              	 return "<input name='configList[][templateElsAccount]' type='text' value='"+val+"'/>"; 
               }},
               { title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />', name:'templateNumber' ,width:180, align:'center' ,renderer:function(val){
            	 var showText = val;
            	 if(!val || val == "")
            		 showText = "<i18n:I18n key="i18n_label_clickselect" defaultValue="点我选择" />";
            	 return "<span class='showText' style='color:blue;cursor:pointer'>" + showText + "</span><select  class='templateSelector' style='display:none'></select><input name='configList[][templateNumber]' type='hidden' value='"+val+"'/>"; 
               }}
            ];

var blankRow = {"elsAccount":elsAccount,"toElsAccount":"","businessType":"order","templateElsAccount":"","templateNumber":""};

$().ready(function(){
	init();
});
function init(){
	getConfigList();
}
//获取数据
function getConfigList(){
		var data = {"elsAccount":elsAccount};
		$.ajax({
			url :"<%=basePath%>rest/ElsPrintTemplateService/queryPrintTemplateConfig",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				if(!itemGrid){
					itemGrid = $('#table-item').mmGrid({
				        cols: cols,
				        checkCol:true,
				        height:height,
				        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
				        items: data.configList
				    });
				}else{
					itemGrid.load(data.configList);
				}
				itemGrid.on('loadSuccess',function(e, d) {
					if(itemGrid.rowsLength() > 0)
						initSelectorsVal();
				});		
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
}

//初始化下拉框
function initSelectorsVal(){
	$("#table-item").find("tr").each(function(){
		var data = $(this).data("item");
		var businessTypeSelector = $(this).find("select[name='configList[][businessType]']");
		businessTypeSelector.val(data.businessType);
		//初始化每行选择模板点击事件
		initRowSpan($(this));
		bindItemEvent($(this));
	});
}

function bindItemEvent($obj){
	var businessTypeSelector = $obj.find("select[name='configList[][businessType]']");
	var templateElsAccountInput = $obj.find("input[name='configList[][templateElsAccount]']");
	businessTypeSelector.change(function(){
		$obj.find(".showText").text("<i18n:I18n key="i18n_label_clickselect" defaultValue="点我选择" />"); 
		$obj.find("input[name='configList[][templateNumber]']").val("");
	});
	templateElsAccountInput.keyup(function(){
		$obj.find(".showText").text("<i18n:I18n key="i18n_label_clickselect" defaultValue="点我选择" />"); 
		$obj.find("input[name='configList[][templateNumber]']").val("");
	});
}

function checkVal(){
	var bool = true;
	$("#table-item").find("tr").each(function(){
		var templateNumber = $(this).find("input[name='configList[][templateNumber]']").val();
		if(templateNumber == ""){
			bool = false;
			return;
		}
	});
	return bool;
}

//初始化每行选择模板点击事件
function initRowSpan($obj){
	var $span = $obj.find(".showText");
	$span.click(function(){
		    var businessType = $obj.find("select[name='configList[][businessType]']").val();
		    var templateElsAccount = $obj.find("input[name='configList[][templateElsAccount]']").val();
			var $templateSelector = $obj.find(".templateSelector");
			var $hidden = $obj.find("input[name='configList[][templateNumber]']");
			if (templateElsAccount == "") {
				alert("<i18n:I18n key="i18n_label_filltemplateels" defaultValue="请填写模板归属方ELS号" />",2);
				return;
			}else{
				var data = {"elsAccount":templateElsAccount,"businessType":businessType};
				var url = "<%=basePath%>rest/ElsPrintTemplateService/queryPrintTemplate";
				$.ajax({
					url : url,
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(data),
					dataType : "json",
					success : function(data) {
						if(data.length == 0){
							alert("<i18n:I18n key="i18n_alert_notemplate" defaultValue="未查询到对应模板" />",2);
							return;
						}
						$templateSelector.empty();
						var html = "";
						for (var i=0;i<data.length;i++){
							html += "<option value='" + data[i].templateNumber + "'>" + data[i].templateNumber + "_" + data[i].templateDesc + "</option>";
						}
						$templateSelector.append(html);
						$span.hide();
						$templateSelector.show();
						$templateSelector.val($span.text());
						$templateSelector.unbind("blur").bind("blur",function(){
							$(this).prev("span").text($(this).val()); 
							$(this).next("input").val($(this).val());
							$(this).prev("span").show();
							$(this).hide();
						});
					},
					error : function(data) {
		    			if (!permissionError(data)) {
		    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		    			}
					}
				});
			}
		});
}

//新增
$("#btnAdd").click(function(){
	itemGrid.addRow(blankRow,itemGrid.rowsLength());
	var $lastLine = $('#table-item tr:last');
	initRowSpan($lastLine);
	bindItemEvent($lastLine);
});

//保存
$("#saveBtn").click(function(){
	if(!checkVal()){
		alert("<i18n:I18n key="i18n_alert_selecttemplate" defaultValue="请选择模板" />",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/ElsPrintTemplateService/savePrintTemplateConfig",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				if (data.status == "401") {
					alert("<i18n:I18n key="i18n_alert_elsandtyperepeat" defaultValue="对方ELS号以及单据类型配置重复" />",2);
			    }else {
				    alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			    }
			}
		}});
	}});
});

//删除
$("#btnDelete").click(function(){
	var selectedIndexs = itemGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	itemGrid.removeRow(selectedIndexs[0]);
});

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('printTemplateConfig',closeCallback);
});

function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}
</script>
</body>
</html>