<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="auditPreBiddingTwo.jsp"%>
<body>

<script type="text/javascript">

//----------------------投标方开始-----------------------------------------

	var initFriendTag = false
	
	var rightScroll;
	var leftScroll;
	var allFriendList;
	var selFriendList;
	var biddingSupplierVOs = [];
	var biddingSupplierListTable;
	var biddingSupplierArrays = [];
	
	$(".edit-line-invited").click(function(){//点击投标方选项卡
		$("#supplier_distinguishPhases").val("1");//默认选择标段1
		$("body").data("supplier_distinguishPhases","1");
		
		if(!initFriendTag){
			initFriend();
		}
	});
	
	function radioChange(obj,rowIndex){
		var colName = obj.name;
		$("#"+colName).val(obj.value);
	}
	
	var supplierListTableCols = [
	                        {title:'序号',name:'sequenceNumber', width: 80, align: 'center',renderer:function(val,item,rowIndex){
	                       		return rowIndex+1;
	                       	}}, 
	                       { title:'<i18n:I18n key="" defaultValue="供应商账号" />', name:'supplierAccount' ,width:100, align:'center',renderer:function(val){
	                    	    if("undefined"==typeof(val) || null == val){
	                        	    val = ""; 
	                        	}
	                    	    return '<input type="text" name="biddingSupplierVOs[][supplierAccount]" readonly="readonly" value="'+val+'" />';
	                         }},
	                       { title:'<i18n:I18n key="" defaultValue="供应商名称" />', name:'supplierDesc' ,width:100, align:'center'},
	                       { title:'<i18n:I18n key="" defaultValue="应标" />', name:'participate' ,width:160, align:'center',renderer:function(val,item,rowIndex){
	                           
	                    	   if(val=="0"){
		                   	       return '未应标&nbsp;&nbsp;<input type="checkbox" name="noAnswerBidding" id="noAnswerBidding_'+rowIndex+'" value="2" />不应标';
		                   	   }else if(val=="1"){
		                   	       return '已应标';
		                   	   }else{
		                   			return "不应标";
		                   	   }
	                         }},
	                         { title:'<i18n:I18n key="" defaultValue="报名手续" />', name:'register' ,width:120, align:'center',renderer:function(val,item,rowIndex){
	                        	 if("undefined"==typeof(val) || null == val){
	                        	     val = "1"; 
	                        	 }
	                        	 return '<input type="radio" class="radio-class" name="register_'+rowIndex+'" '+(val==0 ? 'checked':'')+' onchange="radioChange(this,'+rowIndex+')" value="0"/>完成&nbsp;&nbsp;'
			                     	   +'<input type="radio" class="radio-class" name="register_'+rowIndex+'" '+(val==1 ? 'checked':'')+' onchange="radioChange(this,'+rowIndex+')" value="1"/>未完成'
			                     	   +'<input type="hidden" name="biddingSupplierVOs[][register]" id="register_'+rowIndex+'" value="'+val+'" />';
	                         }},
	                         { title:'<i18n:I18n key="" defaultValue="资质审核" />', name:'qualify' ,width:120, align:'center',renderer:function(val,item,rowIndex){
	                        	 if("undefined"==typeof(val) || null == val){
	                        	     val = "1"; 
	                        	 }
	                        	 return '<input type="radio" class="radio-class" name="qualify_'+rowIndex+'" '+(val==0 ? 'checked':'')+' onchange="radioChange(this,'+rowIndex+')" value="0"/>通过&nbsp;&nbsp;'
		                     	   	   +'<input type="radio" class="radio-class" name="qualify_'+rowIndex+'" '+(val==1 ? 'checked':'')+' onchange="radioChange(this,'+rowIndex+')" value="1"/>不通过'
		                     		   +'<input type="hidden" name="biddingSupplierVOs[][qualify]" id="qualify_'+rowIndex+'" value="'+val+'" />';
	                         }},
	                         { title:'<i18n:I18n key="" defaultValue="保证金" />', name:'guaranty' ,width:120, align:'center',renderer:function(val,item,rowIndex){
	                        	 if("undefined"==typeof(val) || null == val){
	                        	     val = "1"; 
	                        	 }
	                        	 return '<input type="radio" class="radio-class" name="guaranty_'+rowIndex+'" '+(val==0 ? 'checked':'')+' onchange="radioChange(this,'+rowIndex+')" value="0"/>已缴纳&nbsp;&nbsp;'
		                     	   	   +'<input type="radio" class="radio-class" name="guaranty_'+rowIndex+'" '+(val==1 ? 'checked':'')+' onchange="radioChange(this,'+rowIndex+')" value="1"/>未缴纳'
		                     		   +'<input type="hidden" name="biddingSupplierVOs[][guaranty]" id="guaranty_'+rowIndex+'" value="'+val+'" />';
	                         }},
	                         { title:'<i18n:I18n key="" defaultValue="招标文件" />', name:'getDoc' ,width:120, align:'center',renderer:function(val,item,rowIndex){
	                        	 if("undefined"==typeof(val) || null == val){
	                        	     val = "1"; 
	                        	 }
	                        	 return '<input type="radio" class="radio-class" name="getDoc_'+rowIndex+'" '+(val==0 ? 'checked':'')+' onchange="radioChange(this,'+rowIndex+')" value="0"/>已领&nbsp;&nbsp;'
		                     	   	   +'<input type="radio" class="radio-class" name="getDoc_'+rowIndex+'" '+(val==1 ? 'checked':'')+' onchange="radioChange(this,'+rowIndex+')" value="1"/>未领取'
		                     		   +'<input type="hidden" name="biddingSupplierVOs[][getDoc]" id="getDoc_'+rowIndex+'" value="'+val+'" />';
	                         }},
	                         { title:'<i18n:I18n key="" defaultValue="投标情况" />', name:'bidding' ,width:100, align:'center',renderer:function(val){
			                     if(val!="1"){
			                    	 return "未投标";
			                     }else{
			                    	 return "已投标";
			                     }
	                         }},
	                         { title:'<i18n:I18n key="" defaultValue="开标到场" />', name:'present' ,width:100, align:'center',renderer:function(val){
			                     if(val!="1"){
			                    	 return "未到场";
			                     }else{
			                    	 return "已到场";
			                     }
	                         }},
	                         { title:'<i18n:I18n key="" defaultValue="中标情况" />', name:'win' ,width:100, align:'center',renderer:function(val){
			                     if(val!="1"){
			                    	 return "未中标";
			                     }else{
			                    	 return "已中标";
			                     }
	                         }}
	                 ];
	
	function getBiddingSupplierVOs(){
		for (var i = 0; i < biddingSupplierVOs.length; i++) {
			biddingSupplierVOs[i].supplierAccount = biddingSupplierVOs[i].friendElsAccount;
			biddingSupplierVOs[i].supplierDesc = biddingSupplierVOs[i].friendCompanyName;
		}
		return biddingSupplierVOs;
	}
	
	function setBiddingSupplierVOs(vos){
		for (var i = 0; i < vos.length; i++) {
			vos[i].friendElsAccount = vos[i].supplierAccount;
			vos[i].friendCompanyName = vos[i].supplierDesc;
		}
		biddingSupplierVOs=vos;
	}

	function getSelectedSupplier() {
		var storeNewArr = $('.box-right').find(".contact-people:visible");
		console.log(storeNewArr);
		var lastArr = [];
		if (storeNewArr && storeNewArr.length) {
			for (var i = 0; i < storeNewArr.length; i++) {
				var textObj = JSON.parse($(storeNewArr[i]).find('.storeData').text());
				lastArr.push(textObj);
			}
		}
		return lastArr;
	}
	
	function setSelectedSupplier(vos){		
		initContact(allFriendList,'left',vos);
		initContact(allFriendList,'right',vos);
	}
	
	function getBasicBiddingSupplierVO(){
		var formObj = $("#form").serializeJSON();
		var multiSection = $("input[name='biddingSupplierVO[multiSection]']:checked").val();//是否区分标段radio按钮0：不区分、1：区分
		var supplier_distinguishPhases = $('#supplier_distinguishPhases').val();//标段划分select下拉框0：不区分
		formObj["biddingSupplierVO"]={
			multiSection:multiSection,
			biddingItemNumber:supplier_distinguishPhases
		};	
		return formObj.biddingSupplierVO;
	}
	
	function storeSupplierToCache(){//存储供应商到缓存
		
		var biddingSupplierVO = getBasicBiddingSupplierVO();
		
		var multiSection = biddingSupplierVO.multiSection;//是否区分标段
		var biddingItemNumber = biddingSupplierVO.biddingItemNumber;//获取标段
		
		clearSupplierFromCache();
		
		var vos = getSelectedSupplier();//获取选择的供应商对象
		
		for (var i = 0; i < vos.length; i++) {//给选择的供应商拼凑是否区分标段与标段值
			vos[i].multiSection = multiSection;
			vos[i].biddingItemNumber = biddingItemNumber;
			vos[i]['supplierAccount'] = vos[i].friendElsAccount;
			vos[i]['supplierDesc'] = vos[i].friendCompanyName;
			biddingSupplierVOs.push(vos[i]);
		}
	}
	
	function getSupplierFromCash(biddingItemNumber){
		if(!biddingItemNumber){
			var biddingSupplierVO = getBasicBiddingSupplierVO();

			biddingItemNumber = biddingSupplierVO.biddingItemNumber;//获取标段			
		}
		var vos = [];
		for (var i = 0; i < biddingSupplierVOs.length; i++) {
			if(biddingSupplierVOs[i].biddingItemNumber==biddingItemNumber){				
				vos.push(biddingSupplierVOs[i]);
			}
		}	
		return vos;
	}
	
	function loadSupplierFromCash(){
		setSelectedSupplier(getSupplierFromCash());
	}
	
	function clearSupplierFromCache(){
		
		var biddingSupplierVO = getBasicBiddingSupplierVO();
		
		var multiSection = biddingSupplierVO.multiSection;//是否区分标段
		var biddingItemNumber = biddingSupplierVO.biddingItemNumber;//获取标段
		
		var vos = [];
		
		for (var i = 0; i < biddingSupplierVOs.length; i++) {
			if(biddingSupplierVOs[i].biddingItemNumber!=biddingItemNumber){
				vos.push(biddingSupplierVOs[i]);
			}
		}
		
		biddingSupplierVOs = vos;
	}
	
	//添加供应商信息
	function initFriend() {
		$.ajax({
			url : "<%=basePath%>rest/FriendsService/findMyFriendsByType",
 			type :"POST",
 			contentType : "application/json",
 			dataType : "json",
 			data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
 			success : function(data) {
 				allFriendList = data.rows;
 				for(var i = 0 ; i < allFriendList.length ; i ++){
 					allFriendList[i]["fromIndex"]=i;
 				}
 				//首次进入初始化
 				initContact(allFriendList,'left');
 				initContact(allFriendList,'right');
 				
 				loadSupplierFromCash();
 			},
 			error: function (xhr, type, exception) {//获取ajax的错误信息
                 alert(xhr.responseText, "Failed"); 
        }
 		});
    rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
    leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
    
    if(!biddingSupplierListTable){

        biddingSupplierListTable = $('#supplier_list_table').mmGrid({
    	    cols: supplierListTableCols,
    	    items:getSupplierFromCash($("#supplier_section_list").val()),
    	    height: 240,
    	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
    	});
    }else{
    	var vos=getSupplierFromCash($("#supplier_section_list").val());
    	biddingSupplierListTable.load(vos)
    }

	var biddingPhases = $("#biddingPhases").val();
	
	$("#supplier_distinguishPhases").html(""); 
	$("#supplier_section_list").html(""); 
	
	if(biddingPhases == "1"){//不区分标段
		$("input[name='biddingSupplierVO[multiSection]']").eq(0).attr("checked",'checked');
		$("input[name='biddingSupplierVO[multiSection]']").attr("disabled",true);
	    $("#supplier_distinguishPhases").attr("disabled",true);
	    
		var option = '<option value="0">不划分标段</option>';
		$("#supplier_distinguishPhases").append(option);
		$("#supplier_section_list").append(option);
	    
	}else{
		$("input[name='biddingSupplierVO[multiSection]']").eq(1).attr("checked",'checked');
		var items = $("#form").serializeJSON().biddingPhasesItems;
		
		if(items && items.length>0){
			$("#supplier_distinguishPhases").html("");//标段select 
			$("#supplier_section_list").html(""); //标段select 
			for(var i = 0 ; i < items.length ; i ++){
				var item = items[i];
				var biddingItemName = item.biddingItemName;
				var biddingItemNumber = item.biddingItemNumber;
				var option = '<option value="'+biddingItemNumber+'">标段'+biddingItemNumber+" "+biddingItemName+'</option>';
				$("#supplier_distinguishPhases").append(option);
				$("#supplier_section_list").append(option);
			}
			$("#supplier_distinguishPhases").val("1");//默认选择标段1
			$("body").data("supplier_distinguishPhases","1");
			$("#supplier_distinguishPhases option[value='0']").attr("disabled",true);
		
		}
	}
    
    initFriendTag=true;
};



