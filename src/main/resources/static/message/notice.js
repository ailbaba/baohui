	// 存消息ID 去重复显示
	var msgIdList = {};
	$(function () {
		getMyUnreadChatMessage();
		getMsg();
		//window.setInterval(getMyUnreadChatMessage, 20000);  //getMsg中已包含getMyUnreadChatMessage的调用，此处有重复
		window.setInterval(getMsg, 15000);
		window.setInterval(function () {
			$('.message-scroll').niceScroll({
				cursorcolor: "#ddd",
				cursorwidth: '4px'
			}).resize();
		}, 1000);
	});
// 定义消息类型
	var
		messageType = {
			"order-sendPurchaseOrder": {"title": jsLang.i18n_js_sales_order || "销售订单", "winId": "saleOrderConfirm"},
			"order-sendSaleOrder": {"title": jsLang.i18n_js_purchase_order || "采购订单", "winId": "PurchaseOrderUpdate"},
			"order-confirmReceive": {
				"title": jsLang.i18n_js_modify_shipping_orders || "修改发货订单",
				"winId": "editDelivery"
			},
			"order-confirmReturn": {"title": jsLang.i18n_js_modify_return || "修改退货", "winId": "modifyRefundOrder"},
			"order-sendDelivery": {"title": jsLang.i18n_js_receiving_goods || "收货", "winId": "receiptConfirm"},
			"order-sendReturn": {
				"title": jsLang.i18n_js_confirm_return_goods || "确认退货",
				"winId": "refundConfirmOrderManage"
			},
			"order-viewOrderSchedule": {
				"title": jsLang.i18n_js_view_the_progress || "查看进度",
				"winId": "editOrderSchedule"
			},
			"enquiry-sendPurchaseEnquiry": {
				"title": jsLang.i18n_js_purchase_rfq || "采购询价单",
				"winId": "saleEnquiryConfirm"
			},
			"bargain-sendBargainEnquiry": {
				"title": jsLang.i18n_js_purchase_bargain || "采购议价单",
				"winId": "saleBargainConfirm"
			},
			"sale-sendSaleEnquiry": {"title": jsLang.i18n_js_sale_rfq || "销售询价单", "winId": "saleSaleConfirm"},
			"quotation-sendSaleQuotation": {
				"title": jsLang.i18n_js_sale_quotation || "销售报价单",
				"winId": "editPurchaseQuotation"
			},
			"questionnaire-sendQuestionnaire": {"title": "问卷调查" || "问卷调查", "winId": "clientQuestionnaires"},
			"physicalinventory-sendPhysicalInventory": {"title": "外协盘点单" || "外协盘点单", "winId": "salePhysicalInventoryManageActual"},
			"c2fo-msg": {"title": jsLang.i18n_js_c2fo || "企利通", "winId": "c2fo"},
			"chat-im": {"title": jsLang.i18n_js_chat_ol || "即时聊天", "winId": "IM"},
			"additionCost-sendToPurchaseAdditionCost": {
				"title": jsLang.i18n_js_additional_fee_schedule || "附加费用单",
				"winId": "purchaseAdditionCostManage"
			},
			"additionCost-sendToSaleAdditionCost": {
				"title": jsLang.i18n_js_additional_fee_schedule || "附加费用单",
				"winId": "saleAdditionCostManage"
			},
			"busRecon-replySaleBusRecon": {
				"title": jsLang.i18n_js_mange_seller_bus_rec || "销售方业务对账管理",
				"winId": "saleBusReconManage"
			},
			"busRecon-sendToPurchaseBusRecon": {
				"title": jsLang.i18n_js_mange_buyer_bus_rec || "采购方业务对账管理",
				"winId": "purchaseBusReconManage"
			},
			"contract-sendContractToSale": {
				"title": "销售合同管理" || "销售合同管理",
				"winId": "saleContractManage"
			},
			"busRecon-sendContractToPurchase": {
				"title": "采购合同管理" || "采购合同管理",
				"winId": "purchaseContractManage"
			},
			"project-upd": {"title": "项目管理", "winId": "projectManageUpd"},
			"bidding-sendPurchaseBidding": {"title": "销售方投标", "winId": "quoteManage"},
			"bidding-bidding": {"title": "销售方投标", "winId": "quoteManage"},
			"bidding-warnNoAnwserBidding": {"title": "采购招标明细查看", "winId": "addBiddingThree"},
			"designDoc-sendDesignDoc": {"title": "分配供应商", "winId": "assignDesignDoc"},
			"designDoc-saleConfirmDesignDoc": {"title": "供应商确认设计文档", "winId": "saleConfirmDesignDoc"},
			"requirement-publishPurchaseRequirement": {"title": "需求计划", "winId": "replyRequirementPlanning"},
			"requirement-publishSaleRequirement": {"title": "需求计划", "winId": "editPurchaseRequirement"},
			"sampleOrder-sendSampleOrderToSale": {"title": "样品管理", "winId": "saleSampleManage"},
			"sampleOrder-sendSampleOrderToPurchase": {"title": "样品管理", "winId": "purchaseSampleManage"},
			"standard-saleMainDataManage": {"title": "客户资料", "winId": "saleMainDataManage"},
			"standard-purchaseMainDataManage": {"title": "供应商资料", "winId": "purchaseMainDataManage"},
			"standard-purchaseSupplyManager": {
				"title": "采购方准入评估" || "采购方准入",
				"winId": "purchaseSupplyManager"},
			"standard-saleSupplyManager": {
				"title": "销售方准入评估" || "销售方准入", 
				"winId": "saleSupplyManager"},
			"loan-applyLoanMsg": {"title": "供应链金融", "winId": "loanManageDetail"},
			"friend-requestAddFriend": {"title": "好友验证", "winId": "friendVerify"},
			"deliveryNote-deleteDeliveryNote": {"title": "销售送货通知单" || "销售送货通知单","winId": "saleDeliveryNoteManager"},
			"default": {"title": jsLang.i18n_js_message_center || "消息中心", "winId": "msgManage"}
		},
		openFriendVerifyWindow = function () {
			$('#friendVerify').trigger('click');
		},
		onGetMsgSuccess = function (data) {
			if (data && data.rows && data.rows.length > 0) {
				var newDatas = [];
				data.rows.forEach(function (m) {
					if (msgIdList[m['msgId']])return;
					msgIdList[m['msgId']] = 1;
					newDatas.push({
						tag: 'li',
						id: 'msg-' + m['msgId'],
						onclick: m['msgUrl'] && openMsgWindow.bind(null,m['msgId'], m['msgType'], m.elsAccount, m.elsSubAccount, m.fromName, m.msgUrl,m.module) || undefined,
						class: 'msg-line',
						children: [{
							title: m['fromName'],
							class: 'msg-from',
							tag: 'span',
							text: m['fromName']
						}, {
							class: 'msg-content',
							tag: 'span',
							text: m['msgContent']
						}, {
							class: m['msgUrl'] && 'msg-btn' || '',
							tag: 'a',
							href: '#',
							text: m['msgUrl'] && (jsLang.i18n_js_detail || '查看') || ''
						}]
					})
				});
				$.Messager.anim('slide', 500)
					.show(jsLang.i18n_js_msg_notice || '消息提醒', newDatas, 10000).$el.find('.message-scroll')
					.niceScroll({
						cursorcolor: '#ddd',
						cursorwidth: '4px',
						horizrailenabled: false
					});
			}
		},
		getMsg = function () {
			getMyUnreadChatMessage();
			ajaxWorker("rest/MsgService/getMsg/" + elsAccount + "/" + elsSubAccount + "?t=" + new Date().getTime())
				.done(onGetMsgSuccess)
				.fail();
		},
		getWinInfo = function (msgType) {
			return messageType[msgType] || "default";
		},
		openMsgWindow = function (msgId, msgType, fromElsAccount, fromElsSubAccount, fromName, msgUrl,module) {
			console.log(msgUrl+"    "+msgId);
			var winInfo = getWinInfo(msgType);
			var winId = winInfo.winId + fromElsAccount + fromElsSubAccount + msgId;
			if (msgUrl.indexOf("?") > 0) {
				msgUrl = msgUrl + "&winId=" + winId;
			} else {
				msgUrl = msgUrl + "?winId=" + winId;
			}
			elsDeskTop.defineWin({
				'iconSrc': 'icon/els-icon.png',
				'windowsId': winId,
				'windowTitle': winInfo.title,
				windowSubTitle: fromName,
				'iframSrc': msgUrl,
				windowStatus: 'maximized',
				windowMinWidth: 960,
				windowMinHeight: 700,
				'windowWidth': 960,
				'windowHeight': 700,
				'parentPanel': ".currDesktop"
			});
			// 将消息设为已处理
			ajaxWorker({
				url: "rest/MsgService/handleMsg/" + module + "/" + elsAccount + "/" + elsSubAccount + "/" + msgId + "?t=" + new Date().getTime(),
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function (data) {
				},
				error: function (data) {
				}
			});
			if ($.Messager.$el)$.Messager.$el.find('#msg-' + msgId).remove();
			if (!$.Messager.contentDom||!$.Messager.contentDom.childNodes.length)$.Messager.close();
		};
		var getMyUnreadChatMessage = function () {
			$.ajax({
				url: "rest/ChatMessageService/findMyUnreadChatMessage/" + elsAccount + "/" + elsSubAccount + "?t=" + new Date().getTime(),
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				timeout : 35000, //超时时间设置，单位毫秒
				success: function (data) {

				},
				error: function (textStatus) {
					if(textStatus=="timeout"){
						getMyUnreadChatMessage();
					}
				}
			});
		};