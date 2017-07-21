<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">
html, body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
}

#flashContent {
	display: none;
}

table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
				key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
<!-- 		    <button id="save" class="button-wrap save-isShow">保存</button> -->
<!-- 			<button id="send" class="button-wrap publish-isShow">发布</button> -->
<!-- 			<button id="supplierStatusUpdate" class="button-wrap" ><span>供应商状态更新</span></button> -->
<!-- 			<button id="supplierSend" class="button-wrap" ><span>新供应商发送</span></button> -->
			<button id="passBtn" class="todo button-wrap"><i18n:I18n key="" defaultValue="审批通过" /></button>
			<button id="noPassBtn" class="todo button-wrap"><i18n:I18n key="" defaultValue="审批拒绝" /></button>
			<button id="flowBtn" class="button-wrap"><i18n:I18n key="" defaultValue="查看流程" /></button>
<%-- 			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
		</div>
	</div>
	
	<form id="form" onsubmit="return false;">
		<input type="hidden" id="elsAccount" name="elsAccount"/>
		<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
		<input type="hidden" id="toElsAccounts" name="toElsAccounts"/>
		<input type="hidden" id="toElsDescs" name="toElsDescs"/>
		<input type="hidden" id="biddingNumber1" name="biddingNumber"/>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本数据</span>
			<div class="common-box-line">
				<div class="tab-wrap" id="add-enq-sheet">
					<ul>
						<li><a href="#edit-line-baseInfo">基本信息</a></li>
						<li class="tag-isShow"><a href="#edit-line-connType">联系方式</a></li>
						<li class="edit-line-plan tag-isShow"><a href="#edit-line-plan">招标计划</a></li>
						<li class="edit-line-bail tag-isShow"><a href="#edit-line-bail"><i18n:I18n key="test" defaultValue="保证金" /></a></li>
						<li class="edit-line-content tag-isShow"><a href="#edit-line-content">招标内容</a></li>
						<li class="edit-line-invited tag-isShow"><a href="#edit-line-invited">投标方</a></li>
        				<li class="add-file-sheet tag-isShow"><a href="#edit-line-file"><i18n:I18n key="test" defaultValue="查阅表单" /></a></li>
        				<li class="add-form-sheet tag-isShow"><a href="#back-sign-form"><i18n:I18n key="test" defaultValue="回签表单" /></a></li>
        				<li class="add-line-apply"><a href="#edit-line-apply">报名条件</a></li>
        				<li class="edit-line-qualify"><a href="#edit-line-qualify">资质审核</a></li>
					</ul>
					
					<!-- 基本信息 -->
					<div id="edit-line-baseInfo">
					 <table border="0">
				    	<tbody>
				    	    <tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标名称:" /></td>
				    			<td colspan="1" align="left">
									<input id="biddingName" name="biddingName" type="text" style="width: 200px;" />
									<span style="color: red;" class="required">*</span>
								</td>
								<td colspan="1" align="right" width="120px"><i18n:I18n key="test" defaultValue="招标编码:" /></td>
				    			<td colspan="1" align="left">
									<input id="biddingNumber" name="biddingNumber" type="text" style="width: 200px;" readonly="readonly" value=""/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标类型:" /></td>
				    			<td colspan="1" align="left">
									<select id="biddingType" name="biddingType"  >
										<option value="0">邀请招标</option>
										<!-- <option value="1">公开招标</option> -->
										<option value="2">在线竞标</option>
										<!-- <option value="3">在线竞标-公开</option>
										<option value="4">暂定招标-邀请</option>
										<option value="5">暂定招标-公开</option>
										<option value="6">竞争性谈判</option> -->
									</select><span style="color: red;" class="required">*</span>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="目标价发给投标方" />:</td>
				    			<td colspan="1" align="left">
				    				<i18n:I18n key="test" defaultValue="是" />:
									<input type="radio" name="fbk6" value="0" checked="checked" />  &nbsp;&nbsp;
									<i18n:I18n key="test" defaultValue="否" />:
								    <input type="radio" name="fbk6" value="1" />
								</td>
								<%-- <td colspan="1" align="right"><i18n:I18n key="test" defaultValue="公开竞价" />:</td>
								<td colspan="1" align="left">
								    <input type="radio" id="biddingClass" name="biddingClass" value="0" disabled="true">
								    &nbsp;&nbsp;<i18n:I18n key="test" defaultValue="定向邀请" />:
								    <input type="radio" id="biddingClass" name="biddingClass" value="1" checked="checked" disabled="true">
								</td> --%>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="项目编号"/>:</td>
				    			<td colspan="1" align="left">
									<input id="biddingProjectNumber" name="biddingProjectNumber" type="text" readonly="readonly" style="width: 200px;" value=""/>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="定标结果发送投标方"/>:</td>
				    			<td colspan="1" align="left">
									<select id="sendResultInfo" name="sendResultInfo" value=""/>
										<option value="0">全部发送</option>
										<option value="1">不发送</option>
										<option value="2">只发送中标方</option>
									</select>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="预算金额" />:</td>
				    			<td colspan="1" align="left">
									<input id="budgetAmount" name="budgetAmount" type="text" style="width: 200px;" value="" onkeyup="value=value.replace(/[^(\d.)]/g,'')" />
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="结算货币" />:</td>
				    			<td colspan="1" align="left">
									<select id="currency" name="currency"  >
										<option value="CNY">CNY</option>
										<option value="HKD">HKD</option>
										<option value="USD">USD</option>
										<option value="JPY">JPY</option>
										<option value="EUR">EUR</option>
										<option value="TWD">TWD</option>
										<option value="KER">KER</option>
									</select>
								</td>
				    		</tr>
				    		<tr class='online-bidding'>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="资金来源" />:</td>
				    			<td colspan="1" align="left">
									<input id="fundSource" name="fundSource" type="text" style="width: 200px;" class = "init-roundTable" />
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招投标状态" />:</td>
				    			<td colspan="1" align="left">
									<select id="biddingStatus" name="biddingStatus" disabled="true" >
										<option value="0" selected>未发布</option>
										<option value="1">审批中</option>
										<option value="2">审批退回</option>
										<option value="3">审批拒绝</option>
										<option value="4">已发布</option>
										<option value="5">招标进行中</option>
										<option value="6">未开标</option>
										<option value="7">评标中</option>
										<option value="8">招标作废</option>
										<option value="9">定标中</option>
										<option value="10">定标审批中</option>
										<option value="11">定标审批退回</option>
										<option value="12">招标结束</option>
									</select>
								</td>
				    		</tr>
				    		<tr class='online-bidding'>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="发布前审批" />:</td>
				    			<td colspan="1" align="left">
									<select id="preAuditStatus" name="preAuditStatus" disabled="true" >
										<option value="1" >未审批</option>
										<option value="2">审批中</option>
										<option value="0">审批通过</option>
										<option value="3">审批拒绝</option>
									</select>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="中标审批" />:</td>
				    			<td colspan="1" align="left">
									<select id="auditStatus" name="auditStatus" disabled="true" >
										<option value="1" >未审批</option>
										<option value="2">审批中</option>
										<option value="0">审批通过</option>
										<option value="3">审批拒绝</option>
									</select>
								</td>
				    		</tr> 
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="概况与范围" />:</td>
				    			<td colspan="3" align="left">
									<textarea style="width: 400px; height: 80px" id="header_summary"  name="summary"></textarea>
								</td>
				    		</tr>
				    		<%-- <tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="信息发布" />:</td>
				    			<td colspan="3" align="left">
				    			     <input type="checkbox" id="isPublishInfo" name="publish"><span>招标信息发布到企业空间</span>
								</td>
				    		</tr> --%>
				    	</tbody>
				      </table>
				      <main class="grid-container">
				          <div class="edit-box-wrap" style="padding-top: 5px;">
				            <span>标段划分</span>:
				            <select id="biddingPhases" name="biddingItemCount"  >
										<option value="1">不区分标段</option>
										<option value="2">2个标段</option>
										<option value="3">3个标段</option>
										<option value="4">4个标段</option>
										<option value="5">5个标段</option>
									</select>
						   </div>
							<div class="grid-100" id="reCreate">
								<table id="phases-table"></table>
							</div>
					  </main>
					</div>
					
					<!-- 联系方式 -->
					<div id="edit-line-connType">
					    <div class="box-wrap pos-relative bg-common">
			                 <span class="dis-in-b pos-absolute box-tip bg-common">招标机构</span>
			                 <div class="common-box-line">
			                      <div class="input-and-tip">
							         <span>招标单位:</span> 
							         <input id="orgName" name="biddingLinkmanVOs[][orgName]" type="text" style="width: 500px;"/>
							         <span style="color: red;" class="required">*</span>
						          </div>
						          <div class="input-and-tip">
							          <span>负  责  人:</span>&nbsp;
							          <input id="principal" name="biddingLinkmanVOs[][principal]" type="text" style="width: 500px;"/>
							          <span style="color: red;" class="required">*</span>
						          </div>
						          <div class="input-and-tip">
							          <span>联系电话:</span> 
							          <input id="telephone" name="biddingLinkmanVOs[][telephone]" type="text" style="width: 500px;"/>
							          <span style="color: red;" class="required">*</span>
						          </div>
						          <div class="input-and-tip">
							          <span>电子邮箱:</span> 
							          <input id="email" name="biddingLinkmanVOs[][email]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span>电子传真:</span> 
							          <input id="fax" name="biddingLinkmanVOs[][fax]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span>联系地址:</span> 
							          <input id="bidding-address" name="biddingLinkmanVOs[][address]" type="text" style="width: 500px;"/>
							          <span style="color: red;" class="required">*</span>
						          </div>
			                 </div>
			             </div>
						
						<div class="box-wrap pos-relative bg-common">
			                 <span class="dis-in-b pos-absolute box-tip bg-common">代理招标机构</span>
			                 <div class="common-box-line">
			                      <div class="input-and-tip">
							         <span>招标单位:</span> 
							         <input id="dl_orgName" name="biddingLinkmanVOs[][orgName]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span>负  责  人:</span>&nbsp;
							          <input id="dl_principal" name="biddingLinkmanVOs[][principal]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span>联系电话:</span> 
							          <input id="dl_telephone" name="biddingLinkmanVOs[][telephone]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span>电子邮箱:</span> 
							          <input id="dl_email" name="biddingLinkmanVOs[][email]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span>电子传真:</span> 
							          <input id="dl_fax" name="biddingLinkmanVOs[][fax]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span>联系地址:</span> 
							          <input id="dl_address" name="biddingLinkmanVOs[][address]" type="text" style="width: 500px;"/>
						          </div>
			                 </div>
			             </div>
					</div>
					<!-- 招标计划 -->
					<div id="edit-line-plan">
					     <div class="common-box-line">
					          <div class="input-and-tip">
								   <input type="radio" id="plan_isDistinguishPhases" name="biddingRoundsVO[multiSection]" value="0"/>
								   <i18n:I18n key="test" defaultValue="不区分标段" />
								   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								   <input type="radio" id="plan_isDistinguishPhases" name="biddingRoundsVO[multiSection]" value="1"/>
					               <i18n:I18n key="test" defaultValue="区分标段" />
					               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					               <i18n:I18n key="test" defaultValue="标段" />:
					               <select id="plan_distinguishPhases" name="biddingRoundsVO[biddingItemNumber]">
					                   <option value="0">不区分标段</option>
					               </select>
					          </div>
					          <div class="input-and-tip">
							          <span style="color: red;">*</span><span>招标轮数:</span> 
							          <input id="totalRound" name="biddingRoundsVO[totalRound]" class="keyup-plan-double-digit init-roundTable" type="text" onkeyup="value=value.replace(/[^(\d)]/g,'')" />
							          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							          <span>每轮持续:</span> 
							          <span style="color: red;">*</span><input id="duration" name="biddingRoundsVO[duration]" class="keyup-plan-three-digit init-roundTable" type="text" onkeyup="value=value.replace(/[^(\d)]/g,'')" /><span class="date-unit"></span>
							          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							          <span style="color: red;">*</span><span>每轮间隔:</span> 
							          <input id="intervalType" name="biddingRoundsVO[intervalType]" class="keyup-plan-three-digit-0 init-roundTable" type="text" onkeyup="value=value.replace(/[^(\d)]/g,'')" /><span class="date-unit"></span>
						       </div>
					           <div class="input-and-tip">
					                <span style="color: red;">*</span><i18n:I18n key="test" defaultValue="开始日期" />:
					                <input type="text" id="plan_beginDate" class="Wdate init-roundTable" name="biddingRoundsVO[beginDate]"
										onfocus="WdatePicker({minDate:'%y-%M-%d',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                <span style="color: red;">*</span><i18n:I18n key="test" defaultValue="开始时间" />:
					                <input type="text" id="plan_beginTime" class="Wdate init-roundTable" name="biddingRoundsVO[beginTime]"
										onfocus="WdatePicker({minDate:'HH:mm:00',startDate:'HH:mm:00',dateFmt:'HH:mm:00',alwaysUseStartDate:true})" />
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                <span style="color: red;">*</span><i18n:I18n key="test" defaultValue="应标期限" />:
					                <input type="text" id="fbk1" name="biddingRoundsVO[fbk1]" value="" />天
					           </div>
					           <div class="box-wrap pos-relative bg-common isShow-isSecrecy">
			                        <span class="dis-in-b pos-absolute box-tip bg-common">开标前是否可以查看招标内容</span>
			                        <div class="common-box-line" style="width: 800px;">
			                            <input type="radio" id="plan_secret" name="biddingRoundsVO[secret]" value="0"/>
								        <i18n:I18n key="test" defaultValue="开标前保密" />
								        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								        <input type="radio" id="plan_secret" name="biddingRoundsVO[secret]" value="1"/>
					                    <i18n:I18n key="test" defaultValue="开标前可查看" />
			                        </div>
			                   </div>
					     </div>
					     <main class="grid-container">
							<div class="grid-100">
								<table id="phases-round-table"></table>
							</div>
					  </main>
					</div>
					<!-- 保证金-->
					<div id="edit-line-bail">
					    <div class="common-box-line">
					          <div class="input-and-tip">
								   <input type="radio" id="margin_isDistinguishPhases" name="biddingMarginVO[multiSection]" value="0"/>
								   <i18n:I18n key="test" defaultValue="不区分标段" />
								   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								   <input type="radio" id="margin_isDistinguishPhases" name="biddingMarginVO[multiSection]" value="1"/>
					               <i18n:I18n key="test" defaultValue="区分标段" />
					               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					               <i18n:I18n key="test" defaultValue="标段" />:
					               <select id="margin_distinguishPhases" name="biddingMarginVO[biddingItemNumber]">
					                   <option value="0">不区分标段</option>
					               </select>
					          </div>
					          <div class="input-and-tip">
					             <table>
					                <tbody>
			    		               <tr>
			    			             <td colspan="1" align="right"><i18n:I18n key="test" defaultValue="收取保证金:" /></td>
			    			             <td colspan="1" align="left">
								             <input id="" name="biddingMarginVO[collect]" type="radio" value="0" checked="true"/>否
								             <input id="" name="biddingMarginVO[collect]" type="radio" value="1" />是
							             </td>
			    			             <td colspan="1" align="right"><i18n:I18n key="test" defaultValue="退还保证金:" /></td>
			    			             <td colspan="1" align="left">
								             <input id="" name="biddingMarginVO[back]" type="radio"  value="0"/>否
								             <input id="" name="biddingMarginVO[back]" type="radio" checked="true" value="1"/>是
							             </td>
			    		             </tr>
			    		             <tr>
			    			             <td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金金额:" /></td>
			    			             <td colspan="3" align="left">
								             <input id="margin_amount" name="biddingMarginVO[amount]" type="text" style="width: 300px;" value="" onkeyup="value=value.replace(/[^(\d.)]/g,'')"/>
								             <select id="margin_currencyType" name="biddingMarginVO[currency]"  >
										         <option value="CNY">CNY</option>
										         <option value="HKD">HKD</option>
										         <option value="USD">USD</option>
										         <option value="JPY">JPY</option>
										         <option value="EUR">EUR</option>
										         <option value="TWD">TWD</option>
										         <option value="KER">KER</option>
									         </select>
							             </td>
			    		             </tr>
			    		             <tr>
			    			             <td colspan="1" align="right"><i18n:I18n key="test" defaultValue="缴纳日期(从):" /></td>
			    			             <td colspan="3" align="left">
								             <input type="text" class="Wdate" id="margin_payBeginDate" name="biddingMarginVO[payBeginDate]" value="" 
								             onfocus="WdatePicker({minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'margin_payEndDate\')}'})" />
				  				             <span><i18n:I18n key="test" defaultValue="到" /></span>
	                    		             <input type="text" class="Wdate" id="margin_payEndDate" name="biddingMarginVO[payEndDate]" value="" 
	                    		             onfocus="WdatePicker({minDate:'#F{$dp.$D(\'margin_payBeginDate\')}'})"/>
							             </td>
			    		             </tr>
			    		             <tr>
			    			             <td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金细节规则:" /></td>
			    			             <td colspan="3" align="left">
								             <textarea style="width: 500px; height: 80px" id="margin_remark" name="biddingMarginVO[remark]"></textarea>
							             </td>
			    		             </tr>
			    	             </tbody>
			                   </table>
					          </div>
					     </div>
				  
				</div>
					<!-- 受邀方 -->
					<div id="edit-line-invited">
						<div class="supplie-groud">
