<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="biddingBargainManage.jsp"%>
<body>

<script type="text/javascript">

//历史轮次信息
function itemHistoryLoad(){
	
	//加载竞价
    var headParamBak = {
   	'elsAccount':elsAccount,
   	'biddingNumber':biddingNumber
   };
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/getPurchaseBiddingContentItem' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(headParamBak),
		dataType : "json",
		success : function(data) {
			$("#materialSpecification").val(data.materialSpecification);
			$("#quantity").val(data.quantity);
			$("#unitQuantity").val(data.unitQuantity);
			$("#property1").val(data.property1);
			var deliveryDate = data.deliveryDate;
			if (deliveryDate!=null&&deliveryDate.length!=10)
				deliveryDate = new Date(deliveryDate).format("yyyy-MM-dd");
			$("#deliveryDate").val(deliveryDate);
			$("#materialNumber").val(data.materialNumber);
			$("#materialDesc").val(data.materialDesc);
			//当前最低报价
			$(".currentMinPrice").html(data.fbk3);
			$("#currentMinPrice").val(data.fbk3);
			
		},
		error : function(data) {
			alert("加载失败",3);
		}
	});
	
	 //加载竞价
    var fileParam = {
		'elsAccount':elsAccount,
    	'biddingNumber':biddingNumber
	};
	itemHistory = $('#historyTable').mmGrid({
	    cols: cols_history,
	    url: '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryPurchaseBiddingContentOnlinePriceByCondtion',
	    params: fileParam,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    fullWidthRows:true,
	    multiSelect : false,
        checkCol : true,
        indexCol : false,
	    height:250,
        width:730,
	    plugins: [
              $('#onlinePage').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                  , limit: null
                  , limitList: [10,15,20]
              })
          ]
	});
	
	refreshPrice();//开始刷新
};

//列自定义
$("#columnDefineBtn_target_score").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount 
	    		+ "&tableCode=tenderTargetBiddingItem_mt" + "&window=iframeApp_tenderTargetBiddingItem_mt",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	 });
});

//列自定义
$("#columnDefineBtn2").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount 
	    		+ "&tableCode=biddingPurchaseContentItemBak_mt" + "&window=iframeApp_biddingPurchaseContentItemBak_mt",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	 });
});

function refreshPrice(){
	var fileParam = {
			'elsAccount':elsAccount,
	    	'biddingNumber':biddingNumber
		};
	intervalItemHis = setInterval(function() {
		itemHistory.load(fileParam);
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryCurrentMinPrice',
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(fileParam),
			dataType : "json",
			success : function(data) {
				$(".currentMinPrice").html(data.fbk3);
				$("#currentMinPrice").val(data.fbk3);
			/* 	//windows
			 	var path = data.fbk20;
			 	if(path=="") path = "1.jpg";
			 	path = path.substring(path.lastIndexOf(':')+1);
				$("#fbk20").attr("src",path);
				//linux
				//$("#logoImage").attr("src",logoPath+fbk1);   */
				key = data.key || [];
				value = data.value || [];
				bar123();
			}
		});
    }, 5000);
}

// 时间凭借
function toDateAndTime(date,time){
		var arrDate = date.split("-");
		var arrTime = time.split(":");
		return new Date(arrDate[0],arrDate[1]-1,arrDate[2],arrTime[0],arrTime[1],arrTime[2]).format("yyyy-MM-dd hh:mm:ss");
	}
var interval1;
var interval2;
var interval3;

function timerLoad(headParam){
	 clearInterval(interval1);
	 clearInterval(interval2);
	 clearInterval(interval3);
	 $.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/getPurchaseEnquiryBidding',
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(headParam),
			dataType : "json",
			success : function(data) {
				debugger;
				 var currentDate = new Date();
				 var currentRound;//当前轮次
				 var currentRoundDate;//距离最近到时间，结束或者开始
				 var currentFbk2;//当前最少降价幅度
				 var currentFbk3;//当前幅度单位
				 var limitPrices = data.fbk4;//第一轮的采购限价
				 var currentFbk1;
				 var flag;
				 for(var i= 0 ; i < data.biddingRoundItms.length ; i ++){
					 var itemRound = data.biddingRoundItms[i];
					 var beginDate = toDateAndTime(new Date(itemRound.biddingBeginDate).format('yyyy-MM-dd'),itemRound.biddingBeginTime);
					 var endDate = toDateAndTime(new Date(itemRound.biddingEndDate).format('yyyy-MM-dd'),itemRound.biddingEndTime);
					 if(Date.parse(beginDate) <= Date.parse(endDate) && new Date().getTime() <= Date.parse(endDate)){
						 currentRound = itemRound.roundsNumber;
						 currentFbk2 = itemRound.fbk2;//获取当前轮次的降价幅度
						 currentRoundDate = endDate;
						 currentFbk1 = itemRound.fbk1;//获取当前轮次的采购限价
						 currentFbk3 = itemRound.fbk3; //获取当前轮次的幅度单位
						 break;
					 }
					 if(currentDate.getTime() > Date.parse(endDate)){
						 flag = i;
					 }
				 }
				 var dateTime = toDateAndTime(new Date(data.biddingRoundItms[0].biddingBeginDate).format('yyyy-MM-dd'),
						 data.biddingRoundItms[0].biddingBeginTime);
				 if(currentDate.getTime() < Date.parse(dateTime)){
					 $("#currentRound").val("尚未开始");
					 $("#upMinPrice").val(limitPrices);
					 clearInterval(intervalItemHis);
					 var round = data.biddingRoundItms[0];
					 var fbk2 = round.fbk2;
					 if(fbk2){//填写的降价幅度的
						 if(round.fbk3 == "0"){
							 $("#currentFbk2").val(parseInt(fbk2).toFixed(2));
						 }else{
							 var result = limitPrices*fbk2/100.0;
							 $("#currentFbk2").val(result.toFixed(2));
						 }
					 }else{
						 $("#currentFbk2").val("");
					 }
					 
					 var currentRoundDate = toDateAndTime(new Date(data.biddingRoundItms[flag].biddingBeginDate).format('yyyy-MM-dd'),data.biddingRoundItms[0].biddingBeginTime);
					 interval1 = setInterval(function() {
						 var date = new Date();
						 var xj = Date.parse(currentRoundDate) - date.getTime();
						 if(xj<= 10){
							 timerLoad(headParam);
							 refreshPrice();
							 return;
						 }
						 minutes = Math.floor(xj/1000/60);
						 seconds = Math.floor(xj/1000%60);
						 minutes = minutes>=10?minutes:'0'+minutes;
						 seconds = seconds>=10?seconds:'0'+seconds;
						 msg = "距离本次在线竞标开始还有"+minutes+"分"+seconds+"秒";
						 $("#timer").html(msg);
						}, 1000);
				 }else{
					 if(!currentRound){
						 $("#currentRound").val("第"+data.biddingRoundItms[flag].roundsNumber+"轮结束");
						 clearInterval(intervalItemHis);
						 var round = data.biddingRoundItms[flag];
						 var fbk2 = round.fbk2;
						 var fbk1 = round.fbk1;
						 if(fbk2){
							 if(round.fbk3 == "0"){
								 $("#currentFbk2").val(parseInt(fbk2).toFixed(2));
								 if(fbk1){
									 $("#upMinPrice").val(fbk1);
								 }else{
									 for(var i = flag-1 ; i >= 0 ; i -- ){
										 var itemRound = data.biddingRoundItms[i];
										 var fbk1 = itemRound.fbk1;
										 if(fbk1){
											 $("#upMinPrice").val(fbk1);
											 break;
										 }
									 }
								 }
							 }else{
								 if(fbk1){
									 var result = fbk1*fbk2/100.0;
									 $("#currentFbk2").val(result.toFixed(2));
									 $("#upMinPrice").val(fbk1);
								 }else{
									 for(var i = flag-1 ; i >= 0 ; i -- ){//如果当前轮次最低报价数为空，则一次向上轮递推到有最低限价为止
										 var itemRound = data.biddingRoundItms[i];
										 var fbk1 = itemRound.fbk1;
										 if(fbk1){
											 var result = fbk1*fbk2/100.0;
											 $("#currentFbk2").val(result.toFixed(2));
											 $("#upMinPrice").val(fbk1);
											 break;
										 }
									 }
									 
								 }
							 }
						 }else{
							 $("#currentFbk2").val("");
						 }
						 
						 if(flag == data.biddingRoundItms.length-1){
							 $("#timer").html("本次在线竞标已结束！");
							 clearInterval(intervalItemHis);
							 return;
						 }else{
							 var currentRoundDate = toDateAndTime(new Date(data.biddingRoundItms[flag+1].biddingBeginDate).format('yyyy-MM-dd'),data.biddingRoundItms[0].biddingBeginTime);
							 clearInterval(intervalItemHis);
							 interval2 = setInterval(function() {
								 var date = new Date();
								 var xj = Date.parse(currentRoundDate) - date.getTime();
								 if(xj<= 10){
									 timerLoad(headParam);
									 refreshPrice();
									 return;
								 }
								 minutes = Math.floor(xj/1000/60);
								 seconds = Math.floor(xj/1000%60);
								 minutes = minutes>=10?minutes:'0'+minutes;
								 seconds = seconds>=10?seconds:'0'+seconds;
								 msg = "距离下一轮开始还有"+minutes+"分"+seconds+"秒";
								 $("#timer").html(msg);
								}, 1000);
						 }
					 }else{
						 $("#currentRound").val(currentRound);
						 //设置这一轮次的最低限价 也就是上一轮的最低报价--
						 for(var i = flag-1 ; i >= 0 ; i -- ){
							 var itemRound = data.biddingRoundItms[i];
							 var fbk1 = itemRound.fbk1;
							 if(fbk1){
								 $("#upMinPrice").val(fbk1);
								 break;
							 }
						 }
						 if(currentFbk2){
							 if(currentFbk3 == "0"){
								 $("#currentFbk2").val(parseInt(currentFbk2).toFixed(2));
							 }else{
								 if(currentFbk1){
									 var result = currentFbk1*currentFbk2/100.0;
									 $("#currentFbk2").val(result.toFixed(2));
								 }else{
									 for(var i = flag ; i >= 0 ; i -- ){
										 var itemRound = data.biddingRoundItms[i];
										 var fbk1 = itemRound.fbk1;
										 if(fbk1){
											 var result = fbk1*currentFbk2/100.0;
											 $("#currentFbk2").val(result.toFixed(2));
											 break;
										 }
									 }
								 }
							 }
						 }else{
							 $("#currentFbk2").val("");
						 }
						 
						 interval3 = setInterval(function() {
							 var date = new Date();
							 var xj = Date.parse(currentRoundDate) - date.getTime();
							 if(xj<= 10){
								 timerLoad(headParam);
								 clearInterval(intervalItemHis);
								 itemHistory.load(headParam);//一轮结束后刷新报价列表
								 return;
							 }
							 minutes = Math.floor(xj/1000/60);
							 seconds = Math.floor(xj/1000%60);
							 minutes = minutes>=10?minutes:'0'+minutes;
							 seconds = seconds>=10?seconds:'0'+seconds;
							 msg = "距离本轮结束还有"+minutes+"分"+seconds+"秒";
							 $("#timer").html(msg);
							}, 1000);
					 }
				 }
			}
	 });
}

