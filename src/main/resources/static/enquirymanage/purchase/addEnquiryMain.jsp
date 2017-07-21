<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="addEnquiryMainHeader.jsp"%>

<script type="text/javascript">

var editFileTable;
var editTable;
var editSupplieTable;
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var userName = "<%=session.getAttribute("username")%>";
var currId ="<%=request.getParameter("currId") %>";
var fileUploader;
var excelUploader;
var addLadderPriceTable;
var selectUnitOfMeasurementTable;
var selectCostConstituteTemplateTable;
var selectCostConstituteTemplateItemTable;
var sapMaterialTable;
var selectPrincipalTable;
var orderType = 1;
var rightScroll;
var leftScroll;
var cols;
var supplieQuotaTable;
var queryTextureTable;
var queryMaterialTable;
var queryMaterialReplaceTable;
var taxRate=[];
var purchaseApplyJson = getIframeData();
var items=[];
var materialReplaceFirst = true;

$(document).ready(function() {
	
	window.beforeClose = function(close){
	    top.elsDeskTop.tip.init({type: 'confirm',displayType: 2,message: '确认关闭?',closeEvent : function () {
	           callBack();
	           close();
	        }
	    });
	}; 
    //初始化控件
    $( '#add-enq-sheet').tabs();
    $("#FBK4").val(elsSubAccount+"_"+userName);
    var beginDate = new Date();
    $("#beginDate").val(beginDate.format('yyyy-MM-dd'));
    var endDate_milliseconds=beginDate.getTime()+1000*60*60*24*3; 
    var endDate=new Date(); 
    endDate.setTime(endDate_milliseconds); 
    $("#endDate").val(endDate.format('yyyy-MM-dd'));
    //供应商配额tag页默认隐藏
    $(".supplier-isShow").hide();
    $(".ishowTexture").hide();
    $('.col-sel').live('dblclick',function() {
        if($(this).find('input').length<= 0) {
            var inp= $('<input type="text" />');
            var ph=$(this).height()-10;
            var pw= $(this).width()-20;
            inp.css({'height': ph+'px','width': pw+'px'});
            var inpVal=$(this).find('span').text();
            var inp = '<input class="cancel-focus" type="text" style="height: '+ ph+'px; width: '+pw+'px; margin:0px " value='+ inpVal +' />'
            $(this).find('span').hide();
            $(inp).appendTo($(this)).show().focus();
        }
    });
    $('.cancel-focus').live('blur',function() {
        var inpVal =$(this).val();
        $(this).siblings('span').show().text(inpVal);
        var selCel = $('body').data('selectCel');
        editTable.updateRow();
        $(this).remove();
    });
    initExcelUploader();
    //选中列
    var selColItem = function(val,item,rowIndex){
        return '<div class="col-sel"><span>' + val + '</span></div>';
    };
    
	//获取询报价-税码、税率  @author jiangzhidong @date 20160526
	$.ajax({
	    url :"<%=basePath%>rest/ElsTaxRateService/queryElsTaxRateList",
	    type :"post",
	    contentType : "application/json",
	    data : JSON.stringify({"elsAccount":elsAccount}),
	    dataType : "json",
	    success : function(data) {
	    	if(data.statusCode == "-100"){
			}else{
				taxRate = data.rows;
				
				// @author move/jiangzhidong @date 20160526
			    if(purchaseApplyJson){
			    	for(var i = 0; i < purchaseApplyJson.length; i ++){
			    		var item = purchaseApplyJson[i];
			    		item["isERP"]="yes";
			    		items.push(item);
			    	}
			    }
			    //默认物料询价--物料列加载
			    cols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryItem_material_mt"/>;
			    editTable = $('#add-enq-project').mmGrid({
			        cols: cols,
			        items:items,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
			        fullWidthRows:true,
		   	        multiSelect: true,
		   	        checkCol: true,
		   	    	nowrap:true,
		   	        indexCol:true
			    });
			    editTable.on('loadSuccess', function(e, data){
			    	if(data){
			    		$("#enquiryDesc").val(data.materialNumber+" - "+data.materialDesc);
			    	}
				});
			    editTable.on('rowInserted', function(e, item, index){
				});
			    editTable.on('rowRemoved', function(e, item, index){
				});
			   // @author move/jiangzhidong @date 20160526
			}
	    },
	    error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
    });
    
    
    supplieQuotaTable = $('#supplie-quota').mmGrid({
        cols: supplieQuotaClos,
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        fullWidthRows:true
    });
    
    editSupplieTable=$('#add-supplie-project').mmGrid({
        cols: colsSupplie,
        width: 325,
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        checkCol : true,
		multiSelect: true,
		indexCol: true
    });
	editSupplieTable.on('rowInserted', function(e, item, index){
	});
	editSupplieTable.on('rowRemoved', function(e, item, index){
	});
	editSupplieTable.on('loadSuccess', function(e, data){
	});
	editSupplieTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
    });
	
	//获取当前用户默认的采购组、采购组织
	$.ajax({
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
				debugger;
				if(purchaseGroup.length > 0){
					$("#purchaseGroup").val(purchaseGroup.split(";")[1]);
				}
				if(purchaseOrganization.length > 0){
					$("#purchaseOrganization").val(purchaseOrganization.substring(1,purchaseOrganization.length));
				}
			}
	    }
    });
	
});

//--物料编码失去焦点事件-----
$('.blur_materialNumber').live('blur',function() {
	var rowIndex = $(this).closest("tr").index();
    var frmObj = $("#purchaseEnquiryForm").serializeJSON();
	var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
	var scanCol = $(this).next();
    var sanContentText = scanCol.text();
    var sanContent = sanContentText.split("@enquiry@"); 
	var currentLineObj = JSON.parse(sanContent[0]);
	var materialNumber = $(this).val();
	if(materialNumber != ""){
		$.ajax({
			url :"<%=basePath%>rest/MaterialService/getMaterial",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"elsAccount":elsAccount,"materialNumber":materialNumber}),
			success : function(data) {
				if(data.statusCode == null){
					var materialDesc = data.materialDesc;
					var materialSpecification = data.fbk2;
					var purchaseUnit = data.purchaseUnit;
					var basicUnit = data.basicUnit;
					if(materialDesc != null && materialDesc != ""){
						materialLineJsonObj["materialDesc"]=materialDesc;
					}
					if(materialSpecification != null && materialSpecification != ""){
						materialLineJsonObj["materialSpecification"]=materialSpecification;
					}
					if(purchaseUnit != null && purchaseUnit != ""){
						materialLineJsonObj["unitQuantity"]=purchaseUnit;
						materialLineJsonObj["priceQuantity"]=purchaseUnit;
					}else if(basicUnit != null && basicUnit != ""){
						materialLineJsonObj["unitQuantity"]=basicUnit;
						materialLineJsonObj["priceQuantity"]=basicUnit;
					}
					materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
					editTable.updateRow(materialLineJsonObj,rowIndex);
					//设置询价单头 询价单描述字段
					var materialDescHead = $("#enquiryDesc").val();
					if(materialDescHead == null || materialDescHead == ""){
						$("#enquiryDesc").val(materialNumber+" - "+materialDesc);
					}
				}
			}
		});
		
	}
});

//--物料描述失去焦点事件-----
$('.blur_materialDesc').live('blur',function() {
	//设置询价单头 询价单描述字段
	var materialDescHead = $("#enquiryDesc").val();
	if(materialDescHead == null || materialDescHead == ""){
		var rowIndex = $(this).closest("tr").index();
	    var frmObj = $("#purchaseEnquiryForm").serializeJSON();
		var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
		var materialNumber = materialLineJsonObj.materialNumber;
		var materialDesc = $(this).val();
		$("#enquiryDesc").val(materialNumber+" - "+materialDesc);
	}
});
    
