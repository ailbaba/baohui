<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button id="loginBtn" class="button-wrap" ><i18n:I18n key="" defaultValue="登录" /></button>
				<button id="resetBtn" class="button-wrap"><i18n:I18n key="" defaultValue="重置" /></button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></span>
			<div class="common-box-line">
				<div class="common-box-line">
					<div class="input-and-tip">
						<span>采购方ELS帐号：</span>
						<input id="elsAccount" name="elsAccount" type="text"/>
					</div>
					<div class="input-and-tip">
						<span>销售方ELS帐号：</span>
						<input id="toElsAccount" name="toElsAccount" type="text"/>
					</div>
					<div class="input-and-tip" >
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span>ELS子帐号：</span>
						 <select id="elsSubAccount" name="elsSubAccount" style="width: 165px; max-width: 165px;" disabled="disabled">
					     </select>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<script>
debugger;
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
	//重置
	$("#resetBtn").click(function() {
		$("#elsAccount").val(elsAccount);
		$("#toElsAccount").val('');
		$("#elsSubAccount").val('');
	});

	//登录
	$("#loginBtn").click(function() {
		$("#elsSubAccount").removeAttr("disabled");
        var elsAccount=$("#elsAccount").val();
		var toElsAccount=$("#toElsAccount").val();
		var elsSubAccount=$("#elsSubAccount").val();
		
		if(elsAccount==null||elsAccount.length<=0){
			alert("采购方ELS帐号,不能为空!",2);
			return;
		}
		if(toElsAccount==null||toElsAccount.length<=0){
			alert("销售方ELS帐号,不能为空!",2);
			return;
		}
		if(elsSubAccount==null||elsSubAccount.length<=0){
			alert("ELS子帐号,不能为空!",2);
			return;
		}
		debugger;
		// 查询代报设置
		$.ajax({
			url: '<%=basePath%>rest/PurchaseEnquiryReplaceService/queryPurchaseEnquiryReplaceSetByCondtion',
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"elsAccount":elsAccount,"toElsAccount":toElsAccount,"elsSubAccount":elsSubAccount}),
			success : function(data) {
				debugger;
				if(data && data.rows && data.rows.length) {
					showEnquiryWindow();
				}else{
					alert("该供应商没有配置代报人",2);
				}
			},
			error: function (xhr, type, exception) {
				return;
            	alert(xhr.responseText, "Failed"); 
        	}
		});
	});
	function showEnquiryWindow(){
     	//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
       	debugger;
       	var test = [];
       	var toElsAccount =$("#toElsAccount").val();
       	test["elsAccount"]=toElsAccount;
       	test["toElsAccount"]=elsAccount;
       	test["elsSubAccount"]=elsSubAccount;
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/icon9.png',
	        'windowsId':'PurchaseEnquiryDetail',
	        'windowTitle':'代报价管理',
	        'iframSrc':'<%=basePath%>enquirymanage/purchase/purchaseReplaceManage.jsp',
	        showAdv: true,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop",
	        data:test
	    });
	}
	//初始化
	$('#elsAccount').val(elsAccount);
	$('#elsAccount').attr("readonly",true);
	$('#elsSubAccount').val(elsSubAccount);
	findToElsAccount(elsAccount,elsSubAccount);
	$('#elsSubAccount').attr("readonly",true);
	
	//加载els子帐号
	$('#elsAccount').keyup( function() {
		debugger;
		var elsAccount = $('#elsAccount').val();
		findToElsAccount(elsAccount,null);
	});
	
	//查询子帐号
	function findToElsAccount(elsAccount,elsSubAccount){
		$('#elsSubAccount').empty();
		 $.ajax({
				url :"<%=basePath%>rest/AccountService/subAccountList",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount}),
				success : function(data) {
					var option ="";
					if(data && data.rows && data.rows.length) {
						debugger;
						for(var i=0; i<=data.rows.length-1;i++) {
							if(data.rows[i].elsSubAccount == elsSubAccount)
								option += '<option value='+ data.rows[i].elsSubAccount+"_"+data.rows[i].name+' selected>'+data.rows[i].elsSubAccount+"_"+data.rows[i].name+'</option>';
							else
							    option += '<option value='+ data.rows[i].elsSubAccount+"_"+data.rows[i].name+'>'+data.rows[i].elsSubAccount+"_"+data.rows[i].name+'</option>';
						}
					}
					$('#elsSubAccount').append(option);
				},
				error: function (xhr, type, exception) {
	            	alert(xhr.responseText, "Failed"); 
	        	}
			});
	}
		
		</script>
</body>
</html>