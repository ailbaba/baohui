/**
 * Created by zwy on 2015/12/4.
 */
var EFB = function (sel, efbOpt) {
	var _EFB = this,
		__tempT,
		__active,                           // 缓存激活的模板
		$efb_choose,                    // 模板选择
		$efb_select,                     // 模板选择下拉部分
		$efb_template_opt,         // 模板选择区域
		$efb_fields,                      // 模板控件摆放区域
		$efb_edit,                          // 组件编辑区域
		$efb_edit_main,                // 组件编辑 属性设置区
		$efb_print_page,             // 展示页
		$efb_edit_btn,                  // 组件编辑按钮
		$efb_page_prev,               // 前一条数据
		$efb_page_next,               //  下一条数据
		$efb_data_num,                  // 当前数据位置
		$btn_template_save,	  		// 保存当前模板
		$btn_template_save_as,
		$btn_template_delete,
		$btn_page_print,				// 打印
		$efb_opt_tip,					// 模板选择区域操作提示区
		$efb_opt_tip_ico,					// 模板选择区域操作提示区图标
		$efb_opt_tip_text,					// 模板选择区域操作提示区文字
		preventClickEvent,                       // 跳过当次click事件
		__pageSize__ =[],
		__pageScale__= 100,

		lang = EFB.lang.zh_cn,      // 语言选择
		defaultOpt = {                   // 默认配置
			templates: [],          // 导入的模板
			mode: EFB.mode.OVERWRITE,//模式：覆盖旧的模板
			selector: '',          // 选择器
			autoSave: false,    // 模板自动保存模式
			queryUrl:'',			// 增删查改接口
			param:{}				// 提交参数
		},
		templateOptTip = {
			timer:-1,
			showLoading : function(a){
				clearInterval(templateOptTip.timer );
				$efb_opt_tip.fadeIn(100);
				var _a = 0,_c=['.','..','...'];
				var setText = function(){
					$efb_opt_tip_ico.show();
					_a = (_a+1)%3;
					$efb_opt_tip_text.text((a||lang.LOADING) + _c[_a]);
				};
				templateOptTip.timer = setInterval(setText,500);
				setText();
			},
			close : function(){
				clearInterval(templateOptTip.timer );
				$efb_opt_tip_text.text('');
				$efb_opt_tip.fadeOut();
			},
			showText : function(a){
				clearInterval(templateOptTip.timer );
				$efb_opt_tip_ico.hide();
				$efb_opt_tip_text.text(a);
			}
		},
		execOpt = function(type){
			var
				c = _EFB.templates.export(),
				a = _EFB.templates.active||__tempT||{},
				t = a.templateNumber,
				url,param= $.extend({},_EFB.opt.param),
				showL,
				doneT = lang.OPT_DONE,
				failT = lang.OPT_FAIL,
				done = function(data){
					if(type === 'query'){
						if(data&&data.length){
							_EFB.loadTemplates(data.map(function(d){
								var t ;
								try {
									t = JSON.parse(d.content);
									if(t)t.templateNumber = d.templateNumber;
								}catch(err) {
									console.debug(err);
								}
								return t;
							}))
						}else{
							failT = lang.NONE_DATA;
							return fail();
						}
					}else{
						if(type !=='delete'){
							if(!data.templateNumber)return fail();
							a.templateNumber = data.templateNumber;
						}else if(data.statusCode == '200'){
							_EFB.templates.remove('name',_EFB.templates.active.name);
							_EFB.templates.active = '';
						}else return fail();
					}
					templateOptTip.showText(doneT);
					setTimeout(templateOptTip.close,1000);
					$efb_opt_tip.one('click',templateOptTip.close);
				},
				fail = function(){
					templateOptTip.showText(failT);
					$efb_opt_tip.one('click',templateOptTip.close);
				};
			switch(type){
				case 'query':
					showL = lang.LOADING_TEMPLATE;
					doneT = lang.LOAD_DONE;
					failT = lang.LOAD_FAIL;
					url =_EFB.opt.api.query;
					_EFB.loadTemplates([],EFB.mode.EMPTY_LOAD);
					break;
				case 'save':
					if(!a.name||param.elsAccount!==elsAccount)return;
					if(t){
						showL = lang.UPDATING_TEMPLATE;
						param.templateNumber = t;
						url = _EFB.opt.api.update;
					} else {
						if(__tempT){
							var r = _EFB.templates.get('name',__tempT.name);
							if(r) {
								templateOptTip.showText('同名模板已存在');
								return;
							}else {
								_EFB.loadTemplates(__tempT);
								_EFB.templates.active = __tempT.name;
							}
						}
						__tempT = false;
						showL = lang.CREATING_TEMPLATE;
						url = _EFB.opt.api.create;
					}
					$.extend(param, {
						templateDesc : _EFB.templates.active.name,
						content :  _EFB.templates.export(),
						elsAccount :elsAccount,
						elsSubAccount : elsSubAccount
					});
					break;
				case 'delete':
					if(!a.name||param.elsAccount!==elsAccount)return;
					if(t){
						failT = '当前只能删除test开头的模板！';
						if(/^test.*$/gi.test(a.name))
							url = _EFB.opt.api.delete;
						$.extend(param, {
							templateNumber:t,
							templateDesc : _EFB.templates.active.name,
							content : c,
							elsAccount :elsAccount,
							elsSubAccount : elsSubAccount
						});
					}else return;
			}
			templateOptTip.showLoading(showL);
			$.ajax({
				url : url,
				dataType : "json",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(param)
			}).done(done).fail(fail)
		},
		checkAttr = function (field,attr) {
			return field.hasOwnProperty(attr) && (!field.hideAttr || field.hideAttr.indexOf(attr) === -1)
		},
		fix = function (w) {
			if (undefined == w) w = '';
			if (w !== 0 && w !== 'auto')if ($.isNumeric(w))w += 'px';
			return w;
		},
	// 更加安全的JSON字符串输出 跳过循环元素和过滤字段
		safeJSONStringify = function (o) {
			var cache = [];
			return JSON.stringify(o, function (key, value) {
				if (typeof value === 'object' && value !== null) {
					// 过滤不需要字段
					if (['$el', '_config', 'cell','templateNumber'].indexOf(key) !== -1) {
						return;
					}
					// 去掉循环
					if (cache.indexOf(value) !== -1) {
						return;
					}
					cache.push(value);
				}
				return value;
			});
		},
	// 数组对象排序 可以多个检查字段
	// k:['key1','key2'...] 或者 'key'
	// opt [false,false] 或者 false (false 升序 ,true 降序)
		sortBy = function (array, k, opt) {
			array.sort(function (a, b) {
				if (!$.isArray(k))k = [k];
				var c = 0;
				for (var i = 0; i < k.length; i++) {
					c = ''.localeCompare.call(a[k[i]] - b[k[i]]);
					if (!c) return c * (1 - (~~(opt.length ? opt[i] : opt)) * 2);
				}
				return c;
			});
			return array;
		},
	// 绑定样式字段
		cssProto = function (obj, cssName, key) {
			return {
				get: function () {
					return obj.$el.css(cssName);
				},
				set: function (a) {
					obj.$el.options._config[key] = a;
					obj.$el.css(cssName, a);
				}
			}
		},
	// 属性双向绑定
	// 方法内为通用默认属性
	// extend 为拓展方法
	// extend - {xx:yy} xx 存在则覆盖 yy为null则删除xx属性
		extendProperties = function (obj, extend) {
			extend = extend || {};
			// 基础属性
			var opt = {
				value: {
					get: function () {
						return obj.$el.text();
					},
					set: function (a) {
						obj.$el.options._config.value = a;
						obj.$el.text(a);
					}
				},
				width: cssProto(obj, 'width', 'width'),
				color: cssProto(obj, 'color', 'color'),
				height: cssProto(obj, 'height', 'height'),
				textAlign: cssProto(obj, 'text-align', 'textAlign'),
				fontFamily: cssProto(obj, 'font-family', 'fontFamily'),
				fontSize: cssProto(obj, 'font-size', 'fontSize'),
				border: cssProto(obj, 'border', 'border'),
				borderTop: cssProto(obj, 'border-top', 'borderTop')
			};
			for (var i in extend) {
				if (extend.hasOwnProperty(i)) {
					var ex = extend[i];
					if (typeof ex === 'object') {
						if (null === ex)delete opt[i];
						else opt[i] = ex;
					}
				}
			}
			Object.defineProperties(obj, opt);
		},
	// 组件可以改变大小
		initResizeable = function (obj) {
			if(obj.type === 'page')return;
			if (obj.root) {
				initResizeable(obj.root);
			}
			obj.$el.resizable({
				containment: '.efp-print-page',
				handles: "e, s",
				resize: function (e, u) {
					obj.width = u.size.width;
					obj.height = u.size.height;
				},
				stop: function () {
					// TODO : 会不会有类型转换bug？height有没有统一输入输出类型?
					preventClickEvent = true;
					// 表格外边框高度修正
					if (obj.root)obj.root.height = '' + obj.root.height;
					_EFB.editField(obj.$el.options);
				}
			});
			_EFB.resizeField = obj;
		},
	// 组件按钮拖拽
		initBtnDrag = function (f, btn) {
			btn.draggable({
				appendTo: '.efp-print-page',
				cancel: false,
				addClasses: false,
				cursor: 'move',
				revert: true,
				helper: function () {
					return _EFB.activeField(f).$el.clone();
				},
				opacity: 0.7,
				revertDuration: 0,
				snap: true,
				snapMode: 'inner',
				snapTolerance: 20,
				start: function (e, u) {
					var fi = _EFB.activeField(f);
					fi.order = 0;
					fi.button = btn;
					_EFB.printPage.dragField = fi;
					_EFB.printPage.fields.push(fi);
					u.helper.css({'background-color': '#E7F7FF'});
					btn.addClass('efb-dragging');
				},
				stop: function () {
					$('body').css('cursor', '');
					btn.removeClass('efb-dragging');
					$efb_print_page.find('.efb-drop-active').removeClass('efb-drop-active');
					var isDrop = $efb_print_page.find(_EFB.printPage.dragField.$el).length;
					if (isDrop) {
						btn.remove();
					} else {
						_EFB.printPage.fields.splice(_EFB.printPage.fields.indexOf(_EFB.printPage.dragField), 1);
						delete _EFB.data.map[_EFB.printPage.dragField.key];
					}
					delete _EFB.printPage.dragField;
					delete  btn.field;
				}
			});
			return btn;
		},
	// 组件可以拖拽
		initDragAndDrop = function (obj) {
			Object.defineProperty(obj, 'order', {
				get: function () {
					return ~~parseInt(obj.$el.attr('data-order'));
				},
				set: function (a) {
					obj._config.order = parseInt(a);
					obj.$el.attr('data-order', parseInt(a))
				}
			});
			obj.$el.draggable({
				addClasses: false,
				cancel: '.ui-resizable-handle',
				cursor: 'move',
				revert: true,
				helper: 'clone',
				opacity: 0.7,
				revertDuration: 0,
				snap: true,
				snapMode: 'inner',
				snapTolerance: 20,
				drag: function () {
					obj.$el.addClass('efb-dragging');
				},
				start: function (e, u) {
					_EFB.printPage.dragField = obj;
					u.helper.width(obj.$el.width());
					u.helper.height(obj.$el.height());
					u.helper.css({'background-color': '#E7F7FF'});
				},
				stop: function () {
					delete _EFB.printPage.dragField;
					obj.$el.removeClass('efb-dragging');
					$efb_print_page.find('.efb-drop-active').removeClass('efb-drop-active');
				}
			});
			obj.$el.droppable({
				hoverClass: 'efb-drop-active',
				tolerance: 'pointer',
				accept: '.efb-field-warp,#efb-fields button.efb-field',
				addClasses: false,
				drop: function (e) {
					e.preventDefault();
					e.stopPropagation();
					$efb_print_page.removeClass('efb-field-add-to-page');
					var d = _EFB.printPage.dragField;
					if (d.order > obj.order) {
						obj.$el.before(d.$el);
					} else {
						obj.$el.after(d.$el);
					}
					_EFB.printPage.freshOrders();
				}
			});
			return obj;
		},
		resetPageField = function () {
			if (preventClickEvent) {
				preventClickEvent = false;
				return false;
			}
			$efb_print_page.find('.efb-f-active').removeClass('efb-f-active');
			$efb_edit_main.html('');
			$efb_edit_btn
				.addClass('js-create-field')
				.removeClass('js-remove-field')
				.text(lang.CREATE)[0]
				.onclick = $.noop;
			_EFB.editField(_EFB.printPage);
			//TODO  还原创建方法
		},
	// 绑定到编辑视图
		bindToEditView = function (obj) {
			obj.$el[0].onmouseenter = function () {
				preventClickEvent = false;
				$efb_print_page.find('.efb-f-hover').removeClass('efb-f-hover');
				if (obj.root)obj.root.$el.addClass('efb-f-hover');
				obj.$el.addClass('efb-f-hover');
			};
			obj.$el[0].onmouseleave = function () {
				obj.$el.removeClass('efb-f-hover');
			};
			obj.$el[0].onclick = function (e) {
				e.preventDefault();
				e.stopPropagation();
				if (preventClickEvent) {
					preventClickEvent = false;
					return;
				}
				$efb_print_page.find('.efb-f-active').removeClass('efb-f-active');
				obj.$el.addClass('efb-f-active');
				// 传递 _self 对接到编辑区域
				initResizeable(obj.$el.options);
				_EFB.editField(obj.$el.options);
			};
		},
	// 基础控件类
		BaseField = function (dom, basOpt) {
			this.hideAttr = ['value'];
			this._config = basOpt;
			var _self = this;
			var basDefaultOpt = {
				type: 'base field',
				key: '',
				width: '100%',
				height: 'auto'
			};
			basOpt = $.extend({}, basDefaultOpt, basOpt || {});
			this.$el = $(dom);
			this.$el.addClass('efb-field');
			this.$el.options = this;
			this.type = basOpt.type;
			var _subFields = [];
			extendProperties(this, {
				options: {
					get: function () {
						return basOpt;
					},
					set: function (o) {
						_self._config = o;
						$.extend(o, $.extend(basOpt, o));
						for (var p in o) {
							if (o.hasOwnProperty(p))
								var _p =_self.$el.options[p];
								if(_p&&_p.hasOwnProperty('options')){
									_p.options=o[p];
								}else{
									_self.$el.options[p] = o[p];
								}
						}
					}
				},
				subFields: {
					get: function () {
						return _subFields;
					},
					set: function (sf) {
						_subFields=[];
						_self.$el.empty();
						sf.forEach(function (s) {
							var b = new BaseField(s);
							b.root = _self;
							_subFields.push(b);
							_self.$el.append(b.$el);
						});
					}
				}
			});
			bindToEditView(this);
			_self.options = basOpt;
		},
	// 标签 + 文本控件类
		CommonField = function (comOpt) {
			this.hideAttr = ['value'];
			this._config = comOpt;
			comOpt = $.extend({}, comOpt, {type: 'common field'});
			comOpt.label = $.extend({}, comOpt.label, {type: 'label'});
			comOpt.text = $.extend({}, comOpt.text, {type: 'text'});
			var _self = this;
			var _key = '';
			var b = new BaseField('<div class="efb-field-warp" ></div>');
			b.subFields = ['<label><span></span></label>', '<span><span><span></span>'];
			b.$el.options = this;
			this.$el = b.$el;
			extendProperties(this, {
				options: {
					get: function () {
						return comOpt;
					},
					set: function (a) {
						b.options = a;
						_self.label.options = a.label;
						_self.text.options = a.text;
					}
				},
				label: {
					get: function () {
						return b.subFields[0];
					},
					set: function (a) {
						_self._config.label = a;
						_self.label.options = a;
					}
				},
				text: {
					get: function () {
						return b.subFields[1];
					},
					set: function (a) {
						_self._config.text = a;
						_self.text.options = a;
					}
				},
				key: {
					get: function () {
						return _key;
					},
					set: function (a) {
						_key = a;
						_self._config.key = a;
						_EFB.data.map[comOpt.type] = _EFB.data.map[comOpt.type] || {};
						_EFB.data.map[comOpt.type][a] = _self;
					}
				},
				value: {
					get: function () {
						return _self.text.$el.find('span').text();
					},
					set: function (a) {
						//_self. _config.value = a;
						_self.text.$el.find('span').text(a)
					}
				}
			});
			this.options = comOpt;
			initDragAndDrop(this);
		},
	// 表格cell
		EfbCell = function (cellOpt) {
			this.hideAttr = ['value'];
			this._config = cellOpt;
			var v = cellOpt.value;
			this.type = cellOpt.type;
			var cell = '';
			var _self = this;
			var compare = function (a, b) {
				var c = a.$el, d = b.$el;
				if (a.hasOwnProperty('cell')) {
					c = a.cell.$el;
				}
				if (b.hasOwnProperty('cell')) {
					d = b.cell.$el;
				}
				return c.parent().children().index(c) - d.parent().children().index(d);
			};
			var freshRow = function (obj) {
				var row = obj.row;
				var keys = obj.root.keys;
				// 更新视图
				row.sort(compare);
				// 更新配置
				keys.sort(compare);
			};
			switch (_self.type) {
				case 'th':
					cell = $('<th ><div class="efb-cell"></div></th>');
					cell.draggable({
						addClasses: false,
						appendTo: 'parent',
						axis: 'x',
						containment: 'parent',
						cursor: 'move',
						revert: true,
						helper: 'clone',
						opacity: 0.7,
						revertDuration: 0,
						snap: true,
						snapMode: 'inner',
						snapTolerance: 20,
						drag: function () {
							cell.addClass('efb-dragging');
						},
						start: function (e, u) {
							_self.root.dragField = _self;
							_self.helper = u.helper;
							u.helper.css({'background-color': '#E7F7FF'});
							u.helper.width(_self.$el.width());
							u.helper.height(_self.$el.height());
						},
						stop: function () {
							delete _self.helper;
							delete _self.root.dragField;
							_self.$el.removeClass('efb-dragging');
							$efb_print_page.find('.efb-drop-active').removeClass('efb-drop-active');
						}
					});
					cell.droppable({
						tolerance: 'pointer',
						hoverClass: 'efb-drop-active',
						accept: 'th',
						addClasses: false,
						drop: function () {
							var d = _self.root.dragField;
							var indexA = d.row.indexOf(d);
							var indexB = _self.row.indexOf(_self);
							d.column.forEach(function (a, i) {
								var obj = _self.column[i];
								if (indexA > indexB) {
									obj.$el.before(a.$el);
								} else {
									obj.$el.after(a.$el)
								}
							});
							_self.column.forEach(function (a) {
								freshRow(a);
							});
						}
					});
					break;
				case 'td':
					cell = $('<td ><div class="efb-cell"></div></td>');
					break
			}
			this.$el = cell;
			cell.find('.efb-cell').text(v);
			this.$el.options = this;
			extendProperties(this, {
				options: {
					get: function () {
						return _self._config;
					},
					set: function (a) {
						_self._config = a;
						for (var i in a) {
							if (a.hasOwnProperty(i)) {
								_self[i] = a[i];
							}
						}
					}
				},
				x: {
					get: function () {
						return _self.row && _self.row.indexOf(_self) || -1;
					}
				},
				y: {
					get: function () {
						return _self.column && _self.column.indexOf(_self) || -1;
					}
				},
				value: {
					get: function () {
						return cell.find('.efb-cell').text();
					}, set: function (a) {
						cell.find('.efb-cell').text(a);
					}
				},
				visible: _self.type === 'th' ? {
					get: function () {
						return 'none' !== cell.css('display');
					},
					set: function (a) {
						if (['false', 'true', '1', '0'].indexOf(a) > -1)a = !!eval(a);
						_self._config.visible = a;
						cell.options.column.forEach(function (c) {
							c.$el.css('display', a ? '' : 'none');
						});
					}
				} : null,
				height: {
					get: function () {
						return cell.find('.efb-cell').css('height');
					}, set: function (a) {
						_self._config.height = a;
						cell.css('height', '');
						cell.options.row.forEach(function (c) {
							c.$el.find('.efb-cell').css('height', a);
						});
					}
				},
				colspan:{
					get:function(){
						return cell.attr('colspan');
					},
					set:function(a){
						_self._config.colspan = a;
						cell.attr('colspan',a);
					}
				},
				width: cssProto(_self, 'width', 'width')
			});
			bindToEditView(this);
		},
	// 表单头部类
		HeadField = function (headOpt) {
			this._config = headOpt;
			headOpt = $.extend({}, headOpt, {type: 'head field'});
			var _self = this;
			var b = new BaseField('<div class="efb-field-warp" ></div>');
			b.subFields = ['<h1></h1>'];
			_self.$el = b.$el;
			b.$el.options = _self;
			extendProperties(this, {
				options: {
					get: function () {
						return headOpt;
					},
					set: function (a) {
						b.options = a;
					}
				},
				value: {
					get: function () {
						return _self.head.value;
					},
					set: function (a) {
						_self.head.value=a;
					}
				},
				head: {
					get: function () {
						return b.subFields[0];
					},
					set: function (a) {
						_self.head.options = a;
					}
				}
			});
			_EFB.data.map[headOpt.type] = _EFB.data.map[headOpt.type] || {};
			_EFB.data.map[headOpt.type]['value'] = _self;

			initDragAndDrop(this);
			this.options = headOpt;
			this.head.hideAttr = [];
		},
	// 表格控件类
		TableField = function (tableOpt) {
			this.hideAttr = ['value'];
			var _self = this;
			var _keys = [];
			var b = new BaseField('<div class="efb-field-warp" ></div>');
			var _data;
			var _cells = [];
			this.$el = b.$el;
			this.$el.options = this;
			this._config = tableOpt;
			tableOpt = $.extend({}, tableOpt, {type: 'table field'});
			b.subFields = ['<label></label>', '<table><thead><tr></tr></thead><tbody></tbody></table>'];
			this.label = b.subFields[0];
			this.table = b.subFields[1];
			this.label.hideAttr = [];
			// 排序
			this.orderBy = function (a, b) {
				sortBy(_data, a, b);
				return _self;
			};
			// 刷新数据
			this.fresh = function () {
				for (var i = 0; i < _data.length; i++) {
					for (var n = 0; n < _self.keys.length; n++) {
						_data[i][_self.keys[n]] = _cells[n, i].value;
					}
				}
				return _self;
			};
			extendProperties(this, {
				color: null,
				textAlign: null,
				fontFamily: null,
				fontSize: null,
				height: {
					get: function () {
						return _self.$el.css('height');
					},
					set: function (a) {
						var h = a;
						if (/\d+(px)?$/g.test(a)) {
							h = Math.max(parseFloat(a), _self.label.$el.outerHeight() + _self.table.$el.outerHeight() + 10) + 'px';
						}
						_self.$el.css('height', h);
						_self._config.height = h;
					}
				},
				options: {
					get: function () {
						return tableOpt;
					},
					set: function (a) {
						b.options = a;
						_self.label.options = a.label;
						_self.table.options = a.table;
					}
				},
				// 数据
				value: {
					get: function () {
						return _data;
					},
					set: function (a) {
						var tbody = _self.table.$el.find('tbody').html('');
						_cells = [];
						for (var i = 0; i < a.length; i++) {
							if (!a[i]) continue;
							var tr = $('<tr></tr>');
							for (var n = 0, row = []; n < _self.keys.length; n++) {
								var k = _self.keys[n].key;
								var c = new EfbCell({value: a[i][k], type: 'td'});
								c.root = _self;
								if (false === _self.keys[n].visible)c.$el.css('display', 'none');
								var preCell = row.slice(-1);
								if(preCell.colspan||preCell._colspan){
									c._colspan = (preCell.colspan||preCell._colspan)-1;
								}else
								tr.append(c.$el);
								row.push(c);
								_cells[n] = _cells[n] || [_self.keys[n].cell];
								_cells[n][i + 1] = c;
								c.column = _cells[n];
								c.row = row;
								_self.keys[n].cell.column = c.column;
							}
							tbody.append(tr);
						}
					}
				},
				keys: {
					set: function (a) {
						var thead = _self.table.$el.find('thead');
						_keys = a;
						var tr = $('<tr></tr>');
						for (var i = 0, row = []; i < a.length; i++) {
							var cell = new EfbCell({value: a[i].name, type: 'th'});
							cell.column = [cell];
							cell.root = _self;
							cell.row = row;
							a[i].cell = cell;
							cell.options = a[i];
							tr.append(cell.$el);
							row.push(cell);
						}
						thead.html('').append(tr);
					},
					get: function () {
						return _keys;
					}
				}
			});
			_EFB.data.map[tableOpt.type] = _EFB.data.map[tableOpt.type] || {};
			_EFB.data.map[tableOpt.type]['value'] = _self;
			initDragAndDrop(this);
			this.options = tableOpt;
		};
	// 导入单个控件到左侧控件区域
	this.loadField = function (f) {
		var btn = $('<button class="efb-field ">' +
			'<span class="fa-font ' +
			(f.icon || '') +
			'"></span>' +
			f.name +
			'</button>');

		if (f.order) {
			_EFB.printPage.addField(f, btn);
		} else {
			$efb_fields.append(initBtnDrag(f, btn));
		}
		btn[0].onclick = function () {
			btn.remove();
			_EFB.printPage.addField(f, btn);
		};
	};
	// 页面插入组件
	// 处理组件Order字段的逻辑
	this.printPage = {
		print:function(opt){
			var defaultPrintOpt = {
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
			};
			opt = $.extend({},defaultPrintOpt,opt);
			_EFB.printPage.$el.click();
			_EFB.printPage.$el.printThis(opt);
		},
		name:'纸张',
		type:'page',
		options : _EFB.printPage,
		$el: [],
		removeField: function (f) {
			f.order = 0;
			var a = this.fields.indexOf(f);
			this.fields.splice(a, ~~(a > -1));
			delete _EFB.data.map[f.key];
			$efb_fields.append(initBtnDrag(f._config, f.button));
			f.$el.remove();
		},
		freshOrders: function () {
			_EFB.printPage.fields.forEach(function (f) {
				f.order = $efb_print_page.children().index(f.$el) + 1;
			});
		},
		fields: [],
		addField: function (f, btn) {
			var fi = _EFB.activeField(f);
			fi.button = btn;
			if (!fi.order)fi.order = 0;
			if (0 === _EFB.printPage.fields.length || fi.order === 0) {
				$efb_print_page.append(fi.$el);
			} else {
				fi.destance = Number.MAX_VALUE;
				for (var i = 0, c; i < _EFB.printPage.fields.length; i++) {
					c = _EFB.printPage.fields[i];
					var distance = Math.abs(c.order - fi.order);
					if (fi.destance > distance) {
						fi.destance = distance;
						fi.target = c;
					}
				}
				c = fi.target;
				if (fi.order > c.order)c.$el.after(fi.$el);
				else c.$el.before(fi.$el);
				delete  fi.destance;
				delete  fi.target;
			}
			_EFB.printPage.fields.push(fi);
			if (!fi.order)this.freshOrders();
		}
	};
	Object.defineProperties(this.printPage,{
		scale : {
			get:function(){
				return __pageScale__;
			},
			set:function(a){
				__pageScale__ = parseInt(a);
				var scale = 'scale('+(a/100).toFixed(3) + ')';
				_EFB.printPage.$el.css({
					'-webkit-transform': scale,
				'-ms-transform': scale,
				'transform': scale
				});
			}
		},
		pageSize : {
			get:function(){
				return __pageSize__;
			},
			set:function(a){
				if(a.length&& a.map){
					__pageSize__ = a;
					_EFB.printPage.$el.css({width:a[0]+'mm',height:a[1] +'mm'});
				}
			}
		}
	});
	//组件装入到打印区域
	this.activeField = function (f) {
		var cf = {};
		var vs = _EFB.data.values[f.type];
		switch (f.type) {
			case 'common field':
				cf = new CommonField(f);
				cf.value = vs && vs[cf.key] || cf.value || '';
				cf.name = vs && vs[cf.name] || cf.name || '';
				break;
			case 'table field':
				cf = new TableField(f);
				cf.keys = vs && vs.keys || cf.keys || '';
				cf.value = vs && vs.value || cf.value || '';
				break;
			case 'head field':
				cf = new HeadField(f);
				cf.value = vs && vs.value || cf.value || '';
				break;
		}
		cf.order = f.order;
		return cf
	};
	//批量导入控件
	this.loadFields = function (f) {
		if (f && !$.isArray(f))f = [f];
		if (!f || !f.length)return _EFB;
		f.forEach(function (a) {
			_EFB.loadField(a);
		});
		return _EFB;
	};
	// 定义模板管理对象(不是直接导入的模板)
	this.templates = {
		data: [],//存放模板
		whiteList:{},
		blackList:{},
		export: function (f) {
			f = f || _EFB.templates.active;
			if (!f)return;
			return safeJSONStringify(_EFB.templates.active);
		},
		exportAll: function () {
			return safeJSONStringify(_EFB.templates.data);
		},
		forEach: function (func) {
			_EFB.templates.data.forEach(func);
			return this;
		},
		// 参数：数字 返回对应的模板 ， or 键名，值  返回字段符合条件的模板
		get: function (k, v) {
			var _this = _EFB.templates;
			if ($.isNumeric(k) && undefined === v) {
				return _this.data[k];
			} else {
				for (var i = 0; i < _this.data.length; i++) {
					if (_this.data[i][k] === v)return _this.data[i];
				}
			}
		},
		index: function (k, v) {
			for (var i = 0; i < _EFB.templates.data.length; i++) {
				if (_EFB.templates.data[i][k] === v)return i;
			}
			return -1;
		},
		//对模板排序 opt - true 降序
		sortBy: function (k, opt) {
			sortBy(_EFB.templates.data, k, opt);
			return this;
		},
		// 插入模板到模板数组字段
		push: function (a) {
			_EFB.templates.data.push(a);
			return this;
		},
		// 移除模板
		remove: function (k, v) {
			var i = _EFB.templates.index(k, v);
			_EFB.templates.data[i].$el.remove();
			if (i > -1)_EFB.templates.data.splice(i, 1);
			return this;
		}
	};
	// this.templates active 绑定get set 方法
	// this.templates.active 返回激活的模板
	// this.templates active = ‘模板名称’ 设定激活的模板
	Object.defineProperty( _EFB.templates, 'active', {
		get: function () {
			return _EFB.templates.get('name', __active);
		},
		set: function (a) {
			__active = a;
			var t = _EFB.templates.active;
			_EFB.tabs.tabs({active: 0});
			$efb_choose.val(a);
			$efb_fields.find('button:not(.add)').remove();
			$efb_print_page.html('');
			$efb_edit_main.html('');
			_EFB.printPage.fields = [];
			// 清空组件键值对
			_EFB.data.map = {};
			if (!t)return;
			// 载入组件
			var f = t.fields;
			sortBy(f, ['type', 'name'], [false, false]);
			_EFB.loadFields(f);
		}
	});
	this.setBlankTemplate = function(t){
		if(t)_EFB.templates.blankTemplate =t;
		t.name='__blank__';
	};
	// 批量载入模板
	this.loadTemplates = function (t, mode) {
		if(!t)execOpt('query');
		if(typeof t === 'string') t=JSON.parse(t);
		if (t && !$.isArray(t))t = [t];
		if (!t)return _EFB;
		mode = mode || EFB.mode.OVERWRITE;
		_EFB.templates.data = (EFB.mode.EMPTY_LOAD === mode ? [] : (_EFB.templates.data || []));
		if(_EFB.templates.blankTemplate
			&&_EFB.templates.data.indexOf(_EFB.templates.blankTemplate)===-1){
			_EFB.templates.data.push(_EFB.templates.blankTemplate);
		}
		_EFB.templates.active = '';
		t.forEach(function (a) {
			if(!a||!a.name)return;
			// TODO: 这里是过滤 将来权限的限制可能在这里配置
			// 当模板所属账号是对方账号时候启动过滤
			if(_EFB.opt.param.elsAccount!==elsAccount){
				// 当白名单不为空 且模板ID不在白名单中 跳过该模板
				if(_EFB.templates.whiteList.length&&
					_EFB.templates.whiteList.indexOf(a.templateNumber)===-1)
				return;
			}
			var r=_EFB.templates.get('name', a.name);
			if (r) {
				if (EFB.mode.OVERWRITE === mode)$.extend(r, a);
			} else _EFB.templates.push(a);
		});
		$efb_select.find('li:not(.add)').remove();
		_EFB.templates.sortBy('name').forEach(function (a) {
			if(a.name==='__blank__')return;
			var li = $('<li>' + a.name + '</li>');
			a.$el=li;
			li.click(function (e) {
				e.stopPropagation();
				if (!_EFB.templates.active || _EFB.templates.active.name !==$(this).text()) {
					_EFB.templates.active = $(this).text();
					__tempT=false;
					$efb_choose.attr('readonly', 'readonly');
				}
				$efb_select.slideUp(100);
			});
			$efb_select.find('.add').before(li);
		})
	};
	// 键值数据缓存
	this.data = {
		_datas: [],
		map: {},
		values: {},
		load: function (d) {
			if ($.isArray(d)) {
				this._datas = d;
				return this.load(d[0]);
			}
			if (this._datas.indexOf(d) === -1) {
				this._datas.push(d);
			}
			$efb_data_num.text(this._datas.indexOf(d) + 1 + '/' + this._datas.length);
			d = d || _EFB.data.values;
			_EFB.data.values = d;
			for (var t in _EFB.data.map) {
				if (!_EFB.data.map.hasOwnProperty(t))return;
				if (typeof _EFB.data.map[t] === 'object') {
					var ks = _EFB.data.map[t];
					for (var k in ks) {
						if (d[t] && d[t][k]) {
							ks[k].value = d[t][k];
						}
					}
				}
			}
			return _EFB;
		}
	};
	// 编辑区域功能组件生成
	this.editView = {
		createTableFieldsEditor: function (field) {
			if (field.type === 'table field') {
				var $dom = $('<div class="efb-table-fields"></div>');
				if (field.keys) {
					field.keys.forEach(function (a) {
						var $d = $("<div><input type='checkbox' id='" + a.key + "'><label for='" + a.key + "'>" + a.name + "</label></div>");
						$d.find('input').attr('checked', a.cell.visible).change(function () {
							a.cell.visible = !!$(this).attr('checked');
						});
						$dom.append($d);
					});
					return $dom;
				}
			}
			return [];
		},
		createRange:function(field,attr,label,w1, w2, w3,min,max,defaultValue,step){
			if(!checkAttr(field,attr))return '';
			return definedDom('div',{
				css : {width :fix(w1)},
				children:[{
					tag:'label',
					text : label,
					css : {width : fix(w2)}
				}, {
					tag:'input',
					defaultValue : field[attr],
					min : min||0,
					max: max||100,
					step: step||1,
					type: 'range',
					css: {width :fix(w3)},
					onchange : function(){
						field[attr] = this.value;
					},
					oninput:function(){
						field[attr] = this.value;
					},
					onpropertychange:function(){
						field[attr] = this.value;
					}
				}
			]});
		},
		createSelect:function(field,attr,label,w1, w2, w3,options){
			if(!checkAttr(field,attr))return '';
			var d =  definedDom('div', {
				css : {width :fix(w1)},
				children : [{
					tag:'label',
					text : label,
					css : {width : fix(w2)}
				},{
					tag:'select',
					css: {width :fix(w3)},
					onchange : function(){
						field[attr] = this.value.split(',');
					},
					children : options.map(function(a){
						return {
							tag : 'option',
							text : a.t,
							value : a.v
						}
					})
				}]
			});
			if(!field[attr].length){
				field[attr] = options[0].v;
			}else {
				for(var i=0;i<options.length;i++){
					if(options[i].v.join()===field[attr].join())d.seleceIndex = i;
				}
			}
			return d;
		},
		createInputs: function (opt) {
			var $els = [];
			var field = opt[0], w1 = opt[1], w2 = opt[2], w3 = opt[3], handle = opt[4];
			var args = arguments;
			for (var i = 1; i < args.length; i++) {
				var arg = args[i];
				if ($.isArray(arg)) {
					var a = [arg[2] || field, arg[0], arg[1], arg[3] || w1, arg[4] || w2, arg[5] || w3, arg[6] || handle];
					$els.push(_EFB.editView.createInput.apply(null, a))
				}
			}
			return $els;
		},
		createInput: function (field, attr, label, w1, w2, w3, handle) {
			if(!checkAttr(field,attr))return '';
			var fix = function (w) {
				if (undefined == w) w = '';
				if (w !== 0 && w !== 'auto')if ($.isNumeric(w))w += 'px';
				return w;
			};
			var a = $('<div><label></label><input type="text"></div>');
			a.width(fix(w1)).find('label')
				.text(label).width(fix(w2))
				.siblings('input').width(fix(w3)).val(field[attr])
				.on('keyup input propertychange', function (e) {
					e.stopPropagation();
					var v = this.value;
					if (handle)v = handle(v);
					field[attr] = v;
				});
			return a;
		}
	};
	// 编辑功能 传入组件类对象
	this.editField = function (field) {
		if (field.type && field.$el.hasClass('efb-field-warp')) {
			$efb_edit_btn
				.removeClass('js-create-field')
				.addClass('js-remove-field')
				.text(lang.DELETE)[0].onclick = function () {
				$efb_edit_main.html('');
				_EFB.printPage.removeField(field);
				$efb_print_page.click();
			};
		} else {
			$efb_edit_btn
				.addClass('js-create-field')
				.removeClass('js-remove-field')
				.text(lang.CREATE)[0]
				.onclick = $.noop;
		}
		_EFB.tabs.tabs({active: 1});

		$efb_edit_main.html('').append(
			$('<h5/>',{text:(field.root?field.root._config.name+' ['+field.type+']':field.name)+'  '+((field.root&&field.root._config||field).key||'')}),
			_EFB.editView.createRange(field,'scale','页面缩放',200,50,200,10,100,false,1),
			_EFB.editView.createSelect(field,'pageSize','纸张比例',200,50,200,[
				{t:'A4[纵向 210*297mm]',v:[210,297]},{t:'A4[横向 297*210mm]',v:[297,210]},
				{t:'A3[纵向 279*420mm]',v:[279,420]},{t:'A3[横向 420*297mm]',v:[420,279]}
			]),
			_EFB.editView.createInputs(
				[field, 100, 50, 100], ['value', lang.VALUE], ['width', lang.WIDTH],
				['height', lang.HEIGHT], ['textAlign', lang.TEXT_ALIGN],
				['color', lang.COLOR], ['fontFamily', lang.FONT],
				['fontSize', lang.FONT_SIZE], ['maxWidth', lang.MAX_WIDTH],
				['maxHeight', lang.MAX_HEIGHT], ['minWidth', lang.MIN_WIDTH],
				['minHeight', lang.MIN_HEIGHT], ['border', lang.BORDER],
				['borderTop', lang.BORDER_TOP],['visible', lang.VISIBLE]
			)).append(_EFB.editView.createTableFieldsEditor(field));
	};
	//初始化
	// 可以传一个参数 selector 或者包含selector 的opt
	// 可以传两个参数 selector 和 opt
	this.initialize = function (sel, opt) {
		if (typeof sel === 'object') {
			var _opt = opt;
			opt = sel;
			sel = _opt;
		}
		// tabs 模板
		var
		// 组件操作
			editOptArea = '<div class="efb-edit-opt"><label>' +
				lang.FIELD_TYPE +
				'</label><input type="text" readonly /><button class="js-create-field">' +
				lang.CREATE +
				'</button><ul class="efb-f-type"></ul></div>',
		// 组件编辑
			editContent = '<div class="efb-edit-main"><p>' +
				lang.EDIT_AREA +
				'</p></div>',
			tabs =
				'<div class="efb-tabs"><ul><li><a href="#efb-fields">' +
				lang.FIELDS_LIST +
				'</a></li><li><a href="#efb-edit">' +
				lang.EDIT_FIELD +
				'</a></li></ul><div id="efb-fields"></div><div id="efb-edit">' +
				editOptArea +
				editContent +
				'</div></div>',
		// 模板操作部分
			templateOptArea = '<div class="efb-template-opt">' +
				'<div class="js-print" title="'+lang.PRINT+'"></div>' +
				'<div class ="efb-opt-tip"><div><span class="efb-opt-loading"></span><span class="efb-opt-content"></span></div></div>' +
				'<label>' + lang.CHOOSE_TEMPLATE + '</label>' +
				'<div class="js-data-prev"></div><div class="efb-data-num">' +
				lang.PAGE +
				'<span>0/0</span></div><div class="js-data-next">' +
				'</div><input type="text" readonly class="js-choose">' +
				'<div class="efb-opt-btn-group">' +
				'<button class="js-save" title="' + lang.SAVE + '"></button>' +          // 保存按钮
				'<button class="js-save-as" title="' + lang.SAVE_AS + '"></button>' +      // 另存为按钮
				'<button class="js-delete" title="' + lang.DELETE + '"></button>' +        // 删除按钮
				'</div>' +
				'<ul class="efb-select"></ul>' +
				'</div>';
		// 继承默认选项
		efbOpt = $.extend({}, defaultOpt, efbOpt || {});
		_EFB.opt = efbOpt;
		if (sel && efbOpt)efbOpt.selector = sel;
		var $el = $(efbOpt.selector);
		$el.html(
			'<div class="efb-left">' +
			templateOptArea +
			tabs +
			'</div>' +
			'<div class="efb-right">' +
			'<div class="efp-print-page"></div>' +
			'</div>'
		);
		_EFB.tabs = $('.efb-tabs').tabs({active: 0});
		_EFB.$el = $el;
		_EFB.$el.opt = efbOpt;
		// 初始化各个选择器
		$efb_choose						 	= _EFB.$el.find('.js-choose');
		$efb_select 							= _EFB.$el.find('.efb-select');
		$efb_template_opt 			 	= _EFB.$el.find('.efb-template-opt');
		$efb_fields 						 	= _EFB.$el.find('#efb-fields');
		$efb_print_page 				 	= _EFB.$el.find('.efp-print-page');
		$efb_edit 							 	= _EFB.$el.find('#efb-edit');
		$efb_edit_main 				 	= _EFB.$el.find('.efb-edit-main');
		$efb_edit_btn 					 	= _EFB.$el.find('.efb-edit-opt button');
		$efb_page_prev 				 	= _EFB.$el.find('.js-data-prev');
		$efb_page_next 				 	= _EFB.$el.find('.js-data-next');
		$efb_data_num 				 	= _EFB.$el.find('.efb-data-num span');
		$btn_template_save 		 	= $efb_template_opt.find('.js-save');
		$btn_template_save_as		= $efb_template_opt.find('.js-save-as');
		$btn_template_delete			= $efb_template_opt.find('.js-delete');
		$btn_page_print					= $efb_template_opt.find('.js-print');
		$efb_opt_tip 					 	= $efb_template_opt.find('.efb-opt-tip');
		$efb_opt_tip_ico 			 	= $efb_template_opt.find('.efb-opt-loading');
		$efb_opt_tip_text 			 	= $efb_template_opt.find('.efb-opt-content');
		_EFB.printPage.$el   			 	= $efb_print_page;
		_EFB.printPage.$el.options   = _EFB.printPage;

		$btn_template_save.click(execOpt.bind(null,'save'));
		$btn_template_delete.click(execOpt.bind(null,'delete'));

		$efb_choose.on('input propertychange',function(){
			if(__tempT){
				__tempT.name=$efb_choose.val();
			}
		});

		$efb_print_page.on('click', resetPageField).droppable({
			tolerance: 'pointer',
			accept: '#efb-fields button.efb-field',
			addClasses: false,
			hoverClass: 'efb-field-add-to-page',
			drop: function (e) {
				e.stopPropagation();
				var d = _EFB.printPage.dragField;
				$efb_print_page.append(d.$el);
				_EFB.printPage.freshOrders();
			}
		}).click();

		_EFB.$el.find('.efb-left').droppable({
			tolerance: 'pointer',
			accept: '.efb-field-warp',
			addClasses: false,
			hoverClass: 'efb-field-warp-delete',
			drop: function () {
				var d = _EFB.printPage.dragField;
				$efb_edit_main.html('');
				_EFB.printPage.removeField(d);
				$efb_print_page.click();
			}
		}).on('mouseleave', function () {
			_EFB.$el.find('.efb-left').removeClass('efb-field-warp-delete');
		});

		$efb_page_prev.click(function () {
			var v = _EFB.data.values;
			var i = _EFB.data._datas.indexOf(v);
			if (i > 0)i--;
			_EFB.data.load(_EFB.data._datas[i])
		});

		$efb_page_next.click(function () {
			var v = _EFB.data.values;
			var d = _EFB.data._datas;
			var i = d.indexOf(v);
			if (i < d.length - 1)i++;
			_EFB.data.load(d[i]);
		});

		$efb_choose.click(function (e) {
			e.stopPropagation();
			$efb_select.slideDown(100);
		});

		$efb_edit_btn.click(function () {
			if ($efb_edit_btn.hasClass('js-remove-field')) {

			}
			if ($efb_edit_btn.hasClass('js-create-field')) {

			}
		});
		var creatLi = $('<li class="add">' + lang.NEW_TEMPLATE + '</li>');
		var addField = $('<button class="efb-field  add"><span class="fa-font icon-add"></span>' + lang.NEW_FIELD +
			'</button>');
		addField.click(function () {
			_EFB.tabs.tabs({active: 1});
			// TODO： 构建新建组件部分
		});
		// 下拉点击新建模板
		creatLi.click(function () {
			_EFB.templates.active = '';
			$efb_choose.removeAttr('readonly');
			$efb_choose.focus();
			$efb_choose.val(lang.NEW_TEMPLATE);
			$efb_choose.select();
			$efb_select.slideUp(100);
			if(_EFB.templates.blankTemplate)
				__tempT = $.extend(true,{},_EFB.templates.blankTemplate);
				window.__tempT = __tempT;
				_EFB.loadFields(__tempT.fields);
		});
		// 其他部分点击或者鼠标移出该范围收起
		$efb_template_opt.on('click mouseleave', function () {
			$efb_select.slideUp(100);
		});
		$btn_page_print.click(_EFB.printPage.print);
		$efb_select.append(creatLi);
		$efb_fields.append(addField);

		//加载模板们
		if(opt.templates)_EFB.loadTemplates(opt.templates, opt.mode);
		delete _EFB.initialize;
		return _EFB;
	};
	this.initialize(sel, efbOpt);
};

