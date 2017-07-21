<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<style>
.red{color:red}
.bgred{background-color:gray !important}
</style>
<body>
	<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="companyShortName" value="<%=session.getAttribute("companyShortName")%>" /> 
		<input type="hidden" name="elsAccount" value="${elsAccount }" /> 
		<input type="hidden" name="elsSubAccount" value="${elsSubAccount }" />
		<input type="hidden" name="toElsAccount" value="<%= request.getParameter("toElsAccount") %>"/>
		<input type="hidden" name="requirementNumber" value="<%= request.getParameter("requirementNumber") %>"/>
		<input type="hidden" id="jsonStr" name="jsonStr" value="" />
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_saleRequirement_lable_demandForSingleHead" defaultValue="需求单头" /></span>
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
						<li><a href="#sheet-item-one"><i18n:I18n key="i18n_saleRequirement_title_demandASingleDetail" defaultValue="需求单明细" /></a></li>
					</ul>
					<div id="sheet-item-one">
					    <font color="gray"><i18n:I18n key="i18n_saleRequirement_lable_gray" defaultValue="灰色" /></font><i18n:I18n key="i18n_saleRequirement_lable_IdentificationOfTheMaterialDemandPlanHasFailed" defaultValue="标识的物料表示需求计划已失效" />
						<main id="item-container" class="grid-container">
						<div class="grid-100">
							<table id="table-item"></table>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</form>
   	</div>
<script type="text/javascript">
var toElsAccount = <%= request.getParameter("toElsAccount") %>;
var requirementNumber = <%= request.getParameter("requirementNumber") %>;
var initData;
var headGrid;
var itemGrid;
var jsonData = {};
var selector = '<base:subAccount elsAccount="${elsAccount}" type="select" role="sale"></base:subAccount>';
var dates;


/* var cols_head = [
                 {title : "需求单号",name : "requirementNumber",align : "center",width : 98,renderer : function(val) {
     				return val + "<input type='hidden' name='requirementNumber' value='"+val+"'/> ";
     			 }},
     			 {title : "计划期间从",name : "planDateStart",align : "center",width : 150,renderer : function(val) {
	               if (!val)
	            	   val = "";
	               else
	            	   val = new Date(val).format("yyyy-MM-dd");
	               return "<input class='Wdate' onfocus='WdatePicker()' name='planDateStart' value='" + val + "'/> ";
                 }},
     			 {title : "计划期间到",name : "planDateEnd",align : "center",width : 150,renderer : function(val) {
	               if (!val)
		             val = "";
	               else
		             val = new Date(val).format("yyyy-MM-dd");
	               return "<input class='Wdate' onfocus='WdatePicker()' name='planDateEnd' value='"+ val + "'/> ";
	             }},
     			 {title : "期间类型",name : "dateType",align : "center",width : 100,renderer : function(val) {
	               return "<span class='showText' style='display:none'>"+ val + "</span>" + "<select name='dateType' ><option value='D'>天</option><option value='W'>周</option><option value='M'>月</option></select> ";
                 }},
     			 {title : "采购计划员",name : "purchasePlaner",align : "center",width : 150,renderer : function(val) {
	               var t = $("<span class='showText' style='display:none'>"+ val + "</span><select name='purchasePlaner'></select>");
	               t.append($(selector).html());
	               return $("<p>").append(t).html();
                 }},
     			 {title : "采购方负责人",name : "purchaseInCharge",align : "center",width : 150,renderer : function(val) {
	               var t = $("<span class='showText' style='display:none'>"+ val + "</span><select name='purchaseInCharge'></select>");
	               t.append($(selector).html());
	               return $("<p>").append(t).html();
                 }},
     			 {title : "采购工厂",name : "puchaseFactory",align : "center",width : 150,renderer : function(val) {
     				 if(!val)
     					 val="";
	                 return "<input name='puchaseFactory' value='"+val+"'/> ";
                 }},
     			 {title : "发布时间",name : "publishDate",align : "center",width : 150,renderer : function(val) {
	               if (!val)
		            val = "";
	               else
		            val = new Date(val).format("yyyy-MM-dd");
	               return "<input class='Wdate' onfocus='WdatePicker()' name='publishDate' value='" + val + "'/> ";
                 }} ]; */
                 
