<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="box-wrap pos-relative bg-common ">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_deliveroperation" defaultValue="发货操作" /></span>
            <div class="common-box-line">
	            <div class="dis-in-b text-center thing-manager" id="createDelivery" url="ordermanage/materialVoucher/createDelivery.jsp">
            		<img class="dis-in-b" src="../../icon/1.png" title="<i18n:I18n key='i18n_delivery_windowtitle_createdelivery' defaultValue='新建发货' />">
            		<span class="dis-in-b thing-text"><i18n:I18n key="i18n_delivery_windowtitle_createdelivery" defaultValue="新建发货" /></span>
            	</div>
            	<div class="dis-in-b text-center thing-manager" id="deliveryManage" url="ordermanage/materialVoucher/deliveryManage.jsp">
            		<img class="dis-in-b" src="../../icon/readGod.png" title="<i18n:I18n key='i18n_delivery_windowtitle_deliverymanage' defaultValue='发货管理' />">
            		<span class="dis-in-b thing-text"><i18n:I18n key="i18n_delivery_windowtitle_deliverymanage" defaultValue="发货管理" /></span>
            	</div>
            </div>
    </div>
    <div class="box-wrap pos-relative bg-common ">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_receiptoperation" defaultValue="收货操作" /></span>
         <div class="common-box-line">
         	<div class="dis-in-b text-center thing-manager" id="scenConfirm" url="ordermanage/materialVoucher/sceneConfirm.jsp">
           		<img class="dis-in-b" src="../../icon/fastsearch.png" title="<i18n:I18n key='i18n_delivery_windowtitle_scene' defaultValue='货物到场扫描' />">
           		<span class="dis-in-b thing-text"><i18n:I18n key="i18n_delivery_windowtitle_scene" defaultValue="货物到场扫描" /></span>
           	</div>
           	<div class="dis-in-b text-center thing-manager" id="queryDelivery" url="ordermanage/materialVoucher/queryDelivery.jsp">
           		<img class="dis-in-b" src="../../icon/icon1.png" title="<i18n:I18n key='i18n_delivery_windowtitle_querydelivery' defaultValue='发货单查询' />">
           		<span class="dis-in-b thing-text"><i18n:I18n key="i18n_delivery_button_receipt" defaultValue="收货" /></span>
           	</div>
           	<div class="dis-in-b text-center thing-manager" id="queryReceipt" url="ordermanage/materialVoucher/queryReceipt.jsp">
           		<img class="dis-in-b" src="../../icon/icon0.png" title="<i18n:I18n key='i18n_delivery_windowtitle_receiptmanage' defaultValue='收货管理' />">
           		<span class="dis-in-b thing-text"><i18n:I18n key="i18n_delivery_windowtitle_receiptmanage" defaultValue="收货管理" /></span>
           	</div>
         </div>
    </div>
    <div class="box-wrap pos-relative bg-common ">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_refundoperation" defaultValue="退货操作" /></span>
         <div class="common-box-line">
         	<div class="dis-in-b text-center thing-manager" id="refundOrderManage" url="ordermanage/materialVoucher/refundOrderManage.jsp">
           		<img class="dis-in-b" src="../../icon/qqread.png" title="<i18n:I18n key='i18n_delivery_title_returning' defaultValue='退货' />">
           		<span class="dis-in-b thing-text"><i18n:I18n key="i18n_delivery_title_returning" defaultValue="退货" /></span>
           	</div>
           	<div class="dis-in-b text-center thing-manager" id="refundConfirmOrderManage" url="ordermanage/materialVoucher/refundConfirmOrderManage.jsp">
           		<img class="dis-in-b" src="../../icon/8.png" title="<i18n:I18n key='i18n_delivery_title_refundconfirm' defaultValue='确认退货友' />">
           		<span class="dis-in-b thing-text"><i18n:I18n key="i18n_delivery_title_refundconfirm" defaultValue="确认退货" /></span>
           	</div>
         </div>
    </div>
<script type="text/javascript">
$().ready(function(){
	
	$(".thing-manager").click(function(){
		var id = $(this).attr("id");
		var title = $(this).find("span").html();
		var url = $(this).attr("url");;
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':id,
	        'windowTitle':title,
	         windowSubTitle: "",
	        'iframSrc':url,
	         windowStatus: 'maximized',
	         windowMinWidth: 960,
	         windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	});
});
</script>
</body>
</html>