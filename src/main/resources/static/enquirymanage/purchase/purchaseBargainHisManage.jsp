<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative public-wrap">
    
    	 <!-- 基本操作 -->
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
				<button id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<!-- <button class="button-wrap" id="synchBtn"><i18n:I18n key="test" defaultValue="同步ERP数据" /></button> -->
				<button id="enquirySeachBtn" class="button-wrap" ><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
				<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>
        
        <!-- 条件查询 -->
        <div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <input type="hidden" id="elsAccount" name="elsAccount"/>
            <input type="hidden" id="elsSubAccount" name="elsSubAccount"/>	
            <input type="hidden" id="pageSize" name="pageSize" value="20">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">		
			<div class="common-box-line">
			   <div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n key="test" defaultValue="历史价格类型" />：</span>
					<select class="" id="FBK4" name="FBK4">
						<option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
						<option value="0"><i18n:I18n key="test" defaultValue="本次报价记录" /></option>
						<option value="1"><i18n:I18n key="test" defaultValue="历史报价记录" /></option>
						<option value="2"><i18n:I18n key="test" defaultValue="历史采购记录" /></option>
					</select>
				</div>	
		        <div class="dis-in-b input-and-tip pos-relative">
			       <span><i18n:I18n key="i18n_enquiry_label_supplier" defaultValue="供应商" />：</span>
			       <input id="toElsAccount" name="toElsAccount" type="text" style="width:200px;padding-right:20px;" onkeyup="value=value.replace(/[^(\d,)]/g,'')"/>
		        </div>

				<div class="dis-in-b input-and-tip">
				    <span><i18n:I18n key="test" defaultValue="日期范围" />：</span>
				    <input type="text" class="Wdate" onfocus="WdatePicker({lang:'<%=session.getAttribute("language") %>'})" id="beginDate" name="beginDate"/>
				 </div>
                <div class="dis-in-b input-and-tip">
                    <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
                    <input type="text"  class="Wdate" onfocus="WdatePicker({lang:'<%=session.getAttribute("language") %>'})" id="endDate" name="endDate"/>
                </div>

			  </div>
			</div>
		</div>
       <!-- 物料 -->
       <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="物料信息" /></span>
            <div class="common-box-line">
               <main class="grid-container nest-table">
                    <div class="grid-100">
                        <table id="table-material-his"></table>
                    </div>
                    <div class="clear"></div>
                </main>
            </div>
        </div>
    
    	<!-- 最新报价 -->
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="最新报价" /></span>
            <div class="common-box-line">
               <main class="grid-container nest-table">
                    <div class="grid-100">
                        <table id="table-item-his"></table>
                    </div>
                    <div class="clear"></div>
                </main>
            </div>
        </div>
        
       <!-- 报价历史纪录 -->
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_purchase_bargain_itemHistory" defaultValue="报价历史纪录" /></span>
            <div class="common-box-line">
               <main class="grid-container nest-table">
                    <div class="grid-100">
                        <table id="table-erp-his"></table>
                        <div id="pg-price2" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
        
    </div>
    
<script>
var isloadItemGrid = false;
var materialGrid;
var itemGrid;
var erpGrid;
var obj;
var taxRate=[];

$().ready(function(){
	//初始化控件
	var obj = getIframeData();
    loadMaterial(obj);
    loadErp(obj);
});


