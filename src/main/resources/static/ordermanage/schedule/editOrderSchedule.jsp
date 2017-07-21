<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String businessElsAccount = request.getParameter("businessElsAccount");
String purchaseOrderNumber = request.getParameter("purchaseOrderNumber");
String orderItemNumber = request.getParameter("orderItemNumber");
%>

<body>
<!--引入CSS-->
	<link rel="stylesheet" type="text/css"
		href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
	<!--引入JS-->
	<script type="text/javascript"
		src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="saveBtn" class="editBtn button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="downloadBtn" class="editBtn button-wrap"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="Excel模板下载" /></button>
				<button id="uploadBtn" class="btnUpload editBtn button-wrap"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
	<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
		<input type="hidden" name="businessElsAccount" value="<%=businessElsAccount%>"/>
		<input type="hidden" name="purchaseOrderNumber" value="<%=purchaseOrderNumber%>"/>
		<input type="hidden" name="elsAccount" value="${elsAccount}"/>
		<input type="hidden" name="elsSubAccount" value="${elsSubAccount}"/>
		<input type="hidden" name="companyShortName" value="${companyShortName}"/>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_purchaseOrder_item" defaultValue="采购行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<main class="grid-container">
					<div class="grid-100">
						<table id="table-head"></table>
					</div>
					</main>
				</div>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_projectSchedule" defaultValue="项目进度" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
				<select id="itemSelector" onchange="filterSchedule()">
					<option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
				</select>
				<button style="margin-left: 10px;margin-bottom:10px;" id="fillTime" class="button-wrap"><i18n:I18n key="i18n_label_fillcolumn" defaultValue="填充列" /></button>
				<button style="margin-left: 10px;margin-bottom:10px;display:none;" id="genPlanTime" class="button-wrap">生成计划时间</button>
				</div>
				<div class="tab-wrap" id="sheet-head">
					<main class="grid-container">
					<div class="grid-100" id="tableItem">
						<table id="table-item"></table>
					</div>
					</main>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript">
var businessElsAccount = "<%=businessElsAccount%>";
var purchaseOrderNumber = "<%=purchaseOrderNumber%>";
var orderItemNumber = "<%=orderItemNumber%>";
var headGrid;
var itemGrid;
var readOnlyFlag = false;
if (elsAccount == businessElsAccount) {
	readOnlyFlag = true;
	$("#genPlanTime").show();
	$("#genPlanTime").click(function(){
		parent.elsDeskTop.showLoading();
		$.ajax({
			url :"<%=basePath%>rest/OrderScheduleService/genPlanTime/"+purchaseOrderNumber+"/"+businessElsAccount,
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				itemGrid.load(data);
			},
			error:function(data){
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
			    	alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
				}
			}
		});
	});
// 	$(".editBtn").remove();
}
var cols_head = [
					{ title:'<i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />',name:'purchaseOrderNumber' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="行项目号" />',name:'orderItemNumber' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_common_label_materialnumber" defaultValue="物料编码" />',name:'materialNumber' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_common_label_materialdescribe" defaultValue="物料描述" />',name:'materialDesc' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />',name:'quantity' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_common_title_fbk20" defaultValue="采购方物料规格" />',name:'fbk20' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_common_title_fbk21" defaultValue="采购方物料属性" />',name:'fbk21' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_saleorder_title_salematerialnumber" defaultValue="销售方物料号" />',name:'supplierMaterialNumber' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_common_title_fbk26" defaultValue="销售方规格" />',name:'fbk26' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_saleorder_title_fbk27" defaultValue="销售方物料属性" />',name:'fbk27' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_common_label_trackNumber" defaultValue="跟踪号" />',name:'trackNumber' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_label_requiredDeliveryTime" defaultValue="要求交期" />',name:'deliveryDate' ,width:100, align:'center',renderer:function(val){
						return dateFormat(val,"yyyy-MM-dd");
					}}
                 ];
