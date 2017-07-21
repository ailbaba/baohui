<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
			<form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/TableColumnService/getAllTable">
			    <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_tableCode" defaultValue="表格编码" />： </span><input type="text" name="tableCode"/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_tableName" defaultValue="表格名称" />： </span><input type="text" name="tableName"/></div>
				<button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				<button class="button-wrap" id="clearBtn"><i18n:I18n key="i18n_label_clearcache" defaultValue="清除缓存" /></button>
				<button class="button-wrap" id="editBtn"><i18n:I18n key="i18n_label_edit" defaultValue="修改" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</form>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_customtableentry" defaultValue="自定义表格项" /></span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100" id="tableGrid">
					<table id="tableTable"></table>
					<div id="pg" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_tableitemdetail" defaultValue="表格项明细" /></span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100" id="accountColumnGrid">
					<table id="accountColumnTable"></table>
				</div>
				</main>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
<script type="text/javascript">
	
	var headGrid;
	var tableCode;
	//插入自定义表格项
	function insertTable(){
		$('#tableGrid').html('<table id="tableTable"></table><div id="pg" style="text-align: right;"></div>');
		 var cols = [
				        {title:'<i18n:I18n key="i18n_label_tableCode" defaultValue="表格编码" />', name:'tableCode', width: 200, align: 'center'},
				        { title:'<i18n:I18n key="i18n_label_tableName" defaultValue="表格名称" />', name:'tableName' ,width:200, align:'center' },
				        { title:'<i18n:I18n key="i18n_label_desc" defaultValue="表格描述" />', name:'tableDesc' ,width:400, align:'center'}];
	
	    //本地示例
	      var frm = $("#queryForm");
	      headGrid= $('#tableTable').mmGrid({
	    	 cols: cols,
	         url: frm[0].action,
	         params: frm.serializeJSON(),
	         method:  frm[0].method,
								root : "rows",
								loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
								noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
								checkCol : true,
								plugins : [ $('#pg').mmPaginator({
									style : 'plain',
									totalCountName : 'total',
									page : 1,
									pageParamName : 'currentPage',
									limitParamName : 'pageSize',
									limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />',
							        totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />',
									limit : null,
									limitList : [ 10, 20 ]
								}) ]
							});
	
			headGrid.on('loadSuccess', function(e, data) {
				headGrid.select(0);
				tableCode= data.rows[0].tableCode;
				insertAccountColunmTable();
			});
			
			 headGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
				 	tableCode=item.tableCode;
			    	insertAccountColunmTable();
			     });
	}
	
	insertTable();
	
	var itemCols = [
		        {title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="els账号" />', name:'elsAccount', hidden:true, width: 100, align: 'center'},
		        { title:'<i18n:I18n key="i18n_label_tableCode" defaultValue="表格编码" />', name:'tableCode' ,width:180, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_columnCode" defaultValue="列编码" />', name:'columnCode' ,width:180, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_columnName" defaultValue="列名" />', name:'columnName' ,width:180, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_columnWidth" defaultValue="列宽" />', name:'columnWidth' ,width:100, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_columnAlign" defaultValue="对齐方式" />', name:'columnAlign' ,width:100, align:'center' ,renderer:function(val){
		        	if(val=="center"){
		        		return '<i18n:I18n key="i18n_label_center" defaultValue="居中" />';
		        	}else if(val=="left"){
		        		return '<i18n:I18n key="i18n_label_left" defaultValue="居左" />';
		        	}else if(val=="right"){
		        		return '<i18n:I18n key="i18n_label_right" defaultValue="居右" />';
		        	}
		        }},
		        { title:'<i18n:I18n key="i18n_label_datatype" defaultValue="数据类型" />', name:'dataType' ,width:120, align:'center',renderer:function(val){
		        	if(val=="string"){
		        		return '<i18n:I18n key="i18n_label_stringtype" defaultValue="字符串类型" />';
		        	}else if(val=="number"){
		        		return '<i18n:I18n key="i18n_label_numbertype" defaultValue="数字类型" />';
		        	}else if(val=="date"){
		        		return '<i18n:I18n key="i18n_label_datetype" defaultValue="日期类型" />';
		        	}else if(val=="time"){
		        		return '<i18n:I18n key="i18n_label_timetype" defaultValue="时间类型" />';
		        	}else if(val=="dictionary"){
		        		return '<i18n:I18n key="i18n_label_dictionarytype" defaultValue="字典类型" />';
		        	}
		        } },
		        { title:'<i18n:I18n key="i18n_label_dataformat" defaultValue="数据格式化" />', name:'dataFormat' ,width:180, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_whetheryoucanedit" defaultValue="是否可编辑" />', name:'canEdit' ,width:80, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_whethertohide" defaultValue="是否隐藏" />', name:'isHidden' ,width:80, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_whethertosort" defaultValue="是否可排序" />', name:'canSort' ,width:80, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_userdefined" defaultValue="是否用户自定义" />', name:'isUserDefine' ,width:110, align:'center' ,renderer:function(val){
		        	if(val=="Y"){
		        		return '<i18n:I18n key="i18n_label_custom" defaultValue="自定义" />';
		        	}else {
			        	return '<i18n:I18n key="i18n_label_systemdefinition" defaultValue="系统定义" />';
		        	}
		        } },
		        { title:'<i18n:I18n key="i18n_label_sort" defaultValue="排序" />', name:'sortOrder' ,width:80, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_editfieldname" defaultValue="编辑字段名" />', name:'editPropertyCode' ,width:180, align:'center' },
		        { title:'<i18n:I18n key="i18n_label_renderer" defaultValue="渲染器" />', name:'renderer' ,hidden:true, width:180, align:'center' }];
	
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
				$('#accountColumnTable').mmGrid({
					cols : itemCols,
					items : data,
					loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
					noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
				});
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',3);
			}
		});
	}
	
	//修改
	$("#editBtn").click(function(){
		var selectedIndexs=headGrid.selectedRowsIndex();
		if(selectedIndexs.length<=0){
			 alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
			return;
		}
		var tableCode=headGrid.row(selectedIndexs[0]).tableCode;
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editAccountColumn',
	        'windowTitle':'<i18n:I18n key="i18n_label_modifycustomtablecolumns" defaultValue="修改自定义表格列" />',
	        windowSubTitle: companyShortName,
	        'iframSrc':'<%=basePath%>tablecolumn/editAccountColumn.jsp?tableCode=' +tableCode ,
	        'windowWidth':1060,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('accountColumnManage',closeCallback);
	});
    $("#queryBtn").click(function(){
    	query();
    });
    $("#clearBtn").click(function(){
    	$.ajax({
			url :"<%=basePath%>rest/TableColumnService/clearAccountColumnCache/"+elsAccount,
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',3);
			}
		});
    });
	function closeCallback() {
//			if (parent.frames["iframeApp_queryReceipt"]) {
//				parent.frames["iframeApp_queryReceipt"].insertMaterialVoucherHeaderTable();
//			}
	}
	function query() {
		var frm = $("#queryForm");
		headGrid.opts.params = frm.serializeJSON();
		headGrid.load({});
	}
</script>
</html>