<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div id="btnArea" class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="saveBtn" class="button-wrap">保存</button>
                <base:auditConfig elsAccount="${elsAccount }" businessType="designDoc">
				<button id="entryBtn" class="button-wrap"><i18n:I18n key="i18n_approval_repsst" defaultValue="提交审核" /></button>
				<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_ussssReport" defaultValue="撤回" /></button>
				<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_approval_flow" defaultValue="流程" /></button>
				</base:auditConfig>
				<button id="backBtn" class="button-wrap">退回</button>
                <button id="freezeBtn" class="button-wrap">冻结物料</button>
                <button id="unfreezeBtn" class="button-wrap">解冻物料</button>
                <button id="refleshRevisionBtn" class="button-wrap">变更版次</button>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">数据刷新时间: </span>&nbsp;<span id="lastUpdateDate"></span></div>
                &nbsp;&nbsp;
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单号: </span>&nbsp;<span id="designNum"></span></div>
                &nbsp;&nbsp;
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单状态: </span>
                &nbsp;<span id="status" style="color:blue;cursor:pointer" onclick="showHis();"></span>
                </div>
                &nbsp;&nbsp;
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">审批状态: </span>&nbsp;<span id="audit"></span></div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_sry" defaultValue="设计文档" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计师: </span>
                <input type="text" id="designer" readonly /></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">采购员: </span>
                <input type="text" id="purchaseInCharge" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">物料编码: </span>
            	<input type="text" id="materialNumber" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">物料名称: </span>
            	<input type="text" id="materialDesc" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">尺寸: </span>
            	<input type="text" id="attribute1" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">材质工艺: </span>
            	<input type="text" id="attribute2" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">改版内容: </span>
            	<select id="changeContent" disabled>
            	   <option value="0">图案文字</option>
            	   <option value="1">材质工艺</option>
            	   <option value="2">尺寸</option>
            	   <option value="3">其他</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">版次: </span>
            	<input type="text" id="revision" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">变更编号: </span>
            	<input type="text" id="changeNumber" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">是否打样: </span>
            	<select id="makeSample" disabled>
            	   <option value="0">打样</option>
            	   <option value="1">不打样</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">制版处理: </span>
            	<select id="plateProcess" disabled>
            	   <option value="0">新制版</option>
            	   <option value="1">改版原版保留</option>
            	   <option value="2">改版原版作废</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">制版数量: </span>
            	<input type="text" id="plateQuantity" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">规格: </span>
            	<input type="text" id="materialSpec" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">产品经理: </span>
            	<input type="text" id="productManager" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">特殊要求: </span>
            	<input type="text" id="specRequirement" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">业务日期: </span>
            	<input type="text" id="orderDate" readonly /></div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
           <div class="tab-wrap" id="sheet-project">
           <ul>
	          <li><a href="#sheet-project-one"><i18n:I18n key="i18n_enquiry_title_fossfile" defaultValue="设计文件" /></a></li>
	          <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_fosss" defaultValue="分配供应商" /></a></li>
	       </ul>
		   <div id="sheet-project-one">
				<div class="box-wrap pos-relative bg-common">
					<div class="common-box-line p-zero">
						<div class="pos-relative upload-wrap">
							<div class="pos-absolute file-list">
								<main class="grid-container">
								<div class="grid-100">
									<table id="table-file"></table>
								</div>
								</main>
							</div>
							<div class="file-scan">
								<div class="file-option-zoom">
									<div class="dis-in-b text-left">
										<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
										<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
									</div>
								</div>
								<div class="file-display" id="file-display">
									<a id="viewerPlaceHolder"></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="sheet-project-two">
				<div class="box-wrap pos-relative bg-common">
					<div id="saleBtn" class="edit-box-wrap">
 						<button id="assignBtn" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_butsss" defaultValue="新增供应商" /></button> 
 						<button id="deleteBtn" class="button-wrap add-bottom-btn"><i18n:I18n key="i18n_common_butsss" defaultValue="删除供应商" /></button> 
					</div>
					<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
					<input type="hidden" name="companyShortName" value="${companyShortName}"/>
					<input type="hidden" name="elsAccount" value="${elsAccount}"/>
            	    <input type="hidden" name="elsSubAccount" value="${elsSubAccount}"/>
            	    <input type="hidden" name="userName" value="${username}"/>
            	    <input type="hidden" name="designNumber" id="designNumber" />
            	    <input type="hidden" name="stretegyCode" id="stretegyCode" />
					<main class="grid-container">
					    <div class="grid-100">
						    <table id="table-sale"></table>
					    </div>
					</main>
					</form>
				</div>
			</div>
			</div>
        </div>
        <div id="sayingDialog" class="saying-dialog">
            <div class="fl-left left-content pos-relative">
                <div class="dis-block pos-absolute option-bar pre-active next"></div>
            </div>
            <div class="fl-left right-content pos-relative none-active">
                <div class="saying-box-wrap">
                   <iframe class="testIframe" id="chatIframe" frameborder="0" width="100%">
                   </iframe>
                </div>
            </div>
            <div class="clear-both"></div>
       </div>
    </div>
    <div id="dialog2" class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span><i18n:I18n key="i18n_common_button_selectStrategy" defaultValue="新选择审批策略" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
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
	<div id="dialog1" class="fixed-dialog">
			<div class="dialog-tip bg-common">
				<div id="dialog-close-btn" class="dialog-close-btn"></div>
				<div class="tip-head">
					<img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" /> 
					<span><i18n:I18n key="i18n_title_fillxxx" defaultValue="填写退回意见" /></span>
				</div>
				<div>
					<div class="box-wrap pos-relative bg-common">
						<div class="common-box-line">
							<textarea id="fbk1" name="fbk1" style="width:95%;" rows="5" maxlength="200"></textarea>
							<div class="mt-20">
								<button id="btnFileOK1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_enquiry_select_approveStatus_xx" defaultValue="确认" /></button>
								<button id="btnFileCancel1" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
