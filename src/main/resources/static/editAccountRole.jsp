<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
	<%@ include file="/elsHeader.jsp"%>
	<link rel="stylesheet" href="<%=basePath%>extend/jstree/dist/themes/default/style.css?version=<%=version%>">
	<script type="text/javascript" src="<%=basePath%>extend/jstree/dist/jstree.min.js?version=<%=version%>"></script>
<script type="text/javascript">
	var instance;
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	elsSubAccount=GetQueryString("elsSubAccount");
	
	formatData 		= function (data) {
		return data.map(function(node){
			return  {
				id						: node.roleCode,
				text					: node.roleName,
				state:{
						selected		: node.elsAccount?true:false,
						disabled		: false,
						opened		: node.state==='open'},
// 				moduleCode : node.moduleCode,
// 				type 			  : node.type,
			};
		})
	},
	
	queryData  = function () {
		$('#tt').on('loaded.jstree',function(e,i){
					instance = i.instance;
			}).on('changed.jstree',function(e,i){
					var n = i.node;
					if(n){
						if(n.children.length)n = n.children;
						else{n=[n.id]}
						n.forEach(function(o){
							var c=i.instance.get_node(o);
							if(c.state.disabled&&c.state.selected!==c.original.state.selected){
									i.instance.get_node(o,true).find('.jstree-anchor')[c.original.state.selected?'addClass':'removeClass']('jstree-clicked');
							}
						});
					}
			}).jstree({
			plugins : [  "checkbox" ],
			core :{
				data:function(node,cb){
					$("#elsAccount").val(elsAccount);
					$("#elsSubAccount").val(elsSubAccount);
					var frm = $("#form");
					//获取用户角色
					$.ajax({
						url :"rest/SubAccountRoleService/getSubAccountRole",
						type :"POST",
						contentType : "application/json",
						data : JSON.stringify(frm.serializeJSON()),
						dataType : "json",
						success : function(data) {
							cb( formatData(data));
						},
						error : function(data) {
			    			if (!permissionError(data)) {
			    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			    			}
						}
					});
				}
			}
		});
	},

	$(function() {
		$("#elsSubAccountParam").val(elsSubAccount);
		queryData();
		$('body').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
	});
	
	
	function editAccountRole(){
		 var frm = $("#form");
		 var roleCode = ""
		instance.get_json().forEach(function(a){
			if(!a.state.disabled&&a.state.selected){
				roleCode = roleCode + a.id + ","; 
			}
		});
		 if (roleCode == "") {
			 alert('<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />',2);
			 return;
		 } else {
			 $("#roleCode").val(roleCode.substring(0,roleCode.length - 1));
		 }
		 
		 parent.parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
				parent.parent.elsDeskTop.showLoading();
		 console.log(JSON.stringify(frm.serializeJSON()));
		 $.ajax({
				url :"rest/SubAccountRoleService/updateAccountRole",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.parent.elsDeskTop.hideLoading();
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
// 					setTimeout(function(){				     
						//closeWin();
// 					 }, "3000"); 
				},
				error : function(data) {
					parent.parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		 }});
	}
	
	
	/* function closeWin(){
		$("#mask,#maskTop", window.parent.document).fadeOut(function() {
             $(this).remove();
         });
	} */
</script>
<body>
<div class="box-wrap pos-relative bg-common">
	<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="账号" />：<input type="text"  readonly="readonly" style="width:80px" value="${elsAccount}">
	<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号" />：<input type="text" readonly="readonly" id="elsSubAccountParam" style="width:80px" value="${elsSubAccount}">
	<button onclick="editAccountRole()" id="js-save" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
	</div>
	
	<ul id="tt" style="
		margin:0;
		padding:0;
		position: absolute;
		left: 0;
		right: 0;
		top: 50px;
		bottom: 0;
		overflow: auto;
		background: #F3F3F3;
		border-top: #ddd 1px solid;
	"></ul>
<form id="form" action="" method="post">
<input type="hidden" name="roleCode" id="roleCode"/>
<input  type="hidden" id="elsAccount" name="elsAccount" />
<input  type="hidden" id="elsSubAccount" name="elsSubAccount" />
</form>
</body>
</html>