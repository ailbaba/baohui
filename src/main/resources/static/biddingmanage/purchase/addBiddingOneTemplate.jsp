<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="addBiddingMainTemplate.jsp"%>
<body>
<script type="text/javascript">

//TODO:基本信息-------begin-----------------------
//预算金额失去焦点事件
$("#budgetAmount").blur(function(){
	var val = $(this).val();
	var result = formatNumber(val,2,1);
	$(this).val(result);
});

/** 
 * 将数值四舍五入后格式化. 
 * 
 * @param num 数值(Number或者String) 
 * @param cent 要保留的小数位(Number) 
 * @param isThousand 是否需要千分位 0:不需要,1:需要(数值类型); 
 * @return 格式的字符串,如'1,234,567.45' 
 * @type String 
 */  
function formatNumber(num,cent,isThousand) {  
  num = num.toString().replace(/\$|\,/g,'');  
   // 检查传入数值为数值类型  
   if(isNaN(num))  
     num = "0";  

 // 获取符号(正/负数)  
 sign = (num == (num = Math.abs(num)));  

 num = Math.floor(num*Math.pow(10,cent)+0.50000000001);  // 把指定的小数位先转换成整数.多余的小数位四舍五入  
 cents = num%Math.pow(10,cent);              // 求出小数位数值  
 num = Math.floor(num/Math.pow(10,cent)).toString();   // 求出整数位数值  
 cents = cents.toString();               // 把小数位转换成字符串,以便求小数位长度  

 // 补足小数位到指定的位数  
 while(cents.length<cent)  
   cents = "0" + cents;  

 if(isThousand) {  
   // 对整数部分进行千分位格式化.  
   for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
     num = num.substring(0,num.length-(4*i+3))+','+ num.substring(num.length-(4*i+3));  
 }  

 if (cent > 0)  
     return (((sign)?'':'-') + num + '.' + cents);  
  else  
     return (((sign)?'':'-') + num);  
}  
//基本信息-------end---------------------

//TODO:招标计划----------begin----------------
//只能输入1-99的整数
$(".keyup-plan-double-digit").keyup(function(){
	var val = $(this).val();
	if(val == 0){
		$(this).val("");
	}
	if(val >= 100){
		$(this).val(val.substring(0,2));
	}
});
//只能输入1-999的整数
$(".keyup-plan-three-digit").keyup(function(){
	var val = $(this).val();
	if(val == 0){
		$(this).val("");
	}
	if(val >= 1000){
		$(this).val(val.substring(0,3));
	}
});

//只能输入0-999的整数
$(".keyup-plan-three-digit-0").keyup(function(){
	var val = $(this).val();
	if(val != ""){
		$(this).val(parseInt(val));
	}
	if(val >= 1000){
		$(this).val(val.substring(0,3));
	}
});
//普通招投标
var phasesRoundCols = [
                       { title:'<i18n:I18n key="" defaultValue="是否在线竞标" />', name:'biddingType' ,width:100, align:'center',hidden:true, renderer:function(val){
                             return val+"<input name='biddingRoundItms[][biddingType]' style='display:none;' type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="标段" />', name:'biddingItemNumber' ,width:100, align:'center',renderer:function(val){
                    	   var showText;  
                  	       if(val == 0){
                      	      var showText = "不区分标段"; 
                  	       }else{
                  	    	  showText = val;
                  	       }  
                    	   return showText+"<input name='biddingRoundItms[][biddingItemNumber]' style='display:none;' class='publised_update' type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="轮次" />', name:'roundsNumber' ,width:100, align:'center',renderer:function(val){
  		                     return val+"<input name='biddingRoundItms[][roundsNumber]' style='display:none;' class='publised_update' type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="状态" />', name:'biddingStatus' ,width:100, align:'center',renderer:function(val){
                    	   var showText;  
                    	   if(val == 0){
                    		   showText="未开始";
                    	   }else if(val == 1){
                    	   	   showText="招标进行中";
                    	   }else if(val == 2){
                    	       showText="未开标";
                    	   }else if(val == 3){
                    	       showText="评标中";
                    	   }else if(val == 4){
                    	       showText="本轮完成";
                    	   }else if(val == 5){
                    	       showText="招标作废";
                    	   }
    		               return showText+"<input name='biddingRoundItms[][biddingStatus]' style='display:none;'  type='text' value='"+val+"'/>";
                       }},
                       { title:'<i18n:I18n key="" defaultValue="投标开始日期" />', name:'biddingBeginDate' ,width:100, align:'center',renderer:function(val,item,rowIndex){
                    	   if(val&&val !=""){
                    		   val = new Date(val).format('yyyy-MM-dd');
                    	   }else{
                    		   val = "";
                    	   }
                    	   var noFirstIndex = rowIndex-1;
                    	   if(rowIndex == 0){//第一轮                    		   
	  		                   return "<input name='biddingRoundItms[][biddingBeginDate]' class='Wdate' type='text' id='bidbegin_"+ rowIndex + 
	  		                   "' onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})\" value='"+val+"'/>";
                    	   }else{//非第一轮
                    		   return "<input name='biddingRoundItms[][biddingBeginDate]' class='Wdate' type='text' id='bidbegin_"+ rowIndex + 
	  		                   "' onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\\'bidopen_"+ noFirstIndex +"\\')}'})\" value='"+val+"'/>";
                    	   }
                       }},
                       { title:'<i18n:I18n key="" defaultValue="投标开始时间" />', name:'biddingBeginTime' ,width:100, align:'center',renderer:function(val){
    		           	   return "<input name='biddingRoundItms[][biddingBeginTime]' class='Wdate' onfocus='WdatePicker({dateFmt:\"HH:mm:00\"})' type='text' value='"+val+"'/>";
                       }},
                       { title:'<i18n:I18n key="" defaultValue="投标截止日期" />', name:'biddingEndDate' ,width:100, align:'center',renderer:function(val,item,rowIndex){
                    	   if(val&&val !=""){
                    		   val = new Date(val).format('yyyy-MM-dd');
                    	   }else{
                    		   val = "";
                    	   } 
                    	   return "<input name='biddingRoundItms[][biddingEndDate]' class='Wdate' type='text' id='bidend_"+ rowIndex + 
                    	   "' onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\\'bidbegin_"+ rowIndex +"\\')}'})\" value='"+val+"'/>";
                       }},
                       { title:'<i18n:I18n key="" defaultValue="投标截止时间" />', name:'biddingEndTime' ,width:100, align:'center',renderer:function(val){
		                   return "<input name='biddingRoundItms[][biddingEndTime]' class='Wdate' onfocus='WdatePicker({dateFmt:\"HH:mm:00\"})'  type='text' value='"+val+"'/>";
                       }},
                       { title:'<i18n:I18n key="" defaultValue="开标日期" />', name:'openDate' ,width:100, align:'center',renderer:function(val,item,rowIndex){
                    	   if(val&&val !=""){
                    		   val = new Date(val).format('yyyy-MM-dd');
                    	   }else{
                    		   val = "";
                    	   }  
                    	   return "<input name='biddingRoundItms[][openDate]' class='Wdate' type='text' id='bidopen_"+ rowIndex +
                    	   "' onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\\'bidend_" + rowIndex + "\\')}'})\" value='"+val+"'/>";
        			   }},
        			   { title:'<i18n:I18n key="" defaultValue="开标时间" />', name:'openTime' ,width:100, align:'center',renderer:function(val){
 	           				  return "<input name='biddingRoundItms[][openTime]' class='Wdate' onfocus='WdatePicker({dateFmt:\"HH:mm:00\"})'  type='text' value='"+val+"'/>";
         			       }},
        			   { title:'<i18n:I18n key="" defaultValue="开标地点" />', name:'address' ,width:250, align:'center',renderer:function(val){
	           				  return "<input name='biddingRoundItms[][address]'   type='text' value='"+val+"'/>";
      			       }},
        			   { title:'<i18n:I18n key="" defaultValue="发送低靠" />', name:'fbk5' ,width:100, align:'center',renderer:function(val,item,rowIndex){
        				   if(!val){val="0";}
        				   if(rowIndex==0){return "";}else{
	           				  return "<input name='fbk5' "+(val=="1"?" checked='checked'":"")+" type='checkbox' class='publised_update' value='"+val+"'/>"
	           				  		+"<input type='text' name='biddingRoundItms[][fbk5]' style='display:none;' class='publised_update' value='"+val+"'/>";    					   
        				   }
      			       }},
        			   { title:'<i18n:I18n key="" defaultValue="低靠百分比" />', name:'fbk6' ,width:100, align:'center',renderer:function(val,item,rowIndex){
        				   if(!val){val = "";}
        				   if(rowIndex==0){return "";}else{
 	           				  return "<input name='biddingRoundItms[][fbk6]' type='text' class='publised_update' onkeyup='value=value.replace(/[^(0-9)]/g,\"\")' value='"+val+"'/>";        					   
         				   }
      			       }},
        			   { title:'<i18n:I18n key="" defaultValue="发送排名" />', name:'fbk7' ,width:100, align:'center',renderer:function(val,item,rowIndex){
        				   if(!val){val="0";}
        				   if(rowIndex==0){return "";}else{
 	           				  return "<input name='fbk7' "+(val=="1"?" checked='checked'":"")+" type='checkbox' class='publised_update' value='"+val+"'/>"
 	           						+"<input type='text' name='biddingRoundItms[][fbk7]' style='display:none;' class='publised_update' value='"+val+"'/>"; 
         				   }
      			       }},
        			   { title:'<i18n:I18n key="" defaultValue="人工干预" />', name:'fbk8' ,width:100, align:'center',renderer:function(val,item,rowIndex){
        				   if(!val){val="0";}
        				   if($("#totalRound").val()==(rowIndex+1))
        					   val = 1;
 	           			   return "<input id='phasesRoundColsFbk8_"+rowIndex+"' name='fbk8' "+(val=="1"?" checked='checked'":"")+" type='checkbox' class='publised_update' value='"+val+"'/>"
 	           					+"<input type='text' name='biddingRoundItms[][fbk8]' style='display:none;' class='publised_update' value='"+val+"'/>"; 
      			       }},
        			   { title:'<i18n:I18n key="" defaultValue="是否当前轮次" />', name:'isCurrentRound' ,width:100, align:'center',hidden:true,renderer:function(val,item,rowIndex){
        				   if(!val){val="0";}
 	           			   return "<input name='biddingRoundItms[][isCurrentRound]' class='publised_update' type='text' readonly='readonly' value='"+val+"'/>"; 
      			       }}
                 ];

