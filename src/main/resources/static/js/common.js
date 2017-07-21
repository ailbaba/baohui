/**
 *  用于页面间的跨域通讯
 * */
window.addEventListener('message',function(e){
    var origin = e.origin || e.originalEvent.origin;
    if (new RegExp(location.hostname).test(origin)){
        var data = e.data;
        try {
            data = JSON.parse(data);
            if(data.type==='defineWin'){
            	elsDeskTop.defineWin(data.data)
            }	
        }catch(e){
            console.log(e)
        }
    }
});

/**

 *  @description 图片地址转BASE64
 *  @param {string} src
 *  @param {number} height
 *  @param {number} width
 *  @return {object} 返回 promise 对象
 *  @example
 *   imgSrc2DataURL('icon/destop-icon/desktop_icon_130.gif').done(function(a){console.log(a)})
 * */
var imgSrc2DataURL = function(src,width,height){
    var dfd =  $.Deferred();
    definedDom('img',{
        src:src,
        onload:function(){
            var c = definedDom('canvas',{height:height||this.height, width :width||this.width});
            c.getContext('2d').drawImage(this, 0, 0,width,height);
            dfd.resolve(c.toDataURL());
        },
        onerror:function(){
            dfd.reject(new Error('加载地址失败'),src);
        }
    });
    return dfd.promise();
};


/**
 *  @description    带筛选功能和键位操作的下拉组件
 *  @author     zwy
 *  @create     2016-5-11 14:43
 *  @example
 *   <div id = 'xxx' els-dp></div>
 *
 *  <script>
 *      var  dp = $('#xxx')[0] ;                                     //- 获取功能已经初始化好的Dom对象
 *
 *      dp.onchange = function(){console.log('change',this.value)}
 *
 *      dp.handler = function(dat){ console.log(dat.d)} // 在数据渲染前 处理数据
 *      // 要生效需要在 dp.data = xx 前 设置；
 *
 *      dp.afterRender = function(){// do something} 赋值 data 之后执行
 *
 *      var data = [{c:1,d:'hello'},{c:2,d:'world'}]
 *      // 其他数据格式:
 *      // 或者 data = {1:'hello',2:'world'} 一样会正确解析
 *      // data = ['hello','world']  会解析 为[{c:'0',d:'hello'},{c:'1',d:'world'}]
 *
 *      dp.kName ='c' ;                             // - 设定 数据的key值对应字段
 *      dp.vName = 'd' ;                            // - 设定 数据的文本值对应字段 即页面显示内容
 *      dp.data = data;                              // 赋值 自动生成下拉内容
 *       // 赋值后执行 dp.handler
 *       // 输出  hello
 *      // 输出  world
 *
 *      dp.value = '2'                                  // - 设置 c 为2 的数据选中
 *      // 触发onchange 输出 '2'
 *      dp.value = '2'                                  // - 不触发onchange
 *      console.log(dp.value)                      // - 输出 当前选中的值 2
 *      console.log(dp.selected )                // - 输出 当前选中的Dom <li>world</li>
 *      console.log(dp.selected._d )           // - 输出 当前选中的Dom 对应的数据模型
 *      console.log(dp.selectedIndex )     // - 输出 当前选中的数据下标 1
 *      dp.selectedIndex  =  0；
 *      console.log(dp.value)                      // - 输出 1
 *      dp.selectedIndex  =  99；            // 报错 不改变
 *
 *  </script>
 * */
$(function(){

    $('div[els-dp]').each(function(index,dp){
        var act = function(li){
            if(!li)return;
            if(dp._sel)dp._sel.style.removeProperty('background');
            dp._sel = li;
            dp._sel.style.background = '#dcdcdc';
            (li.scrollIntoViewIfNeeded||li.scrollIntoView).call(li);
        };
        dp.kName='k';
        dp.vName='v';
        dp.innerHTML='';
        var filterLis = function(){
            var _v = this.value.replace(/^\s+|\s+$/,'').toLowerCase();
            dp.state=1;
            ul.visLis=[];
            [].forEach.call(ul.childNodes,function(li){
                var d = li._d;
                var isInK = (d[dp.kName]||'').toLowerCase().indexOf(_v)!==-1;
                var isInV = (d[dp.vName]||'').toLowerCase().indexOf(_v)!==-1;
                var show = isInV||isInK;
                if(show)ul.visLis.push(li);
                li.style.display = show?'':'none';
            });
        };
        var showLis = function(e){
            e.preventDefault();
            e.stopPropagation();
            var _k = dp.value;
            if(_k===''&&text.value === dp.text)text.value='';
            else this.select();
            dp.state = 1;
        };
        var text = definedDom('input',{
            class:'dp-text',
            type:'text',
            onclick:showLis,
            onkeydown :function(e){
                var k = e.keyCode;
                var index = ul.visLis.indexOf(dp._sel||dp.selected);
                if(index===-1)dp._sel=ul.visLis[0];
                act(dp._sel);
                if(k===13){
                    if(dp._sel)dp._sel.click();
                }
                if(k===38){
                    act(ul.visLis[--index]);
                }else if(k===40){
                    act(ul.visLis[++index]);
                }
            },
            oninput:filterLis,
            onfocus:showLis
        });
        var ul = definedDom('ul');
        dp.appendChild(text);
        dp.appendChild(ul);

        var outClick = function(){
            dp.state=0;
        };
        Object.defineProperties(dp,{
            state:{
                get:function(){
                    return this._state;
                },
                set:function(v){
                    var self = this;
                    this._state=v;
                    if(!v){
                    // 关闭
                        [].forEach.call(ul.childNodes,function(li){li.style.maxHeight='0px'});
                        text.value = dp.text;
                        ul.style.opacity=0;
                        setTimeout(function(){
                            ul.style.display='none'
                        },300)
                    }else {
                        act(dp._sel);
                    // 打开
                        if($.__active_dp&&$.__active_dp!==self)$.__active_dp.state=0;
                         $.__active_dp = self;
                        ul.style.display='block';
                        ul.style.opacity=1;
                        ul.visLis=[].filter.call(ul.childNodes,function(li){return li.style.display!=='none'});
                        dp._sel = dp.selected||ul.visLis[0];
                        setTimeout(function(){
                            [].forEach.call(ul.childNodes,function(li){li.style.maxHeight='30px'});
                        },100);
                        $(document.body).off('click',outClick).one('click',outClick);
                    }
                }
            },
            text:{
                get:function(){
                    return text._d&&text._d[dp.vName]||'';
                }
            },
            selectedIndex:{
                get:function(){
                    return [].indexOf.call(ul.childNodes,dp.selected)
                },
                set:function(v){
                    ul.childNodes[v].click();
                }
            },
            value:{
                get:function(){
                    return text._d&&text._d[dp.kName];
                },
                set:function(k){
                    var lis = ul.childNodes;
                    for(var i=0;i<lis.length;i++){
                        var li = lis[i];
                        if(li._d[dp.kName]==k){
                            act(li);
                           return   li.click();
                        }
                    }
                }
            },
            data:{
                get:function(){
                    return this._d;
                },
                set:function(v){
                    dp.selected = undefined;
                    var _k = dp.kName;
                    var _v = dp.vName;
                    if(!v)v=[];
                    delete text._d;
                    ul.innerHTML ='';
                   var ks = Object.keys(v);
                    var data=ks.map(function(k){
                        var d=v[k];
                        var _d={};
                        if(typeof d==='object'){
                            _d= d;
                        }else {
                            _d[_k]=k;
                            _d[_v]=d;
                        }
                        if('function'===typeof dp.handler){
                            dp.handler(_d);
                        }
                        return _d;
                    });
                    // 基于显示数据排序 本地语言比较规则优先
                    data.sort(function(a,b){
                        var compare = function(c){return this>c&&1||this<c&&-1||this==c&&0};
                        return(a&&a[_k]==='')?-1: (''.localeCompare||compare).call(a&&a[_v],b&&b[_v],'zh-Hans-CN',{numeric:true});
                    });

                    ul.innerHTML='';
                    ul.appendChild(definedDom({children:data.map(function(d){
                        return {
                            tag:'li',
                            _d:d,
                            text:d[_v],
                            onmouseenter:function(){
                                act(this);
                            },
                            onclick:function(e){
                                e.preventDefault();
                                e.stopPropagation();
                                dp.selected=this;
                                var old = text._d;
                                text._d =d;
                                text.value = d[_v];
                                dp.state=0;
                                if(!old||old[_k]!==d[_k]||old[_v]!==d[-v]){
                                    if(dp.onchange)dp.onchange();
                                }
                            }
                        }
                    })}));
                    this._d=v;
                    if('function' === typeof this.afterRender){
                        this.afterRender();
                    }
                }
            }
        })
    });
});

