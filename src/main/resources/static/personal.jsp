<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		//电话与邮箱是否已经存在
		var commonCheck=function checkExist(data,checkName,defaultCheckValue){
		  	 $.ajax({
		  			url :"<%=basePath%>rest/AccountService/checkInfoIsExist",
		  			type :"POST",
		  			contentType : "application/json",
		  			dataType : "json",
		  			data:JSON.stringify(data),
		  			success : function(data) {
		  				if(data == "1"){
		  					$('.tag-error').hide();
		  					var nVal = $('.'+checkName).val();
		  					if(checkName=='telphone' && nVal !=defaultCheckValue) {
		  						$('.'+checkName).next('.tag-error').show().html(jsLang.i18n_personal_phone_require||'电话已经存在，请重新输入');
		  					} else if (checkName=='e-mail' && nVal !=defaultCheckValue) {
		  						$('.'+checkName).next('.tag-error').show().html(jsLang.i18n_personal_email_require||'邮箱已经存在，请重新输入');
		  					}
	  						
		  					return nVal;
		  					
		  				}else{
		  					return $('.'+checkName).val();
		  				}
		  			},
		  			error: function (xhr, type, exception) {
		                 
		              }
		  		});
		}
		$('.box-logo').attr('src',location.href.match(/https?:\/\/.*?\//)[0]+('opt/nfsshare/'+top.elsDeskTop.loginStore.logo||"icon/icon1.png"));
		//邮件正则表达式
		$('.e-mail').keyup(function () {
			var val = $(this).val();
			var reg = /([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,5})+/;
			if (reg.test(val)) {
				$(this).next('.tag-error').hide();
				var checkParam = {"elsAccount":elsAccount,"email":val,'elsSubAccount':elsSubAccount};
				commonCheck(checkParam,'e-mail',window.defaultEmail);
			} else {
				$('.tag-error').hide();
				$(this).next('.tag-error').show().html('*'+jsLang.i18n_personal_email_format_require||'*邮箱格式不正确');
				return false;
			}
		});
		$('.telphone').keyup(function () {
			var val = $(this).val();
			if (val) {
				$(this).next('.tag-error').hide();
				var checkParam = {"elsAccount":elsAccount,"telphone1":val,'elsSubAccount':elsSubAccount};
				commonCheck(checkParam,'telphone',window.defaultPhoneNum);
			} else {
				$('.tag-error').hide();
				$(this).next('.tag-error').show().html('*'+jsLang.i18n_personal_phone_empty||'*电话号码不能为空');
				return false;
			}
		});
		$.ajax({
			url: "rest/AccountService/findSubaccount/" + elsAccount + "/" + elsSubAccount + "?t=" + new Date().getTime(),
			type: "GET",
			contentType: "application/json",
			dataType: "json",
			success: function (data) {
				$("#elsAccount").html(elsAccount);
				$("#elsSubAccount").html(elsSubAccount);
				$("#name").html(data.name);
				$("#station").html(data.station == 'purchase' ? jsLang.i18n_personal_purchase||'采购' : jsLang.i18n_personal_sales||'销售');
				$("#companyShortName").html(data.companyShortName);
				$("#email").val(data.email);
				$("#telphone").val(data.telphone1);
				window.defaultPhoneNum = $('.telphone').val();
				window.defaultEmail = $('.e-mail').val();
			},
			error: function (XMLHttpRequest, textStatus, errorThrown) {
				//alert(jsLang.i18n_personal_network_warm||'获取个人信息失败，请检查网络',3);
// 				console.log(XMLHttpRequest);
// 				console.log(textStatus);
// 				console.log(errorThrown);
				alert(XMLHttpRequest.responseText, 3);
			}
		});
		$("#update").click(function () {
			var telphone = $(".telphone").val();
			var email = $(".e-mail").val();
			var oldPassword = $("#oldPassword").val();
			var newPassword = $("#newPassword").val();
			var newPassword2 = $("#newPassword2").val();
			if (!telphone) {
				alert(jsLang.i18n_personal_phone_not||"电话不能为空", 3);
				return;
			}
			var reg = /([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,5})+/;
			if (email && !reg.test(email)) {
				alert(jsLang.i18n_personal_email_format_require||"邮箱格式不正确", 3);
				return;
			}
			if (!oldPassword) {
				alert(jsLang.i18n_personal_oldphone_not||"旧密码不能为空", 3);
				return;
			}
			if (!newPassword) {
				alert(jsLang.i18n_personal_newphone_not||"新密码不能为空", 3);
				return;
			}
			if (newPassword != newPassword2) {
				alert(jsLang.i18n_personal_password_inconsistent||"密码前后不一致", 3);
				return;
			}
			var data = {
				"elsAccount": elsAccount,
				"elsSubAccount": elsSubAccount,
				"email": email,
				"telphone1": telphone
			};
			$.ajax({
				url: "rest/AccountService/updateSubaccount",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify(data),
				dataType: "json",
				success: function (data) {
						var passParams = {
							"elsAccount": elsAccount,
							"elsSubAccount": elsSubAccount,
							"oldPassword": oldPassword,
							"newPassword": newPassword
						};
						$.ajax({
							url: "rest/AccountService/changePassword",
							type: "POST",
							contentType: "application/json",
							data: JSON.stringify(passParams),
							dataType: "json",
							success: function (data) {
								debugger;
								if (data.statusCode == 200){
									alert(jsLang.i18n_personal_update||"资料更新成功");
									setTimeout(function(){
										top.$('.ui_boxyClose.message-close').click();
									}, 2000); 
								}else {
									alert(data.message, 3);
								}
							},
							error: function (data) {
							}
						});
				},
				
				error: function (data) {
					alert(data.responseText,2);
					//关闭窗口的按钮重新出现,并且直接退出到外面
				 	setTimeout(function(){
						top.location.href="login/logout.jsp";
					}, 2500);  
					//alert(jsLang.i18n_personal_update_error||"资料更新失败，请检查网络",3);
				}
			});
		});
	});
