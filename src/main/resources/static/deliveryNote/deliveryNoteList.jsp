<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="SameBtn">
					<i18n:I18n key=" " defaultValue="同步" />
				</button>
				<button class="button-wrap" id="btnCreate">
					<i18n:I18n key=" " defaultValue="新建" />
				</button>
				<button class="button-wrap" id="saveBtn">
					<i18n:I18n key=" " defaultValue="保存" />
				</button>
				<button class="button-wrap" id="sendBtn">
					<i18n:I18n key=" " defaultValue="发送" />
				</button>
				<button class="button-wrap" id="deleteBtn">
					<i18n:I18n key=" " defaultValue="删除" />
				</button>
				<button id="downloadBtn" class="button-wrap"><i18n:I18n key="" defaultValue="导出EXCEL" /></button>
				<button id="caculatorBtn" class="button-wrap"><i18n:I18n key="" defaultValue="测试交期考核" /></button>
				<button id="headcolumnDefineBtn" class="button-wrap">
					<i18n:I18n key="test" defaultValue="列自定义" />
				</button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<form id="form">
					<input name="elsAccount" type="hidden" value="${elsAccount }" />
					<input name="deleteFlag" type="hidden" value="N" />
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="送货通知单号" />：</span><input
							id="deliveryNoteNo" name="deliveryNoteNo" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="物料号或描述" />：</span><input
							id="purchaseMaterialNumber" name="purchaseMaterialNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="供应商" />：</span><input
							id="toElsAccount" name="toElsAccount" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="收货联系人或地址" />：</span><input
							id="userName" name="userName" type="text" />
					</div>
					<div id="div-fbk4"  class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="采购负责人" />：</span>
						<input id="fbk4Param" name="fbk4Param" type="hidden" />
						<span id="fbk4Selector"></span>
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="发送状态" />：</span> <select
							id="sendStatus" name="sendStatus">
							<option value=""><i18n:I18n key=" " defaultValue="全部" /></option>
							<option value="0"><i18n:I18n key=" " defaultValue="未发送" /></option>
							<option value="1" ><i18n:I18n key=" " defaultValue="已发送" /></option>
						</select>
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="确认状态" />：</span> <select
							id="confirmStatus" name="confirmStatus">
							<option value=""><i18n:I18n key=" " defaultValue="全部" /></option>
							<option value="0"><i18n:I18n key=" " defaultValue="待回复" /></option>
							<option value="1"><i18n:I18n key=" " defaultValue="待确认" /></option>
							<option value="2" ><i18n:I18n key=" " defaultValue="接受" /></option>
							<option value="3" ><i18n:I18n key=" " defaultValue="重回" /></option>
							<option value="4" ><i18n:I18n key=" " defaultValue="拒绝" /></option>
						</select>
					</div>
					<div class="dis-in-b input-and-tip">
					    <span><i18n:I18n key="" defaultValue="要求交期" />：</span>
					    <input type="text" class="Wdate" onfocus="WdatePicker()" id="deliveryNoteTimeBegin" name="deliveryNoteTimeBegin"/>
					 </div>
	                <div class="dis-in-b input-and-tip">
	                    <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                    <input type="text"  class="Wdate" onfocus="WdatePicker()" id="deliveryNoteTimeEnd" name="deliveryNoteTimeEnd"/>
	                </div>&nbsp;&nbsp;&nbsp;
	                <div class="dis-in-b input-and-tip">
	                    <span><i18n:I18n key="" defaultValue="查看失效的通知单" /></span>
	                    <input type="checkbox" id="isValidity" name="isValidity" value="X"/>
	                </div>&nbsp;&nbsp;&nbsp;
	                <div class="dis-in-b input-and-tip">
	                    <span><i18n:I18n key="" defaultValue="查看超期未回复的通知单" /></span>
	                    <input type="checkbox" id="isOutValidUntil" name="isOutValidUntil" value="X"/>
	                </div>&nbsp;&nbsp;&nbsp;
	                <div class="dis-in-b input-and-tip">
	                    <span><i18n:I18n key="" defaultValue="回复一致的清单" /></span>
	                    <input type="checkbox" id="isReplyAgreed" name="isReplyAgreed" value="X"/>
	                </div>&nbsp;
					<button class="button-wrap" type="button" style="margin-left: 2%" id="seachBtn">
						<i18n:I18n key="i18n_common_button_query" defaultValue="查询" />
					</button>
				</form>
			</div>
		</div>
		<form id="frm" onsubmit="return false;">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key=" " defaultValue="送货通知单" /></span>
				<div class="common-box-line">
					<div class="tab-wrap" id="sheet-head">
						<div id="sheet-item-one">
							<div class="grid-container">
								<div class="grid-100" id="deliveryNoteHeaderGrid">
									<table id="deliveryNoteHeaderTable"></table>
									<div id="pg" style="text-align: right;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div class="saying-dialog">
            <div class="fl-left left-content pos-relative">
                <div class="dis-block pos-absolute option-bar pre-active next"></div>
            </div>
            <div class="fl-left right-content pos-relative none-active">
                <div class="saying-box-wrap">
                   <iframe class="testIframe" id="chatIframe" frameborder="0" width="100%">
                   </iframe>
                </div>
            </div>
            <div class="clear-both"></div>
        </div>

