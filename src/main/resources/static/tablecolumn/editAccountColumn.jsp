<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_tableitemdetail" defaultValue="表格项明细" /></span>
			<div class="common-box-line">
				<main class="grid-container">
				<form id="form" onsubmit="return false;">
				<input type="hidden" id="elsAccount" name="elsAccount" />
				<input type="hidden" id="tableCode" name="tableCode" />
				<div class="edit-box-wrap">
					<button id="addBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="deleteBtn" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				</div>
				<div class="grid-100" id="accountColumnGrid">
					<table id="accountColumnTable"></table>
				</div>
				</form>
				</main>
			</div>
		</div>
	</div>
	
	
	<table id="blackRow" style="display:none">
	<tr class="itemRow">
		<td class="mmg1ed94-col0"><span class=""><input
				type="checkbox" class="mmg-check" ></span></td>
		<td class="mmg1ed94-col1" ><span class=""><span
				class="showText"></span><input
				name="accountColumnList[][elsAccount]" type="text"
				class="elsAccountInput" style="display: none; width: 85px;" value="#elsAccount" ></span></td>
		<td class="mmg1ed94-col2"  ><span class=""><span
				class="showText">#tableCode</span><input
				name="accountColumnList[][tableCode]" type="text"
				class="tableCodeInput" style="display: none; width: 165px;" value="#tableCode" ></span></td>
		<td class="mmg1ed94-col3"><span class=""><input
				name="accountColumnList[][columnCode]" type="text"
				class="columnCodeInput"  style="width: 165px;"
				value=""></span></td>
		<td class="mmg1ed94-col4"><span class=""><input
				name="accountColumnList[][columnName]" type="text"
				class="columnNameInput" style="width: 165px;"
				value=""></span></td>
		<td class="mmg1ed94-col5"><span class=""><input
				name="accountColumnList[][accountColumnName]" type="text"
				class="columnNameInput" style="width: 165px;"
				value=""></span></td>
		<td class="mmg1ed94-col6"><span class=""><input
				name="accountColumnList[][columnWidth]" type="text"
				class="columnWidthInput" value="7" style="width: 65px;"></span></td>
		<td class="mmg1ed94-col7"><span class=""><select
				name="accountColumnList[][columnAlign]" 
				style="width: 85px;"><option value="center"  selected="selected"><i18n:I18n key="i18n_label_center" defaultValue="居中" /></option>
					<option value="left"><i18n:I18n key="i18n_label_left" defaultValue="居左" /></option>
					<option value="right"><i18n:I18n key="i18n_label_right" defaultValue="居右" /></option></select></span></td>
		<td class="mmg1ed94-col8"><span class=""><select
				name="accountColumnList[][dataType]" class="dataTypeSelect"
				valattr="date" style="width: 125px;"><option
						value="string" selected="selected"><i18n:I18n key="i18n_label_stringtype" defaultValue="字符串类型" /></option>
					<option value="number"><i18n:I18n key="i18n_label_numbertype" defaultValue="数字类型" /></option>
					<option value="date" ><i18n:I18n key="i18n_label_datetype" defaultValue="日期类型" /></option>
					<option value="time"><i18n:I18n key="i18n_label_timetype" defaultValue="时间类型" /></option>
					<option value="dictionary"><i18n:I18n key="i18n_label_dictionarytype" defaultValue="字典类型" /></option>
			</select></span></td>
		<td class="mmg1ed94-col9"><span class=""><span
				class="showText"></span><input
				name="accountColumnList[][dataFormat]" type="text"
				class="columnNameInput" style="width: 165px;"
				value=""></span></td>
		<td class="mmg1ed94-col10"><span class=""><select
				name="accountColumnList[][canEdit]" valattr="N"
				style="width: 105px;"><option value="Y" selected=""><i18n:I18n key="i18n_label_canedit" defaultValue="可编辑" /></option>
				<option value="R" selected=""><i18n:I18n key="i18n_label_readonly" defaultValue="只读(隐藏域)" /></option>
					<option value="N" selected="selected"><i18n:I18n key="i18n_label_cantedit" defaultValue="不可编辑" /></option></select></span></td>
		<td class="mmg1ed94-col11"><span class=""><select
				name="accountColumnList[][isHidden]" valattr="N"
				style="width: 75px;"><option value="Y" selected=""><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
					<option value="N" selected="selected"><i18n:I18n key="i18n_common_no" defaultValue="否" /></option></select></span></td>
		<td class="mmg1ed94-col12"><span class=""><select
				name="accountColumnList[][canSort]" valattr="N"
				style="width: 75px;"><option value="Y" selected=""><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
					<option value="N" selected="selected"><i18n:I18n key="i18n_common_no" defaultValue="否" /></option></select></span></td>
		<td class="mmg1ed94-col13"><span class=""><select
				name="accountColumnList[][clickDisable]" valattr="N"
				style="width: 75px;"><option value="Y" selected=""><i18n:I18n key="i18n_common_yes" defaultValue="是" /></option>
					<option value="N" selected="selected"><i18n:I18n key="i18n_common_no" defaultValue="否" /></option></select></span></td>
		<td class="mmg1ed94-col14"><span class=""><span
				class="showText"><i18n:I18n key="i18n_label_custom" defaultValue="用户自定义" /></span><input
				name="accountColumnList[][isUserDefine]" type="text"
				class="isUserDefineInput" style="display: none; width: 165px;"
				value="Y"></span></td>
		<td class="mmg1ed94-col15"><span class=""><input
				name="accountColumnList[][sortOrder]" type="text"
				class="sortOrderInput" value="255" style="width: 65px;"></span></td>
		<td class="mmg1ed94-col16"><span class=""><input
				name="accountColumnList[][editPropertyCode]" type="text"
				class="editPropertyCodeInput" value="" style="width: 165px;"></span></td>
		<td class="mmg1ed94-col17"><span class=""><input
				name="accountColumnList[][renderer]" type="text"
				class="rendererInput" value="" style="width: 165px;"></span></td>
		<td class="mmg1ed94-col18"><span class=""><input
				name="accountColumnList[][toElsAccount]" type="text"
				class="rendererInput" value="" style="width: 165px;"></span></td>
	</tr>
	</table>