//渲染   @author jiangzhidong 20160113  begin
//类型 
var rendererPurchaseType = function (val,item,index){
	if(val==0) return "标准";
	else if(val==1) return "限制";
	else if(val==2) return "寄售";
	else if(val==3) return "分包";
	else if(val==4) return "未知的商品";
	else if(val==5) return "第三方";
	else if(val==6) return "文本";
	else if(val==7) return "库存转储";
	else if(val==8) return "商品类目";
	else if(val==9) return "服务";
	else return "其他";
};
//只允许数字输入框
var initInputNumber = function (val,item,index){
	if(!val) { val = '';}
	return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
};
//允许任何字符输入框
var initInputAny = function (val,item,index){
	if(!val) { val = '';}
	return '<input type="text" name="'+this.name+'" value="'+val+'"/>';
};
//订单状态
var rendererOrderStatus = function (val,item,index){
	//0-新建1-报价中2-议价中(废弃)3-审批中4-重报价5-已定价6-已拒绝7-已结束8-已报价9-已选择(废弃)
	if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />'
	else if (val == "1") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed" defaultValue="报价中" />';
	else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
	else if (val == "4") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价" />';
	else if (val == "5") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价" />';
	else if (val == "6") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝" />';
	else if (val == "7") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束" />';
	else if (val == "8") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价" />';
};
//审批状态
var rendererAuditStatus = function (val,item,index){
	//审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
	if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
	else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
	else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
	else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';
};
//物料操作
var selColItem = function(val,item,index){
  if(!val) {
      return '<span class="col-price-his" style="color:blue;"><i18n:I18n key="i18n_purchase_bargain_history" defaultValue="历史" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
  } else {
      return '<span>'+ val +'</span>';
  }
};
//报价方式
var initQuoteMethod = function (val,item,index){
	if (val == "0") return '<i18n:I18n key="i18n_ladderprice_select_normalBidding" defaultValue="常规报价" />';
	else if (val == "1") return '<i18n:I18n key="i18n_ladderprice_select_ladderBidding" defaultValue="阶梯报价" />';
};
//日期
var formatDate = function (val,item,index){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	     return val;
};
//附件需求
var initAccessoryRequire = function (val){
	if (val == "0") return '<i18n:I18n key="i18n_common_select_accessoryrequire_choosable" defaultValue="附件可选" />';
	else if (val == "1") return '<i18n:I18n key="i18n_common_select_accessoryrequire_require" defaultValue="必须附件" />';
};
//价格有效期
var initOrderDate = function(val,item,index){
	var priceDate='';
	if (item.beginDate)
		priceDate=priceDate+'<i18n:I18n key="i18n_label_from" defaultValue="从" />:'+new Date(item.beginDate).format("yyyy-MM-dd")+'<br/>';
	if (item.endDate)
		priceDate=priceDate+'<i18n:I18n key="i18n_label_to" defaultValue="到" />:'+new Date(item.endDate).format("yyyy-MM-dd");
	return priceDate;
};
//数量
var initQuantity = function(val,item,index) {
	if(val==""||val==null){
		val = "";
	}
	//常规报价 
	if(item.quoteMethod==0)
		return '<div>' +val+ '</div>';
	//阶梯报价
	else if(item.quoteMethod==1){
		var contain='';
		if (item.ladderPricesHis) {
			for(var i=0; i<=item.ladderPricesHis.length-1;i++) {
				var bottom_line = i==item.ladderPricesHis.length-1? '': 'bottom_line';
	          contain +='<div class="'+bottom_line+'">' +item.ladderPricesHis[i].beginQuantity+'&nbsp;-&nbsp;'+item.ladderPricesHis[i].endQuantity+ '</div>';
			}
		}
      return contain;
	}
	return;
};
//含税单价
var initPriceIncludingVat = function(val,item,index) {
	if(val==""||val==null){
		val = "";
	}
	//常规报价 
	if(item.quoteMethod==0)
		return '<div style="color: red;">' +val+ '</div>';
	//阶梯报价
	else if(item.quoteMethod==1){
		var contain='';
		if (item.ladderPricesHis) {
			for(var i=0; i<=item.ladderPricesHis.length-1;i++) {
				var bottom_line = i==item.ladderPricesHis.length-1? '': 'bottom_line';
	          contain +='<div class="'+bottom_line+'" style="color: red;">' +item.ladderPricesHis[i].price+ '</div>';
			}
		}
      return contain;
	}
	return;
};
//成本项目代码
var initCostItemCode = function (val,item,index){
	var contain='';
	if(item.costConstituteHis){
		for(var i=0; i<=item.costConstituteHis.length-1;i++) {
			var bottom_line = i==item.costConstituteHis.length-1? '': 'bottom_line';
          contain +='<div class="'+bottom_line+'">' +item.costConstituteHis[i].costItemCode+ '</div>';
		}
      return contain;
  }
};
//成本项目名称
var initCostItemName = function (val,item,index){
	var contain='';
	if(item.costConstituteHis){
		for(var i=0; i<=item.costConstituteHis.length-1;i++) {
			var bottom_line = i==item.costConstituteHis.length-1? '': 'bottom_line';
          contain +='<div class="'+bottom_line+'">' +item.costConstituteHis[i].costItemName+ '</div>';
		}
      return contain;
  }
};
//成本项目金额
var initCostItemAmount = function (val,item,index){
	var contain='';
	if(item.costConstituteHis){
		for(var i=0; i<=item.costConstituteHis.length-1;i++) {
			var bottom_line = i==item.costConstituteHis.length-1? '': 'bottom_line';
          contain +='<div class="'+bottom_line+'" style="color: red;">' +item.costConstituteHis[i].costItemAmount+ '</div>';
		}
      return contain;
  }
};
//行表操作
var initPriceSelected = function(val,item,index) {
	if(!val) {
		var selected = '<select name="selected" id="selected"  style="color:blue; min-width:70px; padding:5px;">'
						+'<option value =""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>'
						+'<option value ="接受"><i18n:I18n key="i18n_common_title_accept" defaultValue="接受" /></option>'
						+'<option value ="拒绝"><i18n:I18n key="i18n_common_title_refuse" defaultValue="拒绝" /></option>'
						+'<option value="重报"><i18n:I18n key="i18n_common_title_iterance" defaultValue="重报" /></option></select>'
		return selected;
	}
};
//时间戳
var formatDateTime = function (val,item,index){
	if (!val) {val = "";}
	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
};