/**************---------招标内容---------**************/

		var biddingDetailContentGrid;
		var biddingStandardGrid;
		var perbiddingItemNumberValue;
		var biddingContentItemStandardArray;
		var biddingQualificationArray;

		var biddingDetailContentItem = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="biddingPurchaseContentItem_mt"/>;
		
		/* var biddingDetailContentItem=[
                {title:'序号',name:'sequenceNumber', width: 120, align: 'center',renderer:function(val,item,rowIndex){
               		return (rowIndex+1)+"<span style='display:none;' id='extendFieldsbdDetail_"+item.biddingItemNumber+"_"+rowIndex+"'>"+item.extendFields+"</span>";
               	}},
              	//{title:'需求类型编码',name:'requirementTypeCode', width : 120, align : 'center',renderer : hiddenRendder},
              	//{title:'需求类型名称',name:'requirementTypeName', width : 120, align : 'center',renderer : hiddenRendder},
               	{ title:'<i18n:I18n key="" defaultValue="方案/设计图纸"/>', name:'attachmentFile' , width:80, align:'center',
               		clickDisable:true,renderer:function(val, item, rowIndex){
               			var viewFlag = false;
               			var extendFields = item.extendFields;
               			if(extendFields){
               				extendFields = JSON.parse(extendFields);
               				var fileList = extendFields.fileList;
               				viewFlag = (fileList && fileList!="");
               			}
               			return '<span class="downloadFile-item" id="downloadFile-1-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
               	}},
        		{ title:'<i18n:I18n key="" defaultValue="图片"/>', name:'attachmentImage' , width:100, align:'center',
               		clickDisable:true,renderer:function(val, item, rowIndex){
               			var viewFlag = false;
               			var extendFields = item.extendFields;
               			if(extendFields){
               				extendFields = JSON.parse(extendFields);
               				var imageList = extendFields.imageList;
               				viewFlag = (imageList && imageList!="");
               			}
               			return '<span class="previewImage-item" id="previewImage-1-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
            		    +'&nbsp;&nbsp;<span class="downloadImage-item" id="downloadImage-1-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        		}},
              	{title:'招标编号',name:'biddingNumber',hidden:true,width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][biddingNumber]' type='hidden'  value='"+$("#biddingNumber").val()+"'/>";
              	}},
              	{title:'标段号',name:'biddingItemNumber', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][biddingItemNumber]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'项目编号',name:'biddingProjectNumber', width: 120, align: 'center',renderer:function(val,item,rowIndex){
              		if(!val || null == val) return '';
              		return val+"<input name='biddingContentItem[][biddingProjectNumber]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'物料编号',name:'materialNumber', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][materialNumber]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'名称描述',name:'materialDesc', width: 400, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][materialDesc]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'型号',name:'materialModel', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][materialModel]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'规格&性能',name:'materialSpecification', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][materialSpecification]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'单位',name:'units', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][units]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'数量',name:'quantity', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][quantity]' type='hidden' onkeyup='value=value.replace(/[^(\\d\\.)]/g,\"\")'  value='"+val+"'/>";
              	}},
              	{title:'目标价',name:'fbk2', width: 120, align: 'center',renderer:function(val){
              		if(!val){
              			val="";
              		}
              		return val+"<input name='biddingContentItem[][fbk2]' type='hidden' value='"+val+"'/>";
              	}},
              	{title:'参考价',name:'fbk3', width: 120, align: 'center',renderer:function(val){
              		if(!val){
              			val="";
              		}
              		return val+"<input name='biddingContentItem[][fbk3]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'交货日期',name:'deliveryDate', width: 120, align: 'center',renderer:function(val){
              		if(val&&val !=""){
              			val = new Date(val).format('yyyy-MM-dd');
              		}else{
              		    val = "";
              	   	}
              		return val; 
              	}},
              	{title:'备注',name:'remark', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentItem[][remark]' type='hidden'  value='"+val+"'/>";
              	}}
       	]; */

		var biddingStandardItem=[
              	{title:'序号',name:'sequenceNumber', width: 120, align: 'center',renderer:function(val,item,rowIndex){
              		return rowIndex+1;
              	}},
            	{title:'招标编号',name:'biddingNumber',hidden:true, width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentStandard[][biddingNumber]' type='hidden'  value='"+$("#biddingNumber").val()+"'/>";
              	}},
              	{title:'标段号',name:'biddingItemNumber', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentStandard[][biddingItemNumber]' type='hidden'  value='"+val+"'/>";
              	}},
                { title:'评分类别编号', name:'scoreTypeCode' ,width:100, align:'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][scoreTypeCode]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},
                { title:'评分类别名称', name:'scoreTypeName' ,width:100, align:'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][scoreTypeName]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},
              	{title:'评分标准编号',name:'standardNumber', width: 100, align: 'center',renderer:function(val,item,rowIndex){
              		return val+"<input name='biddingContentStandard[][standardNumber]' type='hidden' readonly='readonly' value='"+val+"'/>";
              	}},     
              	{title:'评分标准名称',name:'standardName', width: 100, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentStandard[][standardName]' type='hidden' readonly='readonly' value='"+val+"'/>";
              	}},     
              	{title:'权重',name:'ratio', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentStandard[][ratio]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'负责人',name:'person', width: 120, align: 'center',renderer:function(val){
              		return val+"<input name='biddingContentStandard[][person]' type='hidden'  value='"+val+"'/>";
              	}},
              	{title:'具体标准',name:'standardDocument', width: 80, align: 'center',renderer:function(val, item, rowIndex){
              		var text = '<span class="downloadFile-contentItem" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span id="standardDocument_'+item.biddingItemNumber+'_'+rowIndex+'" style="display: none;">'+JSON.stringify(item)+'</span>';
              		return text;
              	}},
                { title:'详细说明', name:'standardDetail' ,width:120, align:'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][standardDetail]' type='text' readonly='readonly' value='"+val+"'/>";
              	}}
        ];
		function hiddenRendder(val,item,index){
			var thisRecord = $(this);
			var colName = thisRecord[0].name;
			if("undefined"==typeof(val) || null == val){
				val = ""; 
			}
			if("requirementTypeCode"==colName || "requirementTypeName"==colName) {
				return val + "<input name='biddingContentItem[]["+colName+"]' type='hidden' value='"+val+"'/>";
			}
		}

//单击招标内容tag页时触发 
$('.sheet-project-one1').click(function() {
	//set标段
	if(biddingDetailContentGrid) {
		biddingDetailContentGrid.resize();
		return;
	}
	var setItemNumberObj = $("#contentBiddingItemNumber");
	if(null != biddingPhasesItems && phaseItemsLen > 0) {
		 setItemNumberObj.empty();
		 var items = $("#form").serializeJSON().biddingPhasesItems;
		 for(var i=0;i<items.length;i++) {
			 setItemNumberObj.append("<option value='"+items[i].biddingItemNumber+"'>"+items[i].biddingItemName+"</option>");
		 }
		 if(!$.isArray(biddingContentItemStandardArray)) {
	 		biddingContentItemStandardArray= new Array(items.length-1);
		 }
	} else {
		 setItemNumberObj.empty();
		 setItemNumberObj.append("<option value='0'>不区分标段</option>");
		 if(!$.isArray(biddingContentItemStandardArray)) {
	 		biddingContentItemStandardArray= new Array(0);
		 }
	}
	//set项目编号
	$("#contentBiddingProjectNumber").val($("#biddingProjectNumber").val());
	/*
	if($("#contentBiddingProjectNumber").val()!="") {
		loadProjectName();
	}
	*/
	$("#contentBiddingItemNumber").val("1");//默认选择标段1
	$("body").data("contentBiddingItemNumber_local","1");
	//招标详细内容
	if(!biddingDetailContentGrid) {
		biddingDetailContentGrid=$('#biddingDetailContentTable').mmGrid({
	        cols: biddingDetailContentItem,
	        loadingText: '正在载入',
	        noDataText: '暂无数据',
	        items: []
	    });
		biddingDetailContentGrid.resize();
	}
	//评标标准内容
	if(!biddingStandardGrid) {
		biddingStandardGrid=$('#biddingStandardTable').mmGrid({
	        cols: biddingStandardItem,
	        loadingText: '正在载入',
	        noDataText: '暂无数据',
	        items: []
	    });
		biddingStandardGrid.resize();
	}
	if(typeof(perbiddingItemNumberValue)=="undefined"){
		perbiddingItemNumberValue=setItemNumberObj.get(0).selectedIndex;
	}
});

$('.downloadFile-evalTempItem').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var itemRow = scoreTargetGrid.row(itemRowIndex);
	var fileList = itemRow.fileList;
	if("undefined"!=typeof(fileList) && fileList.length > 0){
		for(var i=0;i<fileList.length;i++){
			window.open("<%=basePath%>servlet/downloadServlet?filePath="+fileList[i].annexFilePath);
		}
	} else {
		alert("没有文件可下载",2);
	}
});

$('.downloadFile-contentItem').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var itemRow = biddingStandardGrid.row(itemRowIndex);
	var fileList = itemRow.fileList;
	if("undefined"!=typeof(fileList) && fileList.length > 0){
		for(var i=0;i<fileList.length;i++){
			window.open("<%=basePath%>servlet/downloadServlet?filePath="+fileList[i].annexFilePath);
		}
	} else {
		alert("没有文件可下载",2);
	}
});

$("#contentBiddingItemNumber").change(function() {
	var form = $("#form").serializeJSON();
	var biddingContent = form.biddingContent;
	var biddingItemNumber = $("body").data("contentBiddingItemNumber_local");//获取标段---原标段
	biddingContent["biddingItemNumber"]=biddingItemNumber;
	biddingContent["biddingContentItem"]=typeof(form.biddingContentItem)=="undefined"?[]:form.biddingContentItem;
	// 因form无法序列化内容行项目中的JSON扩展字段，需要重新设置
	var contentItemArr = biddingContent["biddingContentItem"];
	for(var bc=0;bc<contentItemArr.length;bc++) {
		biddingContent["biddingContentItem"][bc].extendFields=$("#extendFieldsbdDetail_"+biddingItemNumber+"_"+bc).text();
	}
	biddingContent["biddingContentStandard"]=typeof(form.biddingContentStandard)=="undefined"?[]:form.biddingContentStandard;
	// 重新设置评标下载文件
	var standardArry = biddingContent["biddingContentStandard"];
	for(var bc=0;bc<standardArry.length;bc++) {
		var jsonStandardFile = JSON.parse($("#standardDocument_"+biddingItemNumber+"_"+bc).text()).fileList;
		biddingContent["biddingContentStandard"][bc].fileList = jsonStandardFile;
	}
	biddingContentItemStandardArray[perbiddingItemNumberValue]= biddingContent;
	$("#contentSummary").val("");
	$("#contentBiddingProjectNumber").val($("#biddingProjectNumber").val());
	$("#contentDeliveryStartDate").val("");
	$("#contentDeliveryEndDate").val("");
	$("#contentAddress").val("");
	$("#contentQuality").val("");
	var selectValue = $(this).get(0).selectedIndex;
	perbiddingItemNumberValue=selectValue;
	if("undefined" !=typeof(biddingContentItemStandardArray[selectValue])){
		var setBiddingContent = biddingContentItemStandardArray[selectValue];
		var setBiddingContentItem = setBiddingContent.biddingContentItem;
		var setBiddingContentStandard = setBiddingContent.biddingContentStandard;
		$("#contentSummary").val(setBiddingContent.summary);
		$("#contentBiddingProjectNumber").val(setBiddingContent.biddingProjectNumber);
		$("#contentBiddingProjectName").val(setBiddingContent.biddingProjectName);
		 $("#contentDeliveryStartDate").val(formatDate(setBiddingContent.deliveryStartDate));
		 $("#contentDeliveryEndDate").val(formatDate(setBiddingContent.deliveryEndDate));
		$("#contentAddress").val(setBiddingContent.address);
		$("#contentQuality").val(setBiddingContent.quality);
		biddingDetailContentGrid.load(setBiddingContentItem);
		biddingStandardGrid.load(setBiddingContentStandard);
	}
	$("body").data("contentBiddingItemNumber_local",$(this).val());
}); 

/**************---------供应商报价---------**************/
var biddingContentItemSupplierArray1 ;

// 供应商报价-列自定义  @author jiangzhidong @date 20161216 begin
var item_cols_bak = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="biddingPurchaseContentItemBak_mt"/>;
// 供应商报价-列自定义  @author jiangzhidong @date 20161216 end

//图片
function rendererAttachmentImage(val,item,index){
	var viewFlag = false;
	var extendFields = item.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		viewFlag = (imageList && imageList!="");
	}
	return '<span class="previewImage-item" id="previewImage-3-'+index+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	+'&nbsp;&nbsp;<span class="downloadImage-item" id="downloadImage-3-'+index+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
};

//方案/设计图纸
function rendererAttachmentFile(val,item,index){
	var viewFlag = false;
	var extendFields = item.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var fileList = extendFields.fileList;
		viewFlag = (fileList && fileList!="");
	}
	return '<span class="downloadFile-item" id="downloadFile-3-'+index+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
};

function rendererSupplierPrice(val,item,index){
    var thisRecord = $(this);
    var colName = thisRecord[0].name;
    if("undefined"==typeof(val) || null == val){
        val = ""; 
    }
    if(colName=="fbk5") {
		if(item.fbk5==1) {
			val = "接受";
		} else if(item.fbk5==2) {
			val = "拒绝";
		} else if(item.fbk5==3) {
			val = "中标";
		} else if(item.fbk5==4) {
			val = "未中标";
		} else {
			val = "";
		}
    } else if(colName=="roundsNumber") {
    	val = "第"+val+"轮";
    }
	return val;
};

$(".sheet-project-one2").click(function() {
	loadItem(elsAccount,
			biddingNumber,
			$("#contentBiddingItemNumber2").get(0).selectedIndex,
			$("#contentBiddingItemNumber2").val(),
			$("#contentBiddingRound2").get(0).selectedIndex,
			$("#contentBiddingRound2").val()
	);
});

function loadItem(elsAccount,biddingNumber,biddingItemNumberIndex,biddingItemNumber,biddingRoundIndex,biddingRoundNum) {
	var supplierCurRound = biddingContentItemSupplierArray1[biddingItemNumberIndex].rounds[biddingRoundIndex];
	var biddingItemSupplierVar = supplierCurRound["contentTenderItems"];
	var bdStatusVal = supplierCurRound.biddingStatus;
	var secretVal = supplierCurRound.secret;
	// 供应商报价
	if(!supplierTenderItemGrid)
		supplierTenderItemGrid = $('#table-item').mmGrid({
		        cols: item_cols_bak,
		        height: 500,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: (bdStatusVal<3 && secretVal != 1)? '数据保密中' : '暂无数据',
		        checkCol: false,
		        multiSelect: false,
		        indexCol: true
		    });
	supplierTenderItemGrid.opts.noDataText = (bdStatusVal<3 && secretVal != 1) ? '数据保密中' : '暂无数据';
	if(secretVal == 1){
		biddingItemSupplierVar = [];
		var biddingContentTenderItemParam = {
				'elsAccount' : elsAccount,
				'biddingNumber' : biddingNumber,
				'biddingItemNumber' : biddingItemNumber,
				'roundsNumber' : biddingRoundNum
		};
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryBiddingContentTenderItems' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(biddingContentTenderItemParam),
			dataType : "json",
			success : function(data) {
				var dataRows = data.rows;
				if("undefined"==typeof(dataRows)) {
					dataRows = [];
				}
				biddingItemSupplierVar=dataRows;
				supplierTenderItemGrid.load(dataRows);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
			}
		});
	}else if(bdStatusVal > 2 && "undefined"==typeof(biddingItemSupplierVar)) {
		biddingItemSupplierVar = [];
		var biddingContentTenderItemParam = {
				'elsAccount' : elsAccount,
				'biddingNumber' : biddingNumber,
				'biddingItemNumber' : biddingItemNumber,
				'roundsNumber' : biddingRoundNum
		};
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryBiddingContentTenderItems' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(biddingContentTenderItemParam),
			dataType : "json",
			success : function(data) {
				var dataRows = data.rows;
				if("undefined"==typeof(dataRows)) {
					dataRows = [];
				}
				biddingItemSupplierVar=dataRows;
				supplierTenderItemGrid.load(dataRows);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
			}
		});
	} else {
		supplierTenderItemGrid.load(biddingItemSupplierVar);
	}
	// $("#descriptionArea").val();
}

$("#contentBiddingItemNumber2").live("change",function() {
	var selectValue = $(this).val();
	var selectedIndex = $(this).get(0).selectedIndex;
	var setBiddingContent2 = biddingContentItemSupplierArray1[selectedIndex];
	// 重新加载标段对应的轮次信息
	$("#contentBiddingRound2").empty();
	var biddingRoundss =  setBiddingContent2.rounds;
	for(var is=0;is<biddingRoundss.length;is++) {
		$("#contentBiddingRound2").append("<option value='"+biddingRoundss[is].roundsNumber+"'>第"+biddingRoundss[is].roundsNumber+"轮</option>");
	}
	$("#contentBiddingRound2").val("1");
	$("body").data("contentBiddingRoundNumber_local2",0);
	$("body").data("contentBiddingItemNumber_local2",selectedIndex);
	loadItem(elsAccount,biddingNumber,selectedIndex,selectValue,0,"1");
});

