<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String contractTypeCode = request.getParameter("contractTypeCode"); %>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="sendContract"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		<form id="form" onsubmit="return false;">
		<input type="hidden" id="elsAccount" name="elsAccount"/>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_headerinformation" defaultValue="抬头信息" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="headTable">
							<table id="headTable"></table>
							<div id="enquiryPage" style="text-align: right;display: inline-block;position: absolute;top: -49px;right: 19px;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_requirementsPlanning_table_projectInformation" defaultValue="项目信息(表单文件)" /></span>
            <div class="common-box-line">
            	<button class="button-wrap" id="addItemRowBtn"><i18n:I18n key="i18n_delivery_button_createaitem" defaultValue="新增行" /></button>
            	<button class="button-wrap" id="delItemRowBtn"><i18n:I18n key="i18n_delivery_button_removeaitem" defaultValue="删除行" /></button>
                <div class="tab-wrap" id="sheet-project">
                    <div id="sheet-project-one">
                         <main class="grid-container nest-table">
		                    <div class="grid-100" id="reCreate">
		                        <table id="itemTable"></table>
		                    </div>
		                </main>
                    </div>
                </div>
            </div>
        </div>
		</form>
	</div>
</body>
<script>
	var headTable             ;
	var itemTable             ;
	var type             = "" ;
	var roleCode         = "" ;
	var elsAccount       = "<%=session.getAttribute("elsAccount")%>"       ;
	var companyName      = "<%=session.getAttribute("companyShortName")%>" ;
	var contractTypeCode = "<%=contractTypeCode%>" ;
	var rowIndexSelect   = 0                       ;
	var excelUploader                              ;
	var rowIndexId       = ""                      ;
	var beginFormJson = [];
	var endFormJson = [];
	
	// 渲染   @author jiangzhidong 20160120  begin
	//只允许数字输入框
	var initInputNumber = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"  id="'+this.name+'_'+index+'"/>';
	};

	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = ''; }
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>' ;
	};

	//允许任何字符输入框  readonly
	var initInputAnyReadonly = function(val, item, index){
		if(!val) { val = ''; }
		return '<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>' ;
	};

	//企业名称
    var initCompanyName = function (val, item, index){
		if(!val) { val = ''; }
		var name = this.name ;
		var value = this.value ;
		return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>' ;
    }

	//日期input
	var formatDateInput = function (val, item, index){
		if(!val) { val = ''; }
		return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />' ; 
	};

	//时间input
	var formatDateTimeInput = function (val, item, index){
		if(!val) { val = ''; }
		return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />' ; 
	};

	//供应商els帐号
	var initSupplierElsAccount = function (val,item,index){
		return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>' ;
	};

	// 渲染   @author jiangzhidong 20160120  end
	 
	//初始化记载信息 
	$(document).ready(function(){
		var GobalparamStr = {"elsAccount":elsAccount,"contractTypeCode":contractTypeCode}  ;
	  	var height        = $(document).height() - 155 ;
	    
	  	headTable =  $('#headTable').mmGrid({
			cols        :  colst_head    ,
			url         : "<%=basePath%>rest/SupplierContractTypeService/querySupplierContractHeadByCondtion",
			method      : 'post'         ,
			params      :  GobalparamStr ,
			loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
			noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
			root        : 'rows'         ,
			checkCol    :  true          ,
			multiSelect :  false         
        });

		headTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
			rowIndexSelect=rowIndex;
		});
	  	 
		headTable.on('loadSuccess', function(e, data) {
			//headTable.addRow({});
			beginFormJson = $("#form").serializeJSON();
		});
	});
	 
	//退出
	$("#exitBtn").click(function(){
		
		 endFormJson = $("#form").serializeJSON();
			var begin = JSON.stringify(beginFormJson);
			var end = JSON.stringify(endFormJson); 
			if(begin==end){
				parent.elsDeskTop.closeCurWin('contractTypeManagerUpd');
			}else{
				
			parent.elsDeskTop.tip.init({
				type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>',
						closeEvent:function(){
							parent.elsDeskTop.closeCurWin('contractTypeManagerUpd');
		}});
			}
	});
	 
	 //退出窗口 
	 window.beforeClose = function(close){ 
		 endFormJson = $("#form").serializeJSON();
			var begin = JSON.stringify(beginFormJson);
			var end = JSON.stringify(endFormJson); 
			if(begin==end){
				close();
			}else{
				
			parent.elsDeskTop.tip.init({
				type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>',
						closeEvent:function(){
							close();
		}});
			}
		}
	
	//添加企业名称
	var addEnterpriseName = function(val,index){
		var selectRows = val;
		if(val.length >= 6)
			autoGetEnterpriseName(selectRows,index); 
	}
    

    var colst_head = [{ title:'<i18n:I18n key="i18n_common_title_contracttypecode" defaultValue="合同类型编码" />',      name:'contractTypeCode' ,width:100, align:'center', renderer:initInputAny,hidden:true} ,
	     	          { title:'<i18n:I18n key="i18n_common_title_contracttypename" defaultValue="合同类型名称" />',      name:'contractTypeName' ,width:150, align:'center', renderer:initInputAny} ,
	     	          { title:'<i18n:I18n key="i18n_common_title_Ordertolerancecontrol" defaultValue="订单容差控制比例%" />', name:'tolerance'        ,width:80,  align:'center', renderer:initInputNumber} ,
	     	          { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />'             , name:'remark'           ,width:100, align:'center', renderer:initInputAny}];	

	//===========================================项目信息(表单文件)===========================================
	var cols_item  = [{ title:'<i18n:I18n key="i18n_common_title_contractclausecode" defaultValue="合同条款编码" />', name:'contractClauseCode', width: 120, align: 'center',renderer:initInputAny,hidden:true},
		  	          { title:'<i18n:I18n key="i18n_common_title_contracDescName" defaultValue="合同条款名称" />', name:'contractClauseName' ,width:100, align:'center', renderer:initInputAny},
		  	          { title:'<i18n:I18n key="i18n_common_title_contracdetailcontent" defaultValue="合同条款明细内容" />', name:'detailContent', width: 130, align: 'center',renderer:initInputAny},
		  	          { title:'<i18n:I18n key="i18n_common_title_superiorClauseCode" defaultValue="上级合同条款编码" />', name:'superiorClauseCode', width: 150, align: 'center',renderer:initInputAny},
		  		      { title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark', width: 300, align: 'center',renderer:initInputAny}];


	var GobalparamStr = {"elsAccount":elsAccount,"contractTypeCode":contractTypeCode}  ;
	
  	itemTable =  $('#itemTable').mmGrid({
		cols        :  cols_item     ,
		url         : '<%=basePath%>rest/SupplierContractTypeService/querySupplierContractItemByCondtion' + "?t="+new Date().getTime(),
		method      : 'post'         ,
		params      :  GobalparamStr ,
		loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
		noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
		root        : 'rows'         ,
		checkCol    :  true          ,
		multiSelect :  true          ,
		success     : function(data) {
 			var p=data.rows;
 			for(var i = 0 ; i < p.length ; i++ ){
 				var k=p[i];
	 			var itemRow = {'elsAccount':k.elsAccount,
	 					       'toElsAccount':k.toElsAccount,
	 			        	   'contractTypeCode':k.contractTypeCode,
	 				           'contractClauseCode':k.contractClauseCode,
	 				           'contractClauseName':k.contractClauseName,
	 				           'detailContent':k.detailContent,
	 				           'superiorClauseCode':k.superiorClauseCode,
	 				           'remark':k.remark
	 				}; 
	 				itemTable.addRow(itemRow);
 				}
 			},
 			error : function(data) {
 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
 			}
    });	 	
		
	$("#delItemRowBtn").click(function(){
		var selectedItems = itemTable.selectedRowsIndex();
		itemTable.removeRow(selectedItems);
	});
			
	//生成供应商准入单号item
	$("#addItemRowBtn").click(function(){
		itemTable.addRow({});	
	});
	
	//发送合同类型  修改
	$("#sendContract").click(function(){
		$("#elsAccount").val(elsAccount)         ;
		var formObj = $("#form")                 ;
		var jsonObj = formObj.serializeJSON()    ;
		

			               
	   	var supplierContractItemList = [] ;  	  	
	 	var itemTableRows = itemTable.rows() ;
		if(itemTableRows != "" && itemTableRows != null){
			for(var i = 0 ; i < itemTableRows.length ; i ++){
				var singleRow = itemTableRows[i]                         ;
				singleRow       = inputSetValue(singleRow,i)             ;
				supplierContractItemList.push(JSON.stringify(singleRow)) ;
			}
		}
		jsonObj['supplierContractItemList'] = eval('['+supplierContractItemList+']'); 	   	
	
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认准入评估发布？" />',closeEvent:function(){
		parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_title_accessinformationrelease" defaultValue="准入评估信息发布中" />');
		 	$.ajax({
				url         : "<%=basePath%>rest/SupplierContractTypeService/updateSupplierContractByHeader" ,
				type        : "post"                  ,
			 	contentType : "application/json"      ,
				data 		: JSON.stringify(jsonObj) ,
			 	dataType    : "json"                  ,
			 	success     :  function(data) {
			 		parent.elsDeskTop.hideLoading()   ;
			 		if(data.statusCode=="-100"){
			 			alert(data.message,2)         ;
			 		}else{
			 			alert("<i18n:I18n key="i18n_common_alert_updatesuccess" defaultValue="修改成功！" />")            ;
			 			parent.elsDeskTop.closeCurWin('standardSupplyManagerAdd',callBack) ;
			 		}
			 		console.log(data.statusCode+"   "+data.message) ;
			 	},
			 	error       : function(data) {
			 		parent.elsDeskTop.hideLoading()   ;
			 		alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			 	}
		    });
		}});
	});

	function inputSetValue(materialLine,index){
	    //合同条款名称
	    var contractClauseName             = $("#contractClauseName_"+index).val();
	    materialLine["contractClauseName"] = contractClauseName;
	    //合同条款明细内容
	    var detailContent                  = $("#detailContent_"+index).val();
	    materialLine["detailContent"]      = detailContent     ;
	    //上级合同条款编码
	    var superiorClauseCode             = $("#superiorClauseCode_"+index).val();
	    materialLine["superiorClauseCode"] = superiorClauseCode  ;
	    //备注
	    var remark                         = $("#remark_"+index).val();
	    materialLine["remark"]             = remark   ;
	    return materialLine;
	}	
	
	//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
	function callBack(){
		if(parent.frames['iframeApp_standardSupplyManager']) {
			parent.frames['iframeApp_standardSupplyManager'].purchQuery();
		}
	}
</script>
</html>