<div class="fixed-dialog" id="createDeliveryNoteDialog">
           <div class="dialog-tip bg-common" style="width: 362px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="createDeliveryNoteClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="" defaultValue="新建送货通知单" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                     <form id="batchSetForm" onsubmit="return false;">
                       <div class="common-box-line" >
                           <div class="input-and-tip">
	                         <span>新建类型：</span>
	                         <select id="deliveryNoteType" name="deliveryNoteType">
	                             <option value="0">物料</option>
	                             <option value="1">订单</option>
	                         </select>
	                       </div>
	                       <div class="input-and-tip material">
	                         <span>物料编码：</span>
	                         <input class="easyui-textbox"  name="materialNumber" id="create_materialNumber" type="text" />
	                       </div>
	                       <div class="input-and-tip order">
	                         <span>订单号：</span>
	                         <input class="easyui-textbox"  name="purchaseOrderNumber" id="create_purchaseOrderNumber" type="text" />
	                       </div>
	                       <div class="input-and-tip order" >
	                         <span>订单行号：</span>
	                         <input class="easyui-textbox"  name="orderItemNumber" id="create_orderItemNumber" type="text" />
	                       </div>
	                       <div class="input-and-tip">
	                         <span>需求数量：</span>
	                         <input class="easyui-textbox"  name="quantity" id="create_quantity" type="text" onkeyup="value=value.replace(/[^(\d\.)]/g,'')"/>
	                       </div>
	                       <div class="input-and-tip deliveryDate-show">
	                         <span>需求日期：</span>
	                         <input name="deliveryDate" id="create_deliveryDate" class="Wdate" onfocus="WdatePicker({minDate: '%y-%M-%d' })" type="text" />
	                       </div>
	                       <div class="input-and-tip deliveryDate-show">
	                         <span>回复有效期至：</span>
	                         <input name="validUntil" id="create_validUntil" class="Wdate" onfocus="WdatePicker({minDate: '%y-%M-%d' })" type="text" />
	                       </div>
	                       <div class="mt-20 text-center">
	                          <button id="createOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                      <button id="createCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
	                     </form>
                       </div>
                   </div>
               </div>
        </div>
</div>

<div class="fixed-dialog" id="selectDialog">
           <div class="dialog-tip bg-common" style="width: 402px;height: auto; margin-left: -161px;margin-top: -190px;">
               <div class="dialog-close-btn" id="selectClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="" defaultValue="同步送货通知单" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                     <form id="selectForm" onsubmit="return false;">
                       <div class="common-box-line" >
                            <div class="input-and-tip">
                               <span>物料编号:</span>
                               <input id="materialNumber" name="materialNumber" type="text" />
                            </div>
	                       <div class="mt-20 text-center">
	                          <button id="selectOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                      <button id="selectCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
	                     </form>
                       </div>
                   </div>
             </div>
       </div>	

<script type="text/javascript">
var deliveryNoteNo;
var itemGrid;
var sendStatus;
var pageData;
var peopleList;
var toElsAccount = "";
var selector = '<base:subAccount role='purchase' elsAccount='${elsAccount }' type='multiple' id='fbk4' ></base:subAccount>';
	
var cols_item =<base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="deliveryNoteDetail_mt"/>;