//单击招标计划tag事件                 
$(".edit-line-plan").click(function(){
	if(phasesRoundTable){//仅当第一次点击加载本tag页
		return;
	}
	var cols = phasesRoundCols;
	$(".date-unit").html("天");
	
	//初始化phasesRoundTable
	phasesRoundTable = $('#phases-round-table').mmGrid({
	    cols: cols,
	    height: 240,
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
	});
});

//计算并生成轮次数据
function computeOperation(){
	 var biddingBeginDate = $("#plan_beginDate").val();
	 var biddingBeginTime = $("#plan_beginTime").val();
	 var biddingRounds = $("#totalRound").val();//轮次
	 var eachRound = $("#duration").val();//每轮持续
	 var roundInterval = $("#intervalType").val(); //间隔
	 var budgetAmount = $("#budgetAmount").val();
	 if(budgetAmount == null || budgetAmount == ""){
		 budgetAmount = 0;
	 }
	 if(budgetAmount == null || budgetAmount == ""){
		 budgetAmount = 0;
	 }
	 
	 if(biddingBeginDate == "" || biddingBeginTime == "" || eachRound == "" || roundInterval == "" || biddingRounds == ""){
		 if(typeof(phasesRoundTable) != "undefined"){
			 phasesRoundTable.removeRow(undefined);
		 }
		 return ;
	 }
	 var beginDate;
	 var endDate;
	 phasesRoundTable.removeRow(undefined);
	 
	 var address = $("#bidding-address").val();
	 var bidOpenDate = new Date();
	 for(var i = 0 ; i < biddingRounds ; i ++){
		 var endDateVal;
		 if(!endDate){
			 beginDate = new Date(biddingBeginDate+" "+biddingBeginTime);
			 endDate=new Date();
			 var round = parseInt(eachRound)-1;//每轮持续天数
			 endDate.setTime(beginDate.getTime()+1000*60*60*24*round);
			 var endDateStr = endDate.format('yyyy-MM-dd');
			 endDateVal = new Date(endDateStr);
			 endDateVal.setTime(endDateVal.getTime() + 1000*60*60*10);
			 bidOpenDate.setTime(endDate.getTime()+1000*60*60*24);
			 
		 }else{
			 var intervalType = parseInt(roundInterval) + 1;
			 beginDate.setTime(bidOpenDate.getTime()+1000*60*60*24*intervalType);
			 var round = parseInt(eachRound)-1;//每轮持续天数
			 endDate.setTime(beginDate.getTime()+1000*60*60*24*round);
			 var endDateStr = endDate.format('yyyy-MM-dd');
			 endDateVal = new Date(endDateStr);
			 endDateVal.setTime(endDateVal.getTime() + 1000*60*60*10);
			 bidOpenDate.setTime(endDate.getTime()+1000*60*60*24);
		 }
		 var item = {"biddingType":"0","biddingItemNumber":"0","roundsNumber":i+1,"biddingStatus":"0","biddingBeginDate":beginDate.format('yyyy-MM-dd'),"biddingBeginTime":beginDate.format('hh:mm:ss'),"biddingEndDate":endDateVal.format('yyyy-MM-dd'),"biddingEndTime":endDateVal.format('hh:mm:ss'),"openDate":bidOpenDate.format('yyyy-MM-dd'),"openTime":bidOpenDate.format('hh:mm:ss'),"address":address};
		 phasesRoundTable.addRow(item);
	 }
		
	 if(phasesNumber == "0" || phasesNumber == "1"){//区分跟不区分标段时，设置第一标段/第零标段的起始时间为招投标头上的起始时间
    	 $("body").data("header_beginDate",biddingBeginDate);//开始日期
    	 $("body").data("header_endDate",endDate.format('yyyy-MM-dd'));//结束日期
    	 $("body").data("header_totalRound",biddingRounds);//总轮次
     }
}
$("input[name='fbk5']").live('change',function(){
	 if($(this).is(':checked')){
		 $(this).val("1");
		 $(this).next().val("1");
	 }else{
		 $(this).val("0");
		 $(this).attr("checked",false);
		 $(this).next().val("0");
	 }
});
$("input[name='fbk7']").live('change',function(){
	 if($(this).is(':checked')){
		 $(this).val("1");
		 $(this).next().val("1");
	 }else{
		 $(this).val("0");
		 $(this).attr("checked",false);
		 $(this).next().val("0");
	 }
});
$("input[name='fbk8']").live('change',function(){
	// 最后一轮必须人工评标
	if(phasesRoundTable!="" && $(this).attr("id").split("_")[1]==(phasesRoundTable.rowsLength()-1)) {
		 $(this).attr("checked",true);
		 $(this).val("1");
		 $(this).next().val("1");
		 return;
	}
	 if($(this).is(':checked')){
		 $(this).val("1");
		 $(this).next().val("1");
	 }else{
		 $(this).val("0");
		 $(this).attr("checked",false);
		 $(this).next().val("0");
	 }
});
//------触发事件---------
$('.init-roundTable').live('blur',function() {
	var biddingBeginDate = $("#plan_beginDate").val();
	var biddingBeginTime = $("#plan_beginTime").val();
	var biddingRounds = $("#totalRound").val();//轮次
	var eachRound = $("#duration").val();//每轮持续
	var roundInterval = $("#intervalType").val(); //间隔
	var roundsRows = phasesRoundTable.rows();
	if(biddingBeginDate != "" && biddingBeginTime != "" && biddingRounds != ""&& eachRound != "" && roundInterval != "" && typeof(roundsRows[0])=="undefined"){
		computeOperation();	
	}
});
//------点击按钮更新轮次表数据---------
$('#updateBiddingPlanTable').live('click',function() {
	//parent.elsDeskTop.tip.init({type: 'confirm',message: '是否重新覆盖计划表数据?',closeEvent:function(){
		computeOperation();
	//}});
});


function extend(destination, source) {
    for (var property in source)  
      destination[property] = source[property];  
    return destination;  
}

function clearRound(){
	phasesRoundTable.removeRow();
	$("#totalRound").val("");
	$("#duration").val("");
	$("#intervalType").val("");
	$("#plan_beginDate").val("");
	$("#plan_beginTime").val("");
	$("input[name='biddingRoundsVO[secret]']").eq(0).attr("checked",'checked');
}
//保存招标计划中标段和总轮次的信息，公招标文件页使用
$("#totalRound").blur(function(){
	var totalRound = $("#totalRound").val();
	for(var i=0;i<totalRoundArr.length;i++){
		if(totalRoundArr[i].itemNumber == "0"){
			totalRoundArr.splice(i,1);
		}
	}
	var data = {itemNumber:"0",totalRound:totalRound};
	totalRoundArr.push(data);
});
//招标计划----------end----------------

//TODO:保证金----------begin----------------
//单击保证金tag事件      --初始化tag页           
$(".edit-line-bail").click(function(){
	var init_margin_flag = $("body").data("init_margin_flag");
	if(init_margin_flag){
		return;
	}
	$("body").data("init_margin_flag",true);//设置成已经初始化
});

//保证金金额失去焦点事件
$("#margin_amount").blur(function(){
	var val = $(this).val();
	var result = formatNumber(val,2,1);
	$(this).val(result);
});

function clearMargin(){
	$("input[name='biddingMarginVO[collect]']").eq(1).attr("checked",'checked');
	$("input[name='biddingMarginVO[back]']").eq(1).attr("checked",'checked');
	$("#margin_amount").attr("readonly",false).val("");
	$("#margin_currencyType").attr("disabled",false).val("CNY");
	$("#margin_payBeginDate").attr("disabled",false).val("");
	$("#margin_payEndDate").attr("disabled",false).val("");
	$("#margin_remark").attr("readonly",false).val("");
}