/**
 * @function createExtend 更便捷地创建对象继承关系
 *
 * @description
 * Object 对象上添加不可枚举的 createExtend 方法 生成新的继承对象
 *e.g 1.
 *      var a={c:1};
 *      var b = a.createExtend({d:1})
 *      //b -> {c:1,d:1}
 *
 * e.g 2.
 *      var Person = function(){};
 *      var Man = Person.createExtend(
 *          function(name){this.name = name},
 *          {sex:'male'}
 *       );
 *       var m = new Man
 *
 * @param {function} [c] constructor 在原有的constructor 中插入的方法
 * @param {object} [o] 在原有的对象添加属性
 * @param {boolean} [d] true-属性深拷贝 false-属性浅拷贝  默认false
 * */
if(!Object.prototype.createExtend)Object.defineProperties(Object.prototype,{
    createExtend:{
        enumerable:false,
        value:function(c,o,d){
            var skipO =[],skipK=[];
            var copyObject = function(a,b){
                for(var k in a){
                    if(a.hasOwnProperty(k)){
                        var e = a[k];
                        if(skipO.indexOf(e)===-1){
                            if(d===obj&&skipK.indexOf(k)>-1)continue;
                            if(d&&typeof e==='object'){
                                b[k]={};
                                copyObject(e,b[k]);
                            }else{
                                b[k]=e;
                            }
                            skipO.push(e);
                            if(b===obj) skipK.push(k);
                        }
                    }
                }
            };
           var args = Array.prototype.slice.call(arguments,0,2);
            for(var i=args.length;i--;){
                var n = args[i];
                var t = typeof n;
                if(t==='object')o=n;
                else if(t==='function')c=n;
                else if(t==='boolean')d=n;
            }
            c=typeof c!=='object'&&c||o.constructor;
            var obj,that = this;
            if(typeof that === 'function'){
                obj = function(){
                    var x = that.apply(this,arguments);
                    if(typeof c==="function")c.apply(this,arguments);
                    if(x&&o){copyObject(o,x)}
                    return x;
                };
                obj.prototype = Object.create(that.prototype);
                if(o)copyObject(o,obj.prototype);
                obj.prototype.constructor=obj;
            }else if(typeof that==='object'){
                obj={};
                if(o){
                    copyObject(o,obj);
                    copyObject(that,obj)
                }
            }
            return obj;
        }
    }
});

window.jsLang  =top.jsLang;
var cssLoader = function(basePath,cssArray,s){
    document.head.appendChild(definedDom(cssArray.map(function(a){
        return {
            tag : 'link',
            rel:'stylesheet',
            href:basePath+ a.replace(/\.css\s+$/,'')+'.css'+(s&&('?'+s)||'')
        }
    })));
};
/**
 * @function  ajaxWorker( url [, opt , data , dataType , handler] )
 *
 * @description
 *          浏览器后台生成一个Worker来处理Ajax数据
 *          优点：使用的是其他线程 ，提升性能
 *          如果浏览器不支持Worker则退为当前页面Jquery的Ajax处理。
 *          可选参数没有顺序要求
 *  @see Worker资料 {@link https://developer.mozilla.org/zh-CN/docs/Web/API/Worker}
 *
 * @param {string} [url]                       - 请求地址
 * @param {object|string} [opt]         - 如果是object则是整体的配置，如果是{string} 则是请求类型 get|post
 * @param {string} [opt.data]             - 请求包含的数据
 * @param {string} [opt.header]         - 请求头部信息
 * @param {string} [opt.type]             - 请求类型 get|post
 * @param {string} [opt.dataType]    - 返回的数据格式 json|jsonP|xml|text
 * @param {function} [opt.handler]     - 在Worker的js中包装返回的数据
 *
 * @param {string} [data]                   - 请求包含的数据
 * @param {string} [dataType]          - 返回的数据格式 json|jsonP|xml|text
 * @param {function} [handler]           - 在Worker的js中包装返回的数据
 *      参数handler 的方法无法访问window中的对象方法以及document中的对象方法
 *      handler只能是原生js
 *
 * @return {object} Promise对象
 * */
