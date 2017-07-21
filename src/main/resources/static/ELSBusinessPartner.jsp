<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative public-wrap ">
	<form id="queryForm" onsubmit="return false;">
		<input type="hidden" id="pageSize" name="pageSize" value="10">
		<input type="hidden" id="currentPage" name="currentPage" value="1">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
				<div class="common-box-line">
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="ELS号" />： </span>
						<input type="text" id="elsAccount" name="elsAccount" style="width:200px;"/>
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="企业名称" />： </span>
						<input type="text" id="fullName" name="fullName" style="width:200px;"/>
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="业务角色" />： </span>
			        	<select class="" id="station" name="station">
							<option value=""><i18n:I18n defaultValue="全部" key=""></i18n:I18n></option>
							<option value="purchase"><i18n:I18n defaultValue="采购商" key=""></i18n:I18n></option>
							<option value="sale"><i18n:I18n defaultValue="供应商" key=""></i18n:I18n></option>
						</select>
		        	</div>
		        	<br/>
		        	<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="注册日期" />：</span>
					</div>
					<div class="dis-in-b input-and-tip">
						<input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="startTime" name="startTime" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span>
						<input type="text" id="endTime" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="endTime" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span class="dis-in-b text-right w-72"><i18n:I18n key="" defaultValue="账户状态" />： </span>
			        	<select class="" id="frozenFlag" name="frozenFlag">
							<option value=""><i18n:I18n defaultValue="全部" key=""></i18n:I18n></option>
							<option value="N"><i18n:I18n defaultValue="正常" key=""></i18n:I18n></option>
							<option value="Y"><i18n:I18n defaultValue="已冻结" key=""></i18n:I18n></option>
						</select>
		        	</div>
		        	<div class="dis-in-b input-and-tip">
								<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
					</div>
				</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="ELS业务伙伴信息" /></span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100" id="ELSBusinessPartnerGrid">
					<table id="ELSBusinessPartnerTable"></table>
					<div id="pg" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>
		</form>
	</div>
	<script type="text/javascript">
	
	var elsBusinessPartnerGrid;

	$().ready(function(){
		init();
	});
	
	function init(){
		
		var frm = $("#queryForm");
		 //初始化控件
	    $('button').button();
	    elsBusinessPartnerGrid=$('#ELSBusinessPartnerTable').mmGrid({
		    cols: elsBusinessPartnerCols,
		    url: '<%=basePath%>rest/AccountService/findBusinessPartner',
		    params: frm.serializeJSON(),
		    height: 420,
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
	}
	
	function queryBtn() {
		var frm = $("#queryForm");
		elsBusinessPartnerGrid.opts.params = frm.serializeJSON();
		elsBusinessPartnerGrid.load({page:1});
	}
	
	//查询
	$("#queryBtn").click(function() {
		queryBtn();
	});
	var elsBusinessPartnerCols = [
					   { title:'<i18n:I18n defaultValue="操作" key=""/>', name:'updateAccountValidityDate' ,width:100, align:'center',renderer:rendererAccountValidityDate},
					   { title:'<i18n:I18n defaultValue="上级ELS账号" key=""></i18n:I18n>', name:'parentElsAccount' , width:80, align:'center'},
	                   { title:'<i18n:I18n defaultValue="上级企业名称" key=""></i18n:I18n>', name:'parentFullName' ,width:120, align:'center'},
	                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:80, align:'center'},
	                   { title:'<i18n:I18n defaultValue="企业名称" key=""></i18n:I18n>', name:'fullName' ,width:120, align:'center'},
	                   { title:'<i18n:I18n defaultValue="企业简称" key=""></i18n:I18n>', name:'shortName' ,width:100, align:'center'},
	                   { title:'<i18n:I18n defaultValue="企业性质" key=""></i18n:I18n>', name:'nature' ,width:120, align:'center'},
	                   { title:'<i18n:I18n defaultValue="角色" key=""></i18n:I18n>', name:'station' ,width:90, align:'center',renderer:rendererStation},
	                   { title:'<i18n:I18n defaultValue="行业" key=""/>', name:'industry' ,width:100, align:'center'},
	                   { title:'<i18n:I18n defaultValue="账户状态" key="i18n_account_title_accountStatus"/>', name:'frozenFlag' ,width:100, align:'center',renderer:rendererAccountStutas},
	                   { title:'<i18n:I18n defaultValue="行业细类" key=""></i18n:I18n>', name:'industryDetail' ,width:120, align:'center'},
	                   { title:'<i18n:I18n defaultValue="注册日期" key=""/>', name:'registerDate' ,width:100, align:'center',renderer:rendererTime},
	                   { title:'<i18n:I18n defaultValue="生效日期" key=""/>', name:'registerDate' ,width:100, align:'center',renderer:rendererTime},
	                   { title:'<i18n:I18n defaultValue="账户有效期限至" key="i18n_account_title_validityDate"/>', name:'accountValidityDate' ,width:100, align:'center',renderer:rendererDate},
	                   { title:'<i18n:I18n defaultValue="最大授权数" key=""/>', name:'' ,width:100, align:'center'},
	                   { title:'<i18n:I18n defaultValue="来源" key=""/>', name:'' ,width:100, align:'center'},
	                   { title:'<i18n:I18n defaultValue="供应商数" key=""/>', name:'purchaseNumber' ,width:100, align:'center',renderer:rendererNumber},
	                   { title:'<i18n:I18n defaultValue="客户数" key=""/>', name:'saleNumber' ,width:100, align:'center',renderer:rendererNumber},
	                   { title:'<i18n:I18n defaultValue="授权应用" key=""/>', name:'' ,width:100, align:'center'},
	                   { title:'<i18n:I18n defaultValue="国家代码" key=""></i18n:I18n>', name:'countryCode' ,width:90, align:'center'},
	                   { title:'<i18n:I18n defaultValue="省份" key=""/>', name:'province' ,width:120, align:'center'},
	                   { title:'<i18n:I18n defaultValue="城市" key=""/>', name:'city' ,width:120, align:'center'},
	                   { title:'<i18n:I18n defaultValue="详细地址" key=""/>', name:'address' ,width:200, align:'center'}
	            ];
	
	//修改冻结时间
	$('.accountValidityDate-detail').live("click", function() {
		var scanCol = $(this).next();
	    var sanContent = scanCol.text();
	    var item = JSON.parse(sanContent);
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
		var url='<%=basePath%>editAccountValidityDate.jsp?elsAccount='+item.elsAccount
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop2_icon_181.png',
	        'windowsId':'editAccountValidityDate',
	        'windowTitle':'<i18n:I18n defaultValue="修改账户有效期" key=""/>',
	        'iframSrc':url,
	         windowStatus: 'regular',
	         windowMinWidth: 300,
	         windowMinHeight: 250,
	        'windowWidth':350,
	        'windowHeight':250,
	         windowPositionTop:50,
	        'parentPanel':".currDesktop"
	    });
	});
	//渲染修改冻结时间按钮
	function rendererAccountValidityDate(val, item, rowIndex){
		return '<span class="accountValidityDate-detail" style="cursor: pointer;color:blue;"><i18n:I18n key="" defaultValue="修改" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	}
	//渲染业务角色
	function rendererStation(val){
		if (!val) {val = "";}
		if (val == "sale"){
			val =  '<i18n:I18n defaultValue="供应商" key=""></i18n:I18n>';
		}else {
		    val =  '<i18n:I18n defaultValue="采购商" key=""></i18n:I18n>';
		}
		return val;
	}
	
	//渲染供应商数和客户数
	function rendererNumber(val){
		if (val===null || val==="" ) {val = "0";}
		
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
	
	//日期格式渲染 yyyy-MM-dd
	function rendererDate(val){
		if (!val) {val = "";}
		if (val!="") {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	}
	
	//日期格式渲染 yyyy-MM-dd hh:mm:ss
	function rendererTime(val){
		if (!val) {val = "";}
		if (val!="") {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
		return val;
	}
</script>
</body>
</html>