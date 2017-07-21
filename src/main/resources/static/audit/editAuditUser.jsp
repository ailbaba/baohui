<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_audit_lable_auditpersons" defaultValue="审批人" /></span>
         <div class="common-box-line">
         		<div class="edit-box-wrap">
					<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
					<button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				</div>
				<input type="hidden" name="stretegyCode" id="stretegyCode" />
				<input type="hidden" name="businessType" id="businessType" />
				<input type="hidden" name="flowCode" id="flowCode" />
				<input type="hidden" name="elsAccount" value="${elsAccount}" />
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-user"></table>
                    </div>
                </main>
         </div>
 </div>
</form>
<script type="text/javascript">
var stretegyCode = "<%=request.getParameter("stretegyCode")%>";
var businessType = "<%=request.getParameter("businessType")%>";
var flowCode = "<%=request.getParameter("flowCode")%>";
var userGrid;
var cols_user = [
                   { title:'<i18n:I18n key="i18n_audit_title_auditpersonels" defaultValue="审批人的ELS账号" />', name:'auditElsAccount' ,width:180, align:'center' ,renderer:function(val){
               	    if (!val) {val = "";}
              	    return "<input class='auditElsAccount' name='auditUserList[][auditElsAccount]' type='text' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_audit_title_auditpersonels_oo" defaultValue="ELS名称" />', name:'companyShortName' ,width:180, align:'center',renderer:function(val){
                  	    return "<span class='shortName'>"+val+"</span>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_audit_title_type" defaultValue="类型" />', name:'auditUserType' ,width:150, align:'center',renderer:function(val){
                  	 return "<span class='showText' style='display:none'>" + val + "</span>" + "<select class='select' name='auditUserList[][auditUserType]'><option value='0'><i18n:I18n key='i18n_audit_selector_auditbyrole' defaultValue='角色审批' /></option><option value='1'><i18n:I18n key='i18n_audit_selector_auditbysubaccount' defaultValue='子账号审批' /></option></select>";
                   }},
                   { title:'<i18n:I18n key="i18n_audit_lable_auditpersons_xx" defaultValue="审批人子账号/角色编码" />', name:'auditUser' ,width:180, align:'center' ,renderer:function(val){
                	 return "<input class='auditUser' name='auditUserList[][auditUser]' type='text' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_audit_title_auditpersonels_oo" defaultValue="子账号名称/角色名称" />', name:'name' ,width:180, align:'center',renderer:function(val){
                  	    return "<span class='name'>"+val+"</span>"; 
                   }}
               ];;

var blankRow = {"auditElsAccount":"","companyShortName":"","auditUserType":"0","auditUser":"","name":""};

$().ready(function(){
	init();
});
function init(){
	var height=$(document).height()-230;
	if(!userGrid){
		userGrid = $('#table-user').mmGrid({
	        cols: cols_user,
	        checkCol:true,
	        height:height,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items: []
	    });
	}
	userGrid.on('loadSuccess',function() {
		bindItemEvent();
	});
	$("#stretegyCode").val(stretegyCode);
	$("#businessType").val(businessType);
	$("#flowCode").val(flowCode);
	getUserList();
}
//获取数据
function getUserList(){
		var data = {"elsAccount":elsAccount,"businessType":businessType,"stretegyCode":stretegyCode,"flowCode":flowCode};
		$.ajax({
			url :"<%=basePath%>rest/AuditService/getAuditUserList",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				userGrid.load(data.auditUserList);
				var obj = $("#table-user");
				initSelect(obj,1);
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
}

//初始化下拉框
function initSelect(obj,flag){
	obj.find("td").each(function(){
		var val=$(this).find(".showText").text();
		var selectObj=$(this).find("select");
		if(selectObj.length>0){
			if(flag == 1)
				selectObj.val(val);
		}
	});
}

//新增
$("#btnAdd").click(function(){
	userGrid.addRow(blankRow,userGrid.rowsLength());
	var lastLine = $('#table-user tr:last');
 	initSelect(lastLine,0);
 	bindItemEvent();
});

//保存
$("#saveBtn").click(function(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/AuditService/saveAuditUserList",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			parent.elsDeskTop.closeCurWin('editAuditUser',closeCallback);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
	}});
});

