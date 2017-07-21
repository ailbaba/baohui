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
		    <button id="save" class="button-wrap save-isShow">保存</button>
			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
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
						<li><a href="#edit-line-connType">联系方式</a></li>
						<li class="edit-line-plan"><a href="#edit-line-plan">招标计划</a></li>
						<li class="edit-line-bail"><a href="#edit-line-bail"><i18n:I18n key="test" defaultValue="保证金" /></a></li>
						<li class="edit-line-content"><a href="#edit-line-content">招标内容</a></li>
						<li class="edit-line-invited"><a href="#edit-line-invited">投标方</a></li>
	         			<li class="add-file-sheet"><a href="#edit-line-file"><i18n:I18n key="test" defaultValue="查阅表单" /></a></li>
        				<li class="add-form-sheet"><a href="#back-sign-form"><i18n:I18n key="test" defaultValue="回签表单" /></a></li>
					</ul>
					
					<!-- 基本信息 -->
					<div id="edit-line-baseInfo">
					 <table>
				    	<tbody>
				    	    <tr>
				    			<td colspan="1" align="right"><span style="color: red;" class="required">*</span><i18n:I18n key="test" defaultValue="招标名称:" /></td>
				    			<td colspan="1" align="left">
									<input id="biddingName" name="biddingName" type="text" style="width: 200px;" />
								</td>
								<td colspan="1" align="right" width="120px"><i18n:I18n key="test" defaultValue="招标编码:" /></td>
				    			<td colspan="1" align="left">
									<input id="biddingNumber" name="biddingNumber" type="text" style="width: 200px;" readonly="readonly" value=""/>
								</td>
				    		</tr>
				    		<tr>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="目标价发给投标方" />:</td>
				    			<td colspan="1" align="left">
				    				<i18n:I18n key="test" defaultValue="是" />:
									<input type="radio" name="fbk6" value="0" checked="checked" />  &nbsp;&nbsp;
									<i18n:I18n key="test" defaultValue="否" />:
								    <input type="radio" name="fbk6" value="1" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="项目编号"/>:</td>
				    			<td colspan="1" align="left">
									<input id="biddingProjectNumber" name="biddingProjectNumber" type="text" readonly="readonly" style="width: 200px;" value=""/>
								</td>
								<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="定标结果发送投标方"/>:</td>
				    			<td colspan="1" align="left">
									<select id="sendResultInfo" name="sendResultInfo" value="">
										<option value="1">全部发送</option>
										<option value="2">不发送</option>
										<option value="3">只发送中标方</option>
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
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="概况与范围" />:</td>
				    			<td colspan="3" align="left">
									<textarea style="width: 400px; height: 80px" id="header_summary"  name="summary"></textarea>
								</td>
				    		</tr>
				    	</tbody>
				      </table>
					</div>
					
					<!-- 联系方式 -->
					<div id="edit-line-connType">
					    <div class="box-wrap pos-relative bg-common">
			                 <span class="dis-in-b pos-absolute box-tip bg-common">招标机构</span>
			                 <div class="common-box-line">
			                      <div class="input-and-tip">
							         <span style="color: red;" class="required">*</span><span>招标单位:</span> 
							         <input id="orgName" name="biddingLinkmanVOs[][orgName]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span style="color: red;" class="required">*</span><span>负  责  人:</span>&nbsp;
							          <input id="principal" name="biddingLinkmanVOs[][principal]" type="text" style="width: 500px;"/>
						          </div>
						          <div class="input-and-tip">
							          <span style="color: red;" class="required">*</span><span>联系电话:</span> 
							          <input id="telephone" name="biddingLinkmanVOs[][telephone]" type="text" style="width: 500px;"/>
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
							          <span style="color: red;" class="required">*</span><span>联系地址:</span> 
							          <input id="bidding-address" name="biddingLinkmanVOs[][address]" type="text" style="width: 500px;"/>
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
					          <div class="">
							          <span style="color: red;">*</span><span>招标轮数:</span> 
							          <input id="totalRound" name="biddingRoundsVO[totalRound]" class="keyup-plan-double-digit init-roundTable" type="text" onkeyup="value=value.replace(/[^(\d)]/g,'')" />
							          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							           <span style="color: red;">*</span><span>每轮持续:</span> 
							          <input id="duration" name="biddingRoundsVO[duration]" class="keyup-plan-three-digit init-roundTable" type="text" onkeyup="value=value.replace(/[^(\d)]/g,'')" /><span class="date-unit"></span>
							          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							          <span style="color: red;">*</span><span>每轮间隔:</span> 
							          <input id="intervalType" name="biddingRoundsVO[intervalType]" class="keyup-plan-three-digit-0 init-roundTable" type="text" onkeyup="value=value.replace(/[^(\d)]/g,'')" /><span class="date-unit"></span>
						       </div>
					           <div class="">
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
								        <input type="radio" id="plan_secret" name="biddingRoundsVO[secret]" value="1" checked="checked"/>
					                    <i18n:I18n key="test" defaultValue="开标前可查看" />
					                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                    <button id="updateBiddingPlanTable" class="button-wrap" ><span>重新加载数据表格</span></button>
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
								             <input readonly="readonly" id="margin_amount" name="biddingMarginVO[amount]" type="text" style="width: 300px;" value="" onkeyup="value=value.replace(/[^(\d.)]/g,'')"/>
								             <select disabled="true" id="margin_currencyType" name="biddingMarginVO[currency]"  >
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
								             <input disabled="true" type="text" class="Wdate" id="margin_payBeginDate" name="biddingMarginVO[payBeginDate]" value="" 
								             onfocus="WdatePicker({minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'margin_payEndDate\')}'})" />
				  				             <span><i18n:I18n key="test" defaultValue="到" /></span>
	                    		             <input disabled="true" type="text" class="Wdate" id="margin_payEndDate" name="biddingMarginVO[payEndDate]" value="" 
	                    		             onfocus="WdatePicker({minDate:'#F{$dp.$D(\'margin_payBeginDate\')}'})"/>
							             </td>
			    		             </tr>
			    		             <tr>
			    			             <td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金细节规则:" /></td>
			    			             <td colspan="3" align="left">
								             <textarea readonly="readonly" style="width: 500px; height: 80px" id="margin_remark" name="biddingMarginVO[remark]"></textarea>
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
							<div class="bg-common contacts-box">
								<div class="box-wrap pos-relative bg-common">
									<!-- <span class="dis-in-b pos-absolute" style="left: 16px;">可添加供应商列表：</span> -->
									<input class="dis-in-b pos-absolute contact-search" type="text"
										style="left: 16px; width: 220px; max-width: 220px; padding-right: 20px;"
										placeholder="输入查找关键字" /> <img class="dis-in-b pos-absolute"
										src="../../img/icon_search.png"
										style="width: 14px; left: 244px; top: 14px;" /> <span
										class="dis-in-b pos-absolute" style="left: 345px;"><span style="color: red;">*</span><i18n:I18n
											key="i18n_common_title_alreadyaddcontact1"
											defaultValue="已添加的供应商列表" />：</span>
									<div class="fl-left box-left mt-27"></div>
									<div class="fl-left box-middle mt-27">
										<p class="all-pre text-center">
											<button class="contact-option-btn button-wrap" title="全部右移">>></button>
										</p>
										<p class="all-back text-center">
											<button class="contact-option-btn button-wrap" title="全部左移"><<</button>
										</p>
									</div>
									<div class="fl-left box-right mt-27"></div>
									<div class="clear-both"></div>
								</div>
							</div>
							
					       	<div id="supplier_list_container" class="box-wrap pos-relative bg-common">
					            <button id="supplierStatusUpdate" class="button-wrap" >状态保存</button>
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
					    			<td colspan="1" align="right">招标内容&nbsp;&nbsp;<br/>总体描述：</td>
					    			<td colspan="1" align="left">
										<textarea style="width: 500px; height: 80px" id="contentSummary" name="biddingContent[summary]"></textarea>
									</td>
					    		</tr>
					    		<tr>
					    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="所属项目" />：</td>
					    			<td colspan="1" align="left">
										<input id="contentBiddingProjectNumber" name="biddingContent[biddingProjectNumber]" type="text" readonly="readonly" style="width: 200px;" />
										<input id="contentBiddingProjectName" name="biddingContent[biddingProjectName]" type="text" value="" readonly="readonly" style="width: 300px;" />
									</td>
					    		</tr>
					    		<tr>
				    				<td colspan="1" align="right"><span style="color: red;">*</span><i18n:I18n key="test" defaultValue="生效日期" />：</td>
					    			<td colspan="1" align="left">
										<input type="text" class="Wdate" id="contentDeliveryStartDate" name="biddingContent[deliveryStartDate]" value="" 
										onfocus="WdatePicker({minDate:'%y-%M-%d'})"  />
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
								<span class="dis-in-b pos-absolute box-tip bg-common"><span style="color: red;">*</span><i18n:I18n key="" defaultValue="招标详细内容" /></span>
								<div class="common-box-line">
									<button id="biddingDetailContentAdd" class="button-wrap">添加</button>
									<button id="biddingDetailContentRemove" class="button-wrap">删除</button>
									<button id="importByMaterial" class="button-wrap">导入</button>
									<button id="downMaterialModual" class="button-wrap">导出模板</button>
									<button id="btnFromMaterial" class="button-wrap"><i18n:I18n key="" defaultValue="选择物料" /></button>
									<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
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
				</div>
			</div>
		</div>
		</form>
		
	<div class="fixed-dialog" id="addFileDialog">
		<div class="dialog-tip bg-common" style="width: 353px;height: 200px;margin-left: -251px;margin-top: -190px;">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件名称" />：</span>
							<select id="fileClass" name="fileClass">
								<option value="1">招标文件</option>
								<option value="2">报名文件</option>
								<option value="3">投标文件</option>
								<option value="4">澄清答疑文件</option>
								<option value="5">评标文件</option>
								<option value="6">保证金文件</option>
							</select>
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span>
							<input id="fileName" name="fileName" type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload btnFileUpload">
							<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" />
							</div></span>
							<input id="filePath" name="filePath" type="hidden" />
							<input id="fileSize" name="fileSize" type="hidden" />
							<input id="fileType" name="fileType" type="hidden" />
							<input id="fileQ" name="fileQ" type="hidden" />
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="fixed-dialog" id="addFileDialog1">
		<div class="dialog-tip bg-common btnFormUpload" style="width: 353px;height: 200px;margin-left: -251px;margin-top: -190px;">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle1"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件名称" />：</span>
							<select id="fileClass1" name="fileClass1">
								<option value="1">招标文件</option>
								<option value="2">报名文件</option>
								<option value="3">投标文件</option>
								<option value="4">澄清答疑文件</option>
								<option value="5">评标文件</option>
								<option value="6">保证金文件</option>
							</select>
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span>
							<input id="fileName1" name="fileName1" type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFormUpload" class="btn btnUpload">
							<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" />
							</div></span>
							<input id="filePath1" name="filePath1" type="hidden" />
							<input id="fileSize1" name="fileSize1" type="hidden" />
							<input id="fileType1" name="fileType1" type="hidden" />
							<input id="fileQ1" name="fileQ1" type="hidden" />
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFormOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFormCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="fixed-dialog" id="selectBiddingProjectNumberDialog" >
	<div class="dialog-tip bg-common" style="width: 1200px;height:auto;margin-left: -600px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectBiddingProjectNumberDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div>
	    	 <div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectNumber" defaultValue="项目编号" />:</span>
					<input type="text" id="projectNumber" name="projectNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectDesc" defaultValue="项目描述" />:</span>
					<input type="text" id="projectDesc" name="projectDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectLeader" defaultValue="项目负责人" />:</span>
					<input type="text" id="projectLeader" name="projectLeader" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectStatus" defaultValue="项目状态" />:</span>
					<select id="projectStatus" name="projectStatus">
						<option value="">请选择</option>
						<option value="0">新建</option>
						<option value="1">进行中</option>
						<option value="2">完成</option>
						<option value="3">关闭</option>
					</select>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectCreateDate" defaultValue="项目创建日期" />:</span>
	                <input type="radio" name="dateArea" value="lastMonth" checked="checked"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
	                <input type="radio" name="dateArea" value="lastThreeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
	                <input type="radio" name="dateArea" value="defineDateArea"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
				</div>
                <div class="dis-in-b input-and-tip" style="display:none;">
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="startCreateDate" name="startCreateDate"/>
                </div>
                <div class="dis-in-b input-and-tip" style="display:none;">
	                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="endCreateDate" name="endCreateDate" />
                </div>
                <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			</div>
		</div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="headTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectBiddingProjectNumberOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectBiddingProjectNumberCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<div id="dialog2" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_selectStrategy" defaultValue="请选择审批策略" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_audit_lable_stretegy" defaultValue="审批策略" />：</span> 
							<select id="stretegySelctor">
							</select>
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 选择物料弹出框 -->
<div class="fixed-dialog" id="selectMaterialDialog" >
	<div class="dialog-tip bg-common" style="width: 630px;height: 403px;margin-left: -205px;margin-top: -270px;">
	  <div class="dialog-close-btn" id="btnSelectMaterialDialogClose"></div>
       <form id="selectMaterialForm" onsubmit="return false;">
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" ><i18n:I18n key="" defaultValue="请选物料信息" /></span>
		    <input type="hidden" id="pageSize" name="pageSize" value="20">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
		    <input type="hidden" id="fbk1" name="fbk1" value="WL">	
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="查询条件" /></span>
	            <div class="common-box-line">
	               <div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料编码/名称" />：</span>
						<input id="materialNumber" name="materialNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料组" />：</span>
						<input id="materialGroup" name="materialGroup" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<button id="queryMaterial" class="button-wrap "><i18n:I18n key="" defaultValue="查询" /></button>
					</div>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="query-material-table"></table>
                        <div id="query-material-page" style="text-align: right;"></div>
                    </div>
                    <div class="mt-20 text-center" >
	                    <button id="btnQueryMaterialOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnQueryMaterialCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
	   </form>
    </div>
