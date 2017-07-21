<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" href="<%=basePath%>extend/jstree/dist/themes/default/style.css?version=<%=version%>">
<script type="text/javascript" src="<%=basePath%>extend/jstree/dist/jstree.min.js?version=<%=version%>"></script>
<script>	
var instance,
elsSubAccount = GetQueryString("elsSubAccount"),
queryUrl 	  = "<%=basePath %>rest/RoleAppService/getRoleAppTree/",
sendUrl		  = "<%=basePath %>rest/RoleAppService/updateRoleApp",
formatData 	  = function (data,pid) {
	return data.map(function(node){
		return  {
			id						: (pid?'__'+pid+'__':'')+node.id,
			text					: node.text + (node.type=="resource"?'<a onClick="setPermission(event,\''+node.code+'\')">【<i18n:I18n key="i18n_common_alert_setpermission" defaultValue="设置权限" />】</a>':''),
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
				$.get(queryUrl+$("#roleCode").val()).done(
					function(data){
						console.debug('roleCode',$("#roleCode").val(),'data',JSON.stringify(data));
						cb( formatData(data));
						parent.parent.elsDeskTop.hideLoading();
					}
				);
			}
		}
	});
},
saveData  = function(){
	
	parent.parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
		parent.parent.elsDeskTop.showLoading();
	var s='';
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
	$("#appIds").val(s);
	var frm = $("#form");
	$("#elsAccount").val(elsAccount);
	$.ajax({
		url :sendUrl,
		type :"POST",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.parent.elsDeskTop.hideLoading();
			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
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
function setPermission(e,code) {
	e.stopPropagation();
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editRoleAppResource',
        'windowTitle':'<i18n:I18n key="i18n_common_alert_setpermission" defaultValue="设置权限" />',
        windowSubTitle: companyShortName,
        'iframSrc':"<%=basePath%>resource/editRoleAppResource.jsp?appCode="+code+"&roleCode="+$("#roleCode").val(),
        'windowWidth':350,
        'windowHeight':640,
        'parentPanel':".currDesktop"
    });
}
function closeWin(){
	parent.elsDeskTop.closeCurWin('roleAppManage',closeCallback);
}

function closeCallback() {
//		if (parent.frames["iframeApp_queryReceipt"]) {
//			parent.frames["iframeApp_queryReceipt"].insertMaterialVoucherHeaderTable();
//		}
}

$(function(){
		$('button').button();
		var roleCode = '<%=request.getParameter("roleCode") %>';
		$("#roleCode").val(roleCode);
		$("#roleCode").change(function(){
			parent.parent.elsDeskTop.showLoading();
			instance.refresh(false,true);
		});
		queryData();   
	});
</script>
<body>
<div id="accountManagerContent" class="box-wrap pos-relative bg-common">
	<form id="form" style="display: inline-block;">
	<input type="hidden" id="elsAccount" name="elsAccount">
	<input type="hidden" id="appIds" name="params">
	<input type="hidden" id="operateType" name="operateType">
    <span class="dis-in-b text-right w-20"><i18n:I18n key="i18n_label_role" defaultValue="角色" />： </span><base:roleSelector id="roleCode" name="roleCode" elsAccount="${elsAccount }" type="select"></base:roleSelector>
	</form>
	<button onclick="saveData()" id="js-save" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
    <button id="exitBtn" class="button-wrap" onclick="closeWin()"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
</div>
<div class="box-wrap pos-relative bg-common">
	<ul id="tt"></ul>
</div>
</body>
</html>