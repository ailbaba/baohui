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
        <button class="button-wrap" id="publishSamplePO"><i18n:I18n key="" defaultValue="提交送检" /></button>
        <button class="button-wrap" id="closeBtn"><i18n:I18n key="" defaultValue="关闭" /></button>
    </div>
</div>
<form id="samplePOForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">

<div class="tab-wrap tab-wrap-change" id="add-enq-sheet">
    <ul>
        <li><a href="#edit-line-one"><i18n:I18n key="" defaultValue="样品行项目" /></a></li>
    </ul>
    <div class="p-zero" id="edit-line-one">
        <main class="bg-common p-6">
            <div class="edit-box-wrap" style="padding-top: 5px;">
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
<%--                 <button id="removeFile" class="button-wrap"><i18n:I18n key="" defaultValue="移除附件" /></button> --%>
            </div>
            <div class="grid-100" id="reCreate">
                <table id="add-enq-project"></table>
            </div>
        </main>
    </div>
  </div>
</form>

<script type="text/javascript">

var editTable;
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var userName = "<%=session.getAttribute("username")%>";
var currId ="<%=request.getParameter("currId") %>";

var paramObj = getIframeData();

var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="sampleOrderInspect_mt"/>;

$(document).ready(function() {
	
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
   
    var selectItem = paramObj.selectItem;
    var selectRows = paramObj.selectRows;
    
    $.ajax({
 		url : "<%=basePath%>rest/PurchaseSampleService/initInspectOrder",
 		type : "post",
 		data:JSON.stringify({"purchaseOrderItemList":selectRows}),
 		contentType : "application/json",
 		async:false,
 		dataType : "json",
 		success : function(data) {
 			var rows = data.rows;
 			 //初始化样品单行列表
 		    editTable=$('#add-enq-project').mmGrid({
 		    	cols: cols_item,
 		    	items:rows,
 		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
 		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
 		        multiSelect: true,
 		        nowrap:true,
 		        checkCol: true,
 		        indexCol:false
 		    });
 		}
 	});
    
});

   
    function initInput(val,item,index){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
		return '<input  style="width:46px;height: 14px;"  name="childInfos[]['+name+']"  type="text" value="'+val+'"/>';
    }
    
    function initInputHide(val,item,index){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
		return val+'<input   name="childInfos[]['+name+']"  type="hidden" value="'+val+'"/>';
    }
    
    function initInputDouble(val,item,index,colName){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
		return '<input  onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 14px;"  name="childInfos[]['+name+']"  type="text" value="'+val+'"/>';
    }

    function initInputDate(val,item,index){
    	if(!val) { val = '';}
    	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
    	var name = $(this)[0].name;
    	return '<input class="Wdate" onfocus="WdatePicker({minDate: \'%y-%M-%d\'})" style="width:46px;height: 14px;"  name="childInfos[]['+name+']"  type="text" value="'+val+'"/>';
    }
    
    function initAddFile(val,item,index){
    	var showText='';
    	if(!val){
    		showText="查看";
    		val = "";
    	}else{
    		var fileArray = val.split(";");
    		for(var i in fileArray){
    			var file = fileArray[i];
    			showText += file.substring(file.indexOf("_")+1,file.length)+";"
    		}
    		showText=showText.substring(0,showText.length-1);
    	}
    	return '<span class="click-addFile" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><input style="display: none;"  name="childInfos[][testAccessory]"  type="text" value="'+val+'"/>';
    }
    
    //回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
    function callBack(){
    	parent.elsDeskTop.closeCurWin('samplePOInspect');
    	if(parent.frames[currId]) {
    		parent.frames[currId].query();
    	}
    } 
   
   
$("#columnDefineBtn").click(function(){
   columnDefine("sampleOrderInspect_mt");//行情询价
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
	debugger;
	var index = $(this).closest("tr").index();
	var selectedRow = editTable.rows()[index];
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
        'windowTitle':'查看附件',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>samplemanage/purchase/showSamplePOFile.jsp?currId='+currId,
        'showAdv': true,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 550,
        'windowPositionTop':20,
        'windowWidth':960,
        'windowHeight':550,
        'parentPanel':".currDesktop",
        'data':selectedRow
    });
});
function setFileNumbers(fileNumbers){
	var index = $("body").data("rowIndex");
	if(fileNumbers && fileNumbers.length > 0){
		var fileNumbers = fileNumbers.replace(/@file@/g,'_');
    	var jsonObj = $("#samplePOForm").serializeJSON();
    	var item = jsonObj.childInfos[index];
    	var testAccessory = item.testAccessory;
    	if(testAccessory != null && testAccessory != ""){
    		item['testAccessory']=testAccessory+";"+fileNumbers;
    	}else{
    		item['testAccessory']=fileNumbers;
    	}
    	editTable.updateRow(item,index);
	}
}
//添加附件--end---


//关闭--
$("#closeBtn").click(function () {
	parent.elsDeskTop.closeCurWin('samplePOInspect');
});


//移除附件--
$("#removeFile").click(function () {
	var selectedRowsIndex = editTable.selectedRowsIndex();
	if(selectedRowsIndex.length < 1){
		alert("请选择需要操作的行项目",2);
		return;
	}
	var jsonObj = $("#samplePOForm").serializeJSON();
	var items = jsonObj.childInfos;
	for(var i = 0 ; i < selectedRowsIndex.length ;i ++){
		var index = selectedRowsIndex[i];
		var item = items[index];
		item['testAccessory']="";
		editTable.updateRow(item,index);
	}
	
});

$("#publishSamplePO").click(function () {
	var voucherNumber = editTable.rows()[0].fbk1;
	var jsonObj = $("#samplePOForm").serializeJSON();
	var items = jsonObj.childInfos;
	var selectItem = paramObj.selectItem;
	selectItem["voucherNumber"] = voucherNumber;
    selectItem["childInfos"] = items;
    selectItem["elsAccount"]=elsAccount;
    parent.elsDeskTop.tip.init({type: 'confirm',message:"确认提交送检？",closeEvent:function(){
    	parent.elsDeskTop.showLoading("处理中");
    	$.ajax({
     		url : "<%=basePath%>rest/PurchaseSampleService/createWorkflowBySRM",
     		type : "post",
     		data:JSON.stringify(selectItem),
     		contentType : "application/json",
     		dataType : "json",
     		success : function(data) {
     			debugger;
     			parent.elsDeskTop.hideLoading();
     			if(data.statusCode == "-100"){
     				alert(data.message,3);
     			}else{
     				alert("送检单已成功提交！",1);
     				callBack();
     			}
     		},
			error: function (msg) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("操作失败:"+msg.responseText,3); 
	        }
     	});
    }});
	
});

</script>
</body>
</html>