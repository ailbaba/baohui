<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" href="<%=basePath%>extend/jstree/dist/themes/default/style.css?version=<%=version%>">
<script type="text/javascript" src="<%=basePath%>extend/jstree/dist/jstree.min.js?version=<%=version%>"></script>
<script type="text/javascript">
	var instance,roleCode,queryUrl,sendUrl,
	formatData 	= function (data,pid) {
		return data.map(function(node){
			return  {
				id						: (pid?'__'+pid+'__':'')+node.id,
				text					: node.text,
				state:{
						selected		: node.checked,
						disabled		: false,
						opened		: node.state==='open'},
				moduleCode : node.moduleCode,
				type 			  : node.type,
				children 		  : formatData(node.children,(pid?'__'+pid+'__':'')+node.id)
			};
		})
	},
	queryData  = function () {
		queryUrl = "<%=basePath %>rest/RoleResourceService/getRoleResourceTree/" + roleCode;
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
					$.get(queryUrl).done(
						function(data){
							cb( formatData(data));
						}
					);
				}
			}
		});
	},
	saveData  = function(){
		parent.parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
			var s = '';
			sendUrl	= "<%=basePath %>rest/RoleResourceService/updateRoleResource";
			instance.get_json().forEach(function(a){
				s+=a.id+':';
				a.children.forEach(
					function(b){
						if(!b.state.disabled&&b.state.selected)s+=b.id+','
					}
				);
				s+=',';
				s=s.replace(/,+$/g,';').replace(/__.*?__/g,'').replace(a.id+':;','');
			});
			$.ajax({
				url :sendUrl,
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify({elsAccount:elsAccount,elsSubAccount:elsSubAccount,roleCode:roleCode,resourceCode:s}),
				dataType : "json",
				success : function(data) {
					parent.parent.elsDeskTop.hideLoading();
					if(data.statusCode=="-100"){
						alert('<i18n:I18n key="i18n_alertMsg_systemError" defaultValue="系统异常" />',2);
					}else{
						alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
					}
					//closeWin();
				},
				error : function(data) {
					parent.parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}});
	};
	function closeWin(){
		parent.elsDeskTop.closeCurWin('roleResourceManage',closeCallback);
	}

	function closeCallback() {
//			if (parent.frames["iframeApp_queryReceipt"]) {
//				parent.frames["iframeApp_queryReceipt"].insertMaterialVoucherHeaderTable();
//			}
	}
	$(function(){
		$('button').button();
		roleCode = '<%=request.getParameter("roleCode") %>';
		$("#roleCode").val(roleCode);
		$("#roleCode").change(function(){
			roleCode = $("#roleCode").val();
			queryData();
			instance.refresh(false,true);
		});
		queryData();  
	});
</script>
<body>
	<div id="accountManagerContent" class="box-wrap pos-relative bg-common">
	    <div class="common-box-line">
            <div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-20"><i18n:I18n key="i18n_label_role" defaultValue="角色" />： </span> <base:roleSelector id="roleCode" name="roleCode" elsAccount="${elsAccount }" type="select"></base:roleSelector></div>
            <button onclick="saveData()" id="js-save" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
            <button id="exitBtn" class="button-wrap" onclick="closeWin()"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
	<div class="box-wrap pos-relative bg-common">
		<ul id="tt"></ul>
	</div>
</body>
</html>