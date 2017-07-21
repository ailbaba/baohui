<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<style type="text/css" media="screen">
html, body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
}

#flashContent {
	display: none;
}

table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>
	<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="btnPublish" class="button-wrap">发布</button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="companyShortName"
			value="<%=session.getAttribute("companyShortName")%>" /><input
			type="hidden" name="elsAccount"
			value="${elsAccount }" /> <input type="hidden"
			name="elsSubAccount" value="${elsSubAccount }" />
			<input type="hidden" id="toElsAccounts"
			name="toElsAccounts" value="" />
			<input type="hidden" id="jsonStr"
			name="jsonStr" value="" />
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">需求单头</span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<main class="grid-container">
					<div class="grid-100">
						<table id="table-head"></table>
					</div>
					</main>
				</div>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<ul>
						<li><a href="#sheet-item-one">需求单明细</a></li>
						<li><a href="#sheet-item-two">选择供应商</a></li>
					</ul>
					<div id="sheet-item-one">
						<div class="edit-box-wrap">
							<button id="btnGen" class="edit-btn button-wrap add-bottom-btn">生成数据</button>
							<button id="btnAdd" class="edit-btn button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
							<button id="btnRemove" class="edit-btn button-wrap del-btn"><i18n:I18n key="i18n_common_button_removeline" defaultValue="删除一行" /></button>
						</div>
						<main id="item-container" class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
						</div>
						</main>
					</div>
					<!-- 受邀方 -->
					<div id="sheet-item-two">
						<div class="supplie-groud">
							<div class="bg-common contacts-box">
								<div class="tip-head pos-relative">
									 <span
										class="dialogTitle"><i18n:I18n
											key="i18n_common_title_addcontact" defaultValue="添加供应商" /></span>
<!-- 									<button class="button-wrap sure-selct" -->
<!-- 										style="position: absolute; right: 44px; top: 11px;"> -->
<%-- 										<i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /> --%>
<!-- 									</button> -->
								</div>
								<div class="box-wrap pos-relative bg-common">
									<!-- <span class="dis-in-b pos-absolute" style="left: 16px;">可添加供应商列表：</span> -->
									<input class="dis-in-b pos-absolute contact-search" type="text"
										style="left: 16px; width: 220px; max-width: 220px; padding-right: 20px;"
										placeholder="输入查找关键字" /> <img class="dis-in-b pos-absolute"
										src="../img/icon_search.png"
										style="width: 14px; left: 244px; top: 14px;" /> <span
										class="dis-in-b pos-absolute" style="left: 345px;"><i18n:I18n
											key="i18n_common_title_alreadyaddcontact"
											defaultValue="已添加的供应商列表" />：</span>
									<div class="fl-left box-left mt-27"></div>
									<div class="fl-left box-middle mt-27">
										<p class="all-pre text-center">
											<button class="contact-option-btn button-wrap" title="全部右移">>></button>
										</p>
										<p class="all-back text-center">
											<button class="contact-option-btn button-wrap" title="全部左移"><<</button>
										</p>
									</div>
									<div class="fl-left box-right mt-27"></div>
									<div class="clear-both"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
   	</div>
<script type="text/javascript">
var initData;
var headGrid;
var itemGrid;
var rightScroll;
var leftScroll;
var toElsAccounts="";
var selector = '<base:subAccount elsAccount="${elsAccount}" type="select" role="purchase"></base:subAccount>';
var cols_head = [{title:"需求单号",name:"requirementNumber",align:"center",width:98},
                 {title:"计划期间从",name:"planDateStart",align:"center",width:150,renderer:function(){
                	 return "<input class='Wdate' onfocus='WdatePicker()' id='planDateStart' name='planDateStart'/> ";
                 }},
                 {title:"计划期间到",name:"planDateEnd",align:"center",width:150,renderer:function(){
                	 return "<input class='Wdate' onfocus='WdatePicker()' id='planDateEnd' name='planDateEnd'/> ";
                 }},
                 {title:"期间类型",name:"dateType",align:"center",width:100,renderer:function(){
                	 return "<select id='dateType' name='dateType'><option value='D'>天</option><option value='W'>周</option><option value='M'>月</option></select> ";
                 }},
                 {title:"采购计划员",name:"purchasePlaner",align:"center",width:150,renderer:function(){
                	 var t = $("<select name='purchasePlaner'></select>");
                	 t.append($(selector).html());
                	 return $("<p>").append(t).html();
                 }},
                 {title:"采购方负责人",name:"purchaseInCharge",align:"center",width:150,renderer:function(){
                	 var t = $("<select name='purchaseInCharge'></select>");
                	 t.append($(selector).html());
                	 return $("<p>").append(t).html();
                 }},
                 {title:"采购工厂",name:"puchaseFactory",align:"center",width:150,renderer:function(){
                	 return "<input name='puchaseFactory'/> ";
                 }},
                 {title:"发布时间",name:"publishDate",align:"center",width:150,renderer:function(val){
                	 return "<input class='Wdate' onfocus='WdatePicker()' name='publishDate' value='"+val+"'/> ";
                 }}];