$("#contentBiddingRound2").live("change",function() {
	var selectRoundValue = $(this).val();
	var selectedRoundIndex = $(this).get(0).selectedIndex;
	var selectItemValue = $("#contentBiddingItemNumber2").val();
	var selectedItemIndex = $("#contentBiddingItemNumber2").get(0).selectedIndex;
	$("body").data("contentBiddingRoundNumber_local2",selectedRoundIndex);
	$("body").data("contentBiddingItemNumber_local2",selectedItemIndex);
	loadItem(elsAccount,biddingNumber,selectedItemIndex,selectItemValue,selectedRoundIndex,selectRoundValue);
});

/**************---------供应商报价---------**************/

/**************---------表单文件---------**************/

var file_cols = [
		{ title:'文件名称', name:'fileName' , width:100, align:'center'},
		{ title:'文件路径', name:'filePath', width:100, align:'center'},
		{ title:'文件类型', name:'fileType', width:100, align:'center'},
		{ title:'文件大小', name:'fileSize', width:100, align:'center'},
		{ title:'文件创建方', name:'fileOwner', width:60, hidden:true ,align:'center'},
		{ title:'备注', name:'remark', width:100, align:'center'}
	];

function loadFile() {
	var fileParam = {
		'elsAccount': elsAccount,
		'currentPage': 1,
		'pageSize': 5,
    	'biddingNumber': biddingNumber,
    	'fbk5':0
	};
	if(!editFileTable){
		editFileTable=$('#add-file-project').mmGrid({
		    cols: file_cols,
		    url: '<%=basePath%>rest/PurchaseBiddingService/queryReceiveBiddingFileByCondtion',
		    params: fileParam,
		    method: 'post',
		    root: 'rows',
		    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		    fullWidthRows: true,
		    indexCol: false,
		    plugins: [
	              $('#enquiryFilePage').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
	                  , limit: null
	                  , limitList: [5,10,15,20]
	              })
	          ]
		});
	} else {
		editFileTable.load(fileParam);
	}
	//刷新
	$("#flushFileBtn").click(function() {
		editFileTable.load({});
	});
	//文件下载
	$("#downloadFile").click(function() {
		var selectRows = editFileTable.selectedRows();
		if (selectRows.length > 0) {
			selectRow = selectRows[0];
			var filePath = selectRow.filePath;
		    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
		} else {
			parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
		}
	});
	 //---------------文件展示----begin------------------
    editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
  		previewFile(filePath);
  	});
  	
    function previewFile(filePath){
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var param = {
				elsAccount : elsAccount,
				filePath : filePath
		};
    	
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	} else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
	    	$.ajax({
				url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
				type :"POST",
				data : JSON.stringify(param),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					var resStatus = data.statusCode;
					var message = data.message;
					if("200" == resStatus){
						var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
						var width=$("#file-display").width();
						var height=$("#file-display").height();
						$("#viewerPlaceHolder").css("width",width+"px");  
						$("#viewerPlaceHolder").css("height",height+"px");  
						$("#viewerPlaceHolder").css("display","block" );  
	
						var fp = new FlexPaperViewer(
						            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
						            'viewerPlaceHolder', 
						            {config : {
						                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
						                Scale : 1.5,//初始化缩放比例(1=100%)
						                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
						                ZoomTime : 0.5,//切换缩放比例延迟显示时间
						                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
						                FitPageOnLoad : false,//初始化时自适应页面
						                FitWidthOnLoad : false,//初始化时自适应宽度
						                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
						                ProgressiveLoading : true,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
						                MinZoomSize : 0.2,//最小缩放比例
						                MaxZoomSize : 5,//最大缩放比例
						                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
						                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
						                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
						                ZoomToolsVisible : true,//工具浪是否显示缩放工具
						                NavToolsVisible : true,//工具栏是否显示导航工具
						                CursorToolsVisible : true,//工具栏是否显示光标
						                SearchToolsVisible : true,//工具栏是否显示搜索工具
						                localeChain: 'zh_CN'//地区语言(en_US:English,)
						            	}
						            });
					} else {
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : message});
					}
				},
				error : function(data) {
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
				}
			});
    	} else {
    		parent.elsDeskTop.tip.init({type: 'alert',displayType: 3, message: '<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型!" />'});
    	}
    }
      //---------------文件展示----end------------------
	
}
//回签文件
function loadForm() {
	var fileParam = {
		'elsAccount': elsAccount,
		'currentPage': 1,
		'pageSize': 5,
    	'biddingNumber': biddingNumber,
    	'fbk5':1
	};
	if(!editFormTable){
		editFormTable=$('#add-form-project').mmGrid({
		    cols: file_cols,
		    url: '<%=basePath%>rest/PurchaseBiddingService/queryReceiveBiddingFileByCondtion',
		    params: fileParam,
		    method: 'post',
		    root: 'rows',
		    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		    fullWidthRows: true,
		    indexCol: false,
		    plugins: [
	              $('#enquiryFormPage').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
	                  , limit: null
	                  , limitList: [5,10,15,20]
	              })
	          ]
		});
	} else {
		editFormTable.load(fileParam);
	}
	//刷新
	$("#flushFormBtn").click(function() {
		editFormTable.load({});
	});
	//文件下载
	$("#downloadForm").click(function() {
		var selectRows = editFormTable.selectedRows();
		if (selectRows.length > 0) {
			selectRow = selectRows[0];
			var filePath = selectRow.filePath;
		    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
		} else {
			parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
		}
	});
	 //---------------文件展示----begin------------------
    editFormTable.on('cellSelected', function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
  		previewFile(filePath);
  	});
  	
    function previewFile(filePath){
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var param = {
				elsAccount : elsAccount,
				filePath : filePath
		};
    	
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	} else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
	    	$.ajax({
				url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
				type :"POST",
				data : JSON.stringify(param),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					var resStatus = data.statusCode;
					var message = data.message;
					if("200" == resStatus){
						var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
						var width=$("#file-display").width();
						var height=$("#file-display").height();
						$("#viewerPlaceHolder").css("width",width+"px");  
						$("#viewerPlaceHolder").css("height",height+"px");  
						$("#viewerPlaceHolder").css("display","block" );  
	
						var fp = new FlexPaperViewer(
						            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
						            'viewerPlaceHolder', 
						            {config : {
						                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
						                Scale : 1.5,//初始化缩放比例(1=100%)
						                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
						                ZoomTime : 0.5,//切换缩放比例延迟显示时间
						                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
						                FitPageOnLoad : false,//初始化时自适应页面
						                FitWidthOnLoad : false,//初始化时自适应宽度
						                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
						                ProgressiveLoading : true,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
						                MinZoomSize : 0.2,//最小缩放比例
						                MaxZoomSize : 5,//最大缩放比例
						                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
						                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
						                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
						                ZoomToolsVisible : true,//工具浪是否显示缩放工具
						                NavToolsVisible : true,//工具栏是否显示导航工具
						                CursorToolsVisible : true,//工具栏是否显示光标
						                SearchToolsVisible : true,//工具栏是否显示搜索工具
						                localeChain: 'zh_CN'//地区语言(en_US:English,)
						            	}
						            });
					} else {
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : message});
					}
				},
				error : function(data) {
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
				}
			});
    	} else {
    		parent.elsDeskTop.tip.init({type: 'alert',displayType: 3, message: '<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型!" />'});
    	}
    }
      //---------------文件展示----end------------------
	
}

/**************---------表单文件---------**************/


//加载供应商列表-------------------begin---------------------
var colsSupplie = [
       { title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS账号"/>', name:'supplierAccount' , width:150, align:'center'},
       { title:'<i18n:I18n key="i18n_common_title_suppliername" defaultValue="供应商名称"/>', name:'supplierDesc' , width:280, align:'center'}
   ];

$(".add-supplie-sheet").click(function() {
	 if(!editSupplieTable) {
		 editSupplieTable=$('#add-supplie-project').mmGrid({
            cols: colsSupplie,
            url: "<%=basePath%>rest/PurchaseBiddingService/queryBiddingSupplieList",
            params:{
        		'currentPage': 1,
        		'pageSize': 10,
        		"biddingNumber": biddingNumber,
        		"elsAccount": elsAccount,
        		"biddingItemNumber": $("#contentBiddingItemNumberSYF").val()
        		},
            width : 450,
            method: 'post',
            root: 'rows',
            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
            fullWidthRows:true,
            plugins: [
                      $('#enquirySuppliePage').mmPaginator({
                          style: 'plain'
                          , totalCountName: 'total'
                          , page: 1
                          , pageParamName: 'currentPage'
                          , limitParamName: 'pageSize'
                          , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                          , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                          , limit: null
                          , limitList: [10, 30, 40, 50]
                      })
                  ]
          });
	 } else {
		 editSupplieTable.opts.params = {"elsAccount":elsAccount,"toElsAccount":elsAccount,"biddingNumber": biddingNumber,"biddingItemNumber":$("#contentBiddingItemNumberSYF").val()};
		 editSupplieTable.load();
	 }
});

$("#contentBiddingItemNumberSYF").live("change",function(){
	editSupplieTable.opts.params = {"elsAccount":elsAccount,"toElsAccount":elsAccount,"biddingNumber": biddingNumber,"biddingItemNumber":$("#contentBiddingItemNumberSYF").val()};
	editSupplieTable.load();
});

//加载供应商列表-------------------end---------------------
$(".basic-info-sheet").click(function() {
<%--
	var headParam = {
	    	'elsAccount':elsAccount,
	    	'biddingNumber':biddingNumber
	    };
	$.ajax({
		url : 'basePath/rest/PurchaseEnquiryBiddingService/getPurchaseEnquiryBidding',
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(headParam),
		dataType : "json",
		success : function(data) {
			itemRounds.load(data.purchaseBiddingRounds);
		}
	});
	--%>
});

	var bar123 = function() {
		var fileLocation = 'js/echarts';
		require.config({
			paths : {
				echarts : fileLocation,
				'echarts/chart/line' : fileLocation,
				'echarts/chart/bar' : fileLocation,
				'echarts/chart/pie' : fileLocation
			}
		});

		// 作为入口
		require([ 'echarts', 'echarts/chart/bar' ],
		displayChart
		);
	}

	function displayChart(ec) {
		//柱状图
		var barChart = ec.init(document.getElementById('bar123'));
		var barChartOtion = getBarChartOption();
		barChart.setOption(barChartOtion);
	}

	//获得Bar图的选项和数据
	function getBarChartOption() {
		
		var option = {
			title : {
				text : '最低报价',
				subtext : '单位：轮次',
				fontSize : '10'
			},
			tooltip : {
				show : true,
				trigger : 'item'
			},
			legend : {
				data : [ '' ]
			},
			toolbox : {
				show : true,
				feature : {
					mark : true,
					dataView : {
						readOnly : false
					},
					magicType : [ 'line', 'bar' ],
					restore : true,
					saveAsImage : true
				}
			},
			calculable : true,
			xAxis : [ {
				type : 'category',
				data : key
			} ],
			yAxis : [ {
				type : 'value',
				splitArea : {
					show : true
				}
			} ],
			series : [ {
				name : '最低报价',
				type : 'bar',
				itemStyle : { // 系列级个性化样式，纵向渐变填充
					normal : {
						borderColor : 'red',
						color : (function() {
							var zrColor = require('zrender/tool/color');
							return zrColor.getLinearGradient(0, 350, 0, 250, [
									[ 0, 'green' ], [ 1, 'skyBlue' ] ])
						})(),
						label : {
							show : true,
							textStyle : {
								fontSize : '10',
								color : 'red'
							}
						}
					},
					emphasis : {
						borderWidth : 2,
						borderColor : 'green',
						color : (function() {
							var zrColor = require('zrender/tool/color');
							return zrColor.getLinearGradient(0, 350, 0, 250, [
									[ 0, 'skyBlue' ], [ 1, 'skyBlue' ] ])
						})(),
						label : {
							show : true,
							position : 'top',
							formatter : "{a} {b} {c}",
							textStyle : {
								color : 'blue'
							}
						}
					}
				},
				data : value
			} ]
		};
		return option;
	}
/*--------------评标定标(begin)--------------*/
var scoreTargetGrid;//评分标准
var perbiddingItemNumberValue1 = 0;
var perbiddingRoundNumberValue1 = 0;
var biddingContentItemStandardArray1;
var candidateSupplierGrid;
var tenderTargetGrid;
var scoreTargetItem=[
      	{title:'供应商ELS',name:'supplierAccount', width: 90, align: 'center',renderer:function(val){
      		val = val + "<input name='biddingEvalTargetScoreVOs[][elsAccount]' type='hidden'  value='"+elsAccount+"'/>"
      				  + "<input name='biddingEvalTargetScoreVOs[][toElsAccount]' type='hidden'  value='"+elsAccount+"'/>"
      				  + "<input name='biddingEvalTargetScoreVOs[][supplierAccount]' type='hidden'  value='"+val+"'/>"
      				  + "<input name='biddingEvalTargetScoreVOs[][biddingNumber]' type='hidden'  value='"+biddingNumber+"'/>"
      				  + "<input name='biddingEvalTargetScoreVOs[][biddingItemNumber]' type='hidden'  value='"+$("#contentBiddingItemNumber1").val()+"'/>"
      				  + "<input name='biddingEvalTargetScoreVOs[][roundsNumber]' type='hidden'  value='"+$("#contentBiddingRound").val()+"'/>"
      				  ;
       		return val;
       	}},
       	{title:'供应商名称',name:'supplierDesc', width: 150, align: 'center',renderer:function(val){
       		return val+"<input name='biddingEvalTargetScoreVOs[][supplierDesc]' type='hidden'  value='"+val+"'/>";
       	}},
       	/*
       	{title:'序号',name:'standardNumber', width: 120, align: 'center',renderer:function(val,item,rowIndex){
       		return rowIndex+1;
       	}},
       	*/
        { title:'评分类别编号', name:'scoreTypeCode' ,width:100, align:'center',renderer:function(val,item,index){
        	return val+"<input name='biddingEvalTargetScoreVOs[][scoreTypeCode]' type='hidden' value='"+val+"'/>";
        }},
        { title:'评分类别名称', name:'scoreTypeName' ,width:100, align:'center',renderer:function(val,item,index){
        	return val+"<input name='biddingEvalTargetScoreVOs[][scoreTypeName]' type='hidden' value='"+val+"'/>";
        }},
       	{title:'评分标准编号',name:'scoreModuleCode', width: 100, align: 'center',renderer:function(val,item,index){
       		return val+"<input name='biddingEvalTargetScoreVOs[][scoreModuleCode]' type='hidden' id='evalTargetScoreModuleCode_"+index+"'  value='"+val+"'/>";
       	}},
       	{title:'评分标准名称',name:'scoreModuleName', width: 120, align: 'center',renderer:function(val){
       		return val+"<input name='biddingEvalTargetScoreVOs[][scoreModuleName]' type='hidden'  value='"+val+"'/>";
       	}},
       	{title:'权重',name:'weight', width: 80, align: 'center',renderer:function(val,item,index){
       		val = null==val?"":val;
       		return "<input name='biddingEvalTargetScoreVOs[][weight]' type='text' "
       			+(item["scoreModuleName"]!="" ? " onblur='this.value=toNum(this.value);' readonly='readonly' class='readOnlyFalse' " : " ")
       			+" value='"+val+"' />";
       	}},
       	{title:'得分',name:'score', width: 80, align: 'center',renderer:function(val,item,index){
       		val = null==val?"":val;
       		return "<input id='socreHid"+index+"' name='biddingEvalTargetScoreVOs[][score]' type='text' "
       			+(item["scoreModuleName"]!="" ? " readonly='readonly' class='readOnlyFalse' onblur='blurEdit(this,"+index+");' " : " ")
       			+" value='"+val+"'/>";
       	}},
       	{title:'负责人',name:'principal', width: 100, align: 'center',renderer:function(val,item,index){
       		val = null==val?"":val;
       		return "<input name='biddingEvalTargetScoreVOs[][principal]' type='text' "
       			+(item["scoreModuleName"]!="" ? " readonly='readonly' class='readOnlyFalse' " : " ")
       			+" id='evalScorePrincipal_"+index+"' "
				+" value='"+val+"'/>";
       	}},
      	{title:'具体标准',name:'standardDocument1', width: 80, align: 'center',renderer:function(val, item, rowIndex){
      		var text = '';
      		if(item.fileList)
      			text = '<span class="downloadFile-evalTempItem" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span id="'+$(this)[0].name+'_'+rowIndex+'" style="display: none;">'+JSON.stringify(item)+'</span>';
      		return text;
      	}},
        { title:'详细说明', name:'standardDetail' ,width:150, align:'center',renderer:function(val){
      		return "<input name='biddingEvalTargetScoreVOs[][standardDetail]' type='text' readonly='readonly' value='"+val+"'/>";
      	}}
];

var candidateSupplierItem=[
      	{title:'序号',name:'candidateRank', width: 120, align: 'center',renderer:function(val,item,rowIndex){
      		return (rowIndex+1)+'<input type="hidden" name="biddingCandidateSuppliers[][candidateRank]" value="'+val+'"></input>';
      	}},
    	{title:'推荐供应商ELS',name:'supplierAccount', width: 120, align: 'center',renderer:function(val){
      		val = val + "<input name='biddingCandidateSuppliers[][elsAccount]' type='hidden'  value='"+elsAccount+"'/>"
					  + "<input name='biddingCandidateSuppliers[][toElsAccount]' type='hidden'  value='"+elsAccount+"'/>"
					  + "<input name='biddingCandidateSuppliers[][supplierAccount]' type='hidden'  value='"+val+"'/>"
					  + "<input name='biddingCandidateSuppliers[][biddingNumber]' type='hidden'  value='"+biddingNumber+"'/>"
					  + "<input name='biddingCandidateSuppliers[][biddingItemNumber]' type='hidden'  value='"+$("#contentBiddingItemNumber1").val()+"'/>"
					  + "<input name='biddingCandidateSuppliers[][roundsNumber]' type='hidden'  value='"+$("#contentBiddingRound").val()+"'/>"
			  ;
      		return val;
      	}},
      	{title:'推荐供应商名称',name:'supplierDesc', width: 300, align: 'center',renderer:function(val){
      		return val + "<input name='biddingCandidateSuppliers[][supplierDesc]' type='hidden'  value='"+val+"'/>";
      	}},
      	{title:'总分',name:'sumScore', width: 120, align: 'center',renderer:function(val,item,rowIndex){
      		val = null==val ? '' : val;
      		return '<span id="sumScoreSpn_'+item.supplierAccount+'">'+val+'</span><input type="hidden" id="sumSocreHid_'+item.supplierAccount+'" name="biddingCandidateSuppliers[][sumScore]" value="'+val+'"></input>';
      	}},
      	{title:'推荐简要说明',name:'candidateDesc', width: 220, align: 'center',renderer:function(val,item,rowIndex){
      		val = null==val ? '' : val;
      		return '<input type="text" name="biddingCandidateSuppliers[][candidateDesc]" value="'+val+'"></input>';
      	}},
      	{title:'中标详情',name:'biddingWinDetail', width: 120, align: 'center',renderer : function(val,item,rowIndex) {
      		var text = '<span class="biddingWinDetail" style="color:blue;cursor:pointer;"><i18n:I18n key="test" defaultValue="中标详情" /></span>';
      		return text;
      	}}
];

function checkWinSupplier(obj){
	if($(obj).prop("checked")) {
		obj.value = 1;
	} else {
		obj.value = 0;
	}
};

$('.biddingWinDetail').live("click", function() {
	var rowIndex = $(this).closest("tr").index();
	showBiddingWinList(rowIndex);
});

function showBiddingWinList(rowIndex){
	var itemRow = candidateSupplierGrid.row(rowIndex);
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }

   	var testIframeData = [];
   	testIframeData["toElsAccount"]=itemRow.supplierAccount;
   	testIframeData["elsAccount"]=itemRow.elsAccount;
   	testIframeData["biddingNumber"]=itemRow.biddingNumber;
   	testIframeData["biddingItemNumber"]=itemRow.biddingItemNumber;
   	testIframeData["roundsNumber"]=itemRow.roundsNumber;
   	testIframeData["fbk1"]=$("body").data("cur_item_total_round")+'';
	parent.elsDeskTop.closeCurWin('BiddingTenderWinList');
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'BiddingTenderWinList',
        'windowTitle':'<i18n:I18n key="test" defaultValue="中标详情"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>biddingmanage/purchase/biddingTenderDetail.jsp?frameAppId=PurchaseBiddingBargainDetail',
        'showAdv': false,
 	   	'mask' : true,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop",
        'data':testIframeData
    });
}

