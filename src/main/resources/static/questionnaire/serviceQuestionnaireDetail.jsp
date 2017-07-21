<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"></span>
			<div class="common-box-line" >  
			<div align="center">
				<font style="font-size: 18px" >供应链竞争力调查问卷结果</font>
			</div>
			<br>
			</div>
		</div>
		<form id="questionnaireForm">
		<input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsAccount") %>">
		<input type="hidden" id="elsSubAccount" name="elsSubAccount" value="<%=session.getAttribute("elsSubAccount") %>">
		<input type="hidden" id="userName" name="userName" value="<%=session.getAttribute("username") %>">
		<input type="hidden" id="companyName" name="companyName" value="<%=session.getAttribute("companyShortName") %>">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				一、供应链敏捷性与密切度
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>1. 相同类型的产品，上ELS后的周期和未上ELS的周期对比(缩短天数)</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="firstQuestion1Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="firstQuestion1" name="firstQuestion1"  value="5" > A.缩短周期20%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion1" name="firstQuestion1" value="4" > B.缩短周期10%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion1" name="firstQuestion1" value="3" > C.缩短周期10%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion1" name="firstQuestion1" value="1" > D.缩短周期5%以下</span>
				</div>
				<br>
				<br>
				<div class="dis-in-b input-and-tip">
					<span>2. 同一客户产品，上ELS之前和之后的周期对比(缩短天数)</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="firstQuestion2Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="firstQuestion2" name="firstQuestion2" value="5"> A.缩短周期20%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion2" name="firstQuestion2" value="4" > B.缩短周期10%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion2" name="firstQuestion2" value="3" > C.缩短周期10%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion2" name="firstQuestion2" value="1" > D.缩短周期5%以下</span>
				</div>
				<br>
				<br>
				<div class="dis-in-b input-and-tip">
					<span>3. 相同类型的产品，上ELS后的和未上ELS的沟通效率对比</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="firstQuestion3Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="firstQuestion3" name="firstQuestion3" value="5"> A.显著提高，提高沟通效率 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion3" name="firstQuestion3" value="4" > B.沟通方便快捷</span>
					<!-- <span style="margin-left: 100px"><input type="radio" id="question2" name="question2"> C.缩短周期10%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="question2" name="question2"> D.缩短周期5%以下</span> -->
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span>4. 同一客户产品，上ELS之前和之后的沟通效率对比</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="firstQuestion4Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="firstQuestion4" name="firstQuestion4" value="5"> A.显著提高，提高沟通效率 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion4" name="firstQuestion4" value="4" > B.沟通方便快捷</span>
					<!-- <span style="margin-left: 100px"><input type="radio" id="question2" name="question2"> C.缩短周期10%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="question2" name="question2"> D.缩短周期5%以下</span> -->
				</div>
				<br>
				<br>
				<div class="dis-in-b input-and-tip">
					<span>5. 上ELS之前与客户有无全销售流程数据记录</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="firstQuestion5Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="firstQuestion5" name="firstQuestion5" value="5"> A.没有 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion5" name="firstQuestion5" value="4" > B.部分有</span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion5" name="firstQuestion5" value="1"> C.有</span>
					<!-- <span style="margin-left: 100px"><input type="radio" id="question2" name="questivalue="4" on2"> C.缩短周期10%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="question2" name="question2"> D.缩短周期5%以下</span> -->
				</div>
				<br>
				<br>
				<div class="dis-in-b input-and-tip">
					<span>6. 交货期相比于之前是否有缩短(之前交货期，使用后交货期)</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="firstQuestion6Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="firstQuestion6" name="firstQuestion6" value="5"> A.是 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion6" name="firstQuestion6" value="4" > B.否</span>
					<!-- <span style="margin-left: 100px"><input type="radio" id="question2" name="question2"> C.缩短周期10%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="question2" name="question2"> D.缩短周期5%以下</span> -->
				</div>
				<br>
				<br>
				<div class="dis-in-b input-and-tip">
					<span>7. 与上线客户客户合作时间</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="firstQuestion7Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="firstQuestion7" name="firstQuestion7" value="5"> A.2年以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion7" name="firstQuestion7" value="4" > B.1年以上</span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion7" name="firstQuestion7" value="3" > C.半年以上</span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion7" name="firstQuestion7" value="1" > D.半年以下</span>
				</div>
				<br>
				<br>
				<div class="dis-in-b input-and-tip">
					<span>8. 上线客户占总销售额比重</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="firstQuestion8Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="firstQuestion8" name="firstQuestion8" value="5"> A.10%以下 </span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion8" name="firstQuestion8" value="4" > B.10-25%</span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion8" name="firstQuestion8" value="3" > C.25-50%</span>
					<span style="margin-left: 100px"><input type="radio" id="firstQuestion8" name="firstQuestion8" value="1" > D.50%以上</span>
				</div>
			</div>
		</div>
		<br>
		<br>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				二、客户导向指标
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>9. 准时交货订单数所占比例</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="secondQuestion1Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="secondQuestion1" name="secondQuestion1" value="5"> A.90%以上 </span>
					<span style="margin-left: 100px"><input type="radio" id="secondQuestion1" name="secondQuestion1" value="4" > B.90-75%</span>
					<span style="margin-left: 100px"><input type="radio" id="secondQuestion1" name="secondQuestion1" value="3" > C.75-50%</span>
					<span style="margin-left: 100px"><input type="radio" id="secondQuestion1" name="secondQuestion1" value="1" > D.50%以下</span>
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span>10. 客户总体评价</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="secondQuestion2Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="secondQuestion2" name="secondQuestion2" value="5"> A.非常满意 </span>
					<span style="margin-left: 100px"><input type="radio" id="secondQuestion2" name="secondQuestion2" value="4" > B.满意</span>
					<span style="margin-left: 100px"><input type="radio" id="secondQuestion2" name="secondQuestion2" value="3" > C.一般</span>
					<span style="margin-left: 100px"><input type="radio" id="secondQuestion2" name="secondQuestion2" value="1" > D.不满意</span>
				</div>
			</div>
		</div>
		<br>
		<br>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				三、财务
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>11. 客户总体评价</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="thirdQuestion1Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="thirdQuestion1" name="thirdQuestion1" value="5"> A.增长迅速 </span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion1" name="thirdQuestion1" value="4" > B.平稳增长</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion1" name="thirdQuestion1" value="3" > C.持平</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion1" name="thirdQuestion1" value="1" > D.下降</span>
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span>12. 客户总体评价</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="thirdQuestion2Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="thirdQuestion2" name="thirdQuestion2" value="5"> A.增长迅速 </span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion2" name="thirdQuestion2" value="4" > B.平稳增长</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion2" name="thirdQuestion2" value="1" > C.持平</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion2" name="thirdQuestion2" value="1" > D.下降</span>
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span>13. 当前月销售额和应收账款对比情况</span>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="thirdQuestion3Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="thirdQuestion3" name="thirdQuestion3" value="5"> A.X>=1 </span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion3" name="thirdQuestion3" value="4" > B.1>X>=0.5</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion3" name="thirdQuestion3" value="3" > C.0.5>X>=0.25</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion3" name="thirdQuestion3" value="1" > D.0.25>X</span>
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span>14. 主要客户付款及时性(客户A/B/C/D)</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="thirdQuestion4Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="thirdQuestion4" name="thirdQuestion4" value="5"> A.付款延迟7天以内</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion4" name="thirdQuestion4" value="4" > B.付款延迟15天以内</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion4" name="thirdQuestion4" value="3" > C.付款延迟30天以内</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion4" name="thirdQuestion4" value="1" > D.付款延迟30天以上</span>
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span>15. 当前公司流动资金情况</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="thirdQuestion5Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="thirdQuestion5" name="thirdQuestion5" value="5"> A.资金非常宽裕 </span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion5" name="thirdQuestion5" value="4" > B.资金良好</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion5" name="thirdQuestion5" value="3" > C.资金一般</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion5" name="thirdQuestion5" value="1" > D.资金紧张</span>
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span title="当前公司流动资金情况">16.当前公司主要的融资机构</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="thirdQuestion6Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="thirdQuestion6" name="thirdQuestion6" value="5"> A.银行</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion6" name="thirdQuestion6" value="4" > B.银行+小贷公司</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion6" name="thirdQuestion6" value="3" > C.小贷公司</span>
					<span style="margin-left: 100px"><input type="radio" id="thirdQuestion6" name="thirdQuestion6" value="1" > D.民间借贷/无融资记录</span>
				</div>
			</div>
		</div>
		<br>
		<br>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				四、管理水平
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>17. 公司是否有质检部门/人员，以及是否有的质检标准</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="fourthQuestion1Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="fourthQuestion1" name="fourthQuestion1" value="5"> A.有人员，有标准</span>
					<span style="margin-left: 100px"><input type="radio" id="fourthQuestion1" name="fourthQuestion1" value="4" > B.有人员，无标准</span>
					<span style="margin-left: 100px"><input type="radio" id="fourthQuestion1" name="fourthQuestion1" value="3" > C.无人员，有标准</span>
					<span style="margin-left: 100px"><input type="radio" id="fourthQuestion1" name="fourthQuestion1" value="1" > D.无人员，无标准</span>
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span>18. 公司产品退货情况怎么样(若有，主要是什么客户以及什么产品)</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="fourthQuestion2Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="fourthQuestion2" name="fourthQuestion2" value="5"> A.无退货，客户反馈良好</span>
					<span style="margin-left: 100px"><input type="radio" id="fourthQuestion2" name="fourthQuestion2" value="4" > B.偶尔有退货，情况很少</span>
					<span style="margin-left: 100px"><input type="radio" id="fourthQuestion2" name="fourthQuestion2" value="3" > C.退货相对频繁，时有发生</span>
					<span style="margin-left: 100px"><input type="radio" id="fourthQuestion2" name="fourthQuestion2" value="1" > D.退货情况严重</span>
				</div>
			</div>
		</div>
		<br>
		<br>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				五、HR
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>19. 员工流失情况(流失的员工主要的岗位)</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="fifthQuestion1Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="fifthQuestion1" name="fifthQuestion1" value="5"> A.员工很稳定，基本无流失情况</span>
					<span style="margin-left: 100px"><input type="radio" id="fifthQuestion1" name="fifthQuestion1" value="4" > B.流失率正常</span>
					<span style="margin-left: 100px"><input type="radio" id="fifthQuestion1" name="fifthQuestion1" value="3" > C.流失员工较多</span>
					<span style="margin-left: 100px"><input type="radio" id="fifthQuestion1" name="fifthQuestion1" value="1" > D.流失情况很严重</span>
				</div>
				<br><br>
				<div class="dis-in-b input-and-tip">
					<span>20.员工流失情况(流失的员工主要的岗位)</span>>&nbsp;&nbsp;得分:&nbsp;<span style="color: red;font-size: 13px;" id="fifthQuestion2Value"></span>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span style="margin-left: 20px "><input type="radio" id="fifthQuestion2" name="fifthQuestion2" value="5"> A.招聘进展顺利，完全满足需求</span>
					<span style="margin-left: 100px"><input type="radio" id="fifthQuestion2" name="fifthQuestion2" value="4" > B.招聘情况良好，基本满足需求</span>
					<span style="margin-left: 100px"><input type="radio" id="fifthQuestion2" name="fifthQuestion2" value="3" > C.进展相对缓慢</span>
					<span style="margin-left: 100px"><input type="radio" id="fifthQuestion2" name="fifthQuestion2" value="1" > D.招聘困难，人员缺口很大</span>
				</div>
			</div>
		</div>
		</form>
		<div class="box-wrap pos-relative bg-common" align="center">
			<button id="okBtn" class="button-wrap"><i18n:I18n key="i18n_js_close" defaultValue="关闭" /></button>
		</div>
		<br><br>
	</div>
	<script type="text/javascript">
		$("#okBtn").click(function(){
	        parent.elsDeskTop.closeCurWin('serviceQuestionnaireDetail');
		});
		
		$(document).ready(function(){
			var elsAcct = GetQueryString("elsAcct");
			var elsSubAcct = GetQueryString("elsSubAcct");
			var type = GetQueryString("type");
			var param = {"elsAccount":elsAcct,"elsSubAccount":elsSubAcct,"type":type};
			  $.ajax({
				url :"<%=basePath%>rest/QuestionnaireService/selectByPrimaryKey",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					init(data);
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});    
		});
		
		function init(obj){
			var firstQuestion1 = obj.firstQuestion1;
			var firstQuestion2 = obj.firstQuestion2;
			var firstQuestion3 = obj.firstQuestion3;
			var firstQuestion4 = obj.firstQuestion4;
			var firstQuestion5 = obj.firstQuestion5;
			var firstQuestion6 = obj.firstQuestion6;
			var firstQuestion7 = obj.firstQuestion7;
			var firstQuestion8 = obj.firstQuestion8;
			
			var secondQuestion1 = obj.secondQuestion1;
			var secondQuestion2 = obj.secondQuestion2;
			
			var thirdQuestion1 = obj.thirdQuestion1;
			var thirdQuestion2 = obj.thirdQuestion2;
			var thirdQuestion3 = obj.thirdQuestion3;
			var thirdQuestion4 = obj.thirdQuestion4;
			var thirdQuestion5 = obj.thirdQuestion5;
			var thirdQuestion6 = obj.thirdQuestion6;
			
			var fourthQuestion1 = obj.fourthQuestion1;
			var fourthQuestion2 = obj.fourthQuestion2;
			
			var fifthQuestion1 = obj.fifthQuestion1;
			var fifthQuestion2 = obj.fifthQuestion2;
			$("#firstQuestion1Value").text(firstQuestion1==null?"":firstQuestion1);
			$("#firstQuestion2Value").text(firstQuestion2==null?"":firstQuestion2);
			$("#firstQuestion3Value").text(firstQuestion3==null?"":firstQuestion3);
			$("#firstQuestion4Value").text(firstQuestion4==null?"":firstQuestion4);
			$("#firstQuestion5Value").text(firstQuestion5==null?"":firstQuestion5);
			$("#firstQuestion6Value").text(firstQuestion6==null?"":firstQuestion6);
			$("#firstQuestion7Value").text(firstQuestion7==null?"":firstQuestion7);
			$("#firstQuestion8Value").text(firstQuestion8==null?"":firstQuestion8);
			
			$("#secondQuestion1Value").text(secondQuestion1==null?"":secondQuestion1);
			$("#secondQuestion2Value").text(secondQuestion2==null?"":secondQuestion2);
			$("#fourthQuestion1Value").text(fourthQuestion1==null?"":fourthQuestion1);
			$("#fourthQuestion2Value").text(fourthQuestion2==null?"":fourthQuestion2);
			$("#fifthQuestion1Value").text(fifthQuestion1==null?"":fifthQuestion1);
			$("#fifthQuestion2Value").text(fifthQuestion2==null?"":fifthQuestion2);
			
			$("#thirdQuestion1Value").text(thirdQuestion1==null?"":thirdQuestion1);
			$("#thirdQuestion2Value").text(thirdQuestion2==null?"":thirdQuestion2);
			$("#thirdQuestion3Value").text(thirdQuestion3==null?"":thirdQuestion3);
			$("#thirdQuestion4Value").text(thirdQuestion4==null?"":thirdQuestion4);
			$("#thirdQuestion5Value").text(thirdQuestion5==null?"":thirdQuestion5);
			$("#thirdQuestion6Value").text(thirdQuestion6==null?"":thirdQuestion6);
			
			
			$("input[type=radio][name=firstQuestion1][value="+obj.firstQuestion1+"]").attr("checked",'checked');
			$("input[type=radio][name=firstQuestion2][value="+obj.firstQuestion2+"]").attr("checked",'checked');
			$("input[type=radio][name=firstQuestion3][value="+obj.firstQuestion3+"]").attr("checked",'checked');
			$("input[type=radio][name=firstQuestion4][value="+obj.firstQuestion4+"]").attr("checked",'checked');
			$("input[type=radio][name=firstQuestion5][value="+obj.firstQuestion5+"]").attr("checked",'checked');
			
			$("input[type=radio][name=firstQuestion6][value="+obj.firstQuestion6+"]").attr("checked",'checked');
			$("input[type=radio][name=firstQuestion7][value="+obj.firstQuestion7+"]").attr("checked",'checked');
			$("input[type=radio][name=firstQuestion8][value="+obj.firstQuestion8+"]").attr("checked",'checked');
			
		 	$("input[type=radio][name=secondQuestion1][value="+obj.secondQuestion1+"]").attr("checked",'checked');
			$("input[type=radio][name=secondQuestion2][value="+obj.secondQuestion2+"]").attr("checked",'checked');
			
			$("input[type=radio][name=thirdQuestion1][value="+obj.thirdQuestion1+"]").attr("checked",'checked');
			$("input[type=radio][name=thirdQuestion2][value="+obj.thirdQuestion2+"]").attr("checked",'checked');
			$("input[type=radio][name=thirdQuestion3][value="+obj.thirdQuestion3+"]").attr("checked",'checked');
			$("input[type=radio][name=thirdQuestion4][value="+obj.thirdQuestion4+"]").attr("checked",'checked');
			$("input[type=radio][name=thirdQuestion5][value="+obj.thirdQuestion5+"]").attr("checked",'checked');
			$("input[type=radio][name=thirdQuestion6][value="+obj.thirdQuestion6+"]").attr("checked",'checked');
			
			$("input[type=radio][name=fourthQuestion1][value="+obj.fourthQuestion1+"]").attr("checked",'checked');
			$("input[type=radio][name=fourthQuestion2][value="+obj.fourthQuestion2+"]").attr("checked",'checked');
			$("input[type=radio][name=fifthQuestion1][value="+obj.fifthQuestion1+"]").attr("checked",'checked');
			$("input[type=radio][name=fifthQuestion2][value="+obj.fifthQuestion2+"]").attr("checked",'checked');
		};
		
	</script>
</body>
</html>