<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="importDepositBank" class="button-wrap">导入开户行</button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="importEnterpriseInfo" class="button-wrap" >导入企业信息</button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="importSubAccount" class="button-wrap">导入账号信息</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="importSupplierRelation" class="button-wrap">导入供应商ERP关联信息</button>
                </div>
  				<div class="dis-in-b input-and-tip">
                     <button id="importSubAccountBusinessPartner" class="button-wrap">导入子账号的合作伙伴清单</button>
                </div>
            </div>
        </div>
</div>

<script>	


//导入开户行信息
$("#importDepositBank").click(function(){
	$('.fixed-dialog').show();
	//将选择行的信息填充到对应的窗口下 .

	
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'changePassword',
        'windowTitle':'导入开户行',
        'iframSrc':'<%=basePath%>batchimport/batchImportDepositBank.jsp',
        showAdv: false,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });

});


//导入企业信息
$("#importEnterpriseInfo").click(function(){
	$('.fixed-dialog').show();
	//将选择行的信息填充到对应的窗口下 .

	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'changePassword',
        'windowTitle':'导入企业信息',
        'iframSrc':'<%=basePath%>batchimport/batchImportEnterpriseInfo.jsp',
        showAdv: false,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });

});


//导入账号信息
$("#importSubAccount").click(function(){
	$('.fixed-dialog').show();
	//将选择行的信息填充到对应的窗口下 .

	
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'changePassword',
        'windowTitle':'导入账号信息',
        'iframSrc':'<%=basePath%>batchimport/batchImportSubAccountInfo.jsp',
        showAdv: false,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });

});


//导入供应商ERP关联信息
$("#importSupplierRelation").click(function(){
	$('.fixed-dialog').show();
	//将选择行的信息填充到对应的窗口下 .

	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'changePassword',
        'windowTitle':'导入供应商ERP关联信息',
        'iframSrc':'<%=basePath%>batchimport/batchImportSupplierRelation.jsp',
        showAdv: false,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });

});

//导入子账号合作伙伴清单
$("#importSubAccountBusinessPartner").click(function(){
	$('.fixed-dialog').show();
	//将选择行的信息填充到对应的窗口下 .

	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'changePassword',
        'windowTitle':'导入子账号的合作伙伴清单',
        'iframSrc':'<%=basePath%>batchimport/batchImportSubAccountBusinessPartner.jsp',
        showAdv: false,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });

});

</script>
</body>
</html>
