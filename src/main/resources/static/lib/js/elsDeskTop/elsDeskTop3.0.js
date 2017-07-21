!function () {
	/*-----------------------------------------------------------
	 *version: mydesktop 3.0
	 *author: pssdss
	 *email: 530624206@qq.com
	 *blog: http://www.pssdss.com/
	 *date:2013-1-24
	 *桌面组件脚本，包括窗口、状态栏、侧边栏、桌面、桌面导航切换、全局视图、登录框
	 ----------------------------------------------------------*/
	var deskTopData, $body, innerDesktop,dragEventType,iconCategories=[];
	iconCategories[5]=undefined;
	// 缓存不变的对象和初始化容错
	var _,appMap = elsDeskTop.appPosition={};
	var _wins={};
	var creatGroupId = function(a){
		var i = 'g_'+((new Date()|1)+~~a).toString(36);
		if(appMap[i])return creatGroupId(1000);
		return i;
	};
	var createCacheElm = function(selector,n){
		if(typeof selector==='object'&&n===undefined){
			for(var i in selector){
				if(selector.hasOwnProperty(i)){
					createCacheElm(selector[i],i);
				}
			}return;
		}
		var opt={},p;
		if(selector instanceof Array && selector.length===2){
			p=selector[0];
			selector = selector[1];
		}
		_['_'+n]=$([]);
		opt[n]={
			get:function(){
				if(0===_['_'+n].length){
					_['_'+n] = p? p.find(selector):$(selector)
				}
				return _['_'+n];
			}
		};
		Object.defineProperties(_,opt);
	};

//创建myWindow命名空间
	elsDeskTop.clearCache=function(){
		_= {
			_ds: $([]), desktopNum: 0, get desktops() {
				if (0 === this.desktopNum) {
					this._ds = $('.desktop');
					this.desktopNum = this._ds.length;
				}
				return this._ds;
			}};

		createCacheElm({
			innerDesktop						: '.innerDesktop',
			outerDesktop					: '.outerDesktop',
			desktopsContainer			: '#desktopsContainer',
			desktopContainer				: '#desktopContainer',
			bottomBarBgTask				: '#bottomBarBgTask',
			navBar									: '#navBar',
			topBar									: '#topBar',
			leftBar								: '#leftBar',
			rightBar								: '#rightBar',
			body									: 'body'
		});
	};
	elsDeskTop.clearCache();

	elsDeskTop.myWindow = {
		init: function (_opt) {
			var wh = {'w': $(window).width(), 'h': $(window).height()},//浏览器窗口宽度、高度
				curWinNum = $('.myWindow').size(),//当前已打开窗口数量
				$timeImg = 0, //广告图片轮播的定时器对象
			//默认参数配置
				defaults = {
					friendElsAccount:'', /* 打开对方空间 */
					elsId: '', /* els账号,有值就显示个人信息，无值就不显示个人信息*/
					windowCls: '', /* 窗口自定义Class*/
					windowTitle: null, /* true, false窗口标题*/
					appCategoryId: null, /* appCategoryId 对应当前的窗口*/
					windowSubTitle: '', /*子标题内容*/
					showAdv: false, /*是否显示广告*/
					advArr: [], /*存放广告图片的数组*/
					windowsId: null, /* true, false窗口id*/
					iconSrc: null,
					windowPositionTop: 'center', /* Posible are pixels or 'center' 窗口初始位置top*/
					windowPositionLeft: 'center', /* Posible are pixels or 'center' 窗口初始位置left*/
					windowWidth: Math.round(wh['w'] * 0.6), /* Only pixels 窗口宽度*/
					windowHeight: Math.round(wh['h'] * 0.8), /* Only pixels 窗口高度*/
					windowMinWidth: 250, /* Only pixels 窗口最小宽度*/
					windowMinHeight: 250, /* Only pixels窗口最小高度 */
					iframSrc: null, /* iframe的src路径*/
					data: null, /* 传递给iframe的参数 */
					winHelpBtn: false, /*是否显示帮助按钮*/
					winHelpClick: '#item2', /*帮助按钮链接*/
					windowResizable: true, /* true, false是否可以resize窗口*/
					windowMaximize: true, /* true, false是否可以最大化窗口*/
					windowMinimize: true, /* true, false是否可以最小化窗口*/
					windowClosable: true, /* true, false是否可以关闭窗口*/
					windowDraggable: true, /* true, false是否拖曳窗口*/
					windowStatus: 'regular', /* 'regular', 'maximized', 'minimized' 打开窗口时显示状态*/
					windowAnimationSpeed: 500, /* 动画执行时间*/
					windowAnimation: false, /* true, false 是否启用动画*/
					parentPanel: 'body', /* 窗口被插入的容器元素*/
					summary: '', /*个性签名*/
					closeEvent: function () {
					}                   /* 关闭窗口时回调函数*/
				},
				 options = $.extend({},defaults, _opt,{showAdv:false}),
				$newWin = $('#win_' + options['windowsId']), //当前打开的窗口
				//窗口html结构
				winHtml = function (options) {
					return definedDom('div', {
						class: 'myWindow ' + (options.showAdv ? 'adv-show ' : '') + (options.windowCls || ''),
						id: 'win_' + options.windowsId,
						func: function () {
							var $this = $(this);
							$this.on('zindexchange', function (e, z) {
								$this.removeClass('topWin').find('.iframeFix').show();
								var z1 = parseInt(this.style.zIndex);
								var z2 = parseInt(z);
								if (0 !== z2 && z1 > z2) this.style.zIndex = --z1;
							})
						},
						children: [{
							tag: 'div', class: 'winTitle',alt: 'img',
							css: {
								'min-height': 'friendlist' === options.windowsId ? '74px' : '',
								'border-color': 'rgba(' + elsDeskTop.themeSkinType.r
								+ ',' + elsDeskTop.themeSkinType.g
								+ ',' + elsDeskTop.themeSkinType.b
								+ ',' + elsDeskTop.themeSkinType.a
								+ ')',
								'background-color': 'rgba(' + elsDeskTop.themeSkinType.r
								+ ',' + elsDeskTop.themeSkinType.g
								+ ',' + elsDeskTop.themeSkinType.b
								+ ',' + elsDeskTop.themeSkinType.a
								+ ')'
							},
							children: [{
								tag: 'img', class: 'icon-application float-left', src: options.iconSrc,
								title: options.elsId ? jsLang['i18n_js_show_base_info'] || '显示基本信息' : '',
								onclick: basicMessage.bind(null, options),
								css: {cursor: options.elsId ? 'default' : ''}
							}, {
								tag: 'span', class: 'winTitleName win-head-title dis-in-b',
								children: [{text: options.windowTitle + ' '}].concat(
									'friendlist' !== options.windowsId ? [
										{tag: 'br'}, {text: options.windowSubTitle ? options.windowSubTitle : ''}
									] : [])
							}, options.showAdv ? {tag: 'div', class: 'adv-wrap',
								children: [{tag: 'div', class: 'adv-body-wrap',
									children: options.advArr && options.advArr.length ? (('string' === typeof options.advArr) && options.advArr.split(',') || options.advArr).map(function (a, i) {
										a= a.split('|');
										return {tag: 'img',css:{
											cursor:'pointer'
										}, class: '' + i, src: a[0], alt: 'img',onclick:a[1]&&function(){top.$('#'+a[1]).click()}}
									}) : []
								}]
							} : {}, (options.summary && options.summary.length>30) ?
							{tag: 'marquee', class: 'winTitleSummary', text: options.summary || '', scrollamount: '5'} : {'tag':'span','css':{'color':'#fff','lineHeight':'26px'}},
								{tag: 'span', class: 'winControlBtn',
								children: [
									options.winHelpBtn &&
									{tag: 'a', href: '#', class: 'winHelpBtn', text:'帮助',title: jsLang['i18n_js_help'] || '帮助',
										onclick: function (e) {
											e.preventDefault();
											var c = options.winHelpClick;
											if (typeof c === 'function') {
												c();
											} else if (typeof c === 'string') {
												if(c==='#item2')return $('#item2').trigger('click');
												elsDeskTop.defineWin({
													'iconSrc':'icon/item2.png',
													'windowsId':'quickGuide'+options.windowsId,
													'windowTitle':(jsLang['i18n_js_use_guide']||"使用指南") + '-'+options.windowTitle,
													'iframSrc':'quickGuide.jsp',
													'windowStatus': 'maximized',
													'windowMinWidth': 960,
													'windowMinHeight': 700,
													'windowWidth':960,
													'windowHeight':700,
													'parentPanel':".currDesktop",
													data:{pdfSrc:c}
												});
											}
										}
									},
									{tag: 'a', href: '#', class: 'winMinBtn', title: jsLang['i18n_js_minimize'] || '最小化'},
									{tag: 'a', href: '#', class: 'winMaxBtn', title: jsLang['i18n_js_maximize'] || '最大化'},
									{tag: 'a', href: '#', class: 'winRestore', title: jsLang['i18n_js_restore'] || '还原'},
									{tag: 'a', href: '#', class: 'winCloseBtn', title: jsLang['i18n_js_close'] || '关闭'}
								]
							}, 'friendlist' === options.windowsId ? {
								tag: 'div',
								css: {
									borderTop: '#6D6D6D 1px solid',
									borderColor: 'rgba(' + elsDeskTop.themeSkinType.r + ',' + elsDeskTop.themeSkinType.g + ',' + elsDeskTop.themeSkinType.b + ',' + elsDeskTop.themeSkinType.a + ')',
									marginTop: '27px'
								},
								children: [{
									tag: 'img',
									class: 'icon-application float-left',
									src: location.href.match(/https?:\/\/.*?\//)[0] + ('opt/nfsshare/' + logo || 'icon/icon1.png'),
									onerror: function () {
										this.src = 'icon/icon1.png';
									},
									onclick: function () {
										//$('#navbarHeaderImg').click()
										basicMessage({'elsId':elsAccount});
									},
									css: {
										width: '35px',
										height: '35px',
										paddingLeft: '4px'
									}
								}, {
									tag: 'div',
									css: {
										marginTop: '5px',
										paddingLeft: '24px',
										opacity: '.9'
									},									
									children: [{
										tag: 'span',
										class: 'win-head-elsAc',
										title: options.windowSubTitle ? options.windowSubTitle : '',
										text: options.windowSubTitle ? options.windowSubTitle : '',
									},{
										tag: 'span',
										class: 'win-head-elsSubAc',
										title: username,
										text: username
									}]
								}, {
									tag: 'br'
								}, {
									tag: 'div',
									css: {
										marginTop: '-5px',
										paddingLeft: '24px',
										opacity: '.9'
									},
									children: [{
										tag: 'span',
										class: 'win-head-elsAc',
										text: (jsLang['i18n_js_els_ac'] || 'ELS账号') + ':    ' + elsAccount
									}, {
										tag: 'span',
										class: 'win-head-elsSubAc',
										text: (jsLang['i18n_js_els_sub_ac'] || '子账号') + ':    ' + elsSubAccount
									}]
								}]
							} : {}]
						}, {
							tag: 'div',
							class: 'winContent bg-total-color',
							children: [
								{
									tag: 'div',
									class: 'loading',
									text: jsLang['i18n_js_loading'] || '加载中'
								}, {
									tag: 'iframe',
									onload: function (e) {
										var ifr = e.target;
										if(!ifr.contentWindow)return console.log('can not open ifr.contentWindow at', ifr.src);
										var _b = ifr.contentWindow.beforeClose;
										Object.defineProperties(ifr.contentWindow, {
											beforeClose: {
												get: function () {return ifr.beforeIframeClose},
												set: function (v) {ifr.beforeIframeClose = v}
											}
										});
										if (_b)ifr.beforeIframeClose = _b;
									},
									scrolling: 'auto',
									frameBorder: 0,
									class: 'iframeApp',
									name: 'iframeApp_' + options.windowsId,
									id: 'iframeApp_' + options.windowsId,
									src: ''
								}, {
									tag: 'div',
									class: 'iframeFix',
									id: 'iframeFix_' + options.windowsId
								}
							]
						}]
					});
				},
				_self = this;

			//新建窗口,并判断此窗口是否已经存在
			if (!$newWin.size()) {
				$(winHtml(options, elsDeskTop.themeSkinType)).appendTo('#desktopContainer');
				$newWin = $("#win_" + options['windowsId']);
				var $allWins = $(".myWindow"),
					$loading = $newWin.find("div.loading"),
					$winTitle = $newWin.find("div.winTitle"),
					winMaximize_btn = $newWin.find('a.winMaxBtn'),//最大化按钮
					winMinimize_btn = $newWin.find('a.winMinBtn'),//最小化按钮
					winClose_btn = $newWin.find('a.winCloseBtn'),//关闭按钮
					winHyimize_btn = $newWin.find('a.winRestore');//还原按钮
				$newWin.options = options;

				//设置窗口位置、大小
				var $topWin = $("div.topWin"),
					dy = Math.floor((Math.random() * 60)) + (wh['h'] - options['windowHeight']) / 2, //偏移量
					dx = Math.floor((Math.random() * 60)) + (wh['w'] - options['windowWidth']) / 2, //偏移量
					zindex = curWinNum ? parseInt($topWin.css("z-index")) + 1 : curWinNum + 100,
					wLeft = (options['windowPositionLeft'] == 'center') ? dx : parseInt(options['windowPositionLeft']),
					wTop = (options['windowPositionTop'] == 'center') ? dy : parseInt(options['windowPositionTop']);

				//初始化窗口
				$allWins.removeClass("topWin").find("div.iframeFix").show();
				var $newWinIframe = $newWin
					.addClass("topWin")
					.css({
						"width": options['windowWidth'],
						"height": options['windowHeight'],
						"left": wLeft,
						"top": wTop,
						"z-index": zindex
					})
					.find("div.winContent")
					.css({"width": options['windowWidth'], "height": options['windowHeight'] - $winTitle.height()})
					.find("iframe")
					.attr("src", options['iframSrc']);

				var ifr = $newWinIframe[0];
				ifr.parentData = options['data'];
				ifr.onparentdataload = ifr.onparentdataload || $.noop;
				ifr.onparentdataload(options['data']);

				$newWinIframe.load(function () {//当iframe加载完毕
						$loading.hide();
						$(this).css("left", 0);
					})
					.end()
					.find("div.iframeFix")
					.hide();

				//更新窗口当前位置大小信息
				$newWin.data('winLocation', {
					'w': options['windowWidth'],
					'h': options['windowHeight'],
					'left': wLeft,
					'top': wTop
				});

				//是否显示最大化按钮
				if (!options.windowMaximize) {
					winMaximize_btn.hide();
				}

				//是否显示最小化按钮
				if (!options.windowMinimize) {
					winMinimize_btn.hide();
				}

				//是否显示关闭按钮
				if (!options.windowClosable) {
					winClose_btn.hide();
				}
				//每一秒轮播一次广告
				if (options.showAdv && options.advArr && options.advArr.length) {
					var imgChangeArr = $newWin.find('div.adv-body-wrap').find('img'),
						ind = 0;
					var storeImgs = (typeof options.advArr === 'string') && options.advArr.split(',') || options.advArr;
					$timeImg = setInterval(function () {
						$(imgChangeArr[ind]).show();
						$(imgChangeArr).not('.' + ind).hide();
						ind++;
						if (ind == storeImgs.length) {
							ind = 0;
						}
					}, 5000);
				}
				//多个窗口上下切换
				$allWins.mousedown(function (event) {
					event.stopPropagation();
					elsDeskTop.myWindow.setTopWin($(this));
				});

				//启用窗口拖动
				if (options.windowDraggable) {
					_self.winDrag($newWin);
				}

				//启用拖曳改变窗口大小
				if (options.windowResizable) {
					_self.winResize($newWin, [options.windowMinWidth, options.windowMinHeight, wh['w'] - wLeft, wh['h'] - wTop]);
				}
				// 单个应用初始化显示在状态栏
				//添加到状态栏
				//if(!$("#taskTab_"+options.windowsId).size() && options.type){
				//	elsDeskTop.taskBar.addTask(options.windowsId,options.windowTitle,options.iconSrc);
				//}
				//关闭窗口
				winClose_btn.click(function () {
					if ($timeImg) {
						clearInterval($timeImg);
					}
					_self.winClose($newWin);
					var fun = $.isFunction(options.closeEvent) ? options.closeEvent : $.noop;
					fun.call(fun, options.windowsId);
				});

				//最大化窗口
				winMaximize_btn.click(function () {
					//var res = options.type? true: false;
					_self.winMaximize($newWin);
				});

				//最小化窗口
				winMinimize_btn.click(function () {
					_self.winMinize($newWin);
				});

				//还原窗口
				winHyimize_btn.click(function () {
					_self.winHyimize($newWin);
				});

				//双击标题栏最大化、还原窗口
				$winTitle.dblclick(function () {
					var hasMaximizeBtn = $(this).find(winMaximize_btn);
					if (!hasMaximizeBtn.is(":hidden")) {
						winMaximize_btn.trigger("click");
					} else {
						winHyimize_btn.trigger("click");
					}
				});

				if (options.windowStatus == "maximized") {
					winMaximize_btn.trigger("click");
				}

				if (options.windowStatus == "minimized") {
					winMinimize_btn.trigger("click");
				}

				//当改变浏览器窗口时且窗口处于最大化状态
				$(window).wresize(function () {
					if ($newWin.is(':not(.hideWin)') && $newWin.data('windowStatus') == "maximized") {
						//var res = options.type? true: false;
						_self.winMaximize($newWin, true);
					}
					//更新窗口大小
					if (options.windowResizable)
						_self.winResize($newWin, [options.windowMinWidth, options.windowMinHeight, $(window).width(), $(window).height()]);
				});
				var usageData;
				var paramFriendEls = options.friendElsAccount;
				if("undefined" == typeof(paramFriendEls) || ""==paramFriendEls || "null"==paramFriendEls){//从桌面图标进入应用
					usageData = {
						appCode : options.windowsId,//应用编码
						appCategoryId : options.appCategoryId,//应用类别(分类页)
						appName : options.windowTitle,//应用名称
						appUrl : options.iframSrc//应用路径
					};
				} else {//针对对方ELS进入应用时参数与桌面进入不同,需分别处理
					var appCodeStr = options.windowsId;//windowsId附带了对方ELS号,需截取
					var urlStr = options.iframSrc;//iframSrc附带了参数,需截取
					if(appCodeStr.indexOf("_") >=0){
						appCodeStr = appCodeStr.substring(0,appCodeStr.indexOf("_"));
					}
					if(urlStr.indexOf("?") >=0){
						urlStr = urlStr.substring(0,urlStr.indexOf("?"));
					}
					usageData = {
						appCode : appCodeStr,//应用编码
						appCategoryId : "",//应用类别(分类页)-无
						appName : options.windowSubTitle,//应用名称数据位于windowSubTitle
						appUrl : urlStr//应用路径
					};
				}
				//ajaxWorker({
				//	url : "rest/ElsUsageInfoService/addUsageInfo",
				//	contentType : "application/json",
				//	type : "post",
				//	data : JSON.stringify(usageData),
				//	dataType : "json"
				//})
				return $newWin;

				//已经存在窗口
			} else {
				$("#taskTab_" + options.windowsId).trigger("click");
			}
			return $newWin;
		},
		//拖动窗口
		winDrag: function ($newWin) {
			var wh = {'w': $(window).width(), 'h': $(window).height()};
			$newWin
				.draggable({
					handle: 'div.winTitle',
					scroll: false
				})
				.bind('drag', function () {
					$(this).find('.iframeFix').show();
				})
				.bind('dragstop', function (event) {
					$(this).find('.iframeFix').hide();

					//限制窗口拖曳范围
					if (event.pageY > wh.h - 80) {
						$(this).css('top', wh.h - 80);
					} else if (event.pageY < 0) {
						$(this).css('top', 0);
					}

					//更新窗口当前位置大小信息
					$newWin.data('winLocation', {
						'w': $(this).width(),
						'h': $(this).height(),
						'left': $(this).css('left'),
						'top': $(this).css('top')
					});

				});
		},
		//拖曳改变窗口大小
		winResize: function ($newWin, arr) {
			var wintitHeight = $newWin.find('.winTitle').height();
			$newWin
				.resizable({
					minWidth: arr[0],
					minHeight: arr[1],
					containment: 'document',
					maxWidth: arr[2],
					maxHeight: arr[3],
					autoHide: true,
					handles: 'n, e, s, w, ne, se, sw, nw, all',
					helper: 'ui-resizable-helper'
				})
				.css('position', 'absolute')
				.on('resize', function (e) {
					e.stopPropagation();
					e.preventDefault();
					$(this).find('div.iframeFix').show();
				})
				.on('resizestop', function (e, ui) {
					e.stopPropagation();
					e.preventDefault();
					var h = $(this).innerHeight(), w = $(this).innerWidth();
					$(this)
						.find('div.winContent')
						.css({'width': w, 'height': h - wintitHeight})
						.end()
						.find('div.iframeFix')
						.hide();
					var wh = ui.size, lt = ui.position;
					//更新窗口当前位置大小信息
					$newWin.data('winLocation', {
						'w': wh.width,
						'h': wh.height,
						'left': lt.left,
						'top': lt.top
					});
				});
		},
		setTopWin: function ($newWin) {
			$newWin.find('.iframeFix').hide();
			if (!$newWin.hasClass('topWin')) {
				$newWin.siblings('.myWindow:not(.hideWin)').trigger('zindexchange', $newWin.css('z-index'));
				$newWin.css('z-index', 99 + $('.myWindow:not(.hideWin)').size()).addClass('topWin');
				elsDeskTop.taskBar.upTaskTab($newWin.attr("id"));
			}
		},
		//移除、最小化当前窗口时候 更新其他窗口层级和设置最顶层窗口 。
		setNextTopWin: function ($newWin) {
			$newWin.removeClass('topWin');
			var topWin = undefined;
			$newWin.siblings('.myWindow:not(.hideWin)').trigger('zindexchange', $newWin.css('z-index')).each(function (i, elm) {
				if (!topWin)topWin = elm;
				else {
					if (parseInt(elm.style.zIndex) > parseInt(topWin.style.zIndex))topWin = elm;
				}
			}).end().css('z-index', '0');
			topWin = $(topWin);
			topWin.addClass('topWin');
			elsDeskTop.taskBar.upTaskTab(topWin.attr("id"));
		},
		//关闭窗口
		winClose: function ($newWin) {
			var before = $newWin.find('iframe.iframeApp')[0].beforeIframeClose;
			var func = $newWin.find('iframe.iframeApp')[0].onIframeClose;
			if (typeof  func === 'function') {
				func();
			}
			var c = function(){
				elsDeskTop.myWindow.setNextTopWin($newWin);
				elsDeskTop.taskBar.removeTaskTab($newWin.attr("id"));
				delete _wins[$newWin.attr('id')]
				$newWin.remove();
			};
			if(typeof before === 'function'){
				return before.call(this,function(){
					c();
				});
			}else if(before){
				top.elsDeskTop.tip.init({
					type            : 'confirm',
					displayType     : 2,
					message         : typeof before==='string'?before:'确认关闭?',
					closeEvent : function () {
						c();
					}
				});
			} else c();
		},
		//最大化窗口
		winMaximize: function ($newWin, keepIndex) {
			if (!keepIndex)elsDeskTop.myWindow.setTopWin($newWin);
			var wh = {'w': $(window).width(), 'h': $(window).height()},
				winHyimize_btn = $newWin.find("a.winRestore"),
				winMaximize_btn = $newWin.find("a.winMaxBtn"),
				navBar = $("#navBar"),
				leftBar = $("#leftBar"),
				rightBar = $("#rightBar"),
				topBar = $("#topBar"),
				l = 0, t = 0;
			var slideWidth = topBar.is(":hidden") ? leftBar.width() : 0,
				topHeight = topBar.is(":hidden") ? navBar.height() : topBar.height();
			if (!leftBar.is(":hidden")) {
				l = slideWidth * -1;
				t = topHeight * -1;
			} else {
				l = 0;
				t = topHeight * -1;
			}
			var fixBottom = !localStorage.getItem('tbp')&&30||0;
			$newWin
				.data("windowStatus", "maximized")
				.draggable("disable")
				.resizable("disable")
				.removeClass("ui-state-disabled")
				.addClass("maxWin")
				//.css({"width":wh['w']-2,"height":wh['h'],"left":l,"top":t})
				.css({"width": wh['w'], "height": wh['h'] -fixBottom, "left": l, "top": t})
				.find("div.winContent")
				.css({"width": wh['w'], "height": wh['h'] -fixBottom- ($newWin.options.showAdv ? 61 : 31)});
			winMaximize_btn.hide();
			winHyimize_btn.css("display", "inline-block");
		},
		//还原窗口
		winHyimize: function ($newWin) {
			elsDeskTop.myWindow.setTopWin($newWin);
			var winInfo = $newWin.data("winLocation"),
				winHyimize_btn = $newWin.find("a.winRestore"),
				winMaximize_btn = $newWin.find("a.winMaxBtn");
			$newWin
				.data("windowStatus", "regular")
				.draggable("enable")
				.resizable("enable")
				.removeClass("maxWin")
				.css({"width": winInfo.w, "height": winInfo.h, "left": winInfo.left, "top": winInfo.top})
				.find("div.winContent")
				.css({"width": winInfo.w, "height": winInfo.h - ($newWin.options.showAdv ? 61 : 30)});
			winHyimize_btn.hide();
			winMaximize_btn.show();
		},
		//最小化窗口
		winMinize: function ($newWin) {
			var p = $("div.desktop").index($newWin.parent());
			$newWin.data({"oldLeft": $newWin.css("left"), "index": p}).css("left", -99999).addClass("hideWin");
			elsDeskTop.taskBar.upTaskTab($newWin.attr("id"));
			elsDeskTop.myWindow.setNextTopWin($newWin);
		}
	};

//创建wallpaper命名空间
	/*背景平铺三种类型,1背景拉伸,2背景居中,3背景自适应屏幕*/
	elsDeskTop.wallpaper = {
		init: function (imgUrl, type) {
			var _self = this;
			$("body").data("wallpaperType", type);

			if (type != 3) {
				elsDeskTop.getImgWh(imgUrl, function (imgWidth, imgHeight) {
					$("#wallpaper").html("<img src='" + imgUrl + "' />");
					_self.setWallpaper(imgWidth, imgHeight, type);

					$(window).wresize(function () {
						_self.setWallpaper(imgWidth, imgHeight, type);
					});
				});

			} else { //背景平铺
				$("#wallpaper").css({
					"background": "url(" + imgUrl + ") repeat 0 0",
					"height": $(window).height()
				}).fadeTo('slow', 1);
			}

		},
		setWallpaper: function (imgWidth, imgHeight, type) {
			var winW = $(window).width(),
				winH = $(window).height();

			if (type == 1) {//如果是拉伸
				$("#wallpaper").find("img").css({'width': winW, 'height': winH});
			}

			if (type == 2) {//如果是居中
				if (imgWidth > winW) {
					$("#wallpaper").find("img").css({
						'width': imgWidth,
						'height': imgHeight,
						'margin-left': (imgWidth - winW) / 2 + "px",
						'margin-top': (imgHeight - winH) / 2 + "px"
					});
				} else {
					$("#wallpaper").find("img").css({
						'width': imgWidth,
						'height': imgHeight,
						'margin-left': -(imgWidth - winW) / 2 + "px",
						'margin-top': -(imgHeight - winH) / 2 + "px"
					});
				}
			}
		},
		updateWallpaper: function (imgSrc) {
			//alert(imgSrc);
			var type = $("body").data("wallpaperType");
			this.init(imgSrc, type);
		}
	};


//创建桌面控制栏desktopBar
	elsDeskTop.desktopBar = {
		init: function (desktopNum, index, cateNameArr) {
			var navBar = $("#navBar"),
				nav = "",
				bottomBarBgTask = $("#bottomBarBgTask"),
				_self = this;
			//桌面图标归类
			// var appType = ['采购管理','销售管理','公共应用','系统设置','其他扩展'];
			for (var i = 0; i < desktopNum; i++) {
				i == index ? nav += "<a href='#' class='currTab' title='" + cateNameArr[i] + "'>" + (i + 1) + "</a>" : nav += "<a href='#' title='" + cateNameArr[i] + "'>" + (i + 1) + "</a>";
			}
			navBar
				.find("span")
				.html(nav)
				.end()
				.css("margin-left", (navBar.width() + 20) * -1 / 2)
				.draggable({
					disabled: true,
					scroll: false,
					containment: "body"
				});
			//单击tab切换桌面
			var tabs = navBar.find("span > a");
			tabs
				.on("click", function () {
					_self.moveDesktop(tabs.index($(this)));
				})
				.droppable({
					scope: 'a',
					over: function () {
						_self.moveDesktop(tabs.index($(this)));
					}
				});

			//单击头像，弹出登陆框
			$("#navbarHeaderImg").click(function () {
				elsDeskTop.personal.init("personal.jsp");
			});
			//单击全局视图
			$("a.indicator_manage").click(function () {
				//初始化全局视图
				elsDeskTop.appManagerPanel.init();
				$("#appManagerPanel").css("top", 0).show();
				$("#desktopWrapper").hide();
			});
		},
		moveDesktop: function (i) {
			var navBar = $("#navBar"),
				tabs = navBar.find("span > a"),
				innerDesktop = $("div.innerDesktop");
			innerDesktop.hide();
			_.desktops.eq(i).animate({left: 0}, 500, "easeInOutQuint");
			innerDesktop.eq(i).show();
			tabs.removeClass("currTab").eq(i).addClass("currTab");
			_.desktops.removeClass("currDesktop").eq(i).addClass("currDesktop");
			for (var j = 0; j < _.desktopNum; j++) {
				_.desktops.eq(j).css('left', j > i ? '2000px' : '-2000px');
			}
		}
	};

//创建desktop命名空间
	elsDeskTop.desktop = {
		get:function(id){
			return _wins[id];
		},
		reload:function(){
			elsDeskTop.clearCache();
			$('body').html('<div id="desktopWrapper"><div id="topBar"></div><div id="leftBar"><div id="dockBar">' +
				'</div><div id="dockContainer" class="dock_container pin dock_pos_left">' +
				'<div class="pin-bar"></div><div class="dock_middle"><div id="default_app">' +
				'<div class="default-app-part"></div><div class="active-app-part"></div></div>' +
				'<div class="default_tools"><a href="javascript:void(0);" id="showZm_btn" title="'+
				(jsLang['i18n_js_full_screen']||'全屏(IE环境请直接按F11)')+
				'"></a><a href="javascript:void(0);" id="search_app_btn" title="' +
				(jsLang['i18n_js_search_app']||'查找应用') +
				'"></a></div><div class="default_tools"><a href="javascript:void(0);" id="reset_btn" title="' +
				(jsLang['i18n_js_reset_app']||'恢复默认设置') +
				'"></a><a href="javascript:void(0);" id="them_btn" title="' +
				(jsLang['i18n_js_theme_set']||'主题设置') +
				'"></a></div><div id="start_block"> ' +
				'<a title="' +
				(jsLang['i18n_js_begin_menu']||'开始菜单') +
				'" id="start_btn"></a><div id="start_item"></div></div></div></div></div><div id="rightBar">' +
				'</div><div class="dock_drag_effect dock_drag_effect_top" ></div>' +
				'<div class="dock_drag_effect dock_drag_effect_left" ></div><div class="dock_drag_effect dock_drag_effect_right" >' +
				'</div><div class="dock_drag_mask"><div class="dock_drop_region_top"></div>' +
				'<div  class="dock_drop_region_left"></div>' +
				'<div  class="dock_drop_region_right"></div></div><div id="desktopsContainer">' +
				'<div id="desktopContainer"></div></div><div id="bottomBarBgTask" class="pin"></div><div id="taskBlock" class="pin">' +
				'<div class="tray">'+
				'<i class="tray-msg"></i>'+
				'</div>'+
				'<div class="pin-bar"></div>' +
				'<div id="taskPreBox" class="taskPreBox"><a href="javascript:void(0);" id="taskPre" class="taskPre"></a> </div>' +
				'<div id="taskOuterBlock"><div id="taskInnnerBlock"> </div></div>' +
				'<div class="taskNextBox" id="taskNextBox"><a href="javascript:void(0);" class="taskNext" id="taskNext"></a> </div></div>' +
				'<div id="bottomBarMouseEnter"></div>' +
				'<div id="navBar"><div class="l"><div class="indicator indicator_header"  title="' +
				(jsLang['i18n_js_edit_personal_information']||'编辑个人资料') +
				' ">' +
				'<img src="" alt="" class="indicator_header_img" id="navbarHeaderImg" onerror=\'this.src="icon/icon1.png"\'/>' +
				'</div></div><span></span><div class="r">' +
				'<a class="indicator indicator_manage" href="javascript:void(0);"  title="' +
				(jsLang['i18n_js_global_view']||'全局视图') +
				'"></a>' +
				'</div></div><div id="wallpaper"></div></div><div id="appManagerPanel" ><a class="aMg_close" href="javascript:void(0);">' +
				'</a><div class="aMg_dock_container"></div><div class="aMg_line_x"></div><div class="aMg_folder_container">' +
				'<div class="aMg_folder_innercontainer"></div></div><a href="javascript:void(0);" id="aMg_prev"></a>' +
				'<a href="javascript:void(0);" id="aMg_next"></a></div>');
			$(window).load();
		},
		init: function (iconData, options) {
			$body = $('body');
			deskTopData = $body.data();
			var
				_self = this,
				defaults = {
					arrangeType: 1,       //图标排列类型,1竖排,2横排
					iconMarginLeft: 30,   //图标左边距
					iconMarginTop: 20,     //图标上边距
					defaultDesktop: 0,
					appCateName: [],
					extend: ''
				};
			options = $.extend(defaults, options);
			//显示时区或者时间
			if (options.extend) {
				$body.append(
					'<div style="position:fixed;width:200px;height:200px top: 10px;' +
					'right:0;text-align:center;color:#fff;text-shadow: 0 0 1px' +
					'rgba(0,0,0,1),0 0 0 rgba(0,0,0,1),1px 1px 2px rgba(0,0,0,.8);' +
					'font-size:14px;">' + options.extend + '</div>'
				);
			}
			//存储desktop配置
			deskTopData.desktopConfig = options;
			//创建初始化桌面图标
			_self.desktopIconInit(iconData);
			innerDesktop = $(".innerDesktop");
			//默认显示第一个桌面
			//默认配置
			_.desktops.eq(options.defaultDesktop).addClass('currDesktop').css('left', 0);
			innerDesktop.eq(options.defaultDesktop).fadeIn(3000);
			if (_.desktopNum) { //是否显示桌面控制栏
				elsDeskTop.desktopBar.init(_.desktopNum, options.defaultDesktop, options.appCateName);
				//拖动桌面滑动切换桌面
				var dxStart, dxEnd, tabs = $("#navBar").find("span > a");
				_.desktops
					.draggable({
						axis: 'x',
						scroll: false,
						start: function (event) {
							dragEventType='';
							$(this).css("cursor", "move");
							dxStart = event.pageX;
						},
						stop: function (event) {
							var $t = $(this);
							$t.css("cursor", "inherit");
							dxEnd = event.pageX;
							var dxCha = dxEnd - dxStart
								, deskIndex = _.desktops.index($t);
							//左移
							if (dxCha < -150 && deskIndex < _.desktopNum - 1) {
								tabs.eq(deskIndex + 1).trigger('click');
								//右移
							} else if (dxCha > 150 && deskIndex > 0) {
								tabs.eq(deskIndex - 1).trigger('click');
							} else {
								$t.animate({'left': 0}, 500, "easeInOutQuint");
							}
						}
					});
			}
			//设置桌面区域大小和排列桌面图标
			_self.arrangeIcons();
			//如果窗口大小改变，则重新排列图标
			$(window).wresize(function () {
				_self.arrangeIcons();
			});
			//拖曳图标，在桌面空白处释放，插入最后
			innerDesktop.droppable({
				scope: 'a',
				drop: function (event, ui) {
					if(dragEventType)return;
					var
						$t = $(this),
						$lastIcon = $t.find('>.desktopIcon:last'),
						$dragIcon = ui.draggable;
					if(!$dragIcon.is($lastIcon)){
						$dragIcon.insertAfter($lastIcon);
						_self.arrangeIcons();
						_self.saveIconInfo();
					}
				}
			});
			//单击添加应用按钮
			_.desktops
				.find('div.addIcon')
				.click(function () {
					elsDeskTop.defineWin({
						'iconSrc': 'icon/destop-icon/more_app.png',
						'windowsId': 'appShop',
						'windowTitle': jsLang['i18n_js_more_app'] || '更多应用',
						'iframSrc': 'appShop.html',
						'windowWidth': 600,
						'windowHeight': 600,
						'parentPanel': '.desktop',
						data:elsDeskTop.desktop.hideIconsData
					});
				});
			//解决谷歌浏览器下桌面打窗口出现滚动条问题
			$(window).scroll(function () {
				$(document).scrollTop(0);
				$(document).scrollLeft(0);
			});
			_self.setIconRightClick(_.leftBar.find('.desktopIcon'));
		},
		saveIconInfo:function(){
			localStorage.removeItem('appMap');
			localStorage.setItem('app_map_'+(+(elsAccount+elsSubAccount)).toString(36),JSON.stringify(appMap));
			ajaxWorker({
				url :'rest/AccountAppService/saveAppPosition',
				type :'post',
				contentType : 'application/json',
				data : JSON.stringify({elsAccount:elsAccount,elsSubAccount:elsSubAccount,appPosition:JSON.stringify(appMap)}),
				dataType : "json"
			});
			return appMap;
		},
		//桌面图标初始化
		arrangeIcons: function () {
			var
				options 		 = deskTopData.desktopConfig,
				winW			 = $(window).width(),
				winH			 = $(window).height(),
				topBarH 		 = _.topBar.is(':hidden') ? 0 : _.topBar.height(),
				slideWidth	= _.leftBar.is(':hidden') && _.rightBar.is(':hidden') ? 0 : _.leftBar.width(),
				topHeight	= _.topBar.is(':hidden') ? _.navBar.height() : _.topBar.height(),
				sw 				= winW - slideWidth,
				sh					= winH - topBarH - _.bottomBarBgTask.height() - 60;

			_.desktopsContainer.css({'width': sw, 'height': 0, 'left': slideWidth, 'top': topHeight});
			if (!_.rightBar.is(':hidden')) {
				_.desktopsContainer.css({'width': sw, 'height': 0, 'left': 0, 'top': topHeight});
			}
			_.desktopContainer.css({'width': sw, 'height': sh});
			_.desktops.css({'width': sw, 'height': sh});
			_.outerDesktop.css({'width': sw, 'height': sh}).eq(0).width(sw);
			//排列图标
			_.desktops.each(function (index,d) {
				var
					desktop	= $(d),
					desktopIcon = desktop.find('.innerDesktop>.desktopIcon,.innerDesktop>.addIcon'),
					iconW = desktopIcon.width(),
					iconH = desktopIcon.height(),
					iconNum = desktopIcon.size(),
					gH = iconH + options.iconMarginTop,//一个图标总高度，包括上下margin
					gW = iconW + options.iconMarginLeft,//图标总宽度,包括左右margin
					maxCols = Math.floor(_.outerDesktop.width() / gW),
					//maxRows = Math.floor(_.outerDesktop.height() / gH),
					rows = Math.floor(_.outerDesktop.height() / gH),
					cols = Math.ceil(iconNum / rows),
					curcol = 0, currow = 0;
				if (cols > maxCols) {
					rows = Math.ceil(iconNum / maxCols);
					//预留看清底部图标的显示位置
					desktop.find('.innerDesktop').css({'height': rows * gH - 30});
				}
				//存储当前总共有多少桌面图标
				deskTopData.deskIconNum= iconNum;
				//如果是竖排
				if (options.arrangeType == 1) {
					desktopIcon
						.css({
							position				: 'absolute',
							margin					: 0,
							left : function (index) {
								var v = curcol * gW + 30;
								if ((index + 1) % rows == 0) {
									curcol = curcol + 1;
								}
								return v;
							},
							top : function (index) {
								var v = (index - rows * currow) * gH + 20;
								if ((index + 1) % rows == 0) {
									currow = currow + 1;
								}
								return v;
							}
						});
				}
				//如果是横排
				if (options.arrangeType == 2) {
					desktopIcon.css({
						float				: 'left',
						'margin-left'	: options.iconMarginLeft,
						'margin-top'	: options.iconMarginTop
					});
				}
			});
		},
		setIconRightClick: function ($el) {
			var
				_self		= elsDeskTop.desktop;
			//	dnData 	= [(iconCategories||[]).map(function (d,i) {
			//	return {
			//		text: (jsLang['i18n_js_desktop'] || '桌面') + (i + 1),
			//		func: function (j) {
			//			var $last = _.desktops.eq(j).find('.innerDesktop>.desktopIcon:last');
			//			if($last.is(this))return;
			//			$(this).insertAfter($last);
			//			_self.arrangeIcons();
			//			_self.saveIconInfo();
			//		}
			//	}
			//})];
			var data = [
				[{
					text: jsLang['i18n_js_open_app'] || '打开应用',
					func: function () {
						$(this).trigger('click');
					}
				}],
				[
				//{
				//	text: jsLang['i18n_js_move_app'] || '移动应用到',
				//	data: dnData
				//},
					{
					text: jsLang['i18n_js_uninstall_app'] || '卸载应用',
					func: function () {
						var $this = $(this);
						var id = this.id;
						var _dat = $.extend({},this.dat);
						appMap[id]=_dat;
						_dat.h=1;
						_self.hideIconsData.push($this.data('winAttrData'));
						var $w = _self.get('appShop');
						if($w)$w.setIframeData(_self.hideIconsData);
						$(this).remove();
						//更新桌面布局
						_self.arrangeIcons();
						//这里通过ajax写更新后台数据
						_self.saveIconInfo();
					}
				}]
			];
			if($el.length===1&&$el.hasClass('iconGroup')){
				var _d =data.concat();
				_d.splice(1,1,[{
					text: jsLang['i18n_js_rename'] || '重命名',
					func: function () {
						this.setName();
					}
				}]);
				elsDeskTop.contextMenu($el, _d, 'iconsgroup', 10);
			}else {
				elsDeskTop.contextMenu($el, data, 'icons', 10);
			}
		},
		setIconDrag: function ($el) {
			var _self = this;
			$el.draggable({
				helper: 'clone',
				scroll: false,
				scope: 'a',
				appendTo: 'body',
				delay: 200,
				zIndex: 100,
				start: function (event, ui) {
					dragEventType='';
					$(this).css('opacity', 0.2);
					ui.helper.removeClass('desktopIconOver').removeClass('btnOver').css({'float': 'none'}).find('.text').hide();
					deskTopData.curDrag = $(this).next();
					deskTopData.curDragPar= $(this).parent();
				},
				stop: function (event, ui) {
					event.stopPropagation();
					var $el = $(this).css('opacity', '');
					_self.arrangeIcons();
					ui.helper.find('.text').show();
					var groupDom =deskTopData.curDragPar.parents('.gpAppLis')[0];
					if(groupDom)groupDom.iconDom.checkApps($el[0]);
				}
			}).droppable({
				accept: '.desktopIcon',
				scope: 'a',
				over: function (e, u) {
					var $el = $(this);
					clearTimeout(u.draggable.t);
					u.draggable.t = setTimeout(function () {
						if($el.parent().hasClass('appBox'))return;
						$el.addClass('createGroup');
					}, 500)
				},
				out: function (e, u) {
					clearTimeout(u.draggable.t);
					$(this).removeClass('createGroup');
				},
				drop: function (event, ui) {
					dragEventType=1;
					var $el = $(this),$eld = ui.draggable;
					clearTimeout($eld.t);
					if ($el.hasClass('createGroup')&&!$el.parents('#dockContainer').length) {
						$el.removeClass('createGroup');
						var elsAry = [],groupIcon;
						if($el.hasClass('iconGroup')){
							groupIcon=$el[0];
							elsAry.push($eld[0]);
						} else {
							elsAry.push($el[0]);
							if($eld.hasClass('iconGroup')){
								groupIcon=$eld[0]
							}else {
								elsAry.push($eld[0]);
								groupIcon=_self.creatIconBox();
								$el.after(groupIcon);
							}
						}
						_.body.append(groupIcon.appBox);
						groupIcon.addApps.apply(null,elsAry);
					} else {
						var curDrag = deskTopData.curDrag,
							curDragPar = deskTopData.curDragPar;
						if (curDragPar.is($(this).parent())) {
							if ($(this).is(curDrag)) {
								ui.draggable
									.addClass('desktopIcon')
									.insertAfter($(this));
							} else {
								ui.draggable
									.addClass('desktopIcon')
									.insertBefore($(this));
							}
							if(curDragPar.hasClass('appBox')){
								curDragPar[0].parentNode.iconDom.resetIcon()
							}
						}else {return}
					}
					_self.arrangeIcons();
					_self.saveIconInfo();
				}
			});
		},
		//t - 文字
		creatIconBox: function (t) {
			var _t= t,id =creatGroupId(),_o;
			if(typeof t === 'object'&& t.k&& t.n){
				_t = t.n;
				id = t.k;
				delete t.k;
				delete t.n;
				_o=t;
			}
			_t = textClip(_t,38);
			var
				_self 				= this,
				defaultName	= textClip(_t,18)||'自定义分组',
				gpLis 				= definedDom('div', {tag: 'div', class: 'appBox'}),
				dfName			= definedDom('span', {text: defaultName, class: 'name'}),
				icon 				= definedDom('div', {tag: 'div', class: 'icon'}),
				title					= definedDom('div',{class:'title',text:defaultName}),
				input				= definedDom('input',{
					type:'text',
					onclick:function(e){
						e.stopPropagation();
						e.preventDefault();
					},
					onchange:function(){
						var v =input.value.replace(/^\s+|\s+$/gi,'');
						if(!v)return;
						dom.title=textClip(v,38);
						$(dfName).text(textClip(v,18));
						_self.saveIconInfo();
					},
					onblur:function(){
						input.style.display='none';
						dfName.style.display='block';
					}
				}),
				 bgDom			= definedDom({tag: 'div', class: 'bg'}),
				 appBox		    = definedDom('div',{
					 onclick:function(e){
						 e.stopPropagation();
						 e.preventDefault();
					 },
					 close:function(){
						 appBox.className = 'gpAppLis';
						 setTimeout(function () {
							 appBox.style.display='none';
						 }, 500);
					 },
					 class: 'gpAppLis', children: [
					 bgDom, {
						 tag: 'div', class: 'icon-close',
					 	onclick:function(){
							appBox.close();
						}
					 }, title,gpLis],
					 func:function(){
						 $(this).droppable({
							 scope			: 'a',
							 greedy		: true,
							 drop: function (event, ui) {
								 dragEventType=1;
								 var el = ui.draggable[0];
								 if(el===dom)return;
								 dom.addApps(el);
								 _self.saveIconInfo();
							 }
						 })
					 }
				 }),
				 dom = definedDom('div', {
					 id:id,
					 dat:{
					 	 get n(){return dom.title},
						 get i(){return [].indexOf.call(dom.parentNode.childNodes,dom)},
						 get c(){
							 var i = parseInt(dom.parentNode.parentNode.parentNode.id.replace(/appCategory/,''));
							 return isNaN(i)?undefined:i;
						 }
					 },
					 func: function () {
						 appMap[id]=this.dat;
						 _self.setIconDrag($(this));
						 _self.setIconRightClick($(this));
					 },
					 apps: [],
					 setName: function (t) {
						 if(t){
							 dom.title=t;
							 return input.blur();
						 }
						 input.value = dom.title;
						 input.style.display = 'block';
						 dfName.style.display = 'none';
						 input.focus();
						 input.select();
						 setTimeout(function () {
							 _.body.one('click', function () {
								 input.blur();
							 })
						 }, 100);
					 },
					 resetIcon: function () {
						 icon.innerHTML = '';
						 var imgs = [];
						 dom.apps = Array.apply(null,gpLis.childNodes);
						 for (var i = -1, a; a = dom.apps[++i], a && i < 4;) {
							 imgs.push(a.getElementsByTagName('img')[0].cloneNode(false))
						 }
						 icon.appendChild(definedDom(imgs));
					 },
					 addApps: function () {
						 [].forEach.call(arguments, function (o) {
							 var apps = o.apps || [o];
							 var _apps = [];
							 for (var i = 0, p, _p = dom.apps; p = apps[i++];) {
								 if (_p.indexOf(p) === -1) {
									 p.removeAttribute('style');
									 _apps.push(p)
								 }
							 }
							 apps.length = 0;
							 if (!_apps.length)return;
							 dom.apps = dom.apps.concat(_apps);
							 gpLis.appendChild(definedDom(_apps));
							 if (o.apps) {
								 o.checkApps();
							 }
						 });
						 dom.resetIcon();
						 return dom;
					 },
					 removeGroup:function(){
						 $(dom).remove();
						 $(dom.appBox).remove();
						 delete appMap[id];
						 dom = null;
						 _self.arrangeIcons();
					 },
					 checkApps: function (o) {
						 if (o) {
							 if (gpLis.contains(o))return;
							 var i = dom.apps.indexOf(o);
							 if (1 !== -1)dom.apps.splice(i, 1);
							 dom.resetIcon();
						 }
						 if(dom.apps.length===1){
							 $(dom).before(dom.apps[0]);
							dom.removeGroup();
							 _self.saveIconInfo();
							 return;
						 }
						 if (dom.apps.length === 0) {
							 dom.removeGroup();
						 }
						 return dom;
					 },
					 onmouseenter: function (e) {
						 e.stopPropagation();
						 if (this.className.indexOf('desktopIconOver') === -1)
							 this.className += ' desktopIconOver'
					 },
					 onmouseleave: function (e) {
						 e.stopPropagation();
						 this.className = this.className.replace(/desktopIconOver/g, '');
					 },
					 title: defaultName,
					 class: 'desktopIcon iconGroup',
					 onclick: function (e) {
						 e.stopPropagation();
						 e.preventDefault();
						 bgDom.style.backgroundImage = 'url(' + document.getElementById('wallpaper').children[0].src + ')';
						 title.innerHTML = dom.title;
						 var s = $(appBox);
						 s.show();
						 setTimeout(function () {
							 s.addClass('opened');
							 $(appBox).find('.desktopIcon').one('click', function () {
								 appBox.close();
							 });
							 _.body.one('click', function () {
								 appBox.close();
							 })
						 }, 100);
					 },
					 children: [
						 icon, {tag: 'div', class: 'text', children: [dfName, input]}
					 ]
				 });
			appBox.iconDom=dom;
			dom.appBox=appBox;

			if(_o){
				dom.setName(_t);
				dom.addApps.apply(null,Object.keys(_o).map(function(o){
					return _self.creatIcon(_o[o]);
				}));
				_.body.append(appBox);
			}
			return dom;
		},
		// o-数据,i-排序,c-桌面
		creatIcon: function (o,disableDrag) {
			if(!o)return;
			var id = o.windowsId, _self = this;
			if(!id) {
				return _self.creatIconBox(o);
			}
			 var dom = definedDom('div', {
				dat:{
					get i(){return [].indexOf.call(dom.parentNode.childNodes,dom)},
					get c(){
						var p =dom.parentNode;
						if(p.className==='appBox')return undefined;
						var i =parseInt(p.parentNode.parentNode.id.replace(/appCategory/,''));
						return isNaN(i)?undefined:i;
					},
					get g(){
						var p =dom.parentNode;
						if(p.className==='appBox'){
							return p.parentNode.iconDom.id;
						}
					},
					get s(){
						return dom.parentNode.className.indexOf('active-app-part')>-1?1:undefined
					}
				},
				class: 'desktopIcon',
				id: id,
				func: function () {
					appMap[id]=this.dat;
					$(this).data('winAttrData',o);
					if(!disableDrag)_self.setIconDrag($(this));
					_self.setIconRightClick($(this));
				},
				onclick: function (e) {
					e.stopPropagation();
					if (!o['isWidget']) {
						o.parentPanel = '.currDesktop';
						elsDeskTop.myWindow.init(o);
						//添加到状态栏
						if (!document.getElementById('taskTab_' + id)) {
							elsDeskTop.taskBar.addTask(
								id, o.windowTitle, o.iconSrc
							);
						}
					} else {
						//小工具
						elsDeskTop.widget.init({
							id: id,
							width: o.windowWidth,
							height: o.windowHeight,
							title: o.windowTitle,
							isDrag: true,
							iframeSrc: o.iframSrc,
							top: o.top,
							left: o.left,
							right: o.right,
							parentTo: '.currDesktop'
						})
					}
				},
				onmouseenter: function (e) {
					e.stopPropagation();
					if (this.className.indexOf('desktopIconOver') === -1)
						this.className += ' desktopIconOver'
				},
				onmouseleave: function (e) {
					e.stopPropagation();
					this.className = this.className.replace(/desktopIconOver/g, '');
				},
				children: [{
					tag: 'span', class: 'icon',
					children: [
						o.txNum ? {tag: 'div', class: 'txInfo', text: o.txNum} : undefined,
						{tag: 'img', src: o.iconSrc, title: o.windowTitle}
					]
				}, {
					tag: 'div', class: 'text',
					children: {tag: 'span', text: textClip(o.windowTitle, 18)}
				}]
			});
			return dom;
		},
		//初始化创建桌面图标
		desktopIconInit: function (data) {
			var _self = this;
			iconCategories =Object.keys(data).sort();
			$('#desktopContainer').html(definedDom({
				children: iconCategories.map(function (a) {
					return {
						tag: 'div', id: a, class: 'desktop',
						children: {
							tag: 'div', class: 'outerDesktop',
							children: {
								tag: 'div', class: 'innerDesktop',
								children: data[a].map(function (o) {
									return o&& _self.creatIcon(o)
								}).concat($("<div class='addIcon'><span class='icon'><img src='theme/default/images/add_icon2.png'/></span><div class='text'><span>"+(jsLang.i18n_js_more||'更多')+"</span></div>")[0])
							}
						}
					}
				})
			}));
		},
		addApp: function (appData) {
			if (!document.getElementById(appData.windowsId)) {
				var p = $('.currDesktop'),
					_self = this;
				p.find('.innerDesktop>.desktopIcon:last').before(_self.creatIcon(appData));
				//更新桌面布局
				_self.arrangeIcons();
				//图标添加到的桌面id并保存
				_self.addIconSuccess(p.attr('id'), appData);
			}
		},
		//添加图标成功后调用
		addIconSuccess: function (pid, data) {
			//pid 值添加到的桌面id
			//data 值新添加的图标数据
			//这里写与后台的交互
		},
		//删除图标函数
		removeIcon: function (iconid) {
			//这里写与后台的交互

		},
		//移动图标到其它桌面
		moveIconTo: function (desktopId, iconid) {
			//这里写与后台的交互
		},
		// 存储隐藏的图标数据
		hideIconsData:[]
	};


//创建状态栏命名空间
	elsDeskTop.taskBar = {
		init: function () {
			var $win = $(window);
			deskTopData  = $('body').data();
			//存储任务栏jq元素对象
			this.taskData();
			var taskBarData = deskTopData.taskBar,
				taskNextBox = taskBarData.taskNextBox,
				taskPreBox = taskBarData.taskPreBox,
				taskInnnerBlock = taskBarData.taskInnnerBlock;

			$win.wresize(function () {
				var $taskTab =  $('.taskTab');
				var taskTabNum =$taskTab.size(),
					tabWidth = $taskTab.width(),
					winWidth = $win.width(),
					maxTabNum = Math.floor((winWidth - taskNextBox.outerWidth() * 2) / tabWidth);
				$('body').data('maxTabNum',maxTabNum).data('ww',winWidth);
				if (taskTabNum <= maxTabNum) {
					taskBarData.taskNextBox.hide();
					taskBarData.taskPreBox.hide();
				}else {
					taskBarData.taskNextBox.show();
					taskBarData.taskPreBox.show();
				}
			});

			function taskMove(a) {
				taskInnnerBlock.animate({'margin-right': '+=' + a}, 300);
			}
			taskNextBox.on('click', function () {
				var
					mr = parseInt(taskInnnerBlock.css('margin-right')),
					taskTabWidth = deskTopData.tabWidth;
				if (Math.abs(mr) > taskTabWidth) {
					taskMove(taskTabWidth);
				} else {
					taskMove(Math.abs(mr));
				}
			});
			taskPreBox.on('click', function () {
				var
					ml = Math.abs(taskInnnerBlock.position().left),
					taskTabWidth = $('body').data('tabWidth');
				if (ml > taskTabWidth) {
					taskMove(taskTabWidth * -1);
				} else {
					taskMove(ml * -1);
				}
			});
			var
				$try = $('#taskBlock .tray'),
				$bTaskBarPin = $('#taskBlock .pin-bar'),
				$taskBlock = $('#taskBlock'),
				$bTaskBarBg = $('#bottomBarBgTask'),
				$bTaskBarList = $('#taskBlock'),
				$bTaskBarMouse = $('#bottomBarMouseEnter'),
				$leftBar = $('#dockBar'),
				$dockContainer = $('#dockContainer'),
				$dockBarPin = $('#dockContainer .pin-bar'),
				tbp = localStorage.getItem('tbp'),
				dcp = localStorage.getItem('dcp'),

				pin = function () {
					if ($(this).is($bTaskBarPin)){
						$taskBlock.toggleClass('pin');
						$bTaskBarBg.toggleClass('pin');
						var isPin = $taskBlock.hasClass('pin');
						localStorage.setItem('tbp',isPin?'':1);
					}
					if ($(this).is($dockBarPin)){
						$dockContainer.toggleClass('pin');
						localStorage.setItem('dcp',+$dockContainer.hasClass('pin')?'':1);
					}
				},
				show = function (e) {
					e.stopPropagation();
					if ($(this).is($bTaskBarMouse) || $(this).is($win)) {
						if ($win.height() - e.clientY > 15)return;
						$bTaskBarBg.animate({bottom: 0 + 'px'}, 300);
						$bTaskBarList.animate({bottom: 0 + 'px'}, 300);
						$try.children().animate({top: 5 + 'px'}, 300);
					}
					if ($(this).is($leftBar) || $(this).is($win)) {
						if (e.clientX > 5)return;
						$dockContainer.animate({left: 0 + 'px'}, 300);
					}
				},
				hide = function (e) {
					e.stopPropagation();
					if ($(this).is($bTaskBarBg) || $(this).is($bTaskBarList) || $(this).is($win)) {
						if ($taskBlock.hasClass('pin'))return;
						if ($win.height() - e.clientY > 29) {
							$bTaskBarBg.animate({bottom: -29 + 'px'}, 300);
							$bTaskBarList.animate({bottom: -29 + 'px'}, 300);
							$try.children().animate({top: -30 + 'px'}, 300);
						}
					}
					if ($(this).is($dockContainer) || $(this).is($win)) {
						if ($dockContainer.hasClass('pin'))return;
						$dockContainer.animate({left: -52 + 'px'}, 300);
					}
				};
			if(null === tbp||undefined === tbp){
				localStorage.setItem('tbp',1);
				tbp = '1';
			}
			if(tbp){
				$try.children().animate({top: -30 + 'px'}, 300);
				$bTaskBarBg.removeClass('pin');
				$taskBlock.removeClass('pin');
			}
			if(dcp){
				$try.children().animate({top: 5 + 'px'}, 300);
				$dockContainer.removeClass('pin');
			}
			$dockContainer.on('mouseleave', hide);
			$leftBar.on('mouseenter', show);
			$bTaskBarBg.on('mouseleave', hide);
			$bTaskBarList.on('mouseleave', hide);
			$bTaskBarMouse.on('mouseenter', show);
			$bTaskBarPin.on('click', pin);
			$dockBarPin.on('click', pin);
			$win.on('mouseleave', show);
			$win.on('click', hide);
		},
		taskData: function () {
			$('body').data('taskBar', {
				taskBlock: $('#taskBlock'),
				taskInnnerBlock: $('#taskInnnerBlock'),
				taskOuterBlock: $('#taskOuterBlock'),
				taskNextBox: $('#taskNextBox'),
				taskPreBox: $('#taskPreBox'),
				ww: $(window).width(),
				wh: $(window).height()
			});
		},
		upTaskTab: function (id) {
			if (!id)return;
			//删除所有tab的taskCurrent样式
			$('div.taskTab').removeClass('taskCurrent');
			$(id.replace(/^.*?_/,'#taskTab_')).parent().addClass('taskCurrent');
		},
		removeTaskTab: function (id) {
			var
				taskBarData = deskTopData.taskBar,
				taskTabWidth = deskTopData.tabWidth;

			$( id.replace(/^.*?_/,'#taskTab_')).parent().remove();
			var taskTabNum = $('div.taskTab').size(),
				maxTabNum = deskTopData.maxTabNum;

			taskBarData.taskInnnerBlock.width(taskTabNum * taskTabWidth);
			if (taskTabNum <= maxTabNum) {
				taskBarData.taskNextBox.hide();
				taskBarData.taskPreBox.hide();
			}
		},
		addTask: function (id, text, icon) {
			var taskBarData = deskTopData.taskBar,
				taskNextBox = taskBarData.taskNextBox,
				taskPreBox = taskBarData.taskPreBox,
				ww = taskBarData.ww,
				taskInnnerBlock = taskBarData.taskInnnerBlock,
				taskOuterBlock = taskBarData.taskOuterBlock,
				ow = ww - taskNextBox.outerWidth(true) * 2;

			//删除所有tab的taskCurrent样式
			$('.taskTab').removeClass('taskCurrent');

			var taskTabHtml = "<div class='taskTab taskCurrent'><a href='#'  title='" + text + "' class='taskItem' id='taskTab_" + id + "'><div class='tabIcon'><img src='" + icon + "'/></div><div class='tabTxt'><span>" + text + "</span></div></a></div>";
			$(taskTabHtml).appendTo(taskInnnerBlock);

			var taskTab = $("div.taskTab"),
				tabNum = taskTab.size(),
				tabWidth = taskTab.width(),
				maxTabNum = Math.floor((ww - taskNextBox.outerWidth() * 2) / tabWidth),
				win = $("#win_" + id);

			$("body").data({"tabWidth": tabWidth, "maxTabNum": maxTabNum});
			taskInnnerBlock.width(tabNum * tabWidth);

			//单击tab
			$("#taskTab_" + id).on("click", function () {
				var win = $(this.id.replace(/^taskTab_/,'#win_')),
					left = win.data("oldLeft");
				if (win.hasClass("hideWin")) {
					win.css("left", left).removeClass("hideWin");
				}
				win.trigger("mousedown");
			});
			//如果tab超过最大显示数目，则显示左右移动按钮
			if (tabNum > maxTabNum) {
				taskNextBox.show();
				taskPreBox.show();
			}
			//初始化任务栏Tab右键菜单
			var data = [
				[{
					text: jsLang['i18n_js_maximize'] || '最大化',
					func: function () {
						win.find('a.winMaxBtn').trigger('click');
					}
				}, {
					text: jsLang['i18n_js_minimize'] || '最小化',
					func: function () {
						win.find('a.winMinBtn').trigger('click');
					}
				}]
				, [{
					text: jsLang['i18n_js_close'] || '关闭',
					func: function () {
						$("#smartMenu_taskTab_" + id).remove();
						win.find('a.winCloseBtn').trigger('click');
					}
				}]
			];
			if(id==="friendlist"){
				data[0].splice(0,1);
			}
			elsDeskTop.contextMenu($("#taskTab_" + id), data, "taskTab_" + id, 10);
		}
	};

//侧边栏
	elsDeskTop.sildeBar = {
		init: function (iconData, activeData, pos) {
			activeData=activeData||[];
			iconData=iconData||[];
			var _data = {};
			var checkRepeatData = function(datas){
				for(var i=0;i<datas.length;i++){
					var a = datas[i];
					if(!a){
						datas.splice(i--,1);
						continue;
					}
					var c=a.windowsId;
					if(c){
						if(_data[c]){	
							datas.splice(i--,1);
						}else _data[c]=1;
					}
				}
			};
			checkRepeatData(activeData);
			checkRepeatData(iconData);
			deskTopData = _.body.data();
			var
				dockContainer 					= $('#dockContainer'),
				default_app 						= $('#default_app'),
				dock_drag_effect 			= $('.dock_drag_effect'),
				dock_drag_effect_left 	= $('.dock_drag_effect_left'),
				dock_drag_effect_right = $('.dock_drag_effect_right'),
				dock_drag_effect_top 	= $('.dock_drag_effect_top'),
				default_fixed_part			= $('.default-app-part'),
				default_active_part			= $('.active-app-part'),
				dock_drag_mask 				= $('.dock_drag_mask'),
				dock_drop_region_top 	= $('.dock_drop_region_top'),
				dock_drop_region_left 	= $('.dock_drop_region_left'),
				dock_drop_region_right = $('.dock_drop_region_right'),
				fixedDom, activeDom, _self = this;

			//添加图标:固定图标和动态图标
			if (iconData instanceof Array)
				fixedDom = definedDom(iconData.map(function (o) {
					return elsDeskTop.desktop.creatIcon(o,true);
				}));
			if (activeData instanceof Array)
				activeDom = definedDom(activeData.map(function (o) {
					return elsDeskTop.desktop.creatIcon(o);
				}));

			default_fixed_part.empty().append(fixedDom);
			default_active_part.empty().append(activeDom);

			default_active_part.droppable({
				scope: 'a',
				drop: function (event, ui) {
					var
						$dragEl = ui.draggable,
						$t = $(this);
					if($dragEl)
					var num = $dragEl.parent().is($t) ? 5 : 4;
					if ($t.find(".desktopIcon").size() < num) {
							$dragEl.removeAttr('style');
							$dragEl.appendTo($t);
							elsDeskTop.desktop.saveIconInfo();
					}
				}
			});

			//侧边栏位置
			if (pos == "left") {
				_self.moveLeft();
			}

			if (pos == "right") {
				_self.moveRight();
			}

			if (pos == "top") {
				_self.moveTop();
			}

			//拖曳侧边栏
			var isMd = false, isMo = false;

			function hideMark() {
				isMd = false;
				isMo = false;
				dock_drag_effect.hide();
				dock_drag_mask.hide();
			}

			function showMk(id) {
				if (id == "leftBar") {
					dock_drag_effect.removeClass("dock_drag_effect_current");
					dock_drag_effect_left.addClass("dock_drag_effect_current")
				}

				if (id == "rightBar") {
					dock_drag_effect.removeClass("dock_drag_effect_current");
					dock_drag_effect_right.addClass("dock_drag_effect_current")
				}

				if (id == "topBar") {
					dock_drag_effect.removeClass("dock_drag_effect_current");
					dock_drag_effect_top.addClass("dock_drag_effect_current")
				}
			}

			//dockContainer.mousedown(function (event) {
			//	isMd = true;
			//	$(this).mousemove(function (event) {
			//		isMo = true;
			//		if (isMd) {
			//			dock_drag_effect.show();
			//			dock_drag_mask.show();
			//			showMk($(this).parent().attr("id"));
			//		}
			//	});
			//	$("body").mouseup(function () {
			//		hideMark();
			//	});
			//	$(".dock_drag_effect_top,.dock_drop_region_top").mouseover(function () {
			//		showMk("topBar");
			//	}).mouseup(function () {
			//		hideMark();
			//		_self.moveTop();
			//	});
			//	$(".dock_drag_effect_left,.dock_drop_region_left").mouseover(function () {
			//		showMk("leftBar");
			//	}).mouseup(function () {
			//		hideMark();
			//		_self.moveLeft();
			//	});
			//	$(".dock_drag_effect_right,.dock_drop_region_right").mouseover(function () {
			//		showMk("rightBar");
			//	}).mouseup(function () {
			//		hideMark();
			//		_self.moveRight();
			//	});
			//}).mouseup(function () {
			//	$(this).removeClass("dock_drag_effect_current");
			//});

			//初始化小工具栏
			_self.wigInit();
		},
		//添加图标到侧边栏
		addIcon: function (iconData, obj) {
			var default_app = $("#default_app").find('.active-app-part'),
				icon = elsDeskTop.desktop.creatIcon(iconData);
			obj == undefined ? default_app.append(icon) : $(icon).insertAfter(obj);
		},
		//小工具栏
		wigInit: function () {
			//全屏
			$("#showZm_btn")
				.click(fullScreenWin);
			//查找应用
			$("#search_app_btn").click(function (event) {
				event.preventDefault();
				event.stopPropagation();
				$("a.indicator_manage").trigger('click');
				/*elsDeskTop.widget.init({
				 id:"shizhong",
				 width:140,
				 height:230,
				 title:"时钟",
				 isDrag:true,
				 iframeSrc:"app_tools/shizhong/index.html",
				 top:20,
				 left:'auto',
				 right:50,
				 parentTo:$("div.currDesktop")
				 });*/
			});

			//恢复默认设置
			$("#reset_btn").click(function (event) {
				event.preventDefault();
				event.stopPropagation();
				["_uploadBg", "bLang", "shinTheme", "tab_id"].forEach(function(n){
					if(n!=='bLang')localStorage.removeItem(n);
				});
				localStorage.setItem('clearAppMap',1);
				return elsDeskTop.desktop.reload();
			});

			//$("#shizhong_btn,#weather_btn").trigger("click");


			//设置主题
			$("#them_btn").click(function (event) {
				event.preventDefault();
				event.stopPropagation();
				elsDeskTop.myWindow.init({
					'iconSrc': 'theme/default/images/skin.png',
					'windowsId': 'skins',
					'windowTitle': jsLang['i18n_js_theme_set'] || '主题设置',
					'iframSrc': 'app_tools/skins/skin.jsp',
					'windowMaximize': false,
					'windowResizable': false,
					'windowPositionTop': 0,
					'windowWidth': 480,
					'windowHeight': 560,
					'parentPanel': ".currDesktop"
				});
				//添加到状态栏
				if (!$("#taskTab_skins").size()) {
					elsDeskTop.taskBar.addTask("skins", jsLang['i18n_js_theme_set'] || '主题设置', "theme/default/images/skin.png");
				}
			});

			$("div.default_tools > a").mousemove(function (event) {
					event.preventDefault();
					event.stopPropagation();
				})
				.mousedown(function (event) {
					event.preventDefault();
					event.stopPropagation();
				});

		},
		moveLeft: function () {
			var leftBar = $("#leftBar"), dockContainer = $("#dockContainer");
			$("#rightBar,#topBar").hide();
			leftBar.show().append(dockContainer);
			dockContainer.removeClass("dock_pos_right").addClass("dock_pos_left").addClass("dock_container");
			elsDeskTop.desktop.arrangeIcons();
		},
		moveRight: function () {
			var rightBar = $("#rightBar"), dockContainer = $("#dockContainer");
			$("#leftBar,#topBar").hide();
			dockContainer.removeClass("dock_pos_left").addClass("dock_pos_right").addClass("dock_container");
			rightBar.show().append(dockContainer);
			elsDeskTop.desktop.arrangeIcons();
		},
		moveTop: function () {
			var topBar = $("#topBar"), dockContainer = $("#dockContainer");
			$("#rightBar,#leftBar").hide();
			topBar.show().append(dockContainer);
			dockContainer.removeClass("dock_container").removeClass("dock_pos_right").removeClass("dock_pos_left");
			elsDeskTop.desktop.arrangeIcons();

		}
	};

//创建widget窗口
	elsDeskTop.widget = {
		init: function (options) {

			var defaults = {
					id: "",
					width: 210,
					height: 210,
					title: jsLang['i18n_js_gadgets'] || "小工具",
					isDrag: true,
					iframeSrc: "",
					top: 0,
					left: 0,
					right: 'auto',
					bottom: 'auto',
					parentTo: "body"
				},
				_self = this;

			var o = $.extend(defaults, options);

			if (!$("#myWidget_" + o.id).size()) {

				$(o.parentTo).append(_self.widgetHtml(o));

				var newWidget = $("#myWidget_" + o.id);
				widgetTitle = newWidget.find("div.widgetTitle"),
					widgetClose = newWidget.find("a.widgetClose"),
					widgetCon = newWidget.find("div.widgetCon");

				newWidget
					.css({
						"width": o.width,
						"height": o.height,
						"left": o.left,
						"right": o.right,
						"top": o.top,
						"bottom": o.bottom
					})
					.hover(function () {
						$(this).find(".innerWidgetTitle").show();
					}, function () {
						$(this).find(".innerWidgetTitle").hide();
					})
					.find("iframe")
					.attr("src", o.iframeSrc)
					.load(function () {
						newWidget.find("div.loading").hide();
					});

				widgetCon.height(o.height - widgetTitle.height());

				if (o.isDrag) {
					newWidget.draggable({
						scroll: false,
						drag: function () {
							$(this).find(".iframeFix").show();
						},
						stop: function () {
							var l = parseInt($(this).css("left")), tw = $(this).width();
							$(this).find(".iframeFix").hide();
							$(this).css({"left": "auto", "right": $(window).width() - l - tw - 73});
						}
					});
				}

				widgetClose.click(function () {
					newWidget.remove();
				});

			}

		},
		widgetHtml: function (o) {
			return "<div class='myWidget' id='myWidget_" + o.id + "'><div class='widgetTitle'><div class='innerWidgetTitle'><b>" + o.title + "</b><span class='widgetBtn'><a href='#' class='widgetClose'></a></span></div></div><div class='widgetCon'><iframe src='#' allowtransparency='true' frameborder='0' scrolling='no' width='100%' height='100%'></iframe><div class='loading'>" + (jsLang['i18n_js_loading'] || '加载中') + "...</div><div class='iframeFix' id='iframeFix_" + o.id + "'></div></div></div>";
		}
	};

//开始菜单
	elsDeskTop.startBtn = {
		init: function (data) {

			//读取元素对象数据
			var $start_btn = $("#start_btn"),
				$start_block = $("#start_block")
				, $start_item = $("#start_item")
				, slideBar = $("#topBar,#leftBar,#rightBar")
				, _this = this;

			//alert(data.length);
			function creatItme(d, a) {
				var itemHtml = "", i, j;

				if (a) {
					itemHtml += "<ul class='item childItem'>";
				} else {
					itemHtml += "<ul class='item'>";
				}

				for (i = 0; i < d.length; i++) {

					var arr = d[i];
					if (i != 0) {
						itemHtml += "<div class='line'></div>";
					}

					for (j = 0; j < arr.length; j++) {

						if (arr[j]["childItem"] == undefined) {
							itemHtml += "<li id=" + arr[j]["id"] + "><span>" + ((arr[j]["icon"] && arr[j]["icon"].length) ? "<img src='" + arr[j]["icon"] + "'/>" : "") + arr[j]["text"] + "</span></li>";
						} else {
							itemHtml += "<li id=" + arr[j]["id"] + "><span><img src='" + arr[j]["icon"] + "'/>" + arr[j]["text"] + "</span><b></b>";
							itemHtml += creatItme(arr[j]["childItem"], 1);
							itemHtml += "</li>";

							$("#" + arr[j]["id"])
								.live("mouseover", function () {
									//$(".childItem").hide();
									$(this).children(".childItem").show();
								})
								.live("mouseout", function () {
									$(this).children(".childItem").hide();
								});
						}
						if(arr[j]["func"])$("#" + arr[j]["id"]).live("click", arr[j]["func"]);
					}
				}

				itemHtml += "</ul >";
				return itemHtml;
			}
			$start_item.append(creatItme(data, 0));

			//开始按钮、菜单交互效果
			$start_btn.click(function (event) {
					event.preventDefault();
					event.stopPropagation();

					if ($start_item.is(":hidden")) {
						slideBar.css("z-index", 800);
						$start_item.show();
					} else {
						slideBar.css("z-index", 45);
						$start_item.hide();
					}

				})
				.on("mousemove", function (event) {
					event.stopPropagation()
				});

			$start_block.mousemove(function (event) {
				event.preventDefault();
			});

			$("body").click(function (event) {
				event.preventDefault();

				slideBar.css("z-index", 45);
				$start_item.hide();
				$(".childItem").hide();
			});

		}
	};

//编辑个人信息窗口
	elsDeskTop.personal = {
		init: function (src) {
			var personalHtml = "<div class='personal-message-box'><div class='ui_boxyClose message-close'></div><iframe src='#' frameborder='0' width='100%' height='100%' style='border-radius: 2px;' scrolling='no'></iframe></div>",
				personalMark = "<div class='ui_maskLayer'></div>";

			$("body").append($(personalMark));
			$("body").append($(personalHtml));

			var message_box = $("div.personal-message-box"), ui_boxyClose = $(".message-close"), ui_layout = $(".ui_maskLayer");

			message_box.find("iframe").attr("src", src);

			ui_boxyClose.click(function () {
				$("div.personal-message-box,div.ui_maskLayer").remove();
			});
			//ui_layout.click(function() {
			//	ui_boxyClose.trigger('click');
			//});
		}
	};

//全局视图
	elsDeskTop.appManagerPanel = {
		init: function () {
			var appManagerPanel = $("#appManagerPanel"),
				aMg_close = $(".aMg_close"),
				aMg_dock_container = $(".aMg_dock_container"),
				aMg_folder_container = $(".aMg_folder_container"),
				aMg_folder_innercontainer = $(".aMg_folder_innercontainer"),
				aMg_prev = $("#aMg_prev"),
				aMg_next = $("#aMg_next"),
				wh = $(window).height(),
				ww = $(window).width(),
				dhtml = "",
				_self = this;

			//取消右键菜单
			elsDeskTop.contextMenu(appManagerPanel, [], "appManagerPanel", 10);

			aMg_folder_container.height(wh - aMg_dock_container.height());

			aMg_dock_container.html($("#default_app").clone(true));

			function amgClose() {
				appManagerPanel.css("top", "-9999px");
				$("#desktopWrapper").show();
				aMg_folder_innercontainer.css("margin-left", 0);
				elsDeskTop.desktop.arrangeIcons();
				$("#appManagerPanel").hide();
			}

			aMg_close.click(function () {
				amgClose();
			});

			for (var i = 0; i < iconCategories.length; i++) {
				dhtml += "<div class='folderItem folderItem_turn' id='folder_" + i + "'><div class='folder_bg'>" + (i + 1) + "</div><div class='folderOuter'><div class='folderInner' style='overflow: hidden;'></div></div><div class='aMg_line_y'></div></div>";
			}

			aMg_folder_innercontainer.html(dhtml);

			var folderItem = $("div.folderItem"), fitemWidth = parseInt(ww / 5), folderOuter = $(".folderOuter");
			folderItem.css("width", fitemWidth);
//
			for (var i = 0; i < iconCategories.length; i++) {
				$("#folder_" + i).find(".folderInner").append($("div.innerDesktop").eq(i).find(".desktopIcon:not(.addIcon)").clone());
				$("#folder_" + i).find(".folderOuter").niceScroll("#folder_" + i + " .folderInner", {
					touchbehavior: false,
					cursorcolor: "#666",
					horizrailenabled: true,
					cursoropacitymax: 0.8,
					cursorborder: "1px solid #ccc"
				});
				$(window).wresize(function () {
					$("#folder_" + i).find(".folderOuter").getNiceScroll().resize();
				});
			}

			var folderIcon = folderItem.find('.desktopIcon');

			folderIcon
				.on("mouseover", function () {
					$(this).addClass("hover");
				})
				.on("mouseout", function () {
					$(this).removeClass("hover");
				})
				.attr("style", "");

			$(".aMg_dock_container,.folderItem")
				.find('.desktopIcon')
				.on("click", function (e) {
					amgClose();
					var index = $(this).parent().parent().parent().attr("id").split("_")[1], navBar = $("#navBar");
					$("#" + this.id).trigger('click');
					navBar.find("span > a").eq(parseInt(index)).trigger('click');

					var ev = e || event;
					ev.stopPropagation();
					return false;
				});

			aMg_folder_innercontainer.width(_.desktopNum * (fitemWidth)).height(wh - aMg_dock_container.height());

			$(window).wresize(function () {
				var h = $(window).height() - aMg_dock_container.height(), fw = $(window).width() / 5;
				aMg_folder_container.height(h);
				aMg_folder_innercontainer.height(h).width(_.desktopNum * fw);
				folderItem.css("width", fw);
				fitemWidth = parseInt(fw);
			});

			if (_.desktopNum > 5) {
				aMg_folder_container.mousemove(function (event) {
					if (event.pageX < 50) {
						aMg_prev.show();
					} else {
						aMg_prev.hide();
					}

					if (event.pageX > $(window).width() - 50) {
						aMg_next.show();
					} else {
						aMg_next.hide();
					}
				});
			}

			var moveIndex = 0, maxMoveNum = _.desktopNum - 5;

			function move_amg(a) {
				aMg_folder_innercontainer.animate({
					"margin-left": '+=' + a
				}, 100, "easeInOutCirc");
			}

			//单击向上翻页
			aMg_prev.click(function () {
				moveIndex = parseInt(aMg_folder_innercontainer.css("margin-left"));
				if (moveIndex < 0) {
					move_amg(fitemWidth);
				}
			});

			//下一页
			aMg_next.click(function () {
				moveIndex = parseInt(aMg_folder_innercontainer.css("margin-left"));

				if (moveIndex > maxMoveNum * -1 * fitemWidth) {
					move_amg(-1 * fitemWidth);
				}
			});

		}
	};
//自定义窗口
	elsDeskTop.defineWin = function (option) {
		var $win = elsDeskTop.myWindow.init(option);
		_wins[option.windowsId]=$win;
		// 给返回的对象添加方法
		// 传递数据到对应的Iframe并且触发onparentdataload
		// 获取方式：
		// iframe页面： getIframeData 返回传入数据  onIframeDataChange 监听传入数据
		$win.setIframeData = function (a) {
			var ifr = $win.find('iframe')[0];
			ifr.parentData = a;
			ifr.onparentdataload = ifr.onparentdataload || $.noop;
			ifr.onparentdataload(a);
		};
		//添加到状态栏
		if (!$("#taskTab_" + option.windowsId).size()) {
			elsDeskTop.taskBar.addTask(option.windowsId, option.windowTitle, option.iconSrc);
		}
		return $win;
	};
// 关闭当前窗口
	elsDeskTop.closeCurWin = function (wId, callback) {
		if (callback) {
			callback();
		}
		$("#win_" + wId).find('a.winCloseBtn').trigger('click');
	};
// 提示框
	elsDeskTop.tip = {
		init: function (option) {
			if ($(".tip-box")) {
				$(".tip-box,.els-tip.ui_maskLayer").remove();
			}
			var defaults = {
					type: 'alert',
					displayType: 0,//0 -无 ,1-成功,2-警告,3-错误
					logoUrl: 'icon/els-icon.png',
					tipName: jsLang['i18n_js_tip'] || '提示',
					tipTitle: '',
					message: jsLang['i18n_js_illegal_opt'] || '您的操作有误',
					exit: 2000,
					closeEvent: function () {
					},
					cancelEvent: function () {
					}
				},
				tipOptions = $.extend(defaults, option);
			var content = '';
			var icon = ['', 'icon/ico-suc.png', 'icon/ico-warn.png', 'icon/ico-err.png'][~~tipOptions.displayType];
			if (tipOptions.type == 'alert') {
				content = '<div  style="display:table;height: 100%;width:100%;">'
					+ '<div  style="display:table-cell;text-align: right;">' + (tipOptions.displayType ? '<img style="width:40px;height:40px;padding-left: 10px;padding-right: 6px;" src=' + icon + ' alt="" />' : '')
					+ '</div><div  style="display:table-cell;vertical-align: middle;word-wrap: break-word;word-break: break-all;"><p style="text-align:' + (tipOptions.displayType ? 'left' : 'center') + '">' + tipOptions.message + '</p></div>'
					+ '</div>';
			} else if (tipOptions.type == 'confirm') {
				content = '<div class="confirm-tip"><div class="tip-message"><h6 style="font-weight: bolder;font-size: 15px;color: blue;">'
					+ tipOptions.message
					+ '<h6></div><span class="dis-in-b btn-option cancel-btn">' + (jsLang['i18n_js_cancel'] || "取消") + '</span><span class="dis-in-b btn-option sure-btn">' + (jsLang['i18n_js_confirm'] || '确定') + '</span></div>';
			}
			var tipHtml = '<div class="tip-box">'
					+ '<div style="margin-top: 20px;margin-bottom: 20px;margin-left: 6px;margin-right: 10px;">'
					+ content
					+ '</div><textarea readonly style="z-index:-1;position: absolute;left: -1px;top: -1px;width: 100%;height: 100%;opacity: 0.001"></textarea></div>',
				tipMark = '<div class="els-tip ui_maskLayer"></div>';

			//支持复制文本内容
			var $tip =$(tipHtml);
			$tip[0].t=tipOptions.message;
			elsDeskTop.contextMenu($tip, [[{text:'复制',func:function(){
				var $el = $(this);
				$el.find('textarea').val(this.t).select();
				if(document.execCommand('copy')){
					window.getSelection().removeAllRanges();
				}
			}}]], 'tipCopy', 3,300009);
			$("body").append(tipMark).append($tip);

			var tip_box = $("div.tip-box"), ui_boxyClose = $(".tip-close"), tip_layer = $('.els-tip.ui_maskLayer');
			tip_layer.click(function () {
				if(tipOptions.type !== 'confirm')
				$("div.tip-box,.els-tip.ui_maskLayer").remove();
				if (exitTime) {
					clearTimeout(exitTime);
				}
			});
			ui_boxyClose.click(function () {
				tip_layer.trigger('click');
			});
			var exitTime = setTimeout(function () {
				if (tipOptions.type == 'alert') {
					if (tipOptions.displayType != 3) {
						tip_layer.trigger('click');
					}
				}
			}, tipOptions.exit);
			if (tipOptions.type == 'confirm') {
				var tip_cancel = $("span.cancel-btn"), tip_sure = $(".sure-btn");
				tip_cancel.click(function () {
					if (tipOptions.cancelEvent) {
						tipOptions.cancelEvent();
						if(tipOptions.type === 'confirm')$("div.tip-box,.els-tip.ui_maskLayer").remove();
					}
					tip_layer.trigger('click');
				});
				tip_sure.click(function () {
					if (tipOptions.closeEvent) {
						tipOptions.closeEvent();
						if(tipOptions.type === 'confirm')$("div.tip-box,.els-tip.ui_maskLayer").remove();
					}
					tip_layer.trigger('click');
				});
			}
		}
	};
//加载logo遮罩
	elsDeskTop.showLoading = function (text) {
		var txt = text ? text : jsLang['i18n_js_loading'] || '加载中';
		$("<div id='showLoading'></div><div id='loadLogo'><span>" + txt + "</span></div>").appendTo('body');
		var w = $(window).width(), h = $(window).height();
		$('#showLoading').css({
			'width': '100%',
			'height': '100%',
			'position': 'absolute',
			'left': 0,
			'top': 0,
			'opacity': 1,
			'background': 'rgba(0,0,0,0.2)',
			'z-index': 9999
		}).fadeTo('slow', 1);
		$('#loadLogo').css({
			'position': 'absolute',
			'background': 'url(theme/default/images/loading.gif) no-repeat center center',
			'z-index': 1000000,
			'width': '110px',
			'height': '64px',
			'left': (w - 110) / 2,
			'top': ((h - 64) / 2) - 50
		}).find('span').css({
			'position': 'absolute',
			'left': 0,
			'bottom': '-40px',
			'width': 110,
			'display': 'block',
			'height': 40,
			'text-align': 'center'
		});
	};
//隐藏logo遮罩
	elsDeskTop.hideLoading = function () {
		$('#showLoading').remove();
		$('#loadLogo').remove();
	};
	elsDeskTop.themeSkinType = {'r': 107, 'g': 107, 'b': 107, 'a': '1.0'};
	elsDeskTop.themeSkin = function (_type, _g, _b, _a) {
		if (undefined === _type)return;
		var rgbaDeep = _type, r, g, b, a;
		if (arguments.length == 4) {
			r = _type;
			g = _g;
			b = _b;
			a = _a;
		} else {
			r = parseInt(rgbaDeep.substring(1, 3), 16).toString(10);
			g = parseInt(rgbaDeep.substring(3, 5), 16).toString(10);
			b = parseInt(rgbaDeep.substring(5, rgbaDeep.length), 16).toString(10);
			a = _g || 1;
		}
		elsDeskTop.themeSkinType.r = r;
		elsDeskTop.themeSkinType.g = g;
		elsDeskTop.themeSkinType.b = b;
		elsDeskTop.themeSkinType.a = a;
		$('js-message-bar').css({
			'background-color': 'rgba(' + (parseInt(r)) + ',' + (parseInt(g)) + ',' + (parseInt(b)) + ',' + a + ')',
			'border-bottom-color': 'rgba(' + (parseInt(r) + 2) + ',' + (parseInt(g) + 2) + ',' + (parseInt(b) + 2) + ',' + a + ')'
		});
		$('.dock_middle').css({'background-color': 'rgba(' + (parseInt(r) - 62) + ',' + (parseInt(g) - 61) + ',' + (parseInt(b) - 62) + ',' + a + ')'});
		$('#default_app').css({'border-bottom-color': 'rgba(' + (parseInt(r) + 2) + ',' + (parseInt(g) + 2) + ',' + (parseInt(b) + 2) + ',' + a + ')'});
		$('.default_tools').css({'border-bottom-color': 'rgba(' + (parseInt(r) + 2) + ',' + (parseInt(g) + 2) + ',' + (parseInt(b) + 2) + ',' + a + ')'});
		$('.myWindow .winTitle').css({
			'background-color': 'rgba(' + r + ',' + g + ',' + b + ',' + a + ')',
			'border-color': 'rgba(' + r + ',' + g + ',' + b + ',' + a + ')'
		});
		$('.myWindow .winTitle div').css({
			'border-color': 'rgba(' + (parseInt(r) + 2) + ',' + (parseInt(g) + 2) + ',' + (parseInt(b) + 2) + ',' + a + ')'
		});
		$('#bottomBarBgTask').css({'background-color': 'rgba(' + r + ',' + g + ',' + b + ',' + a + ')'});
	};
//存储登陆的信息:登陆信息以及主题皮肤
	elsDeskTop.loginStore = $.extend({
			'shemeType': elsDeskTop.themeSkinType,
			'defaultActiveData': []
		}, elsDeskTop.loginStore,
		(function () {
			var ua = navigator.userAgent.toLowerCase(),
				regStr_ie = /msie ([\d.]+);/i,
				regStr_ff = /firefox\/[\d.]+/gi,
				regStr_chrome = /chrome\/[\d.]+/gi,
				regStr_saf = /safari\/[\d.]+/gi,
				regStr_ie11 = /trident\/.*?rv:\d+/gi,
				os = (ua.indexOf("nt 10.0") > -1 && 'Windows 10')
					|| (ua.indexOf("nt 6.3") > -1 && 'Windows 8.1')
					|| (ua.indexOf("nt 6.2") > -1 && 'Windows 8')
					|| (ua.indexOf("nt 6.1") > -1 && 'Windows 7')
					|| (ua.indexOf("nt 6.0") > -1 && 'Windows Vista')
					|| (ua.indexOf("nt 5.2") > -1 && 'Windows Server 2003')
					|| (ua.indexOf("nt 5.1") > -1 && 'WinXp')
					|| (ua.indexOf("nt 5.0") > -1 && 'Win2000')
					|| ((ua.indexOf("windows") != -1 || ua.indexOf("win32") != -1) && 'Windows')
					|| ((ua.indexOf("macintosh") != -1 || ua.indexOf("mac os x") != -1) && 'Mac')
					|| ((ua.indexOf("adobeair") != -1) && 'Air')
					|| ((ua.indexOf("linux") != -1) && 'Linux')
					|| 'unknown',
				browser = (regStr_ie.test(ua) && 'Internet Explorer ' + (ua.match(regStr_ie)[1] || ''))
					|| ((ua.indexOf("firefox") > -1) && ua.match(regStr_ff)[0])
					|| ((ua.indexOf("chrome") > -1) && ua.match(regStr_chrome)[0])
					|| ((ua.indexOf("safari") > -1 && ua.indexOf("chrome") === -1) && ua.match(regStr_saf)[0])
					|| (regStr_ie11.test(ua) && 'Internet Explorer ' + (ua.match(/rv:(\d+\.\d*)/)[1] || ''))
					|| 'unknown';
			return {
				os: os,
				bs: browser
			}
		})());
}();

