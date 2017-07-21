<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
        <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
            	<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
            	<button id="saveAsBtn" class="button-wrap"><i18n:I18n key="i18n_button_saveAs" defaultValue="另存为" /></button>
            	<button id="saveDefaultBtn" class="button-wrap"><i18n:I18n key="i18n_button_setdefault" defaultValue="恢复默认" /></button>
            	<button id="deleteBtn" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
            	<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            	<button id="sycSystemBtn" class="button-wrap"><i18n:I18n key="" defaultValue="系统列同步" /></button>
            </div> 
        </div>
        <!-- 支持mmGrig调节高度 @author update/jiangzhidong @date 20161229 begin -->
        <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common">基本选择</span>
            <div class="common-box-line">
            	<i18n:I18n key="i18n_coststructure_button_selecttemplate" defaultValue="模板选择" />: 
            	<select id="tableSelector"></select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	表格高度:
            	<select id="tableHeight">
            		<option value='50'>50</option>
            		<option value='100'>100</option>
            		<option value='150'>150</option>
            		<option value='200'>200</option>
            		<option value='250'>250</option>
            		<option value='300' selected="selected">300（常用）</option>
            		<option value='350'>350（常用）</option>
            		<option value='400'>400（常用）</option>
            		<option value='450'>450（常用）</option>
            		<option value='500'>500（常用）</option>
            		<option value='550'>550（常用）</option>
            		<option value='600'>600（常用）</option>
            		<option value='650'>650</option>
            		<option value='700'>700</option>
            		<option value='750'>750</option>
            		<option value='800'>800</option>
            		<option value='850'>850</option>
            		<option value='900'>900</option>
            		<option value='950'>950</option>
            		<option value='1000'>1000</option>
            	</select>
            </div>
        </div>
        <!-- 支持mmGrig调节高度 @author update/jiangzhidong @date 20161229 end -->
        <div class="box-wrap pos-relative bg-common">
        <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/TableColumnService/updateSubAccountColumn">
            <input type="hidden" id="elsAccount" name="elsAccount" value="${elsAccount }"/>
            <input type="hidden" id="elsSubAccount" name="elsSubAccount" value="${elsSubAccount }"/>
            <input type="hidden" id="tableCode" name="tableCode" value="<%=request.getParameter("tableCode")%>"/>
            <input type="hidden" id="templateCode" name="templateCode"/>
            <input type="hidden" id="templateName" name="templateName" value="<i18n:I18n key='i18n_label_default' defaultValue='默认' />"/>
            <input type="hidden" id="canSort" name="canSort" />
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_allColumns" defaultValue="所有列" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </form>
        </div>
        <div class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../icon/els.PNG" /> <span
					id="dialogTitle"><i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<div class="common-box-line">
						<div id="divOrderItem" class="input-and-tip">
							<span><i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />：</span> <input type="text" id="templateNameInput"/>
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFileOK1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
var itemGrid;
var cols_item = [
                 {title:'<i18n:I18n key="i18n_label_columnCode" defaultValue="列编码" />', name:'columnCode', width: 150, align: 'center', hidden:true, renderer:function(val){
	             	if (!val) {val = "";}
	            	return "<input name='subAccountColumnList[][columnCode]' type='hidden' value='"+val+"'/>";
	             }},
                 {title:'<i18n:I18n key="i18n_label_columnName" defaultValue="列名" />', name:'displayName', width: 150, align: 'center'},
                 {title:'<i18n:I18n key="i18n_label_columnWidth" defaultValue="列宽" />', name:'columnWidth' ,width:120, align:'center', renderer:function(val){
	             	if (!val) {val = "";}
	            	return "<input name='subAccountColumnList[][columnWidth]' type='text' style='width:50px' value='"+val+"'/>";
	             }},
                 {title:'<i18n:I18n key="i18n_label_columnAlign" defaultValue="对齐方式" />', name:'columnAlign', width: 200, align: 'center', hidden:true, renderer:function(val){
             	  	return "<span class='showText' style='display:none'>" + val + "</span>" + "<select name='subAccountColumnList[][columnAlign]'><option value='left'>左对齐</option><option value='center'>居中对齐</option><option value='right'>右对齐</option></select>";
                 }},
                 {title:'<i18n:I18n key="i18n_label_display" defaultValue="显示" />', name:'isHidden' ,width:60, align:'center',renderer:function(val){
             	  	return "<input name='subAccountColumnList[][isHidden]' type='hidden' value='"+val+"'/><input type='checkbox' />";
                 }},
                 {title:'<i18n:I18n key="i18n_label_sort" defaultValue="排序" />', name:'sortOrder', width: 60, align: 'center',renderer:function(val){
             	  	return "<img src='../extend/mmGrid/src/img/arrow_up.png' class='up' style='cursor: pointer'/>&nbsp;&nbsp;&nbsp;<img src='../extend/mmGrid/src/img/arrow_down.png' class='down' style='cursor: pointer'/>";
                 }}
             ];
