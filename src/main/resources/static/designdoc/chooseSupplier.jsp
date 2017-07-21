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
        <div class="common-box-line">
		    <button id="btnOK" class="button-wrap">确定</button>
		</div>
    </div>
	<div class="box-wrap pos-relative bg-common">
		<div class="common-box-line">
			<div class="supplie-groud">
				<div class="bg-common contacts-box">
					<div class="tip-head pos-relative">
						<span class="dialogTitle"><i18n:I18n key="i18n_common_title_xxx" defaultValue="添加供应商" /></span>
					</div>
					<div class="box-wrap pos-relative bg-common">
						<input class="dis-in-b pos-absolute contact-search" type="text"
							   style="left: 16px; width: 220px; max-width: 220px; padding-right: 20px;"
							   placeholder="输入查找关键字" /> 
						<img class="dis-in-b pos-absolute"
							 src="../img/icon_search.png"
							 style="width: 14px; left: 244px; top: 14px;" /> 
							 <span class="dis-in-b pos-absolute" style="left: 345px;">
							 <i18n:I18n key="i18n_common_title_sxxxxontact" defaultValue="已添加的供应商列表" />：</span>
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
<script type="text/javascript">
var rightScroll;
var leftScroll;
var toElsAccounts="";
var winId = "<%= request.getParameter("winId") %>";
$().ready(function(){
	initFriend();
	$("#btnOK").click(function(){
		var list = new Array();
		$('.box-right').find(".contact-people").each(function(index ,val){
			if(jQuery(this).css("display")!="none"){ 
				var textObj = JSON.parse($(this).find('.storeData').text());
				list.push(textObj);
			}
		});
		if (list.length > 0)
			parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10),closeCallback(list));
		else
			alert("未选择任何供应商",2);
	});
});
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
function closeCallback(toElsAccounts) {
	var $frame = parent.frames["iframeApp_assignDesignDoc"];
	if(winId != null && winId != "" && winId != "null"){
		$frame = parent.frames["iframeApp_"+winId];
	}
	$frame.fillSaleGrid(toElsAccounts);
}  
</script>
</body>
</html>