var tenderTargetItem = [
     	{title:'操作',name:'operScoreTarget', width: 120, align: 'center',renderer : initScoreTargetSelected},
     	{title:'结果',name:'result', width: 80, align: 'center',renderer: initScoreTargetSelected},
     	{title:'供应商ELS',name:'toElsAccount', width: 120, align: 'center', renderer : initScoreTargetSelected},
     	{title:'供应商名称',name:'supplierDesc', width: 200, align: 'center', renderer : initScoreTargetSelected},
     	{ title:'项目编号' , name:'biddingProjectNumber', hidden:true, width: 80, align:'center'},
     	{ title:'招标内容行号' , name:'biddingContentItemNumber', width: 80, align:'center'},
       	{ title:'<i18n:I18n key="" defaultValue="方案/设计图纸"/>',hidden:true, name:'attachmentFile' , width:80, align:'center',
       		clickDisable:true,renderer:function(val, item, rowIndex){
       			var viewFlag = false;
       			var extendFields = item.extendFields;
       			if(extendFields){
       				extendFields = JSON.parse(extendFields);
       				var fileList = extendFields.fileList;
       				viewFlag = (fileList && fileList!="");
       			}
       			return '<span class="downloadFile-item" id="downloadFile-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
       	}},
		{ title:'<i18n:I18n key="" defaultValue="图片"/>',hidden:true, name:'attachmentImage' , width:100, align:'center',
       		clickDisable:true,renderer:function(val, item, rowIndex){
       			var viewFlag = false;
       			var extendFields = item.extendFields;
       			if(extendFields){
       				extendFields = JSON.parse(extendFields);
       				var imageList = extendFields.imageList;
       				viewFlag = (imageList && imageList!="");
       			}
       			return '<span class="previewImage-item" id="previewImage-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
    		    +'&nbsp;&nbsp;<span class="downloadImage-item" id="downloadImage-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		}},
     	{ title:'物料编号', name:'materialNumber' ,width:80, align:'center'},
     	{ title:'物料描述', name:'materialDesc' ,width:400, align:'center'},
     	{ title:'型号' , name:'materialModel' ,width:100, align:'center'},
     	{ title:'规格&性能', name:'materialSpecification', width: 80, align: 'center'},
     	{ title:'数量', name:'quantity' ,width:100, align:'center'},
     	{ title:'数量单位', name:'units', width: 70, align: 'center'},
     	{ title:'报价', name:'priceIncludingVat' ,width:100, align:'center',renderer : function(val, item, rowIndex) {
     		if(item.fbk1=='1'){
       		   return "不报价";
       	   	}else{
       	   		return val;
       	   	}
     	}},
     	{ title:'金额', name:'amount', width: 70, align: 'center',renderer : function(val, item, rowIndex) {
     		if(item.fbk1=='1'){
       		   return "不报价";
       	   	}else{
       	   		return val;
       	   	}
     	}},
     	{ title:'目标价', name:'fbk2' ,width:100, align:'center'},
     	{ title:'目标金额', name:'fbk8' ,width:100, align:'center'},
     	{ title:'参考价', name:'fbk2' ,width:100, align:'center'},
     	{ title:'参考金额', name:'fbk8' ,width:100, align:'center'},
     	{ title:'完成日期', name:'deliveryDate' ,width:160, align:'center',renderer: formatDate },
     	{ title:'备注', name:'remark', width: 200, align: 'center'}
];

var tenderTargetBiddingItem = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="tenderTargetBiddingItem_mt"/>;

function tenderItemBidddingFbk7(val, item, rowIndex) {
	return toNum(val).toFixed(2); 
}

function tenderItemBidddingInput(val,item,index) {

    var thisRecord = $(this);
    var colName = thisRecord[0].name;
    if("undefined"==typeof(val) || null == val || "null" == val){
        val = ''; 
    }
	if("fbk7"==colName) {
		if(item.roundsNumber == $("body").data("cur_item_total_round")) {
			val = toNum(val).toFixed(2); 
			if($("body").data("cur_item_round_biddingStatus")==3) {
				return '<span style="display: none;"></span><input type="text" id="tenderFbk7Inp_'+index+'" name="biddingTenderContentItems[]['+colName+']" onfocus="tenderItemTargetFbk7Focus(this);" onblur="tenderItemTargetFbk7Blur(this,'+index+',1);" value="'+val+'" />'
					+ '<span style="display: none;">'+JSON.stringify(item)+'</span>';
			} else {
				return val;
			}
		} else {
			val = '';
		}
	}
	return val;
}

function tenderItemTargetFbk7Focus(obj) {
	$(obj).prev().html(obj.value);
}

function tenderItemTargetFbk7Blur(obj,indexVal,updType) {
	var val = obj.value;
   	if(toNum(val) > 0 && toNum(val) <= 100) {
   		if(updType == 1) {
	   		var oldStartFbk7Val = $(obj).prev().text();
	   		if(oldStartFbk7Val==obj.value) {
	   			return;
	   		}
   		}
   		parent.elsDeskTop.showLoading();
   		obj.value = toNum(val).toFixed(2);
   		var biddingTenderItemFbk7Tmp = JSON.parse($(obj).next().text());
   		biddingTenderItemFbk7Tmp["fbk7"] = obj.value;
   		biddingTenderItemFbk7Tmp["fbk5"] = $("#biddingTenderContentStatus_"+indexVal).val()+'';
   		var paramTenderItemObj ={
	    	'elsAccount': biddingTenderItemFbk7Tmp.elsAccount,
	    	'toElsAccount': biddingTenderItemFbk7Tmp.toElsAccount,
	    	'biddingNumber': biddingTenderItemFbk7Tmp.biddingNumber,
	    	'biddingItemNumber': biddingTenderItemFbk7Tmp.biddingItemNumber,
	    	'biddingContentItemNumber': biddingTenderItemFbk7Tmp.biddingContentItemNumber,
	    	'roundsNumber': biddingTenderItemFbk7Tmp.roundsNumber,
	    	'fbk7': obj.value,
	    	'fbk5': biddingTenderItemFbk7Tmp.fbk5,
		};
   		$.ajax({
			url :"<%=basePath%>rest/PurchaseBiddingService/tenderBidCentOne",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(biddingTenderItemFbk7Tmp),
			success : function(data) {
				if(data.statusCode == "-100") {
					alert(data.message,3);
				} else if(data.statusCode == "-300") {
					alert('该物料中标份额总和不能超过100!',3);
					$(obj).val(0);
					$(obj).focus();
				} else {
					if(null!=data.lastWonBidQute && data.lastWonBidQute!='0.00') {
						alert('剩余中标份额：'+data.lastWonBidQute,2);
					}
				}
				var targetGridDataObj = biddingContentItemStandardArray1[$("#contentBiddingItemNumber1").get(0).selectedIndex]["biddingRounds"][$("#contentBiddingRound").get(0).selectedIndex]["tenderTargetGridRows"];
				targetGridDataObj[indexVal]["fbk7"] = obj.value;
			},complete : function(data) {
				parent.elsDeskTop.hideLoading();
			}
		});
   	} else {
    	obj.value='';
    }
   	// 
}

function initScoreTargetSelected(val,item,index) {
    var thisRecord = $(this);
    var colName = thisRecord[0].name;
    if("undefined"==typeof(val) || null == val){
        val = ""; 
    }
	if("toElsAccount"==colName || "operScoreTarget"==colName || "supplierDesc"==colName || "result"==colName) {
		if(item.priceIncludingVat && item.priceIncludingVat != null && item.priceIncludingVat != "0"){
			val = val + setScoreTargetGridCol(colName,item,index);
		}else{
			val = '';
		}
	}
	return val;
};

function setScoreTargetGridCol(colName,item,index) {
	var hiddenVal = '';
	if("operScoreTarget"==colName) {
		if(item.roundsNumber==$("body").data("cur_item_total_round")) {
	    	hiddenVal = '<div style="text-align:left;min-width: 160px; margin:0 auto;">'
				+'<input type="radio" name="'+colName+'_'+index+'" '+(item.fbk5==3 ? 'checked' : '')+' value="3" onclick="clickTenderStatus(this,'+index+');" class="radio-class" style="width: 14px !important;height: 14px !important; display:inline-block; margin-left:5px !important;" />'
				+'<label style="display:inline-block; margin-left:5px; font-size:12px;">中标</label>'
				+'<input type="radio" name="'+colName+'_'+index+'" '+(item.fbk5==4 ? 'checked' : '')+' value="4" onclick="clickTenderStatus(this,'+index+');" class="radio-class" style="width: 14px !important;height: 14px !important; margin-left: 5px !important;display:inline-block;" />'
				+'<label style="display:inline-block; margin-left:5px; font-size:12px;">未中标</label>'
				+ '<input type="hidden" id="biddingTenderContentStatus_'+index+'" name="biddingTenderContentItems[][fbk5]" value="'+nullStrReplace(item.fbk5)+'">'
				+'</div>';
		} else {
			if($("body").data("cur_item_round_autoBargain")==0) {
				hiddenVal = '';
			} else {
    			hiddenVal = '<div style="text-align:left;min-width: 160px; margin:0 auto;">'
					+'<input type="radio" name="'+colName+'_'+index+'" '+(item.fbk5==1 ? 'checked' : '')+' value="1" onchange="changeTenderStatus(this,'+index+');" class="radio-class" style="width: 14px !important;height: 14px !important; display:inline-block; margin-left:5px !important;" />'
					+'<label style="display:inline-block; margin-left:5px; font-size:12px;">接受</label>'
					+'<input type="radio" name="'+colName+'_'+index+'" '+(item.fbk5==2 ? 'checked' : '')+' value="2" onchange="changeTenderStatus(this,'+index+');" class="radio-class" style="width: 14px !important;height: 14px !important; margin-left: 5px !important;display:inline-block;" />'
					+'<label style="display:inline-block; margin-left:5px; font-size:12px;">拒绝</label>'
					+ '<input type="hidden" id="biddingTenderContentStatus_'+index+'" name="biddingTenderContentItems[][fbk5]" value="'+nullStrReplace(item.fbk5)+'">'
					+'</div>';
			}
		}
	}
    if("toElsAccount"==colName) {
    	hiddenVal  =  '<input type="hidden" name="biddingTenderContentItems[][toElsAccount]" value="'+item.toElsAccount+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][elsAccount]" value="'+item.elsAccount+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][biddingNumber]" value="'+item.biddingNumber+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][biddingItemNumber]" value="'+item.biddingItemNumber+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][roundsNumber]" value="'+item.roundsNumber+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][biddingProjectNumber]" value="'+nullStrReplace(item.biddingProjectNumber)+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][biddingContentItemNumber]" value="'+item.biddingContentItemNumber+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][priceIncludingVat]" value="'+item.priceIncludingVat+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][fbk2]" value="'+item.fbk2+'">'
		    		+ '<input type="hidden" name="biddingTenderContentItems[][quantity]" value="'+item.quantity+'">'
		    		;
	}
    if("result"==colName) {
    	if(item.roundsNumber==$("body").data("cur_item_total_round")) {
	    	if(item.fbk5==3) {
	 			val = "<span id='tenderTargetOperRestId_"+index+"'>中标</span>";
	 		} else if(item.fbk5==4) {
	 			val = "<span id='tenderTargetOperRestId_"+index+"'>未中标</span>";
	 		} else {
	 			val = "<span id='tenderTargetOperRestId_"+index+"'></span>";
	 		}
    	} else {
			if($("body").data("cur_item_round_autoBargain")==0) {
				return '';
			}
	    	if(item.fbk5==1) {
	 			val = "<span id='tenderTargetOperRestId_"+index+"'>接受</span>";
	 		} else if(item.fbk5==2) {
	 			val = "<span id='tenderTargetOperRestId_"+index+"'>拒绝</span>";
	 		} else {
	 			val = "<span id='tenderTargetOperRestId_"+index+"'></span>";
	 		}
    	}
   		return val;
    }
    return hiddenVal;
}