$('input[name="biddingMarginVO[collect]"]:eq(0)').click(function(){//不收取保证金
	$('input[name="biddingMarginVO[back]"]').eq(0).attr("checked",'checked');
	$('input[name="biddingMarginVO[back]"]').eq(0).parent().hide();
	$('input[name="biddingMarginVO[back]"]').eq(0).parent().prev().hide();
	$("#margin_amount").attr("readonly",true).val("");
	$("#margin_currencyType").attr("disabled",true).val("CNY");
	$("#margin_payBeginDate").attr("disabled",true).val("");
	$("#margin_payEndDate").attr("disabled",true).val("");
	$("#margin_remark").attr("readonly",true).val("");
});
$('input[name="biddingMarginVO[collect]"]:eq(1)').click(function(){//收取保证金
	$('input[name="biddingMarginVO[back]"]').eq(1).attr("checked",'checked');
	$('input[name="biddingMarginVO[back]"]').eq(0).parent().show();
	$('input[name="biddingMarginVO[back]"]').eq(0).parent().prev().show();
	$("#margin_amount").attr("readonly",false);
	$("#margin_currencyType").attr("disabled",false);
	$("#margin_payBeginDate").attr("disabled",false);
	$("#margin_payEndDate").attr("disabled",false);
	$("#margin_remark").attr("readonly",false);
	var currDate = new Date().format("yyyy-MM-dd");
	$("#margin_payBeginDate").val(currDate);
	$("#margin_payEndDate").val(currDate);
});
//保证金----------end------------------

/* =============================================招标内容  start================================================ */
var biddingDetailContentGrid;
var biddingStandardGrid;
var perbiddingItemNumberValue;
var biddingContentItemStandardArray;
var contentItemArray=new Array();
var contentStandardArray=new Array();

var biddingDetailContentItem = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="biddingPurchaseContentItem_mt"/>;

var biddingStandardItem=[
      	{title:'序号',name:'sequenceNumber', width: 100, align: 'center',renderer:function(val,item,rowIndex){
      		return rowIndex+1;
      	}},     
    	{title:'招标编号',name:'biddingNumber',hidden:true, width: 100, align: 'center',renderer:function(val){
      		return "<input name='biddingContentStandard[][biddingNumber]' readonly='readonly' type='text'  value='"+$("#biddingNumber").val()+"'/>";
      	}},     
      	{title:'标段号',name:'biddingItemNumber', width: 100, align: 'center',renderer:function(val){
      		return "<input name='biddingContentStandard[][biddingItemNumber]' type='text' readonly='readonly' value='"+val+"'/>";
      	}},   
        { title:'评分类别编号', name:'scoreTypeCode' ,width:100, align:'center',renderer:function(val){
      		return "<input name='biddingContentStandard[][scoreTypeCode]' type='text' readonly='readonly' value='"+val+"'/>";
      	}},
        { title:'评分类别名称', name:'scoreTypeName' ,width:100, align:'center',renderer:function(val){
      		return "<input name='biddingContentStandard[][scoreTypeName]' type='text' readonly='readonly' value='"+val+"'/>";
      	}},
      	{title:'评分标准编号',name:'standardNumber', width: 100, align: 'center',renderer:function(val,item,rowIndex){
      		return "<input name='biddingContentStandard[][standardNumber]' type='text' readonly='readonly' value='"+val+"'/>";
      	}},     
      	{title:'评分标准名称',name:'standardName', width: 100, align: 'center',renderer:function(val){
      		return "<input name='biddingContentStandard[][standardName]' type='text' readonly='readonly' value='"+val+"'/>";
      	}},     
      	{title:'权重',name:'ratio', width: 120, align: 'center',renderer:function(val){
      		return "<input name='biddingContentStandard[][ratio]' type='text'  value='"+val+"' onblur='this.value=toNum(this.value);'/>";
      	}},    
      	{title:'负责人',name:'person', width: 120, align: 'center',renderer:function(val){
      		return "<input name='biddingContentStandard[][person]' type='text'  value='"+val+"'/>";
      	}},     
      	{title:'具体标准',name:'standardDocument', width: 80, align: 'center',renderer:function(val, item, rowIndex){
      		var text = '<span class="downloadFile-contentItem" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
      		return text;
      	}},  
        { title:'详细说明', name:'standardDetail' ,width:120, align:'center',renderer:function(val){
      		return "<input name='biddingContentStandard[][standardDetail]' type='text'  value='"+val+"'/>";
      	}}
      ];

function initInput(val,item,index){
	if(!val) { val = '';}
	var name = $(this)[0].name;
	return '<input name="biddingContentItem[]['+name+']" id="'+name+'_'+index+'" type="text" class="biddingDetailContentColsEdit" value="'+val+'"/>';
}
//渲染   @author songzhen 20161215  begin
//招标内容行表渲染
function attachmentFileRenderer(val, item, rowIndex){
	var viewFlag = false;
		var extendFields = item.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var fileList = extendFields.fileList;
			viewFlag = (fileList && fileList!="");
		}
		return '<span class="uploadFile-item" id="attachmentFile_upload_'+rowIndex+'" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span>'
    +'&nbsp;&nbsp;<span class="downloadFile-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span>';
}
function attachmentImageRenderer(val, item, rowIndex){
		var viewFlag = false;
		var extendFields = item.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var imageList = extendFields.imageList;
			viewFlag = (imageList && imageList!="");
		}
		return '<span class="previewImage-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span>'
    +'&nbsp;&nbsp;<span class="uploadImage-item" id="attachmentImage_upload_'+rowIndex+'" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span>'
    +'&nbsp;&nbsp;<span class="downloadImage-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" />';
}
function biddingNumberRenderer(val){
		return "<input name='biddingContentItem[][biddingNumber]' type='text' readonly='readonly' value='"+$("#biddingNumber").val()+"'/>";
	}
function biddingItemNumberRenderer(val){
		return "<input name='biddingContentItem[][biddingItemNumber]' type='text' readonly='readonly' value='"+val+"'/>";
	}
function biddingContentItemNumberRenderer(val){
		return "<input name='biddingContentItem[][biddingContentItemNumber]' type='text' readonly='readonly' value='"+val+"'/>";
	}
function biddingProjectNumberRenderer(val,item,rowIndex){
		return "<input name='biddingContentItem[][biddingProjectNumber]' type='text' readonly='readonly' value='"+val+"'/>";
	}
function materialNumberRenderer(val){
		return val + "<input name='biddingContentItem[][materialNumber]' type='hidden' value='"+val+"'/>";
	}
function materialDescRenderer(val){
		return "<input name='biddingContentItem[][materialDesc]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
	}
function materialModelRenderer(val){
		return "<input name='biddingContentItem[][materialModel]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
	}
function materialSpecificationRenderer(val){
		return "<input name='biddingContentItem[][materialSpecification]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
	}
function unitsRenderer(val){
		return "<input name='biddingContentItem[][units]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
	}
function quantityRenderer(val){
	if(!val || val ==null){
		val = "";
	}
	return "<input name='biddingContentItem[][quantity]' type='text' class='biddingDetailContentColsEdit' onkeyup='value=value.replace(/[^(0-9\\.)]/g,\"\")'  value='"+val+"'/>";
}
function fbk2Renderer(val){
	if(!val){
		val="";
	}
	return "<input name='biddingContentItem[][fbk2]' type='text' class='biddingDetailContentColsEdit' onkeyup='value=value.replace(/[^(0-9\\.)]/g,\"\")' value='"+val+"'/>";
}
function fbk3Renderer(val){
	if(!val){
		val="";
	}
	return "<input name='biddingContentItem[][fbk3]' type='text' class='biddingDetailContentColsEdit' onkeyup='value=value.replace(/[^(0-9\\.)]/g,\"\")' value='"+val+"'/>";
}
function deliveryDateRenderer(val){
	if(val&&val !=""){
		val = new Date(val).format('yyyy-MM-dd');
	}else{
		val = "";
	}
	return '<input type="text" id="" name="biddingContentItem[][deliveryDate]"  class="Wdate" onfocus=\'WdatePicker({dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
}
function remarkRenderer(val){
	return "<input name='biddingContentItem[][remark]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
}
function fbk10Renderer(val){
	if(!val){val = "";}
	return "<input name='biddingContentItem[][fbk10]' type='text' readonly='readonly' value='"+val+"'/>";
}
//渲染   @author songzhen 20161215  end

/**----------============需求类型和编码选择（BEGIN）============----------*/
function selectRequirementTypeCode(rowIndex){
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
		event.preventDefault();
		event.stopPropagation();
	} else {
		window.event.returnValue = false;
	}
	var getData = function(data) {
		requirementTypeCallback(data,rowIndex);
	};
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
		'windowsId':'requirementTypeCheck',
		'windowTitle':'<i18n:I18n key="" defaultValue="需求类型"/>',
		'windowSubTitle': companyShortName,
		'iframSrc':'<%=basePath%>requirement/requirementtype/requirementTypeCheck.jsp?frameAppId=addBiddingThree',
		'showAdv': false,
			'mask' : true,
		'windowStatus': 'regular',
		'windowMinWidth': 1024,
		'windowMinHeight': 580,
		'windowPositionTop':14,
		'windowWidth':1024,
		'windowHeight':580,
		'parentPanel':".currDesktop",
		data: getData
	});
}

function requirementTypeCallback(dataRows,rowIndex){
	if("undefined"!=typeof(dataRows) && dataRows.length > 0){
		var itemRow = biddingDetailContentGrid.row(rowIndex);
		itemRow["requirementTypeCode"] = dataRows[0].requirementTypeCode;
		itemRow["requirementTypeName"] = dataRows[0].requirementTypeName;
		$("#requirementTypeCode_"+rowIndex).val(itemRow["requirementTypeCode"]);
		$("#requirementTypeName_"+rowIndex).val(itemRow["requirementTypeName"]);
		biddingDetailContentGrid.updateRow(itemRow, rowIndex);
	}
}

