<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<%
String biddingNumber =request.getParameter("biddingNumber");
String biddingName =request.getParameter("biddingName");
String toElsAccount = request.getParameter("toElsAccount");
String biddingStatus = request.getParameter("biddingStatus");
String operation = request.getParameter("operation");
String biddingItemNumber = request.getParameter("biddingItemNumber");
String roundsNumber = request.getParameter("roundsNumber");
String biddingType = request.getParameter("biddingType");
String tagertPriceSendOrNot = request.getParameter("tagertPriceSendOrNot");
%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>

<style>
table tbody tr td {
	padding-top: 1px;
	padding-bottom: 1px;
}
</style>

<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common" id="mySpan"><i18n:I18n
					key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line" id="myButton">
				<button id="sendToSupplier" class="button-wrap"><i18n:I18n key="test" defaultValue="发送至招标方" /></button>
				<button id="markBidding" class="button-wrap"><i18n:I18n key="test" defaultValue="应标" /></button>
				<button id="markBiddingNo" class="button-wrap"><i18n:I18n key="test" defaultValue="不应标" /></button>
			</div>
		</div>
		<form id="form" onsubmit="return false;">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common">招投标管理</span>
				<div class="common-box-line">
					<div class="tab-wrap" id="sheet-project">
						<ul>
							<li><a href="#edit-line-baseInfo">基本信息</a></li>
							<li class="add-file-sheet"><a href="#edit-line-connType"><i18n:I18n key="test" defaultValue="联系方式" /></a></li>
							<li class="add-file-sheet"><a href="#edit-line-bail"><i18n:I18n key="test" defaultValue="保证金" /></a></li>
				    		<li class="sheet-project-one2"><a href="#sheet-project-one"><i18n:I18n key="i18n_purchase_bargain_supplierQuotedPrice" defaultValue="招标内容" /></a></li>
				    		<li class="sheet-project-one1"><a href="#sheet-project-one1">招标内容</a></li>
				    		<li class="sheet-project-online2"><a href="#sheet-project-online"><i18n:I18n key="test" defaultValue="在线竞价" /></a></li>
							<li><a class="scan-file-sheet" href="#sheet-project-two">查阅文件</a></li>
							<li class="scan-form-sheet2"><a class="scan-form-sheet" href="#sheet-project-three">回签文件</a></li>
							<li class="sheet-supplier-info2"><a href="#sheet-supplier-info">供应商信息</a></li>
						</ul>
						<!-- 基本信息 -->
						<div id="edit-line-baseInfo">
							<div class="box-wrap pos-relative bg-common">
								<table>
									<tbody>
										<tr>
											<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标类型:" /></td>
											<td colspan="1" align="left">
												<select id="biddingType" name="biddingType" style="width: 164px; max-width: 164px;" disabled="disabled">
													<option value="">ALL_类型</option>
													<option value="0">邀请招标</option>
													<option value="1">公开招标</option>
													<option value="2">在线竞标-邀请</option>
												</select>
												<span style="color: red;">*</span>
											</td>
										</tr>
										<tr>
											<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标编码:" /></td>
											<td colspan="1" align="left">
												<input id="biddingNumber" name="biddingNumber" type="text" style="width: 200px;background-color: white;" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标名称:" /></td>
											<td colspan="1" align="left">
												<input name="biddingName" type="text" style="width: 200px;background-color: white;" readonly="readonly"/>
												<span style="color: red;">*</span>
											</td>
										</tr>
										<tr>
											<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="招标说明:" /></td>
											<td colspan="1" align="left">
												<textarea id="remarkArea" style="width: 500px; height: 80px;background-color: white;" readonly="readonly"></textarea>
											</td>
										</tr>
									</tbody>
								</table>
								<main class="grid-container">
									<div class="grid-100">
										<table id="baseTable"></table>
									</div>
						  		</main>
								<!-- <main class="grid-container">
									<div class="grid-100">
										<table id="baseTable"></table>
									</div>
								</main> -->
							</div>
						</div>

						<!-- 联系方式 -->
						<div id="edit-line-connType">
							<div class="input-and-tip">
								<span>招标单位:</span> 
								<input id="biddingCompany" name="biddingCompany" type="text" style="width: 500px;background-color: white;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>负 责 人:</span>&nbsp; 
								<input id="principal" name="principal" type="text" style="width: 500px;background-color: white;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>联系电话:</span> 
								<input id="telephone" name="telephone" type="text" style="width: 500px;background-color: white;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>电子邮箱:</span> 
								<input id="email" name="email" type="text" style="width: 500px;background-color: white;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>电子传真:</span> 
								<input id="fax" name="fax" type="text" style="width: 500px;background-color: white;" readonly="readonly"/>
							</div>
							<div class="input-and-tip">
								<span>联系地址:</span> 
								<input id="address" name="address" type="text" style="width: 500px;background-color: white;" readonly="readonly"/>
							</div>
						</div>
						<!-- 保证金-->
						<div id="edit-line-bail">
							<table>
								<tbody>
									<tr>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="收取保证金:" /></td>
										<td colspan="1" align="left">
											<input disabled="disabled" name="radio1" type="radio" />是 
											<input disabled="disabled" name="radio1" type="radio" />否
										</td>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="退还保证金:" /></td>
										<td colspan="1" align="left">
											<input id="back" disabled="disabled" name="radio2" type="radio" checked="true" />是 
											<input id="back" disabled="disabled" name="radio2" type="radio" />否
										</td>
									</tr>
									<tr>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金金额:" /></td>
										<td colspan="3" align="left">
											<input id="amount" readonly="readonly" name="" type="text" style="width: 300px;background-color: white;" value="10000"/> 
											<select id="currency" name="currency" disabled="disabled">
												<option>CNY</option>
												<option>HK</option>
												<option>USD</option>
												<option>GBP</option>
											</select>
										</td>
									</tr>
									<tr>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="缴纳日期(从):" /></td>
										<td colspan="3" align="left">
											<input type="text" class="Wdate" 
											id="payBeginDate" name="payBeginDate" value="" readonly="readonly" style="background-color: white;"/> 
											<span><i18n:I18n key="test" defaultValue="到" /></span> 
											<input type="text" class="Wdate" 
											id="payEndDate" name="payEndDate" value="" readonly="readonly" style="background-color: white;"/>
										</td>
									</tr>
									<tr>
										<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="保证金细节规则:" /></td>
										<td colspan="3" align="left">
											<textarea id="remark" name="remark" readonly="readonly" style="width: 500px; height: 80px;background-color: white;" ></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- 供应商报价内容 -->
						<div id="sheet-project-one">
							<div class="box-wrap pos-relative bg-common">
								<table>
									<tbody>
										<tr>
											<td colspan="1" align="right"></td>
											<td colspan="1" align="left">
												<select id="roundsSelect"></select>
											</td>
										</tr>
										<tr>
											<td colspan="1" align="right">招标内容<br />总体描述:</td>
											<td colspan="1" align="left">
												<textarea id="descriptionArea" readonly="readonly" style="width: 800px; height: 80px; background-color: white;" ></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="所属项目:" /></td>
											<td colspan="1" align="left">
												<input id="projectNumber" name="projectNumber" type="text" readonly="readonly" style="width: 200px;background-color: white;" /> 
												<input id="projectRemark" name="projectRemark" type="text" readonly="readonly" style="width: 300px;background-color: white;" />
											</td>
										</tr>
										<tr>
						    				<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="交货日期(从)" />：</td>
							    			<td colspan="1" align="left">
												<input type="text" class="Wdate" disabled="disabled" name="deliveryStartDate" value="" 
												id="deliveryStartDate" onfocus="WdatePicker()" style="background-color: white;" />
								  				<span><i18n:I18n key="test" defaultValue="到" /></span>
					                    		<input type="text" class="Wdate" disabled="disabled" name="deliveryEndDate" value="" 
					                    	    id="deliveryEndDate" onfocus="WdatePicker()" style="background-color: white;" />
											</td>
					    				</tr>
							    		<tr>
							    			<td colspan="1" align="right">交货地点：</td>
							    			<td colspan="1" align="left">
												<input type="text" id="contentAddress" name="address" readonly="readonly" style="background-color: white;">
											</td>
							    		</tr>
							    		<tr>
							    			<td colspan="1" align="right">质量要求：</td>
							    			<td colspan="1" align="left">
												<textarea style="width: 500px; height: 80px; background-color: white;" id="quality" name="quality" disabled="disabled"></textarea>
											</td>
							    		</tr>
									</tbody>
								</table>
								<main class="grid-container nest-table">
									 <div class="common-box-line">
										<button id="importS" class="button-wrap">导入报价</button>
										<button id="downMaterialModual" class="button-wrap">导出报价模板</button>  
										<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
									</div>
									<div class="grid-100" id="reCreate">
										<table id="table-item"></table>
										<div id="pg-price" style="text-align: right;"></div>
									</div>
								</main>
							</div>
						</div>
						
						<!-- 在线报价物料信息 -->
						<div id="sheet-project-one1">
							<div class="box-wrap pos-relative bg-common">
								<main class="grid-container nest-table">
									<div class="grid-100" id="reCreate">
										<table id="table-item1"></table>
										<div id="pg-price1" style="text-align: right;"></div>
									</div>
								</main>
							</div>
						</div>
						
						<!-- ----------------------------------------在线竞价 @author jiangzhidong @date 20160324  begin------------------------ -->
						<div id="sheet-project-online">
							<table>
								<tbody>
									<tr>
										<td align="center" colspan="1" rowspan="2" align="right" style="width: 350px; border: solid 1px #ccc;">
										<!-- 竞价情况 --><img src="../purchase/1.jpg" style="height: 150px; width: 250px;"><br /> 
										<strong>竞价情况</strong><br />-------------------------------------------------------<br /><br />
											<table>
											<tbody>
												<tr>
													<td align="right">合同包:</td>
													<td><input id="biddingName2" name="biddingName" type="text" class="init-biddingNumber" style="width: 300px;" readonly = "readonly"/></td>
												</tr>
												<tr>
													<td align="right">竞价类型:</td>
													<td>
														<select id="biddingType2" name="biddingType" class = "init-biddingType" style="width: 164px; max-width: 164px;" disabled="disabled">
															<option value="0">邀请招标</option>
															<option value="1">公开招标</option>
															<option value="2">在线竞标-邀请</option>
															<option value="3">在线竞标</option>
									            		</select>
													</td>
												</tr>
												<tr>
													<td align="right">采购限价:</td>
													<td><input id="limitPrices" name="limitPrices" type="text" class="init-limitPrices" style="width: 300px;" readonly = "readonly"/></td>
												</tr>
												<tr>
													<td align="right">最小竞价幅度:</td>
													<td><input id="currentFbk2" name="currentFbk2" type="text" style="width: 300px;" readonly = "readonly"/></td>
												</tr>
												<tr>
													<td align="right">当前最低报价:</td>
													<td><input id="currentMinPrice" name="currentMinPrice" type="text" style="width: 300px;" readonly = "readonly"/></td>
												</tr>
												<tr>
													<td></td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td align="right">竞价开始时间:</td>
													<td><input id="biddingBeginDate" name="biddingBeginDate" type="text" style="width: 300px;" readonly = "readonly"/></td>
												</tr>
												<tr>
													<td align="right">竞价结束时间:</td>
													<td><input id="biddingEndDate" name="biddingEndDate" type="text" style="width: 300px;" readonly = "readonly"/></td>
												</tr>
												<tr>
													<td align="right">当前处于几轮次:</td>
													<td><input id="currentRound" type="text" style="width: 300px;" readonly = "readonly"/></td>
												</tr>
												<tr>
													<td align="right">本轮次报价排名:</td>
													<td><input type="currentRank" style="width: 300px;" value=""/></td>
												</tr>
											</tbody>
										</table>
									</td>
									<td align="center" colspan="1" rowspan="1" align="right" style="width: 600px; border: solid 1px #ccc;">
										<!-- 当前最低报价 -->				
		           						<table style="width: 450px;">
							    			<tbody>
							    				<tr>
							    					<td colspan="1" align="right"><h5>当前最低报价：</h5></td>
							    					<td colspan="1" align="left"><h5 style="color: red;"  class="currentMinPrice"></h5></td>
							    					<td colspan="1" align="left"><h5>&nbsp;&nbsp;竞价倒计时：</h5></td>
							    					<td colspan="1" align="left"><h5 style="color: red;"  id="timer"></h5></td>
							    				</tr>
							    			</tbody>
							    		</table>
										---------------------------------------------------------------------------------<br />
										竞选轮次：本次竞选一共<span id=totalRound></span>
										轮  每轮持续时间：<span id="fbk3"></span>
										分钟  每轮间隔时间：<span id="fbk2"></span>分钟
									</td>
								</tr>
									<tr>
										<td align="center" colspan="1" rowspan="2" align="right" style="width: 600px; border: solid 1px #ccc;">
											<!-- 竞价 -->
											<table style="width: 600px;">
												<!-- <tbody>
													<tr>
														<td colspan="1" align="right">采购品目:</td>
														<td colspan="1" align="left"><input id="purchaseItem" type="text" style="width: 120px;"  readonly = "readonly"/></td>
														<td colspan="1" align="right">商品品牌:</td>
														<td colspan="1" align="left"><input id="goodsBrand" type="text" style="width: 120px;"  readonly = "readonly"/></td>
													</tr>
													<tr>
														<td colspan="1" align="right">商品名称:</td>
														<td colspan="1" align="left"><input id="goodsName" type="text" style="width: 120px;"  readonly = "readonly"/></td>
														<td colspan="1" align="right">规格型号:</td>
														<td colspan="1" align="left"><input id="goodsSize" type="text" style="width: 120px;" readonly = "readonly" /></td>
													</tr>
													<tr>
														<td colspan="1" align="right">最高限价:</td>
														<td colspan="1" align="left"><input id="MaxPriceLimit" type="text" style="width: 120px;" readonly = "readonly"/></td>
														<td colspan="1" align="right">数量:</td>
														<td colspan="1" align="left"><input id="goodsNumber" type="text" style="width: 120px;" readonly = "readonly"/></td>
													</tr>
													<tr>
														<td colspan="1" align="right">交货期:</td>
														<td colspan="1" align="left"><input id="deliveryPeriod" type="text" style="width: 120px;" readonly = "readonly"/></td>
														<td colspan="1" align="right">计量单位:</td>
														<td colspan="1" align="left"><input id="goodsUnit" type="text" style="width: 120px;" readonly = "readonly"/></td>
													</tr>
													<tr>
														<td colspan="1" align="right">当前轮次总价格:</td>
														<td colspan="3" align="left"><input id="localRoundsTotalPrice" type="text" style="width: 120px;" readonly = "readonly"/></td>
													</tr>
												</tbody>
											</table>  -->
											<!-- 本次报价 -->
											<h6>本次报价</h6>
											<table style="border: solid 1px #ccc;">
												<tbody>
													<tr style="border: solid 1px #ccc; width: 450px;" align="center">
														<td align="center" colspan="1" rowspan="2" align="right" style="width: 80px; border: solid 1px #ccc;">价格:</td>
														<td align="center" colspan="1" rowspan="1" align="right" style="width: 80px; border: solid 1px #ccc;">单价</td>
														<td align="center" colspan="1" rowspan="1" align="right" style="width: 80px; border: solid 1px #ccc;">总价</td>
														<td align="center" colspan="1" rowspan="1" align="right" style="width: 80px; border: solid 1px #ccc;">币种</td>
														<td align="center" colspan="1" rowspan="1" align="right" style="width: 80px; border: solid 1px #ccc;">备注</td>
														<td align="center" colspan="1" rowspan="2" align="right" style="width: 80px; border: solid 1px #ccc;">															
															<button id="onlinebidding" class="button-wrap">报价</button>
														</td>
													</tr>
													<tr style="border: solid 1px #ccc; width: 450px;">
														<td align="center" colspan="1" rowspan="1" align="right" style="width: 80px; border: solid 1px #ccc;">
															<input type = "text"  style="width: 100px;"id = "localPrice"  class="button-wrap"></input>
														</td>
														<td align="center" colspan="1" rowspan="1" align="right" style="width: 80px; border: solid 1px #ccc;">
															<input  type = "text"   style="width: 100px;"id = "localTotalPrice"  class="button-wrap"></input>
														</td>
														<td align="center" colspan="1" rowspan="1" align="right" style="width: 80px; border: solid 1px #ccc;">
															<input  type = "text"  style="width: 100px;" id = "localCurrency" readonly = "readonly" class="button-wrap" value = "CNY"></input>
														</td>
														<td align="center" colspan="1" rowspan="1" align="right" style="width: 80px; border: solid 1px #ccc;">
															<input  type = "text"  style="width: 100px;" id = "localRemark"  class="button-wrap"></input>
														</td>
													</tr>
												</tbody>
											</table> 
											
											<!-- 历史报价 -->
											
											<h6>历史报价</h6> 
											<main class="grid-container">
												<div class="grid-100">
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
						<!-- 查阅文件 -->
						<div id="sheet-project-two">
							<div class="box-wrap pos-relative bg-common" style="padding: 0;">
								<div class="common-box-line p-zero">
									<div class="pos-relative upload-wrap">
										<div class="pos-absolute file-list">
											<div class="file-list-head">
												<select id="selectPurchaseSale" name="selectPurchaseSale">
													<option value="0"><i18n:I18n
															key="i18n_common_select_filetype_all" defaultValue="所有文件" /></option>
													<option value="1"><i18n:I18n
															key="i18n_common_title_ourfile" defaultValue="我方文件" /></option>
													<option value="2"><i18n:I18n
															key="i18n_common_title_theyfile" defaultValue="对方文件" /></option>
												</select> <select id="selectFileType" name="selectFileType"
													style="width: 165px;">
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
													<button id="fileColumnDefineBtn" class="button-wrap">
														<i18n:I18n key="i18n_common_button_columncustom"
															defaultValue="列自定义" />
													</button>
													<button id="flushFileBtn" class="button-wrap">
														<i18n:I18n key="i18n_common_title_flush" defaultValue="刷新" />
													</button>
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
						<!-- 回签文件 -->
						<div id="sheet-project-three">
							<div class="box-wrap pos-relative bg-common" style="padding: 0;">
								<div class="common-box-line p-zero">
									<div class="pos-relative upload-wrap">
										<div class="pos-absolute file-list">
											<main class="grid-container">
											<div class="grid-100" id="reCreateFile">
												<table id="add-form-project"></table>
												<div id="enquiryFilePage" style="text-align: right;"></div>
											</div>
											</main>
										</div>
										<div class="file-scan">
											<div class="file-option-zoom">
												<div class="dis-in-b text-left">
													<button id="formColumnDefineBtn" class="button-wrap">
														<i18n:I18n key="i18n_common_button_columncustom"
															defaultValue="列自定义" />
													</button>
													<button id="flushFormBtn" class="button-wrap">
														<i18n:I18n key="i18n_common_title_flush" defaultValue="刷新" />
													</button>
													<button id="downloadForm" class="button-wrap">下载</button>
													<button id="uploadForm" class="button-wrap">上传</button>
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
						<div id="sheet-supplier-info">
							<div class="box-wrap pos-relative bg-common">
								<main class="grid-container">
									<div class="grid-100">
										<table id="supplier_info_table"></table>
									</div>
						  		</main>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
		<!--         聊天窗口 -->
		<!--          <div class="saying-dialog"> -->
		<!--             <div class="fl-left left-content pos-relative"> -->
		<!--                 <div class="dis-block pos-absolute option-bar pre-active next"></div> -->
		<!--             </div> -->
		<!--             <div class="fl-left right-content pos-relative none-active"> -->
		<!--                 <div class="saying-box-wrap"> -->
		<!--                    <iframe class="testIframe" id="chatIframe" frameborder="0" width="100%"> -->
		<!--                    </iframe> -->
		<!--                 </div> -->
		<!--             </div> -->
		<!--             <div class="clear-both"></div> -->
		<!--     </div> -->

		<div class="fixed-dialog" id="fixed-dialog">
			<div class="dialog-tip bg-common"style="width: 353px; height: 200px; margin-left: -251px; margin-top: -190px;">
				<div class="dialog-close-btn"></div>
				<div class="tip-head">
					<img class="icon" src="../../icon/els.PNG" /> <span
						id="dialogTitle"><i18n:I18n
							key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
				</div>
				<div>
					<div class="box-wrap pos-relative bg-common">
						<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
								key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
						<div class="common-box-line">
							<div class="input-and-tip">
								<span><i18n:I18n key="i18n_common_label_filename"
										defaultValue="表单文件名称" />：</span> <input id="fileName"
									name="fileName" type="text" />
							</div>
							<div class="input-and-tip">
								<span><div id="btnFileUpload" class="btn btnUpload">
										<i18n:I18n key="i18n_common_button_chooseformfile"
											defaultValue="选择表单文件" />
									</div></span> <input id="filePath" name="filePath" type="hidden" /> <input
									id="fileSize" name="fileSize" type="hidden" />
							</div>
							<input id="fileType" name="fileType" type="hidden" />
						</div>
						<div class="mt-20">
							<button id="btnFileOK" class="button-wrap tip-option-btn">
								<i18n:I18n key="i18n_common_button_ok" defaultValue="确定" />
							</button>
							<button id="btnFileCancel" class="button-wrap tip-option-btn">
								<i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" />
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="fixed-dialog" id="fixed-dialog_one">
			<div class="dialog-tip bg-common"
				style="width: 353px; height: 200px; margin-left: -251px; margin-top: -190px;">
				<div class="dialog-close-btn"></div>
				<div class="tip-head">
					<img class="icon" src="../../icon/els.PNG" /> <span
						id="dialogTitle"><i18n:I18n
							key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
				</div>
				<div>
					<div class="box-wrap pos-relative bg-common">
						<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
								key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
						<div class="common-box-line">
							<div class="input-and-tip">
								<span><i18n:I18n key="i18n_common_label_filename"
										defaultValue="表单文件名称" />：</span> <input id="formName"
									name="formName" type="text" />
							</div>
							<div class="input-and-tip">
								<span><div id="btnFormUpload" class="btn btnUpload">
										<i18n:I18n key="i18n_common_button_chooseformfile"
											defaultValue="选择表单文件" />
									</div></span> <input id="formPath" name="formPath" type="hidden" /> <input
									id="formSize" name="formSize" type="hidden" />
							</div>
							<input id="formType" name="formType" type="hidden" />
						</div>
						<div class="mt-20">
							<button id="btnFormOK" class="button-wrap tip-option-btn">
								<i18n:I18n key="i18n_common_button_ok" defaultValue="确定" />
							</button>
							<button id="btnFormCancel" class="button-wrap tip-option-btn">
								<i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" />
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<script>

	debugger;
