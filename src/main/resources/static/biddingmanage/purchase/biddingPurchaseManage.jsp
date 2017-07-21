<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<base:supplierAuth elsAccount="${elsAccount }" authCode="enquiry" toElsAccount="${param['toElsAccount'] }"></base:supplierAuth>
<body>
<div class="box-wrap pos-relative bg-common">
       <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="enquirySeachBtn" class="button-wrap" ><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                <button id="addPurchaseEnquiry" class="button-wrap"><i18n:I18n key="i18n_common_button_create" defaultValue="新建" /></button>
                <button id="addPurchaseTemplate" class="button-wrap"><i18n:I18n key="test" defaultValue="调用模板" /></button>
                <button id="deleteBtn" class="button-wrap">删除</button>
                <button id="stopBtn" class="button-wrap">招标作废</button>
                <button id="entryBtn" class="button-wrap">定标前批量提交审批</button>
                <button id="entryPreBiddingBtn" class="button-wrap">发送前批量提交审批</button>
				<button id="preFlowBtn" class="button-wrap"><i18n:I18n key="" defaultValue="发送前查看流程" /></button>
                <button id="flowBtn" class="button-wrap"><i18n:I18n key="" defaultValue="定标查看流程" /></button>
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
            </div>
        </div>
        <form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <input type="hidden" id="elsAccount" name="elsAccount"/>
            <input type="hidden" id="elsSubAccount" name="elsSubAccount"/>	
            <input type="hidden" id="pageSize" name="pageSize" value="10">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">		
			<div class="common-box-line">
			<div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="test" defaultValue="招标编号名称" />：</span><input id="biddingNumber"
							name="biddingNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="test" defaultValue="招标负责人" />：</span><input id="principal"
							name="principal" type="text" />
					</div>
					
					<div class="dis-in-b input-and-tip">
					    <span><i18n:I18n key="test" defaultValue="招标日期" />：</span>
					    <input type="text" class="Wdate" onfocus="WdatePicker()" id="beginDate" name="beginDate"/>
					 </div>
	                <div class="dis-in-b input-and-tip">
	                    <span><i18n:I18n key="test" defaultValue="到" /></span>
	                    <input type="text" class="Wdate" onfocus="WdatePicker()" id="endDate" name="endDate"/>
	                </div>
	                <div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="test" defaultValue="招标状态" />：</span>
						<select id="biddingStatus" name="biddingStatus">
						    <option value="">全部</option>
							<option value="0">未发布</option>
	                        <option value="1">发表前审批中</option>
							<option value="3">发标前审批拒绝</option>
							<option value="4">已发布</option>
							<option value="5">招标进行中</option>
							<option value="6">未开标</option>
							<option value="7">评标中</option>
							<option value="8">招标作废</option>
							<option value="10">定标审批中</option>
							<option value="11">定标审批拒绝</option>
							<option value="12">招标结束</option>
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
	<div id="dialog2" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_selectStrategy" defaultValue="请选择审批策略" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_audit_lable_stretegy" defaultValue="审批策略" />：</span> 
							<select id="stretegySelctor">
							</select>
						</div>
					</div>
					<div class="mt-20">
						<button id="btnFileOK2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel2" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>