</div>
	
<script type="text/javascript">
var phasesTable;//标段mmgrid 表实体
var phasesRoundTable;//各阶段轮次 mmgrid 表实体
var biddingNumber ="<%=request.getParameter("biddingNumber") %>";
var materialAttrList = [];
var biddingDetailContentGrid;
var queryMaterialTable;
var totalRoundArr=[];
var biddingItemArray;
var saveFlag = 0;
$().ready(function(){
	$("#controlBidding").hide();
	$('#add-enq-sheet').tabs();
	$("#elsAccount").val(elsAccount);
	$("#elsSubAccount").val(elsSubAccount);
	$("#selectBiddingProjectNumberDialog").hide();
	$('input[name="biddingMarginVO[back]"]').eq(0).parent().hide();
	$('input[name="biddingMarginVO[back]"]').eq(0).parent().prev().hide();
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
		$("#contentDeliveryStartDate").val(currDate);
		$("#contentDeliveryEndDate").val(currDate);
		return;
	}
	$("#importByMaterial").hide();
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
			if(data.fbk6=='0'){
				$('input[name="fbk6"]:eq(0)').attr('checked',true);
			}else{
				$('input[name="fbk6"]:eq(1)').attr('checked',true);
			}
			$("#fbk1_sendResult").val(data.fbk1);
			$("#biddingNumber").val(data.biddingNumber);
			$("#biddingProjectNumber").val(data.biddingProjectNumber);
			$("#budgetAmount").val(data.budgetAmount);
			$("#currency").val(data.currency);
			$("#fundSource").val(data.fundSource);
			$("#biddingStatus").val(data.biddingStatus);
			$("#preAuditStatus").val(data.preAuditStatus);
			$("#auditStatus").val(data.auditStatus);
			$("#header_summary").val(data.summary);
			$("#sendResultInfo").val(data.fbk1);
			if(data.publish == "1"){ //是否发布到企业控件
				$("#isPublishInfo").attr("checked","checked");
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
			var cols = phasesRoundCols;
			$(".date-unit").html("天");
			var biddingRoundItms = data.biddingRoundItms;
			if(biddingRoundItms &&  biddingRoundItms.length>0){
				var roundItem;
				var roundItems = [];
				roundItem = biddingRoundItms[0];
				roundItems = biddingRoundItms;
				fileTempData = {itemNumber:0,totalRound:roundItem.roundsNumber};
				totalRoundArr.push(fileTempData);
				
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
			}
			
			//加载招标方式----end-------
			
			//加载保证金----begin-------
			var biddingMarginVOs = data.biddingMarginVOs;
			if(biddingMarginVOs &&  biddingMarginVOs.length>0){
				var multiSection = biddingMarginVOs[0].multiSection;//获取保证金列表中任意一条数据，查看保证金是否区分标段
				var margin = biddingMarginVOs[0];
				$("input[name='biddingMarginVO[collect]']").eq(margin.collect).attr("checked",'checked');
				$("input[name='biddingMarginVO[back]']").eq(margin.back).attr("checked",'checked');
				$("#margin_amount").val(margin.amount);
				$("#margin_currencyType").val(margin.currency);
				$("#margin_remark").val(margin.remark);
				// 去除不可更改 
				if(margin.collect=="1"){
					$("#margin_amount").attr("readonly",false);
					$("#margin_payBeginDate").attr("disabled",false);
					$("#margin_payEndDate").attr("disabled",false);
					$("#margin_remark").attr("readonly",false);
					$('input[name="biddingMarginVO[back]"]').eq(0).parent().show();
					$('input[name="biddingMarginVO[back]"]').eq(0).parent().prev().show();
				}
				if(margin.payBeginDate != null && margin.payBeginDate != ""){
					$("#margin_payBeginDate").val(new Date(margin.payBeginDate).format('yyyy-MM-dd'));					
				}
				if(margin.payEndDate != null && margin.payEndDate != ""){
					$("#margin_payEndDate").val(new Date(margin.payEndDate).format('yyyy-MM-dd'));					
				}
				$("body").data("init_margin_flag",true);//设置成已经初始化
			}
			//加载保证金----end-------
			
			//加载招标内容----begin-------
			var biddingContentVOs = data.biddingContentVOs;
			var biddingContentItemVOs = data.biddingContentItemVOs;
			var biddingContentStandardVOs = data.biddingContentStandardVOs;
			var setBiddingContent;

			if(biddingContentVOs &&  biddingContentVOs.length>0){
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
				 $("#contentSummary").val(setBiddingContent.summary);
			 	 $("#contentBiddingProjectNumber").val(setBiddingContent.biddingProjectNumber);
				 $("#contentBiddingProjectName").val(setBiddingContent.biddingProjectName);
				 if(setBiddingContent.deliveryStartDate != null && setBiddingContent.deliveryStartDate != ""){
					 $("#contentDeliveryStartDate").val(new Date(setBiddingContent.deliveryStartDate).format('yyyy-MM-dd'));					 
				 }
				 if(setBiddingContent.deliveryEndDate != null && setBiddingContent.deliveryEndDate != ""){
					 $("#contentDeliveryEndDate").val(new Date(setBiddingContent.deliveryEndDate).format('yyyy-MM-dd'));					 
				 }
				 $("#contentAddress").val(setBiddingContent.address);
				 $("#contentQuality").val(setBiddingContent.quality);
				 if(biddingContentItemVOs != null && biddingContentItemVOs.length > 0){
					 biddingDetailContentGrid=$('#biddingDetailContentTable').mmGrid({
					    cols: biddingDetailContentItem,
					    items:contentItemArray,
					    height: 350,
					    checkCol:true,
				        multiSelect:true,
				        //hasJsonOption : "extendFields",
					    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
					});
					biddingDetailContentGrid.on("cellSelected",function(e, item, rowIndex, colIndex){
						var colsObj = biddingDetailContentGrid.opts.cols;
						var thisColName = colsObj[colIndex].name;
						if("requirementTypeCode"==thisColName){
							electRequirementTypeCode(rowIndex);//弹出选择需求类型页面进行选择
						} else if("materialNumber"==thisColName){
							selectMaterialNumber(rowIndex);//弹出物料选择页面进行选择
						} else {
							//do nothing
						}
					});
				}
				if(biddingContentItemVOs != null && biddingContentItemVOs.length > 0){
					 biddingStandardGrid=$('#biddingStandardTable').mmGrid({
					    cols: biddingStandardItem,
					    items:contentStandardArray,
					    height: 250,
					    checkCol:true,
				        multiSelect:true,
					    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
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
			
			//加载供应商信息
			if(data.biddingSupplierVOs && data.biddingSupplierVOs.length>0){
				setBiddingSupplierVOs(data.biddingSupplierVOs);
			    if(!biddingSupplierListTable){
			        biddingSupplierListTable = $('#supplier_list_table').mmGrid({
			    	    cols: supplierListTableCols,
			    	    items:getSupplierFromCash($("#supplier_section_list").val()),
			    	    height: 240,
			    	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
			    	});
			    }else{
			    	var vos=getSupplierFromCash("0");
			    	biddingSupplierListTable.load(vos);
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
			}
			
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
			parent.elsDeskTop.hideLoading();
            alert("加载招投标信息失败:"+exception,3); 
        }
	});
}



$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('addBiddingOneTemplate',callBack);//退出当前页面并执行父页面的查询方法
});

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_biddingPurchaseTemplateSel']) {
		parent.frames['iframeApp_biddingPurchaseTemplateSel'].purchQuery();
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
	{ title:"审批状态", name:"auditStatus" , width:100, align:"center"},
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
//列自定义
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount 
	    		+ "&tableCode=biddingPurchaseContentItem_mt" + "&window=iframeApp_biddingPurchaseContentItem_mt",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	 });
});
//*********************************修改部分结束******************************//

</script>
</body>
</html>