var itemGrid               ;
var itemGrid1              ;
var chatIfr                ;
var isloadItemGrid = false ;
var editFileTable          ;
var editFormTable          ;
var fileUploader           ;
var formUploader           ;
var updateFile = false     ;
var updateForm = false     ;
var onlineBth  = true     ;
var fbk1  ;
var currency;
var historyGrid;
var intervalItemHis; //定时刷新报价列及最低报价定时器
var key;
var value;
var item_cols;
var item_cols1;
var itemRows_data = [];
var controlBidding;
//判断投标状态 ,控制发布按钮的操作和报价的可操作
var toElsAccount =  '<%=toElsAccount%>';
var biddingNumber = '<%=biddingNumber%>';
var biddingName = '<%=biddingName%>';
var biddingItemNumber = '<%=biddingItemNumber%>';
var roundsNumber = '<%=roundsNumber%>';
var biddingStatus = '<%=biddingStatus%>';
var operation = '<%=operation%>';
var biddingType = '<%=biddingType%>'
var tagertPriceSendOrNot = '<%=tagertPriceSendOrNot%>'
var currentPurchaseOrderNumber;
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var companyName = '<%=session.getAttribute("companyShortName") %>';
var rowIndexSelect=0;
var $sob;
//聊天窗口
//供应商列表：toElsAccount ,每个供应商对应的负责人：elsSubAccount,询价订单号 ： businessID
function initChat() {	
	  //查询供应商表purchase_enquiry_supplie_list  供应商编码   供应商名称    
	  //查询采购方purchase_enquiry_header  负责人
	  var supplieParam = {
	  	'elsAccount':elsAccount,
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
 	 		   	var toElsSubAccount                  ;

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
$(document).ready(function(){
	debugger;
// 	chatIfr= $('#chatIframe')[0];
<%-- 	chatIfr.src = '<%=basePath%>' + 'multiChat_n.jsp'; --%>
// 	// 动态加载聊天窗口
// 	$sob = $('.saying-dialog .option-bar');
// 	//initChat();
// 	//初始化聊天控制状态
//     if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
//     $sob.click();
	init();
	//timer();
});

//计算时间
var minute=document.getElementById("fbk2").innerHTML;
var maxtime = minute*60; //一个小时，按秒计算，自己调整!
function CountDown(){
if(maxtime>=0){
minutes = Math.floor(maxtime/60);
seconds = Math.floor(maxtime%60);
minutes = minutes>=10?minutes:'0'+minutes;
seconds = seconds>=10?seconds:'0'+seconds;
msg = "距离结束还有"+minutes+"分"+seconds+"秒";
document.all["timer"].innerHTML=msg;
if(maxtime == 5*60) alert('注意，还有5分钟!');
--maxtime; 
}
else{
clearInterval(timer);
}
}
var timer = setInterval("CountDown()",1000);   

function closeCallback() {
	if (parent.frames["iframeApp_biddingSaleManage"]) {
		parent.frames["iframeApp_biddingSaleManage"].purchQuery();
	}else{
		//top.elsDeskTop.closeCurWin('quoteManage');//仅退出当前页面
		$("#sendToSupplier").hide();
	}
}
//列自定义
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount 
	    		+ "&tableCode=biddingSaleContentItem_mt" + "&window=iframeApp_biddingSaleContentItem_mt",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	 });
});
//发送至采购商
$("#sendToSupplier").click(function() {
	var url = "" ;
	var frm = $("#form") ;
	var jsonObj = frm.serializeJSON()||{};
	updatejson();//更新输入框json数据
	if(controlBidding=="0"){//必须全部报价
		var itemRecords = itemGrid.rows();
		for(var i=0;i<itemRecords.length;i++){
			var itemRecord = itemRecords[i];
			if(itemRecord.priceIncludingVat == "0.00000" || !itemRecord.priceIncludingVat){
				alert("采购方要求必须全部报价！",2);
				return;
			}
			if(itemRecord.amount.length > 19){
				alert("总金额位数超过最大位数！",2);
				return;
			}
		}
	}else{//可以部分报价
		var itemRecords = itemGrid.rows();
		var flag = false;
		for(var i=0;i<itemRecords.length;i++){
			var itemRecord = itemRecords[i];
			if(itemRecord.priceIncludingVat != "0.00000" && itemRecord.priceIncludingVat){
				flag = true;
			}
			if(!flag){
				alert("报价不能全为空！",2);
				return;
			}
			if(itemRecord.amount.length > 19){
				alert("总金额位数超过最大位数！",2);
				return;
			}
		}
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading() ;
		//组装json开始---------------
		jsonObj["elsAccount"] = elsAccount ;
		jsonObj["toElsAccount"] = toElsAccount ;
		jsonObj["biddingNumber"] = biddingNumber ;
		jsonObj["biddingItemNumber"] = biddingItemNumber;
		jsonObj["currentRound"] = roundsNumber;
		var biddingContentItemVOs = [] ;
		var biddingContentItemTableRows = itemGrid.rows() ;
		if(biddingContentItemTableRows != "" && biddingContentItemTableRows != null){
			for(var i = 0 ; i < biddingContentItemTableRows.length ; i ++){
				biddingContentItemVOs.push(JSON.stringify(biddingContentItemTableRows[i])) ;
			}
		}
		if(updateForm==true){
			//获取表单文件信息sale_bidding_file
			var biddingFileVOs = [];//用于存放表单文件信息
			//判断是否切换文件显示的界面，如果没有切换，则不需要更新文件信息 
			var selectRows = editFormTable.rows();
			if(selectRows.length > 0){
				for(var j = 0 ; j < selectRows.length ; j ++){
					biddingFileVOs.push(JSON.stringify(selectRows[j]));				
				}
			}
			jsonObj['biddingFileVOs']        = eval('['+biddingFileVOs+']'); 
		}
		jsonObj['biddingContentItemVOs'] = eval('['+biddingContentItemVOs+']');
		
		$.ajax({
					url 		: "<%=basePath%>rest/SaleBiddingService/updateSaleBiddingItems",
					type 		: "post",
					contentType : "application/json",
					data 		: JSON.stringify(jsonObj),
					dataType 	: "json",
					success     : function(data) {
						if(data.statusCode == "-100"){
							parent.elsDeskTop.hideLoading();
							alert(data.message,3);
						}else{
							parent.elsDeskTop.hideLoading();
			    			alert('<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />',1);
							parent.elsDeskTop.closeCurWin('quoteManage',closeCallback());
						}
					},error : function(data) {
						parent.elsDeskTop.hideLoading();
		    			alert('<i18n:I18n key="i18n_common_sendfail" defaultValue="发送失败" />',3);
		    		}
		});

	}});
});

