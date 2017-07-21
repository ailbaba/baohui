<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
			<div class="common-box-line">
				<button class="button-wrap" id="editPassword">修改</button>
				<button class="button-wrap" id="SearchPasswordRecord">查看密码更改记录</button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">密码修改</span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="passwordGrid">
							<table id="accountTable"></table>
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
				<span id="dialogTitle">设置</span>
			</div>
			<div class="mt-40">
				<div class="box-wrap pos-relative bg-common">
				   <form id="replaceFrom">
					<div class="common-box-line">
						<div class="input-and-tip">
							<span>ELS帐号：</span>
							<input id="elsAccount" name="elsAccount" type="text"  readonly = "readonly"/>
						</div>
						<div class="input-and-tip">
							<span>ELS子帐号：</span>
							<input id="elsSubAccount" name="elsSubAccount" type="text"  readonly = "readonly"/>
						</div>
						<div class="input-and-tip">
							<span>新密码：</span>
							<input id="newPassword" name="newPassword" type="password" />
						</div>
						<div class="input-and-tip">
							<span>新密码确定：</span>
							<input id="newPasswordConfirm" name="newPasswordConfirm" type="password" />
						</div>
					</div>
				   </form>
					<div class="mt-40">
						<button id="okBtn" class="button-wrap tip-option-btn">确定</button>
						<button id="cancelBtn" class="button-wrap tip-option-btn">取消</button>
					</div>
				</div>
			</div>
		</div>
	</div>
		<script>
	 var passwordGrid;
	 var type="";
	 var roleCode="";
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 
	function initGrid(){
		$('#passwordGrid').html('<table id="accountTable"></table><div id="pg" style="text-align: right;"></div>');
		//列
	    var cols = [
	        {title:'ELS帐号', name:'elsAccount', width: 120, align: 'center'},
	        {title:'ELS子帐号', name:'elsSubAccount' ,width:120, align:'center' },
	        {title:'账户姓名', name:'name', width: 120, align: 'center'},
	        {title:'创建时间', name:'createDate' ,width:125, align:'center', renderer:function(val){
 		    	if (!val) 
	        		return "";
	        	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
 		    }},
	    ];

		var paramStr={"elsAccount":elsAccount};

		var height=$(document).height()-155;
	     passwordGrid= $('#accountTable').mmGrid({
	    	 cols: cols,
	         url: '<%=basePath%>rest/AccountService/subAccountList',
					params : "",
					method : 'post',
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
						height:height,
						totalCountLabel : '共<span>{0}</span>条记录',
						limit : null,
						limitList : [ 10, 20 ]
					}) ]
				});

				passwordGrid.on('loadSuccess', function(e, data) {
					if (data.total > 0) {
						passwordGrid.select(0);
					}
				});
			}

			 //初始化加载信息 
			$(document).ready(function(){
			
				initGrid();      //初始化表格数据和事件 
			});

			
			$("#okBtn").click(function() {
				var Newpassword = $("#newPassword").val();
				var passwordConfirm = $("#newPasswordConfirm").val();
				if(Newpassword.length<6){
					alert("密码长度至少6位",2);
					return;
				}
					if(Newpassword!=passwordConfirm){
						alert("密码不一致",2);
						return;
					}
				changePassword();
			});
			
			$("#editPassword").click(function() {
				$('.fixed-dialog').show();
				//将选择行的信息填充到对应的窗口下 .
				var selectRows = passwordGrid.selectedRows();
				$("#elsAccount").val(selectRows[0]["elsAccount"]);
				$("#elsSubAccount").val(selectRows[0]["elsSubAccount"]);
			});
			
			//关闭对话框
			$("#cancelBtn,.dialog-close-btn").click(function() {
				$('.fixed-dialog').hide();
			});
			
			//查看密码更改记录 
			$("#SearchPasswordRecord").click(function() {
				//将选择行的信息填充到对应的窗口下 .
				var selectRow = passwordGrid.selectedRows();
				if(selectRow.length < 1){
					parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
					return;
				}
				
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
			        'windowsId':'passwordRecord',
			        'windowTitle':'<i18n:I18n defaultValue="更改密码" key="i18n_account_button_passwordchange"></i18n:I18n>',
			        windowSubTitle: selectRow[0].name,
			        'iframSrc':'<%=basePath%>systemset/passwordmanage/passwordRecord.jsp?elsAccount='+selectRow[0].elsAccount+'&elsSubAccount='+selectRow[0].elsSubAccount,
			        windowMinWidth: 300,
			        windowMinHeight: 300,
			        windowPositionTop:24,
			        'windowWidth':800,
			        'windowHeight':400,
			        'parentPanel':".currDesktop"
			    });
			});
			
	
			
			//修改密码
			function changePassword(){
				var elsSubAccount = $("#elsSubAccount").val();
				var newPassword = $("#newPasswordConfirm").val();
				 $.ajax({
						url :"<%=basePath%>rest/AccountService/adminChangePassword",
						type :"POST",
						contentType : "application/json",
						dataType : "json",
						data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"newPassword":newPassword}),
						success : function(data) {
							alert("修改成功", 1); 
							$("#newPassword").val("");
							$("#newPasswordConfirm").val("");
						},
						error: function (xhr, type, exception) {
			            	alert(xhr.responseText, "Failed"); 
			        	}
					});
			}
			
			
		</script>
</body>
</html>