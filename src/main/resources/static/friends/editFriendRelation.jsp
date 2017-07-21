<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 100px;
		padding-left: 20px;
		padding-top: 20px ;
		text-align: right;
	}
</style>
<form id="subAccountForm" action="" method="post">
	

		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"/>：</span>
			<input readonly class="" type="text" id="friendElsAccount" name="friendElsAccount" />
			<input type="hidden" id="elsAccount" name="elsAccount" />
			<input type="hidden" id="elsSubAccount" name="elsSubAccount" />
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="对方公司一级类型" key="i18n_common_title_stairType"/>：</span>
			<select class="" id="groupIdA" name="groupIdA" style="display:none;">
			</select>
		</div>
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n defaultValue="对方公司二级类型" key="i18n_common_title_secondType"/>：</span>
			<select class="" id="groupIdB" name="groupIdB">
			</select>
			
		</div>
</form>		
		
        <div style="text-align: center; padding: 5px">
            <button id="addSubAccountOK" onclick="editSubAccount();" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" onclick="closeWin();" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>

<script type="text/javascript">


	elsAccount='<%=session.getAttribute("elsAccount") %>';
	
	elsSubAccount=GetQueryString("elsSubAccount");
	friendElsAccount=GetQueryString("friendElsAccount");
	
	
	function showFriendGroupA() {
		$.ajax({
			url : "../rest/FriendsService/findMyFriendsGroup/"+elsAccount+"/"+elsSubAccount+"/"+1+"?t="+new Date().getTime(),
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var groupIdA = $("#groupIdA");
				groupIdA.empty();
				//groupIdA.append($("<option>").text('ALL_省').val(''));
				for (var i = 0; i < data.length; i++) {
					var option = $("<option>").text(data[i].groupName).val(data[i].groupId)
					groupIdA.append(option);
				}
				showFriendGroupB();
				
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
			}
		});
	}
	
	function showFriendGroupB() {
		$.ajax({
			url : "../rest/FriendsService/findMyFriendsGroup/"+elsAccount+"/"+elsSubAccount+"/"+2+"?t="+new Date().getTime(),
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var groupIdB = $("#groupIdB");
				groupIdB.empty();
				//groupIdB.append($("<option>").text('请选择二级类型').val(''));
				for (var i = 0; i < data.length; i++) {
					var option = $("<option>").text(data[i].groupName).val(data[i].groupId)
					groupIdB.append(option);
				}
				initUpdateData();
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
			}
		});
	}
	
	function initUpdateData(){
		 $.ajax({
				url :"../rest/FriendsService/findMyFriendByFridendAccount/"+elsAccount+"/"+elsSubAccount+"/"+friendElsAccount+"?t="+new Date().getTime(),
				type :"GET",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					$("#groupIdA").val(data.groupIdA);
					var txt = $("#groupIdA").find("option[value="+data.groupIdA+"]").html();
					$("#groupIdA").after(txt);
					$("#groupIdB").val(data.groupIdB);
					//$("#name").val(data.name);
				},
				error : function(data) {
					
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					
				}
			});
	}
	
	$(function() {
		
		$("#elsAccount").val(elsAccount);
		$("#elsSubAccount").val(elsSubAccount);
		$("#friendElsAccount").val(friendElsAccount);
		
		
		showFriendGroupA();
		//showFriendGroupB();
		 
// 			$("#groupIdA").change(function(e) {
// 				showFriendGroupB($(this).val());
// 			});
		
	});
	
	function editSubAccount(){
		

		 
		 var frm = $("#subAccountForm");
		 
		 $.ajax({
				url :"../rest/FriendsService/updateMyFriend",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="i18n_delivery_updatesuccess" defaultValue="修改成功" />',1);
					setTimeout(function(){				     
						closeWin();
					 }, "1000"); 
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					
				}
			});
		 
	}
	
	
	function closeWin(){
		parent.frames['iframeApp_friendManager'].queryAccountInfo();
        parent.elsDeskTop.closeCurWin('editFriendRelation');
	}
</script>
	

</body>
</html>