//网上报价
$("#onlinebidding").click(function() {
	if(!onlineBth){
		alert("请求进行进行中，请勿频繁操作！",2);
		return;
	}
	if(/[\u4e00-\u9fa5]/g.test($("#currentRound").val())){
		alert("当前不允许报价",2);
		return;
	}
	var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	//当前价格
	var localPrice      = $("#localPrice").val()      ;	
	var localPriceValue = parseFloat(localPrice);
	// 总价格
	var localTotalPrice = $("#localTotalPrice").val()  ;
	var localTotalPriceValue = parseFloat(localTotalPrice);
	//当前轮次
	var currentRound    = $("#currentRound").val()    ;
	//数量 
	/* var quantity        = $("#goodsNumber").val()     ; */
	var quantity = 0 ;
	//币种
	var currency        = $("#localCurrency").val()   ;
	//限制价格 
	var limitPrice      = $("#limitPrices").val()      ;
	var limitPriceValue = parseFloat(limitPrice);
	var remark          = $("#localRemark").val()     ;
	var currentFbk2 = $("#currentFbk2").val();
	
	if ("" == localTotalPrice || localTotalPrice == null || localTotalPrice == undefined){
		alert("报价金额不能空！",2);
		return;
	}
	if (!(reg.test(localTotalPrice))) {
		alert("请输入正确的金额！",2);
		return;
   	}
	var tableMaterial = itemGrid1.rows();
	if(tableMaterial.length == 1 ){ // 单个物料
		if (!(reg.test(localPrice))) {
			alert("请输入正确的金额！",2);
			return;
	   	}
		quantity = tableMaterial.quantity; // 数量
		if ("" == localPrice || localPrice == null || localPrice == undefined){
			alert("没有输入价格,不能报价!",2);
			return;
		}
	}
	
	if(""!=limitPrice && undefined!=limitPrice){
		if(limitPriceValue < localTotalPriceValue){
			alert("总价高于限购价",2);
			return;
		}
	}
	// 获取历史报价信息
	var historyRows = historyGrid.rows();
	// 判断当前报价是否比上一次报价少
	
	if(typeof(historyRows[0]) != "undefined" && historyRows.length > 0){
		if(currentRound == historyRows[historyRows.length-1].currentCount){
			if(""!=currentFbk2 && undefined!=currentFbk2){
				var price = "";
				if(currentFbk2.indexOf("%") > 0){
					price=historyRows[historyRows.length-1].totalPrice*(1-currentFbk2.substring(0,currentFbk2.length-1)/100);
				}else{
					price=historyRows[historyRows.length-1].totalPrice-currentFbk2.substring(0,currentFbk2.length-1);
				}
				if(localTotalPrice > price){
					alert("价格高于竞价幅度",2);
					return;
				}
			}else{
				if(localTotalPrice >= historyRows[historyRows.length-1].totalPrice){
					alert("当前报价不能高于上一次报价",2);
					return;
				}
			}
		}else{
			if(localTotalPrice >= historyRows[historyRows.length-1].totalPrice){
				alert("当前报价不能高于上一轮报价",2);
				return;
			}
		}
	}
		
	var frm = $("#form") ;
	var jsonObj = frm.serializeJSON()         ;
	//组装json开始---------------
	jsonObj["elsAccount"]    = elsAccount     ;
	jsonObj["toElsAccount"]  = toElsAccount   ;
	jsonObj["biddingNumber"] = biddingNumber  ;

	//TODO
	var biddingContentOnlinePriceVOs = [] ;			
	var price      = $("#price").val() ;
	var totalPrice = $("#totalPrice").val() ;
	var priceJson  = {"elsAccount":elsAccount, "fbk2":companyName ,"toElsAccount": toElsAccount,"biddingNumber":biddingNumber, "biddingName":biddingName,"price":localPrice,"currentCount":currentRound,"totalPrice":localTotalPrice, "quantity":quantity,"currency":currency,"remark":remark};
	biddingContentOnlinePriceVOs.push(JSON.stringify(priceJson));
	var PriceJsonObj = eval('[' + biddingContentOnlinePriceVOs + ']');
	jsonObj['biddingContentOnlinePriceVOs'] = PriceJsonObj;
	$.ajax({
		url         : "<%=basePath%>rest/SaleBiddingService/updateSaleBiddingPrice",
		type        : "post" ,
		contentType : "application/json",
		data        : JSON.stringify(jsonObj),
		dataType    : "json" ,	
		beforeSend  : function(){
			onlineBth = false;
		},
		success     : function(data) {
			  alert("报价成功",1);
			  refreshPrice();
			  refleshRank();
		},error : function(data) {
			alert("发送失败",3);
		},
		complete: function(){
			onlineBth = true;
		}
	});
	
	
	<%-- 原始方法调用， 
	$.ajax({
				url         : "<%=basePath%>rest/SaleBiddingService/updateSaleBiddingPrice",
				type        : "post" ,
				contentType : "application/json",
				data        : JSON.stringify(jsonObj),
				dataType    : "json" ,		
		  }).done(function(data){
		  alert("报价成功",1);
		  refreshPrice();
		  refleshRank();
	  }).fail(function(data){
		  alert("报价成功",0);
	  });
	  $("#localPrice").val("") ;  
      $("#localTotalPrice").val("") ;
	  $("#localRemark").val("") ; --%>
	  
});

//输入单价自动算出总价
$("#localPrice").keyup(function(){
	var tableMaterial = itemGrid1.rows();
	if(tableMaterial.length == 1 ){
		var quantity = tableMaterial[0].quantity;
		/* var quantity = $("#goodsNumber").val(); */
		var localPrice = $("#localPrice").val();
		var localTotalPrice = quantity * localPrice;
		$("#localTotalPrice").val(localTotalPrice);
	} else {
		alert("存在多物料报价，请直接输入总价,单价即将清空",2);
		$("#localPrice").val("");
	}
})

//输入总价自动算出单价
$("#localTotalPrice").keyup(function(){
	var tableMaterial = itemGrid1.rows();
	if(tableMaterial.length == 1 ){
		var quantity = tableMaterial[0].quantity;
		/* var quantity = $("#goodsNumber").val(); */
		var localTotalPrice = $("#localTotalPrice").val();
		var localPrice =  localTotalPrice / quantity;
		$("#localPrice").val(localPrice);
	}
})


//提交审批
$("#entryBtn").click(function(){
	var itemRows = itemGrid.selectedRows();
	var itemRowsIndex=itemGrid.selectedRowsIndex();
	var yes = 0;
	var yes2 = 0;
	var yes3 = 0;
	
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	
	//审批中(即：已提交)不能再提交
	for(var i= 0; i<=itemRows.length-1; i++) {
		if(itemRows[i].auditStatus == 2){
			yes2 = yes2 + 1;
		}
	}
	if(yes2==itemRows.length){
		alert('<i18n:I18n key="i18n_alert_bargain_auditSendNoOperate" defaultValue="审批已提交,不能执行操作!" />!',2);
		return;
	}else if(yes2>0){
		alert('<i18n:I18n key="i18n_alert_bargain_partAuditSendNoOperate" defaultValue="部分审批已提交,不能执行操作!" />!',2);
		return;
	}
	
	//审批通过不能再提交
	for(var i= 0; i<=itemRows.length-1; i++) {
		if(itemRows[i].auditStatus == 0){
			yes3 = yes3 + 1;
		}
	}
	if(yes3==itemRows.length){
		alert('<i18n:I18n key="i18n_alert_bargain_passAuditNoOperate" defaultValue="已审批通过,不能执行操作!" />!',2);
		return;
	}else if(yes3>0){
		alert('<i18n:I18n key="i18n_alert_bargain_partPassAuditNoOperate" defaultValue="部分已审批通过,不能执行操作!" />!',2);
		return;
	}
	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_confirmReportAudit" defaultValue="是否确定提交审批?" />!',closeEvent:function(){
		//提交赋值
		for(var i= 0; i<=itemRows.length-1; i++) {
			itemRows[i].elsSubAccount = elsSubAccount;
		}
		
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
	var itemRows = itemGrid.selectedRows();
	var itemRowsIndex=itemGrid.selectedRowsIndex();
	var yes = 0;
	var yes2 = 0;
	var yes3 = 0;
	
	if(itemRows.length==0){
		alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2);
		return;
	}
	
	//审批通过不能再提交
	for(var i= 0; i<=itemRows.length-1; i++) {
		if(itemRows[i].auditStatus == 0){
			yes3 = yes3 + 1;
		}
	}
	if(yes3==itemRows.length){
		alert("已审批通过,不能执行操作!",2);
		alert('<i18n:I18n key="i18n_alert_bargain_passAuditNoOperate" defaultValue="已审批通过,不能执行操作!" />!',2);
		return;
	}else if(yes3>0){
		alert('<i18n:I18n key="i18n_alert_bargain_partAuditSendNoOperate" defaultValue="部分已审批通过,不能执行操作!" />!',2);
		return;
	}
	
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


//行列自定义
$("#itemColumnDefineBtn").click(function(){
	 parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryBargainItem" + "&window=iframeApp_quoteManage",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	  });
});


//文件列自定义
$("#fileColumnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=biddingSaleQueryFiles_mt" + "&window=iframeApp_quoteManage",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	});
});

// 回签文件-->文件列自定义
$("#formColumnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	     'iconSrc':'icon/els-icon.png',
	     'windowsId':'subAccountColumnSetting',
	     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	     windowSubTitle: "",
	     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=biddingSaleQueryFiles_mt" + "&window=iframeApp_quoteManage",
	     windowMinWidth: 480,
	     windowMinHeight: 600,
	     'windowWidth':480,
	     'windowHeight':600,
	     'parentPanel':".currDesktop"
	});
});

//获取input 对象里面的值
function inputSetValue(row,index){
    var priceIncludingVat = $("#priceIncludingVat_" + index).val();
    var biddingQuoteNumber = $("#biddingQuoteNumber_" + index).val();
    var amount = $("#amount_" + index).val();
    var fbk1 = $("#fbk1_" + index+" option:selected").val();
    var fbk2 = $("#fbk2_" + index).val();
    var fbk3 = $("#fbk3_" + index).val();
    var fbk4 = $("#fbk4_" + index).val();
    row["priceIncludingVat"]=priceIncludingVat;
    row["biddingQuoteNumber"]=biddingQuoteNumber;
    row["amount"]=amount;
    row["fbk1"]=fbk1;
    row["fbk2"]=fbk2;
    row["fbk3"]=fbk3;
    row["fbk4"]=fbk4;
    return row;
}    
//更新所有的json数据
function updatejson(){
	var itemRow =  itemGrid.rows();
	if(null!=itemRow&&itemRow!=""){
		for(var i = 0;i<itemRow.length;i++){
			var singleRow = itemRow[i];
			singleRow = inputSetValue(singleRow,i);
		}
	}
}

