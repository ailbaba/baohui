<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" /></span>
            <div class="common-box-line">
                <button id="queryBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
                <button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create"/> </button>
                <button id="delBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete"/></button>
                <button id="quoteQueryBtn" class="button-wrap"><i18n:I18n defaultValue="报价明细查询" key="i18n_button_queryEnquiryDetail"/></button>
                <button id="columnDefineBtn"  class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="物料条件" key="i18n_materialList_title_materialCondition"/></span>
            <div class="common-box-line">
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="物料询单号" key="i18n_materialList_quotationNumber"/>:</span>
					<input type="text" id="quotationNumber" name="quotationNumber" />
				</div>	
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="物料编号" key="i18n_common_lable_materialnumber"/>:</span>
					<input type="text" id="materialNumber" name="materialNumber" width="100%"/>
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="物料描述" key="i18n_common_label_materialdescribe"/>:</span>
					<input type="text" id="materialDesc" name="materialDesc" />
				</div>
            </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="物料属性条件" key="i18n_materialList_title_materialAttributeCondition"/></span>
            <div class="common-box-line" id="attrSelectDiv">
				<div class="dis-in-b input-and-tip"> 
					<span><select name="attr"></select></span>
					<input type="text" name="attr" />
				</div>
            	<button id="addAttrCondBtn" class="button-wrap">+</button>
            </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="供应商条件" key="i18n_materialList_title_SupplierCondition"/></span>
            <div class="common-box-line" >
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="对方ELS号" key="i18n_label_additionCost_toElsAccount"/>:</span>
					<input type="text" id="toElsAccount" name="toElsAccount" />
				</div>
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="对方ELS描述" key="i18n_label_additionCost_toElsDesc"/>:</span>
					<input type="text" id="toElsDesc" name="toElsDesc" />
				</div>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="物料清单" key="i18n_common_title_billofmaterials"/></span>
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
			
	var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseMatertialListManage"/>;
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/PurchaseMaterialListService/queryPurchaseMaterialListHead",
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
		plugins : [
		    $("#headPage").mmPaginator({
		        style : "plain",
		        totalCountName : "total",
		        page : 1,
		        pageParamName : "currentPage",
		        limitParamName : "pageSize",
		        limitLabel : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
		        totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
		        limit : null,
		        limitList : [10,20]
		    })
		]
	}); 
	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    var currDate = new Date();
			    
	  	//初始化表头
	    var toElsAccount = $("#toElsAccount").val();
	    var toElsDesc = $("#toElsDesc").val();
	    var materialNumber = $("#materialNumber").val();
	    var materialDesc = $("#materialDesc").val();
		
	    var select = $("#attrSelectDiv select[name='attr']");
	    $.ajax({
			url : "${pageContext.request.contextPath}/rest/MaterialCateService/queryMaterialSpecList",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify({"elsAccount":elsAccount}),
			dataType : "json",
			success : function(data) {
				var rows = data.rows;
				if(typeof(rows)!="undefined" && rows.length>0){
					for(var i=0;i<rows.length;i++){
						var record = rows[i];
						$("<option value='"+record.materialSpecCode+"'>"+record.materialSpecName+"</option>").appendTo(select);
					}
				}
			},
			error : function(data) {
				alert("<i18n:I18n defaultValue='获取物料属性失败' key='i18n_alert_queryMaterialAttrFail'/>",1);
			}
		});
	    
		var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	toElsDesc : toElsDesc,
	    	materialNumber : materialNumber,
	    	materialDesc : materialDesc,
	    };
		//设置params给分页插件使用,若直接使用headGrid.load(queryParam)查询,则分页插件调用gird时是无参数的导致分页数据不对
		$.extend(headGrid.opts.params,queryParam);
		headGrid.load();
	}
			
	$("#queryBtn").click(function(){
		refreshData();
	});
	
	$("#addBtn").click(function(){
	    parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "purchaseMaterialListAdd",
	        windowTitle : "<i18n:I18n defaultValue='新建采购物料清单' key='i18n_windowTitle_purchaseMaterialListAdd'/>",
	        iframSrc : "${pageContext.request.contextPath}/suppliermanage/purchaseMaterialListAdd.jsp",
	        showAdv : true,
	        windowStatus : "maximized",
	        windowMinWidth : 960,
	        windowMinHeight : 700,
	        windowWidth : 960,
	        windowHeight : 700,
	        parentPanel : ".currDesktop"
	    });
	});
	
	$("#delBtn").click(function(){
		if(confirm("是否确定删除?")){
			var selectRows = headGrid.selectedRows();
			if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/PurchaseMaterialListService/delPurchaseMaterialListByHead",
						type : "post",
						contentType : "application/json",
						data : JSON.stringify(selectRows),
						dataType : "json",
						success : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
							
							var selectedIndexes = headGrid.selectedRowsIndex();
							headGrid.removeRow(selectedIndexes);
						},
						error : function(data) {
							parent.elsDeskTop.hideLoading();
							alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",3);
						}
					});
				}});
			}
		}
	});
	
	$("#quoteQueryBtn").click(function(){
	    parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "purchaseMaterialListQuoteDetail",
	        windowTitle : "<i18n:I18n defaultValue='供应商报价明细查询' key='i18n_windowTitle_purchaseMaterialListQuoteDetail'/>",
	        iframSrc : "${pageContext.request.contextPath}/suppliermanage/purchaseMaterialListQuoteDetail.jsp",
	        showAdv : true,
	        windowStatus : "maximized",
	        windowMinWidth : 960,
	        windowMinHeight : 700,
	        windowWidth : 960,
	        windowHeight : 700,
	        parentPanel : ".currDesktop"
	    });
	});
			
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"<i18n:I18n defaultValue='列自定义' key='i18n_common_button_columncustom'/>",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseMatertialListManage&window=iframeApp_purchaseMaterialListManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	$("#addAttrCondBtn").click(function(){
		var attrParentDiv = $("#attrSelectDiv");
		var selectSize = attrParentDiv.children("div").length;
		if(selectSize < 5){
			var div = $(this).prev("div");
			$(this).before(div.clone());
		} else {
			alert("最多5个属性条件",2);
		}
	});
	
	function refreshData(){
		var toElsAccount = $("#toElsAccount").val();
	    var toElsDesc = $("#toElsDesc").val();
		var quotationNumber = $("#quotationNumber").val();
	    var materialNumber = $("#materialNumber").val();
	    var materialDesc = $("#materialDesc").val();
	    
	    var attributeList = [];
	    $("#attrSelectDiv div").each(function(){
	    	var attrCode = $(this).find("select[name='attr']").eq(0).val();
	    	var attrValue = $(this).find("input[name='attr']").eq(0).val();
	    	attributeList.push({
	    		materialAttribute : attrValue,
	    		materialAttributeDesc : attrCode,
	    	});
	    });
	    
						
		var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	toElsDesc : toElsDesc,
	    	quotationNumber : quotationNumber,
	    	materialNumber : materialNumber,
	    	materialDesc : materialDesc,
	    	attributeList : attributeList,
	    };
		//设置params给分页插件使用,若直接使用headGrid.load(queryParam)查询,则分页插件调用gird时是无参数的导致分页数据不对
		$.extend(headGrid.opts.params,queryParam);
		headGrid.load();
	}
	/****************/
	$("#headDiv button").live('click',function(){
		var name = $(this).attr("name");
		var rowIndex = $(this).closest("tr").index();
		var rowData = headGrid.row(rowIndex);
		if("sendDetail" == name){
			parent.elsDeskTop.defineWin({
		        iconSrc : "icon/icon9.png",
		        windowsId : "purchaseMaterialListDetail",
		        windowTitle : "<i18n:I18n defaultValue='采购物料清单明细' key='i18n_windowTitle_purchaseMaterialListDetail'/>",
		        iframSrc : "${pageContext.request.contextPath}/suppliermanage/purchaseMaterialListDetail.jsp?elsAccount="+rowData.elsAccount
		        		+"&quotationNumber="+rowData.quotationNumber+"&materialNumber="+rowData.materialNumber
		        		+"&materialGroup="+rowData.materialGroup+"&materialCategory="+rowData.materialCategory 
		        ,
		        showAdv : true,
		        windowStatus : "maximized",
		        windowMinWidth : 960,
		        windowMinHeight : 700,
		        windowWidth : 960,
		        windowHeight : 700,
		        parentPanel : ".currDesktop"
		    });
		} else if("receiveDetail" == name){
			parent.elsDeskTop.defineWin({
		        iconSrc : "icon/icon9.png",
		        windowsId : "purchaseQuotationManage",
		        windowTitle : "<i18n:I18n defaultValue='供应商物料报价信息' key='i18n_windowTitle_purchaseQuotationManage'/>",
		        iframSrc : "${pageContext.request.contextPath}/quotation/purchase/purchaseQuotationManage.jsp?elsAccount="+rowData.elsAccount
				        +"&quotationNumber="+rowData.quotationNumber+"&materialNumber="+rowData.materialNumber
		        		+"&materialGroup="+rowData.materialGroup+"&materialCategory="+rowData.materialCategory
        		,
		        showAdv : true,
		        windowStatus : "maximized",
		        windowMinWidth : 960,
		        windowMinHeight : 700,
		        windowWidth : 960,
		        windowHeight : 700,
		        parentPanel : ".currDesktop"
		    });
		} else {
			//nothing
		}
	});
	
	function sendRender(val,item,rowIndex){
		return "<button name='sendDetail' >询单明细</button>";
	}
	
	function receiveRender(val,item,rowIndex){
		return "<button name='receiveDetail' >报单明细</button>";
	}
	/****************/
</script>
</body>
</html>