var $sob;
var chatFromUrlFlag = false;
$(document).ready(function() {
	$sob = $('.saying-dialog .option-bar');
	//initChat();
	 $("#fbk4Selector").html(selector);
	 $("#fbk4").val(elsSubAccount + "_" + username);
	 $("#fbk4").attr("placeholder",'<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />');
	 $("#fbk4").SumoSelect({optAfter:'#div-fbk4',optCancel:'#div-fbk4 .mmg-bodyWrapper', placeholder: '<i18n:I18n key="i18n_common_select_all" defaultValue="全部" />'});
	 $(".SlectBox").each(function(){
			$(this).css({ "padding-top": "0",
			              "padding-bottom": "0",
			              "line-height": "20px",
			              "height": "21px",
			              "font-size": "12px",
			              "max-width": "150px",
			              "border-radius": "2px"
			              });
		});
	   var fbk4Param = $("#fbk4").val();
	   $("#fbk4Param").val(fbk4Param);
	 
		initData();
		//同步
		$("#SameBtn").click(function(){
			$("#materialNumber").val("")
			$("#selectDialog").show();
		});
		$("#selectClose").click(function(){
			$("#selectDialog").hide();
		});

		$("#selectCancel").click(function(){
			$("#selectDialog").hide();
		});
		//送检弹出框确认操作
		$("#selectOK").click(function(){
			SimpleDeleteDeliveryNote();
		});
		//查询
		$("#seachBtn").click(function(){
			query();
		});
		
		//新建
		$("#btnCreate").click(function(){
			$("#create_materialNumber").val("");
			$("#create_quantity").val("");
			$("#create_deliveryDate").val("");
			$("#create_validUntil").val("");
			$("#create_purchaseOrderNumber").val("");
			$("#create_orderItemNumber").val("");
			$("#deliveryNoteType").val(0);
			$(".order").hide();
			$("#createDeliveryNoteDialog").show();
		});
		//取消
		$("#createCancel").click(function(){
			$("#createDeliveryNoteDialog").hide();
		});
		$("#createOK").click(function(){
			carateDeliverNote();
		});
		//修改创建类型
		$("#deliveryNoteType").change(function(){
            var val = $(this).val();
            if(val == 0){
            	$(".order").hide();
            	$(".material").show();
            }else{
            	$(".order").show();
            	$(".material").hide();
            }
		});
		//关闭
		$("#createDeliveryNoteClose").click(function(){
			$("#createDeliveryNoteDialog").hide();
		});
		
		$("#isValidity").click(function(){
			query();
		});
		$("#isOutValidUntil").click(function(){
			query();
		});
		$("#isReplyAgreed").click(function(){
			query();
		});
		$('body').data("checkAllFlag",true);
});
//初始化聊天窗口
//ELS账号+订单号 作为 businessID
function initChat(businessID,fbk1, hadSelected) {
		if (toElsAccount == "") {
			$('.testIframe').attr('src','');
			return;
		}
		toElsAccount = hadSelected[0].toElsAccount;
		//采购凭证号
		var purchaseOrderNumberList = [];
		//订单号
		var bIdList = [];
		//聊天显示列表
		var chatList = [];
		if(hadSelected && hadSelected.length) {
			hadSelected.forEach(function(d,i){
				var obj ={};
				obj[d.purchaseOrderNumber] = d.fbk1 || '' ;
				bIdList.push(obj); 
				chatList.push(d.purchaseOrderNumber);
			});
			chatList=chatList.map(function(d){
				return {name:d}
			}); 
		};
		//初始化iframe
		 var toElsSubAccount;
		 //fbk5 为对方负责人
		/* if(!fbk5 || fbk5===null|| !businessID || businessID===null){
			toElsSubAccount="";
		}else{
			toElsSubAccount=fbk5.split("_")[0];
			
		} */
	  	//多人聊天  type=multi 一对一 type=single  list 用来显示列表人
	  	bIdString = bIdList&&bIdList.length?'['+bIdList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	chatListString = chatList&&chatList.length?'['+chatList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	var url = "multiChatTest.jsp?type=multi&fromElsAccount="
				+ elsAccount
				+ "&fromElsSubAccount="
				+ elsSubAccount
				+ "&toElsAccount="
				+ toElsAccount
				+ "&toElsSubAccount="+peopleListString
				+ "&businessType=order"
				+ "&businessID="+bIdString
          + "&list="+ (chatListString&&chatListString.length?chatListString : peopleListString)
				+"&t="+new Date().getTime();
	   
	   $('.testIframe').attr('src','<%=basePath%>'+ url);
	   //滚动条美化niceScroll
	   $('.public-wrap').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
}

