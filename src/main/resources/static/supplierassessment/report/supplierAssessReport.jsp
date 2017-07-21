<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript" src="stockData.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" /></span>
            <div class="common-box-line">
                <button id="queryBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
                <button id="exportBtn" class="button-wrap"><i18n:I18n defaultValue="导出Excel" key="i18n_common_lable_exportasexcel"/></button>
                <button id="frozenBtn" class="button-wrap">冻结</button>
                <button id="toDisableBtn" class="button-wrap">转失效</button>
                <button id="toChangeBtn" class="button-wrap">转潜在</button>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查询条件" key="i18n_additionCost_queryCondition"/></span>
            <div class="common-box-line">
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="供应商大类" key="i18n_supplierrassessreport_table_supplierCategories"/>:</span>
					<select id="firstCategory" name="firstCategory">
						<option value=""><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></option>
					</select>
				</div>	
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="供应商二级分类" key="i18n_supplierrassessreport_table_supplierSecondaryClassification"/>:</span>
					<select id="secondCategory" name="secondCategory">
						<option value=""><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></option>
					</select>
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n defaultValue="供应商ELS账号" key="i18n_common_title_supplierelsaccount"/>:</span>
					<input type="text" id="toElsAccount" name="toElsAccount" />
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="评估期间从" key="i18n_supplierrassessreport_table_assessmentPeriodFrom"/>:</span>
					<input type="text" id="startDate" name="startDate" class="Wdate" onfocus="WdatePicker()" />
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="到" key="i18n_enquiry_label_enquirydateend"/>:</span>
					<input type="text" id="endDate" name="endDate" class="Wdate" onfocus="WdatePicker()" />
				</div>
            </div>
        </div>
		
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="评估结果明细" key="i18n_supplierrassessreport_table_detailedEvaluationResults"/></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100" id="headDiv">
                        <table id="headTable"></table>
                        <div id="headPage" style="text-align: right;"></div>
                    </div>
               </main>
            </div>
        </div>
    </div>