//区分不区分标段，radio 单击事件
$("input[name='biddingSupplierVO[multiSection]']").click(function(){
	var val = $(this).val();
	if(val == "0"){ //不区分标段
		$("#supplier_distinguishPhases").attr("disabled",true);
		$("#supplier_distinguishPhases").val("0");//设置为不区分标段
	}else{
		$("#supplier_distinguishPhases").attr("disabled",false);
		$("#supplier_distinguishPhases").val("1");//设置为标段1
	}
});
$('#supplier_distinguishPhases').live('blur',function() {
	var vos=getSupplierFromCash($("body").data("supplier_distinguishPhases"));
	biddingSupplierListTable.load(vos);
});
//标段下拉改变事件
$("#supplier_distinguishPhases").change(function(){
	loadSupplierFromCash();
});

$("#supplier_section_list").change(function(){
	
	var formObj = $("#form").serializeJSON();
	var biddingSupplierVOs = formObj.biddingSupplierVOs;
	var biddingItemNumber = $("body").data("supplier_distinguishPhases");//获取标段---原标段
	var currentBiddingItemNumber = $(this).val();//获取标段---将要切换成的标段
	
	var vos=getSupplierFromCash($(this).val());
	
	if(biddingSupplierVOs && typeof(biddingSupplierVOs) != "undefined" && biddingSupplierVOs.length > 0){
		for(var i=0;i<biddingSupplierVOs.length;i++){
			biddingSupplierVOs[i]["biddingItemNumber"]=biddingItemNumber;
		}
		biddingSupplierArrays[biddingItemNumber]=biddingSupplierVOs;
	}
	var biddingSupplierVOsTemp = biddingSupplierArrays[currentBiddingItemNumber];
	
	if(biddingSupplierVOsTemp && typeof(biddingSupplierVOsTemp) != "undefined" && biddingSupplierVOsTemp.length > 0){
		for(var i=0;i<vos.length;i++){
			vos[i]["register"]=biddingSupplierVOsTemp[i].register;
			vos[i]["qualify"]=biddingSupplierVOsTemp[i].qualify;
			vos[i]["guaranty"]=biddingSupplierVOsTemp[i].guaranty;
			vos[i]["getDoc"]=biddingSupplierVOsTemp[i].getDoc;
		}
		biddingSupplierListTable.load(vos);
	}else{
		biddingSupplierListTable.load(vos);
	}
	$("body").data("supplier_distinguishPhases",$(this).val());//存入当前的标段
});
$("div .mmg-bodyWrapper").click(function(){
	var itemNumber = $("#supplier_section_list").find("option:selected").val();
	var vos=getSupplierFromCash(itemNumber);
	biddingSupplierListTable.load(vos);
});