function selectMaterialNumber(rowIndex){
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
		event.preventDefault();
		event.stopPropagation();
	} else {
		window.event.returnValue = false;
	}
	var getData = function(data) {
		materialCallback(data,rowIndex);
	};
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
		'windowsId':'materialCheck',
		'windowTitle':'<i18n:I18n key="" defaultValue="物料基础数据"/>',
		'windowSubTitle': companyShortName,
		'iframSrc':'<%=basePath%>materialmanage/materialCheck.jsp?frameAppId=addBiddingThree',
		'showAdv': false,
			'mask' : true,
		'windowStatus': 'regular',
		'windowMinWidth': 1024,
		'windowMinHeight': 580,
		'windowPositionTop':14,
		'windowWidth':1024,
		'windowHeight':580,
		'parentPanel':".currDesktop",
		data: getData
	});
}

function materialCallback(dataRows,rowIndex){
	if("undefined"!=typeof(dataRows) && dataRows.length > 0){
		var itemRow = biddingDetailContentGrid.row(rowIndex);
		var materialNumber = itemRow.materialNumber;
		var updateFlag = (materialNumber && null!=materialNumber && $.trim(materialNumber)!="");
		var curRowIndex = biddingDetailContentGrid.rowsLength();
		for(var i=0; i<dataRows.length; i++) {
			var contentBiddingProjectNumber = $("#contentBiddingProjectNumber").val();
			if(i==0 && !updateFlag) {
				itemRow["biddingProjectNumber"] = contentBiddingProjectNumber;
				itemRow["biddingItemNumber"] = "0";
				itemRow["materialNumber"] = dataRows[i].materialNumber;
				itemRow["materialDesc"] = dataRows[i].materialName;
				itemRow["extendFields"] = dataRows[i].extendFields;
				itemRow["deliveryDate"] = new Date().format('yyyy-MM-dd');
				biddingDetailContentGrid.updateRow(itemRow,rowIndex);//更新改行数据
				continue ;
			}
			var maxNumber = getMaxContentItemNum();
			var data = {
					biddingProjectNumber : contentBiddingProjectNumber,
					biddingItemNumber : "0",
					biddingContentItemNumber : maxNumber+1,
					materialNumber : dataRows[i].materialNumber,
					materialDesc : dataRows[i].materialName,
					quantity : 0.0,
					materialModel : "",
					materialSpecification : "",
					units : "",
					deliveryDate : new Date().format('yyyy-MM-dd'),remark:"",
					extendFields : dataRows[i].extendFields
			};
			biddingDetailContentGrid.addRow(data,(curRowIndex+i));//插入到表格最后
		}
	}
}
/**----------============需求类型和编码选择（END）============----------*/

//单击招标内容tag页时触发 
$('.edit-line-content').click(function() {
	//set标段
	initImportExlModual(bdContentItemUploader);
	if(biddingDetailContentGrid ===undefined) {
		biddingDetailContentGrid=$('#biddingDetailContentTable').mmGrid({
	        cols: biddingDetailContentItem,
	        items: contentItemArray,
	        heigth: 350,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect:true,
	        hasJsonOption : "extendFields"
	    });
		biddingDetailContentGrid.resize();
	}
	if(biddingStandardGrid ===undefined) {
		biddingStandardGrid=$('#biddingStandardTable').mmGrid({
	        cols: biddingStandardItem,
	        items: contentStandardArray,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect:true
	    });
		biddingStandardGrid.resize();
	}
	 
	//set项目编号
	$("#contentBiddingProjectNumber").val($("#biddingProjectNumber").val());
	if($("#contentBiddingProjectNumber").val()!=""){
		loadProjectName();
	}
	
	if(biddingDetailContentGrid){
		biddingDetailContentGrid.resize();
		return;
	}
	//招标详细内容
	if(!biddingDetailContentGrid) {
		biddingDetailContentGrid=$('#biddingDetailContentTable').mmGrid({
	        cols: biddingDetailContentItem,
	        heigth: 350,
	        hasJsonOption : 'extendFields',
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect:true,
	        items: []
	    });
		biddingDetailContentGrid.resize();
	}
	//评标标准内容
	if(!biddingStandardGrid) {
		biddingStandardGrid=$('#biddingStandardTable').mmGrid({
	        cols: biddingStandardItem,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect:true,
	        items: []
	    });
		biddingStandardGrid.resize();
	}
});

function biddingDetailContentAddItem(){
	var rows = biddingDetailContentGrid.rows();
	var maxContentItemNumber = 0;
	for(var i=0;i<rows.length;i++){
		if(typeof(rows[i]) != "undefined" && rows[i] != null){
			var biddingContentItemNumber = rows[i].biddingContentItemNumber;
			if(biddingContentItemNumber != null && typeof(biddingContentItemNumber) != "undefined" && biddingContentItemNumber>maxContentItemNumber){
				maxContentItemNumber = biddingContentItemNumber;
			}
		}
	}
	var maxNumber = parseInt(maxContentItemNumber);
	if($("#biddingType").val() == "3" && rows[0]){
		alert("在线竞标只能添加一条物料信息！",2);
		return;
	}
	var contentBiddingProjectNumber = $("#contentBiddingProjectNumber").val();
	var biddingDetailBlackItem={
			biddingProjectNumber:contentBiddingProjectNumber,biddingItemNumber:"0",biddingContentItemNumber:maxNumber+1,
			materialNumber:"",materialDesc:"",quantity:0.0,fbk2:"",fbk3:"",
			materialModel:"",materialSpecification:"",units:"",deliveryDate:new Date().format('yyyy-MM-dd'),remark:"",
			};
	biddingDetailContentGrid.addRows([biddingDetailBlackItem]);
}

function biddingDetailContentRemoveItem(){
	var seletectIndexArr=biddingDetailContentGrid.selectedRowsIndex();
	if(seletectIndexArr.length<=0){
		alert("请选择要删除的行!",2);
		return;
	}
	for(var i=0;i<seletectIndexArr.length;i++){
		biddingDetailContentGrid.removeRow(seletectIndexArr);
	}
}

function biddingStandardAddItem(){
	var rows = biddingStandardGrid.rows();
	var standardIndex = biddingStandardGrid.rowsLength()+1;
	var biddingStandardBlackItem={biddingItemNumber:"0",standardNumber:standardIndex,standardName:"",ratio:0,person:"",standardDetail:""};
	biddingStandardGrid.addRow(biddingStandardBlackItem,standardIndex);
}

function biddingStandardRemoveItem(){
	var seletectIndexArr=biddingStandardGrid.selectedRowsIndex();
	if(seletectIndexArr.length<=0){
		alert("请选择要删除的行!",2);
		return;
	}
	for(var i=0;i<seletectIndexArr.length;i++){
		biddingStandardGrid.removeRow(seletectIndexArr);
	}
}

function loadProjectName(){
	var biddingProjectNumber = $("#contentBiddingProjectNumber").val();
	if(biddingProjectNumber){
		//头信息
		$.ajax({
			url :"<%=basePath%>rest/ProjectManageService/queryProjectManageHead",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"elsAccount":elsAccount,"projectNumber":biddingProjectNumber}),
			success : function(data) {
				if(data.statusCode == null){
					if(data.rows != null && data.rows != ""){
						$("#contentBiddingProjectName").val(data.rows[0].projectDesc);
					}else{
						$("#contentBiddingProjectName").val("");
					}
				}else{
					$("#contentBiddingProjectName").val("");
				}
			}
		});
	}else{
		$("#contentBiddingProjectName").val("");
	}
}

//添加招标详细内容
$("#biddingDetailContentAdd").click(function(){
	biddingDetailContentAddItem();
});

//删除招标详细内容
$("#biddingDetailContentRemove").click(function(){
	biddingDetailContentRemoveItem();
});

//添加 评标标准内容
$("#biddingStandardAdd").click(function(){
	biddingStandardAddItem();
});

//删除 评标标准内容
$("#biddingStandardRemove").click(function(){
	biddingStandardRemoveItem();
});

$('#contentBiddingProjectNumber').live('blur',function() {
	loadProjectName();
});


/** -----------===============Excel导入导出、评标导入、需求计划提取（开始）===============----------- */
var bdContentItemUploader ;
initImportExlModual(bdContentItemUploader);

$(".biddingDetailContentColsEdit").live('change',function(){
	var thisVal = $(this).val();
	var thisName = $(this).attr("name");
	var splitThisArr = thisName.split("[]");
	if(splitThisArr.length>0) {
		var tempSplitArr1 = splitThisArr[1];
		if(tempSplitArr1 && tempSplitArr1.length>2) {
			thisName = tempSplitArr1.substr(1,tempSplitArr1.length-2);
		    var rowIndex = $(this).closest("tr").index();
		    var rowData = biddingDetailContentGrid.row(rowIndex);
		    rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
		}
	}
});