// 模板加载模式
EFB.mode = {
	EMPTY_LOAD: 0x000001, //清空然后载入
	SKIP_SAME_NAME: 0x000002, // 跳过已存在
	OVERWRITE: 0x000003 // 覆盖已存在
};
// 语言选择
EFB.lang = {
	zh_cn: {
		VALUE: '值',
		OPT_DONE:'操作完成!',
		OPT_FAIL:'操作失败!',
		LOAD_DONE:'模板加载完成!',
		LOAD_FAIL:'模板加载失败!',
		NONE_DATA:'没有数据!',
		UPDATING_TEMPLATE: '正在更新模板',
		LOADING_TEMPLATE: '正在加载模板',
		CREATING_TEMPLATE:'正在保存模板',
		NEW_TEMPLATE: '新建模板',
		COLOR: '颜色',
		FIELDS_LIST: '组件列表',
		EDIT_FIELD: '编辑组件',
		CHOOSE_TEMPLATE: '选择模板',
		NEW_FIELD: '新建组件',
		DELETE: '删除',
		SAVE: '保存',
		SAVE_AS: '另存为',
		EDIT_AREA: '组件编辑区域',
		CREATE: '创建',
		FIELD_TYPE: '组件类别',
		COMMON_FIELD: '一般组件',
		TABLE_FIELD: '表格',
		LABEL: '标签',
		LOADING:'正在执行操作',
		LENGTH: '长度',
		WIDTH: '宽度',
		HEIGHT: '高度',
		TEXT_ALIGN: '文字对齐',
		FONT: '字体',
		ORDER: '顺序',
		FONT_SIZE: '文字大小',
		VISIBLE: '显示',
		MAX_WIDTH: '最大宽度',
		MAX_HEIGHT: '最大高度',
		MIN_WIDTH: '最小宽度',
		MIN_HEIGHT: '最小高度',
		PADDING_X: '横向内间距',
		PADDING_Y: '纵向内间距',
		PRINT:'打印页面',
		PAGE: '页面',
		BORDER : '边框',
		BORDER_TOP:'顶部边框'
	}
};

