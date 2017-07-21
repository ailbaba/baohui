<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 130px;
		padding-left: 20px;
		padding-top: 10px ;
		text-align: right;
	}
</style>
<div id="friend">
<form id="friendVerifyForm" action="" method="post" onClick="return false;">
	<input type="hidden" value="" id="fromElsAccount" name="fromElsAccount"></input>
	<input type="hidden" value=""  id="fromElsSubAccount" name="fromElsSubAccount"></input>
	<input type="hidden" value="" id="toElsAccount" name="toElsAccount"></input>
	<input type="hidden" id="requestId" name="requestId" value="">
	
	    <div class="input-and-tip text-left">
	         <span class="edit-sub-title">
		         <i18n:I18n key="i18n_common_title_stairType" defaultValue="一级类型" />：
		    </span>
			<select class="" id="groupIdA" name="groupIdA">
				<option value=""></option>
			</select>&nbsp;
			<%-- <button  onclick="newGroup(1);" value="新建" class="button-wrap"><i18n:I18n key="i18n_common_button_create" defaultValue="新建" /></button> --%>
		</div>
		<div class="input-and-tip text-left">
		    <span class="edit-sub-title">
		        <i18n:I18n key="i18n_common_title_secondType" defaultValue="二级类型" />：
		    </span>
			<select class="" id="groupIdB" name="groupIdB">
							<option value=""></option>
			</select>&nbsp;
			<!-- ADDED BY CTQ 2016/6/2 BUG#1002-38 -->
			<button onclick="delGroup();" class="button-wrap"><i18n:I18n key="i18n_common_button_delete" defaultValue="删除" /></button>
			<button onclick="newGroup(2);" class="button-wrap"><i18n:I18n key="i18n_common_button_create" defaultValue="新建" /></button>
		</div>
	</form>	
		<div style="text-align: center; padding: 5px">
		    <button  onclick="agreeFriend();" class="button-wrap"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
		    <button class="button-wrap" onclick="closeWin()" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
		</div>
</div>

<div id="group">
<form id="addGroupForm" action="" method="post">
    <input type="hidden" id="elsAccount" name="elsAccount" value="">
	<input type="hidden" id="elsSubAccount" name="elsSubAccount" value="">
	<input type="hidden" id="groupClass" name="groupClass" value="">
	
		<div class="input-and-tip text-left">
		    <span class="edit-sub-title">
		       <i18n:I18n key="i18n_account_alert_typeName" defaultValue="类型名称" />：
		    </span>
			<input type="text" id="groupName" name="groupName" />
		</div>
		<div class="input-and-tip text-left">
		    <span class="edit-sub-title">
		        <i18n:I18n key="i18n_account_alert_typeExplain" defaultValue="类型说明" />：
		    </span>
			<input size=30 type="text" id="groupDes" name="groupDes" />
		</div>
</form>
		<div style="text-align: center; padding: 5px">
			<button  onclick="addGroup();" class="button-wrap"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
			<button  onclick="cancel();" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消 " /></button>
		</div>

</div>

<script type="text/javascript">

requestId=GetQueryString("requestId");
var parentWinId = "<%= request.getParameter("parentWinId") %>";

if(parentWinId=="null"||parentWinId==""){
	parentWinId="friendVerify";
}

elsAccount='<%=session.getAttribute("elsAccount") %>';
elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';

	function init(){
		$("#group").hide();
		$("#friend").show();
		
		showGroupSelect(1);
		showGroupSelect(2);
	}
	
	$(function() {
		init();
	});

	//ADDED BY CTQ 2016/6/2 BUG#1002-38
	function delGroup(){
		
		var groupId=$("#groupIdB").val();
		var groupName=$("#groupIdB").text();
		
		if(groupId == null || groupId == undefined || groupId == ''){
			return;
		}
		
		var param = {groupId:groupId,groupName:groupName,elsAccount:elsAccount,elsSubAccount:elsSubAccount};
		
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_deleteFriendsGroup" defaultValue="您确定要删除此好友分组吗？" />',closeEvent:function(){
			var url = "<%=basePath%>rest/FriendsService/delFriendsGroup";
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data!=null&&data.statusCode=="-100"){
						alert(data.message,2);
					}else{
						init();
						alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
					
				}
			});
		}});
	}
	
	function addGroup(){
		
		var groupName = $("#groupName").val();
		if (groupName.length == 0) {
			alert('<i18n:I18n key="i18n_account_alert_typeNameRequired" defaultValue="请输入类型名称" />',2);
			$("#groupName").focus();
			return;
		}

		$("#elsAccount").val(elsAccount);
		$("#elsSubAccount").val(elsSubAccount);

		var frm = $("#addGroupForm");
		$.ajax({
			url : "../rest/FriendsService/addFriendsGroup",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />',1);
				init();
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);

			}
		});
	}
	
	function newGroup(groupClass) {
		$("#group").show();
		$("#friend").hide();
		$("#groupClass").val(groupClass);
		$("#groupName").val("");
		$("#groupDes").val("");
		
	}
	
	function cancel(){
		$("#group").hide();
		$("#friend").show();
	}
	
	function showGroupSelect(groupClass){
		
		var groupIdA=$("#groupIdA");
		var groupIdB=$("#groupIdB");
		$.getJSON("../rest/FriendsService/findMyFriendsGroup/"+elsAccount+"/"+elsSubAccount+"/"+groupClass+"?t="+new Date().getTime(),
			    function(data) {
					if(groupClass==1)
						groupIdA.empty();
					else
						groupIdB.empty();
					
			        $.each(data, function(index, item) {
			        	var option = $("<option>").text(item.groupName).val(item.groupId);
			        	if(groupClass==1)
			        		groupIdA.append(option);
			        	else
			        		groupIdB.append(option);
			        })  
			});
	}
	
	
	function agreeFriend(){
		
		$("#requestId").val(requestId);
	
		var groupIdA=$("#groupIdA").val();
		var groupIdB=$("#groupIdB").val();
		
		if(groupIdA===null || groupIdA.length==0){
			alert('<i18n:I18n key="i18n_common_alert_stairTypeRequired" defaultValue="请选择一级类型" />',2);
			return;
		 }
		
		if(groupIdB===null || groupIdB.length==0){
			alert('<i18n:I18n key="i18n_common_alert_secondTypeRequired" defaultValue="请选择二级类型" />',2);
			return;
		 }
		
		 var frm = $("#friendVerifyForm");
		 $.ajax({
				url : "../rest/FriendsService/agreeFriendsRequest",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />',1);
// 					setTimeout(function(){				     
// 						closeWin();
// 					 }, "1000"); 
					
					closeWin();
					
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					
				}
			});
		 
	}
	
	
	function closeWin(){
		//debugger;
		parent.frames['iframeApp_'+parentWinId].queryAccount();
        parent.elsDeskTop.closeCurWin('agreeFriend');
	}
</script>

</body>
</html>