function initImportExlModual(bdContentItemUploader) {
	if(!bdContentItemUploader) {
			bdContentItemUploader = WebUploader.create({
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
		    pick: '#importByMaterial',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false,
	  	    formData : {
		     	elsAccount : elsAccount
		    }
		});
			bdContentItemUploader.on( 'uploadAccept', function( file, response ) {
			 	var filePath = response.url;
			 	var fbk6 = $("input[name='fbk6']:checked").val();
			 	var biddingNumber = $("#biddingNumber").val();
			 	var biddingItemNumber = "0";
		  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
		  	$.ajax({
				url :"<%=basePath%>rest/PurchaseBiddingService/importExcelByPath",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"fbk9":filePath,"elsAccount":elsAccount,"fbk6":fbk6,
					"biddingNumber":biddingNumber,"biddingItemNumber":biddingItemNumber}),
				success : function(data) {
					//var obj = JSON.parse(data);
					if(data.statusCode=="-100"){
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_importFailure" defaultValue="导入失败！请检查文件内容！" />'});
					}else{
						parent.elsDeskTop.hideLoading();
						biddingDetailContentGrid.load(data.rows);
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 1,message : '<i18n:I18n key="i18n_common_alert_successfulImprot" defaultValue="导入成功！" />'});
					}
				},
			    error : function(data) {
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		});
	}
}
$("#downMaterialModual").click(function() {
	window.location.href = "<%=basePath%>"+"template/招投标物料导入模板.xls";
});
var getEvaltempData = function(data) {
	var biddingStandardRowLength = biddingStandardGrid.rowsLength();
	var biddingStandardGridRows = biddingStandardGrid.rows();
	var biddingStandardTempArr = [];
	if(biddingStandardGridRows != "") {
		for(var j=0; j<biddingStandardGridRows.length; j++) {
			biddingStandardTempArr.push(biddingStandardGridRows[j]["standardNumber"]);
		}
	}
	for(var i=0;i<data.length;i++) {
		var standardIndex = biddingStandardRowLength + i;
		if(jQuery.inArray(data[i].scoreModuleCode,biddingStandardTempArr) != -1)
				continue;
		var biddingStandardRetItem={
				biddingItemNumber: "0",
				standardNumber: data[i].scoreModuleCode,
				standardName: data[i].scoreModuleName,
				scoreTypeCode: data[i].scoreTypeCode,
				scoreTypeName: data[i].scoreTypeName,
				ratio: 0,
				person: "",
				standardDetail: data[i].detailDesc,
				standardDocument : ""
		};
		biddingStandardRetItem.fileList=data[i].fileList;
		biddingStandardGrid.addRow(biddingStandardRetItem,standardIndex);
		//$("#scoreTypeCode"+standardIndex).val(data[i].scoreTypeCode);
	}
};
$("#obtainByEvaltemp").click(function() {
	parent.elsDeskTop.defineWin({
	   'iconSrc': 'icon/destop-icon/desktop_icon_93.gif',
	   'windowsId': 'biddingEvalTempSel',
	   	'mask' : true,
	   'windowTitle': '<i18n:I18n key="" defaultValue="选择评分模板"/>',
	   'windowSubTitle': companyShortName,
	   'iframSrc': '<%=basePath%>biddingmanage/purchase/biddingEvalTempSel.jsp'+
	   				'?frameAppId=biddingPurchaseManage2&biddingNumber='+$("#biddingNumber").val()+
	   				'&elsAccounta='+$("#elsAccount").val()+
	   		   		'&biddingItemNumOne=0',
	   'showAdv': false,
	   'windowStatus': 'regular',
	   'windowMinWidth': 1024,
	   'windowMinHeight': 580,
	   'windowPositionTop': 14,
	   'windowWidth': 1024,
	   'windowHeight': 580,
	   'parentPanel': ".currDesktop",
       data: getEvaltempData
	});
});
$('.downloadFile-contentItem').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var itemRow = biddingStandardGrid.row(itemRowIndex);
	var fileList = itemRow.fileList;
	if("undefined"!=typeof(fileList) && fileList.length > 0){
		for(var i=0;i<fileList.length;i++){
			window.open("<%=basePath%>servlet/downloadServlet?filePath="+fileList[i].annexFilePath);
		}
	} else {
		alert("没有文件可下载",2);
	}
});
var uploadFileRowIndex;
var fileUploader1;
$('.uploadFile-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var item = biddingDetailContentGrid.row(itemRowIndex);
	var materialNumber = item.materialNumber;
	if(!(materialNumber && null!=materialNumber && $.trim(materialNumber)!="")) {
		alert('物料编号不能为空，请选择物料',2);
		return ;
	}
	uploadFileType="file";
	uploadFileRowIndex=itemRowIndex;
	uploadFile();
});

$('.downloadFile-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var itemRow = biddingDetailContentGrid.row(itemRowIndex);
	var extendFields = itemRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var fileList = extendFields.fileList;
		if("undefined"!=typeof(fileList) && fileList.length > 0){
			downloadFile("file",itemRowIndex);
		} else {
			alert("没有文件可下载",2);
		}
	} else {
		alert("没有文件可下载",2);
	}
});

$(".previewImage-item").live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var itemRow = biddingDetailContentGrid.row(itemRowIndex);
	var extendFields = itemRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		if("undefined"!=typeof(imageList) && imageList.length > 0){
			parent.elsDeskTop.closeCurWin('showPicture');
			for(var i=0;i<imageList.length;i++) {
				imageList[i]["preViewFilePath"] = imageList[i].filePath;
			}
			var obj={
					windowTitle: "图片预览",
					data:{
						defaultShow:"1",
						imageList : imageList
					},
			 	   	mask : true,
					windowMaximize: false,
					windowMinimize: false,
					windowStatus: "regular",
					windowWidth: 860,
					windowHeight: 700,
					iframSrc: elsBasePath+"common/previewimg/showPicture.jsp",
					windowsId: "showPicture",//传递上一级的窗口iframe id用parentWinId,其他数据自定
				};
			parent.elsDeskTop.defineWin(obj);
		} else {
			alert("没有图片可预览",2);
		}
	} else {
		alert("没有图片可预览",2);
	}
});

$('.uploadImage-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var item = biddingDetailContentGrid.row(itemRowIndex);
	var materialNumber = item.materialNumber;
	if(!(materialNumber && null!=materialNumber && $.trim(materialNumber)!="")) {
		alert('物料编号不能为空，请选择物料',2);
		return ;
	}
	uploadFileType="image";
	uploadFileRowIndex=itemRowIndex;
	uploadFile();
});

$('.downloadImage-item').live("click", function() {
	var itemRowIndex = $(this).closest("tr").index();
	var itemRow = biddingDetailContentGrid.row(itemRowIndex);
	var extendFields = itemRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		if("undefined"!=typeof(imageList) && imageList.length > 0){
			downloadFile("image",rowIndex);
		} else {
			alert("没有图片可下载",2);
		}
	} else {
		alert("没有图片可下载",2);
	}
});
$("#addFileBtnOK").click(function(){
	$("#addFileDialog1").hide();
	var filePath = $("#filePath1").val();
	if(filePath == ""){
		alert("<i18n:I18n defaultValue='请选择上传文件！' key='i18n_please_select_a_file_to_upload'/>",1);
		return false;
	}
	var fileName = $("#fileName1").val();
	var filePath = $("#filePath1").val();
	
	var itemRow = biddingDetailContentGrid.row(uploadFileRowIndex);
	var extendFields = itemRow.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
	} else {
		extendFields = {};
	}
	
	if("file"==uploadFileType){
		var fileList = extendFields.fileList;
		if("undefined"==typeof(fileList)){
			fileList = [];
		}
		fileList.push({fileType: "file",fileName:fileName,filePath:filePath});
		extendFields["fileList"]=fileList;
		itemRow["extendFields"]= JSON.stringify(extendFields);
		$("#attachmentFile_upload_"+uploadFileRowIndex).next().show();
	} else if("image"==uploadFileType){
		var imageList = extendFields.imageList;
		if("undefined"==typeof(imageList)){
			imageList = [];
		}
		imageList.push({fileType: "image",fileName:fileName,filePath:filePath});
		extendFields["imageList"]=imageList;
		itemRow["extendFields"]= JSON.stringify(extendFields);
		$("#attachmentImage_upload_"+uploadFileRowIndex).prev().show();
		$("#attachmentImage_upload_"+uploadFileRowIndex).next().show();
	} else{}
	
	clearAddFileInfo();
});
//添加文件弹出框取消按钮
$("#addFileBtnCancel").click(function(){
	$("#addFileDialog1").hide();
	clearAddFileInfo();
});

//关闭按钮处理
$("#dialogFileClose").click(function(){
	$("#addFileDialog1").hide();
	clearAddFileInfo();
});

function uploadFile(){
	clearAddFileInfo();
	$("#addFileDialog1").show();
	initFileUploader1(fileUploader1);
}

function downloadFile(type,rowIndex){
	var materialRow = biddingDetailContentGrid.row(rowIndex);
	var filePathArrStr = '';
	if("file"==type){
		var extendFields = materialRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var fileList = extendFields.fileList;
			if("undefined"!=typeof(fileList) && fileList.length > 0){
				for(var i=0;i<fileList.length;i++){
					filePathArrStr += (','+fileList[i].filePath);
				}
			} 
		}
	} else if("image"==type){
		var extendFields = materialRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var imageList = extendFields.imageList;
			if("undefined"!=typeof(imageList) && imageList.length > 0){
				for(var i=0;i<imageList.length;i++){
					filePathArrStr += (','+imageList[i].filePath);
				}
			}
		}
	} else{}
	convertToZipFileDown(filePathArrStr);
}

function clearAddFileInfo(){
	$("#fileName1").val("");
	$("#filePath1").val("");
	$("#fileType1").val("");
}