function query(){
    var fbk4Param = $("#fbk4").val();
	$("#fbk4Param").val(fbk4Param);
	var frm = $("#form");
	itemGrid.opts.params = frm.serializeJSON();
	itemGrid.load({page:1});
}

function operation(val,item,index){
	
	if(item.toElsAccount && item.sendStatus == 0 && item.isValidity == 0){
		var name = "confirmStatus_"+index;
		var id0 = name+"_0";
		var id1 = name+"_1";
		var id2 = name+"_2";
		var checked0 = '';
		var checked1 = '';
		var checked2 = '';
        var confirmStatus = item.confirmStatus;
        if(confirmStatus == "2" || confirmStatus == "1"){
        	checked0 = ' checked="checked"';
        }else if(confirmStatus == "3"){
        	checked1 = ' checked="checked"';
        }else if(confirmStatus == "4"){
        	checked2 = ' checked="checked"';
        }
		var text = '<div style="text-align:left;min-width: 160px; margin:0 auto;style="position: absolute;"">'
			+'<input type="radio" name="'+name+'" id="'+id0+'" '+checked0+' value="2" style="width: 14px !important; display:inline-block; margin-left:5px !important;" />'
			+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
			+'<label style="display:inline-block; margin-left:22px; font-size:12px;">接受</label>'
			+'<input type="radio" name="'+name+'" id="'+id1+'" '+checked1+' value="3" style="width: 14px !important; margin-left: 55px !important;display:inline-block;" />'
			+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
			+'<label style="display:inline-block; margin-left:25px; font-size:12px;">重回</label>'
			+'<input type="radio" name="'+name+'" id="'+id2+'" '+checked2+' value="4" style="width: 14px !important; margin-left: 105px !important;display:inline-block;" />'
			+'<span style="display: none;">'+JSON.stringify(item)+'</span>'
			+'<label style="display:inline-block; margin-left:27px; font-size:12px;">拒绝</label>'
			+'</div>';
			return text;
	}
	return "";
}

function rendPurchaseGroup(val,item,index){
	if(!val){val=""}
	if(item.orgDesc){
		return val+"-"+item.orgDesc;
	}else{
		return val;
	}
}