<script type="text/javascript">
var winId = "<%= request.getParameter("winId") %>";
var designNumber = "<%=request.getParameter("designNumber")%>";
var $sob;
var chatIfr;
var chatFromUrlFlag = false;
var peopleList;
var toElsAccount = "";
var flowCode = "";
var itemGrid;
var saleGrid;
var cols_item = [
                 {title:"文件编号",name:"fileNumber",align:"center",width:80,hidden:true},
                 {title:"文件名称",name:"fileName",align:"center",width:120},
                 {title:"文件路径",name:"filePath",align:"center",width:120,hidden:true},
                 {title:"文件类别",name:"fileType",align:"center",width:120,renderer:function(val){
                	 if(val == "0")
                	     return "设计文件";
                	 else
                		 return "图片文件"; }
                 },
                 {title:"文件备注",name:"fbk1",align:"center",width:120},
                 {title:"上传人",name:"createUser",align:"center",width:100},
                 {title:"上传时间",name:"createDate",align:"center",width:130,renderer:function(val){
                	 if(!val)
                	     return "";
                	 else
                		 return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }
                 }
                ];
var cols_sale = [
                 {title:"ELS",name:"elsAccount",align:"center",width:120,hidden:true,renderer:function(){
                	 return elsAccount + "<input type='hidden' name='purchaseSupplierList[][elsAccount]' value='" + elsAccount + "'/>";}
                 },
                 {title:"供应商ELS",name:"toElsAccount",align:"center",width:120,renderer:function(val){
                	 return val + "<input type='hidden' name='purchaseSupplierList[][toElsAccount]' value='" + val + "'/>";}
                 },
                 {title:"供应商名称",name:"companyShortName",align:"center",width:140},
                 {title:"设计单号",name:"designNumber",align:"center",width:120,renderer:function(){
                	 return designNumber + "<input type='hidden' name='purchaseSupplierList[][designNumber]' value='" + designNumber + "'/>";}
                 }
                ];

$().ready(function(){
	$("#sayingDialog").hide();
    $("#sheet-project").tabs();
    $("#designNumber").val(designNumber);
	init();
});

