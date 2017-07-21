$(function() {
	var asUno = $('.asUno');
	var regBox = $('.reg_box');


	var items=[
		{'.login_box h3':'i18n_login_register'},
		{'.login_box [for=fullName] span:first-child':'i18n_reg_com_name'},
		{'.login_box #fullName[placeholder]':'i18n_reg_please_entering_company_name'},
		{'.login_box [for=registerCode] span:first-child':'i18n_reg_inv_code'},
		{'.login_box #registerCode[placeholder]':'i18n_reg_please_enter_the_invitation_code'},
		{'.login_box [for=telphone] span:first-child':'i18n_reg_phone'},
		{'.login_box #telphone[placeholder]':'i18n_reg_please_enter_your_mobile_phone_number'},
		{'.login_box [for=elsSubAccountPassword] span:first-child':'i18n_reg_password'},
		{'.login_box #elsSubAccountPassword[placeholder]':'i18n_login_passwordRequired'},
		{'.login_box [for=elsSubAccountPassword2] span:first-child':'i18n_reg_confirm_password'},
		{'.login_box #elsSubAccountPassword2[placeholder]':'i18n_reg_please_enter_your_password_again'},
		{'.login_box [for=name] span:first-child':'i18n_reg_full_name'},
		{'.login_box #name[placeholder]':'i18n_reg_please_enter_your_name.'},
		{'.login_box [for=station] span:first-child':'i18n_reg_role'},
		{'.login_box [value=purchase]':'i18n_reg_role_purchasing'},
		{'.login_box [value=sale]':'i18n_reg_role_sale'},
		{'.login_box #reg_btn':'i18n_reg_btn_submit'},
		{'.login_box #goBackBtn':'i18n_reg_back'},
		{'.main_foot .bottom+a':'i18n_login_system_login'}
	];
	var param={language:['zh-cn','en'][parseInt(elsDeskTop.cookie.map.__l||'0')]};
	window.setBaseLanguage(param,items,1);

	$('#goBackBtn').click(function() {			
			$.ajax({
				url: "../rest/AccountService/goBackLogin",
				type: "POST",
				data:JSON.stringify({}),
				contentType: "application/json",
				dataType: "json",
				success: function (data) {
					if (data.statusCode == 200) {
						show_msg('正在跳转,到登陆界面。');
						if(!data.forwardUrl)
						{
							show_err_msg(data.message);
						}	
						else{							
							location.href = data.forwardUrl;
						}
						
					} else {
						show_err_msg(data.message);
					}},
				error: function(data) {
					show_err_msg(data.message);
				}
			});
		});
		
	//提交表单
	$('#reg_btn').click(function(){
		if(!$('#agree').is(':checked')){
			return show_err_msg('您没有同意使用协议！')
		}
		show_loading();
		
		if($('#fullName').val() == ''){
			show_err_msg((jsLang.i18n_js_plz_fill_u_com_name||'请填写公司名称')+'！');
			$('#fullName').focus();
		}else if($('#registerCode').val() == ''){
			show_err_msg((jsLang.i18n_js_plz_fill_inv_code||'请填写邀请码')+'！');
			$('#registerCode').focus();
		}else if($('#elsSubAccountPassword').val() == ''){
			show_err_msg((jsLang.i18n_login_password_warm||'请填写密码')+'！');
			$('#elsSubAccountPassword').focus();
		}else if($('#elsSubAccountPassword2').val() == ''){
			show_err_msg((jsLang.i18n_js_type_u_psw_again||'请再次输入密码')+'！');
			$('#elsSubAccountPassword2').focus();
		}else if($('#elsSubAccountPassword2').val() != $('#elsSubAccountPassword').val()){
			show_err_msg((jsLang.i18n_js_pwd2_not_match||'两次密码不一致')+'！');
			$('#elsSubAccountPassword2').focus();
		}else if($('#name').val() == ''){
			show_err_msg((jsLang['i18n_reg_please_enter_your_name.']||'请输入姓名')+'！');
			$('#name').focus();
		}else{
			var frm = $("#registerForm");
			$.ajax({
				url : "../rest/AccountService/register",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data){
					if(data.statusCode=='200') {
						var msg = (jsLang.i18n_js_suc_get_els_ac||"你已成功申请到ELS账号")+":" + data.elsAccount + ","+(jsLang.i18n_login_elsSubAccount||"个人账号")+":"
						+ data.elsSubAccount + ","+(jsLang.i18n_js_pwd||"密码")+"：" + data.noEncryptPassword
						+ ","+(jsLang.i18n_js_plz_care_pwd||"请保管好您的密码")+"！";
						show_msg(msg,"/ELSServer_MT",1);
					} else {
						show_err_msg(data.message);
					}
				},
				error : function(data){
					show_err_msg((jsLang.i18n_js_reg_fail||'注册失败')+'！');
				}
			});
			
//			show_msg('注册成功咯！  正在为您跳转...','/ELSServer');	
		}
		
	});
	

	$.ajax({
		url : "../rest/BaseInfoService/findAllIndustry",
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			var industry = $("#industry");
			industry.empty();
			for (var i = 0; i < data.length; i++) {
				var option = $("<option>").text(data[i].mc).val(data[i].aj)
				industry.append(option);
			}
			industry.val("C");
		},
		error : errorResponse
	});

	$.ajax({
		url : "../rest/BaseInfoService/findAllERP",
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			var erp = $("#erp");
			erp.empty();
			for (var i = 0; i < data.length; i++) {
				var option = $("<option>").text(data[i].mc).val(data[i].mc)
				erp.append(option);
			}
		},
		error : errorResponse
	});

	function showIndustry(industry) {
		$.ajax({
			url : "../rest/BaseInfoService/industrys/" + industry,
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var industryDetail = $("#industryDetail");
				industryDetail.empty();
				for (var i = 0; i < data.length; i++) {
					var option = $("<option>").text(data[i].mc).val(data[i].mc)
					industryDetail.append(option);
				}
			},
			error : errorResponse
		});
	}
	$("#industry").change(function(e) {
		showIndustry($(this).val());
	});
	showIndustry("C");

	$.ajax({
		url : "../rest/BaseInfoService/findAllCountry",
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			var countryCode = $("#countryCode");
			countryCode.empty();
			for (var i = 0; i < data.length; i++) {

				var option = $("<option>").text(data[i].mc).val(data[i].gj)

				countryCode.append(option);
			}
			countryCode.val("CN");
		},
		error : errorResponse
	});

	function showProvince(country) {
		$.ajax({
			url : "../rest/BaseInfoService/provices/" + country,
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var province = $("#province");
				province.empty();
				for (var i = 0; i < data.length; i++) {
					var option = $("<option>").text(data[i].mc).val(data[i].aj)
					province.append(option);
				}
				province.val("88");
			},
			error : errorResponse
		});
	}
	showProvince("CN");

	$("#countryCode").change(function(e) {
		showProvince($(this).val());
	});

	function showCity(province) {
		$.ajax({
			url : "../rest/BaseInfoService/citys/" + province,
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var city = $("#city");
				city.empty();
				for (var i = 0; i < data.length; i++) {
					var option = $("<option>").text(data[i].mc).val(
							data[i].aj + "_" + data[i].mc)
					city.append(option);
				}
			},
			error : errorResponse
		});
	}
	showCity("88");

	$("#province").change(function(e) {
		showCity($(this).val());
	});

	function errorResponse(data) {
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), getI18nAlertMsg("i18n_alertMsg_systemError"));

	}
});

