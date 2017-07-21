<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

<style type="text/css" media="screen">  
html, body   { height:100%; }  
body { margin :0; padding:0; overflow:auto ; }    
#flashContent { display :none; }  
</style>

<body>
  <div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
        <button class="button-wrap isHidden" id="publishSamplePO"><i18n:I18n key="i18n_common_button_issue" defaultValue="发布" /></button>
        <button class="button-wrap isHidden" id="saveSamplePO"><i18n:I18n key="" defaultValue="保存" /></button>
        <button class="button-wrap" id="closeBtn"><i18n:I18n key="" defaultValue="关闭" /></button>
    </div>
</div>
<form id="samplePOForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
 <div class="box-wrap pos-relative bg-common">
	 <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="样品头信息" /></span>
	 <div class="common-box-line">
	     <input id="orderSendStatus" name="orderSendStatus" type="hidden">
	     <input id="elsAccount" name="elsAccount" type="hidden">
	     <div class="dis-in-b input-and-tip">
			<span>样品单号：</span><input id="fbk28" name="fbk28" type="text" readonly/>
		 </div>
		 <div class="dis-in-b input-and-tip">
		    <span><i18n:I18n key="" defaultValue="需求日期" />：</span>
		    <input type="text" class="Wdate" onfocus="WdatePicker({minDate: '%y-%M-%d' })" id="deliveryDate" name="deliveryDate"/>
		 </div>
          <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_purchasegroup" defaultValue="采购组" />：</span><input id="purchaseGroup" name="purchaseGroup" type="text" style="width:200px;"/>
		 </div>
		 <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="" defaultValue="币别" />：</span><input id="currency" name="currency" type="text" style="width:200px;"/>
		 </div>
		 <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="" defaultValue="付款条件" />：</span><input id="payTermsCode" name="payTermsCode" type="text" style="width:200px;"/>
		 </div>
         <div class="dis-in-b input-and-tip pos-relative">
            <span><i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />：</span><input id="fbk4" name="fbk4" type="text"  readonly style="width:144px;max-width:144px;padding-right:20px;" />
            <img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryPrincipal" title="查找负责人" />
	     </div>
	     <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="" defaultValue="备注说明" />：</span><input id="remark" name="remark" type="text" style="width:1244px;max-width:244px;padding-right:20px;"/>
		 </div>
	 </div>
</div>

<div class="tab-wrap tab-wrap-change" id="add-enq-sheet">
    <ul>
        <li><a href="#edit-line-one"><i18n:I18n key="" defaultValue="样品行项目" /></a></li>
        <li class="add-supplier-sheet"><a href="#edit-line-three"><i18n:I18n key="i18n_enquiry_title_supplierinformation" defaultValue="供应商信息" /></a></li>
    </ul>
    <div class="p-zero" id="edit-line-one">
        <main class="bg-common p-6">
            <div class="edit-box-wrap" style="padding-top: 5px;">
            	<button id="btnQueryMaterial" class="button-wrap ishowMaterial"><i18n:I18n key="" defaultValue="选择物料" /></button>
                <button id="btnManuAdd" class="button-wrap"><i18n:I18n key="" defaultValue="添加" /></button>
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="btnGetPLMFile" class="button-wrap"><i18n:I18n key="" defaultValue="获取PLM文件" /></button>
                <button id="removeFile" class="button-wrap"><i18n:I18n key="" defaultValue="移除附件" /></button>
                <button id="btnManuDel" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button>
            </div>
            <div class="grid-100" id="reCreate">
                <table id="add-enq-project"></table>
            </div>
        </main>
    </div>
   
    <div class="p-zero" id="edit-line-three">
	    <div class="common-box-line p-zero">
		    <div class="pos-relative upload-wrap">
		         <div class="pos-absolute file-list">
					 <main class="bg-common p-6">
						  <div class="edit-box-wrap" style="padding-top: 5px;">
						      <button id="btnAddSupplie" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
						      <button id="btnDelSupplie" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button>
						   </div>
						   <div class="grid-100" >
						   <table id="add-supplie-project"></table>
						 </div>
					</main>
		         </div>
			</div>
		</div>
    </div>
  </div>
</form>
<div class="fixed-dialog supplie-groud" >
           <div class="dialog-tip bg-common contacts-box">
               <div class="dialog-close-btn" id="contactClose"></div>
               <div class="tip-head pos-relative">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="i18n_common_title_addcontact" defaultValue="添加供应商" /></span>
                   <button class="button-wrap sure-selct" style="position: absolute;right: 44px;top: 11px;"><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
               </div>
               <div class="box-wrap pos-relative bg-common">
               <input class="dis-in-b pos-absolute contact-search" type="text" style="left: 16px;width: 220px;max-width: 220px;padding-right: 20px;" placeholder="输入查找关键字" />
               <img class="dis-in-b pos-absolute" src="../../img/icon_search.png" style="width:14px; left: 244px;top:14px;" />
               <span class="dis-in-b pos-absolute" style="left: 345px;"><i18n:I18n key="i18n_common_title_alreadyaddcontact" defaultValue="已添加的供应商列表" />：</span>
                   <div class="fl-left box-left mt-27"></div>
                   <div class="fl-left box-middle mt-27">
                        <p class="all-pre text-center">
                            <button class="contact-option-btn button-wrap" title="全部右移" >>></button>
                        </p>
                        <p class="all-back text-center">
                            <button class="contact-option-btn button-wrap"  title="全部左移" ><<</button>
                        </p>
                    </div>
                   <div class="fl-left box-right mt-27"></div>
                   <div class="clear-both"></div>
               </div>
           </div>
