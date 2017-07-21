<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@taglib prefix="base" uri="/WEB-INF/tld/web-base.tld"%>
<%@taglib prefix="i18n" uri="/WEB-INF/tld/i18n.tld"%>
<%@page import="com.els.common.SysProperties"%>
<%@page import="java.util.Properties"%>
	
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String WsBasePath = "ws://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String version = "0.2.4";
%>
<body>

<link
	href="<%=basePath%>extend/jquery-ui/themes/base/jquery.ui.all.css?version=<%=version%>"
	rel="stylesheet" />
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/css/normalize.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/src/mmGrid.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/src/mmPaginator.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/bootstrap/css/bootstrap.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/src/theme/bootstrap/mmGrid-bootstrap.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/mmGrid/src/theme/bootstrap/mmPaginator-bootstrap.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/public.css?version=<%=version%>">
<link rel="stylesheet" href="<%=basePath%>extend/multiselect/sumoselect.css?version=<%=version%>">
<script type="text/javascript"
	src="<%=basePath%>lib/js/jquery/jquery-1.8.2.min.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>lib/js/jquery/jquery.nicescroll.min.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.core.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.widget.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.button.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.tabs.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.position.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.tooltip.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.mouse.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.draggable.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/jquery-ui/jquery.ui.droppable.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>extend/multiselect/jquery.sumoselect.min.js?version=<%=version%>"></script>
<!-- <script type="text/javascript" -->
<script language="javascript" type="text/javascript" src="<%=basePath%>extend/wdatepicker/WdatePicker.js?version=<%=version%>"></script>
<!--[if lt IE 9]>
    <script src="<%=basePath%>extend/mmGrid/js/vendor/html5shiv.js?version=<%=version%>"></script>
    <script src="<%=basePath%>extend/mmGrid/js/vendor/css3-mediaqueries.js?version=<%=version%>"></script>
    <![endif]-->
<script src="<%=basePath%>extend/mmGrid/js/vendor/modernizr-2.6.2.min.js?version=<%=version%>"></script>
<script src="<%=basePath%>extend/mmGrid/js/plugins.js?version=<%=version%>"></script>
<script src="<%=basePath%>extend/mmGrid/js/vendor/json2.js?version=<%=version%>"></script>
<script src="<%=basePath%>extend/mmGrid/src/mmGrid.js?version=<%=version%>"></script>
<script src="<%=basePath%>extend/mmGrid/src/mmPaginator.js?version=<%=version%>"></script>
<script type="text/javascript"
	src="<%=basePath%>js/jquery.serializejson.js?version=<%=version%>"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js?version=<%=version%>"></script>