var cols_head = [
                                    { title:'<i18n:I18n key="i18n_materialRelation_title_purchaseElsAccount" defaultValue="采购方ELS账号" />', name:'toElsAccount' , width:120, align:'center',renderer:function(val){
                         				return "<span>"+val+"</span><input name='toElsAccount' style='display:none;'  type='text' value='"+val+"' readOnly />";
                         			}},
                                    { title:'<i18n:I18n key="i18n_saleRequirement_table_demandOrderNumber" defaultValue="需求单号" />', name:'requirementNumber' , width:120, align:'center',renderer:function(val){
                         				return "<span>"+val+"</span><input name='requirementNumber' style='display:none;'  type='text' value='"+val+"' readOnly />";
                         			}},
                                    { title:'<i18n:I18n key="i18n_saleRequirement_table_purchasingPlanner" defaultValue="采购计划员" />', name:'purchasePlaner' , width:120, align:'center',renderer:function(val){
                         				return "<span>"+val+"</span><input name='purchasePlaner' style='display:none;'  type='text' value='"+val+"' readOnly />";
                         			}},
                                    { title:'<i18n:I18n key="i18n_common_title_responserofpurchase" defaultValue="采购方负责人" />', name:'purchaseInCharge' , width:120, align:'center',renderer:function(val){
                         				return "<span>"+val+"</span><input name='purchaseInCharge' style='display:none;'  type='text' value='"+val+"' readOnly />";
                         			}},
                         			{title : "<i18n:I18n key="i18n_common_title_responserofsupplier" defaultValue="销售方负责人" />",name : "saleInCharge",align : "center",width : 150,renderer : function(val) {
                     	               var t = $("<span class='showText' style='display:none'>"+ val + "</span><select name='saleInCharge' selectedValue='"+val+"'></select>");
                     	               t.append($(selector).html());
                     	               return $("<p>").append(t).html();
                                      }},
                                    { title:'<i18n:I18n key="i18n_saleRequirement_table_planningHorizonFrom" defaultValue="计划期间从" />', name:'planDateStart' , width:120, align:'center',renderer:function(val){
            	           				if(val){
            	           					return "<span>"+new Date(val).format("yyyy-MM-dd")+"</span><input name='planDateStart' style='display:none;'  type='text' value='"+val+"'/>";
            	           				}else{
            	           					return "";
            	           				}
                       			    }},
                                    { title:'<i18n:I18n key="i18n_saleRequirement_table_planningHorizonTo" defaultValue="计划期间到" />', name:'planDateEnd' , width:120, align:'center',renderer:function(val){
            	           				if(val){
            	           					return "<span>"+new Date(val).format("yyyy-MM-dd")+"</span><input name='planDateEnd' style='display:none;'  type='text' value='"+val+"'/>";
            	           				}else{
            	           					return "";
            	           				}
                       			    }},
                                    { title:'<i18n:I18n key="i18n_additionCost_purchaseFactory" defaultValue="采购工厂" />', name:'puchaseFactory' , width:120, align:'center',renderer:function(val){
                         				return "<span>"+val+"</span><input name='puchaseFactory' style='display:none;'  type='text' value='"+val+"' readOnly />";
                         			}},
                                    { title:'<i18n:I18n key="i18n_saleRequirement_table_salesFactory" defaultValue="销售工厂" />', name:'saleFactory' , width:120, align:'center',renderer:function(val){
                                    	if(!val){
                                    		val = "";
                                    	}
                         				return "<input name='saleFactory'   type='text' value='"+val+"'/>";
                         			}},
                                    { title:'<i18n:I18n key="i18n_saleRequirement_table_publishStatus" defaultValue="发布状态" />', name:'publishStatus' , width:120, align:'center',hidden:true,renderer:function(val){
                                    	if("0"==val){
                                    		return "<i18n:I18n key="i18n_saleRequirement_table_notReleased" defaultValue="未发布" />"+"</span><input name='publishStatus' style='display:none;'  type='text' value='"+val+"'/>";
                                    	} else if("1"==val){
                                    		return "<i18n:I18n key="i18n_saleRequirement_table_alreadyReleased" defaultValue="已发布" />"+"</span><input name='publishStatus' style='display:none;'  type='text' value='"+val+"'/>";
                                    	}else {
                                    		return "";
                                    	}
                       			    }},
                                    { title:'<i18n:I18n key="i18n_saleRequirement_table_releaseDate" defaultValue="发布日期" />', name:'publishDate' , width:120, align:'center',renderer:function(val){
            	           				if(val){
            	           					return "<span>"+new Date(val).format("yyyy-MM-dd")+"</span><input name='publishDate' style='display:none;'  type='text' value='"+val+"'/>";
            	           				}else{
            	           					return "";
            	           				}
                       			    }},
                                    { title:'<i18n:I18n key="i18n_saleRequirement_table_periodType" defaultValue="期间类型" />', name:'dateType' , width:120, align:'center',renderer:function(val){
                                    	if("D"==val){
                                    		return "<i18n:I18n key="i18n_schedule_selector_day" defaultValue="天" />"+"</span><input name='dateType' style='display:none;'  type='text' value='"+val+"'/>";
                                    	} else if("W"==val){
                                    		return "<i18n:I18n key="i18n_schedule_selector_week" defaultValue="周" />"+"</span><input name='dateType' style='display:none;'  type='text' value='"+val+"'/>";
                                    	} else if("M"==val){
                                    		return "<i18n:I18n key="i18n_schedule_selector_month" defaultValue="月" />"+"</span><input name='dateType' style='display:none;'  type='text' value='"+val+"'/>";
                                    	}else {
                                    		return "";
                                    	}
                       			    }}
                             ];