<!-- 					          <div class="input-and-tip"> -->
<!-- 								   <input type="radio" id="supplier_isDistinguishPhases" name="biddingSupplierVO[multiSection]" value="0"/> -->
<%-- 								   <i18n:I18n key="test" defaultValue="不区分标段" /> --%>
<!-- 								   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 								   <input type="radio" id="supplier_isDistinguishPhases" name="biddingSupplierVO[multiSection]" value="1"/> -->
<%-- 					               <i18n:I18n key="test" defaultValue="区分标段" /> --%>
<!-- 					               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<%-- 					               <i18n:I18n key="test" defaultValue="标段" />: --%>
<!-- 					               <select id="supplier_distinguishPhases" name="biddingSupplierVO[biddingItemNumber]"> -->
<!-- 					                   <option value="0">不划分标段</option> -->
<!-- 					               </select> -->
<!-- 					          </div> -->
							<div class="bg-common contacts-box">
<%-- 								<div class="tip-head pos-relative">
									 <span
										class="dialogTitle"><i18n:I18n
											key="i18n_common_title_addcontact1" defaultValue="添加供应商" /></span>
								</div> --%>
<!-- 								<div class="box-wrap pos-relative bg-common"> -->
<!-- 									<span class="dis-in-b pos-absolute" style="left: 16px;">可添加供应商列表：</span> -->
<!-- 									<input class="dis-in-b pos-absolute contact-search" type="text" -->
<!-- 										style="left: 16px; width: 220px; max-width: 220px; padding-right: 20px;" -->
<!-- 										placeholder="输入查找关键字" /> <img class="dis-in-b pos-absolute" -->
<!-- 										src="../../img/icon_search.png" -->
<!-- 										style="width: 14px; left: 244px; top: 14px;" /> <span -->
<%-- 										class="dis-in-b pos-absolute" style="left: 345px;"><i18n:I18n --%>
<%-- 											key="i18n_common_title_alreadyaddcontact1" --%>
<%-- 											defaultValue="已添加的供应商列表" />：</span> --%>
<!-- 									<div class="fl-left box-left mt-27"></div> -->
<!-- 									<div class="fl-left box-middle mt-27"> -->
<!-- 										<p class="all-pre text-center"> -->
<!-- 											<button class="contact-option-btn button-wrap" title="全部右移">>></button> -->
<!-- 										</p> -->
<!-- 										<p class="all-back text-center"> -->
<!-- 											<button class="contact-option-btn button-wrap" title="全部左移"><<</button> -->
<!-- 										</p> -->
<!-- 									</div> -->
<!-- 									<div class="fl-left box-right mt-27"></div> -->
<!-- 									<div class="clear-both"></div> -->
<!-- 								</div> -->
							</div>
							
					       	<div id="supplier_list_container" class="box-wrap pos-relative bg-common">
								<i18n:I18n key="test" defaultValue="标段" />:
					               <select id="supplier_section_list" >
					                   <option value="0">不划分标段</option>
					               </select>
								<div class="common-box-line">
								   <main class="grid-container">
									<div class="grid-100">
										<table id="supplier_list_table"></table>
									</div>
									</main>
								</div>
							</div>
							
						</div>
					</div>
					<!-- 招标内容 -->
					<div id="edit-line-content">
						<div class="box-wrap pos-relative bg-common">
						  <table>
					    	<tbody>
					    		<tr>
					    			<td colspan="1" align="right">标段：</td>
					    			<td colspan="1" align="left">
										<select id="contentBiddingItemNumber" name="biddingContent[biddingItemNumber]">
										</select>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right">招标内容&nbsp;&nbsp;<br/>总体描述：</td>
					    			<td colspan="1" align="left">
										<textarea style="width: 500px; height: 80px" id="contentSummary" name="biddingContent[summary]"></textarea>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="所属项目" />：</td>
					    			<td colspan="1" align="left">
										<input id="contentBiddingProjectNumber" name="biddingContent[biddingProjectNumber]" type="text" readonly="readonly" style="width: 200px;" />
										<input id="contentBiddingProjectName" name="biddingContent[biddingProjectName]" type="text" value="自动取项目名称" readonly="readonly" style="width: 300px;" />
										<!-- <img src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;left: 402px;top: 140px;cursor: pointer;" class="equirementsplanning" title="选择需求计划" /> -->
									</td>
					    		</tr>
					    		<tr>
				    				<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="生效日期" />：</td>
					    			<td colspan="1" align="left">
										<input type="text" id="contentDeliveryStartDate" name="biddingContent[deliveryStartDate]" readonly="readonly"/>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right">交货地点：</td>
					    			<td colspan="1" align="left">
										<input type="text" id="contentAddress" name="biddingContent[address]">
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right">质量要求：</td>
					    			<td colspan="1" align="left">
										<textarea style="width: 500px; height: 80px" id="contentQuality" name="biddingContent[quality]"></textarea>
									</td>
					    		</tr>
					    	</tbody>
					       </table>
					       	<div class="box-wrap pos-relative bg-common">
								<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
										key="" defaultValue="招标详细内容" /></span>
								<div class="common-box-line">
									<button id="biddingDetailContentAdd" class="button-wrap">添加</button>
									<button id="biddingDetailContentRemove" class="button-wrap">删除</button>
									<button id="importByMaterial" class="button-wrap">导入</button>
									<button id="downMaterialModual" class="button-wrap">导出模板</button>
									<button id="btnFromRequrePlan" class="button-wrap"><i18n:I18n key="" defaultValue="从需求计划提取" /></button>
									<span id="controlBidding">
										<input type="radio" name="controlBidding" value="0" checked="checked"/>&nbsp;&nbsp;必须全部投标
										<input type="radio" name="controlBidding" value="1" />&nbsp;&nbsp;可以部分投标
									</span>
								</div>
								<div class="common-box-line">
								   <main class="grid-container">
									<div class="grid-100">
										<table id="biddingDetailContentTable"></table>
									</div>
									</main>
								</div>
							</div>
					       	<div class="box-wrap pos-relative bg-common">
								<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
										key="" defaultValue="评标标准内容" /></span>
								<div class="common-box-line">
									<button id="obtainByEvaltemp" class="button-wrap">从评标模板提取</button>
									<%--
									<button id="biddingStandardAdd" class="button-wrap">添加</button>
									--%>
									<button id="biddingStandardRemove" class="button-wrap">删除</button>
								</div>
								<div class="common-box-line">
								   <main class="grid-container">
									<div class="grid-100">
										<table id="biddingStandardTable"></table>
									</div>
									</main>
								</div>
							</div>
						</div>
					</div>

					<!-- 查阅表单 -->
					<div class="p-zero" id="edit-line-file">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line p-zero">
								<div class="pos-relative upload-wrap">
									<div class="pos-absolute file-list">
										<div class="file-list-head">
											<section>
												标段： <select id="fileBiddingItemNumber"
													name="fileBiddingItemNumber">
												</select> &nbsp;&nbsp; 轮次： <select id="fileRoundNumber"
													name="fileRoundNumber">
												</select>
											</section>
										</div>
										<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="add-file-project"></table>
										</div>
										</main>
									</div>
									<div class="file-scan">
										<div class="file-option-zoom">
											<div class="dis-in-b text-left">
												<button id="uploadFile" class="button-wrap">上传</button>
												<button id="downloadFile" class="button-wrap">下载</button>
												<!-- <button id="lookFile" class="button-wrap">在线查看</button> -->
											</div>
										</div>
										<div class="file-display" id="file-display">
											<a id="viewerPlaceHolder"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 回签表单 -->
					<div class="p-zero" id="back-sign-form">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line p-zero">
								<div class="pos-relative upload-wrap">
									<div class="pos-absolute file-list">
										<div class="file-list-head">
											<section>
												标段： <select id="fileBiddingItemNumber1"
													name="fileBiddingItemNumber1">
												</select> &nbsp;&nbsp; 轮次： <select id="fileRoundNumber1"
													name="fileRoundNumber1">
												</select>
											</section>
										</div>
										<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="sign-form-project"></table>
										</div>
										</main>
									</div>
									<div class="file-scan">
										<div class="file-option-zoom">
											<div class="dis-in-b text-left">
												<button id="uploadForm" class="button-wrap">上传</button>
												<button id="downloadForm" class="button-wrap">下载</button>
												<!-- <button id="lookForm" class="button-wrap">在线查看</button> -->
											</div>
										</div>
										<div class="file-display" id="file-display">
											<a id="viewerPlaceHolder"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!--报名条件 -->
					<div id="edit-line-apply">
					   <table style="width: 80%" >
						 <tbody>
			    			<tr>
			    			<td  align="left">
								<input id="qualificationMultiSection" name="biddingQualification[multiSection]" type="radio" value="0" />不区分标段
								<input id="qualificationMultiSection" name="biddingQualification[multiSection]" type="radio" value="1"/>区分标段
							</td>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="标段" />：</td>
			    			<td colspan="1" align="left">
								<select id="qualificationBiddingItemNumber" name="biddingQualification[biddingItemNumber]"></select>
							</td>
			    			<td colspan="1" align="left"><i18n:I18n key="test" defaultValue="注：可以按标段指定不同的报名条件。" /></td>
			    		</tr>
			    		</tbody>
			    		</table>
			    		<br>
			    		 <table>
						 <tbody>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="报名截至" />：</td>
			    			<td colspan="3" align="left">
								<input type="text" class="Wdate" onfocus="WdatePicker({minDate:'%y-%M-%d',startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" id="qualificationRegisterEndDate" name="biddingQualification[registerEndDate]"  />
								<input type="text" onfocus="WdatePicker({minDate:'HH:mm:00',startDate:'HH:mm:00',dateFmt:'HH:mm:00',alwaysUseStartDate:true})" id="qualificationRegisterEndTime" name="biddingQualification[registerEndTime]"  />
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="注册资金" />：</td>
			    			<td colspan="1" align="left">
							<select id="qualificationCapital" name="biddingQualification[capital]">
									<option value="100">100</option>
									<option value="500">500</option>
									<option value="1000">1000</option>
									<option value="1500">1500</option>
									<option value="10000">10000</option>
								</select>
				  				<span><i18n:I18n key="test" defaultValue="万元以上" /></span>
							</td>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="联合投标" />：</td>
			    			<td colspan="1" align="left">
								<select id="qualificationJointBidding" name="biddingQualification[jointBidding]">
									<option value="1">不允许</option>
									<option value="2">允许</option>
								</select>
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="企业资质" />：</td>
			    			<td colspan="3" align="left">
								<textarea style="width: 500px; height: 80px" id="qualificationQualification" name="biddingQualification[qualification]"></textarea>
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="供应能力" />：</td>
			    			<td colspan="3" align="left">
								<textarea style="width: 500px; height: 80px" id="qualificationDeliverability" name="biddingQualification[deliverability]"></textarea>
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="认证要求" />：</td>
			    			<td colspan="3" align="left">
								<textarea style="width: 500px; height: 80px" id="qualificationAuthentication" name="biddingQualification[authentication]"></textarea>
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="附加信息" />：</td>
			    			<td colspan="3" align="left">
								<textarea style="width: 500px; height: 80px" id="qualificationRemark" name="biddingQualification[remark]"></textarea>
							</td>
			    		</tr>
			    		<tr>
			    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="其他要求" />：</td>
			    			<td colspan="1" align="left">
								<button id="qualificationUploadFile" class="button-wrap">上传附件</button>
							</td>
			    		</tr>
			    	</tbody>
			      </table>
					</div>
					<!-- 资质审核 -->
					<div id="edit-line-qualify">
					     <main class="grid-container">
							<div class="grid-100">
								<table id="qualify-table"></table>
							</div>
					  </main>
					</div>
				</div>
			</div>
		</div>
		<div class="fixed-dialog" id = "fillOpinion">
			<div class="dialog-tip bg-common">
				<div class="dialog-close-btn"></div>
				<div class="tip-head">
					<img class="icon" src="../../icon/els.PNG" /> <span
						id="dialogTitle"><i18n:I18n key="i18n_title_fillOpinion" defaultValue="填写审批意见" /></span>
				</div>
				<div>
					<div class="box-wrap pos-relative bg-common">
						<div class="common-box-line">
							<textarea id="auditOpinion" name="auditOpinion" style="width:95%;" rows="5" maxlength="200"></textarea>
							<div class="mt-20">
								<button id="btnFileOK1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_pass" defaultValue="审批通过" /></button>
								<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_notpass" defaultValue="审批拒绝" /></button>
								<button id="btnFileCancel1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
		
