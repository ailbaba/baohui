<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
  	    <div class="box-wrap" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="查询条件" /></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                	    <td  class="tb-p"><i18n:I18n key="i18n_common_label_requisitionnumber" defaultValue="请求单号" />:</td>
	                		<td><input class="easyui-textbox"  style="width: 100px;" type="text" id="purchaseOrderNumber" /></td>
	                		<td  class="tb-p"><i18n:I18n key="i18n_common_label_requestdate" defaultValue="请求日期" />:</td>
	                		<td><input class="Wdate" onfocus="WdatePicker()" style="width: 100px;" type="text" id="requestDate" /></td>
	                		<!-- <td  class="tb-p">至:</td>
	                		<td><input class="easyui-textbox" style="width: 100px;" type="text" id="requestDate" /></td> -->
	                		<td  class="tb-p"><i18n:I18n key="i18n_common_label_materialnumber" defaultValue="物料编码" />:</td>
	                		<td><input class="easyui-textbox" style="width: 100px;" type="text" id="materialNumber" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                		<td  class="tb-p"><i18n:I18n key="i18n_common_label_purchasegroup" defaultValue="采购组" />:</td>
	                		<td><input class="easyui-textbox" style="width: 100px;" type="text" id="purchaseGroup_sap" /></td>
	                		<td  class="tb-p"><i18n:I18n key="i18n_common_label_factory" defaultValue="工厂" />:</td>
	                		<td style="width: 130px;"><input class="easyui-textbox" style="width: 100px;" type="text" id="factory_sap" /></td>
	                		<td  class="tb-p"><i18n:I18n key="i18n_common_label_trackingnumber" defaultValue="跟踪号" />:</td>
	                		<td style="width: 130px;"><input class="easyui-textbox" style="width: 100px;" type="text" id="trackNumber" /></td>
	                		<td><button id="btnAddEnquiryItemBySAPDialogQuery" class="button-wrap "><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button></td>
	                		<td></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="sap-material-table"></table>
                    </div>
                    <div class="mt-20 text-center" >
	                    <button id="btnAddEnquiryItemBySAPDialogOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnAddEnquiryItemBySAPDialogCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
</div>

<script>

var editFileTable;
var editTable;
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var userName = "<%=session.getAttribute("username")%>";
var fileUploader;
var excelUploader;
var addLadderPriceTable;
var selectUnitOfMeasurementTable;
var selectCostConstituteTemplateTable;
var selectCostConstituteTemplateItemTable;
var sapMaterialTable;
var selectPrincipalTable;
var orderType = 1;
var rightScroll;
var leftScroll;


