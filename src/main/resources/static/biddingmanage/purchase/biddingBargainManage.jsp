<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String biddingNumber = request.getParameter("biddingNumber");
String toElsAccount = request.getParameter("toElsAccount");
String elsAccount = request.getParameter("elsAccount");
String biddingItemNumOne = request.getParameter("biddingItemNumOne");
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="js/esl.js"></script>

<style>
table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>

<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="sendToSupplier" class="button-wrap">发送至投标方</button>
                <!--<base:auditConfig elsAccount="${elsAccount}" businessType="bargainEnquiry">
				</base:auditConfig>-->
					<button id="entryBtn" class="button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="定标提交审批" /></button>
					<button id="cancelBiddingBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
<%-- 					<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" /></button> --%>
				<!-- <button id="uploadToERP" class="button-wrap"><i18n:I18n key="test" defaultValue="回写SAP" /></button> -->
				<button id="saveScoreTargetBtn" class="button-wrap"><i18n:I18n key="" defaultValue="保存" /></button>
				<button id="close-biddingBarginManage" class="button-wrap">关闭</button>
            </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></span>
            
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="test" defaultValue="招标编码" />：</strong><span id="biddingNumber2"/></div>
                <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="test" defaultValue="招标类型" />：</strong><span id="biddingType2"/></div>
                <%-- <div class="dis-in-b input-and-tip"><strong><i18n:I18n key="test" defaultValue="开标日期" />: </strong><span id="opentime"></span></div> --%>
            </div>
		</div>
	<form id="form" onsubmit="return false;">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                     <ul>
                     	<li class="basic-info-sheet"><a href="#edit-line-baseInfo">基本信息</a></li>
				    	<li class="add-file-sheet"><a href="#edit-line-connType"><i18n:I18n key="test" defaultValue="联系方式" /></a></li>
				    	<li class="add-file-sheet"><a href="#edit-line-bail"><i18n:I18n key="test" defaultValue="保证金" /></a></li>
				    	<li class="sheet-project-one1"><a href="#edit-line-content"><i18n:I18n key="test" defaultValue="招标内容" /></a></li>
				    	<li class="sheet-project-one2"><a href="#sheet-project-one"><i18n:I18n key="i18n_purchase_bargain_supplierQuotedPrice" defaultValue="供应商报价" /></a></li>
				    	<li class="sheet-project-online2"><a href="#sheet-project-online"><i18n:I18n key="test" defaultValue="在线竞价" /></a></li>
				    	<li class="add-supplie-sheet"><a href="#edit-line-three"><i18n:I18n key="test" defaultValue="受邀方" /></a></li>
                        <li><a class="scan-file-sheet" href="#edit-line-file"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                        <li class="scan-form-sheet2"><a class="scan-form-sheet" href="#sheet-project-three">回签文件</a></li>
                        <li class="bid-evaluation"><a class="evalute-target-sheet" href="#edit-evalute-target"><i18n:I18n key="test" defaultValue="评标定标" /></a></li>
                    </ul>
                    
                <!-- 基本信息 -->
				<div id="edit-line-baseInfo">
					<div class="box-wrap pos-relative bg-common">
					  <table>
				    	<tbody>
				    		<tr>
				    			<td colspan="1" align="left">
									<input id="biddingStatus" name="biddingStatus" class="init-biddingStatus" type="hidden" style="width: 200px;"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标类型:" /></td>
				    			<td colspan="1" align="left">
									<select id="biddingType" name="biddingType" class = "init-biddingType" style="width: 164px; max-width: 164px;" disabled="disabled">
									<option value="0">邀请招标</option>
									<option value="1">公开招标</option>
									<option value="2">在线竞标-邀请</option>
									<option value="3">在线竞标</option>
					            </select><span style="color: red;">*</span>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标编码:" /></td>
				    			<td colspan="1" align="left">
									<input id="biddingNumber" name="biddingNumber" class="init-biddingNumber" type="text" style="width: 200px;"  readonly = "readonly"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标名称:" /></td>
				    			<td colspan="1" align="left">
									<input id="biddingName" name="biddingName" type="text" class="init-biddingName" style="width: 200px;"  readonly = "readonly"/><span style="color: red;">*</span>
								</td>
				    		</tr>
				    		<tr class='online-bidding'>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="每轮持续:" /></td>
				    			<td colspan="1" align="left">
									<input id="roundMinutes" name="purchaseBiddingHeader[fbk2]" type="text" style="width: 200px;" class = "init-roundTable" readonly = "readonly"/><span>分钟</span>
								</td>
				    		</tr>
				    		<tr class='online-bidding'>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="每轮间隔:" /></td>
				    			<td colspan="1" align="left">
									<input id="intervalMinutes" name="purchaseBiddingHeader[fbk3]" type="text" style="width: 200px;" class = "init-roundTable" readonly = "readonly"/><span>分钟</span>
								</td>
				    		</tr>
				    		<tr class='online-bidding'>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="采购限价:" /></td>
				    			<td colspan="1" align="left">
									<input id="limitPrices" name="purchaseBiddingHeader[fbk4]" type="text" style="width: 200px;" class = "init-roundTable init-limitPrices" readonly = "readonly"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标说明:" /></td>
				    			<td colspan="1" align="left">
									<textarea id="remarkBase" name="remark" style="width:500px; height:80px" readonly = "readonly"></textarea>
								</td>
				    		</tr>
				    	</tbody>
				       </table>
						<main class="grid-container">
						<div class="grid-100">
							<table id="baseTable"></table>
						</div>
						</main>
					</div>
				</div>
                    
                <!-- 联系方式 -->
				<div id="edit-line-connType">
					<div class="box-wrap pos-relative bg-common">
						<span class="dis-in-b pos-absolute box-tip bg-common">招标机构</span>
						<div class="common-box-line">
							<div class="input-and-tip">
								<span>招标单位:</span>
								<input id="orgName" name="biddingLinkmanVOs[][orgName]" type="text" style="width: 500px;" readonly="readonly"/>
								<span style="color: red;">*</span>
							</div>
							<div class="input-and-tip">
								<span>负 责 人:</span>&nbsp;
								<input id="principal" name="biddingLinkmanVOs[][principal]" type="text" style="width: 500px;" readonly="readonly"/>
								<span style="color: red;">*</span>
							</div>
							<div class="input-and-tip">
								<span>联系电话:</span>
								<input id="telephone" name="biddingLinkmanVOs[][telephone]" type="text" style="width: 500px;" readonly="readonly"/>
								<span style="color: red;">*</span>
							</div>
							<div class="input-and-tip">
								<span>电子邮箱:</span>
								<input id="email" name="biddingLinkmanVOs[][email]" type="text" style="width: 500px;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>电子传真:</span>
								<input id="fax" name="biddingLinkmanVOs[][fax]" type="text" style="width: 500px;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>联系地址:</span>
								<input id="bidding-address" name="biddingLinkmanVOs[][address]" type="text" style="width: 500px;" readonly="readonly"/>
								<span style="color: red;">*</span>
							</div>
						</div>
					</div>
					<div class="box-wrap pos-relative bg-common">
						<span class="dis-in-b pos-absolute box-tip bg-common">代理招标机构</span>
						<div class="common-box-line">
							<div class="input-and-tip">
								<span>招标单位:</span>
								<input id="dl_orgName" name="biddingLinkmanVOs[][orgName]" type="text" style="width: 500px;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>负 责 人:</span>&nbsp;
								<input id="dl_principal" name="biddingLinkmanVOs[][principal]" type="text" style="width: 500px;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>联系电话:</span>
								<input id="dl_telephone" name="biddingLinkmanVOs[][telephone]" type="text" style="width: 500px;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>电子邮箱:</span>
								<input id="dl_email" name="biddingLinkmanVOs[][email]" type="text" style="width: 500px;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>电子传真:</span>
								<input id="dl_fax" name="biddingLinkmanVOs[][fax]" type="text" style="width: 500px;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>联系地址:</span>
								<input id="dl_address" name="biddingLinkmanVOs[][address]" type="text" style="width: 500px;" readonly="readonly"/>
							</div>
						</div>
					</div>
				</div>

				<!-- 保证金-->
				<div id="edit-line-bail">
					<div class="common-box-line">
						<div class="input-and-tip">
							<input type="radio" id="margin_isDistinguishPhases" name="biddingMarginVO[multiSection]" value="0" />
							<i18n:I18n key="test" defaultValue="不区分标段" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" id="margin_isDistinguishPhases" name="biddingMarginVO[multiSection]" value="1" />
							<i18n:I18n key="test" defaultValue="区分标段" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
											<input id="" name="biddingMarginVO[collect]" type="radio" value="0" checked="true" />否
											<input id="" name="biddingMarginVO[collect]" type="radio" value="1" />是
										</td>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="退还保证金:" /></td>
										<td colspan="1" align="left">
											<input id="" name="biddingMarginVO[back]" type="radio" value="0" />否
											<input id="" name="biddingMarginVO[back]" type="radio" checked="true" value="1" />是
										</td>
									</tr>
									<tr>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金金额:" /></td>
										<td colspan="3" align="left">
											<input id="margin_amount" name="biddingMarginVO[amount]" type="text" style="width: 300px;" value="" readonly="readonly"/>
												<%-- <select id="margin_currencyType" name="biddingMarginVO[currency]" onfocus="this.defaultIndex=this.selectedIndex;" onchange="this.selectedIndex=this.defaultIndex;"> --%>
												<select id="margin_currencyType" name="biddingMarginVO[currency]">
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
											<input type="text" id="margin_payBeginDate" name="biddingMarginVO[payBeginDate]" value="" readonly="readonly"/>
											<span><i18n:I18n key="test" defaultValue="到" /></span>
											<input type="text" id="margin_payEndDate" name="biddingMarginVO[payEndDate]" value="" readonly="readonly"/>
										</td>
									</tr>
									<tr>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金细节规则:" /></td>
										<td colspan="3" align="left">
											<textarea style="width: 500px; height: 80px" id="margin_remark" name="biddingMarginVO[remark]" readonly="readonly">
											</textarea>
										</td>
									</tr>
								</tbody>
							</table>
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
										<textarea style="width: 500px; height: 80px" id="contentSummary" name="biddingContent[summary]" readonly="readonly">
										</textarea>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="所属项目" />：</td>
					    			<td colspan="1" align="left">
										<input id="contentBiddingProjectNumber" name="biddingContent[biddingProjectNumber]" type="text" style="width: 200px;" readonly="readonly"/>
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
										<input type="text" id="contentAddress" name="biddingContent[address]" readonly="readonly">
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right">质量要求：</td>
					    			<td colspan="1" align="left">
										<textarea style="width: 500px; height: 80px" id="contentQuality" name="biddingContent[quality]" readonly="readonly">
										</textarea>
									</td>
					    		</tr>
					    	</tbody>
					       </table>
					       	<div class="box-wrap pos-relative bg-common">
								<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
										key="" defaultValue="招标详细内容" /></span>
								<div class="common-box-line">
								   <main class="grid-container">
								   <div class="common-box-line">	
										<button id="columnDefineBtn_content_item" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
									</div>
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
								   <main class="grid-container">
									<div class="grid-100">
										<table id="biddingStandardTable"></table>
									</div>
									</main>
								</div>
							</div>
						</div>
					</div>
					<!-- 供应商报价 -->
					<div id="sheet-project-one">
						<div class="box-wrap pos-relative bg-common">
							<table>
								<tbody>
									<tr>
										<td colspan="1" align="right">标段：</td>
										<td colspan="1" align="left">
											<select id="contentBiddingItemNumber2" name="biddingContent2[biddingItemNumber]">
												<option value='0'>不区分标段</option>
											</select>
											&nbsp;&nbsp;轮次：
											<select id="contentBiddingRound2" name="biddingContent2[contentBiddingRound]">
											</select>
										</td>
									</tr>
									<%-- 
									<tr>
										<td colspan="1" align="right">招标内容<br />总体描述:</td>
										<td colspan="1" align="left">
											<textarea id="descriptionArea" readonly="readonly" style="width: 800px; height: 80px">
											</textarea>
										</td>
									</tr>
									 --%>
									<tr>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="所属项目:" /></td>
										<td colspan="1" align="left">
											<input id="projectNumber" name="projectNumber" type="text" readonly="readonly" style="width: 200px;" />
											<input id="projectRemark" name="projectRemark" type="text" readonly="readonly" style="width: 300px;" />&nbsp;&nbsp;&nbsp;	<button id="columnDefineBtn2" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
										</td>
									</tr>
								</tbody>
							</table>
							<main class="grid-container nest-table">
								<div class="grid-100" id="reCreate">
									<table id="table-item"></table>
									<div id="pg-price" style="text-align: right;"></div>
								</div>
							</main>
						</div>
					</div>
 <!-- ----------------------------------------在线竞价 @author jiangzhidong @date 20160324  begin------------------------ -->                 
                 <div id="sheet-project-online">
           			<table>
           				<tbody>
           					<tr>
          						<td align="center" colspan="1" rowspan="2" align="right" style=" width: 350px; border: solid 1px #ccc;">
