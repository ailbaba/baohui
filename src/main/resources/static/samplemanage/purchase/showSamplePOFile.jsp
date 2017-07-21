<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

<style type="text/css" media="screen">  
html, body   { height:100%; }  
body { margin :0; padding:0; overflow:auto ; }    
#flashContent { display :none; }  
</style>

<body>
<form id="samplePOForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">

<div class="tab-wrap tab-wrap-change" id="add-enq-sheet">
    <ul>
         <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
    </ul>
    <div class="p-zero" id="sheet-project-two">
        <main class="bg-common p-6">
            <div class="grid-100" id="reCreate">
                <table id="table-file"></table>
            </div>
        </main>
    </div>
  </div>
</form>

<script type="text/javascript">

var fileGrid;
var editTable;
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var userName = "<%=session.getAttribute("username")%>";
var currId ="<%=request.getParameter("currId") %>";
var selectedRow = getIframeData();
var materialVoucherNumber = selectedRow.fbk1;
var toElsAccount = selectedRow.toElsAccount;

var cols_file = [{ title:'id',name:'formId' ,width:200, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'materialVoucherItemNumber' ,width:90, align:'center',renderer:function(val){
	                 	if (val == ""||val== null) {
	                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialheader" defaultValue="凭证头文件" />';
	                	} else{
	                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialitem" defaultValue="凭证项文件" />';
	                	}
	                }},
              { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="订单项编号" />',name:'materialVoucherItemNumber' ,width:200, align:'center',hidden:true},
              { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />',name:'filePath' ,width:200, align:'center',hidden:true},
              { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:400, align:'center'},
              { title:'<i18n:I18n key="i18n_delivery_lable_mobiletype" defaultValue="移动类型" />',name:'mobileType' ,width:200, align:'center',hidden:true},
              { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="待发状态" />', name:'fileStatus' ,width:59, align:'center',renderer:function(val){
             	 var showText;
             	 if (val == "0") {
             		 showText = '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
             	} else if (val == "1") {
             		showText = '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
             	} else if (val == "2") {
             		showText = '<i18n:I18n key="i18n_common_title_sendstatus_received" defaultValue="已接收" />';
             	}
              	return showText;
              }},
              { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
	                  	if (val == elsAccount) {
	                 		return '<i18n:I18n key="i18n_label_self" defaultValue="已方" />';
	                 	} else {
	                 		return '<i18n:I18n key="i18n_label_otherSide" defaultValue="对方" />';
	                 	} 
	             }}
          ];

$(document).ready(function() {
	initFileGrid();
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
    debugger;
    var data = {"elsAccount":toElsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":"601"};
    
    $.ajax({
		url :"<%=basePath%>rest/MaterialFormFileService/findMaterialFormFile",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : "json",
		success : function(data) {
			fileGrid.load(data.rows);
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
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
    		showText="添加";
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
        'windowTitle':'查看附件',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>samplemanage/purchase/samplePOInspect.jsp?currId='+currId,
        'showAdv': true,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 550,
        'windowPositionTop':20,
        'windowWidth':960,
        'windowHeight':550,
        'parentPanel':".currDesktop",
        'data':paramObj
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
	
	var jsonObj = $("#samplePOForm").serializeJSON();
	var items = jsonObj.childInfos;
	var selectItem = paramObj.selectItem;
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
function initFileGrid(){
	if(!fileGrid){
		fileGrid = $('#table-file').mmGrid({
	        cols: cols_file,
	        items: [],
	        checkCol: true
	    });
	}
}
</script>
</body>
</html>