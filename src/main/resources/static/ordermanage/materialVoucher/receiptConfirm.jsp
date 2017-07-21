<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_delivery_button_receipt" defaultValue="收货" /></button>
				<button class="button-wrap" id="toERP">写入ERP</button>
				<button id="headColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
				<button id="deliveryFlowBtn" class="button-wrap"><i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<form id="form" onsubmit="return false;">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_receiptheader" defaultValue="收货单抬头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<main class="grid-container">
					<div class="grid-100">
						<table id="table-head"></table>
					</div>
					</main>
				</div>
			</div>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
				<ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_title_purchaseOrder_item" defaultValue="采购行项目" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                    </ul>
                    <div id="sheet-project-one">
					<button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
						<input type="hidden" 
						name="companyShortName"  value="${companyShortName}"/> 
					<input type="hidden" id="elsAccountParam"
						name="materialVoucherHeaderVO[elsAccount]" /> <input
						type="hidden" id="elsSubAccountParam"
						name="materialVoucherHeaderVO[elsSubAccount]" /> <input
						type="hidden" class="deliveryStatusParam"
						name="materialVoucherHeaderVO[deliveryStatus]" /> <input
						type="hidden" id="materialVoucherNumberParam"
						name="materialVoucherHeaderVO[materialVoucherNumber]" />
<!-- 						<input -->
<!-- 						type="hidden" id="mobileTypeParam" -->
<!-- 						name="materialVoucherHeaderVO[mobileType]" value="601" /> -->
					<main class="grid-container">
					<div class="grid-100" id="materialVoucherItemGrid">
						<table id="materialVoucherItemTable"></table>
					</div>
					</main>
                    </div>
                    <div id="sheet-project-two">
				     <div class="box-wrap pos-relative bg-common">
					  <div class="common-box-line p-zero">
						<div class="pos-relative upload-wrap">
							<div class="pos-absolute file-list">
								<div class="file-list-head">
									<i18n:I18n key="i18n_common_lable_filelist" defaultValue="表单文件列表" />：<span></span>
								</div>
								<main class="grid-container">
								<div class="grid-100">
									<table id="table-file"></table>
								</div>
								</main>
							</div>
							<div class="file-scan">
								<div class="file-option-zoom">
									<div class="dis-in-b text-left">
										<button id="btnAddFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button>
										<button id="btnModifyFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改文件" /></button>
										<button id="btnDeleteFile" class="edit-btn button-wrap"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button>
									</div>
									<div class="dis-in-b text-right">
										<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
										<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
