!function () {
	var fetch = function (opt) {
		return ajaxWorker({
			url: opt.url,
			type: opt.type || 'post',
			contentType: "application/json",
			data: JSON.stringify(opt.param),
			dataType: "json"
		})
	};

	var main, menu, _s;
	/**
	 * @description 面板配置
	 * */
	var config = {};
	var loading = '<div class="cps-loading"><span></span><div>loading</div></div>';
	var noData = '<div class="cps-loading"><p>暂无数据.</p></div>';
	var errData = '<div class="cps-loading"><p>获取数据失败!</p></div>';
	/**
	 * 搜索输入框
	 * */
	var s_input = definedDom('input', {
		placeholder: '销售方ELS号或名称模糊查询',
		onblur: function () {
			setTimeout(function () {
				s_input.dropdownEl.slideUp(100);
			}, 300)
		},
		onfocus: function (e) {
			if(e)this.select();
			if (s_input.lis && s_input.lis.length)
				s_input.dropdownEl.slideDown(100);
		},
		onkeydown: function (e) {
			if (!s_input.lis || !s_input.lis.length)return;
			var keyCode = e.keyCode;
			if (keyCode === 39 || keyCode === 40) {
				s_input.activeLi._next.onmouseover();
			} else if (keyCode === 37 || keyCode === 38) {
				s_input.activeLi._pre.onmouseover();
			} else if (keyCode === 13) {
				menu.active(s_input.activeLi._d);
				this.blur();
			}
		},
		checkData: function () {
			var _v = this.value
				.replace(/^\s+|\s+$/g, '')
				.toLowerCase();
			var tempLi;
			(s_input.lis || []).forEach(function (li) {
				var showThis = li.innerHTML.toLowerCase().indexOf(_v) !== -1;
				if (showThis) {
					li.style.background = '';
					li._next = li;
					if (tempLi) {
						tempLi._next = li;
						li._pre = tempLi;
					} else {
						s_input.activeLi = li;
						li._pre = li;
					}
					tempLi = li;
				}
				li.style.display = showThis ? 'block' : 'none';
			});
		},
		oninput: function () {
			this.onfocus();
			s_input.checkData();
			if (s_input.activeLi)s_input.activeLi.onmouseover();
		}
	});

	/**
	 * 下拉筛选
	 * */
	var cpsFilterSearch = function () {
		var dropList = definedDom('ul', {
			class: 'cps-search-list'
		});
		s_input.dropdownEl = $(dropList);
		var dom = definedDom('div', {
			id: 'cps-search',
			children: [
				{tag: 'span', text: '快速定位'},
				s_input,
				{
					tag: 'button', text: '确定', onclick: function () {
					menu.active(s_input.activeLi._d);
				}
				},
				dropList
			]
		});
		dom.setData = function (data) {
			dropList.innerHTML = '';
			var list = data.map(function (d) {
				return definedDom('li', {
					text: d.friendElsAccount + '_' + d.companyShortName,
					_d: d,
					onmouseover: function () {
						if (s_input.activeLi)s_input.activeLi.style.background = '';
						this.style.background = '#eee';
						s_input.activeLi = this;
					},
					onclick: function () {
						s_input.value = this._d.name;
						
						menu.active(d);
						s_input.dropdownEl.slideUp(100);
					}
				})
			});
			s_input.lis = list;
			dropList.appendChild(definedDom({children: list}))
		};
		_s = dom;
		return dom;
	};

	/**
	 * 左侧初始化
	 * */

	var menuInit = function () {
		menu.innerHTML = '';
		menu._items = [];
		menu.setData = function (data) {
//			if (!data instanceof Array)return;
//			data = data.sort(function (a, b) {
//				return a.friendElsAccount - b.friendElsAccount
//			});
			_s.setData(data);
			data.forEach(function (d) {
				menu._items.push(definedDom('div', {
					class: 'menu-item',
					text: d.friendElsAccount + '_' + d.companyShortName,
					_d: d,
					onclick: function () {
						menu.active(d);
					}
				}))
			});
			menu.appendChild(definedDom({children: menu._items}));
			menu.active(data[0]);
			var s = $(menu).niceScroll({
				cursorcolor: 'rgba(253, 253, 253, 0.39)',
				cursorwidth: '5px',
				cursorborder: 'transparent'
			});
			$(window).resize(function () {
				s.resize();
			});
			return menu;
		};
		menu.active = function (d) {
			if (d) {
				s_input.value = d.friendElsAccount + '_' + d.companyShortName;
			} else s_input.value = s_input.activeLi._d.friendElsAccount + '_' + s_input.activeLi._d.companyShortName;
			s_input.checkData();
			s_input.dropdownEl.slideUp(100);
			for (var i = menu._items.length, item; item = menu._items[--i];) {
				if (item._d === d) {
					item.style.background = '#00BCD4';
					item.style.color = '#fff';
					menu.activeItem = item;
					//滚动到当前 scrollIntoViewIfNeeded - chrome
					(item.scrollIntoViewIfNeeded||item.scrollIntoView).call(item);
				} else {
					item.style.background = '';
					item.style.color = '';
				}
			}
			if (main.cards) {
				main.cards.forEach(function (c) {
					(c.activeTab || c.tabs[0]).onclick();
				})
			}
			return menu;
		};
		fetch(config.menu_list_opt).done(function (data) {
			menu.setData(data).active(data[0]);
		})
	};

	/**
	 * 右边初始化
	 * */
	var cardsInit = function () {
		main.innerHTML = '';
		main.cards = [];
		config.cards.forEach(function (d) {
			main.cards.push(createCard(d));
		});
		main.appendChild(definedDom({children: main.cards}));
		var s = $(main).niceScroll({
			cursorcolor: 'rgba(50, 67, 80, 0.37)',
			cursorwidth: '8px',
			cursorborder: 'transparent'
		});
		$(window).resize(function () {
			s.resize();
		});
	};

	/**
	 * 创建卡片
	 * */
	var createCard = function (d) {
		var tabBox = definedDom('div', {
			class: 'cps-card-tabs'
		});
		var tabContent = definedDom('div', {
			class: 'cps-card-content'
		});
		var moreBtn = definedDom('div', {
			class: 'more-btn-box'
		});
		var dom = definedDom('div', {
			class: 'cps-card',
			tabs: [],
			children: [tabBox, tabContent, moreBtn],
			setData: function (d) {
				tabBox.innerHTML = '';
				tabContent.innerHTML = loading;
				d.forEach(function (t) {
					var tb = createTab(t);
					tb.tabContent = tabContent;
					tb.tabMore = moreBtn;
					tb.card = dom;
					dom.tabs.push(tb);
					tabBox.appendChild(tb)
				});
				var f = dom.tabs[0];
				if (f)f.onclick();
				return dom;
			}
		});
		return dom.setData(d);
	};

	/**
	 * 创建tab页
	 * */
	var createTab = function (d) {
		var moreBtn = definedDom('div', {
			class: 'more-btn',
			text: '更多'
		});
		var tab = definedDom('div', {
			text: d.name,
			_d: d,
			onclick: function () {
				if (menu.activeItem && tab.card
					&& tab.card.activeTab === tab
					&& menu.activeItem._d === tab.activeData)
					return;
				var _d = (menu.activeItem || {})._d;
				tab.activeData = _d;
				if (this.tabContent) {
					tab.tabMore.innerHTML = '';
					 if('function'=== typeof d.more){
						moreBtn.onclick = d.more.bind(null,_d);
						tab.tabMore.appendChild(moreBtn);
					}
					tab.card.activeTab = tab;
					tab.card.tabs.forEach(function (t) {
						if (t === tab) {
							t.style.background = '#fff';
							t.style.color = '#666';
							t.style.borderColor = 'transparent';
						} else {
							t.style.background = '';
							t.style.color = '';
							t.style.borderColor = '';
						}
					});
					if (_d) {
						tab.tabContent.innerHTML = loading;
						var dat = d.param;
						var url = d.url;
						if(typeof url==='function'){
							url = url(_d);
						}
						if(typeof dat==='function'){
							dat = dat(_d);
						}
						fetch({
							url: url,
							type: d.type,
							param: dat
						}).done(function (data) {
							console.log('\n[done]',url,'\n tab name:',tab.textContent,'\ndata:',data);
							tab.tabContent.innerHTML = doT.template(d.template)(data);
							if (!tab.tabContent.textContent)tab.tabContent.innerHTML = noData;
						}).fail(function () {
							console.log('\n[fail]',url,'\n tab name:',tab.textContent);
							tab.tabContent.innerHTML = errData;
						})
					}
				}
			}
		});
		return tab;
	};

	/**
	 *  初始化和组装
	 * */
	var init = function () {
		menu = document.getElementById('cps-menu-list');
		main = document.getElementById('cps-main');
		document.getElementById('cps-searchBox')
			.appendChild(cpsFilterSearch());
		menuInit();
		cardsInit();
	};
	window.cpsManagerInit = function (opt) {
		config = opt || config;
		init();
	}
}();