function initFileUploader1(fileUploader1){
//新增表单文件
	if (!fileUploader1) {
	  	fileUploader1 = WebUploader.create({
	  	    swf : "${pageContext.request.contextPath}/jsLib/webuploader/Uploader.swf",// swf文件路径
	  	    auto : true,//是否选择文件后自动上传
	  	    server : "${pageContext.request.contextPath}/servlet/UploadServlet",// 文件接收服务端。
	  	    pick : "#btnFileUpload1",//选择文件的按钮,可选.内部根据当前运行时创建,可能是input元素,也可能是flash/
	  	    resize : false,// 不压缩image,默认如果是jpeg,文件上传前会压缩再上传.
	  	    formData : {
		     	elsAccount : elsAccount
		    }
	  	});
		
	 	// 当有文件添加进来的时候
		fileUploader1.on("fileQueued",function(file){
			var fileName = file.name;
			$("#fileName1").val(fileName);
			$("#fileType1").val(file.ext);
		});
	 	//上传到服务器响应后触发
		fileUploader1.on("uploadAccept", function( obj, response ) {
			var errorNumber = response.error;
			if(errorNumber == 0){
				var filePath = response.url;
				$("#filePath1").val(filePath);
			} else {
	   			var errorMessage = response.message;
	   			alert(errorMessage,3);
			}
		  	});
		//上传出错时触发
		fileUploader1.on( "uploadError", function( obj, reason  ) {
		  	   	var errorMessage = response.message;
		  	        alert(reason,3); 
	  	});
	}
}
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//---------------------从物料提取开始------------------------//
var colsQueryMaterial = [
         	    { title:'<i18n:I18n key="" defaultValue="物料编码"/>', name:'materialNumber' , width:140, align:'center'},
         	    { title:'<i18n:I18n key="" defaultValue="物料描述"/>', name:'materialDesc' , width:180, align:'center'},
         	    { title:'<i18n:I18n key="" defaultValue="物料组"/>', name:'materialGroup' , width:140, align:'center'}
         	     ];	
$("#btnFromMaterial").click(function() {
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
	   event.preventDefault();
	   event.stopPropagation();
	} else {
	   window.event.returnValue = false;
	}
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
	rightScroll.resize();
	leftScroll.resize();
});
//关闭窗口
$("#btnSelectMaterialDialogClose").click(function(){
	$("#selectMaterialDialog").hide();
	rightScroll.resize();
	leftScroll.resize();
});

//查询
$("#queryMaterial").click(function(){
	var paramObj = $("#selectMaterialForm").serializeJSON();
	paramObj["elsAccount"]=elsAccount;
	$.extend(queryMaterialTable.opts.params,paramObj);
	queryMaterialTable.load();
});

function getMaxContentItemNum() {
	var rowsMy = biddingDetailContentGrid.rows();
	var maxContentItemNumber = 0;
	for(var i=0;i<rowsMy.length;i++){
		if(typeof(rowsMy[i]) != "undefined" && rowsMy[i] != null){
			var biddingContentItemNumber = rowsMy[i].biddingContentItemNumber;
			if(biddingContentItemNumber != null && typeof(biddingContentItemNumber) != "undefined" && biddingContentItemNumber>maxContentItemNumber){
				maxContentItemNumber = biddingContentItemNumber;
			}
		}
	}
	return parseInt(maxContentItemNumber)+1;
}

/**
* 确认选择物料
*/
$("#btnQueryMaterialOK").click(function(){
	$("#selectMaterialDialog").hide();
	var selectRows = queryMaterialTable.selectedRows();
	var purchaseGroup = $("#purchaseGroup").val();
	var items = $("#form").serializeJSON().biddingContentItem;
	for(var i = 0 ; i < selectRows.length ; i ++){
		var row = selectRows[i];
		if(items && items != ""){//物料去重
			var isContinue = false;
			for(var j = 0 ; j < items.length ; j++){
				var item = items[j];
				if(row.materialNumber == item.materialNumber){
					isContinue = true;
				}
			}
			if(isContinue){
				continue;
			}
		}
		
		var item = {};
		var curMaxContentItemNO= getMaxContentItemNum();
		item['biddingItemNumber']="0";
		item['biddingContentItemNumber']=curMaxContentItemNO;
		item['materialNumber']=row.materialNumber;
		item['materialDesc']=row.materialDesc;
		item['materialModel']="";
		item["materialSpecification"]="";
		item["units"]="";
		item['quantity']=0.0;
		item['fbk2']="";
		item['fbk3']="";
		item['deliveryDate']=new Date().format('yyyy-MM-dd');
		item["remark"]="";
		item["fbk10"]=$("#currency option:selected").text();
		biddingDetailContentGrid.addRow(item);
	}
});
//---------------------从物料提取结束------------------------//

/** -----------===============Excel导入导出、评标导入、需求计划提取（结束）===============----------- */

/* ====================================招标内容END================================================= */

/* ====================================表单文件  start ============================================= */
	var editFileTable;
	var editFormTable;
	var fileUploader;

	var file_cols = [
	{ title:'标段', name:'biddingItemNumber' , width:60, align:'center',renderer:function(val){
		return val+"<input name='biddingFile[][biddingItemNumber]' type='text' style='display:none;'  value='"+val+"'/>";
	}},
	{ title:'标段名称', name:'biddingItemName' , width:60, align:'center',renderer:function(val){
		return val+"<input name='biddingFile[][biddingItemName]' type='text' style='display:none;'  value='"+val+"'/>";
	}},
	{ title:'轮次', name:'roundNumber', width:60, align:'center',renderer:function(val){
		return val+"<input name='biddingFile[][roundNumber]' type='text' style='display:none;'  value='"+val+"'/>";
	}},
	{ title:'文件类别', name:'fileClass', width:100, align:'center',renderer:function(val){
		if("undefined"==typeof(val)){
			val = "";
		}
		var typeName = "";
		if("1"==val){
			typeName="招标文件";
		} else if("2"==val){
			typeName="报名文件";
		} else if("3"==val){
			typeName="投标文件";
		} else if("4"==val){ 
			typeName="澄清答疑文件";
		} else if("5"==val){ 
			typeName="评标文件";
		} else if("6"==val){ 
			typeName="保证金文件";
		}
		return typeName+"<input name='biddingFile[][fileClass]' style='display:none;' type='text'  value='"+val+"'/>";
	}},
	{ title:'文件名称', name:'fileName' , width:100, align:'center',renderer:function(val){
		return "<input name='biddingFile[][fileName]' type='text'  value='"+val+"'/>";
	}},
	{ title:'文件类型', name:'fileType', width:100, align:'center',renderer:function(val){
		return val+"<input name='biddingFile[][fileType]' type='text' style='display:none;' value='"+val+"'/>";
	}},
	{ title:'文件所属方', name:'fileOwner', width:60,hidden:true ,align:'center',renderer:function(val){
		return val+"<input name='biddingFile[][fileOwner]' type='text' style='display:none;'  value='"+val+"'/>";
	}},
	{ title:'文件大小', name:'fileSize', width:100, align:'center',renderer:function(val){
		if("undefined"==typeof(val)||val==null){
			val = 0;
		}
		return val+"<input name='biddingFile[][fileSize]' type='text' style='display:none;'  value='"+val+"'/>";
	}},
	{ title:'备注', name:'remark', width:100, align:'center',renderer:function(val){
		return "<input name='biddingFile[][remark]' type='text'  value='"+val+"'/>";
	}},
	{ title:'文件路径', name:'filePath', width:100, align:'center',hidden:true,renderer:function(val){
		return "<input name='biddingFile[][filePath]' type='text' value='"+val+"'/>";
	}},
	{ title:'所属文件类型', name:'fbk5', width:100, align:'center',hidden:true,renderer:function(val){
		return "<input name='biddingFile[][fbk5]' type='text' readonly value='"+val+"'/>";
	}}
	];
var localRoundNumber;
//轮次改变事件
$("#fileRoundNumber").change(function(){
var itemNumber = $("#fileBiddingItemNumber").val();
var fileRoundNumber = $("#fileRoundNumber").val();
$("#add-file-project").find("tr").each(function(){
	var biddingItemNumber = $(this).find("input[name='biddingFile[][biddingItemNumber]']").val();
	var roundNumber = $(this).find("input[name='biddingFile[][roundNumber]']").val();
	if(itemNumber != biddingItemNumber || fileRoundNumber != roundNumber){
		$(this).attr("hidden",true);
	}else{
		$(this).attr("hidden",false);
	}
});
});
//点击文件选项卡
$('.add-file-sheet').click(function() {
//set轮次
var fileBiddingItemNumber = "0";
if(!totalRoundArr || totalRoundArr.length ==0){
	alert("招标计划-表格不能为空！请输入必填项",2);
}else{
	var flag = false;
	var tempRound;
	for(var i=0;i<totalRoundArr.length;i++){
		if(totalRoundArr[i].itemNumber == fileBiddingItemNumber){
			tempRound = totalRoundArr[i];
			flag = true;
		}
	}
	if(flag == false){
		alert("招标计划-表格不能为空！请输入必填项",2);
		return;
	}else{
		var setFileRoundNumber= $("#fileRoundNumber");
		 var totalRound = tempRound.totalRound;
		 if(totalRound>0){
			 setFileRoundNumber.empty();
			 for(var i=1;i<=totalRound;i++){
				 setFileRoundNumber.append("<option value='"+i+"'>"+i+"</option>");
			 }
		 }else {
			 setFileRoundNumber.empty();
			 setFileRoundNumber.append("<option value='0'>不区分轮次</option>");
		 }
	}
}
if(editFileTable){
	return;
}
localRoundNumber = setFileRoundNumber.length;
if(!editFileTable) {
	editFileTable=$('#add-file-project').mmGrid({
	    cols: file_cols,
	    height:650,
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol:true,
        multiSelect:true,
        items: []
	});
	editFileTable.resize();
}
});

