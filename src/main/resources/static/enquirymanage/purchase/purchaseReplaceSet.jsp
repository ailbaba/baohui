<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="editRoleBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
				<button id="addRoleBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
				<button id="deleteBtn" class="button-wrap"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_replaceList" defaultValue="代报列表" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="replaceGrid">
							<table id="roleTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 对话框 -->
	<div class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="<%=basePath%>/icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_label_settings" defaultValue="设置" /></span>
			</div>
			<div class="mt-40">
				<div class="box-wrap pos-relative bg-common">
				   <form id="replaceFrom">
				   <table>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_label_enquiryElsAccount" defaultValue="采购方ELS帐号" />：</span></td>
							<td align="left"><input id="elsAccount" name="elsAccount" type="text" />
											 <input id="elsAccountOld" name="elsAccountOld" type="hidden" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_label_saleElsAccount" defaultValue="销售方ELS帐号" />：</span></td>
							<td align="left"><input id="toElsAccount" name="toElsAccount" type="text" />
											 <input id="toElsAccountOld" name="toElsAccountOld" type="hidden" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_label_elsSubAccount" defaultValue="子帐号" />：</span></td>
							<td align="left"><select id="elsSubAccount" name="elsSubAccount" style="width: 165px; max-width: 165px;"></select>
											 <input id="elsSubAccountOld" name="elsSubAccountOld" type="hidden" /></td>
						</tr>
					</table>
				   </form>
					<div class="mt-40">
						<button id="okBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="cancelBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
		<script>
	 var replaceGrid;
	 var type="";
	 var roleCode="";
	 
	// 渲染   @author jiangzhidong 20160120  begin
	//时间
	var formatDateTime = function (val, item, index){
		if (!val) {val = "";}
		return new Date(val).format("yyyy-MM-dd hh:mm:ss");
	};
	// 渲染   @author jiangzhidong 20160120  end
	
	function insertTable(){
		$('#replaceGrid').html('<table id="roleTable"></table><div id="pg" style="text-align: right;"></div>');
		//列
	    var cols = [
	        {title:'<i18n:I18n key="i18n_label_enquiryElsAccount" defaultValue="采购方ELS帐号" />', name:'elsAccount', width: 120, align: 'center'},
	        {title:'<i18n:I18n key="i18n_label_saleElsAccount" defaultValue="销售方ELS帐号" />', name:'toElsAccount' ,width:120, align:'center' },
	        {title:'<i18n:I18n key="i18n_common_label_elsSubAccount" defaultValue="子帐号" />', name:'elsSubAccount', width: 120, align: 'center'},
	        {title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />', name:'logtime' ,width:125, align:'center', renderer:formatDateTime},
	    ];

		var paramStr={"elsAccount":elsAccount};

		var height=$(document).height()-155;
	     replaceGrid= $('#roleTable').mmGrid({
	    	 cols: cols,
	         url: '<%=basePath%>rest/PurchaseEnquiryReplaceService/queryPurchaseEnquiryReplaceByCondtion',
					params : paramStr,
					method : 'post',
					root : "rows",
					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
					checkCol : true,
					plugins : [ $('#pg').mmPaginator({
						style : 'plain',
						totalCountName : 'total',
						page : 1,
						pageParamName : 'currentPage',
						limitParamName : 'pageSize',
						height:height,
						limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />',
				        totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />',
						limit : null,
						limitList : [ 10, 20 ]
					}) ]
				});

				replaceGrid.on('loadSuccess', function(e, data) {
					if (data.total > 0) {
						replaceGrid.select(0);
					}
				});
			}

			insertTable();

			//添加
			$("#addRoleBtn").click(function() {
				type="add";
				initDig(null);
			});

			//修改
			$("#editRoleBtn").click(function() {
				type="edit"
				initDig(1);
			});

			//删除
			$("#deleteBtn").click(function() {
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除?" />',closeEvent:function(){
				var replaceRows = replaceGrid.selectedRows();
				$.ajax({
		    		url :"<%=basePath%>rest/PurchaseEnquiryReplaceService/deletePurchaseEnquiryReplace",
		    		type :"post",
		    		contentType : "application/json",
		    		data : JSON.stringify(replaceRows[0]),
		    		dataType : "json",
		    		success : function(data) {
		    			replaceGrid.load();
		    			alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
		    		},
		    		error : function(data) {
		    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
		    		}
		    	}); 
				}});
				
			});
			
			$("#okBtn").click(function() {
				if(type=="add"){
					addProc();
				}else if(type=="edit"){
					editProc();
				}
			});
			
			//关闭对话框
			$("#cancelBtn,.dialog-close-btn").click(function() {
				$('.fixed-dialog').hide();
			});
			
			//初始化对话框
			function initDig(status){
				if(status==null){//添加
					$("#dialogTitle").html('<i18n:I18n key="i18n_common_label_addition" defaultValue="添加" />');
					$("#elsAccount").val('');
					$("#toElsAccount").val('');
					$('#elsSubAccount').empty();
				}else{//修改
					var selectedRows=replaceGrid.selectedRows();
					$("#dialogTitle").html('<i18n:I18n key="i18n_label_update" defaultValue="修改" />');
					$("#elsAccount").val(selectedRows[0].elsAccount);
					$("#toElsAccount").val(selectedRows[0].toElsAccount);
					findToElsAccount(selectedRows[0].elsAccount,selectedRows[0].elsSubAccount);
					$("#elsAccountOld").val(selectedRows[0].elsAccount);
					$("#toElsAccountOld").val(selectedRows[0].toElsAccount);
					$("#elsSubAccountOld").val(selectedRows[0].elsSubAccount);
				}
				$('.fixed-dialog').show();
			}
			
			//加载els子帐号
			$('#elsAccount').keyup( function() {
				var elsAccount = $('#elsAccount').val();
				findToElsAccount(elsAccount,null);
			});
			
			//添加过程
			function addProc(){
				var elsAccount=$("#elsAccount").val();
				var toElsAccount=$("#toElsAccount").val();
				var elsSubAccount=$("#elsSubAccount").val();
				
				if(elsAccount==null||elsAccount.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_elsAccountNotNull" defaultValue="采购方ELS帐号,不能为空!" />',2);
					return;
				}
				if(toElsAccount==null||toElsAccount.length<=0){
					alert("销售方ELS帐号,不能为空!",2);
					return;
				}
				if(elsSubAccount==null||elsSubAccount.length<=0){
					alert("ELS子帐号,不能为空!",2);
					return;
				}
				
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmAddition" defaultValue="是否确认添加?" />',closeEvent:function(){
				var paramStr = $("#replaceFrom").serializeJSON();
				$.ajax({
		    		url: '<%=basePath%>rest/PurchaseEnquiryReplaceService/addPurchaseEnquiryReplace',
		    		type :"post",
		    		contentType : "application/json",
		    		data : JSON.stringify(paramStr),
		    		dataType : "json",
		    		success : function(data) {
						if(data.statusCode==-100){
		    				alert(data.message,3);
		    			}else{
		    				replaceGrid.load(paramStr);
		    				$('.fixed-dialog').hide();
		    				alert('<i18n:I18n key="i18n_common_alert_addsuccess" defaultValue="添加成功!" />',1);
		    			}
		    		},
		    		error : function(data) {
		    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
		    		}
		    	}); 
				}});
			}
			
			//修改过程 
			function editProc(){
				var elsAccount=$("#elsAccount").val();
				var toElsAccount=$("#toElsAccount").val();
				var elsSubAccount=$("#elsSubAccount").val();
				
				if(elsAccount==null||elsAccount.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_elsAccountNotNull" defaultValue="采购方ELS帐号,不能为空!" />',2);
					return;
				}
				if(toElsAccount==null||toElsAccount.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_toElsAccountNotNull" defaultValue="销售方ELS帐号,不能为空!" />',2);
					return;
				}
				if(elsSubAccount==null||elsSubAccount.length<=0){
					alert('<i18n:I18n key="i18n_label_alert_elsSubAccountNotNull" defaultValue="ELS子帐号,不能为空!" />',2);
					return;
				}
				
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_label_confirmmodification" defaultValue="是否确认修改?" />',closeEvent:function(){
				var paramStr = $("#replaceFrom").serializeJSON();
				$.ajax({
		    		url: '<%=basePath%>rest/PurchaseEnquiryReplaceService/updatePurchaseEnquiryReplace',
		    		type :"post",
		    		contentType : "application/json",
		    		data : JSON.stringify(paramStr),
		    		dataType : "json",
		    		success : function(data) {
		    			if(data.statusCode==-100){
		    				alert(data.message,3);
		    			}else{
		    				insertTable();
		    				$('.fixed-dialog').hide();
		    				alert('<i18n:I18n key="i18n_common_alert_updatesuccess" defaultValue="修改成功!" />',1);
		    			}
		    		},
		    		error : function(data) {
		    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
		    		}
		    	}); 
				}});
			}
		
			
			//查询子帐号
			function findToElsAccount(elsAccount,elsSubAccount){
				$('#elsSubAccount').empty();
				 $.ajax({
						url :"<%=basePath%>rest/AccountService/subAccountList",
						type :"POST",
						contentType : "application/json",
						dataType : "json",
						data:JSON.stringify({"elsAccount":elsAccount}),
						success : function(data) {
							var option ="";
							if(data && data.rows && data.rows.length) {
								for(var i=0; i<=data.rows.length-1;i++) {
									if(data.rows[i].elsSubAccount == elsSubAccount)
										option += '<option value='+ data.rows[i].elsSubAccount+' selected>'+data.rows[i].name+'</option>';
									else
									    option += '<option value='+ data.rows[i].elsSubAccount+'>'+data.rows[i].name+'</option>';
								}
							}
							$('#elsSubAccount').append(option);
						},
						error: function (xhr, type, exception) {
			            	alert(xhr.responseText, "Failed"); 
			        	}
					});
			}
			
		</script>
</body>
</html>