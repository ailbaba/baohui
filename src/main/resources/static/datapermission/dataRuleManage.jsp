<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button id="addBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
				<button id="editBtn" class="button-wrap"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
				<button id="deleteBtn" class="button-wrap"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_permission_list" defaultValue="数据权限列表" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="ruleGrid">
							<table id="ruleTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>
		<script>
	 var ruleGrid;
	 var ruleType=GetQueryString("ruleType");
	 var ruleTarget=GetQueryString("ruleTarget");
	
	function insertRuleTable(){
		$('#ruleGrid').html('<table id="ruleTable"></table><div id="pg" style="text-align: right;"></div>');
		//列
	    var cols = [
	        {title:'<i18n:I18n key="i18n_permission_ruleid" defaultValue="规则ID" />', name:'ruleId', width: 60, align: 'center'},
	        { title:'<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />', name:'elsAccount' ,width:80, align:'center' },
	        { title:'<i18n:I18n key="i18n_permission_objectCode" defaultValue="对象编码" />', name:'objectCode' ,width:140, align:'center'},
	        { title:'<i18n:I18n key="i18n_permission_ruleType" defaultValue="规则类型" />', name:'ruleType' ,width:120, align:'center',renderer:function(val){
	        	if(val=="1"){
	        		return '<i18n:I18n key="i18n_permission_rolerule" defaultValue="角色规则" />';
	        	}else{
	        		return '<i18n:I18n key="i18n_permission_subaccountrule" defaultValue="子账号规则" />';
	        	}
	        }},
	        { title:'<i18n:I18n key="i18n_permission_ruleobject" defaultValue="规则对象" />', name:'ruleTarget' ,width:120, align:'center'},
	        { title:'<i18n:I18n key="i18n_permission_rulesql" defaultValue="规则sql" />', name:'ruleSql' ,width:250, align:'center'}
	    ];
		var paramStr={"elsAccount":elsAccount,"ruleType":ruleType,"ruleTarget":ruleTarget};

		var height=$(document).height()-155;
	    //ch
	    debugger;
	     ruleGrid= $('#ruleTable').mmGrid({
	    	 cols: cols,
	         url: "<%=basePath%>rest/DataRuleService/getRoleOrAccountDataRuleList",
					params : paramStr,
					method : 'post',
					root : "rows",
					loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
					noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
					checkCol : true,
					height:height,
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

				ruleGrid.on('loadSuccess', function(e, data) {
					if (data.total > 0) {
						ruleGrid.select(0);
					}
				});
			}

			insertRuleTable();
			
			//添加
			$("#addBtn").click(function(){
				debugger;
				parent.elsDeskTop.defineWin({
    		        'iconSrc':'icon/els-icon.png',
    		        'windowsId':'editDataRule',
    		        'windowTitle':'<i18n:I18n key="i18n_permission_adddaterule" defaultValue="添加数据权限" />',
    		        windowSubTitle: companyShortName,
    		        'iframSrc':'<%=basePath%>datapermission/editDataRule.jsp?ruleTarget='+ruleTarget+'&ruleType='+ruleType ,
    		        'windowWidth':1060,
    		        'windowHeight':600,
    		        'parentPanel':".currDesktop"
    		    });
			});
			
			//修改
			$("#editBtn").click(function(){
				var selectedIndexs=ruleGrid.selectedRowsIndex();
				if(selectedIndexs.length<=0){
					alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
					return;
				}
				var ruleId=ruleGrid.row(selectedIndexs[0]).ruleId;
				parent.elsDeskTop.defineWin({
    		        'iconSrc':'icon/els-icon.png',
    		        'windowsId':'editDataRule',
    		        'windowTitle':'<i18n:I18n key="i18n_permission_updatedatapermission" defaultValue="修改数据权限" />',
    		        windowSubTitle: companyShortName,
    		        'iframSrc':'<%=basePath%>datapermission/editDataRule.jsp?ruleId=' +ruleId+'&ruleTarget='+ruleTarget+'&ruleType='+ruleType ,
    		        'windowWidth':1060,
    		        'windowHeight':600,
    		        'parentPanel':".currDesktop"
    		    });
			});
			
			//删除
			$("#deleteBtn").click(function(){
				var selectedIndexs=ruleGrid.selectedRowsIndex();
				if(selectedIndexs.length<=0){
					alert('<i18n:I18n key="i18n_permission_selectitemstodelete" defaultValue="请选择要删除的项！" />');
					return;
				}
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
					var ruleId=ruleGrid.row(selectedIndexs[0]).ruleId;
					var paramStr='{"elsAccount":"'+ elsAccount+ '","elsSubAccount":"'+ elsSubAccount+ '","ruleId":"'+ ruleId+'"}';
					$.ajax({
			    		url :"<%=basePath%>rest/DataRuleService/deleteDataRule",
			    		type :"post",
			    		contentType : "application/json",
			    		data : paramStr,
			    		dataType : "json",
			    		success : function(data) {
			    			insertRuleTable();
			    			alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功" />');
			    		},
			    		error : function(data) {
			    			alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',3);
			    		}
			    	}); 
				}});
			});

			
			//退出
			$("#exitBtn").click(function(){
				parent.elsDeskTop.closeCurWin('dataRuleManage',closeCallback);
			});
			
			function closeCallback() {
//	 			if (parent.frames["iframeApp_queryReceipt"]) {
//	 				parent.frames["iframeApp_queryReceipt"].insertMaterialVoucherHeaderTable();
//	 			}
			}
		</script>
</body>
</html>