//历史价格类型
var initFbk50 = function (val,item,index){
	debugger;
	if (val == "0") return '<i18n:I18n key="test" defaultValue="本次报价记录" />';
	else if (val == "1" || val == null) return '<i18n:I18n key="test" defaultValue="历史报价记录" />';
	else if (val == "2") return '<i18n:I18n key="test" defaultValue="历史采购记录" />';
	else return '<i18n:I18n key="test" defaultValue="错误记录" />';
};

//价格类型 如果填了含量,显示:折百价; 不填留空  诺普信
var initFBK14 = function(val,item,index) {
	var val='';
	if(item.FBK13!=null&&item.FBK13!='')
		var val='<input style="background-color: yellow;" readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="折百价"/>';
	else
		var val='<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value=""/>';
	return val;
};

// 税码/税率  @author jiangzhidong @date 20160523 begin
var initTaxCode = function (val,item,index) {
	var orderStatus = item.orderStatus;
	if(orderStatus==3||orderStatus==4||orderStatus==5||orderStatus==6||orderStatus==7||orderStatus==8){
		var name = $(this)[0].name;
	    var sel = '<div><p style="display: none;">'+JSON.stringify(item)+'</p><select onchange="changeTaxCode(this.id, '+index+')" name="'+this.name+'" id="'+name+'_'+index+'" class="taxType" style="padding: 0;height: 25px;width: 100px;">';
	    for(var i = 0 ; i < taxRate.length ; i ++){
			var row = taxRate[i];
			if(row.taxCode==val)
			sel += '<option value="'+row.taxCode+'" taxValue="'+row.taxValue+'" selected>'+row.taxCode+'_'+row.taxName+'</option>';
			else
			sel += '<option value="'+row.taxCode+'" taxValue="'+row.taxValue+'">'+row.taxCode+'_'+row.taxName+'</option>';
		}
	    return sel;
	}else {
		return '<input readonly="readonly" style="width:46px;height: 14px;" name="'+this.name+'" id="'+name+'_'+index+'" type="text"/>';;
	}
}
var initTaxValue = function (val,item,index) {
	var orderStatus = item.orderStatus;
	if(orderStatus==3||orderStatus==4||orderStatus==5||orderStatus==6||orderStatus==7||orderStatus==8){
		if(!val) {
			val = '';
			if(taxRate.length>0){
	         	var row = taxRate[0];
	         	val = row.taxValue;
	        }
		}
		var name = $(this)[0].name;
		return '<input readonly="readonly" style="width:46px;height: 14px;" name="'+this.name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	}else {
		return '<input readonly="readonly" style="width:46px;height: 14px;" name="'+this.name+'" id="'+name+'_'+index+'" type="text"/>';
	}
}
var changeTaxCode = function(val,index){
	var obj=document.getElementById(val);  
	var selIndex=obj.selectedIndex;  
	var text=obj.options[selIndex].getAttribute("taxValue");  
	$('#FBK16_'+index).val(text);
	return val;
}
// 税码/税率 @author jiangzhidong @date 20160523 end

//渲染   @author jiangzhidong 20160113  end


//行列自定义
$("#itemColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'列自定义',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainItem" + "&window=iframeApp_PurchaseEnquiryDetail",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});

