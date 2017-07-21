<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="elsHeader.jsp"%>
<body vlink='#333333' link='#333333'>
	<style type='text/css'>
A {
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

BODY {
	font-family: Verdana;
	font-size: 12px;
	margin: 0;
	color: #000000;
	background: #ffffff;
}

TD {
	border-right: 1px;
	border-top: 0px;
	font-size: 9pt;
	color: #000000;
}

.index_font {
	color: #3A4F6C;
	background-color: #EBEBEB;
	font-weight: bold;
	padding: 5px;
}
</style>
	<style>
.proccess {
	background: #ffffff;
	border-bottom: 1px solid;
	border-left: 1px solid;
	border-right: 1px solid;
	border-top: 1px solid;
	height: 8px;
	margin: 3px;
	width: 8px;
}
</style>
	<div class="pos-relative public-wrap">
		<!--         <div class="box-wrap pos-relative bg-common"> -->
		<!--             <div class="common-box-line"> -->
		<!--                <form id="accoutForm"> -->
		<!--                 <input type="hidden" id="elsAccount" name="elsAccount"> -->
		<!--                 <input type="hidden" id="pageSize" name="pageSize" value="10"> -->
		<!-- 		        <input type="hidden" id="currentPage" name="currentPage" value="1">  -->
		<!--                 </form> -->
		<!--             </div> -->
		<!--         </div> -->
		<!--         <div class="box-wrap pos-relative bg-common"> -->
		<!--         </div> -->
		<!--         <div class="box-wrap pos-relative bg-common"> -->
		<!--         </div> -->
		<br>
		<table width='100%' border='0' cellspacing='0' cellpadding='0'
			height='90%' align='center'>
			<tr align='center' valign='middle'>
				<td>
					<table border='0' cellspacing='1' cellpadding='10'
						bgcolor='#666666' width='600'>
						<tr>
							<td class='index_font' align='center' bgcolor="#9999cc">
								<p>
									<meta content="Microsoft FrontPage 4.0" name="GENERATOR">
	</div>
<div align="center">
								<table align="center" height="70%" valign="middle">
									<tbody>
										<tr>
											<td align="middle">
												<!--  Displaytext--> 登陆成功！！ <font class="fontbig">页面跳转中.....
													<!--End Displaytext-->
													<div align="center">
														<form method="post" name="proccess">
															<script language="javascript">  
                                                                for (i = 0; i < 30; i++) document.write("<input class=proccess>")  
                                                            </script>
														</form>
													</div>
											</font>
											</td>
										</tr>
									</tbody>
								</table>
								<div align="center">
									<script language="JavaScript">  
                                            var p = 0, j = 0;  
                                            var c = new Array("lightskyblue", "white")  
                                            setInterval('proccess();', 100)  
                                            function proccess() {  
                                                document.forms.proccess.elements[p].style.background = c[j];  
                                                p += 1;  
                                                if (p == 30) { p = 0; j = 1 - j; }   
                                            }  
                                            </script>
        									</script>
        									</div>
							</div>
							</div> <a href='default.jsp' class='index_font'>如果您的浏览器没有自动跳转,请点击这里</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<script>	

var accountGrid;
var elsAccount='<%=session.getAttribute("elsAccount")%>';

$().ready(function(){
	debugger;
	var code = window.location.href.split("=")[1];
    var param = {"elsAccount":elsAccount,"purchaseEnquiryNumber":code};
     $.ajax({
			url :"<%=basePath%>rest/AlibabaWebService/invokeUpdateCode",
			type :"POST",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				debugger;
				parent.elsDeskTop.tip.init({type: 'alert',displayType:1,message:'<i18n:I18n defaultValue="删除成功" key="i18n_common_alert_deletesuccess"></i18n:I18n>'});
				queryAccountInfo();   
			},
			error : function(data) {
				debugger;
				parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n defaultValue="请求出错" key="i18n_common_alert_requestfail"></i18n:I18n>'});
			}
		});
	init();
});	

//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererTime(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
	return val;
}

//日期格式渲染 yyyy-MM-dd
function rendererDate(val){
	if (!val) {val = "";}
	if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
	return val;
}

function rendererStation(val){
	if (!val) {val = "";}
	if (val == "sale"){
		val =  '<i18n:I18n defaultValue="销售岗位" key="i18n_account_select_stationtype_sell"></i18n:I18n>';
	}else {
	    val =  '<i18n:I18n defaultValue="采购岗位" key="i18n_account_select_stationtype_purchase"></i18n:I18n>';
	}
	return val;
}

function rendererAccountStutas(val){
	if (val == "N"){
		val =  '<font color="green"><i18n:I18n defaultValue="正常" key="i18n_account_select_accountStatus_normal"/></font>';
	}else if(val == "Y"){
	    val =  '<font color="red"><i18n:I18n defaultValue="已冻结" key="i18n_account_select_accountStatus_frozen"/></font>';
	}else{
		val = "";
	}
	return val;
}

function init(){
	
	$("#elsAccount").val(elsAccount);//设置当前登录账号
	
	var frm = $("#accoutForm");
	 //初始化控件
    $('button').button();
    var code = window.location.href.split("=")[1];
    var param = {"elsAccount":code,"purchaseEnquiryNumber":code};
     $.ajax({
			url :"<%=basePath%>rest/AlibabaWebService/invokeUpdateCode",
			type :"POST",
			contentType : "application/json",
			data : JSON.stringify(param),
			dataType : "json",
			success : function(data) {
				debugger;
				parent.elsDeskTop.tip.init({type: 'alert',displayType:1,message:'<i18n:I18n defaultValue="删除成功" key="i18n_common_alert_deletesuccess"></i18n:I18n>'});
				queryAccountInfo();   
			},
			error : function(data) {
				debugger;
				parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n defaultValue="请求出错" key="i18n_common_alert_requestfail"></i18n:I18n>'});
			}
		});
			debugger;
			setTimeout("location.href='default.jsp';", 3000);
		}
	</script>
</body>
</html>
