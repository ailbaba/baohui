var colors =[
	"#6B6B6B ","#2a90ff","#a7c0dc",
	"#6cccd2","#b4cde6","#d2d2d4",
	"#cdcdd1","#9aaE94","#90ff94",
	"#a8c1dd","#908E94","#ff908f",
	"#e0e3e9"
];


var imgList = [
		"theme/default/images/wallpaper.jpg",
		"theme/default/images/wallpaper1.jpg",
		"theme/default/images/Pictures/n1.jpg",
		"theme/default/images/Pictures/n2.jpg",
		"theme/default/images/Pictures/n3.jpg",
		"theme/default/images/Pictures/n4.jpg",
		"theme/default/images/Pictures/n5.jpg",
		"theme/default/images/Pictures/n6.jpg",
		"theme/default/images/Pictures/n7.jpg",
		"theme/default/images/Pictures/n8.jpg",
		"theme/default/images/Pictures/n9.jpg",
		"theme/default/images/Pictures/n10.jpg",
		"theme/default/images/Pictures/n11.jpg"
	],

	$bgArea,					$bgSlide,					$controlArrowL,
	$controlArrowR, 		$btnCancel,		$prevBgBox,
	$cValue,						$oValue,						$barColor,
	$barOpacity,				$btnOk,						urlPrefix,
	backInfo,					theme,							$win,
	themeKey,					_slideLength,				_slideIndex,
	$bgList,						_slideStep = 120,		_fileUploader,

	rgba = function(c,o){
		var rgba =(c.replace(/#([0-9a-f])([0-9a-f])([0-9a-f])$/i,'#$1$1$2$2$3$3')
			.match(/([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i)||[]).slice(1)
			.map(function(a){
				return parseInt(a,16);
			});
		if(rgba.length===3)
			return rgba.concat(parseFloat(o));
	},
	imgFac = function(i,c,n){
		return {
			tag : 'img',
			src : urlPrefix + i,
			class : c,
			onclick : function (e){
				e.stopPropagation();
				e.preventDefault();
				setBg(this.src);
				setBarColor(colors[n]);
				$(this).addClass('on').siblings('img.on').removeClass('on');
			}
		}
	},
	loadInfo	= function(){
		$bgSlide.append(definedDom({
			children:imgList.map(function(i,c){
				return imgFac(i,undefined,c);
			})
		}));
		theme = localStorage.getItem(themeKey);
		if(theme){
			try {
				theme = JSON.parse(theme);
			}catch (e){
				console.error(e);
			}
		}
		theme = $.extend({
			cColor 			: '#6B6B6B',
			cOpacity 		: '1',
			bgImg				: top.document.getElementById('wallpaper').getElementsByTagName('img')[0].src
		},theme);
		backInfo = $.extend(true,{},theme);
		setBarColor(backInfo.cColor);
		setBarOpacity(backInfo.cOpacity);
		setBg(backInfo.bgImg);
	},
	recoverInfo = function(){
		if(backInfo) {
			theme = backInfo;
			showChange();
			applyChange();
		}
	},
	fixSliderPosition = function(){
		if(!_slideLength){
			_slideLength = parseInt($bgList.outerWidth()/_slideStep);
			_slideIndex = _slideIndex || 0;
		}
		slideListMove(_slideIndex);
	},
	slideListMove = function(i){
		var max = $bgSlide.children().length-1;
		max = max-_slideLength+max%_slideLength-1;
		if(i>=max){
			i=max;
			$controlArrowR.fadeOut(600);
		}else {
			$controlArrowR.fadeIn(600);
		}
		if(i<=0){
			i=0;
			$controlArrowL.fadeOut(600);
		}else {
			$controlArrowL.fadeIn(600);
		}
		_slideIndex = i;
		$bgSlide.css('left',-1*i*_slideStep+'px');
	},
	slideLeft = function(){
		slideListMove(_slideIndex-_slideLength);
	},
	slideRight = function(){
		slideListMove(_slideIndex+_slideLength);
	},
	setBarColor = function(c){
		if(typeof c === 'object' ||!c){ c =$barColor.val()}
		else $barColor.val(c);
		$cValue.text(c||'#6B6B6B');
		$barColor.css('background',c);
		theme.cColor = c;
		showChange();
	},
	setBarOpacity = function(o){
		if(typeof o === 'object' ||!o){ o =$barOpacity.val()}
		else{
			o = parseFloat(o).toFixed(2)||1;
			$barOpacity.val(o);
		}
		$oValue.text((o*100).toFixed(0)+'%');
		theme.cOpacity = o;
		showChange();
	},
	setBg = function(b){
		if(!b)return;
		theme.bgImg = b;
		$prevBgBox.css('background-image','url('+b+')');
		showChange();
	},
	showChange = function(){
		top.elsDeskTop.wallpaper.updateWallpaper(theme.bgImg);
		top.elsDeskTop.themeSkin.apply('',rgba(theme.cColor,theme.cOpacity));
	},
	applyChange = function(){
		backInfo = $.extend(true,{},theme);
		if(localStorage)localStorage.setItem(themeKey,JSON.stringify(theme));
	},
	initFileUploader = function initFileUploader() {
		if (!_fileUploader) {
			_fileUploader = WebUploader.create({
				swf: urlPrefix + 'jsLib/webuploader/Uploader.swf',
				auto: true,
				server: urlPrefix + 'servlet/UploadServlet',
				pick: '.uploadImageBtn',
				resize: false,
				formData: {
					elsAccount: elsAccount
				}
			});
			_fileUploader.on("fileQueued", function () {
				top.elsDeskTop.showLoading();
			});
			_fileUploader.on('uploadAccept', function (file, res) {
				$.ajax({
					url: basePath + "rest/ElsSubjectService/doElsSubject?elsSubject=" + res.url,
					type: "POST",
					contentType: "application/json",
					dataType: "text"}).done(function(){
						top.elsDeskTop.hideLoading();
						alert(jsLang.i18n_js_upload_done||"上载成功!", 1);
						saveImgFromResponse('/'+fileSystemPath+res.url);
						fixSliderPosition();
						slideListMove(0);
				}).fail(function(){
					alert(jsLang.i18n_js_sys_err||"系统异常!", 3);
				});
			});
			_fileUploader.on('uploadError', function (file) {
				top.elsDeskTop.hideLoading();
				alert(jsLang.i18n_js_sys_err||"系统异常!", 3);
				console.debug('uploadError', file);
			});
		}
	},
	saveImgFromResponse = function(src){
		localStorage.setItem('_uploadBg', src);
		var upImg = $bgSlide.find('.up');
		if (!upImg.length){
			upImg = $(definedDom(imgFac(src,'up')));
			$bgSlide.prepend(upImg);
		}
		upImg.attr('src', src);
	},
	initFileFind = function(){
		$.ajax({
			url: urlPrefix + "rest/ElsSubjectService/findElsSubject",
			type: "POST",
			contentType: "application/json",
			dataType: "text"
		}).done(
			function(data){
				parent.elsDeskTop.hideLoading();
				var fbk1 = data;
				if (fbk1) {
					var pathNum = basePath.lastIndexOf(path);
					var logoPath = basePath.substring(0, pathNum);
					fbk1 = fbk1.substring(fbk1.lastIndexOf(':') + 1);
					var src = logoPath + fbk1;
					saveImgFromResponse(src);
				}
			}
		).fail(
			function(XMLHttpRequest, textStatus, errorThrown){
				parent.elsDeskTop.hideLoading();
				console.log(XMLHttpRequest);
				/*alert(jsLang.i18n_js_sys_err||"系统异常!", 3);*/
				alert(XMLHttpRequest.responseText, 3);
			}
		);
	},
	initTheme = function(){
		themeKey				= 'shinTheme';
		$win						= $(window);
		$bgArea					= $('bgArea');
		$bgSlide					= $('.bgSlide');
		$controlArrowL	= $('.controlArrow.left');
		$controlArrowR	= $('.controlArrow.right');
		$prevBgBox			= $('.prevBgBox');
		$cValue					= $('#cValue');
		$oValue					= $('#oValue');
		$barColor				= $('#barColor');
		$barOpacity			= $('#barOpacity');
		$btnOk					= $('.btnOk');
		$btnCancel				= $('.btnCancel');
		urlPrefix					= basePath;
		$bgList					= $('.bgList');

		frameElement.onIframeClose = recoverInfo;

		$win.resize(fixSliderPosition);
		loadInfo();
		fixSliderPosition();
		initFileUploader();
		initFileFind();
		slideListMove(0);
		$controlArrowL.click(slideLeft);
		$controlArrowR.click(slideRight);
		$btnOk.click(function(){
			applyChange();
			top.elsDeskTop.closeCurWin('skins');
		});
		$btnCancel.click(function(){
			top.elsDeskTop.closeCurWin('skins')
		});
		$barColor.colorpicker({
				hideButton: true
		}).on('input propertychange change',setBarColor);
		$barOpacity.on('input propertychange change',setBarOpacity);

	};
$(function () {
	initTheme();
});