var supplierListTableCols = [
	{title:'序号',name:'sequenceNumber', width: 80, align: 'center',renderer:function(val,item,rowIndex){
		return rowIndex+1;
	}}, 
	{title:'<i18n:I18n key="" defaultValue="供应商账号" />', name:'supplierAccount' ,width:100, align:'center'},
	{title:'<i18n:I18n key="" defaultValue="供应商名称" />', name:'supplierDesc' ,width:120, align:'center'},
	{title:'<i18n:I18n key="" defaultValue="应标" />', name:'participate' ,width:100, align:'center',renderer:function(val){
		if(val=="0"){
			return "未应标";
		}else if(val=="1"){
			return "应标";
		}else{
			return "不应标";
		}
	}},
	{title:'<i18n:I18n key="" defaultValue="报名手续" />', name:'register' ,width:100, align:'center',renderer:function(val,item,rowIndex){
		if(val!="0"){
			return "未完成";
		}else{
			return "完成";
        }
	}},
	{title:'<i18n:I18n key="" defaultValue="资质审核" />', name:'qualify' ,width:100, align:'center',renderer:function(val,item,rowIndex){
		if(val!="0"){
       		return "不通过";
        }else{
       		return "通过";
        }
	}},
	{title:'<i18n:I18n key="" defaultValue="保证金" />', name:'guaranty' ,width:100, align:'center',renderer:function(val,item,rowIndex){
		if(val!="0"){
       		return "未缴纳";
        }else{
       		return "已缴纳";
        }
	}},
	{title:'<i18n:I18n key="" defaultValue="招标文件" />', name:'getDoc' ,width:100, align:'center',renderer:function(val,item,rowIndex){
		if(val!="0"){
       		return "未领取";
        }else{
       		return "已领取";
        }
	}},
	{title:'<i18n:I18n key="" defaultValue="投标情况" />', name:'bidding' ,width:100, align:'center',renderer:function(val){
		if(val!="1"){
			return "未投标";
		}else{
			return "已投标";
		}
	}},
	{title:'<i18n:I18n key="" defaultValue="开标到场" />', name:'present' ,width:100, align:'center',renderer:function(val){
		if(val!="1"){
			return "未到场";
		}else{
			return "已到场";
		}
	}},
	{title:'<i18n:I18n key="" defaultValue="中标情况" />', name:'win' ,width:100, align:'center',renderer:function(val){
		if(val!="1"){
			return "未中标";
		}else{
			return "已中标";
		}
	}}
];
//渲染   @author songzhen 20161215  begin
function attachmentFileRenderer(val, item, rowIndex){
	var viewFlag = false;
	var extendFields = item.extendFields;
	if(extendFields){
	   	extendFields = JSON.parse(extendFields);
		var fileList = extendFields.fileList;
		viewFlag = (fileList && fileList!="");
	}
	return '<span class="downloadForm-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
}
function attachmentImageRenderer(val, item, rowIndex){
	var viewFlag = false;
	var extendFields = item.extendFields;
	if(extendFields){
		extendFields = JSON.parse(extendFields);
		var imageList = extendFields.imageList;
		viewFlag = (imageList && imageList!="");
	}
	return '<span class="previewImage-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
    	+'&nbsp;&nbsp;<span class="downloadImage-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
}
function bidResultRenderer(val,item,index){
	var fbk5_ = item.fbk5;
	var fbk7_ = item.fbk7;
	var wonBidRank = item.wonBidRank;
	if(fbk5_ == 3){
		if(fbk7_ && fbk7_ != "null" && wonBidRank && wonBidRank != "null"){
			return fbk7_+'%/第'+wonBidRank+'中标方';
		}else if((!fbk7_ || fbk7_ == "null") && (!wonBidRank || wonBidRank == "null")){
			return '中标';
		}else if((!fbk7_ || fbk7_ == "null") && (wonBidRank || wonBidRank != "null")){
			return '第'+wonBidRank+'中标方';
		}else{
			return fbk7_+'%';
		}
	}else{
		return '未中标';
	}
}
function quantityRenderer(val,item,index){
	if(!val) { 
		val = 0;
	}
	if(biddingStatus=="2"){
		return '<input name="quantity" type="text" readonly="readonly" value="'+val+'" class="quantity"/>';
	}else{
		return '<span>'+val+'</span>';
	}
}
function fbk1Renderer(val,item,index){
	if(!val || val=="0") { 
		return '<select name="'+this.name+'" value="'+val+'" id="'+this.name+'_'+index+
			'" class="fbk1"><option value="0" selected="selected">报价</option><option value="1">不报价</option></select>';
	}else{
		return '<select name="'+this.name+'" value="'+val+'" id="'+this.name+'_'+index+
			'" class="fbk1"><option value="0">报价</option><option value="1" selected="selected">不报价</option></select>';
	}
}
function priceIncludingVatRenderer(val,item,index){
	if(!val) { 
		val = 0;
	}
	if(typeof(val)=="string"){
		val = parseFloat(val);
	}
	if(biddingStatus=="2"){
		return '<input type="text" name="'+this.name+'" value="'+val.toFixed(5)+'"  id="'+this.name+'_'+index+'" class="priceIncludingVat"/>';
	}else{
		return '<span>'+val.toFixed(5)+'</span>';
	}
}
function amountRenderer(val,item,index){
	if(!val){ 
		val = 0;
	}
	if(typeof(val)=="string"){
		val = parseFloat(val);
	}
	if(biddingStatus=="2"){
		return '<input name="amount" type="text" readonly="readonly" value="'+val.toFixed(5)+'" id="'+this.name+'_'+index+ '" class="amount"/>';
	}else{
		return '<span>'+val.toFixed(5)+'</span>';
	}
}
function fbk2Renderer(val,item,index){
	if(!val) {val = 0;}
	if(tagertPriceSendOrNot=="1"){
		return '';
	}else{
		if(biddingStatus=="2"){
			return '<input type="text" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+'" class="fbk2" readonly="readonly" />';
		}else{
			return '<span>'+val+'</span>';
		}				
	}
}
function fbk3Renderer(val,item,index){
	if(!val) {val = 0;}
	if(biddingStatus=="2"){
		if(roundsNumber=="1"){return "";}else{
			return '<input type="text" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+'" class="fbk3" readonly="readonly" />';					
		}
	}else{
		return '<span>'+val+'</span>';
	}
}
function fbk4Renderer(val,item,index){
	if(!val) {val = 0;}
	if(biddingStatus=="2"){
		if(roundsNumber=="1"){return "";}else{
		return '<input type="text" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+'" class="fbk4" readonly="readonly" />';
		}
	}else{
		return '<span>'+val+'</span>';
	}
}
function fbk6Renderer(val,item,index){
	if(!val) {val = '';}
		return val + '<input type="hidden" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+'" />';
}
function fbk9Renderer(val,item,index){
	if(!val) {val = '';}
	return '<span>'+val+'</span>';
}

//渲染   @author songzhen 20161215  end
//文件表渲染   @author songzhen 20161228  start
function remarkRenderer(val){
	return "<input name='biddingFile[][remark]' type='text'  value='"+val+"'/>";
}
function fileFbk5Renderer(val){
	if(val == "1"){
		return '回签文件';
	}else if(val == "0"){
		return '查阅文件';
	}else{
		return '未知文件所属方';
	}
}
//文件表渲染   @author songzhen 20161228  end
// 渲染   @author jiangzhidong 20160113  begin
//只允许数字输入框
var initInputNumber = function (val,item,index){
	if(!val) { val = '';}
	if(biddingStatus=="2"){
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+' "  id="'+this.name+'_'+index+'"/>';
	}else{
		return '<span> ' + val +'</span>'
	}
};
//允许任何字符输入框
var initInputAny = function (val,item,index){
	if(!val) { val = '';}
	return '<span class="' + this.name +'">'+val+'</span>';
};

//审批状态
var rendererauditStatus = function (val,item,index){
	//审批状态：auditStatus,auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
	if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
	else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
	else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
	else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';
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
	return new Date(val).format("hh:mm:ss");
};
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

//时间戳
var formatDateTime = function (val,item,index){
	if (!val) {val = "";}
	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
};

//招标状态
function rendererBiddingStatus(val){
    	if(val==0){
    		return '<i18n:I18n key="test" defaultValue="未开始" />';
    	}else if(val==1){
    		return '<i18n:I18n key="test" defaultValue="招标进行中" />';
    	}else if(val==2){
    		return '<i18n:I18n key="test" defaultValue="本轮完成" />';
    	}else if(val==3){
    		return '<i18n:I18n key="test" defaultValue="招标作废" />';
    	}
}

//在线竞标状态  : 0或null:有效竞价  1:中标
function rendererFbk3(val){
   	if(val==0 || val=='' || val ==null){
   		return '<i18n:I18n key="test" defaultValue="有效竞价" />';
   	}else if(val==1){
   		return '<i18n:I18n key="test" defaultValue="中标" />';
   	}
}

//表格clos   @author jiangzhidong 20160113  end
var black={a$1:"1",a$2:"",a$3:"",a$4:"",a$5:"",a$6:""};
var cols_item2 = [
     {title:'轮次',name:'roundsNumber', width: 120, align: 'center'},
     {title:'投标开始日期',name:'biddingBeginDate', width: 160, align: 'center', renderer:formatDateTime},
     {title:'投标结束日期', name:'biddingEndDate', width: 160, align: 'center', renderer:formatDateTime},
     {title:'状态',name:'biddingStatus', width: 120, align: 'center',renderer:rendererBiddingStatus}
];


//普通招投标
var round_cols = [
	{ title:'<i18n:I18n key="" defaultValue="是否在线竞标" />', name:'biddingType' ,width:100, align:'center',hidden:true, renderer:function(val){
		return val+"<input name='biddingRoundItms[][biddingType]' style='display:none;'  type='text' value='"+val+"'/>";
	}},
	{ title:'<i18n:I18n key="" defaultValue="标段" />', name:'biddingItemNumber' ,width:100, align:'center',renderer:function(val){
		if(val == 0){
 	    	return "不区分标段"; 
 	    }else{
 	    	return val;
 	    }              	         
	}},
    { title:'<i18n:I18n key="" defaultValue="轮次" />', name:'roundsNumber' ,width:100, align:'center',renderer:function(val){return val;}},
    { title:'<i18n:I18n key="" defaultValue="状态" />', name:'biddingStatus' ,width:100, align:'center',renderer:function(val){
		var showText;  
 	   	if(val == 0){
 			showText="未开始";
 	    }else if(val == 1){
 	    	showText="招标进行中";
 	    }else if(val == 2){
 	    	showText="本轮完成";
 	    }else if(val == 3){
 	    	showText="招标中止";
 	    }else if(val == 4){
 	    	showText="投标中止";
 	    }
        return showText;                   	   
	}},
    { title:'<i18n:I18n key="" defaultValue="投标开始日期" />', name:'biddingBeginDate' ,width:100, align:'center',renderer:function(val){
    	if(val&&val !=""){
 		   val = new Date(val).format('yyyy-MM-dd');
		}else{
 		   val = "";
 	    }
        return val;                   	   
	}},
	{ title:'<i18n:I18n key="" defaultValue="投标开始时间" />', name:'biddingBeginTime' ,width:100, align:'center',renderer:function(val){return val;}},
	{ title:'<i18n:I18n key="" defaultValue="投标截止日期" />', name:'biddingEndDate' ,width:100, align:'center',renderer:function(val){
		if(val&&val !=""){
 		   	val = new Date(val).format('yyyy-MM-dd');
 		}else{
 			val = "";
 	   	} 
 	   		return val;                	   
	}},
	{ title:'<i18n:I18n key="" defaultValue="投标截止时间" />', name:'biddingEndTime' ,width:100, align:'center',renderer:function(val){return val;}},
	{ title:'<i18n:I18n key="" defaultValue="开标日期" />', name:'openDate' ,width:100, align:'center',renderer:function(val){
		if(val&&val !=""){
 		    val = new Date(val).format('yyyy-MM-dd');
 	   	}else{
 		   	val = "";
 	   	}  
 	   	return val;               	   
	}},
	{ title:'<i18n:I18n key="" defaultValue="开标时间" />', name:'openTime' ,width:100, align:'center',renderer:function(val){return val;}},
	{ title:'<i18n:I18n key="" defaultValue="开标地点" />', name:'address' ,width:250, align:'center',renderer:function(val){
		return val;
	}}
];
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//历史轮次    		
var cols_history = [
	{title:'轮次',name:'currentCount', width: 60, align: 'center'},
	{title:'日期',name:'biddingTime', width: 100, align: 'center', renderer:formatDate},
	{title:'时间',name:'biddingTime', width: 100, align: 'center', renderer:formatTime},
	{title:'单价', name:'price', width: 60, align: 'center'},
	{title:'总价', name:'totalPrice', width: 60, align: 'center'},
	{title:'币种', name:'currency', width: 60, align: 'center'},
	{title:'状态', name:'fbk3', width: 60, align: 'center',renderer:rendererFbk3},
	{title:'备注', name:'remark', width: 60, align: 'center'}
];
			
