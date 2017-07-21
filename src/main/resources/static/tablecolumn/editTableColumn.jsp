<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
			<div class="common-box-line">
				<button class="button-wrap" id="saveBtn">保存</button>
				<button id="tableSyncBtn" class="button-wrap">全表同步</button>
				<button id="exitBtn" class="button-wrap">退出</button>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">表格项明细</span>
			<div class="common-box-line">
				<main class="grid-container">
				<form id="form" onsubmit="return false;">
				<input type="hidden" id="elsAccount" name="elsAccount" />
				<input type="hidden" id="tableCode" name="tableCode" />
				<div class="edit-box-wrap">
					<button id="addBtn" class="button-wrap">添加</button>
					<button id="deleteBtn" class="button-wrap">删除</button>
					<button id="syncBtn" class="button-wrap">列同步</button>
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
		<td class="mmg1ed94-col2"  ><span class=""><span
				class="showText">#tableCode</span><input
				name="tableColumnList[][tableCode]" type="text"
				class="tableCodeInput" style="display: none; width: 165px;" value="#tableCode" ></span></td>
		<td class="mmg1ed94-col3"><span class=""><input
				name="tableColumnList[][columnCode]" type="text"
				class="columnCodeInput"  style="width: 165px;"
				value=""></span></td>
		<td class="mmg1ed94-col4"><span class=""><input
				name="tableColumnList[][columnName]" type="text"
				class="columnNameInput" style="width: 165px;"
				value=""></span></td>
		<td class="mmg1ed94-col5"><span class=""><input
				name="tableColumnList[][columnWidth]" type="text"
				class="columnWidthInput" value="7" style="width: 65px;"></span></td>
		<td class="mmg1ed94-col6"><span class=""><select
				name="tableColumnList[][columnAlign]" 
				style="width: 85px;"><option value="center"  selected="selected">居中</option>
					<option value="left">居左</option>
					<option value="right">居右</option></select></span></td>
		<td class="mmg1ed94-col7"><span class=""><select
				name="tableColumnList[][dataType]" class="dataTypeSelect"
				valattr="date" style="width: 125px;"><option
						value="string" selected="selected">字符串类型</option>
					<option value="number">数字类型</option>
					<option value="date" >日期类型</option>
					<option value="time">时间类型</option>
					<option value="dictionary">字典类型</option>
			</select></span></td>
		<td class="mmg1ed94-col8"><span class=""><span
				class="showText"></span><input
				name="tableColumnList[][dataFormat]" type="text"
				class="columnNameInput" style="width: 165px;"
				value=""></span></td>
		<td class="mmg1ed94-col9"><span class=""><select
				name="tableColumnList[][canEdit]" valattr="N"
				style="width: 105px;"><option value="Y" selected="">可编辑</option>
				<option value="R" selected="">只读(隐藏域)</option>
					<option value="N" selected="selected">不可编辑</option></select></span></td>
		<td class="mmg1ed94-col10"><span class=""><select
				name="tableColumnList[][isHidden]" valattr="N"
				style="width: 75px;"><option value="Y" selected="">是</option>
					<option value="N" selected="selected">否</option></select></span></td>
		<td class="mmg1ed94-col11"><span class=""><select
				name="tableColumnList[][canSort]" valattr="N"
				style="width: 75px;"><option value="Y" selected="">是</option>
					<option value="N" selected="selected">否</option></select></span></td>
		<td class="mmg1ed94-col12"><span class=""><select
				name="tableColumnList[][clickDisable]" valattr="N"
				style="width: 75px;"><option value="Y" selected="">是</option>
					<option value="N" selected="selected">否</option></select></span></td>
		<td class="mmg1ed94-col13"><span class=""><span
				class="showText">系统默认</span><input
				name="tableColumnList[][isUserDefine]" type="text"
				class="isUserDefineInput" style="display: none; width: 165px;"
				value="N"></span></td>
		<td class="mmg1ed94-col14"><span class=""><input
				name="tableColumnList[][sortOrder]" type="text"
				class="sortOrderInput" value="255" style="width: 65px;"></span></td>
		<td class="mmg1ed94-col15"><span class=""><input
				name="tableColumnList[][editPropertyCode]" type="text"
				class="editPropertyCodeInput" value="" style="width: 165px;"></span></td>
		<td class="mmg1ed94-col16"><span class=""><input
				name="tableColumnList[][renderer]" type="text"
				class="rendererInput" value="" style="width: 165px;"></span></td>
	</tr>
	</table>