</body>
<script type="text/javascript">
	var tableCode=GetQueryString("tableCode");
	$("#elsAccount").val(elsAccount);
	$("#tableCode").val(tableCode);
	

	var height=$(document).height()-140;
	var itemCols = [
		        {title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="els账号" />', name:'elsAccount', hidden:true, width: 100, align: 'center', renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<span class='showText'>" + val + "</span>" + "<input name='accountColumnList[][elsAccount]' type='text' class='elsAccountInput' style='display:none' value='"+val+"'/>";
                 }},
		        { title:'<i18n:I18n key="i18n_label_tableCode" defaultValue="表格编码" />', name:'tableCode' ,width:180, align:'center' , renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<span class='showText'>" + val + "</span>" + "<input name='accountColumnList[][tableCode]' type='text' class='tableCodeInput' style='display:none' value='"+val+"'/>";
                 }},
		        { title:'<i18n:I18n key="i18n_label_columnCode" defaultValue="列编码" />', name:'columnCode' ,width:180, align:'center' , renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<span class='showText'>" + val + "</span>" + "<input name='accountColumnList[][columnCode]' type='text' class='columnCodeInput' style='display:none' value='"+val+"'/>";
                 }},
		        { title:'<i18n:I18n key="i18n_label_columnName" defaultValue="列名" />', name:'columnName' ,width:180, align:'center', renderer:function(val){
             	    if (!val) {val = "";}
            	    return  "<input name='accountColumnList[][columnName]' type='text' class='columnNameInput'  value='"+val+"'/>";
                 } },
                 { title:'<i18n:I18n key="i18n_label_accountColumnName" defaultValue="显示名" />', name:'accountColumnName' ,width:180, align:'center', renderer:function(val){
              	    if (!val) {val = "";}
             	    return  "<input name='accountColumnList[][accountColumnName]' type='text' class='columnNameInput'  value='"+val+"'/>";
                  } },
		        { title:'<i18n:I18n key="i18n_label_columnWidth" defaultValue="列宽" />', name:'columnWidth' ,width:80, align:'center',renderer:function(val){
					if (!val) {val = "";}
				    return  "<input  name='accountColumnList[][columnWidth]' type='text' class='columnWidthInput' value='"+val+"'/>";
				}},
		        { title:'<i18n:I18n key="i18n_label_columnAlign" defaultValue="对齐方式" />', name:'columnAlign' ,width:100, align:'center' ,renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='accountColumnList[][columnAlign]' valAttr='"+val+"'>"+
		        				"<option value='center' selected><i18n:I18n key='i18n_label_center' defaultValue='居中' /></option><option value='left' ><i18n:I18n key='i18n_label_left' defaultValue='居左' /></option><option value='right'><i18n:I18n key='i18n_label_right' defaultValue='居右' /></option></select>";
		        }},
		        { title:'<i18n:I18n key="i18n_label_datatype" defaultValue="数据类型" />', name:'dataType' ,width:140, align:'center',renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<span class='showText'></span><select name='accountColumnList[][dataType]' class='dataTypeSelect' style='display:none' valAttr='"+val+"' >"+
		        	"<option value='string' ><i18n:I18n key='i18n_label_stringtype' defaultValue='字符串类型' /></option> <option value='number' ><i18n:I18n key='i18n_label_numbertype' defaultValue='数字类型' /></option> <option value='date' ><i18n:I18n key='i18n_label_datetype' defaultValue='日期类型' /></option>"+
		        	"<option value='time' ><i18n:I18n key='i18n_label_timetype' defaultValue='时间类型' /></option> <option value='dictionary' ><i18n:I18n key='i18n_label_dictionarytype' defaultValue='字典类型' /></option> </select>";
		        }},
		        { title:'<i18n:I18n key="i18n_label_dataformat" defaultValue="数据格式化" />', name:'dataFormat' ,width:180, align:'center', renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<span class='showText'>" + val + "</span>" + "<input name='accountColumnList[][dataFormat]' type='text' class='dataFormat' style='display:none' value=''/>";
                 }},
		        { title:'<i18n:I18n key="i18n_label_whetheryoucanedit" defaultValue="是否可编辑" />', name:'canEdit' ,width:120, align:'center' , renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='accountColumnList[][canEdit]' valAttr='"+val+"'>"+
		        				"<option value='Y'><i18n:I18n key='i18n_label_canedit' defaultValue='可编辑' /></option><option value='R'><i18n:I18n key='i18n_label_readonly' defaultValue='只读(隐藏域)' /></option><option value='N'><i18n:I18n key='i18n_label_cantedit' defaultValue='不可编辑' /></option></select>";
		        }},
		        { title:'<i18n:I18n key="i18n_label_whethertohide" defaultValue="是否隐藏" />', name:'isHidden' ,width:90, align:'center', renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='accountColumnList[][isHidden]' valAttr='"+val+"'>"+
		        				"<option value='Y' selected><i18n:I18n key='i18n_common_yes' defaultValue='是' /></option><option value='N' ><i18n:I18n key='i18n_common_no' defaultValue='否' /></option></select>";
		        } },
		        { title:'<i18n:I18n key="i18n_label_whethertosort" defaultValue="是否可排序" />', name:'canSort' ,width:90, align:'center' , renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='accountColumnList[][canSort]' valAttr='"+val+"'>"+
		        				"<option value='Y' selected><i18n:I18n key='i18n_common_yes' defaultValue='是' /></option><option value='N' ><i18n:I18n key='i18n_common_no' defaultValue='否' /></option></select>";
		        } },
		        { title:'<i18n:I18n key="i18n_label_disableclickselected" defaultValue="是否禁用点击选中" />', name:'clickDisable' ,width:90, align:'center' , renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='tableColumnList[][clickDisable]' valAttr='"+val+"'>"+
		        				"<option value='Y' selected><i18n:I18n key='i18n_common_yes' defaultValue='是' /></option><option value='N' ><i18n:I18n key='i18n_common_no' defaultValue='否' /></option></select>";
		        } },
		        { title:'<i18n:I18n key="i18n_label_userdefined" defaultValue="是否用户自定义" />', name:'isUserDefine' ,width:120, align:'center' , renderer:function(key){
		        	var val=key;
		        		if(val=="Y"){
			        		val= '<i18n:I18n key="i18n_label_custom" defaultValue="自定义" />';
			        	}else{
			        		val= '<i18n:I18n key="i18n_label_systemdefinition" defaultValue="系统定义" />';
			        	}
	            	    return "<span class='showText'>" + val + "</span>" + "<input name='accountColumnList[][isUserDefine]' type='text' class='isUserDefineInput' style='display:none' value='"+key+"'/>";
		        } },
		        { title:'<i18n:I18n key="i18n_label_sort" defaultValue="排序" />', name:'sortOrder' ,width:80, align:'center' , renderer:function(val){
		        	if (!val) {val = "";}
        	    	return  "<input name='accountColumnList[][sortOrder]' type='text' class='sortOrderInput' value='"+val+"'/>";
		        }},
		        { title:'<i18n:I18n key="i18n_label_editfieldname" defaultValue="编辑字段名" />', name:'editPropertyCode' ,width:180, align:'center', renderer:function(val){
		        	if (!val) {val = "";}
         	   		 return  "<input name='accountColumnList[][editPropertyCode]' type='text' class='editPropertyCodeInput' value='"+val+"'/>";
		        }},
		        { title:'<i18n:I18n key="i18n_label_renderer" defaultValue="渲染器" />', name:'renderer' ,width:180, align:'center' , hidden:true, renderer:function(val){
		        	if (!val) {val = "";}
         	    	return "</span>" +"<input name='accountColumnList[][renderer]' type='text' class='rendererInput' value=''/>";
		        }}];

	var blackRow=$("#blackRow").find("tbody").html();
	blackRow=blackRow.replace("#elsAccount",elsAccount);
	blackRow=blackRow.replace("#tableCode",tableCode);
	blackRow=blackRow.replace("#tableCode",tableCode);
	
	//添加
	$("#addBtn").click(function(){
		if($("#accountColumnTable").find(".emptyRow").length>0){
			$("#accountColumnTable").find("tbody").html("");
		}
		$("#accountColumnTable").find("tbody").append(blackRow);
		var currentClass=$(".mmg-head").find("thead tr:first-child").find("th").eq(2).attr("class");
		var tempStr=currentClass.substring(0,currentClass.length-2);
		$(".itemRow").find("td").each(function(){
			var className=$(this).attr("class");
			$(this).attr("class",className.replace("mmg1ed94-col",tempStr));
		});
		$(".mmg-message").css("display","none");
		
	});
	
	
	//删除
	$("#deleteBtn").click(function(){
		var trItem=$("#accountColumnTable").find(".selected");
		
		if(trItem.length<=0){
			 alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
			return;
		}
		var isUserDefine=trItem.find(".isUserDefineInput").val();
		console.log(isUserDefine);
		if(isUserDefine!="Y"){
			alert('<i18n:I18n key="i18n_label_systemdefaultcannotbedeleted" defaultValue="系统默认项不能删除！" />',2);
			return;
		}
		trItem.remove();
		
		var rowCount=$("#accountColumnTable").find("tr").length;
		if(rowCount<=0){
			$(".mmg-message").css("display","block");
			
		}
	});
	
	
	function insertAccountColunmTable(){
		$('#accountColumnGrid').html('<table id="accountColumnTable"></table><div id="pg" style="text-align: right;"></div>');
		var paramStr = '{"elsAccount":"'+elsAccount+'","tableCode":"'+tableCode+'"}';
		$.ajax({
			url :"<%=basePath%>rest/TableColumnService/getAccountColumnList",
			type : "post",
			dataType : "json",
			contentType : "application/json",
			data : paramStr,
			success : function(data) {
				var itemGrid=$('#accountColumnTable').mmGrid({
					cols : itemCols,
					items : data,
					height:height,
					checkCol : true,
					loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
					noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
				});
				itemGrid.on('loadSuccess', function(e, dat) {
					init(data);
				});
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',3);
			}
		});
	}
	
	//初始化下拉框
	function init(data){
		var index=0;
		$("#accountColumnTable").find("tr").each(function(){
			$(this).find(".rendererInput").val(data[index].renderer);
			$(this).find(".dataFormat").val(data[index].dataFormat);
			index++;
		});
		
		$("#accountColumnTable").find("td").each(function(){
			$(this).find("input").not(":checkbox").css("width",$(this).width()-15);
			$(this).find("select").css("width",$(this).width()-15);
			var selectObj=$(this).find("select");
			if(selectObj.length>0){
				var val=selectObj.attr("valAttr");
				var idName=selectObj.attr("class");
				selectObj.find("option[value='"+val+"']").attr("selected",true);
			}
			
			var status=$(this).parent().find(".isUserDefineInput").val();
			if(status=="Y"){//如果是是自定义列
				var className=$(this).find("input").attr("class");
				if(className!="isUserDefineInput" && className!="tableCodeInput"){
					$(this).find(".showText").remove();
					$(this).find("input").css("display","");	
					$(this).find("select").css("display","");	
				}
			}else{
				var className=selectObj.attr("class");
				if(className=="dataTypeSelect"){
					var val=selectObj.attr("valAttr");
					selectObj.prev(".showText").html(selectObj.find("option[value='"+val+"']").html());
				}
			}
		});
	}
	
	insertAccountColunmTable();
	
	//保存
	$("#saveBtn").click(function(){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
		var url = "<%=basePath%>rest/TableColumnService/updateAccountColumn";
		var frm = $("#form");
		$.ajax({
			url :url,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',3);
			}
		});
		}});
	});
	
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('editAccountColumn',closeCallback);
	});
	
	function closeCallback() {
			if (parent.frames["iframeApp_accountColumnManage"]) {
				parent.frames["iframeApp_accountColumnManage"].insertAccountColunmTable();
			}
	}
</script>
</html>