var ajaxWorker = function(url,opt,data , dataType , handler){
    // 参数处理 智能匹配 兼容jq Ajax 配置
    var args = Array.prototype.slice.call(arguments);
    if(typeof url==='object'){
        opt = url;
        args.splice(0,0,undefined);
    }
    if('object'!==typeof opt){
        opt = {};
        var pMap={
            'string':function(a){
                a.replace(/^\s+|\s+$/);
                return /get|post/gi.test(a)&&'type'
                    || /^json|jsonP|xml|text$/gi.test(a)&&'dataType'
                    || /[{|}|\[|\]]/.test(a)&&'data'
                    ||false
            },
            'object':['data'],
            'function':['handler']
        };
        args.slice(1,6).forEach(function(a){
            var c,p;
            c= pMap[typeof a];
            p =typeof c==='function'&&c(a)|| c.splice(0,1)[0];
            if(p)opt[p]=a;
        });
    }
    opt = $.extend({
        url: url,
        type: 'get',
        contentType: /^post$/i.test(opt.type)
            ? 'application/x-www-form-urlencoded;charset=UTF8'
            : 'html/text;charset=UTF8',
        dataType: 'json'
    }, opt);
    //降级 - jquery Ajax 方案
    if(!'Worker' in window){
        var f = opt.handler&&'_'||'';
        opt.dataType = f+opt.dataType;
        if(f){
            var c={converters:{}};
            c[opt.dataType +' '+ opt.dataType] = opt.handler;
            delete opt.handler;
        }
        return $.ajax($.extend(opt,c));
    }
    if(opt.handler){
        opt.handler = Object.toString.call(opt.handler);
    }
    //增强 - web Worker 方案
    var worker = function (opt) {
        var w = new Worker((window.elsBasePath||'')+'js/ajaxWorker.js');
        var def = $.Deferred();
        $.extend(this, def.promise());
        var suc = opt.success, err = opt.error;
        if (suc) {
            delete opt.success;
            this.done(function () {
                suc.apply(this, arguments)
            })
        }
        if (err) {
            delete opt.error;
            this.fail(function () {
                err.apply(this, arguments)
            })
        }
        w.onmessage = function (e) {
            var r = e.data;
            w.onmessage=undefined;
            w.terminate();
            if (r.fail) {
                return def.reject.apply(this, r.fail);
            }
            else if (r.done) {
                return def.resolve.apply(this, r.done);
            }
        };
        w.postMessage(opt);
    };
    return new worker(opt);
};
// 其他浏览器的 DOMParser HTML 类型支持
(function(DOMParser) {
    "use strict";
    var
        proto = DOMParser.prototype
        , nativeParse = proto.parseFromString;
    // Firefox/Opera/IE throw errors on unsupported types
    try {
        // WebKit returns null on unsupported types
        if ((new DOMParser()).parseFromString("", "text/html")) {
            // text/html parsing is natively supported
            return;
        }
    } catch (ex) {}

    proto.parseFromString = function(markup, type) {
        if (/^\s*text\/html\s*(?:;|$)/i.test(type)) {
            var
                doc = document.implementation.createHTMLDocument("")
                ;
            if (markup.toLowerCase().indexOf('<!doctype') > -1) {
                doc.documentElement.innerHTML = markup;
            }
            else {
                doc.body.innerHTML = markup;
            }
            return doc;
        } else {
            return nativeParse.apply(this, arguments);
        }
    };
}(DOMParser));
var
    logisticsMap =[
        {'id':'aae','name':'AAE快递'},{'id':'axd','name':'安信达快递|华企快运'},{'id':'aj','name':'安捷快递'},{'id':'aramex','name':'Aramex'},
        {'id':'anwl','name':'安能物流'},{'id':'bgn','name':'布谷鸟快递'},{'id':'bfdf','name':'百福东方|EES快递'},
        {'id':'bgpyghx','name':'包裹、平邮、挂号信|国内邮政快递|华诚物流'},{'id':'cxwl','name':'传喜物流'},
        {'id':'chengguang','name':'程光快递'},{'id':'coe','name':'COE快递|东方快递'},{'id':'ctwl','name':'长通物流'},
        {'id':'cszx','name':'城市之星物流'},{'id':'cs','name':'城市100快递'},{'id':'chuanzhi','name':'传志快递'},
        {'id':'chengji','name':'城际快递'},{'id':'ddwl','name':'大达物流'},{'id':'debang','name':'德邦物流'},
        {'id':'dhl','name':'DHL快递'},{'id':'dpex','name':'DPEX快递'},{'id':'dsf','name':'递四方速递'},{'id':'dtwl','name':'大田物流'},
        {'id':'dywl','name':'大洋物流'},{'id':'ds','name':'D速快递'},{'id':'ems','name':'EMS快递|E邮宝快递'},
        {'id':'fedex','name':'FEDEX国际快递'},{'id':'fedexcn','name':'FEDEX国内快递|联邦快递'},{'id':'fkd','name':'飞康达快递'},
        {'id':'fbwl','name':'飞邦物流'},{'id':'feibao','name':'飞豹快递'},{'id':'feihu','name':'飞狐快递'},{'id':'feiyang','name':'飞洋快递'},
        {'id':'fengda','name':'丰达快递'},{'id':'fanyu','name':'凡宇快递'},{'id':'guada','name':'冠达快递'},{'id':'guangtong','name':'广通速递'},
        {'id':'gjbg','name':'国际包裹'},{'id':'gtsd','name':'高铁速递'},{'id':'gdems','name':'广东ems快递'},{'id':'gsdwl','name':'共速达物流'},
        {'id':'guotong','name':'国通快递'},{'id':'gznd','name':'港中能达|能达快递'},{'id':'henglu','name':'恒路物流'},{'id':'huiqiang','name':'汇强快递'},
        {'id':'hxlwl','name':'华夏龙物流'},{'id':'hswl','name':'昊盛物流'},{'id':'huaqi','name':'华企快递'},{'id':'huitong','name':'汇通快递'},{'id':'jingdong','name':'京东快递'},
        {'id':'jldt','name':'嘉里大通物流'},{'id':'jywl','name':'佳怡物流'},{'id':'jiaji','name':'佳吉快运'},{'id':'jiayunmei','name':'加运美快递'},
        {'id':'jingguang','name':'京广快递'},{'id':'jinyue','name':'晋越快递'},{'id':'kuaijie','name':'快捷快递'},{'id':'klwl','name':'康力物流'},
        {'id':'kjwl','name':'科捷物流'},{'id':'krwl','name':'宽容物流'},{'id':'lanhu','name':'蓝狐快递'},{'id':'longbang','name':'龙邦快递'},
        {'id':'lianhaotong','name':'联昊通快递'},{'id':'lejiedi','name':'乐捷递快递'},{'id':'lijisong','name':'立即送'},{'id':'minbang','name':'民邦快递'},
        {'id':'minhang','name':'民航快递'},{'id':'meiguo','name':'美国快递'},{'id':'meilong','name':'美龙快递'},{'id':'newl','name':'尼尔物流'},
        {'id':'ocs','name':'OCS快递'},{'id':'pinganda','name':'平安达快递'},{'id':'quanfeng','name':'全峰快递'},{'id':'quanyi','name':'全一快递'},
        {'id':'quanchen','name':'全晨快递'},{'id':'quanritong','name':'全日通快递'},{'id':'rufengda','name':'如风达快递'},{'id':'rrs','name':'日日顺物流'},
        {'id':'shiyun','name':'世运快递'},{'id':'stwl','name':'速通物流'},{'id':'shentong','name':'申通快递|申通E物流'},{'id':'shunfeng','name':'顺丰快递'},
        {'id':'suer','name':'速尔快递'},{'id':'haihong','name':'山东海红快递'},{'id':'santai','name':'三态速递'},{'id':'shenghui','name':'盛辉物流'},
        {'id':'shengfeng','name':'盛丰物流'},{'id':'shengan','name':'圣安物流'},{'id':'saiaodi','name':'赛澳递'},{'id':'tnt','name':'TNT快递'},
        {'id':'thtx','name':'通和天下物流'},{'id':'tcwl','name':'通成物流'},{'id':'tdhy','name':'天地华宇|华宇物流'},{'id':'tiantian','name':'天天快递|海航天天快递'},
        {'id':'ups','name':'UPS国际快递'},{'id':'weibang','name':'伟邦快递'},{'id':'weitepai','name':'微特派快递'},{'id':'wxwl','name':'万象物流'},
        {'id':'wanbo','name':'万博快递'},{'id':'xlyt','name':'祥龙运通'},{'id':'xindan','name':'新蛋物流|奥硕物流'},{'id':'xfwl','name':'信丰物流'},
        {'id':'xinbang','name':'新邦物流'},{'id':'yuantong','name':'圆通快递'},{'id':'yunda','name':'韵达快递'},{'id':'yibang','name':'一邦快递'},
        {'id':'yuntong','name':'运通快递'},{'id':'yzjc','name':'元智捷诚快递'},{'id':'yuanfeihang','name':'原飞航快递'},{'id':'yafeng','name':'亚风快递'},
        {'id':'ycwl','name':'远成物流'},{'id':'yuefeng','name':'越丰快递'},{'id':'yousu','name':'优速快递|UC优速快递'},{'id':'yitongda','name':'易通达'},
        {'id':'yad','name':'源安达快递'},{'id':'yxwl','name':'宇鑫物流'},{'id':'zengyi','name':'增益快递'},{'id':'zhongtong','name':'中通快递'},
        {'id':'zjs','name':'宅急送快递'},{'id':'zhongtie','name':'中铁快运'},{'id':'zhongyou','name':'中邮物流'},{'id':'zmkm','name':'芝麻开门'},
        {'id':'zzjh','name':'郑州建华快递'},{'id':'ztwy','name':'中天万运快递'}
    ],
    fullScreenEls =$(),
    isSupportImage = function (filePath) {
        return ('undefined' != typeof(filePath) && '' != filePath) &&
            ('bmp,png,gif,jpg,jpeg'.indexOf(
                filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase()) >= 0)
    },
    isSupportFile = function (filePath) {
        return ('undefined' != typeof(filePath) && '' != filePath) &&
            ('doc,docx,xls,xlsx,ppt,pptx,txt,sql,pdf'.indexOf(
                filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase()) >= 0)
    },
    /**
     * @method filterDOMString(t,f,type)
     * @param {string} t 要解析的字符串
     * @param {object} f 正则表达式数组 用于过滤
     * @param {boolean} [type] true 返回NodeLis 对象,false 返回字符串
     * @description html字符串解析过滤
     * @return {NodeList | string}
     *
     * 利用 DOMParser 正确的过滤属性
     *
     * */
    filterDOMString = function(t,f,type){
        t=t||'';
        if(!window.DOMParser)return;
        var parser=new DOMParser();
        var d = parser.parseFromString(t,'text/html').body;
        if(typeof f==='string')f=[f];
        if(Array.isArray(f)){
            $(d).find('*').toArray().forEach(function(o){
                var a = Array.apply(null,o.attributes);
                f.forEach(function(t){
                    for(var i=0;i< a.length;i++){
                        if(t.test(a[i].name)){
                            o.removeAttribute(a[i].name);
                            a.splice(i--,1);
                        }
                    }
                })
            })
        }
        if(type)return d.childNodes;
        return d.innerHTML;
    },

    /**
     * createInputFilter 带数据源的下拉过滤选择
     * @param _s 选择器名称 初始化的对象 tag必须是 input
     * @param _d 【可选】数据源 数组对象或者可以解析为数组对象的JSON字符串
     * @param h 【可选】选择器名称 监听该选择器对象的滚动或者鼠标点击事件 触发隐藏
     * @return object jquery对象
     *
     * e.g:
     * var a = createInputFilter('[name="saleOrderNumber"]',logisticsMap)
     * //也可以后面再设置数据 a.setSource( your source)
     */
     createInputFilter = function(_s,_d,h){
        var $t = $(_s),list=definedDom('ul',{
            class:'js-input-filter'
        }),
            init = function(){
                $t.click(showList);
                $t.click(showList);
                $t.on('input propertychange',filter);
                $t.setSource = setSource.bind($t);
                $t.setSource(_d);
                fixPosition();
            },
            showList = function(e){
                e.preventDefault();
                e.stopImmediatePropagation();
                var ofs = $t.offset();
                list.style.top=ofs.top+$t.outerHeight();
                list.style.left=ofs.left;
                list.innerHTML='';
                list.appendChild(definedDom({children: $t.source.map(function(c){
                    return {
                        tag:'li',
                        css:{
                            display:'none'
                        },
                        text: c.name+'('+c.id+')',
                        c_name: c.name,
                        c_id: c.id,
                        onclick : function(e){
                            e.preventDefault();
                            e.stopImmediatePropagation();
                            $t.val(this.c_name+'('+this.c_id+')');
                            hideList();
                        }
                    }
                })}));
                document.body.appendChild(list);
                filter();
                $(list).slideDown(100);
                if(h)$(h).on('scroll  click',hideList);
                $('body').one('scroll  click',hideList);
                $(window).one('scroll  click',hideList);
            },
            hideList = function(){
               setTimeout(function(){
                   if(h)$(h).off('scroll mouseleave click',hideList);
                   $('body').off('scroll mouseleave click',hideList);
                   $(window).off('scroll mouseleave click',hideList);
                   $(list).slideUp(100,function(){
                       list.remove();
                   });
               },5);
            },
            fixPosition = function(){
                var ofs = $t.offset();
                $(list).offset({
                    top : ofs.top+$t.outerHeight(),
                    left:ofs.left
                })
            },
            filter = function(){
                var s =$t.val().replace(/^\s+|\s+/gi,'').toLowerCase();
                $(list).children().each(function(i,l){
                    var $l = $(l);
                    if(s&&$l.text().toLowerCase().indexOf(s)===-1){
                        $l.hide();
                    }else $l.show();
                })
            },
            setSource = function(s){
                if(typeof s ==='string'){
                    try {
                        s = JSON.parse(s);
                    }catch (e){
                        s=[];
                        console.error(e);
                    }
                }
                this.source  =s||[];
            };
        init();
        return $t;
    },
    fullScreenWin = function () {
        document.__fullScreenState = !document.__fullScreenState;
        localStorage.setItem('__fullScreenState', document.__fullScreenState);
        fullScreenEls.trigger('fullScreen');
    },
    makeFullScreen = function (evt) {
        var divObj = evt.target;  //  get the target element
        divObj.objFs = divObj.objFs
            || divObj['requestFullscreen']
            || divObj['msRequestFullscreen']
            || divObj['mozRequestFullScreen']
            || divObj['webkitRequestFullscreen']
            || function () {
                elsDeskTop.fullscreenIE();
            };
        if (document.__fullScreenState)
            divObj.objFs();
        else
            document.cancelDomFs();
    },
    /**
     *  autoSetTitle
     *  自动设置title
     *  @param s1 选择器1 要添加title的对象
     *  @param s2 可选 选择器2 s1的子节点 以该节点内的文字作为title 没有则取s1
     *
     * */
    autoSetTitle = function (s1, s2) {
        $(s1).each(function (i, a) {
            var $a = $(a);
            var $b = s2 && $a.find(s2) || $a;
            a.title = $b.text().replace(/[:： ]+$/, '');
        });
    },
    /**
    *  elsFieldsCheck
    *  对表单内容验证的通用行为封装
    *
    *  使用Promise风格 避免过多回调嵌套
    *  关于Promise 的入门理解请参考：http://www.ruanyifeng.com/blog/2011/08/a_detailed_explanation_of_jquery_deferred_object.html
    *  项目实际应用：WebContent\login\js\fpwd.js
    *
    *
    * e.g
    * var rNewPwd = $(...);
    *
    * //[0-名称,1-非空检查，2-正则检查,3-正则检查提示,4-上下文逻辑检查,5-逻辑检查提示,6-ajax请求检查,7-ajax错误提示]
    * rNewPwd.checkList    = [jsLang.i18n_fpw_confirm_new_password||'确认新密码', 1, 0, 0,
    *      function (v) {
    *			return v === newPwd.val();
    *		}, jsLang.i18n_js_pwd2_not_match||'两次密码不一致'
    *    ];
    *
    * elsFieldsCheck(rNewPwd,$field2,$field3...).done(function(){
    *  console.log(arguments)// arguments - 返回每个字段的Deferred结果  {$el:$f,state:'',data}，{$el:$f,state:'ajax',data}
    *  //检查通过
    *   ....
    * }).fail(function(){
    *  // 检查未通过
    *  ....
    * })
    *
    *
    * */
    elsFieldsCheck = function () {
        var checkField = function ($f, k) {
                var dfd = $.Deferred();
                setTimeout(function () {
                    if (!k || !k.v) {
                        return dfd.reject();
                    }
                    var c = $f.checkList;
                    if (c && c.length) {
                        var v = $f.val();
                        if (c[1]) {
                            // 非空检查
                            if (!v) {
                                if (k && k.v) {
                                    if (k.v)show_err_msg(c[0] + ' ' + (jsLang['i18n_js_can_not_be_empty'] || '不能为空'));
                                    k.v = false;
                                }
                            }
                        }
                        if (k.v && c[2] && c[2].test) {
                            // 正则表达式检查
                            if (!c[2].test(v)) {
                                if (k.v && c[3])show_err_msg(c[0] + c[3]);
                                k.v = false;
                            }
                        }
                        if (k.v && c[4]) {
                            if (!c[4](v)) {
                                if (k.v && c[5])show_err_msg(c[5]);
                                k.v = false;
                            }
                        }
                        if (k.v && c[6]) {
                            // ajax 检查
                            return c[6](v).done(function (data) {
                                dfd.resolve({$el: $f, state: 'ajax', data: data})
                            }).fail(
                                function (data) {
                                    if (k.v && c[7]) {
                                        if (typeof c[7] === 'string')show_err_msg(c[7]);
                                        else if (typeof c[7] === 'function') {
                                            show_err_msg(c[7].call({data: data}));
                                        }
                                    }
                                    k.v = false;
                                    dfd.reject({$el: $f, state: 'ajax', data: data});
                                }
                            )
                        } else {
                            dfd[k.v ? 'resolve' : 'reject']({$el: $f})
                        }
                    } else  dfd.resolve()
                }, 1);
                return dfd.promise();
            },
            fieldsCheck = function (args) {
                var k = {v: true};
                return $.when.apply(this, [].map.call(args, function (a) {
                    return checkField(a, k);
                }))
            };
        return fieldsCheck(arguments);
    },
    elsDeskTop = elsDeskTop || {};
   /**
    *  elsDeskTop.cookie
    *  对cookie 进行存储删除和设置生命周期的操作
    *
    *   elsDeskTop.cookie.map                          - object      cookie 转换为对象
    *   elsDeskTop.cookie.getItem(k)             - function   获取cookie中 k 的值 返回k对应的值
    *   elsDeskTop.cookie.removeItem(k,p)      - function   移除 路径为p 键为k 的cookie  返回 elsDeskTop.cookie
    *   elsDeskTop.cookie.setItem(k,v,t,p)       - function   设置cookie中的k键的值为v 周期为t秒  路径为p 返回elsDeskTop.cookie
   *
   * */
    elsDeskTop.cookie = {
        map : (function(){
            var _c = {};
            document.cookie.split(/;\s*/).forEach(function(a){
                var _a = a.match(/(.+?)=(.+)/);
                if(_a&&_a.length===3&&_a[1]!=='max-age'){
                    _c[_a[1]] = _a[2];
                }
            });
            return _c;
        })(),
        getItem : function(k){
            return this.map[k];
        },
        removeItem : function(k,p){
            p=p||'*';
            delete this.map[k];
            document.cookie = k+'=;max-age=0;path='+p;
            return this;
        },
        setItem : function (k,v,t,p){
            if(!t)t=60*60*24*7;// 默认7天
            this.map[k] = v;
            var  _c =k+'=' + v +';max-age='+t;
            if(p)_c+=';path='+p;
            document.cookie = _c;
            return this;
        }
    };

