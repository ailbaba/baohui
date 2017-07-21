<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="updateBtn"><i18n:I18n key="i18n_delivery_button_updatereceipt" defaultValue="修改收货" /></button>
				<button id="deliveryFlowBtn" class="button-wrap"><i18n:I18n key="i18n_button_deliveryFlow" defaultValue="物流跟踪" /></button>
				<button class="button-wrap" id="toErpBtn"><i18n:I18n key="i18n_delivery_button_posttosap" defaultValue="过账到SAP" /></button>
				<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
				<button class="button-wrap" id="getERPMaterialVoucher">获取物料凭证</button>
				<button class="button-wrap" id="getK3Receipt">获取k3-PO累计入库数</button>
				<button class="button-wrap" id="timerGetK3Receipt">获取srm物料凭证</button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span><input id="purchaseOrderNumber" name="purchaseOrderNumber" type="text" /></div>
				<div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_delivery_lable_materialvouchernumber" defaultValue="发货单号" />：</span><input id="materialVoucherNumber" name="materialVoucherNumber" type="text" /></div>
				<div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_common_title_suppliername" defaultValue="供应商名称" />：</span><input id="companyShortName" name="companyShortName" type="text" /></div>
				<div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_delivery_lable_estimatedscene" defaultValue="预计到货日期" />：</span><input type="text" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" id="startReceiptDate" name="startReceiptDate"/>
                <span><i18n:I18n key="i18n_common_label_to" defaultValue="到" /> </span><input type="text" id="endReceiptDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="endReceiptDate"/></div>
				    <br>
                <div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_common_label_factory" defaultValue="工厂" />：</span><input id="fbk34" name="fbk34" type="text" /></div>
                <div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_common_label_trackNumber" defaultValue="跟踪号" />：</span><input id="fbk35" name="fbk35" type="text" /></div>
				<div class="dis-in-b input-and-tip"><span><i18n:I18n key="i18n_delivery_lable_deliveryStatus" defaultValue="单据状态" />：</span>
				    <select id="deliveryStatus" name="deliveryStatus">
                		<option value="0"><i18n:I18n key="i18n_delivery_select_deliveronway" defaultValue="发货在途" /></option>
                		<option value="2" selected><i18n:I18n key="i18n_delivery_lable_receipt" defaultValue="已收货" /></option>
                		<option value="3"><i18n:I18n key="i18n_delivery_lable_scene" defaultValue="到货" /></option>
                	</select>
               	</div>
				<button class="button-wrap" id="seachBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				<button  id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_materialvoucherheader" defaultValue="物料凭证抬头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="materialVoucherHeaderGrid">
							<table id="materialVoucherHeaderTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_delivery_lable_items" defaultValue="行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_title_purchaseOrder_item" defaultValue="采购行项目" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                    </ul>
                    <div id="sheet-project-one">
                    	<button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                        <main class="grid-container">
		                    <div class="grid-100"  id="materialVoucherItemGrid">
		                        <table id="table-item" id="materialVoucherItemTable"></table>
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
	</div>
	
	<div class="fixed-dialog" id="selectDialog">
           <div class="dialog-tip bg-common" style="width: 402px;height: auto; margin-left: -161px;margin-top: -190px;">
               <div class="dialog-close-btn" id="selectClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="test" defaultValue="获取K3物料凭证" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                     <form id="selectForm" onsubmit="return false;">
                       <div class="common-box-line" >
                           <div class="input-and-tip">
                               <span>采购订单:</span>
                               <input id="pOName" name="pOName" type="text" />
                            </div>
<!--                             <div class="input-and-tip"> -->
<!--                                <span>物料编号:</span> -->
<!--                                <input id="productName" name="productName" type="text" /> -->
<!--                             </div> -->
<!--                             <div class="input-and-tip"> -->
<!--                                <span>供应商号:</span> -->
<!--                                <input id="vendorName" name="vendorName" type="text" /> -->
<!--                             </div> -->
<!--                             <div class="input-and-tip"> -->
<!--                                <span>截止时间:</span> -->
<!--                                <input type="text" id="deliveryDate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="deliveryDate"/> -->
<!--                            </div> -->
	                       <div class="mt-20 text-center">
	                          <button id="selectOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                      <button id="selectCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
	                     </form>
                       </div>
                   </div>
             </div>
       </div>
	<script type="text/javascript">