window.beforeClose=function(close){
	top.elsDeskTop.closeCurWin('biddingEvalTempSel');
	top.elsDeskTop.closeCurWin('PurchaseBiddingBargainDetail');
	top.elsDeskTop.closeCurWin('addBiddingThree');
	close();
};
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var biddingManageTable;
var biddingNumberArr = [];
$(document).ready(function() {
	    $("#elsAccount").val(elsAccount);
		var frm = $("#queryForm");
		var frmObj = frm.serializeJSON();

		/* function hasNextRowView(item,index) {
			// 从第二行开始判断
			if(index > 0) {
				if("undefined"!= typeof(biddingManageTable) && biddingManageTable.length>0) {
					return biddingNumberArr[index-1] != item.biddingNumber;
	 			}
			}
			return true;
		} */
		function checkViewAble(val, item, rowIndex) {
			var text = '';
			biddingNumberArr.push(item.biddingNumber);
			/* if(hasNextRowView(item, rowIndex)) {
				text = '<input type="checkbox" id="bdMngChkbox_'+rowIndex+'" name="bdMngChkbox"/>';
			} */
			text = '<input type="checkbox" id="bdMngChkbox_'+rowIndex+'" name="bdMngChkbox"/>';
			return text;
		}
		function renderPreAuditStatus(val,item,index){
// 			var fbk22 = item.auditStatus;
			//审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
			if(val != "2" ){
				if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
				else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
		 		else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
		 		else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';
			}else{
				 return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
// 				return '<span class="flowBtn" style="color:blue;white-space: normal;"><i18n:I18n key="test" defaultValue="'+fbk22+'" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			}
		}
		function renderAuditStatus(val,item,index){
			//审批状态：auditStatus 0-审批通过     1或null-未审批    2-审批中    3-审批拒绝
			if(item.biddingItemNumber != 0 && item.extendFields != null){
				var obj = JSON.parse(item.extendFields);
				for(var key in obj){
					if(key == item.biddingItemNumber){
						val = obj[key].auditStatus;
					}
				}
			}
			if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过" />';
			else if (val == "1" || val == null) return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveNo" defaultValue="未审批" />';
	 		else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
	 		else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveRefuse" defaultValue="审批拒绝" />';
		}
		//渲染议价/查看按钮
		function enquiryHandle(val, item, rowIndex) {
			var text = '';
			var iBiddingStatus = item.biddingStatus;
			/* if(hasNextRowView(item, rowIndex)) {
				if(iBiddingStatus > 3) {//已发布
					text = '<span class="enquiry-detail enquiry-bargain" style="color:blue;"><i18n:I18n key="test" defaultValue="评标" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>&nbsp;&nbsp;';
				}
				text += '<span class="enquiry-detail bidding-detail" style="color:blue;"><i18n:I18n key="test" defaultValue="详情" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			} */
			if(iBiddingStatus > 3) {//已发布
				text = '<span class="enquiry-detail enquiry-bargain" style="color:blue;"><i18n:I18n key="test" defaultValue="评标" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>&nbsp;&nbsp;';
			}
			text += '<span class="enquiry-detail bidding-detail" style="color:blue;"><i18n:I18n key="test" defaultValue="详情" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			return text;
		}
		function controlRenderer(val, item, rowIndex) {
			return '<span class="enquiry-detail control" style="color:blue;"><i18n:I18n key="test" defaultValue="刷新状态" /></span><span style="display: none;">'+JSON.stringify(item);
		}
		function biddingMngRender(val, item, rowIndex) {
			if (!val) {val = "";}
			/* val = hasNextRowView(item, rowIndex) ? val : ""; */
			return val;
		}
		function secretRender(val, item, rowIndex) {
			if (!val) {val = "";}
			if(item.biddingType==0 && item.secret==0) {
				if(item.biddingStatus==5 || item.biddingStatus==6) {
					val = '<span class="enquiry-detail bidding-secret" style="color:blue;"><i18n:I18n key="test" defaultValue="开标" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
				}
			} else {
				val = "";
			}
			return val;
		}
		//渲染招标状态
		function rendererBiddingStatus(val,item, rowIndex){
			if(val==0){
				return '<i18n:I18n key="test" defaultValue="未发布" />';
			}else if(val==1){
				return '<i18n:I18n key="test" defaultValue="发标前审批中" />';
			}else if(val==2){
				return '<i18n:I18n key="test" defaultValue="审批退回" />';
			}else if(val==3){
				return '<i18n:I18n key="test" defaultValue="发标前审批拒绝" />';
			}else if(val==4){
				return '<i18n:I18n key="test" defaultValue="已发布" />';
			}else if(val==5){
				return '<i18n:I18n key="test" defaultValue="招标进行中" />';
			}else if(val==6){
				return '<i18n:I18n key="test" defaultValue="未开标" />';
			}else if(val==7){
				return '<i18n:I18n key="test" defaultValue="评标中" />';
			}else if(val==8){
				return '<i18n:I18n key="test" defaultValue="招标作废" />';
			}else if(val==9){
				return '<i18n:I18n key="test" defaultValue="定标中" />';
			}else if(val==10){
				return '<i18n:I18n key="test" defaultValue="定标审批中" />';
			}else if(val==11){
				return '<i18n:I18n key="test" defaultValue="定标审批拒绝" />';
			}else {
				return '<i18n:I18n key="test" defaultValue="招标结束" />';
			}
		}
		function rendererBiddingType(val, item, rowIndex){
				if(val==0){
	        		return '<i18n:I18n key="test" defaultValue="邀请招标" />';
	        	}else if(val==1){
	        		return '<i18n:I18n key="test" defaultValue="公开招标" />';
	        	}else if(val==2){
	        		return '<i18n:I18n key="test" defaultValue="在线竞标-邀请" />';
	        	}else if(val==3){
	        		return '<i18n:I18n key="test" defaultValue="在线竞标-公开" />';
	        	}else if(val==4){
	        		return '<i18n:I18n key="test" defaultValue="暂定招标-邀请" />';
	        	}else if(val==5){
	        		return '<i18n:I18n key="test" defaultValue="暂定招标-公开" />';
	        	}else if(val==6){
	        		return '<i18n:I18n key="test" defaultValue="竞争性谈判" />';
	        	}
		}
		var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="biddingPurchaseManage_mt"/>;
         biddingManageTable =  $('#biddingManageTable').mmGrid({
             cols: cols,
             url:"<%=basePath%>rest/PurchaseBiddingService/findHeaderList/",
             method: 'post',
             params: frmObj,
             height:400,
             loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
             noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
             root: 'rows',
             multiSelect:true,
             checkCol: true,
             remoteSort:true,
             plugins: [
             $('#biddingPage').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                  , limit: null
                  , limitList: [10, 30, 40, 50]
             })
             ]
         });
         biddingManageTable.on('cellSelected', function(e, item, rowIndex, colIndex){
        	 var colName = e.target.name;
        	 if(colIndex==1)
        		 return ;
        	 var bdMngChkboxVar = $("#bdMngChkbox_"+rowIndex);
        	 if(bdMngChkboxVar && typeof(bdMngChkboxVar.get(0)) != "undefined") {
        		 if(colName != "bdMngChkbox"){
		        	 if(bdMngChkboxVar.attr("checked")) {
		        		 bdMngChkboxVar.removeAttr("checked");
		        	 } else {
		        		 bdMngChkboxVar.attr("checked",'true');
		        	 }
        		 }
        	 }
         });
         var mkPatchLoad = biddingManageTable._loadAjax;
         biddingManageTable._loadAjax = function() {
        	 biddingNumberArr = [];
        	 mkPatchLoad.call(biddingManageTable);
         };
});

		//采购方评标
		<%-- OLD CODE
		$('.enquiry-bargain').live("click", function() {
	         var scanCol = $(this).next();
	         
	         var sanContent = scanCol.text();
	         var item = JSON.parse(sanContent);
	         
	         var beginDate = item.beginDate;
	        	if (beginDate!=null&&beginDate.length!=10) {
	        		beginDate = new Date(beginDate).format("yyyy-MM-dd");
	        	}	
	        	var endDate = item.endDate;
	        	if (endDate!=null&&endDate.length!=10) {
	        		endDate = new Date(endDate).format("yyyy-MM-dd");
	        	}
	        	//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
			        'windowsId':'PurchaseEnquiryDetail',
			        'windowTitle':'<i18n:I18n key="test" defaultValue="采购方评标" />',
			        windowSubTitle: companyShortName,
			        'iframSrc':'<%=basePath%>biddingmanage/purchase/biddingBargainOne.jsp?biddingNumber='+item.biddingNumber+
	        		'&biddingStatus='+item.biddingStatus+  
	        		'&beginDate='+beginDate+
	        		'&endDate='+endDate,
			        showAdv: false,
			        windowStatus: 'maximized',
			        windowMinWidth: 960,
			        windowMinHeight: 700,
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop"
			    });
	        	
	     });
		 --%>
		//采购招标明细查看
		$('.bidding-detail').live("click", function() {
	            var scanCol = $(this).next();
	            var sanContent = scanCol.text();
	            var item = JSON.parse(sanContent);
	            var biddingStatus = item.biddingStatus;
	        	//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
			        'windowsId':'addBiddingThree',
			        'windowTitle':'<i18n:I18n key="test" defaultValue="采购招标明细查看" />',
			        'windowSubTitle': companyShortName,
			        'iframSrc':'<%=basePath%>biddingmanage/purchase/addBiddingThree.jsp?biddingNumber='+item.biddingNumber+
			        '&biddingStatus='+item.biddingStatus+'&type=add',
			        'showAdv': false,
			        'windowStatus': 'maximized',
			        'windowMinWidth': 960,
			        'windowMinHeight': 700,
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop"
			    });
	        	
	     });
		
		window.purchQuery = function() {
			var frm = $("#queryForm");
			biddingManageTable.opts.params = frm.serializeJSON();
			biddingManageTable.load({page:1});
		}
        //设置条件查询
		$("#enquirySeachBtn").click(function(){
			purchQuery();
		});
		$("#flowBtn").click(function(){
			flow();
		});
		function flow() {
			debugger;
			var rows = biddingManageTable.selectedRows();
			if (rows.length == 0) {
				alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
				return;
			}
			if(rows.length != 1) {
				alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择一条数据" />",2);
				return;
			}else{
				var biddingNumber = rows[0].biddingNumber ;
				var biddingItemNumber = rows[0].biddingItemNumber;
			}
			var businessId;
			if(biddingItemNumber != null && biddingItemNumber != 0){
				businessId = biddingNumber + "-" +biddingItemNumber;
			}else{
				businessId = biddingNumber;
			}
			var targetElsAccount = elsAccount;
			var businessType = "bidding";
			var title = '<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程     " />'+"  招标编号："+businessId;
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'auditFlowList',
		        'windowTitle':title,
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':680,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		}
		$("#preFlowBtn").click(function(){
			preFlow();
		});
		function preFlow() {
			debugger;
			var rows = biddingManageTable.selectedRows();
			var biddingNumber;
			var biddingItemNumber;
			if (rows.length == 0) {
				alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
				return;
			}
			if(rows.length != 1) {
				alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择一条数据" />",2);
				return;
			}else{
				biddingNumber = rows[0].biddingNumber ;
				biddingItemNumber = rows[0].biddingItemNumber;
			}
			var businessId;
			if(biddingItemNumber != null && biddingItemNumber != 0){
				businessId = biddingNumber + "-" +biddingItemNumber;
			}else{
				businessId = biddingNumber;
			}
			var targetElsAccount = elsAccount;
			var businessType = "preBidding";
			var title = '<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程     " />'+"  招标编号："+businessId;
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'auditFlowList',
		        'windowTitle':title,
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':680,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		}
		$("#entryBtn").click(function(){
	    	entryBidding();
	    });
		$("#entryPreBiddingBtn").click(function(){
	    	entryPreBidding();
	    });
        //打开新增采购招标页面
		$("#addPurchaseEnquiry").click(function(){
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
		        'windowsId':'addBiddingThree',
		        'windowTitle':'新增招投标',
		        windowSubTitle: companyShortName,
		        'iframSrc':'<%=basePath%>biddingmanage/purchase/addBiddingThree.jsp?type=add',
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
		});
        //打开新增采购招标页面
		$("#addPurchaseTemplate").click(function(){
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
		        'windowsId':'biddingPurchaseTemplateSel',
		        'windowTitle':'招投标模板',
		        windowSubTitle: companyShortName,
		        'iframSrc':'<%=basePath%>biddingmanage/purchase/biddingPurchaseTemplateSel.jsp?t='+new Date(),
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
		});
        
	 //列自定义
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=biddingPurchaseManage_mt" + "&window=iframeApp_biddingPurchaseManage_mt",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	 });
});