//渲染输入框
function initInputDouble(val,item,index){
	if(!val) { val = '';}
	var name = $(this)[0].name;
	var isValidity = item.isValidity;//是否有效，0有效，1失效
	var confirmStatus = item.confirmStatus;//0:待回复,1:待确认,2:接受,3:重回,4:拒绝,5:未匹配到供应商
	var validUntil = item.validUntil; //有效期至
	var isOutValid = isOutValidUntil(validUntil);
	if(isValidity == "0" && confirmStatus == "0" && isOutValid){
	   return '<input  onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 14px;"  name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}else{
		return val+'<input style="display: none;" name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}
}

function initEditInput(val,item,index){
	if(!val) { val = '';}
	var name = $(this)[0].name;
	var isValidity = item.isValidity;//是否有效，0有效，1失效
	var confirmStatus = item.confirmStatus;//0:待回复,1:待确认,2:接受,3:重回,4:拒绝,5:未匹配到供应商
	var validUntil = item.validUntil; //有效期至
	var isOutValid = isOutValidUntil(validUntil);
	if(isValidity == "0" && confirmStatus == "0" && isOutValid){
	   return '<input  style="width:46px;height: 14px;"  name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}else{
		return val+'<input style="display: none;" name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}
}
 
function initInputDate(val,item,index){
	if(!val) { val = '';}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	var name = $(this)[0].name;
	var isValidity = item.isValidity;//是否有效，0有效，1失效
	var confirmStatus = item.confirmStatus;//0:待回复,1:待确认,2:接受,3:重回,4:拒绝,5:未匹配到供应商
	var validUntil = item.validUntil; //有效期至
	var isOutValid = isOutValidUntil(validUntil);
	if(isValidity == "0" && confirmStatus == "0" && isOutValid){
	    return '<input class="Wdate" onfocus="WdatePicker({minDate: \'%y-%M-%d\'})" style="width:46px;height: 14px;"  name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}else{
		return val+'<input style="display: none;" name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}
}

function isOutValidUntil(validUntil){
	if(!validUntil){
		return false;
	}
	var currentDate = new Date().format("yyyy-MM-dd");
	var validDate = new Date(validUntil).format("yyyy-MM-dd");
	if(currentDate > validDate){//超出回复有效期
		return true;
	}else{
		return false;
	}
}

//行信息列自定义
$("#headcolumnDefineBtn").click(function(){
		 parent.elsDeskTop.defineWin({
		     'iconSrc':'icon/els-icon.png',
		     'windowsId':'subAccountColumnSetting',
		     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="行信息列自定义" />',
		     windowSubTitle: "",
		     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=deliveryNoteDetail_mt" + "&window=deliveryNoteList",
		     windowMinWidth: 480,
		     windowMinHeight: 600,
		     'windowWidth':480,
		     'windowHeight':600,
		     'parentPanel':".currDesktop"
		  });
 });
 
function initData(){
	itemGrid= $('#deliveryNoteHeaderTable').mmGrid({
		     cols: cols_item,
		     url :"<%=basePath%>rest/DeliveryNoteService/findDeliveryNoteItem",
	 	     params: $("#form").serializeJSON(),
	 	     method:  "post",
	 	     root:"rows",
		     remoteSort:true,
		     checkCol:true,
		     indexCol:true,
		     multiSelect : true,
			 nowrap:true,
			 height :330,
		     loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		     noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		     plugins: [
		         $('#pg').mmPaginator({
		           style: 'plain'
		                 , totalCountName: 'total'
		                 , page: 1
		                 , pageParamName: 'currentPage'
		                 , limitParamName: 'pageSize'
		                 , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
		                 , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
		                 , limit:null
		                 , limitList: [20,50,100]
		             })
		         ]
		});
	itemGrid.on('loadSuccess',function(e, data) {
		//打开聊天行选择开关
		chatFromUrlFlag = true;
	});
	itemGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
		toElsAccount = item.toElsAccount;
		var itemIds="";
		var hadSelected = itemGrid.selectedRows();
		var multiToEls = false;
		var checkToElsAccount;
		var flag = 0;
		hadSelected.forEach(function(val){
			if(flag == 0){
				checkToElsAccount = val.toElsAccount;
			}else{
				if (val.toElsAccount != checkToElsAccount) {
	    			multiToEls = true;
	    		}
			}
			flag ++;
    		itemIds=itemIds+","+val.purchaseOrderNumber;
    	});
		if(itemIds!=""){
    		itemIds=itemIds.substring(1);
    	} else {
    		toElsAccount = "";
    	}
    	if (multiToEls) {
    		toElsAccount = "";
    	}
    	// 动态加载聊天窗口
		if(hadSelected && hadSelected.length) {
			if(chatFromUrlFlag) {
				initChat(elsAccount+"_"+item.purchaseOrderNumber,item.fbk1,hadSelected);
			}
    	} else {
    		initChat();
    	}
      });
		
}


function checkData(item,isCheckToElsAccount){
	    if(!item){
	    	return false;
	    }
	    if(isCheckToElsAccount){
	    	if(!item.toElsAccount){
	    		return false;
	    	}
	    }
	    var isValidity = item.isValidity;//是否有效，0有效，1失效
		var confirmStatus = item.confirmStatus;//0:待回复,1:待确认,2:接受,3:重回,4:拒绝,5:未匹配到供应商
		var validUntil = item.validUntil; //有效期至
		var sendStatus = item.sendStatus;
		var isOutValid = isOutValidUntil(validUntil);
		if(isValidity == 0 && ((confirmStatus == 0 && isOutValid) || sendStatus == 0)){
			return true;
		}else{
			return false;
		}
}
	
//同步k3数据
function SimpleDeleteDeliveryNote(){
	var materialNumber = $.trim($("#materialNumber").val());
	var flag = false;
	var json={"elsAccount":elsAccount,"materialNumber":materialNumber};
	var paramStr = JSON.stringify(json);
	if(materialNumber == ""){
		parent.elsDeskTop.tip.init({type: 'confirm',message: "物料编码为空，将同步所有的欠料需求，是否继续？",closeEvent:function(){
			invokeAjax(paramStr);
		}});
	}else{
		invokeAjax(paramStr);
	}
}

function invokeAjax(paramStr){
	$.ajax({
		url : "<%=basePath%>rest/DeliveryNoteService/syncRequirementPlan" ,
		contentType : "application/json",
 		type : "post",
 		dataType : "json",
 		data:paramStr,
 		success : function(data) {
 			if(data!=null&&data.statusCode=="-100"){
 				alert(data.message,2);
 			}else if(data!=null&&data.statusCode=="-200"){
 				alert(data.message,3);
 			}else{
 				$("#selectDialog").hide();
 				alert("<i18n:I18n key="" defaultValue="同步请求已提交！" />");
 				//initData();
 			}
 		},
 		error : function(data) {
 			alert("<i18n:I18n key="i18n_message_getfromerpfailure" defaultValue="从ERP获取数据失败" />",3);
 		}
 	});
}
	
$("#sendBtn").click(function(){
	var selectRowsIndex = itemGrid.selectedRowsIndex();
	if(selectRowsIndex.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var selectRows = itemGrid.selectedRows();//返回所选择的数据行
	var frmObj = $("#frm").serializeJSON();
	var deliveryNoteList = frmObj.deliveryNoteList;
	for(var i = 0 ; i < selectRows.length ; i ++){
		var index = selectRowsIndex[i];
		var row = selectRows[i];
		var rowNumber = index+1;
		if(!checkData(row,true)){
			alert("您勾选的行项目中，第"+rowNumber+"行不能执行该操作，请核对！",2);
			return;
		}
		var confirmStatus = $("input[name='confirmStatus_"+index+"']:checked").val();
		if(confirmStatus){
		   row["confirmStatus"]=confirmStatus;
		}else{//采购方代回复
			var item = deliveryNoteList[index];
		    var saleMaterialQuantity = item.saleMaterialQuantity;
		    if($.trim(saleMaterialQuantity) == ""){
		    	alert("您勾选的行项目中，第"+rowNumber+"行供应商确认数量未填写，请核对！",2);
		    	return;
		    }
		    var deliveryDate = item.deliveryDate;
		    if($.trim(deliveryDate) == ""){
		    	alert("您勾选的行项目中，第"+rowNumber+"行供应商确认交期未填写，请核对！",2);
		    	return;
		    }
		    var saleRemark = item.saleRemark;
		    row["saleMaterialQuantity"]=saleMaterialQuantity;
		    row["deliveryDate"]=deliveryDate;
		    row["saleRemark"]=saleRemark;
			row["confirmStatus"]="00";
		}
		row["sendStatus"]="1";//已发送
	}
	var param = {"elsAccount":elsAccount};
	param["deliveryNoteList"] = selectRows;
	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认发送？",closeEvent:function(){
		parent.elsDeskTop.showLoading("发送中");
		$.ajax({
			url : "<%=basePath%>rest/DeliveryNoteService/sendConfirmStatus",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				if(data.statusCode == "-100"){
					alert("发送失败："+data.message,3);
				}
				parent.elsDeskTop.hideLoading();
				query();
				alert('<i18n:I18n key="" defaultValue="发送成功" />');
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert(data.responseText,3);
			}
		});
	}});
});	

