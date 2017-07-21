/**
 * Created by zwy on 2016/1/5.
 * 临时构建的打印表单
 */

var EFB = function (sel, data, template,page) {
	this.opt = {
		page: page
	};
	var self = this;
	// 页面生成
	var
		buildTemplate = function (t) {
			return t.replace(/\$(\d+)/g, function (a, b) {
				return data[parseInt(b)] || '　'
			})
		},
		_efb = this,
		printPage = $(sel),
		cacheHtml = buildTemplate(template.head),
		footHtml = buildTemplate(template.foot),

		pageFac = function (p) {
			console.debug('page',p,!template.foot);
			printPage.append(p || cacheHtml);
			printPage.find('.page').css({
				'width': _efb.opt.page.width - _efb.opt.page.padding * 2 - 3 + 'mm',
				'min-height': _efb.opt.page.height - _efb.opt.page.padding * 2 - 5 + 'mm'
			});
			if (!template.foot)pagingFac();
		},
		pagingFac = function () {
			var p = $(sel + ' .page .paging');
			p.each(function (i, _p) {
				$(_p).find('.cur').text(i + 1);
				$(_p).find('.total').text(p.length);
			})
		};
	this.rowInsertFac = function (d) {
		var r;
		if(typeof d ==='string'){
			r = $(d);
		}else {
			var t =template.tr,r;
			if(getIframeData().dataFrom='deliveryManage'){
				r=$(t.replace(/\$(\d+)/g, function (a, b) {
					return d[parseInt(b)] || '　'
				}))
			}else {
				r = $('<tr/>');
				d.forEach(function (_d,i) {
					r.append('<td>' + (_d || '　') + '</td>');
				});
			}
		}
		var p = $(sel + ' .page:last');
		p.find('tbody').append(r);
		if (p.outerHeight() > parseInt(p.css('min-height')) + 10) {
			p.append(template.paging);
			if (!template.foot) {
				pageFac();
				p = $(sel + ' .page:last');
				p.append(template.cTable);
			}
			$(sel + ' .page:last tbody').append(r);
		}
	};
	this.footFac = function () {
		self.rowInsertFac(template.tExtra);
		if (!footHtml)return;
		var p = $(sel + ' .page:last');
		p.append(footHtml);
		if (p.outerHeight() > parseInt(p.css('min-height')) + 10) {
			pageFac(template.page);
			var _p = $(sel + ' .page:last');
			while (p.outerHeight() > parseInt(p.css('min-height')) + 10) {
				_p.prepend(p.find('.fl:last'));
			}
			_p.append(template.paging);
		}
		p.append(template.paging);
		pagingFac();
	};
	pageFac();
};
$(function () {
	// 缓存请求结果 减少重复请求
	var accountKeyMap = {};
	var replaceAccountToFullName = function (selector,key) {
		var $dom = $(selector);
		if($dom.length>1)return $dom.each(function(i,d){
			replaceAccountToFullName(d,key);
		});
		$dom.key = key;
		if (!$dom.length || $dom[0]['is-'+key] )return;
		var ac = accountKeyMap[$dom.text()];
		if(ac){
			if(ac.data){
				return $dom.text(ac.data[key]);
			}else{
				ac.doms.push($dom);
			}
		}else {
			ac = accountKeyMap[$dom.text()]={doms:[$dom]};
			$.ajax({
				url: basePath + 'rest/AccountService/queryPurchaseEnquirySupplyByCondtion',
				type: 'POST',
				contentType: 'application/json',
				dataType: 'json',
				data: JSON.stringify({'elsAccount': $dom.text()})
			}).done(function (data) {
				if (data) {
					ac.data = data;
					ac.doms.forEach(function($d){
						$d.text(data[$d.key]||'');
						$d[0]['is-'+key] = true;
					});
					ac.doms=[];
				}
			});
		}
	};

	$('body').append(definedDom('div', {
		class: 'js-print',
		title: '打印表单',
		onclick: function () {
			$('.efb-main .page').printThis({
				debug: false,              //  show the iframe for debugging
				importCSS: true,       //      import page CSS
				importStyle: true,        //  import style tags
				printContainer: true,     //   grab outer container as well as the contents of the selector
				//loadCSS: "path/to/my.css",  // path to additional css file - us an array [] for multiple
				pageTitle: "",       //        add title to print page
				removeInline: false,       //  remove all inline styles from print elements
				printDelay: 333,            // variable print delay
				header: null,              //  prefix to html
				formValues: true        //     preserve input/form values
			})
		}
	}));
	var printData='';
	var loadData = function (a) {
		var tKeys = ['purchaseOrderNumber', 'orderItemNumber', 'purchaseMaterialNumber', 'purchaseMaterialDesc',
			'#materialSpecification', 'unitQuantity', '#fbk32', 'wesbs', '#none','orderBatch','fbk35','saleMaterialNumber','saleMaterialDesc','#fbk26'];
		var cKeys = ['voucherDate', 'materialVoucherNumber', '#code', 'elsAccount', 'toElsAccount', 'fbk1', 'elsAccount'];
		printData = getIframeData();
		printData.cData = printData.cData || [];
		var t = {
			head: '<div class="page"><div class="title">送货单</div><div class="fl c1"><label>送货日期：</label><span>$0</span></div><div class="fl c1"><label>送货单号：</label><span>$1</span></div><div class="fl c2 code"><label>条码区</label><span>$2</span></div><div class="fl c1"><label>送货方：</label><span class="js-account">$3</span></div><div class="fl c1"><label>收货方：</label><span class="js-account">$4</span></div><div class="fl c1"><label>承运方：</label><span>$5</span></div><div class="fl c1"><label>收货地址：</label><span class="js-address">$6</span></div><table class="fl"><thead><tr><th>采购订单</th><th>行号</th><th>物料编号</th><th>物料描述</th><th>物料规格</th><th>单位</th><th>件数</th><th>送货数量</th><th>实收数量</th><th>批号</th><th>跟踪号</th></tr></thead><tbody></tbody></table><div class="clear"></div><div class="fl c3"><label>备注：</label><span>$7</span></div><div class="fl c4"><label>发货方：</label><span>$8</span></div><div class="fl c4"><label>发货方：</label><span>$9</span></div><div class="fl c4"><label>收货方：</label><span>$10</span></div><div class="paging"><span>第<span class="cur">$11</span></span>页&nbsp;<span>共<span class="total">$12</span></span>页</div><div class="clear"></div></div>',
			tExtra: '',
			foot: '',
			tr:'<tr><td rowspan="2">$0</td><td rowspan="2">$1</td><td>$2</td><td>$3</td><td style="min-width:80px">$4</td><td rowspan="2">$5</td><td rowspan="2">$6</td><td rowspan="2">$7</td><td rowspan="2">$8</td><td rowspan="2" style="min-width:60px">$9</td><td rowspan="2" style="min-width:60px">$10</td></tr><tr><td>$11</td><td>$12</td><td>$13</td></tr>'
		};
		a = a || getIframeData();
		if(a.dataFrom==='editDelivery'){
		}else if (a.tUrlKey === "saleOrderNumber") {
			cKeys = ['elsAccount','materialVoucherNumber', '#code', 'elsAccount', 'toElsAccount', 'fbk1', 'address'];
			tKeys = [ 'purchaseMaterialNumber','orderItemNumber', 'purchaseOrderNumber', 'purchaseMaterialDesc', 'noDeliverQuantity', 'unitQuantity', 'price', 'wesbz', '#none','#deliveryDate','#none'];
			t.head = '<div class="page cgdd"><div class="title com js-account">$0</div><div class="title t">采购合同</div><div class="fl h"><div class="fl c5"><label>合同编号：</label><span>$1</span></div><div class="fl c5"><label>日&nbsp;&nbsp;&nbsp;&nbsp;期：</label><span>$2</span></div></div><div class="fl l"></div><div class="fl l"></div><div class="fl c6"><label>卖&nbsp;&nbsp;方：</label><span class="js-account">$3</span></div><div class="fl c6"><label>买&nbsp;&nbsp;方：</label><span class="js-account">$4</span></div><div class="fl c6"><label>地&nbsp;&nbsp;址：</label><span>$5</span></div><div class="fl c6"><label>地&nbsp;&nbsp;址：</label><span>$6</span></div><div class="br fl"></div><div class="br fl"></div><div class="fl c6"><label>联系人：</label><span>$7</span></div><div class="fl c6"><label>联系人：</label><span>$8</span></div><div class="fl c7"><label>电&nbsp;&nbsp;话：</label><span>$9</span></div><div class="fl c7"><label>传真：</label><span>$10</span></div><div class="fl c7"><label>电&nbsp;&nbsp;话：</label><span>$11</span></div><div class="fl c7"><label>传真：</label><span>$12</span></div><div class="fl c6"><label>邮&nbsp;&nbsp;箱：</label><span>$13</span></div><div class="fl c6"><label>邮&nbsp;&nbsp;箱：</label><span>$14</span></div><div class="fl l"></div><span class="fl">1.订购明细和交货期</span><table class="fl"><thead><tr><th>物料编号</th><th>色号</th><th>供应商货号</th><th>供应商色号</th><th>数量</th><th>单位</th><th>含税单价</th><th>币别</th><th>本公司款号</th><th>交货期</th><th>允收范围</th></tr></thead><tbody></tbody></table><div class="clear"></div></div>';
			t.tExtra = '<tr><td></td><td></td><td></td><td>总数:</td><td class="totalQ"></td><td></td><td></td><td colspan="2" class="totalC"></td><td></td><td></td></tr>';
			t.foot = '<div class="fl tk">$15</div><div class="fl bz"><span>备注:</span><p class="bz">$16</p></div><div class="fl c6"><label>卖&nbsp;&nbsp;方：</label><span>$17</span></div><div class="fl c6"><label>买&nbsp;&nbsp;方：</label><span>$18</span></div><div class="fl c6"><label>代表人签字：</label><span></span></div><div class="fl c6"><label>代表人签字：</label><span></span></div><div class="fl c6"><label>日&nbsp;&nbsp;期：</label><span></span></div><div class="fl c6"><label>日&nbsp;&nbsp;期：</label><span></span></div>';
			t.cTable = '<div class="page cgdd"><table class="fl"><thead><tr><th>物料编号</th><th>色号</th><th>供应商货号</th><th>供应商色号</th><th>数量</th><th>单位</th><th>含税单价</th><th>币别</th><th>本公司款号</th><th>交货期</th><th>允收范围</th></tr></thead><tbody></tbody></table><div class="clear"></div></div>';
			t.paging = '<div class="paging"><span>第<span class="cur"></span></span>页&nbsp;<span>共<span class="total"></span></span>页</div><div class="clear"></div>'
			t.page = '<div class="page cgdd"></div>'
		}
		var datas = [], urls = [];
		// 重组数据结构
		a.cData.forEach(function (d, i) {
			urls[i] = {
				u: a.tUrlPrefix,
				param: {
					itemIds: d[a.tUrlKey], 
					deliveryStatus: d.deliveryStatus||'',
					materialVoucherNumber: d.materialVoucherNumber,
					elsAccount: elsAccount,
					elsSubAccount: elsSubAccount
				}
			};
			datas[i] = datas[i] || {};
			datas[i]['head field'] = datas[i]['head field'] || {};
			datas[i]['common field'] = datas[i]['common field'] || {};

			cKeys.forEach(function (k) {
				datas[i]['common field'][k] = d[k]||'　';
			})
		});
		var _s = 0;
		var onSuccess = function (data) {
			_s++;
			if (typeof data === 'object' && data.rows||data.length) {
				datas[this.i]['table field'] = {value: data.rows||data};
			}
			if (_s === urls.length) {
				$('.efb-main').empty();
				console.debug(datas);
				datas.forEach(function (_d) {
					var c = cKeys.map(function (a) {
						var _a = _d['common field'][a] || '　';
						if (a === 'voucherDate'  ||  a==='deliveryDate' && _a) {
							return new Date(_a).format('yyyy-MM-dd');
						}
						if (a === '#code') {
							var c1 = _d['common field'].elsAccount;
							var c2 = _d['common field'].materialVoucherNumber;
							if (c1 && c2) {
								return c1 + c2;
							}
							return '　';
						}
						return _a;
					});
					// 开始生成页面
					var page = {
						padding: 5,
						width: a.tUrlKey === "saleOrderNumber"?210:297,
						height: a.tUrlKey === "saleOrderNumber"?297:210
					};
					console.debug('page data:',c);
					var efb = new EFB('.efb-main', c, t,page);
					$(".page:last .code").barcode($(".page:last .code span").text(), "code128", {
						barWidth: 1,
						barHeight: 50
					});
					((_d['table field'] || {}).value || []).forEach(function (a) {
						var _a = tKeys.map(function (t) {
							if (t === '#deliveryDate') {
								return new Date(parseInt(a['deliveryDate'])).format('yyyy-MM-dd');
							}
							if(t==='#fbk26'){
								return a.fbk26+ a.fbk27;
							}
							if(t==='#fbk32'){
								return '0'=== (a.fbk32+'') ?'　': (a.fbk32||'　');
							}
							if(t==='#materialSpecification'){
								return (a['materialSpecification']||'') + (a['fbk21']||'　');
							}
							if (t === 'quantity') {
								return parseInt(a[t]);
							}
							if (t === 'wesbz'||t==='wesbs') {
								return parseFloat(a[t]);
							}
							return a[t]
						});
						efb.rowInsertFac(_a);
					});
					var _q = $('tbody tr:not(:last) td:nth-child(5)').toArray().map(function(b){
						return parseFloat(b.innerHTML)||0
					});
					var _c = $('tbody tr:not(:last) td:nth-child(7)').toArray();
					_c.forEach(function(b,i){
						var c = _q[i];
						_q[i]+=_q[i-1]||0;
						_c[i]=(parseFloat(_c[i-1])||0)+ c*(parseFloat(b.innerHTML)||0)
					});
					efb.footFac();
					$('.totalQ').text(_q[_q.length-1]);
					$('.totalC').text(_c[_c.length-1]);
					replaceAccountToFullName('.page .js-account','fullName');
					replaceAccountToFullName('.page .js-address','address');
				})
			}
		};
		urls.forEach(function (a, i) {
			var _d = getIframeData();
			$.ajax({
				url: a.u,
				type: 'post',
				dataType: 'json',
				contentType: 'application/json',
				data: JSON.stringify(a.param)
			}).done(onSuccess.bind({i: i}));
		});
	};
	loadData(printData);
	onIframeDataChange(loadData)
});