var cols_item = [{title:"物料编号",name:"purchaseMaterialNumber",align:"center",width:90,renderer:function(){
					 return "<input name='itemList[][purchaseMaterialNumber]'/> ";
				}},{title:"物料描述",name:"purchaseMaterialDesc",align:"center",width:120,renderer:function(){
					 return "<input name='itemList[][purchaseMaterialDesc]'/> ";
				}},{title:"采购方工厂",name:"puchaseFactory",align:"center",width:100,renderer:function(){
					 return "<input name='itemList[][puchaseFactory]'/> ";
				}},{title:"采购方工厂名称",name:"puchaseFactoryName",align:"center",width:100,renderer:function(){
					 return "<input name='itemList[][puchaseFactoryName]'/> ";
				}},{title:"单位",name:"unit",align:"center",width:100,renderer:function(){
					 return "<input name='itemList[][unit]'/> ";
				}},{title:"类型",name:"requireType",align:"center",width:100,renderer:function(){
					 return "净需求数";
				}}
                 ];

$().ready(function(){
	init();
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10),closeCallback());
	});
	$("#btnPublish").click(function(){
		$('.box-right').find(".contact-people").each(function(index ,val){
			if(jQuery(this).css("display")!="none"){ 
				var textObj = JSON.parse($(this).find('.storeData').text());
				toElsAccounts+=textObj.friendElsAccount+",";
			}
		});
		if (toElsAccounts == "") {
			alert("请选择供应商",2);
			return;
		}
		toElsAccounts = toElsAccounts.substring(0,toElsAccounts.length-1);
		$("#toElsAccounts").val(toElsAccounts);
		if (itemGrid.rowsLength()==0) {
			alert("请输入需求单明细",2);
			return;
		}
		//拼装json
		var json = [];
		var itemNumber = 1;
		$("#table-item").find("tr").each(function(){
			$(this).find(".content").each(function(){
				json.push({"itemNumber":itemNumber,"date":$(this).attr("date"),"value":$(this).attr("value")});
			});
			itemNumber++;
		});
		$("#jsonStr").val(JSON.stringify(json));
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			var frm = $("#form");
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/PurchaseRequirementService/publishPurchaseRequirement",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />");
					$("#exitBtn").click();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		}});
	});
	$("#btnAdd").click(function(){
		var row = {};
		itemGrid.addRow(row,itemGrid.rowsLength());
	});
	$("#btnRemove").click(function(){
		var selectedIndexs = itemGrid.selectedRowsIndex();
		if (selectedIndexs.length == 0) {
			alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
			return;
		}
		itemGrid.removeRow(selectedIndexs[0]);
	});
	$("#btnGen").click(function(){
		var dateType = $("#dateType").val();
		var planDateStart = $("#planDateStart").val();
		var planDateEnd = $("#planDateEnd").val();
		if (planDateStart=="") {
			alert("请输入计划开始时间",2);
			return;
		}
		if (planDateEnd=="") {
			alert("请输入计划结束时间",2);
			return;
		}
		var days = DateDiff(planDateStart,planDateEnd);
		//按天不能超过30天
		if (dateType == "D" && days > 30) {
			alert("按天不能超过30天",2);
			return;
		}
		if (dateType == "W" && days > 210) {
			alert("按周不能超过30周",2);
			return;
		}
		if (dateType == "M" && days > 900) {
			alert("按月不能超过30个月",2);
			return;
		}
		var cols_gen = $.extend([],cols_item);
		var index = cols_gen.length;
		var curr = planDateStart;
		if (dateType == "D") {
			//按天填报
			while (curr <= planDateEnd) {
				var t = curr;
				cols_gen[index] = {title:curr,name:curr,align:"center",width:100,renderer:attrRenderer};
				curr = getNewDay(curr,1);
				index++
			}
		} else if (dateType == "W") {
			//按周填报
			while (curr <= planDateEnd) {
				cols_gen[index] = {title:curr,name:curr,align:"center",width:100,renderer:attrRenderer};
				curr = getNewDay(curr,7);
				index++
			}
		} else if (dateType == "M") {
			//按月填报
			while (curr <= planDateEnd) {
				cols_gen[index] = {title:curr,name:curr,align:"center",width:100,renderer:attrRenderer};
				curr = getNewDay(curr,30);
				index++
			}
		}
		$("#item-container").html('<div class="grid-100"><table id="table-item"></table></div>');
		itemGrid  = $('#table-item').mmGrid({
	        cols: cols_gen,
	        checkCol:true,
	        items:[]
	    });
	});
});
function attrRenderer(val,item,index,name) {
	return "<input class='content' date='"+name+"'/> ";
}
//初始化联系人弹窗,将联系人的列表传人
function initContact(list, dir, had) {
	if(list && list.length) {
		var oldArr = list;
		$('body').data('cacheOldArr',oldArr);
    	var txt ="";
    	if(dir == 'left') {
    		$('.box-left').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">left</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-left').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-left').find('.contact-people').eq(ind).hide();
    			}
    		}
    		leftScroll.resize();
    		
    	} 
    	else if(dir == 'right') {
    		$('.box-right').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="display:none;margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">right</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-right').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-right').find('.contact-people').eq(ind).show();
    			}
    		}
    		rightScroll.resize();
    	}
	}
};
//添加供应商信息
function initFriend(){
		$.ajax({
 			url :"<%=basePath%>rest/FriendsService/findMyFriendsByType",
 			type :"POST",
 			contentType : "application/json",
 			dataType : "json",
 			data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
 			success : function(data) {
 				var rows = data.rows;
 				for(var i = 0 ; i < rows.length ; i ++){
 					rows[i]["fromIndex"]=i;
 				}
 				//首次进入初始化
 				initContact(rows,'left');
 				initContact(rows,'right');
 			},
 			error: function (xhr, type, exception) {//获取ajax的错误信息
                 alert(xhr.responseText, "Failed"); 
        }
 		});
    rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
    leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
}
//存储临时的选择数据
var cacheData = {};
$('.contact-people').live('mouseover',function() {
	$('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact');
});
$('.contact-people').live('click',function() {
    /* $('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact'); */
    //cacheData.text = JSON.parse($(this).find('.storeData').text());
    cacheData.index = parseInt($(this).find('.people-index').text());
    cacheData.dir = $(this).find('.storeData-from').text();
    $('body').data('cachePeople',cacheData);
    var oldObj = $('body').data('cachePeople');
    if(oldObj && oldObj.dir=='left') {
    	$('.box-left').find('.contact-people').eq(oldObj.index).hide();
    	$('.box-right').find('.contact-people').eq(oldObj.index).show();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	rightScroll.resize();
   } else if(oldObj && oldObj.dir=='right') {
       	$('.box-left').find('.contact-people').eq(oldObj.index).show();
    	$('.box-right').find('.contact-people').eq(oldObj.index).hide();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	leftScroll.resize();
	}
});