$("#saveBtn").click(function(){
	var selectRowsIndex = itemGrid.selectedRowsIndex();
	if(selectRowsIndex.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var selectRows = itemGrid.selectedRows();//返回所选择的数据行
	var frmObj = $("#frm").serializeJSON();
	var deliveryNoteList = frmObj.deliveryNoteList;
	for(var i = 0 ; i < selectRows.length ; i ++){
		var index = selectRowsIndex[i];
		var row = selectRows[i];
		var rowNumber = index+1;
		if(!checkData(row,true)){
			alert("您勾选的行项目中，第"+rowNumber+"行不能执行该操作，请核对！",2);
			return;
		}
		var confirmStatus = $("input[name='confirmStatus_"+index+"']:checked").val();
		if(confirmStatus){
		   row["confirmStatus"]=confirmStatus;
		}else{//采购方代回复
			var item = deliveryNoteList[index];
		    var saleMaterialQuantity = item.saleMaterialQuantity;
		    var deliveryDate = item.deliveryDate;
		    var saleRemark = item.saleRemark;
		    row["saleMaterialQuantity"]=saleMaterialQuantity;
		    row["deliveryDate"]=deliveryDate;
		    row["saleRemark"]=saleRemark;
			row["confirmStatus"]="0";
		}
	}
	var param = {"elsAccount":elsAccount};
	param["deliveryNoteList"] = selectRows;
	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认保存？",closeEvent:function(){
		parent.elsDeskTop.showLoading("保存中");
		$.ajax({
			url : "<%=basePath%>rest/DeliveryNoteService/saveConfirmStatus",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				if(data.statusCode == "-100"){
					alert("保存失败："+data.message,3);
				}
				parent.elsDeskTop.hideLoading();
				query();
				alert('<i18n:I18n key="" defaultValue="保存成功" />');
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert(data.responseText,3); 
			}
		});
	}});
});

