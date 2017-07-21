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
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="物料条件" key="i18n_materialList_title_materialCondition"/></span>
            <div class="common-box-line">
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
			
	//var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseMatertialListManage"/>;
	var headCols = [
			{ title:"ELS号", name:'elsAccount', width:100, align:'center'},
			{ title:"对方ELS号", name:'toElsAccount', width:100, align:'center'},
			{ title:"对方ELS描述", name:'fbk11', width:100, align:'center'},
			{ title:"单号", name:'quotationNumber', width:100, align:'center'},
			{ title:"物料编号", name:'materialNumber', width:100, align:'center'},
			{ title:"物料描述", name:'materialDesc', width:100, align:'center'},
			{ title:"物料组", name:'materialGroup', width:100, align:'center'},
			{ title:"物料类别", name:'materialCategory', width:100, align:'center'},
			{ title:"品牌", name:'attribute1' , width:100, align:'center'},
			{ title:"颜色", name:'attribute2' , width:100, align:'center'},
			{ title:"长度", name:'attribute3' , width:100, align:'center'},
			{ title:"宽度", name:'attribute4' , width:100, align:'center'},
			{ title:"高度", name:'attribute5' , width:100, align:'center'},
			{ title:"基准价格", name:'price' , width:100, align:'center'},
			{ title:"单位", name:'unitPrice' , width:100, align:'center'},
			{ title:"有效起始日期", name:'fbk7' , width:100, align:'center'},
			{ title:"有效结束日期", name:'fbk8' , width:100, align:'center'},
			{ title:"最小订货量", name:'fbk9' , width:100, align:'center'},
			{ title:"最大订货量", name:'fbk10' , width:100, align:'center'},
	    ];
	
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/PurchaseQuotationService/queryPurchaseQuotationItem",
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
	    
		/* var queryParam = {
	    	elsAccount : elsAccount,
	    	toElsAccount : toElsAccount,
	    	toElsDesc : toElsDesc,
	    	materialNumber : materialNumber,
	    	materialDesc : materialDesc,
	    };
		//设置params给分页插件使用,若直接使用headGrid.load(queryParam)查询,则分页插件调用gird时是无参数的导致分页数据不对
		$.extend(headGrid.opts.params,queryParam);
		headGrid.load(); */
	}
			
	$("#queryBtn").click(function(){
		refreshData();
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
</script>
</body>
</html>