function init() {
	//加载数据
	initData();
	
	$("#refleshRevisionBtn").click(function(){
		var materialNumber = $("#materialNumber").val();
		var revision = $("#revision").val();
		var changeNumber = $("#changeNumber").val();
		var data = {"elsAccount":elsAccount,"materialNumber":materialNumber,"revision":revision,"changeNumber":changeNumber};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/DesignDocService/updateRevision",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("操作成功");
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	
	$("#dialog-close-btn").click(function(){
	    $("#dialog1").hide();
	});
	
	$("#btnFileCancel1").click(function(){
	    $("#dialog-close-btn").trigger('click');
	});
	
	$("#backBtn").click(function(){
		if (flowCode != null && flowCode != "" && flowCode != "00") {
			alert("已上报审核,不能退回",2);
		}else{
			$("#dialog1").show();
 			$(".dialog-tip").height(275);
		}
	});
	
	$("#btnFileOK1").click(function(){
		var fbk1 = $("#fbk1").val();
		var param = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"userName":username,"designNumber":designNumber,"orderStatus":0,"fbk1":fbk1};
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_xxx" defaultValue="是否确认退回？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/DesignDocService/updateDesignDoc",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					$("#dialog1").hide();
					alert("<i18n:I18n key="i18n_delivery_revoksssuccess" defaultValue="操作成功" />");
					parent.elsDeskTop.closeCurWin('assignDesignDoc',closeCallback);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		}});
	});
	
	$("#freezeBtn").click(function(){
		var materialNumber = $("#materialNumber").val();
		var fbk3 = $("#attribute1").val();
		var fbk4 = $("#attribute2").val();
		var data = {"elsAccount":elsAccount,"materialNumber":materialNumber,"fbk3":fbk3,"fbk4":fbk4};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/DesignDocService/frozenMaterial",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("操作成功");
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	
	$("#unfreezeBtn").click(function(){
		var materialNumber = $("#materialNumber").val();
		var fbk3 = $("#attribute1").val();
		var fbk4 = $("#attribute2").val();
		var data = {"elsAccount":elsAccount,"materialNumber":materialNumber,"fbk3":fbk3,"fbk4":fbk4};
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/DesignDocService/cancelFrozenMaterial",
			dataType : "json",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("操作成功");
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});
	});
	
	$("#entryBtn").click(function(){
		if(saleGrid.rowsLength() < 1){
			alert("<i18n:I18n key="i18n_alert_ssss" defaultValue="请分配供应商" />",2);
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			var frm = $("#form");
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/DesignDocService/entryDesignDoc",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.statusCode == "-100") {
						alert(data.message,3);
						return;
					}
					// 匹配的审批策略有多条，让用户选择
					if (data.rows) {
						showStretegySelector(data.rows);
						return;
					}
					flowCode = data.flowCode;
					changeButtonStatus();
					alert("<i18n:I18n key="i18n_common_rexxx_success" defaultValue="操作成功" />");
					parent.elsDeskTop.closeCurWin('assignDesignDoc',closeCallback);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						if (data.status == "401") {
							alert("<i18n:I18n key="i18n_common_orders_cannot_be_repeated_tssport" defaultValue="不能重复上报审核" />",2);
						} else if (data.status == "402") {
							alert("<i18n:I18n key="i18n_common_orders_cannot_be_repeated_tssport" defaultValue="该设计文档已被设计师撤回,不能进行操作" />",2);
						} else {
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						};
					}
				}
			});
		}});
	});
	
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('assignDesignDoc',closeCallback);
	});
	
	$("#flowBtn").click(function(){
        if (flowCode == null || flowCode == "" || flowCode == "00") {
			alert("<i18n:I18n key="i18n_delivery_nsssport" defaultValue="单据尚未开始审核" />",2);
		} else {
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'auditFlowList',
		        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
		        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=designDoc&businessId=' + designNumber,
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':680,
		        'windowHeight':500,
		        'parentPanel':".currDesktop"
		    });
		}
		
	});
	
	$("#cancelEntryBtn").click(function(){
		var param = {"businessElsAccount":elsAccount,"designNumber":designNumber,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"userName":username,"orderStatus":1};
		cancelAudit(param,true);
	});
	
