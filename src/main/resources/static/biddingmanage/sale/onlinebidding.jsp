<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String biddingNumber =request.getParameter("biddingNumber");
String biddingName =request.getParameter("biddingName");
String toElsAccount = request.getParameter("toElsAccount");
String currentRound = request.getParameter("currentRound");
String quantity = request.getParameter("quantity");
String currency = request.getParameter("currency");
String localPrice = request.getParameter("localPrice");
String limitPrice = request.getParameter("limitPrice");
String decreaseRange = request.getParameter("decreaseRange");
%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 130px;
		padding-left: 20px;
		padding-top: 3px ;
		text-align: right;
	}
</style>

<form id="onlineBiddingForm" action="" method="post">

<%-- 		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</span>
			<input readonly class="" type="text" id="elsAccount" name="elsAccount" />
		</div> --%>
		<div style="text-align: center; ">
		    <span class="edit-sub-title">报价：</span>
			<input  class="" type="text" id="price" name="price" />
			<input type="hidden" id = "elsAccount"  name = " elsAccount" />
			<input type="hidden" id = "toElsAccount"  name = "toElsAccount" />
			<input type="hidden" id = "biddingNumber"   name = "biddingNumber"/>
			<input type="hidden" id = "biddingName"   name = "biddingName"/> 
			<input type="hidden" id = currentCount   name = "currentCount"/> 
			 <span class="edit-sub-title">数量：</span>
			<input  class="" type="text" id="quantity" name="quantity"  readonly = "readonly"/>
			 <span class="edit-sub-title">总价：</span>
			<input  class="" type="text" id="totalPrice" name="totalPrice"  readonly = "readonly"  />
		</div>



		<div style="text-align: center; padding: 5px">
            <button id="onlineBiddingOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>
</form>	        
   
<script type="text/javascript">
	var elsAccount	  = '<%=session.getAttribute("elsAccount") %>' ;
	var biddingNumber = '<%= biddingNumber%>';
	var biddingName = '<%= biddingName%>';
	var toElsAccount = '<%= toElsAccount%>';
	var currentRound = '<%= currentRound%>';
	var quantity = <%= quantity%>;
	var currency = '<%= currency%>';
	var localPrice = '<%= localPrice%>';
	var limitPrice = '<%= limitPrice%>';
	var decreaseRange = '<%= decreaseRange%>';
	$(function() {
		$("#elsAccount").val(elsAccount);
		$("#biddingNumber").val(biddingNumber);
		$("#biddingName").val(biddingName);
		$("#toElsAccount").val(toElsAccount);
		$("#currentCount").val(currentRound);
		$("#quantity").val(quantity);
		//caluTotal();
	});
	$("#onlineBiddingOK").click(function(){
		//判断轮次是否存在汉字,如何存在就不允许报价
		if(/[\u4e00-\u9fa5]/g.test($("#currentCount").val())){
			alert("当前不允许报价",2) ;
			return ;
		}
		
	
		
		var currentCount = $("#currentCount").val() ;
		var frm = $("#onlineBiddingForm") ;
		var jsonObj = frm.serializeJSON() ;
		jsonObj["elsAccount"]    = elsAccount ;
		jsonObj["toElsAccount"]  = toElsAccount ;
		jsonObj["biddingName"]   = biddingName ;
		jsonObj["biddingNumber"] = biddingNumber ;
		
		var saleBiddingContentOnlinePriceVOs = [] ;
		
		var price      = $("#price").val() ;
		var totalPrice =  $("#totalPrice").val() ;
		var priceJson  = {"elsAccount":elsAccount,"toElsAccount": toElsAccount,"biddingNumber":biddingNumber,
			 "biddingName":biddingName,"price":price,"currentCount":currentCount,"totalPrice":totalPrice,
				 "quantity":quantity,"currency":currency};
		saleBiddingContentOnlinePriceVOs.push(JSON.stringify(priceJson)) ;
		jsonObj["saleBiddingContentOnlinePriceVOs"] = eval('['+saleBiddingContentOnlinePriceVOs+']') ;
		if(""!=localPrice&&""!=decreaseRange){
			var preprice = valueOf(localPrice);
			console.log(preprice);
		}
		//判断是否低于限价
// 		if(limitPrice<price){
// 			alert("低于采购价格");
// 			return;
// 		}
		
// 		if(localPrice+decreaseRange>price){
// 			alert("降价幅度不足");
// 			return;
// 		}
		
		$.ajax({
				url : "<%=basePath%>rest/SaleBiddingService/updateSaleBiddingPrice",
				type :"post" ,
				contentType : "application/json",
				data : JSON.stringify(jsonObj),
				dataType 	: "json"                                   ,				
		  }).done(function(data){
			  alert("报价成功",1)                             ;
			  closeWin();
		  }).fail(function(data){
			  alert("报价成功",0)                             ;
			  closeWin();
		  })                                                          ;
	});

	$("#closeWin").click(function(){
		closeWin();
	});
	
	function closeWin(){
		 //重新加载报价信息
		 parent.frames['iframeApp_PurchaseEnquiryDetail'].setLocalPrice($("#price").val(), $("#totalPrice").val(),currency);
		 parent.frames['iframeApp_PurchaseEnquiryDetail'].reloadHistory();
		 parent.elsDeskTop.closeCurWin('onlineBidding');
	}
	
 	$("#price").keyup(function(){
		caluTotal();
	})
	function caluTotal(){
		var price = $("#price").val();
		var quantity  = $("#quantity").val();
		 var total = price * quantity;
		 $("#totalPrice").val(total);
	}
     
    
</script>

</body>
</html>