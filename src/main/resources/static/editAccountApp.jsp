	<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
	<%@ include file="/elsHeader.jsp"%>
	<link rel="stylesheet" href="<%=basePath%>extend/jstree/dist/themes/default/style.css?version=<%=version%>">
	<script type="text/javascript" src="<%=basePath%>extend/jstree/dist/jstree.min.js?version=<%=version%>"></script>
<script type="text/javascript">
var
instance,
elsSubAccount	= GetQueryString("elsSubAccount"),
queryUrl 			= "<%=basePath %>rest/AccountAppService/getAccountAppTree/"+elsAccount+"/"+elsSubAccount,
sendUrl				= "<%=basePath %>rest/AccountAppService/updateAccountApp",
formatData 		= function (data,pid) {
	return data.map(function(node){
		return  {
			id						: (pid?'__'+pid+'__':'')+node.id,
			text					: node.text + (node.type=="resource"?'<a onClick="setPermission(event,\''+node.code+'\')">【<i18n:I18n key="i18n_common_alert_setpermission" defaultValue="设置权限" />】</a>':''),
			state:{
					selected		: node.checked,
					disabled		: !node['enableCheck'],
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
	$("#strAppIds").val(s);
	var frm = $("#form");
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	$.ajax({
		url :sendUrl,
		type :"POST",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.parent.elsDeskTop.hideLoading();
			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
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
$(function(){
	$("#elsSubAccountParam").val(elsSubAccount);
	queryData();
});
function setPermission(e,code) {
	e.stopPropagation();
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'editAccountAppResource',
        'windowTitle':'<i18n:I18n key="i18n_common_alert_setpermission" defaultValue="设置权限" />',
        windowSubTitle: companyShortName,
        'iframSrc':"<%=basePath%>resource/editAccountAppResource.jsp?appCode="+code+"&elsSubAccount="+elsSubAccount,
        'windowWidth':350,
        'windowHeight':640,
        'parentPanel':".currDesktop"
    });
}

function closeWin(){
	parent.elsDeskTop.closeCurWin('editAccountApp',closeCallback);
}

</script>
<body>
<div class="box-wrap pos-relative bg-common">
	<form id="form">
<input type="hidden" id="elsAccount" name="elsAccount">
<input type="hidden" id="elsSubAccount" name="elsSubAccount">
<input type="hidden" id="strAppIds" name="params">
<input type="hidden" id="operateType" name="operateType">
</form>
	<i18n:I18n key="i18n_common_title_elsaccount" defaultValue="账号" />：<input type="text"  readonly="readonly" style="width:80px" value="${elsAccount}">
	<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号" />：<input type="text" readonly="readonly" style="width:80px" id="elsSubAccountParam" value="${elsSubAccount}">
	<button onclick="saveData()" id="js-save" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
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

</body>
</html>