/* var cols_head = [{title:"需求单号",name:"requirementNumber",align:"center",width:98},
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
                 {title:"采购工厂",name:"purchaseFoctory",align:"center",width:150,renderer:function(){
                	 return "<input name='purchaseFoctory'/> ";
                 }},
                 {title:"发布时间",name:"publishDate",align:"center",width:150,renderer:function(){
                	 return "<input class='Wdate' onfocus='WdatePicker()' name='publishDate'/> ";
                 }}]; */
// var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="editSaleQuotationItem"/>;
var cols_item = [{title:"<i18n:I18n key="i18n_saleRequirement_lable_state" defaultValue="状态" />",name:"fbk1",align:"center",width:90,hidden:true,renderer:function(val){
	                if (!val) val="";
	                return "<input name='itemList[][fbk1]' value='"+val+"' readOnly='readOnly'/> ";
                }},{title:"<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />",name:"purchaseMaterialNumber",align:"center",width:150,renderer:function(val){
					if (!val) val="";
					return "<input name='itemList[][purchaseMaterialNumber]' value='"+val+"' readOnly/> ";
				}},{title:"<i18n:I18n key="i18n_common_label_materialdescribe" defaultValue="物料描述" />",name:"purchaseMaterialDesc",align:"center",width:150,renderer:function(val){
					if (!val) val=""; 
					return "<input name='itemList[][purchaseMaterialDesc]' value='"+val+"' readOnly/> ";
				}},{title:"<i18n:I18n key="i18n_delivery_lable_salematerialnumber" defaultValue="销售方物料编号" />",name:"saleMaterialNumber",align:"center",width:150,renderer:function(val){
					if (!val) val="";
					return "<input name='itemList[][saleMaterialNumber]' value='"+val+"' /> ";
				}},{title:"<i18n:I18n key="i18n_delivery_lable_salematerialdesc" defaultValue="销售方物料描述" />",name:"saleMaterialDesc",align:"center",width:150,renderer:function(val){
					if (!val) val=""; 
					return "<input name='itemList[][saleMaterialDesc]' value='"+val+"' /> ";
				}},{title:"<i18n:I18n key="i18n_purchase_factory" defaultValue="采购方工厂" />",name:"puchaseFactory",align:"center",width:150,renderer:function(val){
					if (!val) val="";
					 return "<input name='itemList[][puchaseFactory]' value='"+val+"' readOnly/> ";
				}},{title:"<i18n:I18n key="i18n_saleRequirement_lable_purchasingFactoryName" defaultValue="采购方工厂名称" />",name:"puchaseFactoryName",align:"center",width:150,renderer:function(val){
					if (!val) val=""; 
					return "<input name='itemList[][puchaseFactoryName]' value='"+val+"' readOnly/> ";
				}},{title:"<i18n:I18n key="i18n_sale_factory" defaultValue="销售方工厂" />",name:"saleFactory",align:"center",width:150,renderer:function(val){
					if (!val) val="";
					 return "<input name='itemList[][saleFactory]' value='"+val+"' /> ";
				}},{title:"<i18n:I18n key="i18n_saleRequirement_lable_sellersFactoryName" defaultValue="销售方工厂名称" />",name:"saleFactoryName",align:"center",width:150,renderer:function(val){
					if (!val) val=""; 
					return "<input name='itemList[][saleFactoryName]' value='"+val+"' /> ";
				}},{title:"<i18n:I18n key="i18n_delivery_lable_unit" defaultValue="单位" />",name:"unit",align:"center",width:100,renderer:function(val){
					if (!val) val=""; 
					return "<input name='itemList[][unit]' value='"+val+"' readOnly/> ";
				}},{title:"<i18n:I18n key="i18n_audit_title_type" defaultValue="类型" />",name:"requireType",align:"center",width:100,renderer:initType}
                 ];