$().ready(function(){
	init();
});
var fromWindow = "<%=request.getParameter("window")%>";
function init(){
	//初始化控件
    debugger;
	if(elsAccount !="160000" || elsSubAccount !="1001"){
		$("#sycSystemBtn").hide();
	}
	var tableCode = "<%=request.getParameter("tableCode")%>";
	
	// 获取用户自定义表格
	$.ajax({
			url :"<%=basePath%>rest/TableColumnService/getSubAccountTable/"+elsAccount+"/" + elsSubAccount+"/" + tableCode,
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				debugger;
				if (data&&data.statusCode == "-100") {
				    alert(data.message,3);
				    return;
				}
				// 支持mmGrig调节高度 @author jiangzhidong @date 20161229 begin
				$("#tableHeight").val(data.tableHeight);
				// 支持mmGrig调节高度 @author jiangzhidong @date 20161229 end
				if (data.rows.length==0) {
					$("#tableSelector").append("<option value='system'><i18n:I18n key='i18n_label_default' defaultValue='默认' /></option>");
				} else {
					var html = "";
					for (var i=0;i<data.rows.length;i++) {
						debugger;
						if (data.rows[i].isDefault == "Y") {
							html += "<option value='"+data.rows[i].templateCode+"' selected>"+data.rows[i].templateName+"</option>";
							$("#templateCode").val(data.rows[i].templateCode);
							$("#templateName").val(data.rows[i].templateName);
						} else {
							html += "<option value='"+data.rows[i].templateCode+"'>"+data.rows[i].templateName+"</option>";
						}
					}
					$("#tableSelector").append(html);
					$("#tableSelector").change(function(){
						debugger;
						$("#templateCode").val($(this).val());
						$("#templateName").val($(this).find("option[value="+$(this).val()+"]").html());
						itemGrid.opts.url = "<%=basePath%>rest/TableColumnService/getCurrentSubAccountColumn/"+elsAccount+"/"+elsSubAccount+"/"+tableCode+"/"+$(this).val();
						itemGrid.load({});
					});
				}
				var height = $(document).height()-160;
				if (!itemGrid) {
					var templateCode = $("#tableSelector").val();
					 itemGrid = $('#table-item').mmGrid({
				        cols: cols_item,
				        url : "<%=basePath%>rest/TableColumnService/getCurrentSubAccountColumn/"+elsAccount+"/"+elsSubAccount+"/"+tableCode+"/"+templateCode,
				        method:  "GET",
				        height: height,
				        root:"lstData",
				        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
				    });
				}
				itemGrid.on('loadSuccess',function(e, data) {
					if (itemGrid.rowsLength() > 0){
						initSelect();
					    initCheckBox();
					    initUpDownBtn();
					}
				});
			},
			error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('subAccountColumnSetting');
	});
	$("#saveAsBtn").click(function(){
		$("#templateNameInput").val("");
    	$(".fixed-dialog").show();
    	$(".dialog-tip").height(175);
	});
	$("#btnFileOK1").click(function(){
		var templateName = $("#templateNameInput").val().trim();
		if (templateName == "") {
			alert("<i18n:I18n key='i18n_columnsetting_entertempname' defaultValue='请输入模板名称' />",2);
			return;
		}
		$("#templateCode").val("");
		$("#templateName").val(templateName);
    	$(".fixed-dialog").hide();
    	$("#saveBtn").click();
    });
	 $("#btnFileCancel1").click(function(){
	    $(".fixed-dialog").hide();
	 });
	 $('.dialog-close-btn').click(function(){
	    $('.fixed-dialog').hide();
	 });
	$("#saveBtn").click(function(){
		debugger;
		var frm = $("#queryForm");
		//支持mmGrig调节高度 @author jiangzhidong @date 20161229 begin
		var tableHeight = $("#tableHeight").val();
		var obj = frm.serializeJSON();
		obj["tableHeight"] = tableHeight;
		//支持mmGrig调节高度 @author jiangzhidong @date 20161229 end
		$.ajax({
			url :frm[0].action,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(obj),
			dataType : "json",
			success : function(data) {
				if (data&&data.statusCode == "-100") {
				     alert(data.message,3);
				 } else {
					 alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功' />");
					 parent.elsDeskTop.closeCurWin('subAccountColumnSetting',closeCallback());
				}
			},
			error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	$("#sycSystemBtn").click(function(){
		debugger;
		var frm = $("#queryForm");
		//支持mmGrig调节高度 @author jiangzhidong @date 20161229 begin
		var tableHeight = $("#tableHeight").val();
		var obj = frm.serializeJSON();
		obj["tableHeight"] = tableHeight;
		//支持mmGrig调节高度 @author jiangzhidong @date 20161229 end
		$.ajax({
			url :"<%=basePath%>rest/TableColumnService/updateSubAccountColumnByAdmin",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(obj),
			dataType : "json",
			success : function(data) {
				if (data&&data.statusCode == "-100") {
				     alert(data.message,3);
				 } else {
					 alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功' />");
					 parent.elsDeskTop.closeCurWin('subAccountColumnSetting',closeCallback());
				}
			},
			error : function(data) {
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	
	$("#saveDefaultBtn").click(function(){
		var templateCode = $("#tableSelector").val();
		if (templateCode == "system") {
			alert("<i18n:I18n key='i18n_columnsetting_noneedrecovery' defaultValue='已经是默认设置，不需要恢复' />",2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_columnsetting_confirmreset" defaultValue="确定要恢复默认设置吗？" />',closeEvent:function(){
			$.ajax({
				url :"<%=basePath%>rest/TableColumnService/setDefault/"+elsAccount+"/"+elsSubAccount+"/"+tableCode+"/"+templateCode,
				type :"get",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功' />");
					parent.elsDeskTop.closeCurWin('subAccountColumnSetting',closeCallback());
				},
				error : function(data) {
				    if (!permissionError(data)) {
				    	alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			    }
				}
			});
		}});
	});
	
	$("#deleteBtn").click(function(){
		var len = $("#tableSelector").find("option").length;
		if (len == 1) {
			alert("<i18n:I18n key='i18n_columnsetting_leaveoneplease' defaultValue='至少要保留一套模板' />",2);
			return;
		}
		var templateCode = $("#tableSelector").val();
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_columnsetting_confirmdelete" defaultValue="确定要删除当前模板吗？" />',closeEvent:function(){
			$.ajax({
				url :"<%=basePath%>rest/TableColumnService/deleteTemplate/"+elsAccount+"/"+elsSubAccount+"/"+tableCode+"/"+templateCode,
				type :"get",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					alert("操作成功");
					parent.elsDeskTop.closeCurWin('subAccountColumnSetting',closeCallback());
				},
				error : function(data) {
					if (!permissionError(data)) {
    				    alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			    }
				}
			});
		}});
	});
}
function initSelect(){
	$("#table-item").find("td").each(function(){
		var val = $(this).find(".showText").text();
		var selectObj = $(this).find("select");
		if(selectObj.length>0)
			selectObj.val(val);			
	});
}
function initCheckBox(){
	$("#table-item").find("td").each(function(){
		var hidden = $(this).find("input:hidden");
		var checkbox = $(this).find("input:checkbox");
		var val = hidden.val();
		if(val == "N")
			checkbox.attr("checked","checked");
		else
			checkbox.removeAttr("checked");	
		checkbox.click(function(){
			if(checkbox.attr("checked"))
				hidden.val("N");
			else
				hidden.val("Y");
		});
	});
}
function initUpDownBtn(){
    //上移 
    var $up = $(".up");
    $up.click(function() { 
        var $tr = $(this).parents("tr"); 
        if ($tr.index() != 0) { 
            $tr.prev().before($tr); 
        } 
    }); 
    //下移 
    var $down = $(".down"); 
    var len = $down.length; 
    $down.click(function() { 
        var $tr = $(this).parents("tr"); 
        if ($tr.index() != len - 1) { 
            $tr.next().after($tr); 
        } 
    }); 
}
function closeCallback() {
	if (fromWindow && parent.frames[fromWindow]) {
		parent.frames[fromWindow].location.reload();
	}
}
</script>
</body>
</html>