<script>
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	
	var formatDate = function(val,item,rowIndex){
		if("undefined"==typeof(val) || ""==val){
			return "";
		} else {
			return new Date(val).format("yyyy-MM-dd");
		}
	};
	
	function frozen(toElsAccount,companyShortName){
		parent.elsDeskTop.defineWin({
		    'iconSrc':'icon/els-icon.png',
		    'windowsId':'supplierFrozen',
		    'windowTitle':'<i18n:I18n key="test" defaultValue="供应商冻结管理" />',
		    windowSubTitle: "",
		    'iframSrc':'<%=basePath%>supplierfrozen/supplierfrozenmanage.jsp?elsAccount=' + elsAccount
		    		+ "&toElsAccount=" + toElsAccount 
		    		+ "&companyShortName=" + companyShortName,
		    windowMinWidth: 1200,
		    windowMinHeight: 600,
		    'windowWidth':1200,
		    'windowHeight':600,
		    'parentPanel':".currDesktop"
		 });
	}
	
	function preDisable(toElsAccount){
		//先查询是否已经是失效供应商了
		$.ajax({
				url :"${pageContext.request.contextPath}/rest/FriendsService/findMyFriendByFridendAccount/"+elsAccount+"/"+elsSubAccount+"/"+toElsAccount+"?t="+new Date().getTime(),
				type :"GET",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					console.log(data.groupIdA);
					if("108" == data.groupIdA){
						alert("已经是失效供应商,无需重复操作",2);
					}else{
						toDisable(toElsAccount);
					}
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});
	}
	
	function toDisable(toElsAccount){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认此操作',closeEvent:function(){
			var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"friendElsAccount":toElsAccount,"groupIdA":"108"};
			 $.ajax({
					url :"${pageContext.request.contextPath}/rest/FriendsService/updateMyFriend",
					type :"POST",
					contentType : "application/json",
					data : JSON.stringify(data),
					dataType : "json",
					success : function(data) {
						alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
					},
					error : function(data) {
						alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);	
					}
				});
		}});
	}
	
	function preChange(toElsAccount){
		//先查询是否已经是潜在供应商了
		$.ajax({
				url :"${pageContext.request.contextPath}/rest/FriendsService/findMyFriendByFridendAccount/"+elsAccount+"/"+elsSubAccount+"/"+toElsAccount+"?t="+new Date().getTime(),
				type :"GET",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					if("106" == data.groupIdA){
						alert("已经是潜在供应商,无需重复操作",2);
					}else{
						toChange(toElsAccount);
					}
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});
	}
	
	function toChange(toElsAccount){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认此操作',closeEvent:function(){
			var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"friendElsAccount":toElsAccount,"groupIdA":"106"};
			 $.ajax({
					url :"${pageContext.request.contextPath}/rest/FriendsService/updateMyFriend",
					type :"POST",
					contentType : "application/json",
					data : JSON.stringify(data),
					dataType : "json",
					success : function(data) {
						alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
					},
					error : function(data) {
						alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);	
					}
				});
		}});
	}
	
	function rendererOperation(val, item, rowIndex){      
		var text = '<span class="details" style="color:blue;cursor:pointer;"><i18n:I18n defaultValue="详情" key="i18n_supplierrassessreport_table_particulars"/></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		return text;
	}
	
	function rendererOptions(val, item, rowIndex){
		var toElsAccount = item.toElsAccount;
		var companyShortName = item.toCompanyShortName;
		var showText = "";
		if(val == "0")
			showText = "无";
		else if(val == "1")
			showText = "<span style='color:blue;cursor:pointer;' onclick=\"frozen("+toElsAccount+",'"+companyShortName+"');\">冻结</span>";
		else if(val == "2")
			showText = "<span style='color:blue;cursor:pointer;' onclick=\"preDisable("+toElsAccount+");\">转失效</span>";
		else if(val == "3")
			showText = "<span style='color:blue;cursor:pointer;' onclick=\"preChange("+toElsAccount+");\">转潜在</span>";
		return showText;
	}
	
	$('.details').live("click", function() {
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
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
	        'windowsId':'supplierAssessDetails',
	        'windowTitle':'<i18n:I18n defaultValue="供应商评分详情" key="i18n_supplierrassessreport_title_supplierScoringDetails"/>',
	        'windowSubTitle': companyShortName,
	        'iframSrc':'<%=basePath%>supplierassessment/report/supplierAssessDetails.jsp?assessmentNumber='+item.assessmentNumber
	        		+'&grades='+item.grades+'&toElsAccount='+item.toElsAccount+'&toCompanyShortName='+item.toCompanyShortName,
	        'showAdv': false,
	        'windowStatus': 'regular',
	        'windowMinWidth': 1024,
	        'windowMinHeight': 580,
	        'windowPositionTop':14,
	        'windowWidth':1024,
	        'windowHeight':580,
	        'parentPanel':".currDesktop"
	    });
	    
	});
	
	var headCols = [
            { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:130, align:'center', clickDisable:true,renderer: rendererOperation},
        	{ title:"<i18n:I18n key="i18n_supplierrassessreport_lable_ranking" defaultValue="排名" />", name:"rank", width:100, align:"center"},
        	{ title:"<i18n:I18n key="i18n_supplierrassessreport_lable_assessmentNumber" defaultValue="评估编号" />", name:"assessmentNumber", width:110, align:"center"},
        	{ title:"<i18n:I18n key="i18n_supplierrassessreport_lable_evaluationName" defaultValue="评估名称" />", name:"assessmentTemplateName", width:120, align:"center"},
        	{ title:"<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS账号" />", name:"toElsAccount", width:100, align:"center"},
        	{ title:"<i18n:I18n key="i18n_enquiry_label_supplierName" defaultValue="供应商名称" />", name:"toCompanyShortName", width:100, align:"center"},
        	{ title:"<i18n:I18n key="i18n_supplierrassessreport_lable_evaluationScore" defaultValue="评估分数" />", name:"grades", width:100, align:"center"},
        	{ title:"等级判定", name:"level", width:130, align:"center"},
        	{ title:"建议处理方式", name:"options", width:100, align:"center",renderer:rendererOptions},
        	{ title:"<i18n:I18n key="i18n_supplierrassessreport_lable_startDateOfEvaluationPeriod" defaultValue="评估期间开始日期" />", name:"cycleBeginDate" , width:120, align:"center",renderer:formatDate},
        	{ title:"<i18n:I18n key="i18n_supplierrassessreport_lable_endDateOfEvaluationPeriod" defaultValue="评估期间结束日期" />", name:"cycleEndDate" , width:120, align:"center",renderer:formatDate},
        	{ title:"<i18n:I18n key="i18n_label_remark" defaultValue="备注" />", name:"remark", width:200, align:"center"}
        ];
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentResult",
		method :  "POST",
		autoLoad : false,
		height : "500px",
		cols : headCols,
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : true,
        checkCol : true,
        indexCol : false,
	}); 
	
	$("#firstCategory").on("change",function(){
		var firstCategory = $(this).val();
		if(firstCategory != ""){
			var secondCategorySelect = $("#secondCategory");
			secondCategorySelect.empty();
			$("<option value=''><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></option>").appendTo(secondCategorySelect);
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsGroupBbyGroupA/"+elsAccount+"/"+elsSubAccount+"/"+firstCategory,
				type :"get",
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					if("undefined"!=typeof(data) && data.length>0){
						for(var i=0;i<data.length;i++){
							$("<option value='"+data[i].groupId+"'>"+data[i].groupName+"</option>").appendTo(secondCategorySelect);
						}
					}
				},
				error : function(data) {
					alert("<i18n:I18n defaultValue='获取供应商类别异常' key='i18n_supplierrassessreport_lable_obtainVendorClassException'/>");
				}
			});
		}
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    $.ajax({
			url :"${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsGroup/"+elsAccount+"/"+elsSubAccount+"/1",
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if("undefined"!=typeof(data) && data.length>0){
					var firstCategorySelect = $("#firstCategory");
					firstCategorySelect.empty();
					$("<option value=''><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></option>").appendTo(firstCategorySelect);
					for(var i=0;i<data.length;i++){
						$("<option value='"+data[i].groupId+"'>"+data[i].groupName+"</option>").appendTo(firstCategorySelect);
					}
				}
			},
			error : function(data) {
				alert("<i18n:I18n defaultValue='获取供应商类别异常' key='i18n_supplierrassessreport_lable_obtainVendorClassException'/>");
			}
		});
	    
	    var queryParams = {
	    		elsAccount : elsAccount,
	    		elsSubAccount : elsSubAccount,
	    };
	    headGrid.load(queryParams);
	}
	
	function refreshData(){
		var firstCategory = $("#firstCategory").val();
	    var secondCategory = $("#secondCategory").val();
	    var toElsAccount = $("#toElsAccount").val();
	    var startDate = $("#startDate").val();
	    var endDate = $("#endDate").val();
	    
	  	var queryParams = {
	  			elsAccount : elsAccount,
	  			elsSubAccount : elsSubAccount,
	  			toElsAccount : toElsAccount,
	  			groupIdA : firstCategory,
	  			groupIdB : secondCategory,
	  			cycleBeginDate : startDate,
	  			cycleEndDate : endDate,
	  	};
		headGrid.load(queryParams);
	}
	
	$("#frozenBtn").click(function(){
		var selectRow = headGrid.selectedRows();
		if(selectRow.length <= 0){
			alert("请选择供应商",2);
			return;
		}
		var toElsAccount = selectRow[0].toElsAccount;
		var companyShortName = selectRow[0].toCompanyShortName;
		frozen(toElsAccount,companyShortName);
	});
	
	$("#toDisableBtn").click(function(){
		var selectRow = headGrid.selectedRows();
		if(selectRow.length <= 0){
			alert("请选择供应商",2);
			return;
		}
		var toElsAccount = selectRow[0].toElsAccount;
		preDisable(toElsAccount);
	});
	
	$("#toChangeBtn").click(function(){
		var selectRow = headGrid.selectedRows();
		if(selectRow.length <= 0){
			alert("请选择供应商",2);
			return;
		}
		var toElsAccount = selectRow[0].toElsAccount;
		preChange(toElsAccount);
	});
			
	$("#queryBtn").click(function(){
		refreshData();
	});
	
	$("#exportBtn").click(function(){
		var firstCategory = $("#firstCategory").val();
	    var secondCategory = $("#secondCategory").val();
	    var toElsAccount = $("#toElsAccount").val();
	    var startDate = $("#startDate").val();
	    var endDate = $("#endDate").val();
	    
	  	var queryParams = {
	  			elsAccount : elsAccount,
	  			elsSubAccount : elsSubAccount,
	  			toElsAccount : toElsAccount,
	  			groupIdA : firstCategory,
	  			groupIdB : secondCategory,
	  			cycleBeginDate : startDate,
	  			cycleEndDate : endDate,
	  	};
	  	
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/PurchaseEnquiryAssessmentService/exportSupplierAssessmentResult",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(queryParams),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				var filePath = data.message;
				window.location.href = "${pageContext.request.contextPath}/servlet/downloadServlet?filePath="+filePath;
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
	});
	
	$(document).ready(function(){
		init();
	});
	
</script>
</body>
</html>