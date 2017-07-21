<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
     <form id="addFieldDictionaryFrom" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="基础信息"/></span>
            <div class="common-box-line">
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n key="" defaultValue="表名"/>:&nbsp;
			       <select id="tableName" name="tableName"></select>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <i18n:I18n key="" defaultValue="字段名" />:&nbsp;
			       <span id="fieldNameType"><select id="fieldName" name="fieldName"></select></span>
			       <span style="color: red">*</span>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n key="" defaultValue="字段描述" />:&nbsp;
			       <input id="fieldText" name="fieldText" type="text">
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n key="" defaultValue="字段类型" />:&nbsp;
			       <input id="fieldType" name="fieldType" type="text">
		        </div>
		        <div class="dis-in-b input-and-tip">
			       &nbsp;&nbsp;<i18n:I18n key="" defaultValue="权限组" />:&nbsp;
			       <input id="authorityGroup" name="authorityGroup" type="text">
		        </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
		        <div class="dis-in-b input-and-tip">
                     <button id="addValue" class="button-wrap" ><i18n:I18n key="" defaultValue="新增" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="saveValue" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteValue" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <input type="hidden" id="elsAccount" name="elsAccount">
            <input type="hidden" id="elsDesc" name="elsDesc">
            <input type="hidden" id="pageSize" name="pageSize" value="10">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-item-info"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
     </form>
</div>


<script>
var itemGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsDesc ='<%=session.getAttribute("companyShortName")%>';

$().ready(function(){
	init();
	/* window.beforeClose = function(close){
	    top.elsDeskTop.tip.init({
	        type            : 'confirm',
	        displayType     : 2, 
	        message         : '<i18n:I18n key="i18n_common_alert_confirmTheShutDown" defaultValue="确认关闭" />?',
	        closeEvent : function () {
	           close();
	        }
	    });
	};  */
});	

var itemCols = [
                           { title:'<i18n:I18n key="" defaultValue="ELS账号" />', name:'elsAccount' ,width:120, align:'center',renderer:function(val){
                              return val+"<input name='dictionaryVOs[][elsAccount]' style='display:none;'  type='text' value='"+val+"'/>";
                             }},
	                       { title:'<i18n:I18n key="" defaultValue="字段值" />', name:'fieldValue' ,width:200, align:'center',renderer:function(val){
	           				  return "<input name='dictionaryVOs[][fieldValue]'   type='text' value='"+val+"'/>";
           			       }},
           			       { title:'<i18n:I18n key="" defaultValue="值描述" />', name:'fieldValueText' ,width:200, align:'center',renderer:function(val){
	           				  return "<input name='dictionaryVOs[][fieldValueText]'   type='text' value='"+val+"'/>";
         			       }},
         			       { title:'<i18n:I18n key="" defaultValue="国家" />', name:'country' ,width:200, align:'center',renderer:function(val){
	           				  return "<input name='dictionaryVOs[][country]'   type='text' value='"+val+"'/>";
           			       }},
           			       { title:'<i18n:I18n key="" defaultValue="语言" />', name:'language' ,width:200, align:'center',renderer:function(val){
	           				  return val+"<input name='dictionaryVOs[][language]' style='display:none;'  type='text' value='"+val+"'/>";
         			       }}
                    ];

function init(){
	$("#elsAccount").val(elsAccount);
	$("#elsDesc").val(elsDesc);
	
	$.ajax({
		url : "<%=basePath%>rest/ElsSearchDictionaryService/getAllTable",
		type : "POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify({"elsAccount":elsAccount}),
		success : function(data) {
			var tableName = $("#tableName");
			tableName.append($("<option>").text("不限定表").val(""));
			for (var i = 0; i < data.length; i++) {
				var option = $("<option>").text(data[i]).val(data[i])
				tableName.append(option);
			}
			tableName.change();
		}
	});
	
    itemGrid=$('#table-item-info').mmGrid({
	    cols: itemCols,
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    checkCol:true,
	    multiSelect:true
	});
} 

$("#tableName").change(function(){
	var tableName = $(this).val();
	if(tableName == ""){
		var fieldName = $("#fieldName option:selected").text();
		$("#fieldNameType").html('<input id="fieldName" name="fieldName" type="text">');
		$("#fieldName").val(fieldName);
	}else{
		$("#fieldNameType").html('<select id="fieldName" name="fieldName"></select>');
		$.ajax({
			url : "<%=basePath%>rest/ElsSearchDictionaryService/getFieldPropertyByTableName",
			type : "POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"tableName":tableName}),
			success : function(data) {
				var dictionaryVOs = data.dictionaryVOs;
				var fieldNameSel = $("#fieldName");
				fieldNameSel.empty();
				for(var i = 0; i < dictionaryVOs.length; i++){
					var vo = dictionaryVOs[i];
					var fieldName = vo.fieldName;
					var fieldType = vo.fieldType;
					var fieldText = vo.fieldText;
					var option = $("<option>").text(fieldName).val(fieldType+"_&_#"+fieldText);
					fieldNameSel.append(option);
				}
				fieldNameSel.change();
			}
		});
	}
});

$('#fieldName').live("change", function() {
	var text = $(this).val();
	var textArray = text.split("_&_#");
	var fieldType = textArray[0];
	var fieldText = textArray[1];
	$("#fieldType").val(fieldType);
	$("#fieldText").val(fieldText);
});

$("#addValue").click(function(){
	var item = {
			"elsAccount":elsAccount,
			"fieldValue":"",
			"fieldValueText":"",
			"country":"",
			"language":language
	};
	itemGrid.addRow(item);
});

$("#deleteValue").click(function(){
	var indexs = itemGrid.selectedRowsIndex();
	if(indexs.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	itemGrid.removeRow(indexs);
});

$("#saveValue").click(function(){
	debugger;
	var frm = $("#addFieldDictionaryFrom");
	var frmObj = frm.serializeJSON();
	var fieldName = $("#fieldName option:selected").text();
	if(fieldName&&fieldName != ""){
		frmObj["fieldName"]=fieldName;
	}
	var dictionaryVOs = frmObj.dictionaryVOs;
	if(!dictionaryVOs){
		alert("至少添加一条数据",2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认保存?" key=""/>',closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/ElsSearchDictionaryService/addField",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(frmObj),
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,3);
				}else{
					alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
					parent.frames['iframeApp_searchDictionaryManage'].refreshData();
				    parent.elsDeskTop.closeCurWin('addFieldDictionary');
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(exception,3); 
	        }
	  });
	}});
});


</script>

</body>
</html>
