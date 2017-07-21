// JavaScript Document
//支持Enter键登录
var data = window.location.search.substring(1);
var ltype = decodeURI(data);
var changeCode = function () {
	$('#code').attr('src', '../image/identifyingCode.img?t=' + new Date().getTime());
};
/*document.onkeydown = function (e) {
	if ($(".bac").length == 0) {
		if (!e) e = window.event;
		if ((e.keyCode || e.which) == 13) {
			var obtnLogin = document.getElementById("submit_btn");
			obtnLogin.focus();
		}
	}
};*/
$(function () {
	document.onkeydown = function (e) {
		if ($(".bac").length == 0) {
			if (!e) e = window.event;
			if ((e.keyCode || e.which) == 13) {
				var obtnLogin = document.getElementById("submit_btn");
				obtnLogin.focus();
			}
		}
	};
	//多语言需要渲染的数组
	var items=[
	           {'.downloadClientApp a':'i18n_login_download__client'},
	           {'.login_box h3':'i18n_login_login'},
	           {'.reserved':'i18n_login_reserved'},
	           {'.record-num':'i18n_login_record_num'},
	           {'.customer_serv':'i18n_js_customer_serv_ol'},
	           {'.login_box .form-group.space .btn.blue':'i18n_login_login'},
	           {'.login_box .form-group.space .btn.blue':'i18n_login_login'},
	          // {'.login_box .form-group #language option[value="zh_cn"]':'i18n_login_chinese'},
	          // {'.login_box .form-group #language option[value="en"]':'i18n_login_english'},
	           {'.login_box .form-group.space .btn.gray':'i18n_login_register'},
	           {'.login_box .form-group.opt .js-save-p span':'i18n_login_remember_password'},
	           {'.login_box .form-group.opt .js-auto-l span':'i18n_login_auto'},
	           {'.login_box .form-group.opt .js-forgot-p a span':'i18n_login_forget_password'},
	           {'.login_box .form-group .change-code a':'i18n_login_change_code'},
	           {'.login_box .form-group label.t[for="language"] span:first-child ':'i18n_login_language'},
	           {'.login_box .form-group label.t[for="elsAccount"] span:first-child ':'i18n_login_elsAccount'},
	           {'.login_box .form-group label.t[for="elsSubAccount"] span:first-child ':'i18n_login_elsSubAccount'},
	           {'.login_box .form-group label.t[for="elsSubAccountPassword"] span:first-child ':'i18n_login_password'},
	           {'.login_box .form-group label.t[for="identifyCode"] span:first-child':'i18n_login_identifyCode'},
	           {'.login_box .form-group.opt label.warn span':'i18n_login_click_warm'},
	           {'.login_box .form-group input#elsAccount[placeholder]':'i18n_login_elsAccountRequired'},
	           {'.login_box .form-group input#elsSubAccount[placeholder]':'i18n_login_subAccount_require'},
	           {'.login_box .form-group input#elsSubAccountPassword[placeholder]':'i18n_login_passwordRequired'},
	           {'.login_box .form-group input#identifyCode[placeholder]':'i18n_login_identifyCodeRequired'}
	           ];
	
	var
		$logo = $('.page-container .login_logo img');
		$form = $('.page-container form'),
		$els = $form.find('#elsAccount'),
		$user = $form.find('#elsSubAccount'),
		$pwd = $form.find('#elsSubAccountPassword'),
		$warn = $form.find('.opt .warn'),
		$forget = $form.find('.opt .js-forgot-p'),
		$savep = $form.find('.opt .js-save-p input'),
		$autol = $form.find('.opt .js-auto-l input'),
		$lang = $form.find('#language'),
		$iden = $form.find('#identifyCode'),
		$submit = $form.find('#submit_btn'),
		timer = null,
		encode = window.btoa || Base64.encode,
		decode = window.atob || Base64.decode,
		saveInfo = function () {
			elsDeskTop.cookie.setItem('__e', encode($els.val() || ''));
			elsDeskTop.cookie.setItem('__u', encode($user.val() || ''));
			elsDeskTop.cookie.setItem('__p', encode($pwd.val() || ''));
		},
		recoverInfo = function () {
			$els.val(decode(elsDeskTop.cookie.getItem('__e') || ''));
			$user.val(decode(elsDeskTop.cookie.getItem('__u') || ''));
			$pwd.val(decode(elsDeskTop.cookie.getItem('__p') || ''));
		},
		autoLogin = function () {
			recoverInfo();
			if(ltype=='ltype=logout')return;
			if ($els.val() && $user.val() && $pwd.val())
			submit($lang.val(), $els.val(), $user.val(), $.md5($pwd.val()), null, 'auto');
		},
		onChange = function (a, e) {
			if (timer)clearTimeout(timer);
			if (e.target.checked) {
				$warn.slideDown(300, function () {
					timer = setTimeout(function () {
						$warn.slideUp();
					}, 8000)
				});
			} else {
				$warn.slideUp();
			}
			elsDeskTop.cookie.setItem(a, e.target.checked, 60 * 60 * 24 * 7, '/');
		},
		submit = function (language, elsAccount, elsSubAccount, elsSubAccountPassword, identifyCode, loginType) {
			var param = {
				"language": language,
				"elsAccount": elsAccount,
				"elsSubAccount": elsSubAccount,
				"elsSubAccountPassword": elsSubAccountPassword,
				"identifyCode": identifyCode,
				"loginType": loginType
			};
			$.ajax({
				url: "../rest/AccountService/login",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify(param),
				dataType: "json",
				success: loginOKResponse,
				error: loginErrorResponse
			});
		},
		loginOKResponse = function (data) {
			if (data.statusCode == 200) {
				show_msg(baseLang.i18n_login_success_tip, '');
				location.href = "../default.jsp?account=" + $els.val() + "_" + $user.val();
			} else {
				show_err_msg(data.message);
			}
		},
		loginErrorResponse = function (data) {
			show_err_msg(data.message);
		};

	$pwd.keyup(function () {
		$(this).parent().find('.error').fadeOut('fast');
	});
	$savep.change(function (e) {
		if (!this.checked)$autol.attr('checked', false).change();
		onChange('rememberPwd', e);
	});
	$autol.change(function (e) {
		if (this.checked)$savep.attr('checked', true).change();
		onChange('autoLogin', e);
	});
	//匹配语言
	var ind = 0;
	if(window.getClientLanguage()) {
		ind = $lang.find("option[value="+window.getClientLanguage()+"]").index(); 
	}
	$lang[0].selectedIndex = parseInt(elsDeskTop.cookie.map['__l'] || ind);
	//公司logo多语言匹配
	$logo.eq(parseInt(elsDeskTop.cookie.map['__l'] || ind)).addClass('active').fadeIn('fast');
	var param={};
	param.language=$lang.val();
	window.setBaseLanguage(param,items);
	$lang.change(function (e) {
		var language = $(this).val();
		elsDeskTop.cookie.setItem('__l', this.selectedIndex);
		$.ajax({
			url: '../rest/I18nService/setLanguage/' + language,
			type: 'POST',
			contentType: 'application/json',
			data: '{\'language\':' + language + '}',
			dataType: 'json',
			success: function (data) {
					var param={};
					param.language=language;
					window.setBaseLanguage(param,items);
					$logo.removeClass('active');
					$logo.eq(parseInt(elsDeskTop.cookie.map['__l'] || ind)).addClass('active').fadeIn('fast');
			},
			error: function (data) {
			}
		});
	});
	//提交表单
	$submit.click(function () {
		show_loading();
		if ($els.val() == '') {
			show_err_msg(baseLang.i18n_login_company_name_warm+'！'||'请填写公司账号！');
			$els.focus();
		} else if ($user.val() == '') {
			show_err_msg(baseLang.i18n_login_personal_name_warm+'！'||'请填写个人账号！');
			$user.focus();
		} else if ($iden.val() == '') {
			show_err_msg(baseLang.i18n_login_identify_code_warm+'！'||'请填写验证码！');
			$iden.focus();
		} else if ($pwd.val() == '') {
			show_err_msg(baseLang.i18n_login_password_warm+'！'||'请填写密码！');
			$pwd.focus();
		} else {
			var elsAccount = $els.val();
			var language = $lang.val();
			var elsSubAccount = $user.val();
			var elsSubAccountPassword = $.md5($pwd.val());
			var identifyCode = $iden.val();
			//ajax提交表单，#login_form为表单的ID。 如：$('#login_form').ajaxSubmit(function(data) { ... });
			submit(language, elsAccount, elsSubAccount, elsSubAccountPassword, identifyCode, "");
			saveInfo();
		}
	});
	$('#reg_btn').click(function () {
		location.href = 'register.html';
	});
	if (elsDeskTop.cookie.getItem('autoLogin') === 'true') {
		$autol.attr('checked', true);
		$savep.attr('checked', true);
		autoLogin();
	} else if (elsDeskTop.cookie.getItem('rememberPwd') === 'true') {
		$savep.attr('checked', true);
		recoverInfo();
	} else {

	}
	//拖动表单
	$( ".login_box" ).draggable({ containment: ".page-container", scroll: false,cursor: "move" });
	
});