//物料信息
var materialHisCol = [{ title:'物料编码', name:'materialNumber' ,width:100, align:'center'},
        			{ title:'物料描述', name:'materialDesc' ,width:100, align:'center'},
                    { title:'物料规格', name:'materialSpecification', width: 80, align: 'center'},
                    { title:'物料属性', name:'property1', width: 120, align: 'center'},
        	        { title:'工厂名称', name:'factory' ,width:100, align:'center'},
        	        { title:'库存地名称', name:'stockPoint' ,width:100, align:'center'},
        	        { title:'要求日期', name:'requestDate' ,width:100, align:'center',renderer: formatDate},
        	        { title:'订单数量', name:'quantity', width: 130, align: 'center'},
        	        { title:'订单单位', name:'unitQuantity' ,width:100, align:'center'},
        	        { title:'价格单位', name:'priceQuantity' ,width:100, align:'center'},
        	        { title:'价格基数', name:'priceMetricQuantity' ,width:100, align:'center'},
        	        { title:'币别', name:'currency' ,width:100, align:'center'}];

//行表purchase_enquiry_item  阶梯表purchase_enquiry_ladder_price  成本表purchase_receive_enquiry_cost_constitute
var erpHisCol =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryBargainItem_mt"/>;

//把操作类型那一列去掉
erpHisCol.forEach(function(d,i){
	if(d.name == "priceSelected")
		erpHisCol.splice(i,1);
});
			
/*报价历史纪录
var erpHisCol = 
			[{ title:'删除标记' , name:'fbk1', width: 50, align:'center', hidden:true},
			{ title:'历史价格类型', name:'fbk50' ,width:100, align:'center', renderer: initFbk50},
			{ title:'采购订单日期', name:'requestDate' ,width:100, align:'center', renderer: formatDate},
			{ title:'采购申请编号', name:'purchaseEnquiryNumber' ,width:100, align:'center'},
			{ title:'采购订单号', name:'purchaseOrderNumber' ,width:100, align:'center'},
            { title:'采购订单的项目编号', name:'orderItemNumber', width: 80, align: 'center'},
            { title:'供应商ERP编号', name:'fbk2', width: 120, align: 'center'},
	        { title:'供应商名称', name:'fbk3' ,width:100, align:'center'},
	        { title:'物料号', name:'materialNumber' ,width:70, align:'center'},
	        { title:'物料描述', name:'materialDesc' ,width:130, align:'center'},
	        { title:'材质工艺(旧)', name:'property1', width: 130, align: 'center'},
			{ title:'规格尺寸(旧)', name:'property2', width: 90, align: 'center'},
			{ title:'材质工艺(新)', name:'property3' ,width:100, align:'center'},
			{ title:'规格尺寸(新)', name:'property4' ,width:100, align:'center'},
			{ title:'版次', name:'fbk4' ,width:100, align:'center'},
		    { title:'基本计量单位', name:'unitQuantity' ,width:100, align:'center'},
		    { title:'数量', name:'fbk5' ,width:100, align:'center'},
		    { title:'净价', name:'fbk6' ,width:100, align:'center'},
		    { title:'价格( 条件金额或百分数 )', name:'fbk7' ,width:100, align:'center'},
		    { title:'平方数', name:'fbk8' ,width:100, align:'center'},
		    { title:'总值', name:'fbk9' ,width:100, align:'center'},
		    { title:'文本', name:'fbk10' ,width:100, align:'center'},
		    { title:'交货日期', name:'fbk11' ,width:100, align:'center'},
		    { title:'仓储地点的描述', name:'fbk12' ,width:100, align:'center'},
		    { title:'采购组', name:'fbk13' ,width:100, align:'center'},
		    { title:'交货已完成标识', name:'fbk14' ,width:100, align:'center'},
		    { title:'订单回执需求', name:'fbk15' ,width:100, align:'center'}];
			
*/
            
            
//物料
function loadMaterial(obj) {
	 var materialParam = {
	    	'elsAccount':obj.currentElsAccount,
	    	'elsSubAccount':obj.elsSubAccount,
	    	'purchaseEnquiryNumber':obj.purchaseEnquiryNumber
	};
	 materialGrid = $('#table-material-his').mmGrid({
		url: '<%=basePath%>rest/PurchaseEnquiryOtherService/queryMaterialByCondtion',
        params: materialParam,
		height: 80,
        cols: materialHisCol,
        params: obj,
        method:  'POST',
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
    }).on('loadSuccess',function(){
    	loadItem(obj);
    });
}