// 	$(document).ready(function(){
		$("#elsAccount").val(elsAccount);
		$("#sheet-project").tabs({active: 0});
		var materialVoucherNumber="";
		var mobileType="101,102,103,105";
		var mobileTypeParam="";
		var itemMobileType = "101";
		var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="queryReceipt_head_mt"/>;
		var cols_item = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="queryReceipt_item_mt"/>;
		var headGrid;
		//将销售订单表头数据插入表格中
		function insertMaterialVoucherHeaderTable(){
			$('#materialVoucherHeaderGrid').html('<table id="materialVoucherHeaderTable"></table><div id="pg" style="text-align: right;"></div>');
			//列
	        var startReceiptDate = $("#startReceiptDate").val();
	        var endReceiptDate = $("#endReceiptDate").val();
	        var deliveryStatus = $("#deliveryStatus").val();
	        var companyName = $("#companyShortName").val();
			var paramStr={"companyShortName":companyName,"elsAccount":elsAccount,"startReceiptDate":startReceiptDate,"endReceiptDate":endReceiptDate,"deliveryStatus":deliveryStatus,"mobileType":mobileType,"purchaseOrderNumber":$("#purchaseOrderNumber").val(),"materialVoucherNumber":$("#materialVoucherNumber").val().trim(),"factory":$("#fbk34").val(),"trackNumber":$("#fbk35").val()};

		    //本地示例
		    headGrid= $('#materialVoucherHeaderTable').mmGrid({
		    	 cols: cols,
		         url: "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherHeaderByStatus",
		         params:paramStr,
		         method:'post',
		         root:"rows",
		         remoteSort:true,
		         checkCol:true,
		         loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		         noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		         plugins: [
		             $('#pg').mmPaginator({
		                 style: 'plain'
		                 , totalCountName: 'total'
		                 , page: 1
		                 , pageParamName: 'currentPage'
		                 , limitParamName: 'pageSize'
		                 , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
		                 , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
		                 , limit:null
		                 , limitList: [10,20]
		             })
		         ]
		    });
		    
		     headGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
		    	materialVoucherNumber=item.materialVoucherNumber;
		    	itemMobileType = item.mobileType;
		    	mobileTypeParam= item.mobileType;
		    	insertMaterialVoucherItemTable(materialVoucherNumber)
		    	insertDeliveryFile(materialVoucherNumber)
		     });
		    
		     headGrid.on('loadSuccess',function(e, data) {
			    	if(data.total>0){
			    		headGrid.select(0);
			    		materialVoucherNumber=data.rows[0].materialVoucherNumber;
			    		itemMobileType = data.rows[0].mobileType;
			    		mobileTypeParam= data.rows[0].mobileType;
			    		insertMaterialVoucherItemTable(materialVoucherNumber);
			    		insertDeliveryFile(materialVoucherNumber)
			    	}else{
			    		insertMaterialVoucherItemTable(null);
			    		insertDeliveryFile(null)
			    	}
			    	
			    	$('#materialVoucherHeaderTable').find("tr").each(function(){
			       	     var item = $(this).data("item");
			       	     if (item&&item.mobileType == "102") {
			       	    	$(this).css("color","red");
			       	     }
			       	});
			    });
		}
		
		insertMaterialVoucherHeaderTable();
		
		//点击查询
		$("#seachBtn").click(function(){
			insertMaterialVoucherHeaderTable();
		});
		
		function initQuantity(val,item,index){
			if(item && item.mobileType == "102"){
				return "-"+val;
			}
		}
		
		//将销售订单xiang数据插入表格中
		function insertMaterialVoucherItemTable(materialVoucherNumber){
			$('#materialVoucherItemGrid').html('<table id="materialVoucherItemTable"></table>')
			var paramStr={"elsAccount":elsAccount,"mobileType":itemMobileType,"materialVoucherNumber":materialVoucherNumber};
			//列
			
			if(materialVoucherNumber==null){
				//本地示例
			    $('#materialVoucherItemTable').mmGrid({
			        cols: cols_item,
			        items:[],
			        remoteSort:true,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}else{
				//本地示例
			    $('#materialVoucherItemTable').mmGrid({
			        cols: cols_item,
			        url : "<%=basePath%>rest/MaterialVoucherService/findMaterialVoucherItem",
			        params:paramStr,
			        method:'post',
			        root:"rows",
			        remoteSort:true,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}
		    
		}
		$("#deliveryFlowBtn").click(function(){
			if (headGrid.selectedRows().length==0) {
				alert("<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />",2);
				return;
			}
			var fbk1=headGrid.selectedRows()[0].fbk1;
			var fbk2=headGrid.selectedRows()[0].fbk2;
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
		 $('#updateBtn').click(function(){
				//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
				
				if(materialVoucherNumber==null||materialVoucherNumber==""||materialVoucherNumber==undefined){
					alert("<i18n:I18n key='i18n_delivery_choosereceivevoucher' defaultValue='请选择收货凭证！' />",2);
					return;
				}

			    var toCompanyName = "<%=request.getParameter("toCompanyName")%>";
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'updateReceipt',
			        'windowTitle':'<i18n:I18n key="i18n_delivery_windowtitle_queryreceipt" defaultValue="收货单查询" />',
			        windowSubTitle: companyShortName,
			        'iframSrc':"<%=basePath%>ordermanage/materialVoucher/updateReceipt.jsp?materialVoucherNumber="+materialVoucherNumber,
			        windowStatus: 'maximized',
			        windowMinWidth: 960,
			        windowMinHeight: 700,
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop"
			    });
			});
		 
			//退出
			$("#exitBtn").click(function(){
				if (winId) {
					parent.elsDeskTop.closeCurWin(winId,closeCallback);
				} else {
					parent.elsDeskTop.closeCurWin('queryReceipt',closeCallback);
				}
			});
			
			function closeCallback(){}
			
// 	});


			$("#columnDefineBtn").click(function(){
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'subAccountColumnSetting',
			        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
			        windowSubTitle: "",
			        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryReceipt_head_mt" + "&window=iframeApp_queryReceipt",
			        windowMinWidth: 480,
			        windowMinHeight: 600,
			        'windowWidth':480,
			        'windowHeight':600,
			        'parentPanel':".currDesktop"
			    });
			});


			$("#itemColumnDefineBtn").click(function(){
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'subAccountColumnSetting',
			        'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
			        windowSubTitle: "",
			        'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=queryReceipt_item_mt" + "&window=iframeApp_queryReceipt",
			        windowMinWidth: 480,
			        windowMinHeight: 600,
			        'windowWidth':480,
			        'windowHeight':600,
			        'parentPanel':".currDesktop"
			    });
			});
			
			function insertDeliveryFile(materialVoucherNumber){
				$('#fileGrid').html('<table id="fileTable"></table>')
				var cols_file = [
				                 {title:'<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" />', name:'filePath', width: 80, align: 'center',renderer:function(val){
				                	 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/downloadServlet?filePath="+ val +"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
				                 }},
				                 {title:'<i18n:I18n key="i18n_common_title_myelsaccount" defaultValue="本方ELS号" />', name:'elsAccount', width: 150, align: 'center'},
				                 { title:'<i18n:I18n key="i18n_label_additionCost_toElsAccount" defaultValue="对方ELS号" />', name:'toElsAccount' ,width:150, align:'center'},
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
				                }},
				                 { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
					                  	if (val == elsAccount) {
					                 		return '<i18n:I18n key="i18n_label_self" defaultValue="已方" />';
					                 	} else {
					                 		return '<i18n:I18n key="i18n_label_otherSide" defaultValue="对方" />';
					                 	} 
					            }}
				             ];
				
				if(materialVoucherNumber==null){
					$('#fileTable').mmGrid({
				        cols: cols_file,
				        items:[],
				        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
				        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
				    });
				}else{
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
			}
			
			//采购订单过账到sap
			$("#toErpBtn").click(function(){
				parent.elsDeskTop.showLoading();
				var json={"materialVoucherNumber":materialVoucherNumber,"elsAccount":elsAccount,"mobileType":mobileTypeParam}
				var paramStr = JSON.stringify(json);
//			 	return;
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
			});
			
			$("#getERPMaterialVoucher").click(function(){
						parent.elsDeskTop.showLoading();
						$.ajax({
							url : "<%=basePath%>rest/MaterialVoucherService/syncMV",
							type : "get",
							dataType : "json",
							contentType : "application/json",
							success : function(data) {
								parent.elsDeskTop.hideLoading();
								if(data!=null&&data.statusCode=="-100"){
									alert(data.message,2);
								}else{
									alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
								}
							},
							error : function(data) {
								parent.elsDeskTop.hideLoading();
				    			if (!permissionError(data)) {
				    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				    			}
							}
						});
					});