var
    Base64 = {
    _keyStr: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=', encode: function (e) {
        var t = '';
        var n, r, i, s, o, u, a;
        var f = 0;
        e = Base64._utf8_encode(e);
        while (f < e.length) {
            n = e.charCodeAt(f++);
            r = e.charCodeAt(f++);
            i = e.charCodeAt(f++);
            s = n >> 2;
            o = (n & 3) << 4 | r >> 4;
            u = (r & 15) << 2 | i >> 6;
            a = i & 63;
            if (isNaN(r)) {
                u = a = 64
            } else if (isNaN(i)) {
                a = 64
            }
            t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a)
        }
        return t
    }, decode: function (e) {
        var t = '';
        var n, r, i;
        var s, o, u, a;
        var f = 0;
        e = e.replace(/[^A-Za-z0-9\+\/=]/g, '');
        while (f < e.length) {
            s = this._keyStr.indexOf(e.charAt(f++));
            o = this._keyStr.indexOf(e.charAt(f++));
            u = this._keyStr.indexOf(e.charAt(f++));
            a = this._keyStr.indexOf(e.charAt(f++));
            n = s << 2 | o >> 4;
            r = (o & 15) << 4 | u >> 2;
            i = (u & 3) << 6 | a;
            t = t + String.fromCharCode(n);
            if (u != 64) {
                t = t + String.fromCharCode(r)
            }
            if (a != 64) {
                t = t + String.fromCharCode(i)
            }
        }
        t = Base64._utf8_decode(t);
        return t
    }, _utf8_encode: function (e) {
        e = e.replace(/\r\n/g, '\n');
        var t = '';
        for (var n = 0; n < e.length; n++) {
            var r = e.charCodeAt(n);
            if (r < 128) {
                t += String.fromCharCode(r)
            } else if (r > 127 && r < 2048) {
                t += String.fromCharCode(r >> 6 | 192);
                t += String.fromCharCode(r & 63 | 128)
            } else {
                t += String.fromCharCode(r >> 12 | 224);
                t += String.fromCharCode(r >> 6 & 63 | 128);
                t += String.fromCharCode(r & 63 | 128)
            }
        }
        return t
    }, _utf8_decode: function (e) {
        var t = '';
        var n = 0,c2,c3;
        var r  = c2 = c3=0;
        while (n < e.length) {
            r = e.charCodeAt(n);
            if (r < 128) {
                t += String.fromCharCode(r);
                n++
            } else if (r > 191 && r < 224) {
                c2 = e.charCodeAt(n + 1);
                t += String.fromCharCode((r & 31) << 6 | c2 & 63);
                n += 2
            } else {
                c2 = e.charCodeAt(n + 1);
                c3 = e.charCodeAt(n + 2);
                t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63);
                n += 3
            }
        }
        return t
    }
};
var
    /**
     * Dom工厂
     *
     * @param tag 标签名称 可选 类型 string
     * @param opt 配置 必选 类型 object / function
     * @return Node
     *
     *  definedDom 方法的属性是对dom对象属性直接赋值
     *  1.如果属性非标准属性属性不会生效
     *  2.如果该dom没有该属性，属性赋值成功但不会在文档结构中显示（即$.fn.attr拿不到）
     *  3.通过definedDom构建的对象属性正确获取姿势：
     *     var a= definedDom('li',{name='xx'}) // 生成 <li></li>   注： li 是没有name这个属性的 ,dom对象里只有部分对象有name
     *     a.name === 'xx' // true 正确姿势
     *     a.getAttribute('name') ==='xx'||$(a).attr('name')==='xx'   //false 错误姿势 , 除非原生dom有这个属性 比如id之类的
     *  4.使用了textContent属性 所以不支持ie8 及其以下，文本直接 text:'xxxx'
     *  5. 可以通过ajax回调生成对象，即当传入参数为function类型时候 必须要有[返回值]!!! 不然回调的参数无法添加到生成对象当中
     *  //e.g:
     *  var a = definedDom(function(cb){
     *      $.ajax(url:'xxxx').done(function(data){
     *          cb(data.map(function(d){
     *              //....your code
     *              // d需要转化为 definedDom支持参数，比如 {tag:'',name:'',css:'',children:[]...}
     *          }))
     *          //cb 会执行 definedDom，
      *        //生成的对象会 通过回调 下面返回的对象  然后appendChild
     *      });
     *      return {
     *          tag:'div'       // 要有return
     *      }
     *  })
     *  6. 使用举例
     * //e.g:
     *  var a= definedDom('a',{
     *      children:[{tag:'div'}]
     *      css:{'z-index':100}
     *  })
     *  or:
     *   var a= definedDom({
     *      tag:'a',
     *      children:[{tag:'div'}]
     *      css:{'z-index':100}
     *  })
     *
     *  //return:  <a style="z-index:100"><div></div></a>
     *
     */
    definedDom = function(tag,opt){
        var d,r ={},_func,_children;
        if('function' === typeof arguments[0]){
            var _f = arguments[0];
            var callback = function(a){
                r.dom.appendChild(definedDom(a));
            }.bind(r);
            r.dom=definedDom(_f(callback));
            return r.dom;
        }
        if('object'===typeof arguments[0]){
            opt = arguments[0];
            tag = opt['tag'];
            if(opt&&/^\[object NodeList]$|^\[object Array]$/i.test(Object.prototype.toString.apply(opt))){
                opt={children:opt}
            }
        }else {
            tag = arguments[0];
            opt=arguments[1];
        }
        var _opt={};
        for(var p in opt){
            if(opt.hasOwnProperty(p))
            _opt[p]=opt[p];
        }
        opt = _opt;
        delete opt['tag'];
        if(!tag)d=document.createDocumentFragment();
        else{
            d=document.createElement(tag);
        }
        r.dom = d;
        if(opt.virtualParentNode){
            d.virtualParentNode = opt.virtualParentNode;
            delete opt.virtualParentNode;
        }
        if(undefined!==opt.text){
            d.textContent = opt.text;
            delete  opt.text
        }
        if(opt.func){
           _func = opt.func;
            delete opt.func;
        }
        if(undefined!==opt.html){
            d.innerHTML = opt.html;
            delete opt.html;
        }
        if(opt.class){
            d.className = opt.class;
            delete  opt.class
        }
        if(opt.css && 'object' === typeof opt.css){
            for(var i in opt.css){
                if(opt.css.hasOwnProperty(i)){
                    d.style[i]=opt.css[i];
                }
            }
            delete opt.css;
        }
        if(opt.children){
            if(!/^\[object NodeList]$|^\[object Array]$/i.test(Object.prototype.toString.apply(opt.children))){
                _children=[opt.children];
            }else{
                _children = opt.children
            }
            delete  opt.children;
        }
        for(var o in opt){
            if(opt.hasOwnProperty(o)){
                d[o]=opt[o]
            }
        }
        if(_children){
            if(_children.length){
                var f = document.createDocumentFragment();
                [].forEach.call(_children,function(c){
                    c=c||{};
                    if(!/\[object HTML.*?Element]|\[object Text]/i.test(Object.prototype.toString.apply(c))){
                        c.virtualParentNode = d;
                        c=definedDom(c);
                    }
                    f.appendChild(c);
                });
                d.appendChild(f);
                [].forEach.call(d.children||[],function(c){
                    delete c.virtualParentNode;
                });
            }
        }
        if(_func){
            _func.call(r.dom);
        }
        return d
    },
    /**
     * 获取多语言getI18nAlertMsg
     *
     * @param key i18n 配置的key
     *
     */
    getI18nAlertMsg = function (key) {
        var msg = '';
        $.ajax({
            url: 'rest/I18nService/getResourceByKey/' + key,
            type: 'GET',
            async: false,
            contentType: 'application/json',
            data: '',
            dataType: 'json',
            success: function (data) {
                msg = data.value;
            },
            error: function () {
                alert('系统异常，请检查' + key + '的I18N配置',3);
            }
        });
        return msg;
    },
    GetQueryString = function (name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return (r[2]);
        return r;
    },
    timeStamp2String = function (time, language) {
        var datetime = new Date();
        datetime.setTime(time);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? '0' + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? '0' + datetime.getDate() : datetime.getDate();
        var hour = datetime.getHours() < 10 ? '0' + datetime.getHours() : datetime.getHours();
        var minute = datetime.getMinutes() < 10 ? '0' + datetime.getMinutes() : datetime.getMinutes();
        var second = datetime.getSeconds() < 10 ? '0' + datetime.getSeconds() : datetime.getSeconds();
        var dt = year + '/' + month + '/' + date + ' ' + hour + ':' + minute + ':' + second;
        if (language != 'cn') {
            dt = month + '/' + date + '/' + year + ' ' + hour + ':' + minute + ':' + second;
        }
        return dt;
    },
    showMsg = function (msg) {
        var isIE = !-[1,];
        if (isIE)
            alert(msg);
        else
            $.MsgBox.Alert(jsLang['i18n_js_msg']||'消息', msg);
    },
    setOpacity = function (obj, val) {
        if (document.documentElement.filters) { //IE
            obj.style.filter = 'alpha(opacity=' + val + ')';
        } else {
            obj.style.opacity = val / 100;
        }
    },
    fadeIn = function fadeIn(obj) {
        var thisObj = obj;
        var val = 10;
        var t = setInterval(function () {
            if (val >= 100) {
                clearInterval(t);
            }
            setOpacity(thisObj, val);
            val += 10;
        }, 300);
    },
