<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<base:supplierAuth elsAccount="${elsAccount }" authCode="enquiry" toElsAccount="${param['toElsAccount'] }"></base:supplierAuth>
<body>
<div class="box-wrap pos-relative bg-common">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<button id="enquirySeachBtn" class="button-wrap" ><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
			<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
		</div>
	</div>

	<form id="queryForm">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
		<input type="hidden" id="elsAccount"    name="elsAccount"/>
		<input type="hidden" id="elsSubAccount" name="elsSubAccount"/>	
		<input type="hidden" id="pageSize"      name="pageSize"    value="10">
		<input type="hidden" id="currentPage"   name="currentPage" value="1">		
		<div class="common-box-line">
		<div>
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="招标编号名称" />：</span><input id="biddingCode" name="biddingNumber" type="text" />
			</div>
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="招标负责人" />：</span><input id="biddingpincipal" name="principal" type="text" />
			</div>	
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="招标日期" />：</span><input type="text" class="Wdate" onfocus="WdatePicker({lang:'<%=session.getAttribute("language") %>'})" id="beginDate" name="beginDate"/>
			</div>
	        <div class="dis-in-b input-and-tip">
	            <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span><input type="text"  class="Wdate" onfocus="WdatePicker({lang:'<%=session.getAttribute("language") %>'})" id="endDate" name="endDate"/>
	        </div>
            <div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="test" defaultValue="招标状态" />：</span>
				<select id="biddingStatus" name="biddingStatus">
				    <option value="">全部</option>
					<option value="0">待应标</option>
                    <option value="1">不应标</option>
					<option value="2">待投标</option>
					<option value="3">已投标</option>
					<option value="4">本轮投标结束</option>
					<option value="5">未投标</option>
					<option value="6">招标中止</option>
					<option value="7">未中标</option>
					<option value="8">已中标</option>
				</select>
			</div>
		</div>
		</div>
	</div>
	</form>
    <div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
        <div class="common-box-line">
		    <main class="grid-container">
			    <div class="grid-100"  id="biddingHeaderGrid">
					<table id="biddingManageTable"></table>
					<div id="biddingPage" style="text-align: right;"></div>
				</div>
			</main>
         </div>
	</div>
