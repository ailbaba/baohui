/**
 *  @description
 *  	搭配 common.js 中的 ajaxWorker使用
 *  	详细文档见{@link ajaxWorker}
 *  @function onmessage(e)
 *  @param {event} e
 *  @param {object} e.data 接收的数据
 *  @func postMessage(data)
 *  @param {object} data 返回数据
 * */

var worker = this;
/**
 * @func ajax
 * @desc 原生方法包装ajax请求
 * @param {object} opt 请求配置
 * @param {function} cb 回调方法
 * */
var ajax = function (opt, cb) {
	var xhr = new XMLHttpRequest();
	var url = opt.url;
	if(!/^\w+:\/\//.test(url)){
		url='../'+url;
	}
	xhr.open(opt.type, url, true);
	if(opt.timeout)xhr.timeout=opt.timeout;
	xhr.setRequestHeader('Content-Type', opt.contentType);
	var h = opt.header;
	if (h) {
		for (var o in h) {
			if (h.hasOwnProperty(o))
				xhr.setRequestHeader(o, h[o]);
		}
	}
	xhr.ontimeout = function(){
		debugger;
		cb(xhr)
	};
	xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
			cb(xhr)
		}
	};
	xhr.send(opt.data || null);
};
worker.onmessage = function (e) {
	var opt = e.data, r = {},a,
	handler = function(t){
		var _t = (opt.dataType||'text').toLowerCase();
		var _r ='';
		if('text'===_t){
			_r= t;
		}else if('json'===_t){
			try {
				_r= JSON.parse(t);
			}catch (e){
				r.fail=[null, e.name, e.stack]
			}
		}
		var _h,_d = opt.handler;
		if(_d){
			try {
				_h = eval(_d);
			}catch (e){
				r.fail=[null, e.name, e.stack]
			}
		}
		if('function' === typeof _h){
			a =_h(_r)
		}
		return a||_r;
	};
	ajax(e.data, function (xhr) {
		var t= xhr.responseText;
		if(xhr.status>399||xhr.status<200){
			r.fail =[null,xhr.statusText,t]
		}else {
			r.done = [handler(t),'success']
		}
		worker.postMessage(r);
	});
};