// 淡出
    fadeOut = function fadeOut(obj) {
        var thisObj = obj;
        var val = 90;
        var t = setInterval(function () {
            if (val <= 0) {
                clearInterval(t);
            }
            setOpacity(thisObj, val);
            val -= 10;
        }, 300);
    },
    fadein = function fadein(ele, opacity, speed) {
        if (ele) {
            var v = ele.style.filter.replace('alpha(opacity=', '').replace(')', '')
                || ele.style.opacity;
            v < 1 && (v = v * 100);
            var count = speed / 1000;
            var avg = count < 2 ? (opacity / count) : (opacity / count - 1);
            var timer = null;
            timer = setInterval(function () {
                if (v < opacity) {
                    v += avg;
                    setOpacity(ele, v);
                } else {
                    clearInterval(timer);
                }
            }, 500);
        }
    },
    fadeout = function (ele, opacity, speed) {
        if (ele) {
            var v = ele.style.filter.replace('alpha(opacity=', '').replace(')', '')
                || ele.style.opacity || 100;
            v < 1 && (v = v * 100);
            var count = speed / 1000;
            var avg = (100 - opacity) / count;
            var timer = null;
            timer = setInterval(function () {
                if (v - avg > opacity) {
                    v -= avg;
                    setOpacity(ele, v);
                } else {
                    clearInterval(timer);
                }
            }, 500);
        }
    },
    /**
     * 剪切文字
     *
     * @param  str - 要剪切的对象
     * @param len - 文字的长度 中文字符算两个长度
     * @return  String 新的字符串
     */
    textClip = function (str, len) {
        str=(str||'').replace(/^\s+|\r+|\n+|\s+$/g,'');
        for (var i = 0; i < len; i++) {
            len -= /[^\x00-\xff]/.test(str[i])
        }
        return str.slice(0, len) + (str.length>len?'...':'')
    },
    /**
     * 传入Iframe窗口数据
     *
     * @param  ifr - iframe Dom对象
     * @param a - 传入的数据
     */
    setIframeData = function (ifr, a) {
        ifr.parentData = a;
        ifr.onparentdataload = ifr.onparentdataload || $.noop;
        ifr.onparentdataload(a);
    },
    /**
     * Iframe页面内获取传入窗口的数据
     * @return 获取到的数据
     */
    getIframeData = function () {
        return (window.frameElement || {}).parentData;
    },
    /**
     *  Iframe页面内监听传入数据
     *
     * @param  func - 数据改变后的回调
     */
    onIframeDataChange = function (func) {
        var f = window.frameElement;
        if (f) {
            /**
             * @param d - 传入iframe的数据
             */
            f.onparentdataload = function (d) {
                func.call(this, d);
            }
        }
    };
