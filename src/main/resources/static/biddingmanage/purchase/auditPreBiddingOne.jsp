<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="auditPreBiddingMain.jsp"%>
<body>

<script type="text/javascript">

//TODO:基本信息-------begin-----------------------
var phasesTableCols = [
                       { title:'<i18n:I18n key="" defaultValue="标段编号" />', name:'biddingItemNumber' ,width:80, align:'center',renderer:function(val){
		                     return val+"<input  name='biddingPhasesItems[][biddingItemNumber]' style='display:none;'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="标段名称" />', name:'biddingItemName' ,width:200, align:'center',renderer:function(val,item,rowIndex){
                    		var itemNumber = rowIndex + 1;
                    	    if(val == ""){
                    			val = "标段" + itemNumber; 
                   	       	}
	           				return "<input name='biddingPhasesItems[][biddingItemName]'   type='text' value='"+val+"'/>";
        			       }},
        			   { title:'<i18n:I18n key="" defaultValue="标段备注说明" />', name:'remark' ,width:200, align:'center',renderer:function(val){
	           				  return "<input name='biddingPhasesItems[][remark]'   type='text' value='"+val+"'/>";
      			       }}
                 ];

//标段划分下拉改变事件
$("#biddingPhases").change(function(){
	var val = $(this).val();
	if(val != "1"){
		var items = [];
		for(var i = 1 ; i <= parseInt(val) ; i ++){
			var item = {"biddingItemNumber":i,"biddingItemName":"","remark":""};
			items.push(item);
		}
		if(!phasesTable){
			phasesTable=$('#phases-table').mmGrid({
			    cols: phasesTableCols,
			    items:items,
			    height: 140,
			    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
			});
		}else{
			phasesTable.load(items);
		}
	}else{
		$("#reCreate").html('<table id="phases-table"></table>');
		phasesTable = null;
	}
});

//招标类型下拉改变事件
$("#biddingType").change(function(){
	var val = $(this).val();
	if(val == "1" || val == "3" || val == "5" || val == "6"){//公开招标
		$("input[name='biddingClass']").eq(0).attr("checked",'checked');
	    $("#isPublishInfo").attr("checked","checked");
	    $("#isPublishInfo").attr("disabled",true);
	}else{//邀请招标
		$("input[name='biddingClass']").eq(1).attr("checked",'checked');
		$("#isPublishInfo").attr("checked","checked");
	    $("#isPublishInfo").attr("disabled",false);
	}
});
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
                    	   return showText+"<input name='biddingRoundItms[][biddingItemNumber]' style='display:none;'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="轮次" />', name:'roundsNumber' ,width:100, align:'center',renderer:function(val){
  		                     return val+"<input name='biddingRoundItms[][roundsNumber]' style='display:none;'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="状态" />', name:'biddingStatus' ,width:100, align:'center',renderer:function(val){
                    	   var showText;  
                    	   if(val == 0){
                    		     showText="未开始";
                    	     }else if(val == 1){
                    	    	 showText="投标进行中";
                    	     }else if(val == 2){
                    	    	 showText="开标评标中";
                    	     }else if(val == 3){
                    	    	 showText="本轮结束";
                    	     }else{
                    	    	 showText="未开标";
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
	           				  return "<input name='biddingRoundItms[][fbk5]' "+(val=="1"?" checked='checked'":"")+" type='checkbox' value='"+val+"'/>";        					   
        				   }
      			       }},
        			   { title:'<i18n:I18n key="" defaultValue="低靠百分比" />', name:'fbk6' ,width:100, align:'center',renderer:function(val,item,rowIndex){
        				   if(!val){val = "";}
        				   if(rowIndex==0){return "";}else{
 	           				  return "<input name='biddingRoundItms[][fbk6]' type='text' value='"+val+"'/>";        					   
         				   }
      			       }},
        			   { title:'<i18n:I18n key="" defaultValue="发送排名" />', name:'fbk7' ,width:100, align:'center',renderer:function(val,item,rowIndex){
        				   if(!val){val="0";}
        				   if(rowIndex==0){return "";}else{
 	           				  return "<input name='biddingRoundItms[][fbk7]' "+(val=="1"?" checked='checked'":"")+" type='checkbox' value='"+val+"'/>";        					   
         				   }
      			       }},
        			   { title:'<i18n:I18n key="" defaultValue="人工干预" />', name:'fbk8' ,width:100, align:'center',renderer:function(val,item,rowIndex){
        				   if(!val){val="0";}
        				   if(rowIndex==0){return "";}else{
 	           				  return "<input name='biddingRoundItms[][fbk8]' "+(val=="1"?" checked='checked'":"")+" type='checkbox' value='"+val+"'/>";        					   
         				   }
      			       }}
                 ];

//普在线竞标
var phasesRoundOnlineCols = [
                       { title:'<i18n:I18n key="" defaultValue="是否在线竞标" />', name:'biddingType' ,width:100, align:'center',hidden:true, renderer:function(val){
                             return val+"<input name='biddingRoundItms[][biddingType]' style='display:none;'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="标段" />', name:'biddingItemNumber' ,width:100, align:'center',renderer:function(val){
                    	     var showText;  
                    	     if(val == 0){
                        	   var showText = "不区分标段"; 
                    	     }else{
                    	    	 showText = val;
                    	     }
		                     return showText+"<input name='biddingRoundItms[][biddingItemNumber]' style='display:none;'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="轮次" />', name:'roundsNumber' ,width:100, align:'center',renderer:function(val){
  		                     return val+"<input name='biddingRoundItms[][roundsNumber]' style='display:none;'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="状态" />', name:'biddingStatus' ,width:100, align:'center',renderer:function(val){
                    	   var showText;  
                    	   if(val == 0){
                    		     showText="未开始";
                    	     }else if(val == 1){
                    	    	 showText="进行中";
                    	     }else if(val == 2){
                    	    	 showText="已完成";
                    	     }else{
                    	    	 showText="";
                    	     }  
                    	   return showText+"<input name='biddingRoundItms[][biddingStatus]' style='display:none;'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="竞标开始日期" />', name:'biddingBeginDate' ,width:100, align:'center',renderer:function(val){
                    	   if(val&&val !=""){
                    		   val = new Date(val).format('yyyy-MM-dd');
                    	   }else{
                    		   val = "";
                    	   }  
                    	   return "<input name='biddingRoundItms[][biddingBeginDate]' class='Wdate' onfocus='WdatePicker({dateFmt:\"yyyy-MM-dd\"})'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="竞标开始时间" />', name:'biddingBeginTime' ,width:100, align:'center',renderer:function(val){
    		                     return "<input name='biddingRoundItms[][biddingBeginTime]' class='Wdate' onfocus='WdatePicker({dateFmt:\"HH:mm:00\"})'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="竞标结束日期" />', name:'biddingEndDate' ,width:100, align:'center',renderer:function(val){
                    	   if(val&&val !=""){
                    		   val = new Date(val).format('yyyy-MM-dd');
                    	   }else{
                    		   val = "";
                    	   }  
                    	   return "<input name='biddingRoundItms[][biddingEndDate]' class='Wdate' onfocus='WdatePicker({dateFmt:\"yyyy-MM-dd\"})'  type='text' value='"+val+"'/>";
                           }},
                       { title:'<i18n:I18n key="" defaultValue="竞标结束时间" />', name:'biddingEndTime' ,width:100, align:'center',renderer:function(val){
  		                     return "<input name='biddingRoundItms[][biddingEndTime]' class='Wdate' onfocus='WdatePicker({dateFmt:\"HH:mm:00\"})'  type='text' value='"+val+"'/>";
                           }},
                       {title:'采购限价',name:'initPrice', width: 120, align: 'center',renderer:function(val){
                    	   if(val==null) val=0;
                    	   if(!val){
	             				return "<span>"+val+"</span><input name='biddingRoundItms[][initPrice]' style='display:none;'  type='text' value='"+val+"'/>";
                    	   }else {
                    		   return "0"; 
                    	   }
             			   }},
             			{title:'降价幅度',name:'priceOff', width: 120, align: 'center',renderer:function(val){
             				if(val==null) val=0;
             				return "<input name='biddingRoundItms[][priceOff]'  onkeyup=\"value=value.replace(/[^(\\d\\.)]/g,'')\"  type='text' value='"+val+"'/>";
             			   }},
             			{title:'幅度单位',name:'unitsType', width: 120, align: 'center',renderer:function(val){
             				var sel = "<select name='biddingRoundItms[][unitsType]' ><option value='0' selected>元</option><option value='1'>%</option></select>"
             				return sel;
             			}}
                 ];
