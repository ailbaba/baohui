/**
 * @class TemplateManager 前端模板生成
 *  @description
 *  	- 使用doT.js 模板引擎解析模板
 *  	- TemplateManager 包括了分页判断和模板组装以及数据填充等功能
 *  @param {string|Node} [selector]  可选 模板输出到该选择器中
 *  @this  TemplateManager
 * */
var TemplateManager = function(selector) {
    if (selector) {
        this.$el = $(selector)
    }
    var pageList = [];
    var tpls = [];
    // 模板各个部分
    var ruls = [];
    // 各个部分的添加规则
    var lastTable;
    var ph, rh;
    //页面像素高，行像素高
    this.pageList = pageList;
    /**
	 * @member {object}
	 * @description  默认模板 当自定义模板中对应的部分未定义会使用这里定义的内容
	 * */
    this.defaultTpls = {
        pagination: '<div class="paging">' 
        + '<span>第<span class="cur">1</span></span>页&nbsp;<span>共<span class="total">1</span></span>页</div>' 
        + '<div class="clear"></div>'
    };
    /**
	 * @private {function}
	 * @description  基于模板显示规则创建新的页面
	 * */
    var createPage = function() {
        var t = self._t;
        var children = []
          
        , p = pageList.length
          
        , exec = {
            // 每页都显示
            all: function(t) {
                children.push(t.cloneNode(true))
            },
            // 只显示在第一页
            first: function(t) {
                if (p === 0)
                    children.push(t)
            },
            // 只显示在第二页
            last: function(t) {
                children.push(t)
            },
            // 表格
            table: function(t) {
                t = t.cloneNode(true);
                children.push(t);
                lastTable = t;
            }
        };
        ruls.forEach(function(r, i) {
            var t = tpls[i];
            var e = exec[r];
            if (!e) {
                throw new Error('没有对应的模板显示规则')
            }
            e(t);
        });
        var elm = definedDom('div', {
            children: children
        });
        var page = definedDom('div', {
            class: 'page',
            children: elm,
            css: {
                width: parseFloat(t.width) - 13 + 'mm',
                height: parseFloat(t.height) - 18 + 'mm'
            }
        });
        page.elm = elm;
        pageList.push(page);
        self.$el.append(page);
    }
    ;
    /**
	 * @private {function}
	 * @description 执行渲染模板(包括分页)
	 * */
    var processRender = function() {
        var pageCursor = 0;
        var o = self._t;
        var r = o.rowRule && Object.keys(o.rowRule)[0];
        if (typeof self._h === 'function') {
            var rt = self._h(self._d);
            if (rt)
                self._d = rt;
        }
        if (self._d.promise) {
            self._d.done(function(d) {
                delete self._h;
                self._d = d;
                processRender();
            });
            return self
        }
        o.templateRule.forEach(function(a) {
            var k = Object.keys(a)[0];
            tpls.push(definedDom('div', {
                class: 'tpl ' + 'tpl-' + k,
                html: doT.template(self._t[k] || self.defaultTpls[k])(self._d)
            }));
            ruls.push(a[k]);
        });
        createPage();
        var rTpl, repeatNum, rows, curP = null , elm = null , table = null ;
        var setCurElem = function() {
            curP = pageList[pageCursor];
            elm = $(curP.elm);
            if (r)
                table = elm.find(o.rowRule[r]);
        }
        ;
        setCurElem();
        if (r) {
            rTpl = self._t[r];
            repeatNum = rTpl && (rTpl.match(/<tr>/g) || 'x').length;
            rows = $(doT.template(rTpl)(self._d)).toArray();
            ph = $(curP).height();
            for (var i = 0, l = rows.length; repeatNum && i < l; i += repeatNum) {
                var ro = rows.slice(i, i + repeatNum);
                table.append(ro);
                var rph = elm.outerHeight(true);
               /* if (rph > ph)
                	throw new Error('页面高度设置过小！');
                if (i === 0) {
                    rh = $(ro).outerHeight(true) * repeatNum
                }*/
                //加上border的高度
                debugger;
                rh = $(ro).outerHeight(true) * repeatNum+4;
                if ((rh + rph + rh) > ph || (rph+rh>ph)) {
                    createPage();
                    rph = elm.outerHeight(true);
                    console.log('\nrow height :', rh, '\npage content height :', rph, '\npage height :', ph);
                    if (rh + rph+rh > ph) {
                        pageCursor++;
                        setCurElem();
                    }
                } else
                    console.log('\nrow height :', rh, '\npage content height :', rph, '\npage height :', ph);
            }
            var trs = table.find('tr').size();
            if (0 === trs && pageList.length > 1)
                lastTable.remove();
        }
        
        var l = pageList.length;
        if (l > 0 && !$(pageList[l - 1]).text()) {
            pageList.splice(l - 1, 1)[0].remove();
        }
        if (typeof self._f === 'function') {
            self._f.call(self)
        }
        console.log('\nPageData:\t', self._d);
        console.log('\nPageTemplate:\t', self._t);
    }
    ;
    var self = this;
    /**
	 * @member {function}
	 * @param {function} h
	 * @return TemplateManager
	 * 传入的数据处理
	 * */
    this.handler = function(h) {
        self._h = h;
        return self
    }
    ;
    
    /**
	 * @member {function}
	 * @param {object} t
	 *
	 *   模板规则：
	 *  	- 模板内部组件按照templateRule里数组的排序依次放入到页面
	 *    - [{k:v},{k:v}]
	 *    k - 对应自定义模板的同名部分
	 *    v  - 'all'        	该部分在所有页面都显示
	 *    v  -  'first'    	该部分在第一个页面显示
	 *    v  -  'last'        该部分在最后的页面显示
	 *    v  -  'table'    	该部分是一个表格
	 *
	 *  {object} opt.row {k:v} k-自定义模板里的键 v-选择器 表示要插入到的地方
	 * */
    this.template = function(t) {
        self._t = t;
        return self;
    }
    ;
    /**
	 * @member {function}
	 * @param {object} d 传入的数据 可以是promise对象
	 * @return TemplateManager
	 * */
    this.data = function(d) {
        if (typeof d.done === 'function') {
            self.promise = d;
        } else
            self._d = d;
        return self
    }
    ;
    /**
	 * @member {function}
	 * @param {function} func 执行完渲染后的补充操作
	 * @return TemplateManager
	 * */
    this.fix = function(func) {
        self._f = func;
        if (pageList.length)
            func.call(self);
        return self;
    }
    ;
    /**
	 * @member {function}
	 * @param {string} selector 渲染内模板容到指定目标中
	 * @return TemplateManager
	 * */
    this.render = function(selector) {
        if (selector) {
            self.$el = $(selector)
        }
        if (!self.$el) {
            throw new Error('no render target found!');
        }
        if (self.promise && self.promise.done) {
            self.promise.done(function(d) {
                self.data(d);
                processRender();
            }).fail(function() {
                throw new Error('Can\'t get any data!');
            })
        } else
            processRender();
        return self;
    }
}
;