/**
 * optionDragBar 侧边栏拖拽
 * init    : 初始化
 * destroy    : 移除
 *
 */
optionDragBar = (function () {
    var
        $win, // 当前窗口
        $body, // 文档body
        $mouseMoveMask, // 鼠标监听遮罩层
        $optionBar, // 右侧收起按钮
        $leftContent, // 左侧窗口
        $rightContent, // 右侧窗口
        lDefaultWidth, // 左侧默认宽度
        rDefaultWidth, // 右侧默认宽度
        dragOriginX = 'N', // 拖动起点
        dragOffsetX = 0, // 拖动横向偏移量
        dragResizeWin = function () {
            $rightContent.width(rDefaultWidth + dragOffsetX + 'px');
            $leftContent.width(lDefaultWidth - dragOffsetX - 4 + 'px');
        },
        onDragMouseMove = function (e) {
            if ('N' === dragOriginX) {
                dragOriginX = e.clientX;
            } else {
                // 边界判断
                var _dragOffsetX = dragOriginX - e.clientX;
                var rw = $rightContent.width();
                if (_dragOffsetX < 720 - rw && _dragOffsetX > 100 - rw) {
                    dragOffsetX = _dragOffsetX;
                    dragResizeWin();
                }
            }
        },
    //鼠标弹起事件
        onDragMouseStop = function () {
            mouseMoveMaskStopListen();
        },
    //鼠标拖动区域判断是否Click
        mouseMoveMaskEventCheck = function () {
            $optionBar.one('mousemove', mouseMoveMaskStartListen);
        },
    //鼠标拖动区域添加监听
        mouseMoveMaskStartListen = function () {
            if (!$optionBar.hasClass('next') || $optionBar[0].toggleState !== 1) {
                lDefaultWidth = lDefaultWidth || $leftContent.width();
                rDefaultWidth = rDefaultWidth || $rightContent.width();
                $mouseMoveMask.on('mousemove', onDragMouseMove);
                $mouseMoveMask.on('mouseup mouseleave', onDragMouseStop);
                $mouseMoveMask.css('z-index', 9999);
            }
        },
    //鼠标拖动区域移除监听
        mouseMoveMaskStopListen = function () {
            $optionBar.off('mousemove', mouseMoveMaskStartListen);
            $mouseMoveMask.off('mousemove', onDragMouseMove);
            $mouseMoveMask.off('mouseup mouseleave', onDragMouseStop);
            $mouseMoveMask.css('z-index', -9999);
        },
        removeAllListen = function () {
            if ($optionBar) {
                $optionBar.off('mousedown', mouseMoveMaskEventCheck);
                $optionBar.off('mousedup', mouseMoveMaskStopListen);
                reInit();
            }
        },
        reInit = function () {
            if ($rightContent) {
                lDefaultWidth = 0;
                rDefaultWidth = 0;
                dragOffsetX = 0;
                dragOriginX = 'N';
                $rightContent.css('width', '');
                $leftContent.css('width', '');
                mouseMoveMaskStopListen();
            }
        },
        initOptionBarDrag = function () {
            $win = $(window);
            $body = $('body');
            $body.find('.mouse-move-mask horizontal').remove();
            $body.append('<div class="mouse-move-mask horizontal"></div>');
            $mouseMoveMask = $('.mouse-move-mask');
            $optionBar = $('.saying-dialog .pre-active');
            $leftContent = $('.pos-relative.public-wrap');
            $rightContent = $('.pos-relative.right-content');
            removeAllListen();
            if ($optionBar.length && $leftContent.length && $rightContent.length) {
                $optionBar.click(reInit);
                //拖动改变列表和发送窗口高度
                $optionBar.on('mousedown', mouseMoveMaskEventCheck);
                $optionBar.on('mousedup', mouseMoveMaskStopListen);
            }
            $win.resize(reInit);
        };
    return {
        disable: removeAllListen,
        active: initOptionBarDrag
    }
}());