//单击招标计划tag事件                 
$(".edit-line-plan").click(function(){
	if(phasesRoundTable){//仅当第一次点击加载本tag页
		return;
	}
	var biddingType = $("#biddingType").val();//获得当前招投标类型
	var cols;
	if(biddingType == "2" || biddingType == "3"){ //在线竞标
		cols = phasesRoundOnlineCols;
	    $(".date-unit").html("分钟");
	    $(".isShow-isSecrecy").hide();
	}else{
		cols = phasesRoundCols;
		$(".date-unit").html("天");
	}
	
	if(biddingType == "1" || biddingType == "4" || biddingType == "5"){//公开招投标、暂定招标-邀请、暂定招标-公开 默认为保密
		$("input[name='biddingRoundsVO[secret]']").eq(0).attr("checked",'checked');
	}else if(biddingType == "0" || biddingType == "6"){//邀请招投标、竞争性谈判默认可查看
		$("input[name='biddingRoundsVO[secret]']").eq(1).attr("checked",'checked');
	}
	
	//初始化phasesRoundTable
	phasesRoundTable = $('#phases-round-table').mmGrid({
	    cols: cols,
	    height: 240,
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
	});
	
	var biddingPhases = $("#biddingPhases").val();
	if(biddingPhases == "1"){//不区分标段
		$("input[name='biddingRoundsVO[multiSection]']").eq(0).attr("checked",'checked');
		$("input[name='biddingRoundsVO[multiSection]']").attr("disabled",true);
	    $("#plan_distinguishPhases").attr("disabled",true);
	}else{//区分标段
		$("input[name='biddingRoundsVO[multiSection]']").eq(1).attr("checked",'checked');
		var items = $("#form").serializeJSON().biddingPhasesItems;
		for(var i = 0 ; i < items.length ; i ++){
			var item = items[i];
			var biddingItemName = item.biddingItemName;
			var biddingItemNumber = item.biddingItemNumber;
			var option = '<option value="'+biddingItemNumber+'">标段'+biddingItemNumber+" "+biddingItemName+'</option>';
			$("#plan_distinguishPhases").append(option);
		}
		$("#plan_distinguishPhases").val("1");//默认选择标段1
		$("body").data("plan_distinguishPhases","1");
		$("#plan_distinguishPhases option[value='0']").attr("disabled",true);
	}
	
});
//区分不区分标段，radio 单击事件
$("input[name='biddingRoundsVO[multiSection]']").click(function(){
	var val = $(this).val();
	if(val == "0"){ //不区分标段
		$("#plan_distinguishPhases").attr("disabled",true);
		$("#plan_distinguishPhases").val("0");//设置为不区分标段
	}else{
		$("#plan_distinguishPhases").attr("disabled",false);
		$("#plan_distinguishPhases").val("1");//设置为标段1
	}
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
		 budgetAmount= 0;
	 }
	 var phasesNumber = $("#plan_distinguishPhases").val();//标段编号
	 
	 if(biddingBeginDate == "" || biddingBeginTime == "" || eachRound == "" || roundInterval == "" || biddingRounds == ""){
		 if(typeof(phasesRoundTable) != "undefined"){
			 phasesRoundTable.removeRow(undefined);
		 }
		 return ;
	 }
	 var beginDate;
	 var endDate;
	 phasesRoundTable.removeRow(undefined);
	 var biddingType = $("#biddingType").val();//获得当前招投标类型
	 if(biddingType == "2" || biddingType == "3"){ //在线竞标
		 for(var i = 0 ; i < biddingRounds ; i ++){
			 if(!endDate){
				 beginDate = new Date(biddingBeginDate+" "+biddingBeginTime);
				 endDate=new Date();
				 endDate.setTime(beginDate.getTime()+1000*60*eachRound);
				 var item = {"biddingType":"0","biddingItemNumber":phasesNumber,"roundsNumber":i+1,"biddingStatus":"0","biddingBeginDate":biddingBeginDate,"biddingBeginTime":biddingBeginTime,"biddingEndDate":endDate.format('yyyy-MM-dd'),"biddingEndTime":endDate.format('hh:mm:ss'),"initPrice":budgetAmount,"priceOff":"","unitsType":""};
				 phasesRoundTable.addRow(item);
			 }else{
				 beginDate.setTime(endDate.getTime()+1000*60*roundInterval);
				 endDate.setTime(beginDate.getTime()+1000*60*eachRound);
				 var item = {"biddingType":"0","biddingItemNumber":phasesNumber,"roundsNumber":i+1,"biddingStatus":"0","biddingBeginDate":beginDate.format('yyyy-MM-dd'),"biddingBeginTime":beginDate.format('hh:mm:ss'),"biddingEndDate":endDate.format('yyyy-MM-dd'),"biddingEndTime":endDate.format('hh:mm:ss'),"initPrice":"0","priceOff":"","unitsType":""};
				 phasesRoundTable.addRow(item);
			 }
		 }
	 }else{//普通招投标
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
			 var item = {"biddingType":"1","biddingItemNumber":phasesNumber,"roundsNumber":i+1,"biddingStatus":"0","biddingBeginDate":beginDate.format('yyyy-MM-dd'),"biddingBeginTime":beginDate.format('hh:mm:ss'),"biddingEndDate":endDateVal.format('yyyy-MM-dd'),"biddingEndTime":endDateVal.format('hh:mm:ss'),"openDate":bidOpenDate.format('yyyy-MM-dd'),"openTime":bidOpenDate.format('hh:mm:ss'),"address":address};
			 phasesRoundTable.addRow(item);
		 }
	 }
	 if(phasesNumber == "0" || phasesNumber == "1"){//区分跟不区分标段时，设置第一标段/第零标段的起始时间为招投标头上的起始时间
    	 $("body").data("header_beginDate",biddingBeginDate);//开始日期
    	 $("body").data("header_endDate",endDate.format('yyyy-MM-dd'));//结束日期
    	 $("body").data("header_totalRound",biddingRounds);//总轮次
     }
	 $("input[name='biddingRoundsVO[multiSection]']").attr("disabled",true);
}
$("input[name='biddingRoundItms[][fbk5]']").live('change',function(){
	 if($(this).is(':checked')){
		 $(this).val("1");
	 }else{
		 $(this).val("0");
	 }
});
$("input[name='biddingRoundItms[][fbk7]']").live('change',function(){
	 if($(this).is(':checked')){
		 $(this).val("1");
	 }else{
		 $(this).val("0");
	 }
});
$("input[name='biddingRoundItms[][fbk8]']").live('change',function(){
	 if($(this).is(':checked')){
		 $(this).val("1");
	 }else{
		 $(this).val("0");
	 }
});
//------触发事件---------
$('.init-roundTable').live('blur',function() {
	 computeOperation();
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
////////////////////////////////////////////////////////////////////////
//保存招标计划中标段和总轮次的信息，公招标文件页使用
$("#totalRound").blur(function(){
	var plan_distinguishPhases = $("#plan_distinguishPhases").val();
	var totalRound = $("#totalRound").val();
	for(var i=0;i<totalRoundArr.length;i++){
		if(totalRoundArr[i].itemNumber == plan_distinguishPhases){
			totalRoundArr.splice(i,1);
		}
	}
	var data = {itemNumber:plan_distinguishPhases,totalRound:totalRound};
	totalRoundArr.push(data);
});
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//标段下拉改变事件
$("#plan_distinguishPhases").change(function(){
	if(biddingStatus != 0 && biddingStatus != 1){
		$("#phases-round-table :text").each(function(){
			$(this).attr("disabled",false);
		});
	}
	
	var formObj = $("#form").serializeJSON();
	var roundItem = formObj.biddingRoundItms;
	formObj["biddingRoundItms"] = phasesRoundTable.rows();
	if(typeof(roundItem) != "undefined" && roundItem != null){
		for(var i=0 ; i<roundItem.length ; i++){
			formObj["biddingRoundItms"][i]["biddingBeginDate"] = roundItem[i].biddingBeginDate;
			formObj["biddingRoundItms"][i]["biddingBeginTime"] = roundItem[i].biddingBeginTime;
			formObj["biddingRoundItms"][i]["biddingEndDate"] = roundItem[i].biddingEndDate;
			formObj["biddingRoundItms"][i]["biddingEndTime"] = roundItem[i].biddingEndTime;
			formObj["biddingRoundItms"][i]["openDate"] = roundItem[i].openDate;
			formObj["biddingRoundItms"][i]["openTime"] = roundItem[i].openTime;
			formObj["biddingRoundItms"][i]["address"] = roundItem[i].address;
		}
	}
	
	var multiSection = $('input[name="biddingRoundsVO[multiSection]"]:checked').val();//是否区分标段	
	var biddingItemNumber = $("body").data("plan_distinguishPhases");//获取标段---原标段	
	var currentBiddingItemNumber = $(this).val();//获取标段---将要切换成的标段
	var roundItms = formObj.biddingRoundItms;//获取轮次列表
	var biddingRoundsVO = formObj.biddingRoundsVO;
	biddingRoundsVO["biddingItemNumber"] = biddingItemNumber;
	biddingRoundsVO["multiSection"] = multiSection;
	if(!roundItms || roundItms.length == 0 || !roundItms[0]){
		alert("轮次不能为空！请输入必填项",2);
		$("#plan_distinguishPhases").val(biddingItemNumber);
		return;
	}
	
	var biddingRounds = $("body").data("biddingRounds");
	if(!biddingRounds){//不存在标段轮次信息
		biddingRounds = [];
		for(var i = 0 ; i < roundItms.length ; i ++){
			var item = roundItms[i];
			item = extend(item,biddingRoundsVO);
			biddingRounds.push(item);
		}
		clearRound();
	}else{
		//先循环已经存在的轮次信息，如果已经存在则移除
		for(var i = 0 ; i < biddingRounds.length ;){
			var _biddingItemNumber = biddingRounds[i].biddingItemNumber;
			if(_biddingItemNumber == biddingItemNumber){
				biddingRounds.splice(i,1);
				i = 0;
			}else{
				i++
			}
		}
		//添加轮次数据
		for(var i = 0 ; i < roundItms.length ; i ++){
			var item = roundItms[i];
			item = extend(item,biddingRoundsVO);
			biddingRounds.push(item);
		}
		//循环已经存在的标段轮次信息，查看是否将要切换到的那个标段是否已经有数据存在，如果有则加载出来
		var roundItems = [];
		for(var i = 0 ; i < biddingRounds.length ; i ++){
			var _biddingItemNumber = biddingRounds[i].biddingItemNumber;
			if(_biddingItemNumber == currentBiddingItemNumber){
				var roundItem = biddingRounds[i];
				roundItems.push(roundItem);
			}
		}
		if(roundItems.length > 0){
			$("#totalRound").val(roundItems[0].totalRound);//招标轮数
			$("#duration").val(roundItems[0].duration);//每轮持续
			$("#intervalType").val(roundItems[0].intervalType);//每轮间隔
			if(roundItems[0].beginDate != ""){
				$("#plan_beginDate").val(new Date(roundItems[0].beginDate).format('yyyy-MM-dd'));
			}
			$("#plan_beginTime").val(roundItems[0].beginTime);
			$("input[name='biddingRoundsVO[secret]']").eq(roundItems[0].secret).attr("checked",'checked');
			phasesRoundTable.load(roundItems);
		}else{
			clearRound();
		}
	}
	$("body").data("biddingRounds",biddingRounds);
	$("body").data("plan_distinguishPhases",$(this).val());//存入当前的标段
	
	if(biddingStatus != 0 && biddingStatus != 1){
		$("#phases-round-table :text").each(function(){
			$(this).attr("disabled",true);
		});
	}
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
	
	var biddingPhases = $("#biddingPhases").val();//标段划分
	if(biddingPhases == "1"){//不区分标段
		$("input[name='biddingMarginVO[multiSection]']").eq(0).attr("checked",'checked');
		$("input[name='biddingMarginVO[multiSection]']").attr("disabled",true);
	    $("#margin_distinguishPhases").attr("disabled",true);
	}else{
		$("input[name='biddingMarginVO[multiSection]']").eq(1).attr("checked",'checked');
		var items = $("#form").serializeJSON().biddingPhasesItems;
		for(var i = 0 ; i < items.length ; i ++){
			var item = items[i];
			var biddingItemName = item.biddingItemName;
			var biddingItemNumber = item.biddingItemNumber;
			var option = '<option value="'+biddingItemNumber+'">标段'+biddingItemNumber+" "+biddingItemName+'</option>';
			$("#margin_distinguishPhases").append(option);
		}
		$("#margin_distinguishPhases").val("1");//默认选择标段1
		$("body").data("margin_distinguishPhases","1");
		$("#margin_distinguishPhases option[value='0']").attr("disabled",true);
	}
	
});

//区分不区分标段，radio 单击事件
$("input[name='biddingMarginVO[multiSection]']").click(function(){
	var val = $(this).val();
	if(val == "0"){ //不区分标段
		$("#margin_distinguishPhases").attr("disabled",true);
		$("#margin_distinguishPhases").val("0");//设置为不区分标段
	}else{
		$("#margin_distinguishPhases").attr("disabled",false);
		$("#margin_distinguishPhases").val("1");//设置为标段1
	}
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

//保证金下拉改变事件
$("#margin_distinguishPhases").change(function(){
	
	var formObj = $("#form").serializeJSON();
	var collect = $(":input[name='biddingMarginVO[collect]']:checked").val();
	var back = $(":input[name='biddingMarginVO[back]']:checked").val();
	var margin_amount = $("#margin_amount").val();
	var currency = $("#margin_currencyType").val();
	var payBeginDate = $("#margin_payBeginDate").val();
	var payEndDate = $("#margin_payEndDate").val();
	var remark = $("#margin_remark").val();
	
	formObj["biddingMarginVO"]["collect"] = collect;
	formObj["biddingMarginVO"]["back"] = back;
	formObj["biddingMarginVO"]["amount"] = margin_amount;
	formObj["biddingMarginVO"]["currency"] = currency;
	formObj["biddingMarginVO"]["payBeginDate"] = payBeginDate;
	formObj["biddingMarginVO"]["payEndDate"] = payEndDate;
	formObj["biddingMarginVO"]["remark"] = remark;
		
	var multiSection = $('input[name="biddingMarginVO[multiSection]"]:checked').val();//是否区分标段	
	var biddingItemNumber = $("body").data("margin_distinguishPhases");//获取标段---原标段
	var currentBiddingItemNumber = $(this).val();//获取标段---将要切换成的标段
	var biddingMarginVO = formObj.biddingMarginVO;
	var amount = biddingMarginVO.amount;
	biddingMarginVO["amount"] = amount.replace(/,/g,"");
	biddingMarginVO["biddingItemNumber"] = biddingItemNumber;
	biddingMarginVO["multiSection"] = multiSection;
	
	var biddingMargins = $("body").data("biddingMargins");
	if(!biddingMargins){//不存在保证金信息
		biddingMargins = [];
		biddingMargins.push(biddingMarginVO);
		clearMargin();
		
	}else{
		//先循环已经存在的保证金信息，如果已经存在则移除
		for(var i = 0 ; i < biddingMargins.length ;){
			var _biddingItemNumber = biddingMargins[i].biddingItemNumber;
			if(_biddingItemNumber == biddingItemNumber){
				biddingMargins.splice(i,1);
				i = 0;
			}else{
				i++
			}
		}
		//添加轮次数据
		biddingMargins.push(biddingMarginVO);
		clearMargin();
		//循环已经存在的标段轮次信息，查看是否将要切换到的那个标段是否已经有数据存在，如果有则加载出来
		for(var i = 0 ; i < biddingMargins.length ; i ++){
			var _biddingItemNumber = biddingMargins[i].biddingItemNumber;
			if(_biddingItemNumber == currentBiddingItemNumber){
				var item = biddingMargins[i];
				
				if(item.collect == 1){
					$('input[name="biddingMarginVO[back]"]').attr("disabled",false);
					$("#margin_amount").attr("readonly",false);
					$("#margin_currencyType").attr("disabled",false);
					$("#margin_payBeginDate").attr("disabled",false);
					$("#margin_payEndDate").attr("disabled",false);
					$("#margin_remark").attr("readonly",false);
				}else{
					$('input[name="biddingMarginVO[back]"]').attr("disabled",true);
					$("#margin_amount").attr("readonly",true).val("");
					$("#margin_currencyType").attr("disabled",true).val("CNY");
					$("#margin_payBeginDate").attr("disabled",true).val("");
					$("#margin_payEndDate").attr("disabled",true).val("");
					$("#margin_remark").attr("readonly",true).val("");
				}
				
				$("input[name='biddingMarginVO[collect]']").eq(item.collect).attr("checked",'checked');
				$("input[name='biddingMarginVO[back]']").eq(item.back).attr("checked",'checked');
				$("#margin_amount").val(item.amount);
				$("#margin_currencyType").val(item.currencyType);
				if(item.payBeginDate != ""){
					$("#margin_payBeginDate").val(new Date(item.payBeginDate).format('yyyy-MM-dd'));
				}
				if(item.payEndDate != ""){
					$("#margin_payEndDate").val(new Date(item.payEndDate).format('yyyy-MM-dd'));
				}
				$("#margin_remark").val(item.remark);
				break;
			}
		}
	}
	$("body").data("biddingMargins",biddingMargins);
	$("body").data("margin_distinguishPhases",$(this).val());//存入当前的标段
	$("input[name='biddingMarginVO[multiSection]']").attr("disabled",true);
});
$('input[name="biddingMarginVO[collect]"]:eq(0)').click(function(){//不收取保证金
	alert(1);
	debugger;
	$('input[name="biddingMarginVO[back]"]').attr("disabled",true);
	$("#margin_amount").attr("readonly",true).val("");
	$("#margin_currencyType").attr("disabled",true).val("CNY");
	$("#margin_payBeginDate").attr("disabled",true).val("");
	$("#margin_payEndDate").attr("disabled",true).val("");
	$("#margin_remark").attr("readonly",true).val("");
});
$('input[name="biddingMarginVO[collect]"]:eq(1)').click(function(){//收取保证金
	alert(2);
	debugger;
	$('input[name="biddingMarginVO[back]"]').attr("disabled",false);
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
//TODO:保存/发布招投标信息-----begin------------
$("#save").click(function(){
	var url="<%=basePath%>rest/PurchaseBiddingService/saveBidding";
	var biddingNumber = $("#biddingNumber").val();
	if(biddingNumber == "null" || biddingNumber == ""){//招标编号为空
		if($("#biddingPhases").val()==1){
			var message1="确认是否保存？";
		}else{			
			var message1="确认是否保存？";
		}
	}else{		
		var message1="确认是否保存？";
	}
	var message2="保存中";
	operation(url,message1,message2,1);
});
$("#send").click(function(){
	var url="<%=basePath%>rest/PurchaseBiddingService/publishBidding";
	var message1="确认是否发布？";
	var message2="发布中";
	operation(url,message1,message2,2);
});
//保存招投标信息-----end--------------
//审批begin
$("#passBtn").click(function(){
	debugger;
		$("#fillOpinion").show();
    	$(".dialog-tip").height(250);
    	$("#auditOpinion").attr("readOnly",false);
    	$("#btnFileOK1").show();
    	$("#btnFileOK2").hide();
	});
	$("#noPassBtn").click(function(){
		debugger;
		$("#fillOpinion").show();
    	$(".dialog-tip").height(250);
    	$("#auditOpinion").attr("readOnly",false);
    	$("#btnFileOK1").hide();
    	$("#btnFileOK2").show();
	});
	$("#btnFileOK1").click(function(){
		pass();
	});
	$("#btnFileOK2").click(function(){
		nopass();
	});
	$("#flowBtn").click(function(){
		flow();
	});
	 $('.dialog-close-btn').click(function(){
	        $('.fixed-dialog').hide();
	    });
	    $('.tip-option-btn').click(function(){
	        $('.dialog-close-btn').trigger('click');
	    });
	//end
	function flow() {
	debugger;
	var targetElsAccount = "${param.businessElsAccount}";
	var businessType = "preBidding";
	var businessId = "${param.biddingNumber}";
	var title = '<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程     " />'+"  招标编号："+businessId;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':title,
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
}
function pass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent:function(){
		debugger;
		parent.elsDeskTop.showLoading();
		var formObj = $("#form").serializeJSON();
		var currDate = new Date().format("yyyy-MM-dd");
		var currTime = new Date().format("hh:mm:ss");
		
		//必填项非空验证
		var biddingNumber = $("#biddingNumber").val();
		if(biddingNumber == "null" || biddingNumber == ""){		
			var biddingName = $("#biddingName").val();
			if(biddingName == "" || biddingName == "null"){
				alert("必填项不能为空！",2);
				return;
			}
		}else{
			formObj["biddingNumber"]=biddingNumber;
			formObj["elsAccount"]=elsAccount;
			formObj["elsSubAccount"]=elsSubAccount;
		}
		
		//如果是不区分标段，则每个选项卡仅有一个页面，如果区分标段，则标段数对应每个选项卡有几个标段页面
		var itemPageNumber;
		if(typeof(formObj.biddingPhasesItems) == "undefined"){
			itemPageNumber = 1;
		}else{
			itemPageNumber = formObj.biddingPhasesItems.length;
			var phasesItemsTemp = formObj.biddingPhasesItems;
			for(var i=0;i<phasesItemsTemp.length;i++){
				if(phasesItemsTemp[i].biddingItemName == ""){
					alert("标段名称不能为空！",2);
					return;
				}
			}
		}
		debugger;
		$.ajax({
			url :"<%=basePath%>rest/PurchaseBiddingService/sendPreBiddingPass",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(formObj),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "401") {
					alert("<i18n:I18n key="i18n_audit_afteritemsallpass" defaultValue="订单行项目未全部通过不能审批通过" />",3);
				} else if (data.status == "403") {
					alert("<i18n:I18n key="i18n_audit_noauthority" defaultValue="没有审批权限" />",3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}
function nopass() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditrefuse" defaultValue="确认要审批拒绝吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		debugger;
		var formObj = $("#form").serializeJSON();
		var currDate = new Date().format("yyyy-MM-dd");
		var currTime = new Date().format("hh:mm:ss");
		
		//必填项非空验证
		var biddingNumber = $("#biddingNumber").val();
		if(biddingNumber == "null" || biddingNumber == ""){		
			var biddingName = $("#biddingName").val();
			if(biddingName == "" || biddingName == "null"){
				alert("必填项不能为空！",2);
				return;
			}
		}else{
			formObj["biddingNumber"]=biddingNumber;
			formObj["elsAccount"]=elsAccount;
			formObj["elsSubAccount"]=elsSubAccount;
		}
// 		else{
// 			var result = true;
// 			$(".required").prev().each(function(){
// 				var val = $(this).val();
// 				if(val == "" || val == "null" || typeof(val) == "undefined"){
// 					alert("必填项不能为空！",2);
// 					result = false;
// 				}
// 			});
// 			if(result == false){
// 				return;
// 			}		
// 		}
		
		//如果是不区分标段，则每个选项卡仅有一个页面，如果区分标段，则标段数对应每个选项卡有几个标段页面
		var itemPageNumber;
		if(typeof(formObj.biddingPhasesItems) == "undefined"){
			itemPageNumber = 1;
		}else{
			itemPageNumber = formObj.biddingPhasesItems.length;
			var phasesItemsTemp = formObj.biddingPhasesItems;
			for(var i=0;i<phasesItemsTemp.length;i++){
				if(phasesItemsTemp[i].biddingItemName == ""){
					alert("标段名称不能为空！",2);
					return;
				}
			}
		}
// 		var formObj = $("#form").serializeJSON();
// 		var frm = $("#auditForm");
		var param = formObj;
		//审批备注 @author jiangzhidong @date 20161011 begin
		//审批备注 @author jiangzhidong @date 20161011 end
		$.ajax({
			url :"<%=basePath%>rest/PurchaseBiddingService/sendPreBiddingNoPass",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				debugger;
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	}});
}
// 撤销审批
function cancel() {
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_auditcancel" defaultValue="确认要撤销审批吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		var frm = $("#auditForm");
		$.ajax({
			url :"<%=basePath%>rest/PurchaseBiddingService/cancelAuditBidding",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data&&data.statusCode&&data.statusCode != "200") {
					alert(data.message,3);
					return;
				}
				alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				parent.elsDeskTop.closeCurWin('auditRecord',closeCallback());
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (data.status == "401") {
					alert("<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />",3);
				} else if (data.status == "403") {
					alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",3);
				} else {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			}
		});
	}});
}
function operation(url,message1,message2,operType){
	var formObj = $("#form").serializeJSON();
	var currDate = new Date().format("yyyy-MM-dd");
	var currTime = new Date().format("hh:mm:ss");
	
	//必填项非空验证
	var biddingNumber = $("#biddingNumber").val();
	if(biddingNumber == "null" || biddingNumber == ""){		
		var biddingName = $("#biddingName").val();
		if(biddingName == "" || biddingName == "null"){
			alert("必填项不能为空！",2);
			return;
		}
	}else{
		var result = true;
		$(".required").prev().each(function(){
			var val = $(this).val();
			if(val == "" || val == "null" || typeof(val) == "undefined"){
				alert("必填项不能为空！",2);
				result = false;
			}
		});
		if(result == false){
			return;
		}		
	}
	
	//如果是不区分标段，则每个选项卡仅有一个页面，如果区分标段，则标段数对应每个选项卡有几个标段页面
	var itemPageNumber;
	if(typeof(formObj.biddingPhasesItems) == "undefined"){
		itemPageNumber = 1;
	}else{
		itemPageNumber = formObj.biddingPhasesItems.length;
		var phasesItemsTemp = formObj.biddingPhasesItems;
		for(var i=0;i<phasesItemsTemp.length;i++){
			if(phasesItemsTemp[i].biddingItemName == ""){
				alert("标段名称不能为空！",2);
				return;
			}
		}
	}
	
	//----组装基本信息------begin---------
	var sendResultInfo = $("#sendResultInfo").val();
	formObj["fbk1"]=sendResultInfo;
	var fbk6 = $('input[name="fbk6"]:checked').val(); //目标价是否发给投标方
	formObj["fbk6"]=fbk6;
	
	var biddingClass = $('input[name="biddingClass"]:checked').val(); //招标类别
	formObj["biddingClass"]=biddingClass;
	var publish = $("#isPublishInfo").is(':checked');//是否发布到企业控件
	formObj["publish"]=publish?1:0;
	var biddingType = $("#biddingType").val();//招标类型
	formObj["biddingType"]=biddingType;
	var biddingStatus = $("#biddingStatus").val();//招标状态
	formObj["biddingStatus"]=biddingStatus;
	var preAuditStatus = $("#preAuditStatus").val();//发布前审批
	formObj["preAuditStatus"]=preAuditStatus;
	var auditStatus = $("#auditStatus").val();//中标审批
	formObj["auditStatus"]=auditStatus;
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
	
	var biddingNumber = $("#biddingNumber").val();
	if(biddingNumber != ""){//判断基本信息已经保存
		//----组装招标计划------begin-------------
		var multiSection = $('input[name="biddingRoundsVO[multiSection]"]:checked').val();//是否区分标段
		var secret = $('input[name="biddingRoundsVO[secret]"]:checked').val();//开标前是否保密
		var biddingItemNumber = $("#plan_distinguishPhases").val();//获取标段
		var biddingRoundsVO = formObj.biddingRoundsVO;
		biddingRoundsVO["biddingItemNumber"] = biddingItemNumber;
		biddingRoundsVO["multiSection"] = multiSection;
		biddingRoundsVO["secret"] = secret;
		var roundItms = formObj.biddingRoundItms;//获取轮次列表
		if(!roundItms){
			alert("轮次不能为空！请输入必填项",2);
			return;
		}
		var biddingRoundsVOs = [];
		for(var i = 0 ; i < roundItms.length ; i ++){
			var item = roundItms[i];
			item = extend(item,biddingRoundsVO);
			biddingRoundsVOs.push(item);
		}
		if(multiSection == "0"){//不区分 标段
			formObj["biddingRoundItms"]=biddingRoundsVOs;
		}else{
			var biddingRounds = $("body").data("biddingRounds");//获取body中存放的标段轮次信息
			if(biddingRounds){
				//循环已经存在的标段轮次信息，如果当前标段已经存在则移除
				for(var i = 0 ; i < biddingRounds.length ;){
					var _biddingItemNumber = biddingRounds[i].biddingItemNumber;
					if(_biddingItemNumber == biddingItemNumber){
						biddingRounds.splice(i,1);
						i = 0;
					}else{
						i++
					}
				}
				//日期格式化
				for(var i = 0 ; i < biddingRounds.length ;i++){
					biddingRounds[i]["beginDate"] = new Date(biddingRounds[i].beginDate).format('yyyy-MM-dd');
					biddingRounds[i]["biddingBeginDate"] = new Date(biddingRounds[i].biddingBeginDate).format('yyyy-MM-dd');
					biddingRounds[i]["biddingEndDate"] = new Date(biddingRounds[i].biddingEndDate).format('yyyy-MM-dd');
					biddingRounds[i]["openDate"] = new Date(biddingRounds[i].openDate).format('yyyy-MM-dd');
				}
				biddingRoundsVOs = biddingRoundsVOs.concat(biddingRounds);
			}
			formObj["biddingRoundItms"]=biddingRoundsVOs;
			
		}
		var biddingRoundsVOsTemp = formObj.biddingRoundItms;
		//所有标段轮次表时间校验
		var roundsArrays = [];
		var items = formObj.biddingPhasesItems;
		var isManageItem = $("input[name='biddingRoundsVO[multiSection]']:checked").val();
		if(isManageItem == 1){//区分标段
			for(var i=0;i<items.length;i++){
				var tempArray = [];
				for(var j=0;j<biddingRoundsVOsTemp.length;j++){
					if(items[i].biddingItemNumber == biddingRoundsVOsTemp[j].biddingItemNumber){
						tempArray.push(biddingRoundsVOsTemp[j]);
					}
				}
				roundsArrays[i] = tempArray;
			}
		}else{
			roundsArrays[0] = biddingRoundsVOsTemp;
		}
		if(roundsArrays && roundsArrays != "" && roundsArrays.length == itemPageNumber){
			for(var a=0;a<roundsArrays.length;a++){//循环标段	
				var biddingRounds = roundsArrays[a];
				if(!biddingRounds || biddingRounds.length <= 0){
					alert("招标计划-标段-表格数据不能为！",2);
					return;
				}
				for(var i=0;i<biddingRounds.length;i++){//循环标段下的轮次行记录
					
					var beginDateStr = biddingRounds[i].beginDate;
					var beginTimeStr = biddingRounds[i].beginTime;
					
					var biddingBeginDateStr = biddingRounds[i].biddingBeginDate;
					var biddingBeginTimeStr = biddingRounds[i].biddingBeginTime;
					
					var biddingEndDateStr = biddingRounds[i].biddingEndDate;
					var biddingEndTimeStr = biddingRounds[i].biddingEndTime;
					
					var openDateStr = biddingRounds[i].openDate;
					var openTimeStr = biddingRounds[i].openTime;
					
					var beginDT = toDateAndTime(beginDateStr,beginTimeStr);
					var beginDateTime = toDateAndTime(biddingBeginDateStr,biddingBeginTimeStr);
					var endDateTime = toDateAndTime(biddingEndDateStr,biddingEndTimeStr);
					var openDateTime = toDateAndTime(openDateStr,openTimeStr);
					
					if(beginDT < toDateAndTime(currDate,currTime)){
						alert("投标开始日期有误",2);
						return;
					}
					
					if(i==0 && beginDateTime > endDateTime || endDateTime > openDateTime){//第一轮
						alert("投标开始时间有误",2);
						return;
					}else if(i!=0){//非第一轮要比较当前轮的招标开始时间和上一轮的开标时间
						var prevRoundOpenDateTime = toDateAndTime(biddingRounds[i-1].openDate,biddingRounds[i-1].openTime);
						if(prevRoundOpenDateTime > beginDateTime || beginDateTime > endDateTime || endDateTime > openDateTime){
							alert("开标日期,开标时间有误",2);
							return;
						}
					}else{
						//do nothing
					}
				}
			}
		}else{
			alert("招标计划-标段-表格数据不能为！",2);
			return;
		}
		//----组装招标计划------end-------------
		
		//----组织保证金-------begin------------
		var multiSection = $('input[name="biddingMarginVO[multiSection]"]:checked').val();//是否区分标段
		var collect = $('input[name="biddingMarginVO[collect]"]:checked').val();//是否收取保证金
		var back = $('input[name="biddingMarginVO[back]"]:checked').val();//是否退还保证金
		var biddingItemNumber = $("#margin_distinguishPhases").val();//获取标段
		var amount = $("#margin_amount").val();
		var biddingMarginVO = formObj.biddingMarginVO;
		biddingMarginVO["biddingItemNumber"] = biddingItemNumber;
		biddingMarginVO["multiSection"] = multiSection;
		biddingMarginVO["back"] = back;
		biddingMarginVO["collect"] = collect;
		biddingMarginVO["amount"] = amount.replace(/,/g,"");
		var biddingMarginVOs = [];
		if(multiSection == "0"){//不区分标段
			biddingMarginVOs.push(biddingMarginVO);
			formObj["biddingMarginVOs"]=biddingMarginVOs;
		}else{
			var biddingMargins = $("body").data("biddingMargins");//获取body中的标段保证金信息
			if(biddingMargins){
				for(var i = 0 ; i < biddingMargins.length ;){
					var _biddingItemNumber = biddingMargins[i].biddingItemNumber;
					if(_biddingItemNumber == biddingItemNumber){
						biddingMargins.splice(i,1);
						i = 0;
					}else{
						i++
					}
				}
				//日期格式化
				for(var i = 0 ; i < biddingMargins.length ;i++){
					biddingMargins[i]["payBeginDate"] = new Date(biddingMargins[i].payBeginDate).format('yyyy-MM-dd');
					biddingMargins[i]["payEndDate"] = new Date(biddingMargins[i].payEndDate).format('yyyy-MM-dd');
				}
				biddingMargins.push(biddingMarginVO);
				formObj["biddingMarginVOs"]=biddingMargins;
			}else{
				biddingMargins = [];
				biddingMargins.push(biddingMarginVO);
				formObj["biddingMarginVOs"]=biddingMargins;
			}
		}
		//所有标段保证金缴纳日期校验
		var biddingMarginVOsTemp = formObj.biddingMarginVOs;
		if(biddingMarginVOsTemp && biddingMarginVOsTemp != "" && biddingMarginVOsTemp.length == itemPageNumber){
			for(var i=0;i<biddingMarginVOsTemp.length;i++){
				var margin = biddingMarginVOsTemp[i];
				if(margin.collect == 1){//收取保证金
					var margin_payBeginDate_Str = margin.payBeginDate;
					var margin_payEndDate_Str = margin.payEndDate;
					var margin_payBeginDate = toDate(margin_payBeginDate_Str);
					var margin_payEndDate = toDate(margin_payEndDate_Str);
					var margin_amount = margin.amount;
					/*if(margin_payBeginDate_Str == "" || margin_payEndDate_Str == ""){
						alert("请确认所有标段保证金缴纳日期不为空！",2);
						return;
					}
					if(margin_amount == "" || margin_amount == "0.00"){
						alert("请确认所有标段保证金金额不为空且不能为零！",2);
						return;
					}
					if(margin_payBeginDate < toDate(currDate)){
						alert("保证金缴纳日期规划有误！",2);
						return;
					}*/
				}
			}
		}else{
			//alert("请确认保证金所有标段页都填入数据",2);
			//return;
		}	
		//----组织保证金-------end------------
		debugger;
		//招标内容、表单文件、报名条件  ------begin------
		var biddingPhasesValue = $("#biddingPhases").val();
		if(typeof(biddingContentItemStandardArray)!="undefined"){
			var selectContentBiddingNumberIndex = $("#contentBiddingItemNumber").get(0).selectedIndex;
			var biddingContent = formObj.biddingContent;
			var records = biddingDetailContentGrid.rows();
			if(typeof(records[0]) != "undefined" && records.length > 0){
				for(var i=0;i<records.length;i++){
		    		// 设置物料属性内容图片文件内容
		    		formObj["biddingContentItem"][i]["extendFields"] = records[i].extendFields;
				}
			}
			if(biddingPhasesValue=="1"){//不区分标段
				biddingContent["fbk1"] = $("input[name='controlBidding']:checked").val();//0：必须全部投标、1：可以部分投标
			}
			biddingContent.biddingContentItem=formObj.biddingContentItem;
			biddingContent.biddingContentStandard=formObj.biddingContentStandard;
			biddingContentItemStandardArray[selectContentBiddingNumberIndex]= biddingContent;
			formObj["biddingContentVOs"]=biddingContentItemStandardArray;
			
		}else {
			formObj["biddingContentVOs"]=[];
		}
		//所有标段招标内容行项目和评估标准表非空校验
		var biddingContentVOsTemp = formObj.biddingContentVOs;
		if(biddingContentVOsTemp && biddingContentVOsTemp != "" && biddingContentVOsTemp.length == itemPageNumber){
			for(var i=0;i<biddingContentVOsTemp.length;i++){//循环标段
				var biddingContentItemTemp = biddingContentVOsTemp[i].biddingContentItem;
				var biddingContentStandardTemp = biddingContentVOsTemp[i].biddingContentStandard;
				
				var deliveryStartDate_Str = biddingContentVOsTemp[i].deliveryStartDate;
				var deliveryEndDate_Str = biddingContentVOsTemp[i].deliveryEndDate;
				var deliveryStartDate = toDate(deliveryStartDate_Str);
				if(deliveryStartDate_Str == "" || deliveryEndDate_Str == ""){
					alert("请确认所有标段收货日期不为空！",2);
					return;
				}
				if(deliveryStartDate < toDate(currDate)){
					alert("收货日期规划有误！",2);
					return;
				}
				
				if(!biddingContentItemTemp || biddingContentItemTemp == ""){
					alert("请确认所有标段页的招标内容行项目不为空！",2);
					return;
				}
				if(!biddingContentStandardTemp || biddingContentStandardTemp.length == ""){
					//alert("请确认所有标段页的标段评估标准不为空！",2);
					//return;
				} else {
					if(operType==2) {
						// 判断权重总和必须为100
						var weightSumVal = 0;
						for(var si=0;si<biddingContentStandardTemp.length;si++) {
							weightSumVal += toNum(biddingContentStandardTemp[si].ratio);
						}
						if(weightSumVal != 100) {
							alert('评标标准内容权重总和必须为100',2);
							return;
						}
					}
				}
			}
		}else{
			alert("请确认招标内容所有标段页行项目和评估表不为空！",2);
			return;
		}
		
		formObj["biddingFileVOs"]=typeof(formObj.biddingFile)!="undefined"?formObj.biddingFile:[];
		if(typeof(biddingQualificationArray)!="undefined"){
			var qualificationMultiSection = $('input[name="biddingQualification[multiSection]"]:checked').val();
			var biddingQualification = formObj.biddingQualification;
			var selectQualificationBiddingNumber= $("#qualificationBiddingItemNumber");
			if(qualificationMultiSection=="0"){
				biddingQualification["multiSection"]=qualificationMultiSection;
				biddingQualification["biddingItemNumber"]=selectQualificationBiddingNumber.val();
				formObj["biddingQualificationVOs"]=[biddingQualification];
			}else {
				var selectQualificationBiddingNumberIndex = selectQualificationBiddingNumber.get(0).selectedIndex;
				biddingQualificationArray[selectQualificationBiddingNumberIndex]= biddingQualification;
				formObj["biddingQualificationVOs"]=biddingQualificationArray;
			}
		}else {
			formObj["biddingQualificationVOs"]=[];
		}
		//招标内容、表单文件、报名条件  ------end------
		
		//保存投标方信息
		var tempSuppliers = formObj.biddingSupplierVOs;
		var currentItemNumber = $("#supplier_section_list").val();
		if(tempSuppliers && typeof(tempSuppliers) != "undefined" && tempSuppliers.length > 0){
			for(var i=0;i<tempSuppliers.length;i++){
				tempSuppliers[i]["biddingItemNumber"]=currentItemNumber;
			}
			biddingSupplierArrays[currentItemNumber]=tempSuppliers;
		}
		
		var biddingSupplierVOs = getBiddingSupplierVOs();
		if(biddingSupplierVOs && biddingSupplierVOs.length > 0){
			for(var i=0;i<biddingSupplierVOs.length;i++){
				var biddingItemNumber = biddingSupplierVOs[i].biddingItemNumber;
				var tempSuppliers = biddingSupplierArrays[biddingItemNumber];
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
		
		//所有标段供应商表非空校验
		var biddingSupplierVOsTemp = formObj.biddingSupplierVOs;
		if(biddingSupplierVOsTemp && biddingSupplierVOs != ""){
			var items = formObj.biddingPhasesItems;
			if(typeof(items) != "undefined"){//区分标段			
				for(var i=0;i<items.length;i++){
					var flag = false;
					for(var j=0;j<biddingSupplierVOsTemp.length;j++){
						if(items[i].biddingItemNumber == biddingSupplierVOs[j].biddingItemNumber){
							flag = true;
						}
					}
					if(flag == false){
						alert("投标方-标段-已添加的供应商列表不能为空！",2);
						return;
					}
				}	
			}else{//不区分标段
				if(!biddingSupplierVOsTemp || biddingSupplierVOsTemp == ""){
					alert("投标方-已添加的供应商列表不能为空！",2);
					return;
				}
			}
		}else{
			alert("投标方-已添加的供应商列表不能为空！",2);
			return;
		}
		
		//资质审核
		formObj["biddingApplicationVOs"]=getBiddingApplicationVOs();
	} 
	parent.elsDeskTop.tip.init({type: 'confirm',message: message1,closeEvent:function(){
		debugger;
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
				$(".tag-isShow").show();
				$("#biddingPhases").attr("disabled",true);
				$("#biddingType").attr("disabled",true);
				var biddingStatus = data.biddingStatus;
				if(biddingStatus != 0 && biddingStatus != 1){//发布操作
					$(".publish-isShow").hide();
					$(".save-isShow").hide();
					parent.elsDeskTop.closeCurWin('addBiddingThree',callBack);
				}else{
					$(".publish-isShow").show();
				}
				alert("操作成功！",1);
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("操作失败:"+exception,3); 
	        }
		});
	}});
}

function toNum(obj) {
   	if(!isNaN(obj) && Number(obj)<=100) {
		return Number(obj);
   	}
	return 0;
}
$("#supplierStatusUpdate").click(function(){
	if($("#elsAccount").attr("disabled")=="disabled"){
		$("#elsAccount").attr("disabled",false);
	}
	if($("#biddingNumber").attr("disabled")=="disabled"){
		$("#biddingNumber").attr("disabled",false);
	}
	var formObj = $("#form").serializeJSON();
	var tempSuppliers = formObj.biddingSupplierVOs;
	var currentItemNumber = $("#supplier_section_list").val();
	var tempArr = [];
	if(tempSuppliers && typeof(tempSuppliers) != "undefined" && tempSuppliers.length > 0){
		for(var i=0;i<tempSuppliers.length;i++){
			tempSuppliers[i]["biddingItemNumber"]=currentItemNumber;
			//判断不应标复选框是否被选中
			if($("#noAnswerBidding_"+i).attr("checked")=="checked"){
				tempSuppliers[i]["participate"]="2";
			}
		}
		biddingSupplierArrays[currentItemNumber]=tempSuppliers;
	}
	if($("#biddingPhases").val()=="1"){//不区分标段
		for(var i=0;i<biddingSupplierArrays[0].length;i++){
			tempArr.push(biddingSupplierArrays[0][i]);
		}
	}else{
		var allRecords = phasesTable.rows();
		for(var i=0;i<allRecords.length;i++){
			var supplierArr = biddingSupplierArrays[allRecords[i].biddingItemNumber];
			if(typeof(supplierArr) != "undefined" && supplierArr){
				for(var j=0;j<supplierArr.length;j++){
					tempArr.push(supplierArr[j]);
				}				
			}
		}
	}
	formObj["biddingSupplierVOs"]=tempArr;
	
	parent.elsDeskTop.tip.init({type: 'confirm',message: "更新供应商信息",closeEvent:function(){
		parent.elsDeskTop.showLoading("更新中");
		$.ajax({
			url :"<%=basePath%>rest/PurchaseBiddingService/updateSupplierInfo",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(formObj),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("操作成功！",1);
				initUpdatePage();//刷新页面
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("操作失败:"+exception,3); 
	        }
		});
	}});
});

$("#supplierSend").click(function(){
	if($("#elsAccount").attr("disabled")=="disabled"){
		$("#elsAccount").attr("disabled",false);
	}
	if($("#biddingNumber").attr("disabled")=="disabled"){
		$("#biddingNumber").attr("disabled",false);
	}
	var formObj = $("#form").serializeJSON();
	var biddingSupplierVOs = getBiddingSupplierVOs();
	formObj["biddingSupplierVOs"]=biddingSupplierVOs;
	parent.elsDeskTop.tip.init({type: 'confirm',message: "新增供应商发送",closeEvent:function(){
		parent.elsDeskTop.showLoading("发送中");
		$.ajax({
			url :"<%=basePath%>rest/PurchaseBiddingService/newSupplierSend",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(formObj),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("操作成功！",1);
				initUpdatePage();//刷新页面
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("操作失败:"+exception,3); 
	        }
		});
	}});
});
</script>
</body>
</html>