<!-- 竞价情况  -->
<div id="bar123" style="width: 350px;height: 250px;">
<img id="fbk20" name="fbk20" src="./1.jpg" style="width: 250px;height: 150px; margin-top: 50px;"></div>
<h5>竞价情况</h5>
-------------------------------------------------------
<table>
<tbody>
<tr>
<td align="right">合同包:</td>
<td><input id="biddingName" name="biddingName" type="text" class="init-biddingName" style="width: 300px;" readonly = "readonly"/>
</td>
</tr>
<tr>
<td align="right">竞价类型:</td>
<td><select id="biddingType" name="biddingType" class = "init-biddingType" style="width: 164px; max-width: 164px;" disabled="disabled">
									<option value="0">邀请招标</option>
									<option value="1">公开招标</option>
									<option value="2">在线竞标-邀请</option>
									<option value="3">在线竞标</option>
					            </select>
</td>
</tr>
<tr>
<td align="right">采购限价:</td>
<td><input id="limitPrices" name="limitPrices" type="text" class="init-limitPrices" style="width: 300px;" readonly = "readonly"/>
</td>
</tr>
<tr>
<td align="right">最小竞价幅度:</td>
<td><input id="currentFbk2" name="currentFbk2" type="text" style="width: 300px;" readonly = "readonly"/>
</td>
</tr>
<tr>
<td align="right">当前最<a style="color: red;">低</a>报价:</td>
<td><input id="currentMinPrice" name="currentMinPrice" type="text" style="width: 300px;" readonly = "readonly"/>
</td>
</tr>
<tr>
<td></td>
<td>&nbsp;
</td>
</tr>
<tr>
<td align="right">竞价开始时间:</td>
<td><input id="biddingBeginDate" name="biddingBeginDate" type="text" style="width: 300px;" readonly = "readonly"/>
</td>
</tr>
<tr>
<td align="right">竞价结束时间:</td>
<td><input id="biddingEndDate" name="biddingEndDate" type="text" style="width: 300px;" readonly = "readonly"/>
</td>
</tr>
<tr>
<td align="right">当前处于几轮次:</td>
<td><input id="currentRound" type="text" style="width: 300px;" readonly = "readonly"/>
</td>
</tr>
<!-- <tr>
<td align="right">本轮次报价排名:</td>
<td><input type="text" style="width: 300px;" value="3"/>>><a style="color: red;" href="http://www.w3school.com.cn">点击详情</a>
</td>
</tr> -->
</tbody>
</table>

								</td>
           						<td align="center" colspan="1" rowspan="1" align="right" style=" width: 750px; border: solid 1px #ccc;">
	           		
	           						<!-- 当前最低报价 -->				
	           						<table style="width: 550px;">
						    		<tbody>
						    		<tr>
						    		<td colspan="1" align="right"><h5>当前最低报价：</h5></td>
						    		<td colspan="1" align="left"><h5 style="color: red;"  class="currentMinPrice"></h5></td>
						    		<td colspan="1" align="right"><h5>竞价倒计时：</h5></td>
						    		<td colspan="1" align="left"><h5 style="color: red;"  id="timer"></h5></td>
						    		</tr>
						    		</tbody>
						    		</table>

----------------------------------------------------------------------------------------------<br/>
竞选轮次：本次竞选一共<span id=totalRound></span>轮  每轮持续时间：<span id="fbk2"></span>分钟  每轮间隔时间：<span id="fbk3"></span>分钟

								</td>
					    	</tr>
					    	<tr>
           						<td align="left" colspan="1" rowspan="2" align="right" style="width: 600px; border: solid 1px #ccc; margin: 0px;">
           			  <!-- 竞价 -->
                 	  <table style="width: 600px;">
					    	<tbody>
					    		<tr>
					    			<td colspan="1" align="right">竞价名称:</td>
					    			<td colspan="1" align="left">
					    				<input id="materialDesc" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
									<td colspan="1" align="right">&nbsp;&nbsp;&nbsp;&nbsp;商品品牌:</td>
					    			<td colspan="1" align="left">
					    				<input id="property1" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right">商品品名:</td>
					    			<td colspan="1" align="left">
					    				<input id="materialNumber" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
									<td colspan="1" align="right">规格型号:</td>
					    			<td colspan="1" align="left">
					    				<input id="materialSpecification" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right">最高限价:</td>
					    			<td colspan="1" align="left">
					    				<input id="upMinPrice" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
									<td colspan="1" align="right">数量:</td>
					    			<td colspan="1" align="left">
					    				<input id="quantity" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right">交货期:</td>
					    			<td colspan="1" align="left">
					    				<input id="deliveryDate" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
									<td colspan="1" align="right">计量单位:</td>
					    			<td colspan="1" align="left">
					    				<input id="unitQuantity" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right">当前轮次总价格:</td>
					    			<td colspan="3" align="left">
					    				<input id="contentfbk1" type="text" style="width: 100%;" readonly="readonly"/>
									</td>
					    		</tr>
					    		<tr>
									<td align="right">备注说明：</td>
									<td colspan="3">
									<textarea id="remark" style="width: 450px;" readonly="readonly"></textarea>
									</td>
					    		</tr>
					    	</tbody>
					   </table>
					   <!-- 历史报价 -->
					   <h5 style="margin-left: 10px;">供应商历史报价<button style="margin-left: 50px;" id="historyBtn" class="button-wrap"><i18n:I18n key="test" defaultValue="中标" /></button></h5>
                       <main class="grid-container">
						<div class="grid-100" style="width: 700px; margin-left: 10px;">
							<table id="historyTable"></table>
							<div id="onlinePage" style="text-align: right;"></div>
						</div>
					   </main>

								</td>
					    	</tr>
					    </tbody>
					 </table>
                  </div>