<!-- 	<div class="fixed-dialog" id="addFileDialog"> -->
<!-- 		<div class="dialog-tip bg-common" style="width: 353px;height: 200px;margin-left: -251px;margin-top: -190px;"> -->
<!-- 			<div class="dialog-close-btn"></div> -->
<!-- 			<div class="tip-head"> -->
<!-- 				<img class="icon" src="../../icon/els.PNG" /> -->
<%-- 				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span> --%>
<!-- 			</div> -->
<!-- 			<div> -->
<!-- 				<div class="box-wrap pos-relative bg-common"> -->
<%-- 					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span> --%>
<!-- 					<div class="common-box-line"> -->
<!-- 						<div class="input-and-tip"> -->
<%-- 							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件名称" />：</span> --%>
<!-- 							<select id="fileClass" name="fileClass"> -->
<!-- 								<option value="1">招标文件</option> -->
<!-- 								<option value="2">报名文件</option> -->
<!-- 								<option value="3">投标文件</option> -->
<!-- 								<option value="4">澄清答疑文件</option> -->
<!-- 								<option value="5">评标文件</option> -->
<!-- 								<option value="6">保证金文件</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 						<div class="input-and-tip"> -->
<%-- 							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span> --%>
<!-- 							<input id="fileName" name="fileName" type="text" /> -->
<!-- 						</div> -->
<!-- 						<div class="input-and-tip"> -->
<!-- 							<span><div id="btnFileUpload" class="btn btnUpload btnFileUpload"> -->
<%-- 							<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /> --%>
<!-- 							</div></span> -->
<!-- 							<input id="filePath" name="filePath" type="hidden" /> -->
<!-- 							<input id="fileSize" name="fileSize" type="hidden" /> -->
<!-- 							<input id="fileType" name="fileType" type="hidden" /> -->
<!-- 							<input id="fileQ" name="fileQ" type="hidden" /> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="mt-20"> -->
<%-- 						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button> --%>
<%-- 						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
<!-- 	<div class="fixed-dialog" id="addFileDialog1"> -->
<!-- 		<div class="dialog-tip bg-common btnFormUpload" style="width: 353px;height: 200px;margin-left: -251px;margin-top: -190px;"> -->
<!-- 			<div class="dialog-close-btn"></div> -->
<!-- 			<div class="tip-head"> -->
<!-- 				<img class="icon" src="../../icon/els.PNG" /> -->
<%-- 				<span id="dialogTitle1"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span> --%>
<!-- 			</div> -->
<!-- 			<div> -->
<!-- 				<div class="box-wrap pos-relative bg-common"> -->
<%-- 					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span> --%>
<!-- 					<div class="common-box-line"> -->
<!-- 						<div class="input-and-tip"> -->
<%-- 							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件名称" />：</span> --%>
<!-- 							<select id="fileClass1" name="fileClass1"> -->
<!-- 								<option value="1">招标文件</option> -->
<!-- 								<option value="2">报名文件</option> -->
<!-- 								<option value="3">投标文件</option> -->
<!-- 								<option value="4">澄清答疑文件</option> -->
<!-- 								<option value="5">评标文件</option> -->
<!-- 								<option value="6">保证金文件</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 						<div class="input-and-tip"> -->
<%-- 							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span> --%>
<!-- 							<input id="fileName1" name="fileName1" type="text" /> -->
<!-- 						</div> -->
<!-- 						<div class="input-and-tip"> -->
<!-- 							<span><div id="btnFormUpload" class="btn btnUpload"> -->
<%-- 							<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /> --%>
<!-- 							</div></span> -->
<!-- 							<input id="filePath1" name="filePath1" type="hidden" /> -->
<!-- 							<input id="fileSize1" name="fileSize1" type="hidden" /> -->
<!-- 							<input id="fileType1" name="fileType1" type="hidden" /> -->
<!-- 							<input id="fileQ1" name="fileQ1" type="hidden" /> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="mt-20"> -->
<%-- 						<button id="btnFormOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button> --%>
<%-- 						<button id="btnFormCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
<!-- 	<div class="fixed-dialog" id="selectBiddingProjectNumberDialog" > -->
<!-- 	<div class="dialog-tip bg-common" style="width: 1200px;height:auto;margin-left: -600px;margin-top: -270px;"> -->
<!-- 	    <div class="dialog-close-btn" id="selectBiddingProjectNumberDialogClose"></div> -->
<!--         <div class="tip-head"> -->
<!-- 	        <img class="icon" src="../../icon/els.PNG" /> -->
<%-- 	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span> --%>
<!-- 	    </div> -->
<!-- 	    <div> -->
<!-- 	    	 <div class="box-wrap pos-relative bg-common"> -->
<%-- 			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span> --%>
<!-- 			<div class="common-box-line"> -->
<!-- 				<div class="dis-in-b input-and-tip"> -->
<%-- 					<span><i18n:I18n key="i18n_projectManage_projectNumber" defaultValue="项目编号" />:</span> --%>
<!-- 					<input type="text" id="projectNumber" name="projectNumber" /> -->
<!-- 				</div> -->
<!-- 				<div class="dis-in-b input-and-tip"> -->
<%-- 					<span><i18n:I18n key="i18n_projectManage_projectDesc" defaultValue="项目描述" />:</span> --%>
<!-- 					<input type="text" id="projectDesc" name="projectDesc" /> -->
<!-- 				</div> -->
<!-- 				<div class="dis-in-b input-and-tip"> -->
<%-- 					<span><i18n:I18n key="i18n_projectManage_projectLeader" defaultValue="项目负责人" />:</span> --%>
<!-- 					<input type="text" id="projectLeader" name="projectLeader" /> -->
<!-- 				</div> -->
<!-- 				<div class="dis-in-b input-and-tip"> -->
<%-- 					<span><i18n:I18n key="i18n_projectManage_projectStatus" defaultValue="项目状态" />:</span> --%>
<!-- 					<select id="projectStatus" name="projectStatus"> -->
<!-- 						<option value="">请选择</option> -->
<!-- 						<option value="0">新建</option> -->
<!-- 						<option value="1">进行中</option> -->
<!-- 						<option value="2">完成</option> -->
<!-- 						<option value="3">关闭</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 				<br> -->
<!-- 				<div class="dis-in-b input-and-tip"> -->
<%-- 					<span><i18n:I18n key="i18n_projectManage_projectCreateDate" defaultValue="项目创建日期" />:</span> --%>
<%-- 	                <input type="radio" name="dateArea" value="lastMonth" checked="checked"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" /> --%>
<%-- 	                <input type="radio" name="dateArea" value="lastThreeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" /> --%>
<%-- 	                <input type="radio" name="dateArea" value="defineDateArea"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" /> --%>
<!-- 				</div> -->
<!--                 <div class="dis-in-b input-and-tip" style="display:none;"> -->
<!--                 	<input type="text" class="Wdate" onfocus="WdatePicker()" id="startCreateDate" name="startCreateDate"/> -->
<!--                 </div> -->
<!--                 <div class="dis-in-b input-and-tip" style="display:none;"> -->
<%-- 	                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span> --%>
<!-- 	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="endCreateDate" name="endCreateDate" /> -->
<!--                 </div> -->
<%--                 <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	        <div class="box-wrap pos-relative bg-common"> -->
<!-- 	            <main class="bg-common p-6"> -->
<!--                     <div class="grid-100" > -->
<!--                         <table id="headTable"></table> -->
<!--                     </div> -->
<!--                     <div class="mt-40 text-center" style="margin-top: 14px;"> -->
<%-- 	                    <button id="selectBiddingProjectNumberOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button> --%>
<%-- 	                    <button id="selectBiddingProjectNumberCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button> --%>
<!-- 	                </div> -->
<!--                  </main> -->
<!-- 	        </div> -->
<!-- 	    </div> -->
<!--     </div> -->
<!-- </div> -->
	