function nullStrReplace(nullStrObj) {
	var anullStrObj = '';
	if("undefined" != typeof(nullStrObj)
			&& null != nullStrObj
			&& $.trim(nullStrObj).tolocaleLowerCase != "null") {
		anullStrObj = $.trim(nullStrObj);
	}
	return anullStrObj;
}

// 点击中标不中标按钮
function clickTenderStatus(obj,index) {
	var fbk7InpVar = $('#tenderFbk7Inp_'+index);
	var objValVar = obj.value;
	if((objValVar==3 || objValVar==4) ) {
		var targetGridDataObj = biddingContentItemStandardArray1[$("#contentBiddingItemNumber1").get(0).selectedIndex]
			["biddingRounds"][$("#contentBiddingRound").get(0).selectedIndex]["tenderTargetGridRows"];
		targetGridDataObj[index]["fbk5"] = obj.value;
		$("#biddingTenderContentStatus_"+index).val(obj.value);
		$("#tenderTargetOperRestId_"+index).html($(obj).next().html());
		if(typeof(fbk7InpVar.val())=="undefined") {
			var targetGridDataObj = biddingContentItemStandardArray1[$("#contentBiddingItemNumber1").get(0).selectedIndex]
				["biddingRounds"][$("#contentBiddingRound").get(0).selectedIndex]["tenderTargetGridRows"];
			targetGridDataObj[index]["fbk5"] = obj.value;
			if(toNum(targetGridDataObj[index]["fbk7"])) {
				$("#biddingTenderContentStatus_"+index).val(obj.value);
				tenderItemTargetFbk7Blur($("#tenderFbk7Inp_"+index).get(0),index,2);
			}
		}
		if(toNum(fbk7InpVar.val()) > 0)  {
			$("#biddingTenderContentStatus_"+index).val(obj.value);
			tenderItemTargetFbk7Blur($("#tenderFbk7Inp_"+index).get(0),index,2);
		}
	}
	if(objValVar==4) {
		$("#tenderFbk7Inp_"+index).val("");
		$("#tenderFbk7Inp_"+index).attr("readonly",true);
	}
	if(objValVar==3) {
		$("#tenderFbk7Inp_"+index).attr("readonly",false);
	}
}

function changeTenderStatus(obj,index) {
	var targetGridDataObj = biddingContentItemStandardArray1[$("#contentBiddingItemNumber1").get(0).selectedIndex]
		["biddingRounds"][$("#contentBiddingRound").get(0).selectedIndex]["tenderTargetGridRows"];
	targetGridDataObj[index]["fbk5"] = obj.value;
	$("#biddingTenderContentStatus_"+index).val(obj.value);
	$("#tenderTargetOperRestId_"+index).html($(obj).next().html());
}

//评估得分失去焦点事件
function blurEdit(obj,rowIndex) {
	var val = obj.value;
    var curRowTarget = scoreTargetGrid.row(rowIndex);
   	if(toNum(val)<=100) { 
   		obj.value = toNum(val);
   		var xVal =toNum(val);
   		var totalIdx = rowIndex;
   		// 计算总分
   		var rowsLen = scoreTargetGrid.rowsLength();
   		if(rowsLen>1) {
   			var curRowSupplier = scoreTargetGrid.row(rowIndex)["supplierAccount"];
   			var totalSum = 0;
   			// 往前查找
   			totalSum = xVal*(toNum(curRowTarget["weight"])/100);
   			if(rowIndex>0) {
   				for(var i=rowIndex;i>0;i--) {
   					var preIdx = i-1;
   					if(scoreTargetGrid.row(preIdx)["scoreModuleCode"]=="") {
   						break;
   					} else {
   						totalSum += (toNum($("#socreHid"+preIdx).val())*(toNum(scoreTargetGrid.row(preIdx)["weight"])/100));
   					}
   				}
   			}
   			// 往后查找
   			var sufIndex = rowIndex;
   			// 最后一行
   			for(var i=sufIndex;i<rowsLen;i++) {
   				var sufIdx = i+1;
   				// 倒数第二行数据
   				if(sufIdx<rowsLen) {
   					if(scoreTargetGrid.row(sufIdx)["scoreModuleCode"]=="") {
   						totalIdx = sufIdx;
   						break;
   					} else {
   						totalSum += (toNum($("#socreHid"+sufIdx).val())*(toNum(scoreTargetGrid.row(sufIdx)["weight"])/100));
   					}
   				}
   			}
   			// 填充总分
   			totalSum = totalSum.toFixed(2);
   			$("#socreHid"+totalIdx).val(totalSum);
   			if(curRowSupplier!="") {
   				$("#sumScoreSpn_"+curRowSupplier).text(totalSum);
   				$("#sumSocreHid_"+curRowSupplier).val(totalSum);
   			}
   		}
    } else {
    	//alert('请输入100以内的正整数！',2);
    	obj.value=0;
    	$(obj).focus();
    }
}

/** 
* 将数值四舍五入后格式化. 
* 
* @param num 数值(Number或者String) 
* @param cent 要保留的小数位(Number) 
* @param isThousand 是否需要千分位 0:不需要,1:需要(数值类型); 
* @return 格式的字符串,如'1,234,567.45' 
* @type String 
*/  
function formatNumber(num,cent,isThousand) {  
num = num.toString().replace(/\$|\,/g,'');  
 // 检查传入数值为数值类型  
 if(isNaN(num))  
   num = "0";  

// 获取符号(正/负数)  
sign = (num == (num = Math.abs(num)));  

num = Math.floor(num*Math.pow(10,cent)+0.50000000001);  // 把指定的小数位先转换成整数.多余的小数位四舍五入  
cents = num%Math.pow(10,cent);              // 求出小数位数值  
num = Math.floor(num/Math.pow(10,cent)).toString();   // 求出整数位数值  
cents = cents.toString();               // 把小数位转换成字符串,以便求小数位长度  

// 补足小数位到指定的位数  
while(cents.length<cent)  
 cents = "0" + cents;  

if(isThousand) {  
 // 对整数部分进行千分位格式化.  
 for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
   num = num.substring(0,num.length-(4*i+3))+','+ num.substring(num.length-(4*i+3));  
}  

if (cent > 0)  
   return (((sign)?'':'-') + num + '.' + cents);  
else  
   return (((sign)?'':'-') + num);  
}
<%--
$("#contentBiddingItemNumber").live("change",function(){
	var changeVal = this.value;
	//var oldVal = $("#scoreTargetSelChange").val();
	<%--
	var frm = $("#scoreTargetTableForm");
	var frmObj = frm.serializeJSON();
	var josnStrData = JSON.stringify(frmObj);
	josnStrData = josnStrData.substr(josnStrData.indexOf("["));
	$.ajax({
		async: false,
		url : 'rest/PurchaseEnquiryBiddingService/saveItemEvalTargeScore' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : josnStrData,
		dataType : "json",
		success : function(data1) {
		--%>
		<%--
			var jsonParam = {
		    	'elsAccount': elsAccount,
		    	'toElsAccount': elsAccount,
		    	'biddingNumber': biddingNumber,
		    	'biddingItemNumber': changeVal,
			};
			$.ajax({
				async: false,
				url : '#=basePath#rest/PurchaseEnquiryBiddingService/getEnquiryBiddingContent' + "?t="+new Date().getTime(),
				type : 'POST',
				contentType : "application/json",
				data : JSON.stringify(jsonParam),
				dataType : "json",
				success : function(data) {
					 $("#contentSummary").val(data.summary);
				 	 $("#contentBiddingProjectNumber").val(data.biddingProjectNumber);
					 $("#contentBiddingProjectName").val(data.biddingProjectName);
					 $("#contentDeliveryStartDate").val(new Date(data.deliveryStartDate).format('yyyy-MM-dd'));
					 $("#contentDeliveryEndDate").val(new Date(data.deliveryEndDate).format('yyyy-MM-dd'));
					 $("#contentAddress").val(data.address);
					 $("#contentQuality").val(data.quality);
					 var scoreTargetArray = new Array();
					 scoreTargetArray = data.biddingEvalTargetScoreVOs;
					 initEvalTargetScoreSum(scoreTargetArray);
					scoreTargetGrid.load(scoreTargetArray);
					$("#scoreTargetSelChange").val(changeVal);
				},
				error : function(data) {
					alert("加载失败",3);
				}
			});
			<%--
		},
		error : function(data) {
			alert("加载失败",3);
		}
	});
	--%>
	<%--
});
	--%>

$("#saveScoreTargetBtn").click(function() {
	setScoreTargetCurRound();
	saveScoreTargetContent(0);
});

$("#sendToSupplier").click(function() {
	setScoreTargetCurRound();
	var selectItemValue = $("#contentBiddingItemNumber1").get(0).selectedIndex;
	if("undefined" == typeof(biddingContentItemStandardArray1[selectItemValue]["curSendItem"]))
		biddingContentItemStandardArray1[selectItemValue]["curSendItem"]="";
	biddingContentItemStandardArray1[selectItemValue]["curSendItem"]=$("#contentBiddingItemNumber1").val();
	biddingContentItemStandardArray1[selectItemValue]["biddingName"] = $(".init-biddingName").val();
	var operScoreTargetRadio = $("#tenderTargetTable tbody :radio[name^='operScoreTarget_']");
	if(operScoreTargetRadio) {
		var radioOperFlag = false;
		operScoreTargetRadio.each(function(i,ele){
			if(i%2==0 && ele.checked) {
				radioOperFlag = true;
				return true;
			} else if(i%2==1 && !ele.checked && !radioOperFlag) {
				return radioOperFlag;
			}
		});
		if(!radioOperFlag) {
			alert("还存在未操作的物料，不能发布！",2);
			return;
		}
	} else {
		alert("没有一个物料中标，不能发布！",2);
		return;
	}
	var confirmMsg = "你确定要发布["+$("#contentBiddingItemNumber1").find("option:selected").text()+"]的"+$("#contentBiddingRound").find("option:selected").text()+"的评标定标吗？";
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="'+confirmMsg+'" />',closeEvent:function(){
		saveScoreTargetContent(1);
	}});
});