<script type="text/javascript" src="<%=basePath%>js/tableColumn.js?version=<%=version%>"></script>

	<%-- <link href="extend/jquery-ui/themes/base/jquery.ui.all.css?version=<%=version%>" rel="stylesheet" />
	
	<link href="extend/public.css?version=<%=version%>" rel="stylesheet" />
	
	<script type="text/javascript"
		src="lib/js/jquery/jquery-1.8.2.min.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="lib/js/jquery/jquery.nicescroll.min.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="extend/jquery-ui/jquery.ui.core.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="extend/jquery-ui/jquery.ui.widget.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="extend/jquery-ui/jquery.ui.button.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="extend/jquery-ui/jquery.ui.tabs.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="extend/jquery-ui/jquery.ui.position.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="extend/jquery-ui/jquery.ui.tooltip.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="extend/jquery-ui/jquery.ui.draggable.js?version=<%=version%>"></script>
	
	<script type="text/javascript"
		src="js/jquery.serializejson.js?version=<%=version%>"></script>
	<script type="text/javascript"
		src="js/common.js?version=<%=version%>"></script>
	
	<script type="text/javascript"
		src="js/json2.js?version=<%=version%>"></script>
	
	<link rel="stylesheet" type="text/css" href="css/jscrollpane1.css" />
	<script type="text/javascript" src="xheditor/xheditor-1.2.1.min.js"></script> --%>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"></span>
			<div class="common-box-line" >  
			<div align="center">
				<font style="font-size: 18px" >供应链竞争力调查问卷</font>
			</div>
			<br>
			<div class="dis-in-b input-and-tip">
				尊敬的客户，欢迎您参加本次问卷调查，您的意见将帮助我们更好了解供应链的现状并提升供应链竞争力。
			</div>
			</div>
		</div>
		<form id="questionnaireForm">
		<input type="hidden" id="elsAccount" name="elsAccount" >
		<input type="hidden" id="elsSubAccount" name="elsSubAccount" >
		<input type="hidden" id="userName" name="userName">
		<input type="hidden" id="companyName" name="companyName">
		<input type="hidden" id="telphone" name="telphone">
		<input type="hidden" id="key" name="key">
		<input type="hidden" id="type" name="type" value="1">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				一、供应链敏捷性与密切度
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>1. </span>
					相同类型的产品，上ELS后的周期和未上ELS的周期对比(缩短天数)
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
					<span>2. </span>
					同一客户产品，上ELS之前和之后的周期对比(缩短天数)
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
					<span>3. </span>
					相同类型的产品，上ELS后的和未上ELS的沟通效率对比
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
					<span>4. </span>
					同一客户产品，上ELS之前和之后的沟通效率对比
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
					<span>5. </span>
					上ELS之前与客户有无全销售流程数据记录
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
					<span>6. </span>
					交货期相比于之前是否有缩短(之前交货期，使用后交货期)
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
					<span>7. </span>
					与上线客户客户合作时间
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
					<span>8. </span>
					上线客户占总销售额比重
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
					<span>9. </span>
					准时交货订单数所占比例
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
					<span>10. </span>
					客户总体评价
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
					<span>11. </span>
					客户总体评价
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
					<span>12. </span>
					客户总体评价
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
					<span>13. </span>
					当前月销售额和应收账款对比情况
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
					<span>14. </span>
					主要客户付款及时性(客户A/B/C/D)
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
					<span title="当前公司流动资金情况">15.当前公司流动资金情况</span>
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
					<span title="当前公司流动资金情况">16.当前公司主要的融资机构</span>
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
					<span>17. </span>
					公司是否有质检部门/人员，以及是否有的质检标准
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
					<span>18. </span>
					公司产品退货情况怎么样(若有，主要是什么客户以及什么产品)
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
					<span>19. </span>
					员工流失情况(流失的员工主要的岗位)
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
					<span>20. </span>
					员工流失情况(流失的员工主要的岗位)
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
			<button id="okBtn" class="button-wrap">提交</button>
		</div>
		<br><br>
	</div>
	<script type="text/javascript">
		var acct =GetQueryString("acct");
	    var subAcct =GetQueryString("subAcct");
	    var name =GetQueryString("name");
	    var cpyName =GetQueryString("cpyName");
	    var tel =GetQueryString("tel");
	    var key =GetQueryString("key");
	 	$("#okBtn").click(function(){
			 if(!isVerify()){
				 return false;
			 }
			  var doServer = "insertSelective";
			  if(key!=null&&key!=""){
				  doServer = "csinsertSelective";
			  }else {
				  var elsAccount = <%=session.getAttribute("elsAccount")%>;
			      var elsSubAccount = <%=session.getAttribute("elsSubAccount")%>;
			      if(elsAccount==null||elsAccount==""||elsSubAccount==null||elsSubAccount==""){
			    	  alert("非法请求!");
			    	  return;
			      } 
			  }
		 	  var frm = $("#questionnaireForm");
			   $.ajax({
					url :"<%=basePath%>rest/QuestionnaireService/"+doServer,
					type :"POST",
					contentType : "application/json",
					data : JSON.stringify(frm.serializeJSON()),
					dataType : "json",
					success : function(data) {
						if(data.statusCode==-100){
							alert(data.message,3);
						}else {
							alert('操作成功');
						}
						setTimeout(function(){				     
							closeWin();
							parent.elsDeskTop.closeCurWin("clientQuestionnaire");
						 }, "1000"); 
					},
					error : function(data) {
						alert('请求出错',3);
					}
				});     
		});
		
		function isVerify(){
			var firstQuestion1=$('input:radio[name="firstQuestion1"]:checked').val();
			var firstQuestion2=$('input:radio[name="firstQuestion2"]:checked').val();
			var firstQuestion3=$('input:radio[name="firstQuestion3"]:checked').val();
			var firstQuestion4=$('input:radio[name="firstQuestion4"]:checked').val();
			var firstQuestion5=$('input:radio[name="firstQuestion5"]:checked').val();
			var firstQuestion6=$('input:radio[name="firstQuestion6"]:checked').val();
			var firstQuestion7=$('input:radio[name="firstQuestion7"]:checked').val();
			var firstQuestion8=$('input:radio[name="firstQuestion8"]:checked').val();
			
			var secondQuestion1=$('input:radio[name="secondQuestion1"]:checked').val();
			var secondQuestion2=$('input:radio[name="secondQuestion2"]:checked').val();
			
			var thirdQuestion1=$('input:radio[name="thirdQuestion1"]:checked').val();
			var thirdQuestion2=$('input:radio[name="thirdQuestion2"]:checked').val();
			var thirdQuestion3=$('input:radio[name="thirdQuestion3"]:checked').val();
			var thirdQuestion4=$('input:radio[name="thirdQuestion4"]:checked').val();
			var thirdQuestion5=$('input:radio[name="thirdQuestion5"]:checked').val();
			var thirdQuestion6=$('input:radio[name="thirdQuestion6"]:checked').val();
			
			var fourthQuestion1=$('input:radio[name="fourthQuestion1"]:checked').val();
			var fourthQuestion2=$('input:radio[name="fourthQuestion2"]:checked').val();
			
			var fifthQuestion1=$('input:radio[name="fifthQuestion1"]:checked').val();
			var fifthQuestion2=$('input:radio[name="fifthQuestion2"]:checked').val();
			 if(firstQuestion1==null){
				 alert("请选择相同类型的产品，上ELS后的周期和未上ELS的周期对比(缩短天数)");
				 $("#firstQuestion1").focus();
				 return false;
			 }
			 if(firstQuestion2==null){
				 alert("请选择同一客户产品，上ELS之前和之后的周期对比(缩短天数)");
				 $("#firstQuestion2").focus();
				 return false;
			 }
			 if(firstQuestion3==null){
				 alert("请选择相同类型的产品，上ELS后的和未上ELS的沟通效率对比");
				 $("#firstQuestion3").focus();
				 return false;
			 }
			 if(firstQuestion4==null){
				 alert("请选择同一客户产品，上ELS之前和之后的沟通效率对比");
				 $("#firstQuestion4").focus();
				 return false;
			 }
			 if(firstQuestion5==null){
				 alert("请选择上ELS之前与客户有无全销售流程数据记录");
				 $("#firstQuestion5").focus();
				 return false;
			 }
			 if(firstQuestion6==null){
				 alert("请选择交货期相比于之前是否有缩短(之前交货期，使用后交货期)");
				 $("#firstQuestion6").focus();
				 return false;
			 }
			 if(firstQuestion7==null){
				 alert("请选择与上线客户客户合作时间");
				 $("#firstQuestion7").focus();
				 return false;
			 }
			 if(firstQuestion8==null){
				 alert("请选择上线客户占总销售额比重");
				 $("#firstQuestion8").focus();
				 return false;
			 }
			 if(secondQuestion1==null){
				 alert("请选择准时交货订单数所占比例");
				 $("#secondQuestion1").focus();
				 return false;
			 }
			 if(secondQuestion2==null){
				 alert("请选择客户总体评价");
				 $("#secondQuestion2").focus();
				 return false;
			 }
			 
			 if(thirdQuestion1==null){
				 alert("请选择最近一年销售额增长情况/订单量是否有增加");
				 $("#thirdQuestion1").focus();
				 return false;
			 }
			 if(thirdQuestion2==null){
				 alert("请选择当前企业应收账款平均账期(主要客户A/B/C/D的账期，开发票到付款的时间)");
				 $("#thirdQuestion2").focus();
				 return false;
			 }
			 if(thirdQuestion3==null){
				 alert("请选择当前月销售额和应收账款对比情况");
				 $("#thirdQuestion3").focus();
				 return false;
			 }
			 if(thirdQuestion4==null){
				 alert("请选择主要客户付款及时性(客户A/B/C/D)");
				 $("#thirdQuestion4").focus();
				 return false;
			 }
			 if(thirdQuestion5==null){
				 alert("请选择当前公司流动资金情况");
				 $("#thirdQuestion5").focus();
				 return false;
			 }
			 if(thirdQuestion6==null){
				 alert("请选择当前公司主要的融资机构");
				 $("#thirdQuestion6").focus();
				 return false;
			 }
			 
			 if(fourthQuestion1==null){
				 alert("请选择公司是否有质检部门/人员，以及是否有的质检标准");
				 $("#fourthQuestion1").focus();
				 return false;
			 }
			 if(fourthQuestion2==null){
				 alert("请选择公司产品退货情况怎么样(若有，主要是什么客户以及什么产品)");
				 $("#fourthQuestion2").focus();
				 return false;
			 }
			 
			 if(fifthQuestion1==null){
				 alert("请选择员工流失情况(流失的员工主要的岗位)");
				 $("#fifthQuestion1").focus();
				 return false;
			 }
			 if(fifthQuestion2==null){
				 alert("请选择公司招聘情况怎么样(主要需求的岗位)");
				 $("#fifthQuestion2").focus();
				 return false;
			 }
			return true;
		};
		
		$(document).ready(function(){
			 $('#okBtn').button();
		  	  var doServer = "selectByPrimaryKey";
			  if(isCS()){
				  doServer = "csselectByPrimaryKey";
			  }else {
				  var elsAccount = <%=session.getAttribute("elsAccount")%>;
			      var elsSubAccount = <%=session.getAttribute("elsSubAccount")%>;
			      if(elsAccount==null||elsAccount==""||elsSubAccount==null||elsSubAccount==""){
			    	  alert("非法请求!");
			    	  return;
			      }
			  }
			  var frm = $("#questionnaireForm");
			  $.ajax({
					url :"<%=basePath%>rest/QuestionnaireService/"+doServer,
					type :"POST",
					contentType : "application/json",
					data : JSON.stringify(frm.serializeJSON()),
					dataType : "json",
					success : function(data) {
						init(data);
					},
					error : function(data) {
						alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					}
				});    
			
		});
		
		function isCS(){
		    if(acct!=null&acct!=""&&subAcct!=null&&subAcct!=""){
				$("#elsAccount").val(acct);
				$("#elsSubAccount").val(subAcct);
				$("#userName").val(name);
				$("#companyName").val(cpyName);
				$("#telphone").val(tel);
				$("#key").val(key);
				return true;
		    }else {
		    	var elsAccount = <%=session.getAttribute("elsAccount")%>;
		    	var elsSubAccount = <%=session.getAttribute("elsSubAccount")%>;
				$("#elsAccount").val(elsAccount);
				$("#elsSubAccount").val(elsSubAccount);
				return false;
		    }
		    
		}
		
		function init(obj){
			$("#type").val(obj.type);
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