<script type="text/javascript">
var auditType = "${param.auditType}";
var phasesTable;//标段mmgrid 表实体
var phasesRoundTable;//各阶段轮次 mmgrid 表实体
var biddingStatus ="<%=request.getParameter("biddingStatus") %>";
var hbiddingStatus ="<%=request.getParameter("hbiddingStatus") %>";
var businessElsAccount ="<%=request.getParameter("businessElsAccount") %>";
var biddingNumber ="<%=request.getParameter("biddingNumber") %>";
var stretegyCode ="<%=request.getParameter("stretegyCode") %>";
var flowCode ="<%=request.getParameter("flowCode") %>";
var businessType ="<%=request.getParameter("businessType") %>";
var type ="<%=request.getParameter("type") %>";
var materialAttrList = [];
var biddingDetailContentGrid;
var totalRoundArr=[];
$().ready(function(){
debugger;
	// 切换标签页时进行判断，暂作废
	$("#add-enq-sheet ul li").each(function(index){
        $(this).click(function(){
			var curUlLiTagIndex = $("body").data("curUlLiTag_local");
			if(curUlLiTagIndex==4) {
				// 招标内容判断评标权重必须是100
			}
			$("#add-enq-sheet .titsh").removeClass("titsh");
			$(this).addClass("titsh");
			$("body").data("curUlLiTag_local",index);
        });
    });
	$(".add-line-apply").hide();
	$(".edit-line-qualify").hide();
	$("#controlBidding").hide();
	$('#add-enq-sheet').tabs();
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	$(".tag-isShow").hide();
	$(".publish-isShow").hide();
	$("#supplierSend").hide();
	$("#selectBiddingProjectNumberDialog").hide();
	$.ajax({
		url : "<%=basePath%>rest/PurchaseBiddingService/queryEnterpriseInfo",
		type : "post",
		contentType : "application/json",
		dataType : "json",
		data : JSON.stringify({"elsAccount":elsAccount}),
		success : function(data) {
			if (data&&data.statusCode == "-100") {
			     alert(data.message,3);
			 } else {
				 if(data != null){
					 $("#orgName").val(data.orgName);
						$("#principal").val(username);
						$("#telephone").val(data.telephone);
						$("#email").val(data.email);
						$("#fax").val(data.fax);
						$("#bidding-address").val(data.address);
				}
			}
		},
		error : function(data) {
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
	initUpdatePage();
});
//修改操作时执行此方法
function initUpdatePage(){
	if(biddingNumber == "null" || biddingNumber == ""){
		var currDate = new Date().format("yyyy-MM-dd");
		$("#margin_payBeginDate").val(currDate);
		$("#margin_payEndDate").val(currDate);
		$("#contentDeliveryStartDate").val(currDate);
		$("#contentDeliveryEndDate").val(currDate);
		return;
	}
	$(".tag-isShow").show();
	if(hbiddingStatus < 2){//新建或者变更
		$(".publish-isShow").show();
	}else{
		$("#supplierSend").show();
		$(".save-isShow").hide();
		$(":input:not('#exitBtn')").attr("disabled",true);
		$("#importByMaterial").hide();
		$("#supplierStatusUpdate").attr("disabled",false);
		$("#btnFileOK1").attr("disabled",false);
		$("#auditOpinion").attr("disabled",false);
		$(".dialog-close-btn").attr("disabled",false);
		$("#btnFileOK2").attr("disabled",false);
		$("#btnFileCancel1").attr("disabled",false);
		$("#passBtn").attr("disabled",false);
		$("#noPassBtn").attr("disabled",false);
		$("#flowBtn").attr("disabled",false);
		$("#supplierSend").attr("disabled",false);
		////////////////////////////////////////////////////////////////////
		$("#plan_distinguishPhases").attr("disabled",false);
		$("#margin_distinguishPhases").attr("disabled",false);
		$("#contentBiddingItemNumber").attr("disabled",false);
		$("#supplier_distinguishPhases").attr("disabled",false);
		$("#supplier_section_list").attr("disabled",false);
		$("#fileBiddingItemNumber").attr("disabled",false);
		$("#fileBiddingItemNumber1").attr("disabled",false);
		$("#fileRoundNumber").attr("disabled",false);
		$("#fileRoundNumber1").attr("disabled",false);
		//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	}
	var param = {"elsAccount":elsAccount,"biddingNumber":biddingNumber};
	$.ajax({
		url :"<%=basePath%>rest/PurchaseBiddingService/loadBidding",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(param),
		success : function(data) {
			//加载基本信息----beigin----
			$("#biddingName").val(data.biddingName);
			$("#biddingNumber").val(data.biddingNumber);
			$("#biddingType").val(data.biddingType);
			$("#biddingType").attr("disabled",true);
			if(data.biddingType == "1" || data.biddingType == "3" || data.biddingType == "5" || data.biddingType == "6"){//公开招标
				$("#isPublishInfo").attr("disabled",true);
			}
			$("input[name='biddingClass']").eq(data.biddingClass).attr("checked",'checked');
			$("#biddingProjectNumber").val(data.biddingProjectNumber);
			$("#budgetAmount").val(data.budgetAmount);
			$("#currency").val(data.currency);
			$("#fundSource").val(data.fundSource);
			$("#biddingStatus").val(data.biddingStatus);
			if(data.preAuditStatus != "2"){
				$("#passBtn").hide();
				$("#noPassBtn").hide();
			}
			$("#preAuditStatus").val(data.preAuditStatus);
			$("#auditStatus").val(data.auditStatus);
			$("#header_summary").val(data.summary);
			$("#sendResultInfo").val(data.fbk1);
			if(data.publish == "1"){ //是否发布到企业控件
				$("#isPublishInfo").attr("checked","checked");
			}
			$("#biddingPhases").val(data.biddingItemCount);
			$("#biddingPhases").attr("disabled",true);
			var biddingPhasesItems = data.biddingPhasesItems;
			if(biddingPhasesItems != null && biddingPhasesItems.length > 1){
				phasesTable=$('#phases-table').mmGrid({
				    cols: phasesTableCols,
				    items:biddingPhasesItems,
				    height: 140,
				    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
				});
			}
			//加载基本信息----end----
			
			//加载联系方式----beigin----
			var biddingLinkmanVOs = data.biddingLinkmanVOs;
			if(typeof(biddingLinkmanVOs)!="undefined") {
				for(var i = 0 ; i < biddingLinkmanVOs.length ; i ++){
					linkMan = biddingLinkmanVOs[i];
					var linkmanType = linkMan.linkmanType;
					if(linkmanType == 0){//是否代理招标单位 
						$("#orgName").val(linkMan.orgName);
						$("#principal").val(linkMan.principal);
						$("#telephone").val(linkMan.telephone);
						$("#email").val(linkMan.email);
						$("#fax").val(linkMan.fax);
						$("#bidding-address").val(linkMan.address);
					}else{
						$("#dl_orgName").val(linkMan.orgName);
						$("#dl_principal").val(linkMan.principal);
						$("#dl_telephone").val(linkMan.telephone);
						$("#dl_email").val(linkMan.email);
						$("#dl_fax").val(linkMan.fax);
						$("#dl_address").val(linkMan.address);
					}
				}
			}
			//加载联系方式----end----
			
			//加载招标方式----beigin----
			var cols;
			if(data.biddingType == "2" || data.biddingType == "3"){ //在线竞标
				cols = phasesRoundOnlineCols;
			    $(".date-unit").html("分钟");
			    $(".isShow-isSecrecy").hide();
			}else{
				cols = phasesRoundCols;
				$(".date-unit").html("天");
			}

			var biddingRoundItms = data.biddingRoundItms;
			if(biddingRoundItms &&  biddingRoundItms.length>0){
				var multiSection = biddingRoundItms[0].multiSection;//获取轮次列表中任意一条数据，查看招标计划是否区分标段
				$("input[name='biddingRoundsVO[multiSection]']").attr("disabled",true);
				var roundItem;
				var roundItems = [];
				if(multiSection == 0){//不区分标段
					$("input[name='biddingRoundsVO[multiSection]']").eq(0).attr("checked",'checked');
					$("#plan_distinguishPhases").attr("disabled",true);
					roundItem = biddingRoundItms[0];
					roundItems = biddingRoundItms;
					fileTempData = {itemNumber:0,totalRound:roundItem.roundsNumber};
					totalRoundArr.push(fileTempData);
				}else{
					$("input[name='biddingRoundsVO[multiSection]']").eq(1).attr("checked",'checked');
					$("body").data("biddingRounds",biddingRoundItms);//在body上绑定一个key为biddingRounds，值为招标轮次的所有信息对象
					for(var i = 0 ; i < biddingPhasesItems.length ; i ++){
						var item = biddingPhasesItems[i];
						var biddingItemName = item.biddingItemName;
						var biddingItemNumber = item.biddingItemNumber;
						var option = '<option value="'+biddingItemNumber+'">标段'+biddingItemNumber+" "+biddingItemName+'</option>';
						$("#plan_distinguishPhases").append(option);
					}
					$("#plan_distinguishPhases").val("1");//默认选择标段1
					$("body").data("plan_distinguishPhases","1");
					$("#plan_distinguishPhases option[value='0']").attr("disabled",true);
					for(var i = 0 ; i < biddingRoundItms.length ; i ++){
						var biddingItemNumber = biddingRoundItms[i].biddingItemNumber;
						if(biddingItemNumber == "1"){//第一标段数据
							roundItems.push(biddingRoundItms[i]);
							roundItem = biddingRoundItms[i];
						}
					}
					
					for(var i=0;i<biddingRoundItms.length;i++){
						var tempData = {itemNumber:biddingRoundItms[i].biddingItemNumber,totalRound:biddingRoundItms[i].roundsNumber};
						totalRoundArr.push(tempData);
					}
				}
				
				$("#totalRound").val(roundItem.totalRound);
				$("#duration").val(roundItem.duration);
				$("#intervalType").val(roundItem.intervalType);
				$("#plan_beginDate").val(new Date(roundItem.biddingBeginDate).format('yyyy-MM-dd'));
				$("#plan_beginTime").val(roundItem.biddingBeginTime);
				$("#fbk1").val(roundItem.fbk1);
				$("input[name='biddingRoundsVO[secret]']").eq(roundItem.secret).attr("checked",'checked');
				//初始化phasesRoundTable
				phasesRoundTable = $('#phases-round-table').mmGrid({
				    cols: cols,
				    items : roundItems,
				    height: 240,
				    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
				});
				phasesRoundTable.on("loadSuccess",function(e, data) {
					if(hbiddingStatus > 1){
						$("#phases-round-table :text").each(function(){
							$(this).attr("disabled",true);
						});
					}
				});
			}
			
			//加载招标方式----end-------
			//加载保证金----begin-------
			var biddingMarginVOs = data.biddingMarginVOs;
			if(biddingMarginVOs &&  biddingMarginVOs.length>0){
				var multiSection = biddingMarginVOs[0].multiSection;//获取保证金列表中任意一条数据，查看保证金是否区分标段
				$("input[name='biddingMarginVO[multiSection]']").attr("disabled",true);
				var margin ;
				
				if(multiSection == 0 || multiSection == null){
					$("input[name='biddingMarginVO[multiSection]']").eq(0).attr("checked",'checked');
					$("#margin_distinguishPhases").attr("disabled",true);
					margin = biddingMarginVOs[0];
				}else{
					$("input[name='biddingMarginVO[multiSection]']").eq(1).attr("checked",'checked');
					$("body").data("biddingMargins",biddingMarginVOs);
					for(var i = 0 ; i < biddingPhasesItems.length ; i ++){
						var item = biddingPhasesItems[i];
						var biddingItemName = item.biddingItemName;
						var biddingItemNumber = item.biddingItemNumber;
						var option = '<option value="'+biddingItemNumber+'">标段'+biddingItemNumber+" "+biddingItemName+'</option>';
						$("#margin_distinguishPhases").append(option);
					}
					$("#margin_distinguishPhases").val("1");//默认选择标段1
					$("body").data("margin_distinguishPhases","1");
					$("#margin_distinguishPhases option[value='0']").attr("disabled",true);
					for(var i = 0 ; i < biddingMarginVOs.length ; i ++){
						var biddingItemNumber = biddingMarginVOs[i].biddingItemNumber;
						if(biddingItemNumber == "1"){//第一标段数据
							margin = biddingMarginVOs[i];
						}
					}
				}
				$("input[name='biddingMarginVO[collect]']").eq(margin.collect).attr("checked",'checked');
				$("input[name='biddingMarginVO[back]']").eq(margin.back).attr("checked",'checked');
				$("#margin_amount").val(margin.amount);
				$("#margin_currencyType").val(margin.currency);
				$("#margin_remark").val(margin.remark);
				debugger;
				if(margin.payBeginDate != null && margin.payBeginDate != ""){
					$("#margin_payBeginDate").val(new Date(margin.payBeginDate).format('yyyy-MM-dd'));					
				}
				if(margin.payEndDate != null && margin.payEndDate != ""){
					$("#margin_payEndDate").val(new Date(margin.payEndDate).format('yyyy-MM-dd'));					
				}
				$("body").data("init_margin_flag",true);//设置成已经初始化
			}
			if(biddingStatus == 0 || biddingStatus == 2){
				$("#margin_amount").attr("readonly",false);
				$("#margin_payBeginDate").attr("disabled",false);
				$("#margin_payEndDate").attr("disabled",false);
				$("#margin_remark").attr("readonly",false);
			}
			//加载保证金----end-------
			
			//加载招标内容----begin-------
			var biddingContentVOs = data.biddingContentVOs;
			var biddingContentItemVOs = data.biddingContentItemVOs;
			var biddingContentStandardVOs = data.biddingContentStandardVOs;
			var setBiddingContent;

			if(biddingContentVOs &&  biddingContentVOs.length>0){
				 var setItemNumberObj = $("#contentBiddingItemNumber");
				 var biddingPhases = $("#biddingPhases");
				 var biddingPhasesValue = biddingPhases.val();
				 if(biddingPhasesValue=="1"){
					 setItemNumberObj.empty();
					 setItemNumberObj.append("<option value='0'>"+biddingPhases.find("option:selected").text()+"</option>");					 
					 if(!$.isArray(biddingContentItemStandardArray)){
				 		biddingContentItemStandardArray= new Array(0);
					 }
					 setBiddingContent=biddingContentVOs[0];
					 for(var i=0;i<biddingContentItemVOs.length;i++){
						 contentItemArray.push(biddingContentItemVOs[i]);
					 }
					 for(var i=0;i<biddingContentStandardVOs.length;i++){
						 contentStandardArray.push(biddingContentStandardVOs[i]);
					 }
					 biddingContentVOs["biddingContentItem"]=biddingContentItemVOs;
					 biddingContentVOs["biddingContentStandard"]=biddingContentStandardVOs;
					 biddingContentItemStandardArray[0]=biddingContentVOs;
					 if(setBiddingContent.fbk1 == "0"){
						 $("input[name='controlBidding']:eq(0)").attr("checked","checked");
					 }else{
						 $("input[name='controlBidding']:eq(1)").attr("checked","checked");						 
					 }
				 }else {
					 setItemNumberObj.empty();
					 for(var i=0;i<biddingPhasesItems.length;i++){
						 setItemNumberObj.append("<option value='"+biddingPhasesItems[i].biddingItemNumber+"'>"+biddingPhasesItems[i].biddingItemName+"</option>");
					 }
					 if(!$.isArray(biddingContentItemStandardArray)){
				 		biddingContentItemStandardArray= new Array(biddingContentVOs.length);
					 }
					 
					 for(var i=0;i<biddingContentVOs.length;i++){
						 if(biddingContentVOs[i].biddingItemNumber==1){
							 setBiddingContent=biddingContentVOs[i];
						 }
					 }
					 
					 for(var j=0;j<biddingContentItemVOs.length;j++){
						 if(biddingContentItemVOs[j].biddingItemNumber==1){
							 biddingContentItemVOs[j].deliveryDate=new Date(biddingContentItemVOs[j].deliveryDate).format('yyyy-MM-dd');
							 contentItemArray.push(biddingContentItemVOs[j]);
						 }
					 }
					 
					 for(var i=0;i<biddingContentStandardVOs.length;i++){
						 if(biddingContentStandardVOs[i].biddingItemNumber==1){
							 contentStandardArray.push(biddingContentStandardVOs[i]);
						 }
					 } 
					 
					 for(var i=0;i<biddingContentItemStandardArray.length;i++){
						 var contentA = biddingContentVOs[i];
						 var contentI = new Array();
						 var contentS = new Array();
						 for(var j=0;j<biddingContentItemVOs.length;j++){
							 if(biddingContentItemVOs[j].biddingItemNumber==(i+1)){
								 contentI.push(biddingContentItemVOs[j]);
							 }
						 }
						 for(var k=0;k<biddingContentStandardVOs.length;k++){
							 if((i+1)==biddingContentStandardVOs[k].biddingItemNumber){
								 contentS.push(biddingContentStandardVOs[k]);
							 }
						 } 
						 contentA["biddingContentItem"]=contentI;
						 contentA["biddingContentStandard"]=contentS;
						 biddingContentItemStandardArray[i]=contentA;
						 biddingContentItemStandardArray[i]["deliveryStartDate"] = new Date(biddingContentItemStandardArray[i].deliveryStartDate).format('yyyy-MM-dd');
						 biddingContentItemStandardArray[i]["deliveryEndDate"] = new Date(biddingContentItemStandardArray[i].deliveryEndDate).format('yyyy-MM-dd');
					 }
					 $("#contentBiddingItemNumber").val("1");//默认选择标段1
					 $("body").data("contentBiddingItemNumber_local","1");
				 }
				 $("#contentSummary").val(setBiddingContent.summary);
			 	 $("#contentBiddingProjectNumber").val(setBiddingContent.biddingProjectNumber);
				 $("#contentBiddingProjectName").val(setBiddingContent.biddingProjectName);
				 $("#contentDeliveryStartDate").val(new Date(setBiddingContent.deliveryStartDate).format('yyyy-MM-dd'));
				 $("#contentDeliveryEndDate").val(new Date(setBiddingContent.deliveryEndDate).format('yyyy-MM-dd'));
				 $("#contentAddress").val(setBiddingContent.address);
				 $("#contentQuality").val(setBiddingContent.quality);
				 if(biddingContentItemVOs != null && biddingContentItemVOs.length > 0){
					 biddingDetailContentGrid=$('#biddingDetailContentTable').mmGrid({
					    cols: biddingDetailContentItem,
					    items:contentItemArray,
					    height: 140,
					    checkCol:true,
				        multiSelect:true,
				        //hasJsonOption : "extendFields",
					    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
					});
				 	biddingDetailContentGrid.on("loadSuccess",function(e, data) {
						if(hbiddingStatus > 1){
							$("#biddingDetailContentTable :input").each(function(){
								$(this).attr("readonly",true);
							});
							$("#biddingDetailContentTable .uploadFile-item").each(function(){
								$(this).attr("hidden",true);
							});
							$("#biddingDetailContentTable .uploadImage-item").each(function(){
								$(this).attr("hidden",true);
							});
						}
					});
					if(hbiddingStatus < 2) {
					 	biddingDetailContentGrid.on("cellSelected",function(e, item, rowIndex, colIndex){
					    	var colsObj = biddingDetailContentGrid.opts.cols;
					    	var thisColName = colsObj[colIndex].name;
					    	if("requirementTypeCode"==thisColName){
					    		selectRequirementTypeCode(rowIndex);//弹出选择需求类型页面进行选择
					    	} else if("materialNumber"==thisColName){
					    		selectMaterialNumber(rowIndex);//弹出物料选择页面进行选择
					    	} else {
					    		//do nothing
					    	}
					    });
					}
				  }
				 if(biddingContentItemVOs != null && biddingContentItemVOs.length > 0){
					 biddingStandardGrid=$('#biddingStandardTable').mmGrid({
					    cols: biddingStandardItem,
					    items:contentStandardArray,
					    height: 140,
					    checkCol:true,
				        multiSelect:true,
					    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
					});
					 biddingStandardGrid.on("loadSuccess",function(e, data) {
						if(hbiddingStatus > 1){
							$("#biddingStandardTable :input").each(function(){
								$(this).attr("readonly",true);
							});
						}
					});
				  }				
			}
			//加载招标内容----end-------
			
			//加载表单文件----begin-------
			var fileVOs =data.biddingFileVOs;
			if(fileVOs &&  fileVOs.length>0){
				console.log(fileVOs);
				editFileTable=$('#add-file-project').mmGrid({
				    cols: file_cols,
				    items:fileVOs,
				    height: 320,
				    checkCol:true,
			        multiSelect:true,
				    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
				});
			}
			//加载表单文件----end-------
			
			//加载回签表单----begin-------
			var formVOs =data.biddingFormVOs;
			if(formVOs &&  formVOs.length>0){
				console.log(formVOs);
				editFormTable=$('#sign-form-project').mmGrid({
				    cols: file_cols,
				    items:formVOs,
				    height: 320,
				    checkCol:true,
			        multiSelect:true,
				    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
				});
			}
			//加载回签表单----end-------
			
			//加载招标条件----begin-------
			 var qualificationVOs =data.biddingQualificationVOs;
			if(qualificationVOs &&  qualificationVOs.length>0){
				 var multiSection = qualificationVOs[0].multiSection;
				 var setItemNumberObj = $("#qualificationBiddingItemNumber");
				  var biddingQualification;
				 if(multiSection==0){
					 $("input[name='biddingQualification[multiSection]']").eq(0).attr("checked",'checked');
					 $("input[name='biddingQualification[multiSection]").attr("disabled",true);
					 $("#qualificationBiddingItemNumber").attr("disabled",true);
					 setItemNumberObj.empty();
					 setItemNumberObj.append("<option value='0'>"+biddingPhases.find("option:selected").text()+"</option>");
					 if(!$.isArray(biddingQualificationArray)){
						 biddingQualificationArray= new Array(0);
					 }
					 biddingQualification=qualificationVOs[0];
				 }else {
					 $("input[name='biddingQualification[multiSection]']").eq(1).attr("checked",'checked');
					 setItemNumberObj.empty();
					 for(var i=0;i<qualificationVOs.length;i++){
						 setItemNumberObj.append("<option value='"+biddingPhasesItems[i].biddingItemNumber+"'>"+biddingPhasesItems[i].biddingItemName+"</option>");
					 }
					 if(!$.isArray(biddingQualificationArray)){
				 		biddingQualificationArray= new Array(qualificationVOs.length);
					 }
					 for(var i=0;i<qualificationVOs.length;i++){
						 if(qualificationVOs[i].biddingItemNumber==1){
						 	biddingQualification=qualificationVOs[i];
						 }
						 biddingQualificationArray[i]=qualificationVOs[i];
					 }
					$("#qualificationBiddingItemNumber").val("1");//默认选择标段1
					$("body").data("qualificationBiddingItemNumber_local","1");
					$("body").data("qualificationIndex_local",setItemNumberObj.get(0).selectedIndex);
				 }
				 $("#qualificationRegisterEndDate").val(new Date(biddingQualification.registerEndDate).format('yyyy-MM-dd'));
				 $("#qualificationRegisterEndTime").val(biddingQualification.registerEndTime);
				 $("#qualificationCapital").val(biddingQualification.capital);
				 $("#qualificationJointBidding").val(biddingQualification.jointBidding);
				 $("#qualificationQualification").val(biddingQualification.qualification);
				 $("#qualificationDeliverability").val(biddingQualification.deliverability);
				 $("#qualificationAuthentication").val(biddingQualification.authentication);
				 $("#qualificationRemark").val(biddingQualification.remark);
			} 
			//加载招标条件----end-------
			
			//加载资质审核信息
			qualifyTable = $('#qualify-table').mmGrid({
			    cols: qualifyTableCols,
			    items:data.biddingApplicationVOs,
			    height: 240,
			    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
			});
			
			//加载供应商信息
			if(data.biddingSupplierVOs && data.biddingSupplierVOs.length>0){
				setBiddingSupplierVOs(data.biddingSupplierVOs);
				//initFriend();
				
				var multiSection = data.biddingSupplierVOs[0].multiSection;//获取供应商列表中任意一条数据，查看供应商是否区分标段
				$("input[name='biddingSupplierVO[multiSection]']").attr("disabled",true);
				
				$("#supplier_distinguishPhases").html(""); 
				$("#supplier_section_list").html(""); 
				
				if(multiSection == 0){
					$("input[name='biddingSupplierVO[multiSection]']").eq(0).attr("checked",'checked');
					$("#supplier_distinguishPhases").attr("disabled",true);
					$("#supplier_section_list").attr("disabled",true);
					
					var option = '<option value="0">不划分标段</option>';
					$("#supplier_distinguishPhases").append(option);
					$("#supplier_section_list").append(option);
				}else{
					$("input[name='biddingSupplierVO[multiSection]']").eq(1).attr("checked",'checked');

					for(var i = 0 ; i < biddingPhasesItems.length ; i ++){
						var item = biddingPhasesItems[i];
						var biddingItemName = item.biddingItemName;
						var biddingItemNumber = item.biddingItemNumber;
						var option = '<option value="'+biddingItemNumber+'">标段'+biddingItemNumber+" "+biddingItemName+'</option>';
						$("#supplier_distinguishPhases").append(option);
						$("#supplier_section_list").append(option);
					}
					$("#supplier_distinguishPhases").val("1");//默认选择标段1
					$("#supplier_section_list").val("1");//默认选择标段1
					$("body").data("supplier_distinguishPhases","1");
					$("#supplier_distinguishPhases option[value='0']").attr("disabled",true);
					$("#supplier_section_list option[value='0']").attr("disabled",true);

				}
				
			    if(!biddingSupplierListTable){
			    	
			        biddingSupplierListTable = $('#supplier_list_table').mmGrid({
			    	    cols: supplierListTableCols,
			    	    items:getSupplierFromCash($("#supplier_section_list").val()),
			    	    height: 240,
			    	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
			    	});
			    }else{
			    	var vos=getSupplierFromCash($("#supplier_section_list").val());
			    	biddingSupplierListTable.load(vos);
			    }
			}
			
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
			parent.elsDeskTop.hideLoading();
            alert("加载招投标信息失败:"+exception,3); 
        }
	});
}



$("#exitBtn").click(function(){
	debugger;
	if(type=="add"){
// 		parent.elsDeskTop.closeCurWin('auditPreBidding',callBack);//退出当前页面并执行父页面的查询方法
	}else{
		top.elsDeskTop.closeCurWin('auditPreBidding');//仅退出当前页面
	}
});

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_biddingPurchaseManage']) {
		parent.frames['iframeApp_biddingPurchaseManage'].purchQuery();
	}
}

//*********************************修改部分开始******************************//
//点击项目编号弹出框，选择已审批完成的项目
$("#biddingProjectNumber").click(function(){
	showSelectBiddingProjectNumber();
});
var renderFormatDate = function(val,item,rowIndex){
	if("undefined"==typeof(val) || "" == val){
		return "";
	} else {
		return new Date(val).format("yyyy-MM-dd");
	}
};

var renderFormatStatus = function(val,item,rowIndex){
	if("0"==val){
		return "新建";
	} else if("1"==val){
		return "进行中";
	} else if("2"==val){
		return "完成";
	} else if("3"==val){
		return "关闭";
	} else {
		return "";
	}
};
var renderFormatApprove = function(val,item,rowIndex){
	if("0"==val){
		return "审批通过";
	} else if("1"==val){
		return "未审批";
	} else if("2"==val){
		return "审批中";
	} else if("3"==val){
		return "审批拒绝";
	} else {
		return "";
	}
};
var headCols = [
	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
	{ title:"项目描述", name:"projectDesc", width:100, align:"center"},
	{ title:"项目概述", name:"projectSummary", width:100, align:"center"},
	{ title:"外部参考项目编号", name:"refProjectNumber", width:100, align:"center"},
	{ title:"项目类型", name:"projectType", width:100, align:"center"},
	{ title:"项目状态", name:"projectStatus" , width:100, align:"center",renderer:renderFormatStatus},
	{ title:"项目总负责人", name:"projectLeader" , width:100, align:"center"},
	{ title:"审批状态", name:"auditStatus" , width:100, align:"center",renderer:renderFormatApprove},
	{ title:"项目客户名称", name:"customerDesc" , width:100, align:"center"},
	{ title:"项目地址", name:"projectAddress" , width:100, align:"center"},
	{ title:"币别", name:"currency" , width:100, align:"center"},
	{ title:"预算金额", name:"budgetAmount" , width:100, align:"center"},
	{ title:"实际金额", name:"actualAmount" , width:100, align:"center"},
	{ title:"计划周期(天)", name:"planCycle" , width:100, align:"center"},
	{ title:"实际周期(天)", name:"actualCycle" , width:100, align:"center"},
	{ title:"计划开始日期", name:"planStartDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"计划结束日期", name:"planEndDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"实际开始日期", name:"actualStartDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"实际结束日期", name:"actualEndDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"备注", name:"remark" , width:100, align:"center"},
	{ title:"创建人", name:"createUser" , width:100, align:"center"},
	{ title:"流程编码", name:"flowCode", width:100, align:"center",hidden:true}
];
var headGrid;
function showSelectBiddingProjectNumber(){
	$("#selectBiddingProjectNumberDialog").show();
	headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryBiddingSelectProjectHead",
		method :  "POST",
		autoLoad : false,
		cols : headCols,
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
	    checkCol : true,
	    indexCol : false,
	});
	refreshData();
}
//查询
$("#queryBtn").click(function(){
	refreshData();
});
function refreshData(){
	var projectNumber = $("#projectNumber").val();
	var projectDesc = $("#projectDesc").val();
	var projectLeader = $("#projectLeader").val();
	var projectStatus = $("#projectStatus").val();
	var startCreateDate = $("#startCreateDate").val();
	var endCreateDate = $("#endCreateDate").val();
	
	var parentId = "";
	
	var queryParam = {
    	elsAccount : elsAccount,
    	projectNumber : projectNumber,
    	projectDesc : projectDesc,
    	projectLeader : projectLeader,
    	projectStatus : projectStatus,
    	startCreateDate : startCreateDate,
    	endCreateDate : endCreateDate,
    };
    //$.extend(headGrid.opts.params,queryParam);
    headGrid.load(queryParam);
}
if (auditType == "todo") {
	$(".todo").show();
	$(".done").hide();
} else {
	$(".todo").hide();
	$(".done").show();
}
//选择项目点击确定事件
$("#selectBiddingProjectNumberOKBtn").click(function(){
	var selectRow = headGrid.selectedRows()[0];
	var selectAuditStatus = selectRow["auditStatus"];
	if(selectAuditStatus == 0){		
		$("#biddingProjectNumber").val(selectRow["projectNumber"]);
		$("#budgetAmount").val(selectRow["budgetAmount"]);
		$("#selectBiddingProjectNumberDialog").hide();
	}else{
		alert("请选择审批完成的项目",2);
	}
});
$("#selectBiddingProjectNumberDialogClose").click(function(){
	$("#selectBiddingProjectNumberDialog").hide();
});