function saveScoreTargetContent(typeMethod) {
	if(biddingContentItemStandardArray1 && biddingContentItemStandardArray1.length>0) {
		var urlMethod = typeMethod==0 ? "saveItemEvalTargeScore" : "sendItemEvalTargeScore";
		var alertMsg = typeMethod==0 ? "保存成功!" : "发布成功!";
		parent.elsDeskTop.showLoading();
		$.ajax({
			async: false,
			url : '<%=basePath%>rest/PurchaseBiddingService/'+urlMethod+'?t='+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(biddingContentItemStandardArray1),
			dataType : "json",
			success : function(data1) {
				if(data1.statusCode=='-100') {
					alert(data1.message,3);
				}
				alert(alertMsg);
				//if(typeMethod==1) {
					window.location.reload();
				//}
			},complete : function(data) {
				parent.elsDeskTop.hideLoading();
			}
		});
	}
}

// 初始化总分
function initEvalTargetScoreSum(scoreTargetArray) {
	 var scoreTargetArrayLen = scoreTargetArray.length;
	 var tkSumVal = 0;
	 for(var tk=0;tk<scoreTargetArrayLen;tk++) {
		 var curRowTarget = scoreTargetArray[tk];
		 var nextTk = tk+1;
		 if(tkSumVal==0) {
			 tkSumVal = (toNum(curRowTarget["score"]))*(toNum(curRowTarget["weight"])/100);
		 }
		 if(scoreTargetArrayLen>1) {
			 // 说明是最后一行
			 if(nextTk==scoreTargetArrayLen) {
				var newScoreTargetRow = jQuery.extend({}, blankScoreTargetRow);
				newScoreTargetRow["score"]=tkSumVal.toFixed(2);
				scoreTargetArray.push(newScoreTargetRow);
			 } else {
				 var nextRowTarget = scoreTargetArray[nextTk];
				 if(curRowTarget["supplierAccount"]==nextRowTarget["supplierAccount"]) {
					 tkSumVal += ((toNum(nextRowTarget["score"]))*(toNum(nextRowTarget["weight"])/100));
				 } else {
					var newScoreTargetRow = jQuery.extend({},blankScoreTargetRow);
					newScoreTargetRow["score"]=tkSumVal.toFixed(2);
					scoreTargetArray.insert(nextTk,newScoreTargetRow);
					tk = nextTk;
					tkSumVal = 0;
					scoreTargetArrayLen++;
				 }
			 }
		 }
	 }
}

//单击评标定标tag页时触发 
$('.evalute-target-sheet').click(function() {
	var biddingItemNumberIndx = $("#contentBiddingItemNumber1").get(0).selectedIndex;//标段号
	if(typeof(biddingItemNumberIndx)=="undefined"){
		biddingItemNumberIndx = 0;
	}
	var tagCurContent = biddingContentItemStandardArray1[biddingItemNumberIndx];//当前标段信息
	var tagCurItem = $("#contentBiddingItemNumber1").val(); 
	var tagCurRound = tagCurContent.curRound; //轮次
	$("#contentBiddingRound").val(tagCurRound);
	var roundsNumberIndx = $("#contentBiddingRound").get(0).selectedIndex;//当前轮次index
	$("body").data("contentBiddingItemNumber_local1",biddingItemNumberIndx);//给body设值
	$("body").data("contentBiddingRoundNumber_local1",roundsNumberIndx);//给body设值
	var setBiddingContentCurTag = biddingContentItemStandardArray1[biddingItemNumberIndx]["biddingRounds"][roundsNumberIndx];//联系方式
	$("body").data("cur_item_total_round",(setBiddingContentCurTag.totalRound+''));
	$("body").data("cur_item_round_biddingStatus",setBiddingContentCurTag.biddingStatus);
	$("body").data("cur_item_round_autoBargain",setBiddingContentCurTag.fbk8);
	// 最后一轮之前且无需人工评标
	if(setBiddingContentCurTag.fbk8==0 && tagCurRound < setBiddingContentCurTag.totalRound) {
		$("#sendToSupplier").hide();
		$("#saveScoreTargetBtn").hide();
	}
	if(tagCurRound == setBiddingContentCurTag.totalRound && setBiddingContentCurTag.biddingStatus>2) {
		if(setBiddingContentCurTag.biddingStatus==3){
			var biddingStatus= $("#biddingStatus").val();
			// 审批中
			if(biddingStatus == "10"){
				$("#cancelBiddingBtn").show();
			}else{
				$("#entryBtn").show();
			}
			$("#sendToSupplier").hide();
// 			$("#sendToSupplier").show();
		}
		$("#sendTenderBidConfig").show();
		if(setBiddingContentCurTag.sendWonBidQute == 1) {
			$("#chkSendWonBidQute").prop("checked");
			$("#chkSendWonBidQute").get(0).checked = true;
			$("#chkSendWonBidQute").val(1);
		} else {
			$("#chkSendWonBidQute").get(0).checked = false;
			$("#chkSendWonBidQute").val(0);
		}
		if(setBiddingContentCurTag.sendWonBidRank == 1) {
			$("#chkSendWonBidRank").prop("checked");
			$("#chkSendWonBidRank").get(0).checked = true;
			$("#chkSendWonBidRank").val(1);
		} else {
			$("#chkSendWonBidRank").get(0).checked = false;
			$("#chkSendWonBidRank").val(0);
		}
		if(setBiddingContentCurTag.biddingStatus != 3) {
			$("#chkSendWonBidQute").attr("disabled",true);
			$("#chkSendWonBidRank").attr("disabled",true);
		}
	} else {
		$("#sendTenderBidConfig").hide();
	}
	initScoreTargetChangeGrid(biddingItemNumberIndx,roundsNumberIndx,tagCurItem,tagCurRound);
	var tagCurRoundInfo;
	tagCurRoundInfo = tagCurContent["biddingRounds"][roundsNumberIndx];
	//setScoreDisabled("",tagCurRoundInfo.biddingStatus);
});

function showBiddingStatusContent(biddingStatusVal) {
	var strVal = '未开始';
	if(biddingStatusVal == 1) {
		strVal = '招标进行中';
	} else if(biddingStatusVal ==3) {
		strVal = '评标中';
		if(($("body").data("contentBiddingRoundNumber_local1") + 1 )==$("body").data("cur_item_total_round")){
			var biddingStatus = $("#biddingStatus").val();
			// 定标审批中
			if(biddingStatus == "10"){
				$("#cancelBiddingBtn").show();
			}else{
				$("#entryBtn").show();
			}
			$("#sendToSupplier").hide();
// 			$("#sendToSupplier").show();
			$("#saveScoreTargetBtn").show();
		}else{
			$("#entryBtn").hide();
			// 无需人工评标
			if($("body").data("cur_item_round_autoBargain")==0) {
				$("#sendToSupplier").hide();
				$("#saveScoreTargetBtn").hide();
			} else {
				$("#saveScoreTargetBtn").show();
				$("#sendToSupplier").show();
			}
		}
	} else if(biddingStatusVal == 4) {
		strVal = '结束';
	} else if(biddingStatusVal == 2) {
		strVal = '未开标';
	} else if(biddingStatusVal == 5) {
		strVal = '招标作废';
	}
	$("body").data("cur_item_round_biddingStatus",biddingStatusVal);
	return strVal;
}
function setScoreDisabled(gridTable,disbiddingStatus) {
	$("#curBiddingStatusSpan").html('<font color="red">'+showBiddingStatusContent(disbiddingStatus)+'</font>');
	if(disbiddingStatus==3 && $("body").data("cur_item_round_autoBargain")==1) {
		if("scoreTargetTable"==gridTable) {
			$("#scoreTargetTable tbody input[type='text']").each(function(i,ele) {
				$(ele).attr("readonly",true);
				if("undefined" != typeof($(ele).attr("class"))
						&& $(ele).attr("class").indexOf("readOnlyFalse")==0) {
					$(ele).attr("readonly",false);
				}
			});
		} else
		if("candidateSupplierTable"==gridTable) {
			$("#candidateSupplierTable tbody input[type='text']").each(function(i,ele) {
				$(ele).attr("readonly",false);
			});
		} else
		if("tenderTargetTable"==gridTable) {
			$("#tenderTargetTable tbody :radio").each(function(i,ele) {
				$(ele).attr("disabled",false);
			});
		}
	} else  {
		if("candidateSupplierTable"==gridTable) {
			$("#candidateSupplierTable tbody input[type='text']").each(function(i,ele) {
				$(ele).attr("readonly",true);
			});
		} else
		if("scoreTargetTable"==gridTable) {
			$("#scoreTargetTable tbody input[type='text']").each(function(i,ele) {
				$(ele).attr("readonly",true);
			});
		} else
		if("tenderTargetTable"==gridTable) {
			$("#tenderTargetTable tbody :radio").each(function(i,ele) {
				$(ele).attr("disabled",true);
			});
		}
	}
}

// 加载报价的供应商
function loadCandidate(biddingItemNumberIndx,roundsNumberIndx,biddingItemNumberval,roundsNumberval) {
	var setBiddingContent1 = biddingContentItemStandardArray1[biddingItemNumberIndx]["biddingRounds"][roundsNumberIndx];
	// 判断当前轮次是否为最后一轮
	var roundsNumbervalInt = parseInt(roundsNumberval);
	var totalRound = setBiddingContent1.totalRound;
	if(roundsNumbervalInt!=totalRound) {
		$("#candidateSupplierDiv").hide();
		return;
	} else {
		$("#candidateSupplierDiv").show();
	}
	if(!candidateSupplierGrid)
		candidateSupplierGrid = $('#candidateSupplierTable').mmGrid({
		        cols: candidateSupplierItem,
		        height: 180,
		        loadingText: '正在载入',
		        noDataText: '暂无数据',
		        autoLoad:false,
		        checkCol: false,
		        indexCol: false
		    });
	if("undefined" == typeof(setBiddingContent1["biddingCandidateSuppliers"])
			|| setBiddingContent1["biddingCandidateSuppliers"].length==0) {
		parent.elsDeskTop.showLoading();
		var candidateJsonData = {
				toElsAccount : elsAccount,
				elsAccount : elsAccount,
				biddingNumber : biddingNumber,
				biddingItemNumber : biddingItemNumberval,
				roundsNumber : roundsNumberval,
				totalRound : totalRound
		};
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/findCandidateSuppliers?t='+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(candidateJsonData),
			dataType : "json",
			success : function(data) {
				var dataRows = data.rows;
				if("undefined"==typeof(dataRows)) {
					dataRows = [];
				}
				setBiddingContent1["biddingCandidateSuppliers"]=dataRows;
				candidateSupplierGrid.load(dataRows);
			},
			error : function(data) {
				alert('加载数据失败!',3);
			},
			complete : function(data) {
				parent.elsDeskTop.hideLoading();
			}
		});
	} else {
		candidateSupplierGrid.load(setBiddingContent1.biddingCandidateSuppliers);
	}
	candidateSupplierGrid.on("loadSuccess",function(e, data1){
		setScoreDisabled("candidateSupplierTable",setBiddingContent1.biddingStatus);
	});
}

// 加载供应商报价
function loadTenderTarget(biddingItemNumberIndx,roundsNumberIndx,biddingItemNumberval,roundsNumberval) {
	var setBiddingContent1 = biddingContentItemStandardArray1[biddingItemNumberIndx]["biddingRounds"][roundsNumberIndx];
	var bdStatusVal = setBiddingContent1.biddingStatus;
	var secretVal = setBiddingContent1.secret;
	// 以后需要做特殊处理
	var myTenderTargetItem = tenderTargetBiddingItem;
	if(!tenderTargetGrid) {
		tenderTargetGrid = $('#tenderTargetTable').mmGrid({
	        cols: myTenderTargetItem,
	        height: 512,
	        loadingText: '正在载入',
	        autoLoad : false,
	        noDataText: (bdStatusVal<3 && secretVal != 1) ? '数据保密中' : '暂无数据',
	        checkCol: false,
	        indexCol: false
	    });
	}
	tenderTargetGrid.opts.cols = myTenderTargetItem;
	tenderTargetGrid.opts.noDataText = (bdStatusVal<3 && secretVal != 1) ? '数据保密中' : '暂无数据';
	if(secretVal == 1){
		var tenderJsonData = {
				elsAccount : elsAccount,
				biddingNumber : biddingNumber,
				biddingItemNumber : biddingItemNumberval,
				roundsNumber : roundsNumberval,
				fbk1 : (setBiddingContent1.totalRound+'') // 只为查询临时使用
		};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/findTenderTargetItems?t='+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(tenderJsonData),
			dataType : "json",
			success : function(data) {
				var dataRows = data.rows;
				if("undefined"==typeof(dataRows)) {
					dataRows = [];
				}
				else{
					var count = 1;
					var flag = true;
					for(var i = 0 ;i<dataRows.length;i++){
						if(dataRows[i].fbk5 == null || ""==dataRows[i].fbk5){
							dataRows[i].fbk5 = "4";
							dataRows[i].fbk7 = "0";
							for(var j = i+1 ;j<dataRows.length;j++){
								if(dataRows[i].materialNumber == dataRows[j].materialNumber){
									if(dataRows[i].priceIncludingVat >= dataRows[j].priceIncludingVat){
										count +=1;
										if(count >1){
											dataRows[i].fbk5 = "3";
											dataRows[j].fbk5 = "3";
											for(var k=i;k<count ; k++){
												dataRows[k].fbk7 = 100/count ;
											}
										}
									}else{
										dataRows[i].fbk5 = "3";
										dataRows[i].fbk7 = "100";
									}
								}
							}
							for(var q=0;q<dataRows.length;q++){
								if(dataRows[i].materialNumber == dataRows[q].materialNumber){
									flag = false;
								}
							}
							if(flag){//flag为true表示当前物料只有一家供应商报价
								dataRows[i].fbk5 = "3";
								dataRows[i].fbk7 = "100";
							}
						}
					}
				}
				setBiddingContent1["tenderTargetGridRows"]=dataRows;
				tenderTargetGrid.load(dataRows);
			},
			error : function(data) {
				alert('加载数据失败!',3);
			},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}else if(bdStatusVal > 2 && "undefined" == typeof(setBiddingContent1["tenderTargetGridRows"])) {
		var tenderJsonData = {
				elsAccount : elsAccount,
				biddingNumber : biddingNumber,
				biddingItemNumber : biddingItemNumberval,
				roundsNumber : roundsNumberval,
				fbk1 : (setBiddingContent1.totalRound+'') // 只为查询临时使用
		};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/findTenderTargetItems?t='+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(tenderJsonData),
			dataType : "json",
			success : function(data) {
				var dataRows = data.rows;
				if("undefined"==typeof(dataRows)) {
					dataRows = [];
				}
				else{
					var count = 1;
					var flag = true;
					for(var i = 0 ;i<dataRows.length;i++){
						if(dataRows[i].fbk5 == null || ""==dataRows[i].fbk5){
							dataRows[i].fbk5 = "4";
							dataRows[i].fbk7 = "0";
							for(var j = i+1 ;j<dataRows.length;j++){
								if(dataRows[i].materialNumber == dataRows[j].materialNumber){
									if(dataRows[i].priceIncludingVat >= dataRows[j].priceIncludingVat){
										count +=1;
										if(count >1){
											dataRows[i].fbk5 = "3";
											dataRows[j].fbk5 = "3";
											for(var k=i;k<count ; k++){
												dataRows[k].fbk7 = 100/count ;
											}
										}
									}else{
										dataRows[i].fbk5 = "3";
										dataRows[i].fbk7 = "100";
									}
								}
							}
							for(var q=0;q<dataRows.length;q++){
								if(dataRows[i].materialNumber == dataRows[q].materialNumber){
									flag = false;
								}
							}
							if(flag){//flag为true表示当前物料只有一家供应商报价
								dataRows[i].fbk5 = "3";
								dataRows[i].fbk7 = "100";
							}
						}
					}
				}
				setBiddingContent1["tenderTargetGridRows"]=dataRows;
				tenderTargetGrid.load(dataRows);
			},
			error : function(data) {
				alert('加载数据失败!',3);
			},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	} else {
		tenderTargetGrid.load(setBiddingContent1.tenderTargetGridRows);
	}
	setTimeout(function(){
		var data1 = setBiddingContent1.tenderTargetGridRows;
			var oddBg = 1;
			var curbtciNum = 0;
			if(data1!="") {
			$.each(data1,function(i,ele) {
				var nextEle = data1[i+1];
				if(curbtciNum==0) {
					curbtciNum = data1[i].biddingContentItemNumber;
					$('#tenderTargetTable tr:eq('+i+')').css('background-color','#00FFFF');
					if(typeof(nextEle)=="undefined" || null==nextEle)
						return false;
					var nextbtciNum = nextEle.biddingContentItemNumber;
					if(curbtciNum != nextbtciNum) {
						oddBg = oddBg ==1 ? 0 : 1;
						curbtciNum = nextbtciNum
					}
				}
				if(i > 0) {
					// exists next ele
					if(typeof(nextEle)=="undefined" || null==nextEle) {
						if(oddBg == 1) {
							$('#tenderTargetTable tr:eq('+i+')').css('background-color','#00FFFF');
						}
						return false;
					} else {
						if(oddBg == 1) {
							$('#tenderTargetTable tr:eq('+i+')').css('background-color','#00FFFF');
						}
						var nextbtciNum = nextEle.biddingContentItemNumber;
						if(curbtciNum != nextbtciNum) {
							oddBg = oddBg ==1 ? 0 : 1;
							curbtciNum = nextbtciNum
						}
					}
				}
			});
			}
		setScoreDisabled("tenderTargetTable",bdStatusVal);
	},300);
	setTimeout(function(){
		tenderTargetGrid.resize();
	},300);
}