function validate() {
	
	var name = $("#name").val();
	var elsSubAccountPassword = $("#elsSubAccountPassword").val();
	var elsSubAccountPassword2 = $("#elsSubAccountPassword2").val();

	var businessRegNumber = $("#businessRegNumber").val();
	var fullName = $("#fullName").val();
	var shortName = $("#shortName").val();

	var address = $("#address").val();
	var telphone = $("#telphone").val();
	var email = $("#email").val();
	var fax = $("#fax").val();
	var website = $("#website").val();

	var logo = $("#logo").val();

	if (name.length == 0) {
		var msg = (jsLang['i18n_reg_please_enter_your_name.']||"请输入姓名")+"!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (elsSubAccountPassword.length == 0) {
		var msg = (jsLang.i18n_login_passwordRequired||"请输入密码")+"!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (elsSubAccountPassword2.length == 0) {
		var msg = (jsLang.i18n_fpw_new_psw_plz_again||"请再次输入新密码")+"!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (elsSubAccountPassword2 != elsSubAccountPassword) {
		var msg =(jsLang.i18n_js_pwd2_not_match||"两次密码不一致")+"!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (businessRegNumber.length == 0) {
		var msg = (jsLang.i18n_js_plz_input_bus_reg_num||"请输入工商注册号")+"!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (fullName.length == 0) {
		var msg = (jsLang.i18n_js_plz_fill_u_com_name||"请填写公司名称")+"!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	/*if (shortName.length == 0) {
		var msg = "请输入企业简称!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (address.length == 0) {
		var msg = "请输入企业详细地址!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (telphone.length == 0) {
		var msg = "请输入电话号码!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (email.length == 0) {
		var msg = "请输入邮件地址!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return false;
	}
	if (fax.length == 0) {
		var msg = "请输入传真号码!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return;
	}
	if (website.length == 0) {
		var msg = "请输入网站地址!";
		$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "error");
		return;
	}*/

	return true;
}

