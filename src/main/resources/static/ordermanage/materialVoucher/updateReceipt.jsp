<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
<!--                 <button class="button-wrap" id="saveBtn">保存</button> -->
                <button class="button-wrap" id="reverseBtn"><i18n:I18n key="i18n_label_writeoff" defaultValue="冲销" /></button>
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
					<input type="hidden" id="elsAccountParam"
						name="materialVoucherHeaderVO[elsAccount]" /> <input
						type="hidden" id="elsSubAccountParam"
						name="materialVoucherHeaderVO[elsSubAccount]" /> <input
						type="hidden" class="deliveryStatusParam"
						name="materialVoucherHeaderVO[deliveryStatus]" /> <input
						type="hidden" id="materialVoucherNumberParam"
						name="materialVoucherHeaderVO[materialVoucherNumber]" />
						<input
						type="hidden" id="toMaterialVoucherNumberParam"
						name="materialVoucherHeaderVO[toMaterialVoucherNumber]" />
<!-- 						<input -->
<!-- 						type="hidden" id="mobileTypeParam" -->
<!-- 						name="materialVoucherHeaderVO[mobileType]"  value="101"/> -->
					<main class="grid-container">
					<div class="grid-100" id="materialVoucherItemGrid">
						<table id="materialVoucherItemTable"></table>
					</div>
					</main>
                    </div>
                    <div id="sheet-project-two">
                        <main class="grid-container">
		                    <div class="grid-100" id="fileGrid">
		                        <table id="fileTable" ></table>
		                    </div>
		                </main>
                    </div>
				</div>
			</div>
		</div>
	</form>
	</div>
	<script type="text/javascript">
	var materialVoucherNumber=GetQueryString("materialVoucherNumber");
	var mobileType="101,103,105";
	var toElsAccount;
	var fbk1 = "";
	var fbk2 = "";
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="receiptConfirm_mt"/>;
	var cols_head = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="receiptHead"/>;
	var headGrid;
	var itemGrid;
	var resevertTag="";
	var isInit=true;//是第一次加载数据
	$(document).ready(function() {
		
		$("#sheet-head").tabs();
		$("#sheet-project").tabs();
		$("#elsAccountParam").val(elsAccount);
		$("#elsSubAccountParam").val(elsSubAccount);
		$("#materialVoucherNumberParam").val(materialVoucherNumber);
		$("#mobileType").val(mobileType);
		
		//得到订单头部信息
		function getSaleOrderHeadBySaleOrderNumber(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherHeaderByStatus",
				type :"POST",
				contentType : "application/json",
				data : '{"elsAccount":"'+elsAccount+'","mobileType":"'+mobileType+'","materialVoucherNumber":"'+materialVoucherNumber+'"}',
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
// 					var data=data.rows[0];
					mobileType = data.rows[0].mobileType;
// 					$("#fbk1").val(data.fbk1);
// 					$("#fbk2").val(data.fbk2);
// 					$("#fbk3").val(data.fbk3);
// 					$("#saleOrderNumber").val(data.saleOrderNumber);
// 					$("#purchaseOrderNumber").val(data.purchaseOrderNumber);
// 					$("#materialVoucherNumber").val(data.materialVoucherNumber);
// 					$("#voucherDate").val(new Date(data.voucherDate).format("yyyy-MM-dd"));
// 					$("#postDate").val(new Date(data.postDate).format("yyyy-MM-dd"));
// 					$("#mobileType").val(data.mobileType);
// 					$("#deliveryStatus").val(data.deliveryStatus);
// 					$("#toMaterialVoucherNumber").val(data.toMaterialVoucherNumber);
// 					$("#toMaterialVoucherNumberParam").val(data.toMaterialVoucherNumber);
// 					$("#status").html(showStatus(data.deliveryStatus));
					if(headGrid==null){
						headGrid= $('#table-head').mmGrid({
					        cols: cols_head,
					        items:data.rows,
					        height:100,
					    });
					
						headGrid.on('loadSuccess',function(e, data) {
							resevertTag=data.fbk10;
							if(resevertTag=="Y"){
								$("#reverseBtn").hide();
							}
							  $("#table-head").find("span input").attr("readOnly",true);
							  $("#table-head").find("select").attr("readOnly",true);
							  $("#table-head").find("select").attr("style","pointer-events: none;");
						});
					}else{
						isInit=false;
						headGrid.load(data.rows);
					}
					
					if (data.rows[0].fbk1) {
						fbk1 = data.rows[0].fbk1;
					}
					if (data.rows[0].fbk2) {
						fbk2 = data.rows[0].fbk2;
					}
					if(isInit){//是第一次加载头数据
						insertMaterialVoucherItemTable();
						insertDeliveryFile();
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

		//显示当前销售订单状态
		function showStatus(deliveryStatus){
			var str = "<i18n:I18n key='i18n_label_currentstate' defaultValue='目前状态' />：<i18n:I18n key='i18n_label_receivingnote' defaultValue='收货单' />";
			if(deliveryStatus == 0){//销售订单未确认
				return str += " --> <i18n:I18n key='i18n_delivery_select_notdeliver' defaultValue='未发货' />";
			}else if(deliveryStatus == 1){//订单已确认
				str += " --> <i18n:I18n key='i18n_delivery_select_deliveronway' defaultValue='发货在途' />";
			}else if(deliveryStatus == 2){//订单已确认
				str += " --> <i18n:I18n key='i18n_delivery_lable_receipt' defaultValue='已收货' />";
			}else if(deliveryStatus == 3){//订单更改生产状态
				str += " --> <i18n:I18n key='i18n_delivery_lable_scene' defaultValue='到货' />";
			}
			return str;
		}
		
		getSaleOrderHeadBySaleOrderNumber();
		
		function insertMaterialVoucherItemTable(){
			$('#materialVoucherItemGrid').html('<table id="materialVoucherItemTable"></table>')
			var paramStr={"elsAccount":elsAccount,"mobileType":mobileType,"materialVoucherNumber":materialVoucherNumber};
			//列
		    var height=$(document).height()-305;
		    //本地示例
		    if(itemGrid==null){
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
								var url = "<%=basePath%>ordermanage/materialVoucher/editReceiptPackage.jsp?materialVoucherNumber=" + materialVoucherNumber + "&materialVoucherItemNumber=" + materialVoucherItemNumber+"&mobileType="+mobileType;
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
					   $("#materialVoucherItemTable").find("span input").attr("readOnly",true);
					});
		    }else{
<%-- 		    	itemGrid.opts.url = "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherItem"; --%>
// 		    	itemGrid.opts.params=paramStr;
// 		    	itemGrid.opts.root="rows";
// 		    	itemGrid.load({});
		    }
		}
		
		//保存
		$("#saveBtn").click(function(){
			var frm=$("#form")
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_label_confirmmodification" defaultValue="是否确认修改？" />',closeEvent:function(){
		    parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url :"<%=basePath%>rest/MaterialVoucherService/updateReceiptMaterialVoucher",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key="i18n_label_operationfailed" defaultValue="冲销操作失败" />",3);
				}
			});
			}});
		});
		
		//冲销
		$("#reverseBtn").click(function(){
			var frm=$("#form");
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_label_confirmsterilization" defaultValue="是否确认冲销？" />',closeEvent:function(){
		    parent.elsDeskTop.showLoading();
	    	$.ajax({
	    		url :"<%=basePath%>rest/MaterialVoucherService/reverseReceiptMaterialVoucher",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if(data.statusCode=="-100"){
						alert(data.message,2);
					}else{
						getSaleOrderHeadBySaleOrderNumber();
						alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
					}
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key="i18n_label_operationfailed" defaultValue="冲销操作失败" />",3);
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
		//退出
		$("#exitBtn").click(function(){
			if (winId) {
				parent.elsDeskTop.closeCurWin(winId,closeCallback);
			} else {
				parent.elsDeskTop.closeCurWin('updateReceipt',closeCallback);
			}
		});
		
		function closeCallback() {
			if (parent.frames["iframeApp_queryReceipt"]) {
				parent.frames["iframeApp_queryReceipt"].insertMaterialVoucherHeaderTable();
			}
		}

	});
	
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'subAccountColumnSetting',
	        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=receiptConfirm_mt" + "&window=iframeApp_updateReceipt",
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
	        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=receiptHead" + "&window=iframeApp_updateReceipt",
	        windowMinWidth: 480,
	        windowMinHeight: 600,
	        'windowWidth':480,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	
	function updateRowLink(itemNumber,wesbs){
		$("#materialVoucherItemTable").find("tr").each(function(){
			var data = $(this).data("item");
			if(itemNumber == data.materialVoucherItemNumber){
				$(this).find("input[name='materialVoucherItemList[][wesbs]']").val(wesbs);
			}
		});
	}
	
	function insertDeliveryFile(){
		$('#fileGrid').html('<table id="fileTable"></table>')
		var cols_file = [
		                 {title:'<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" />', name:'filePath', width: 80, align: 'center',renderer:function(val){
		                	 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/downloadServlet?filePath="+ val +"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
		                 }},
		                 {title:'<i18n:I18n key="i18n_common_purchaseels" defaultValue="采购方ELS号" />', name:'elsAccount', width: 150, align: 'center'},
		                 { title:'<i18n:I18n key="i18n_common_saleels" defaultValue="销售方ELS号" />', name:'toElsAccount' ,width:150, align:'center'},
		                 { title:'<i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="物料凭证编号" />', name:'materialVoucherNumber' ,width:180, align:'center'},
		                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'materialVoucherItemNumber' ,width:90, align:'center',renderer:function(val){
			                 	if (val == ""||val== null) {
			                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialheader" defaultValue="凭证头文件" />';
			                	} else{
			                		return '<i18n:I18n key="i18n_common_lable_fileofmaterialitem" defaultValue="凭证项文件" />';
			                	}
			                }},
		                 { title:'<i18n:I18n key="i18n_common_title_materialvoucheritemnumber" defaultValue="物料凭证项编号" />', name:'materialVoucherItemNumber' ,width:150, align:'center'},
		                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型" />', name:'fileType' ,width:150, align:'center'},
		                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
		                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="待发状态" />', name:'fileStatus' ,width:150, align:'center',renderer:function(val){
		                 	if (val == "0") {
		                		return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
		                	} else if (val == "1") {
		                		return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
		                	} else if (val == "2") {
		                		return '<i18n:I18n key="i18n_common_title_sendstatus_received" defaultValue="已接收" />';
		                	}
		                }}
		             ];
		
			var paramStr={"materialVoucherNumber":materialVoucherNumber,"elsAccount":elsAccount,"mobileType":"101"}
			$('#fileTable').mmGrid({
		        cols: cols_file,
		        url : "<%=basePath%>rest/MaterialFormFileService/findMaterialFormFile",
		        params:paramStr,
		        method:'post',
		        root:"rows",
		        remoteSort:true,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
		    });
	}
	
	var renderItemIsFinishCheckbox = function(val,item){
		if(val && val == "1")
			return "是";
		else
			return "<input name='materialVoucherItemList[][fbk41]' type='checkbox' value='1' />";
	}
    var materialAttrsRender = function(){
		
	}
	
</script>
</body>
</html>