<%-- $("#backBtn").click(function(){
		if (flowCode != null && flowCode != "" && flowCode != "00") {
			alert("已上报审核,不能退回",2);
		}else{
			var param = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"designNumber":designNumber,"orderStatus":0};
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				$.ajax({
					url :"<%=basePath%>rest/DesignDocService/updateDesignDoc",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(param),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n key="i18n_delivery_revoksssuccess" defaultValue="操作成功" />");
						parent.elsDeskTop.closeCurWin('assignDesignDoc',closeCallback);
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						if (!permissionError(data)) {
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						}
					}
				});
			}});
		}
   if (flowCode != null && flowCode != "" && flowCode != "00") {
			var param = {"businessElsAccount":elsAccount,"designNumber":designNumber,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"orderStatus":0};
			cancelAudit(param,true);
		}else{
			var param = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"designNumber":designNumber,"orderStatus":0};
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				$.ajax({
					url :"<%=basePath%>rest/DesignDocService/updateDesignDoc",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(param),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n key="i18n_delivery_revoksssuccess" defaultValue="操作成功" />");
						parent.elsDeskTop.closeCurWin('assignDesignDoc',closeCallback);
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						if (!permissionError(data)) {
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						}
					}
				});
			}});
		}
	}); --%>
	
	$("#saveBtn").click(function(){
		if(saleGrid.rowsLength() < 1){
			alert("<i18n:I18n key="i18n_alert_ssss" defaultValue="请分配供应商" />",2);
			return;
		}
		var frm = $("#form");
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/DesignDocService/saveAssignedSupplier",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(frm.serializeJSON()),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("操作成功");
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					if (data.status == "401") {
						alert("<i18n:I18n key="i18n_common_orders_cannot_be_repeated_tssport" defaultValue="该设计文档已被设计师撤回,不能进行操作" />",2);
					}else{
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			}
		});
	});
	
	$("#assignBtn").click(function(){
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'chooseSupplier',
	        'windowTitle':'<i18n:I18n key="ll" defaultValue="选择供应商" />',
	        'iframSrc':'<%=basePath%>designdoc/chooseSupplier.jsp?winId='+winId,
	        'windowWidth':680,
	        'windowHeight':430,
	        'parentPanel':".currDesktop"
	    });
	});
	
	$("#deleteBtn").click(function(){
    	var selectedIndexs = saleGrid.selectedRowsIndex();
    	if (selectedIndexs.length == 0) {
    		alert("<i18n:I18n key="i18n_delivery_choosefilepsse" defaultValue="请选择供应商" />",2);
    		return;
    	}
		var rowIndex = selectedIndexs[0];
    	var selectedRow = saleGrid.row(rowIndex);
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认删除?',closeEvent:function(){
			var toElsAccount = selectedRow.toElsAccount;
			var data = {"elsAccount":elsAccount,"designNumber":designNumber,"toElsAccount":toElsAccount};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/DesignDocService/deleteAssignedSupplier",
				dataType : "json",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					saleGrid.removeRow(rowIndex);
					alert("操作成功");
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		}});
	});
	
	$("#btnDownloadFile").click(function(){
		var selectedRows = itemGrid.selectedRows();
		if(selectedRows.length == 0){
			alert("<i18n:I18n key="i18n_delivery_choosefilesssease" defaultValue="请选择文件" />",2);
			return;
		}
		var filePath = selectedRows[0].filePath;
		window.location.href = "<%=basePath%>servlet/downloadServlet?filePath=" + filePath;
	});
    
    $("#btnViewFile").click(function(){
    	var selectedRows = itemGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key="i18n_delivery_choossssplease" defaultValue="请选择文件" />",2);
    		return;
    	}
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var filePath = selectedRows[0].filePath;
    	var data = {"elsAccount":elsAccount,"filePath":filePath};
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	}else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
    	    parent.elsDeskTop.showLoading();
    	    $.ajax({
			url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				var resStatus = data.statusCode;
				var filePath = data.message;
				if("200" == resStatus){
					var width=$("#file-display").width();
					var height=$("#file-display").height();
					$("#viewerPlaceHolder").css("width",width*0.94+"px");  
					$("#viewerPlaceHolder").css("height",height+"px");  
					$("#viewerPlaceHolder").css("padding-left",width*0.03+"px");  
					$("#viewerPlaceHolder").css("display","block" );  

					var fp = new FlexPaperViewer(
					            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
					            'viewerPlaceHolder', 
					            {config : {
					                SwfFile : filePath,
					                Scale : 1.5,
					                ZoomTransition : 'easeOut',
					                ZoomTime : 0.5,
					                ZoomInterval : 0.2,
					                FitPageOnLoad : false,
					                FitWidthOnLoad : false,
					                FullScreenAsMaxWindow : false,
					                ProgressiveLoading : false,
					                MinZoomSize : 0.2,
					                MaxZoomSize : 5,
					                SearchMatchAll : false,
					                InitViewMode : 'SinglePage',
					                ViewModeToolsVisible : true,
					                ZoomToolsVisible : true,
					                NavToolsVisible : true,
					                CursorToolsVisible : true,
					                SearchToolsVisible : true,
					                localeChain: 'zh_CN'
					            	}
					            });
				}else{
					alert(data.message,2);
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
				}
			}
		});
    	}else {
    		alert("该文件不支持在线预览，请下载查看",2);
    	}
    });
}
function initData(){
	var data = {"elsAccount":elsAccount,"designNumber":designNumber};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/DesignDocService/getDesignDoc",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.lastUpdateDate)
				$("#lastUpdateDate").text(new Date(data.lastUpdateDate).format("yyyy-MM-dd hh:mm:ss"));
			$("#designNum").text(data.designNumber);
			var status = "";
       	    if (data.orderStatus == 0) {
       	    	status = "设计师新建文档";
       	    	$("#btnArea").hide();
       	    }else if(data.orderStatus == 1)
       	    	status = "采购分配供应商";
    	     else if(data.orderStatus == 2) 
    	    	status = "内部流程审核中";
    	     else if(data.orderStatus == 3) 
    	    	status = "供应商处理中";
    	     else if(data.orderStatus == 4) 
    	    	status = "已完结";
    	     else if(data.orderStatus == 5) 
    	    	status = "作废";
			$("#status").text(status);
       	    var audit = "";
    	    if (data.auditStatus == 0) 
    	    	audit = "审核通过";
    	    else if(data.auditStatus == 1) 
    	    	audit = "未开始审核";
    	    else if(data.auditStatus == 2) 
    	    	audit = "审核中";
    	    else if(data.auditStatus == 3) 
    	    	audit = "审核拒绝";
    	    $("#audit").text(audit);
			flowCode = data.flowCode;
			$("#designer").val(data.designer);
			$("#purchaseInCharge").val(data.purchaseInCharge);
			$("#materialNumber").val(data.materialNumber);
			$("#materialDesc").val(data.materialDesc);
			$("#attribute1").val(data.attribute1);
			$("#attribute2").val(data.attribute2);
			$("#changeContent").val(data.changeContent);
			$("#revision").val(data.revision);
			$("#changeNumber").val(data.changeNumber);
			$("#makeSample").val(data.makeSample);
			$("#plateProcess").val(data.plateProcess);
			$("#plateQuantity").val(data.plateQuantity);
			$("#materialSpec").val(data.materialSpec);
			$("#productManager").val(data.productManager);
			$("#specRequirement").val(data.specRequirement);
			if(data.orderDate)
				$("#orderDate").val(new Date(data.orderDate).format("yyyy-MM-dd"));
			//初始化文件列表
			initItemGrid(data.purchaseDesignFileList);
			//初始化分配供应商列表
			initSaleGrid(data.purchaseSupplierList,data.auditStatus);
			changeButtonStatus();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function initItemGrid(fileList){
	var height=$(document).height()-368;
	if(!itemGrid){
		itemGrid = $('#table-file').mmGrid({
	        cols        : cols_item,
	        height      : height,
	        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items       : fileList
	    });
	}
}

function initSaleGrid(supplierList,auditStatus){
	var height=$(document).height()-368;
	if(!saleGrid){
		saleGrid = $('#table-sale').mmGrid({
	        cols        : cols_sale,
	        height      : height,
	        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items       : supplierList,
	        multiSelect:true,
	        checkCol:true
	    });
	}
	if(auditStatus == 0){
		$("#sayingDialog").show();
		chatIfr = $('#chatIframe')[0];
		chatIfr.src = '<%=basePath%>' + 'multiChat_n.jsp';
		// 动态加载聊天窗口
		$sob = $('.saying-dialog .option-bar');
		saleGrid.on('loadSuccess',function(e, data) {
// 			if(saleGrid.rowsLength() > 0){
// 				saleGrid.select(0);//默认选中第一行
// 				var selectedRows = saleGrid.selectedRows();
// 				if(selectedRows && selectedRows.length) {
					initChat(saleGrid.rows());// 动态加载聊天窗口
					if($sob[0].toggleState)
						$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
		            $sob.click();
// 				}
// 			}
		});
// 		saleGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
// 			// 动态加载聊天窗口
// 			var hadSelected = saleGrid.selectedRows();
// 			if(hadSelected && hadSelected.length) {
// 				initChat(hadSelected);
// 	    	}
// 		});
	}
}

function fillSaleGrid(list){
	$.each(list,function(n,value){
		var toElsAccount = value.friendElsAccount;
		var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"companyShortName":value.friendCompanyName,"designNumber":designNumber};
		var isExist = false;
		if(saleGrid.rowsLength() > 0){
			$("#table-sale").find("tr").each(function(){
				var item = $(this).data("item");
				if(toElsAccount == item.toElsAccount){
					isExist = true;
					return false;
				}
		    });
		}
		if(!isExist)
			saleGrid.addRow(data);
    });
}

