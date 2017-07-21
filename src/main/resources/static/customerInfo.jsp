<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="elsHeader.jsp"%>

<body>

<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="accoutForm">
                <!-- <input type="hidden" id="elsAccount" name="elsAccount"> -->
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"/>：</span><input id="elsAccount" name="elsAccount" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="公司名称" key="i18n_common_lable_companyname"/>：</span>
			       <!-- <input id="shortName" name="shortName" type="text" style="width:200px;"/> -->
			      <!--  <input type="text" x-webkit-speech x-webkit-grammar="builtin:translate" /> -->
			      <input id="shortName" name="shortName" type="text" style="width:200px;" x-webkit-speech x-webkit-grammar="builtin:translate" onwebkitspeechchange="speechChange(this.value)" />
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="行业" key="i18n_account_title_industry"/>：</span>
			       <select class=""  id="industry" name="industry">
							<option value="">ALL_<i18n:I18n defaultValue="行业" key="i18n_account_title_industry"/></option>
					</select>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="行业细类" key="i18n_account_title_industrySubdivision"/>：</span>
			       <select class="" id="industryDetail" name="industryDetail">
							<option value="">ALL_<i18n:I18n defaultValue="行业细类" key="i18n_account_title_industrySubdivision"/></option>
					</select>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="国家" key="i18n_account_title_country"/>：</span>
			       <select class="" id="countryCode" name="countryCode">
							<option value="">ALL_<i18n:I18n defaultValue="国家" key="i18n_account_title_country"/></option>
					</select>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="省份" key="i18n_account_title_province"/>：</span>
			       <select class="" id="province" name="province">
							<option value="">ALL_<i18n:I18n defaultValue="省份" key="i18n_account_title_province"/></option>
					</select>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="城市" key="i18n_account_title_city"/>：</span>
			       <select class="" id="city" name="city">
							<option value="">ALL_<i18n:I18n defaultValue="城市" key="i18n_account_title_city"/></option>
					</select>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryAccountInfo" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="addAccount" class="button-wrap" ><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="checkAccountInfo" class="button-wrap"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-account"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>

<script>



var accountGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';

$().ready(function(){
	init();
});	

var accountCols = [
                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:80, align:'center'},
                   { title:'<i18n:I18n defaultValue="公司性质" key="i18n_account_title_companyNature"/>', name:'nature' , width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="公司全称" key="i18n_account_title_companyFullName"/>', name:'fullName' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="公司简称" key="i18n_account_title_companyAbbreviation"/>', name:'shortName' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="行业" key="i18n_account_title_industry"/>', name:'industry' ,width:140, align:'center'},
                   { title:'<i18n:I18n defaultValue="行业细类" key="i18n_account_title_industrySubdivision"/>', name:'industryDetail' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="国家" key="i18n_account_title_country"/>', name:'countryCode' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="省份" key="i18n_account_title_province"/>', name:'province' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="城市" key="i18n_account_title_city"/>', name:'city' ,width:100, align:'center'},
                   { title:'<i18n:I18n defaultValue="街道" key="i18n_account_title_street"/>', name:'address' ,width:120, align:'center'}
            ];

function init(){
	
	var frm = $("#accoutForm");
	 //初始化控件
   $('button').button();

	
	$.ajax({
		url : "rest/BaseInfoService/findAllIndustry",
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			var industry = $("#industry");
			industry.empty();
			
			industry.append($("<option>").text('ALL_<i18n:I18n defaultValue="行业" key="i18n_account_title_industry"/>').val(''));
			
			for (var i = 0; i < data.length; i++) {
				var option = $("<option>").text(data[i].mc).val(data[i].aj);
				
				industry.append(option);
			}
			
		},
		error :  function(data) {
			
		}
	});
	
	
	function showIndustry(industry) {
		$.ajax({
			url : "rest/BaseInfoService/industrys/" + industry,
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var industryDetail = $("#industryDetail");
				industryDetail.empty();
				industryDetail.append($("<option>").text('ALL_<i18n:I18n defaultValue="业" key="i18n_account_title_industrySubdivision"/>').val(''));
				for (var i = 0; i < data.length; i++) {
					var option = $("<option>").text(data[i].mc).val(data[i].mc)
					industryDetail.append(option);
				}
			},
			error : errorResponse
		});
	}
	$("#industry").change(function(e) {
		showIndustry($(this).val());
	});
	

	$.ajax({
		url : "rest/BaseInfoService/findAllCountry",
		type : "GET",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			var countryCode = $("#countryCode");
			countryCode.empty();
			
			countryCode.append($("<option>").text('ALL_<i18n:I18n defaultValue="国家" key="i18n_account_title_country"/>').val(''));
			
			for (var i = 0; i < data.length; i++) {

				var option = $("<option>").text(data[i].mc).val(data[i].gj)

				countryCode.append(option);
			}
			
		},
		error : errorResponse
	});

	function showProvince(country) {
		$.ajax({
			url : "rest/BaseInfoService/provices/" + country,
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var province = $("#province");
				province.empty();
				province.append($("<option>").text('ALL_<i18n:I18n defaultValue="省" key="i18n_account_title_province"/>').val(''));
				for (var i = 0; i < data.length; i++) {
					var option = $("<option>").text(data[i].mc).val(data[i].aj)
					province.append(option);
				}
				
			},
			error : errorResponse
		});
	}
	

	$("#countryCode").change(function(e) {
		showProvince($(this).val());
	});

	function showCity(province) {
		$.ajax({
			url : "rest/BaseInfoService/citys/" + province,
			type : "GET",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var city = $("#city");
				city.empty();
				city.append($("<option>").text('ALL_<i18n:I18n defaultValue="城市" key="i18n_account_title_city"/>').val(''));
				for (var i = 0; i < data.length; i++) {
					var option = $("<option>").text(data[i].mc).val(
							data[i].aj + "_" + data[i].mc)
					city.append(option);
				}
			},
			error : errorResponse
		});
	}
	

	$("#province").change(function(e) {
		showCity($(this).val());
	});

	function errorResponse(data) {
		$.messager.alert(getI18nAlertMsg("i18n_alertMsg_systemError"));

	}
	
}