$(function () {
	var printData = getIframeData();
	printData.tKeys = printData.tKeys||[];
	printData.cKeys = printData.cKeys||[];
	printData.cData = printData.cData||[];
	var param ={
		businessType : printData.businessType,
		elsAccount: elsAccount,
		elsSubAccount : elsSubAccount
	};

	var blankTemplate =printData.blankTemplate||{fields: [{
		name: '表头',
		type: 'head field',
		head: {
			value: '表头'
		}
	}, {
		name: '打印人',
		key: 'print-user',
		type: 'common field',
		width: '100%',
		label:{
			value:'打印人'
		},
		text:{
			value:top.elsDeskTop.loginStore.username
		}
	}, {
		name: '打印时间',
		key: 'print-data',
		type: 'common field',
		width: '100%',
		label:{
			value:'打印时间'
		},
		text:{
			value: new Date().toLocaleDateString()
		}
	}
	].concat(printData.cKeys.map(function (d) {
		return {
			name: d.title,
			key: d.name,
			type: 'common field',
			width: '100%',
			text: {width: 'auto'},
			label: {width: '100px',value:d.title+'：',hideAttr:[]}
		}
	})).concat(
		{
			name: '表A',
			type: 'table field',
			label:{
				value:'表',
				hideAttr:[]
			},
			keys: printData.tKeys.map(function (a) {
				return {name: a.title, key: a.name}
			})
		}
	)};
	window.efb = new EFB('.efb-main',{
		api:{
			query        : basePath+'rest/ElsPrintTemplateService/queryPrintTemplate',
			create      : basePath+'rest/ElsPrintTemplateService/addPrintTemplate',
			update      : basePath+'rest/ElsPrintTemplateService/updPrintTemplate',
			delete       : basePath+'rest/ElsPrintTemplateService/delPrintTemplate'
		}
	});
	efb.setBlankTemplate(blankTemplate);
	var loadData = function (a) {
		console.debug(a);
		var datas = [], urls = [];
		// 重组数据结构
		a.cData.forEach(function (d, i) {
			urls[i] ={
					u:a.tUrlPrefix,
					param:{
						itemIds:d[a.tUrlKey],
						elsAccount :elsAccount
					}
			};
			datas[i] = datas[i] || {};
			datas[i]['head field'] = datas[i]['head field'] || {};
			datas[i]['common field'] = datas[i]['common field'] || {};
			a.cKeys.forEach(function (k) {
				datas[i]['common field'][k.name] = d[k.name];
			})
		});
		var _s = 0;
		var onSuccess = function (data) {
			_s++;
			if (typeof data === 'object' && data.rows) {
				datas[this.i]['table field'] = {value: data.rows};
			}
			if (_s === urls.length)efb.data.load(datas);
		};
		urls.forEach(function (a, i) {
			$.ajax({
				url : a.u,
				type : "post",
				dataType : "json",
				contentType : "application/json",
				data:JSON.stringify(a.param)
			}).done(onSuccess.bind({i: i}));
		});
	};
	$.ajax({
		// 过滤
		url : basePath + 'rest/ElsPrintTemplateService/getPrintTemplateConfig',
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify({
			businessType : printData.businessType,
			elsAccount: printData.elsAccount[0],
			toElsAccount:printData.toElsAccount[0]
		})
	}).done(function(data){
		if(data&&data.templateNumber&&data.templateElsAccount&&data.businessType){
			$.extend(param,{
				businessType : data.businessType,
				elsAccount: data.templateElsAccount,
				elsSubAccount : data.elsSubAccount||''
			});
			efb.templates.whiteList=data.templateNumber.split(',');
		}
		efb.opt.param = param;
		efb.loadTemplates();
		loadData(printData);
		onIframeDataChange(loadData);
	}).fail(function(){
		return parent.elsDeskTop.tip.init({type: 'alert',displayType: 3, message:'error'});
	});
});