//存储临时的选择数据
var cacheData = {};
$('.contact-people').live('mouseover',function() {
	$('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact');
});
$('.contact-people').live('click',function() {//点击好友框好友时触发事件
    cacheData.index = parseInt($(this).find('.people-index').text());
    cacheData.dir = $(this).find('.storeData-from').text();
    $('body').data('cachePeople',cacheData);
    var oldObj = $('body').data('cachePeople');
    if(oldObj && oldObj.dir=='left') {
    	$('.box-left').find('.contact-people').eq(oldObj.index).hide();
    	$('.box-right').find('.contact-people').eq(oldObj.index).show();
    	//清空临时存储的数据
    	$('body').data('cachePeople','');
    	rightScroll.resize();
   } else if(oldObj && oldObj.dir=='right') {
	       	$('.box-left').find('.contact-people').eq(oldObj.index).show();
	    	$('.box-right').find('.contact-people').eq(oldObj.index).hide();
	    	//清空临时存储的数据
	    	$('body').data('cachePeople','');
	    	leftScroll.resize();
	}
    
    storeSupplierToCache();//存储供应商到缓存
});

//初始化联系人弹窗,将联系人的列表传人
function initContact(list, dir, had) {
	
	if (list && list.length) {
		var oldArr = list;
		$('body').data('cacheOldArr', oldArr);
		var txt = "";
		if (dir == 'left') {
			$('.box-left').html('');
			for (var i = 0; i < oldArr.length; i++) {
				var ifShow = "block";
				if (had && had.length) {
					for (var j = 0; j < had.length; j++) {
						if (oldArr[i].friendElsAccount == had[j].friendElsAccount) {
							ifShow = "none";
						}
					}
				}
				txt += '<p class="contact-people" style="display:'+ifShow+';margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">left</span><span class="people-index">'
						+ oldArr[i].fromIndex
						+ '</span><span class="storeData">'
						+ JSON.stringify(oldArr[i])
						+ '</span><span class="friend-name">'
						+ oldArr[i].friendElsAccount
						+ "_"
						+ oldArr[i].friendCompanyName + '</span></p>';
			}
			$('.box-left').append(txt);
			leftScroll.resize();
		} else if (dir == 'right') {
			$('.box-right').html('');
			for (var i = 0; i < oldArr.length; i++) {
				var ifShow = "none";
				if (had && had.length) {
					for (var j = 0; j < had.length; j++) {
						if (oldArr[i].friendElsAccount == had[j].friendElsAccount) {
							ifShow = "block";
						}
					}
				}
				txt += '<p class="contact-people" style="display:'+ifShow+';margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">right</span><span class="people-index">'
						+ oldArr[i].fromIndex
						+ '</span><span class="storeData">'
						+ JSON.stringify(oldArr[i])
						+ '</span><span class="friend-name">'
						+ oldArr[i].friendElsAccount
						+ "_"
						+ oldArr[i].friendCompanyName + '</span></p>';
			}
			$('.box-right').append(txt);
			rightScroll.resize();
		}
	}
};

