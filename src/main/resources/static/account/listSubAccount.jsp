<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../sessionCheck.jsp"%>
<%@taglib prefix="base" uri="/WEB-INF/tld/web-base.tld"%>
<html>
<head>
	<base:supplierAuth elsAccount="${elsAccount }" authCode="chat" toElsAccount="${param['toElsAccount'] }"></base:supplierAuth>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>ELS互联网企业解决方案</title>
	<link rel="icon" href="images/logo.ico">
	<link rel="shortcut icon" href="images/logo.ico"/>
	<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../easyui/demo.css">
	<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="../js/jquery.serializejson.js" type="text/javascript"></script>
	<script src="../js/json2.js" type="text/javascript"></script>
	<script src="../js/common.js" type="text/javascript"></script>
	<script src="../js/popwin.js" type="text/javascript"></script>
	<script type="text/javascript">

		var elsAccount = '<%=session.getAttribute("elsAccount") %>',
				elsSubAccount = '<%=session.getAttribute("elsSubAccount") %>',
				toElsAccount = GetQueryString("toElsAccount"),
				role = '<%=session.getAttribute("role") %>',
				toElsSubAccount,toElsSubAccountName,selectDom;

		$(function () {
			selectDom = $("#elsSubAccount");
			$.ajax({
				url: "../rest/AccountService/findMyFriendSubAccountList/" + elsAccount + "/" + elsSubAccount + "/" + role + "/" + toElsAccount + "?t=" + new Date().getTime(),
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function (data) {
					$("#elsSubAccount").html(definedDom((data || []).map(function (d) {
						return {
							tag: 'option',
							text: d.elsSubAccount + '_' + d.name,
							value: d.elsSubAccount
						}
					})))
				},
				error: function () {
					showMsg("请求出错");
				}
			});
		});
		function ok() {
			var pageData = getIframeData() || {};
			 toElsSubAccount =selectDom.val();
			if(!toElsSubAccount)return;
			 toElsSubAccountName = selectDom.find("option:selected").text();
			var title = "与  " + pageData.friendName + " 聊天中...";
			var url = "chat2.jsp?fromElsAccount="
					+ elsAccount
					+ "&fromElsSubAccount="
					+ elsSubAccount
					+ "&toElsAccount="
					+ toElsAccount
					+ "&toElsSubAccount="
					+ toElsSubAccount
					+ "&t=" + new Date().getTime();

			parent.elsDeskTop.defineWin($.extend({}, pageData, {
				'windowCls': 'ui-themeA',
				'windowsId': 'chatWin' + toElsAccount + toElsSubAccount,
				'windowTitle': title,
				'windowSubTitle': toElsSubAccountName,
				'windowMinWidth': 500,
				'windowMinHeight': 600,
				'windowPositionTop': 'top',
				'windowPositionLeft': 'center',
				'iframSrc': url,
				'parentPanel': '.currDesktop',
				'showAdv': true,
				'windowWidth': 520,
				'windowHeight': 590,
			}));
			parent.elsDeskTop.closeCurWin("selectSubaccount" + toElsAccount);
		}
	</script>
<body>
	对方子账号：
	<select id="elsSubAccount" name="elsSubAccount"></select>
	&nbsp;<input type="button" onclick="ok();" value="确定"/>
</body>
</html>