//获取mes物料凭证--------
$("#getK3Receipt").click(function(){
	$("#selectDialog").show();
});

$("#selectClose").click(function(){
	$("#selectDialog").hide();
});

$("#selectCancel").click(function(){
	$("#selectDialog").hide();
});

//送检弹出框确认操作
$("#selectOK").click(function(){
	var item = $("#selectForm").serializeJSON()
	debugger;
	var deliveryDate = item.deliveryDate;
// 	if($.trim(deliveryDate) == ""){
// 		alert("截止时间不能为空！",2);
// 		return;
// 	}
	item["elsAccount"]=elsAccount;
	parent.elsDeskTop.showLoading("获取k3中。");
	$.ajax({
		url :"<%=basePath%>rest/MaterialVoucherService/getK3Receipt",
		type :"post",
		contentType : "application/json",
		data:JSON.stringify(item),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.statusCode == "-100"){
				alert(data.message , 2);
				return;
			}
			$("#selectDialog").hide();
			alert("操作成功！",1);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert(data,3);
		}
	});
});

// 获取srm物料凭证 @author update/jiangzhidong @date 20170118 begin
$("#timerGetK3Receipt").click(function(){
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="获取srm物料凭证?" />',closeEvent:function(){
		debugger;
		var item = $("#selectForm").serializeJSON()
		item["elsAccount"]=elsAccount;
		parent.elsDeskTop.showLoading("获取srm中。");
		$.ajax({
			url :"<%=basePath%>rest/MaterialVoucherService/timerGetK3Receipt",
			type :"post",
			contentType : "application/json",
			data:JSON.stringify(item),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data.statusCode == "-100"){
					alert(data.message , 2);
					return;
				}
				alert("操作成功！",1);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert(data.responseText,3);
			}
		});
	}});
});
//获取srm物料凭证 @author update/jiangzhidong @date 20170118 end

</script>
</body>
</html>