//模糊匹配
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
	
	storeSupplierToCache();
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
	
	storeSupplierToCache();
});

//---------------------------资质审核开始----------------------------------------------------

var initQualifyTag = false;
var biddingApplicationInfos = [];

$(".edit-line-qualify").click(function(){
	if(!initQualifyTag){
		initQualifyGrid();
	}
});

function formatDate(val){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	     return val;
}

function viewApplyInfo(item){
	
}

function getBiddingApplicationVOs(){
	var formObj = $("#form").serializeJSON();
	return formObj.biddingApplicationInfos;
}

var qualifyTableCols = [
                        {title:'序号',name:'sequenceNumber', width: 80, align: 'center',renderer:function(val,item,rowIndex){
                       		return rowIndex+1;
                       	}}, 
                       { title:'<i18n:I18n key="" defaultValue="供应商账号" />', name:'supplierAccount' ,width:100, align:'center', renderer:function(val){
                           return val+"<input name='biddingApplicationInfos[][supplierAccount]' style='display:none;'  type='text' value='"+val+"'/>";
                       }},
                       { title:'<i18n:I18n key="" defaultValue="供应商名称" />', name:'supplierDesc' ,width:100, align:'center'},
                       { title:'<i18n:I18n key="" defaultValue="报名日期" />', name:'createDate' ,width:100, align:'center',renderer:formatDate},
                       { title:'<i18n:I18n key="" defaultValue="报名信息" />', name:'supplierDesc' ,width:100, align:'center',renderer:function(val){
		                     return "<a onclick='viewApplyInfo(this)'>查看报名信息</a>";
                         }},
                       { title:'<i18n:I18n key="" defaultValue="审核" />', name:'auditStatus' ,width:100, align:'center',renderer:function(val){
                    	   return "<select name='biddingApplicationInfos[][auditStatus]' ><option value='0' " + (val=="0"?"selected":"")
                    	   + ">未审核</option><option value='1' " + (val=="1"?"selected":"") 
                    	   + ">通过</option><option value='2' " + (val=="2"?"selected":"") + ">不通过</option></select>";
                        }},
                       { title:'<i18n:I18n key="" defaultValue="审核人" />', name:'auditUser' ,width:100, align:'center'},
                       { title:'<i18n:I18n key="" defaultValue="审核日期" />', name:'auditDate' ,width:100, align:'center',renderer:formatDate},
        			   { title:'<i18n:I18n key="" defaultValue="备注" />', name:'remark' ,width:300, align:'center'}
                 ];

