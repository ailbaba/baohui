<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" /></span>
            <div class="common-box-line">
                <button id="queryBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
                <button id="saveBtn" class="button-wrap"><i18n:I18n defaultValue="保存" key="i18n_button_save"/></button>
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom"/></button>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery"/></span>
            <div class="common-box-line">
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="物料编码" key="i18n_common_label_materialnumber"/>:</span>
					<input type="text" id="materialNumber" name="materialNumber"  />
				</div>
	            <div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="物料描述" key="i18n_common_label_materialdescribe"/>:</span>
					<input type="text" id="materialDesc" name="materialDesc" />
				</div>	
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="物料组" key="i18n_common_title_materialgroup"/>:</span>
					<input type="text" id="materialGroup" name="materialGroup"  />
				</div>	
				<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="生产线" key="i18n_label_productionLine"/>:</span>
					<input type="text" id="productLine" name="productLine"  />
				</div>
            </div>
        </div>
        <div class="pos-relative">
        	<div style="width:75%;">
        		<div class="box-wrap pos-relative bg- common">
		            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="采购物料清单" key="i18n_materialList_title_purchaseMaterialList"/></span>
		            <div class="common-box-line">
			            <main class="grid-container">
		                    <div class="grid-100">
		                        <table id="materialTable"></table>
		                    </div>
		               </main>
		            </div>
		        </div>
        	</div>
	        <div class="pos-absolute" style="width: 25%;right: 0;top: 0;">
		        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="供应商信息" key="i18n_enquiry_title_supplierinformation"/></span>
	            <div class="common-box-line">
		            <main class="grid-container">
	                    <div class="grid-100">
	                        <table id="supplierTable"></table>
	                    </div>
	               </main>
	            </div>
	        	</div>
	        </div>
        </div>
        
        
        
    </div>
<script>
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	var language = "${sessionScope.language}";
	
	//var materialCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="supplierMatertialListManage"/>;
	var materialCols = [
		    { title:"ELS号", name:'elsAccount' , width:60, align:'center'},
		    { title:"物料编号", name:'materialNumber' , width:60, align:'center'},
		    { title:"物料描述", name:'materialDesc' , width:60, align:'center'},
		    { title:"物料组", name:'materialGroup' , width:60, align:'center'},
		    { title:"物料类别", name:'fbk1' , width:60, align:'center'},
		    { title:"生产线", name:'productLine' , width:60, align:'center'},
		    { title:"是否可用", name:'isLocked' , width:60, align:'center',render:function(val,item,rowIndex){
		    	if("Y" == val){
		    		return "是";
		    	} else {
		    		return "否";
		    	}
		    }}
		];
	var materialGrid = $("#materialTable").mmGrid({
		cols : materialCols,
		url : "${pageContext.request.contextPath}/rest/MaterialService/queryMaterialList",
		method :  "POST",
		autoLoad : false,
		height : "500px",
		root : "rows",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : true,
        checkCol : true,
        indexCol : false,
	});

	//对账单行信息列
	var supplierCols = [
	    { title:"ELS号", name:'elsAccount' , width:60, align:'center',hidden:true},
	    { title:"对方ELS号", name:'friendElsAccount' , width:60, align:'center'},
	    { title:"对方ELS描述", name:'friendCompanyName' , width:60, align:'center'},
	    { title:"一级分组编号", name:'groupIdA' , width:60, align:'center',hidden:true},
	    { title:"一级分组名称", name:'groupIdAName' , width:60, align:'center',renderer:getI18nValue},
	    { title:"二级分组编号", name:'groupIdB' , width:60, align:'center',hidden:true},
	    { title:"二级分组名称", name:'groupIdBName' , width:60, align:'center'},
	];
	
	var supplierGrid = $('#supplierTable').mmGrid({
	    cols : supplierCols,
	    height : "500px",
	    url : "${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsByType",
	    method : 'post',
	    params : {
        	elsAccount : elsAccount,
        	elsSubAccount : elsSubAccount,
        	groupIdAName : "供应商"
        },
	    root : "rows",
	    fullWidthRows : true,
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
	    checkCol : true,
	    indexCol : false
	});
	
	$(document).ready(function(){
		$("button").button();
		
		var materialNumber = $("#materialNumber").val();
	    var materialDesc = $("#materialDesc").val();
	    var materialGroup = $("#materialGroup").val();
	    var productLine = $("#productLine").val();
	    
		var queryParam = {
	    	elsAccount : elsAccount,
	    	materialNumber : materialNumber,
	    	materialDesc : materialDesc,
	    	materialGroup : materialGroup,
	    	productLine : productLine
	    };
		materialGrid.load(queryParam);
	});
	
	$("#queryBtn").click(function(){
		var materialNumber = $("#materialNumber").val();
	    var materialDesc = $("#materialDesc").val();
	    var materialGroup = $("#materialGroup").val();
	    var productLine = $("#productLine").val();
	    
		var queryParam = {
	    	elsAccount : elsAccount,
	    	materialNumber : materialNumber,
	    	materialDesc : materialDesc,
	    	materialGroup : materialGroup,
	    	productLine : productLine
	    };
		materialGrid.load(queryParam);
	});
		
	$("#saveBtn").click(function(){
		var materialRows = materialGrid.selectedRows();
		var supplierRows = supplierGrid.selectedRows();
		var data = {
				materialListStr : JSON.stringify(materialRows),
				supplierListStr : JSON.stringify(supplierRows),
	   	};
		
		parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中' key='i18n_common_saveing'/>");
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/PurchaseMaterialListService/addPurchaseMaterialList",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存成功' key='i18n_common_alert_savesuccess'/>",1);
				//parent.elsDeskTop.closeCurWin('purchaseMaterialListAdd',callBack);
				window.location.href="${pageContext.request.contextPath}/suppliermanage/purchaseMaterialListDetail.jsp?elsAccount="
						+data.elsAccount+"&quotationNumber="+data.quotationNumber;
				
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存出错' key='i18n_common_alert_saveError'/>");
			}
		});
	});
	
	function callBack(){
		if(parent.frames['iframeApp_purchaseMaterialListManage']) {
			parent.frames['iframeApp_purchaseMaterialListManage'].init();
		}
	} 
	
	function getI18nValue(val,item,rowIndex){
		if(typeof(val)=="undefined" || ""==val ){
			return "";
		} else {
			var valArr = val.split(":");
			var key = valArr[0];
			var defaultValue = valArr[1];
			var returnVal = "";
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/I18nService/getResourceByKey/"+key,
				type :"GET",
				contentType : "application/json",
				data : "",
				async : false,//异步
				dataType : "json",
				success : function(data) {
					if(typeof(data.value)=="undefined" || ""==data.value){
						returnVal = defaultValue;
					} else {
						returnVal = data.value;
					}
				},
				error : function(data) {
					returnVal = defaultValue;
				}
			});
			return returnVal;
		}
	}
</script>
</body>
</html>