</script>
<body style="background-color: transparent!important;">
<div class="personal-box">
	<div class="display-info">
		<div class="p-box-left">
			<img class="box-logo" alt="" onerror="javascript:this.src='icon/icon1.png';"  />
			<!-- <span class="p-label">简称：</span>
			<span id="companyShortName" class="p-text">企企通</span>
			<br/> -->
			<span class="p-label"><i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />：</span>
			<span id="elsAccount" class="p-text"></span>
			<br/>
			<span class="p-label"><i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号" />：</span>
			<span id="elsSubAccount" class="p-text"></span>
			<div class="clear"></div>
		</div>
		<div class="p-box-right">
			<h2 id="companyShortName"></h2>
			<span class="p-label"><i18n:I18n key="i18n_common_title_username" defaultValue="姓名" />：</span>
			<span id="name" class="p-text"> </span>
			<br/>
			<span class="p-label"><i18n:I18n key="i18n_label_role" defaultValue="角色" />：</span>
			<span id="station" class="p-text"></span>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="edit-info">
		<ul class="item-list ">
			<li class="tag-wrap pos-relative">
				<span class="p-label"><i18n:I18n key="i18n_enterprise_telphone" defaultValue="电话" />：</span>
				<input id="telphone" class="telphone" type="text" value=""/>
				<!-- <span style="color: red" id="telphone_span"></span> -->
				<span class="dis-in-b pos-absolute tag-error">*<i18n:I18n key="i18n_personal_phone_empty" defaultValue="电话号码不能为空" /></span>
				<!-- <input style="max-width:100%;"  type="hidden" id="telphoneBak" /> -->
			</li>
			<li class="tag-wrap  pos-relative">
				<span class="p-label"><i18n:I18n key="i18n_personal_email_name" defaultValue="邮箱" />：</span>
				<input id="email" type="text" class="e-mail" value=""/>
				<!-- <span style="color: red" id="email_span"></span> -->
				<span class="dis-in-b pos-absolute tag-error">*<i18n:I18n key="i18n_personal_email_format_require" defaultValue="邮箱格式不正确" /></span>
				<!-- <input style="max-width:100%;"  type="hidden" id="emailBak" /> -->
			</li>
			<li class="tag-wrap  pos-relative">
				<span class="p-label"><i18n:I18n key="i18n_personal_old_password" defaultValue="旧密码" />：</span>
				<input id="oldPassword" type="password" value=""/>
				<span class="dis-in-b pos-absolute tag-error">*<i18n:I18n key="i18n_personal_oldphone_not" defaultValue="旧密码不能为空" /></span>
			</li>
			<li class="tag-wrap  pos-relative">
				<span class=" p-label"><i18n:I18n key="i18n_fpw_new_password" defaultValue="新密码" />：</span>
				<input id="newPassword" type="password" value=""/>
				<span class="dis-in-b pos-absolute tag-error">*<i18n:I18n key="i18n_personal_newphone_not" defaultValue="新密码不能为空" /></span>
			</li>
			<li class="tag-wrap  pos-relative">
				<span class=" p-label"><i18n:I18n key="i18n_reg_confirm_password" defaultValue="确认密码" />：</span>
				<input id="newPassword2" type="password" value=""/>
				<span class="dis-in-b pos-absolute tag-error">*<i18n:I18n key="i18n_personal_different_password" defaultValue="密码前后不一致" /></span>
			</li>
		</ul>
	</div>
	<div id="update" class="option-btn blue " style="text-align:center;line-height:28px;"><i18n:I18n key="i18n_common_button_update" defaultValue="更新" /></div>
</div>
</body>
</html>