function initQualifyGrid(){
	


/* 	qualifyData = [];
	qualifyData.push({elsAccount:'105012',toElsAccount:'105012',biddingNumber:'201600001',supplierAccount:'105159',supplierDesc:'A公司',unitedAccount:'105160',unitedDesc:'B公司',createDate:'2016-11-30 15:30:00',auditDate:'2016-6-30 15:30:00',auditUser:'1001_张三',auditStatus:'0'});
	qualifyData.push({elsAccount:'105012',toElsAccount:'105012',biddingNumber:'201600001',supplierAccount:'105161',supplierDesc:'C公司',unitedAccount:'',unitedDesc:'',createDate:'2016-11-30 15:30:00',auditDate:'2016-6-30 15:30:00',auditUser:'1001_张三',auditStatus:'1'});
	qualifyData.push({elsAccount:'105012',toElsAccount:'105012',biddingNumber:'201600001',supplierAccount:'105162',supplierDesc:'D公司',unitedAccount:'',unitedDesc:'',createDate:'2016-11-30 15:30:00',auditDate:'2016-6-30 15:30:00',auditUser:'1001_张三',auditStatus:'2'});
	
	qualifyTable = $('#qualify-table').mmGrid({
	    cols: qualifyTableCols,
	    //items:qualifyData,
	    height: 240,
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
	}); */
	
	initQualifyTag=true;
	
}
function closeCallback() {
	if (parent.frames["iframeApp_auditList"]) {
		parent.frames["iframeApp_auditList"].query();
	}
}
</script>
</body>
</html>