function carateDeliverNote(){
	var deliveryNoteType = $("#deliveryNoteType").val();
	var create_materialNumber = $("#create_materialNumber").val();
	var create_purchaseOrderNumber = $("#create_purchaseOrderNumber").val();
	var create_orderItemNumber = $("#create_orderItemNumber").val();
	var create_quantity = $("#create_quantity").val();
	var create_deliveryDate = $("#create_deliveryDate").val();
	var create_validUntil = $("#create_validUntil").val();
	var msg;
	
	if(deliveryNoteType == 0){
		if($.trim(create_materialNumber) == ""){
			alert("物料编码不能为空",2);
			return;
		}
		msg = "新建送货通知单会作废掉："+create_materialNumber+" 之前生成的送货通知单，是否继续？";
	}else{
		if($.trim(create_purchaseOrderNumber) == ""){
			alert("订单号不能为空",2);
			return;
		}
		if($.trim(create_orderItemNumber) == ""){
			alert("订单行号不能为空",2);
			return;
		}
		msg = "确认新建？";
	}
	if($.trim(create_quantity) == ""){
		alert("需求数量不能为空",2);
		return;
	}
	if($.trim(create_deliveryDate) == ""){
		alert("需求日期不能为空",2);
		return;
	}
	if($.trim(create_validUntil) == ""){
		alert("回复有效期至不能为空",2);
		return;
	}
	
	var param = {"elsAccount":elsAccount,"deliveryNoteType":deliveryNoteType,"materialNumber":create_materialNumber,"purchaseOrderNumber":create_purchaseOrderNumber,"orderItemNumber":create_orderItemNumber,"deliveryQuantity":create_quantity,"deliveryTime":create_deliveryDate,"validUntil":create_validUntil};
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:msg ,closeEvent:function(){
		parent.elsDeskTop.showLoading("生成送货通知单中");
		$.ajax({
			url : "<%=basePath%>rest/DeliveryNoteService/createRequirementPlan",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data.statusCode == "-100"){
					alert("新建失败："+data.message,3);
				}else{
					$("#createDeliveryNoteDialog").hide();
					query();
					alert('<i18n:I18n key="" defaultValue="新建成功" />');
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("新建失败:"+data.responseText,3); 
			}
		});
	}});
	
}

$("#deleteBtn").click(function(){
	var selectRowsIndex = itemGrid.selectedRowsIndex();
	if(selectRowsIndex.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var selectRows = itemGrid.selectedRows();//返回所选择的数据行
	var frmObj = $("#frm").serializeJSON();
	var deliveryNoteList = frmObj.deliveryNoteList;
	for(var i = 0 ; i < selectRows.length ; i ++){
		var index = selectRowsIndex[i];
		var row = selectRows[i];
		var rowNumber = index+1;
		if(row.confirmStatus == 6){
			alert("您勾选的行项目中，第"+rowNumber+"行不能执行该操作，请核对！",2);
			return;
		}
	}
	var param = {"elsAccount":elsAccount};
	param["deliveryNoteList"] = selectRows;
	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认删除？",closeEvent:function(){
		parent.elsDeskTop.showLoading("删除中");
		$.ajax({
			url : "<%=basePath%>rest/DeliveryNoteService/deleteDeliveryNote",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				if(data.statusCode == "-100"){
					alert("删除失败："+data.message,3);
				}
				parent.elsDeskTop.hideLoading();
				query();
				alert('<i18n:I18n key="" defaultValue="删除成功" />');
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert(data.responseText,3); 
			}
		});
	}});
});
//导出excel文件
$("#downloadBtn").click(function(){
	debugger;
	var frmObj =$("#form").serializeJSON();
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/DeliveryNoteService/exportExcel",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frmObj),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + data.message;
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
});

//测试交期考核
$("#caculatorBtn").click(function(){
	debugger;
	var frmObj =$("#form").serializeJSON();
	parent.elsDeskTop.showLoading();
	$.ajax({
		url : "<%=basePath%>rest/DeliveryNoteService/caculatorDelivery",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frmObj),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert('<i18n:I18n key="" defaultValue="计算成功" />');
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
});

</script>
</body>
</html>