<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<head>
	<link rel="stylesheet" type="text/css" href="css/chat.css"/>
	<link href="css/smartMenu.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="js/jquery-smartMenu-min.js"></script>
</head>
<body>
<div class="">
	<div class="content">
		<div class="chatRight">
			<div class="chat03" style="overflow:hidden">
				<div class="chat03_icon_search"></div>
				<div class="icon_clear">x</div>
				<input class="chat03_search" type="text"
				       placeholder='<i18n:I18n key="i18n_chat_search" defaultValue="搜索"/>' maxlength="20">
				<div class="chat03_title">
					<label class="chat03_title_t"></label>
				</div>
				<div id="drop" class="chat03_content" style="overflow: auto;">
				</div>
				<div class="chat03_bottom_bar">
					<div class="chat03_bar_icon" data-toggle="@showGroupA">
						<img src="img/reload.png"
						     title='<i18n:I18n key="i18n_chat_refresh_partner_list" defaultValue="刷新好友列表"/>'>
					</div>
					<div class="chat03_bar_icon " data-toggle="#addFriend">
						<img src="icon/destop-icon/desktop_icon_91.gif"
						     title='<i18n:I18n key="i18n_label_addfrient" defaultValue="添加好友"/>'>
					</div>
					<div class="chat03_bar_icon" data-toggle="#friendManager">
						<img src="icon/destop-icon/desktop2_icon_181.png"
						     title='<i18n:I18n key="i18n_label_friendmanager" defaultValue="好友管理"/>'>
					</div>
					<div class="chat03_bar_icon" data-toggle="#msgManage">
						<img src="icon/icon3.png" title='<i18n:I18n key="i18n_js_message_center" defaultValue="消息中心"/>'>
					</div>
					<div class="chat03_bar_icon "></div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<div style="clear: both;">
		</div>
	</div>