//我方文件
var file_cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="biddingSaleQueryFiles_mt"/>;
  
  	  //初始化招投标基本信息
      function initBaseInfo(){
    	  var params = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber":biddingNumber,};
    	  $.ajax({
  			url : '<%=basePath%>rest/SaleBiddingService/querySaleBiddingHeaderByPrimary',
  			type : 'POST',
  			contentType : "application/json",
  			data : JSON.stringify(params),
  			dataType : "json",
  			success : function(data) {
  				if(data!=null&&data!=""){
  					var summary = data.summary;
  					currency = data.currency;
  					var biddingType = data.biddingType;
  					$("#biddingNumber").val(biddingNumber);
  		     		$("#biddingName").val(biddingName);
  		     		$("#biddingType").val(biddingType);
  		     		$("#biddingType2").val(biddingType);
  		     		$("#remarkArea").val(summary);
  					if(data.biddingType == 2){
  						$(".sheet-supplier-info2").hide();
  						$(".scan-form-sheet2").hide();
  						$(".sheet-project-online2").show();
  						$(".sheet-project-one1").show();
  					}else if(data.biddingType != 3){
  						$(".sheet-project-one2").show();
  						$(".sheet-project-one1").hide();
  					}else{
  						$(".sheet-project-online2").show();
  						$(".sheet-project-one1").hide();
  					}
  				}
      		},error : function(data) {
      			alert("请求出错",2);
      		}
  		});
      }
	//初始化供应商信息表
	function initSupplierInfo(){
		var param = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber": biddingNumber,"biddingItemNumber":biddingItemNumber};
		$.ajax({
			url :"<%=basePath%>rest/SaleBiddingService/querySaleBiddingSupplierByCondtion",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				var tempArr = [];
				tempArr.push(data);
				biddingSupplierListTable = $('#supplier_info_table').mmGrid({
		    	    cols: supplierListTableCols,
		    	    items: tempArr,
		    	    height: 100,
		    	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
		            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
		    	});
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("加载招投标信息失败:"+exception,3); 
	        }
		});	
      }
      
      //初始化招投标联系人信息
      function initContact(){
    	  var params = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber":biddingNumber};
  		$.ajax({
			url : '<%=basePath%>rest/SaleBiddingService/querySaleBiddingLinkmanByCondtion',
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if(data!=null&&data!=""){
					var telephone = data[0].telephone;
					var email = data[0].email;
					var fax = data[0].fax;
					var address = data[0].address;
					var principal = data[0].principal;
					var orgName = data[0].orgName;
					$("#principal").val(principal);
					$("#telephone").val(telephone);
					$("#email").val(email);
					$("#fax").val(fax);
					$("#address").val(address);
					$("#biddingCompany").val(orgName);
				}
    		},error : function(data) {
    			
    		}
		});
      }

      
      //初始化供应商报价内容信息
      function initContent(){
    	  var params = {"elsAccount":elsAccount,"biddingNumber":biddingNumber,"toElsAccount":toElsAccount,"biddingItemNumber":biddingItemNumber};
  		$.ajax({
			url : '<%=basePath%>rest/SaleBiddingService/querySaleBiddingContentByCondtion',
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if(data!=null&&data!=""){
					var summary = data[0].summary;
					var projectNumber = data[0].biddingProjectNumber;
					var projectRemark = data[0].biddingProjectName;
					var deliveryStartDate = data[0].deliveryStartDate;
					var deliveryEndDate = data[0].deliveryEndDate;
					var address = data[0].address;
					var quality = data[0].quality;
					controlBidding = data[0].fbk1;
					$("#descriptionArea").val(summary);
					$("#projectNumber").val(projectNumber);
					$("#projectRemark").val(projectRemark);
					$("#deliveryStartDate").val(new Date(deliveryStartDate).format("yyyy-MM-dd"));
					$("#deliveryEndDate").val(new Date(deliveryEndDate).format("yyyy-MM-dd"));
					$("#contentAddress").val(address);
					$("#quality").val(quality);
				}
    		},
    		error : function(data) {
    			
    		}
		});
      }
      //初始化采购方保证金
      function initMargin(){
    	  var params = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber":biddingNumber,"biddingItemNumber":biddingItemNumber};
  		$.ajax({
			url : '<%=basePath%>rest/SaleBiddingService/querySaleBiddingMarginByCondtion',
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if(data!=null&&data!=""){
					var collect = data[0].collect;
					var back = data[0].back;
					var amount = data[0].amount;
					var currency = data[0].currency;
					var payBeginDate = data[0].payBeginDate;
					var payEndDate = data[0].payEndDate;
					var payBeginDate1 = formatDate(payBeginDate);
					var payEndDate1 = formatDate(payEndDate);
					var remark = data[0].remark;
					if(collect == "0"){
						$("input[name='radio1']:eq(1)").attr("checked",true);
						$("input[name='radio1']:eq(1)").parent().next().hide();
						$("input[name='radio1']:eq(1)").parent().next().next().hide();
					}else{
						$("input[name='radio1']:eq(0)").attr("checked",true);
					}
					$("#back").val(back);
					$("#amount").val(amount);
					$("#currency").val(currency);
					$("#payBeginDate").val(payBeginDate1);
					$("#payEndDate").val(payEndDate1);
					$("#remark").val(remark);
				}
    		},error : function(data) {
    			
    		}
		});
      }
      <%-- //初始化采购方招投标文件
      function initFile(){
    	  var params = {"elsAccount":elsAccount,"biddingNumber":biddingNumber};
  		$.ajax({
			url : '<%=basePath%>rest/SaleBiddingService/querySaleBiddingFilesByCondtion',
			type : 'POST',
			contentType : "application/json",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if(data!=null&&data!=""){
					var description = data.rows[0].remark;
					var projectNumber = data.rows[0].biddingProjectNumber;
					var projectRemark = data.rows[0].fbk1;
					$("#descriptionArea").val(description);
					$("#projectNumber").val(projectNumber);
					$("#projectRemark").val(projectRemark);
				}
    		},error : function(data) {
    			
    		}
		});
		editFileTable.load(params);
      } --%>
      
      //初始化网上竞标商品信息
      function initBiddingGoods(){
    	  var params = {"elsAccount":toElsAccount,"biddingNumber":biddingNumber};
    		$.ajax({
    		url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/getPurchaseBiddingContentItem' + "?t="+new Date().getTime(),
  			type : 'POST',
  			contentType : "application/json",
  			data : JSON.stringify(params),
  			dataType : "json",
  			success : function(data) {
  				if(data!=null&&data!=""){
  					/* $("#purchaseItem").val(data.materialDesc); */
  					/* $("#goodsBrand").val(data.materialSpecification); */
  					/* $("#goodsName").val(data.materialDesc); */
  					/* $("#goodsSize").val(data.materialSpecification); */
  					/* $("#MaxPriceLimit").val(data.purchaseItem); */
  					/* $("#goodsNumber").val(data.quantity); */
  					/* $("#deliveryPeriod").val(data.purchaseItem); */
  					/* $("#goodsUnit").val(data.unitQuantity); */
  					$("#localRoundsTotalPrice").val(data.purchaseItem);
  					//当前最低报价
  					$(".currentMinPrice").html(data.fbk3);
  					$("#currentMinPrice").val(data.fbk3);
  				}
      		},error : function(data) {
				alert("加载失败",3);
      		}
  		});
      }
      
      //初始化网上竞标信息
      function initBiddingInfo(){
    	    //头表purchase_bidding_header
    	    //查询采购的竞标信息
    	    var headParam = {
    	    	'elsAccount':toElsAccount,
    	    	'biddingNumber':biddingNumber,
    	    	'biddingItemNumber':biddingItemNumber
    	    };
    	    
    	    //加载头
    		$.ajax({
    			url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/getPurchaseEnquiryBidding' + "?t="+new Date().getTime(),
    			type : 'POST',
    			contentType : "application/json",
    			data : JSON.stringify(headParam),
    			dataType : "json",
    			success : function(data) {
    				//招标编号
    				$("#biddingNumber2").text(data.biddingNumber);
    				//招标名称
    				$(".init-biddingNumber").val(data.biddingName);
    				//开标日期
    				var opentime = data.opentime;
    				if (opentime!=null&&opentime.length!=10)
    					opentime = new Date(opentime).format("yyyy-MM-dd hh:mm:ss");
    				$("#opentime").text(opentime);
    				//招标类型
    				var biddingType="错误";
    				if(data.biddingType==0)
    					biddingType='<i18n:I18n key="test" defaultValue="邀请招标" />';
    				else if(data.biddingType==1)
    					biddingType='<i18n:I18n key="test" defaultValue="公开招标" />';
    				else if(data.biddingType==2)
    					biddingType='在线竞标-邀请';
    				$(".init-biddingType").val(data.biddingType);
    				//var cols_round;
    				//判断是否在线竞标
    				if(data.biddingType == 2){
    					//每轮持续/分钟
    					$("#fbk2").text(data.fbk2);
    					//每轮间隔/分钟
    					$("#fbk3").text(data.fbk3);
//     					$("#roundMinutes").val(data.fbk2);
//     					$("#intervalMinutes").val(data.fbk3);
    					//采购限价
    					$(".init-limitPrices").val(data.fbk4);
    					//cols_round = cols_rounds_online;
    					
    					timerLoad(headParam);
    					 var currentDate = new Date();
    					 var currentRound;
    					 var currentFbk2;
    					 for(var i= 0 ; i < data.biddingRoundItms.length ; i ++){
    						 var itemRound = data.biddingRoundItms[i];
        					 var beginDate = toDateAndTime(new Date(itemRound.biddingBeginDate).format('yyyy-MM-dd'),itemRound.biddingBeginTime);
        					 var endDate = toDateAndTime(new Date(itemRound.biddingEndDate).format('yyyy-MM-dd'),itemRound.biddingEndTime);
        					 
    						 if(Date.parse(beginDate) <= Date.parse(endDate) && new Date().getTime() >= Date.parse(endDate)){
    							 currentRound = itemRound.roundsNumber;
    							 currentFbk2 = itemRound.priceOff;
    							 break;
    						 }
    					 }
    					 $("#totalRound").text(data.totalRound);
    					 $("#currentRound").val(currentRound);
    					 $("#currentFbk2").val(currentFbk2);
    					 var biddingBeginDate = new Date(data.biddingRoundItms[0].biddingBeginDate).format('yyyy-MM-dd');
    					 var biddingBeginTime = data.biddingRoundItms[0].biddingBeginTime;
    					 var biddingEndDate = new Date(data.biddingRoundItms[data.biddingRoundItms.length -1].biddingEndDate).format('yyyy-MM-dd');
    					 var biddingEndTime = data.biddingRoundItms[data.biddingRoundItms.length -1].biddingEndTime;
    					 $("#biddingBeginDate").val(toDateAndTime(biddingBeginDate,biddingBeginTime));
    					 $("#biddingEndDate").val(toDateAndTime(biddingEndDate,biddingEndTime));
    				}else if(data.biddingType != 3){
    					$(".online-bidding").hide();
    					//cols_round = cols_rounds;
    				}else{
    					
    					//每轮持续/分钟
    					$("#fbk2").text(data.fbk2);
    					//每轮间隔/分钟
    					$("#fbk3").text(data.fbk3);
//     					$("#roundMinutes").val(data.fbk2);
//     					$("#intervalMinutes").val(data.fbk3);
    					//采购限价
    					$(".init-limitPrices").val(data.fbk4);
    					//cols_round = cols_rounds_online;
    					
    					timerLoad(headParam);
    					 var currentDate = new Date();
    					 var currentRound;
    					 var currentFbk2;
    					 for(var i= 0 ; i < data.purchaseBiddingRounds.length ; i ++){
    						 var itemRound = data.purchaseBiddingRounds[i];
    						 var beginDate = new Date(itemRound.biddingBeginDate);
    						 var endDate = new Date(itemRound.biddingEndDate);
    						 if(beginDate.getTime() <= currentDate.getTime() && endDate.getTime() >= currentDate.getTime()){
    							 currentRound = itemRound.roundsNumber;
    							 currentFbk2 = itemRound.priceOff;
    							 break;
    						 }
    					 }
    					 $("#totalRound").text(data.purchaseBiddingRounds.length);
    					 $("#currentRound").val(currentRound);
    					 $("#currentFbk2").val(currentFbk2);
    					 $("#biddingBeginDate").val(new Date(data.biddingRoundItms[0].biddingBeginDate).format('yyyy-MM-dd hh:mm:ss'));
    					 $("#biddingEndDate").val(new Date(data.biddingRoundItms[data.biddingRoundItms.length -1].biddingEndDate).format('yyyy-MM-dd hh:mm:ss'));
    				}
    				 
    				//招标说明
    				$("#remark").val(data.remark);
    				//采购方招标联系人信息
    				if(data.purchaseBiddingLinkMan!=null&&data.purchaseBiddingLinkMan!=''){
    					$("#elsAccount").val(data.purchaseBiddingLinkMan[0].elsAccount);
    					$("#principal").val(data.purchaseBiddingLinkMan[0].principal);
    					$("#telephone").val(data.purchaseBiddingLinkMan[0].telephone);
    					$("#email").val(data.purchaseBiddingLinkMan[0].email);
    					$("#fax").val(data.purchaseBiddingLinkMan[0].fax);
    					$("#address").val(data.purchaseBiddingLinkMan[0].address);
    				}
    				//采购方招标内容信息
    				if(data.biddingContentVOs!=null&&data.biddingContentVOs!=''){
    					$("#contentremark").val(data.biddingContentVOs.remark);
    					$("#contentbiddingProjectNumber").val(data.biddingContentVOs.biddingProjectNumber);
    					$("#contentfbk1").val(data.biddingContentVOs.fbk1);
    				}
    				
    			},
    			error : function(data) {
    				alert("加载失败",3);
    			}
    		});
      }
      
      
      var interval1;
      var interval2;
      var interval3;
      
      // 时间凭借
      function toDateAndTime(date,time){
    		var arrDate = date.split("-");
    		var arrTime = time.split(":");
    		return new Date(arrDate[0],arrDate[1]-1,arrDate[2],arrTime[0],arrTime[1],arrTime[2]).format("yyyy-MM-dd hh:mm:ss");
    	}
      
      //加载轮次
      function timerLoad(headParam){
    		 clearInterval(interval1);
    		 clearInterval(interval2);
    		 clearInterval(interval3);
    		 $.ajax({
    				url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/getPurchaseEnquiryBidding',
    				type : 'POST',
    				contentType : "application/json",
    				data : JSON.stringify(headParam),
    				dataType : "json",
    				success : function(data) {
    					 var currentDate = new Date();
    					 var currentRound;//当前轮次
    					 var currentRoundDate;//距离最近到时间，结束或者开始
    					 var currentFbk2;//当前最少降价幅度
    					 var currentFbk3;//当前幅度单位
    					 var limitPrices = data.fbk4;//第一轮的采购限价
    					 var currentFbk1;
    					 var flag;
    					 for(var i= 0 ; i < data.biddingRoundItms.length ; i ++){
    						 var itemRound = data.biddingRoundItms[i];
    						 var beginDate = toDateAndTime(new Date(itemRound.biddingBeginDate).format('yyyy-MM-dd'),itemRound.biddingBeginTime);
        					 var endDate = toDateAndTime(new Date(itemRound.biddingEndDate).format('yyyy-MM-dd'),itemRound.biddingEndTime);
        					 if(Date.parse(beginDate) <= Date.parse(endDate) && new Date().getTime() <= Date.parse(endDate)){
    							 currentRound = itemRound.roundsNumber;
    							 currentFbk2 = itemRound.priceOff;//获取当前轮次的降价幅度
    							 currentRoundDate = endDate;
    							 currentFbk1 = itemRound.fbk1;//获取当前轮次的采购限价
    							 currentFbk3 = itemRound.unitsType; //获取当前轮次的幅度单位
    							 flag = i;
    							 break;
    						 }
    						 if(currentDate.getTime() > Date.parse(endDate)){
    							 flag = i;
    						 }
    					 }
    					 var bBate = data.biddingRoundItms[flag].biddingBeginDate;
    					 var bTime = data.biddingRoundItms[flag].biddingBeginTime;
    					 var dateTime = toDateAndTime(new Date(bBate).format('yyyy-MM-dd'),bTime);
    					 if(currentDate.getTime() < Date.parse(dateTime)){
    						 $("#currentRound").val("第"+(flag+1)+"轮尚未开始");
    						 var round = data.biddingRoundItms[0];
    						 var fbk2 = round.priceOff;
    						 clearInterval(intervalItemHis);
    						 if(fbk2){//填写的降价幅度的
    							 if(round.unitsType == "0"){
    								 $("#currentFbk2").val(parseInt(fbk2).toFixed(2)+"元");
    							 }else{
    								 /* var result = limitPrices*fbk2/100.0;
    								 $("#currentFbk2").val(result.toFixed(2)+"%"); */
    								 $("#currentFbk2").val(parseInt(currentFbk2).toFixed(2)+"%");
    							 }
    						 }else{
    							 $("#currentFbk2").val("");
    						 }
    						 
    						 var currentRoundDate = toDateAndTime(new Date(data.biddingRoundItms[flag].biddingBeginDate).format('yyyy-MM-dd'),data.biddingRoundItms[flag].biddingBeginTime);
    						 interval1 = setInterval(function() {
    							 var date = new Date();
    							 var xj = Date.parse(currentRoundDate) - date.getTime();
    							 if(xj<= 10){
    								 timerLoad(headParam);
    								 return;
    							 }
    							 minutes = Math.floor(xj/1000/60);
    							 seconds = Math.floor(xj/1000%60);
    							 minutes = minutes>=10?minutes:'0'+minutes;
    							 seconds = seconds>=10?seconds:'0'+seconds;
    							 msg = "距离本次在线竞标开始还有"+minutes+"分"+seconds+"秒";
    							 $("#timer").html(msg);
    							}, 1000);
    					 }else{
    						 if(!currentRound){
    							 $("#currentRound").val("第"+data.biddingRoundItms[flag].roundsNumber+"轮结束");
    							 var round = data.biddingRoundItms[flag];
    							 var fbk2 = round.priceOff;
    							 var fbk1 = round.fbk1;
    							 clearInterval(intervalItemHis);
    							 if(fbk2){
    								 if(round.unitsType == "0"){
    									 if(""!=currentFbk2 && undefined!=currentFbk2){
    									 	$("#currentFbk2").val(parseInt(fbk2).toFixed(2)+"元");
    									 }else{
    										 $("#currentFbk2").val("");
    								 	 }
    								 }else{
    									 if(fbk1){
    										/*  var result = fbk1*fbk2/100.0;
    										 $("#currentFbk2").val(result.toFixed(2)+"%"); */
    										 if(""!=currentFbk2 && undefined!=currentFbk2){
    											 $("#currentFbk2").val(parseInt(currentFbk2).toFixed(2)+"%");
    										 }else{
    											 $("#currentFbk2").val("");
    										 }
    									 }else{
    										 for(var i = flag-1 ; i >= 0 ; i -- ){//如果当前轮次最低报价数为空，则一次向上轮递推到有最低限价为止
    											 var itemRound = data.biddingRoundItms[i];
    											 var fbk1 = itemRound.fbk1;
    											 if(fbk1){
    												 var result = fbk1*fbk2/100.0;
    												 $("#currentFbk2").val(result.toFixed(2)+"%");
    												 break;
    											 }
    										 }
    										 
    									 }
    								 }
    							 }else{
    								 $("#currentFbk2").val("");
    							 }
    							 
    							 if(flag == data.biddingRoundItms.length-1){
    								 $("#timer").html("本次在线竞标已结束！");
    								 clearInterval(intervalItemHis);
    								 return;
    							 }else{
    								 var currentRoundDate = toDateAndTime(
    										 new Date(data.biddingRoundItms[flag+1].biddingBeginDate).format('yyyy-MM-dd'),
    										 data.biddingRoundItms[0].biddingBeginTime);
    								 clearInterval(intervalItemHis);
    		    					 
    								 interval2 = setInterval(function() {
    									 var date = new Date();
    									 var xj = Date.parse(currentRoundDate) - date.getTime();
    									 if(xj<= 10){
    										 timerLoad(headParam);
    										 clearInterval(intervalItemHis);
    										 return;
    									 }
    									 minutes = Math.floor(xj/1000/60);
    									 seconds = Math.floor(xj/1000%60);
    									 minutes = minutes>=10?minutes:'0'+minutes;
    									 seconds = seconds>=10?seconds:'0'+seconds;
    									 msg = "距离下一轮开始还有"+minutes+"分"+seconds+"秒";
    									 $("#timer").html(msg);
    									}, 1000);
    							 }
    						 }else{
    							 $("#currentRound").val(currentRound);
    							 if(currentFbk2){
    								 if(currentFbk3 == "0"){
    									 $("#currentFbk2").val(parseInt(currentFbk2).toFixed(2)+"元");
    								 }else{
	    								 $("#currentFbk2").val(parseInt(currentFbk2).toFixed(2)+"%");
    									 /* if(currentFbk1){
    										 var result = currentFbk1*currentFbk2/100.0;
    										 $("#currentFbk2").val(result.toFixed(2)+"%");
    	    								 $("#currentFbk2").val(parseInt(currentFbk2).toFixed(2)+"%");
    									 }else{
    										 for(var i = flag ; i >= 0 ; i -- ){
    											 var itemRound = data.biddingRoundItms[i];
    											 var fbk1 = itemRound.fbk1;
    											 if(fbk1){
    												 var result = fbk1*currentFbk2/100.0;
    												 $("#currentFbk2").val(result.toFixed(2)+"%");
    												 break;
    											 }
    										 }
    									 } */
    								 }
    							 }else{
    								 $("#currentFbk2").val("");
    							 }
    							 
    							 interval3 = setInterval(function() {
    								 var date = new Date();
    								 var xj = Date.parse(currentRoundDate) - date.getTime();
    								 if(xj<= 10){
    									 timerLoad(headParam);
    									 return;
    								 }
    								 minutes = Math.floor(xj/1000/60);
    								 seconds = Math.floor(xj/1000%60);
    								 minutes = minutes>=10?minutes:'0'+minutes;
    								 seconds = seconds>=10?seconds:'0'+seconds;
    								 msg = "距离本轮结束还有"+minutes+"分"+seconds+"秒";
    								 $("#timer").html(msg);
    								}, 1000);
    						 }
    					 }
    				}
    		 });
    	}
  
      function loadHistory(){
    		 //加载竞价
    	    var fileParam = {
    			'elsAccount':elsAccount,
    	    	'biddingNumber':biddingNumber
    		};
    	    historyGrid = $('#historyTable').mmGrid({
    		    cols: cols_history,
    		    url: '<%=basePath%>rest/SaleBiddingService/querySaleBiddingPriceByCondtion',
    		    params: fileParam,
    		    method: 'post',
    		    root: 'rows',
    		    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
    	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
    		   // fullWidthRows:true,
    		    indexCol: false,
    		    height:250,
    	        width:600,
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
    	    refreshPrice();
    	    refleshRank();
      }
      
      function refreshPrice(){
    		var fileParam = {
    				'elsAccount':toElsAccount,
    		    	'biddingNumber':biddingNumber
    			};
    		//区别对应的参数值
    		 var GridParam = {
    				'elsAccount':elsAccount,
    		    	'biddingNumber':biddingNumber
    			};
    		historyGrid.load(GridParam);
    		intervalItemHis = setInterval(function() {
    			$.ajax({
    				url : '<%=basePath%>rest/PurchaseEnquiryBiddingService/queryCurrentMinPrice',
    				type : 'POST',
    				contentType : "application/json",
    				data : JSON.stringify(fileParam),
    				dataType : "json",
    				success : function(data) {
    					$(".currentMinPrice").html(data.fbk3);
    					$("#currentMinPrice").val(data.fbk3);
    					key = data.key || [];
    					value = data.value || [];
    				}
    			});
    	    }, 5000);
    	}
      
      //获取竞价排名
      function refleshRank(){
    	  var currentCount = $("#currentRound").val();
    	  var fileParam = {
  				'elsAccount':toElsAccount,
  		    	'biddingNumber':biddingNumber,
  		    	'currentCount': currentCount
  			};
  		intervalItemHis = setInterval(function() {
  			$.ajax({
  				url : '<%=basePath%>rest/SaleBiddingService/getBiddingSupplierRank',
  				type : 'POST',
  				contentType : "application/json",
  				data : JSON.stringify(fileParam),
  				dataType : "json",
  				success : function(data) {
					$("#currentRank").val(data.rank);
  				}
  			});
  	    }, 5000);
      }
           
//加载查阅文件
function loadFile() {
	debugger;
    /* var items = itemGrid.rows();
    var toElsAccounts = '';
 	for(var i= 0; i<=items.length-1; i++) {
 		var tmp = items[i].toElsAccount;
 		if (i==0) 
 			toElsAccounts = tmp;
 		else {
 			if(toElsAccounts.indexOf(tmp)==-1)
 				toElsAccounts = toElsAccounts+'-'+tmp;
 		}
 	} */
    
    //文件参数
  /*   var sft = $('#selectFileType').val().split("-");
	var sps = $('#selectPurchaseSale').val(); */
	var fileParam = {
		'elsAccount':currentElsAccount,
		'toElsAccount':toElsAccount,
		'biddingNumber':biddingNumber,
		'biddingItemNumber':biddingItemNumber,
		'roundsNumber':roundsNumber,
		'fbk5':0
	};
	if(!editFileTable){
		editFileTable=$('#add-file-project').mmGrid({
		    cols: file_cols,
		    url: '<%=basePath%>rest/SaleBiddingService/querySaleBiddingFilesByCondtion',
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
	} else {
		editFileTable.load(fileParam);
	}
	
	//刷新
	$("#flushFileBtn").click(function() {
		editFileTable.load({});
	})
	
		//显示上传弹框
	$("#uploadFile").click(function(){
		 initFileUploader(fileUploader);
		 $('#fixed-dialog').show();
	});
	
	//显示上传弹框
	$("#btnFileOK").click(function(){
		addFileItem();
   	    updateFile = true;
		
	});
	//关闭上传弹框
	$("#btnFileCancel ,.dialog-close-btn").click(function(){
		 $('#fixed-dialog').hide();
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
	
	
	//在文件列表添加新添加的文件列
	function addFileItem(){
		var filePath=$("#filePath").val();
		var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
		var fileName=$("#fileName").val();
		var fileSize = $("#fileSize").val();
		
		/* var biddingItemNumber = ?;
		var biddingItemName = ?;
		var roundNumber = ?; */
		var currTime = (new Date()).format("yyyy-MM-dd");
		
		var fileBlackItem={biddingNumber:biddingNumber,biddingItemNumber:biddingItemNumber,biddingItemName:"?",
				roundNumber:roundsNumber,fileName:fileName,logtime:currTime, remark:"",fileOwner:1};
		editFileTable.addRow(fileBlackItem);
		$('#fixed-dialog').hide();
	}
	
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
	
	 //---------------文件展示----begin------------------
    editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
  		var filePath = item.filePath;
  		previewFile(filePath);
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
      //---------------文件展示----end------------------
}

//加载回签文件
function loadForm() {
	var formParam = {
		'elsAccount':currentElsAccount,
		'toElsAccount':toElsAccount,
		'biddingNumber':biddingNumber,
		'biddingItemNumber' : biddingItemNumber,
		'fbk5':1
	};
	if(!editFormTable){
		editFormTable=$('#add-form-project').mmGrid({
		    cols: file_cols,
		    url: '<%=basePath%>rest/SaleBiddingService/querySaleBiddingFilesByCondtion',
		    params: formParam,
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
	} else {
		editFormTable.load(formParam);
	}
	
	//回签文件-->刷新
	$("#flushFormBtn").click(function() {
		editFormTable.load({});
	})
	//回签文件-->显示上传弹框
	$("#uploadForm").click(function(){
		 initFormUploader(formUploader);
		 $('#fixed-dialog_one').show();
	});
	
	//回签文件-->显示上传弹框
	$("#btnFormOK").click(function(){
		addFormItem();
   	    updateForm = true;
		
	});
	
	//关闭上传弹框
	$("#btnFormCancel ,.dialog-close-btn").click(function(){
		 $('#fixed-dialog_one').hide();
	});
	//查阅文件-->文件下载
	$("#downloadForm").click(function(){
		var selectRows = editFormTable.selectedRows();
		if(selectRows.length > 0){
			selectRow = selectRows[0];
			var formPath = selectRow.formPath;
		    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?formPath=" + formPath;
		}else{
			parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
		}
	 });
	// 查阅文件-->在线预览
	$("#lookForm").click(function(){
		var selectRows = editFormTable.selectedRows();
		if(selectRows.length > 0){
			selectRow = selectRows[0];
			var formPath = selectRow.formPath;
			previewForm(formPath);
		}else{
			parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
		}
	});
	
	
	//在文件列表添加新添加的文件列
	function addFormItem(){
		var formPath=$("#formPath").val();
		var formType = formPath.substring(formPath.lastIndexOf('.')+1);
		var formName=$("#formName").val();
		var formSize = $("#formSize").val();
		
		/* var biddingItemNumber = ?;
		var biddingItemName = ?;
		var roundNumber = ?; */
		var currTime = (new Date()).format("yyyy-MM-dd");
		
		var formBlackItem={biddingNumber:biddingNumber,biddingItemNumber:biddingItemNumber,biddingItemName:"?",fileType:formType,
				roundNumber:roundsNumber,fileName:formName,logtime:currTime,filePath:formPath, remark:"",fileOwner:1,fbk5:"1"};
		editFormTable.addRow(formBlackItem);
		$('#fixed-dialog_one').hide();
	}
	
	//初始化文件上传控件
	function initFormUploader(formUploader){
	   if(!formUploader){
	    //新增表单文件
	  	formUploader = WebUploader.create({
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
	  	formUploader.on( 'uploadAccept', function( obj, response ) {
	  	  	if(0 == response.error){
	  	   	   var formPath = response.url;
	  	   		$("#formPath").val(formPath);
	  	   	    $("#formName").val(response.name);
	  	   	    $("#formSize").val(response.size);
	  	  	}else{
	  	  		alert(response.message,2);
	  	  	}
	  	});
	  }
	}
	 //---------------文件展示----begin------------------
    editFormTable.on('cellSelected', function(e, item, rowIndex, colIndex){
  		var formPath = item.formPath;
  		previewForm(formPath);
  	});
	
  //在线预览文件
    function previewForm(formPath){
    	var showDiv = $("#form-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var param = {
				elsAccount : elsAccount,
				formPath : formPath
		};
    	
    	if(isSupportImage(formPath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${formSystemPath}/"+formPath+"' />").appendTo(viewerPlaceA);
    	} else if(isSupportForm(formPath)){//系统支持在线预览的文档则转为swf文件在线预览
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
      //---------------文件展示----end------------------
}

//应标
$("#markBidding").click(function() {
	var dataParam = {"elsAccount":elsAccount , "toElsAccount":toElsAccount , "biddingNumber":biddingNumber , "biddingItemNumber":biddingItemNumber};
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确定应标?" />',closeEvent:function(){
		parent.elsDeskTop.showLoading() ;
		//发送至供应商
		$.ajax({
			url         : "<%=basePath%>rest/SaleBiddingService/updateSaleBiddingHeader",
			type        : 'POST',
			contentType : "application/json",
			data        : JSON.stringify(dataParam),
			dataType    : "json",
			success     : function(data) {
    			alert('应标成功!',1);
				//////////////////////////////////////////////////////////////////////////////////////
    			//判断当前服务器时间是否在投标开始时间之后来决定能否投标
    			$.ajax({ 
    				url :"<%=basePath%>rest/SaleBiddingService/judgeBiddingTime",
    				type :"POST",
    				contentType : "application/json",
    				dataType : "json",
    				data:JSON.stringify({"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber":biddingNumber,"biddingItemNumber":biddingItemNumber,"roundsNumber":roundsNumber}),
    				success : function(data) {
    					if(data.statusCode =="200") {
    						biddingStatus = 2;//待投标
    						operation = "bid";
    					} else if(data.statusCode =="-1"){
    						biddingStatus = 2;//待投标
    						operation = "look";
    						alert("当前时间未到本轮招标开始时间！",2);
    					}else if(data.statusCode =="1"){
    						biddingStatus = 5;//未投标(超过投标时间)
    						operation = "look";
    						alert("超过了投标时间段，投标失败！",2);
    					}
    					init();//初始化
    	    			parent.elsDeskTop.hideLoading();
    				},
    				error: function (xhr, type, exception) {//获取ajax的错误信息
    					alert(exception, 3); 
    				}
    			});
    			//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    		},error     : function(data) {
    			alert('应标失败!',3);
    			parent.elsDeskTop.hideLoading();
    		},complete  : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
	    });
	}});
});

//不应标 @author jiangzhidong @date 20161221 begin
$("#markBiddingNo").click(function() {
	var dataParam = {"elsAccount":elsAccount , "toElsAccount":toElsAccount , "biddingNumber":biddingNumber , "biddingItemNumber":biddingItemNumber};
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确定不应标?" />',closeEvent:function(){
		parent.elsDeskTop.showLoading() ;
		//发送至供应商
		$.ajax({
			url         : "<%=basePath%>rest/SaleBiddingService/noAnswerBidding",
			type        : 'POST',
			contentType : "application/json",
			data        : JSON.stringify(dataParam),
			dataType    : "json",
			success     : function(data) {
    			biddingStatus = 1;
				init();
    			parent.elsDeskTop.hideLoading();
    		},error     : function(data) {
    			parent.elsDeskTop.hideLoading();
    		},complete  : function(data) {
    			parent.elsDeskTop.hideLoading();
    		}
	    });
	}});
});
//不应标 @author jiangzhidong @date 20161221 end

function bindItemEvent(){	
	$(".priceIncludingVat").blur(function(){
		var val = $(this).val();
		if(!val){
			val="0.00000";
		}
		if(isNaN(val)){
			alert("单价必须是数字类型!",2);
			$(this).val("0.00000");
			return;
		}
		if(!isNaN(val) && val < 0){
			alert("单价不能为负数!",2);
			$(this).val("0.00000");
			return;
		}
		var quantity = $(this).parent().parent().parent().find(".quantity").val();
		var $amount = $(this).parent().parent().parent().find(".amount");
		var param = {"priceIncludingVat":val,"quantity":quantity}
		$.ajax({
			url :"<%=basePath%>rest/SaleBiddingService/calculateAmount",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				if(data && data.statusCode == "-100"){
					alert(data.message,3)
				}else{			
					$amount.val(data.amount.toFixed(5));
				}
			}
		});
	});
	$(".fbk1").change(function(){
		var val = $(this).val();
		if(val == "1"){//不报价
			$(this).parent().parent().parent().find(".priceIncludingVat").val("0").attr("readonly",true);
			$(this).parent().parent().parent().find(".amount").val("0").attr("readonly",true);
		}else{
			$(this).parent().parent().parent().find(".priceIncludingVat").val("0").attr("readonly",false);
			$(this).parent().parent().parent().find(".amount").val("0").attr("readonly",false);
		}
	});
}
function initPricesUnit(){
	if(!currency){
		currency = "";
	}
	$(".priceUnits").each(function(){
		$(this).text(currency);
	});
}
//初始化控件
function init() {
	debugger;
	var dbContentItemUploader  ;
	//更改新增供应商招标内容目标价  @auth0r songZhen 20161229 begin
	var temp_data = {"elsAccount": elsAccount, "toElsAccount": toElsAccount, "biddingNumber":biddingNumber , "biddingItemNumber":biddingItemNumber,"roundsNumber":roundsNumber};
	$.ajax({
		url : "<%=basePath%>rest/SaleBiddingService/updateTargetPrice",
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(temp_data),
		async : false,
		dataType : "json",
		success : function(data) {
			if(data.statusCode == "-100"){
				alert("更改目标价失败"+e.message,3);
			}
		}
    });
	//更改新增供应商招标内容目标价  @author songZhen 20161229 end
	
	$("#markBidding").hide();
	//不应标 @author jiangzhidong @date 20161221 begin
	$("#markBiddingNo").hide();
	//不应标 @author jiangzhidong @date 20161221 end
 	//initDbContentItemUploader();
	//行表bidding_content_item  bidding_tender_content_item
	item_cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="biddingSaleContentItem_mt"/>;
	
	item_cols1 = [
	     		{ title:'招标编号' , name:'biddingNumber', width: 150, align:'center'},
	     		{ title:'标段序号' , name:'biddingItemNumber', width: 80, align:'center'},
	     		{ title:'行项目号' , name:'biddingContentItemNumber', width: 80, align:'center'},
	     		{ title:'<i18n:I18n key="" defaultValue="方案/设计图纸"/>', name:'attachmentFile' , width:80, align:'center',
	     	   		clickDisable:true,renderer:function(val, item, rowIndex){
	     	   			var viewFlag = false;
	     	   			var extendFields = item.extendFields;
	     	   			if(extendFields){
	     	   				extendFields = JSON.parse(extendFields);
	     	   				var fileList = extendFields.fileList;
	     	   				viewFlag = (fileList && fileList!="");
	     	   			}
	     	   			return '<span class="downloadForm-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	     	   	}},
	     		{ title:'<i18n:I18n key="" defaultValue="图片"/>', name:'attachmentImage' , width:100, align:'center',
	     	   		clickDisable:true,renderer:function(val, item, rowIndex){
	     	   			var viewFlag = false;
	     	   			var extendFields = item.extendFields;
	     	   			if(extendFields){
	     	   				extendFields = JSON.parse(extendFields);
	     	   				var imageList = extendFields.imageList;
	     	   				viewFlag = (imageList && imageList!="");
	     	   			}
	     	   			return '<span class="previewImage-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	     			    +'&nbsp;&nbsp;<span class="downloadImage-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	     		}},
	     		{ title:'项目编号' , name:'biddingProjectNumber', width: 150, align:'center'},
	     		{ title:'报价编号' , name:'biddingQuoteNumber', width: 80, align:'center',hidden:true,renderer: initInputNumber},
	     		{ title:'物料编号', name:'materialNumber' ,width:100, align:'center'},
	     		{ title:'物料描述', name:'materialDesc' ,width:400, align:'center'},
	     		{ title:'型号' , name:'materialModel' ,width:100, align:'center'},
	     		{ title:'规格&性能', name:'materialSpecification', width: 80, align: 'center'},
	     		{ title:'数量', name:'quantity' ,width:100, align:'center',renderer:function(val,item,index){
	     			if(!val) { 
	     				val = 0;
	     			}
	     			if(biddingStatus=="2"){
	     				return '<input name="quantity" type="text" readonly="readonly" value="'+val+'" class="quantity"/>';
	     			}else{
	     				return '<span>'+val+'</span>';
	     			}
	     		}},
	     		{ title:'数量单位', name:'units', width: 70, align: 'center'},
	     		{ title:'不报价', name:'fbk1' ,width:70, align:'center',renderer: function(val,item,index){
	     			if(!val || val=="0") { 
	     				return '<select name="'+this.name+'" value="'+val+'" id="'+this.name+'_'+index+
	     					'" class="fbk1"><option value="0" selected="selected">报价</option><option value="1">不报价</option></select>';
	     			}else{
	     				return '<select name="'+this.name+'" value="'+val+'" id="'+this.name+'_'+index+
	     					'" class="fbk1"><option value="0">报价</option><option value="1" selected="selected">不报价</option></select>';
	     			}
	     		}},
	     		{ title:'报价(单价)', name:'priceIncludingVat' ,width:100, align:'center',renderer: function(val,item,index){
	     			if(!val) { 
	     				val = 0;
	     			}
	     			if(typeof(val)=="string"){
						val = parseFloat(val);
					}
	     			if(biddingStatus=="2"){
	     				return '<input type="text" name="'+this.name+'" value="'+val.toFixed(5)+'"  id="'+this.name+'_'+index+'" class="priceIncludingVat"/>';
	     			}else{
	     				return '<span>'+val.toFixed(5)+'</span>';
	     			}
	     		}},
	     		{ title:'报价(总额)', name:'amount' ,width:100, align:'center',renderer:function(val,item,index){
	     			if(!val){ 
	     				val = 0;
	     			}
	     			if(typeof(val)=="string"){
						val = parseFloat(val);
					}
	     			if(biddingStatus=="2"){
	     				return '<input name="amount" type="text" readonly="readonly" value="'+val.toFixed(5)+'" id="'+this.name+'_'+index+ '" class="amount"/>';
	     			}else{
	     				return '<span>'+val.toFixed(5)+'</span>';
	     			}
	     		}},
	     		{ title:'目标价', name:'fbk2', width: 70, align: 'center',renderer: function(val,item,index){
	     			if(!val) {val = 0;}
	     			if(tagertPriceSendOrNot=="1"){
	     				return '';
	     			}else{
	     				if(biddingStatus=="2"){
	     					return '<input type="text" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+
	     						'" class="fbk2" readonly="readonly" />';
	     				}else{
	     					return '<span>'+val+'</span>';
	     				}				
	     			}
	     		}},
	     		{ title:'上轮报价', name:'fbk3', width: 70, align: 'center',renderer: function(val,item,index){
	     			if(!val) {val = 0;}
	     			if(biddingStatus=="2"){
	     				if(roundsNumber=="1"){return "";}else{
	     					return '<input type="text" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+
	     						'" class="fbk3" readonly="readonly" />';					
	     				}
	     			}else{
	     				return '<span>'+val+'</span>';
	     			}
	     		}},
	     		{ title:'上轮目标价', name:'fbk4', width: 70, align: 'center',renderer: function(val,item,index){
	     			if(!val) {val = 0;}
	     			if(biddingStatus=="2"){
	     				if(roundsNumber=="1"){return "";}else{
	     				return '<input type="text" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+
	     					'" class="fbk4" readonly="readonly" />';
	     				}
	     			}else{
	     				return '<span>'+val+'</span>';
	     			}
	     		}},
	     		{ title:'上轮排名', name:'fbk6', width: 70,  align: 'center',renderer: function(val,item,index){
	     			if(!val) {val = '';}
	     				return val + '<input type="hidden" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+
	     					'" />';
	     		}},
	     		{ title:'价格单位', name:'priceUnits', width: 70, align: 'center',renderer: initInputAny},
	     		{ title:'完成日期', name:'deliveryDate' ,width:160, align:'center',renderer: formatDate },
	     		{ title:'备注', name:'remark', width: 200, align: 'center'}
	     	];
	
	var queryParams = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber": biddingNumber,
			"biddingItemNumber":biddingItemNumber,"roundsNumber":roundsNumber};
	itemGrid = $('#table-item').mmGrid({
		cols: item_cols,
		url : "<%=basePath%>rest/SaleBiddingService/querySaleBiddingContentTenderItem",
	    params: queryParams,
	    method: 'post',
	    root: 'rows',
	    height: 300,
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	    noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    checkCol: true,
	    multiSelect: true,
	    plugins     :  [  $('#pg-price').mmPaginator({
	          style          : 'plain'
	        , totalCountName : 'total'
	        , page           : 1
	        , pageParamName  : 'currentPage'
	        , limitParamName : 'pageSize'
	        , limitLabel     : '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
	        , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	        , limit          : null
	        , limitList      : [10, 30, 40, 50]
	    })]			        
	});
	itemGrid1 = $('#table-item1').mmGrid({
		cols: item_cols1,
		url : "<%=basePath%>rest/SaleBiddingService/querySaleBiddingContentTenderItem",
	    params: queryParams,
	    method: 'post',
	    root: 'rows',
	    height: 300,
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	    noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    checkCol: true,
	    multiSelect: true,
	    plugins     :  [  $('#pg-price1').mmPaginator({
	          style          : 'plain'
	        , totalCountName : 'total'
	        , page           : 1
	        , pageParamName  : 'currentPage'
	        , limitParamName : 'pageSize'
	        , limitLabel     : '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
	        , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	        , limit          : null
	        , limitList      : [10, 30, 40, 50]
	    })]			        
	});
	if(biddingStatus=="2" && operation=="bid"){//待投标
	 // $('#selectPurchaseSale').attr("disabled",false);
		$('#selectFileType').attr("disabled",false);
		$('#fileColumnDefineBtn').attr("disabled",false);
		$('#flushFileBtn').attr("disabled",false);
		$('#downloadFile').attr("disabled",false);
		$('#lookFile').attr("disabled",false);
		$("#sendToSupplier").show();
		
		itemGrid.load();
		itemGrid.on("loadSuccess",function(e, data) {
			$("#table-item :text").each(function(){
				$(this).attr("disabled",false);
			});
			bindItemEvent();
			initPricesUnit();
		});
	}else if(biddingStatus=="0"){//应标前的显示详情
		$("#sendToSupplier").hide();
		$("#markBidding").show();
		//不应标 @author jiangzhidong @date 20161221 begin
		$("#markBiddingNo").show();
		//不应标 @author jiangzhidong @date 20161221 end
		
		itemGrid.load();
		itemGrid.on("loadSuccess",function(e, data) {
			$("#table-item :text").each(function(){
				$(this).attr("disabled",true);
			});
			initPricesUnit();
		});
	}else{//投标后显示信息
		$("#sendToSupplier").hide();
		$("#myButton").hide();
		$("#mySpan").hide();
		
		/* $('#selectPurchaseSale').attr("disabled",false); */
		$('#selectFileType').attr("disabled",false);
		$('#fileColumnDefineBtn').attr("disabled",false);
		$('#flushFileBtn').attr("disabled",false);
		$('#downloadFile').attr("disabled",false);
		$('#lookFile').attr("disabled",false);
		
		itemGrid.load();
		itemGrid.on("loadSuccess",function(e, data) {
			$("#table-item :text").each(function(){
				$(this).attr("disabled",true);
			});
			initPricesUnit();
		});
	}
	if(biddingType == "2"){
		$("#sendToSupplier").hide();
		$("#myButton").hide();
		$("#mySpan").hide();
		itemGrid1.on("loadSuccess",function(e, data) {
			$("#table-item :text").each(function(){
				$(this).attr("disabled",false);
			});
		});
	}
	//查询是否已应标
	var tempDataa = {"elsAccount": elsAccount, "toElsAccount": toElsAccount, "biddingNumber":biddingNumber , "biddingItemNumber":biddingItemNumber};
	$.ajax({
		url : "<%=basePath%>rest/SaleBiddingService/queryIsAnwserBidding",
		type : 'POST',
		contentType : "application/json",
		data : JSON.stringify(tempDataa),
		async : false,
		dataType : "json",
		success : function(data) {
			if(data.statusCode == "-100"){
				alert("查询是否已应标失败"+e.message,3);
			}else{
				if(data.participate == 1){//已应标
					$("#markBidding").hide();
				}				
			}
		}
    });
	$(".sheet-project-one2").hide();
	$(".sheet-project-one1").hide();
	$(".sheet-project-online2").hide();
	initBaseInfo();
	initSupplierInfo();
	initContact();
	initMargin();
	loadFile();
//	loadForm();
	initContent();
	////////////////////////////////////////////////////////////////////
	var $roundsSelect = $("#roundsSelect");
	$roundsSelect.empty();
	for(var i=0;i<roundsNumber;i++){
		$roundsSelect.append("<option value='"+(i+1)+"'>第"+(i+1)+"轮</option>");
	}
	$roundsSelect.val(roundsNumber);//设置当前轮次为选择项
	$("body").data("prevRoundSelect",roundsNumber);
	
	$roundsSelect.change(function(){
		var selectRounds = $roundsSelect.val();
		var prevRoundSelect = $("body").data("prevRoundSelect");
		if(!itemRows_data || itemRows_data.length == 0 || itemRows_data == []){//第一次改变下拉框
			updatejson();//更新输入框json数据
			itemRows_data = itemGrid.rows();				
		}
		if(biddingStatus=="2"){//投标状态			
			if(roundsNumber == selectRounds){//如果要切换成的轮次为当前轮次
				itemGrid.load(itemRows_data);
				$("#table-item :text").each(function(){
					$(this).attr("disabled",false);
				});
			}else if(roundsNumber != selectRounds && roundsNumber == prevRoundSelect){//如果要切换成的轮次不为当前轮次，且前一轮次为当前轮次
				updatejson();//更新输入框json数据
				itemRows_data = itemGrid.rows();//先保存前一轮次信息，再加载历史报价
				
				selectTableLoad(selectRounds);
			}else{//如果要切换成的轮次不为当前轮次，且前一轮次也不为当前轮次,直接加载历史报价
				selectTableLoad(selectRounds);
			}
		}else{//非投标状态-->查看状态
			selectTableLoad(selectRounds);
		}
	});
	function selectTableLoad(selectRounds){
		itemGrid.opts.params = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber": biddingNumber,
				"biddingItemNumber":biddingItemNumber,"roundsNumber":selectRounds};
		itemGrid.load();
		$("#table-item :text").each(function(){
			$(this).attr("disabled",true);
		});
	}
	$("#importS").click(function(){
		initDbContentItemUploader();
	});
	
	// 导入报价模板
	function initDbContentItemUploader() {
		if(!dbContentItemUploader) {
	   		dbContentItemUploader = WebUploader.create({
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
			    pick: '#importS',
			    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			    resize: false,
		  	    formData : {
			     	elsAccount : elsAccount
			    }
			});
	   		dbContentItemUploader.on( 'uploadAccept', function( file, response ) {
	   			if(elsAccount == "160000"){
	   				if(toElsAccount == "" || toElsAccount == null){
	   					var toElsAccount = "";
	   				}else{
	   					var toElsAccount = toElsAccount;
	   				}
	   			}else{
	   				var toElsAccount = elsAccount;
	   			}
	   			if($("#isValidity").prop("checked")){
	   				flag = $("#isValidity").val();
	   			}else{
	   				flag = "";
	   			}
	   			var fbk7 = flag;
	   		 	var filePath = response.url;
	   		 	var fbk6 = $("input[name='fbk6']:checked").val();
	   		 	var biddingNumber = $("#biddingNumber").val();
	   		 	debugger;
	   		 	var biddingItemNumber = $("#contentBiddingItemNumber").val();
		   		var materialDesc = $("#materialDesc").val();
		 		var materialNumber = $("#materialNumber").val();
			  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
			  	$.ajax({
					url :"<%=basePath%>rest/SaleBiddingService/importExcelByPath",
					type :"POST",
					contentType : "application/json",
					dataType : "json",
					data:JSON.stringify({"materialNumber":materialNumber,"materialDesc":materialDesc,"elsAccount":elsAccount,"fbk6":tagertPriceSendOrNot,"fbk9":filePath,
						"biddingNumber":biddingNumber,"biddingItemNumber":biddingItemNumber,"elsAccount":toElsAccount,"toElsAccount":"160000","fbk7":fbk7}),
					success : function(data) {
						//var obj = JSON.parse(data);
						if(data.statusCode=="-100"){
							parent.elsDeskTop.hideLoading();
							parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_importFailure" defaultValue="导入失败！请检查文件内容！" />'});
						}else{
							parent.elsDeskTop.hideLoading();
							itemGrid.load(data.rows);
							parent.elsDeskTop.tip.init({type : 'alert',displayType : 1,message : '<i18n:I18n key="i18n_common_alert_successfulImprot" defaultValue="导入成功！" />'});
						}
					},
					error: function (data) {//获取ajax的错误信息
// 						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误！" />'});
		            }
				});
			});
		}
	}
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	if(biddingType == 2 ){
		//加载网上竞价商品信息 
		initBiddingGoods();
		//加载网上竞价轮次信息
		initBiddingInfo();
		//加载报价记录 
		loadHistory();
	}
    //查看历史报价纪录
    $('.col-price-his').live("click", function() {
        var scanCol = $(this).next().text();
        var item = JSON.parse(scanCol);
        parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'PurchaseEnHisPrice',
            'windowTitle':'查看历史报价记录',
            windowSubTitle: '报价记录',
            'iframSrc':'<%=basePath%>enquirymanage/purchase/purchaseBargainHisManage.jsp?'+JSON.stringify(item),
            windowStatus: 'regular',
            windowMinWidth: 1100,
            windowMinHeight: 450,
            'windowWidth':1100,
            'windowHeight':450,
            'parentPanel':".currDesktop"
        });
    });
    
    var tab=$( "#sheet-project").tabs();
    $('.scan-file-sheet').click(function() {
    	$('#selectFileType').empty();
     	$('#selectFileType').append('<option value=0><i18n:I18n key="i18n_common_select_filetype_all" defaultValue="所有文件" /></option>');
 		$('#selectFileType').append('<option value=1><i18n:I18n key="i18n_common_select_filetype_public" defaultValue="公共文件" /></option>');
     	var itemGrids = itemGrid.rows();
     	for(var i= 0; i<=itemGrids.length-1; i++) {
     		var selVal = itemGrids[i].materialNumber+'-'+itemGrids[i].materialDesc;
     		$('#selectFileType').append('<option value='+selVal+'>'+selVal+'</option>');
     	}
     	loadFile();
    })
    
   $('.scan-form-sheet').click(function() {
     	loadForm();
    })
    
    //我方的文件  对方的文件
    $('#selectPurchaseSale').change(function(){
    	$('#selectPurchaseSale').change(function(){
        	var fileRows = editFileTable.rows();
        	var sps = $('#selectPurchaseSale').val();
        	if(sps == "0"){
        		loadFile();
        	}else if(sps == "1"){
        		for(var i=0;i<fileRows.length;i++){
        			var fileOwner = fileRows[i].fileOwner;
        			if(fileOwner == "0"){
        				$("#add-file-project tr:eq("+i+")").hide();
        			}
        		}
        	}else {
        		for(var i=0;i<fileRows.length;i++){
        			var fileOwner = fileRows[i].fileOwner;
        			loadFile();
        			if(fileOwner == "1"){
        				$("#add-file-project tr:eq("+i+")").hide();
        			}
        		}
        	}
        	
        })
    })
     //所有文件  公共文件  物料文件
     $('#selectFileType').change(function(){
     	loadFile();
    })
    
     //我方的文件  对方的文件
    $('#selectPurchaseForm').change(function(){
    	$('#selectPurchaseForm').change(function(){
        	var fileRows = editFileTable.rows();
        	var sps = $('#selectPurchaseForm').val();
        	if(sps == "0"){
        		loadFile();
        	}else if(sps == "1"){
        		for(var i=0;i<fileRows.length;i++){
        			var fileOwner = fileRows[i].fileOwner;
        			if(fileOwner == "0"){
        				$("#add-form-project tr:eq("+i+")").hide();
        			}
        		}
        	}else {
        		for(var i=0;i<fileRows.length;i++){
        			var fileOwner = fileRows[i].fileOwner;
        			loadFile();
        			if(fileOwner == "1"){
        				$("#add-form-project tr:eq("+i+")").hide();
        			}
        		}
        	}
        	
        })
    })
    
    <%-- itemGrid2 = $('#baseTable').mmGrid({
        cols: cols_item2,
        url : '<%=basePath%>rest/SaleBiddingService/querySaleBiddingRoundsByCondtion',
	    params: {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber": biddingNumber},
	    root: 'rows',
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
//         checkCol:true,
      //  items: [black]
    }); --%>
    
    var param = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber": biddingNumber,"biddingItemNumber":biddingItemNumber};
	$.ajax({
		url :"<%=basePath%>rest/SaleBiddingService/querySaleBiddingRoundsByCondtion",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(param),
		success : function(data) {
		    var biddingRoundItms = data;
			if(biddingRoundItms &&  biddingRoundItms.length>0){
				var multiSection = biddingRoundItms[0].multiSection;//获取轮次列表中任意一条数据，查看招标计划是否区分标段
				var roundItems = [];
				if(multiSection == 0){//不区分标段
					roundItems = biddingRoundItms;
				}else{
					for(var i = 0 ; i < biddingRoundItms.length ; i ++){
						roundItems.push(biddingRoundItms[i]);
					}
				}
				//初始化phasesRoundTable
				phasesRoundTable = $('#baseTable').mmGrid({
				    cols: round_cols,
				    items : roundItems,
				    height: 240,
				    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>'
				});
			}
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
			parent.elsDeskTop.hideLoading();
            alert("加载招投标信息失败:"+exception,3); 
        }
	});
    
	$('.downloadFile-item').live("click", function() {
		var itemRowIndex = $(this).closest("tr").index();
		var itemRow = itemGrid.row(itemRowIndex);
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
		var itemRow = itemGrid.row(itemRowIndex);
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
	$('.downloadImage-item').live("click", function() {
		var itemRowIndex = $(this).closest("tr").index();
		var itemRow = itemGrid.row(itemRowIndex);
		var extendFields = itemRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var imageList = extendFields.imageList;
			if("undefined"!=typeof(imageList) && imageList.length > 0){
				downloadFile("image",itemRowIndex);
			} else {
				alert("没有图片可下载",2);
			}
		} else {
			alert("没有图片可下载",2);
		}
	});
	function downloadFile(type,rowIndex){
		var materialRow = itemGrid.row(rowIndex);
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
	
	// 导出报价模板
	$("#downMaterialModual").click(function(){
		if(elsAccount == "160000"){
			if(toElsAccount == "" || toElsAccount == null){
				var toElsAccount = "";
			}else{
				var toElsAccount = toElsAccount;
			}
		}else{
			var toElsAccount = elsAccount;
		}
		if($("#isValidity").prop("checked")){
			flag = $("#isValidity").val();
		}else{
			flag = "";
		}
		var materialDesc = $("#materialDesc").val();
		var materialNumber = $("#materialNumber").val();
		var fbk7 = flag;
		$.ajax({
			url :"<%=basePath%>rest/SaleBiddingService/exportExcel",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify({"materialNumber":materialNumber,"biddingNumber":biddingNumber,
				"materialDesc":materialDesc,"elsAccount":toElsAccount,"toElsAccount":"160000","fbk6":tagertPriceSendOrNot,"fbk7":fbk7}),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + data.message;
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	
}
</script>

</body>
</html>