//开标
$('.bidding-secret').live("click", function() {
     var scanCol = $(this).next();
     
     var sanContent = scanCol.text();
     var item = JSON.parse(sanContent);
   	// 判断当前服务器时间是否已经到开标时间
	$.ajax({
		url :"<%=basePath%>rest/PurchaseBiddingService/canBidOpen",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data : JSON.stringify(item),
		success : function(data) {
			if(data.statusCode =="200") {
				alert('开标成功！');
			} else if(data.statusCode =="100") {
				alert('对不起，还没到开标时间不能开标！',2);
			} else if(data.statusCode =="300") {
				alert('对不起，本轮已经结束了！',3);
			} else if(data.statusCode =="-100"){
				alert(data.message,3);
			} else {
				alert('开标失败！',3);
			}
			biddingManageTable.load();
		},
		error: function (xhr, type, exception) {//获取ajax的错误信息
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
});

// 评标
$('.enquiry-bargain').live("click", function() {
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
       	// 评标定标打分，
   		openPurchaseEnquiryDetail(item);
});
// 手动更新轮次状态
$('.control').live("click", function() {
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
       	$.ajax({
       		url : "<%=basePath%>rest/PurchaseBiddingService/scannerUpdateStatusManual",
       		contentType : "application/json",
       		type : "post",
       		data : JSON.stringify({"elsAccount":item.elsAccount,"biddingNumber":item.biddingNumber}),
       		dataType : "json",
       		success : function(data){
       			alert("更新状态成功！",1);
       			purchQuery();
       		},
       		error : function (xhr, type, exception) {
                alert("更新状态失败:"+exception,3); 
            }
       	});
});
// 定标提交审批
function entryBidding(){
	debugger;
	var rows = biddingManageTable.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var biddingNumbers = "";
	for (var i = 0;i<rows.length;i++){
		if(rows[i].biddingStatus == 8){
			alert("作废的标书禁止提交审批",2);
			return;
		}
		if(rows[i].biddingStatus == 12){
			alert("招标结束的标书禁止提交审批",2);
			return;
		}
		// 区分标段的审批上报
		debugger;
		if(rows[i].biddingItemNumber != 0){
			if(rows[i].extendFields != null){
				var obj = JSON.parse(rows[i].extendFields);
				for(var key in obj){
					if(key == rows[i].biddingItemNumber){
						if(obj[key].auditStatus == "2"){
							var errMsg = "审批中的招标"+rows[i].biddingNumber+"标段"+rows[i].biddingItemNumber+"不能再次提交";
							alert(errMsg,2);
							return;
						}
						if(obj[key].auditStatus == "0"){
							var errMsg = "审批通过的招标"+rows[i].biddingNumber+"标段"+rows[i].biddingItemNumber+"不能再次提交";
							alert(errMsg,2);
							return;
						}
					}
				}
			}
			biddingNumbers += rows[i].biddingNumber + ":" + rows[i].biddingItemNumber + ",";
		}else{
			biddingNumbers += rows[i].biddingNumber + ","; 
			if(rows[i].preAuditStatus != "0"){
				var errMsg = "未发布的招标"+rows[i].biddingNumber+"不能提交";
				alert(errMsg,2);
				return;
			}
			if(rows[i].auditStatus == "2"){
				var errMsg = "审批中的招标"+rows[i].biddingNumber+"不能再次提交";
				alert(errMsg,2);
				return;
			}
			if(rows[i].auditStatus == "0"){
				var errMsg = "审批通过的招标"+rows[i].biddingNumber+"不能再次提交";
				alert(errMsg,2);
				return;
			}
			debugger;
			if(!((rows[i].totalRound == rows[i].currentRound) && (rows[i].biddingStatus == "7"))){
				var errMsg = "不在最后一轮评标中的招标"+rows[i].biddingNumber+"不能提交";
				alert(errMsg,2);
				return;
			}
		}
	}
	var stretegyCode=$("#stretegySelctor").val();
	biddingNumbers = biddingNumbers.substring(0,biddingNumbers.length-1);
	debugger;
	var data = {"stretegyCode":stretegyCode,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"companyShortName":companyShortName,"biddingNumber":biddingNumbers};
	//获取当前选中的
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseBiddingService/batchEntryBidding",
    		contentType : "application/json",
    		type : "post",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			debugger;
    			if(data !=null){
                if(data.statusCode == "E"){
					alert(data.message,3);
					return;
				}else if(data.statusCode == "Other"){
					console.log(data.errMessage);
					alert('请求不允许执行',3);
					return;
				}else if (data.statusCode == "-100") {
					console.log(data.message);
					alert(data.message,3);
					return;
				}
                debugger;
             	// 匹配的审批策略有多条，让用户选择
    			if (data.rows) {
					showStretegySelector(data.rows);
					return;
				}}else{
				alert("<i18n:I18n key="i18n_common_report_success" defaultValue="上报成功" />");
				purchQuery();
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					if (data.status == "401") {
						alert("<i18n:I18n key="i18n_common_orders_cannot_be_repeated_to_report" defaultValue="订单不能重复上报" />",3);
					} else {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					};
				}
			}
		});
	}});
}