function cancelAudit(param,isBack){
    if (flowCode == null || flowCode == "" || flowCode == "00") {
		alert("<i18n:I18n key="i18n_delivery_notssssort" defaultValue="单据尚未开始审核" />",2);
	} else {
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this" defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/DesignDocService/cancelAudit",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(param),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					flowCode = data.flowCode;
					changeButtonStatus();
					alert("<i18n:I18n key="i18n_delivery_revossscess" defaultValue="操作成功" />");
					if(isBack)
						parent.elsDeskTop.closeCurWin('assignDesignDoc',closeCallback);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						if (data.status == "401") {
							alert("<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />",2);
						} else if (data.status == "403") {
							alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",2);
						} else {
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						}
					}
				}
			});
		}});
	}
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
		$("#stretegyCode").val($("#stretegySelctor").val());
		$("#entryBtn").click();
	});
}

function closeCallback(){
 	if (parent.frames["iframeApp_designDocManageForPurchase"]) {
		parent.frames["iframeApp_designDocManageForPurchase"].query();
	}
}

function showHis(){
	//兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'viewDesignDocHis',
        'windowTitle':'<i18n:I18n key="ll" defaultValue="设计文档历史记录" />',
        'iframSrc':'<%=basePath%>designdoc/viewDesignDocHis.jsp?designNumber='+designNumber,
        'windowWidth':730,
        'windowHeight':450,
        'parentPanel':".currDesktop"
    });
}

