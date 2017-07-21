<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<body>
	<div class="pos-relative public-wrap">		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button id="queryHeadBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新增" key="i18n_common_button_create"/></button>
				<button id="updateBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update"/></button>
				<button id="deleteBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete"/></button>
				<button id="ERPBtn" class="button-wrap"><i18n:I18n key="i18n_button_getfromerp" defaultValue="从ERP获取" /></button>
				<button class="button-wrap" id="downBtn"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="模板下载" /></button>
				<button class="btn btnUpload" id="exportBtn" style="height: 24px;line-height:24px;"><span><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></span></button>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip pos-relative">
					<span><i18n:I18n key="i18n_common_title_clientElsAccount" defaultValue="客户ELS" />:</span>
					<input type="text" id="qToElsAccount" name="qToElsAccount" />
					<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryElsAccount" />
				</div>
				<div class="dis-in-b input-and-tip">
					<input type="text" id="qToElsDesc" name="qToElsDesc" readonly="readonly" />
				</div>
				<div class="dis-in-b input-and-tip pos-relative">
					<span><i18n:I18n key="i18n_common_label_salematerialnumber" defaultValue="供应商物料" />:</span>
					<input type="text" id="qMaterialNumber" name="qMaterialNumber" />
					<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryMaterialNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<input type="text" id="qMaterialDesc" name="qMaterialDesc" readonly="readonly" />
				</div>
				<div class="dis-in-b input-and-tip pos-relative">
					<span><i18n:I18n key="i18n_common_label_Supplyfactory" defaultValue="供应工厂" />:</span>
					<input type="text" id="qFactoryNumber" name="qFactoryNumber" />
					<img class="dis-in-b" src="${pageContext.request.contextPath}/icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryFactoryNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<input type="text" id="qFactoryName" name="qFactoryName" readonly="readonly" />
				</div>
				<br/>
				<div class="dis-in-b input-and-tip">
	                <input type="radio" name="dateArea" value="currDate" checked="checked"><i18n:I18n key="i18n_label_currentInventory" defaultValue="当前库存" />
	                <input type="radio" name="dateArea" value="definedDate"><i18n:I18n key="i18n_label_customDateInventory" defaultValue="自定义日期库存" />
				</div>
	            <div class="dis-in-b input-and-tip" style="display:none;">
					<input type="text" class="Wdate" onfocus="WdatePicker()" id="qStockDate" name="qStockDate"/>
	            </div>
			</div>
		</div>
							
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="VenderGrid1">
							<table id="venderTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="fixed-dialog" id="selectFriendElsAccountDialog" >
	<div class="dialog-tip bg-common" style="width: 500px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectFriendElsAccountDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectFriendElsAccountTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectFriendOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectFriendCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>

<div class="fixed-dialog" id="selectMaterialDialog" >
	<div class="dialog-tip bg-common" style="width: 500px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectMaterialDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectMaterialTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectMaterialOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectMaterialCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>

<div class="fixed-dialog" id="selectFactoryDialog" >
	<div class="dialog-tip bg-common" style="width: 500px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectFactoryDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectFactoryTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectFactoryOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectFactoryCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>


