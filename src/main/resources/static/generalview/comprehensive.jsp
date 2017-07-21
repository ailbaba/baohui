<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ include file="/elsHeader.jsp"%>
<link type="text/css" rel="stylesheet" href="cps.css">
<script type="text/javascript" src="../extend/formbuilder/doT.min.js"></script>
<script type="text/javascript" src="cps.js"></script>
<script type="text/javascript" src="status.js"></script>
<script type="text/javascript" src="dataHandle.js"></script>

<body>
<div id="cps">
	<div id="cps-head">
		<div id="cps-searchBox"></div>
	</div>
	<div id="cps-menu">
		<div id="cps-menu-head">供应商列表</div>
		<div id="cps-menu-list"></div>
	</div>
	<div id="cps-main"></div>
</div>
<script>

$(function () {
		//todo : 头像路径是否拼接正确？
		var basePath = (/.*?\/ELSServer\//.exec(location.href) || [''])[0];
		var path = '<%=path%>';
		var pathNum = basePath.lastIndexOf(path);
		var logoPath = basePath.substring(0, pathNum) + '/data/nfsshare/';
		var maxCount = 6;
		/**
		 * 创建表格模板
		 * */
		var tableTpl = function (h, v, n) {
			var t = '<table><tr>';
			var r = '</tr>{{~it' + (n ? ('.' + n) : '') + '.slice(0,' + maxCount + '):r:index}}<tr>';
			for (var i = 0; i < h.length; i++) {
				var _r,_v=v[i].replace(/^\s+|\s+$/,'');
				if(/^\w/.test(_v)){
					_r = '{{!r.' + _v + '}}'
				}else {
					_r = '{{!'+_v+'}}'
				}
				t += '<th>' + h[i] + '</th>';
				r += '<td>'+_r+'</td>';
			}
			return t + r + '</tr>{{~}}</table>';
		};
		
    	var startDate = new Date() ;
    	var endDate = new Date() ;
    	endDate.setMonth(endDate.getMonth()-3);
    	
    	startMonth = (startDate.getMonth()+1)>=10?(startDate.getMonth()+1):'0'+(startDate.getMonth()+1);
    	startDay = startDate.getDate()>= 10?startDate.getDate():'0'+startDate.getDate();
    	
    	endMonth = (endDate.getMonth()+1)>=10?(endDate.getMonth()+1):'0'+(endDate.getMonth()+1);
    	endDay = endDate.getDate()>= 10?endDate.getDate():'0'+endDate.getDate();
    	
    	var startDate = startDate.getFullYear()+""+startMonth+""+startDay ;
    	var endDate = endDate.getFullYear()+""+endMonth+""+endDay ;
    	
		cpsManagerInit({
			menu_list_opt: { 
				 // 左边列表数据接口配置,
				url: 'rest/FriendsService/myFriendsMostOrders/'+elsAccount+'/'+elsSubAccount+'/'+endDate+'/'+startDate ,
				type: 'get'
			},
			cards: [// 右边面板列表
				[
					{
						name: '订单',
						url: 'rest/PurchaseOrderService/order/findPurchaseOrderByCondtion',
						param: function(d){
							return {
								elsAccount: elsAccount,
								toElsAccount:d.friendElsAccount,
								pageSize: '5'
							}
						},
						template: tableTpl(
								['采购订单号','订单日期','订单状态','交付状态','总计金额','货币'],
								['purchaseOrderNumber','orderDate','(getOrderStatue(r.orderStatus))','(getOrderSendStatus(r.orderSendStatus))','fbk30','fbk7'],
								'rows'),
						type: 'post',
						more: function (d) {
							var urlPrefix = 'ordermanage/purchaseorder/purchaseOrderManage.jsp';
							var helpUrl = "quickGuide/quick_guide_purchaseOrder_cn.pdf";
							if (role === 'sale') {
								urlPrefix = 'ordermanage/saleorder/saleOrderManager.jsp';
								helpUrl = "quickGuide/quick_guide_saleOrder_cn.pdf";
							}
							var url = urlPrefix + '?fromElsAccount='
									+ elsAccount
									+ '&fromElsSubAccount='
									+ elsSubAccount
									+ '&toElsAccount='
									+ d.friendElsAccount
									+ '&toCompanyName='
									+ encodeURIComponent(d['friendCompanyName'])
									+ '&t=' + new Date().getTime();
							var opt = {
								windowSubTitle: '<i18n:I18n key="i18n_chat_order_manage" defaultValue="订单管理"/>',
								windowMinWidth: 1210,
								windowMinHeight: 710,
								winHelpClick: helpUrl,
								windowStatus: 'maximized',
								showAdv: true,
								winHelpBtn: true,
								advArr: 'icon/banner01.jpg,icon/banner02.jpg,icon/banner03.jpg,icon/banner04.jpg',
								parentPanel: '.currDesktop',
								windowWidth: 1210,
								windowHeight: 710,
								windowsId: 'OrderManage_' + d.friendElsAccount,
								iframSrc: url,
								friendName: d['friendCompanyName'],
								friendElsAccount: d.friendElsAccount,
								txNum: 0,
								summary: d['signature'],
								iconSrc: d.logo !== 'null' && d.logo ? logoPath + d.logo : 'icon/els-icon.png',
								windowTitle: d['friendCompanyName']
							};
							top.elsDeskTop.defineWin(opt);
						}
					}, {
					name: '交货计划',
					param: function(d){
						return {
							elsAccount: elsAccount,
							elsSubAccount: elsSubAccount,
							toElsAccount:d.friendElsAccount,
							pageSize: '5'
						}
					},
					more: function () {
						top.$('#purchaseDeliveryPlanReport').click();
					},
					url: basePath + 'rest/PurchaseOrderService/findPurchasePlanReport',
					template: tableTpl(
							['采购订单号','行号', '计划交货日期','计划交货数','已交货数量'],
							['purchaseOrderNumber','orderItemNumber', '(new Date(r.purchaseDeliveryTimePlan).format(\'yyyy-MM-dd\'))', 'purchaseDeliveryQuantityPlan','deliveryQuantity'],
							'rows')
				}, {
					name: '收货管理',
					more: function () {
						top.$('#queryReceipt').click();
					},
					url: basePath + 'rest/MaterialVoucherService/findMaterialVoucherHeaderByStatus',
					type: 'post',
					param: function(d){
						return {
							elsAccount: elsAccount,
							toElsAccount:d.friendElsAccount,
							mobileType:'101' ,
							deliveryStatus: '2' ,
							pageSize: '5'
						}
					},
					template: tableTpl(
							['物料凭证编号','采购订单号','凭证日期','发货状态','过账日期'],
							['materialVoucherNumber','purchaseOrderNumber','(new Date(r.voucherDate).format(\'yyyy-MM-dd\'))','(getDeliveryStatus(r.deliveryStatus))','(new Date(r.postDate).format(\'yyyy-MM-dd\'))'],
							'rows')
						
				}, {
					name: '采购方业务对账',
					more: function () {
						top.$('#PurchaseBus').click();
					},
					url: 'rest/PurchaseBusinessReconciliationService/findPurchaseBusReconHeadList',
					param: function(d){
						return {
							elsAccount: elsAccount,
							toElsAccount: d.friendElsAccount,
							pageSize: '5'
						}
					},
					type: 'post',	
					template: tableTpl(
							['采购业务对账单号','对账单状态','对账日期','总税金额','币别','发票号'],
							['purchaseBusReconNumber','(busReconStatus(r.busReconStatus))','(new Date(r.reconDate).format(\'yyyy-MM-dd\'))','totalTaxAmount','currency','invoiceNumber'],
							'rows')
				}
				], [{
					name: '会话',
					url: function(d){
						return 'rest/ChatMessageService/findNewestChatRecord/'+elsAccount+'/'+elsSubAccount+'/5'
					},
					type: 'get',
					template: tableTpl(
							            [''],
							            ['(getdfInfo(r.toElsAccount,r.toElsSubAccount,r.content))']
							           ),
					more: function (d) {
						var opt = {
							windowSubTitle: '<i18n:I18n key="i18n_chat_session_management" defaultValue="会话管理"/>',
							windowMaximize: false,
							windowMinimize: false,
							windowStatus: 'regular',
							windowWidth: 300,
							windowHeight: 120,
							windowTitle: d['friendCompanyName'],
							parentPanel: '.currDesktop',
							txNum: 0,
							iframSrc: 'account/listSubAccount.jsp?toElsAccount='
							+ d.friendElsAccount + '&friendName='
							+ encodeURIComponent(d['friendCompanyName']),
							windowsId: 'ChatSessionManage_' + d.friendElsAccount,
							iconSrc: d.logo !== 'null' && d.logo ? logoPath + d.logo : 'icon/els-icon.png',
							data: {
								friendName: d['friendCompanyName'],
								friendElsAccount: d.friendElsAccount,
								summary: d['signature'],
								iconSrc: d.logo !== 'null' && d.logo ? logoPath + d.logo : 'icon/els-icon.png',
								avatar: d.logo !== 'null' && d.logo ? logoPath + d.logo : 'icon/els-icon.png',
								windowTitle: d['friendCompanyName']
							}
						};
						top.elsDeskTop.defineWin(opt);
					}
				}, {
					name: '供应商主数据',
					url: 'rest/SupplierMainDataService/getSupplierMainDataList',
					param: function(d){
						return {
						     elsAccount: elsAccount , 
						     toElsAccount:d.friendElsAccount ,
						     pageSize: '5'
						}
					  },
					type: 'post',
					template: tableTpl(
							['行业大类','公司名称','电话号码','传真号码'],
							['toElsAccount','companyShortName','telephone1','fax'],
							'rows'
					)
				}, {
					name: '单据审批',
					url: 'rest/AuditService/getTodoList',
					param:function(d){
						return {	
							elsAccount: elsAccount , 
							elsSubAccount: elsSubAccount , 
							businessType: "all", 
							toElsAccount:d.friendElsAccount ,
							pageSize: "5"
						}
					},
					type: 'post' ,
					template: tableTpl(
							['单据ID','创建日期','单据类型','节点名称','审批状态'],
							['(getVoucherId(r.businessId))','(new Date(r.createDate).format(\'yyyy-MM-dd\'))','businessType','flowName','(getXJAuditStatus(r.auditStatus))'],
							'rows'
					)
				}
				],
				[{
					name: '询价',
					more:function(){top.$('#purchaseEnquiryManage').click()},
					url: 'rest/PurchaseEnquiryItemService/findEnquiryList/105012',
					type: 'post',
					param: function(d){
						return {
								elsAccount: elsAccount , 
								elsSubAccount: elsSubAccount , 
								toElsAccount:d.friendElsAccount ,
								pageSize: '5'
					   }
					},
					template: tableTpl(
							['询价单号','询价单状态','审批状态','发送状态'],
							['purchaseEnquiryNumber','(xjOrderStatus(r.orderStatus))','(getXJAuditStatus(r.auditStatus))','(getXJOrderSendStatus(r.orderSendStatus))'],
							'rows'
					)
				}, {
					name: '采购需求计划',
					more:function(){top.$('#purchaseRequirement').click()},
					url: 'rest/PurchaseRequirementService/findPurchaseRequirement',
					param: function(d){
						return {
								elsAccount: elsAccount , 
								elsSubAccount: elsSubAccount , 
								toElsAccount:d.friendElsAccount ,
								pageSize: '5'
					   }
					},	
					type: 'post',
					template: tableTpl(
							['需求单号','计划时间从','计划时间到','期间类型','采购方负责人','采购工厂','发布时间'],
							['requirementNumber','(new Date(r.planDateStart).format(\'yyyy-MM-dd\'))','(new Date(r.planDateEnd).format(\'yyyy-MM-dd\'))','dateType','purchaseInCharge','puchaseFactory','(new Date(r.publishDate).format(\'yyyy-MM-dd\'))'],
							'rows'
					)
				}, {
					name: '采购方招标管理',
					more:function(){top.$('#biddingPurchaseManage').click()},
					url: 'rest/PurchaseEnquiryBiddingService/queryPurchaseEnquiryBiddingByCondtion/'+elsAccount,
					type: 'post',
					param: function(d){
						return {
								elsAccount: elsAccount , 
								toElsAccount:d.friendElsAccount ,
								pageSize: '5'
					   }
					},
					template: tableTpl(
							['招标编号','招标类型','招标名称','招标状态','当前轮次','总轮数','开始日期','结束日期'],
							['biddingNumber','(biddingType(r.biddingType))','biddingName','(biddingStatus(r.biddingStatus))','currentCount','totalNumber','(new Date(r.beginDate).format(\'yyyy-MM-dd\'))','(new Date(r.endDate).format(\'yyyy-MM-dd\'))'],
							'rows'
					)
				}
				],
				[{
					name: '准入评估',
					more:function(){top.$('#standardSupplyManager').click()},
					url: 'rest/SupplierStandardService/queryStandardSupplierHeadByCondtion',
					type:'post',
					param: function(d){
						return {
								elsAccount: elsAccount , 
								toElsAccount:d.friendElsAccount ,
								pageSize: '5'
					   }
					},
					template: tableTpl(
							['准入评估单号','申请日期','发送状态','单据状态','总评分'],
							['standardNumber','(new Date(r.applyDate).format(\'yyyy-MM-dd\'))','(getZRSendStatus(r.sendStatus))','(getZRStandardStatus(r.standardStatus))','totalScore'],
							'rows'
					)
				}, {
					name: '评估',
					more:function(){top.$('#assessmentSupplyManager').click()},
					url: 'rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentCheckHearderByCondtion/'+elsAccount,
					type:'post' ,
					param: function(d){
						return {
								elsAccount: elsAccount , 
								toElsAccount:d.friendElsAccount ,
								pageSize: '5'
					   }
					},
					template: tableTpl(
							['评估编号','评估名称','评估状态','开始日期','结束日期'],
							['assessmentNumber','assessmentTemplateName','(assessmentStatus(r.assessmentStatus))','(new Date(r.beginDate).format(\'yyyy-MM-dd\'))','(new Date(r.endDate).format(\'yyyy-MM-dd\'))'],
							'rows'
					)	
				}
				],
				[{
					name: '外协收货',
					more:function(){top.$('#refundBomManage').click()},
					url: 'rest/BomVoucherService/findReceiptBomVoucherHeader',
					type:'post',
					param: function(d){
						return {
								elsAccount: elsAccount , 
								toElsAccount:d.friendElsAccount ,
								mobileType: '101' ,
								pageSize: '5'
					   }
					},
					template: tableTpl(
							['物料号','凭证日期','过账日期','发货状态','采购方备注','销售方备注'],
							['materialVoucherNumber','(new Date(r.voucherDate).format(\'yyyy-MM-dd\'))','(new Date(r.postDate).format(\'yyyy-MM-dd\'))','(getDeliveryStatus(r.deliveryStatus))','purchaseRemark','saleRemark'],
							'rows'
					)
				}, {
					name: 'VMI库存',
					more:function(){top.$('#iReportSupplyre').click()},
					url: 'tab23',
					template: ''
				}
				],
				[{
					name: '合同管理',
					more:function(){top.$('#contractManager').click()},
					url: 'rest/ContractManageService/queryContractManageHeadByCondtion',
					type: 'post' ,
					param: function(d){
						return {
								elsAccount: elsAccount , 
								toElsAccount:d.friendElsAccount ,
								dateArea:'lastMonth',
								pageSize: '5'
					   }
					},
					template: tableTpl(
							['合同编码','合同状态','合同类型','供应商','合同总金额','累计付款金额'],
							['contractNumber','contractStatus','contractTypeName','toElsAccount','totalContractAmount','totalPaymentAmount'],
							'rows'
					)
				}, {
					name: '物料文档',
					more:function(){top.$('#filedistribution').click()},
					url: 'tab23',
					template: ''
				}, {
					name: '供应商文档',
					more:function(){top.$('#filedistribution').click()},
					url: 'tab23',
					template: ''
				}
				]
			]
		})
	})

</script>
</body>