</div>
<script type="text/javascript">

	var ajaxWorker = $.ajax;  //解决客户端在好友过多时白屏的问题 modify by ctq 2016/10/14

	$('body').on('click',function(){
		top.$('.smart_menu_box').hide();
	});
	//显示不同类型未处理数ms=[{type:'order',num:'1'},{type:'enquiry',num:'1'},,{type:'busrecon',num:'1'}]
	function tipSheetType(ms) {
		if(ms && ms.length) {
			return definedDom({
				'tag':'div',
				'class':'dis-in-b tip-sheet-type',
				'children': ms.map(function(m,d) {
					if(parseInt(m.num)) {
						var rNum=parseInt(m.num)>9?'9+':parseInt(m.num);
						var rtxt='';
						if(m.type=='order') {
							rtxt='订单数';
						}
						if(m.type=='enquiry') {
							rtxt='询价单数';
						}
						if(m.type=='busrecon') {
							rtxt='对账单数';
						}
						return {
								'tag':'div',
								'class':'dis-in-b sheet-num-wrap '+ m.type,
								'children':[
								           	{'tag':'span','text':rNum,title:rtxt} 
								           ]
						};
					} else { 
						return {};
					}
				})
			})
		}else {
			return [];
		}
	};
	var
			$win, $c3Title, $c3Content, $c3Search,
			$c3BBar, $c3TitleT, $c3SearchBtn, $c3SearchClear,
			_m = {
				d: {},

				//订单管理
				get order() {
					var urlPrefix='ordermanage/purchaseorder/purchaseOrderManage.jsp';
					var helpUrl = "quickGuide/quick_guide_purchaseOrder_cn2.0.pdf";
					var advUrl="[]"
					if(role === 'sale'){
						urlPrefix='ordermanage/saleorder/saleOrderManager.jsp';
						helpUrl = "quickGuide/quick_guide_saleOrder_cn.pdf";
						 advUrl="icon/load.gif|loan";
					}
					var url = urlPrefix+'?fromElsAccount='
							+ elsAccount
							+ '&fromElsSubAccount='
							+ elsSubAccount
							+ '&toElsAccount='
							+ _m.d.friendElsAccount
							+ '&toCompanyName='
							+ encodeURIComponent(_m.d.friendName)
							+'&t='+new Date().getTime();
					if(role === 'sale'){
						return {
							windowSubTitle: '<i18n:I18n key="i18n_chat_order_manage" defaultValue="订单管理"/>',
							windowMinWidth: 1210,
							windowMinHeight: 710,
							winHelpClick:helpUrl,
							windowStatus: 'maximized',
							//showAdv: true,
							winHelpBtn: true,
							//advArr: advUrl,
							parentPanel: '.currDesktop',
							windowWidth: 1210,
							windowHeight: 710,
							windowsId: 'OrderManage_' + _m.d.friendElsAccount,
							iframSrc: url
						}
					}else{
						return {
							windowSubTitle: '<i18n:I18n key="i18n_chat_order_manage" defaultValue="订单管理"/>',
							windowMinWidth: 1210,
							windowMinHeight: 710,
							winHelpClick:helpUrl,
							windowStatus: 'maximized',
							//showAdv: true,
							winHelpBtn: true,
							parentPanel: '.currDesktop',
							windowWidth: 1210,
							windowHeight: 710,
							windowsId: 'OrderManage_' + _m.d.friendElsAccount,
							iframSrc: url
					}
					}
				},

				//询报价管理
				get enquiry() {
					var urlPrefix = 'enquirymanage/purchase/enquiryManage.jsp';
					var helpUrl = "quickGuide/quick_guide_purchaseEnquiry_cn.pdf";
					if (role === 'sale') {
						urlPrefix = 'enquirymanage/saleorder/enquiryOrderManager.jsp';
						var helpUrl = "quickGuide/quick_guide_quote_manage_cn.pdf";
					}
					
					if (role === 'sale') {
						return {
							windowSubTitle	 : '<i18n:I18n key="i18n_enquiry_quotedmanage" defaultValue="询报价管理"/>',
							windowMinWidth: 1210,
							windowMinHeight: 710,
							winHelpClick:helpUrl,
							windowStatus: 'maximized',
							//showAdv: true,
							winHelpBtn: true,
							//advArr: 'icon/load.gif|loan',
							windowWidth: 1210,
							windowHeight: 710,
							windowsId: 'purchaseEnquiryManage_'+ _m.d.friendElsAccount,
							iframSrc: urlPrefix + '?fromElsAccount=' + elsAccount
							+ '&fromElsSubAccount=' + elsSubAccount
							+ '&toElsAccount=' + _m.d.friendElsAccount
							+ '&toCompanyName='
							+ encodeURIComponent(_m.d.friendName)
							+ '&t=' + new Date().getTime()
						}
					}else{
						return {
							windowSubTitle	 : '<i18n:I18n key="i18n_enquiry_quotedmanage" defaultValue="询报价管理"/>',
							windowMinWidth: 1210,
							windowMinHeight: 710,
							winHelpClick:helpUrl,
							windowStatus: 'maximized',
							//showAdv: true,
							winHelpBtn: true,
							windowWidth: 1210,
							windowHeight: 710,
							windowsId: 'purchaseEnquiryManage_'+ _m.d.friendElsAccount,
							iframSrc: urlPrefix + '?fromElsAccount=' + elsAccount
							+ '&fromElsSubAccount=' + elsSubAccount
							+ '&toElsAccount=' + _m.d.friendElsAccount
							+ '&toCompanyName='
							+ encodeURIComponent(_m.d.friendName)
							+ '&t=' + new Date().getTime()
						}
					}
				},

				//业务对账
				get busrecon() {
					var helpUrl = "quickGuide/quick_guide_purchase_bidding_cn.pdf";
					if(role === 'sale'){
						helpUrl = "quickGuide/quick_guide_saleReconciliation_cn.pdf";
					}

					return {
						windowSubTitle: '<i18n:I18n key="i18n_chat_reconciliations_management" defaultValue="对账管理"/>',
						'windowMinWidth': 1210,
						windowMinHeight: 710,
						winHelpClick:helpUrl,
						windowStatus: 'maximized',
						winHelpBtn: true,
						windowWidth: 1210,
						windowHeight: 710,
						iframSrc: 'busreconmanage/' + role + '/' + role + 'BusReconManage.jsp'
						+ '?fromElsAccount=' + elsAccount
						+ '&fromElsSubAccount=' + elsSubAccount + '&toElsAccount='
						+ _m.d.friendElsAccount
						+ '&toCompanyName='
						+ encodeURIComponent(_m.d.friendName)
						+ '&t=' + new Date().getTime()
						, windowsId: 'BusreconManage_' + _m.d.friendElsAccount
					}
				},

				//会话管理
				get listSubAct() {
					return {
						windowSubTitle: '<i18n:I18n key="i18n_chat_session_management" defaultValue="会话管理"/>',
						windowMaximize: false,
						windowMinimize: false,
						windowStatus: 'maximized',
						windowWidth: 300,
						windowHeight: 120,
						iframSrc: 'account/listSubAccount.jsp?toElsAccount=' + _m.d.friendElsAccount + '&friendName=' + encodeURIComponent(_m.d.friendName),
						windowsId: 'ChatSessionManage_' + _m.d.friendElsAccount,
						summary: '',
						data: _m.d
					}
				},//管理
				get listPurchaseComeHis() {
					var urlPrefix = 'supplierstandard/sale/addSaleMainData.jsp';
					return {
						windowSubTitle: '<i18n:I18n key="" defaultValue="供应商管理"/>',
						windowMinWidth: 1210,
						windowMinHeight: 710,
						windowStatus: 'maximized',
						showAdv: true,
						winHelpBtn: true,
						parentPanel: '.currDesktop',
						windowWidth: 1210,
						windowHeight: 710,
						iframSrc: urlPrefix + '?toElsAccount=' + _m.d.friendElsAccount
						+ '&t=' + new Date().getTime(),
						windowsId: 'listPurchaseComeHis_' + _m.d.friendElsAccount,
						summary: '',
						data: _m.d
					}
				}
			},
			openWin = function (scope, type) {
				_m.d = scope.dat;
				var opt = $.extend({},_m.d, _m[type]);
				parent.elsDeskTop.defineWin(opt)
			},
			imageMenuData = [[{
				text: '<i18n:I18n key="i18n_chat_order_manage" defaultValue="订单管理"/>',
				func: function () {
					openWin(this, 'order')
				}
			}, {
				text: '<i18n:I18n key="i18n_enquiry_quotedmanage" defaultValue="询报价管理"/>',
				func: function () {
					openWin(this, 'enquiry')
				}
			}], [{
				text: '<i18n:I18n key="i18n_chat_business_reconciliations" defaultValue="业务对账"/>',
				func: function () {
					openWin(this, 'busrecon')
				}
			}],
				[{
					text: '<i18n:I18n key="i18n_chat_session_management" defaultValue="会话管理"/>',
					func: function () {
						openWin(this, 'listSubAct')
					}
				}],[{
					text: '<i18n:I18n key="" defaultValue="供应商管理"/>',
					func: function () {
						openWin(this, 'listPurchaseComeHis')
					}
				}]
			],
			resizeC3Content = function () {
				$c3Content.height($win.height() - $c3Title.outerHeight() - $c3BBar.outerHeight() - $c3Search.outerHeight());
				if (!$c3Content.nScroll) {
					$c3Content.nScroll = $c3Content.niceScroll({cursorcolor: "#ddd", cursorwidth: '8px'});
				} else {
					$c3Content.nScroll.resize();
				}
			},
			showGroupA = function () {
				var queryGAUrl =
						"rest/FriendsService/findMyFriendsGroup/"
						+ elsAccount + "/" + elsSubAccount
						+ "/1?t=" + new Date().getTime();
				$c3TitleT.html(definedDom(
						{
							tag: 'div',
							children: [{
								tag: 'div',
								readOnly: true,
								id: 'groupA',
								name: 'groupA',
								class: 'select',
								onchange: function () {
									var ul = $('.chat03_title_t ul');
									ul.slideUp(100);
									showGroupB(this.gId);
								},
								onclick: function (e) {
									e.stopPropagation();
									e.preventDefault();
									var ul = $('.chat03_title_t ul');
									ul.slideDown(100);
								}
							}, function (cb) {
								ajaxWorker(queryGAUrl)
										.done(function (data) {
											if (data && data.length > 0)
												cb({
													children: data.map(function (d, i) {
														if (0 === i) {
															$('#groupA').text(d.groupName);
															showGroupB(d.groupId);
														}
														if ('1' === '' + d.groupClass) {
															return {
																tag: 'li',
																text: d.groupName,
																value: d.groupId,
																onclick: function (e) {
																	e.stopPropagation();
																	e.preventDefault();
																	var gA = $('#groupA')[0];
																	if (gA.innerHTML !== this.innerHTML) {
																		gA.innerHTML = this.innerHTML;
																		gA.gId = this.value;
																		gA.onchange();
																	}
																}
															}
														}
													})
												});
										}).fail();
								return {
									tag: 'ul',
									onmouseleave: function () {
										$(this).slideUp(100);
									}
								}
							}]
						})
				);
			},
			showGroupB = function (groupIdA) {
				var queryUrl = 'rest/FriendsService/findMyFriendsGroupBbyGroupA/'
						+ elsAccount + '/' + elsSubAccount + '/' + groupIdA
						+ '?t=' + new Date().getTime();
				$c3Content.html(definedDom({
							children: function (cbk) {
								ajaxWorker(queryUrl).done(function (data) {
									var type = 2;
									if (!data || data.length === 0) {
										type = 1;
										data = [{
											groupName: '<i18n:I18n key="i18n_chat_ungrouped" defaultValue="未分组"/>',
											groupId: groupIdA
										}]
									}
									cbk({
										children: data.map(function (da, i) {
											return {
												children: [{
													tag: 'h2',
													id: 'h' + i,
													text: da.groupName,
													onclick: showHideUl.bind(null, i),
													css: {
														background: 'url(images/up.gif) no-repeat 260px center'
													}
												}, function (cb) {
													var qUrl = 'rest/FriendsService/findMyFriends/'
															+ elsAccount + '/' + elsSubAccount + '/'
															+ da.groupId + '/' + type
															+ '?t=' + new Date().getTime();
													var basePath = '<%=basePath%>';
													var path = '<%=path%>';
													var pathNum = basePath.lastIndexOf(path);
													var logoPath = basePath.substring(0, pathNum) + "/opt/nfsshare/";
													ajaxWorker(qUrl).done(function (dat) {
														if (dat.length > 0) {
															cb({
																children: dat.map(function (d, i) {
																	//在合作伙伴的供应商客户列表中增加订单、询价单、会话图标标示，以不同颜色的圆形图标加数字显示 @author jiangzhidong @date 20160827
																	//d.message=[{type:'order',num:'1'},{type:'enquiry',num:'0'},{type:'busrecon',num:'5'}];
																	d.message = JSON.parse(d.message)
																	if (d.groupIdA == groupIdA) return {
																		tag: 'li',
																		func: function () {
																			d._dom = this;
																			var self = this;
																			this.dat = {
																				friendName:d['friendCompanyName'],
																				friendElsAccount:d.friendElsAccount,
																				parentPanel: '.currDesktop',
																				txNum: 0,
																				summary: d['signature'],
																				get iconSrc(){return self.querySelector('img').src},
																				get avatar(){return self.querySelector('img').src},
																				windowTitle:d['friendCompanyName']
																			};
																			var beforeShow = function(){};
																			beforeShow.call = function(){
																				var e = this.call.caller.arguments[0];
																				var o = top.$(frameElement).offset();
																				var x = e.clientX;
																				var y = e.clientY;
																				Object.defineProperties(e,{
																					clientX:{get:function(){
																						return  o.left+x;
																					}},
																					clientY:{get:function(){
																						return o.top+y;
																					}}
																				});
																			};
																			top.$(this).smartMenu(imageMenuData, {
																				beforeShow : beforeShow
																			});
																		},
																		onclick: function () {
																			openWin(this,'order')
																		},
																		children: [{
																			tag: 'label',
																			class: 'Y' === d.friendIsonline ? 'online' : 'offline'
																		}, {
																			tag: 'a',
																			href: 'javascript:void(0)',
																			children: {
																				tag: 'img',
																				src: null == d.logo ? 'img/head/' + ((i + 2) % 26 + 1) + '.jpg' : logoPath + d.logo,
																				onerror: function () {
																					this.onerror = function () {
																					};
																					this.src = 'img/head/' + ((i + 2) % 26 + 1) + '.jpg';
																				}
																			}
																		}, {
																			tag: 'a',
																			href: 'javascript:void(0)',
																			title: d.friendElsAccount+'_'+d.friendCompanyName,//光标els号 @author jiangzhidong @date 20160817
																			class: 'chat03_name' + (d.signature && ' show_bio' || ''),
																			text: textClip(d.friendCompanyName,20)
																		}, {
																			tag: 'a',
																			title: d.signature || '',
																			href: 'javascript:void(0)',
																			class: 'chat03_bio '+(d.message&&d.message.length?'had-message':''),
																			text: d.signature || ''
																		}].concat(tipSheetType(d.message))
																	}
																})
															})
														}
														resizeC3Content();
													});
													return {
														tag: 'ul',
														id: 'u' + i
													}
												}]
											}
										})
									});
									resizeC3Content();
								});
								return {tag: 'div'}
							}
						})
				);
			},
			showHideUl = function (i) {
				var ohId = "h" + i;
				var ulId = "u" + i;
				var oH2 = document.getElementById(ohId);
				var $oUl = $('#' + ulId);
				oH2.style.background = "url(images/" + ($oUl.is(':visible') ? "down" : "up") + ".gif) no-repeat 260px center";
				$oUl.slideToggle(200, resizeC3Content);
			};

	$(function () {
		$win = $(window);
		$c3Title = $('.chat03_title');
		$c3Content = $('#drop');
		$c3BBar = $('.chat03_bottom_bar');
		$c3TitleT = $('.chat03_title_t');
		$c3Search = $('.chat03_search');
		$c3SearchBtn = $('.chat03_icon_search');
		$c3SearchClear = $('.icon_clear');

		showGroupA();
		resizeC3Content();
		$win.resize(resizeC3Content);
		//点击空白区域触发右键按钮隐藏
		$(document).click(function (e) {
			$(e.target).find('body').click();
		});
		var showSearch = function (e) {
			e.stopPropagation();
			$c3Search.slideDown(200, resizeC3Content);
			setTimeout(function () {
				$c3SearchClear.show();
			}, 300);
			$c3SearchBtn.css({
				right: '8px',
				top: '4px'
			});
		};
		var hideSearch = function (e) {
			e && e.stopPropagation();
			if ($c3Search.val())return;
			$c3SearchClear.hide();
			$c3Search.slideUp(200, resizeC3Content);
			$c3SearchBtn.css({
				right: '',
				top: ''
			});
		};
		var searchList = function (a) {
			a = (a || '').replace(/^\s*|\s*$/, '');
			var $lis = $c3Content.find('ul li').hide();
			if (!a) {
				$c3Search.val('');
				$lis.show();
			}
			var c = $c3Search.val().replace(/^\s*|\s*$/, '');
			if (c) {
				$lis.filter(function (i, li) {
					return $(li).text().toLowerCase().indexOf(c.toLowerCase()) !== -1;
				}).show();
			}
		};
		$c3SearchClear.click(function () {
			var a = $c3Search.val().replace(/^\s*|\s*$/, '');
			if (!a)hideSearch();
			searchList();
		});
		$c3SearchBtn.click(showSearch);
		$c3Search.blur(hideSearch);
		$c3Search.on('input propertychange', function () {
			searchList($c3Search.val());
		});

		$win.click(function (e) {
			var $t = $(e.target);
			if (!$t.is($c3Search) && !$t.is($c3SearchBtn) && !$t.is($c3SearchClear))hideSearch(e);
		});

		$('.chat03_bar_icon').click(function () {
			var t = $(this).attr('data-toggle');
			if (/^@/g.test(t)) {
				t = t.replace('@', '') + '()';
				eval(t);
			} else {
				$(top.document).find(t).click()
			}
		});
		window.setInterval(showGroupA, 1 * 60000);		//从5分钟调整为1分钟	MODIFIED BY CTQ 20106/6/6 BUG#1001-53
	});

	var newsArray = [];
	function getMyUnreadChatMessage() {
		ajaxWorker({
			url: "rest/ChatMessageService/findMyUnreadChatMessage/" + elsAccount + "/" + elsSubAccount + "?t=" + new Date().getTime(),
			type: "GET",
			contentType: "application/json",
			dataType: "json",
			success: function (data) {
				if (data.length > 0) {
					for (i = 0; i < data.length; i++) {
						var friend = data[i].fromElsAccount;
						//showNews("img_"+friend);
						var news = setInterval(function () {
							if (!-[1,]) {
								showNews("img_" + friend);
							} else {
								$("#" + friend).fadeOut(200).fadeIn(200);
							}
						}, 1200);
						if ($.inArray(news, newsArray) == -1)
							newsArray.push(news);
					}
				} else {
					for (var i = 0; i < newsArray.length; i++) {
						clearInterval(newsArray[i]);
					}
				}

			},
			error: function (data) {
				parent.elsDeskTop.tip.init({
					type: 'alert',
					displayType: '3',
					message: data.message
				});
			}
		});
	}
	function showNews(objId) {
		var obj = document.getElementById(objId);
		if (obj == null || typeof(obj) == "undefined") {
			return;
		}
		if (obj.style.visibility == "visible")
			obj.style.visibility = "hidden";
		else
			obj.style.visibility = "visible";
		setTimeout("showNews(" + objId + ")", 300);
	}
</script>
</body>