//发布标书前提交审批
function entryPreBidding(){
	debugger;
	var rows = biddingManageTable.selectedRows();
	if (rows.length == 0) {
		alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
		return;
	}
	var biddingNumbers = "";
	for (var i = 0;i<rows.length;i++){
		biddingNumbers += rows[i].biddingNumber + ",";
		if(rows[i].biddingStatus == 8){
			alert("作废的标书禁止提交审批",2);
			return;
		}
		if(rows[i].biddingStatus == 12){
			alert("招标结束的标书禁止提交审批",2);
			return;
		}
		if(rows[i].preAuditStatus == "2"){
			var errMsg = "审批中的招标"+rows[i].biddingNumber+"不能再次提交";
			alert(errMsg,2);
			return;
		}
		if(rows[i].preAuditStatus == "0"){
			var errMsg = "审批通过的招标"+rows[i].biddingNumber+"不能再次提交";
			alert(errMsg,2);
			return;
		}
	}
	var stretegyCode=$("#stretegySelctor").val();
	biddingNumbers = biddingNumbers.substring(0,biddingNumbers.length-1);
	debugger;
	var data = {"stretegyCode":stretegyCode,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"companyShortName":companyShortName,"biddingNumber":biddingNumbers};
	//获取当前选中的
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
    	$.ajax({
    		url : "<%=basePath%>rest/PurchaseBiddingService/batchEntryPreBidding",
    		contentType : "application/json",
    		type : "post",
    		data : JSON.stringify(data),
    		dataType : "json",
    		success : function(data) {
    			parent.elsDeskTop.hideLoading();
    			debugger;
    			if(data !=null){
                if(data.statusCode == "E"){
					alert(data.message,3);
					return;
				}else if(data.statusCode == "Other"){
					console.log(data.errMessage);
					alert('请求不允许执行',3);
					return;
				}else if (data.statusCode == "-100") {
					console.log(data.message);
					alert(data.message,3);
					return;
				}
                debugger;
             	// 匹配的审批策略有多条，让用户选择
    			if (data.rows) {
					showStretegySelector(data.rows);
					return;
				}}else{
				alert("<i18n:I18n key="i18n_common_report_success" defaultValue="上报成功" />");
				purchQuery();
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					if (data.status == "401") {
						alert("<i18n:I18n key="i18n_common_orders_cannot_be_repeated_to_report" defaultValue="订单不能重复上报" />",3);
					} else {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					};
				}
			}
		});
	}});
}
function showStretegySelector(stretegyList) {
	$(".dialog-tip").height(40);
	var html = "";
	for (var i=0;i<stretegyList.length;i++){
		html += "<option value='"+stretegyList[i].stretegyCode+"'>"+stretegyList[i].stretegyName+"</option>";
	}
	$("#stretegySelctor").empty().html(html);
	$('#dialog2').show();
	$("#btnFileOK2").unbind("click").click(function(){
		var stretegyCode=$("#stretegySelctor").val();
		$("#entryPreBiddingBtn").click();
		$('#dialog2').hide();
	});
}
function openPurchaseEnquiryDetail(item) {
    var beginDate = formatDate(item.beginDate);	
   	var endDate = formatDate(item.endDate);
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
        'windowsId':'PurchaseBiddingBargainDetail',
        'windowTitle':'<i18n:I18n key="test" defaultValue="采购方评标" />',
        windowSubTitle: companyShortName,
        'iframSrc':'<%=basePath%>biddingmanage/purchase/biddingBargainOne.jsp?biddingNumber='+item.biddingNumber+
   		'&biddingStatus='+item.biddingStatus+  
   		'&toElsAccount='+item.toElsAccount+  
   		'&beginDate='+beginDate+
   		'&endDate='+endDate+
   		'&biddingItemNumOne='+item.biddingItemNumOne,
        showAdv: false,
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
}