var cols_item = [
					{ title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />',name:'templateCode' ,width:100, align:'center',hidden:true,renderer:function(val,data){
						return "<span>" + val + "</span><input type='hidden' name='steps[][templateCode]' value='" + val + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />',name:'purchaseOrderNumber' ,width:100, align:'center',renderer:function(val,data){
						return "<span>" + val + "</span><input type='hidden' name='steps[][purchaseOrderNumber]' value='" + val + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="行项目号" />',name:'orderItemNumber' ,width:100, align:'center',renderer:function(val){
						return "<span>" + val + "</span><input type='hidden' class='orderItemNumber' name='steps[][orderItemNumber]' value='" + val + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_stepCode" defaultValue="步骤编号" />',name:'stepCode' ,width:100, align:'center',renderer:function(val){
						return "<span>" + val + "</span><input type='hidden' name='steps[][stepCode]' value='" + val + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_stepName" defaultValue="步骤名称" />',name:'stepName' ,width:100, align:'center',renderer:function(val){
						return "<span>" + val + "</span><input type='hidden' name='steps[][stepName]' value='" + val + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_planFinishTime" defaultValue="采购方预计完成时间" />',name:'planFinishTime' ,width:100, align:'center',renderer:function(val){
						return "<input type='text' class='Wdate purchaseEdit' style='width:135px;'  onfocus='WdatePicker()' name='steps[][planFinishTime]' value='" + dateFormat(val) + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_factFinishTime" defaultValue="采购方实际完成时间" />',name:'factFinishTime' ,width:150, align:'center',renderer:function(val){
						return "<input type='text' class='Wdate purchaseEdit' style='width:135px;'  onfocus='WdatePicker()' name='steps[][factFinishTime]' value='" + dateFormat(val) + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_saleplanFinishTime" defaultValue="销售方预计完成时间" />',name:'salePlanFinishTime' ,width:100, align:'center',renderer:function(val){
						return "<input type='text' class='Wdate saleEdit' style='width:135px;'  onfocus='WdatePicker()' name='steps[][salePlanFinishTime]' value='" + dateFormat(val) + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_salefactFinishTime" defaultValue="销售方实际完成时间" />',name:'saleFactFinishTime' ,width:100, align:'center',renderer:function(val){
						return "<input type='text' class='Wdate saleEdit' style='width:135px;'  onfocus='WdatePicker()' name='steps[][saleFactFinishTime]' value='" + dateFormat(val) + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_factFinishQuantity" defaultValue="实际完成数量" />',name:'factFinishQuantity' ,width:100, align:'center',renderer:function(val){
						if (!val) {
							val = "0.00";
						}
						return "<input type='text' style='width:135px;' class='saleEdit' name='steps[][factFinishQuantity]' value='" + val + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_logtime" defaultValue="更新时间" />',name:'logtime' ,width:130, align:'center',renderer:timeFormat},
					{ title:'<i18n:I18n key="i18n_common_title_remarkbysupplier" defaultValue="供应商备注" />',name:'remark' ,width:100, align:'center',renderer:function(val){
						if (!val) {
							val = "";
						}
						return "<input type='text' name='steps[][remark]' class='saleEdit' style='width:185px;' value='" + val + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_common_title_remarkbypurchase" defaultValue="采购方备注" />',name:'fbk1' ,width:100, align:'center',renderer:function(val){
						if (!val) {
							val = "";
						}
						return "<input type='text' name='steps[][fbk1]' class='purchaseEdit' style='width:185px;' value='" + val + "'/>";
					}},
					{ title:'<i18n:I18n key="i18n_label_daopaistartdate" defaultValue="倒排开始日期" />',name:'daoPaiStartDate' ,width:100, align:'center'},
					{ title:'<i18n:I18n key="i18n_label_daopaienddate" defaultValue="倒排完成日期" />',name:'daoPaiEndDate' ,width:100, align:'center'},
	                { title:'<i18n:I18n key="i18n_schedule_title_estimatexxxx" defaultValue="预警天数" />', name:'warningDays' ,width:100, align:'center',hidden:true}
              ];               
$().ready(function(){
	init();
});

function init(){
	
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId);
		} else {
			parent.elsDeskTop.closeCurWin('editOrderSchedule');
		}
	});
	$("#saveBtn").click(function(){
		saveSchedule();
	});
	$("#downloadBtn").click(function(){
		downloadTemplate();
	});
	$("#fillTime").click(function(){
		fill();
	});
			
	uploadSchedule();
	// 加载订单项
	$.ajax({
		url :"<%=basePath%>rest/OrderScheduleService/getOrderSchedule/"+purchaseOrderNumber+"/"+businessElsAccount,
		type :"get",
		contentType : "application/json",
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			fillData(data);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				if (data.status == "401") {
					alert("<i18n:I18n key="i18n_alert_notemplate" defaultValue="没有找到匹配的进度模板" />",3);
			    }else if (data.status == "402") {
			    	alert("<i18n:I18n key="i18n_alert_noStep" defaultValue="进度模板没有配置步骤" />",3);
			    }else {
			    	alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
			    }
			}
			parent.elsDeskTop.closeCurWin('editOrderSchedule');
		}
	});
}
var deliveryItemArr = [];
function fillData(data) {
	if (data.rows[0].rows.length <= 200) {
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height: 100,
	        items:data.rows[0].rows
	    });
		headGrid.on('loadSuccess',function(e, d) {
			var html = "";
			var trs = $("#table-head").find("tr");
			for (var i=0;i<trs.length;i++){
				var item = trs.eq(i).data("item");
				if (item && item.orderItemNumber != "") {
					html += "<option value='"+item.orderItemNumber+"'>" + item.orderItemNumber + "_" + item.materialDesc + "</option>";
					deliveryItemArr.push(item.orderItemNumber);
				}
			}
			$("#itemSelector").append(html);
			itemGrid = $('#table-item').mmGrid({
		        cols: cols_item,
		        checkCol:true,
		        multiSelect: true,
		        items:data.rows[1].rows
		    });
			itemGrid.on('loadSuccess',function(e, d) {
				if (readOnlyFlag) {
					$(".saleEdit").each(function(){
						var name=$(this).attr("name");
						var val=$(this).val();
						var str="<span>" + val + "</span><input type='hidden' name='"+name+"' value='" + val + "'/>";
						$(this).parent().html(str);
					});
				}else{
					$(".purchaseEdit").each(function(){
						var name=$(this).attr("name");
						var val=$(this).val();
						var str="<span>" + val + "</span><input type='hidden' name='"+name+"' value='" + val + "'/>";
						$(this).parent().html(str);
					});
				}
				showCheck();
				if (orderItemNumber != "null") {
					$("#itemSelector").val(orderItemNumber);
					filterSchedule();
				}
				//高亮
		        $('#table-item').find("tr").each(function(){
		        	var item = $(this).data("item");
		        	var curr = new Date();
		        	var daoPaiEndDate = new Date(item.daoPaiEndDate);
		        	if(item.saleFactFinishTime && item.saleFactFinishTime != ""){
			        	var saleFactFinishDate = new Date(item.saleFactFinishTime);
				        if (saleFactFinishDate > daoPaiEndDate) {
				        	$(this).css("background-color","rgba(213, 58, 58, 0.0980392)");
				        }
		        	}else{
		        		daoPaiEndDate.setDate(daoPaiEndDate.getDate() - item.warningDays);
		        		if(curr >= daoPaiEndDate){
		        			$(this).css("background","yellow");
		        		}
		        	}
			   });
			});
		});
	} else {
		loadPartItem(0,200,data.rows);
	}
}
function loadPartItem(start,size,data) {
	var array = [];
	for (var i=0;i<size;i++) {
		array[i] = data[0].rows[start+i];
	}
	start = start + size;
	if(headGrid){
		headGrid.addRows(array);
	} else {
		headGrid = $('#table-head').mmGrid({
	        cols: cols_head,
	        height: 100,
	        items:array
	    });
	}
	if (start < data[0].rows.length) {
		setTimeout(function(){
			if (data[0].rows.length - start > 200) {
				loadPartItem(start,200,data);
			} else {
				loadPartItem(start,data[0].rows.length-start,data);
			}
		},200);
	} else {
		var html = "";
		var trs = $("#table-head").find("tr");
		for (var i=0;i<trs.length;i++){
			var item = trs.eq(i).data("item");
			if (item && item.orderItemNumber != "") {
				html += "<option value='"+item.orderItemNumber+"'>" + item.orderItemNumber + "_" + item.materialDesc + "</option>";
				deliveryItemArr.push(item.orderItemNumber);
			}
		}
		$("#itemSelector").append(html);
		loadPartStep(0,200,data);
	}
}
function loadPartStep(start,size,data) {
	var array = [];
	for (var i=0;i<size;i++) {
		array[i] = data[1].rows[start+i];
	}
	start = start + size;
	if (itemGrid) {
		itemGrid.addRows(array);
	} else {
		itemGrid = $('#table-item').mmGrid({
	        cols: cols_item,
	        items:array
	    });
	}
	if (start < data[1].rows.length) {
		setTimeout(function(){
			if (data[1].rows.length - start > 200) {
				loadPartStep(start,200,data);
			} else {
				loadPartStep(start,data[1].rows.length-start,data);
			}
		},200);
	} else {
		if (readOnlyFlag) {
			$("span input").not(":hidden").not(":checkbox").each(function(){
				$(this).parent().html($(this).val());
			});
		}
		if (orderItemNumber != "null") {
			$("#itemSelector").val(orderItemNumber);
			filterSchedule();
		}
	}
}
function filterSchedule() {
	var orderItemNumber = $("#itemSelector").val();
	if (orderItemNumber == "") {
		$('#table-item').find("tr").show();
	} else {
		$(".orderItemNumber").each(function(){
			if (deliveryItemArr.indexOf($(this).val()) == -1) {
				$(this).parent().parent().parent().remove();
				return;
			}
			if ($(this).val()==orderItemNumber) {
				$(this).parent().parent().parent().show();
			} else {
				$(this).parent().parent().parent().hide();
			}
		});
	}
	itemGrid.deselect("all");
}
function saveSchedule() {
	parent.elsDeskTop.showLoading();
	var frm = $("#form");
	$.ajax({
		url :"<%=basePath%>rest/OrderScheduleService/saveScheduleStep",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
			window.location.reload();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}
function downloadTemplate() {

	window.location.href = "<%=basePath%>rest/OrderScheduleService/downloadTemplate/"+businessElsAccount + "/" + purchaseOrderNumber;
}
function uploadSchedule() {
	var uploader = WebUploader.create({
	    // swf文件路径
	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
	    auto: true,
	    duplicate :true,
	    accept:{
	    	extensions:"xls,xlsx"
	    },
	    // 文件接收服务端。
	    server: '<%=basePath%>rest/OrderScheduleService/uploadSchedule',
	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#uploadBtn',
	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	    resize: false
	});
	
	uploader.on( 'uploadAccept', function( file, response ) {
		if(response.statusCode=="-100"){
			alert("<i18n:I18n key="i18n_alert_importFormatError" defaultValue="导入文件格式不正确" />",3);
		}else{
			if (response.rows && response.rows.length > 0) {
				// 更新行
				var rows = itemGrid.rows();
				for (var i=0;i<rows.length;i++) {
					for (var j=0;j<response.rows.length;j++) {
						if (rows[i].orderItemNumber == response.rows[j].orderItemNumber && rows[i].stepCode == response.rows[j].stepCode) {
							if(readOnlyFlag){
								rows[i].planFinishTime = response.rows[j].planFinishTime;
								rows[i].factFinishTime = response.rows[j].factFinishTime;
								rows[i].fbk1 = response.rows[j].fbk1;
							}else{
								rows[i].salePlanFinishTime = response.rows[j].salePlanFinishTime;
								rows[i].saleFactFinishTime = response.rows[j].saleFactFinishTime;
								rows[i].factFinishQuantity = response.rows[j].factFinishQuantity;
								rows[i].remark = response.rows[j].remark;
							}
							break;
						}
					}
				}
				itemGrid.load(rows);
				showCheck();
		    }
		}
	});
}


//给可以填充的列添加选择框
function showCheck(){
	$("#tableItem").find("th").each(function(){
		var className=$(this).attr("class").split(" ")[0];
		var addCheck="<input type='checkbox' class='mmg-column-check'>";
		var count=$("."+className).find("input[name^='steps[]']").not(":hidden").length;
		if(count>0){
			if($(this).find(".mmg-titleWrapper .mmg-column-check").length<1){
				$(this).find(".mmg-titleWrapper").css('white-space','nowrap').prepend(addCheck);
			}
		}
	});
}

function fill(){
	var selecteds=$("#tableItem tr[class$='selected']");
	var columnSelected=$("#tableItem").find("th input:checked");          
	if(selecteds.length<1){
		alert("请选择填充行！",2);
		return;
	}
	if(columnSelected.length<1){
		alert("请选择填充列！",2);
		return;
	}
	$("#tableItem").find("th input:checked").each(function(){
		var className=$(this).parent().parent().attr("class").split(" ")[0];
		var val=selecteds.eq(0).find("."+className+" input").val();
		$("#tableItem tr[class$='selected']").each(function(){
			$(this).find("."+className+" input").val(val);
		});
	});
}

</script>
</body>
</html>