<div class="fixed-dialog" id="addFileDialog">
	<div class="dialog-tip bg-common" style="width: 262px;height: auto; margin-left: -131px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="dialogFileClose"></div>
	    <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_button_chooseformfile"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                <div class="common-box-line">
	            	<div class="input-and-tip"><span><i18n:I18n defaultValue="文件名称" key="i18n_common_label_filename"/>：</span><input id="fileName" name="fileName" type="text" /></div>
	                	<div class="input-and-tip"><span><i18n:I18n defaultValue="文件路径" key="i18n_common_label_filepath"/>：</span><input id="filePath" name="filePath" type="text" /></div>
	                <div class="input-and-tip text-right">                 
	                <div id="btnFileUpload" class="btn btnUpload"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_button_chooseformfile"/></div>           
	                	<input id="fileType" name="fileType" type="hidden" />
	                </div>
	                <div class="mt-20 text-center">
	                    <button id="addFileBtnOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                	<button id="addFileBtnCancel" class="button-wrap "><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</div>
	<!-- 对话框 -->
	<div class="fixed-dialog" id="dia">
		<div class="dialog-tip bg-common">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="<%=basePath%>/icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_label_settings" defaultValue="设置" /></span>
			</div>
			<div class="mt-40" >
				<div class="box-wrap pos-relative bg-common">
				   <form id="VenderForm">
				    <div style="width:360px; height:225px; overflow-y:scroll;">
					<table>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS帐号" />：</span></td>
							<td align="left"><input id="elsAccount" name="elsAccount" type="text"  readonly = "readonly"   value = "<%=session.getAttribute("elsAccount")%>"/></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司名称" />：</span></td>
							<td align="left"><input id="elsDesc" name="elsDesc" type="text"  readonly = "readonly"   value = "<%=session.getAttribute("companyShortName")%>"/></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_label_factory" defaultValue="工厂" />：</span></td>
							<td align="left"><input id="factoryNumber" name="factoryNumber" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_saleRequirement_lable_FactoryName" defaultValue="工厂名称" />：</span></td>
							<td align="left"><input id="factoryName" name="factoryName" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />：</span></td>
							<td align="left"><input id="materialNumber" name="materialNumber" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />：</span></td>
							<td align="left"><input id="materialDesc" name="materialDesc" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_title_clientElsAccount" defaultValue="客户ELS" />：</span></td>
							<td align="left"><input id="toElsAccount" name="toElsAccount" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_title_clientName" defaultValue="客户名称" />：</span></td>
							<td align="left"><input id="toElsDesc" name="toElsDesc" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_lable_customermaterialnumber" defaultValue="客户物料编号" />：</span></td>
							<td align="left"><input id="purchaseMaterialNumber" name="purchaseMaterialNumber" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_lable_customermaterialname" defaultValue="客户物料名称" />：</span></td>
							<td align="left"><input id="purchaseMaterialDesc" name="purchaseMaterialDesc" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />：</span></td>
							<td align="left"><input id="quantity" name="quantity" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_delivery_lable_unit" defaultValue="单位" />：</span></td>
							<td align="left"><input id="unit" name="unit" type="text" /></td>
						</tr>
						<tr>
							<td align="right"><span><i18n:I18n key="i18n_common_label_stockDate" defaultValue="库存日期" />：</span></td>
							<td align="left"><input type="text" id="stockDate" class="Wdate" onfocus="WdatePicker()" name="stockDate"   style="width:80px;"/></td>
						</tr>
					</table>
					</div>
				   </form>
					<div class="mt-40">
						<button id="okBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="cancelBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	</div>
		<script>
	 var VenderGrid;
	 var elsAccount     = "<%=session.getAttribute("elsAccount")%>"       ;
	 var companyName    = "<%=session.getAttribute("companyShortName")%>" ;
	 var supplierStockVODelList = [];
	 var fileUploader;
	// 渲染   @author yangyajun 20160309  end
    //clickDisable:true禁止点击
    var renderFormatDate = function(val,item,rowIndex){
		if("undefined"==typeof(val) || "" == val){
			return "";
		} else {
			return new Date(val).format("yyyy-MM-dd");
		}
	};
    var cols = [{ title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />',name:'elsAccount',width: 120, align: 'center', hidden:true},
                { title:'<i18n:I18n key="i18n_common_logintime" defaultValue="登录时间" />',name:'logtime',width: 120, align: 'center', hidden:true},
                { title:'<i18n:I18n key="i18n_common_label_stockNumber" defaultValue="库存号" />',name:'stockSequenceNumber',width: 120, align: 'center', hidden:true},
                {title:'<i18n:I18n key="i18n_common_label_factory" defaultValue="工厂" />', name:'factoryNumber' ,width:160, align:'center'},
                {title:'<i18n:I18n key="i18n_saleRequirement_lable_FactoryName" defaultValue="工厂名称" />',name:'factoryName' ,width:70, align:'center'},
    	        {title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />', name:'materialDesc', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_title_clientElsAccount" defaultValue="客户ELS" />', name:'toElsAccount' ,width:220, align:'center' },
    	        {title:'<i18n:I18n key="i18n_common_title_clientName" defaultValue="客户名称" />', name:'toElsDesc', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_lable_customermaterialnumber" defaultValue="客户物料编号" />', name:'purchaseMaterialNumber', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_lable_customermaterialname" defaultValue="客户物料名称" />', name:'purchaseMaterialDesc', width: 70, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />', name:'quantity' ,width:150, align:'center'},
    	        {title:'<i18n:I18n key="i18n_delivery_lable_unit" defaultValue="单位" />', name:'unit' ,width:70, align:'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_stockDate" defaultValue="库存日期" />', name:'stockDate', width: 120, align: 'center',renderer:renderFormatDate}
    	    ];
   
    		var GobalparamStr={"elsAccount":elsAccount ,"stockDate":new Date()};
    		VenderGrid= $('#venderTable').mmGrid({
    	    	cols       : cols  ,
    	        url        : '<%=basePath%>rest/SupplierStockService/querySupplierStockVOByCondtion'    ,
    			params     : GobalparamStr ,
    			method     : 'post',
    			items      : "rows",
    			loadingText:'<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
    			noDataText :'<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
    			height     :"500px",
    			checkCol   : true
    		});

    		VenderGrid.on('loadSuccess', function(e, data) {
  					if (data!=null) {
  						VenderGrid.select(0);
  					} 
  				});

    		$("input[name='dateArea']").click(function(){
    			var dateArea = $(this).val();
    			var currDate = new Date();
    			
    			if("currDate" == dateArea){
    				$("#qStockDate").val(currDate.format("yyyy-MM-dd"));
    				$("#qStockDate").parent().hide();
    			} else if("definedDate" == dateArea) {
    				$("#qStockDate").val("");
    				$("#qStockDate").parent().show();
    			} else {//默认查最近一月
    				$("#qStockDate").val(currDate.format("yyyy-MM-dd"));
    				$("#qStockDate").parent().hide();
    			}
    		});
    		
    		$(document).ready(function(){
    			//初始化控件
    			$("button").button();
    			initFileUpload();
    		});
    		
    		/* 查询供应商信息 start  */
    		//查询对方ELS信息(只在好友列表中查询) 
    		var toElsCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
    		var toElsGrid;
    		$("#queryElsAccount").click(function(){
    			$("#selectFriendElsAccountDialog").show();
    			toElsGrid = $('#selectFriendElsAccountTable').mmGrid({
    				cols : toElsCols,
    				url : "${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsByType",
    				params : {
    					elsAccount : elsAccount,
    					elsSubAccount : elsSubAccount,
    					groupIdAName : "供应商"
    				},
    				method : "post",
    				root : "rows",
    				loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    				noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    				multiSelect : false,
    				checkCol : true,
    				indexCol :false
    			});

    			var selectElsAccount = $("#qToElsAccount").val();
    			var totalRows = toElsGrid.rows();
    			if(totalRows != null && totalRows != "" && selectElsAccount != ""){
    				for(var i = 0 ; i < totalRows.length ; i ++){
    					var toElsAccount = totalRows[i].friendElsAccount;
    					var toElsDesc = totalRows[i].friendCompanyName;
    					if(toElsAccount == selectElsAccount){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
    						toElsGrid.select(i);
    						continue;
    					}
    				}
    			}
    		});

    		//选择对方ELS确认按钮单击事件
    		$("#selectFriendOKBtn").click(function(){
    			var selectedRows = toElsGrid.selectedRows();
    			if(selectedRows != "" ){
    				$("#qToElsAccount").val(selectedRows[0].friendElsAccount);
    				$("#qToElsDesc").val(selectedRows[0].friendCompanyName);
    				//切换供应商后清除供应商物料及工厂选项
    				$("#qMaterialNumber").val("");
    				$("#qMaterialDesc").val("");
    				$("#qFactoryNumber").val("");
    				$("#qFactoryName").val("");
    			}else{
    				alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
    				return;
    			}
    			$("#selectFriendElsAccountDialog").hide();
    		});

    		$("#selectFriendElsAccountDialogClose").click(function(){
    			$("#selectFriendElsAccountDialog").hide();
    		});

    		$("#selectFriendCancelBtn").click(function(){
    			$("#selectFriendElsAccountDialog").hide();
    		});
    		/* 查询供应商信息 end  */

    		/* 查询供应商物料信息 start */
    		//var materialCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
    		var materialGrid;
    		var materialCols = [
    		   	   	{ title:"<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />", name:"elsAccount", width:100, align:"center"},
    		   		{ title:"<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />", name:"materialNumber", width:100, align:"center"},
    		   		{ title:"<i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />", name:"materialDesc", width:100, align:"center"},
    		   		{ title:"<i18n:I18n key="i18n_common_title_materialgroup" defaultValue="物料组" />", name:"materialGroup", width:100, align:"center"},
    		   		{ title:"<i18n:I18n key="i18n_label_productionLine" defaultValue="生产线" />", name:"productLine", width:100, align:"center"},
    		   	];
    		$("#queryMaterialNumber").click(function(){
    			var _elsAccount = $("#qToElsAccount").val();
    			if("undefined"==typeof(_elsAccount) || ""==_elsAccount){
    				alert("<i18n:I18n key="i18n_label_additionCost_pleaseSelectsuppliersFirst" defaultValue="请先选择供应商" />",2);
    			} else {
    				$("#selectMaterialDialog").show();
    				if(materialGrid){
    					materialGrid.load({elsAccount : _elsAccount});
    				} else {
    					materialGrid = $('#selectMaterialTable').mmGrid({
    						cols : materialCols,
    						url : "${pageContext.request.contextPath}/rest/MaterialService/queryMaterialList",
    						params : {
    							elsAccount : _elsAccount,
    						},
    						method : "post",
    						root : "rows",
    						loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    						noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    						multiSelect : false,
    						checkCol : true,
    						indexCol :false
    					});
    				}
    			}

    			var selectMaterialNumber = $("#qMaterialNumber").val();
    			var totalRows = materialGrid.rows();
    			if(totalRows != null && totalRows != "" && selectMaterialNumber != ""){
    				for(var i = 0 ; i < totalRows.length ; i ++){
    					var materialNumber = materialGrid[i].materialNumber;
    					var materialDesc = totalRows[i].materialDesc;
    					if(materialNumber == selectMaterialNumber){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
    						materialGrid.select(i);
    						continue;
    					}
    				}
    			}
    		});

    		//选择物料确认按钮单击事件
    		$("#selectMaterialOKBtn").click(function(){
    			var selectedRows = materialGrid.selectedRows();
    			if(selectedRows != "" ){
    				$("#qMaterialNumber").val(selectedRows[0].materialNumber);
    				$("#qMaterialDesc").val(selectedRows[0].materialDesc);
    			}else{
    				alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
    				return;
    			}
    			$("#selectMaterialDialog").hide();
    		});

    		$("#selectMaterialDialogClose").click(function(){
    			$("#selectMaterialDialog").hide();
    		});

    		$("#selectMaterialCancelBtn").click(function(){
    			$("#selectMaterialDialog").hide();
    		});
    		/* 查询供应商物料信息 end  */

    		/* 查询供应商工厂信息 start */
    		//var factoryCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
    		var factoryGrid;
    		var factoryCols = [
    			   	{ title:"<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />", name:"elsAccount", width:100, align:"center"},
    				{ title:"<i18n:I18n key="i18n_label_additionCost_accountName" defaultValue="ELS名称" />", name:"elsDesc", width:100, align:"center"},
    				{ title:"<i18n:I18n key="i18n_common_label_factoryNumber" defaultValue="工厂编号" />", name:"factoryNumber", width:100, align:"center"},
    				{ title:"<i18n:I18n key="i18n_saleRequirement_lable_FactoryName" defaultValue="工厂名称" />", name:"factoryName", width:100, align:"center"},
    				{ title:"<i18n:I18n key="i18n_saleRequirement_lable_factoryNameAddress" defaultValue="工厂地址" />", name:"factoryAddress", width:100, align:"center"},
    				{ title:"<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />", name:"remark" , width:100, align:"center"},
    			];
    		$("#queryFactoryNumber").click(function(){
    			var _elsAccount = $("#qToElsAccount").val();
    			if("undefined"==typeof(_elsAccount) || ""==_elsAccount){
    				alert("<i18n:I18n key="i18n_label_additionCost_pleaseSelectsuppliersFirst" defaultValue="请先选择供应商" />",2);
    			} else {
    				$("#selectFactoryDialog").show();
    				if(factoryGrid){
    					factoryGrid.load({elsAccount : _elsAccount});
    				} else {
    					factoryGrid = $('#selectFactoryTable').mmGrid({
    						cols : factoryCols,
    						url : "${pageContext.request.contextPath}/rest/SupplierStockService/querySupplierFactory",
    						params : {
    							elsAccount : _elsAccount
    						},
    						method : "post",
    						root : "rows",
    						loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    						noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    						multiSelect : false,
    						checkCol : true,
    						indexCol :false
    					});
    				}
    				
    				var selectFactoryNumber = $("#qFactoryNumber").val();
    				var totalRows = factoryGrid.rows();
    				if(totalRows != null && totalRows != "" && selectFactoryNumber != ""){
    					for(var i = 0 ; i < totalRows.length ; i ++){
    						var factoryNumber = totalRows[i].factoryNumber;
    						var factoryName = totalRows[i].factoryName;
    						if(factoryNumber == selectFactoryNumber){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
    							factoryGrid.select(i);
    							continue;
    						}
    					}
    				}
    			}
    		});

    		//选择物料确认按钮单击事件
    		$("#selectFactoryOKBtn").click(function(){
    			var selectedRows = factoryGrid.selectedRows();
    			if(selectedRows != "" ){
    				$("#qFactoryNumber").val(selectedRows[0].factoryNumber);
    				$("#qFactoryName").val(selectedRows[0].factoryName);
    			}else{
    				alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
    				return;
    			}
    			$("#selectFactoryDialog").hide();
    		});

    		$("#selectFactoryDialogClose").click(function(){
    			$("#selectFactoryDialog").hide();
    		});

    		$("#selectFactoryCancelBtn").click(function(){
    			$("#selectFactoryDialog").hide();
    		});
    		/* 查询供应商工厂信息 end  */

    		$("#downBtn").click(function(){
    			window.location.href = "${pageContext.request.contextPath}/rest/SupplierStockService/downExcelTemplate?filePath=template/供应商库存导入模板.xlsx";
    		});
			
    		function initFileUpload(){
    			if (!fileUploader) {
    				fileUploader = WebUploader.create({
    			  	    swf : "${pageContext.request.contextPath}/jsLib/webuploader/Uploader.swf",// swf文件路径
    			  	    auto : true,//是否选择文件后自动上传
    			  	    server : "${pageContext.request.contextPath}/rest/SupplierStockService/exportExcel",// 文件接收服务端。
    			  	    pick : "#exportBtn",//选择文件的按钮,可选.内部根据当前运行时创建,可能是input元素,也可能是flash/
    			  	    resize : false,// 不压缩image,默认如果是jpeg,文件上传前会压缩再上传.
    			  	    formData : {
    				     	elsAccount : elsAccount
    				    }
    			  	});
    			}
    			
    			// 当有文件添加进来的时候
    			fileUploader.on("fileQueued",function(file){
    				var fileName = file.name;
    				$("#fileName").val(fileName);
    				$("#fileType").val(file.ext);
    			});
    		 	//上传到服务器响应后触发
    			fileUploader.on("uploadAccept", function(obj,response) {
    				var errorNumber = response.error;
   					var filePath = response.url;
   					$("#filePath").val(filePath);
    			});
    			//上传过程中触发，携带上传进度
    			fileUploader.on("uploadProgress", function(file,percentage) {
    			});
    			//当文件上传成功时触发
    			fileUploader.on("uploadSuccess", function(file,response) {
    				alert("<i18n:I18n key="i18n_common_alert_successfulImprot" defaultValue="导入成功！" />",1);
    				//上传成功后,重置文件队列
    				fileUploader.reset();//重置upload,该方法目前只重置了队列
    			});
    			//上传出错时触发
    			fileUploader.on("uploadError", function(file,reason) {
    		  		alert(reason,3); 
    			});
    		}

		     //查询
			 $("#queryHeadBtn").click(function(){
 					var toElsAccount = $("#qToElsAccount").val();
					var materialNumber = $("#qMaterialNumber").val();
					var factoryNumber = $("#qFactoryNumber").val();
					var stockDate = $("#qStockDate").val(); 
					var Gobalparam={"toElsAccount":toElsAccount, "materialNumber":materialNumber, "factoryNumber":factoryNumber,"stockDate":stockDate};
 					VenderGrid.load(Gobalparam); 
			  });

				//初始化对话框
				function initDig(status){
					if(status==null){//添加
						console.log(elsAccount);
						$("#elsAccount").attr({ readonly: 'true' });
					    $("#elsAccount").val(""); 
					    $("#elsDesc").val(companyName); 
						$("#factoryNumber").removeAttr("readonly"); 
						$("#dialogTitle").html('<i18n:I18n key="i18n_common_label_addition" defaultValue="添加" />');
						$("#factoryName").val("");
						$('#materialNumber').val("");
						$('#materialDesc').val("");
						$("#toElsAccount").val("");
						$('#toElsDesc').val("");
						$('#purchaseMaterialNumber').val("");
						$("#purchaseMaterialDesc").val("");
						$('#quantity').val("");
						$('#unit').val("");
						$("#stockDate").val("");						
					}else{//修改
						$("#elsAccount").attr({ readonly: 'true' });
						$("#elsDesc").attr({ readonly: 'true' });
						$("#elsAccount").val(elsAccount); 
						var selectedRows=VenderGrid.selectedRows();
						$("#dialogTitle").html('<i18n:I18n key="i18n_label_update" defaultValue="修改" />');
						$("#elsAccount").val(elsAccount);
						$("#elsDesc").val(companyName);
						$('#factoryNumber').val(selectedRows[0].factoryNumber);
						$('#factoryName').val(selectedRows[0].factoryName);
						$('#materialNumber').val(selectedRows[0].materialNumber);
						$('#materialDesc').val(selectedRows[0].materialDesc);
						$('#toElsAccount').val(selectedRows[0].toElsAccount);
						$('#toElsDesc').val(selectedRows[0].toElsDesc);
						$('#purchaseMaterialNumber').val(selectedRows[0].purchaseMaterialNumber);
						$("#purchaseMaterialDesc").val(selectedRows[0].purchaseMaterialDesc);
						$('#quantity').val(selectedRows[0].quantity);
						$('#unit').val(selectedRows[0].unit);
						var stockDate = selectedRows[0].stockDate;
						if("undefined"== typeof(stockDate) || stockDate=="" ){
							stockDate = "";
						} else {
							stockDate = new Date(stockDate).format("yyyy-MM-dd");
						}
						$("#stockDate").val(stockDate);
					}
					$('#dia').show();
				}
				//关闭对话框
				$("#cancelBtn,.dialog-close-btn").click(function() {
					$('#dia').hide();
				});
				
				//确定
				$("#okBtn").click(function() {
					if(type=="add"){
						addProc();
					}else if(type=="edit"){
						editProc();
					}				
				});
				
				
				//添加
				$("#addBtn").click(function() {
					type="add";
					initDig(null);
				});

				//修改
				$('#updateBtn').live("click", function() {
					type="edit";
					initDig(1);
				});
				
				//添加过程
				function addProc(){
					var toElsAccount =$("#toElsAccount").val();
					if(toElsAccount==null||toElsAccount.length<=0){
						alert('<i18n:I18n key="i18n_label_alert_CustomerelsAccountNotNull" defaultValue="客户Els帐号,不能为空!" />',2);
						return;
					}
					parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmAddition" defaultValue="是否确认添加?" />',closeEvent:function(){
						var paramStr = $("#VenderForm").serializeJSON();
						VenderGrid.addRow(paramStr);
						$('#dia').hide();
					}});
				}
				
				//修改过程 
				function editProc(){
					var toElsAccount =$("#toElsAccount").val();
					if(toElsAccount==null||toElsAccount.length<=0){
						alert('<i18n:I18n key="i18n_label_alert_CustomerelsAccountNotNull" defaultValue="客户Els帐号,不能为空!" />',2);
						return;
					}
					
					parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_label_confirmmodification" defaultValue="是否确认修改?" />',closeEvent:function(){
					var paramStr = $("#VenderForm").serializeJSON();
					var rowsIndex = VenderGrid.selectedRowsIndex();
					VenderGrid.updateRow(paramStr,rowsIndex);
					$('#dia').hide();
					}});
				}
			
				
				$("#deleteBtn").live("click", function() {
					var selectedRows=VenderGrid.selectedRows();	
	 				 var rowsIndex = VenderGrid.selectedRowsIndex();
	 				VenderGrid.removeRow(rowsIndex);
	 				 if(selectedRows.length<=0){
	 					 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
	 					 return;
	 				 }
	 				 var row = selectedRows[0];
	 				 var stockDate=row["stockDate"];
	 				 if(stockDate!=null){
	 					supplierStockVODelList.push(row);
	 				 }
				})
				
				$("#saveBtn").live("click", function() {
					var supplierStockVOList=[];
					if(VenderGrid.rowsLength() > 0){
						supplierStockVOList = VenderGrid.rows();
					}
	 				var Content={"elsAccount":elsAccount,"supplierStockVOList":supplierStockVOList,"supplierStockVODelList":supplierStockVODelList};
					parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存?" />',closeEvent:function(){
						$.ajax({
				    		url:"<%=basePath%>rest/SupplierStockService/saveSupplierStock",
				    		type:"post",
				    		contentType: "application/json",
				    		data: JSON.stringify(Content),
				    		dataType: "json",
				    		success: function(data) {
				    			alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
			 					VenderGrid.load(VenderGrid.opts.params);
				    		},
				    		error: function(data) {
				    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
				    		}
				    	}); 
						}});
				})
		</script>
</body>
</html>