$(document).ready(function(){
	init();
});	  
function formatDate(val){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
	     return val;
}
function init(){
	var colsMaterial = [
			            {title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="请求单号" />', name:'purchaseOrderNumber', width: 140, align: 'center'},
		                { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行项目号" />', name:'orderItemNumber' , width:140, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_label_trackingnumber" defaultValue="追踪号" />', name:'trackNumber' , width:120, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_requestdate" defaultValue="请求日期" />', name:'requestDate' ,width:100, align:'center' ,renderer:formatDate},
		                { title:'<i18n:I18n key="i18n_common_title_materialnumber" defaultValue="物料编码" />', name:'materialNumber' ,width:130, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述" />', name:'materialDesc' ,width:130, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_quantityrequired" defaultValue="需求数量" />', name:'quantity' ,width:130, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_unitofmeasurement" defaultValue="计量单位" />', name:'unitQuantity',width:150, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_deliverydate" defaultValue="需求日期" />', name:'deliveryDate' ,width:100, align:'center' ,renderer:formatDate},
		                { title:'<i18n:I18n key="i18n_common_title_materialgroup" defaultValue="物料组" />', name:'materialGroup' ,width:100, align:'center'},
		                { title:'<i18n:I18n key="i18n_enquiry_title_purchasegroup" defaultValue="采购组" />', name:'purchaseGroup' ,width:100, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_storagelocation" defaultValue="库存地点" />', name:'stockPoint' ,width:120, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_factory" defaultValue="工厂" />', name:'factory' ,width:100, align:'center'},
		                { title:'<i18n:I18n key="i18n_common_title_itemclasses" defaultValue="项目类别" />', name:'itemClasses' ,width:100, align:'center'}
			        ];
	
	if(!sapMaterialTable){
		sapMaterialTable=$('#sap-material-table').mmGrid({
			cols: colsMaterial,
			url: "<%=basePath%>rest/PurchaseEnquiryItemService/pullEnquiryMaterialLineBySAP/"+elsAccount,
            params: {"purchaseOrderNumber":"","requestDate":"","materialNumber":"","purchaseGroup":"","trackNumber":"","factory":""},
            method: 'post',
            root: 'rows',
            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
            indexCol:true,
            multiSelect:true,
            checkCol:true
         });
	}
}
//从sap获取物料信息弹出窗查询按钮单击事件
$("#btnAddEnquiryItemBySAPDialogQuery").click(function(){
	var purchaseOrderNumber = $("#purchaseOrderNumber").val();
	var requestDate = $("#requestDate").val();
	var materialNumber = $("#materialNumber").val();
	var purchaseGroup = $("#purchaseGroup_sap").val();
	var trackNumber = $("#trackNumber").val();
	var factory = $("#factory_sap").val();
	var param = {"purchaseOrderNumber":purchaseOrderNumber,"materialNumber":materialNumber,
			"purchaseGroup":purchaseGroup,"trackNumber":trackNumber,"requestDate":requestDate,"factory":factory};
	sapMaterialTable.load(param);
});

//从sap获取物料信息弹出窗确认按钮单击事件
$("#btnAddEnquiryItemBySAPDialogOK").click(function(){
	var selectRows = sapMaterialTable.selectedRows();
	if(selectRows.length == 0){
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_selectAtLeastOneRecord" defaultValue="至少选择一条数据！" />'});
	}
	var materialRows = editTable.rows();
	if(materialRows != "" && selectRows != null){
		for( var i = 0 ; i < materialRows.length ; i ++){
			for( var j = 0 ; j < selectRows.length ; j ++){
				var materialRow = materialRows[i];
				var selectRow = selectRows[j];
				var purchaseOrderNumber = materialRow.purchaseOrderNumber;
				var orderItemNumber = materialRow.orderItemNumber;
				var _purchaseOrderNumber = selectRow.purchaseOrderNumber;
				var _orderItemNumber = selectRow.orderItemNumber;
				if(purchaseOrderNumber == _purchaseOrderNumber && orderItemNumber == _orderItemNumber){
					selectRows.splice(j,1);//去重
				}
			}
		}
	}
    var rows = [];
	for(var i = 0 ; i < selectRows.length ; i++ ){ //设置初始值
		var selectRow = selectRows[i];
		selectRow["priceMetricQuantity"]=1;
		selectRow["quoteMethod"]=0;
		selectRow["currency"]="CNY";
		selectRow["isERP"]="yes";
		selectRow["priceQuantity"]=selectRow.unitQuantity;
		selectRow["quoteMethod_select"]=[{name:'<i18n:I18n key="i18n_ladderprice_select_normalBidding" defaultValue="常规报价" />',value:0},{name:'<i18n:I18n key="i18n_ladderprice_select_ladderBidding" defaultValue="阶梯报价" />',value:1}];
		selectRow["accessoryRequire"]=0;
		selectRow["accessoryRequire_select"]=[{name:'<i18n:I18n key="i18n_common_select_accessoryrequire_choosable" defaultValue="附件可选" />',value:0},{name:'<i18n:I18n key="i18n_common_select_accessoryrequire_require" defaultValue="必须附件" />',value:1}];
		//设置询价单头 询价单描述字段
		var materialDescHead = $("#materialDesc").val();
		if(materialDescHead == null || materialDescHead == ""){
			$("#materialDesc").val(selectRow.materialNumber+" - "+selectRow.materialDesc);
		}
		rows.push(selectRow);
	}
	//设置询价单类型下拉框为不可用
	$("#orderType").attr("disabled",true);
	$("#columnDefineBtn").attr("disabled",true);
    editTable.addRow(rows);
    
});
</script>

</body>
</html>