//**********阶梯报价相关 *****begin***********************************

     var colsLadderPrice = [
   	                        { title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="申请订单号"/>', name:'purchaseOrderNumber' ,hidden:true, width:60, align:'center'},
   	                        { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行号"/>', name:'orderItemNumber' ,hidden:true, width:60, align:'center'},
   	                        { title:'<i18n:I18n key="i18n_common_title_materialnumber" defaultValue="物料编码"/>', name:'materialNumber' , width:100, align:'center'},
   	                        { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述"/>', name:'materialDesc' , width:180, align:'center'},
   	                        { title:'<i18n:I18n key="i18n_ladderprice_title_quantity" defaultValue="数量从"/>', name:'beginQuantity' , width:80, align:'center'},
   	                        { title:'<i18n:I18n key="i18n_ladderprice_title_quantityto" defaultValue="数量到"/>', name:'endQuantity' , width:80, align:'center'}
   	                    ];
     var colsUnitOfMeasurement = [
		         	                { title:'<i18n:I18n key="i18n_common_title_unitcode" defaultValue="单位代码"/>', name:'unitCode' , width:100, align:'center'},
		         	                { title:'<i18n:I18n key="i18n_common_title_unitname" defaultValue="单位名称"/>', name:'unitName' , width:180, align:'center'}
		         	            ];
   	                    
     function selectDown(val,item,rowIndex) {
          var sel = '<div><p style="display: none;">'+JSON.stringify(item)+'</p><select name="purchaseEnquiryMaterialVOs[][quoteMethod]" class="select-tag" style="padding: 0;height: 25px;width: 100px;">';
          if(val == "0" || !val){
        	  sel += '<option value="0" selected>常规报价</option><option value="1">阶梯报价</option>';
          }else if(val == "1"){
        	  sel += '<option value="0" >常规报价</option><option value="1" selected>阶梯报价</option>';
          }
        return sel;
    }
    //TODO:设置阶梯报价下拉事件
    $('.select-tag').live('change',function(e) {
        e.stopPropagation();
        var value = $(this).find("option:selected").val();
        var rowIndex = $(this).closest("tr").index();
        var frmObj = $("#purchaseEnquiryForm").serializeJSON();
		var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
		materialLineJsonObj["quoteMethod"]=value;
		var materialLineJson = $(this).siblings('p').text();
		var currentLineObj = JSON.parse(materialLineJson);
		materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
		editTable.updateRow(materialLineJsonObj,rowIndex);
    });
    //阶梯报价单击按钮
    function scanCol(val, item, rowIndex){
        if(item.quoteMethod == '1') {
            return '<span class="col-scan" style="cursor: pointer;color:blue;" ><i18n:I18n key="i18n_common_label_settings" defaultValue="设置" /></span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
        } else {
            return '<span></span>';
        }
    };
   //增加阶梯报价
    $("#btnAddLadderPrice").click(function(){
   	 var beginNumberTxt = $("#beginNumber");
   	 var endNumberTxt = $("#endNumber");
   	 if(beginNumberTxt.val() == ""){
   		 parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n key="i18n_ladderprice_alert_startnumbernotempty" defaultValue="起始数量不能为空！" />'});
   		 beginNumberTxt.focus();
   		 return;
   	 }
   	 if(endNumberTxt.val() == ""){
   		 parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n key="i18n_ladderprice_alert_endnumbernotempty" defaultValue="截止数量不能为空！" />'});
   		 endNumberTxt.focus();
   		 return;
   	 }
   	 var beginNumber = parseInt(beginNumberTxt.val());
   	 var endNumber = parseInt(endNumberTxt.val());
   	 var purchaseOrderNumber = $("#ladderPrice_purchaseOrderNumber").val();
   	 var orderItemNumber = $("#ladderPrice_orderItemNumber").val();
   	 var materialNumber = $("#ladderPrice_materialNumber").val();
   	 var materialDesc = $("#ladderPrice_materialDesc").val();
   	 if(beginNumber > endNumber){
   		 parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n key="i18n_ladderprice_alert_maxmustGTmin" defaultValue="最大数量不能小于最少数量！" />'});
   		 endNumberTxt.val("");
   		 endNumberTxt.focus();
   	 }else{
   		 var data = {
           		 purchaseOrderNumber : purchaseOrderNumber,
           		 orderItemNumber : orderItemNumber,
           		 materialNumber : materialNumber,
           		 materialDesc : materialDesc,
           		 beginQuantity : beginNumber,
           		 endQuantity : endNumber
   			};
   		 addLadderPriceTable.addRow(data);
   		 beginNumberTxt.val(endNumber+1);
   		 endNumberTxt.val("");
   		 endNumberTxt.focus();
   	 }
    });
   //删除阶梯报价
    $("#btnDelLadderPrice").click(function(){
   	   var selectedIndexes = addLadderPriceTable.selectedRowsIndex();
   	   addLadderPriceTable.removeRow(selectedIndexes);
    });
   //单击设置阶梯报价按钮
    $('.col-scan').live("click", function() {
   	 $("#setLadderPriceDialog").show();
   	 debugger;
   	 if(!addLadderPriceTable){
   		 addLadderPriceTable = $('#add-ladder-price-table').mmGrid({
    	       	   height:180,
    	           cols: colsLadderPrice,
    	           loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
    	           noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
    	           multiSelect: true,
    	           checkCol: true,
    	           indexCol:true
    	       });
   	    }
        var scanCol = $(this).next();
        var sanContentText = scanCol.text();
        var sanContent = sanContentText.split("@enquiry@"); 
        var oldRowIndex = sanContent[1];
        var rowIndex = $(this).closest("tr").index();
		var materialLineJsonObj = JSON.parse(sanContent[0]);
		var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
		var purchaseEnquiryMaterialVOs = jsonObj.purchaseEnquiryMaterialVOs;//获得input框输入的物料信息
		var purchaseOrderNumber = purchaseEnquiryMaterialVOs[rowIndex].purchaseOrderNumber;
		var orderItemNumber = purchaseEnquiryMaterialVOs[rowIndex].orderItemNumber;
	    var materialNumber = purchaseEnquiryMaterialVOs[rowIndex].materialNumber;
		var materialDesc = purchaseEnquiryMaterialVOs[rowIndex].materialDesc;
        $("#materialRowIndex").val(rowIndex);
        $('body').data("materialLineJsonObj",materialLineJsonObj);
        //取出并判断存放价格阶梯json是否为空
        var ladderPriceJson = materialLineJsonObj.ladderPriceJson;
        addLadderPriceTable.load();
        $("#beginNumber").val(1);
        if(ladderPriceJson != null && ladderPriceJson != ""){
       	    var priceObj = ladderPriceJson[ladderPriceJson.length-1];
       	    var endNumber = priceObj.endQuantity;
       	    $("#beginNumber").val(endNumber+1);
       	    for(var itemObj in ladderPriceJson){
       	    	ladderPriceJson[itemObj].materialNumber = materialNumber;
       	    	ladderPriceJson[itemObj].materialDesc = materialDesc;
       	    	ladderPriceJson[itemObj].purchaseOrderNumber = purchaseOrderNumber;
       	    	ladderPriceJson[itemObj].orderItemNumber = orderItemNumber;
       	    }
       	    addLadderPriceTable.load(ladderPriceJson);
        }
        $("#ladderPrice_purchaseOrderNumber").val(purchaseOrderNumber);
        $("#ladderPrice_orderItemNumber").val(orderItemNumber);
        $("#ladderPrice_materialNumber").val(materialNumber);
        $("#ladderPrice_materialDesc").val(materialDesc);
//         $("#titleLadderPriceDialog").text('<i18n:I18n key="i18n_enquiry_title_materialsinformation" defaultValue=" 物料信息" />： '+materialNumber+" "+materialDesc);
    });
    //阶梯报价窗口确定按钮
    $("#btnAddLadderPriceOK").click(function(){
    	debugger;
    	var flag = $("body").data("setLadder");
    	var ladderPriceJson = [];
   	    var ladderPriceItmes = addLadderPriceTable.rows();
   	    for(var i=0; i< ladderPriceItmes.length;i++){
   		    ladderPriceJson.push(ladderPriceItmes[i]);
        }
   	    if(flag){
   	    	$("body").data("ladderPriceItmes",ladderPriceItmes);
   	    }else{
   	    	var materialLineJson = $('body').data("materialLineJsonObj");
   	   	    var rowIndex = $("#materialRowIndex").val();
   	   	    materialLineJson['ladderPriceJson']= ladderPriceJson;
   	   	    materialLineJson["changeFlag"]=rowIndex;
   	     	var frmObj = $("#purchaseEnquiryForm").serializeJSON();
   	   	    var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
	        materialLineJsonObj = initUpdateObj(materialLineJson,materialLineJsonObj);
		    editTable.updateRow(materialLineJsonObj,rowIndex);
   	    }
   	    $("body").data("setLadder",false);
   	    $("#setLadderPriceDialog").hide();
   	    $("#beginNumber").val(1);
    });
    //阶梯报价窗口取消按钮
    $("#btnAddLadderPriceCancel").click(function(){
    	$("#setLadderPriceDialog").hide();
    });
    //关闭阶梯报价设置窗口按钮
    $("#btnsetLadderPriceDialogClose").click(function(){
   	    $("#setLadderPriceDialog").hide();
     });
  //**********设置阶梯报价相关*****end*********************************************
  
    //设置成本组成渲染
    function setCostConstitute(val, item, rowIndex){
       var fr = '<span class="col-CostConstitute" style="cursor: pointer;color:blue;">';
 	   var content;
 	   if(item.isSetCost && item.isSetCost == 'Y'){
 		   content = '<i18n:I18n key="" defaultValue="已设置" />'
 	   }else{
 		   content = '<i18n:I18n key="i18n_common_label_settings" defaultValue="设置" />'
 	   }
 	   var end = '</span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
       return fr+content+end;
    };
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
    
    //判断是否是从erp获取，如果是则字段不可编辑
    function isFromERP(val,item,index,name){
    	if(!val) { val = '';}
    	var isERP = item.isERP;
    	var name = $(this)[0].name;
    	if(isERP == null || isERP != "yes" || name == "materialDesc"){
    		return '<input  style="width:46px;height: 14px;" class="blur_'+name+'"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}else{
    		return '<input readonly style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}
    }
    //
    function initInputDate(val,item,index){
    	if(!val) { val = '';}
    	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
    	var isERP = item.isERP;
    	var name = $(this)[0].name;
    	if(isERP == null || isERP != "yes"){
    		return '<input class="Wdate" onfocus="WdatePicker({minDate: \'%y-%M-%d\'})" style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}else{
    		return '<input  readonly style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}
    }
    // 税码/税率  @author jiangzhidong @date 20160523 begin
    var initTaxCode = function (val,item,index) {
    	var name = $(this)[0].name;
        var sel = '<div><p style="display: none;">'+JSON.stringify(item)+'</p><select onchange="changeTaxCode(this.id, '+index+')" name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" class="taxType" style="padding: 0;height: 25px;">';
        for(var i = 0 ; i < taxRate.length ; i ++){
			var row = taxRate[i];
			if(row.taxCode=='J1')
			sel += '<option value="'+row.taxCode+'" taxValue="'+row.taxValue+'" selected>'+row.taxCode+'_'+row.taxName+'</option>';
			else
			sel += '<option value="'+row.taxCode+'" taxValue="'+row.taxValue+'">'+row.taxCode+'_'+row.taxName+'</option>';
		}
        return sel;
    }
    var initTaxValue = function (val,item,index) {
    	if(!val) { val = '';}
    	if(taxRate.length>0){
         	for(var i = 0 ; i < taxRate.length ; i ++){
    			var row = taxRate[i];
    			if(row.taxCode=='J1') 
    				val = row.taxValue;
    		}
        }
    	var name = $(this)[0].name;
		return '<input readonly="readonly" style="width:46px;height: 14px;" name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
    }
	var changeTaxCode = function(val,index){
		var obj=document.getElementById(val);  
		var selIndex=obj.selectedIndex;  
		var text=obj.options[selIndex].getAttribute("taxValue");  
		$('#taxValue_'+index).val(text);
		return val;
	}
    // 税码/税率 @author jiangzhidong @date 20160523 end
   
    //渲染文件发送状态
    function redererFileSendStatus(val){
    	if(val == 0){
			return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
		}else if(val == 1){
			return '<i18n:I18n key="i18n_common_select_sendstatus_saapunut" defaultValue="已送达" />';
		}else if(val == 2){
			return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
		}else{
			return "";
		}
    }
    //列
    var colsfile = [
        { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>', name:'fileName' , width:80, align:'center'},
        { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>', name:'filePath' , width:60, align:'center',hidden:true},
        { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型"/>', name:'fileType' , width:60, align:'center',hidden:true},
        { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态"/>', name:'fileStatus' ,width:100, align:'center', renderer: redererFileSendStatus},
        { title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="请求单号"/>', name:'purchaseApplyNumber' ,width:140, align:'center'},
        { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行项目号"/>', name:'purchaseApplyItemNumber' ,width:140, align:'center'},
        { title:'<i18n:I18n key="i18n_common_title_materialnumber" defaultValue="物料编码"/>', name:'purchaseMaterialNumber' ,width:130, align:'center'},
        { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述"/>', name:'purchaseMaterialDesc' ,width:120, align:'center'},
        { title:'materialIndex', name:'materialIndex' ,width:60, align:'center',hidden:true}
    ];
    $('.add-file-sheet').click(function() {
    	if(!editFileTable) {
    		editFileTable=$('#add-file-project').mmGrid({
				autoLoad:false,
    	        cols: colsfile,
    	        url: "",
    	        method: 'get',
    	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
    	        multiSelect: false,
    	        checkCol: true,
    	        fullWidthRows: true,
    	        indexCol:false
    	    }); 
    		editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
    			var seled=editFileTable.selectedRows();
    			if(seled && seled.length) {
    				var filePath = item.filePath;
        			//增加文件选择控制
        			if(filePath && filePath.length) {
//         				previewFile(filePath);
        			} else {
        				alert('<i18n:I18n key="i18n_enquiry_alert_notfoundfilepath" defaultValue="服务器异常，找不到文件上传的路径" />',3);
        			}
    			}
    		});
    	}
    	//初始化文件tag的文件下拉类型----------begin------------
    	var frmObj = $("#purchaseEnquiryForm").serializeJSON();
		var rows = frmObj.purchaseEnquiryMaterialVOs;
    	//每次进来都是初始化一个默认的下拉列表
    	$('#file-list-head').html('<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="文件类型" />：'+
    			'</span><select class="" id="selectFileType" name="selectFileType" onchange="selectFileTypeChange();">'+
    			'<option value="" store=""><i18n:I18n key="i18n_common_select_filetype_all" defaultValue="所有文件" />'+
    			'</option><option value="" store=""><i18n:I18n key="i18n_common_select_filetype_public" defaultValue="公共文件" /></option>');
    	if(rows != "" && rows != null){
    		for(var i = 0 ; i < rows.length ; i ++){
    			var singleRow = rows[i];
    			//调用materialLineAddEvent方法给下拉列表增加项
    			materialLineAddEvent(singleRow.purchaseOrderNumber,singleRow.orderItemNumber,singleRow.materialNumber,singleRow.materialDesc,i);
    		}
    	}
    	var showTable = [];
    	showTable = loadAllFile(showTable);
    	editFileTable.load(showTable);
    });
    
    //--------供应商列表----begin------------
    var colsSupplie = [
                    { title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS账号"/>', name:'toElsAccount' , width:120, align:'center'},
                    { title:'<i18n:I18n key="i18n_common_title_suppliername" defaultValue="供应商名称"/>', name:'toElsDesc' , width:180, align:'center'}
                ];
    
    $('.add-supplier-sheet').click(function() {
    	var supplieRows = editSupplieTable.rows();//获取当前供应商列表所有供应商信息
    	if(supplieRows == ""){
    	}
    });
    //TODO:初始化供应商列表
    function initSupplieTable(){
    	var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
    	var materialItmes = jsonObj.purchaseEnquiryMaterialVOs;
    	if(!materialItmes){
    		alert("请先添加物料行信息！",2);
    		return;
    	}
    	for(var i = 0 ; i < materialItmes.length ; i ++ ){
    		var item = materialItmes[i];
    		var param = {"elsAccount":elsAccount,"materialNumber":item.materialNumber};
    		$.ajax({
    			url :"<%=basePath%>rest/PurchaseEnquiryItemService/findMaterialSupplieQuote",
    			type :"POST",
    			contentType : "application/json",
    			dataType : "json",
    			data:JSON.stringify(param),
    			success : function(data) {
    				if(data.statusCode != "-100"){
    					var rows = data.rows;
    					if(rows){//判断是否存在该物料行对应的供应商历史报价
    						var supplieRows = editSupplieTable.rows();//获取当前供应商列表所有供应商信息
							if(supplieRows != ""){
								for(var i = 0 ; i < supplieRows.length ; i++){
    								for(var j = 0 ; j < rows.length ; j ++ ){
    									var toElsAccount = supplieRows[i].toElsAccount;
    									var _toElsAccount = rows[j].toElsAccount;
    									if(toElsAccount == _toElsAccount){
    										rows.splice(j,1); //去重
    									}
    									
    								}
    							}
							}
							if(rows.length > 0){
								editSupplieTable.addRow(rows);
							}
    					}
    				}
    			}
    		});
    	}
    	alert("操作成功！",1);
    	$('#add-enq-sheet').tabs({active:2});
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
		debugger;
        if(storeNewArr && storeNewArr.length) {
        	for(var i=0;i<storeNewArr.length; i++) {
        		var textObj = JSON.parse($(storeNewArr[i]).find('.storeData').text());
        		var Account = textObj.friendElsAccount;
                var fromIndex = textObj.fromIndex;
                var nameDes = textObj.friendCompanyName;
                var obj = {
               		"toElsAccount":Account,
                	"toElsDesc":nameDes,
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
				//计量单位设置默认PCS
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
		//设置询价单类型下拉框为不可用
		$("#orderType").attr("disabled",true); 
		//$("#columnDefineBtn").attr("disabled",true);
		
		//@author add/jiangzhidong @date 20160601 begin
	   	var rows = editTable.rows();
	   	if(rows.length > 0){
	   	    var obj = rows[0];
	   	    $("#enquiryDesc").val(obj.materialNumber+" - "+obj.materialDesc);
	   	}
	   	//@author add/jiangzhidong @date 20160601 end
		
    });
    
    
    $("#btnManuDel").click(function(){
    	 $("#enquiryDesc").val("");
    	 var selectedIndexes = editTable.selectedRowsIndex();
    	 editTable.removeRow(selectedIndexes);
    	 var length = editTable.rowsLength();
    	 if(length == 0){
    		 $("#orderType").attr("disabled",false); 
    		 //$("#columnDefineBtn").attr("disabled",false);
    	 }
    	 //@author add/jiangzhidong @date 20160601 begin
    	 var rows = editTable.rows();
    	 if(rows.length > 0){
    		 var obj = rows[0];
    		 $("#enquiryDesc").val(obj.materialNumber+" - "+obj.materialDesc);
    	 }
    	 //@author add/jiangzhidong @date 20160601 end
    });
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
        	var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
        	var item = jsonObj.purchaseEnquiryMaterialVOs[index];
        	var accessoryRequire_AddFile = item.accessoryRequire_AddFile;
        	if(accessoryRequire_AddFile != null && accessoryRequire_AddFile != ""){
        		item['accessoryRequire_AddFile']=accessoryRequire_AddFile+";"+fileNumbers;
        	}else{
        		item['accessoryRequire_AddFile']=fileNumbers;
        	}
        	editTable.updateRow(item,index);
    	}
    }
  //获取PLM文件
    $("#btnGetPLMFile").click(function () {
    	var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
    	var items = jsonObj.purchaseEnquiryMaterialVOs;
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
    		var accessoryRequire_AddFile = item.accessoryRequire_AddFile;
    		if(accessoryRequire_AddFile){
    			tempStr += i+"@_#"+materialNumber+"@_#"+accessoryRequire_AddFile+";_,";
    		}else{
	    		tempStr += i+"@_#"+materialNumber+"@_#"+""+";_,";
    		}
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
    					item['accessoryRequire_AddFile']=files;
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
    	var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
    	var items = jsonObj.purchaseEnquiryMaterialVOs;
    	for(var i = 0 ; i < selectedRowsIndex.length ;i ++){
    		var index = selectedRowsIndex[i];
    		var item = items[index];
    		item['accessoryRequire_AddFile']="";
    		editTable.updateRow(item,index);
    	}
    	
    });
    
    //----------添加附件相关-----------begin------------------
     function scanAddFile(val, item, rowIndex){
         if(!item.fbk10) {
             return '<span class="col-scan-file" style="cursor: pointer;color:blue;"><i18n:I18n key="i18n_common_label_addition" defaultValue="添加" /></span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
         } else {
        	 var showText='';
         	if(!item.fbk10){
//          		showText="添加";
         		item.fbk10 = "";
         	}else{
         		var fileArray = item.fbk10.split(";");
         		for(var i in fileArray){
         			var file = fileArray[i];
         			showText += file.substring(file.indexOf("_")+1,file.length)+";"
         		}
         		showText=showText.substring(0,showText.length-1);
         	}
//          	return '<span class="click-addFile" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><input style="display: none;"  name="purchaseOrderItemList[][fbk27]"  type="text" value="'+val+'"/>';
             return '<span class="click-addFile" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><input style="display: none;"  name="purchaseEnquiryMaterialVOs[][accessoryRequire_AddFile]"  type="text" value="'+item.fbk10+'"/>';
         }
//          {
//          	var showText='';
//          	if(!val){
//          		showText="添加";
//          		val = "";
//          	}else{
//          		var fileArray = val.split(";");
//          		for(var i in fileArray){
//          			var file = fileArray[i];
//          			showText += file.substring(file.indexOf("_")+1,file.length)+";"
//          		}
//          		showText=showText.substring(0,showText.length-1);
//          	}
//          	return '<span class="col-scan-file" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><input style="display: none;"  name="purchaseEnquiryMaterialVOs[][accessoryRequire_AddFile]"  type="text" value="'+val+'"/>';
//          }
     };
     $('.col-scan-file').live("click", function() {
         var scanCol = $(this).next();
         var sanContentText = scanCol.text();
         var sanContent = sanContentText.split("@enquiry@"); 
         var rowIndex = $(this).closest("tr").index();
         $("#oldMaterialRowIndex").val(sanContent[1]);
         $("#materialRowIndex").val(rowIndex);
         $("#materialLineJson-File").val(sanContent[0]);
         $("#addFileDialog").show();
         $('body').data("selectedFile",false);
         initFileUploader(fileUploader);
     });
   //单击添加表单文件事件
     $('#addFileBtn').click(function() {
     	clearAddFileInfo();
     	$('body').data("selectedFile",false);
     	$("#addFileDialog").show();
     	initFileUploader(fileUploader);
     });
     //添加文件窗口确认按钮
     $("#addFileBtnOK").click(function(){
    	 var flag = $('body').data("selectedFile");
    	 if(!flag){
    		 alert("请选择文件！",2);
    		 return;
    	 }
    	$('body').data("selectedFile",false);
     	$("#addFileDialog").hide();
     	var filePath = $("#filePath").val();
     	if(!editFileTable) {
    		editFileTable=$('#add-file-project').mmGrid({
    	        cols: colsfile,
				autoLoad:false,
    	        url: "",
    	        method: 'get',
    	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
    	        multiSelect: false,
    	        checkCol: true,
    	        indexCol:false
    	    }); 
    		editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
    			var seled=editFileTable.selectedRows();
    			if(seled && seled.length) {
    				var filePath = item.filePath;
        			//增加文件选择控制
        			if(filePath && filePath.length) {
//         				previewFile(filePath);
        			} else {
        				alert('<i18n:I18n key="i18n_enquiry_alert_notfoundfilepath" defaultValue="服务器异常，找不到文件上传的路径" />',3);
        			}
    			}
    		});
    	}
     	enquiryFileAddInfo();
     	clearAddFileInfo();
     	//预览文件内容
     });
     //TODO: 增加文件到表单文件table
     function enquiryFileAddInfo(){
    		var fileName = $("#fileName").val();
    		var filePath = $("#filePath").val();
    		var fileType = "";
    		if(fileName != null && fileName != ""){
    			fileType = fileName.substring(fileName.lastIndexOf('.')+1);
    		}else{
    			return;
    		}
    		var materialLineJson = $("#materialLineJson-File").val();
    		var rowIndex = $("#materialRowIndex").val();
    		var purchaseApplyNumber ="";
			var purchaseApplyItemNumber = "";
			var purchaseMaterialNumber = "";
			var purchaseMaterialDesc = ""; 
			var materialIndex = "";
			var frmObj = $("#purchaseEnquiryForm").serializeJSON();
    		if(materialLineJson != null && materialLineJson != ""){//不为空说明是在物料行上选的添加
    			var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
    			
    			var currentLineObj = JSON.parse(materialLineJson);
    		    var materialFileJson = currentLineObj.materialFileJson || [];
    		    var singleFile = {};//定义一条文件数据的json格式
    		    singleFile["elsAccount"]=elsAccount;
    		    singleFile["purchaseApplyNumber"]=materialLineJsonObj.purchaseOrderNumber;
    		    singleFile["purchaseApplyItemNumber"]=materialLineJsonObj.orderItemNumber;
    		    singleFile["purchaseMaterialNumber"]=materialLineJsonObj.materialNumber;
    		    singleFile["purchaseMaterialDesc"]=materialLineJsonObj.materialDesc;
    		    singleFile["fileName"]=fileName;
    		    singleFile["filePath"]=filePath;
    		    singleFile["fileType"]=fileType;
    		    singleFile["fileStatus"]=0;
    		    singleFile["materialIndex"]=rowIndex;
    		    materialIndex = rowIndex;
    		    materialFileJson.push(singleFile);
    		    currentLineObj['materialFileJson']= materialFileJson;
    		    currentLineObj["changeFlag"]=rowIndex;
    		    materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
    			editTable.updateRow(materialLineJsonObj,rowIndex);
    			
    			purchaseApplyNumber = materialLineJsonObj.purchaseOrderNumber;
    			purchaseApplyItemNumber = materialLineJsonObj.orderItemNumber;
    			purchaseMaterialNumber = materialLineJsonObj.materialNumber;
    			purchaseMaterialDesc = materialLineJsonObj.materialDesc;
    		}else{
    			var selected = $("#selectFileType").find("option:selected");
    	    	var selectFileTypeVal = selected.attr('store');
    	    	var selectFileTypeText = selected.text();
    	    	var index = $("#selectFileType").val();//对应的物料行索引
    	    	var row = editTable.row(index);
    			var valArray = selectFileTypeVal.split("@enquiry@");
				if(valArray.length > 3){//在文件列表tag页 选择了确定的物料文件类型添加
					purchaseApplyNumber = valArray[0];
					purchaseApplyItemNumber = valArray[1];
					purchaseMaterialNumber = valArray[2];
					purchaseMaterialDesc = valArray[3];
					var currentLineObj = row;
	    		    var materialFileJson = currentLineObj.materialFileJson || [];
					var singleFile = {};//定义一条文件数据的json格式
	    		    singleFile["elsAccount"]=elsAccount;
	    		    singleFile["purchaseApplyNumber"]=purchaseApplyNumber;
	    		    singleFile["purchaseApplyItemNumber"]=purchaseApplyItemNumber;
	    		    singleFile["purchaseMaterialNumber"]=purchaseMaterialNumber;
	    		    singleFile["purchaseMaterialDesc"]=purchaseMaterialDesc;
	    		    singleFile["fileName"]=fileName;
	    		    singleFile["filePath"]=filePath;
	    		    singleFile["fileType"]=fileType;
	    		    singleFile["fileStatus"]=0;
	    		    singleFile["materialIndex"]=index;
	    		    materialIndex = index;
	    		    materialFileJson.push(singleFile);
	    		    currentLineObj['materialFileJson']= materialFileJson;
	    		    currentLineObj["changeFlag"]=index;
	    			var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[index];
	    		    materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
	    			editTable.updateRow(materialLineJsonObj,index);
	    		    
				}else{ //添加公共文件类型
					var publicFileTableJson = $("#publicFileTableJson").val();
				    var tbleRows;
				    if(publicFileTableJson != ""){
				    	tbleRows = JSON.parse(publicFileTableJson);
				    }else{
				    	tbleRows = [];
				    }
	    	    	  var singleFile = {};//定义一条文件数据的json格式
		    		    singleFile["elsAccount"]=elsAccount;
		    		    singleFile["purchaseApplyNumber"]=purchaseApplyNumber;
		    		    singleFile["purchaseApplyItemNumber"]=purchaseApplyItemNumber;
		    		    singleFile["purchaseMaterialNumber"]=purchaseMaterialNumber;
		    		    singleFile["purchaseMaterialDesc"]=purchaseMaterialDesc;
		    		    singleFile["fileName"]=fileName;
		    		    singleFile["filePath"]=filePath;
		    		    singleFile["fileType"]=fileType;
		    		    singleFile["fileStatus"]=0;
		    		    singleFile["materialIndex"]="";
		    		    tbleRows.push(singleFile);
	    	    	  $("#publicFileTableJson").val(JSON.stringify(tbleRows));
				}
    		}
    		var item = {
    				fileName : fileName,
    				filePath : filePath,
    				fileType : fileType,
    				fileStatus : 0,
    				purchaseApplyNumber :purchaseApplyNumber,
    				purchaseApplyItemNumber : purchaseApplyItemNumber,
    				purchaseMaterialNumber : purchaseMaterialNumber,
    				purchaseMaterialDesc : purchaseMaterialDesc,
    				materialIndex:materialIndex
    		};
    		editFileTable.addRow(item);
    	    $("#materialLineJson-File").val("");
    	}
     
     function previewFile(filePath){
    	 $("#file-display").show();
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
     		parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "不支持在线预览的文档类型!"});
     	}
     }
     
     function initFileUploader(fileUploader){
    	    //新增表单文件
    	    if (!fileUploader) {
    	  	fileUploader = WebUploader.create({
    	  	    // swf文件路径
    	  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
    	  	    auto: true,
    	  	    // 文件接收服务端。
    	  	    server: '<%=basePath%>servlet/UploadServlet',
    	  	    // 选择文件的按钮。可选。
    	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    	  	    pick: '#btnFileUpload',
    	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
    	  	    resize: false,
    	  	    formData : {
    		     	elsAccount : elsAccount
    		     }
    	  	});
    	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
    	  		if(!response.error) {
    	  			var filePath = response.url;
    	    	  	   var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
    	    	       $("#filePath").val(filePath);
    	  		} else {
    	  			$('#ossfile').html("");
    	  			$("#fileName").val("");
        			$("#fileType").val("");
    	  			alert(response.message,3);
    	  		}
    	  		
    	  	   
    	  	});
    	    // 当有文件添加进来的时候
    		fileUploader.on("fileQueued",function(file){
    			var fileName = file.name;
    			$("#fileName").val(fileName);
    			$("#fileType").val(file.ext);
    			$('body').data("selectedFile",true);
    			
    			$('#ossfile').html('<div id="' + file.id + '">' + file.name + ' (' + file.size + ')<b></b>'
				+'<div class="progress"><div class="progress-bar" style="width: 0%;" aria-valuemin="0" aria-valuemax="100"></div></div>'
				+'</div>');
    		});
    	    
    	    //上传进度条
    		fileUploader.on("uploadProgress",function(file,percentage){
    			var d = document.getElementById(file.id);
    			var percent = percentage*100;
    			d.getElementsByTagName('b')[0].innerHTML = '<span>' + percent + "%</span>";
                var prog = d.getElementsByTagName('div')[0];
    			var progBar = prog.getElementsByTagName('div')[0];
    			progBar.style.width = percent+'%';
    			progBar.setAttribute('aria-valuenow', percent);
    		});
    		
    	    }
    	}
     //添加文件弹出框取消按钮
     $("#addFileBtnCancel").click(function(){
     	$("#addFileDialog").hide();
     	clearAddFileInfo();
     });
     //关闭按钮处理
     $("#dialogFileClose").click(function(){
     	$("#addFileDialog").hide();
     	clearAddFileInfo();
     });
     //clear
     function clearAddFileInfo(){
     	$("#fileName").val("");
     	$("#filePath").val("");
     	$("#materialLineJson-File").val("");
     	$('#ossfile').html("");
     }
     //删除选择文件行事件
     $("#deleteSelectBtn").click(function(){
         var selectedIndexes = editFileTable.selectedRowsIndex();
         var selectedRows = editFileTable.selectedRows();
         editFileTable.removeRow(selectedIndexes);
         if(selectedRows != "" && selectedRows != null){
        	 for(var i = 0 ; i < selectedRows.length ; i ++){
        		 var singleRow = selectedRows[i];
        		 var filePath = singleRow.filePath;
        		 var materialIndex = singleRow.materialIndex;
        		 if(materialIndex === null || materialIndex === ""){//为空说明移除公共文件
        			var publicFileTableJson = $("#publicFileTableJson").val();
 				    if(publicFileTableJson != ""){
 				    	var publicFileTableJsonObj = JSON.parse(publicFileTableJson);
 				    	for(var j = 0 ; j < publicFileTableJsonObj.length ; j ++){
 				    		var singleFileRow = publicFileTableJsonObj[j];
 				    		var _filePath = singleFileRow.filePath;
 				    		if(filePath == _filePath){
 				    			publicFileTableJsonObj.splice(j,1);
 				    		}
 				    	}
 				    	$("#publicFileTableJson").val(JSON.stringify(publicFileTableJsonObj));
 				    }
        		 }else{//删除指定的物料文件
        			 var row = editTable.row(materialIndex);
        	   		 var fileJson = row.materialFileJson;
        	   		 if(fileJson != "" && fileJson != null){
        	   			 for(var j = 0 ; j < fileJson.length ; j ++){
        	   				 var singleFileJson = fileJson[j];
        	   				 var _filePath = singleFileJson.filePath;
        	   				 if(filePath == _filePath){
        	   					fileJson.splice(j,1);
        	   				 }
        	   			 }
        	   			row["materialFileJson"]=fileJson;
        	   			var frmObj = $("#purchaseEnquiryForm").serializeJSON();
        	   			var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[materialIndex];
        	   			materialLineJsonObj = initUpdateObj(row,materialLineJsonObj);
            			editTable.updateRow(materialLineJsonObj,rowIndex);
        	   		 }
        		 }
        	 }
         }
         
         $("#file-display").hide();
     });
    //----------添加附件相关-----------end--------------------
    
    //保存询价单---saveEnquiry
    $("#saveEnquiry").click(function(){
    	var purchaseGroup = $("#purchaseGroup").val();
    	var purchaseOrganization = $("#purchaseOrganization").val();
    	if(purchaseGroup==null||purchaseGroup==''){
    		alert("采购组不能为空,不能执行操作!",2);
    		return;
    	}
    	if(purchaseOrganization==null||purchaseOrganization==''){
    		alert("采购组织不能为空,不能执行操作!",2);
    		return;
    	}
    	operationEnquiry(0,"是否确认保存？","保存中");
    });
    
   //TODO: 发布询价单**************************** 
    $("#publishEnquiry").click(function(){
    	var purchaseGroup = $("#purchaseGroup").val();
    	var purchaseOrganization = $("#purchaseOrganization").val();
    	if(purchaseGroup==null||purchaseGroup==''){
    		alert("采购组不能为空,不能执行操作!",2);
    		return;
    	}
    	if(purchaseOrganization==null||purchaseOrganization==''){
    		alert("采购组织不能为空,不能执行操作!",2);
    		return;
    	}
    	operationEnquiry(1,'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认发布？" />','<i18n:I18n key="i18n_enquiry_alert_publish" defaultValue="询价单发布中" />');
    });
    
    function operationEnquiry(operationType,message1,message2){
    	var orderType = $("#orderType").val();
    	var frm =$("#purchaseEnquiryForm");
    	var jsonObj = frm.serializeJSON();
        var orderSendStatus = jsonObj.orderSendStatus;
        if(orderSendStatus == 2){
        	alert("已发布询价单不能修改或再次发布！",2);
        	return;
        }
        jsonObj["fbk30"]=$("#isAlibabaPublish").val();
    	jsonObj["orderType"]=orderType;
    	jsonObj["maker"]=userName;
    	jsonObj["elsShortName"]=companyShortName;
    	jsonObj["elsSubAccount"]=elsSubAccount;
    	jsonObj["operationType"]=operationType;
    	var purchaseEnquiryItemVOs = jsonObj.purchaseEnquiryItemVOs;
    	if(purchaseEnquiryItemVOs){
    		jsonObj["supplierQuota"]="1";
    	}else{
    		jsonObj["supplierQuota"]="0";
    	}
    	//获取所添加询价单物料列表
    	var purchaseEnquiryMaterialVOs=[]; //用于存放询价单下所有物料信息
    	var purchaseEnquiryMaterialSetVOs=[]; //用于存放询价单下所有物料行的阶梯报价信息
    	var enquiryCostConstituteVOs=[]//用于存放询价单下所有物料行的报价成本组成信息
    	var purchaseCreateEnquiryFileVOs=[];//用于存放表单文件信息
    	
    	materialItmes = editTable.rows();
    	if(materialItmes == null || materialItmes ==""){
    		alert('<i18n:I18n key="i18n_enquiry_alert_leastonematerialdata" defaultValue="至少添加一条物料行信息!" />',2);
    		$('#add-enq-sheet').tabs({active:0});
    		return;
    	}
    	
    	for(var i=0; i< materialItmes.length;i++){
    		var materialItme = materialItmes[i];
    		var quoteMethod = materialItme.quoteMethod;
    		if (materialItmes[i].unitQuantity == null||materialItmes[i].unitQuantity == ''){
				alert("计量单位不能空!",2);
				return;
			}
    		if(parseInt(quoteMethod) == 1){
    			//设置阶梯报价信息到相应的json存放数组---------begin---------
    			//@author update/jiangzhidong @date 20160526  begin
        		var ladderPriceJsons = materialItme.ladderPriceJson;
        		if(ladderPriceJsons !=null && ladderPriceJsons != ""){ //判断该物料行是否设置了阶梯报价
        			for(var j = 0 ; j < ladderPriceJsons.length ; j++){
        				var singleJson = ladderPriceJsons[j];
        				singleJson["materialLineNumber"]=i+1;//设置物料行号
        				purchaseEnquiryMaterialSetVOs.push(JSON.stringify(singleJson));
        			}
        		}else{
        			alert('<i18n:I18n key="i18n_enquiry_alert_pleaseSetLadderPrice" defaultValue="请设置阶梯报价信息" />',2);
        			return;
        		}
        		//@author update/jiangzhidong @date 20160526  end
        		//设置阶梯报价信息到相应的json存放数组---------end---------
    		}
    		
    		//获取成本组成列表信息-----------------begin------------------
    		var costConstituteTemplateJsons = materialItme.costConstituteTemplateJson;
    		if(costConstituteTemplateJsons != null && costConstituteTemplateJsons != ""){
    			for(var j = 0 ; j < costConstituteTemplateJsons.length ; j ++){
    				var singleJson = costConstituteTemplateJsons[j];
    				singleJson["materialLineNumber"]=i+1;//设置物料行号，用于确定询价单下唯一物料行
    				enquiryCostConstituteVOs.push(JSON.stringify(singleJson));
    			}
    		}
    		//获取成本组成列表信息-----------------end------------------
    		//获取文件列表信息-----------------begin-------------------
    		var materialFileJson = materialItme.materialFileJson;
    		if(materialFileJson != null && materialFileJson != ""){
    			for(var j = 0 ; j < materialFileJson.length ; j ++){
    				var singleFileRow = materialFileJson[j];
    				singleFileRow["materialLineNumber"]=i+1;//设置物料行号，用于确定询价单下唯一物料行
    				purchaseCreateEnquiryFileVOs.push(singleFileRow);
    			}
    		}
    		//获取文件列表信息-----------------end-------------------
    		jsonObj["purchaseEnquiryMaterialVOs"][i]["materialLineNumber"]=i+1;
    		//设置工厂描述、物料组描述、采购组描述、库存地点描述
    		if (materialItmes[i].factoryDesc) {
    			jsonObj["purchaseEnquiryMaterialVOs"][i]["factoryDesc"]=materialItmes[i].factoryDesc;
    		}
    		if (materialItmes[i].materialGroupDesc) {
    			jsonObj["purchaseEnquiryMaterialVOs"][i]["materialGroupDesc"]=materialItmes[i].materialGroupDesc;
    		}
    		if (materialItmes[i].purchaseGroupDesc) {
    			jsonObj["purchaseEnquiryMaterialVOs"][i]["purchaseGroupDesc"]=materialItmes[i].purchaseGroupDesc;
    		}
    		if (materialItmes[i].stockPointDesc) {
    			jsonObj["purchaseEnquiryMaterialVOs"][i]["stockPointDesc"]=materialItmes[i].stockPointDesc;
    		}
    		// 附件名
    		if (materialItmes[i].accessoryRequire_AddFile) {
    			jsonObj["purchaseEnquiryMaterialVOs"][i]["fbk10"]=materialItmes[i].accessoryRequire_AddFile;
    		}
    		if (jsonObj["purchaseEnquiryMaterialVOs"][i].deliveryDate == null||jsonObj["purchaseEnquiryMaterialVOs"][i] == '' || jsonObj["purchaseEnquiryMaterialVOs"][i].quantity == null || jsonObj["purchaseEnquiryMaterialVOs"][i].quantity == '' ){
				alert("需求日期和需求数量不能为空!",2);
				return;
			}
    	}
    	//替代料 @author jianghzhidong @date 20160624 begin
		if(queryMaterialReplaceTable && queryMaterialReplaceTable.rowsLength()){
			var materialReplaceRows = queryMaterialReplaceTable.rows();
			jsonObj["materialReplaceVOs"]=materialReplaceRows;
		}
		//替代料 @author jianghzhidong @date 20160624 end
    	var ladderPriceJsonObj = eval('[' + purchaseEnquiryMaterialSetVOs + ']');
    	var costConstituteTemplateJsonObj = eval('[' + enquiryCostConstituteVOs + ']');
    	jsonObj['purchaseEnquiryMaterialSetVOs'] = ladderPriceJsonObj;
    	jsonObj['enquiryCostConstituteVOs'] = costConstituteTemplateJsonObj;
    	//获取所选供应商列表
    	var purchaseEnquirySupplieListVOs=[];
    	var itmes = editSupplieTable.rows();
    	if(itmes == null || itmes ==""){
    		alert('<i18n:I18n key="i18n_enquiry_alert_leastonesupplierdata" defaultValue="至少添加一个供应商！" />',2);
    		$( '#add-enq-sheet').tabs({active:2});
    		$(".add-supplier-sheet").click();
    		return;
    	}
    	for(var i=0; i< itmes.length;i++){
    		purchaseEnquirySupplieListVOs.push(JSON.stringify(itmes[i]));
    	}
    	
    	var suppliejsonobj = eval('[' + purchaseEnquirySupplieListVOs + ']');
    	jsonObj['purchaseEnquirySupplieListVOs'] = suppliejsonobj;
    	//获取公共文件列表
    	var publicFileTableJson = $("#publicFileTableJson").val();
    	if(publicFileTableJson != ""){
    		var publicFileTableJsonObj = JSON.parse(publicFileTableJson);
    		purchaseCreateEnquiryFileVOs = purchaseCreateEnquiryFileVOs.concat(publicFileTableJsonObj);
    	}
		    
    	jsonObj['purchaseCreateEnquiryFileVOs'] = purchaseCreateEnquiryFileVOs;
        parent.elsDeskTop.tip.init({type: 'confirm',message:message1,closeEvent:function(){
    	parent.elsDeskTop.showLoading(message2);
    	debugger;
    	 $.ajax({
			url :"<%=basePath%>rest/PurchaseEnquiryItemService/purchaseEnquiryAdd/"+elsAccount,
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(jsonObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				$("#purchaseEnquiryNumber").val(data.purchaseEnquiryNumber);
				$("#orderSendStatus").val(data.orderSendStatus);
				if(data.operationType == 0){
					alert('<i18n:I18n key="" defaultValue="保存成功！" />',1);
				}else{
					alert('<i18n:I18n key="i18n_common_alert_publishsuccessful" defaultValue="发布成功！" />',1);
					window.beforeClose = false;
					parent.elsDeskTop.closeCurWin('PurchaseEnquiryAdd',callBack);
				}
				
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错！" />',3);
			}
		});
    	
	}});
    }
    //回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
    function callBack(){
    	if(parent.frames[currId]) {
    		parent.frames[currId].purchQuery();
    	}
    
    }
   
    //询价单类型更改事件  ——默认为物料询价
    $("#orderType").change(function(){
		var selectOrderType = $("#orderType").val();
		if(selectOrderType == "1"){
			$(".isShowQuote").show();
			$(".ishowMaterial").show();
		}else{
			$(".isShowQuote").hide();
			$(".ishowMaterial").hide();
		}
		if(selectOrderType == "2"){
			$(".ishowTexture").show();
		}else{
			$(".ishowTexture").hide();
		}
		var colsfile0 = [
		                  { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>', name:'fileName' , width:80, align:'center'},
                          { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>', name:'filePath' , width:60, align:'center',hidden:true},
                          { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型"/>', name:'fileType' , width:60, align:'center',hidden:true},
                          { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态"/>', name:'fileStatus' ,width:100, align:'center', renderer: redererFileSendStatus},
                          { title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="请求单号"/>', name:'purchaseApplyNumber' ,width:140, align:'center'},
                          { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行项目号"/>', name:'purchaseApplyItemNumber' ,width:140, align:'center'},
                          { title:'<i18n:I18n key="i18n_common_title_materialnumber" defaultValue="物料编码"/>', name:'purchaseMaterialNumber' ,width:130, align:'center'},
                          { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述"/>', name:'purchaseMaterialDesc' ,width:120, align:'center'},
                          { title:'materialIndex', name:'materialIndex' ,width:60, align:'center',hidden:true}
		            ];
        var colsfile1 = [
		                
		                  { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>', name:'fileName' , width:80, align:'center'},
                          { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>', name:'filePath' , width:60, align:'center',hidden:true},
                          { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型"/>', name:'fileType' , width:60, align:'center',hidden:true},
                          { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态"/>', name:'fileStatus' ,width:100, align:'center', renderer: redererFileSendStatus},
                          { title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="请求单号"/>', name:'purchaseApplyNumber' ,width:140, align:'center'},
                          { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行项目号"/>', name:'purchaseApplyItemNumber' ,width:140, align:'center'},
		                  { title:'<i18n:I18n key="i18n_enquiry_title_texturenumber" defaultValue="材质编码"/>', name:'purchaseMaterialNumber' ,width:60, align:'center'},
		                  { title:'<i18n:I18n key="i18n_enquiry_title_texturedescribe" defaultValue="材质描述"/>', name:'purchaseMaterialDesc' ,width:120, align:'center'},
		                  { title:'materialIndex', name:'materialIndex' ,width:120, align:'center'}
		            ];
        var colsNew ;
        var colsFile
        //根据询价单的类型选择相应的初始表单title数据 
		if(selectOrderType == 0 ){//行情询价
			colsNew =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryItem_market_mt"/>;
			colsFile = colsfile0;
		}else if(selectOrderType == 1){
			colsNew = cols;
			colsFile = colsfile0;
		}else if(selectOrderType == 2){//材质询价
			colsNew =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryItem_texture_mt"/>;
			colsFile = colsfile1;
		}
        orderType = selectOrderType;
        //remove 之前初始化的表单数据
        $('#reCreate').html('<table id="add-enq-project"></table>');
	    $('#reCreateFile').html('<table id="add-file-project"></table>');
	    //再次初始化物料行table
		editTable=$('#add-enq-project').mmGrid({
	        cols: colsNew,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	        multiSelect: true,
	        checkCol: true,
	        fullWidthRows:true
	    });
		//再次初始化表单文件table
		editFileTable=$('#add-file-project').mmGrid({
	        cols: colsFile,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	        multiSelect: false,
	        checkCol: true,
	    });
		editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
			var seled=editFileTable.selectedRows();
			if(seled && seled.length) {
				var filePath = item.filePath;
    			//增加文件选择控制
    			if(filePath && filePath.length) {
//     				previewFile(filePath);
    			} else {
    				alert('<i18n:I18n key="i18n_enquiry_alert_notfoundfilepath" defaultValue="服务器异常，找不到文件上传的路径" />',3);
    			}
			}
		});
	});
    
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
    	var principal = $("#FBK4").val();
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
    	    var fbk4 = $("#FBK4").val();
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
    		$("#FBK4").val(principals);
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

//选择计量单位相关------------------begin--------------
//table中单击计价单位框
    $('#input-priceQuantity').live("click", function() {
		 var rowIndex = $(this).closest("tr").index();
		 var scanCol = $(this).next();
		 var sanContentText = scanCol.text();
		 var sanContent = sanContentText.split("@enquiry@");
	     $("#oldMaterialRowIndex").val(sanContent[1]);
		 $("#price_index").val(rowIndex);
	     $('body').data('currentLineObj',JSON.parse(sanContent[0]));
	     $("#selectUnitOfMeasurementDialog").show();
	 	if(selectUnitOfMeasurementTable == null || selectUnitOfMeasurementTable ==""){
	 		     //初始化table
	 		     selectUnitOfMeasurementTable=$('#unit-of-measurement-table').mmGrid({
	 		         	height: 180,
	 		         	width: 410,
	 		            cols: colsUnitOfMeasurement,
	 		            url: "<%=basePath%>rest/UnitOfMeasurementService/findSupplierContent/"+elsAccount,
	 		            params: {"unitName":""},
	 		            method: 'post',
	 		            root: 'rows',
	 		            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	 		            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	 		            indexCol:true
	 		         });
	 		     selectUnitOfMeasurementTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
	 		    	 $('body').data('unitRow',item);
	 		     });
	 	}
     });

//模糊查询键入事件
$("#unitName").keyup(function(){
	var unitName = $("#unitName").val();
	selectUnitOfMeasurementTable.load({"unitName":unitName});
});

//选择计量单位弹出框确认按钮单击事件
$("#btnUnitOfMeasurementOK").click(function(){
	var selectedRows = selectUnitOfMeasurementTable.selectedRows();
	if(selectedRows != "" && selectedRows != null ){
		var unitCode = selectedRows[0].unitCode;
		var busType = $("body").data("busType");
		if(busType){//判断是否批量设置弹出框
			$("#"+busType).val(unitCode);
			$("body").data("busType",null);
		}else{
			var price_index = $("#price_index").val();
			var name = $("#oldMaterialRowIndex").val();//列名
			var currentLineObj = $('body').data('currentLineObj');
			var frmObj = $("#purchaseEnquiryForm").serializeJSON();
			var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[price_index];
			materialLineJsonObj[name]=unitCode;
			materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
			editTable.updateRow(materialLineJsonObj,price_index);
		}
	}
	$("#selectUnitOfMeasurementDialog").hide();
});

//TODO:在update行的时候，把mmgrid上的数据；阶梯报价，所属附件，成本组成 初始化带到将被更新的物料行
function initUpdateObj(mmgridObj,frmObj){
	frmObj["ladderPriceJson"]=mmgridObj.ladderPriceJson;
	frmObj["materialFileJson"]=mmgridObj.materialFileJson;
	frmObj["costConstituteTemplateJson"]=mmgridObj.costConstituteTemplateJson;
	frmObj["changeFlag"]=mmgridObj.changeFlag;
	frmObj["isERP"]=mmgridObj.isERP;
	return frmObj;
}
//计量单位表单双击功能
	$('#unit-of-measurement-table').on('dblclick','tr',function() {
		var storeRow = $('body').data('unitRow');
		var busType = $("body").data("busType");
		if(busType){
			$("#"+busType).val(storeRow.unitCode);
			$("body").data("busType",null);
		}else{
			var price_index = $("#price_index").val();
			var name = $("#oldMaterialRowIndex").val();//列名
			var frmObj = $("#purchaseEnquiryForm").serializeJSON();
			var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[price_index];
			materialLineJsonObj[name]=storeRow.unitCode;
			var currentLineObj = $('body').data('currentLineObj');
			materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
			editTable.updateRow(materialLineJsonObj,price_index);
		}
		$("#selectUnitOfMeasurementDialog").hide();
	});
//关闭窗口
$("#btnSelectUnitOfMeasurementClose").click(function(){
	$("#selectUnitOfMeasurementDialog").hide();
	$("body").data("busType",null);
	$("#price_index").val("");
});
//关闭窗口
$("#btnUnitOfMeasurementCancel").click(function(){
	$("#selectUnitOfMeasurementDialog").hide();
	$("body").data("busType",null);
	$("#price_index").val("");
});
//选择计量单位相关------------------end--------------

//选择报价组成模板------------------begin---------------------------
//触发弹出选择报价组成模板窗口事件
$("#btnSelectCostConstituteTemplate").click(function(){
	$("#selectCostConstituteTemplateDialog").show();
	if(selectCostConstituteTemplateTable == null || selectCostConstituteTemplateTable ==""){
		var colsCostConstituteTemplate = [
		         	                { title:'elsAccount', name:'elsAccount' , width:100, align:'center',hidden:true},
		         	                { title:'orderType', name:'orderType' , width:100, align:'center',hidden:true},
		         	                { title:'<i18n:I18n key="i18n_coststructure_title_costtemplatenumber" defaultValue="成本模板号"/>', name:'costTemplateNumber' , width:100, align:'center'},
		         	                { title:'<i18n:I18n key="i18n_coststructure_title_costtemplatedesc" defaultValue="成本模板描述"/>', name:'costTemplateDesc' , width:100, align:'center'},
		         	                { title:'<i18n:I18n key="i18n_coststructure_title_costtemplatedetails" defaultValue="成本详细说明"/>', name:'costDetailDesc' , width:100, align:'center'}
		         	            ];
		     //初始化table
		     selectCostConstituteTemplateTable=$('#cost-constitute-template-table').mmGrid({
		         	height: 200,
		         	width: 500,
		            cols: colsCostConstituteTemplate,
		            url: "<%=basePath%>rest/CostConstituteTemplateService/findTemplates/"+elsAccount,
		            params: {"costTemplateNumber":""},
		            method: 'post',
		            root: 'rows',
		            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
		            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
		            indexCol:true,
		            fullWidthRows:true
		         });
		     selectCostConstituteTemplateTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
		    	 $('body').data('costConstituteTemplateRow',item);
		     });
	}else{
		selectCostConstituteTemplateTable.load({"costTemplateNumber":""});
	}
	
});
//模糊查询键入事件
$("#costTemplateNumber").keyup(function(){
	var costTemplateNumber = $("#costTemplateNumber").val();
	selectCostConstituteTemplateTable.load({"costTemplateNumber":costTemplateNumber});
});

function ajaxFindTempItem(costTemplateNumber){
	var materialNumber = $("#costConstitute_materialNumber").val();
	var materialDesc = $("#costConstitute_materialDesc").val();
	selectCostConstituteTemplateItemTable.load();
	$.ajax({
			url :"<%=basePath%>rest/CostConstituteTemplateService/findTemplateItems/"+elsAccount,
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"costTemplateNumber":costTemplateNumber,"pageSize":1000}),
			success : function(data) {
				var rows = data.rows;
				for(var i = 0 ; i < rows.length ; i ++){
					var costItemCode = rows[i].costItemCode;
					var costItemName = rows[i].costItemName;
					var item={
							"materialNumber":materialNumber,
							"materialDesc":materialDesc,
							"costItemCode":costItemCode,
							"costItemName":costItemName
					}
					selectCostConstituteTemplateItemTable.addRow(item);
				}
				
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
             alert(xhr.responseText, "Failed"); 
            }
		});
}

//报价组成模板表单双击功能
$('#cost-constitute-template-table').on('dblclick','tr',function() {
	var selectRow = $('body').data('costConstituteTemplateRow');
	var costTemplateNumber = selectRow.costTemplateNumber;
	ajaxFindTempItem(costTemplateNumber);
	$("#selectCostConstituteTemplateDialog").hide();
}); 

//选择计量单位弹出框确认按钮单击事件
$("#btnCostConstituteTemplateOK").click(function(){
	var selectedRows = selectCostConstituteTemplateTable.selectedRows();
	if(selectedRows != "" && selectedRows != null ){
		var costTemplateNumber = selectedRows[0].costTemplateNumber;
		ajaxFindTempItem(costTemplateNumber);
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_selectAtLeastOneRecord" defaultValue="至少选择一条记录！" />'});
		return ;
	}
	$("#selectCostConstituteTemplateDialog").hide();
});

//关闭窗口
$("#btnSelectCostConstituteTemplateDialogClose").click(function(){
	$("#selectCostConstituteTemplateDialog").hide();
});
//关闭窗口
$("#btnCostConstituteTemplateCancel").click(function(){
	$("#selectCostConstituteTemplateDialog").hide();
});
//移除成本组成列表项目行
$("#btnRemoveCostConstituteItem").click(function(){
	var selectedIndexes = selectCostConstituteTemplateItemTable.selectedRowsIndex();
    selectCostConstituteTemplateItemTable.removeRow(selectedIndexes);
    $("#checkboxCostConstitute").removeAttr('disabled');//设置勾选框为可编辑状态
});

//自定义添加项按钮单击事件 ---------------------begin---------------
$("#btnCustomAdd").click(function(){
	$("#customCostConstituteTemplateDialog").show();
	
});

//自定义添加窗口确认按钮单击事件
$("#btncustomCostConstituteTemplateOK").click(function(){
	var costItemCode = $("#costItemCode").val();
	var costItemName = $("#costItemName").val();
	var materialNumber = $("#costConstitute_materialNumber").val();
	var materialDesc = $("#costConstitute_materialDesc").val();
	if(costItemCode == null || costItemCode == ""){
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_coststructure_alert_costItemCodeNotNull" defaultValue="成本项目代码不能为空！" />'});
		$("#costItemCode").focus();
		return;
	}
	if(costItemName == null || costItemName == ""){
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_coststructure_alert_costItemNameNotNull" defaultValue="成本项目名称不能为空！" />'});
		$("#costItemName").focus();
		return;
	}
	var totalRows = selectCostConstituteTemplateItemTable.rows();
	if(totalRows != null && totalRows != ""){
		for(var i = 0 ; i < totalRows.length ; i ++){
			var singleRow = totalRows[i];
			var _costItemCode = singleRow.costItemCode;
			if(costItemCode == _costItemCode){//判断成本项目代码是否已经存在
				parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_coststructure_label_costitemcode" defaultValue="成本项目代码" /> '+costItemCode+'<i18n:I18n key="i18n_coststructure_alert_costItemCodeAlreadyExisting" defaultValue="已经存在！请重新输入" />'});
				$("#costItemCode").val("");
				$("#costItemCode").focus();
				return;
			}
		}
	}
	var item={
				"materialNumber":materialNumber,
				"materialDesc":materialDesc,
				"costItemCode":costItemCode,
				"costItemName":costItemName
		}
	selectCostConstituteTemplateItemTable.addRow(item);
	$("#checkboxCostConstitute").attr("checked", true);//默认设置成添加到自定义模板库
	$("#checkboxCostConstitute").removeAttr('disabled');//设置勾选框为可编辑状态
	$("#customCostConstituteTemplateDialog").hide();
	$("#costItemCode").val("");//清空输入框
	$("#costItemName").val("");//清空输入框
});
//关闭窗口
$("#btnCustomCostConstituteTemplateDialogClose").click(function(){
	$("#customCostConstituteTemplateDialog").hide();
});
//关闭窗口
$("#btncustomCostConstituteTemplateCancel").click(function(){
	$("#customCostConstituteTemplateDialog").hide();
});
//自定义添加项按钮单击事件 ---------------------end---------------

//触发弹出选择报价组成模板窗口事件
$('.col-CostConstitute').live("click", function() {
	$("#selectCostConstituteTemplateItemDialog").show();
	if(!selectCostConstituteTemplateItemTable){
		var colsCostConstituteTemplateItem = [
                                    { title:'<i18n:I18n key="i18n_common_title_materialnumber" defaultValue="物料编码"/>', name:'materialNumber' ,width:100, align:'center'},
                                    { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述"/>', name:'materialDesc' ,width:100, align:'center'},
		         	                { title:'<i18n:I18n key="i18n_coststructure_title_costitemcode" defaultValue="成本项目代码"/>', name:'costItemCode' , width:100, align:'center'},
		         	                { title:'<i18n:I18n key="i18n_coststructure_title_costitemname" defaultValue="成本项目名称"/>', name:'costItemName' , width:100, align:'center'},
		         	                { title:'materialLineNumber', name:'materialLineNumber' , width:100, align:'center' ,hidden:true}
		         	            ];
		     //初始化table
		     selectCostConstituteTemplateItemTable=$('#cost-constitute-template-item-table').mmGrid({
		         	height: 180,
		         	width: 600,
		         	items: [],
		            cols: colsCostConstituteTemplateItem,
		            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
		            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
		            indexCol:true,
		            fullWidthRows:true
		         });
	}
	var scanCol = $(this).next();
    var sanContentText = scanCol.text();
    var sanContent = sanContentText.split("@enquiry@"); 
    var rowIndex = $(this).closest("tr").index();
    $("#materialRowIndex").val(rowIndex);
    $("#oldMaterialRowIndex").val(sanContent[1]);
    $("#materialLineJson").val(sanContent[0]);
    var sanobj = eval('('+sanContent[0]+')');
    $('body').data('currentLineObj',sanobj);
    var frmObj = $("#purchaseEnquiryForm").serializeJSON();
	var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
    var materialNumber = materialLineJsonObj.materialNumber;
	var materialDesc = materialLineJsonObj.materialDesc;
	$("#costConstitute_materialNumber").val(materialNumber);
	$("#costConstitute_materialDesc").val(materialDesc);
	$("#titleCostConstituteTemplateItemDialog").text('<i18n:I18n key="i18n_enquiry_title_materialsinformation" defaultValue=" 物料信息" />： '+materialNumber+" "+materialDesc);
	
	var costConstituteTemplateJson = sanobj.costConstituteTemplateJson;
	selectCostConstituteTemplateItemTable.load();//清空列表
	if(costConstituteTemplateJson != null && costConstituteTemplateJson != null){ //判断是否是第一次点击改行的成本组成设置按钮 如为空则是第一次
		for(var i in costConstituteTemplateJson){
			costConstituteTemplateJson[i].materialNumber = materialNumber;
			costConstituteTemplateJson[i].materialDesc = materialDesc;
   	    }
		selectCostConstituteTemplateItemTable.load(costConstituteTemplateJson);//加载已有数据
	}
	$("#checkboxCostConstitute").attr("checked", false);//默认设置成不添加到自定义模板库
	$("#checkboxCostConstitute").attr('disabled',true);//设置勾选框为不可编辑状
});

//TODO: 设置报价成本组成窗口确认事件
$("#btnCostConstituteTemplateItemOK").click(function(){
	var rowIndex = $("#materialRowIndex").val();
    var currentLineObj = $('body').data('currentLineObj');
	var totalRows = selectCostConstituteTemplateItemTable.rows();
	var costConstituteTemplateJson=[];
	var frmObj = $("#purchaseEnquiryForm").serializeJSON();
	var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
	if(totalRows != "" && totalRows != null){
		for(var i = 0 ; i < totalRows.length ; i ++){
			var singleRow = totalRows[i];
			costConstituteTemplateJson.push(singleRow);
		}
		currentLineObj['costConstituteTemplateJson']= costConstituteTemplateJson;
		materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
		materialLineJsonObj["isSetCost"]="Y";
	    editTable.updateRow(materialLineJsonObj,rowIndex);
	}else{
		currentLineObj['costConstituteTemplateJson']= [];
		materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
		materialLineJsonObj["isSetCost"]="N";
	    editTable.updateRow(materialLineJsonObj,rowIndex);
	}
	var checked = $("#checkboxCostConstitute").is(':checked');
	if(checked&&costConstituteTemplateJson){//如果勾选保存到模板库 则调用后台服务保存表单数据到模板库
		$("#addcustomCostConstituteTemplateNameDialog").show();
		$('body').data('body-costConstituteTemplateJson',costConstituteTemplateJson);
	}else{
	    $("#selectCostConstituteTemplateItemDialog").hide();
	}
});
//设置模板名确认按钮
$("#btnaddcustomCostConstituteTemplateNameOK").click(function(){
	var costTemplateDesc = $.trim($("#costTemplateDesc").val());
	if(costTemplateDesc == null || costTemplateDesc == ""){
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n key="i18n_coststructure_alert_templateNameNotNull" defaultValue="模板名称不能为空！" /> '});
		$("#costTemplateDesc").focus();
		return;
	}
	var jsonObj = $('body').data('body-costConstituteTemplateJson');
	$.ajax({
			url :"<%=basePath%>rest/CostConstituteTemplateService/addCustomTemplate/"+elsAccount+"/"+costTemplateDesc,
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(jsonObj),
			success : function(data) {
				alert('<i18n:I18n key="i18n_coststructure_alert_saveTemplateLibrarySuccessful" defaultValue="保存到模板库成功！" /> ');
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
             alert(xhr.responseText, "Failed"); 
            }
		});
	$("#addcustomCostConstituteTemplateNameDialog").hide();
	$("#selectCostConstituteTemplateItemDialog").hide();
});

//关闭窗口 模板
$("#btnAddcustomCostConstituteTemplateNameClose").click(function(){
	$("#addcustomCostConstituteTemplateNameDialog").hide();
});
//关闭窗口 模板
$("#btnaddcustomCostConstituteTemplateNameCancel").click(function(){
	$("#addcustomCostConstituteTemplateNameDialog").hide();
});

//关闭窗口 报价组成
$("#btnSelectCostConstituteTemplateItemDialogClose").click(function(){
	$("#selectCostConstituteTemplateItemDialog").hide();
});
//关闭窗口 报价组成
$("#btnCostConstituteTemplateItemCancel").click(function(){
	$("#selectCostConstituteTemplateItemDialog").hide();
});
//-------------设置模板名---------------end-------------------------


	function materialLineAddEvent(enquiryApplyNumber,enquiryApplyItemNumber,materialNumber,materialDesc,rows){
		//设置表单文件tag页的文件类型下拉列表值
		var option = '<option value="'+rows+'" store="'+enquiryApplyNumber+"@enquiry@"+enquiryApplyItemNumber+"@enquiry@"+materialNumber+"@enquiry@"+materialDesc+'"  >'+materialNumber+" "+materialDesc+'</option>';
		$('#selectFileType').append(option);
	}
	
   //表单文件tag页 文件类型更改事件
   function selectFileTypeChange(){
   	 var selected = $("#selectFileType").find("option:selected");
   	 var selectFileTypeVal = selected.attr('store');
   	 var selectFileTypeText = selected.text();
   	 
   	 var index = $("#selectFileType").val();//对应的物料行索引
   	 var valArray = selectFileTypeVal.split("@enquiry@");
   	 var showTable = [];
   	 if(index != ""){//查看特定物料的文件列表
   		 var row = editTable.row(index);
   		 var fileJson = row.materialFileJson;
   		 if(fileJson != "" && fileJson != null){
   			 for(var i = 0 ; i < fileJson.length ; i ++){
   				 var singleFileJson = fileJson[i];
   				 singleFileJson["materialIndex"]=index;
   				showTable = showTable.concat(singleFileJson);
   			 }
   		 }
   	 }else if(selectFileTypeText == "公共文件" || selectFileTypeText == "Public File"){
   		 var publicFileTableJson = $("#publicFileTableJson").val();
   		 if(publicFileTableJson != ""){
   			showTable = JSON.parse(publicFileTableJson);
   		 }
   	 }else{//查看所有文件
   		showTable = loadAllFile(showTable);
   	 }
   	 editFileTable.load(showTable);
    }
   
   function loadAllFile(showTable){
	   var rows = editTable.rows();
 		 if(rows != "" && rows != null){
 			for(var i = 0 ; i < rows.length ; i ++){
    			 var singleRow = rows[i];
    			 var materialFileJson = singleRow.materialFileJson;
    			 if(materialFileJson != "" && materialFileJson != null){
    				for(var j = 0 ; j < materialFileJson.length ; j ++){
    					var singleFileJson = materialFileJson[j];
    					singleFileJson["materialIndex"]=i;
    					showTable = showTable.concat(singleFileJson);
    				}
    			 }
    		 }
 		 }
 		 var publicFileTableJson = $("#publicFileTableJson").val();
 		 if(publicFileTableJson != ""){
 			 publicFileTableJsonObj = JSON.parse(publicFileTableJson);
    		 showTable = showTable.concat(publicFileTableJsonObj);
 		 }
 		 return showTable;
   }
  
   //excel导入-------------begin-------------------
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
			    pick: '#excelImport',
			    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			    resize: false,
			    formData : {
    		     	elsAccount : elsAccount
    		     }
			});
			
			excelUploader.on( 'uploadAccept', function( obj, response ) {
			  	 var filePath = response.url;
			  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
			  	$.ajax({
					url :"<%=basePath%>rest/PurchaseEnquiryItemService/importExcelByPath",
					type :"POST",
					contentType : "application/json",
					dataType : "json",
					data:JSON.stringify({"filePath":filePath,"elsAccount":elsAccount}),
					success : function(data) {
						//var obj = JSON.parse(data);
						if(data.statusCode=="-100"){
							parent.elsDeskTop.hideLoading();
							parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_importFailure" defaultValue="导入失败！请检查文件内容！" />'});
						}else{
							parent.elsDeskTop.hideLoading();
							var materialRows = editTable.rows();
							if(materialRows != "" && data != null){
								for( var i = 0 ; i < materialRows.length ; i ++){
									for( var j = 0 ; j < data.length ; j ++){
										var materialRow = materialRows[i];
										var selectRow = data[j];
										var purchaseOrderNumber = materialRow.purchaseOrderNumber;
										var orderItemNumber = materialRow.orderItemNumber;
										var _purchaseOrderNumber = selectRow.purchaseOrderNumber;
										var _orderItemNumber = selectRow.orderItemNumber;
										if(purchaseOrderNumber == _purchaseOrderNumber && orderItemNumber == _orderItemNumber){
											data.splice(j,1);//去重
										}
									}
								}
							}
							debugger;
						    //var rows = [];
						    var purchaseGroup = $("#purchaseGroup").val();//获取订单头上填写的采购组
							for(var i = 0 ; i < data.length ; i++ ){ //设置初始值
								var selectRow = data[i];
								selectRow["priceMetricQuantity"]=1;
								selectRow["quoteMethod"]=0;
								selectRow["currency"]="CNY";
								selectRow["purchaseGroup"]=purchaseGroup;//获取订单头上填写的采购组
								selectRow["quoteMethod_select"]=[{name:'<i18n:I18n key="i18n_ladderprice_select_normalBidding" defaultValue="常规报价" />',value:0},{name:'<i18n:I18n key="i18n_ladderprice_select_ladderBidding" defaultValue="阶梯报价" />',value:1}];
								selectRow["accessoryRequire"]=0;
								selectRow["accessoryRequire_select"]=[{name:'<i18n:I18n key="i18n_common_select_accessoryrequire_choosable" defaultValue="附件可选" />',value:0},{name:'<i18n:I18n key="i18n_common_select_accessoryrequire_require" defaultValue="必须附件" />',value:1}];
								//设置询价单头 询价单描述字段
								var materialDescHead = $("#enquiryDesc").val();
								if(materialDescHead == null || materialDescHead == ""){
									$("#enquiryDesc").val(selectRow.materialNumber+" - "+selectRow.materialDesc);
								}
								//rows.push(selectRow);
								editTable.addRow(selectRow);
							}
							//设置询价单类型下拉框为不可用
							$("#orderType").attr("disabled",true);
							//$("#columnDefineBtn").attr("disabled",true);
							parent.elsDeskTop.tip.init({type : 'alert',displayType : 1,message : '<i18n:I18n key="i18n_common_alert_successfulImprot" defaultValue="导入成功！" />'});
						}
					},
					error: function (data) {//获取ajax的错误信息
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误！" />'});
		            }
				});
			});
		}
	}
   //excel导入-------------end-------------------
   //模板下载
   $("#downloadTemplate").click(function(){
		window.location.href = "<%=basePath%>"+"template/询价单请购单批导格式.xlsx";
	});
   
   $("#columnDefineBtn").click(function(){
		if(orderType == 0){
			columnDefine("purchaseEnquiryItem_market");//行情询价
		}else if(orderType == 1){
			columnDefine("purchaseEnquiryItem_material");//物料询价
		}else if(orderType == 2){
			columnDefine("purchaseEnquiryItem_texture");//材质询价
		}
	});
	  
	function columnDefine(tableCode){
		  parent.elsDeskTop.defineWin({
			     'iconSrc':'icon/els-icon.png',
			     'windowsId':'subAccountColumnSetting',
			     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
			     windowSubTitle: "",
			     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=" + tableCode + "&window=iframeApp_PurchaseEnquiryAdd"+elsAccount,
			     windowMinWidth: 480,
			     windowMinHeight: 600,
			     'windowWidth':480,
			     'windowHeight':600,
			     'parentPanel':".currDesktop"
			  });
	  }

//----------加载供应商配额信息------begin------------
var supplieQuotaClos = [
	                       { title:'<i18n:I18n key="" defaultValue="行号" />', name:'materialLineNumber' ,width:100, align:'center',renderer:function(val){
		           				return val+"<input name='purchaseEnquiryItemVOs[][materialLineNumber]' style='display:none;'  type='text' value='"+val+"'/>";
	           			     }},
	           			    { title:'<i18n:I18n key="" defaultValue="物料编号" />', name:'materialNumber' ,width:100, align:'center',renderer:function(val){
		           				return val+"<input name='purchaseEnquiryItemVOs[][materialNumber]' style='display:none;'  type='text' value='"+val+"'/>";
	           			     }},
	        			    { title:'<i18n:I18n key="" defaultValue="物料描述" />', name:'materialDesc' ,width:150, align:'center',renderer:function(val){
		           				return val+"<input name='purchaseEnquiryItemVOs[][materialDesc]' style='display:none;'  type='text' value='"+val+"'/>";
	           			     }},
	                           { title:'<i18n:I18n key="" defaultValue="需求数量" />', name:'FBK3' ,width:100, align:'center',renderer:function(val){
	               				return val+"<input name='purchaseEnquiryItemVOs[][FBK3]' style='display:none;'  type='text' value='"+val+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="单位" />', name:'unitQuantity' ,width:100, align:'center',renderer:function(val){
	               				return val+"<input name='purchaseEnquiryItemVOs[][unitQuantity]' style='display:none;'  type='text' value='"+val+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="供应商ELS" />', name:'toElsAccount' ,width:100, align:'center',renderer:function(val){
	               				return val+"<input name='purchaseEnquiryItemVOs[][toElsAccount]' style='display:none;'  type='text' value='"+val+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="供应商名称" />', name:'FBK4' ,width:100, align:'center',renderer:function(val){
	               				return val+"<input name='purchaseEnquiryItemVOs[][FBK4]' style='display:none;'  type='text' value='"+val+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="配额权数" />', name:'FBK1' ,width:100, align:'center',renderer:function(val,item,index){
	               				return "<input name='purchaseEnquiryItemVOs[][FBK1]' onkeyup='value=value.replace(/[^(\\d\\.)]/g,\"\")'  class='onkeyup-compute'  type='text' value='"+val+"'/>"+
	               				'<span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="比率(%)" />', name:'FBK2' ,width:100, align:'center',renderer:function(val,item,index){
	               				return "<input name='purchaseEnquiryItemVOs[][FBK2]' readonly  type='text' value='"+val+"' id='FBK2_"+index+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="分配需求量" />', name:'quantity' ,width:100, align:'center',renderer:function(val,item,index){
	               				return "<input name='purchaseEnquiryItemVOs[][quantity]' readonly  type='text' value='"+val+"' id='FBK3_"+index+"'/>";
	               			}}
	                    ];
	                    
function initSupplieQuota(){
	var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
	var materialItmes = jsonObj.purchaseEnquiryMaterialVOs;
	var supplieItmes = editSupplieTable.rows();
	var orderType = $("#orderType").val();
	if(orderType == "0" || orderType == "2"){
		alert("行情/材质询价不能配置供应商配额",2);
		return;
	}
	if(materialItmes == null){
		supplieQuotaTable.removeRow();
		alert("请先添加物料行信息！",2);
		return;
	}
	if(supplieItmes == ""){
		supplieQuotaTable.removeRow();
		alert("请先添加供应商信息！",2);
		return;
	}
	supplieQuotaTable.removeRow();
	//显示供应商配额tag页
	$(".supplier-isShow").show();
	supplieQuotaTable.removeRow();
	//生产供应商配额数据信息
	for(var i = 0 ; i < materialItmes.length ; i++){
		for(var j = 0 ; j < supplieItmes.length ; j ++){
			var materialItme = materialItmes[i];
			var supplieItme = supplieItmes[j];
			var toElsAccount = supplieItme.toElsAccount;
			var toElsDesc = supplieItme.toElsDesc;
			var materialNumber = materialItme.materialNumber;
			var startEffectiveDate = materialItme.deliveryDate;
			var quantity = materialItme.quantity;
			materialItme["materialLineNumber"]=i+1;
			materialItme["toElsAccount"]=toElsAccount;
			materialItme["FBK4"]=toElsDesc;
			materialItme["FBK3"]=quantity;
			var param = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"materialNumber":materialNumber,"startEffectiveDate":startEffectiveDate,"dataJson":JSON.stringify(materialItme)};
			$.ajax({
    			url :"<%=basePath%>rest/MaterialSourceListManageService/querySingleMaterialSource",
    			type :"POST",
    			contentType : "application/json",
    			dataType : "json",
    			data:JSON.stringify(param),
    			success : function(data) {
    				if(data.statusCode != "-100"){
    					var dataJson = data.dataJson;
    					var materialItme = JSON.parse(dataJson);
    					var quantity = materialItme.FBK3;
    					var quota = data.quota;
    					if(quantity == ""){
    						if(quota){
    							materialItme["FBK1"]=quota;
        						materialItme["FBK2"]=quota;
    						}else{
    							materialItme["FBK1"]="";
        						materialItme["FBK2"]=100;
    						}
    						materialItme["quantity"]=quantity;
    					}else{
    						if(quota){
    							materialItme["FBK1"]=quota;
        						materialItme["FBK2"]=quota;
        						var result = quantity*parseInt(quota)/100;
        						materialItme["quantity"]=Math.round(result);
    						}else{
    							materialItme["FBK1"]="";
        						materialItme["FBK2"]=100;
        						materialItme["quantity"]=quantity;
    						}
    					}
    					var quotaRows = supplieQuotaTable.rows();
    					if(quotaRows != ""){
    						var flag = false;
    						for(var i = 0 ; i < quotaRows.length ; i ++){
        						var materialLineNumber = quotaRows[i].materialLineNumber;
        						var toElsAccount = quotaRows[i].toElsAccount;
        						var _materialLineNumber = materialItme.materialLineNumber;
        						var _toElsAccount = materialItme.toElsAccount;
        						if(materialLineNumber == _materialLineNumber && toElsAccount == _toElsAccount){
        							flag = true;
        							break;
        						}
        					}
    						if(!flag){
    							supplieQuotaTable.addRow(materialItme);
    						}
    					}else{
    						supplieQuotaTable.addRow(materialItme);
    					}
    				}
    			}
    		});
			
		}
	}
	alert("操作成功！",1);
	$('#add-enq-sheet').tabs({active:3});
}
$(".onkeyup-compute").live('keyup',function(){
	var scanCol = $(this).next();
	var sanContentText = scanCol.text();
	var sanContent = sanContentText.split("@enquiry@");
	var index = sanContent[1];
	var lineObj = JSON.parse(sanContent[0]);
	var quantity = lineObj.quantity;
	var quota = $(this).val();
	if(quota > 100){
		$(this).val(quota.substring(0,2));
		return;
	}
	if(quota == 0 && quota.length > 1){
		$(this).val(0);
		return;
	}
	if(quota < 10 && quota.length > 1){
		$(this).val(quota.substring(1,2));
		return;
	}
	if(quota == 0 || quota == ""){
		$("#FBK2_"+index).val(100);
		$("#FBK3_"+index).val(quantity);
	}else{
		$("#FBK2_"+index).val(quota);
		var result = quantity*quota/100;
		$("#FBK3_"+index).val(Math.round(result));
	}
});

//----------加载供应商配额信息----end------------------------

//-------------批量设置-----begin-------
function clearBatchSet(){
	$("#batchSet_quoteMethod").val("0");
	$("#batchSet_priceQuantity").val("");
	$("#batchSet_unitQuantity").val("");
	$("#batchSet_deliveryDate").val("");
}
//单击批量设置按钮事件
$("#batchSetBtn").click(function(){
	var selectRow = editTable.selectedRows();
	if(selectRow.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	clearBatchSet();
	$("#setLadder").attr("disabled", true);
	var orderType = $("#orderType").val();
	if(orderType == "0"){
		$(".deliveryDate-show").hide();
	}else{
		$(".deliveryDate-show").show();
	}
	$("#batchSetDialog").show();
});

$("#batchSet_quoteMethod").change(function(){
	var val =$("#batchSet_quoteMethod").val();
	if(val == "1"){
		$("#setLadder").attr("disabled", false);
	}else{
		$("#setLadder").attr("disabled", true);
	}
});

$("#batchSetOK").click(function(){
	var obj = $("#batchSetForm").serializeJSON();
	var quoteMethod = obj.quoteMethod;
	var priceQuantity = obj.priceQuantity;
	var unitQuantity = obj.unitQuantity;
	var deliveryDate = obj.deliveryDate;
	var quantity = obj.quantity;
	var indexs = editTable.selectedRowsIndex();//获取所选择的行
	var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
	var materialItmes = jsonObj.purchaseEnquiryMaterialVOs;//获得所以物料行信息--form
	for(var i = 0 ; i < indexs.length ; i ++){
		var index = indexs[i];
		var mmgridItem = editTable.row(index);
		var formItem = materialItmes[index];
		formItem["quoteMethod"]=quoteMethod;
		if(priceQuantity != ""){
			formItem["priceQuantity"]=priceQuantity;
		}
		if(unitQuantity != ""){
			formItem["unitQuantity"]=unitQuantity;
		}
		if(deliveryDate != ""){
			formItem["deliveryDate"]=deliveryDate;
		}
		if(deliveryDate != ""){
			formItem["quantity"]=quantity;
		}
		if(quoteMethod == "1"){//阶梯报价
			//@author update/jiangzhidong @date 20160526  begin
			var ladderPriceJson = [];
			var length = $("body").data("ladderPriceItmes").length;
			var ladderPriceItmes = $.extend(true,{},$("body").data("ladderPriceItmes"));
		    for(var j = 0 ; j < length ; j ++){
		    	var item = ladderPriceItmes[j];
		    	item["materialNumber"]=formItem.materialNumber;
		    	item["materialDesc"]=formItem.materialDesc;
		    	ladderPriceJson.push(item);
		    }
		    mmgridItem["ladderPriceJson"]=ladderPriceJson;
		    //@author update/jiangzhidong @date 20160526  end
		}
		formItem = initUpdateObj(mmgridItem,formItem);
		editTable.updateRow(formItem,index);
	}
	$("#batchSetDialog").hide();
});

//单击设置阶梯报价事件
$("#setLadder").click(function(){
	$("body").data("setLadder",true);
	var ladderPriceItmes = $("body").data("ladderPriceItmes");
	if(ladderPriceItmes != null && ladderPriceItmes != ""){
   	    var priceObj = ladderPriceItmes[ladderPriceItmes.length-1];
   	    var endNumber = priceObj.endQuantity;
   	    $("#beginNumber").val(endNumber+1);
   	    addLadderPriceTable.load(ladderPriceItmes);
    }
	$("#setLadderPriceDialog").show();
  	if(!addLadderPriceTable){
  		 addLadderPriceTable = $('#add-ladder-price-table').mmGrid({
   	       	   height:180,
   	           cols: colsLadderPrice,
   	           loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
   	           noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
   	           multiSelect: true,
   	           checkCol: true,
   	           indexCol:true
   	       });
  	    }
});

//查找计价单位
$("#queryPriceQuantity").click(function(){
	$("body").data("busType","batchSet_priceQuantity");
	openUnitOfMeasurementDialog();
});

//查找计量单位
$("#queryUnitQuantity").click(function(){
	$("body").data("busType","batchSet_unitQuantity");
	openUnitOfMeasurementDialog();
});

function openUnitOfMeasurementDialog(){
	$("#selectUnitOfMeasurementDialog").show();
 	if(!selectUnitOfMeasurementTable){
 		     selectUnitOfMeasurementTable=$('#unit-of-measurement-table').mmGrid({
 		         	height: 180,
 		         	width: 410,
 		            cols: colsUnitOfMeasurement,
 		            url: "<%=basePath%>rest/UnitOfMeasurementService/findSupplierContent/"+elsAccount,
 		            params: {"unitName":""},
 		            method: 'post',
 		            root: 'rows',
 		            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
 		            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
 		            indexCol:true
 		         });
 		     selectUnitOfMeasurementTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
 		    	 $('body').data('unitRow',item);
 		     });
 	}
}

//关闭窗口
$("#batchSetClose").click(function(){
	$("#batchSetDialog").hide();
});
//关闭窗口
$("#batchSetCancel").click(function(){
	$("#batchSetDialog").hide();
});
//-------------批量设置-----------------

//----------加载物料行历史报价供应商相关-----begin------------
$("#loadHisSupplier").click(function(){
	initSupplieTable();
});
//----------加载物料行历史报价供应商相关-----end------------

//----------加载供应商配额信息相关-----begin------------
	$("#loadSupplierQuota").click(function () {
		var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
		var purchaseEnquiryItemVOs = jsonObj.purchaseEnquiryItemVOs;
		if (purchaseEnquiryItemVOs) {
			parent.elsDeskTop.tip.init({
				type: 'confirm', message: "已存在供应商配额数据，继续将重新生成，是否继续？", closeEvent: function () {
					initSupplieQuota();
				}
			});
		} else {
			initSupplieQuota();
		}
	});
//----------加载供应商配额信息相关-----end------------

//----------选择材质询价信息相关-----begin-----------
var colsQueryTexture = [
		         	    { title:'<i18n:I18n key="" defaultValue="材质编码"/>', name:'materialNumber' , width:140, align:'center'},
		         	    { title:'<i18n:I18n key="" defaultValue="材质描述"/>', name:'materialDesc' , width:180, align:'center'},
		         	    { title:'<i18n:I18n key="" defaultValue="物料组"/>', name:'materialGroup' , width:140, align:'center'}
		         	     ];

$("#btnQueryTexture").click(function () {
	$("#selectTextureDialog").show();
	var paramObj = $("#selectTextureForm").serializeJSON();
	paramObj["elsAccount"]=elsAccount;
	
	if(!queryTextureTable){
		queryTextureTable = $('#query-texture-table').mmGrid({
			url:"<%=basePath%>rest/MaterialService/queryMaterialList",
		    params:paramObj,
		    method: 'post',
		    root: 'rows',
   	       	height:300,
   	        cols: colsQueryTexture,
   	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
   	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
   	        multiSelect: true,
   	        checkCol: true,
   	        indexCol:true,
   	        plugins: [
   	            $('#query-texture-page').mmPaginator({
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
$("#btnQueryTextureCancel").click(function(){
	$("#selectTextureDialog").hide();
});
//关闭窗口
$("#btnSelectTextureDialogClose").click(function(){
	$("#selectTextureDialog").hide();
});

//查询
$("#queryTexture").click(function(){
	var paramObj = $("#selectTextureForm").serializeJSON();
	paramObj["elsAccount"]=elsAccount;
    $.extend(queryTextureTable.opts.params,paramObj);
    queryTextureTable.load();
});

//确认
$("#btnQueryTextureOK").click(function(){
	$("#selectTextureDialog").hide();
	var selectRows = queryTextureTable.selectedRows();
	var purchaseGroup = $("#purchaseGroup").val();
	for(var i = 0 ; i < selectRows.length ; i ++){
		var row = selectRows[i];
		var item = {};
		item['materialNumber']=row.materialNumber;
		item['materialDesc']=row.materialDesc;
		item['materialGroup']=row.materialGroup;
		item['requestDate']=new Date().format('yyyy-MM-dd');
		item['currency']="CNY";
		item['purchaseGroup']=purchaseGroup;
		editTable.addRow(item);
		//设置询价单头 询价单描述字段
		var materialDescHead = $("#enquiryDesc").val();
		if(materialDescHead == null || materialDescHead == ""){
			$("#enquiryDesc").val(row.materialNumber+" - "+row.materialDesc);
		}
	}
});

//----------选择材质询价信息相关-----end------------

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

//----------替代料信息相关@author jiangzhidong @date 20160622-----begin-----------
//替代物料编码
var initReplaceMaterialNumber = function(val,item,index) {
	var val='';
	if(item.replace!=null){
		if (!item.replace.materialNumber) {val = "";}
		else val=item.replace.materialNumber;
	}
	return val;
};
//替代物料名称
var initReplaceMaterialDesc = function(val,item,index) {
	var val='';
	if(item.replace!=null){
		if (!item.replace.materialDesc) {val = "";}
		else val=item.replace.materialDesc;
	}
	return val;
};

var colsQueryMaterialReplace = [{ title:'<i18n:I18n key="" defaultValue="供应商ELS号"/>', name:'toElsAccount' , width:80, align:'center'},
                                { title:'<i18n:I18n key="" defaultValue="供应商名称"/>', name:'toElsDesc' , width:140, align:'center'},
                                { title:'<i18n:I18n key="" defaultValue="物料编码"/>', name:'materialNumber' , width:140, align:'center'},
		         	    		{ title:'<i18n:I18n key="" defaultValue="物料描述"/>', name:'materialDesc' , width:200, align:'center'},
		         	    		{ title:'<i18n:I18n key="" defaultValue="替代物料编码"/>', name:'replaceMaterialNumber' , width:140, align:'center',renderer:initReplaceMaterialNumber},
		         	    		{ title:'<i18n:I18n key="" defaultValue="替代物料描述"/>', name:'replaceMaterialDesc' , width:200, align:'center',renderer:initReplaceMaterialDesc}];

queryMaterialReplaceTable = $('#query-material-replace-table').mmGrid({
       height:350,
       cols: colsQueryMaterialReplace,
       loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
       noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
    });
    
$('.add-supplier-sheet').click(function() {
	var editTableRows = editTable.rows();
	debugger;
	//处理变更物料行,自动添加供应商  @author jiangzhidong @date 20160682  begin
	var materialNumbers='';
	if(editTable && editTable.rowsLength()){
		for(var i= 0; i<=editTableRows.length-1; i++) {
			editTableRows[i]["elsAccount"]=elsAccount;
			materialNumbers=materialNumbers+editTableRows[i].materialNumber;
		}
	}
	var obj = $('body').data('materialNumbers');
	if(materialNumbers!=obj){
		materialReplaceFirst = true;
		$('body').data('materialNumbers',materialNumbers);
	}
	//处理变更物料行,自动添加供应商  @author jiangzhidong @date 20160682 end
	if(editTable && editTable.rowsLength()){
		if(materialReplaceFirst){
			queryMaterialReplaceTable.data().mmGrid._hideMessage();
			queryMaterialReplaceTable.data().mmGrid._showLoading();
			$.ajax({
				url : '<%=basePath%>rest/MaterialReplaceService/queryMaterialReplaceListBatch' + "?t="+new Date().getTime(),
				type : 'POST',
				contentType : "application/json",
				data : JSON.stringify(editTableRows),
				dataType : "json",
				success : function(data) {
					debugger;
					if(data.rows.length>0){
						queryMaterialReplaceTable.load(data.rows);
						//加载供应商 begin
						var storeArr = data.rows;
						var editSupplieItem = [];
						if(editSupplieTable && editSupplieTable.rowsLength()) {
							editSupplieItem = editSupplieTable.rows();
					   	}
			        	for(var i=0;i<storeArr.length; i++) {
			        		var isExist = true;
			        		if(storeArr[i].toElsAccount!=''&&storeArr[i].toElsAccount!=null){
			        			for(var j=0;j<editSupplieItem.length; j++) {
			        				if(storeArr[i].toElsAccount==editSupplieItem[j].toElsAccount){
			        					var isExist = false;
			        				}
				                }
			        			if(isExist){
			        				var obj = {
		 			               		"toElsAccount":storeArr[i].toElsAccount,
		 			                	"toElsDesc":storeArr[i].toElsDesc
		 			                };
			        				editSupplieItem.push(obj);
		        				}
			        	 	}
			        	}
			        	editSupplieTable.load(editSupplieItem);
			        	materialReplaceFirst = false;
			        	//加载供应商 end
					}else{
						queryMaterialReplaceTable.load(data.rows);
					}
				},error : function(data) {
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				},complete : function(data) {
					queryMaterialReplaceTable.data().mmGrid._hideLoading();
				}
			});
		}
	} else {
		queryMaterialReplaceTable.load([]);
		editSupplieTable.load([]);
	}
});
//----------替代料信息相关@author jiangzhidong @date 20160622-----end------------

</script>
</body>
</html>