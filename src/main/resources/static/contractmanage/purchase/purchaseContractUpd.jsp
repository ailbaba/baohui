<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation"/></span>
            <div class="common-box-line">
                <button id="saveBtn" class="button-wrap"><i18n:I18n defaultValue="保存" key=""/></button>
                <%-- <button id="saveSendBtn" class="button-wrap"><i18n:I18n defaultValue="保存发送" key=""/></button> --%>
            </div>
        </div>
		
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="采购合同头信息" key=""/></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="headTable"></table>
                    </div>
               </main>
            </div>
        </div>

        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="采购合同详细信息" key=""/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="合同条款信息" key=""/></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n defaultValue="合同物料信息" key=""/></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n defaultValue="合同附件" key=""/></a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container nest-table">
                        	<div class="edit-box-wrap" style="padding-top: 5px;">
				                <button id="queryBasicClause" class="button-wrap"><i18n:I18n defaultValue="选择条款" key=""/></button>
               					<button id="clauseDelBtn" class="button-wrap"><i18n:I18n defaultValue="移除" key="i18n_common_button_remove"/></button>
				            </div>
		                    <div class="grid-100" id="reCreate">
		                        <table id="clauseTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two">
                        <main class="grid-container nest-table">
                        	<div class="edit-box-wrap" style="padding-top: 5px;">
				                <button id="materialAddBtn" class="button-wrap"><i18n:I18n defaultValue="添加" key="i18n_common_button_addition"/></button>
               					<button id="materialDelBtn" class="button-wrap"><i18n:I18n defaultValue="移除" key="i18n_common_button_remove"/></button>
				            </div>
		                    <div class="grid-100" id="receiptDiv">
		                        <table id="materialTable"></table>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-three">
	                  <div class="box-wrap pos-relative bg-common">
			            <div class="common-box-line p-zero">
			                <div class="pos-relative upload-wrap">
			                    <div class="pos-absolute file-list">
									<div class="file-list-head">
					                   <select id="selectFileType" name="selectFileType" style="width: 165px;">
					                   <option value="all"><i18n:I18n defaultValue="所有文件" key="i18n_common_select_filetype_all"/></option>
					                   <option value="common"><i18n:I18n defaultValue="公共文件" key="i18n_common_select_filetype_public"/></option>
					                   </select>
					                 </div>
									<main class="grid-container">
										<div class="grid-100" id="reCreateFile">
											<table id="fileTable" style="width: 300px;"></table>
										</div>
									</main>
			                    </div>
				                 <div class="file-scan">
		   							<div class="file-option-zoom">
					                  <div class="dis-in-b text-left">
							             <button id="addFileBtn" class="button-wrap"><i18n:I18n defaultValue="添加" key="i18n_common_button_addition"/></button>
                                     	 <button id="deleteFileBtn" class="button-wrap"><i18n:I18n defaultValue="移除" key="i18n_common_button_remove"/></button>
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
    </div>
    
    <div class="fixed-dialog" id="queryBasicClauseDialog" >
		<div class="dialog-tip bg-common" style="width: 830px;height: 533px;margin-left: -415px;margin-top: -270px;">
		    <div class="dialog-close-btn" id="queryBasicClauseDialogClose"></div>
	        <div class="tip-head">
		        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
		        <span class="dialogTitle" id="queryBasicClauseDialogTitle"><i18n:I18n defaultValue="基础条款查询" key=""/></span>
		    </div>
		    <div class="" >
		        <div class="box-wrap pos-relative bg-common" >
		            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查询条件" key="i18n_additionCost_queryCondition"/></span>
		            <div class="common-box-line">
		                <table>
		                	<tr class="line-height-tr">
		                	    <td><i18n:I18n defaultValue="条款描述" key=""/>:</td>
		                		<td><input type="text" id="clauseDesc" /></td>
		                	    <td><i18n:I18n defaultValue="条款大类描述" key=""/>:</td>
		                		<td><input type="text" id="parentClauseDesc" /></td>
		                		<td><i18n:I18n defaultValue="关键字" key=""/>:</td>
		                		<td><input type="text" id="keyword" /></td>
								<td><button id="queryBasicClauseBtn" class="button-wrap "><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button></td>
		                	</tr>
		                </table>
		            </div>
		        </div>
		        <div class="box-wrap pos-relative bg-common" >
		            <main class="bg-common p-6">
	                    <div class="grid-100" >
	                        <table id="queryBasicClauseTable"></table>
	                    </div>
	                    <div class="mt-20 text-right" >
		                    <button id="queryBasicClauseDialogOkBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
		                    <button id="queryBasicClauseDialogCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
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
		        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
		        <span class="dialogTitle"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_title_chooseformfile"/></span>
		    </div>
		    <div class="">
		        <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
		               <div class="common-box-line">
							<div class="input-and-tip">
								<span><i18n:I18n defaultValue="文件名称" key="i18n_common_label_filename"/>:</span>
								<input id="fileName" name="fileName" type="text" />
							</div>
							<div class="input-and-tip">
								<span><i18n:I18n defaultValue="文件路径" key="i18n_common_label_filepath"/>:</span>
								<input id="filePath" name="filePath" type="text" />
							</div>
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
	<div class="fixed-dialog" id="selectFriendElsAccountDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectFriendElsAccountDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
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
<div class="fixed-dialog" id="selectContractTemplateDialog" >
	<div class="dialog-tip bg-common" style="width: 1200px;height:auto;margin-left: -600px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="selectContractTemplateDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div>
	    	 <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查询条件" key="i18n_additionCost_queryCondition"/></span>
	            <div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_contractTemplate_templateDesc" defaultValue="模板名称" />:</span>
					<input type="text" id="templateDescQuery" name="templateDescQuery" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_contractTemplate_templateType" defaultValue="模板类型" />:</span>
					<select id="templateType">
						<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
						<option value='附件类'>
							<i18n:I18n key="i18n_contractTemplate_attachmentType" defaultValue="附件类" />
						</option>
						<option value='条款类'>
							<i18n:I18n key="i18n_contractTemplate_clauseType" defaultValue="条款类" />
						</option>
					</select>
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_contractTemplate_businessType" defaultValue="业务类型" />:</span>
					<input type="text" id="businessType" name="businessType" />
				</div>
				<br>
                <div class="dis-in-b input-and-tip">
                	<span><i18n:I18n key="i18n_common_title_createdate" defaultValue="创建时间" />:</span>
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="fromCreateDate" name="fromCreateDate"/>
                </div>
                <div class="dis-in-b input-and-tip">
	                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="toCreateDate" name="toCreateDate" />
                </div>
                <div class="dis-in-b input-and-tip"> 
						<button id="queryContractTemplateBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
				</div>
			</div>
	        </div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectContractTemplateTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="selectContractTemplateOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="selectContractTemplateCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<div class="fixed-dialog" id="selectPrincipalDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectPrincipalDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectPrincipalDialog"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="select-principal-table"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
	                    <button id="btnSelectPrincipalOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
	                    <button id="btnSelectPrincipalCancel" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<script>
	var elsAccount="${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	var fileUploader;
	var currShowFile = "";
	
	//*********************************修改部分******************************//
	//表格渲染
	//数据库中renderer大量修改
    function editHeadRender(val,item,rowIndex){
		var thisRecord = $(this);
		var colName = thisRecord[0].name;
		if("undefined"==typeof(val) || null == val){
			val = "";
		} 
		if("contractSignedDate"==colName || "contractStartDate"==colName || "contractEndDate"==colName || "erpContractSignedDate"==colName){
			if(val == ""){
				return "<input type='text' name='"+colName+"' class='Wdate' onfocus='WdatePicker({dateFmt:\"yyyy-MM-dd\"})' value='"+val+"' />";
			}
			return "<input type='text' name='"+colName+"' class='Wdate' onfocus='WdatePicker({dateFmt:\"yyyy-MM-dd\"})' value='"+new Date(val).format("yyyy-MM-dd")+"' />";
		}else{
			return "<input type='text' name='"+colName+"' class='headColsEdit' value='"+val+"' />";
		}
    }
    function readOnlyHeadRender(val,item,rowIndex){
		var thisRecord = $(this);
		var colName = thisRecord[0].name;
		if("undefined"==typeof(val) || null == val){
			val = "";
		} 
		return "<input type='text' name='"+colName+"' class='headColsEdit' value='"+val+"' readonly='readonly' />";
	}
    function headToElsAccountRender(val,item,rowIndex){
    	var html = "<input type='text' id='toElsAccount' name='toElsAccount' class='toElsAccount' value='"+val+"' readonly='readonly' />"
			+"<img class='toElsAccount dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' id='queryToElsAccount' />";
		return html;
    }
    function headToElsDescRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		return "<input type='text' id='toElsDesc' name='toElsDesc' readonly='readonly' value='"+val+"' />";
	}
    function headTemplateNumberRender(val,item,rowIndex){
    	var html = "<input type='text' id='templateNumber' name='templateNumber' class='templateNumber' value='"+val+"' readonly='readonly' />"
			+"<img class='templateNumber dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' id='queryTemplateNumber' />";
		return html;
    }
    function headTemplateDescRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		return "<input type='text' id='templateDesc' name='templateDesc' readonly='readonly' value='"+val+"' />";
	}
    function headTemplateVersionRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		return "<input type='text' id='templateVersion' name='templateVersion' readonly='readonly' value='"+val+"' />";
	}
  	//模板状态
    var showTemplateStatus = function (val,item,index){
    	//0:无效  1:有效
    	if (val == "1") return '<i18n:I18n key="i18n_basicClauseManage_enabled" defaultValue="有效" />'
    	else return '<i18n:I18n key="i18n_basicClauseManage_disabled" defaultValue="无效" />'
    };
    function headSalePersonRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		var html = "<input type='text' id='salePerson' name='salePerson' class='salePerson' value='"+val+"' readonly='readonly' />"
				+"<img class='salePerson dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' />";

		return html;
	}
	function headPurchasePersonRender(val,item,rowIndex){
		if("undefined"==typeof(val)){
			val = "";
		}
		var html = "<input type='text' id='purchasePerson' name='purchasePerson' class='purchasePerson' value='"+val+"' readonly='readonly' />"
				+"<img class='purchasePerson dis-in-b' src='${pageContext.request.contextPath}/icon/min/search_gray.png' style='width: 14px; height: 14px;position: absolute;right: 4px;top: 2px;cursor: pointer;' />";

		return html;
	}
	$(".headColsEdit").live('keyup',function(){
		var thisVal = $(this).val();
		var thisName = $(this).attr("name");
		var rowIndex = $(this).closest("tr").index();
		var rowData = headGrid.row(rowIndex);
		rowData[""+thisName] = thisVal;//可编辑单元格按下时将值赋给mmgrid对象对应属性
	});
	//下拉框
	function bussinessTypeSelect(val,item,rowIndex) {
        if("undefined"==typeof(val)){
    		val = ""; 
    	}
      	var bussinessTypeSel = $("<select name='businessType' class='select-tag'><option value='' selected>请选择</option><option value='0'>机械</option><option value='1'>电商</option><option value='2'>农业</option></select>");
      	var bussinessType = bussinessTypeSel.clone();
      	bussinessType.find("option[value='"+val+"']").attr("selected",true);
		return bussinessType.prop("outerHTML");	
  	}
    $('.select-tag').live('change',function(e) {
        var value = $(this).find("option:selected").val();
        var thisName = $(this).attr("name");
		var rowIndex = $(this).closest("tr").index();
		var rowData = headGrid.row(rowIndex);
		rowData[""+thisName] = value;//将值赋给mmgrid对象对应属性
    });
	
	function clauseRender(val,item,rowIndex){
		var thisRecord = $(this);
		var colName = thisRecord[0].name;
		if("undefined"==typeof(val) || null == val){
			val = ""; 
		}
		return "<input typpe='text' name='"+colName+"' class='clasueColsEdit' value='"+val+"' />";
	}
   
	$(".clasueColsEdit").live('keyup',function(){
		var thisVal = $(this).val();
		var thisName = $(this).attr("name");
		var rowIndex = $(this).closest("tr").index();
		var rowData = clauseGrid.row(rowIndex);
		rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
	});
	
	function materialRender(val,item,rowIndex){
		var thisRecord = $(this);
		var colName = thisRecord[0].name;
		if("undefined"==typeof(val) || null == val){
			val = ""; 
		}
		return "<input typpe='text' name='"+colName+"' class='materialColsEdit' value='"+val+"' />";
	}
   
	$(".materialColsEdit").live('keyup',function(){
		var thisVal = $(this).val();
		var thisName = $(this).attr("name");
		var rowIndex = $(this).closest("tr").index();
		var rowData = materialGrid.row(rowIndex);
		rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
	});
	
	function fileRender(val,item,rowIndex){
		var thisRecord = $(this);
		var colName = thisRecord[0].name;
		if("undefined"==typeof(val) || null == val){
			val = ""; 
		}
		return "<input typpe='text' name='"+colName+"' class='fileColsEdit' value='"+val+"' />";
	}
   
	$(".fileColsEdit").live('keyup',function(){
		var thisVal = $(this).val();
		var thisName = $(this).attr("name");
		var rowIndex = $(this).closest("tr").index();
		var rowData = fileGrid.row(rowIndex);
		rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
	});
	//*********************************修改部分******************************//
	
	var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractHeadAdd"/>;
	var headGrid = $("#headTable").mmGrid({
		url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractHead",
		method :  "POST",
		cols : headCols,
		autoLoad : false,
		root : "rows",
		height : "150px",
		loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		multiSelect : false,
        checkCol : false,
        indexCol :false,
	});
	//*********************************修改部分开始******************************//
	//点击单元格
	headGrid.on('cellSelected',function(e, item, rowIndex, colIndex){
		var _this=$(e.target);
		headSelectIndex = rowIndex;
		if(_this.hasClass("toElsAccount")) {
			showToElsAccount();
		} else if(_this.hasClass("templateNumber")){
			showTemplateNumber();
		} else if(_this.hasClass("salePerson")){
			showSalePerson();
		} else if(_this.hasClass("purchasePerson")){
			showPurchasePerson();
		} else {

		}
	});
	
	//选择负责人相关-----------------begin---------------
	var subAccountCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findSubAccountByNumber"/>;
	var queryPrincipalType = "sale";
	var queryPrincipalGrid;

	//本方负责人查询其下子账户(采购方)
	function showPurchasePerson(){
		$("#selectPrincipalDialog").show();

		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		var principal = selectRow.find("input[name='purchasePerson']").val();
		var principalArray = principal.split(";");//根据“;”获取以选择的负责人数组
		queryPrincipalType = "purchase";

		if(queryPrincipalGrid){
			queryPrincipalGrid.load({elsAccount : elsAccount,station : "purchase"});
		} else {
			queryPrincipalGrid = $("#select-principal-table").mmGrid({
				cols: subAccountCols,
				url: "${pageContext.request.contextPath}/rest/AccountService/subAccountList",
				method: "post",
				params : {elsAccount : elsAccount,station : "purchase"},
				root: "rows",
				loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
				noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
				multiSelect: true,
				checkCol: true,
				indexCol:true
			});
		}

		var totalRows = queryPrincipalGrid.rows();
		if(totalRows != "" &&totalRows != null && principalArray){
			for(var i = 0 ; i < totalRows.length ; i ++){
				for(var j = 0 ; j < principalArray.length ; j ++ ){
					var elsSubAccount = totalRows[i].elsSubAccount;
					var uname = totalRows[i].name;
					var _principal = principalArray[j];
					var _principalArray = _principal.split("_");
					var _elsSubAccount = _principalArray[0];
					var _name = _principalArray[1];
					if(elsSubAccount == _elsSubAccount && uname == _name){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
						queryPrincipalGrid.select(i);
						continue;
					}
				}
			}
		}
	}

	//选择负责人弹出框确认按钮单击事件
	$("#btnSelectPrincipalOK").click(function(){
		var selectedRows = queryPrincipalGrid.selectedRows();
		var principals ="";
		if(selectedRows != "" ){
			for(var i = 0 ; i < selectedRows.length ; i ++){
				var singleRow = selectedRows[i];
				var elsSubAaccount = singleRow.elsSubAccount;
				var uname = singleRow.name;
				if(i == 0){
					principals += elsSubAaccount+"_"+uname;
				}else{
					principals += ";"+elsSubAaccount+"_"+uname;
				}
			}
		}else{
			alert("<i18n:I18n defaultValue='至少选择一条记录！' key='i18n_common_title_selectAtLeastOneRecord'/>",2);
			return;
		}

		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		var record = headGrid.row(0);
		if(queryPrincipalType == "purchase"){
			selectRow.find("input[name='purchasePerson']").val(principals);//回填文本框
			record["purchasePerson"]=principals;//表格属性赋值
		} else if(queryPrincipalType == "sale"){
			selectRow.find("input[name='salePerson']").val(principals);//回填文本框
			record["salePerson"]=principals;//表格属性赋值
		} else {
			// do nothing
		}

		$("#selectPrincipalDialog").hide();
	});

	$("#btnSelectPrincipalDialogClose").click(function(){
		$("#selectPrincipalDialog").hide();
	});

	$("#btnSelectPrincipalCancel").click(function(){
		$("#selectPrincipalDialog").hide();
	});

	//销售方负责人查询
	function showSalePerson(){
		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		var principal = selectRow.find("input[name='salePerson']").val();
		var principalArray = principal.split(";");//根据“;”获取已选择的负责人数组
		queryPrincipalType = "sale";
		var toElsAccount = selectRow.find("input[name='toElsAccount']").val();
		if(toElsAccount == ""){
			alert("<i18n:I18n defaultValue='请先选择对方ELS！' key='i18n_label_additionCost_pleaseSelectToElsAccounts'/>！",2);
			return false;
		}

		$("#selectPrincipalDialog").show();
		if(queryPrincipalGrid){
			queryPrincipalGrid.load({elsAccount : toElsAccount,station : "sale"});
		} else {
			queryPrincipalGrid = $("#select-principal-table").mmGrid({
				cols: subAccountCols,
				url: "${pageContext.request.contextPath}/rest/AccountService/subAccountList",
				method: "post",
				params : {elsAccount : toElsAccount,station : "sale"},
				root: "rows",
				loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
				noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
				multiSelect: true,
				checkCol: true,
				indexCol:true
			});
		}

		var totalRows = queryPrincipalGrid.rows();
		if(totalRows != "" &&totalRows != null && principalArray){
			for(var i = 0 ; i < totalRows.length ; i ++){
				for(var j = 0 ; j < principalArray.length ; j ++ ){
					var elsSubAccount = totalRows[i].elsSubAccount;
					var uname = totalRows[i].name;
					var _principal = principalArray[j];
					var _principalArray = _principal.split("_");
					var _elsSubAccount = _principalArray[0];
					var _name = _principalArray[1];
					if(elsSubAccount == _elsSubAccount && uname == _name){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
						queryPrincipalGrid.select(i);
						continue;
					}
				}
			}
		}
	}
	//选择负责人相关-----------------end---------------
	
	//查询对方ELS信息(只在好友列表中查询)
	var toElsCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="findMyFriendsByType"/>;
	var toElsGrid;
	function showToElsAccount(){
		$("#selectFriendElsAccountDialog").show();
		toElsGrid = $('#selectFriendElsAccountTable').mmGrid({
			cols : toElsCols,
			url : "${pageContext.request.contextPath}/rest/FriendsService/findMyFriendsByType",
			params : {
				elsAccount : elsAccount,
				elsSubAccount : elsSubAccount,
				groupIdAName : "<i18n:I18n defaultValue='客户' key='i18n_label_customer'/>"
			},
			method : "post",
			root : "rows",
			loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
			noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
			multiSelect : false,
			checkCol : true,
			indexCol :false
		});

		var selectRow = $("#headTable tbody tr").eq(headSelectIndex);

		//var selectToElsAccount = $("#toElsAccount").val();
		var selectToElsAccount = selectRow.find("input[name='toElsAccount']").val();
		var totalRows = toElsGrid.rows();
		if(totalRows != null && totalRows != "" && selectToElsAccount){
			for(var i = 0 ; i < totalRows.length ; i ++){
				var toElsAccount = totalRows[i].friendElsAccount;
				var toElsDesc = totalRows[i].friendCompanyName;
				if(toElsAccount == selectToElsAccount){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
					toElsGrid.select(i);
					continue;
				}
			}
		}
	}
	//选择对方ELS确认按钮单击事件
	$("#selectFriendOKBtn").click(function(){
		var selectedRows = toElsGrid.selectedRows();
		if(selectedRows != "" ){
			$("#toElsAccount").val(selectedRows[0].friendElsAccount);
			$("#toElsDesc").val(selectedRows[0].friendCompanyName);
			
			var record = headGrid.row(0);
			record["toElsAccount"]=selectedRows[0].friendElsAccount;
			record["toElsDesc"]=selectedRows[0].friendCompanyName;
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
	
	//查询合同模板
	var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="contractTemplateHeadManage"/>;
	var contractTemplateGrid;
	function showTemplateNumber(){
		$("#selectContractTemplateDialog").show();
		contractTemplateGrid = $("#selectContractTemplateTable").mmGrid({
			url : "${pageContext.request.contextPath}/rest/ContractManageService/queryContractTemplateHead",
			method :  "POST",
			autoLoad : false,
			cols : headCols,
			root : "rows",
			loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
			noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
			multiSelect : false,
		    checkCol : true,
		    indexCol : false,
		});
	}
	$("#queryContractTemplateBtn").click(function(){
		queryContractTemplate();
	});
	
	function queryContractTemplate(){
		var templateDescQuery = $("#templateDescQuery").val();
	    var templateType = $("#templateType").val();
	    var businessType = $("#businessType").val();
	    var fromCreateDate = $("#fromCreateDate").val();
		var toCreateDate = $("#toCreateDate").val();
		
		var queryParam = {
	    	elsAccount : elsAccount,
	    	templateDesc : templateDescQuery,
	    	templateType : templateType,
	    	businessType : businessType,
	    	fromCreateDate : fromCreateDate,
	    	toCreateDate : toCreateDate
	    };
		contractTemplateGrid.load(queryParam);
	}
	//选择合同模板点击确定事件
	$("#selectContractTemplateOKBtn").click(function(){
		clauseGrid.removeRow();//删除条款所有行
		fileGrid.removeRow();//删除附件所有行
		
		var selectedRows = contractTemplateGrid.selectedRows();
		if(selectedRows != "" ){
			var showContractClauseParam = {
			    	elsAccount : elsAccount,
			    	language : language,
			    	templateNumber : selectedRows[0].templateNumber,
			    	templateVersion : selectedRows[0].templateVersion
			};
			$("#templateNumber").val(selectedRows[0].templateNumber);
			$("#templateDesc").val(selectedRows[0].templateDesc);
			$("#templateVersion").val(selectedRows[0].templateVersion);
			
			var headRecord = headGrid.row(0);
			headRecord["templateNumber"]=selectedRows[0].templateNumber;
			headRecord["templateDesc"]=selectedRows[0].templateDesc;
			headRecord["templateVersion"]=selectedRows[0].templateVersion;
			
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/ContractManageService/queryContractTemplateClauseByTemplateNumber",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(showContractClauseParam),
				dataType : "json",
				success : function(data) {
					for(var i=0 ; i<data.length ; i++){
						var record = {
								elsAccount : elsAccount,
								elsDesc : elsDesc,
								toElsAccount : headRecord.toElsAccount,
								toElsDesc : headRecord.toElsDesc,
								contractNumber : headRecord.contractNumber,
								contractDesc : headRecord.contractDesc,
								contractTemplateNumber : headRecord.templateNumber,
								language : data[i].language,
								contractClauseCode : data[i].clauseNumber,
								contractClauseName : "",
								parentClauseNumber : data[i].parentClauseNumber,
								clauseDesc : data[i].clauseDesc,
								parentClauseDesc : data[i].parentClauseDesc,
								clauseLevel1Sequence : data[i].clauseLevel1Sequence,
								clauseLevel2Sequence : data[i].clauseLevel2Sequence,
								clauseLevel3Sequence : data[i].clauseLevel3Sequence,
								clauseParam1 : data[i].clauseParam1,
								clauseParam2 : data[i].clauseParam2,
								clauseParam3 : data[i].clauseParam3,
								clauseParam4 : data[i].clauseParam4,
								clauseParam5 : data[i].clauseParam5,
								remark : data[i].remark
						};
						clauseGrid.addRow(record,i);
					}
				},
				error : function(data) {
					alert("<i18n:I18n defaultValue='请求出错' key=''/>!",3);
				}
			});
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/ContractManageService/queryContractTemplateHeadByAjax",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(showContractClauseParam),
				dataType : "json",
				success : function(data) {
					var record = {
							elsAccount : elsAccount,
							elsDesc : elsDesc,
							toElsAccount : headRecord.toElsAccount,
							toElsDesc : headRecord.toElsDesc,
							contractNumber : headRecord.contractNumber,
							contractDesc : headRecord.contractDesc,
							contractItemNumber : "",
							contractFileNumber : "1",
							contractFileName : data[0].attachmentFileName,
							contractFileType : data[0].attachmentFileType,
							contractFileVersion : "V1",
							contractFilePath : data[0].attachmentFilePath,
							sendStatus : "0",
							contractFileCreate : "purchase",
							remark : data[0].remark,
							fbk1 : "head"
					};
					fileGrid.addRow(record);
				},
				error : function(data) {
					alert("<i18n:I18n defaultValue='请求出错' key=''/>!",3);
				}
			});	
		}else{
			alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
			return;
		}
		$("#selectContractTemplateDialog").hide();
	});

	$("#selectContractTemplateDialogClose").click(function(){
		$("#selectContractTemplateDialog").hide();
	});

	$("#selectContractTemplateCancelBtn").click(function(){
		$("#selectContractTemplateDialog").hide();
	});
	//*********************************修改部分结束******************************//
	
	
	var clauseCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractClauseAdd"/>;
	var clauseGrid = $("#clauseTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractClause",
	    method:  "POST",
	    cols : clauseCols,
	    autoLoad : false,
	    root:"rows",
	    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    checkCol: true,
	    multiSelect: true,
	});
	
	var materialCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractMaterialAdd"/>;
	var materialGrid = $('#materialTable').mmGrid({
	    cols : materialCols,
	    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractMaterial",
	    method : 'post',
	    root : "rows",
	    autoLoad : false,
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    multiSelect : true,
	    checkCol : true,
	    indexCol : false
	});
	
	var fileCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseContractFileAdd"/>;
	var fileGrid = $("#fileTable").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryPurchaseContractFile",
	    method : "post",
	    cols : fileCols,
	    autoLoad : false,
	    root : "rows",
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    fullWidthRows :true,
	    checkCol : true,
	    indexCol : false,
	});
	
	headGrid.on("loadSuccess",function(e, data) {
    	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
			var record = data.rows[0];
            //根据头表选中项加载对应行,文件等信息
			loadClause(record.elsAccount,record.contractNumber);
			loadFile(record.elsAccount,record.contractNumber);
			loadMaterial(record.elsAccount,record.contractNumber);
		}
    });
	
	fileGrid.on("loadSuccess", function(e, data){
		reGenFileSelect();
  	});
    
    fileGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
    	var filePath = item.contractFilePath;
  		if(currShowFile == filePath){//如果选中的为当前显示文件则不做其他操作
		} else {//如果选中的不是当前显示文件则重新刷新右侧显示文件
			currShowFile = filePath;
			previewFile(filePath);
		}
  	});
	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    $("#sheet-project").tabs();
	    var currDate = new Date();
	    
	    var paramElsAccount = "${param.elsAccount}";
	    var paramContractNumber = "${param.contractNumber}";
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	contractNumber : paramContractNumber,
	    };
	    headGrid.load(queryParam);
	}
	 	
    fileGrid.on("loadSuccess", function(e, data){
    	reGenFileSelect();
  	});
    
    function getSelectedHeadRow(){
		var selectRow;
		if("undefined" == typeof(headSelectIndex)){
			selectRow = $("#headTable tbody tr").eq(0);//没有选中行默认选中第一行
		} else {
			selectRow = $("#headTable tbody tr").eq(headSelectIndex);
		}
		return selectRow;
	}
    $("#saveBtn").click(function(){
    	var headRow = getSelectedHeadRow();
    	var headData = headGrid.row(0);
    	headData["contractSignedDate"] = headRow.find("input[name='contractSignedDate']").val();
    	headData["contractStartDate"] = headRow.find("input[name='contractStartDate']").val();
    	headData["contractEndDate"] = headRow.find("input[name='contractEndDate']").val();
    	headData["erpContractSignedDate"] = headRow.find("input[name='erpContractSignedDate']").val();
		var purchaseContractHead = headData;
		//*********************************修改部分******************************//
	   	var purchaseContractClause = clauseGrid.rowsLength() == 0 ? [] : clauseGrid.rows();
	   	var purchaseContractMaterial = materialGrid.rowsLength() == 0 ? [] : materialGrid.rows();
	   	var purchaseContractFile = fileGrid.rowsLength() == 0 ? [] : fileGrid.rows();
	   	
	   	var data = {
	   			operate : "save",
	   			purchaseContractHead : JSON.stringify(purchaseContractHead),
	   			purchaseContractClause : JSON.stringify(purchaseContractClause),
	   			purchaseContractMaterial : JSON.stringify(purchaseContractMaterial),
	   			purchaseContractFile : JSON.stringify(purchaseContractFile),
	   	}
	   	
	   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中' key=''/>");
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/ContractManageService/savePurchaseContract",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存成功' key=''/>!",1);
				parent.elsDeskTop.closeCurWin("purchaseContractUpd",callBack);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='保存失败' key=''/>!",3);
			}
		});
	});
    
	/* $("#saveSendBtn").click(function(){
    	var headRow = getSelectedHeadRow();
    	var headData = headGrid.row(0);
    	headData["contractSignedDate"] = headRow.find("input[name='contractSignedDate']").val();
    	headData["contractStartDate"] = headRow.find("input[name='contractStartDate']").val();
    	headData["contractEndDate"] = headRow.find("input[name='contractEndDate']").val();
    	headData["erpContractSignedDate"] = headRow.find("input[name='erpContractSignedDate']").val();
		var purchaseContractHead = headData;
	   	var purchaseContractClause = clauseGrid.rowsLength() == 0 ? [] : clauseGrid.rows();
	   	var purchaseContractMaterial = materialGrid.rowsLength() == 0 ? [] : materialGrid.rows();
	   	var purchaseContractFile = fileGrid.rowsLength() == 0 ? [] : fileGrid.rows();
	   	
	   	var data = {
	   			operate : "saveSend",
	   			purchaseContractHead : JSON.stringify(purchaseContractHead),
	   			purchaseContractClause : JSON.stringify(purchaseContractClause),
	   			purchaseContractMaterial : JSON.stringify(purchaseContractMaterial),
	   			purchaseContractFile : JSON.stringify(purchaseContractFile),
	   	}
	   	
	   	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='采购合同发送中!' key=''/>");
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/ContractManageService/savePurchaseContract",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='发送成功' key=''/>!",1);
				parent.elsDeskTop.closeCurWin("purchaseContractUpd",callBack);
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("<i18n:I18n defaultValue='发送失败' key=''/>!",3);
			}
		});
	}); */
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
	function callBack(){
		if(parent.frames['iframeApp_purchaseContractManage']) {
			parent.frames['iframeApp_purchaseContractManage'].init();
		}
	}
	
	$("#clauseDelBtn").click(function(){
		var selectedIndexes = clauseGrid.selectedRowsIndex();
		for(var i = selectedIndexes.length ; i-1 >= 0 ; i--){
			var index = selectedIndexes[i-1];
			clauseGrid.removeRow(index);//删除选中行
		}
	});
	
	//查询基础条款信息--------------begin---------------
	var renderClauseStatus = function(val,item,rowIndex){
		if("undefined"==typeof(val) || ""==val){
			return "无效";
		} else if("1"==val){
			return "有效";
		} else {
			return "无效";
		}
	};
	var queryBasicClauseCols = [
            { title:"<i18n:I18n defaultValue='条款编码' key=''/>", name:'clauseNumber', width: 100, align: 'center'},
            { title:"<i18n:I18n defaultValue='语言' key=''/>", name:'language' , width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='条款描述' key=''/>", name:'clauseDesc' , width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='条款大类描述' key=''/>", name:'parentClauseDesc' , width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='检索关键字' key=''/>", name:'keyword' ,width:100, align:'center'},
            { title:"<i18n:I18n defaultValue='状态' key=''/>", name:'status' ,width:100, align:'center',renderer:renderClauseStatus},
            { title:"<i18n:I18n defaultValue='备注' key=''/>", name:'remark' ,width:100, align:'center'},
        ];
	
	var queryBasicClauseGrid;
	$("#queryBasicClause").click(function(){
		$("#queryBasicClauseDialog").show();//mmgrid加载需指定宽高或知道父容器的宽高,父容器隐藏时无宽高,需先显示再加载或者指定一个宽高让mmgrid加载
		if("undefined"==typeof(queryBasicClauseGrid) || null == queryBasicClauseGrid){
			queryBasicClauseGrid = $("#queryBasicClauseTable").mmGrid({
				cols : queryBasicClauseCols,
				url : "${pageContext.request.contextPath}/rest/ContractManageService/queryBasicClause",
		        method : 'post',
		        autoLoad : false,
		        root : '',
		        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		        indexCol : true,
		        multiSelect :true,
		        checkCol : true
	     	});
		}
	});
	
	$("#queryBasicClauseBtn").click(function(){
		var parentClauseDesc = $("#parentClauseDesc").val();
		var clauseDesc = $("#clauseDesc").val();
		var keyword = $("#keyword").val();
		
		var param = {
				elsAccount : elsAccount,
				parentClauseDesc : parentClauseDesc,
				clauseDesc : clauseDesc,
				keyword : keyword,
		};
		queryBasicClauseGrid.load(param);
	});
	
	$("#queryBasicClauseDialogOkBtn").click(function(){
		var selectRows = queryBasicClauseGrid.selectedRows();
		if(selectRows.length == 0){
			alert("<i18n:I18n defaultValue='请选择条款!' key=''/>",2);
			return;
		}
		var clauseRows = clauseGrid.rows();
		if("undefined" != typeof(clauseRows) && clauseGrid.rowsLength() > 0 && "undefined" != typeof(selectRows)){
			for( var i = 0 ; i < clauseRows.length ; i ++){
				var clauseRow = clauseRows[i];
				if("undefined" != typeof(clauseRow)){
					for( var j = 0 ; j < selectRows.length ; j ++){
						var selectRow = selectRows[j];
						
						var rowElsAccount = clauseRow.elsAccount;
						var rowClauseNumber = clauseRow.contractClauseCode;
						var rowLanguage = clauseRow.language;
						var _elsAccount = selectRow.elsAccount;
						var _clauseNumber = selectRow.clauseNumber;
						var _language = selectRow.language;
						
						if(rowElsAccount == _elsAccount && rowClauseNumber == _clauseNumber && rowLanguage==_language){
							selectRows.splice(j,1);//去重复
						}
					}
				}
			}
		}
		
		var headRecord = headGrid.row(0);
		
		var clauseSize = clauseGrid.rowsLength();
		
	    var rows = [];
		for(var i = 0 ; i < selectRows.length ; i++ ){ //设置初始值
			var selectRow = selectRows[i];
			var record = {
					elsAccount : elsAccount,
					elsDesc : elsDesc,
					toElsAccount : headRecord.toElsAccount,
					toElsDesc : headRecord.toElsDesc,
					contractNumber : headRecord.contractNumber,
					contractDesc : headRecord.contractDesc,
					contractTemplateNumber : headRecord.templateNumber,
					language : selectRow.language,
					contractClauseCode : selectRow.clauseNumber,
					contractClauseName : "",
					clauseDesc : selectRow.clauseDesc,
					parentClauseDesc : selectRow.parentClauseDesc,
			};
			rows.push(record);
			clauseGrid.addRow(record,clauseSize+i);//mmgrid添加数组时顺序是反的,指定顺序添加
		}
		$("#queryBasicClauseDialog").hide();
	});
	
	//关闭窗口
	$("#queryBasicClauseDialogClose").click(function(){
		$("#queryBasicClauseDialog").hide();
	});
	
	//关闭窗口
	$("#queryBasicClauseDialogCancelBtn").click(function(){
		$("#queryBasicClauseDialog").hide();
	});
	//查询基础条款信息--------------end---------------
	
	$("#materialAddBtn").click(function(){
		var headRecord = headGrid.row(0);
		var contractItemNumber;
		if(materialGrid.rowsLength() == 0){
			contractItemNumber = 1;
		} else {
			contractItemNumber = materialGrid.rowsLength()+1;
		}
		var materialRecord = {
				elsAccount : elsAccount,
				elsDesc : elsDesc,
				toElsAccount : headRecord.toElsAccount,
				toElsDesc : headRecord.toElsDesc,
				contractNumber : headRecord.contractNumber,
				contractDesc : headRecord.contractDesc,
				contractItemNumber : contractItemNumber,
		};
		
		materialGrid.addRow(materialRecord,contractItemNumber);
		reGenFileSelect();
	});
	
	$("#materialDelBtn").click(function(){
		var selectedIndexes = materialGrid.selectedRowsIndex();
		for(var i = selectedIndexes.length ; i-1 >= 0 ; i--){
			var index = selectedIndexes[i-1];
			materialGrid.removeRow(index);//删除选中行
		}
		reGenMaterialItemNumber();
	});
	
	function reGenMaterialItemNumber(){
		if(materialGrid.rowsLength() > 0){
			for(var i=0;i<materialGrid.rowsLength();i++){
				var materialRecord = materialGrid.row(i);
				materialRecord["contractItemNumber"] = i+1;
				materialGrid.updateRow(materialRecord,i);
			}
		}
		reGenFileSelect();
	}
	
	function reGenFileSelect(){
		var fileTypeSelect = $("#selectFileType");
		fileTypeSelect.empty();
		$("<option value='all'><i18n:I18n defaultValue='所有' key='i18n_common_option_all'/></option>").appendTo(fileTypeSelect);
		$("<option value='common'><i18n:I18n defaultValue='公共' key='i18n_common_option_common'/></option>").appendTo(fileTypeSelect);
		for(var i=0;i<materialGrid.rowsLength();i++){
			var contractItemNumber = materialGrid.row(i).contractItemNumber;
			$("<option value='"+contractItemNumber+"'>"+contractItemNumber+"</option>").appendTo(fileTypeSelect);//文件下拉列表添加行项目选项
		}
	}
	
	//表单文件tag页 文件类型更改事件
	function selectFileTypeChange(){
		var selectFileType = $("#selectFileType").val();
		if("all" == selectFileType){//显示所有
			$("#fileTable tr").each(function(index,domElement){
				$(domElement).show();
			});
		} else if("common" == selectFileType){//只显示公共文件
			$("#fileTable tr").each(function(index,domElement){
				var contractItemNumber = fileGrid.row(index).contractItemNumber;
				if("" == contractItemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		} else {//显示指定行项目下的文件
			$("#fileTable tr").each(function(index,domElement){
				var contractItemNumber = fileGrid.row(index).contractItemNumber;
				if(selectFileType == contractItemNumber){
					$(domElement).show();
				} else {
					$(domElement).hide();
				}
			});
		}
	}
	
	//单击添加表单文件事件
	$('#addFileBtn').click(function() {
		clearAddFileInfo();
		$("#addFileDialog").show();
		initFileUploader(fileUploader);
	});
	 
	$("#addFileBtnOK").click(function(){
		$("#addFileDialog").hide();
		var filePath = $("#filePath").val();
		if(filePath == ""){
			alert("<i18n:I18n defaultValue='请选择上传文件！' key='i18n_please_select_a_file_to_upload'/>",1);
			return false;
		}
		addFileTableRow();
		clearAddFileInfo();
	});
	 
	//添加文件弹出框取消按钮
	$("#addFileBtnCancel").click(function(){
		$("#addFileDialog").hide();
		clearAddFileInfo();
	});
	
	//关闭按钮处理
	$("#dialogFileClose").click(function(){
		$("#addFileDialog").hide();
		clearAddFileInfo();
	});
	//删除选择文件行事件
	 $("#deleteFileBtn").click(function(){
	     var selectedIndexes = fileGrid.selectedRowsIndex();
	     var selectedRows = fileGrid.selectedRows();
	     fileGrid.removeRow(selectedIndexes);
	     var viewerPlaceA = $("#viewerPlaceHolder");
	     viewerPlaceA.empty();
	     reGenerateFileSequence();//删除文件行后,重新生成文件序号
	 });
	 function reGenerateFileSequence(){
	    	var fileTableRows = fileGrid.rowsLength();
	    	if(fileTableRows > 0){
		    	for(var i=0;i<fileTableRows;i++){
		    		var fileRow = fileGrid.row(i);
		    		fileRow["contractFileNumber"] = i+1;
		    	}
		    	fileGrid.load(fileGrid.rows());
	    	}
	    }
	//----------添加附件相关-----------end--------------------
	
	function clearAddFileInfo(){
    	$("#fileName").val("");
    	$("#filePath").val("");
    	$("#fileType").val("");
    }
    
    //增加文件到表单文件table
    function addFileTableRow(){
   		var fileName = $("#fileName").val();
   		var filePath = $("#filePath").val();
   		var fileType = $("#fileType").val();
   		var selectFileType = $("#selectFileType").val();
   		var contractItemNumber;
   		if("common"==selectFileType || "all"==selectFileType){
   			contractItemNumber = "";
   		} else {
   			contractItemNumber = selectFileType;
   		}
   		var fileNumber = fileGrid.rowsLength() + 1;
   		var headRecord = headGrid.row(0);
   		var fileRecord = {
   				elsAccount : elsAccount,
				elsDesc : elsDesc,
				toElsAccount : headRecord.toElsAccount,
				toElsDesc : headRecord.toElsDesc,
				contractNumber : headRecord.contractNumber,
				contractDesc : headRecord.contractDesc,
				contractItemNumber : contractItemNumber,
				contractFileNumber : fileNumber,
				contractFileName : fileName,
				contractFileType : fileType,
				contractFileVersion : "V1",
				contractFilePath : filePath,
				sendStatus : "0",
				contractFileCreate : "purchase",
   		};
   		fileGrid.addRow(fileRecord,fileGrid.rowsLength()+1);
   	}
    
    function initFileUploader(fileUploader){
   	    //新增表单文件
   	    if (!fileUploader) {
    	  	fileUploader = WebUploader.create({
    	  	    swf : "${pageContext.request.contextPath}/jsLib/webuploader/Uploader.swf",// swf文件路径
    	  	    auto : true,//是否选择文件后自动上传
    	  	    server : "${pageContext.request.contextPath}/servlet/UploadServlet",// 文件接收服务端。
    	  	    pick : "#btnFileUpload",//选择文件的按钮,可选.内部根据当前运行时创建,可能是input元素,也可能是flash/
    	  	    resize : false,// 不压缩image,默认如果是jpeg,文件上传前会压缩再上传.
    	  	    formData : {
    		     	elsAccount : elsAccount
    		    }
    	  	});
    	  	
    	 	// 当有文件添加进来的时候
    		fileUploader.on("fileQueued",function(file){
    			var fileName = file.name;
    			$("#fileName").val(fileName);
    			$("#fileType").val(file.ext);
    		});
    	 	//文件上传成功时触发
    		fileUploader.on("uploadSuccess", function(file,response) {
    			var errorNumber = response.error;
    			if(errorNumber == 0){
					var filePath = response.url;
					$("#filePath").val(filePath);
    			} else {
	    			var errorMessage = response.message;
	    			alert(errorMessage,3);
    			}
     	  	});
    		//上传出错时触发
    		fileUploader.on( "uploadError", function( obj, reason  ) {
     	  	   	var errorMessage = response.message;
     	  	    alert(reason,3); 
     	  	});
   	    }
   	}
	
    //在线预览文件
    function previewFile(filePath){
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var param = {
				elsAccount : elsAccount,
				filePath : filePath
		};
    	
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	} else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
	    	$.ajax({
				url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
				type :"POST",
				data : JSON.stringify(param),
				contentType : "application/json",
				dataType : "json",
				success : function(data) {
					var resStatus = data.statusCode;
					var message = data.message;
					if("200" == resStatus){
						var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
						var width=$("#file-display").width();
						var height=$("#file-display").height();
						$("#viewerPlaceHolder").css("width",width+"px");  
						$("#viewerPlaceHolder").css("height",height+"px");  
						$("#viewerPlaceHolder").css("display","block" );  
	
						var fp = new FlexPaperViewer(
						            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
						            'viewerPlaceHolder', 
						            {config : {
						                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
						                Scale : 1.5,//初始化缩放比例(1=100%)
						                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
						                ZoomTime : 0.5,//切换缩放比例延迟显示时间
						                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
						                FitPageOnLoad : false,//初始化时自适应页面
						                FitWidthOnLoad : false,//初始化时自适应宽度
						                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
						                ProgressiveLoading : true,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
						                MinZoomSize : 0.2,//最小缩放比例
						                MaxZoomSize : 5,//最大缩放比例
						                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
						                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
						                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
						                ZoomToolsVisible : true,//工具浪是否显示缩放工具
						                NavToolsVisible : true,//工具栏是否显示导航工具
						                CursorToolsVisible : true,//工具栏是否显示光标
						                SearchToolsVisible : true,//工具栏是否显示搜索工具
						                localeChain: 'zh_CN'//地区语言(en_US:English,)
						            	}
						            });
					} else {
						alert(message,3); 
					}
				},
				error : function(data) {
					alert(data.message,3); 
				}
			});
    	} else {
    		alert("<i18n:I18n defaultValue='不支持在线预览的文档类型' key='i18n_alert_filetypenotsupport'/>!",3);
    	}
    }
    
    function loadClause(elsAccount,contractNumber) {
	    var queryParam = {
	    	elsAccount : elsAccount,
	    	contractNumber : contractNumber
	    };
	    $.extend(clauseGrid.opts.params,queryParam);
		clauseGrid.load();
	}
	
	function loadFile(elsAccount,contractNumber) {
		var queryParam = {
	    	elsAccount : elsAccount,
	    	contractNumber : contractNumber
	    };
	    $.extend(fileGrid.opts.params,queryParam);
	    fileGrid.load();
	}
	
	function loadMaterial(elsAccount,contractNumber){
		var queryParam = {
	    	elsAccount : elsAccount,
	    	contractNumber : contractNumber
	    };
		$.extend(materialGrid.opts.params,queryParam);
		materialGrid.load();
	}
	
</script>
</body>
</html>