</div>	
</body>
<script>
	var elsAccount       = "<%=session.getAttribute("elsAccount") %>"       ;
	var elsSubAccount    = "<%=session.getAttribute("elsSubAccount") %>"    ;
	var companyShortName = "<%=session.getAttribute("companyShortName") %>" ;
	var biddingManageTable;

	$(document).ready(function() {
		$("#elsAccount").val(elsAccount);
		initSubAcount();
		var name           = "<%=session.getAttribute("username")%>" ;
		var frm = $("#queryForm");
		var frmObj = frm.serializeJSON();
		    frmObj["FBK4"] = elsSubAccount ;
		
		
		
		//渲染投标
		function enquiryHandle(val, item, rowIndex){
			if(item.tenderStatus == '0'){
				return '<span class="enquiry-answer" style="color:blue;">应标</span><span style="display: none;">'+JSON.stringify(item)+'</span>'
						+'&nbsp;&nbsp;<span class="no-enquiry-answer" style="color:blue;">不应标</span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	 					+'&nbsp;&nbsp;<span class="enquiry-detail" style="color:blue;">查看</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			}else if(item.tenderStatus == "1"){
				return '<span class="enquiry-detail"  style="color:blue;">查看</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			}else{
				return '<span class="enquiry-bargain" style="color:blue;">投标</span><span style="display: none;">'+JSON.stringify(item)+'</span>'
						+'&nbsp;&nbsp;<span class="enquiry-detail" style="color:blue;">查看</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			}
		}
		
		//渲染询价单发送状态
		function rendererSendStatus(val,item,index){
			var total_count = item.total_count;
			var answer_count = item.answer_count;
			var not_answer_count = total_count-answer_count;
			if(answer_count == 0){
				return '<i18n:I18n key="i18n_enquiry_label_sendStatus_proceedone" defaultValue="已发送至" />'+
				total_count+'<i18n:I18n key="i18n_enquiry_label_sendStatus_proceedtwo" defaultValue="个供应商，等待接收中" />';
			}else if(total_count == answer_count){
				return '<i18n:I18n key="i18n_enquiry_label_sendStatus_allreceived" defaultValue="全部已接收" />';
			}else{
				return answer_count+'<i18n:I18n key="i18n_enquiry_label_sendStatus_partreceivedone" defaultValue="个供应商已接收," />'+
				not_answer_count+'<i18n:I18n key="i18n_enquiry_label_sendStatus_partreceivedtwo" defaultValue="个供应商等待接收" />';
			}
		}
		
		//渲染投标状态
		function rendererBiddingStatus(val){
			if(val==0){
				return '<i18n:I18n key="test" defaultValue="待应标" />';
			}else if(val==1){
				return '<i18n:I18n key="test" defaultValue="不应标" />';
			}else if(val==2){
				return '<i18n:I18n key="test" defaultValue="待投标" />';
			}else if(val==3){
				return '<i18n:I18n key="test" defaultValue="已投标" />';
			}else if(val==4){
				return '<i18n:I18n key="test" defaultValue="本轮投标结束" />';
			}else if(val==5){
				return '<i18n:I18n key="test" defaultValue="未投标" />';
			}else if(val==6){
				return '<i18n:I18n key="test" defaultValue="招标作废" />';
			}else if(val==7){
				return '<i18n:I18n key="test" defaultValue="未中标" />';
			}else if(val==8){
				return '<i18n:I18n key="test" defaultValue="已中标" />';
			}
		}
		//渲染日期
		function formatDate(val){
			if (!val) {val = "";}
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
			     return val;
		}
		
		function rendererauditStatus(val){
			if(val == 0){
				return '<i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审核通过" />';
			}else if(val == 1){
				return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notApprove" defaultValue="未审核" />';
			}else if(val == 2){
				return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审核中" />';
			}else if(val == 3){
				return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="未审核通过" />';
			}
		}
		
		function rendererBiddingType(val){
			if(val==0){
        		return '<i18n:I18n key="test" defaultValue="邀请招标" />';
        	}else if(val==1){
        		return '<i18n:I18n key="test" defaultValue="公开招标" />';
        	}else if(val==2){
        		return '在线竞标-邀请';
        	}
		}
		
		function rendererDesc(val, item, rowIndex){
			if(item.materialNumber && item.materialDesc){
				return item.materialNumber+" - "+item.materialDesc;
			}
        	return "";
        }
		function biddingNumberRenderer(val){
			if (!val) {val = "";}
			if (val== 0) {
				val = "不区分标段";
			}
			return val;
        }
		var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="biddingSaleManage_mt"/>;
		biddingManageTable =  $('#biddingManageTable').mmGrid({
			cols        :  cols,
			url         : "<%=basePath%>rest/SaleBiddingService/querySaleBiddingHeaderByCondtion",
			method      : 'post',
			params      : frmObj,
			height      :  400,
			loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
			root        : 'rows',
			multiSelect : true,
			indexCol    : true,
			checkCol    : true,
		    plugins     : [$('#biddingPage').mmPaginator({
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

		//初始化供应商下拉框
		initSupplie();
});

	var initSupplie = function (){
		$.ajax({ url :"<%=basePath%>rest/FriendsService/findMyFriendsAndGroups",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"pageSize":1000}),
				success : function(data) {
					var option ="";
					if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							option += '<option value='+ data.rows[i].friendElsAccount+'>'+data.rows[i].friendCompanyName+'</option>';
						}
					}
					$('#toElsAccount').append(option);
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
					alert(xhr.responseText, "Failed"); 
				}
		});
	}

	var initSubAcount = function(){
		$.ajax({url :"<%=basePath%>rest/AccountService/subAccountList",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount,"station":"purchase"}),
				success : function(data) {
					var option ="";
					if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							if(data.rows[i].elsSubAccount == elsSubAccount){
								option += '<option value='+ data.rows[i].elsSubAccount+' selected>'+data.rows[i].name+'</option>';
							}else{
							    option += '<option value='+ data.rows[i].elsSubAccount+'>'+data.rows[i].name+'</option>';
							}
						}
					}
					$('#FBK4').append(option);
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(xhr.responseText, "Failed"); 
				}
		});
	}
	
	var insertPurchaseOrder = function (){
			//获取对方elsAccount
			var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
		    parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
		        'windowsId':'PurchaseEnquiryAdd',
		        'windowTitle':'<i18n:I18n key="i18n_enquiry_windowtitle_purchaseenquirycreate" defaultValue="新建采购询价单" />',
		        windowSubTitle: companyShortName,
		 	   	mask : true,
		        'iframSrc':'<%=basePath%>biddingmanage/purchase/addbiddingMain.jsp?toElsAccount=' + toElsAccount,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
	}
	
	window.purchQuery = function() {
		var frm = $("#queryForm");
		biddingManageTable.opts.params = frm.serializeJSON();
		biddingManageTable.load({});
	}
    //设置条件查询
	$("#enquirySeachBtn").click(function(){
		purchQuery();
	});
	
	//应标
	$('.enquiry-answer').live("click", function() {
		var scanCol = $(this).next() ;
        var sanContent = scanCol.text() ;
        var itemRows = JSON.parse(sanContent) ;
         
		if(itemRows.length==0){
			alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2) ;
			return ;
		}
		
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确定应标?" />',closeEvent:function(){
			parent.elsDeskTop.showLoading() ;
			//发送至供应商
			$.ajax({
				url         : "<%=basePath%>rest/SaleBiddingService/updateSaleBiddingHeader",
				type        : 'POST',
				contentType : "application/json",
				data        : JSON.stringify(itemRows),
				dataType    : "json",
				success     : function(data) {
	    			alert('应标成功!',1);
	    			biddingManageTable.load();
	    			parent.elsDeskTop.hideLoading();
	    		},error     : function(data) {
	    			alert('应标失败!',3);
	    			parent.elsDeskTop.hideLoading();
	    		},complete  : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
		    });
		}});
	})
	
	//不应标
	$('.no-enquiry-answer').live("click", function() {
		var scanCol = $(this).next() ;
        var sanContent = scanCol.text() ;
        var itemRows = JSON.parse(sanContent) ;
         
		if(itemRows.length==0){
			alert('<i18n:I18n key="i18n_common_title_pleaseChooseOperate" defaultValue="请选择操作" />!',2) ;
			return ;
		}
		
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确定不应标?" />',closeEvent:function(){
			parent.elsDeskTop.showLoading() ;
			//发送至供应商
			$.ajax({
				url         : "<%=basePath%>rest/SaleBiddingService/noAnswerBidding",
				type        : 'POST',
				contentType : "application/json",
				data        : JSON.stringify(itemRows),
				dataType    : "json",
				success     : function(data) {
	    			biddingManageTable.load();
	    			parent.elsDeskTop.hideLoading();
	    		},error     : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		},complete  : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
		    });
		}});
	})
	
	//打开投标页面
	$('.enquiry-bargain').live("click", function() {
		
        var scanCol = $(this).next();
        var sanContent = scanCol.text();
        var item = JSON.parse(sanContent);
        //初始化加载的变量
        var biddingNumber = item.biddingNumber;
        var biddingName = item.biddingName;
        var toElsAccount = item.toElsAccount; 
        var beginDate = item.beginDate;
		var endDate = item.endDate;
        var biddingItemNumber = item.biddingItemNumber;
        var currentRound = item.currentRound;
        var biddingStatus = item.biddingStatus;
        var biddingType = item.biddingType;
        var operation = "bid";
        var tagertPriceSendOrNot = item.fbk6;
		if (beginDate!=null&&beginDate.length!=10) {
			beginDate = new Date(beginDate).format("yyyy-MM-dd");
		}	
		if (endDate!=null&&endDate.length!=10) {
			endDate = new Date(endDate).format("yyyy-MM-dd");
		}
		//判断当前服务器时间是否在投标开始时间之后来决定能否投标
		$.ajax({ 
			url :"<%=basePath%>rest/SaleBiddingService/judgeBiddingTime",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"elsAccount":elsAccount,"toElsAccount":toElsAccount,"biddingNumber":biddingNumber,"biddingItemNumber":biddingItemNumber,"roundsNumber":currentRound}),
			success : function(data) {
				if(data.statusCode =="200") {
					//兼容ie 冒泡事件
					if (event && event.preventDefault) {
						event.preventDefault();
						event.stopPropagation();
					} else {
						window.event.returnValue = false;
					}
			        var url = '<%=basePath%>biddingmanage/sale/quoteManage.jsp?biddingNumber=' + biddingNumber + '&biddingName=' + biddingName 
			        		+'&toElsAccount=' + toElsAccount + '&biddingStatus=' + biddingStatus + '&biddingItemNumber=' + biddingItemNumber
			        		+ '&roundsNumber=' + currentRound + '&operation=' + operation+'&tagertPriceSendOrNot='+tagertPriceSendOrNot
			        		+ '&biddingType='+biddingType;
					parent.elsDeskTop.defineWin({
						'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
						'windowsId':'quoteManage',
						'windowTitle':'<i18n:I18n key="test" defaultValue="销售方投标" />',
						 windowSubTitle: companyShortName,
						'iframSrc':url,
						 showAdv: false,
					 	 mask : true,
						 windowStatus: 'maximized',
						 windowMinWidth: 960,
						 windowMinHeight: 700,
						'windowWidth':960,
						'windowHeight':700,
						'parentPanel':".currDesktop"
					});
				} else {
					alert(data.message,2)
				}
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				alert(exception, 3); 
			}
		});
    });
	//查看
	$('.enquiry-detail').live("click", function() {
		debugger;
        var scanCol = $(this).next();
        var sanContent = scanCol.text();
        var item = JSON.parse(sanContent);
        //初始化加载的变量
        var biddingNumber = item.biddingNumber;
        var biddingName = item.biddingName;
        var toElsAccount = item.toElsAccount; 
        var beginDate = item.beginDate;
		var endDate = item.endDate;
        var biddingItemNumber = item.biddingItemNumber;
        var currentRound = item.currentRound;
		var biddingStatus = item.biddingStatus;
		var biddingType = item.biddingType;
		var tagertPriceSendOrNot = item.fbk6;
		var operation = "look";
		var url = '<%=basePath%>biddingmanage/sale/quoteManage.jsp?biddingNumber=' + biddingNumber + '&biddingName=' + biddingName 
				+'&toElsAccount=' + toElsAccount + '&biddingItemNumber=' + biddingItemNumber + '&roundsNumber=' + currentRound 
				+ '&biddingStatus=' + biddingStatus + '&operation=' + operation + '&biddingType='+biddingType+'&tagertPriceSendOrNot='+tagertPriceSendOrNot;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
			'windowsId':'quoteManage',
			'windowTitle':'<i18n:I18n key="test" defaultValue="销售方投标" />',
			 windowSubTitle: companyShortName,
			'iframSrc':url,
			 showAdv: false,
		 	 mask : true,
			 windowStatus: 'maximized',
			 windowMinWidth: 960,
			 windowMinHeight: 700,
			'windowWidth':960,
			'windowHeight':700,
			'parentPanel':".currDesktop"
		});
    });
	
	 //打开新增采购询价单页面
	$("#addPurchaseEnquiry").click(function(){	
		insertPurchaseOrder();
	});
    
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		     'iconSrc':'icon/els-icon.png',
		     'windowsId':'subAccountColumnSetting',
		     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		     windowSubTitle: "",
		     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=biddingSaleManage_mt" + "&window=iframeApp_biddingSaleManage_mt",
		     windowMinWidth: 480,
		     windowMinHeight: 600,
		     'windowWidth':480,
		     'windowHeight':600,
		     'parentPanel':".currDesktop"
		});
	});
</script>
</html>