$("#selectBiddingProjectNumberCancelBtn").click(function(){
	$("#selectBiddingProjectNumberDialog").hide();
});
$("input[name='dateArea']").click(function(){
	var dateArea = $(this).val();
	var currDate = new Date();
	
	if("lastMonth" == dateArea){
		$("#startCreateDate").parent().hide();
		$("#endCreateDate").parent().hide();
		
	    var currDateMill = currDate.getTime();
		var startDate = new Date();
	    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
	    var currMonthMaxDay = startDate.getDate();//本月天数
	    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
	    
		$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
		$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
	} else if("lastThreeMonth" == dateArea){
		$("#startCreateDate").parent().hide();
		$("#endCreateDate").parent().hide();
		
		var currDateMill = currDate.getTime();
		var startDate = new Date();
	    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
	    var currMonthMaxDay = startDate.getDate();//本月天数
	    startDate.setMonth(currDate.getMonth(), 0);//上月最后一日
	    var lastMonthMaxDay = startDate.getDate();//上月天数
	    startDate.setMonth(currDate.getMonth()-1, 0);//前第二月最后一日
	    var last2MonthMaxDay = startDate.getDate();//前第二月天数
	    
	    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay+lastMonthMaxDay+last2MonthMaxDay-1));
		$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
		$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
	} else if("defineDateArea" == dateArea) {
		$("#startCreateDate").val("");
		$("#endCreateDate").val("");
		$("#startCreateDate").parent().show();
		$("#endCreateDate").parent().show();
	} else {//默认查最近一月
		$("#startCreateDate").parent().hide();
		$("#endCreateDate").parent().hide();
		
		var currDateMill = currDate.getTime();
		var startDate = new Date();
	    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
	    var currMonthMaxDay = startDate.getDate();//本月天数
	    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
	    
		$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
		$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
	}
});
//*********************************修改部分结束******************************//
<%-- 
var editFileTable;
var rightScroll;
var leftScroll;
var itemGrid;
var uploader;
var fileUploader;
var black={roundsNumber:"1",biddingBeginDate:"",a$3:"",biddingEndDate:"",a$5:"",biddingStatus:"0"};
//招标状态
function rendererBiddingStatus(val){
    	if(val==0){
    		return '<i18n:I18n key="test" defaultValue="未开始" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
    	}else if(val==1){
    		return '<i18n:I18n key="test" defaultValue="进行中" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
    	}else if(val==2){
    		return '<i18n:I18n key="test" defaultValue="已定标" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
    	}else if(val==3){
    		return '<i18n:I18n key="test" defaultValue="已完成" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
    	}
}
var cols_item = [
     			{title:'轮次',name:'roundsNumber', width: 120, align: 'center',renderer:function(val){
     				return "<span>"+val+"</span><input name='purchaseBiddingRoundsList[][roundsNumber]'  style='display:none;'  type='text' value='"+val+"'/>";
     			}},
     			{title:'投标开始日期',name:'biddingBeginDate', width: 160, align: 'center',renderer:function(val){
     				return '<input type="text" id="" name="purchaseBiddingRoundsList[][biddingBeginDate]"  class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
     			}},
     			{title:'投标结束日期', name:'biddingEndDate', width: 160, align: 'center',renderer:function(val){
     				return '<input type="text" id="" name="purchaseBiddingRoundsList[][biddingEndDate]"  class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
     			}},
     			{title:'状态',name:'biddingStatus', width: 120, align: 'center',renderer:rendererBiddingStatus}
     		];
