<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
			    <button class="button-wrap" id="saveBtn">
					<i18n:I18n key=" " defaultValue="保存" />
				</button>
				<button class="button-wrap" id="confirmBtn">
					<i18n:I18n key=" " defaultValue="发送" />
				</button>
				<button id="downloadBtn" class="button-wrap"><i18n:I18n key="" defaultValue="导出EXCEL" /></button>
           		<button id="importBtn" class="button-wrap"><i18n:I18n key="" defaultValue="导入EXCEL" /></button>
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
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="送货通知单号" />：</span><input
							id="deliveryNoteNo" name="deliveryNoteNo" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="物料号或描述" />：</span><input
							id="purchaseMaterialNumber" name="purchaseMaterialNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="采购商" />：</span><input
							id="toElsAccount" name="toElsAccount" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="收货联系人或地址" />：</span><input
							id="userName" name="userName" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key=" " defaultValue="采购负责人" />：</span><input
							id="createUser" name="createUser" type="text" />
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
						<span><i18n:I18n key=" " defaultValue="通知单状态" />：</span> <select
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
	                </div>
	                <div class="dis-in-b input-and-tip">
	                    <span><i18n:I18n key="" defaultValue="查看失效的通知单" /></span>
	                    <input type="checkbox" id="isValidity" name="isValidity" value="X"/>
	                </div>
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

<script type="text/javascript">
var deliveryNoteNo;
var itemGrid;
var sendStatus;
var pageData;
var optType ="<%=request.getParameter("type") %>";
var excelUploader;
var cols_item =<base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleDeliveryNoteDetail_mt"/>;

var $sob;
var chatFromUrlFlag = false;
var peopleList;
var toElsAccount = "";

$(document).ready(function() {
	  $sob = $('.saying-dialog .option-bar');
	  if(optType){
		  if(optType == 'add'){
			  $("#sendStatus").val("0");
			  $("#confirmStatus").val("0");
		  }else if(optType == 'delete'){
			  $("#isValidity").attr("checked",'true');
		  }
	  }
		initData();
		initExcelUploader();
		//同步
		$("#SameBtn").click(function(){
			SimpleDeleteDeliveryNote();
		});
		
		//查询
		$("#seachBtn").click(function(){
			query();
		}); 
		
		$("#isValidity").click(function(){
			query();
		});
		
});