function changeButtonStatus() {
	//根据flowCode改变各按钮状态
	if (flowCode != null && flowCode != "" && flowCode != "00") {
		$("#saveBtn").hide();
		$("#saleBtn").hide();
		$("#entryBtn").hide();
		$("#backBtn").hide();
		$("#cancelEntryBtn").show();
		$("#flowBtn").show();
	} else {
		$("#saveBtn").show();
		$("#saleBtn").show();
		$("#entryBtn").show();
		$("#backBtn").show();
		$("#cancelEntryBtn").hide();
		$("#flowBtn").hide();
	}
}

//初始化聊天窗口
//ELS账号+设计单号 作为 businessID
//TODO: 多人聊天需要传值 peopleList
function initChat(data) {
	var elsAccount = '<%=session.getAttribute("elsAccount") %>',
  	    elsSubAccount = '<%=session.getAttribute("elsSubAccount") %>',
  	    toElsAccount = '',
  	    toElsSubAccount = '',
  	    businessId = '',
  	    peopleList = [];
    var toElsAccountList = [];
    var toElsSubAccountList = [];
    if(data) {
    	data.forEach(function(d,i){
			var obj={};
			obj.name = d.toElsAccount + '-' + d.companyShortName;
			businessId = '' + designNumber;
			peopleList.push(obj);
			toElsAccountList.push(d.toElsAccount + '-' + d.companyShortName);
			var t = {};
			t[d.toElsAccount + '-' + d.companyShortName] = [];
			if (d.fbk1) {
				t[d.toElsAccount + '-' + d.companyShortName].push(d.fbk1);
			}
			toElsSubAccountList.push(t);
		});}
		setIframeData(chatIfr,{
			type:'multi',
			fromElsAccount:elsAccount,
			fromElsSubAccount:elsSubAccount,
			toElsAccount: toElsAccountList,
			toElsSubAccount: toElsSubAccountList,
			businessType:'designDoc',
			businessID:businessId,
			list:peopleList,
			displayType:'1',
			orderType:"1",
			t: new Date().getTime()
	    });
		
	   //滚动条美化niceScroll
	   $(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
}
</script>
</body>
</html>