//最新报价
function loadItem(obj) {
	
	var material = materialGrid.rows();
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBargainService/queryEnquiryItemsByCondtion' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(material),
		dataType : "json",
		success : function(data) {
			
			//最新报价
			var itemHisCol=[];
			if(obj.quoteMethod==0){
				for(var i= 0; i<=data.rows.length-1; i++) {
					var cls = i%2==0?'set-head-bg':'set-head-bg-two';
					var toCompanyName ='';
					if(data.rows[i].auditStatus==0 && data.rows[i].orderStatus==7){
						toCompanyName=data.rows[i].toCompanyName+'<span style="font-weight: bolder;color: red;">&nbsp;&nbsp;√</span>';
					}else{
						toCompanyName=data.rows[i].toCompanyName;
					}
					itemHisCol.push({title: toCompanyName, setClass:cls, align: 'center', cols:[{setClass:cls, title:'常规数量', name:'quantity'+i ,width:100, align:'center'},
							                                                {setClass: cls, title:'最小订单量', name:'minOrderQuantity'+i ,width:100, align:'center'},
							                                                {setClass: cls, title:'供货周期', name:'cycle'+i ,width:100, align:'center'},
							                                                {setClass: cls, title:'含税单价', name:'priceIncludingVat'+i ,width:100, align:'center'}]});
			 	}
			}else if(obj.quoteMethod==1){
				for(var i= 0; i<=data.rows.length-1; i++) {
				var cls = i%2==0?'set-head-bg':'set-head-bg-two';
				var toCompanyName ='';
				if(data.rows[i].auditStatus==0 && data.rows[i].orderStatus==7){
					toCompanyName=data.rows[i].toCompanyName+'<span style="font-weight: bolder;color: red;">&nbsp;&nbsp;√</span>';
				}else{
					toCompanyName=data.rows[i].toCompanyName;
				}
				itemHisCol.push({title: toCompanyName, setClass: cls, align: 'center', cols:[{setClass: cls, title:'阶梯数量', name:'jietishuliangA' ,width:100, align:'center'},
							                                                {setClass: cls, title:'最小订单量', name:'minOrderQuantity' ,width:100, align:'center'},
							                                                {setClass: cls, title:'供货周期', name:'供货周期' ,width:100, align:'center'},
							                                                {setClass: cls, title:'含税单价', name:'含税单价' ,width:100, align:'center'}]});
				}
			}
			
			itemGrid = $('#table-item-his').mmGrid({
					height: 200,
			        cols: itemHisCol,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    }).on('loadSuccess',function(){
			    	if(!isloadItemGrid){
			    		isloadItemGrid=true;
			    		var arr=new Array();
				    	var obj=new Object();
				    	for(var i= 0; i<=data.rows.length-1; i++) {
				    		obj['quantity'+i]=data.rows[i].quantity;
				    		obj['minOrderQuantity'+i]=data.rows[i].minOrderQuantity;
				    		obj['cycle'+i]=data.rows[i].cycle;
				    		obj['priceIncludingVat'+i]=data.rows[i].priceIncludingVat;
				     	}
				    	arr.push(obj);
				    	itemGrid.load(arr);
			    	}
			    });
			
		},
		error : function(data) {
			alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
		}
	});
	
}

			
//历史价格审批参照纪录
function loadErp(obj) {
		erpGrid = $('#table-erp-his').mmGrid({
		height: 300,
        cols: erpHisCol,
        url : '<%=basePath%>rest/PurchaseEnquiryBargainService/queryEnquiryItemsHisByCondtion',
        params: obj,
        method:  'POST',
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        plugins: [
            $('#pg-price2').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
  	            , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                , limit:null
                , limitList: [10,20,30,50]
            })
        ]
    });
}

//退出
$("#exitBtn").click(function(){
	//parent.elsDeskTop.closeCurWin('purchaseBargainHisManage');
	top.$(frameElement).parents('.myWindow').find('a.winCloseBtn').click()
});

//同步ERP数据
$("#synchBtn").click(function(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确定同步ERP数据?" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/fromSapPurchaseEnquiryItemHistory' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(obj),
			dataType : "json",
			success : function(data) {
				alert(data.message,2);
				parent.elsDeskTop.hideLoading();
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
				parent.elsDeskTop.hideLoading();
			}
		});
	}});
});


			
</script>
</body>
</html>