//初始化聊天窗口
//ELS账号+订单号 作为 businessID
function initChat(businessID,fbk1, hadSelected) {
		if (toElsAccount == "") {
			$('.testIframe').attr('src','');
			return;
		}
		//采购凭证号
		var purchaseOrderNumberList = [];
		//订单号
		var bIdList = [];
		//聊天显示列表
		var chatList = [];
		if(hadSelected && hadSelected.length) {
			hadSelected.forEach(function(d,i){
				var obj ={};
				obj[d.purchaseOrderNumber] = d.createUser || '' ;
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
	var frm = $("#form");
	itemGrid.opts.params = frm.serializeJSON();
	itemGrid.load({page:1});
}

//行信息列自定义
$("#headcolumnDefineBtn").click(function(){
		 parent.elsDeskTop.defineWin({
		     'iconSrc':'icon/els-icon.png',
		     'windowsId':'subAccountColumnSetting',
		     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="行信息列自定义" />',
		     'windowSubTitle': "",
		     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleDeliveryNoteDetail_mt" + "&window=saleDeliveryNoteManager",
		     'windowMinWidth': 480,
		     'windowMinHeight': 600,
		     'windowWidth':480,
		     'windowHeight':600,
		     'parentPanel':".currDesktop"
		  });
 });
 
//渲染输入框
function initInputDouble(val,item,index){
	if(!val) { val = '';}
	var name = $(this)[0].name;
	if(item.sendStatus == 0){
	   return '<input  onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 14px;"  name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}else{
		return val+'<input style="display: none;" name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}
}

function initInputDate(val,item,index){
	if(!val) { val = '';}
	var time = new Date().format("yyyy-MM-dd hh:mm:ss");
	if(val < time && item.sendStatus =="0"){//过期
		val = time;
	}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	var name = $(this)[0].name;
	if(item.sendStatus == 0){
	    return '<input class="Wdate" onfocus="WdatePicker({minDate: \'%y-%M-%d\'})" style="width:46px;height: 14px;"  name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}else{
		return val+'<input style="display: none;" name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}
}

function initInput(val,item,index){
	if(!val) { val = '';}
	var name = $(this)[0].name;
	return val + '<input   style="display: none;"  name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
}

function initEditInput(val,item,index){
	if(!val) { val = '';}
	var name = $(this)[0].name;
	if(item.sendStatus == 0){
	   return '<input  style="width:46px;height: 14px;"  name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}else{
		return val+'<input style="display: none;" name="deliveryNoteList[]['+name+']"  type="text" value="'+val+'"/>';
	}
}
	
function initData(){
	itemGrid= $('#deliveryNoteHeaderTable').mmGrid({
		     cols: cols_item,
		     url :"<%=basePath%>rest/DeliveryNoteService/findDeliveryNoteItem",
	 	     params: $("#form").serializeJSON(),
	 	     method:  "post",
	 	     root:"rows",
		     remoteSort:true,
		     checkCol:true,
		     multiSelect : true,
			 nowrap:true,
			 height :310,
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
	itemGrid.on('loadSuccess', function(e, items){
		if(items && items.rows && items.rows.length) {
			var rs= items.rows;
			for(var i=0;i<rs.length;i++) {
				var r= rs[i];
				if(r.sendStatus == "0" && r.isValidity=="0" && (r.confirmStatus=="0" || r.confirmStatus=="3")) {
					
				} else {
					var td=$(itemGrid).find('tbody').find('tr').eq(i).find('td').eq(0);
					td.attr({'disabled':'disabled'}).find('span:first-child').find('input').attr({'readonly':'readonly'});
				}
			}
		}
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
	if(isValidity == 0 && sendStatus == 0 && (confirmStatus == 0 || confirmStatus == 3)){
		return true;
	}else{
		return false;
	}
}
	
$("#confirmBtn").click(function(){
	var selectRowsIndex = itemGrid.selectedRowsIndex();
	if(selectRowsIndex.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var selectRows = itemGrid.selectedRows();//返回所选择的数据行
	var frmObj = $("#frm").serializeJSON();
	var deliveryNoteList = frmObj.deliveryNoteList;
	var selectVOs = [];
	for(var i = 0 ; i < selectRows.length ; i ++){
		var index = selectRowsIndex[i];
		var row = selectRows[i];
		var rowNumber = index+1;
		if(!checkData(row,true)){
			alert("您勾选的行项目中，第"+rowNumber+"行不能执行该操作，请核对！",2);
			return;
		}
		var itemVO = deliveryNoteList[index];
		var deliveryDate = itemVO.deliveryDate;
		var saleMaterialQuantity = itemVO.saleMaterialQuantity;
		var saleRemark = itemVO.saleRemark;
		row['deliveryDate']=deliveryDate;
		row['saleMaterialQuantity']=saleMaterialQuantity;
		row['saleRemark']=saleRemark;
		var lineNumber = index + 1;
		if($.trim(saleMaterialQuantity) == ""){
			alert("您勾选的第 "+lineNumber +" 行中，供应商确认数量未填写，请核对！",2);
			return;
		}
		if($.trim(deliveryDate) == ""){
			alert("您勾选的第 "+lineNumber +" 行中，供应商确认交期未填写，请核对！",2);
			return;
		}
		
		selectVOs = selectVOs.concat(row);
	}
	frmObj["elsAccount"]=elsAccount;
	frmObj["deliveryNoteList"]=selectVOs;
	parent.elsDeskTop.tip.init({type: 'confirm',message: "是否答复交期？",closeEvent:function(){
		parent.elsDeskTop.showLoading("发送中");
		$.ajax({
			url : "<%=basePath%>rest/DeliveryNoteService/replyDeliveryPlan",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(frmObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				query();
				alert('<i18n:I18n key="" defaultValue="发送成功" />');
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert(	"<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
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
	var selectVOs = [];
	for(var i = 0 ; i < selectRows.length ; i ++){
		var index = selectRowsIndex[i];
		var row = selectRows[i];
		var rowNumber = index+1;
		if(!checkData(row,true)){
			alert("您勾选的行项目中，第"+rowNumber+"行不能执行该操作，请核对！",2);
			return;
		}
		var itemVO = deliveryNoteList[index];
		var deliveryDate = itemVO.deliveryDate;
		var saleMaterialQuantity = itemVO.saleMaterialQuantity;
		var saleRemark = itemVO.saleRemark;
		row['deliveryDate']=deliveryDate;
		row['saleMaterialQuantity']=saleMaterialQuantity;
		row['saleRemark']=saleRemark;
		selectVOs = selectVOs.concat(row);
	}
	frmObj["elsAccount"]=elsAccount;
	frmObj["deliveryNoteList"]=selectVOs;
	parent.elsDeskTop.tip.init({type: 'confirm',message: "是否保存交期？",closeEvent:function(){
		parent.elsDeskTop.showLoading("保存中");
		$.ajax({
			url : "<%=basePath%>rest/DeliveryNoteService/saveDeliveryPlan",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(frmObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				query();
				alert('<i18n:I18n key="" defaultValue="保存成功" />');
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert(	"<i18n:I18n key='i18n_delivery_syserror' defaultValue='系统异常！' />",3);
			}
		});
	}});
});
//导出excel文件
$("#downloadBtn").click(function(){
	var frmObj =$("#form").serializeJSON();
	parent.elsDeskTop.showLoading();
	debugger;
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

//导入excel文件
function initExcelUploader(){
	if(!excelUploader){
		excelUploader = WebUploader.create({
		    // swf文件路径
		    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		    auto: true,
		    duplicate :true,
		    accept:{
		    	extensions:"xls,xlsx"
		    },
		    // 文件接收服务端。
		    server: '<%=basePath%>servlet/UploadServlet',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick:'#importBtn',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false,
		    formData : {
		     	elsAccount : elsAccount
		     }
		});
		
		excelUploader.on( 'uploadAccept', function( obj, response ) {
			debugger;
		  	var filePath = response.url;
		  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
		  	$.ajax({
				url :"<%=basePath%>rest/DeliveryNoteService/importExcelByPath",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"fbk1":filePath,"elsAccount":elsAccount}),
				success : function(data) {
					debugger;
					//var obj = JSON.parse(data);
					if(data.statusCode=="-100"){
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_importFailure" defaultValue="导入失败！请检查文件内容！" />'});
						parent.elsDeskTop.hideLoading();
					}else{
						parent.elsDeskTop.hideLoading();
						alert('<i18n:I18n key="" defaultValue="导入成功!" />',1);
						query();
					}
				},
				error: function (data) {//获取ajax的错误信息
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误！" />'});
					parent.elsDeskTop.hideLoading();
	            }
			});
		});
	}
}
</script>
</body>
</html>