<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="物料明细" key="i18n_requirementsPlanning_table_materialDetail"/></span>
            <div class="common-box-line">
               <main class="grid-container">
					<div class="edit-box-wrap" style="padding-top: 5px;">
					</div>
                    <div class="grid-100" id="materialDiv">
                        <table id="materialTable"></table>
                    </div>
               </main>
            </div>
        </div>
        
         <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="物料属性明细" key="i18n_materialList_title_materialAttributeDetail"/></span>
            <div class="common-box-line">
               <main class="grid-container">
					<div class="edit-box-wrap" style="padding-top: 5px;">
						<button id="addRowsBtn" class="button-wrap"><i18n:I18n defaultValue="新增行" key="i18n_delivery_button_createaitem"/></button>
						<button id="delRowsBtn" class="button-wrap"><i18n:I18n defaultValue="删除行" key="i18n_delivery_button_removeaitem"/></button>
						<button id="saveBtn" class="button-wrap"><i18n:I18n defaultValue="保存" key="i18n_button_save"/></button>
                		<button id="saveSendBtn" class="button-wrap"><i18n:I18n defaultValue="保存发送" key="i18n_button_saveSend"/></button>
					</div>
                    <div class="grid-100" id="attrDiv">
                        <table id="attrTable"></table>
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
	
	var materialCols = [
			{title : "ELS号",name : "elsAccount",width : 100,align : "center"},
			{title : "ELS描述",name : "elsDesc",width : 200,align : "center"},
			{title : "清单号",name : "quotationNumber",width : 100,align : "center"},
			{title : "物料号",name : "materialNumber",width : 100,align : "center"},
			{title : "物料描述",name : "materialDesc",width : 200,align : "center"},
			{title : "物料组",name : "materialGroup",width : 100,align : "center"},
			{title : "物料组描述",name : "materialGroupDesc",width : 200,align : "center"},
			{title : "物料类别",name : "materialCategory",width : 100,align : "center"},
			{title : "物料类别描述",name : "materialCategoryDesc",width : 200,align : "center"},
    ];
	
	var materialGrid = $("#materialTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/PurchaseMaterialListService/queryPurchaseMaterialListHead",
		method :  "POST",
		autoLoad : false,
		height : "200px",
		cols : materialCols,
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
        checkCol : true,
        indexCol : false,
	});
	
	var baseAttrCols = [
			{title : "ELS号",name : "elsAccount",width : 100,align : "center",hidden : true},
			{title : "ELS描述",name : "elsDesc",width : 200,align : "center",hidden : true},
			{title : "清单号",name : "quotationNumber",width : 100,align : "center",hidden : true},
			{title : "对方ELS号",name : "toElsAccount",width : 100,align : "center",hidden : false},
			{title : "对方ELS描述",name : "toElsDesc",width : 200,align : "center",hidden : false},
			{title : "供货编号",name : "supplyNumber",width : 100,align : "center",hidden : true},
			{title : "物料号",name : "materialNumber",width : 100,align : "center",hidden : false},
			{title : "物料描述",name : "materialDesc",width : 200,align : "center",hidden : true},
			{title : "物料组",name : "materialGroup",width : 100,align : "center",hidden : true},
			{title : "物料组描述",name : "materialGroupDesc",width : 200,align : "center",hidden : true},
			{title : "物料类别",name : "materialCategory",width : 100,align : "center",hidden : false},
			{title : "物料类别描述",name : "materialCategoryDesc",width : 200,align : "center",hidden : false},
    ];
	var attrGrid;
	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    var currDate = new Date();
	  	//初始化表头
	    var paramElsAccount = "${param.elsAccount}";
	    var paramQuotationNumber = "${param.quotationNumber}";
	    var paramMaterialNumber = "${param.materialNumber}";
	    var paramMaterialGroup = "${param.materialGroup}";
	    var paramMaterialCategory = "${param.materialCategory}";
		
	    var queryParam = {
	    	elsAccount : paramElsAccount,
	    	quotationNumber : paramQuotationNumber,
	    	materialNumber : paramMaterialNumber,
	    	materialGroup : paramMaterialGroup,
	    	materialCategory : paramMaterialCategory,
	    };
	    materialGrid.load(queryParam);
	}
	
	materialGrid.on("loadSuccess",function(e,data){
		materialGrid.select(0);//加载完默认选中第一行
		loadMaterialAttr(data.rows[0],0);
	});
	
	materialGrid.on("cellSelected",function(e, item, rowIndex, colIndex){
		loadMaterialAttr(item,rowIndex);
	});
	
	$("#saveBtn").click(function(){
		var attrRows = attrGrid.rowsLength()==0?[]:attrGrid.rows();
		if("undefied" != typeof(attrRows) && "[]" != attrRows && "" != attrRows){
			parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中' key='i18n_requirementsPlanning_alert_inTheSave'/>");
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/PurchaseMaterialListService/savePurchaseMaterialList",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(attrRows),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='保存成功' key='i18n_common_alert_savesuccess'/>",1);
					loadMaterialAttr(materialGrid.row(0),0);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='保存出错' key='i18n_common_alert_saveError'/>");
				}
			});
		}
	});
	
	$("#saveSendBtn").click(function(){
		var attrRows = attrGrid.rowsLength()==0?[]:attrGrid.rows();
		if("undefied" != typeof(attrRows) && "[]" != attrRows && "" != attrRows){
			parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='发送中' key='i18n_common_alert_sending'/>");
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/PurchaseMaterialListService/sendPurchaseMaterialList",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(attrRows),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='保存发送成功' key='i18n_common_alert_savesuccess'/>",1);
					loadMaterialAttr(materialGrid.row(0),0);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n defaultValue='保存发送出错' key='i18n_common_alert_saveError'/>",3);
				}
			});
		}
	});
	
	$("#addRowsBtn").click(function(){
		var selectRows = attrGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var record = selectRows[0];
			var selectIndex = attrGrid.selectedRowsIndex()[0];
			var createUser = record.createUser;
			var recordElsAccount = record.elsAccount;
			if(createUser == userName && elsAccount == recordElsAccount){
				var newRecordStr = JSON.stringify(record);//复制JSON数据,直接操作会将原JSON对象改掉
				var newRecord = JSON.parse(newRecordStr);
				newRecord["supplyNumber"]="";
				attrGrid.addRow(newRecord,selectIndex+1);
			} else {
				alert("<i18n:I18n defaultValue='非采购负责人,禁止修改' key='i18n_alert_canotUpd_notPurchaseDirector'/>",2);
			}
		} else {
			alert("必须选择一行为参照添加行",2);
		}
	});
	
	$("#delRowsBtn").click(function(){
		var selectRows = attrGrid.selectedRows();
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			var record = selectRows[0];
			var createUser = record.createUser;
			var recordElsAccount = record.elsAccount;
			var supplyNumber = record.supplyNumber;
			if(typeof(supplyNumber)=="undefined" || "" == supplyNumber ){//为空即页面新增尚未提交的,则页面直接删除即可
				var selectedIndexes = attrGrid.selectedRowsIndex();
				attrGrid.removeRow(selectedIndexes);
				for(var i=selectedIndexes.length;i>0;i--){
					totalAttrData.splice(selectedIndexes[i],1);
				}
			} else {//已存在数据,则先删除数据再删除页面
				if(createUser == userName && elsAccount == recordElsAccount){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/PurchaseMaterialListService/delPurchaseMaterialList",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(selectRows),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
							var selectedIndexes = attrGrid.selectedRowsIndex();
							attrGrid.removeRow(selectedIndexes);
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",1);
						}
					});
				} else {
					alert("<i18n:I18n defaultValue='非创建人,禁止删除' key='i18n_alert_canotDel_notPurchaseDirector'/>",2);
					return;
				}
			}
		}
	});
		
	function loadMaterialAttr(materialRow,rowIndex){
		var attrCols = JSON.parse(JSON.stringify(baseAttrCols));//复制baseAttrCols
		var param = {"elsAccount":materialRow.elsAccount,"materialCateCode":materialRow.materialCategory};
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/MaterialCateService/queryMaterialSpec",
			type : "post",
			dataType : "json",
			contentType : "application/json",
			data:JSON.stringify(param),
			success : function(data) {
				var rows = data.rows;
				if(typeof(rows)!="undefined" && rows.length > 0){
					for(var i=0;i<rows.length;i++){
						var record = { 
							title : rows[i].materialSpecName,
							name : getMaterialAttrName(rows[i].attrIndex),
							width : 200,
							align : "center",
							renderer : eval("attr"+rows[i].attrIndex+"Render"),
						};
						attrCols.push(record);
					}
				}
				
				var attrDiv = $("#attrDiv");
				attrDiv.empty();//清空attrTable重新加载
				$("<table id='attrTable'></table>").appendTo(attrDiv);
				attrGrid = $("#attrTable").mmGrid({
					url : "${pageContext.request.contextPath}/rest/PurchaseMaterialListService/queryPurchaseMaterialListDetail",
					method :  "POST",
					autoLoad : false,
					height : "300px",
					cols : attrCols,
					root : "rows",
					loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
					noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
					multiSelect : false,
			        checkCol : true,
			        indexCol : false,
				});
			    attrGrid.load(materialRow);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		});
	}
	
	function getMaterialAttrName(fieldIndex){
		if(typeof(fieldIndex)=="undefined" || ""==fieldIndex){
			return "materialAttribute1";//默认返回materialAttribute1
		} else {
			return "materialAttribute"+fieldIndex;
		}
	}
	
	/****************/
	$("#attrDiv input[type='text']").live('keyup',function(){
		var value = $(this).val();
		var name = $(this).attr("name");
		var rowIndex = $(this).closest("tr").index();
		var rowData = attrGrid.row(rowIndex);
		rowData[""+name] = value;//将值赋给mmgrid对象对应属性
	});
	
	function attr1Render(val,item,rowIndex){
		return "<input type='text' name='materialAttribute1' value='"+getStrValue(val)+"' />";
	}

	function attr2Render(val,item,rowIndex){
		return "<input type='text' name='materialAttribute2' value='"+getStrValue(val)+"' />";
	}
	
	function attr3Render(val,item,rowIndex){
		return "<input type='text' name='materialAttribute3' value='"+getStrValue(val)+"' />";
	}
	
	function attr4Render(val,item,rowIndex){
		return "<input type='text' name='materialAttribute4' value='"+getStrValue(val)+"' />";
	}
		
	function attr5Render(val,item,rowIndex){
		return "<input type='text' name='materialAttribute5' value='"+getStrValue(val)+"' />";
	}
	
	/****************/
	
	function getStrValue(val,defaultValue){
		if("undefined"==typeof(val) || null==val || "null"==val){
			if("undefined"==typeof(defaultValue) || null==defaultValue || "null"==defaultValue){
				return "";
			} else {
				return defaultValue;
			}
		} else {
			return val;
		}
	}
</script>
</body>
</html>