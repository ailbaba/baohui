<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
			<div class="common-box-line">
			<form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/TableColumnService/getAllTable">
			    <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72">表格编码： </span><input type="text" name="tableCode"/></div>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72">表格名称： </span><input type="text" name="tableName"/></div>
				<button class="button-wrap" id="queryBtn">查询</button>
				<button class="button-wrap" id="clearBtn">清除缓存</button>
				<button class="button-wrap" id="editBtn">修改</button>
				<button id="exitBtn" class="button-wrap">退出</button>
			</form>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">自定义表格项</span>
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
			<span class="dis-in-b pos-absolute box-tip bg-common">表格项明细</span>
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
		 var cols = [ {title:'表格编码', name:'tableCode', width: 200, align: 'center'},
				      { title:'表格名称', name:'tableName' ,width:200, align:'center' },
				      { title:'表格描述', name:'tableDesc' ,width:400, align:'center'},
				      { title:'表格宽度/高度', name:'extendFields' ,width:250, align:'center' }];
	
	    //本地示例
	      var frm = $("#queryForm");
	      headGrid= $('#tableTable').mmGrid({
	    	 cols: cols,
	         url: frm[0].action,
	         params: frm.serializeJSON(),
	         method:  frm[0].method,
								root : "rows",
								loadingText : '正在载入',
								noDataText : '暂无数据',
								checkCol : true,
								plugins : [ $('#pg').mmPaginator({
									style : 'plain',
									totalCountName : 'total',
									page : 1,
									pageParamName : 'currentPage',
									limitParamName : 'pageSize',
									limitLabel : '每页{0}条',
									totalCountLabel : '共<span>{0}</span>条记录',
									limit : null,
									limitList : [ 10, 20 ]
								}) ]
							});
	
			headGrid.on('loadSuccess', function(e, data) {
				if(data.rows&&data.rows.length>0){
					headGrid.select(0);
					tableCode= data.rows[0].tableCode;
					insertAccountColunmTable();
				}
			});
			
			 headGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
				 	tableCode=item.tableCode;
			    	insertAccountColunmTable();
			     });
	}
	
	insertTable();
	
	var itemCols = [
		        {title:'els账号', name:'elsAccount', hidden:true, width: 100, align: 'center'},
		        { title:'表格编码', name:'tableCode' ,width:180, align:'center' },
		        { title:'列编码', name:'columnCode' ,width:180, align:'center' },
		        { title:'列名', name:'columnName' ,width:180, align:'center' },
		        { title:'列宽', name:'columnWidth' ,width:100, align:'center' },
		        { title:'对齐方式', name:'columnAlign' ,width:100, align:'center' ,renderer:function(val){
		        	if(val=="center"){
		        		return "居中";
		        	}else if(val=="left"){
		        		return "居左";
		        	}else if(val=="right"){
		        		return "居右";
		        	}
		        }},
		        { title:'数据类型', name:'dataType' ,width:120, align:'center',renderer:function(val){
		        	if(val=="string"){
		        		return "字符串类型";
		        	}else if(val=="number"){
		        		return "数字类型";
		        	}else if(val=="date"){
		        		return "日期类型";
		        	}else if(val=="time"){
		        		return "时间类型";
		        	}else if(val=="dictionary"){
		        		return "字典类型";
		        	}
		        } },
		        { title:'数据格式化', name:'dataFormat' ,width:180, align:'center' },
		        { title:'是否可编辑', name:'canEdit' ,width:80, align:'center' },
		        { title:'是否隐藏', name:'isHidden' ,width:80, align:'center' },
		        { title:'是否可排序', name:'canSort' ,width:80, align:'center' },
		        { title:'是否用户自定义', name:'isUserDefine' ,width:110, align:'center' ,renderer:function(val){
		        	if(val=="Y"){
		        		return "自定义";
		        	}else {
			        	return "系统默认";
		        	}
		        } },
		        { title:'排序', name:'sortOrder' ,width:80, align:'center' },
		        { title:'编辑字段名', name:'editPropertyCode' ,width:180, align:'center' },
		        { title:'渲染器', name:'renderer' , width:180, align:'center' }];
	
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
				$('#accountColumnTable').mmGrid({
					cols : itemCols,
					items : data,
					loadingText : '正在载入',
					noDataText : '暂无数据',
				});
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}
	
	//修改
	$("#editBtn").click(function(){
		var selectedIndexs=headGrid.selectedRowsIndex();
		if(selectedIndexs.length<=0){
			alert("请选择要修改的项！",2);
			return;
		}
		var tableCode=headGrid.row(selectedIndexs[0]).tableCode;
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editTableColumn',
	        'windowTitle':'修改自定义表格列',
	        windowSubTitle: companyShortName,
	        'iframSrc':'<%=basePath%>tablecolumn/editTableColumn.jsp?tableCode=' +tableCode ,
	        'windowWidth':1060,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('tableColumnManage',closeCallback);
	});
    $("#queryBtn").click(function(){
    	query();
    });
    $("#clearBtn").click(function(){
    	$.ajax({
			url :"<%=basePath%>rest/TableColumnService/clearTableColumnCache",
			type : "get",
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				alert("操作成功");
			},
			error : function(data) {
				alert("系统异常",3);
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