function speechChange(value){
	if (document.createElement("input").webkitSpeech === undefined) {
	    alert("Speech input is not supported in your browser.");
	}else{
		$("#shortName").val(value);
		queryAccountInfo();
	}
	
}
function queryAccountInfo() {
	
	var frm = $("#accoutForm");
	
	if($("#elsAccount").val().length==0 && $("#shortName").val().length==0){
		if(elsAccount!=superAdmin){
		 parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n defaultValue="请输入账号或公司名称！" key="i18n_account_alert_mustInputAccountOrCompanyName"/>'});
		 return;
		}
	}
	
	
	accountGrid=$('#table-account').mmGrid({
	    cols: accountCols,
	    url: '<%=basePath%>rest/AccountService/findEnterpriseByCondition',
	    params: frm.serializeJSON(),
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
       noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    fullWidthRows:true,
	    plugins: [
             $('#pg').mmPaginator({
                 style: 'plain'
                 , totalCountName: 'total'
                 , page: 1
                 , pageParamName: 'currentPage'
                 , limitParamName: 'pageSize'
                 , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                 , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                 , limit: null
                 , limitList: [10,15,20]
             })
         ]
	});
	
	accountGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
   	    $('body').data('account',item);
    });
	
	accountGrid.opts.params = frm.serializeJSON();
	accountGrid.load({page:1});
}

//查询
$("#queryAccountInfo").click(function() {
	queryAccountInfo();
});

//添加好友
$("#addAccount").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	 if(selectRow[0].elsAccount==elsAccount){
		 parent.elsDeskTop.tip.init({type : 'alert',displayType : 2,message : '<i18n:I18n defaultValue="不能添加自己为好友！" key="i18n_account_alert_conNotAddIToFriend"/>'});
		 return;
	 }
	var url='<%=basePath%>friends/addFriend.jsp?toElsAccount='+selectRow[0].elsAccount
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
        'windowsId':'addFriends',
        'windowTitle':'<i18n:I18n defaultValue="添加好友" key="i18n_label_addfrient"/>',
        'iframSrc':url,
        windowStatus: 'regular',
        windowMinWidth: 400,
        windowMinHeight: 340,
        'windowWidth':400,
        'windowHeight':340,
        windowPositionTop:100,
        'parentPanel':".currDesktop"
    });
});

//查看资料
$("#checkAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url='<%=basePath%>account/displayAccount.jsp?elsAccountNumber='+selectRow[0].elsAccount;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
        'windowsId':'PurchaseEnHisPrice',
        'windowTitle':'<i18n:I18n defaultValue="账户信息" key="i18n_account_title_accountInformation"></i18n:I18n>',
        'iframSrc':url,
        windowStatus: 'regular',
        windowMinWidth: 900,
        windowMinHeight: 500,
        'windowWidth':900,
        'windowHeight':500,
        windowPositionTop:40,
        'parentPanel':".currDesktop"
    });
});

$('#table-account').on('dblclick','tr',function() {
	var account = $('body').data('account');
	var url='<%=basePath%>account/displayAccount.jsp?elsAccountNumber='+account.elsAccount;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
        'windowsId':'PurchaseEnHisPrice',
        'windowTitle':'<i18n:I18n defaultValue="账户信息" key="i18n_account_title_accountInformation"></i18n:I18n>',
        'iframSrc':url,
        windowStatus: 'regular',
        windowMinWidth: 900,
        windowMinHeight: 500,
        'windowWidth':900,
        'windowHeight':500,
        windowPositionTop:40,
        'parentPanel':".currDesktop"
    });
});

</script>

</body>
</html>