// 点击-->回签表单 赋值标段和轮次	
$('.add-form-sheet').click(function() {
//set轮次
if(!totalRoundArr || totalRoundArr.length ==0){
	alert("招标计划-表格不能为空！请输入必填项",2);
}else{
	var flag = false;
	var tempRound;
	for(var i=0;i<totalRoundArr.length;i++){
		if(totalRoundArr[i].itemNumber == "0"){
			tempRound = totalRoundArr[i];
			flag = true;
		}
	}
	if(flag == false){
		alert("招标计划-表格不能为空！请输入必填项",2);
		return;
	}else{
		var setFileRoundNumber= $("#fileRoundNumber1");
		 var totalRound = tempRound.totalRound;
		 if(totalRound>0){
			 setFileRoundNumber.empty();
			 for(var i=1;i<=totalRound;i++){
				 setFileRoundNumber.append("<option value='"+i+"'>"+i+"</option>");
			 }
		 }else {
			 setFileRoundNumber.empty();
			 setFileRoundNumber.append("<option value='0'>不区分轮次</option>");
		 }
	}
}
if(editFormTable){
	return;
}
localRoundNumber = setFileRoundNumber.length;
if(!editFormTable) {
	editFormTable=$('#sign-form-project').mmGrid({
	    cols: file_cols,
	    height:650,
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol:true,
        multiSelect:true,
        items: []
	});
	editFormTable.resize();
}
});

function initFileUploader(fileUploader){
   if(!fileUploader){
    //新增表单文件
  	fileUploader = WebUploader.create({
  	    // swf文件路径
  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
  	  	duplicate :true,
  	    auto: true,
  	    // 文件接收服务端。
  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
  	    // 选择文件的按钮。可选。
  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
  	    pick: '#btnFileUpload',
  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
  	    resize: false
  	 });
  	fileUploader.on( 'uploadAccept', function( obj, response ) {
  	  	if(0 == response.error){
  	   	   var filePath = response.url;
  	   		$("#filePath").val(filePath);
  	   	    $("#fileName").val(response.name);
  	   	    $("#fileSize").val(response.size);
  	  	}else{
  	  		alert(response.message,2);
  	  	}
  	});
  }
}

function initFileUploader2(fileUploader1){
   if(!fileUploader1){
    //新增表单文件
  	fileUploader1 = WebUploader.create({
  	    // swf文件路径
  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
  	  	duplicate :true,
  	    auto: true,
  	    // 文件接收服务端。
  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
  	    // 选择文件的按钮。可选。
  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
  	    pick: '#btnFormUpload',
  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
  	    resize: false
  	 });
  	fileUploader1.on( 'uploadAccept', function( obj, response ) {
  	  	if(0 == response.error){
  	   	   var filePath = response.url;
  	   		$("#filePath1").val(filePath);
  	   	    $("#fileName1").val(response.name);
  	   	    $("#fileSize1").val(response.size);
  	  	}else{
  	  		alert(response.message,2);
  	  	}
  	});
  }
}

//在文件列表添加新添加的文件列
function addFileItem(){
	var filePath=$("#filePath").val();
	var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
	var fileName=$("#fileName").val();
	var fileClass=$("#fileClass").val();
	var fileQ=$("#fileQ").val();
	var fileBiddingItemNumber = $("#fileBiddingItemNumber");
	if(fileQ){
		fileBiddingItemNumber = $("#qualificationBiddingItemNumber");
	}
	var fileBiddingItemName = fileBiddingItemNumber.find("option:selected").text();
	var fileRoundNumber = $("#fileRoundNumber").val();
	var fileSize = $("#fileSize").val();
	if(fileSize==null||fileSize==""){
		fileSize=0;
	}
	var fileBlackItem={biddingItemNumber:fileBiddingItemNumber.val(),biddingItemName:fileBiddingItemName,roundNumber:fileRoundNumber,fileName:fileName,fileClass:fileClass,fileType:fileType,filePath:filePath,fileOwner:"0",fileSize:fileSize,remark:"",fbk5:"0"};
	editFileTable.addRow(fileBlackItem);
	$('#addFileDialog').hide();
}

//在文件列表添加新添加的文件列
function addFormItem(){
	var filePath=$("#filePath1").val();
	var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
	var fileName=$("#fileName1").val();
	var fileClass=$("#fileClass1").val();
	var fileQ=$("#fileQ1").val();
	var fileBiddingItemNumber = "0";
	if(fileQ){
		fileBiddingItemNumber = $("#qualificationBiddingItemNumber");
	}
	var fileBiddingItemName = fileBiddingItemNumber.find("option:selected").text();
	var fileRoundNumber = $("#fileRoundNumber1").val();
	var fileSize = $("#fileSize1").val();
	if(fileSize==null||fileSize==""){
		fileSize=0;
	}
	var fileBlackItem={biddingItemNumber:"0",biddingItemName:fileBiddingItemName,roundNumber:fileRoundNumber,fileName:fileName,fileClass:fileClass,fileType:fileType,filePath:filePath,fileOwner:"0",fileSize:fileSize,remark:"",fbk5:"1"};
	editFormTable.addRow(fileBlackItem);
	$('#addFileDialog1').hide();
}

//显示上传弹框
$("#uploadFile").click(function(){
	 initFileUploader(fileUploader);
	 $('#addFileDialog').show();
});

$("#qualificationUploadFile").click(function(){
	 initFileUploader(fileUploader);
	 $("#fileClass").val("2");
	 $("#fileQ").val("1");
	 $("#fileClass").attr("disabled",true);
	 $('#addFileDialog').show();
});

//关闭上传弹框
$("#btnFileCancel ,.dialog-close-btn").click(function(){
	 $('#addFileDialog').hide();
});

//显示上传弹框
$("#btnFileOK").click(function(){
	addFileItem();
});

//文件下载
$("#downloadFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
	    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
 });

//回签文件-->显示上传弹框
$("#uploadForm").click(function(){
	 initFileUploader2(fileUploader1);
	 $('#addFileDialog1').show();
});

//回签文件-->关闭上传弹框
$("#btnFormCancel ,.dialog-close-btn").click(function(){
	 $('#addFileDialog1').hide();
});
//回签文件-->显示上传弹框
$("#btnFormOK").click(function(){
	addFormItem();
});
//回签文件-->文件下载
$("#downloadFile").click(function(){
	var selectRows = editFormTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
	    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
 });
 
//回签文件-->在线预览
$("#lookForm").click(function(){
	var selectRows = editFormTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
		previewFile(filePath);
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
});
 
//在线预览
$("#lookForm").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
		previewFile(filePath);
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
});
//在线预览文件
function previewFile(filePath){
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
					alert(message,3); 
				}
			},
			error : function(data) {
				alert(data.message,3); 
			}
		});
	} else {
		alert("<i18n:I18n defaultValue='不支持在线预览的文档类型' key='i18n_alert_filetypenotsupport'/>!",3);
	}
}
/* 表单文件   end */