</div>

<!-- 选择责任人弹出框 -->
<div class="fixed-dialog" id="selectPrincipalDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectPrincipalDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectPrincipalDialog"><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></span>
	    </div>
	    <div class="box-wrap">
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filtercondition" defaultValue="过滤条件" /></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td width="80px"><input  type="text" id="principalName" name="principalName" /></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="select-principal-table"></table>
                    </div>
                    <div class="text-center" style="margin-top: 14px;">
	                    <button id="btnSelectPrincipalOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnSelectPrincipalCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<!-- 选择物料询价信息相关@author jiangzhidong @date 20160621 -->
<div class="fixed-dialog" id="selectMaterialDialog" >
	<div class="dialog-tip bg-common" style="width: 630px;height: 403px;margin-left: -205px;margin-top: -270px;">
	  <div class="dialog-close-btn" id="btnSelectMaterialDialogClose"></div>
       <form id="selectMaterialForm" onsubmit="return false;">
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" ><i18n:I18n key="" defaultValue="请选物料信息" /></span>
		    <input type="hidden" id="pageSize" name="pageSize" value="20">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
		    <input type="hidden" id="fbk1" name="fbk1" value="WL">	
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="查询条件" /></span>
	            <div class="common-box-line">
	               <div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料编码/名称" />：</span>
						<input id="materialNumber" name="materialNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料组" />：</span>
						<input id="materialGroup" name="materialGroup" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<button id="queryMaterial" class="button-wrap "><i18n:I18n key="" defaultValue="查询" /></button>
					</div>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="query-material-table"></table>
                        <div id="query-material-page" style="text-align: right;"></div>
                    </div>
                    <div class="mt-20 text-center" >
	                    <button id="btnQueryMaterialOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnQueryMaterialCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
	   </form>
    </div>
</div>
<script type="text/javascript">

var editTable;
var editSupplieTable;
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var userName = "<%=session.getAttribute("username")%>";
var currId ="<%=request.getParameter("currId") %>";
var purchaseOrderNumber ="<%=request.getParameter("purchaseOrderNumber") %>";
var fbk28 ="<%=request.getParameter("fbk28") %>";
var deliveryDate ="<%=request.getParameter("deliveryDate") %>";
var sendStatus ="<%=request.getParameter("sendStatus") %>";
var queryMaterialTable;
var selectPrincipalTable;
var rightScroll;
var leftScroll;

var materialReplaceFirst = true;

var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="sampleOrderItemEdit_mt"/>;