// 加载评分标准
function loadScoreTargetGrid(biddingItemNumberIndx,roundsNumberIndx,biddingItemNumberval,roundsNumberval) {
	var setBiddingContent1 = biddingContentItemStandardArray1[biddingItemNumberIndx]["biddingRounds"][roundsNumberIndx];
	var setBiddingContentStandard = setBiddingContent1.biddingEvalTargetScoreVOs;
	if(setBiddingContentStandard) {
		if(setBiddingContentStandard.length==0) {
			parent.elsDeskTop.showLoading();
			var evalJsonData = {
					toElsAccount : elsAccount,
					elsAccount : elsAccount,
					biddingNumber : biddingNumber,
					biddingItemNumber : biddingItemNumberval,
					roundsNumber : roundsNumberval
			};
			$.ajax({
				url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/findScoreTargets?t='+new Date().getTime(),
				type : 'POST',
				contentType : "application/json",
				data : JSON.stringify(evalJsonData),
				dataType : "json",
				success : function(data) {
					var dataRows = data.rows;
					if("undefined"==typeof(dataRows)) {
						dataRows = [];
					}
					setBiddingContent1["biddingEvalTargetScoreVOs"]=dataRows;
					initEvalTargetScoreSum(dataRows);
					scoreTargetGrid.load(dataRows);
				},
				error : function(data) {
					alert('加载数据失败!',3);
				},
				complete : function(data) {
					parent.elsDeskTop.hideLoading();
				}
			});
		} else {
			removeTotalSumCol(setBiddingContentStandard);
			initEvalTargetScoreSum(setBiddingContentStandard);
			scoreTargetGrid.load(setBiddingContentStandard);
		}
	} else {
		scoreTargetGrid.load([]);
	}
	setTimeout(function(){
		scoreTargetGrid.resize();
		setScoreDisabled("scoreTargetTable",setBiddingContent1.biddingStatus);
	},300);
}

function setScoreTargetCurRound() {
	parent.elsDeskTop.showLoading();
	var form = $("#form").serializeJSON();
	var biddingContent = form.biddingContent1;
	var biddingItemNumber = $("body").data("contentBiddingItemNumber_local1");//获取标段---原标段
	if(typeof(biddingItemNumber)=="undefined"){
		biddingItemNumber = 0;
	}
	biddingContent["biddingItemNumber"]=$("#contentBiddingItemNumber1")[0][biddingItemNumber].value;
	var biddingRoundNumber = $("body").data("contentBiddingRoundNumber_local1");//获取标段---原轮次
	biddingRoundNumber=parseInt(biddingRoundNumber);
	// 设置评分打分数据
	var formbiddingEvalTargetScoreVOs = form.biddingEvalTargetScoreVOs;
	removeTotalSumCol(formbiddingEvalTargetScoreVOs);
	var setBiddingContent1 = biddingContentItemStandardArray1[biddingItemNumber]["biddingRounds"][biddingRoundNumber];
	setBiddingContent1["biddingEvalTargetScoreVOs"] = formbiddingEvalTargetScoreVOs;
	// 设置定标详细内容信息
	var formbiddingTenderContentItems = form.biddingTenderContentItems;
	formbiddingTenderContentItems = typeof(formbiddingTenderContentItems)=="undefined" ? [] : formbiddingTenderContentItems;
	setBiddingContent1["biddingTenderContentItems"] = formbiddingTenderContentItems;
	// 设置候选供应商
	var roundsNumbervalInt = parseInt(setBiddingContent1.roundsNumber);
	var totalRound = setBiddingContent1.totalRound;
	if(roundsNumbervalInt==totalRound) {
		var formbiddingCandidateSuppliers = form.biddingCandidateSuppliers;
		formbiddingCandidateSuppliers = typeof(formbiddingCandidateSuppliers)=="undefined" ? [] : formbiddingCandidateSuppliers;
		setBiddingContent1["biddingCandidateSuppliers"] = formbiddingCandidateSuppliers;
	}
	parent.elsDeskTop.hideLoading();
}

//去掉总分行数据
function removeTotalSumCol(formbiddingEvalTargetScoreVOs) {
	formbiddingEvalTargetScoreVOs = typeof(formbiddingEvalTargetScoreVOs)=="undefined"?[]:formbiddingEvalTargetScoreVOs;
	var flength = formbiddingEvalTargetScoreVOs.length;
	if(formbiddingEvalTargetScoreVOs && flength > 0) {
		var fIndex = 0;
		// 去掉总分行数据
		for(var f=0;f<flength;f++) {
			if(formbiddingEvalTargetScoreVOs[f]["scoreModuleCode"]=="") {
				formbiddingEvalTargetScoreVOs.splice(f,1);
				f--;
				flength--;
			} else {
				if("undefined"==typeof(formbiddingEvalTargetScoreVOs[f].fileList))
					formbiddingEvalTargetScoreVOs[f]["fileList"] =
						(JSON.parse($("#standardDocument1_"+fIndex).text())).fileList;
			}
			fIndex ++;
		}
	}
}

$("#contentBiddingItemNumber1").change(function() {
	setScoreTargetCurRound();
	$("#contentSummary1").val("");
	$("#contentBiddingProjectNumber1").val($("#biddingProjectNumber1").val());
	$("#contentDeliveryStartDate1").val("");
	$("#contentDeliveryEndDate1").val("");
	$("#contentAddress1").val("");
	$("#contentQuality1").val("");
	var selectValue = $(this).get(0).selectedIndex;
	perbiddingItemNumberValue1 = selectValue;
	if("undefined" !=typeof(biddingContentItemStandardArray1[selectValue])){
		parent.elsDeskTop.showLoading();
		// 内容
		var setBiddingContent = biddingContentItemStandardArray1[selectValue];
		// 重新加载标段对应的轮次信息
		$("#contentBiddingRound").empty();
		var biddingRoundss =  setBiddingContent.biddingRounds;
		for(var is=0;is<biddingRoundss.length;is++) {
			$("#contentBiddingRound").append("<option value='"+biddingRoundss[is].roundsNumber+"'>第"+biddingRoundss[is].roundsNumber+"轮</option>");
		}
		$("body").data("cur_item_total_round",biddingRoundss.length);
		// 修改为当前轮次  默认为第一轮次
		$("#contentBiddingRound").val(setBiddingContent.curRound);
		perbiddingRoundNumberValue1 = $("#contentBiddingRound").get(0).selectedIndex;
		var setCurRoundItemChange = setBiddingContent["biddingRounds"][perbiddingRoundNumberValue1];
		$("body").data("cur_item_round_autoBargain",setCurRoundRoundChange.fbk8);
		if(setBiddingContent.curRound == setCurRoundItemChange.totalRound && setCurRoundItemChange.biddingStatus>2) {
			if(setCurRoundItemChange.biddingStatus==3){
				$("#entryBtn").show();
// 				$("#sendToSupplier").hide();
				$("#sendToSupplier").show();
			}
			$("#sendTenderBidConfig").show();
			if(setCurRoundItemChange.sendWonBidQute == 1) {
				$("#chkSendWonBidQute").prop("checked");
				$("#chkSendWonBidQute").get(0).checked = true;
				$("#chkSendWonBidQute").val(1);
			} else {
				$("#chkSendWonBidQute").get(0).checked = false;
				$("#chkSendWonBidQute").val(0);
			}
			if(setCurRoundItemChange.sendWonBidRank == 1) {
				$("#chkSendWonBidRank").prop("checked");
				$("#chkSendWonBidRank").get(0).checked = true;
				$("#chkSendWonBidRank").val(1);
			} else {
				$("#chkSendWonBidRank").get(0).checked = false;
				$("#chkSendWonBidRank").val(0);
			}
		} else {
			$("#sendTenderBidConfig").hide();
		}
		$("#contentSummary1").val(setBiddingContent.summary);
		$("#contentBiddingProjectNumber1").val(setBiddingContent.biddingProjectNumber);
		$("#contentBiddingProjectName1").val(setBiddingContent.biddingProjectName);
		$("#contentDeliveryStartDate1").val(formatDate(setBiddingContent.deliveryStartDate));
		$("#contentDeliveryEndDate1").val(formatDate(setBiddingContent.deliveryEndDate));
		$("#contentAddress1").val(setBiddingContent.address);
		$("#contentQuality1").val(setBiddingContent.quality);
		parent.elsDeskTop.hideLoading();
		initScoreTargetChangeGrid(
				perbiddingItemNumberValue1,
				perbiddingRoundNumberValue1,
				$(this).val(),
				$("#contentBiddingRound").val()
			);
	}
	$("body").data("contentBiddingItemNumber_local1",perbiddingItemNumberValue1);
	$("body").data("contentBiddingRoundNumber_local1",perbiddingRoundNumberValue1);
});

function initScoreTargetChangeGrid(curItem,curRound,curItemVal,curRoundVal) {
	// 评分
	loadScoreTargetGrid(curItem,curRound,curItemVal,curRoundVal);
	// 报价
	loadTenderTarget(curItem,curRound,curItemVal,curRoundVal);
	// 推荐
	loadCandidate(curItem,curRound,curItemVal,curRoundVal);
}

$("#contentBiddingRound").change(function() {
	setScoreTargetCurRound();
	var selectValue = $(this).get(0).selectedIndex;
	var biddingItemIndex = $("body").data("contentBiddingItemNumber_local1");
	var biddingItemValNo = $("#contentBiddingItemNumber1").val();
	if(typeof(biddingItemIndex)=="undefined"){
		biddingItemIndex = 0;
		biddingItemValNo = "0";
	}
	$("body").data("contentBiddingItemNumber_local1",biddingItemIndex);
	var setCurRoundRoundChange = biddingContentItemStandardArray1[biddingItemIndex]["biddingRounds"][selectValue];
	$("body").data("cur_item_round_biddingStatus",setCurRoundRoundChange.biddingStatus);
	$("body").data("cur_item_round_autoBargain",setCurRoundRoundChange.fbk8);
	if((selectValue+1) == setCurRoundRoundChange.totalRound && setCurRoundRoundChange.biddingStatus>2) {
		if(setCurRoundRoundChange.biddingStatus==3){
			$("#entryBtn").show();
			// $("#sendToSupplier").hide();
			$("#sendToSupplier").show();
		}
		$("#sendTenderBidConfig").show();
		if(setCurRoundRoundChange.sendWonBidQute == 1) {
			$("#chkSendWonBidQute").prop("checked");
			$("#chkSendWonBidQute").get(0).checked = true;
			$("#chkSendWonBidQute").val(1);
		} else {
			$("#chkSendWonBidQute").get(0).checked = false;
			$("#chkSendWonBidQute").val(0);
		}
		if(setCurRoundRoundChange.sendWonBidRank == 1) {
			$("#chkSendWonBidRank").prop("checked");
			$("#chkSendWonBidRank").get(0).checked = true;
			$("#chkSendWonBidRank").val(1);
		} else {
			$("#chkSendWonBidRank").get(0).checked = false;
			$("#chkSendWonBidRank").val(0);
		}
	} else {
		$("#sendTenderBidConfig").hide();
	}
	initScoreTargetChangeGrid(
			biddingItemIndex,
			selectValue,
			biddingItemValNo,
			$(this).val()
		);
	$("body").data("contentBiddingRoundNumber_local1",selectValue);
}); 

