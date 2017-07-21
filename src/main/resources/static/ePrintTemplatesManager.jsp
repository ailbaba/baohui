<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ include file="/elsHeader.jsp"%>
<link type="text/css" rel="stylesheet" href="<%=basePath%>extend/formbuilder/elsFormBuilder_simplify.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/extend/formbuilder/jquery-barcode.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/extend/formbuilder/jquery-qrcode.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/extend/formbuilder/doT.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/extend/formbuilder/templates.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/extend/formbuilder/templatePrint.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/extend/formbuilder/printThis.js"></script>
<body>
<script>
	/**
	 * @description 基于dot 模板引擎 封装的前端带分页模板
	 * @see TemplateManager
	 * @see {@link http://jinlong.github.io/doT/} dot 模板引擎介绍
	 * */

	var basePath = '<%=basePath%>';
	
	var dataHandler = function(da){
		var rows = da.rows||[];
		var ps =rows.map(function(d){
			$.ajax({
				url :'<%=basePath%>rest/MaterialVoucherService/findDeliveryPackage',
				dataType : 'json',
				type :'post',
				contentType : 'application/json',
				data : JSON.stringify({
					elsAccount: d.elsAccount,
					materialVoucherNumber: d.materialVoucherNumber,
					materialVoucherItemNumber: d.materialVoucherItemNumber,
					mobileType: (d['mobileTypeList']||[])[0]
				})
			}).done(function(b){
				var packageList = b&& b['packageList']||[];
				d.packageList = packageList;
				var pg = packageList.map(function(p){
					return parseFloat(p.deliveryQuantity)
				});
				//for ls tpl bz
				var _m={},total=0;
				pg.forEach(function(p){_m[p]=~~_m[p]+1});
				var pkgLis = Object.keys(_m).sort(function(a,b){return a<b}).map(function(p){
					var t= _m[p];
					total+=t*p;
					return p+(t===1?'':'*'+t)
				});
				d.totalDeliveryQuantity = total;
				if(pkgLis.length){
					d.deliveryTip = pkgLis.join('+')
				}
				if(/^\d+$/g.test(d.deliveryTip))delete d.deliveryTip;
			});
		});
	};
	
	//以下这种写法在客户端上当数据量大时会出问题 MODIFY BY CTQ 2016/6/22
	/*
	var dataHandler = function(da){
		var defer = $.Deferred();
		var rows = da.rows||[];
		var ps =rows.map(function(d){
			var df = $.Deferred();
			ajaxWorker({
				url :'<%=basePath%>rest/MaterialVoucherService/findDeliveryPackage',
				dataType : 'json',
				type :'post',
				contentType : 'application/json',
				data : JSON.stringify({
					elsAccount: d.toElsAccount,
					materialVoucherNumber: d.materialVoucherNumber,
					materialVoucherItemNumber: d.materialVoucherItemNumber,
					mobileType: (d['mobileTypeList']||[])[0]
				})
			}).done(function(b){
				var packageList = b&& b['packageList']||[];
				d.packageList = packageList;
				var pg = packageList.map(function(p){
					return parseFloat(p.deliveryQuantity)
				});
				//for ls tpl bz
				var _m={},total=0;
				pg.forEach(function(p){_m[p]=~~_m[p]+1});
				var pkgLis = Object.keys(_m).sort(function(a,b){return a<b}).map(function(p){
					var t= _m[p];
					total+=t*p;
					return p+(t===1?'':'*'+t)
				});
				d.totalDeliveryQuantity = total;
				if(pkgLis.length){
					d.deliveryTip = pkgLis.join('+')
				}
				if(/^\d+$/g.test(d.deliveryTip))delete d.deliveryTip;
				df.resolve(d);
			}).fail(function(){df.resolve(d)});
			return df.promise();
		});
		$.when.apply($,ps).done(function(){
			defer.resolve(da)
		}).fail(function(){
			defer.resolve(da);
		});
		return defer.promise();
	};*/
	var toElsAccount = (getIframeData()[0]||{}).toElsAccount;
	var chooseTemplate = function (func) {
			var tplName = '';
			if(toElsAccount==='201584'||elsAccount==='201530'){
				tplName = 'npx-shd'
			}else if(elsAccount=='201000'||elsAccount=='201002'||elsAccount=='201001'){
				tplName = 'hj-shd'
			}
			else if(elsAccount == '201559'){
				tplName = 'npx-shd'
			}
			else if (/诺普信/.test(companyShortName)) {
				tplName = 'npx-shd'
			}
			else if (/龙升/.test(companyShortName)) {
				tplName = 'ls-shd'
			}
			else if (/汇洁/.test(companyShortName)) {
				tplName = 'hj-shd'
			}
			else if (/中国好公司/.test(companyShortName)) {
				tplName = 'ls-shd';
			}else {
				tplName = 'mt-shd'
			}
			func(templates[tplName]);
	};

	var printPage = function (s) {
		// 打印
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
	};

	/**
	 *@description 二维码
	 * @see  https://github.com/davidshimjs/qrcodejs
	 * */
	var buildQRCode = function(s){
		$(s.pageList).find('.qrcode').each(function(i,dom){
			var el = $(dom);
			var t = el.text();
			var w = parseInt(el.attr('code-q-w'))||128;
			var h = parseInt(el.attr('code-q-h'))||128;
			el.text('');
			el.qrcode({text:t,width:w,height:h});
			var c = el.find('canvas');
			var img =new Image();
			img.width = w;
			img.height= h;
			img.onload = function(){
				c.replaceWith(img);
			};
			img.src = c[0].toDataURL()
		});
	};
	/**
	 *@description 条码
	 * @see  http://barcode-coder.com/
	 * */
	var buildBarCode = function (s) {
		$(s.pageList).find('.code').each(function(i,d){
			var $el = $(d);
			var h = parseInt($el.attr('code-b-h'))||50;
			var f = parseInt($el.attr('code-b-font'))||13;
			$el.barcode($el.find('span').text(), 'code128', {
				barWidth: 1,
				barHeight: h,
				fontSize:f
			});
		})

	};
	// 页码修正
	var fixPagination = function (s) {
		var total = s.pageList.length;
		s.pageList.forEach(function (p, i) {
			$(p).find('.paging .cur').text(i + 1);
			$(p).find('.paging .total').text(total);
		})
	};
	//打印标签
	var switchView = function () {
			if(switchView.showTags){
				switchView.showTags=false;
				sw.textContent = '显示标签';
				efbEl.replaceChild(pagesEl,tagsEl);
			}else {
				sw.textContent = '显示订单';
				switchView.showTags=true;
				if(!tagsEl){
					var pd = getIframeData();
					var pages = [];
					if (!pd)throw new Error('没有接收到模板数据!');
					for (var i = 0, d; d = pd[i]; i++) {
						!function(){
							var t = definedDom('div');
							pages.push(t);
							var f =pd[i+1];
							new TemplateManager(t).data(d)
									.template(templates['shd-tag'])
									.render().fix(function () {
								buildBarCode(this);
								buildQRCode(this);
								$(t).find('.codeB').each(function(i,d){d = $(d).find('div:last');d.text('箱号'+d.text())});
								if(!f){
									$(pages).find('.page').each(function(i,p){
										var $p = $(p);
										var style = $p.attr('style');
										$p.removeAttr('style');
										$p.removeAttr('class');
										$p.find('.tpl-row').addClass('page').attr('style',style);
									});
									tagsEl = definedDom('div',{
										class:'pages',
										children:pages
									});
									efbEl.replaceChild(tagsEl,pagesEl);
									switchView.allow =true;
									printPage.allow =false;
								}
							})
						}()
					}
				}else {
					efbEl.replaceChild(tagsEl,pagesEl);
				}
			}
	};
	var infoCache={};
	var promiseLis;
	var loadData = function () {
	    promiseLis =[];
		var pd = getIframeData();
		if (!pd)throw new Error('没有接收到模板数据!');
		$('.efb-main .pages').empty();
		// 拆分
		for(var l=pd.length,i=l-1;i>-1;i--){
			var dat = pd[i];
			var splitData={};
			for(var n=0,rs=dat.rows,m=rs.length;n<m;n++){
				var r = rs[n];
				var k = (r.fbk50||'')+'@'+r.purchaseFactory;
				if(!splitData[k]){
					splitData[k]=[r]
				}else{
					splitData[k].push(r);
				}
			}
			[].splice.apply(pd,[i,1].concat(Object.keys(splitData).map(function(d){
				var da = $.extend(true,{},dat);
				da.fbk50 = d.split('@')[0];
				da.rows=splitData[d];
				// 请求接口并包装数据
				var dataHandler = function(data,url,fixDatFunc){
					var params =  JSON.stringify(data); 
					var dif = $.Deferred();
					if(infoCache[params]){
						if(Array.isArray(infoCache[params])){
							infoCache[params].push(da);
						}else{
							fixDatFunc(da,infoCache[params]);
						}
					}else{
						promiseLis.push(dif.promise());
						infoCache[params]=[da];
						ajaxWorker({
							url: url,
							type: 'post',
							contentType: 'application/json',
							dataType: 'json',
							data: params
						}).done(function(data){
							infoCache[params].forEach(function(d){
								fixDatFunc(d,data)
							});
							infoCache[params]=data;
							dif.resolve();
						}).fail(function(){
							infoCache[params]={};
							dif.resolve();
						})
					}
				};
 				dataHandler({elsAccount:da.toElsAccount,orgCategoryId:"companyCode",orgId:da.rows[0].fbk4},basePath+'rest/ElsOrganizationService/queryOrganizationInfo',function(localData,ajaxData){
 					console.log("elsAccount"+da.toElsAccount+"   orgCategoryId: companyCode"+"   orgId:"+da.rows[0].fbk4);
 					if(ajaxData && ajaxData.rows.length > 0){
 						localData.toCompanyShortName=ajaxData.rows[0].orgDesc;
 					}
				}); 
 				dataHandler({elsAccount:da.toElsAccount,factory:da.rows[0].fbk48,location:da.rows[0].fbk48,materialGroup:da.rows[0].fbk49,materialNo:da.rows[0].purchaseMaterialNumber},basePath+'rest/WareHousePersonService/findWarePersonList',function(localData,ajaxData){
 					console.log("elsAccount:"+da.toElsAccount+"  factory:"+da.rows[0].fbk48+"  location:"+da.rows[0].fbk48+"   materialGroup:"+da.rows[0].fbk49+"  materialNo:"+da.rows[0].purchaseMaterialNumber);
 					if(ajaxData && ajaxData.length > 0){
 						localData.address=ajaxData[0].address;
 						localData.contectName=ajaxData[0].name;
 						localData.telphone=ajaxData[0].telphone1;
 						if(ajaxData[0].telphone2){
 							localData.telphone+=","+ajaxData[0].telphone2;
 						}
 					}
				});
				return da;
			})))
		}
		$.when.apply($,promiseLis).done(function(){
			doRenderPrintTpl(pd);
		})
	};
	var doRenderPrintTpl = function(pd){
		for (var i = 0, d; d = pd[i]; i++) {
			chooseTemplate(function (tpl) {
				new TemplateManager('.efb-main .pages')
						.template(tpl).data(this)
						.handler(dataHandler)
						.render().fix(function () {
					buildBarCode(this);
					buildQRCode(this);
					fixPagination(this);
					pagesEl = $('.pages')[0];
				});
			}.bind(d));
		}
	};
	var pagesEl;
	var tagsEl;
	var efbEl;
	var sw ;
	$(function () {
		sw = $('#switch')[0];
		pagesEl = $('pages')[0];
		efbEl = $('.efb-main')[0];
		loadData();
		onIframeDataChange(loadData);
	});
</script>
<div class='efb-main'>
	<div style="float: left;z-index: 10;position: relative;padding: 0 20px;cursor: pointer;" onclick="printPage()">
		<div class="icon-print"></div>
		<span>打印</span></div>
	<div style="float: left;z-index: 10;position: relative;padding: 0 20px;cursor: pointer;" onclick="switchView()">
		<div class="icon-print"></div>
		<span id="switch">显示标签</span></div>
	<div class="pages"></div>
</div>
</body>