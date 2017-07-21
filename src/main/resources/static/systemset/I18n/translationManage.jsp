<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/login/js/jquery.md5.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="国际化标签自动翻译" key="" /></span>
            <div class="common-box-line">
            	<button id="saveBtn" class="button-wrap"><i18n:I18n defaultValue="保存翻译" key=""/></button>
            </div>
        </div>
		
		<div class="pos-relative">
        	<div style="width:50%;">
        		<div class="box-wrap pos-relative bg-common">
		            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="待翻译" key=""/></span>
		            <div class="common-box-line">
			            <main class="grid-container">
			            	<div class="edit-box-wrap" style="padding-top: 5px;">
			            		<i18n:I18n defaultValue="源语言" key=""/>
			            		<select id="language" name="language" onchange="refreshData();">
									<option value="zh_cn">简体中文</option>
									<option value="en">English</option>
									<option value="zh_tw">繁体中文</option>
								</select>
								<div class="dis-in-b input-and-tip"> 
									<span><i18n:I18n defaultValue="标签" key=""/>:</span>
									<input type="text" id="key" name="key" />
								</div>
								<div class="dis-in-b input-and-tip"> 
									<span><i18n:I18n defaultValue="标签内容" key=""/>:</span>
									<input type="text" id="value" name="value" />
								</div>
				                <button id="queryBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
				            </div>
		                    <div class="grid-100">
		                        <table id="sourceTable"></table>
		                        <div id="sourcePage" style="text-align: right;"></div>
		                    </div>
		               </main>
		            </div>
		    	</div>
        	</div>
        	
	        <div class="pos-absolute" style="width: 50%;right: 0;top: 0;">
		        <div class="box-wrap pos-relative bg-common">
		            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="翻译结果" key=""/></span>
		            <div class="common-box-line">
			            <main class="grid-container">
			            	<div class="edit-box-wrap" style="padding-top: 5px;">
			            		<i18n:I18n defaultValue="目标语言" key=""/>
			            		<select id="toLanguage" name="toLanguage">
									<option value="zh_cn">简体中文</option>
									<option value="en">English</option>
									<option value="zh_tw">繁体中文</option>
								</select>
				                <button id="transBtn" class="button-wrap"><i18n:I18n defaultValue="翻译" key=""/> </button>
				            </div>
		                    <div class="grid-100">
		                        <table id="translateTable"></table>
		                    </div>
		               </main>
		            </div>
	        	</div>
	        </div>
        </div>
		        
    </div>