</body>
<script type="text/javascript">
	var tableCode=GetQueryString("tableCode");
	$("#elsAccount").val(elsAccount);
	$("#tableCode").val(tableCode);
	
	var itemGrid;
	var height=$(document).height()-140;
	var itemCols = [
		        {title:'els账号', name:'elsAccount', hidden:true, width: 100, align: 'center', renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<span class='showText'>" + val + "</span>" + "<input name='tableColumnList[][elsAccount]' type='text' class='elsAccountInput' style='display:none' value='"+val+"'/>";
                 }},
		        { title:'表格编码', name:'tableCode' ,width:180, align:'center' , renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<span class='showText'>" + val + "</span>" + "<input name='tableColumnList[][tableCode]' type='text' class='tableCodeInput' style='display:none' value='"+val+"'/>";
                 }},
		        { title:'列编码', name:'columnCode' ,width:180, align:'center' , renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<input name='tableColumnList[][columnCode]' type='text' class='columnCodeInput'  value='"+val+"'/>";
                 }},
		        { title:'列名', name:'columnName' ,width:180, align:'center', renderer:function(val){
             	    if (!val) {val = "";}
            	    return  "<input name='tableColumnList[][columnName]' type='text' class='columnNameInput'  value='"+val+"'/>";
                 } },
		        { title:'列宽', name:'columnWidth' ,width:80, align:'center',renderer:function(val){
					if (!val) {val = "";}
				    return  "<input  name='tableColumnList[][columnWidth]' type='text' class='columnWidthInput' value='"+val+"'/>";
				}},
		        { title:'对齐方式', name:'columnAlign' ,width:100, align:'center' ,renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='tableColumnList[][columnAlign]' valAttr='"+val+"'>"+
		        				"<option value='center' selected>居中</option><option value='left' >居左</option><option value='right'>居右</option></select>";
		        }},
		        { title:'数据类型', name:'dataType' ,width:140, align:'center',renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='tableColumnList[][dataType]' class='dataTypeSelect' valAttr='"+val+"' >"+
		        	"<option value='string' >字符串类型</option> <option value='number' >数字类型</option> <option value='date' >日期类型</option>"+
		        	"<option value='time' >时间类型</option> <option value='dictionary' >字典类型</option> </select>";
		        }},
		        { title:'数据格式化', name:'dataFormat' ,width:180, align:'center', renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<input name='tableColumnList[][dataFormat]' type='text' class='dataFormat'  value=''/>";
                 }},
		        { title:'是否可编辑', name:'canEdit' ,width:120, align:'center' , renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='tableColumnList[][canEdit]' valAttr='"+val+"'>"+
    				"<option value='Y'>可编辑</option><option value='R'>只读(隐藏域)</option><option value='N'>不可编辑</option></select>";
		        }},
		        { title:'是否隐藏', name:'isHidden' ,width:90, align:'center', renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='tableColumnList[][isHidden]' valAttr='"+val+"'>"+
		        				"<option value='Y' selected>是</option><option value='N' >否</option></select>";
		        } },
		        { title:'是否可排序', name:'canSort' ,width:90, align:'center' , renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='tableColumnList[][canSort]' valAttr='"+val+"'>"+
		        				"<option value='Y' selected>是</option><option value='N' >否</option></select>";
		        } },
		        { title:'是否禁用点击选中', name:'clickDisable' ,width:90, align:'center' , renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='tableColumnList[][clickDisable]' valAttr='"+val+"'>"+
		        				"<option value='Y' selected>是</option><option value='N' >否</option></select>";
		        } },
		        { title:'是否用户自定义', name:'isUserDefine' ,width:120, align:'center' , renderer:function(key){
		        	var val=key;
		        		if(val=="Y"){
			        		val= "自定义";
			        	}else{
			        		val= "系统默认";
			        	}
	            	    return "<span class='showText'>" + val + "</span>" + "<input name='tableColumnList[][isUserDefine]' type='text' class='isUserDefineInput' style='display:none' value='"+key+"'/>";
		        } },
		        { title:'排序', name:'sortOrder' ,width:80, align:'center' , renderer:function(val){
		        	if (!val) {val = "";}
        	    	return  "<input name='tableColumnList[][sortOrder]' type='text' class='sortOrderInput' value='"+val+"'/>";
		        }},
		        { title:'编辑字段名', name:'editPropertyCode' ,width:180, align:'center', renderer:function(val){
		        	if (!val) {val = "";}
         	   		 return  "<input name='tableColumnList[][editPropertyCode]' type='text' class='editPropertyCodeInput' value='"+val+"'/>";
		        }},
		        { title:'渲染器', name:'renderer' ,width:180, align:'center' ,renderer:function(val){
		        	if (!val) {val = "";}
         	    	return "</span>" +"<input name='tableColumnList[][renderer]' type='text' class='rendererInput' value=''/>";
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
	
	//同步
	$("#syncBtn").click(function(){
		var rows = itemGrid.selectedRows();
		if (rows.length == 0) {
			alert("请选择操作项",2);
			return;
		}
		var columnCodes="";
		for(var i=0;i<rows.length;i++){
			columnCodes+=rows[i].columnCode+",";
		}
		columnCodes=columnCodes.substring(0,columnCodes.length-1);
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/TableColumnService/syncTableColumn/" + tableCode + "/" + columnCodes,
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("同步成功");
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("系统异常",3);
			}
		});
	});
	$("#tableSyncBtn").click(function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/TableColumnService/syncTable/" + tableCode,
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("同步成功");
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("系统异常",3);
			}
		});
	});
	//删除
	$("#deleteBtn").click(function(){
		var trItem=$("#accountColumnTable").find(".selected");
		if(trItem.length<=0){
			alert("请选择操作项！",2);
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
			url :"<%=basePath%>rest/TableColumnService/getTableColumnList",
			type : "post",
			dataType : "json",
			contentType : "application/json",
			data : paramStr,
			success : function(data) {
				itemGrid=$('#accountColumnTable').mmGrid({
					cols : itemCols,
					items : data,
					height:height,
					 multiSelect: true,
					checkCol : true,
					loadingText : '正在载入',
					noDataText : '暂无数据',
				});
				itemGrid.on('loadSuccess', function(e, dat) {
					init(data);
				});
			},
			error : function(data) {
				alert("系统异常",3);
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
		});
	}
	
	insertAccountColunmTable();
	
	//保存
	$("#saveBtn").click(function(){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认保存？',closeEvent:function(){
		var url = "<%=basePath%>rest/TableColumnService/updateTableColumn";
		var frm = $("#form");
		$.ajax({
			url :url,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				alert("保存成功！");
			},
			error : function(data) {
				alert("系统异常",3);
			}
		});
		}});
	});
	
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('editTableColumn',closeCallback);
	});
	
	function closeCallback() {
			if (parent.frames["iframeApp_tableColumnManage"]) {
				parent.frames["iframeApp_tableColumnManage"].insertAccountColunmTable();
			}
	}
</script>
</html>