//删除
$("#btnDelete").click(function(){
	var selectedIndexs = userGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	userGrid.removeRow(selectedIndexs[0]);
});

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('editAuditUser',closeCallback);
});
//
function bindItemEvent(){
	//监听ELS号
	$(".auditElsAccount").keyup(function(){
		var $input = $(this);
		var val = $input.val();
		if(val == ""){
			$input.parent().parent().parent().find(".shortName").text("");
		}else if (isNaN(val)) {
			$input.val("");
			$input.focus();
			$input.parent().parent().parent().find(".shortName").text("");
			return;
		}
		if(val.length >= 6){
			$.ajax({
				url :"<%=basePath%>rest/AccountService/findEnterpriseInfoByElsAccount/"+val,
				type :"get",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					if(data && data.shortName){
						$input.parent().parent().parent().find(".shortName").text(data.shortName);
						$input.parent().parent().parent().find(".shortName").css("color","black");
					}else{
						$input.parent().parent().parent().find(".shortName").text("未查询到对应的ELS名称！");
						$input.parent().parent().parent().find(".shortName").css("color","red");
					}
				},
				error : function(data) {
					$input.parent().parent().parent().find(".shortName").text("ELS名称查询出错！");
					$input.parent().parent().parent().find(".shortName").css("color","red");
				}
			});
		}else{
			$input.parent().parent().parent().find(".shortName").text("");
		}
	});
	//监听审批人
	$(".auditUser").keyup(function(){
		var $input = $(this);
		var val = $input.val();
		var auditUserType = $input.parent().parent().parent().find("select").val();
		var auditElsAccount = $input.parent().parent().parent().find(".auditElsAccount").val();
		if(val == ""){
			$input.parent().parent().parent().find(".name").text("");
		}else if (auditUserType == 1 && isNaN(val)) {
			$input.val("");
			$input.focus();
			$input.parent().parent().parent().find(".name").text("");
			return;
		}
		//子账号审批
		if(auditUserType == 1){
			if(auditElsAccount != "" && val.length >= 4){
				$.ajax({
					url :"<%=basePath%>rest/AccountService/findSubaccount/"+auditElsAccount+"/"+val,
					type :"get",
					contentType : "application/json",
					dataType : "json",
					success : function(data) {
						if(data && data.name){
							$input.parent().parent().parent().find(".name").text(data.name);
							$input.parent().parent().parent().find(".name").css("color","black");
						}else{
							$input.parent().parent().parent().find(".name").text("未查询到对应的子账号名称！");
							$input.parent().parent().parent().find(".name").css("color","red");
						}
					},
					error : function(data) {
						$input.parent().parent().parent().find(".name").text("子账号名称查询出错！");
						$input.parent().parent().parent().find(".name").css("color","red");
					}
				});
			}else{
				$input.parent().parent().parent().find(".name").text("");
			}
		}else{
			//角色审批
			if(auditElsAccount != "" && val.length > 0){
				var param = {"elsAccount":auditElsAccount,"roleCode":val};
				$.ajax({
					url :"<%=basePath%>rest/RoleService/getRole",
					type :"post",
					contentType : "application/json",
					data: JSON.stringify(param),
					dataType : "json",
					success : function(data) {
						if(data && data.roleName){
							$input.parent().parent().parent().find(".name").text(data.roleName);
							$input.parent().parent().parent().find(".name").css("color","black");
						}else{
							$input.parent().parent().parent().find(".name").text("未查询到对应的角色名称！");
							$input.parent().parent().parent().find(".name").css("color","red");
						}
					},
					error : function(data) {
						$input.parent().parent().parent().find(".name").text("角色名称查询出错！");
						$input.parent().parent().parent().find(".name").css("color","red");
					}
				});
			}else{
				$input.parent().parent().parent().find(".name").text("");
			}
		}
	});
}
function closeCallback() {
/* 	if (parent.frames["iframeApp_dataRuleManage"]) {
		parent.frames["iframeApp_dataRuleManage"].insertRuleTable();
	} */
}
</script>
</body>
</html>