////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////采购订单//////////////////////////////////////
//采购订单的状态 
function getOrderStatue(status)
{
	if(status == '0'){return "对方未确认" ;}
	else if(status == '1'){return "对方已确认" ;}
	else if(status == '2'){return "对方退回" ;}
	else if(status == '3'){return "变更对方未确认" ;}
	else if(status == '4'){return "对方变更确认" ;}
	else if(status == '5'){return "对方变更退回" ;}
	else if(status == '6'){return "关闭" ;}
	else if(status == '7'){return "更新生成状态" ;}
	return "对方未确认" ;
}

//采购订单发送状态
function getOrderSendStatus(status)
{
	if(status == '0'){return "未发送" ;}
	else if(status == '1'){return "已发送，对方已接收" ;}
	else if(status == '2'){return "已发送，等到对方接收" ;}
	return "未发送" ;
}



////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////// 询价单 /////////////////////////////////////////////////////
/**  0：新建  1：报价中 2：议价中 3：接收 4：部分接收  5:拒绝   6:部分拒绝  */
//询价单状态
function xjOrderStatus(status)
{
	if(status == '0'){return "新建" ;}
	else if(status == '1'){return "报价中" ;}
	else if(status == '2'){return "议价中" ;}
	else if(status == '3'){return "接收" ;}
	else if(status == '4'){return "部分接收" ;}
	else if(status == '5'){return "拒绝" ;}
	else if(status == '6'){return "部分拒绝" ;}
	return "新建" ;
}

// 审批状态:   0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
function getXJAuditStatus(status)
{
	if(status == '0'){return "审批通过" ;}
	else if(status == '1'){return "未审批" ;}
	else if(status == '2'){return "审批中" ;}
	else if(status == '3'){return "审批拒绝" ;}
	return "未审批" ;
}

//订单的发送状态：0：未发送    1：已发送，对方已接收      2：已发送，等到对方接收
function getXJOrderSendStatus(status)
{
	if(status == '0'){return "未发送" ;}
	else if(status == '1'){return "已发送,对方已接收" ;}
	else if(status == '2'){return "已发送,等到对方接收" ;}
	return "未发送" ;
}

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// 外协收货 ///////////////////////////////////////

//发货:0_未发货，1_发货在途，2_对方已收货，3_到货，4_部分收货;
//收货:0_未收货,1_发货在途,2_已收货,3_到货;
//退货：0_未发货，1_退货发货在途，2_对方已收退货;
//确认退货：0_未收货，1_退货发货在途，2_已收退货

// 发货状态
function getDeliveryStatus(status)
{
	if(status == '0'){return "未发送" ;}
	else if(status == '1'){return "发货在途" ;}
	else if(status == '2'){return "对方已收货" ;}
	else if(status == '3'){return "到货" ;}
	else if(status == '4'){return "部分收货" ;}
	return "未发送" ;
}


///////////////////////////////////////////////////////////////////////
//////////////////////////////// 供应商准入 ////////////////////////////

//发送状态  (0:未发送  1:已发送)
function getZRSendStatus(status)
{
	if(status == '0'){return "未发送" ;}
	else if(status == '1'){return "已发送" ;}
	return "未发送" ;
}

//单据状态(0:新建   1:销售方填写中   2:采购方评估中   3:待审批中)

function getZRStandardStatus(status)
{
	if(status == '0'){return "新建" ;}
	else if(status == '1'){return "销售方填写中" ;}
	else if(status == '2'){return "采购方评估中" ;}
	else if(status == '3'){return "待审批中" ;}
	return "未发送" ;
}



function getdfInfo(toElsAccount,toElsSubAccount,content)
{
	
	return toElsAccount+"_"+toElsSubAccount+"："+content ;
}




///////  对账单状态 ////////////////////////////////
/*对账单状态
 *      0:新建
		1:采购部分确认
		2:采购全部确认
		3:部分开票
		4:全部开票
		5:发票部分确认
		6:发票全部确认
		7:退回
		8:取消*/
function busReconStatus(status)
{
	if(status == '0'){return "新建" ;}
	else if(status == '1'){return "采购部分确认" ;}
	else if(status == '2'){return "采购全部确认" ;}
	else if(status == '3'){return "部分开票" ;}
	else if(status == '4'){return "全部开票" ;}
	else if(status == '5'){return "发票部分确认" ;}
	else if(status == '6'){return "发票全部确认" ;}
	else if(status == '7'){return "退回" ;}
	else if(status == '8'){return "取消" ;}
	return "新建";
}


//招标类型 
/* 0：邀请招标
   1：公开招标
   2：议标
*/
 
 function biddingType(status)
 {
	   if(status == '0'){return "邀请招标" ;}
		else if(status == '1'){return "公开招标" ;}
		else if(status == '2'){return "议标" ;}
		return "邀请招标" ;
 }
 
 //招标状态 
 /* 0：未开始
    1：进行中
    2：已定标
    3：已完成
*/
 function biddingStatus	(status)
 {
    if(status == '0'){return "未开始" ;}
	else if(status == '1'){return "进行中" ;}
	else if(status == '2'){return "已定标" ;}
	else if(status == '3'){return "已完成" ;}
	return "邀请招标" ;
 }




 
 /*
 评估状态：
 0:进行中
 1:待审批
 2:已完成
*/
 function assessmentStatus(status)
 {
	 if(status == '0'){return "进行中" ;}
	 else if(status == '1'){return "待审批" ;}
	 else if(status == '2'){return "已完成" ;}
	 return "邀请招标" ;
 }