var cols_item_online = [
      			{title:'轮次',name:'roundsNumber', width: 120, align: 'center',renderer:function(val){
      				return "<span>"+val+"</span><input name='purchaseBiddingRoundsList[][roundsNumber]'  style='display:none;'  type='text' value='"+val+"'/>";
      			}},
      			{title:'竞价开始时间',name:'biddingBeginDate', width: 160, align: 'center',renderer:function(val){
      				return "<span>"+val+'</span><input type="text" id="" name="purchaseBiddingRoundsList[][biddingBeginDate]" style="display:none;" class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
      			}},
      			{title:'竞价结束时间', name:'biddingEndDate', width: 160, align: 'center',renderer:function(val){
      				return "<span>"+val+'</span><input type="text" id="" name="purchaseBiddingRoundsList[][biddingEndDate]" style="display:none;" class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
      			}},
      			{title:'采购限价',name:'fbk1', width: 120, align: 'center',renderer:function(val){
      				return "<span>"+val+"</span><input name='purchaseBiddingRoundsList[][fbk1]' style='display:none;'  type='text' value='"+val+"'/>";
      			}},
      			{title:'降价幅度',name:'fbk2', width: 120, align: 'center',renderer:function(val){
      				return "<input name='purchaseBiddingRoundsList[][fbk2]'  onkeyup=\"value=value.replace(/[^(\\d\\.)]/g,'')\"  type='text' value='"+val+"'/>";
      			}},
      			{title:'幅度单位',name:'fbk3', width: 120, align: 'center',renderer:function(val){
      				var sel = "<select name='purchaseBiddingRoundsList[][fbk3]' ><option value='0' selected>金额</option><option value='1'>百分比</option></select>"
      				return sel;
      			}}
      		];
