/**
 * Created by fzb on 2016/1/13.
 */
$(function() {
	//获取客户端的语言类别
	window.getClientLanguage= function () {
		var type = navigator.appName;
		if(type=='Netscape') {
			return navigator.language.replace(/-/g,'_').toLowerCase();
		} else {
			return navigator.userLanguage.replace(/-/g,'_').toLowerCase();
		}
	}
	//base-language-多语言
	window.setBaseLanguage= function(options,items,flag) {
		if(!flag) {
			//语言字符处理
			var language = window.getClientLanguage();
			var lang={};
			if(language && language.length) {
				lang.language=language;
				lang.resourceType = 'frontJs';
			}
			$.extend(lang, options);
			$.ajax({
				url: '../rest/I18nService/getAllResource',
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(lang),
				dataType : "json",
				success: function (data) {
					if(data) {
						window.baseLang = data;
						localStorage.setItem('bLang',JSON.stringify(data));
						if(items && items.length) {
							items.forEach(function(txt,i) {
								for(var key in txt) {
									if(key.indexOf('placeholder') != -1) {
										var val = txt[key];
										var t = data[val];
										$(''+key).attr({'placeholder':t });
									}else if(key.indexOf('title') != -1) {
										var val = txt[key];
										var t = data[val];
										$(''+key).attr({'title':t });
									} else {
										var val = txt[key];
										if(val) {
											var t = data[val];
											if(!t)return;
											$(''+key).html(t);
											$(''+key).attr({'title':t.replace(/&nbsp;/g,"")});
										}
									}
								}
							});
						}
						
					} else {
						alert('web server error');
					}
					
				},
				error: function (e) {
				}
			});
		} else {
			var data = {};
			var s =localStorage.getItem('bLang');
			if(!s)return setBaseLanguage(options,items);
			try{
				data=JSON.parse( s|| '{}');
			}catch(e){console.error(e);
			}
			//localStorage.setItem('bLang',data);
			if(items && items.length) {
				items.forEach(function(txt,i) {
					for(var key in txt) {
						if(key.indexOf('placeholder') != -1) {
							var val = txt[key];
							var t = data[val];
							$(''+key).attr({'placeholder':t });
						}else if(key.indexOf('title') != -1) {
							var val = txt[key];
							var t = data[val];
							$(''+key).attr({'title':t });
						} else {
							var val = txt[key];
							if(val) {
								var t = data[val];
								if(!t)return;
								$(''+key).html(t);
								$(''+key).attr({'title':t.replace(/&nbsp;/g,"")});
							}
						}
					}
				});
			}
		}
		
	};
})