$(document).ready(function() {
	
	if(sendStatus && sendStatus ==1){
		$(".isHidden").hide();
	}
	window.beforeClose = function(close){
	    top.elsDeskTop.tip.init({
	        type            : 'confirm',
	        displayType     : 2, 
	        message         : '确认关闭?',
	        closeEvent : function () {
	           callBack();
	           close();
	        }
	    });
	}; 
    //初始化控件
    $('#add-enq-sheet').tabs();
    $("#fbk4").val(elsSubAccount+"_"+userName);
    $("#elsAccount").val(elsAccount);
   
    //初始化样品单行列表
    editTable=$('#add-enq-project').mmGrid({
    	cols: cols_item,
	    url :"<%=basePath%>rest/PurchaseOrderService/order/findPurchaseOrderItemByNumber/"+elsAccount+"/"+purchaseOrderNumber,
	    method:  "get",
	    root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        multiSelect: true,
        nowrap:true,
        checkCol: true,
        indexCol:false
    });
    //初始化供应商列表
    editSupplieTable=$('#add-supplie-project').mmGrid({
    	url :"<%=basePath%>rest/PurchaseSampleService/findSelSupplierList",
 	    params: {"elsAccount":elsAccount,"fbk28":fbk28},
 	    method:  "post",
 	    root:"rows",
        cols: colsSupplie,
        width: 325,
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        multiSelect: true,
        checkCol: true,
        indexCol:false
    });
    
    if(purchaseOrderNumber && purchaseOrderNumber !="null"){
    	$("#deliveryDate").val(deliveryDate);
    	//加载头信息
    	$.ajax({
    	    url :"<%=basePath%>rest/PurchaseOrderService/getPOHeader/"+elsAccount+"/"+purchaseOrderNumber,
    	    type :"get",
    	    contentType : "application/json",
    	    dataType : "json",
    	    success : function(data) {
    	    	if(data.statusCode == "-100"){
    			}else{
    				$("#fbk28").val(data.fbk28);
    				$("#currency").val(data.currency);
    				$("#payTermsCode").val(data.payTermsCode);
    				$("#fbk4").val(data.fbk4);
    				$("#remark").val(data.remark);
    				$("#orderSendStatus").val(data.orderSendStatus);
    				$("#purchaseGroup").val(data.purchaseGroup);
    			}
    	    }
        });
    }
    
	//获取当前用户默认的采购组、采购组织
	<%-- $.ajax({
	    url :"<%=basePath%>rest/ElsOrganizationService/querySubaccountOrganizationInfo",
	    type :"post",
	    contentType : "application/json",
	    data : JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount}),
	    dataType : "json",
	    success : function(data) {
	    	if(data.statusCode == "-100"){
			}else{
				var rows = data.rows;
				var purchaseGroup="";
				var purchaseOrganization="";
				for(var i = 0 ; i < rows.length ; i ++){
					var row = rows[i];
					var orgCategoryId = row.orgCategoryId;
					if(orgCategoryId == "purchaseOrganization"){//采购组织
						if(row.orgId!=null){
							purchaseOrganization += ";"+row.orgId;
						}else{purchaseOrganization = "1010";}
					}
					if(orgCategoryId == "purchaseGroup"){//采购组
						if(row.orgId!=null){
							purchaseGroup += ";"+row.orgId;
						}else{purchaseGroup += ";09";}
					}
				}
				if(purchaseGroup.length > 0){
					$("#purchaseGroup").val(purchaseGroup.split(";")[1]);
				}
			}
	    }
    }); --%>
    
});

    //渲染计价单位表格
    function priceQuantity(val,item,index){
		 if(!val) { val = '';}
		 var name = $(this)[0].name;
		return '<input style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="priceQuantity_'+index+'" type="text" value="'+val+'"/>'+
		'<img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 4px;cursor: pointer;" id="input-priceQuantity" title="查找计价单位" />'+
		'<span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+name+'</span>';
    }
    
    //渲染计价亮度单位表格
    function priceMetricQuantity(val,item,index){
		 if(!val) { val = '';}
		return '<input  style="width:46px;height: 14px;" name="purchaseEnquiryMaterialVOs[][priceMetricQuantity]" id="priceMetricQuantity_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    }
    function initInput(val,item,index){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
		return '<input  style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    }
    function initInputInteger(val,item,index){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
		return '<input  onkeyup="value=value.replace(/[^(\\d)]/g,\'\')"  style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    }
    function initInputDouble(val,item,index,colName){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
    	if (colName == "quantity" && item.isERP == "yes") {
    		return '<input readOnly onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}
		return '<input  onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    }

    //
    function initInputDate(val,item,index){
    	if(!val) { val = '';}
    	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
    	var name = $(this)[0].name;
    	return '<input class="Wdate" onfocus="WdatePicker({minDate: \'%y-%M-%d\'})" style="width:46px;height: 14px;"  name="purchaseOrderItemList[]['+name+']"  type="text" value="'+val+'"/>';
    }
    
    function initAddFile(val,item,index){
    	var showText='';
    	if(!val){
//     		showText="添加";
    		val = "";
    	}else{
    		var fileArray = val.split(";");
    		for(var i in fileArray){
    			var file = fileArray[i];
    			showText += file.substring(file.indexOf("_")+1,file.length)+";"
    		}
    		showText=showText.substring(0,showText.length-1);
    	}
    	return '<span class="click-addFile" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><input style="display: none;"  name="purchaseOrderItemList[][fbk27]"  type="text" value="'+val+'"/>';
    }
    
    //--------供应商列表----begin------------
    var colsSupplie = [
                    { title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS账号"/>', name:'toElsAccount' , width:120, align:'center'},
                    { title:'<i18n:I18n key="i18n_common_title_suppliername" defaultValue="供应商名称"/>', name:'companyShortName' , width:180, align:'center'}
                ];

  //初始化联系人弹窗,将联系人的列表传人
    function initContact(list, dir, had) {
    	if(list && list.length) {
    		var oldArr = list;
    		$('body').data('cacheOldArr',oldArr);
        	var txt ="";
        	if(dir == 'left') {
        		$('.box-left').html('');
        		for(var i =0;i<oldArr.length;i++) {
        			var ifShow="block";
        			if(had && had.length) {
        				for(var j=0;j<had.length;j++) {
        					if(oldArr[i].toElsAccount == had[j].toElsAccount) {
        						ifShow="none";
        					}
        				}
        			}
            		txt +='<p class="contact-people" style="display:'+ifShow+';margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">left</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
            	}
        		$('.box-left').append(txt);
        		leftScroll.resize();
        	}
        	else if(dir == 'right') {
        		$('.box-right').html('');
        		for(var i =0;i<oldArr.length;i++) {
        			var ifShow="none";
        			if(had && had.length) {
        				for(var j=0;j<had.length;j++) {
        					if(oldArr[i].toElsAccount == had[j].toElsAccount) {
        						ifShow="block";
        					}
        				}
        			}
            		txt +='<p class="contact-people" style="display:'+ifShow+';margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">right</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
            	}
        		$('.box-right').append(txt);
        		rightScroll.resize();
        	}
    	}
    };
    //添加供应商信息
    $("#btnAddSupplie").click(function(){
   	var contactP = $('body').data('cacheOldArr');
   	var tableRows = [];
   	if(editSupplieTable && editSupplieTable.rowsLength()) {
   		tableRows = editSupplieTable.rows();
   	}
   	if(!contactP){
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
    				initContact(rows,'left',tableRows);
    				initContact(rows,'right',tableRows);
    			},
    			error: function (xhr, type, exception) {//获取ajax的错误信息
                    alert(xhr.responseText, "Failed"); 
           		}
    		});
   	} else {
   		   //当表格已经有数据，初始化右边数据
           initContact(contactP,'left',tableRows);
           initContact(contactP,'right',tableRows);
   	}
   	$('.supplie-groud').show();
	    rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
	    leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
	});
    
  //存储临时的选择数据
    var cacheData = {};
    $('.contact-people').live('mouseover',function() {
    	$('.contacts-box').find('p').removeClass('add-contact');
        $(this).addClass('add-contact');
    });
    $('.contact-people').live('click',function() {
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
    $('.sure-selct').click(function() {
    	var storeNewArr = $('.box-right').find(".contact-people:visible");
    	var lastArr = [];
		if(editSupplieTable && editSupplieTable.rowsLength()) {
			lastArr = editSupplieTable.rows();
	   	}
        if(storeNewArr && storeNewArr.length) {
        	for(var i=0;i<storeNewArr.length; i++) {
        		var textObj = JSON.parse($(storeNewArr[i]).find('.storeData').text());
        		var Account = textObj.friendElsAccount;
                var fromIndex = textObj.fromIndex;
                var nameDes = textObj.friendCompanyName;
                var obj = {
               		"toElsAccount":Account,
                	"companyShortName":nameDes,
                    "toFromIndex":fromIndex,
                };
                //去重供应商 begin @author jiangzhidong @date 20160823
        		var isExist = true;
        		if(Account!=''&&Account!=null){
        			for(var j=0;j<lastArr.length; j++) {
        				if(lastArr[j].toElsAccount==Account){
        					var isExist = false;
        				}
	                }
        			if(isExist){
        				lastArr.push(obj);
       				}
        	 	}
	        	//去重供应商 end @author jiangzhidong @date 20160823
        	}
        	editSupplieTable.load(lastArr);
        }
        $('.supplie-groud').hide();
        rightScroll.resize();
        leftScroll.resize();
    });
    //移除供应商信息
    $("#btnDelSupplie").click(function(){
    	 var selectedIndexes = editSupplieTable.selectedRowsIndex();
    	 editSupplieTable.removeRow(selectedIndexes);
	});

    $("#contactClose").click(function() {
    	$('.fixed-dialog').hide();
	    if(leftScroll) leftScroll.resize();
	    if(rightScroll)rightScroll.resize();
    });
    
    //------------选择供应商end---------------
    //手工添加物料行
    $("#btnManuAdd").click(function(){
    	$("#enquiryDesc").val("");
    	var purchaseGroup = $("#purchaseGroup").val();
    	var data = {
				purchaseOrderNumber : "",
				orderItemNumber : "",
				requestDate : new Date().format('yyyy-MM-dd'),
				deliveryDate : "",
				materialNumber : "",
				materialDesc : "",
				quantity : "",
				unitQuantity : "",
				priceMetricQuantity:1,
				priceQuantity:"",
				quoteMethod:0,
				currency:"CNY",
				factory: "",
				stockPoint: "",
				purchaseType: "",
				purchaseGroup: purchaseGroup,
		        accessoryRequire:"",
		        remark:""
		    };
		
    	editTable.addRow(data);//插入到表格最后
    });
    
    
    $("#btnManuDel").click(function(){
    	 var selectedIndexes = editTable.selectedRowsIndex();
    	 editTable.removeRow(selectedIndexes);
    });
    
    //保存样品单---saveSamplePO
    $("#saveSamplePO").click(function(){
    	var purchaseGroup = $("#purchaseGroup").val();
    	if(purchaseGroup==null||purchaseGroup==''){
    		alert("采购组不能为空,不能执行操作!",2);
    		return;
    	}
    	var frm =$("#samplePOForm");
    	var jsonObj = frm.serializeJSON();
    	var purchaseOrderItemList = jsonObj.purchaseOrderItemList;
    	for(var i = 0 ; i < purchaseOrderItemList.length ; i++){
    		var materialDesc = purchaseOrderItemList[i].materialDesc;
	    	if(materialDesc==null||materialDesc==''){
	    		alert("物料描述不能为空,不能执行操作!",2);
	    		return;
	    	}
    	}
    	operationSample(0,"是否确认保存？","保存中");
    });
    
   //TODO: 发布询价单**************************** 
    $("#publishSamplePO").click(function(){
    	var purchaseGroup = $("#purchaseGroup").val();
    	if(purchaseGroup==null||purchaseGroup==''){
    		alert("采购组不能为空,不能执行操作!",2);
    		return;
    	}
    	var frm =$("#samplePOForm");
    	var jsonObj = frm.serializeJSON();
    	var purchaseOrderItemList = jsonObj.purchaseOrderItemList;
    	for(var i = 0 ; i < purchaseOrderItemList.length ; i++){
    		var materialDesc = purchaseOrderItemList[i].materialDesc;
	    	if(materialDesc==null||materialDesc==''){
	    		alert("物料描述不能为空,不能执行操作!",2);
	    		return;
	    	}
    	}
    	operationSample(1,'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认发布？" />','样品单发布中');
    });
    
    function operationSample(operationType,message1,message2){
    	debugger;
    	var orderType = $("#orderType").val();
    	var frm =$("#samplePOForm");
    	var jsonObj = frm.serializeJSON();
        var orderSendStatus = jsonObj.orderSendStatus;
        if(orderSendStatus == 1){
        	alert("已发布样品单不能修改或再次发布！",2);
        	return;
        }
    	jsonObj["operationType"]=operationType;
    	var purchaseOrderItemList = jsonObj.purchaseOrderItemList;

    	if(purchaseOrderItemList == null || purchaseOrderItemList ==""){
    		alert('<i18n:I18n key="" defaultValue="至少添加一条行项目信息!" />',2);
    		$('#add-enq-sheet').tabs({active:0});
    		return;
    	}

    	var itmes = editSupplieTable.rows();
    	if(itmes == null || itmes ==""){
    		alert('<i18n:I18n key="i18n_enquiry_alert_leastonesupplierdata" defaultValue="至少添加一个供应商！" />',2);
    		$('#add-enq-sheet').tabs({active:1});
    		$(".add-supplier-sheet").click();
    		return;
    	}
    	var supplierList = [];
    	for(var i=0; i< itmes.length;i++){
    		var item = itmes[i];
    		supplierList = supplierList.concat(item.toElsAccount);
    	}
    	jsonObj['supplierList'] = supplierList;
        parent.elsDeskTop.tip.init({type: 'confirm',message:message1,closeEvent:function(){
    	parent.elsDeskTop.showLoading(message2);
    	 $.ajax({
			url :"<%=basePath%>rest/PurchaseSampleService/saveOrPublishSamplePO",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(jsonObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data.statusCode == "-100"){
					alert("操作失败："+data.message,3);
					return;
				}
				$("#fbk28").val(data.fbk28);
				$("#orderSendStatus").val(data.orderSendStatus);
				if(data.operationType == 0){
					alert('<i18n:I18n key="" defaultValue="保存成功！" />',1);
				}else{
					alert('<i18n:I18n key="i18n_common_alert_publishsuccessful" defaultValue="发布成功！" />',1);
					window.beforeClose = false;
					parent.elsDeskTop.closeCurWin('addSamplePO',callBack);
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert(data.responseText,3);
			}
		});
    	
	}});
    }
    //回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
    function callBack(){
    	if(parent.frames[currId]) {
    		parent.frames[currId].query();
    	}
    
    }
   
 
//选择负责人相关-----------------begin---------------
    var colsPrincipal = [
		                { title:'<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号"/>', name:'elsSubAccount' , width:110, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_username" defaultValue="用户名称"/>', name:'name' , width:100, align:'center'}
		                
		            ];
    
    //触发负责人弹出框事件，并用负责人文本框数据初始化窗口table的选中数据
    $("#queryPrincipal").click(function(){
    	$("#selectPrincipalDialog").show();
    	if(!selectPrincipalTable){
    		selectPrincipalTable=$('#select-principal-table').mmGrid({
    	        cols: colsPrincipal,
    	        url: "<%=basePath%>rest/AccountService/subAccountList",
    	        params: {"elsAccount":elsAccount,"station":"purchase","name":"","pageSize":"10000"},
    	        method: 'post',
    	        root: 'rows',
    	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
    	        multiSelect: true,
    	        checkCol: true,
    	        indexCol:true
    	    });
    	    
    	    selectPrincipalTable.on('loadSuccess', function(e, data){
    	    	var principalName = $("#principalName").val();
    	    	selectedByInput();
    		});
    	}
    	selectedByInput();
    });
    //用责任人框值初始化选中责任人列表的值
    function selectedByInput(){
    	var principal = $("#fbk4").val();
    	var principalArray = principal.split(";");//根据“;”获取以选择的负责人数组
    	var totalRows = selectPrincipalTable.rows();
    	if(totalRows != "" &&totalRows != null && principalArray){
    		for(var i = 0 ; i < totalRows.length ; i ++){
    			for(var j = 0 ; j < principalArray.length ; j ++ ){
    				var elsSubAccount = totalRows[i].elsSubAccount;
    				var name = totalRows[i].name;
    				var _principal = principalArray[j];
    				var _principalArray = _principal.split("_");
    				var _elsSubAccount = _principalArray[0];
    				var _name = _principalArray[1];
    				if(elsSubAccount == _elsSubAccount && name == _name){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
    					selectPrincipalTable.select(i);
    					continue;
    				}
    			}
    		}
    	}
    }
  //模糊查询键入事件
    $("#principalName").keyup(function(){
    	var principalName = $("#principalName").val();
    	selectPrincipalTable.load({"elsAccount":elsAccount,"station":"purchase","name":principalName,"pageSize":"10000"});
    });
    //选择负责人弹出框确认按钮单击事件
    $("#btnSelectPrincipalOK").click(function(){
    	    var selectedRows = selectPrincipalTable.selectedRows();
    	    var principals ="";
    	    var fbk4 = $("#fbk4").val();
    	    var fbk4Array = fbk4.split(";");
    	    //循环去重
    		for(var i = 0 ; i < fbk4Array.length ; i ++){
    			for(var j = 0 ; j < selectedRows.length ; j ++){
    				var _principal = fbk4Array[i];
    				var _principalArray = _principal.split("_");
    				var _elsSubAccount = _principalArray[0];
    				var elsSubAccount = selectedRows[j].elsSubAccount;
    				if(elsSubAccount == _elsSubAccount){ //判断该行数据是否已经在负责人文本框中，如果有则去除重复数据
    					selectedRows.splice(j,1);
    					continue;
    				}
    			}
    		}
    		//移除已选中的数据，判断依据若责任人在fbk4input框中且又在过滤后的责任人的列表中且状态不是选中状态，则认为该责任人是要从fbk4责任人框中移除的
    		var rows = selectPrincipalTable.rows();
    		var selectedRowsIndex = selectPrincipalTable.selectedRowsIndex();
    		for(var i = selectedRowsIndex.length-1 ; i >= 0 ; i --){
    			rows.splice(selectedRowsIndex[i],1); //去掉选中的行
    		}
    		for(var i = 0 ; i < rows.length ; i ++){
    			for(var j = 0 ; j < fbk4Array.length ; j ++){
    				var _principal = fbk4Array[j];
    				var _principalArray = _principal.split("_");
    				var _elsSubAccount = _principalArray[0];
    				var elsSubAccount = rows[i].elsSubAccount;
    				if(elsSubAccount == _elsSubAccount){ //判断该行数据是否已经在负责人文本框中，如果有则移除
    					fbk4Array.splice(j,1);
    					continue;
    				}
    			}
    		}
    		for(var i = 0 ; i < fbk4Array.length ; i ++){
    			if(i == 0){
    				principals += fbk4Array[i];
    			}else{
    				principals += ";"+fbk4Array[i];
    			}
    		}
    		for(var i = 0 ; i < selectedRows.length ; i ++){
    			var singleRow = selectedRows[i];
    			var elsSubAaccount = singleRow.elsSubAccount;
    			var name = singleRow.name;
    			if(i == 0){
    				if(principals == ""){
    					principals += elsSubAaccount+"_"+name;
    				}else{
    					principals += ";"+elsSubAaccount+"_"+name;
    				}
    			}else{
    			    principals += ";"+elsSubAaccount+"_"+name;
    			}
    		}
    		
    	if(principals != ""){
    		$("#fbk4").val(principals);
    	}else{
    		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_selectAtLeastOneRecord" defaultValue="至少选择一条记录！" />'});
    		return;
    	}
    	$("#selectPrincipalDialog").hide();
    });
    $("#btnSelectPrincipalDialogClose").click(function(){
    	$("#selectPrincipalDialog").hide();
    });
    $("#btnSelectPrincipalCancel").click(function(){
    	$("#selectPrincipalDialog").hide();
    });
//选择负责人相关-----------------end---------------
   
$("#columnDefineBtn").click(function(){
   columnDefine("sampleOrderItemEdit_mt");//行情询价
});
function columnDefine(tableCode){
    parent.elsDeskTop.defineWin({
		'iconSrc':'icon/els-icon.png',
		'windowsId':'subAccountColumnSetting',
		'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		'windowSubTitle': "",
		'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=" + tableCode + "&window=iframeApp_addSamplePO"+elsAccount,
		'windowMinWidth': 480,
		'windowMinHeight': 600,
		'windowWidth':480,
		'windowHeight':600,
		'parentPanel':".currDesktop"
   });
}
//添加附件--begin---
$(".click-addFile").live("click", function(){
	var index = $(this).closest("tr").index();
	$("body").data("rowIndex",index);
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_23.gif',
        'windowsId':'findFileInfo',
        'windowTitle':'添加附件',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>filemanage/findFileInfo.jsp?frameAppId=addSamplePO',
        'showAdv': true,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 550,
        'windowPositionTop':20,
        'windowWidth':960,
        'windowHeight':550,
        'parentPanel':".currDesktop"
    });
});
function setFileNumbers(fileNumbers){
	var index = $("body").data("rowIndex");
	if(fileNumbers && fileNumbers.length > 0){
		var fileNumbers = fileNumbers.replace(/@file@/g,'_');
    	var jsonObj = $("#samplePOForm").serializeJSON();
    	var item = jsonObj.purchaseOrderItemList[index];
    	var fbk27 = item.fbk27;
    	if(fbk27 != null && fbk27 != ""){
    		item['fbk27']=fbk27+";"+fileNumbers;
    	}else{
    		item['fbk27']=fileNumbers;
    	}
    	editTable.updateRow(item,index);
	}
}
//添加附件--end---

//头信息改变时自动同步到行上面去----begin---------
$("#deliveryDate").blur(function () {
	var deliveryDate = $(this).val();
	$("[name='purchaseOrderItemList[][deliveryDate]']").val(deliveryDate);
});
$("#currency").blur(function () {
	var currencyPrice = $(this).val();
	$("[name='purchaseOrderItemList[][currencyPrice]']").val(currencyPrice);
});
//头信息改变时自动同步到行上面去----end---------

//关闭--
$("#closeBtn").click(function () {
	parent.elsDeskTop.closeCurWin('addSamplePO');
});

//获取PLM文件
$("#btnGetPLMFile").click(function () {
	var jsonObj = $("#samplePOForm").serializeJSON();
	var items = jsonObj.purchaseOrderItemList;
	if(!items || items ==""){
		alert("请先添加行项目！",2);
		return;
	}
	var tempStr="";
	for(var i=0 ; i < items.length ; i++){
		var item = items[i];
		var materialNumber = item.materialNumber;
		if($.trim(materialNumber) == ""){
			continue;
		}
		var fbk27 = item.fbk27;
		tempStr += i+"@_#"+materialNumber+"@_#"+fbk27+";_,";
	}
	if(tempStr == ""){
		alert("至少填写一个物料编码",2);
		return;
	}
	tempStr = tempStr.substring(0,tempStr.length - 3);
	parent.elsDeskTop.showLoading("获取附件中。");
	$.ajax({
		url :"<%=basePath%>rest/ElsWsService/getFileNumbers/"+elsAccount,
		type :"get",
		contentType : "application/json",
		data:{"tempStr":tempStr},
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.statusCode == "-100"){
				alert(data.message , 3);
				return;
			}
			var array = data.fileName.split(";_,");
			for(var i = 0 ; i < array.length ; i ++){
				var str = array[i];
				var strs = str.split("@_#");
				var index = strs[0];
				if(strs.length > 1){
					var files = strs[1];
					var item = items[index];
					item['fbk27']=files;
					editTable.updateRow(item,index);
				}
			}
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert(data.responseText,3);
		}
	});
});

//移除附件--
$("#removeFile").click(function () {
	var selectedRowsIndex = editTable.selectedRowsIndex();
	if(selectedRowsIndex.length < 1){
		alert("请选择需要操作的行项目",2);
		return;
	}
	var jsonObj = $("#samplePOForm").serializeJSON();
	var items = jsonObj.purchaseOrderItemList;
	for(var i = 0 ; i < selectedRowsIndex.length ;i ++){
		var index = selectedRowsIndex[i];
		var item = items[index];
		item['fbk27']="";
		editTable.updateRow(item,index);
	}
	
});

//----------选择物料询价信息相关@author jiangzhidong @date 20160621-----begin-----------
var colsQueryMaterial = [
		         	    { title:'<i18n:I18n key="" defaultValue="物料编码"/>', name:'materialNumber' , width:140, align:'center'},
		         	    { title:'<i18n:I18n key="" defaultValue="物料描述"/>', name:'materialDesc' , width:180, align:'center'},
		         	    { title:'<i18n:I18n key="" defaultValue="物料组"/>', name:'materialGroup' , width:140, align:'center'}
		         	     ];

$("#btnQueryMaterial").click(function () {
	$("#selectMaterialDialog").show();
	var paramObj = $("#selectMaterialForm").serializeJSON();
	paramObj["elsAccount"]=elsAccount;
	
	if(!queryMaterialTable){
		queryMaterialTable = $('#query-material-table').mmGrid({
			url:"<%=basePath%>rest/MaterialService/queryMaterialList",
		    params:paramObj,
		    method: 'post',
		    root: 'rows',
   	       	height:300,
   	        cols: colsQueryMaterial,
   	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
   	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
   	        multiSelect: true,
   	        checkCol: true,
   	        indexCol:true,
   	        plugins: [
   	            $('#query-material-page').mmPaginator({
   	                style: 'plain'
   	                , totalCountName: 'total'
   	                , page: 1
   	                , pageParamName: 'currentPage'
   	                , limitParamName: 'pageSize'
   	                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
   	                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
   	                , limit: null
   	             	, limitList: [100, 50, 30 , 10]
   	            })
   	          ]
   	       });
  	    }
});

//关闭窗口
$("#btnQueryMaterialCancel").click(function(){
	$("#selectMaterialDialog").hide();
});
//关闭窗口
$("#btnSelectMaterialDialogClose").click(function(){
	$("#selectMaterialDialog").hide();
});

//查询
$("#queryMaterial").click(function(){
	var paramObj = $("#selectMaterialForm").serializeJSON();
	paramObj["elsAccount"]=elsAccount;
    $.extend(queryMaterialTable.opts.params,paramObj);
    queryMaterialTable.load();
});

/**
 * 确认选择物料
 */
 $("#btnQueryMaterialOK").click(function(){
		$("#selectMaterialDialog").hide();
		var selectRows = queryMaterialTable.selectedRows();
		var purchaseGroup = $("#purchaseGroup").val();
		var itemVOs = $("#purchaseEnquiryForm").serializeJSON().purchaseEnquiryMaterialVOs;
		for(var i = 0 ; i < selectRows.length ; i ++){
			var row = selectRows[i];
			if(itemVOs && itemVOs != ""){
				var isContinue = false;
				for(var j = 0 ; j < itemVOs.length ; j++){
					var itemVO = itemVOs[j];
					if(row.materialNumber == itemVO.materialNumber){
						isContinue = true;
					}
				}
				if(isContinue){
					continue;
				}
			}
			
			var item = {};
			item['materialNumber']=row.materialNumber;
			item['materialDesc']=row.materialDesc;
			item['materialGroup']=row.materialGroup;
			// 带入物料采购单位、计价单位
			item['unitQuantity']=row.purchaseUnit;
			item['priceQuantity']=row.purchaseUnit;
			item['requestDate']=new Date().format('yyyy-MM-dd');
			item['currency']="CNY";
			item['purchaseGroup']=purchaseGroup;
			item["quoteMethod"]=0;
			editTable.addRow(item);
			//设置询价单头 询价单描述字段
			var materialDescHead = $("#enquiryDesc").val();
			if(materialDescHead == null || materialDescHead == ""){
				$("#enquiryDesc").val(row.materialNumber+" - "+row.materialDesc);
			}
		}
	});

//----------选择物料询价信息相关@author jiangzhidong @date 20160621-----end------------
function renderPurchaseTypeSelector(val,item) {
	return "<select name='purchaseOrderItemList[][purchaseType]'>" +
	       "<option value='0'><i18n:I18n key='i18n_common_select_procurementtype_standard' defaultValue='标准' /></option>" +
		   "<option value='1'><i18n:I18n key='i18n_common_select_procurementtype_restrict' defaultValue='限制' /></option>" +
		   "<option value='2'><i18n:I18n key='i18n_common_select_procurementtype_consignment' defaultValue='寄售' /></option>" +
		   "<option value='3'><i18n:I18n key='i18n_common_select_procurementtype_subcontract' defaultValue='分包' /></option>" +
		   "<option value='4'><i18n:I18n key='i18n_common_select_procurementtype_anunknowncommodity' defaultValue='未知的商品' /></option>" +
		   "<option value='5'><i18n:I18n key='i18n_common_select_procurementtype_thirdparty' defaultValue='第三方' /></option>" +
		   "<option value='6'><i18n:I18n key='i18n_common_select_procurementtype_text' defaultValue='文本' /></option>" +
		   "<option value='7'><i18n:I18n key='i18n_common_select_procurementtype_stocktransfer' defaultValue='库存转储' /></option>" +
		   "<option value='8'><i18n:I18n key='i18n_common_select_procurementtype_commoditytype' defaultValue='商品类目' /></option>" +
		   "<option value='9'><i18n:I18n key='i18n_common_select_procurementtype_service' defaultValue='服务' /></option>" +
		   "</select>";
}
function genOverTolerance(a){
	var checked = $(a).is(':checked');
	if (checked) {
		$(a).parent().parent().parent().find("input[name='purchaseOrderItemList[][overTolerance]']").val("0.00");
		$(a).parent().parent().parent().find("input[name='purchaseOrderItemList[][overToleranceQuantity]']").val("0.000");
		$(a).parent().parent().parent().find("input[name='purchaseOrderItemList[][overToleranceQuantity]']").prev(".showText").text("0.000");
	}
}
function renderUnlimitedSelector(val,item){
	return "<input name='purchaseOrderItemList[][unlimited]' type='checkbox' value='X' onclick='genOverTolerance(this)' />";
}
function renderIsFinishCheckbox(val,item){
	if(val && val == "X")
		return "是";
	else
		return "<input name='purchaseOrderHeaderVO[isFinish]' type='checkbox' value='X' />";
}
function renderItemIsFinishCheckbox(val,item){
	if(val && val == "X")
		return "是";
	else
		return "<input name='purchaseOrderItemList[][fbk35]' type='checkbox' value='X' />";
}
</script>
</body>
</html>