<!-- ----------------------------------------在线竞价 @author jiangzhidong @date 20160324  end------------------------ -->                    
                  <!-- 受邀方 -->
                   <div class="p-zero" id="edit-line-three">
                     <div class="fixed-dialog supplie-groud" >
                     </div>
                     <main class="bg-common p-6">
                        <div class="edit-box-wrap">
                        </div>
                        <div>
	                        	标段：
							<select id="contentBiddingItemNumberSYF">
								<option value='0'>不区分标段</option>
							</select>
                        </div>
                        <div class="grid-100" >
                              <table id="add-supplie-project"></table>
                               <div id="enquirySuppliePage" style="text-align: left;"></div>
                               </div>
                     </main>
                 </div>
                    
                  <!-- 表单文件 -->
                  <div id="edit-line-file">
	                  <div class="box-wrap pos-relative bg-common" style="padding: 0;">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<div class="file-list-head">
				                       <select id="selectPurchaseSale" name="selectPurchaseSale">
					                   <option value="0"><i18n:I18n key="i18n_common_select_filetype_all" defaultValue="所有文件" /></option>
					                   <option value="1"><i18n:I18n key="i18n_common_title_ourfile" defaultValue="我方文件" /></option>
					                   <option value="2"><i18n:I18n key="i18n_common_title_theyfile" defaultValue="对方文件" /></option>
					                   </select>
					                 </div>
									<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="add-file-project"></table>
											<div id="enquiryFilePage" style="text-align: right;"></div>
										</div>
									</main>
			                    </div>
				                 <div class="file-scan">
		   							<div class="file-option-zoom">
					                  <div class="dis-in-b text-left">
					                     <button id="downloadFile" class="button-wrap">下载</button>
					                     <!-- <button id="lookFile" class="button-wrap">在线查看</button> -->
							             <!-- <button id="fileColumnDefineBtn" class="button-wrap">列自定义</button> -->
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
				<!-- 回签文件 -->
				<div id="sheet-project-three">
					<div class="box-wrap pos-relative bg-common" style="padding: 0;">
						<div class="common-box-line p-zero">
							<div class="pos-relative upload-wrap">
								<div class="pos-absolute file-list">
									<main class="grid-container">
									<div class="grid-100" id="reCreateFile">
										<table id="add-form-project"></table>
										<div id="enquiryFormPage" style="text-align: right;"></div>
									</div>
									</main>
								</div>
								<div class="file-scan">
									<div class="file-option-zoom">
										<div class="dis-in-b text-left">
											<!-- <button id="formColumnDefineBtn" class="button-wrap">列自定义</button> -->
											<button id="flushFormBtn" class="button-wrap">
												<i18n:I18n key="i18n_common_title_flush" defaultValue="刷新" />
											</button>
											<button id="downloadForm" class="button-wrap">下载</button>
											<!-- <button id="uploadForm" class="button-wrap">上传</button> -->
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
                <!-- 评标定标 -->
				<div id="edit-evalute-target">
					<div class="box-wrap pos-relative bg-common">
						<table>
							<tbody>
								<tr>
									<td colspan="1" align="right">标段：</td>
									<td colspan="1" align="left">
										<select id="contentBiddingItemNumber1" name="biddingContent1[biddingItemNumber]">
											<option value='0'>不区分标段</option>
										</select>
										<input id="scoreTargetSelChange" type="hidden"/>
										<input name="biddingContent1[elsAccount]" type="hidden"/>
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right">轮次：</td>
									<td colspan="1" align="left">
										<select id="contentBiddingRound" name="biddingContent1[contentBiddingRound]">
										</select>
										&nbsp;&nbsp;
										<div id="curBiddingStatusSpan"></div>
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right">招标内容&nbsp;&nbsp;<br />总体描述：
									</td>
									<td colspan="1" align="left">
										<textarea style="width: 500px; height: 80px" id="contentSummary1" name="biddingContent1[summary]" readonly="readonly">
										</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="所属项目" />：</td>
									<td colspan="1" align="left">
										<input id="contentBiddingProjectNumber1" name="biddingContent1[biddingProjectNumber]" readonly="readonly" type="text" style="width: 200px;" />
										<input id="contentBiddingProjectName1" name="biddingContent1[biddingProjectName]" type="text" value="自动取项目名称" readonly="readonly" style="width: 300px;" /> <!-- <img src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;left: 402px;top: 140px;cursor: pointer;" class="equirementsplanning" title="选择需求计划" /> --></td>
								</tr>
								<tr>
									<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="生效日期" />：</td>
					    			<td colspan="1" align="left">
										<input type="text" id="contentDeliveryStartDate1" name="biddingContent1[deliveryStartDate]" readonly="readonly"/>
									</td>
								</tr>
								<tr>
									<td colspan="1" align="right">交货地点：</td>
									<td colspan="1" align="left"><input type="text" id="contentAddress1" name="biddingContent1[address]" readonly="readonly"></td>
								</tr>
								<tr>
									<td colspan="1" align="right">质量要求：</td>
									<td colspan="1" align="left">
										<textarea style="width: 500px; height: 80px" id="contentQuality1" name="biddingContent1[quality]" readonly="readonly">
										</textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="box-wrap pos-relative bg-common">
						<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="评标评分" /></span>
						<div class="common-box-line">
							<main class="grid-container">
							<div class="grid-100">
									<table id="scoreTargetTable"></table>
							</div>
							</main>
						</div>
					</div>
					<div class="box-wrap pos-relative bg-common" id="candidateSupplierDiv">
						<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="推荐候选供应商" /></span>
						<div class="common-box-line">
							<main class="grid-container">
							<div class="grid-100">
									<table id="candidateSupplierTable"></table>
							</div>
							</main>
						</div>
					</div>
					<div class="box-wrap pos-relative bg-common">
						<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="定标详细内容" /></span>
						<table>
							<tr>
								<td>
									<div id="sendTenderBidConfig" class="common-box-line" style="border: 0px;">
										<input type="checkbox" id="chkSendWonBidQute" value="0">发送份额
										&nbsp;&nbsp;
										<input type="checkbox" id="chkSendWonBidRank" value="0"/>发送排名
									</div>
								</td>
								<td>
									<div class="common-box-line" style="border: 0px;">
										<button id="columnDefineBtn_target_score" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>												
									</div>
								</td>
							</tr>
						</table>
						<div class="common-box-line">
							<main class="grid-container">
							<div class="grid-100">
									<table id="tenderTargetTable"></table>
							</div>
							</main>
						</div>
					</div>
				</div>

                </div>
            </div>
        </div>
     </form>
        <!--  @date jiangzhidong @date 20160301
          <div class="saying-dialog">
            <div class="fl-left left-content pos-relative">
                <div class="dis-block pos-absolute option-bar pre-active next"></div>
            </div>
            <div class="fl-left right-content pos-relative none-active">
                <div class="saying-box-wrap">
                   <iframe class="testIframe" id="chatIframe" frameborder="0" width="100%">
                   </iframe>
                </div>
            </div>
            <div class="clear-both"></div>
         </div> -->

    </div>