$().ready(function(){
	init();
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin(window.frameElement.name.substring(10),closeCallback());
	});
	$("#saveBtn").click(function(){
		//拼装json
		var json = [];
		var itemNumber = 1;
		$("#table-item").find("tr").each(function(){
			$(this).find(".content").each(function(){
				json.push({"itemNumber":itemNumber,"requireType":$(this).attr("type"),"date":$(this).attr("date"),"value":$(this).attr("value")});
			});
			itemNumber++;
		});
		$("#jsonStr").val(JSON.stringify(json));
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			var frm = $("#form");
			var frmObj = frm.serializeJSON();
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/SaleRequirementService/reply",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frmObj),
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
});
function closeCallback() {
	if(parent.frames["iframeApp_saleRequirementManage"])
		parent.frames["iframeApp_saleRequirementManage"].queryRequirementsplanning();
}
function init(){
	$("#sheet-project").tabs();
	loadHeadData();
}
function initType(val,item,index,name) {
	return "<div style='border-bottom: solid 1px #ddd !important;'><i18n:I18n key="i18n_saleRequirement_lable_netDemandNumber" defaultValue="净需求数" /></div><div style='border-bottom: solid 1px #ddd !important;'><i18n:I18n key="i18n_saleRequirement_lable_NumberOfSellersReply" defaultValue="销售方回复数" /></div><div><i18n:I18n key="i18n_saleRequirement_lable_DifferencesInTheNumberOf" defaultValue="差异数" /></div>";
};
function initSelect(){
	$("#table-head").find("select").each(function(){
		var selectObj=$(this);
		var val=selectObj.attr("selectedValue");
		console.log(val);
		selectObj.val(val);	
	});
}
function loadHeadData(){
	var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"requirementNumber":requirementNumber};
 	headGrid = $('#table-head').mmGrid({
        cols: cols_head,
        url : "<%=basePath%>rest/SaleRequirementService/displayRequirement",
        params : data,
        method: "POST",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:100
    }); 
	headGrid.on('loadSuccess',function(e,data) {
		initSelect();
		//禁止编辑
        $("#table-head").find("input").each(function(){
        	$(this).attr("readOnly",false);
	    });
        $("#table-head").find("select").each(function(){
        	$(this).attr("readOnly",false);
	    });
        $("#table-head").find(".Wdate").each(function(){
        	$(this).removeAttr("onfocus");
	    });
        var jsonArray = eval(data.rows[0].jsonStr);
        for (var i=0;i<jsonArray.length;i++) {
        	var json = jsonArray[i];
        	if (json.value) {
	        	jsonData[json.itemNumber+"-" + json.requireType+"-"+json.date]=json.value;
        	} else {
        		jsonData[json.itemNumber+"-" + json.requireType+"-"+json.date]="";
        	}
        }
        console.log(jsonData);
        dates = data.rows[0].dates;
        var index = cols_item.length;
        for (var i=0;i<dates.length;i++) {
        	cols_item[index] = {title:dates[i],name:dates[i],align:"center",width:100,renderer:attrRenderer};
        	index++;
        }
        itemGrid  = $('#table-item').mmGrid({
            cols: cols_item,
    		items:data.rows[0].saleRequirementItemVOs
        });
        itemGrid.on('loadSuccess',function(e,data) {
        	$('#table-item').find("tr").each(function(){
        		var item = $(this).data("item");
        		if (item.fbk1 == "Y") {
        			$(this).find("div").addClass("bgred");
        			$(this).find("input").addClass("bgred").attr("readOnly","readOnly");
        		}
        	});
        });
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
/* function attrRenderer(val,item,index,name) {
	var val0 = jsonData[(index+1)+"-0-"+name];
	var val1 = jsonData[(index+1)+"-1-"+name];
	var val2 = jsonData[(index+1)+"-2-"+name];
	return "<div class='bottom_line'><input  id='"+index+"_0_"+name+"' class='content' style='height: 20px !important;border-bottom: solid 1px #ddd;' type='0' date='"+name+"' value='"+val0+"' readOnly/></div><div class='bottom_line'><input id='"+index+"_1_"+name+"' onkeyup='changeValue(this)' class='content' style='height: 20px !important;border-bottom: solid 1px #ddd;top:20px;' type='1' date='"+name+"' value='"+val1+"' /></div><div><input id='"+index+"_2_"+name+"' class='content' style='height: 20px !important;top:40px;' type='2' date='"+name+"' value='"+val2+"' readOnly='readOnly'/></div> ";
}

function changeValue(obj) {
	var id1 = $(obj).attr("id");
	var id0 = id1.split("_")[0]+"_0_"+id1.split("_")[2];
	var id2 = id1.split("_")[0]+"_2_"+id1.split("_")[2];
	var val1 = $(obj).val();
	if (isNaN(val1)) {
		alert("请输入数字",2);
		$(obj).val(0);
	}
	var val0 = $("#"+id0).val();
	if (val0&&val0 != "") {
		var val2 = parseFloat(val1) - parseFloat(val0);
		$("#"+id2).val(val2);
	}
} */
function attrRenderer(val,item,index,name) {
	var val0 = jsonData[(index+1)+"-0-"+name];
	var val1 = jsonData[(index+1)+"-1-"+name];
	var val2 = jsonData[(index+1)+"-2-"+name];
	var text = "<div class='bottom_line'><input  id='"+index+"_0_"+name+"' class='content' style='height: 20px !important;border-bottom: solid 1px #ddd;' type='0' date='"+name+"' value='"+val0+"' readOnly='readOnly'/></div><div class='bottom_line'><input id='"+index+"_1_"+name+"' class='content' onkeyup='changeValue(this)' style='height: 20px !important;border-bottom: solid 1px #ddd;top:20px;' type='1' date='"+name+"' value='"+val1+"' /></div>";
	if(val2 < 0 ){
		text += "<div><input id='"+index+"_2_"+name+"' class='content red' style='height: 20px !important;top:40px;' type='2' date='"+name+"' value='"+val2+"' readOnly='readOnly'/></div> ";
	}else{
		text += "<div><input id='"+index+"_2_"+name+"' class='content' style='height: 20px !important;top:40px;' type='2' date='"+name+"' value='"+val2+"' readOnly='readOnly'/></div> ";
	}
	return text;
}
function changeValue(obj) {
	var id1 = $(obj).attr("id");
	var date = id1.split("_")[2];
	var index = id1.split("_")[0];
	var id0 = index+"_0_"+date;
	var id2 = index+"_2_"+date;
	var val1 = $(obj).val();
	if (isNaN(val1)) {
		alert("<i18n:I18n key="i18n_alert_fillnumber" defaultValue="请输入数字" />",2);
		$(obj).val(0);
	}
	var val0 = $("#"+id0).val();
	if (val0&&val0 != "") {
		var val2 = parseFloat(val1) - parseFloat(val0);
		var dateIndex = 0;
		for(var i=0;i<dates.length;i++){
			if (date==dates[i]) {
				dateIndex = i;
			}
		}
		//如果不是第一项，要加上前一项的差异
		if (dateIndex != 0) {
			var pre = $("#"+index+"_2_"+dates[dateIndex-1]).val();
			console.log("pre:"+pre);
			if (pre&&pre!="") {
				console.log("val2:"+pre);
				val2 = val2 + parseFloat(pre);
			}
		}
		if (val2 < 0) {
			if (!$("#"+id2).hasClass("red")) {
				$("#"+id2).addClass("red")
			}
		} else {
			$("#"+id2).removeClass("red")
		}
		if(val2){
			$("#"+id2).val(val2);
		}else{
			$("#"+id2).val(0);
		}
		
		//如果不是最后一项，要更新后面的值
		if (dateIndex != dates.length-1) {
			changeValue($("#"+index+"_1_"+dates[dateIndex+1]));
		}
	}
}
</script>
</body>
</html>