<script>
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	
	var sourceCols = [
   		    { title:"语言", name:"language" , width:100, align:"center"},
   		    { title:"标签", name:"key" , width:300, align:"left"},
   		    { title:"标签内容", name:"value" , width:500, align:"left"},
   		];
	
	var sourceGrid = $("#sourceTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/I18nService/findI18nKeyContent",
		method :  "POST",
		autoLoad : false,
		height : "500px",
		cols : sourceCols,
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
        checkCol : false,
        indexCol : true,
        plugins : [
   		    $("#sourcePage").mmPaginator({
   		        style : "plain",
   		        totalCountName : "total",
   		        page : 1,
   		        pageParamName : "currentPage",
   		        limitParamName : "pageSize",
   		        limitLabel : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
   		        totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
   		        limit : 500,
   		        limitList : [500,1000,2000]
   		    })
   		]
	});
	
	var changeValue = function(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = ""; 
		}
		return "<input type='text' name='resourceValue' class='resourceValueChange' value='"+val+"' />";
	}
	
	$(".resourceValueChange").live('keyup',function(){
		var resourceValue = $(this).val();
		var rowIndex = $(this).closest("tr").index();
		var rowData = translateGrid.row(rowIndex);
		rowData["value"] = resourceValue;//将值赋给mmgrid对象对应属性
	});
	
	var translateCols = [
			{ title:"语言", name:"language" , width:100, align:"center"},
			{ title:"标签", name:"key" , width:300, align:"left"},
			{ title:"标签内容", name:"value" , width:500, align:"left",renderer:changeValue},
	    ];
	
	var translateGrid = $("#translateTable").mmGrid({
		url : "",
		method :  "POST",
		autoLoad : false,
		height : "500px",
		cols : translateCols,
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
        checkCol : false,
        indexCol : true,
	}); 
	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
		var queryParam = {
			language : "zh_cn",
			currentPage : 1,
			pageSize : 2000
	    };
		//设置params给分页插件使用,若直接使用sourceGrid.load(queryParam)查询,则分页插件调用gird时是无参数的导致分页数据不对
		$.extend(sourceGrid.opts.params,queryParam);
		sourceGrid.load();
	}
	
	$("#queryBtn").click(function(){
		refreshData();
	});
	
	$("#transBtn").click(function(){
		var fromLanguage = $("#language").val();
	    var toLanguage = $("#toLanguage").val();
	    
	    var i18nRows = sourceGrid.rowsLength() == 0 ? [] : sourceGrid.rows();
	    var queryData = "";
	  	//百度翻译API会将整个queryData字符串翻译过来,包括JSON字符串的双引号都会翻译替换掉,不适合传JSON字符串整个翻译
	    for(var i=0;i<i18nRows.length;i++) {
	    	var i18nRecord = i18nRows[i];
	    	queryData += i18nRecord.value+"\n";//换行符分隔要翻译的多个单词或者多段文本
	    }
	    
		var appId = "20160127000009528";
		var key = "0ITqAybPCoMKKdKu_2hT";
		var salt = new Date().getTime();
		var str1 = appId + queryData + salt +key;
		var sign = $.md5(str1);//签名必须为appid+q+salt+密钥 字符串的md5码
		
	    $.ajax({
	        url : "http://api.fanyi.baidu.com/api/trans/vip/translate",
	        type : "POST",
	        dataType : "jsonp",
	        data : {
	            q : queryData,
	            appid : appId,
	            salt : salt,
	            from : getApiLanguage(fromLanguage),
	            to : getApiLanguage(toLanguage),
	            sign : sign
	        },
	        success: function (data) {
	            console.log(data);
	            var trans_result = data.trans_result;//翻译结果
	            /* var src = trans_result[0].src;//原文
	            var dst = trans_result[0].dst;//译文
	            var dstArr = dst.split("\n"); */
	            var dstData = [];
	            for(var i=0;i<i18nRows.length;i++) {
	    	    	var i18nRecord = i18nRows[i];
	    	    	var src = trans_result[i].src;//原文
	    	    	var dst = trans_result[i].dst;//译文
	    	    	var record = {
	    	    			language : toLanguage,	
	    	    			key : i18nRecord.key,
	    	    			value : dst,
	    	    	};
	    	    	dstData.push(record);
	    	    }
	            translateGrid.load(dstData);
	        } 
	    });
	});
	
	$("#saveBtn").click(function(){
		var rows = translateGrid.rows();
		if(typeof(rows) != "undefined" && rows != "[]" && rows != "[undefined]"){
			parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中！' key=''/>");
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/I18nService/saveI18nList",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(rows),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='保存成功' key='i18n_common_alert_savesuccess'/>",1);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='保存出错' key='i18n_common_alert_saveError'/>",3);
				}
			});
		}
	});
	
	function refreshData(){
		var language = $("#language").val();
		var key = $("#key").val();
		var value = $("#value").val();
		var queryParam = {
				language : language,
				key : key,
				value : value,
				currentPage : 1,
				pageSize : 50
		    };
		//设置params给分页插件使用,若直接使用sourceGrid.load(queryParam)查询,则分页插件调用gird时是无参数的导致分页数据错误
		$.extend(sourceGrid.opts.params,queryParam);
		sourceGrid.load();
	}
	
	//语言代码转换
	function getApiLanguage(myLanguage){
		 switch(myLanguage){
	    	case "zh_cn": return "zh";//中文
	    	case "en": return "en";//英语
	    	case "": return "yue";//粤语
	    	case "": return "wyw";//文言文
	    	case "ja": return "jp";//日语
	    	case "ko": return "kor";//韩语
	    	case "fr": return "fra";//法语
	    	case "es": return "spa";//西班牙语
	    	case "th": return "th";//泰语
	    	case "ar": return "ara";//阿拉伯语
	    	case "ru": return "ru";//俄语
	    	case "pt": return "pt";//葡萄牙语
	    	case "de": return "de";//德语
	    	case "it": return "it";//意大利语
	    	case "el": return "el";//希腊语
	    	case "nl": return "nl";//荷兰语
	    	case "pl": return "pl";//波兰语
	    	case "bg": return "bul";//保加利亚语
	    	case "et": return "est";//爱沙尼亚语
	    	case "da": return "dan";//丹麦语
	    	case "fi": return "fin";//芬兰语
	    	case "cs": return "cs";//捷克语
	    	case "ro": return "rom";//罗马尼亚语
	    	case "sl": return "slo";//斯洛文尼亚语
	    	case "sv": return "swe";//瑞典语
	    	case "hu": return "hu";//匈牙利语
	    	case "zh_tw": return "cht";//繁体中文
	    	default : return "en";
	    }
	}
</script>
</body>
</html>