<script>
Number.prototype.toFixed=function (d) { 
    var s=this+""; 
    if(!d)d=0; 
    if(s.indexOf(".")==-1)s+="."; 
    s+=new Array(d+1).join("0"); 
    if(new RegExp("^(-|\\+)?(\\d+(\\.\\d{0,"+(d+1)+"})?)\\d*$").test(s)){
        var s="0"+RegExp.$2,pm=RegExp.$1,a=RegExp.$3.length,b=true;
        if(a==d+2){
            a=s.match(/\d/g); 
            if(parseInt(a[a.length-1])>4){
                for(var i=a.length-2;i>=0;i--){
                    a[i]=parseInt(a[i])+1;
                    if(a[i]==10){
                        a[i]=0;
                        b=i!=1;
                    }else break;
                }
            }
            s=a.join("").replace(new RegExp("(\\d+)(\\d{"+d+"})\\d$"),"$1.$2");

        }if(b)s=s.substr(1); 
        return (pm+s).replace(/\.$/,"");
    }return this+"";

};
Array.prototype.insert = function (index, item) {
  this.splice(index, 0, item);
};
var materialGrid;
var supplierTenderItemGrid;
var itemRounds;
var itemHistory;
var chatIfr;
var isloadItemGrid = false;
var editFileTable;
var editFormTable;
var biddingNumber='<%=biddingNumber%>';
var toElsAccount='<%=toElsAccount%>';
var biddingItemNumOne='<%=biddingItemNumOne%>';
var currentPurchaseOrderNumber;
var editSupplieTable;
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var rowIndexSelect=0;
var peopleList;
var $sob;
var intervalItemHis;//定时刷新报价列及最低报价定时器
var key;
var value;
var blankScoreTargetRow = {"supplierAccount":"","supplierDesc":"","scoreTypeCode":"","scoreTypeName":"","scoreModuleCode":"","scoreModuleName":"","weight":"","score":"","principal":"","annexFileName":"","standardDetail":""};
//聊天窗口
//供应商列表：toElsAccount ,每个供应商对应的负责人：elsSubAccount,询价订单号 ： businessID
function initChat() {	
	  //查询供应商表purchase_enquiry_supplie_list  供应商编码   供应商名称    
	  //查询采购方purchase_enquiry_header  负责人
	  var supplieParam = {
	  	'elsAccount':elsAccount,
	  	'biddingNumber':'<%=biddingNumber%>'
	    };
	  $.ajax({
 		 url: '<%=basePath%>rest/PurchaseEnquiryBargainService/querySupplierByCondtion',
 		 type :"post",
 		 contentType : "application/json",
 		 data : JSON.stringify(supplieParam),
 		 dataType : "json",
 		 success : function(data) {
 			var totalList = [];
 			if(data && data.length) {
 				totalList = data;
 				//供应商列表
 	 			var toElsAccountList = [];
 	 			//每个人供应商对应的责任人列表
 	 			var toElsSubAccountList = totalList;
 	 			var displayList = [];
 	 			if(totalList && totalList.length) {
 	 				totalList.forEach(function(d,i){
 	 					var kObj = d;
 	 					for(var key in kObj) {
 	 						toElsAccountList[i] = key;
 	 						displayList[i] = key;
 	 					}
 	 				});
 	 				//显示的全部数据列表
 	 				displayList=displayList.map(function(d){
 	 					return {name:d};
 	 				}); 
 	 			};
 	 			//初始化iframe
 	 		   
				setIframeData(chatIfr,{
						type:'multi',
						displayType:'1',
						fromElsAccount:elsAccount,
						fromElsSubAccount:elsSubAccount,
						toElsAccount:toElsAccountList,
						toElsSubAccount:toElsSubAccountList,
						businessType:'enquiry',
						businessID:purchaseEnquiryNumber,
						list:displayList,
						orderType:orderType,
						beginDate:beginDate,
						endDate:endDate,
						t: new Date().getTime()
				});
 	 		   //滚动条美化niceScroll
 	 		   $('.public-wrap').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
 			}
 		 },
 		 error : function(data) {
 			alert("系统异常!",3);
 		 }
    }); 
}

$("#close-biddingBarginManage").click(function() {
    parent.elsDeskTop.closeCurWin('PurchaseBiddingBargainDetail');
});

function toNum(obj) {
	//var   typeRexg="^[0-9]*[1-9][0-9]*$"; 
    //var   rexg   =   new   RegExp(typeRexg); 
   	//if(obj.match(rexg)!=null && !isNaN(obj) && Number(obj)<=100) {
   	if(!isNaN(obj) && obj>=0 && obj<=100) {
		return Number(obj);
   	}
	return 0;
}

function toNumCommon(obj) {
   	if(!isNaN(obj) && obj>=0) {
		return Number(obj);
   	}
	return 0;
}
$(document).ready(function(){
	/* dell @date jiangzhidong @date 20160301
	chatIfr= $('#chatIframe')[0];
	chatIfr.src = '获取basePath' + 'multiChat_n.jsp';
	$sob = $('.saying-dialog .option-bar');
	initChat();
    if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
    $sob.click(); 
    */
    $("#entryBtn").hide();
    $("#cancelBiddingBtn").hide();
	$("#sendToSupplier").hide();
    $("#saveScoreTargetBtn").hide();
    $("#sendTenderBidConfig").hide();
	init();
});

//发送至投标方 ----OLD
$("#sendToSupplierxxxx").click(function() {
	var yes = false;
	var yes2 = 0;
	var itemRows = itemGrid.selectedRows();
	var itemRowsIndex=itemGrid.selectedRowsIndex();
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_alert_bargain_pleaseSelectItem" defaultValue="请选择行项目!" />!',2);
		return;
	}
	
	for(var i= 0; i<=itemRows.length-1; i++) {
		var ind = itemRowsIndex[i];
		var selectvalue =document.getElementsByName("selected")[ind].value;
		if(selectvalue != null){
			if(selectvalue.indexOf('接受') != -1 
					|| selectvalue.indexOf('淘汰') != -1){
				yes = true;
			}
		}
	}
	if(!yes){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	//fbk1 0: 未应标 1:应标中 2:已投标 3:未中标 4:已中标 5:已结束
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_reallySent" defaultValue="是否确认发送?" />',closeEvent:function(){
		for(var i= 0; i<=itemRows.length-1; i++) {
			var ind = itemRowsIndex[i];
			var selectvalue =document.getElementsByName("selected")[ind].value;
			if(selectvalue != null){
				if(selectvalue.indexOf('淘汰') != -1){
					itemRows[i].fbk10 = 3;
				}else if(selectvalue.indexOf('接受') != -1){
					itemRows[i].fbk10 = 4; 
				}
			}
			var fbk1 =document.getElementsByName("fbk1")[ind].value;
			itemRows[i].fbk1 = fbk1;
		}
		
		parent.elsDeskTop.showLoading();
		//发送至供应商
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/enquiryContentItemsSendToSuppliers' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRows),
			dataType : "json",
			success : function(data) {
    			alert('<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />',1);
    		},error : function(data) {
    			alert('<i18n:I18n key="i18n_common_sendfail" defaultValue="发送失败" />',3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    			//loadItem();
    		}
		});
		

	}});
	
});

//提交审批
$("#entryBtn").click(function(){

	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_confirmReportAudit" defaultValue="是否确定提交审批?" />!',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToAudit' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRows),
			dataType : "json",
			success : function(data) {
    			alert(data.message,1);
    			query();
    		},error : function(data) {
    			alert("发送失败",3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}});
});

//撤销审批
$("#cancelEntryBtn").click(function(){
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_confirmCancelReportAudit" defaultValue="是否确定撤销审批?" />!',closeEvent:function(){
		for(var i= 0; i<=itemRows.length-1; i++) {
			itemRows[i].elsSubAccount = elsSubAccount;
			itemRows[i].auditStatus = 1;
		}
		
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToCancel' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRows),
			dataType : "json",
			success : function(data) {
    			alert(data.message,1);
    			query();
    		},error : function(data) {
    			alert("发送失败",3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}});
});

//查看流程
$("#flowBtn").click(function(){
	var itemRows = itemGrid.selectedRows();
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	var targetElsAccount = itemRows[0].elsAccount;
	var businessType = "bargainEnquiry";
	var businessId = itemRows[0].toElsAccount+","+itemRows[0].purchaseEnquiryNumber+","+itemRows[0].materialLineNumber;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'auditFlowList',
        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
        windowSubTitle: "",
        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
        windowMinWidth: 480,
        windowMinHeight: 600,
        'windowWidth':680,
        'windowHeight':600,
        'parentPanel':".currDesktop"
    });
});

//发送至ERP
$("#uploadToERP").click(function(){
	var itemRows = itemGrid.selectedRows();
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_title_sendToErp" defaultValue="是否确定发送ERP?" />!',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		//发送至供应商
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBargainService/enquiryItemsSendToERP' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRows),
			dataType : "json",
			success : function(data) {
    			alert(data.message,1);
    			query();
    		},error : function(data) {
    			alert(data.message,3);
    		},complete : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}});
});

//表单文件  列自定义
$("#fileColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + 
	    		 elsAccount + "&elsSubAccount="+elsSubAccount +
	    		 "&tableCode=purchaseEnquiryBargainFile" +
	    		 "&window=iframeApp_PurchaseBiddingBargainDetail",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});