//关联项目回调函数
function callbackFun(rows){
	// 关闭打开的评标界面
	parent.elsDeskTop.closeCurWin('PurchaseBiddingBargainDetail');
	openPurchaseEnquiryDetail(rows);
}

//删除招投标信息
$("#deleteBtn").live("click",function(){
	var selectedRecords = biddingManageTable.selectedRows();
	if(selectedRecords.length > 0 && selectedRecords != "[]" && typeof(selectedRecords[0]) != "undefined"){
		var selectedRecord = selectedRecords[0];
		var biddingStatus = selectedRecord.biddingStatus;
		var biddingNumber = selectedRecord.biddingNumber;
		if(biddingStatus == "0" || null == biddingStatus){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="是否确认删除？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				$.ajax({
					url : '<%=basePath%>rest/PurchaseBiddingService/deleteBiddingByPrimaryKey',
					type : 'POST',
					contentType : "application/json",
					data : JSON.stringify({"elsAccount":elsAccount,"biddingNumber":biddingNumber}),
					dataType : "json",
					success : function(data) {
		    			alert("删除招投标信息成功!",1);
		    			purchQuery();
		    		},error : function(data) {
		    			alert("删除招投标信息失败!",3);
		    		},complete : function(data) {
		    			parent.elsDeskTop.hideLoading();
		    		}
				});
			}});
		}else {
			alert("只能删除未发布的招投标",2);
		}
	}else {
		alert("请选择删除招投标行",2);
	}
});
//作废
$("#stopBtn").live("click",function(){
			var selectRowsIndex = biddingManageTable.selectedRowsIndex();
			if(selectRowsIndex.length < 1){
				alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
				return;
			}
			if(selectRowsIndex.length > 1){
				alert('<i18n:I18n defaultValue="请选择一行数据！" key=""/>',2);
				return;
			}
			var selectedRecords = biddingManageTable.selectedRows()[0];
			var allSelectedRecords = biddingManageTable.selectedRows();
			if(null != typeof(allSelectedRecords) && allSelectedRecords != "" && allSelectedRecords != "[]"){
				for(var i=0;i<allSelectedRecords.length;i++){
					if(allSelectedRecords[i].biddingStatus == 8){
						alert("已作废的标禁止再次做招标作废处理",2);
						return;
					}
					if(allSelectedRecords[i].biddingStatus == 12){
						alert("已结束的标禁止再次做招标作废处理",2);
						return;
					}
				}
			}
			if(null != typeof(selectedRecords) && selectedRecords != "" && selectedRecords != "[]"){
				var selectedRecord = selectedRecords;
				var biddingStatus = selectedRecord.biddingStatus;
				var biddingNumber = selectedRecord.biddingNumber;
					parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="是否确认作废？" />',closeEvent:function(){
						parent.elsDeskTop.showLoading();
						$.ajax({
							url : '<%=basePath%>rest/PurchaseBiddingService/stopBidding',
							type : 'POST',
							contentType : "application/json",
							data : JSON.stringify({"elsAccount":elsAccount,"biddingNumber":biddingNumber}),
							dataType : "json",
							success : function(data) {
								if(data.statusCode == "-100"){
					    			alert("作废招投标失败:"+data.message,3);								
								}else{
									alert("作废招投标成功!",1);
					    			purchQuery();						
								}
				    		},complete : function(data) {
				    			parent.elsDeskTop.hideLoading();
				    		}
						});
					}});
			}else {
				alert("请选择招投标行",2);
			}
});
function formatDate(val){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {
		val = new Date(val).format("yyyy-MM-dd");
	}
	return val;
}
var formatDateTime = function (val,item,index){
	if (!val) {val = "";}
	if (val!=""&&val.length != 19) {
		val = new Date(val).format("yyyy-MM-dd hh:mm:ss");
	}
    return val;
};
</script>

</html>