//----------------------投标方开始-----------------------------------------
	var initFriendTag = false
	
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
			                     if(val=="1"){
			                    	 return "已中标";
			                     }else if(val=="2"){
			                    	 return "拒绝";
			                     }else {
			                    	 return "未中标";
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
		formObj["biddingSupplierVO"]={
			multiSection:"0",
			biddingItemNumber:"0"
		};	
		return formObj.biddingSupplierVO;
	}
	
	function storeSupplierToCache(){//存储供应商到缓存
		
		var biddingSupplierVO = getBasicBiddingSupplierVO();
		clearSupplierFromCache();
		var vos = getSelectedSupplier();//获取选择的供应商对象
		
		for (var i = 0; i < vos.length; i++) {//给选择的供应商拼凑是否区分标段与标段值
			vos[i].multiSection = "0";
			vos[i].biddingItemNumber = "0";
			vos[i]['supplierAccount'] = vos[i].friendElsAccount;
			vos[i]['supplierDesc'] = vos[i].friendCompanyName;
			biddingSupplierVOs.push(vos[i]);
		}
	}
	
	function getSupplierFromCash(biddingItemNumber){
		if(!biddingItemNumber){
			var biddingSupplierVO = getBasicBiddingSupplierVO();
		}
		var vos = [];
		for (var i = 0; i < biddingSupplierVOs.length; i++) {
			if(biddingSupplierVOs[i].biddingItemNumber=="0"){				
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
		var vos = [];
		for (var i = 0; i < biddingSupplierVOs.length; i++) {
			if(biddingSupplierVOs[i].biddingItemNumber!="0"){
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
    
    if(!biddingSupplierListTable){
        biddingSupplierListTable = $('#supplier_list_table').mmGrid({
    	    cols: supplierListTableCols,
    	    items:getSupplierFromCash(0),
    	    height: 240,
    	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
    	});
    }else{
    	var vos=getSupplierFromCash(0);
    	biddingSupplierListTable.load(vos)
    }
    biddingSupplierListTable.on("loadSuccess",function(e, data) {
    	var suppliersRecords = biddingSupplierListTable.rows();
    	if(suppliersRecords != [] && typeof(suppliersRecords[0]) != "undefined"){
	    	for(var i=0;i<suppliersRecords.length;i++){
	    		var participate_ = suppliersRecords[i].participate;
	    		if(participate_ == 2){
	    			$("#supplier_list_table tr:eq("+i+")").css("background-color", "#F5A89A");
	    		}
	    	}    		
    	}
    });
	$("#supplier_distinguishPhases").html(""); 
	$("#supplier_section_list").html(""); 
	$("input[name='biddingSupplierVO[multiSection]']").eq(0).attr("checked",'checked');
    initFriendTag=true;
};

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
    	//rightScroll.resize();
   } else if(oldObj && oldObj.dir=='right') {
	       	$('.box-left').find('.contact-people').eq(oldObj.index).show();
	    	$('.box-right').find('.contact-people').eq(oldObj.index).hide();
	    	//清空临时存储的数据
	    	$('body').data('cachePeople','');
	    	//leftScroll.resize();
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
			//leftScroll.resize();
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
			//rightScroll.resize();
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
	//rightScroll.resize();
	
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
	//leftScroll.resize();
	
	storeSupplierToCache();
});

//TODO:保存/发布招投标信息-----begin------------
$("#save").click(function(){
	var url="<%=basePath%>rest/PurchaseBiddingService/saveBiddingTemplate";
	var biddingNumber = $("#biddingNumber").val();
	var message1="确认是否保存？";
	var message2="保存中";
	operation(url,message1,message2);
});
//保存招投标信息-----end--------------

//日期和时间组装为标准时间
function toDateAndTime(date,time){
	var arrDate = date.split("-");
	var arrTime = time.split(":");
	return new Date(arrDate[0],arrDate[1]-1,arrDate[2],arrTime[0],arrTime[1],arrTime[2]);
}
function toDate(date){
	var arrDate = date.split("-");
	return new Date(arrDate[0],arrDate[1]-1,arrDate[2]);
}

function operation(url,message1,message2){
	var formObj = $("#form").serializeJSON();
	var currDate = new Date().format("yyyy-MM-dd");
	var currTime = new Date().format("hh:mm:ss");
	
	//----组装基本信息------begin---------
	var biddingNumber = $("#biddingNumber").val();
	var sendResultInfo = $("#sendResultInfo").val();
	formObj["fbk1"]=sendResultInfo;
	var fbk6 = $('input[name="fbk6"]:checked').val(); //目标价是否发给投标方
	formObj["fbk6"]=fbk6;
	var publish = $("#isPublishInfo").is(':checked');//是否发布到企业控件
	formObj["publish"]=publish?1:0;
	formObj["biddingType"]=7;//招标模板-邀请
	var biddingStatus = $("#biddingStatus").val();//招标状态
	formObj["biddingStatus"]=biddingStatus;
	var budgetAmount = $("#budgetAmount").val();//预算金额
	formObj["budgetAmount"]=budgetAmount.replace(/,/g,"");
	var beginDate = $("body").data("header_beginDate");//开始日期
	formObj["beginDate"]=beginDate;
	var endDate = $("body").data("header_endDate");//结束日期
	formObj["endDate"]=endDate;
	var totalRound = $("body").data("header_totalRound");//总轮次
	formObj["totalRound"]=totalRound;
	formObj["currentRound"]=1;//设置当前为第一轮
	//----组装基本信息------end------------
	
	//----组装基本信息------begin---------
	var secret = $('input[name="biddingRoundsVO[secret]"]:checked').val();//开标前是否保密
	if(!$.isArray(biddingItemArray)){
		biddingItemArray= new Array(0);
		var biddingPhasesItems = {};
		biddingPhasesItems["biddingItemNumber"] = "0";
		biddingPhasesItems["biddingItemName"] = "不区分标段";
		biddingPhasesItems["remark"] = "";
		biddingPhasesItems["secret"] = secret;
		biddingItemArray.push(biddingPhasesItems);
	}
	if(biddingItemArray != "") {
		formObj["biddingPhasesItems"] = biddingItemArray;
	}
	
	//----组装基本信息------end------------
	
	//----组装招标计划------begin-------------
	var biddingRoundsVO = formObj.biddingRoundsVO;
	biddingRoundsVO["biddingItemNumber"] = "0";
	biddingRoundsVO["multiSection"] = "0";
	biddingRoundsVO["secret"] = secret;
	var roundItms = formObj.biddingRoundItms;//获取轮次列表
	roundItms = typeof(roundItms)=="undefined" ? [] : roundItms;
	var biddingRoundsVOs = [];
	for(var i = 0 ; i < roundItms.length ; i ++){
		var item = roundItms[i];
		item = extend(item,biddingRoundsVO);
		biddingRoundsVOs.push(item);
	}
	formObj["biddingRoundItms"]=biddingRoundsVOs;
	//----组装招标计划------end-------------
	
	//----组织保证金-------begin------------
	var collect = $('input[name="biddingMarginVO[collect]"]:checked').val();//是否收取保证金
	var back = $('input[name="biddingMarginVO[back]"]:checked').val();//是否退还保证金
	var amount = $("#margin_amount").val();
	var biddingMarginVO = formObj.biddingMarginVO;
	biddingMarginVO = typeof(biddingMarginVO)=="undefined" ? [] : biddingMarginVO;
	biddingMarginVO["biddingItemNumber"] = "0";
	biddingMarginVO["multiSection"] = "0";
	biddingMarginVO["back"] = back;
	biddingMarginVO["collect"] = collect;
	biddingMarginVO["amount"] = amount.replace(/,/g,"");
	var biddingMarginVOs = [];
	biddingMarginVOs.push(biddingMarginVO);
	formObj["biddingMarginVOs"]=biddingMarginVOs;
	//----组织保证金-------end------------
	
	//招标内容------begin------
	if(!$.isArray(biddingContentItemStandardArray)){
 		biddingContentItemStandardArray= new Array(0);
	 }
	formObj["biddingContent"]["biddingItemNumber"]="0";
	formObj["biddingContent"]["fbk1"] = $("input[name='controlBidding']:checked").val();//0：必须全部投标、1：可以部分投标
	var records = typeof(biddingDetailContentGrid)=="undefined" ? "" : biddingDetailContentGrid.rows();
	if(records!="") {
		for(var i=0;i<records.length;i++){
			formObj["biddingContentItem"][i]["extendFields"] = records[i].extendFields;
		}
	}
	var biddingContent = formObj.biddingContent;
	biddingContent = typeof(biddingContent)=="undefined" ? [] : biddingContent;
	
	biddingContent["biddingContentItem"]=typeof(formObj.biddingContentItem)=="undefined"?[]:formObj.biddingContentItem;
	biddingContent["biddingContentStandard"]=typeof(formObj.biddingContentStandard)=="undefined"?[]:formObj.biddingContentStandard;
	biddingContentItemStandardArray[0]= biddingContent;
	formObj["biddingContentVOs"]=biddingContentItemStandardArray;
	//招标内容 ------end------
	
	//表单文件  ------begin------
	formObj["biddingFileVOs"]=typeof(formObj.biddingFile)!="undefined"?formObj.biddingFile:[];
	//表单文件 ------end------
	
	//保存投标方信息
	var tempSuppliers = formObj.biddingSupplierVOs;
	tempSuppliers = typeof(tempSuppliers)=="undefined" ? [] : tempSuppliers;
	if(tempSuppliers && typeof(tempSuppliers) != "undefined" && tempSuppliers.length > 0){
		for(var i=0;i<tempSuppliers.length;i++){
			tempSuppliers[i]["biddingItemNumber"]="0";
		}
		biddingSupplierArrays[0]=tempSuppliers;
	}
	
	var biddingSupplierVOs = getBiddingSupplierVOs();
	if(biddingSupplierVOs && biddingSupplierVOs.length > 0){
		for(var i=0;i<biddingSupplierVOs.length;i++){
			var tempSuppliers = biddingSupplierArrays[0];
			if(tempSuppliers && tempSuppliers.length>0){
				for(var j=0;j<tempSuppliers.length;j++){
					if(biddingSupplierVOs[i].supplierAccount==tempSuppliers[j].supplierAccount){
						biddingSupplierVOs[i]["register"]=tempSuppliers[j].register;
						biddingSupplierVOs[i]["qualify"]=tempSuppliers[j].qualify;
						biddingSupplierVOs[i]["guaranty"]=tempSuppliers[j].guaranty;
						biddingSupplierVOs[i]["getDoc"]=tempSuppliers[j].getDoc;
					}
				}
			}
		}
	}
	formObj["biddingSupplierVOs"]=biddingSupplierVOs;
	parent.elsDeskTop.tip.init({type: 'confirm',message: message1,closeEvent:function(){
		parent.elsDeskTop.showLoading(message2);
		$.ajax({
			url :url,
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(formObj),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				var biddingNumber = data.biddingNumber;
				$("#biddingNumber").val(biddingNumber);
				var biddingStatus = data.biddingStatus;
				alert("操作成功！",1);
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("操作失败:"+exception,3); 
	        }
		});
	}});
}
</script>
</body>
</html>