$("#chkSendWonBidQute").live("change",function(){
	var biddingItemNumberIndx = $("#contentBiddingItemNumber1").get(0).selectedIndex;
	if(typeof(biddingItemNumberIndx)=="undefined"){
		biddingItemNumberIndx = 0;
	}
	var roundsNumberIndx = $("#contentBiddingRound").get(0).selectedIndex;
	if($(this).attr("checked")=='checked') {
		biddingContentItemStandardArray1[biddingItemNumberIndx]["biddingRounds"][roundsNumberIndx].sendWonBidQute = 1;
		$(this).val(1);
	} else {
		biddingContentItemStandardArray1[biddingItemNumberIndx]["biddingRounds"][roundsNumberIndx].sendWonBidQute = 0;
		$(this).val(0);
	}
});

$("#chkSendWonBidRank").live("change",function(){
	var biddingItemNumberIndx = $("#contentBiddingItemNumber1").get(0).selectedIndex;
	if(typeof(biddingItemNumberIndx)=="undefined"){
		biddingItemNumberIndx = 0;
	}
	var roundsNumberIndx = $("#contentBiddingRound").get(0).selectedIndex;
	if($(this).attr("checked")=='checked') {
		biddingContentItemStandardArray1[biddingItemNumberIndx]["biddingRounds"][roundsNumberIndx].sendWonBidRank = 1;
		$(this).val(1);
	} else {
		biddingContentItemStandardArray1[biddingItemNumberIndx]["biddingRounds"][roundsNumberIndx].sendWonBidRank = 0;
		$(this).val(0);
	}
});

/*-------------==================文件操作（BEGIN）==================-------------*/
$('.downloadFile-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var gridType = $(this).attr("id").split("-")[1];
	var itemRow = [];
	if(gridType==1) {
		itemRow = biddingDetailContentGrid.row(itemRowIndex);
	} else if(gridType==2) {
		itemRow = tenderTargetGrid.row(itemRowIndex);
	} else if(gridType==3) {
		itemRow = supplierTenderItemGrid.row(itemRowIndex);
	}
	var extendFields = itemRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var fileList = extendFields.fileList;
		if("undefined"!=typeof(fileList) && fileList.length > 0){
			downloadFile("file",itemRow);
		} else {
			alert("没有文件可下载",2);
		}
	} else {
		alert("没有文件可下载",2);
	}
});

$(".previewImage-item").live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var gridType = $(this).attr("id").split("-")[1];
	var itemRow = [];
	if(gridType==1) {
		itemRow = biddingDetailContentGrid.row(itemRowIndex);
	} else if(gridType==2) {
		itemRow = tenderTargetGrid.row(itemRowIndex);
	} else if(gridType==3) {
		itemRow = supplierTenderItemGrid.row(itemRowIndex);
	}
	var extendFields = itemRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		if("undefined"!=typeof(imageList) && imageList.length > 0){
			parent.elsDeskTop.closeCurWin('showPicture');
			for(var i=0;i<imageList.length;i++) {
				imageList[i]["preViewFilePath"] = imageList[i].filePath;
			}
			var obj={
					windowTitle: "图片预览",
					data:{
						defaultShow:"1",
						imageList : imageList
					},
			 	   	mask : true,
					windowMaximize: false,
					windowMinimize: false,
					windowStatus: "regular",
					windowWidth: 860,
					windowHeight: 700,
					iframSrc: elsBasePath+"common/previewimg/showPicture.jsp",
					windowsId: "showPicture",//传递上一级的窗口iframe id用parentWinId,其他数据自定
				};
			parent.elsDeskTop.defineWin(obj);
		} else {
			alert("没有图片可预览",2);
		}
	} else {
		alert("没有图片可预览",2);
	}
});
$('.downloadImage-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var gridType = $(this).attr("id").split("-")[1];
	var itemRow = [];
	if(gridType==1) {
		itemRow = biddingDetailContentGrid.row(itemRowIndex);
	} else if(gridType==2) {
		itemRow = tenderTargetGrid.row(itemRowIndex);
	} else if(gridType==3) {
		itemRow = supplierTenderItemGrid.row(itemRowIndex);
	}
	var extendFields = itemRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		if("undefined"!=typeof(imageList) && imageList.length > 0){
			downloadFile("image",itemRow);
		} else {
			alert("没有图片可下载",2);
		}
	} else {
		alert("没有图片可下载",2);
	}
});
function downloadFile(type,itemRow){
	var materialRow = itemRow;
	var filePathArrStr = '';
	if("file"==type){
		var extendFields = materialRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var fileList = extendFields.fileList;
			if("undefined"!=typeof(fileList) && fileList.length > 0){
				for(var i=0;i<fileList.length;i++){
					filePathArrStr += (','+fileList[i].filePath);
				}
			} 
		}
	} else if("image"==type){
		var extendFields = materialRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var imageList = extendFields.imageList;
			if("undefined"!=typeof(imageList) && imageList.length > 0){
				for(var i=0;i<imageList.length;i++){
					filePathArrStr += (','+imageList[i].filePath);
				}
			}
		}
	} else{}
	convertToZipFileDown(filePathArrStr);
}
/*-------------==================文件操作（BEGIN）==================-------------*/

/*--------------评标定标(end)--------------*/
/*保证金*/
var biddingMarginVOs;
$("#margin_distinguishPhases").live("change",function(){
	var marginChangeVal = this.value;
	if(biddingMarginVOs &&  biddingMarginVOs.length>0) {
		$("#margin_distinguishPhases").val(marginChangeVal);//默认选择标段1
		$("body").data("margin_distinguishPhases",marginChangeVal);
		$("#margin_distinguishPhases option[value='0']").attr("disabled",true);
		var selectValue = $(this).get(0).selectedIndex-1;
		var margin = biddingMarginVOs[selectValue];
		if("undefined" !=typeof(margin)) {
			$("input[name='biddingMarginVO[collect]']").eq(margin.collect).attr("checked",'checked');
			$("input[name='biddingMarginVO[back]']").eq(margin.back).attr("checked",'checked');
			$("#margin_amount").val(margin.amount);
			$("#margin_currencyType").val(margin.currency);
			$("#margin_remark").val(margin.remark);
			$("#margin_payBeginDate").val(formatDate(margin.payBeginDate));
			$("#margin_payEndDate").val(formatDate(margin.payEndDate));
		}
	}
});

function formatDate(date) {
   	if (date!=null&&date.length!=10) {
   		date = new Date(date).format("yyyy-MM-dd");
   	}
   	return date;
}
function formatTime(time) {
   	if (time!=null) {
   		time = new Date(time).format("yyyy-MM-dd hh:mm:ss");
   	}
	return ;
}
/*保证金*/
 
 $("#cancelBiddingBtn").click(function(){
		cancel();
	});
function cancel() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditcancel" defaultValue="确认要撤销审批吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		debugger;
		parent.elsDeskTop.showLoading();
		var formObj = $("#form").serializeJSON();
		var currDate = new Date().format("yyyy-MM-dd");
		var currTime = new Date().format("hh:mm:ss");
		
		//必填项非空验证
		var biddingNumber = $("#biddingNumber").val();
		if(biddingNumber == "null" || biddingNumber == ""){		
			var biddingName = $("#biddingName").val();
			if(biddingName == "" || biddingName == "null"){
				alert("必填项不能为空！",2);
				return;
			}
		}else{
			formObj["biddingNumber"]=biddingNumber;
			formObj["elsAccount"]=elsAccount;
			formObj["elsSubAccount"]=elsSubAccount;
		}
		
		//如果是不区分标段，则每个选项卡仅有一个页面，如果区分标段，则标段数对应每个选项卡有几个标段页面
		var itemPageNumber;
		if(typeof(formObj.biddingPhasesItems) == "undefined"){
			itemPageNumber = 1;
		}else{
			itemPageNumber = formObj.biddingPhasesItems.length;
			var phasesItemsTemp = formObj.biddingPhasesItems;
			for(var i=0;i<phasesItemsTemp.length;i++){
				if(phasesItemsTemp[i].biddingItemName == ""){
					alert("标段名称不能为空！",2);
					return;
				}
			}
		}
		$.ajax({
			url :"<%=basePath%>rest/PurchaseBiddingService/cancelAuditBidding",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(formObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "401") {
					alert("<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />",3);
				} else if (data.status == "403") {
					alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}

$("#entryBtn").click(function(){
	 entryBidding();
});
//定标提交审批
function entryBidding(){
	debugger;
	setScoreTargetCurRound();
	if(biddingContentItemStandardArray1 && biddingContentItemStandardArray1.length>0) {
		$.ajax({
			async: false,
			url : '<%=basePath%>rest/PurchaseBiddingService/saveItemEvalTargeScore?t='+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(biddingContentItemStandardArray1),
			dataType : "json",
			success : function(data1) {

			},
			error : function(data) {
				alert("加载失败",3);
			}
		});
	}
	debugger;
	var currBiddingNumber = "";
	var currBiddingItemNumber = "";
	var currCompanyShortName = "";
	if(biddingContentItemStandardArray1 && biddingContentItemStandardArray1.length>0) {
		currBiddingNumber = biddingContentItemStandardArray1[0]["biddingNumber"];
		currBiddingItemNumber = biddingContentItemStandardArray1[0]["biddingItemNumber"];
		currCompanyShortName = "迈腾电子";
	}
		// 区分标段的审批上报
	if(currBiddingItemNumber != 0){
		if(biddingContentItemStandardArray1[0]["extendFields"] != null){
			var obj = JSON.parse(biddingContentItemStandardArray1[0]["extendFields"]);
			for(var key in obj){
				if(key == currBiddingItemNumber){
					if(obj[key].auditStatus == "2"){
						var errMsg = "审批中的招标"+currBiddingNumber+"标段"+currBiddingItemNumber+"不能再次提交";
						alert(errMsg,2);
						return;
					}
					if(obj[key].auditStatus == "0"){
						var errMsg = "审批通过的招标"+currBiddingNumber+"标段"+currBiddingItemNumber+"不能再次提交";
						alert(errMsg,2);
						return;
					}
				}
			}
		}
	}else{
		if(biddingContentItemStandardArray1[0]["auditStatus"] == "2"){
			var errMsg = "审批中的招标"+rows[i].biddingNumber+"不能再次提交";
			alert(errMsg,2);
			return;
		}
		if(biddingContentItemStandardArray1[0]["auditStatus"] == "0"){
			var errMsg = "审批通过的招标"+rows[i].biddingNumber+"不能再次提交";
			alert(errMsg,2);
			return;
		}
	}
	var stretegyCode=$("#stretegySelctor").val();
	debugger;
	var data = {"stretegyCode":stretegyCode,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"companyShortName":currCompanyShortName,"biddingNumber":currBiddingNumber};
	//获取当前选中的
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseBiddingService/batchEntryBidding",
    		contentType : "application/json",
    		type : "post",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			debugger;
    			if(data !=null){
                if(data.statusCode == "E"){
					alert(data.message,3);
					return;
				}else if(data.statusCode == "Other"){
					console.log(data.errMessage);
					alert('请求不允许执行',3);
					return;
				}else if (data.statusCode == "-100") {
					console.log(data.message);
					alert(data.message,3);
					return;
				}
                debugger;
             	// 匹配的审批策略有多条，让用户选择
    			if (data.rows) {
					showStretegySelector(data.rows);
					return;
				}}else{
				alert("<i18n:I18n key="i18n_common_report_success" defaultValue="上报成功" />");
				$("#close-biddingBarginManage").click();
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					if (data.status == "401") {
						alert("<i18n:I18n key="i18n_common_orders_cannot_be_repeated_to_report" defaultValue="订单不能重复上报" />",3);
					} else {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					};
				}
			}
		});
	}});
}
//渲染   @author songzhen 20161215  begin
function attachmentFileRenderer(val, item, rowIndex){
	var viewFlag = false;
	var extendFields = item.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var fileList = extendFields.fileList;
		viewFlag = (fileList && fileList!="");
	}
    return '<span class="downloadFile-item" id="downloadFile-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
}
function attachmentImageRenderer(val, item, rowIndex){
	var viewFlag = false;
	var extendFields = item.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		viewFlag = (imageList && imageList!="");
	}
	return '<span class="previewImage-item" id="previewImage-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
    	+'&nbsp;&nbsp;<span class="downloadImage-item" id="downloadImage-2-'+rowIndex+'" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
}
function priceIncludingVatRenderer(val, item, rowIndex) {
		if(item.fbk1=='1'){
		   return "不报价";
	   	}else{
	   		return val;
	   	}
	}
//渲染   @author songzhen 20161215  end
//渲染   @author songzhen 20161216  start
function biddingNumberRenderer(val){
	if(!val){val = "";} return val;
}
function biddingItemNumberRenderer(val){
	if(!val){val = "";} return val;
}
function biddingContentItemNumberRenderer(val){
	if(!val){val = "";} return val;
}
function biddingProjectNumberRenderer(val,item,rowIndex){
	if(!val){val = "";} return val;
}
function materialNumberRenderer(val){
	if(!val){val = "";} return val;
}
function materialDescRenderer(val){
	if(!val){val = "";} return val;
}
function materialModelRenderer(val){
	if(!val){val = "";} return val;
}
function materialSpecificationRenderer(val){
	if(!val){val = "";} return val;
}
function unitsRenderer(val){
	if(!val){val = "";} return val;
}
function quantityRenderer(val){
	if(!val){val = "";} return val;
}
function fbk2Renderer(val){
	if(!val){val = "";} return val;
}
function fbk3Renderer(val){
	if(!val){val = "";} return val;
}
function deliveryDateRenderer(val){
	if(val&&val !=""){
		val = new Date(val).format('yyyy-MM-dd');
	}else{
		val = "";
	}
	return val; 
}
function remarkRenderer(val){
	if(!val){val = "";} return val;
}
function fbk10Renderer(val){
	if(!val){val = "";} return val;
}
function fbk9Renderer(val){
	if(!val){val = "";} return val;
}
//列自定义
$("#columnDefineBtn_content_item").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount 
	    		+ "&tableCode=biddingPurchaseContentItem_mt" + "&window=iframeApp_biddingPurchaseContentItem_mt",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	 });
});
//渲染   @author songzhen 20161216  end

</script>
</body>
</html>