var contentGrid;
var content_item=[
	{title:'物料编号',name:'biddingProjectNumber', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][biddingProjectNumber]' type='text'  value='"+val+"'/>";
	}},     
	{title:'招标内容',name:'materialNumber', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][materialNumber]' type='text'  value='"+val+"'/>";
	}},     
	{title:'物料名称描述',name:'materialDesc', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][materialDesc]' type='text'  value='"+val+"'/>";
	}},     
	{title:'型号',name:'fbk2', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][fbk2]' type='text'  value='"+val+"'/>";
	}},    
	{title:'规格&性能',name:'materialSpecification', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][materialSpecification]' type='text'  value='"+val+"'/>";
	}},     
	{title:'单位',name:'unitQuantity', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][unitQuantity]' type='text'  value='"+val+"'/>";
	}},  
	{title:'数量',name:'quantity', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][quantity]' type='text' onkeyup='value=value.replace(/[^(\\d\\.)]/g,\"\")'  value='"+val+"'/>";
	}}, 
	{title:'品牌',name:'property1', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][property1]' type='text'  value='"+val+"'/>";
	}},
	{title:'颜色',name:'property2', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][property2]' type='text'  value='"+val+"'/>";
	}},
	{title:'长',name:'property3', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][property3]' type='text'  value='"+val+"'/>";
	}},
	{title:'宽',name:'property4', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][property4]' type='text'  value='"+val+"'/>";
	}},
	{title:'高',name:'property5', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][property5]' type='text'  value='"+val+"'/>";
	}},
	{title:'报价价格',name:'priceIncludingVat', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][priceIncludingVat]' type='text'  value='"+val+"'/>";
	}},
	{title:'完成日期',name:'deliveryDate', width: 120, align: 'center',renderer:function(val){
		return '<input type="text" id="" name="purchaseBiddingContentItemList[][deliveryDate]"  class="Wdate" onfocus=\'WdatePicker({dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
	}},     
	{title:'备注',name:'remark', width: 120, align: 'center',renderer:function(val){
		return "<input name='purchaseBiddingContentItemList[][remark]' type='text'  value='"+val+"'/>";
	}}];
var contentBlackItem={biddingProjectNumber:"",materialNumber:"",materialDesc:"",quantity:"",priceIncludingVat:"",materialSpecification:"",unitQuantity:"",deliveryDate:"",remark:"",property1:"",property2:"",property3:"",property4:"",property5:"",fbk2:""}
var editFileTable;
var file_cols = [
// { title:'文件来源', name:'FBK2' , width:60, align:'center'},
{ title:'文件名称', name:'fileName' , width:100, align:'center',renderer:function(val){
	return "<input name='purchaseBiddingFileList[][fileName]' type='text'  value='"+val+"'/>";
}},

{ title:'文件路径', name:'filePath', width:100, align:'center',renderer:function(val){
	return "<input name='purchaseBiddingFileList[][filePath]' type='text'  value='"+val+"'/>";
}},
{ title:'文件类型', name:'fileType', width:100, align:'center',renderer:function(val){
	return "<input name='purchaseBiddingFileList[][fileType]' type='text'  value='"+val+"'/>";
}},
{ title:'文件大小', name:'fileSize', width:100, align:'center',renderer:function(val){
	return "<input name='purchaseBiddingFileList[][fileSize]' type='text'  value='"+val+"'/>";
}},
{ title:'备注', name:'remark', width:100, align:'center',renderer:function(val){
	return "<input name='purchaseBiddingFileList[][remark]' type='text'  value='"+val+"'/>";
}},
// { title:'供应商编码', name:'toElsAccount' ,width:80, align:'center'},
// { title:'供应商', name:'toCompanyName' ,width:90, align:'center'},
// { title:'物料编码', name:'purchaseMaterialNumber' ,width:80, align:'center'},
// { title:'物料描述', name:'purchaseMaterialDesc' ,width:100, align:'center'},
// { title:'日期', name:'logtime', width:80, align:'center', hidden:true},
// { title:'说明', name:'remark', width:60, align:'center', hidden:true}
];


$().ready(function(){
	init();
	
	//改变投标轮数
	$("#selectCount").change(function(){
		//改变行数量
		
		if($("#biddingType").val() == "3"){
			computeOperation();
		}else{
			changeGride();
		}
	});
	
	//添加投标内容项
	$("#addItem").click(function(){
		//改变行数量
		addItem();
	});
	
	//删除投标内容项
	$("#removeIten").click(function(){
		//改变行数量
		removeIten();
	});
	
	//显示上传弹框
	$("#uploadFile").click(function(){
		 initFileUploader(fileUploader);
		 $('.fixed-dialog').show();
	});
	
	//关闭上传弹框
	$("#btnFileCancel ,.dialog-close-btn").click(function(){
		 $('.fixed-dialog').hide();
	});
	
	//显示上传弹框
	$("#btnFileOK").click(function(){
		addFileItem();
	});
	
	//发送
	$("#send").click(function(){
		sendBidding();
	});
	
});

//退出
$("#exitBtn").click(function(){
parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>',closeEvent:function(){
		
		parent.elsDeskTop.closeCurWin('addBiddingMain');
	}});
	});

//初始化
function init(){

	$(".online-bidding").hide();
	
	itemGrid = $('#baseTable').mmGrid({
        cols: cols_item,
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        items: [black]
    });
	
	initFriend();
	
	
}