Date.prototype.format = function (fmt) { //author: meizz
    var o = {
        'M+': this.getMonth() + 1, //月份
        'd+': this.getDate(), //日
        'h+': this.getHours(), //小时
        'm+': this.getMinutes(), //分
        's+': this.getSeconds(), //秒
        'q+': Math.floor((this.getMonth() + 3) / 3), //季度
        'S': this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    for (var k in o){
        if(o.hasOwnProperty(k)&&new RegExp('(' + k + ')').test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (('00' + o[k]).substr(('' + o[k]).length)));
    }
    return fmt;
};
if (window.$) {
    //Monkey Patch for mmGrid init bug when element is hidden
    var mmGridCallBacks ={};
    if ($.fn.tabs) {
        var _tabs = $.fn.tabs;
        $.fn.tabs = function () {
            var opts = arguments[0] || {};
            var _activate = opts.activate || $.noop;
            opts.activate  = function (e, ui) {
                var tid = ui.newPanel[0].id;
                if(mmGridCallBacks[tid])mmGridCallBacks[tid]();
                return _activate.call(this, e, ui);
            };
            return _tabs.call(this, opts);
        };
        $.extend($.fn.tabs, _tabs);
    }
    if ($.fn.mmGrid) {
        var _mGrid = $.fn.mmGrid;
        $.fn.mmGrid = function () {
            var patchGrid = _mGrid.apply(this, arguments);
            var panel = $(this).parents('.ui-tabs-panel');
            var tabTargetId =panel.attr('id');
            var bbd = patchGrid.$mmGrid.find('a.mmg-btnBackboardDn');
            if(panel.is(':visible'))bbd[0].isFixed =true;
            if(tabTargetId)mmGridCallBacks[tabTargetId]= function () {
                if(bbd[0].isFixed)return;
                bbd .css({'top': patchGrid.$headWrapper.outerHeight(true)}).slideUp('fast');
                patchGrid.resize();
                bbd[0].isFixed =true;
                patchGrid.width(patchGrid.$head.width());
            };
            return patchGrid;
        };
        $.extend($.fn.mmGrid, _mGrid);
    }
    $(function () {
        window.jsLang  =top.jsLang;
        document.cancelDomFs = document['cancelFullScreen']
            || document['msExitFullscreen']
            || document['mozCancelFullScreen']
            || document['webkitCancelFullScreen']
            || function () {
                elsDeskTop.fullscreenIE();
            };
        if(window===top){
            fullScreenEls = $('.fullScreen');
            fullScreenEls.on('fullScreen',makeFullScreen);
        }
        try {
            if(!window.jsLang)jsLang = JSON.parse(localStorage.getItem('bLang'));
        }catch (e){
            console.log(e)
        }
        if(!window.jsLang)window.jsLang={};
        autoSetTitle('.common-box-line .input-and-tip','span');
        autoSetTitle('.personal-box .p-label');

        //if ($.fn.niceScroll) {
        //    var $pw =$('.public-wrap');
        //    $pw.data('nscroll', $pw.niceScroll({
        //        cursorcolor: '#d2d2d2',
        //        cursorwidth: '4px'
        //    }));
        //}
        var $oBar = $('.saying-dialog .option-bar').attr('title',jsLang['i18n_js_open']||'展开');
        var $obar2 = $('<div class="dis-block pos-absolute option-bar2 pre-active next"></div>').attr('title',jsLang['i18n_js_fully_expanded']||'完全展开');
        var obarOnClick = function (e) {
            e.stopPropagation();
            var $t = $(this),
                $s = $('.saying-dialog .right-content'),
                $p = $('.public-wrap');
            if (undefined === this.toggleState) {
                if ($s.hasClass('none-active'))this.toggleState = 0;//0：展开  1：收起(隐藏)  @author jiangzhidong @date 20160817
                else this.toggleState = 0;
            }
            switch (this.toggleState) {
                case 1:
                    $p.addClass('active').removeClass('max');
                    $s.removeClass('none-active max');
                    $t.addClass('next').attr('title',jsLang['i18n_js_ext_win']||'扩展窗口');
                    $obar2.removeClass('next').attr('title',jsLang['i18n_js_min_win']||'最小化窗口');
                    break;
                case 2:
                    $p.addClass('max active');
                    $s.addClass('max').removeClass('none-active');
                    $t.removeClass('next').attr('title',jsLang['i18n_js_shrink_win']||'收缩窗口');
                    $obar2.removeClass('next').attr('title',jsLang['i18n_js_min_win']||'最小化窗口');
                    break;
                case 3:
                    $p.addClass('active').removeClass('max');
                    $s.removeClass('max none-active');
                    $t.removeClass('next').attr('title',jsLang['i18n_js_shrink_win']||'收缩窗口');
                    $obar2.removeClass('next').attr('title',jsLang['i18n_js_min_win']||'最小化窗口');
                    break;
                case 0:
                    $p.removeClass('active max');
                    $s.addClass('none-active').removeClass('max');
                    $t.addClass('next').attr('title',jsLang['i18n_js_expand_win']||'展开窗口');
                    $obar2.addClass('next').attr('title',jsLang['i18n_js_maxsize_win']||'最大化窗口');
                    break;
            }
            //this.toggleState赋值前为1时隐藏
            var hideIndex=this.toggleState;
            console.log(this.toggleState);
            this.toggleState = (this.toggleState + 1) % 4;
            var nsc = $p.data('nscroll');
            if (nsc)nsc.resize();
            //是否暂存窗口初始化的方法
            this.storeInitChat=this.storeInitChat||'';
            if(this.storeInitChat&&hideIndex==1) {
            	this.storeInitChat();
            }
            
        };

        $oBar.before($obar2);
        $oBar.click(obarOnClick.bind($oBar[0]));
        $obar2.click(function (e) {
            e.stopPropagation();
            var toggleState = $oBar[0].toggleState;
            if (toggleState !== 1) {
                $oBar[0].toggleState = 0;
                obarOnClick.call($oBar[0], e);
            } else {
                $oBar[0].toggleState = 2;
                obarOnClick.call($oBar[0], e);
            }
        });
        //全局侧边栏拖动事件初始化
        var ifr = $('iframe'),
            initChatBar = function (e) {
                if (/(pMultiChat\.jsp|multiChat\.jsp|multiChatTest\.jsp)\??/.test(e.target.src)) {
                    optionDragBar.active();
                }
            };
        ifr.load(initChatBar);
    });
    function ableToggleInit() {
    	if($sob[0].toggleState===1 || $sob[0].toggleState===undefined) {
			  return false;
		 } else {
			 return true;
		 }
    }
}
/**
 *自动匹配搜索插件 by fzb
 *使用 $('class').elsAutoLoad(option||'') 
 *需要依赖jq和jq插件niceScroll
 */
(function ($) {
	$.fn.elsAutoLoad = function(options) { 
		var dft = {
				type:'n',
			getDateUrl:'rest/ElsSearchDictionaryService/getFields',
			elsAccount:elsAccount||'',
			tableName:'supplier_main_data',
			fieldName: 'bankCode',
			antoClass:"auto-wrap"
		};
		var ops = $.extend(dft,options);
		$('.'+ops.antoClass).css({"position":"relative","display":"inline-block"});
		var read_only = ops.type=='n'?'':'readonly ';
		var hTxt='<input type="text" '+read_only+'class="auto-load" name="'+ops.fieldName+'" id="'+ops.fieldName+'"/>'
				+'<div class="auto-content"></div>'
				+'<div class="fixed-wrap"></div>';
		$('.'+ops.antoClass).append(hTxt); 
		
		var getArr= [],autoContent='',inpValue='',
		objParams={"elsAccount":ops.elsAccount,"tableName":ops.tableName,"fieldName":ops.fieldName,"fieldValue":""};
		var autoThis=$('.'+ops.antoClass);
		var scrollOption={
			init: function() {
				autoContent = autoThis.find('.auto-content').niceScroll({"cursorcolor":"#ccc"});
			},
			clear: function() {
				autoContent=null;
			}
		};
		scrollOption.init();
		/**
		 * 自动提示数据组装
		 */
		function antoShow(autoArr) {
			if(autoArr && autoArr.length) {
				var fieldStr='';
				$.each(autoArr,function(index, item) {
					var str='<p class="field-item">'+item.fieldValue+'_'+item.fieldValueText+'</p>';
					fieldStr +=str;
				});
				autoThis.find('.auto-content').html(fieldStr).show();
				autoThis.find('.fixed-wrap').show();
				if(!autoContent) {
					scrollOption.init();
				} else {
					autoContent.resize();
				}
				autoThis.find('.auto-content p').click(function(e) {
					autoThis.find('.auto-load').blur();
					inpValue = $(this).text();
					autoThis.find('.auto-load').val(inpValue);
					autoThis.find('.auto-content').hide();
					autoThis.find('.fixed-wrap').hide();
				});
				
				if(autoArr && autoArr.length == 1){
					inpValue = autoThis.find('.auto-content').eq(0).text();
				}
			}
		}
		/**
		 * 获取数据
		 */
		function getData(fieldV) {
			objParams.elsAccount = elsAccount;
			objParams.fieldValue = fieldV;
			$.ajax({
				url         : ops.getDateUrl,
				type        : "POST",
				contentType : "application/json",
				data        : JSON.stringify(objParams),
				dataType    : "json",
				success  : function(data) {
					if(data && data.rows && data.rows.length) {
						getArr=data.rows;
						antoShow(getArr);
					} else {
						autoThis.find('.auto-content').html('').hide();
						autoThis.find('.fixed-wrap').hide();
						getArr = [];
						//autoThis.find('.auto-load').val(inpValue);
					}  
				},
				error : function(data) {
					autoThis.find('.auto-content').html('').hide();
					autoThis.find('.fixed-wrap').hide();
					getArr = [];
					autoThis.find('.auto-load').val(inpValue);
				}
			}); 
		}
		autoThis.find('.auto-load').keyup(function() {
			getData($(this).val());
		});
		autoThis.find('.auto-load').focus(function() {
			getData($(this).val());
		});
		autoThis.find('.auto-load').blur(function() {
			autoThis.find('.auto-load').val(inpValue);
		});
		autoThis.find('.fixed-wrap').click(function() {
			autoThis.find('.auto-content').hide();
			autoThis.find('.auto-load').val(inpValue);
			autoThis.find(this).hide();
		});
	}
})(jQuery);
/**
 * 禁用backspace键返回上一个历史记录
 **/
var _stopIt=function(e){  
    if(e.returnValue){  
       e.returnValue = false ;  
    }  
    if(e.preventDefault ){  
       e.preventDefault();  
    }                 
  
    return false;  
}
document.onkeydown=function(){  
     
        //获取事件对象  
        var elem = event.relatedTarget || event.srcElement || event.target ||event.currentTarget;   
          
        if(event.keyCode==8){//判断按键为backSpace键  
          
                //获取按键按下时光标做指向的element  
                var elem = event.srcElement || event.currentTarget;   
                  
                //判断是否需要阻止按下键盘的事件默认传递  
                var name = elem.nodeName;  
                  
                if(name!='INPUT' && name!='TEXTAREA'){  
                    return _stopIt(event);  
                }  
                var type_e = elem.type.toUpperCase();  
                if(name=='INPUT' && (type_e!='TEXT' && type_e!='TEXTAREA' && type_e!='PASSWORD' && type_e!='FILE')){  
                        return _stopIt(event);  
                }  
                if(name=='INPUT' && (elem.readOnly==true || elem.disabled ==true)){  
                        return _stopIt(event);  
                }  
        }
 }
/**
 * 刷新消息中心和审批列表数字
 */
function refreshNum() {
	$.ajax({
		'cache':false,
		'url':elsBasePath+'rest/MsgService/getMsgCount/' + elsAccount + '/' + elsSubAccount,
		'success': function(data) {
			var msgCount, todoCount;
			msgCount = data['msgCount'] > 99 ? '99+' : data['msgCount'];
			todoCount = data['todoCount'] > 99 ? '99+' : data['todoCount'];
			top.$('#msgManage .icon div.txInfo').text(msgCount);
			top.$('#auditList .icon div.txInfo').text(todoCount);
		},
		'error': function() {
			console.log('getMsgCount error');
		}
	});
}

/**
 * 责任人允许输入且下拉
 */
(function($) {
	var INPUTSELECT= function(el, options) {
		var defOpt= ['item1','item2','item3'];
		this._options= options || defOpt;
		this._$el = $(el);
		this._init();
	}
	INPUTSELECT.prototype= {
			_options:"",
			_$el: "",
			_init: function() {
				var opts = this._options;
				var _th= this;
				var initDom= definedDom({
					'tag':'div',
					"css": {"display":"inline-block","position":"relative"},
					"children":[
					            {
					            	"tag":"input", 
					            	"type":"text",
					            	"class":"store-value",
					            	"css":{"paddingRight": "20px !important"},
					            	"value":opts[0]
					            },
					            {
					            	"tag":"div",
					            	"class":"list-wrap",
					            	"css": {"display":"none","height":"200px","overflow":"auto","position":"absolute","left":"0","right":"0","z-index":"10","border":"solid 1px #ddd","backgroundColor":"#fff"},
					            	"children": opts.map(function(item,index) {
					            		return definedDom({
					            			"tag":"p",
					            			"css": {"margin":0,"paddingLeft":"7px","cursor":"pointer"},
					            			"text": item,
					            			"func": function() {
					            				$(this).hover(function() {
					            					$(this).css({"background-color":"#dfdfdf"})
					            				},function() {
					            					$(this).css({"background-color":"#fff"})
					            				});
					            			}
					            		})
					            	})
					            },
					            {
					            	"tag":"i",
					            	"css": {
					            		"position":"absolute",
					            		"width": 0,
					            		"height": 0,
					            		"borderLeft": "6px solid transparent",
					            		"borderRight": "6px solid transparent",
					            		"borderTop": "6px solid #333",
					            		"right":"6px",
					            		"top": "9px"
					            	}
					            }
					            ]
				});
				this._$el.html(initDom);
				var $inp= this._$el.find(".store-value");
				var $list= this._$el.find('.list-wrap');
				var $p=this._$el.find('.list-wrap p');
				var enableBlur= true;
				$list.hover(function() {
					enableBlur= false;
				},function() {
					enableBlur= true;
				})
				$inp.focus(function() {
					var e= event;
					e.stopPropagation();
					$list.show();
				});
				$p.click(function() {
					var e= event;
					e.stopPropagation();
					var t= $(this).text();
					$inp.val(t);
					$list.hide()
				})
				$inp.blur(function() {
					if(enableBlur) {
						$list.hide();
					}
				})
				
			}
	}
	$.fn.inputSelect= function(opts) {
		var obj= new INPUTSELECT(this, opts);
		return $.extend(true,this, obj);
	}
})(window.jQuery)