$('.contact-search').keyup(function() {
	var val = $(this).val();
	var all = $('.box-left').find('p').hide();
	if(!val){
		all.show();
	} else {
		all.filter(function(index,html) {
    		var oldText=$(html).find('.friend-name').text();
    		return oldText.indexOf(val) != -1;
    	}).show();
	}
});
//选择左边全部
$('.all-pre').click(function() {
	var left =$('.box-left').find('.contact-people');
	var right =$('.box-right').find('.contact-people');
	left.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.people-index').text();
            right.eq(showInd).show();
        }
	});
	$('.box-left').find('.contact-people').hide();
	//清空临时存储的数据
	$('body').data('cachePeople','right');
	rightScroll.resize();
});
//选择右边全部
$('.all-back').click(function() {
	var left =$('.box-left').find('.contact-people');
	var right =$('.box-right').find('.contact-people');
	right.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.people-index').text();
            left.eq(showInd).show();
        }
	});
	$('.box-right').find('.contact-people').hide();
	//清空临时存储的数据
	$('body').data('cachePeople','left');
	leftScroll.resize();
});
//日期加上天数得到新的日期
//dateTemp 需要参加计算的日期，days要添加的天数，返回新的日期，日期格式：YYYY-MM-DD
function getNewDay(dateTemp, days) {
  var dateTemp = dateTemp.split("-");
  var nDate = new Date(dateTemp[1] + '-' + dateTemp[2] + '-' + dateTemp[0]); //转换为MM-DD-YYYY格式  
  var millSeconds = Math.abs(nDate) + (days * 24 * 60 * 60 * 1000);
  var rDate = new Date(millSeconds);
  var year = rDate.getFullYear();
  var month = rDate.getMonth() + 1;
  if (month < 10) month = "0" + month;
  var date = rDate.getDate();
  if (date < 10) date = "0" + date;
  return (year + "-" + month + "-" + date);
}
function closeCallback() {
	if (parent.frames["iframeApp_purchaseRequirement"]) {
		parent.frames["iframeApp_purchaseRequirement"].query();
	}
}
function init(){
	$("#sheet-project").tabs();
	initFriend();
	var headData = [{"requirementNumber":"","publishDate":new Date().format("yyyy-MM-dd")}];
	headGrid  = $('#table-head').mmGrid({
        cols: cols_head,
        height: 100,
		items:headData
    });
	itemGrid  = $('#table-item').mmGrid({
        cols: cols_item,
        checkCol:true,
		items:[]
    });
}
function  DateDiff(sDate1,  sDate2){    //sDate1和sDate2是2006-12-18格式  
    var  aDate,  oDate1,  oDate2,  iDays  
    aDate  =  sDate1.split("-")  
    oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])    //转换为12-18-2006格式  
    aDate  =  sDate2.split("-")  
    oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])  
    iDays  =  parseInt(Math.abs(oDate1  -  oDate2)  /  1000  /  60  /  60  /24)    //把相差的毫秒数转换为天数  
    return  iDays  
}    
</script>
</body>
</html>