//历史报价  中标
$("#historyBtn").click(function(){
	debugger;
	var itemRows = itemHistory.selectedRows();
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	var itemRow = itemRows[0];
	if(itemRow.totalPrice==''||itemRow.totalPrice==null){
		alert('<i18n:I18n key="test" defaultValue="单价不能为空" />!',2);
		return;
	}
	if(itemRow.totalPrice==''||itemRow.totalPrice==null){
		alert('<i18n:I18n key="test" defaultValue="总价不能为空" />!',2);
		return;
	}
	var biddingEndDate = $("#biddingEndDate").val();
	if(new Date().getTime() < Date.parse(biddingEndDate)){
		alert('<i18n:I18n key="test" defaultValue="投标尚未结束！操作失败" />!',2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确定中标?" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/purchaseBiddingContentOnlinePriceSendToSap' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(itemRow),
			dataType : "json",
			success : function(data) {
				if(data.statusCode == "-100"){
					alert(data.message,2);
				}else{
					alert("操作成功",1);
				}
    			itemHistory.load({page:1});
    		},error : function(data) {
				debugger;
    			alert("操作失败",1);
    		},complete : function(data) {
				debugger;
    			parent.elsDeskTop.hideLoading();
    		}
		});
	}});
});


// 渲染   @author jiangzhidong 20160113  begin
//类型 
var rendererPurchaseType = function (val,item,index){
	if(val==0) return "外购";
	else if(val==1) return "外协";
	else if(val==2) return "寄售票员";
	else if(val==3) return "其他";
	else return "未说明";
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
//招标状态
function rendererBiddingStatus(val){
    	if(val==0){
    		return '<i18n:I18n key="test" defaultValue="未开始" />';
    	}else if(val==1){
    		return '<i18n:I18n key="test" defaultValue="进行中" />';
    	}else if(val==2){
    		return '<i18n:I18n key="test" defaultValue="已定标" />';
    	}else if(val==3){
    		return '<i18n:I18n key="test" defaultValue="已完成" />';
    	}
}

//评标状态
//fbk1 0: 未应标 1:应标中 2:已投标 3:未中标 4:已中标 5:已结束
var fbk1 = function (val,item,index){
	if (val == "3") return '<i18n:I18n key="test" defaultValue="淘汰" />';
	else if (val == "4") return '<i18n:I18n key="test" defaultValue="接受" />';
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
//时间
var formatTime = function (val,item,index){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("hh:mm:ss");}
	return val;
};
// 时间凭借
function toDateAndTime(date,time){
	var arrDate = date.split("-");
	var arrTime = time.split(":");
	return new Date(arrDate[0],arrDate[1]-1,arrDate[2],arrTime[0],arrTime[1],arrTime[2]).format("yyyy-MM-dd hh:mm:ss");
}
//附件需求
var initAccessoryRequire = function (val,item,index){
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
	//常规报价 
	if(item.quoteMethod==0)
		return '<div>' +val+ '</div>';
	//阶梯报价
	else if(item.quoteMethod==1){
		var contain='';
		for(var i=0; i<=item.ladderPrices.length-1;i++) {
			var bottom_line = i==item.ladderPrices.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'">' +item.ladderPrices[i].beginQuantity+'&nbsp;-&nbsp;'+item.ladderPrices[i].endQuantity+ '</div>';
		}
        return contain;
	}
	return;
};
//含税单价
var initPriceIncludingVat = function(val,item,index) {
	//警告提示  @author jiangzhidong @date 20160201
	var title3='<img title="注意: 大于基准价格30%以上" src="<%=basePath%>/icon/ico-warn3.png" style="width:15px; height:15px; margin-right:10px; float:right; cursor: pointer;"/>';
	var title1='<img title="注意: 大于基准价格10%以上" src="<%=basePath%>/icon/ico-warn.png" style="width:15px; height:15px; margin-right:10px; float:right; cursor: pointer;"/>';
	if(item.FBK31==3)
		val=val+title3;
	else if(item.FBK31==1)
		val=val+title1;
	//常规报价
	if(item.quoteMethod==0)
		return '<div style="color: red;">' +val+ '</div>';
	//阶梯报价
	else if(item.quoteMethod==1){
		var contain='';
		for(var i=0; i<=item.ladderPrices.length-1;i++) {
			var bottom_line = i==item.ladderPrices.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'" style="color: red;">' +item.ladderPrices[i].price+ '</div>';
		}
        return contain;
	}
	return;
};
//成本项目代码
var initCostItemCode = function (val,item,index){
	var contain='';
	if(item.costConstitute){
		for(var i=0; i<=item.costConstitute.length-1;i++) {
			var bottom_line = i==item.costConstitute.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'">' +item.costConstitute[i].costItemCode+ '</div>';
		}
        return contain;
    }
};
//成本项目名称
var initCostItemName = function (val,item,index){
	var contain='';
	if(item.costConstitute){
		for(var i=0; i<=item.costConstitute.length-1;i++) {
			var bottom_line = i==item.costConstitute.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'">' +item.costConstitute[i].costItemName+ '</div>';
		}
        return contain;
    }
};
//成本项目金额
var initCostItemAmount = function (val,item,index){
	var contain='';
	if(item.costConstitute){
		for(var i=0; i<=item.costConstitute.length-1;i++) {
			var bottom_line = i==item.costConstitute.length-1? '': 'bottom_line';
            contain +='<div class="'+bottom_line+'" style="color: red;">' +item.costConstitute[i].costItemAmount+ '</div>';
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
						+'<option value ="淘汰"><i18n:I18n key="test" defaultValue="淘汰" /></option></select>'
		return selected;
	}
};
//时间戳
var formatDateTime = function (val,item,index){
	if (!val) {val = "";}
	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
};
//报价
var initPriceIncludingVat = function (val,item,index){
	if (!val) {val = "";}
	return '<div style="color: red;">' +val+ '</div>';
};
//在线竞标状态  : 0或null:有效竞价  1:中标
function rendererFbk3(val){
   	if(val==0 || val=='' || val ==null){
   		return '<i18n:I18n key="test" defaultValue="有效竞价" />';
   	}else if(val==1){
   		return '<i18n:I18n key="test" defaultValue="中标" />';
   	}
}

//渲染   @author jiangzhidong 20160113  end
var phasesTableCols = [
		{title : '<i18n:I18n key="" defaultValue="标段编号" />', name : 'biddingItemNumber',width : 80, align : 'center' },
		{title : '<i18n:I18n key="" defaultValue="标段名称" />', name : 'biddingItemName',width : 200, align : 'center' },
		{title : '<i18n:I18n key="" defaultValue="标段备注说明" />', name : 'remark', width : 200, align : 'center' } 
	];
var cols_rounds = [
     			{title:'轮次',name:'roundsNumber', width: 100, align: 'center'},
     			{title:'投标开始日期',name:'biddingBeginDate', width: 250, align: 'center', renderer:formatDateTime},
     			{title:'投标结束日期', name:'biddingEndDate', width: 250, align: 'center', renderer:formatDateTime},
     			{title:'状态',name:'biddingStatus', width: 120, align: 'center', renderer:rendererBiddingStatus}
     		];
var cols_rounds_online = [
        			{title:'轮次',name:'roundsNumber', width: 100, align: 'center'},
        			{title:'投标开始日期',name:'biddingBeginDate', width: 250, align: 'center', renderer:formatDateTime},
        			{title:'投标结束日期', name:'biddingEndDate', width: 250, align: 'center', renderer:formatDateTime},
        			{title:'采购限价',name:'fbk1', width: 120, align: 'center'},
        			{title:'降价幅度',name:'fbk2', width: 120, align: 'center'},
        			{title:'幅度单位',name:'fbk3', width: 120, align: 'center',renderer:function(val){
        				if(val == "0"){
        					return "金额（元）";
        				}else if(val == "1"){
        					return "百分比(%)";
        				}else{
        					return "";
        				}
        			}}
        		];
//历史轮次    		
var cols_history = [
        			{title:'轮次',name:'currentCount', width: 60, align: 'center'},
        			{title:'日期',name:'biddingTime', width: 100, align: 'center', renderer:formatDate},
        			{title:'时间',name:'biddingTime', width: 100, align: 'center', renderer:formatTime},
        			{title:'供应商ELS', name:'toElsAccount', width: 80, align: 'center'},
        			{title:'供应商名称', name:'fbk2', width: 120, align: 'center'},
        			{title:'单价', name:'price', width: 60, align: 'center'},
        			{title:'总价', name:'totalPrice', width: 60, align: 'center'},
        			{title:'状态', name:'fbk3', width: 60, align: 'center',renderer:rendererFbk3},
        			{ title:'备注', name:'remark', width: 100, align: 'center'},
        		];
			

//初始化控件
function init() {
	
    //头表purchase_bidding_header
    var headParam = {
    	'elsAccount':elsAccount,
    	//'toElsAccount':toElsAccount,
    	'biddingNumber':biddingNumber,
    	'biddingItemNumOne':biddingItemNumOne
    };

	parent.elsDeskTop.showLoading();
    //加载头
	$.ajax({
		url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/getEnquiryBidding' + "?t="+new Date().getTime(),
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(headParam),
		dataType : "json",
		success : function(data) {
			// 招标审批状态
			$("#biddingStatus").val(data.biddingStatus);
			var biddingNumber = data.biddingNumber;
			//招标编号
			$("#biddingNumber2").text(biddingNumber);
			$("#biddingNumber").val(biddingNumber);
			//招标类型
			//招标名称
			$(".init-biddingName").val(data.biddingName);
			$("#remarkBase").val(data.summary);
			//开标日期
			//$("#opentime").text(formatDate(data.beginDate));
			$("#fbk2").text(data.fbk2);
			$("#fbk3").text(data.fbk3);
			$("#totalRound").text(data.biddingRoundItms.length);
			$(".init-biddingType").val(data.biddingType);
			$("#biddingType2").text($("#biddingType option:selected").text());
			formatTime(data.biddingRoundItms[0].biddingBeginDate)
			$("#biddingBeginDate").val(toDateAndTime(new Date(data.biddingRoundItms[0].biddingBeginDate).format('yyyy-MM-dd'),data.biddingRoundItms[0].biddingBeginTime));
			$("#biddingEndDate").val(toDateAndTime(new Date(data.biddingRoundItms[data.biddingRoundItms.length -1].biddingEndDate).format('yyyy-MM-dd'),
					data.biddingRoundItms[data.biddingRoundItms.length -1].biddingEndTime));
			$("#biddingEndDate").val(toDateAndTime(new Date(data.biddingRoundItms[data.biddingRoundItms.length -1].biddingEndDate).format('yyyy-MM-dd'),
					data.biddingRoundItms[data.biddingRoundItms.length -1].biddingEndTime));
			var cols_round;
			//判断是否在线竞标
			if(data.biddingType == 2){
				$(".sheet-project-one1").hide();
				$(".sheet-project-one2").hide();
				$(".bid-evaluation").hide();
				$("#entryBtn").show();
				$("#cancelBiddingBtn").show();
				 //历史轮次信息
				itemHistoryLoad();
				timerLoad(headParam);
			} else if(data.biddingType != 3 ){
				$(".online-bidding").hide();
				cols_round = cols_rounds;
				$(".sheet-project-online2").hide();// 在线竞价
			}else{
				$(".sheet-project-online2").show();
				// 选中tab 测试用 @author jiangzhidong @date 20160324
				$(".tab-wrap").tabs({
					active: 4,
				});
				//每轮持续/分钟
				$("#roundMinutes").val(data.fbk2);
				//每轮间隔/分钟
				$("#intervalMinutes").val(data.fbk3);
				//采购限价
				$(".init-limitPrices").val(data.fbk4);
				cols_round = cols_rounds_online;
				
				timerLoad(headParam);
				
			   }
			var biddingPhasesItems = data.biddingPhasesItems;
			var phaseItemsLen = biddingPhasesItems.length;
			if(biddingPhasesItems != null && phaseItemsLen > 1){
				phasesTable=$('#phases-table').mmGrid({
				    cols: phasesTableCols,
				    items:biddingPhasesItems,
				    height: 140,
				    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
				});
			}
		    //招标轮次信息
		    /*
		    itemRounds = $('#baseTable').mmGrid({
		        cols: cols_round,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: false,
		        multiSelect: true,
		        items:data.biddingRoundItms
		    });
			*/
			//招标说明
			$("#remark").val(data.remark);
			
			//采购方招标联系人信息
			var biddingLinkmanVOs = data.biddingLinkmanVOs;
			for(var i = 0 ; i < biddingLinkmanVOs.length ; i ++) {
				linkMan = biddingLinkmanVOs[i];
				var linkmanType = linkMan.linkmanType;
				if(linkmanType == 0) {//是否代理招标单位 
					$("#orgName").val(linkMan.orgName);
					$("#principal").val(linkMan.principal);
					$("#telephone").val(linkMan.telephone);
					$("#email").val(linkMan.email);
					$("#fax").val(linkMan.fax);
					$("#bidding-address").val(linkMan.address);
				} else {
					$("#dl_orgName").val(linkMan.orgName);
					$("#dl_principal").val(linkMan.principal);
					$("#dl_telephone").val(linkMan.telephone);
					$("#dl_email").val(linkMan.email);
					$("#dl_fax").val(linkMan.fax);
					$("#dl_address").val(linkMan.address);
				}
			}
			// 保证金信息
			biddingMarginVOs = data.biddingMarginVOs;
			if(biddingMarginVOs &&  biddingMarginVOs.length>0) {
				var multiSection = biddingMarginVOs[0].multiSection;//获取保证金列表中任意一条数据，查看保证金是否区分标段
				$("input[name='biddingMarginVO[multiSection]']").attr("disabled",true);
				var margin ;
				if(multiSection == 0) {
					$("input[name='biddingMarginVO[multiSection]']").eq(0).attr("checked",'checked');
					$("#margin_distinguishPhases").attr("disabled",true);
					margin = biddingMarginVOs[0];
				} else {
					$("input[name='biddingMarginVO[multiSection]']").eq(1).attr("checked",'checked');
					$("body").data("biddingMargins",biddingMarginVOs);
					for(var i = 0 ; i < phaseItemsLen ; i ++) {
						var item = biddingPhasesItems[i];
						var biddingItemName = item.biddingItemName;
						var biddingItemNumber = item.biddingItemNumber;
						var option = '<option value="'+biddingItemNumber+'">标段'+biddingItemNumber+" "+biddingItemName+'</option>';
						$("#margin_distinguishPhases").append(option);
					}
					$("#margin_distinguishPhases").val("1");//默认选择标段1
					$("body").data("margin_distinguishPhases","1");
					$("#margin_distinguishPhases option[value='0']").attr("disabled",true);
					for(var i = 0 ; i < biddingMarginVOs.length ; i ++) {
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
				$("#margin_payBeginDate").val(formatDate(margin.payBeginDate));
				$("#margin_payEndDate").val(formatDate(margin.payEndDate));
				$("body").data("init_margin_flag",true);//设置成已经初始化
			}

			//采购方投标内容行编号
			//loadItem();
			//采购方招标内容信息
			var biddingContentVOs = data.biddingContentVOs;
			var biddingContentItemVOs = data.biddingContentItemVOs;
			var biddingContentStandardVOs = data.biddingContentStandardVOs;
			var setBiddingContent;
			var contentItemArray=new Array();
			var contentStandardArray=new Array();
			if(biddingContentVOs &&  biddingContentVOs.length>0) {
				var setItemNumberObj = $("#contentBiddingItemNumber");
				if(biddingPhasesItems && phaseItemsLen > 1) {
					 setItemNumberObj.empty();
					 for(var i=0;i<biddingPhasesItems.length;i++) {
						 setItemNumberObj.append("<option value='"+biddingPhasesItems[i].biddingItemNumber+"'>"+biddingPhasesItems[i].biddingItemName+"</option>");
					 }
					 if(typeof(biddingContentItemStandardArray)=="undefined" || !$.isArray(biddingContentItemStandardArray)) {
				 		biddingContentItemStandardArray= new Array(biddingContentVOs.length);
					 }
					 for(var i=0;i<biddingContentVOs.length;i++) {
						 if(biddingContentVOs[i].biddingItemNumber==1) {
							 setBiddingContent=biddingContentVOs[i];
						 }
					 }
					 for(var j=0;j<biddingContentItemVOs.length;j++) {
						 if(biddingContentItemVOs[j].biddingItemNumber==1) {
							 biddingContentItemVOs[j].deliveryDate=new Date(biddingContentItemVOs[j].deliveryDate).format('yyyy-MM-dd');
							 contentItemArray.push(biddingContentItemVOs[j]);
						 }
					 }
					 for(var i=0;i<biddingContentStandardVOs.length;i++) {
						 if(biddingContentStandardVOs[i].biddingItemNumber==1) {
							 contentStandardArray.push(biddingContentStandardVOs[i]);
						 }
					 } 
					 for(var i=0;i<biddingContentItemStandardArray.length;i++) {
						 var contentA = biddingContentVOs[i];
						 var contentI = new Array();
						 var contentS = new Array();
						 for(var j=0;j<biddingContentItemVOs.length;j++) {
							 if(biddingContentItemVOs[j].biddingItemNumber==(i+1)) {
								 contentI.push(biddingContentItemVOs[j]);
							 }
						 }
						 for(var k=0;k<biddingContentStandardVOs.length;k++) {
							 if((i+1)==biddingContentStandardVOs[k].biddingItemNumber) {
								 contentS.push(biddingContentStandardVOs[k]);
							 }
						 } 
						 contentA["biddingContentItem"]=contentI;
						 contentA["biddingContentStandard"]=contentS;
						 biddingContentItemStandardArray[i]=contentA;
					 }
					 $("#contentBiddingItemNumber").val("1");//默认选择标段1
					 $("body").data("contentBiddingItemNumber_local","1");
				 } else {
					 setItemNumberObj.empty();
					 setItemNumberObj.append("<option value='0'>不区分标段</option>");
					 if(typeof(biddingContentItemStandardArray)=="undefined" || !$.isArray(biddingContentItemStandardArray)) {
				 		biddingContentItemStandardArray= new Array(0);
					 }
					 setBiddingContent=biddingContentVOs[0];
					 for(var i=0;i<biddingContentItemVOs.length;i++) {
						 contentItemArray.push(biddingContentItemVOs[i]);
					 }
					 for(var i=0;i<biddingContentStandardVOs.length;i++) {
						 contentStandardArray.push(biddingContentStandardVOs[i]);
					 }
					 biddingContentVOs["biddingContentItem"]=biddingContentItemVOs;
					 biddingContentVOs["biddingContentStandard"]=biddingContentStandardVOs;
					 biddingContentItemStandardArray[0]=biddingContentVOs;
				 }
				 $("#contentSummary").val(setBiddingContent.summary);
			 	 $("#contentBiddingProjectNumber").val(setBiddingContent.biddingProjectNumber);
				 $("#contentBiddingProjectName").val(setBiddingContent.biddingProjectName);
				 $("#contentDeliveryStartDate").val(formatDate(setBiddingContent.deliveryStartDate));
				 $("#contentDeliveryEndDate").val(formatDate(setBiddingContent.deliveryEndDate));
				 $("#contentAddress").val(setBiddingContent.address);
				 $("#contentQuality").val(setBiddingContent.quality);
				 if(biddingContentItemVOs != null && biddingContentItemVOs.length > 0) {
					 biddingDetailContentGrid=$('#biddingDetailContentTable').mmGrid({
					    cols: biddingDetailContentItem,
					    items: contentItemArray,
					    height: 140,
					    hasJsonOption : "extendFields",
					    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
					});
					biddingDetailContentGrid.resize();
				  }
				 if(biddingContentItemVOs != null && biddingContentItemVOs.length > 0) {
					 biddingStandardGrid=$('#biddingStandardTable').mmGrid({
					    cols: biddingStandardItem,
					    items: contentStandardArray,
					    height: 140,
					    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
					});
				  }
			}

			 /**
			 * 设置供应商报价信息
			 */
			 var setBiddingContent2;
			if(biddingContentVOs &&  biddingContentVOs.length>0) {
				var setItemNumberObj2 = $("#contentBiddingItemNumber2");
				var setRoundNumberObj2 = $("#contentBiddingRound2");
				if(biddingPhasesItems && phaseItemsLen > 1) {
					 setItemNumberObj2.empty();
					 setRoundNumberObj2.empty();
					 if(typeof(biddingContentItemSupplierArray1)=="undefined" || !$.isArray(biddingContentItemSupplierArray1)) {
						 biddingContentItemSupplierArray1= new Array(biddingContentVOs.length);
					 }
					 for(var i=0;i<biddingPhasesItems.length;i++) {
						 var biddingPhasesItemi = biddingPhasesItems[i];
						 setItemNumberObj2.append("<option value='"+biddingPhasesItems[i].biddingItemNumber+"'>"+biddingPhasesItems[i].biddingItemName+"</option>");
						// 默认第一标段的轮次
						 if(i==0) {
							 var biddingRoundss =  biddingPhasesItemi.biddingRounds;
							 for(var is=0;is<biddingRoundss.length;is++) {
								 setRoundNumberObj2.append("<option value='"+biddingRoundss[is].roundsNumber+"'>第"+biddingRoundss[is].roundsNumber+"轮</option>");
							 }
						 }
						if(!biddingContentItemSupplierArray1[i])
							biddingContentItemSupplierArray1[i]=[];
						if(!biddingContentItemSupplierArray1[i].rounds) {
							 biddingContentItemSupplierArray1[i].rounds = [];
							 var biddingRoundss =  biddingPhasesItemi.biddingRounds;
							 for(var is=0;is<biddingRoundss.length;is++) {
								 var tempArry = {roundsNumber : biddingRoundss[is].roundsNumber};
								 biddingContentItemSupplierArray1[i].rounds.push(tempArry);
							 }
						}
					 }
					 // 设置当前默认标段轮次
				 	 setRoundNumberObj2.val("1");
					 $("body").data("contentBiddingRoundNumber_local2",0);
					 setItemNumberObj2.val("1");
					 $("body").data("contentBiddingItemNumber_local2",0);
					 setBiddingContent2=biddingContentVOs[0];
					 $("#contentBiddingItemNumber2").val("1");
				} else {
					 setItemNumberObj2.empty();
					 setItemNumberObj2.append("<option value='0'>不区分标段</option>");
					 if(typeof(biddingContentItemSupplierArray1)=="undefined" || !$.isArray(biddingContentItemSupplierArray1)) {
						 biddingContentItemSupplierArray1= [];
					 }
					 // 轮次
					 var biddingRoundss =  data.biddingRoundItms;
					 for(var is=0;is<biddingRoundss.length;is++) {
						 setRoundNumberObj2.append("<option value='"+biddingRoundss[is].roundsNumber+"'>第"+biddingRoundss[is].roundsNumber+"轮</option>");
						 var tempArry = {};
						 tempArry["roundsNumber"] = biddingRoundss[is].roundsNumber;
						 tempArry["biddingStatus"] = biddingRoundss[is].biddingStatus;
						 tempArry["isCurrentRound"] = biddingRoundss[is].isCurrentRound;
						 tempArry["secret"] = biddingRoundss[is].secret;
						 if(!biddingContentItemSupplierArray1[0])
							 biddingContentItemSupplierArray1[0]=[];
						 if(!biddingContentItemSupplierArray1[0].rounds)
							 biddingContentItemSupplierArray1[0].rounds=[];
						 biddingContentItemSupplierArray1[0].rounds.push(tempArry);
					 }
				}
				setBiddingContent2 = biddingContentVOs[0];
				var curRound = setBiddingContent2.curRound;
				// 设置当前轮次
			 	setRoundNumberObj2.val(curRound);
				$("body").data("contentBiddingRoundNumber_local2",setRoundNumberObj2.get(0).selectedIndex);
				$("#projectNumber").val(setBiddingContent2.biddingProjectNumber);
				$("#projectRemark").val(setBiddingContent2.biddingProjectName);
			}

			 //加载评标定标----begin-------
			//var biddingContentVOs = data.biddingContentVOs;
			var setBiddingContent1;
			var scoreTargetArray = new Array();
			if(biddingContentVOs &&  biddingContentVOs.length>0) {
				var setItemNumberObj = $("#contentBiddingItemNumber1");
				var setRoundNumberObj = $("#contentBiddingRound");
				var biddingEvalTargetScoreVOs = data.biddingEvalTargetScoreVOs;
				if(biddingPhasesItems && phaseItemsLen > 1) {
					 setItemNumberObj.empty();
					 setRoundNumberObj.empty();
					 for(var i=0;i<biddingPhasesItems.length;i++) {
						 var biddingPhasesItemi = biddingPhasesItems[i];
						 setItemNumberObj.append("<option value='"+biddingPhasesItemi.biddingItemNumber+"'>"+biddingPhasesItemi.biddingItemName+"</option>");
						 // 默认第一标段的轮次
						 if(i==0) {
							 var biddingRoundss =  biddingPhasesItemi.biddingRounds;
							 for(var is=0;is<biddingRoundss.length;is++) {
								 setRoundNumberObj.append("<option value='"+biddingRoundss[is].roundsNumber+"'>第"+biddingRoundss[is].roundsNumber+"轮</option>");
							 }
							 $("body").data("cur_item_total_round",biddingRoundss.length);
						 }
					 }
					 if(typeof(biddingContentItemStandardArray1)=="undefined" || !$.isArray(biddingContentItemStandardArray1)) {
					 		biddingContentItemStandardArray1= new Array(biddingContentVOs.length);
					 }
					 // 设置当前默认标段轮次
				 	 setRoundNumberObj.val("1");
					 $("body").data("contentBiddingRoundNumber_local1",0);
					 $("#curBiddingStatusSpan").html('<font color="red">'+showBiddingStatusContent(biddingPhasesItems[0].biddingRounds[0].biddingStatus)+'</font>');
					 setItemNumberObj.val("1");
					 $("body").data("contentBiddingItemNumber_local1",0);
					 setBiddingContent1=biddingContentVOs[0];
					 for(var i=0;i<biddingContentVOs.length;i++) {
						 var curRound = biddingContentVOs[i].curRound;
						 if(curRound!="1") {
						 	setBiddingContent1=biddingContentVOs[i];
							 // 设置当前标段
							 setItemNumberObj.val(setBiddingContent1.biddingItemNumber);
							 $("body").data("contentBiddingItemNumber_local1",setItemNumberObj.get(0).selectedIndex);
							 // 如果不是第一标段，设置该标段的轮次
							 if(i>0) {
								 setRoundNumberObj.empty();
								 var biddingRoundss =  biddingPhasesItems[i].biddingRounds;
								 for(var is=0;is<biddingRoundss.length;is++) {
									 setRoundNumberObj.append("<option value='"+biddingRoundss[is].roundsNumber+"'>第"+biddingRoundss[is].roundsNumber+"轮</option>");
								 }
								 // *******需要实际测试多标段的各种情况********
								 $("body").data("cur_item_total_round",biddingRoundss.length);
							 }
							 // 设置当前轮次
						 	 setRoundNumberObj.val(curRound);
							 var curSelIndex = setRoundNumberObj.get(0).selectedIndex;
							 $("body").data("contentBiddingRoundNumber_local1",curSelIndex);
							 $("#curBiddingStatusSpan").html('<font color="red">'+showBiddingStatusContent(biddingPhasesItems[i].biddingRounds[curSelIndex].biddingStatus)+'</font>');
							 break;
						 }
					 }
					 for(var i=0;i<biddingEvalTargetScoreVOs.length;i++) {
						 scoreTargetArray.push(biddingEvalTargetScoreVOs[i]);
					 }
					 for(var i=0;i<biddingContentVOs.length;i++) {
						 var contentA = biddingContentVOs[i];
						 var biddingRoundss =  biddingPhasesItems[i].biddingRounds;
						 contentA["biddingRounds"]=biddingRoundss;
						 if("undefined"==typeof(contentA["biddingRounds"])) {
							 contentA["biddingRounds"] = [];
						 }
						 biddingContentItemStandardArray1[i]=contentA;
					 }
					 $("#scoreTargetSelChange").val("1");
				 } else {
					 setItemNumberObj.empty();
					 setBiddingContent1=biddingContentVOs[0];
					 setItemNumberObj.append("<option value='0'>不区分标段</option>");
					 if(typeof(biddingContentItemStandardArray1)=="undefined" || !$.isArray(biddingContentItemStandardArray1)) {
						 biddingContentItemStandardArray1= new Array(0);
					 }
					 // 轮次
					 var biddingRoundss =  data.biddingRoundItms;
					 for(var is=0;is<biddingRoundss.length;is++) {
						 setRoundNumberObj.append("<option value='"+biddingRoundss[is].roundsNumber+"'>第"+biddingRoundss[is].roundsNumber+"轮</option>");
					 }
					 $("body").data("cur_item_total_round",biddingRoundss.length);
					 for(var i=0;i<biddingEvalTargetScoreVOs.length;i++) {
						 scoreTargetArray.push(biddingEvalTargetScoreVOs[i]);
					 }
					 var biddingRoundItms = data.biddingRoundItms;
					 if("undefined"==typeof(biddingRoundItms)) {
						 biddingRoundItms = [];
					 }
					 setBiddingContent1=biddingContentVOs[0];
					 var curRound = setBiddingContent1.curRound;
					 // 设置当前轮次
				 	 setRoundNumberObj.val(curRound);
					 $("body").data("contentBiddingRoundNumber_local1",setRoundNumberObj.get(0).selectedIndex);
					 setBiddingContent1["biddingRounds"] = biddingRoundItms;
					 biddingContentItemStandardArray1[0]=setBiddingContent1;
				 }
				 initEvalTargetScoreSum(scoreTargetArray);
				if(typeof(setBiddingContent1)!="undefined") {
					 $("#contentSummary1").val(setBiddingContent1.summary);
				 	 $("#contentBiddingProjectNumber1").val(setBiddingContent1.biddingProjectNumber);
					 $("#contentBiddingProjectName1").val(setBiddingContent1.biddingProjectName);
					 $("#contentDeliveryStartDate1").val(new Date(setBiddingContent1.deliveryStartDate).format('yyyy-MM-dd'));
					 $("#contentDeliveryEndDate1").val(new Date(setBiddingContent1.deliveryEndDate).format('yyyy-MM-dd'));
					 $("#contentAddress1").val(setBiddingContent1.address);
					 $("#contentQuality1").val(setBiddingContent1.quality);
				}
				scoreTargetGrid=$('#scoreTargetTable').mmGrid({
					    cols: scoreTargetItem,
					    items: scoreTargetArray,
					    height: 280,
					    checkCol: false,
					    autoLoad:false,
				        multiSelect:true,
					    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
				});
				scoreTargetGrid.resize();

			}
			//加载评标定标----end-------
			// 受邀方列表
			var setItemNumberSYFObj = $("#contentBiddingItemNumberSYF");
			if(biddingPhasesItems && phaseItemsLen > 1) {
				setItemNumberSYFObj.empty();
				 for(var i=0;i<biddingPhasesItems.length;i++) {
					 setItemNumberSYFObj.append("<option value='"+biddingPhasesItems[i].biddingItemNumber+"'>"+biddingPhasesItems[i].biddingItemName+"</option>");
				 }
			}
			 //历史轮次信息
			 itemHistoryLoad();
		},
		error : function(data) {
			alert("加载失败",3);
		},complete : function(data) {
			parent.elsDeskTop.hideLoading();
		}
	});
    
	//历史轮次信息
	function itemHistoryLoad(){
		//加载竞价
	    var headParamBak = {
	   	'elsAccount':elsAccount,
	   	'biddingNumber':biddingNumber
	   };
		$.ajax({
			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/getPurchaseBiddingContentItem' + "?t="+new Date().getTime(),
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(headParamBak),
			dataType : "json",
			success : function(data) {
				$("#materialSpecification").val(data.materialSpecification);// 材料规范
				$("#quantity").val(data.quantity);// 采购数量
				$("#unitQuantity").val(data.unitQuantity);// 计量单位 
				$("#property1").val(data.property1);//
				var deliveryDate = data.deliveryDate;// 完成日期
				if (deliveryDate!=null&&deliveryDate.length!=10)
					deliveryDate = new Date(deliveryDate).format("yyyy-MM-dd");
				$("#deliveryDate").val(deliveryDate);
				$("#materialNumber").val(data.materialNumber);// 物料编号
				$("#materialDesc").val(data.materialDesc);// 名称描述
				//当前最低报价
				$(".currentMinPrice").html(data.fbk3);
				$("#currentMinPrice").val(data.fbk3);
				
			},
			error : function(data) {
				alert("加载失败",3);
			}
		});
		
		 //加载竞价
	    var fileParam = {
			'elsAccount':elsAccount,
	    	'biddingNumber':biddingNumber
		};
		itemHistory = $('#historyTable').mmGrid({
		    cols: cols_history,
		    url: '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryPurchaseBiddingContentOnlinePriceByCondtion',
		    params: fileParam,
		    method: 'post',
		    root: 'rows',
		    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		   // fullWidthRows:true,
		    multiSelect : false,
	        checkCol : true,
	        indexCol : false,
		    height:250,
	        width:730,
		    plugins: [
	              $('#onlinePage').mmPaginator({
	                  style: 'plain'
	                  , totalCountName: 'total'
	                  , page: 1
	                  , pageParamName: 'currentPage'
	                  , limitParamName: 'pageSize'
	                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
	                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
	                  , limit: null
	                  , limitList: [10,15,20]
	              })
	          ]
		});
		refreshPrice();//开始刷新
	};

	function refreshPrice(){
		var fileParam = {
				'elsAccount':elsAccount,
		    	'biddingNumber':biddingNumber
			};
		var biddingEndDate = $("#biddingEndDate").val();
		if("undefined"!=typeof(biddingEndDate)){
			if(Date.parse(biddingEndDate) < new Date().getTime()){
				return;
			}
		}
		intervalItemHis = setInterval(function() {
			itemHistory.load(fileParam);
			$.ajax({
				url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryCurrentMinPrice',
				type : 'POST',
				contentType : "application/json",
				data : JSON.stringify(fileParam),
				dataType : "json",
				success : function(data) {
					$(".currentMinPrice").html(data.fbk3);
					$("#currentMinPrice").val(data.fbk3);
				/* 	//windows
				 	var path = data.fbk20;
				 	if(path=="") path = "1.jpg";
				 	path = path.substring(path.lastIndexOf(':')+1);
					$("#fbk20").attr("src",path);
					//linux
					//$("#logoImage").attr("src",logoPath+fbk1);   */
					key = data.key || [];
					value = data.value || [];
					bar123();
				}
			});
	    }, 5000);
	}
    
    //加载  表单文件
    var tab=$( "#sheet-project").tabs();
    $('.scan-file-sheet').click(function() {
     	loadFile();
    });
  	//加载  回签文件
    $('.scan-form-sheet').click(function() {
    	loadForm();
    });
    
    //我方的文件  对方的文件
   	$('#selectPurchaseSale').change(function(){
       	var fileRows = editFileTable.rows();
       	debugger;
       	var sps = $('#selectPurchaseSale').val();
       	if(sps == "0"){
       		loadFile();
       	}else if(sps == "1"){
       		for(var i=0;i<fileRows.length;i++){
       		$("#add-file-project tr:eq("+i+")").show();
       			var fileOwner = fileRows[i].fileOwner;
       			if(fileOwner == "1"){
       				$("#add-file-project tr:eq("+i+")").hide();
       			}
       		}
       	}else {
       		for(var i=0;i<fileRows.length;i++){
       		$("#add-file-project tr:eq("+i+")").show();
       			var fileOwner = fileRows[i].fileOwner;
       			if(fileOwner == "0"){
       				$("#add-file-project tr:eq("+i+")").hide();
       			}
       		}
       	}
       	
       });

}

</script>

</body>
</html>