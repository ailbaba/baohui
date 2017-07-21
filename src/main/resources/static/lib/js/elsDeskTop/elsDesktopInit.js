/*-----------------------------------------------------------
 *version: mydesktop 3.0
 *author: pssdss
 *email: 530624206@qq.com
 *blog: http://www.pssdss.com/
 *date:2013-1-24
 *桌面初始化脚本
 ----------------------------------------------------------*/
$(window).load(function() {
	var slideArr = [];
	var defaultAppData = [];
	var loadAppMap = function() {
		var defer = $.Deferred();
		if (localStorage.getItem('clearAppMap')) {
			localStorage.removeItem('clearAppMap');
			localStorage.removeItem('app_map_' + (+(elsAccount + elsSubAccount)).toString(36));
			ajaxWorker('rest/AccountAppService/delAppPosition/' + elsAccount + '/' + elsSubAccount, {
				type: 'get',
				contentType: 'application/json',
				dataType: 'json'
			}).done(
				function() {
					//defer.resolve({})
					console.log('clear icon map success!')
				}
			).fail(
				function() {
					//defer.resolve({})
				}
			);
		}
		var appMap;
		try {
			appMap = JSON.parse(localStorage.getItem('app_map_' + (+(elsAccount + elsSubAccount)).toString(36)));
		} catch (e) {
			console.log(e)
		}
		ajaxWorker({
			url: 'rest/AccountAppService/getAppPosition/' + elsAccount + '/' + elsSubAccount,
			type: 'get',
			contentType: 'application/json',
			dataType: 'json'
		}).done(
			function(data) {
				var _appMap = data && data.appPosition;
				if (_appMap) appMap = JSON.parse(_appMap);
				defer.resolve(appMap)
			}
		).fail(
			function() {
				defer.resolve(appMap)
			}
		);
		return defer.promise();
	};

	var store = elsDeskTop.loginStore;
	//停止进度条
	elsDeskTop.stopProgress();
	//禁止选择文本内容
	elsDeskTop.disableSelect();

	//初始化桌面背景
	///*背景平铺三种类型,1背景拉伸,2背景居中,3背景自适应屏幕*/
	var shemeBgDisType = 1;
	if (window.localStorage) {
		var getStoreSkin = localStorage.getItem('shinTheme');
		if (getStoreSkin) {
			var storeObj = JSON.parse(getStoreSkin);
			elsDeskTop.themeSkin(storeObj.cColor, storeObj.cOpacity);
			elsDeskTop.wallpaper.init(storeObj.bgImg, shemeBgDisType);
			//将数据存储至loginStore
			elsDeskTop.loginStore.shemeBgImg = storeObj.bgImg;
			elsDeskTop.loginStore.shemeBgDisType = shemeBgDisType;
		} else {
			elsDeskTop.wallpaper.init('theme/default/images/wallpaper.jpg', shemeBgDisType);
			//将数据存储至loginStore
			elsDeskTop.loginStore.shemeBgImg = 'theme/default/images/wallpaper.jpg';
			elsDeskTop.loginStore.shemeBgDisType = shemeBgDisType;
		}
	} else {
		elsDeskTop.wallpaper.init('theme/default/images/wallpaper.jpg', shemeBgDisType);
		//将数据存储至loginStore
		elsDeskTop.loginStore.shemeBgImg = 'theme/default/images/wallpaper.jpg';
		elsDeskTop.loginStore.shemeBgDisType = shemeBgDisType;
	}

	//桌面图标初始化
	var toBoolean = function(val) {
		return val !== 'false' && !!val;
	};
	var buildApp = function(d) {
		var txNum = '';
		if (d.txNum > 0) {
			txNum = d.txNum;
		}
		return {
			//桌面图标初始化参数，不是窗口的参数，窗口的参数包含在里面
			elsId: d.fbk1,
			iconSrc: d.appIcon,
			windowsId: d.appCode,
			winHelpClick: d.fbk3,
			windowTitle: d.appName,
			appCategoryId: d.appCategoryId,
			iframSrc: d.appUrl,
			txNum: txNum, //图标是否有消息数提示，没有就设为0或空
			closeEvent: d.closeEvent,
			parentPanel: d.parentPanel,
			windowAnimation: toBoolean(d.windowAnimation),
			windowAnimationSpeed: parseInt(d.windowAnimationSpeed),
			windowStatus: d.windowStatus, //窗口默认打开状态
			windowDraggable: toBoolean(d.windowDraggable),
			windowClosable: toBoolean(d.windowClosable),
			windowMinimize: toBoolean(d.windowMinimize),
			windowMaximize: toBoolean(d.windowMaximize),
			windowResizable: toBoolean(d.windowResizable),
			windowMinHeight: parseInt(d.windowMinHeight),
			windowMinWidth: parseInt(d.windowMinWidth),
			windowPositionLeft: d.windowPositionLeft,
			windowPositionTop: d.windowPositionTop,
			advArr: d.advArr,
			winHelpBtn: toBoolean(d.winHelpBtn),
			showAdv: toBoolean(d.showAdv),
			windowHeight: parseInt(d.windowHeight),
			windowWidth: parseInt(d.windowWidth),
			windowSubTitle: companyShortName,
			windowCls: d.windowCls
		}
	};
	// 图标数据适配器
	var iconDataAdapter = function(m, d) {
		var prefix = 'appCategory';
		var ds = {};
		var _ds = {};
		var dIcon = defaultAppData.map(function(d) {
			return d && d.windowsId;
		});
		//遍历数据
		for (i = 0; i < d.length; i++) {
			var dat = d[i];
			var id = dat.appCode;
			var o = m && m[id];

			if (dIcon.indexOf(id) > -1) {
				d.splice(i--, 1);
				continue;
			}
			//如果有记录位置
			if (o&&'i' in o) {
				elsDeskTop.appPosition[id]=o;
				d.splice(i--, 1);
				var cs;
				//如果是图标组
				if (o.g) {
					var g = m[o.g];
					cs = ds[prefix + g.c] = ds[prefix + g.c] || [];
					var gi = cs[g.i] = cs[g.i] || {};
					gi[id] = buildApp(dat);
					gi.k = o.g;
					gi.n = g.n;
					//如果是侧边栏图标
				} else if (o.s) {
					slideArr[o.i] = buildApp(dat);
				} else if(o.h) {
					// 如果是卸载图标
					elsDeskTop.desktop.hideIconsData.push(buildApp(dat));
				}else if (o.c) {
					//如果是桌面图标
					cs = ds[prefix + o.c] = ds[prefix + o.c] || [];
					cs[o.i] = buildApp(dat);
				}
			} else {
				// 无记位置图标
				var cn = prefix + dat.appCategoryId;
				_ds[cn] = _ds[cn] || [];
				_ds[cn].push(buildApp(dat));
			}
		}
		for (var i in _ds) {
			if (_ds.hasOwnProperty(i) && _ds[i]) {
				ds[i] = (ds[i] || []).concat(_ds[i])
			}
		}
		_ds = null;
		return ds;
	};
	var loadAppData = function() {
		return ajaxWorker("rest/RoleAppService/getAllAppList", {
			type: "post",
			contentType: "application/json",
			data: '{"elsAccount":"' + elsAccount + '","elsSubAccount":"' + elsSubAccount + '","roleCode":"' + role + '"}',
			dataType: "json"
		});
	};
	var getMessageCount = function() {
		//审批列表桌面标识数量与实际数量不符合 @author jiangzhidong @date 20161102 begin
		/*var defer = $.Deferred();
		ajaxWorker('rest/MsgService/getMsgCount/' + elsAccount + '/' + elsSubAccount, {
			type: 'get',
			contentType: "application/json",
			dataType: 'json',
			timeout: 5000
		}).done(function(data) {
			var msgCount, todoCount;
			msgCount = data['msgCount'] > 99 ? '99+' : data['msgCount'];
			todoCount = data['todoCount'] > 99 ? '99+' : data['todoCount'];
			initSildeBarOption(msgCount, todoCount);
			defer.resolve();
		}).fail(function() {
			initSildeBarOption();
			defer.resolve();
		});
		return defer.promise();*/
		 $.ajax({
	            url: 'rest/MsgService/getMsgCount/' + elsAccount + '/' + elsSubAccount,
	            type: 'GET',
	            async: false,
	            contentType: 'application/json',
	            data: '',
	            dataType: 'json',
	            success: function (data) {
	            	var msgCount, todoCount;
	    			msgCount = data['msgCount'] > 99 ? '99+' : data['msgCount'];
	    			todoCount = data['todoCount'] > 99 ? '99+' : data['todoCount'];
	    			initSildeBarOption(msgCount, todoCount);
	            },
	            error: function () {
	            	initSildeBarOption();
	            }
	        });
		 //审批列表桌面标识数量与实际数量不符合 @author jiangzhidong @date 20161102 end
	};
	getMessageCount();
	//初始化任务栏
	elsDeskTop.taskBar.init();
	//初始化侧边栏

	$.when(loadAppMap(), loadAppData()).done(function(map, datas) {
		var m = map,
			d = datas[0];
		if (!d) alert(jsLang['i18n_js_plz_check_ac'] || '请检查账号是否正常！');
		var o = iconDataAdapter(m, d);
		var titleArr = [
			jsLang['i18n_js_purchase_manage'] || '采购管理',
			jsLang['i18n_js_sales_manage'] || '销售管理',
			jsLang['i18n_js_common_apps'] || '公共应用',
			jsLang['i18n_js_sys_set'] || '系统设置',
			jsLang['i18n_js_other_ext'] || '增值服务'
		].slice(0, Object.keys(o).length);
		//得到本地(系统)时区
		var timezoneOffset = new Date().getTimezoneOffset() / 60 * -1;
		timezoneOffset = parseInt(timezoneOffset);
		if (timezoneOffset >= 0) {
			timezoneOffset = '+' + timezoneOffset;
		}
		var defaultDeskTop = 0;
		if (role === 'purchase') {
			defaultDeskTop = 0;
		} else if (role === 'sale') {
			defaultDeskTop = 1;
		}
		elsDeskTop.desktop.init(o, {
			arrangeType: 1,
			iconMarginLeft: 15,
			iconMarginTop: 20,
			defaultDesktop: defaultDeskTop,
			appCateName: titleArr,
			extend: (jsLang['i18n_js_time_zone'] || '您当前时区') + ':UTC' + timezoneOffset
		});
		elsDeskTop.sildeBar.init(defaultAppData, slideArr, 'left');
	
		//迈腾-基本信息-检测必填项 @author jiangzhidong date @date 20160801 begin
		ajaxWorker({
			url: "rest/AccountService/needsAccountByNumber/"+elsAccount,
			type: "get",
			contentType: "application/text",
			dataType: "json",
			success: function(data) {
			    if (data.edit == "false") {
					var url='account/editAccount.jsp';
					var mask = $(definedDom('div',{css:{
						display:'none',
						position:'fixed',
						left:'0',
						top:'0',
						right:'0',
						bottom:'0',
						background:'rgba(0, 0, 0, 0.4)'
					}}));
					$('#desktopsContainer').append(mask);
					mask.fadeIn();
					parent.elsDeskTop.defineWin({
						'iconSrc':'icon/destop-icon/desktop2_icon_181.png',
						'windowsId':'PurchaseEnHisPrice',
						'windowTitle':'请完善带*号企业基本信息设置',
						'iframSrc':url,
						windowMinWidth: 900,
						windowMinHeight: 550,
						'windowWidth':900,
						'windowHeight':550,
						windowPositionTop:25,
						'parentPanel':".currDesktop",
						closeEvent:function(){
							mask.fadeOut();
						}
					});
				}
			    //迈腾-系统公告栏  @author jiangzhidong date @date 20161009 begin
			    if (data.fbk5!=null&&data.fbk5!="") {
					var url='account/systemNotice.jsp';
					var mask = $(definedDom('div',{css:{
						display:'none',
						position:'fixed',
						left:'0',
						top:'0',
						right:'0',
						bottom:'0',
						background:'rgba(0, 0, 0, 0.4)'
					}}));
					$('#desktopsContainer').append(mask);
					mask.fadeIn();
					parent.elsDeskTop.defineWin({
						'iconSrc':'icon/destop-icon/desktop2_icon_181.png',
						'windowsId':'PurchaseEnHisPrice',
						'windowTitle':'系统公告栏',
						'iframSrc':url,
						windowMinWidth: 800,
						windowMinHeight: 450,
						'windowWidth':800,
						'windowHeight':450,
						windowPositionTop:25,
						windowPositionLeft:50,
						'parentPanel':".currDesktop",
						closeEvent:function(){
							mask.fadeOut();
						},
						data:data.fbk5
					});
				}
			    //迈腾-系统公告栏  @author jiangzhidong date @date 20161009 end
			},
			error: function() {
				if (!permissionError(data)) {
					initSildeBarOption();
				}
			}
		});
		//迈腾-基本信息-检测必填项 @author jiangzhidong date @date 20160801 end
		
		setTimeout(function() {
			$('#friendlist').trigger('click');
		}, 1000)
	}).fail(function() {
		alert('图标数据加载失败!', 3);
	});

	//判断当前用户的密码状态 @author luokaiyao 2016.1.18
	///////////////////////////////////Start/////////////////////////////////////////////////
	var parmStr = {
		'elsAccount': elsAccount,
		'elsSubAccount': elsSubAccount
	};
	ajaxWorker({
		url: "rest/PassWordService/getAccountPassWordPolicy",
		type: "post",
		contentType: "application/json",
		data: JSON.stringify(parmStr),
		dataType: "json",
		success: function(data) {
			if (data == "LOCKED") {
				alert((jsLang['i18n_js_els_locked'] || "你的账号已被锁定") + '!', 2);
				location.href = "login/logout.jsp";
			}
			if (data == "WARN") {
				//confirm((jsLang['i18n_js_had__reset']||"你的密码已被重置,请修改密码"));
				parent.elsDeskTop.tip.init({
					type: 'confirm',
					message: jsLang['i18n_js_had__reset'] || "你的密码已被重置,请修改密码",
					closeEvent: function() {
						//点击事件跟点击图标事件一致  
						//$("#navBar").click();
						$('#navbarHeaderImg').click();
						$('.ui_boxyClose.message-close').hide();


					},
					cancelEvent: function() {
						// 点击取消
						location.href = "login/logout.jsp";

					}
				});
			}
		},
		error: function() {
			initSildeBarOption();
		}
	});
	
	
	function initSildeBarOption(msgCount, todoCount) {
		/**
		 * 在线客服的url
		 */
		var onlineServiceUrl = "chat2.jsp?fromElsAccount=" + store.currentElsAccount + "&fromElsSubAccount=" + store.elsSubAccount + "&toElsAccount=" + '100000' + "&toElsSubAccount=" + '2001' + "&t=" + new Date().getTime();
		/**
		 * 合作伙伴的高度 与距离的左边的距离
		 */
		var friendlistH = $(window).height() - 100,
			friendlistL = $(window).width() - 480;

		defaultAppData = [{
			'windowCls': 'ui-themeA',
			'iconSrc': 'icon/destop-icon/kefu.png',
			'windowsId': 'onlineService',
			'windowTitle': jsLang['i18n_js_qqt_name'] || '深圳市企企通科技有限公司',
			'windowSubTitle': (jsLang['i18n_js_customer_serv_ol'] || '在线客服') + ' : 4008351881',
			'showAdv': true,
			'iframSrc': onlineServiceUrl,
			'windowWidth': 500,
			'windowHeight': 600,
			'windowMinWidth': 500,
			'windowMinHeight': 600,
			'txNum': 0
		}, {
			'iconSrc': 'icon/icon3.png',
			'windowsId': 'msgManage',
			'windowTitle': jsLang['i18n_js_message_center'] || '消息中心',
			'iframSrc': 'msgManage.jsp',
			'windowWidth': 800,
			'windowHeight': 500,
			'txNum': msgCount || 0,
			'windowStatus': 'maximized'
		}, {
			'iconSrc': 'icon/els.PNG',
			'windowsId': 'friendlist',
			'windowTitle': jsLang['i18n_js_partner'] || '合作伙伴',
			'windowSubTitle': store.companyShortName,
			'iframSrc': 'chat.jsp',
			'windowPositionTop': 0,
			'windowPositionLeft': friendlistL,
			'windowWidth': 280,
			'windowHeight': friendlistH,
			'windowMaximize': false,
			'txNum': 0,
			'windowResizable': false,
			'parentPanel': '.currDesktop',
			'windowStatus': 'regular'
		}, {
			'iconSrc': 'icon/destop-icon/desktop_icon_09.gif',
			'windowsId': 'auditList',
			'windowTitle': jsLang['i18n_js_approval_lis'] || '审批列表',
			'iframSrc': 'audit/auditList.jsp',
			'windowWidth': 600,
			'windowHeight': 750,
			'txNum': todoCount || 0,
			'windowStatus': 'maximized'
		}];
	}

	// open pdf by src
	var openHelpPDFDom = function(src) {
		elsDeskTop.defineWin({
			'iconSrc': 'icon/item2.png',
			'windowsId': 'quickGuide',
			'windowTitle': jsLang['i18n_js_use_guide'] || "使用指南",
			'windowSubTitle': '在这里你可以更好的融入本系统',
			'iframSrc': 'quickGuide.jsp',
			'windowStatus': 'maximized',
			'windowMinWidth': 960,
			'windowMinHeight': 700,
			'windowWidth': 960,
			'windowHeight': 700,
			'parentPanel': ".currDesktop",
			data: {
				pdfSrc: src
			}
		});
	}

	//分角色显示使用指南
	var getRole = role,
		storeGroup = [];

	if (getRole == 'purchase') {
		storeGroup = [
			[{
				id: "item2_0",
				icon: "icon/item2.png",
				text: (jsLang[''] || "采购订单管理"),
				func: function() {},
				childItem: [
					[{
						id: "item2_0_0",
						icon: "icon/item2.png",
						text: (jsLang[''] || "采购订单管理操作手册"),
						func: function() {
							openHelpPDFDom("quickGuide/quick_guide_purchaseOrder_cn2.0.pdf");
						}
					}],
				]
			}],
			[{
				id: "item2_1",
				icon: "icon/item2.png",
				text: (jsLang[''] || "收货"),
				func: function() {},
				childItem: [
					[{
						id: "item2_1_0",
						icon: "icon/item2.png",
						text: (jsLang[''] || "收货操作手册"),
						func: function() {
							openHelpPDFDom("quickGuide/quick_guide_receipt_cn.pdf");
						}
					}],
				]
			}],
			[{
				id: "item2_2",
				icon: "icon/item2.png",
				text: (jsLang[''] || "采购退货"),
				func: function() {},
				childItem: [
					[{
						id: "item2_2_0",
						icon: "icon/item2.png",
						text: (jsLang[''] || "采购退货操作手册"),
						func: function() {
							openHelpPDFDom("quickGuide/quick_guide_refund_cn.pdf");
						}
					}],
				]
			}],
			[{
				id: "item2_3",
				icon: "icon/item2.png",
				text: (jsLang[''] || "采购对账"),
				func: function() {},
				childItem: [
					[{
						id: "item2_3_0",
						icon: "icon/item2.png",
						text: (jsLang[''] || "采购对账操作手册"),
						func: function() {
							openHelpPDFDom("quickGuide/quick_guide_purchaseReconciliation_cn.pdf");
						}
					}],
				]
			}],

		]
	} else if (getRole == 'sale') {
		storeGroup = [
			[{
				id: "item2_0",
				icon: "icon/item2.png",
				text: (jsLang[''] || "销售订单管理"),
				func: function() {},
				childItem: [
					[{
						id: "item2_0_0",
						icon: "icon/item2.png",
						text: (jsLang[''] || "销售订单管理操作手册"),
						func: function() {
							openHelpPDFDom("quickGuide/quick_guide_saleOrder_cn.pdf");
						}
					}],
				]
			}],
			[{
				id: "item2_1",
				icon: "icon/item2.png",
				text: (jsLang[''] || "发货"),
				func: function() {},
				childItem: [
					[{
						id: "item2_1_0",
						icon: "icon/item2.png",
						text: (jsLang[''] || "发货操作手册"),
						func: function() {
							openHelpPDFDom("quickGuide/quick_guide_delivery_cn.pdf");
						}

					}],
				]
			}],
			[{
				id: "item2_2",
				icon: "icon/item2.png",
				text: (jsLang[''] || "销售退货"),
				func: function() {},
				childItem: [
					[{
						id: "item2_2_0",
						icon: "icon/item2.png",
						text: (jsLang[''] || "销售退货操作手册"),
						func: function() {
							openHelpPDFDom("quickGuide/quick_guide_confirmRefund_cn.pdf");
						}

					}],
				]
			}],
			[{
				id: "item2_3",
				icon: "icon/item2.png",
				text: (jsLang[''] || "销售对账"),
				func: function() {},
				childItem: [
					[{
						id: "item2_3_0",
						icon: "icon/item2.png",
						text: (jsLang[''] || "销售对账操作手册"),
						func: function() {
							openHelpPDFDom("quickGuide/quick_guide_saleReconciliation_cn.pdf");
						}

					}],
				]
			}],

		]
	}

	//初始化开始菜单
	elsDeskTop.startBtn.init([
		[{
			id: "item0",
			text: jsLang['i18n_js_login_info'] || "登录信息",
			icon: "icon/item1.png",
			func: function() {},
			childItem: [
				[{
					id: "item0_0",
					icon: "icon/item1.png",
					text: (jsLang['i18n_js_els_acc'] || "企业账号") + "：" + store.currentElsAccount,
					func: function() {}
				}],
				[{
					id: "item0_1",
					icon: "icon/item1.png",
					text: (jsLang['i18n_login_elsSubAccount'] || "个人账号") + "：" + store.elsSubAccount,
					func: function() {}

				}],
				[{
					id: "item0_2",
					icon: "icon/item1.png",
					text: (jsLang['i18n_js_login_time'] || "登陆时间") + "：" + new Date().toLocaleDateString(),
					func: function() {}

				}],
				[{
					id: "item0_3",
					icon: "icon/item1.png",
					text: (jsLang['i18n_js_browser'] || "浏览器") + "：" + store.bs,
					func: function() {}
				}],
				[{
					id: "item0_4",
					icon: "icon/item1.png",
					text: "IP：" + store.ip,
					func: function() {}

				}],
				[{
					id: "item0_5",
					icon: "icon/item1.png",
					text: (jsLang['i18n_js_os'] || "操作系统") + "：" + store.os,
					func: function() {}

				}],
				[{
					id: "item0_5",
					icon: "icon/item1.png",
					text: (jsLang['i18n_js_language'] || "语言") + "：" + store.language,
					func: function() {}

				}]
			]
		}],
		[{
			id: "item1",
			text: jsLang['i18n_js_sys_set'] || "系统设置",
			icon: "icon/item0.png",
			func: function() {
				$('#navBar').find('a[title=' + (jsLang['i18n_js_sys_set'] || '系统设置') + ']').trigger('click');
			}
		}],
		[{
			id: "item2",
			text: jsLang['i18n_js_use_guide'] || "使用指南",
			icon: "icon/item2.png",
			childItem: storeGroup
		}],
		[{
			id: "item3",
			text: jsLang['i18n_js_about_us'] || "关于我们",
			icon: "icon/els.PNG",
			func: function() {
				parent.elsDeskTop.defineWin({
					'iconSrc': 'icon/els.PNG',
					'windowsId': 'aboutUs',
					'windowTitle': jsLang['i18n_js_about_us'] || "关于我们",
					'iframSrc': 'http://www.els123.com/',
					'windowStatus': 'maximized',
					'windowMinWidth': 960,
					'windowMinHeight': 700,
					'windowWidth': 960,
					'windowHeight': 700,
					'parentPanel': ".currDesktop"
				});
			}
		}],
		[{
			id: "item4",
			text: jsLang['i18n_js_logout'] || "退出系统",
			icon: "icon/item3.png",
			func: function() {
				elsDeskTop.cookie.removeItem('autoLogin');
				location.href = "login/logout.jsp";
			}
		}]
	]);

	//初始化桌面右键菜单
	var data = [
		[{
			text: jsLang['i18n_js_show_desktop'] || "显示桌面",
			func: function() {
				$("div.myWindow").not(".hideWin")
					.each(function() {
						$(this).find(".winMinBtn").trigger("click");
					});
			}
		}],
		[{
			text: jsLang['i18n_js_refresh'] || "刷新页面",
			func: function() {
				elsDeskTop.desktop.reload();
			}
		}],
		[{
			text: jsLang['i18n_js_sys_set'] || "系统设置",
			func: function() {}
		}, {
			text: jsLang['i18n_js_theme_set'] || "主题设置",
			func: function() {
				$("#them_btn").click();
			}
		}],
		[{
			text: jsLang['i18n_js_about_qqt'] || '关于企企通科技',
			func: function() {
				parent.elsDeskTop.defineWin({
					'iconSrc': 'icon/els.PNG',
					'windowsId': 'aboutUs',
					'windowTitle': jsLang['i18n_js_about_qqt'] || '关于企企通科技',
					'iframSrc': 'http://www.els123.com/',
					'windowStatus': 'maximized',
					'windowMinWidth': 960,
					'windowMinHeight': 700,
					'windowWidth': 960,
					'windowHeight': 700,
					'parentPanel': ".currDesktop"
				});
			}
		}],
		[{
			text: jsLang['i18n_js_logout'] || "退出系统",
			func: function() {
				elsDeskTop.cookie.removeItem('autoLogin');
				location.href = "login/logout.jsp";
			}
		}]
	];
	elsDeskTop.contextMenu($(document.body), data, "body", 10);
	//初始化侧边栏多语言title
	$('#showZm_btn').attr({
		'title': jsLang['i18n_js_full_screen'] || '全屏(IE环境请直接按F11)'
	});
	$('#search_app_btn').attr({
		'title': jsLang['i18n_js_search_app'] || '查找应用'
	});
	$('#reset_btn').attr({
		'title': jsLang['i18n_js_reset_app'] || '恢复默认设置'
	});
	$('#them_btn').attr({
		'title': jsLang['i18n_js_theme_set'] || '主题设置'
	});
	$('#start_btn').attr({
		'title': jsLang['i18n_js_begin_menu'] || '开始菜单'
	});
});