<!-- 										<button class="button-wrap" id="sendForm">发送表单文件</button> -->
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
				</div>
			</div>
		</div>
		</form>
	</div>
		<div class="fixed-dialog">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" /> 
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="表单文件分类" />：</span> <select id="operTypeSelector"
								onchange="loadOrderItem()">
								<option value="0"><i18n:I18n key="i18n_common_select_bymaterialheader" defaultValue="按凭证头" /></option>
								<option value="1"><i18n:I18n key="i18n_common_select_bymaterialitem" defaultValue="按凭证行" /></option>
							</select>
						</div>
						<div id="divOrderItem" class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="请选择行项目" />：</span> <select id="orderItemSelector"
								name="orderItemNumber">
							</select>
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span><input id="fileName" name="fileName"
								type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /></div></span>
							<input id="filePath" name="filePath" type="hidden" />
						</div>
						<input id="fileType" name="fileType" type="hidden" />
					</div>
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	    var winId = "<%= request.getParameter("winId") %>";
		var materialVoucherNumber = GetQueryString("materialVoucherNumber");
		var mobileType = "101";
		var deliveryStatus="0";
		var toElsAccount;
		var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="receiptConfirm_mt"/>;
		var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="receiptHead"/>;
		var headGrid;
		var itemGrid;
		var fileGrid;
		var formId;
		var fileName;
		var mobileTypeParam="101";
		var fileStatus;
		var fbk1 = "";
		var fbk2 = "";
		var fileUploader;
		var cols_file = [{ title:'id',name:'formId' ,width:200, align:'center',hidden:true},
		                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'materialVoucherItemNumber' ,width:90, align:'center',renderer:function(val){
			                 	if (val == ""||val== null) {
			                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialheader" defaultValue="凭证头文件" />';
			                	} else{
			                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialitem" defaultValue="凭证项文件" />';
			                	}
			                }},
		                 { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="订单项编号" />',name:'materialVoucherItemNumber' ,width:200, align:'center',hidden:true},
		                 { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />',name:'filePath' ,width:200, align:'center',hidden:true},
		                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
		                 { title:'<i18n:I18n key="i18n_delivery_lable_mobiletype" defaultValue="移动类型" />',name:'mobileType' ,width:200, align:'center',hidden:true},
		                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="待发状态" />', name:'fileStatus' ,width:59, align:'center',renderer:function(val){
		                	 var showText;
		                	 if (val == "0") {
		                		 showText = '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
		                	} else if (val == "1") {
		                		showText = '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
		                	} else if (val == "2") {
		                		showText = '<i18n:I18n key="i18n_common_title_sendstatus_received" defaultValue="已接收" />';
		                	}
		                 	return showText;
		                 }},
		                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
		                  	if (val == elsAccount) {
		                 		return '<i18n:I18n key="i18n_label_self" defaultValue="已方" />';
		                 	} else {
		                 		return '<i18n:I18n key="i18n_label_otherSide" defaultValue="对方" />';
		                 	} 
		                 }}
		             ];
		$(document).ready(
						function() {
							
							$("#sheet-head").tabs();
							$("#sheet-project").tabs();
							$("#elsAccountParam").val(elsAccount);
							$("#elsSubAccountParam").val(elsSubAccount);
							$("#materialVoucherNumberParam").val(materialVoucherNumber);
							initFileGrid();

			//得到订单头部信息
			function getSaleOrderHeadBySaleOrderNumber() {
				parent.elsDeskTop.showLoading();
				$.ajax({
				url : "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherHeaderByStatus",
				type :"POST",
				contentType : "application/json",
				data : '{"elsAccount":"'+elsAccount+'","mobileType":"'+mobileType+'","materialVoucherNumber":"'+materialVoucherNumber+'"}',
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					//默认待检
					data.rows[0].mobileType = '103';
					headGrid= $('#table-head').mmGrid({
				        cols: cols_head,
				        items:data.rows,
				        checkCol:true,
				        height:100,
				    });
					deliveryStatus=data.rows[0].deliveryStatus;
					if (data.rows[0].fbk1) {
						fbk1 = data.rows[0].fbk1;
					}
					if (data.rows[0].fbk2) {
						fbk2 = data.rows[0].fbk2;
					}
					headGrid.on('loadSuccess',function(e, data) {
						$("#table-head").find("input").not(":checkbox").each(function(){
							$(this).css("width",$(this).parent().parent().width()-15);
						});
					});
					insertMaterialVoucherItemTable();
					loadFileItem();
				},
				error : function(data) {
	                parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}

		//显示当前销售订单状态
		function showStatus(deliveryStatus){
			var str='<i18n:I18n key="i18n_delivery_lable_currentstatus" defaultValue="目前状态：发货单" />';
			if(deliveryStatus==0){//销售订单未确认
				return str+=" --> <i18n:I18n key='i18n_delivery_select_notdeliver' defaultValue='未发货' />";
			}else if(deliveryStatus==1){//订单已确认
				str+=" --> <i18n:I18n key='i18n_delivery_select_deliveronway' defaultValue='发货在途' />";
			}else if(deliveryStatus==2){//订单已确认
				str+=" --> <i18n:I18n key='i18n_delivery_lable_receipt' defaultValue='已收货' />";
			}else if(deliveryStatus==3){//订单更改生产状态
				str+=" --> <i18n:I18n key='i18n_delivery_lable_scene' defaultValue='到货' />";
			}
			return str;
		}
		
		getSaleOrderHeadBySaleOrderNumber();
		
		function insertMaterialVoucherItemTable(){
			$('#materialVoucherItemGrid').html('<table id="materialVoucherItemTable"></table>')
			var paramStr={"elsAccount":elsAccount,"mobileType":mobileType,"materialVoucherNumber":materialVoucherNumber};
			var height=$(document).height()-305;
		    //本地示例
			   itemGrid= $('#materialVoucherItemTable').mmGrid({
			        cols: cols,
			        url : "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherItem",
			        params:paramStr,
			        method:'post',
			        root:"rows",
			        height:height,
			        remoteSort:true,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			   itemGrid.on('loadSuccess',function(e, data) {
				   $("#materialVoucherItemTable").find("input").not(":checkbox").each(function(){
						$(this).css("width",$(this).parent().parent().width()-15);
					});
				   $(".isFree").each(function(){
					   var saleOrderNumber = $(this).parent().parent().parent().data("item").saleOrderNumber;
						if (saleOrderNumber != "")  {
							$(this).attr("checked",false);
						} else {
							$(this).attr("checked","checked");
						}
					});
				   
				   $("#materialVoucherItemTable").find("tr").each(function(){
						var link = $(this).find("span[name='rowLink']");
						var data = $(this).data("item");
						link.click(function(){
							var materialVoucherNumber = headGrid.row(0).materialVoucherNumber; 
							var materialVoucherItemNumber = data.materialVoucherItemNumber;
							var mobileType = data.mobileType;
							var url = "<%=basePath%>ordermanage/materialVoucher/editReceiptPackage.jsp?materialVoucherNumber=" + materialVoucherNumber 
									  + "&materialVoucherItemNumber=" + materialVoucherItemNumber + "&mobileType=" + mobileType + "&winId=" + winId;
								//兼容ie 冒泡事件
						    if (event && event.preventDefault) {
						        event.preventDefault();
						        event.stopPropagation();
						    } else {
						        window.event.returnValue = false;
						    }
						    parent.elsDeskTop.defineWin({
						        'iconSrc':'icon/els-icon.png',
						        'windowsId':'editDeliveryPackage',
						        'windowTitle':'<i18n:I18n key="i18n_delivery_windowtitle_packages" defaultValue="包装明细" />',
						        'iframSrc':url,
						        'windowWidth':900,
						        'windowHeight':600,
						        'parentPanel':".currDesktop"
						    });
						});
					});
				   //绑定输入收货数量事件
				   bindReceiptInput();
				});
			}
		
		//过账
		$("#toERP").click(function(){
			console.log(deliveryStatus);
			if(deliveryStatus!="2"){
				alert("收货以后才能写ERP",2);
				return;
			}
			parent.elsDeskTop.tip.init({type: 'confirm',message:'确认写入ERP?',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				var json={"materialVoucherNumber":materialVoucherNumber,"elsAccount":elsAccount,"mobileType":mobileTypeParam}
				var paramStr = JSON.stringify(json);
				console.log(paramStr);
				$.ajax({
					url : "<%=basePath%>rest/MaterialVoucherService/toRecipt" ,
					contentType : "application/json",
			 		type : "post",
			 		dataType : "json",
			 		data:paramStr,
			 		success : function(data) {
			 			parent.elsDeskTop.hideLoading();
			 			if(data!=null&&data.statusCode=="-100"){
			 				alert(data.message,2);
			 			}else if(data!=null&&data.statusCode=="-200"){
			 				alert(data.message,3);
			 			}else{
			 				alert("<i18n:I18n key='i18n_delivery_postsuccess' defaultValue='过账成功' />");
			 	 			query();
			 			}
			 		},
			 		error : function(data) {
			 			parent.elsDeskTop.hideLoading();
			 			alert("<i18n:I18n key='i18n_delivery_postfail' defaultValue='过账失败' />",3);
			 		}
			 	});
			}});
		});
		
		//保存
		$("#saveBtn").click(function(){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_delivery_confirm_receipt" defaultValue="是否确认收货？" />',closeEvent:function(){
			
			$("#materialVoucherItemTable").find(":checkbox").each(function(){
				$(this).removeAttr("disabled");
			});
			var frm=$("#form");
			parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url :"<%=basePath%>rest/MaterialVoucherService/confirmReceiptMaterialVoucher",
	    		type :"post",
	    		contentType : "application/json",
	    		data : JSON.stringify(frm.serializeJSON()),
	    		dataType : "json",
	    		success : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			if(data.statusCode==-100){
	    				alert(data.message,2);
	    			}else{
	    				mobileType=frm.serializeJSON().materialVoucherHeaderVO.mobileType;
	    				mobileTypeParam=frm.serializeJSON().materialVoucherHeaderVO.mobileType;
	    				getSaleOrderHeadBySaleOrderNumber();
	    				refleshFileGrid();
	    				alert("<i18n:I18n key='i18n_delivery_receivesuccess' defaultValue='收货成功' />");
	    			}
	    		},
	    		error : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			alert("<i18n:I18n key='i18n_delivery_receivefail' defaultValue='收货失败' />",3);
	    		}
	    	}); 
			}});
		});
		$("#deliveryFlowBtn").click(function(){
			if (fbk1==""||fbk2=="") {
				alert("<i18n:I18n key="i18n_alert_deliveryflowcannotnull" defaultValue="物流商和物流单号不能为空" />",2);
				return;
			}
			pattern =new RegExp("\\((.| )+?\\)","igm");
			var id = fbk1.match(pattern);
			if (!id || id == "") {
				alert("<i18n:I18n key="i18n_alert_deliveryFlownotsupport" defaultValue="该物流商不支持物流跟踪" />",2);
				return;
			}
			id = id[0].substring(1,id[0].length-1);
			fbk2 = fbk2.replace(/\s/g,"");
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'deliveryFlowList',
		        'windowTitle':'<i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" />',
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>ordermanage/materialVoucher/deliveryFlowList.jsp?id=' + id + '&order='+fbk2,
		        windowMinWidth: 520,
		        windowMinHeight: 500,
		        'windowWidth':520,
		        'windowHeight':500,
		        'parentPanel':".currDesktop"
		    });
		});
	});
		
		//退出
		$("#exitBtn").click(function(){
			if (winId != "null") {
				parent.elsDeskTop.closeCurWin(winId,closeCallback);
			} else {
				parent.elsDeskTop.closeCurWin('receiptConfirm',closeCallback);
			}
		});
		
		function closeCallback() {
			if (parent.frames["iframeApp_queryDelivery"]) {
				parent.frames["iframeApp_queryDelivery"].insertMaterialVoucherHeaderTable();
			}
		}
		
		$("#columnDefineBtn").click(function(){
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'subAccountColumnSetting',
		        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=receiptConfirm_mt" + "&window=iframeApp_receiptConfirm",
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':480,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		});
		$("#headColumnDefineBtn").click(function(){
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'subAccountColumnSetting',
		        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		        windowSubTitle: "",
		        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=receiptHead" + "&window=iframeApp_receiptConfirm",
		        windowMinWidth: 480,
		        windowMinHeight: 600,
		        'windowWidth':480,
		        'windowHeight':600,
		        'parentPanel':".currDesktop"
		    });
		});
		
		function refleshFileGrid(){
			if(fileGrid.rowsLength() > 0) {
				var fileRows = fileGrid.rows();
				for(var i = 0; i< fileRows.length; i++){
					var row = fileRows[i];
					if(row.createBy == elsAccount){
						row.fileStatus = 1;
						fileGrid.updateRow(row,i);
					}
				}
			}
		}
		
		function renderItemIsFinishCheckbox(val,item){
			var fbk14 = parseFloat(0);
			var wesbz = parseFloat(0);
			var wesbs = parseFloat(0);
			if(item.fbk14 && item.fbk14 != "")
				fbk14 = parseFloat(item.fbk14);
			if(item.wesbz && item.wesbz != "")
				wesbz = parseFloat(item.wesbz);
			if(item.wesbs && item.wesbs != "")
				wesbs = parseFloat(item.wesbs);
			if(val && val == "X")
				return "是";
			else if((fbk14 + wesbs) < wesbz)
				return "<input name='materialVoucherItemList[][fbk41]' type='checkbox' value='X' />";
			else 
				return "<input name='materialVoucherItemList[][fbk41]' type='checkbox' value='X' checked disabled/>";
		}
		
		function bindReceiptInput(){
		 	$("#materialVoucherItemTable").find("tr").each(function(){
		 		var itemData = $(this).data("item");
		 		var $fbk41 = $(this).find("input[name='materialVoucherItemList[][fbk41]']");
		 		$(this).find("input[name='materialVoucherItemList[][wesbs]']").keyup(function(){
					var val = $(this).val();
					if (isNaN(val)) {
						alert("<i18n:I18n key="i18n_alert_fillnumber" defaultValue="请输入数字" />",2);
						$(this).focus();
						return;
					}
					val = parseFloat(val);
			 		var wesbz = parseFloat(0);
			 		var fbk14 = parseFloat(0);
			 		if(itemData.wesbz && itemData.wesbz != "")
			 			wesbz = parseFloat(itemData.wesbz);
			 		if(itemData.fbk14 && itemData.fbk14 != "")
			 			fbk14 = parseFloat(itemData.fbk14);
			 		//输入的收货数量 < 发货数量，才允许手动打√
					if((val + fbk14) < wesbz){
						$fbk41.removeAttr("checked");
						$fbk41.removeAttr("disabled");
					}else{
						$fbk41.attr("checked",true);
						$fbk41.attr("disabled",true);
					}
		 		});
			});
		}
		
		function initAddFileDialog(){
			$(".dialog-tip").height(240);
			$("#fileName").attr("readonly",false);
		    $("#filePath").val(null);
		    $("#fileType").val(null);
		    $("#fileName").val(null);
		    $("#operTypeSelector").val("0");
		    $("#orderItemSelector").empty();
		    $("#divOrderItem").hide();
		    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" />');
		    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="上传文件" />');
		    $("#btnFileOK").unbind("click");
		    $("#btnFileOK").click(function(){addFormFile();});
		}
		function initModifyFileDialog(){
			$("#fileName").attr("readonly",true);
		    $("#filePath").val();
		    $("#fileType").val();
		    if(orderItemNumber){
		    	$(".dialog-tip").height(270);
		    	$("#operTypeSelector").val("1");
		    	loadOrderItem();
		    	$("#orderItemSelector").val(orderItemNumber);
		    }else{
		    	$(".dialog-tip").height(240);
		    	$("#operTypeSelector").val("0");
		        $("#orderItemSelector").empty();
		        $("#divOrderItem").hide();
		    }
			$("#fileName").val(fileName);
		    $("#dialogTitle").text('<i18n:I18n key="i18n_common_button_updatefile" defaultValue="修改表单文件" />');
		    $("#btnFileUpload").text('<i18n:I18n key="i18n_common_button_rechooseformfile" defaultValue="重传文件" />');
		    $("#btnFileOK").unbind("click");
		    $("#btnFileOK").click(function(){modifyFormFile();});
		}

		function getOrderItem(){
			$("#orderItemSelector").empty();
			var html = "";
			var trs = $("#materialVoucherItemTable").find("tr");
			for (var i=0;i<trs.length;i++){
				var data = trs.eq(i).data("item");
				if (data.materialVoucherNumber != "") 
					html += "<option value='"+data.materialVoucherItemNumber+"'>" + data.materialVoucherItemNumber + "_" + data.purchaseMaterialDesc + "</option>";
			}
			$("#orderItemSelector").append(html);
		}

		function loadOrderItem(){
			var isOrderItem = $("#operTypeSelector").val();
			if("1" == isOrderItem){
				$(".dialog-tip").height(270);
				$("#divOrderItem").show();
				getOrderItem();
			}else{
				$(".dialog-tip").height(240);
				$("#divOrderItem").hide();
				$("#orderItemSelector").empty();
			}
		}

		function addFormFile(){
			var fileName = $("#fileName").val();
			if (!fileName) {
				alert("<i18n:I18n key='i18n_delivery_enterfilename' defaultValue='请填写文件名称' />",2);
				return;
			}
			var filePath = $("#filePath").val();
			if(!filePath){
				alert("<i18n:I18n key='i18n_delivery_uploadfileplease' defaultValue='请上传文件' />",2);
				return;
			}
			var toElsAccount = itemGrid.row(0).toElsAccount;
			var isOrderItem = $("#operTypeSelector").val();
			var materialVoucherItemNumber = null;
			if(isOrderItem == 1)
				materialVoucherItemNumber = $("#orderItemSelector").val();
			var fileType = $("#fileType").val();
			var logtime = new Date();
			var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"mobileType":101,"fileStatus":0,"materialVoucherNumber":materialVoucherNumber,"materialVoucherItemNumber":materialVoucherItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : "<%=basePath%>rest/MaterialFormFileService/addMaterialFormFile",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data != null){
						fileGrid.addRow(data,fileGrid.rowsLength());
						$('.fixed-dialog').hide();
					}else{
						alert("<i18n:I18n key='i18n_delivery_filenameexist' defaultValue='该文件名已存在' />",2);
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}
		function modifyFormFile(){
			var fileName = $("#fileName").val();
			if (!fileName) {
				alert("<i18n:I18n key='i18n_delivery_enterfilename' defaultValue='请填写文件名称' />",2);
				return;
			}
			var toElsAccount = itemGrid.row(0).toElsAccount;
			var materialVoucherItemNumber = $("#orderItemSelector").val();
			var fileType = $("#fileType").val();
			var filePath = $("#filePath").val();
			var logtime = new Date();
			var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"toElsAccount":toElsAccount,"formId":formId,"mobileType":mobileType,"fileStatus":fileStatus,"materialVoucherNumber":materialVoucherNumber,"materialVoucherItemNumber":materialVoucherItemNumber,"fileType":fileType,"fileName":fileName,"filePath":filePath,"logtime":logtime};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : "<%=basePath%>rest/MaterialFormFileService/updateMaterialFormFile",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					var index = fileGrid.selectedRowsIndex()[0];
					fileGrid.updateRow(data,index);
					$('.fixed-dialog').hide();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		}
		function initFileUploader(fileUploader){
		    //新增表单文件
		    if (!fileUploader) {
		  	fileUploader = WebUploader.create({
		  	    // swf文件路径
		  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		  	    auto: true,
		  	    // 文件接收服务端。
		  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
		  	    // 选择文件的按钮。可选。
		  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		  	    pick: '#btnFileUpload',
		  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		  	    resize: false
		  	});
		  	fileUploader.on( 'uploadAccept', function( obj, response ) {
		  		if(0 == response.error){
		 	  	   var filePath = response.url;
			  	   var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
		  	  	   var noEdit = $("#fileName").attr("readonly");
		  	  	   if(!noEdit){
		  	  		$("#fileName").val(obj.file.name);
		  	  	   }
			       $("#filePath").val(filePath);
			       $("#fileType").val(fileType);
		  		}else{
		  			alert(response.message,2);
		  		}
		  	});
		    }
		}
		function initFileGrid(){
			if(!fileGrid){
				fileGrid = $('#table-file').mmGrid({
			        cols: cols_file,
			        items: [],
			        checkCol: true
			    });
			}
		}
		function loadFileItem(){
			var data = {"elsAccount":elsAccount,"materialVoucherNumber":materialVoucherNumber,"mobileType":"101"};
				$.ajax({
					url :"<%=basePath%>rest/MaterialFormFileService/findMaterialFormFile",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(data),
					dataType : "json",
					success : function(data) {
						fileGrid.load(data.rows);
					},
					error : function(data) {
		    			if (!permissionError(data)) {
		    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		    			}
					}
				});
		}
		$('#btnAddFile').click(function() {
	        $('.fixed-dialog').show();
	        initAddFileDialog();
	        initFileUploader(fileUploader);
		});
		$('#btnModifyFile').click(function() {
			var selectedIndexs = fileGrid.selectedRowsIndex();
			if (selectedIndexs.length == 0) {
				alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
				return;
			}
			var selectedRow = fileGrid.row(selectedIndexs[0]);
			if(selectedRow.createBy != elsAccount){
				alert("<i18n:I18n key='i18n_delivery_cantmodifytofile' defaultValue='对方文件不能修改' />",2);
				return;
			}
			formId = selectedRow.formId;
			fileName = selectedRow.fileName;
			fileStatus = selectedRow.fileStatus;
			mobileType = selectedRow.mobileType;
			orderItemNumber = selectedRow.materialVoucherItemNumber;
		    $('.fixed-dialog').show();
		    initModifyFileDialog();
		    initFileUploader(fileUploader);
		});
		$("#btnDeleteFile").click(function(){
			var selectedIndexs = fileGrid.selectedRowsIndex();
			if (selectedIndexs.length == 0) {
				alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
				return;
			}
			var selectedRow = fileGrid.row(selectedIndexs[0]);
			if(selectedRow.createBy != elsAccount){
				alert("<i18n:I18n key='i18n_delivery_cantdeletetofile' defaultValue='对方文件不能删除' />",2);
				return;
			}
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
			var data = {"formId":selectedRow.formId,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : "<%=basePath%>rest/MaterialFormFileService/deleteMaterialFormFile",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					fileGrid.removeRow(selectedIndexs[0]);
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
			var selectedRows = fileGrid.selectedRows();
			if(selectedRows.length == 0){
				alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
				return;
			}
			window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + selectedRows[0].filePath;
		});
		$("#btnViewFile").click(function(){
			var selectedRows = fileGrid.selectedRows();
			if(selectedRows.length == 0){
				alert("<i18n:I18n key='i18n_delivery_choosefileplease' defaultValue='请选择表单文件' />",2);
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
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
			}else {
				alert('<i18n:I18n key="i18n_alert_filetypenotsupport" defaultValue="不支持在线预览的文档类型!" />',2);
			}
		});
		function updateRowLink(itemNumber,wesbs){
			$("#materialVoucherItemTable").find("tr").each(function(){
				var data = $(this).data("item");
				if(itemNumber == data.materialVoucherItemNumber){
					$(this).find("input[name='materialVoucherItemList[][wesbs]']").val(wesbs);
				}
			});
		}
		$('.dialog-close-btn').click(function(){
		    $('.fixed-dialog').hide();
		});
		$('.tip-option-btn').click(function(){
		    $('.dialog-close-btn').trigger('click');
		});
	</script>
</body>
</html>