//单击招标内容tag页时触发
$('.edit-line-content').click(function() {
	if(!contentGrid) {
		contentGrid=$('#contentTable').mmGrid({
	        cols: content_item,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect:true,
	        items: []
	    });
	}
});

//单击文件tag页时触发
$('.add-file-sheet').click(function() {
	if(!editFileTable) {
		editFileTable=$('#add-file-project').mmGrid({
		    cols: file_cols,
		    height:350,
		    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	        multiSelect:true,
	        items: []
		});
	}
});

//初始化文件上传控件
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

//在文件列表添加新添加的文件列
function addFileItem(){
	var filePath=$("#filePath").val();
	var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
	var fileName=$("#fileName").val();
	var fileSize = $("#fileSize").val();
	var fileBlackItem={fileName:fileName,fileType:fileType,filePath:filePath,fileSize:fileSize,remark:""};
	editFileTable.addRow(fileBlackItem);
	$('.fixed-dialog').hide();
}

//改变行数量
function changeGride(){
	var count=$("#selectCount").find("option:selected").val();
	var arr=new Array();
	for(var i=0;i<count;i++){
		var ind=parseInt(i)+parseInt(1);
		arr[i]={roundsNumber:ind,biddingBeginDate:"",biddingEndDate:"",biddingStatus:"0"};
	}
	itemGrid.removeRow();
	itemGrid.addRows(arr);
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
        		txt +='<p class="contact-people" style="margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">left</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-left').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-left').find('.contact-people').eq(ind).hide();
    			}
    		}
    		leftScroll.resize();
    		
    	} 
    	else if(dir == 'right') {
    		$('.box-right').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="display:none;margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">right</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-right').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-right').find('.contact-people').eq(ind).show();
    			}
    		}
    		rightScroll.resize();
    	}
	}
};

//显示文件列表
function showFileList(){
	var fileParam = { 'elsAccount':elsAccount, 'elsSubAccount':elsSubAccount};
	editFileTable=$('#add-file-project').mmGrid({
	    cols: file_cols,
	    url: '<%=basePath%>rest/PurchaseEnquiryBargainService/queryReceiveEnquiryFileByCondtion',
	    params: fileParam,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    fullWidthRows:true,
	    indexCol: false,
	    plugins: [
              $('#enquiryFilePage').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                  , limit: null
                  , limitList: [5,10,15,20]
              })
          ]
	});
}

//添加供应商信息
function initFriend(){
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
 				initContact(rows,'left');
 				initContact(rows,'right');
 			},
 			error: function (xhr, type, exception) {//获取ajax的错误信息
                 alert(xhr.responseText, "Failed"); 
        }
 		});
    rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
    leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
}
;
//存储临时的选择数据
var cacheData = {};
$('.contact-people').live('mouseover',function() {
	$('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact');
});
$('.contact-people').live('click',function() {
    /* $('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact'); */
    //cacheData.text = JSON.parse($(this).find('.storeData').text());
    cacheData.index = parseInt($(this).find('.people-index').text());
    cacheData.dir = $(this).find('.storeData-from').text();
    $('body').data('cachePeople',cacheData);
    var oldObj = $('body').data('cachePeople');
    if(oldObj && oldObj.dir=='left') {
    	$('.box-left').find('.contact-people').eq(oldObj.index).hide();
    	$('.box-right').find('.contact-people').eq(oldObj.index).show();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	rightScroll.resize();
   } else if(oldObj && oldObj.dir=='right') {
       	$('.box-left').find('.contact-people').eq(oldObj.index).show();
    	$('.box-right').find('.contact-people').eq(oldObj.index).hide();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	leftScroll.resize();
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
	
function addItem(){
	var rows = contentGrid.rows();
	if($("#biddingType").val() == "3" && rows[0]){
		alert("在线竞标只能添加一条物料信息！",2);
		return;
	}
	contentGrid.addRows([contentBlackItem]);
}

function removeIten(){
	var seletectIndexArr=contentGrid.selectedRowsIndex();
	if(seletectIndexArr.length<=0){
		alert("请选择要删除的行!",2);
		return;
	}
	console.log(seletectIndexArr)
// 	for(var i=0;i<seletectIndexArr.length;i++){
// 		console.log(seletectIndexArr[i])
		contentGrid.removeRow(seletectIndexArr);
// 	}
}

//发送投标
function sendBidding(){
	var toElsAccounts="";
	var toElsDescs ="";
	var biddingNumber=$("#biddingNumber").val();
	if(!biddingNumber){
		alert("请输入投标编号！",2);
		return;
	}
	
	$('.box-right').find(".contact-people").each(function(index ,val){
		if(jQuery(this).css("display")!="none"){ 
			var textObj = JSON.parse($(this).find('.storeData').text());
			toElsAccounts+=","+textObj.friendElsAccount;
			toElsDescs+=","+textObj.friendCompanyName;
		}
	});
	console.log(toElsAccounts);
    if(toElsAccounts.length==0) {
    	alert("请选择受邀方!",2);
    	return ;
    }

    $("#elsAccount").val(elsAccount);
    $("#elsSubAccount").val(elsSubAccount);
    $("#toElsAccounts").val(toElsAccounts.substring(1));
    $("#toElsDescs").val(toElsDescs.substring(1));
    $("#biddingNumber1").val(biddingNumber);
//     $("#biddingTypeInput").val($("#biddingType option:selected").val());
    var formObj = $("#form").serializeJSON();
    
    var biddingLinkMan = {"elsAccount":elsAccount,"fbk1":$("#tenderElsAccount").val(),"principal":$("#principal").val(),"telephone":$("#telephone").val(),"email":$("#email").val(),"fax":$("#fax").val(),"address":$("#address").val()};
    var purchaseBiddingLinkManVOs = [];
    purchaseBiddingLinkManVOs.push(biddingLinkMan);
    formObj["purchaseBiddingLinkManVOs"]=purchaseBiddingLinkManVOs;
    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认发布？" />',closeEvent:function(){
    parent.elsDeskTop.showLoading('招投标信息发布中');
	$.ajax({
		url : "<%=basePath%>rest/PurchaseEnquiryBiddingService/sendBidding",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(formObj),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.statusCode=="-100"){
				alert(data.message,2);
			}else{
				alert("创建成功!");
				parent.elsDeskTop.closeCurWin('addBiddingMain',callBack);
			}
			console.log(data.statusCode+"   "+data.message);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		}
	});
	
    }});
}

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_biddingPurchaseManage']) {
		parent.frames['iframeApp_biddingPurchaseManage'].purchQuery();
	}

}

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
 
//在线预览
$("#lookFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
		previewFile(filePath);
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
});

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
//根据所属项目编号，自动带出项目名称
$('#biddingProjectNumber').live('blur',function() {
    var biddingProjectNumber = $("#biddingProjectNumber").val();
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
						$("#biddingProjectName").val(data.rows[0].projectDesc);
					}else{
						$("#biddingProjectName").val("");
					}
				}else{
					$("#biddingProjectName").val("");
				}
			}
		});
    	//行信息
    	$.ajax({
			url :"<%=basePath%>rest/ProjectManageService/queryProjectManageItem",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"elsAccount":elsAccount,"projectNumber":biddingProjectNumber}),
			success : function(data) {
				if(data.statusCode == null){
					if(data.rows != null && data.rows != ""){
						contentGrid.load();
						for(var i = 0 ; i < data.rows.length ; i++ ){
							var row = data.rows[i];
							var contentBlackItem={biddingProjectNumber:row.projectItemNumber,materialNumber:"",materialDesc:row.projectItemDesc,quantity:"",priceIncludingVat:"",materialSpecification:"",unitQuantity:"",deliveryDate:"",remark:"",property1:"",property2:"",property3:"",property4:"",property5:"",fbk2:""};
							contentGrid.addRows([contentBlackItem]);
						}
					}else{
						//contentGrid.load();
					}
				}else{
					contentGrid.load();
				}
			}
		});
    }else{
    	//contentGrid.load();
    	$("#biddingProjectName").val("");
    }
});

//选择需求计划  @author jiangzhidong @date 20160305
$('.equirementsplanning').live("click", function(event) {
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_77.gif',
        'windowsId':'findRequirementsplanning',
        'windowTitle':'<i18n:I18n key="" defaultValue="选择需求计划"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>projectmanage/requirementsplanning/findRequirementsplanning.jsp?frameAppId=addBiddingMain',
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
	
});

function callbackFun(rows){
	debugger;
	for(var i = 0 ; i < rows.length ; i++ ){
		var row = rows[i];
		var contentBlackItem={biddingProjectNumber:row.materialNumber,materialNumber:"",materialDesc:row.materialName,quantity:"",priceIncludingVat:"",materialSpecification:"",unitQuantity:"",deliveryDate:"",remark:row.remark,property1:row.property1,property2:row.property2,property3:row.property3,property4:row.property4,property5:row.property5,fbk2:""};
		contentGrid.addRows([contentBlackItem]);
	}
}

//招标类型改变时
 $("#biddingType").change(function(){
	 var biddingType = $("#biddingType").val();
	 if(biddingType == "3"){
		 $(".online-bidding").show();
		 $('#reCreate').html('<table id="baseTable"></table>');
		 itemGrid = $('#baseTable').mmGrid({
		        cols: cols_item_online,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		    });
		 itemGrid.on("loadSuccess", function(e, data){
			 computeOperation();
		  	});
	 }else{
		 $(".online-bidding").hide();
		 $('#reCreate').html('<table id="baseTable"></table>');
		 itemGrid = $('#baseTable').mmGrid({
		        cols: cols_item,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        items: [black]
		    });
		 $("#endTime").html("");
	 }
 });
 
 //计算并生成轮次数据
 function computeOperation(){
	 var opentime = $("#opentime").val();
	 var selectCount = $("#selectCount").val();//轮次
	 var roundMinutes = $("#roundMinutes").val();
	 var intervalMinutes = $("#intervalMinutes").val();
	 var limitPrices = $("#limitPrices").val();
	 
	 if(opentime == "" || roundMinutes == "" || intervalMinutes == ""){
		 return ;
	 }
	 var beginDate;
	 var endDate;
	 itemGrid.removeRow();
	 for(var i = 0 ; i < selectCount ; i ++){
		 if(!endDate){
			 beginDate = new Date(opentime);
			 endDate=new Date();
			 endDate.setTime(beginDate.getTime()+1000*60*roundMinutes);
			 var item = {"roundsNumber":i+1,"biddingBeginDate":beginDate.format('yyyy-MM-dd hh:mm:ss'),"biddingEndDate":endDate.format('yyyy-MM-dd hh:mm:ss'),"fbk1":limitPrices,"fbk2":"","fbk3":""};
			 itemGrid.addRow(item);
		 }else{
			 beginDate.setTime(endDate.getTime()+1000*60*intervalMinutes);
			 endDate.setTime(beginDate.getTime()+1000*60*roundMinutes);
			 var item = {"roundsNumber":i+1,"biddingBeginDate":beginDate.format('yyyy-MM-dd hh:mm:ss'),"biddingEndDate":endDate.format('yyyy-MM-dd hh:mm:ss'),"fbk1":"","fbk2":"","fbk3":""};
			 itemGrid.addRow(item);
		 }
	 }
	 $("#endTime").html("竞标结束时间："+endDate.format('yyyy-MM-dd hh:mm:ss'));
 }
 
 //------触发事件---------
 $('.init-roundTable').live('blur',function() {
	 computeOperation();
 });
 --%>

</script>
</body>
</html>