function submit() {
	var logo = $("#logo").val();
	if (validate()) {
		if (logo.length == 0) {
			var msg = "你没有上传企业logo,确认使用默认logo吗?";
			$.messager.confirm((jsLang.i18n_js_opt_top||"操作提示"), msg, function(data) {
				if (data) {
					$("#logo").val("default");
					var frm = $("#registerForm");
					$.ajax({
						url : frm[0].action,
						type : frm[0].method,
						contentType : "application/json",
						data : JSON.stringify(frm.serializeJSON()),
						dataType : "json",
						success : registeOKResponse,
						error : registeErrorResponse
					});
				} else {
					$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), "请上传商标logo!", "error");
					return false;
				}
			});

		}

	}
}

function clearForm() {
	
	location.href = "login.html"
}

function registeOKResponse(data) {
	$("#status").textbox("setValue", "成功申请");
	$("#elsAccount").textbox("setValue", data.elsAccount);
	var msg = (jsLang.i18n_js_suc_get_els_ac||"你已成功申请到ELS账号")+":" + data.elsAccount + ","+(jsLang.i18n_login_elsSubAccount||"个人账号")+":"
		+ data.elsSubAccount + ","+(jsLang.i18n_js_pwd||"密码")+"：" + data.noEncryptPassword
		+ ","+(jsLang.i18n_js_plz_care_pwd||"请保管好您的密码")+"！";

	$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), msg, "info", function() {
		location.href = "./default.jsp";
	});
}

function registeErrorResponse(data) {
	$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), "注册失败");
}

function uploadLogo() {

	var form = $("form[name=fileForm]");

	var options = {
		url : '../servlet/UploadServlet',
		type : 'post',
		success : function(data) {
			var jsondata = eval("(" + data + ")");
			if (jsondata.error == "0") {
				var url = jsondata.url;
				$("#logo").val(url);
				$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), "上传成功", "info");
				$("#img").attr("src", url);
			} else {
				var message = jsondata.message;
				$.messager.alert((jsLang.i18n_js_opt_top||"操作提示"), message, "error");
			}
		}
	};
	form.ajaxSubmit(options);
}