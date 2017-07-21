$(function () {
	var items=[
		{'.pwd_box.step1 h3':'i18n_fpw_retrieve_password'},
		{'.pwd_box.step2 h3':'i18n_fpw_set_new_password'},
		{'.pwd_box [for=elsAccount] span:first-child':'i18n_login_elsAccount'},
		{'.pwd_box #elsAccount[placeholder]':'i18n_login_elsAccountRequired'},
		{'.pwd_box [for=newPwd] span:first-child':'i18n_fpw_new_password'},
		{'.pwd_box #newPwd[placeholder]':'i18n_fpw_new_psw_plz'},
		{'.pwd_box [for=rNewPwd] span:first-child':'i18n_fpw_confirm_new_password'},
		{'.pwd_box #rNewPwd[placeholder]':'i18n_fpw_new_psw_plz_again'},
		{'.pwd_box [for=elsSubAccount] span:first-child':'i18n_login_elsSubAccount'},
		{'.pwd_box #elsSubAccount[placeholder]':'i18n_login_personal_name_warm'},
		{'.pwd_box [for=identifyCode] span:first-child':'i18n_fpw_graphic_verification_code'},
		{'.pwd_box #identifyCode[placeholder]':'i18n_fpw_img_code_warm'},
		{'.pwd_box #code[title]':'i18n_fpw_click_change'},
		{'.pwd_box .js-changeCode[title]':'i18n_fpw_click_change'},
		{'.pwd_box [for=elsTelCode] span:first-child':'i18n_fpw_sms_verification_code'},
		{'.pwd_box #elsTelCode[placeholder]':'i18n_fpw_sms_code_input_plz'},
		{'.pwd_box #getTelCode':'i18n_fpw_get_verification_code'},
		{'.pwd_box #next_step':'i18n_fpw_next'},
		{'.pwd_box #submit':'i18n_reg_btn_submit'},
		{'.pwd_box .goBackBtn':'i18n_reg_back'}
	];
	var param={language:['zh-cn','en'][parseInt(elsDeskTop.cookie.map.__l||'0')]};
	window.setBaseLanguage(param,items,1);

	var
		step1						 	= $('.pwd_box.step1'),
		step2 							= $('.pwd_box.step2'),
		elsAc 							= step1.find('#elsAccount'),			// ELS 账号
		elsSub 						= step1.find('#elsSubAccount'),	// 个人账号
		idCode 						= step1.find('#identifyCode'),		// 图形验证码
		elsTelCode 					= step1.find('#elsTelCode'),		// 短信验证码
		getTelCode 				= step1.find('#getTelCode'),		// 获取验证码
		nextStep 					= step1.find('#next_step'),			// 下一步
		goBackBtn 					=$('.goBackBtn'),								//返回
		codeImg						= step1.find('#code'),						//图形验证码图片
		jsChangeCode			=step1.find('.js-changeCode'),
		newPwd 						= step2.find('#newPwd'),				// 新密码
		rNewPwd 					= step2.find('#rNewPwd'),				// 确认新密码
		submit 						= step2.find('#submit'),					// 提交
		pwdForm 					= step1.find('#pwdForm'),				// 找回密码表单
		setPwd 						= step2.find('#setPwd'),					// 设置密码表单
		basePath 					= (/^.*?ELSServer\//.exec(location.href) || [])[0];

	//[0-名称,1-非空检查，2-正则检查,3-正则检查提示,4-上下文逻辑检查,5-逻辑检查提示,6-ajax请求检查,7-ajax错误提示]
	elsAc.checkList 				= [jsLang.i18n_js_els_ac||'ELS账号', 1];
	elsSub.checkList			 	= [jsLang.i18n_login_elsSubAccount||'个人账号', 1];
	idCode.checkList 				= [jsLang.i18n_fpw_graphic_verification_code||'图形验证码', 1];
	elsTelCode.checkList 		= [jsLang.i18n_fpw_sms_verification_code||'短信验证码', 1];
	newPwd.checkList 			= [jsLang.i18n_fpw_new_password||'新密码', 1];
	rNewPwd.checkList 	= [jsLang.i18n_fpw_confirm_new_password||'确认新密码', 1, 0, 0,
		function (v) {
			return v === newPwd.val();
		}, jsLang.i18n_js_pwd2_not_match||'两次密码不一致'];
	step1.checkList = [0, 0, 0, 0, 0, 0, function () {
		return $.ajax({
			url: basePath + 'rest/AccountService/valiteAccountInfo?valiteCode=' + elsTelCode.val(),
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({
				"elsAccount": elsAc.val(),
				"elsSubAccount": elsSub.val(),
				"valiteCode": elsTelCode.val()
			}),
			dataType: 'json'
		})
	}, function () {
		return jsLang.i18n_js_commit_failed||'提交服务器失败';
	}];
	step2.checkList = [0, 0, 0, 0, 0, 0, function () {
		return $.ajax({
			url: basePath + 'rest/AccountService/ResetPassword/?valiteCode='+ elsTelCode.val(),
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({
				"elsAccount": elsAc.val(),
				"elsSubAccount": elsSub.val(),
				"newPassword": rNewPwd.val()
			}),
			dataType: 'json'
		})
	}, function () {
		return jsLang.i18n_js_commit_failed||'提交服务器失败';
	}];
	var
		changeCode = function(){
			$('#code').attr('src', '../image/identifyingCode.img?t=' + new Date().getTime())
		},
		initGetTelCode = function () {
			getTelCode.__state = '';
			getTelCode.removeClass('disable').text(jsChangeCode.i18n_fpw_get_verification_code||'获取验证码');
		},
		stepCheck = function (e, step, cb) {
			e.stopPropagation();
			if (step1 === step) {
				elsFieldsCheck(elsAc, elsSub, idCode, elsTelCode, step1).done(cb)
			} else if (step2 === step) {
				elsFieldsCheck(newPwd, rNewPwd, step2).done(cb)
			}
		};
	codeImg.click(changeCode);
	jsChangeCode.click(changeCode);
	getTelCode.click(function () {
		if (getTelCode.__state === 'wait')return;
		elsFieldsCheck(elsAc, elsSub).done(function () {
			getTelCode.__state = 'wait';
			getTelCode.addClass('disable').text(jsLang.i18n_js_sending_sms||'正在发送短信...');
			$.ajax({
				url: basePath + 'rest/AccountService/getPhoneValiteCode',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({"elsAccount": elsAc.val(), "elsSubAccount": elsSub.val()}),
				dataType: 'json'
			}).done(function (data) {
				if(data&&data.statusCode === '-100'||data == 0){
					show_err_msg(jsLang.i18n_js_sms_send_fail||'验证码发送失败');
					return initGetTelCode();
				}
				show_msg(jsLang.i18n_js_v_code_sent||'验证码已发送');
				var t = 60;
				var timer = setInterval(function () {
					getTelCode.text(t - 1 + 's');
					if (--t < 1) {
						clearInterval(timer);
						initGetTelCode();
					}
				}, 1000);
			}).fail(function () {
				show_err_msg(jsLang.i18n_js_sms_send_fail||'验证码发送失败');
				initGetTelCode();
			})
		})
	});
	nextStep.click(function (e) {
		stepCheck(e, step1, function () {
			console.log(arguments);
			var c= arguments[arguments.length-1];
			if (c.data == 1) {
				step1.hide();
				step2.show();
			} else if (c.data == 2) {
				show_err_msg(jsLang.i18n_js_p_c_code_err||'手机验证码错误');
			} else {
				show_err_msg(c.data&&c.data.message||(jsLang.i18n_js_commit_failed||'提交服务器失败'));
			}
		});
	});
	goBackBtn.click(function(){
		location.href = "login.html"
	});
	submit.click(function (e) {
		stepCheck(e, step2, function () {
			show_msg(jsLang.i18n_js_pwd_moded||'密码已修改','login.html');
		})
	});
});