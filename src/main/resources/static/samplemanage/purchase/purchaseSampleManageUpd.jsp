<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String purchaseSampleNumber = request.getParameter("purchaseSampleNumber"); %>
<%  String toElsAccount = request.getParameter("toElsAccount"); %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">
html, body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
}

#flashContent {
	display: none;
}

table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
				key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<button id="send" class="button-wrap">保存</button>
			<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
		</div>
	</div>
	<form id="form" onsubmit="return false;">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本数据</span>
			<div class="common-box-line">
				<div class="tab-wrap" id="add-enq-sheet">
					<ul>
						<li><a href="#edit-line-baseInfo">基本信息</a></li>
						<li class="edit-line-bail"><a href="#edit-line-bail"><i18n:I18n key="test" defaultValue="样品清单" /></a></li>
<!-- 						<li class="edit-line-content"><a href="#edit-line-content">合同条款</a></li> -->
						<li class="add-supplie-sheet"><a href="#edit-line-three"><i18n:I18n key="test" defaultValue="受邀方" /></a></li>
        				<li class="add-file-sheet"><a href="#edit-line-file"><i18n:I18n key="test" defaultValue="表单文件" /></a></li>
					</ul>
					<!-- 基本信息 -->
					<div id="edit-line-baseInfo">
					 <table>
				    	<tbody>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="采购凭证号:" /></td>
				    			<td colspan="1" align="left">
				    				<input id="purchaseSampleNumber" name="purchaseSampleNumber" type="text" style="width: 200px;" disabled="disabled" value="自动凭证号"/>
								</td>
				    		</tr>
				    		<!-- <tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="合同类型:" /></td>
				    			<td colspan="1" align="left">
									<input id="contractTypeCode" name="contractTypeCode" type="text" readonly="readonly" style="width: 300px;" placeholder="选择合同类型" class = "findTemplate"/>
									<img src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;left: 251px;top: 70px;cursor: pointer;" class="findTemplate" title="选择合同类型" />
								</td>
				    		</tr> -->
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="样品订单类型:" /></td>
				    			<td colspan="1" align="left">
									<input id="orderType" name="orderType" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="样品订单名称:" /></td>
				    			<td colspan="1" align="left">
									<input id="sampleOrderName" name="sampleOrderName" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="样品订单描述:" /></td>
				    			<td colspan="1" align="left">
									<input id="sampleOrderDesc" name="sampleOrderDesc" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="采购凭证日期:" /></td>
				    			<td colspan="1" align="left">
				    			<input type="text" class="Wdate" onfocus="WdatePicker()" id="orderDate" name="orderDate"/>
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="货币码:" /></td>
				    			<td colspan="1" align="left">
									<input id="currency" name="currency" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
				    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="付款条件代码:" /></td>
				    			<td colspan="1" align="left">
									<input id="payTermsCode" name="payTermsCode" type="text" style="width: 200px;" />
								</td>
				    		</tr>
				    		<tr>
								<td align="right">备注：</td>
								<td><textarea id="remark" name="remark" rows="5" cols="300"></textarea></td>
							</tr>
				    	</tbody>
				      </table>
					</div>
					<!-- 样品清单-->
				   <div id="edit-line-bail">
				  		<div class="box-wrap pos-relative bg-common">
						  <table>
					    	<tbody>
					    		<tr>
					    			<td colspan="1" align="right"><i18n:I18n key="test" defaultValue="所属样品:" /></td>
					    			<td colspan="1" align="left">
										<input id="sampleOrderNameBak" name="sampleOrderNameBak" type="text" readonly="readonly" style="width: 200px;" />
										<!-- <input id="" name="" type="text" readonly="readonly" style="width: 300px;" />
										<img src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;left: 375px;top: 116px;cursor: pointer;" class="equirementsplanning" title="选择需求计划" /> -->
									</td>
					    		</tr>
					    	</tbody>
					       </table>
							<div class="common-box-line">
								<button id="addMaterialItem" class="button-wrap">添加</button>
								<button id="removeMaterialItem" class="button-wrap">删除</button>
							</div>
							<main class="grid-container">
							<div class="grid-100">
								<table id="materialTable"></table>
							</div>
							</main>
						</div>
				</div>
					
					<!-- 合同条款 
					<div id="edit-line-content">
						<div class="box-wrap pos-relative bg-common">
							<div class="common-box-line">
								<button id="addItem" class="button-wrap">添加</button>
								<button id="removeItem" class="button-wrap">删除</button>
							</div>
							<main class="grid-container">
							<div class="grid-100">
								<table id="contractTable"></table>
							</div>
							</main>
						</div>
					</div>-->
					
					<!-- 受邀方 -->
 					<div class="p-zero" id="edit-line-three">
                     <div class="fixed-dialog supplie-groud" >
                     </div>
                     <main class="bg-common p-6">
                        <div class="edit-box-wrap">
                        </div>
                        <div class="grid-100" >
                              <table id="add-supplie-project"></table>
                               <div id="enquirySuppliePage" style="text-align: left;"></div>
                               </div>
                     </main>
                    </div>
					
					<!-- 表单文件 -->
					<div class="p-zero" id="edit-line-file">
				        <div class="box-wrap pos-relative bg-common">
						            <div class="common-box-line p-zero">
						                <div class="pos-relative upload-wrap">
						                    <div class="pos-absolute file-list">
												<main class="grid-container">
													<div class="grid-100" id="reCreateFile">
														<table id="add-file-project"></table>
													</div>
												</main>
						                    </div>
							                 <div class="file-scan">
					   							 <div class="file-option-zoom">
								                  <div class="dis-in-b text-left">
								                  	<button id="uploadFile" class="button-wrap">上传</button>
								                  	<button id="downloadFile" class="button-wrap">下载</button>
										            <button id="lookFile" class="button-wrap">在线查看</button>
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

		<div class="fixed-dialog">
		<div class="dialog-tip bg-common" style="width: 353px;height: 200px;margin-left: -251px;margin-top: -190px;">
			<div class="dialog-close-btn"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" />
				<span id="dialogTitle"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增表单文件" /></span>
			</div>
			<div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filename" defaultValue="输入表单文件名称" /></span>
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename" defaultValue="表单文件名称" />：</span>
							<input id="fileName" name="fileName" type="text" />
						</div>
						<div class="input-and-tip">
							<span><div id="btnFileUpload" class="btn btnUpload">
							<i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" />
							</div></span>
							<input id="filePath" name="filePath" type="hidden" />
							<input id="fileSize" name="fileSize" type="hidden" />
						</div>
						<input id="fileType" name="fileType" type="hidden" />
					</div>
					<div class="mt-20">
						<button id="btnFileOK" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
						<button id="btnFileCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
					</div>
				</div>
			</div>
		</div>
	   </div>
	</form>
	
<script type="text/javascript">
$( '#add-enq-sheet').tabs();
var editFileTable;
var rightScroll;
var leftScroll;
var itemGrid;
var uploader;
var fileUploader;
var contractGrid;
var materialGrid;
var purchaseSampleNumber = "<%= purchaseSampleNumber %>";
var toElsAccount = "<%= toElsAccount %>";
var editSupplieTable;

//渲染   @author jiangzhidong 20160120  begin
	//招标状态
	function rendererBiddingStatus(val){
	    	if(val==0){
	    		return '<i18n:I18n key="test" defaultValue="未开始" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
	    	}else if(val==1){
	    		return '<i18n:I18n key="test" defaultValue="进行中" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
	    	}else if(val==2){
	    		return '<i18n:I18n key="test" defaultValue="已定标" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
	    	}else if(val==3){
	    		return '<i18n:I18n key="test" defaultValue="已完成" />'+"<input name='purchaseBiddingRoundsList[][biddingStatus]'  style='display:none;'  type='text' value='"+val+"'/>";
	    	}
	}
	//只允许数字输入框
	var initInputNumber = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//允许任何字符输入框  readonly
	var initInputAnyReadonly = function(val, item, index){
		if(!val) { val = '';}
		return '<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//自动凭证号
	var initPurchaseSampleNumber = function(val, item, index){
		if(!val) { val = '自动凭证号';}
		return '<input readonly="readonly" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//企业名称
 var initCompanyName = function (val, item, index){
 	if(!val) { val = '';}
 	var name = this.name;
 	var value = this.value;
		return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
 }
	//日期input
	var formatDateInput = function (val, item, index){
		if(!val) { val = '';}
		return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
	};
	//时间input
	var formatDateTimeInput = function (val, item, index){
		if(!val) { val = '';}
		return '<input type="text" id="" name="'+this.name+'"  class="Wdate" onfocus=\'WdatePicker({minDate:\"%y-%M-%d HH:mm:ss\",startDate:\"%y-%M-%d\",dateFmt:\"yyyy-MM-dd HH:mm:ss\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
	};
	//转化日期格式
	var formatDate = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};
	//模板下载 input
	var initFbk1 = function(val, item, index){
		if (!val) {val = "请选择或手工录入";}
		if(val) {var arr=val.split("_"); if(arr.length>=3) val = arr[2];}
		return '<input readonly="readonly" class="fbk1" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//模板提交input
	var initTemplatePath = function(val, item, index){
		if (!val) {val = "请选择或手工录入";}
		if(val) {var arr=val.split("_"); if(arr.length>=3) val = arr[2];}
		return '<input readonly="readonly" class="templatePath" type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//审批方式 select
	var initAuditModeSelect = function(val,item,index) {
		//1-审批流 2-自动 3-人工
		var selected = '<select name="auditModeSelect" id="auditModeSelect"  style="color:blue; min-width:70px; padding:5px;">'
						+'<option value="1"><i18n:I18n key="test" defaultValue="审批流" /></option>'
						+'<option value="2"><i18n:I18n key="test" defaultValue="自动" /></option>'
						+'<option value="3"><i18n:I18n key="test" defaultValue="人工" /></option></select>'
		return selected;
	};
	
	//合同状态
	var initAuditStatus = function (val,item,index){
		//0:审批通过  1:未审批  2:审批中  3:审批拒绝
		if (val == "0") return '<i18n:I18n key="test" defaultValue="新建" />'
		else if (val == "1") return '<i18n:I18n key="test" defaultValue="进行中" />'
		else if (val == "2") return '<i18n:I18n key="test" defaultValue="合同签订" />';
		else if (val == "3") return '<i18n:I18n key="test" defaultValue="关闭" />';
	};
	//合同状态 select
	var initcontractStatusSelect = function(val,item,index) {
		if(item.auditMode==3){
			var sel=' selected="true"';
			var selected = '<select name="auditStatusSelect" id="auditStatusSelect" style="color:blue; min-width:70px;"><option value="0"';
			if(val==0) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="新建" /></option><option value="1"'
			if(val==1) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="进行中" /></option><option value="2"'
			if(val==2) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="合同签订" /></option><option value="3"'
			if(val==3) selected = selected +sel;
			selected =selected + '><i18n:I18n key="test" defaultValue="关闭" /></option></select>'
			return selected;
		}
		return initAuditStatus(val,item,index);
	};
	//总评分  人工
	var initTotalScore = function(val, item, index){
		if (!val) {val = "";}
		return '<div style="color: red;">' +val+ '</div>';
	};
	//发送状态
	var initSendStatus = function (val,item,index){
		//0:未发送 1:已发送
		return '<i18n:I18n key="test" defaultValue="未发送" />'
	};

	//供应商els帐号
	var initSupplierElsAccount = function (val,item,index){
		return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	
// 渲染   @author jiangzhidong 20160120  end

//===========================================样品信息===========================================     		
var material_item = [//{ title:'采购凭证号', name:'purchaseSampleNumber', width: 100, align: 'center',renderer:initPurchaseSampleNumber},
	  	            { title:'物料编号', name:'materialNumber', width: 100, align: 'center',renderer:initInputAny},
	  	            { title:'物料描述', name:'materialDesc', width: 100, align: 'center',renderer:initInputAny},
	  		        //{ title:'物料行编号', name:'materialLineNumber', width: 100, align: 'center',renderer:initInputAny},
	  		        { title:'属性1', name:'property1', width: 100, align: 'center',renderer:initInputAny},
	  		        { title:'属性2', name:'property2', width: 100, align: 'center',renderer:initInputAny},
	  		        { title:'属性3', name:'property3',width:100, align:'center' ,renderer:initInputAny},
	  		        { title:'属性4', name:'property4',width:100, align:'center',renderer:initInputAny},
	  		        { title:'属性5', name:'property5',width:120, align:'center' ,renderer:initInputAny},
	  		        { title:'样品订单数量', name:'quantity', width: 120, align: 'center',renderer:initInputNumber},
	  				{ title:'样品订单金额', name:'price', width: 100, align: 'center',renderer:initInputAny},
	  				{ title:'基本数量单位', name:'unitQuantity',width:100, align:'center',renderer:initInputNumber},
	  				{ title:'价格单位兼订单单位', name:'unitPrice',width:100, align:'center',renderer:initInputAny},
	  				{ title:'度量单位', name:'unitMeasure',width:100, align:'center',renderer:initInputAny},
	  				{ title:'工厂', name:'factory',width:100, align:'center',renderer:initInputAny},
	  				{ title:'采购凭证日期', name:'orderDate' ,width:100, align:'center', renderer:formatDateInput},
	  				{ title:'网格值', name:'gridValue', width: 100, align: 'center', renderer:initInputAny},
	  				{ title:'备注', name:'remark',width:150, align:'center',renderer:initInputAny}];

     		
//===========================================合同信息(表单文件)===========================================
var contract_item = [{ title:'合同条款编码', name:'contractManageClauseVOList[][contractClauseCode]', width: 200, align: 'center',renderer:initInputAny},
                { title:'合同条款简称', name:'contractManageClauseVOList[][contractClauseName]', width: 200, align: 'center',renderer:initInputAny},
 	            { title:'合同条款明细内容', name:'contractManageClauseVOList[][detailContent]' ,width:300, align:'center', renderer:initInputAny},
 	            { title:'上级合同条款编码', name:'contractManageClauseVOList[][superiorClauseCode]' ,width:300, align:'center', renderer:initInputAny},
 	            { title:'备注 ', name:'contractManageClauseVOList[][remark]', width: 200, align: 'center',renderer:initInputAny}];

	
	
var contentBlackItem={biddingProjectNumber:"",materialNumber:"",materialDesc:"",quantity:"",priceIncludingVat:"",materialSpecification:"",unitQuantity:"",deliveryDate:"",remark:"",property1:"",property2:"",property3:"",property4:"",property5:"",fbk2:""}
var editFileTable;
var file_cols = [
{ title:'文件名称', name:'fileName' , width:100, align:'center',renderer:function(val){
	return "<input name='purchaseSampleFileVOList[][fileName]' type='text'  value='"+val+"'/>";
}},

{ title:'文件路径', name:'filePath', width:100, align:'center',renderer:function(val){
	return "<input name='purchaseSampleFileVOList[][filePath]' type='text'  value='"+val+"'/>";
}},
{ title:'文件类型', name:'fileType', width:100, align:'center',renderer:function(val){
	return "<input name='purchaseSampleFileVOList[][fileType]' type='text'  value='"+val+"'/>";
}},
{ title:'文件大小', name:'fileSize', width:100, align:'center',renderer:function(val){
	return "<input name='purchaseSampleFileVOList[][fileSize]' type='text'  value='"+val+"'/>";
}},
{ title:'备注', name:'remark', width:100, align:'center',renderer:function(val){
	return "<input name='purchaseSampleFileVOList[][remark]' type='text'  value='"+val+"'/>";
}}];


$().ready(function(){
	init();
	
	//改变投标轮数
	$("#selectCount").change(function(){
		//改变行数量
		changeGride();
	});
	
	//添加合同内容项
	$("#addItem").click(function(){
		//改变行数量
		addItem();
	});
	
	//添加物料特性内容项
	$("#addMaterialItem").click(function(){
		//改变行数量
		itemGrid.addRow({});
	});
	
	//删除物料特性内容项
	$("#removeMaterialItem").click(function(){
		//删除对应选择的行 
		var seletectIndexArr=itemGrid.selectedRowsIndex();
		if(seletectIndexArr.length<=0){
			alert("请选择要删除的行!",2);
			return;
		}
		itemGrid.removeRow(seletectIndexArr);
	});
	
	//删除合同内容项
	$("#removeItem").click(function(){
		removeItem();
	});
	
	//显示上传弹框
	$("#uploadFile").click(function(){
		 initFileUploader(fileUploader);
		 $('.fixed-dialog').show();
	});
	
	//关闭上传弹框
	$("#btnFileCancel ,.dialog-close-btn").click(function(){
		 $('.fixed-dialog').hide();
	});
	
	//显示上传弹框
	$("#btnFileOK").click(function(){
		addFileItem();
	});
	
	//发送
	$("#send").click(function(){
		sendSample();
	});
	
});

//退出
$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('purchaseSampleManageUpd');
	});

//初始化
function init(){
	debugger;
	var materialParams = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseSampleNumber":purchaseSampleNumber};
	materialTable = $('#materialTable').mmGrid({
        cols: material_item,
        url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/queryPurchaseSampleItem",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol:true,
        params:materialParams,
    	method : 'post',
		root : "rows",
    });
	
	initFriend();
	iniSampleHeadInfo();
	
}

//初始化样品表头信息
function iniSampleHeadInfo(){
	var headerparams = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseSampleNumber":purchaseSampleNumber};
	$.ajax({
		    url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/queryPurchaseSampleHead",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(headerparams),
			success : function(data) {
				debugger;
				$("#purchaseSampleNumber").val(data.rows[0].purchaseSampleNumber);
				$("#orderType").val(data.rows[0].orderType);
				$("#sampleOrderName").val(data.rows[0].sampleOrderName);
				$("#sampleOrderNameBak").val(data.rows[0].sampleOrderName);
				$("#sampleOrderDesc").val(data.rows[0].sampleOrderDesc);
				var orderDate = data.rows[0].orderDate;
				orderDate = formatDate(orderDate);
				$("#orderDate").val(orderDate);
				$("#currency").val(data.rows[0].currency);
				$("#payTermsCode").val(data.rows[0].payTermsCode);
				$("#remark").val(data.rows[0].remark);
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
             	alert(xhr.responseText, "Failed"); 
    		}
		});
}

/*单击物料清单tag页时触发
$('.edit-line-bail').click(function() {
	var sampleOrderName = $("#sampleOrderName").val();
	$("#sampleOrderNameBak").val(sampleOrderName);
	if(!materialGrid) {
		itemGrid = $('#materialTable').mmGrid({
	        cols: material_item,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	    });
	}
});*/

/*单击合同条款tag页时触发
$('.edit-line-content').click(function() {
	if(!contractGrid) {
		contractGrid=$('#contractTable').mmGrid({
	        cols: contract_item,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        checkCol:true,
	    });
	}
	
});*/

//单击文件tag页时触发
$('.add-file-sheet').click(function() {
	
	var fileGrid = $("#add-file-project").mmGrid({
	    url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/queryPurchaseSampleFile",
	    method : "post",
	    autoLoad : false,
	    cols : file_cols,
	    root : "rows",
	    loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    fullWidthRows :true,
	    indexCol : false,
	    plugins : [
	        $("#filePage").mmPaginator({
	            style: "plain",
	            totalCountName: "total",
	            page: 1,
	            pageParamName: "currentPage",
	            limitParamName: "pageSize",
	            limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	            totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	            limit: null,
	            limitList: [10, 30, 40, 50]
	        })
	    ]
	});
	
});

//初始化文件上传控件
function initFileUploader(fileUploader){
   if(!fileUploader){
    //新增表单文件
  	fileUploader = WebUploader.create({
  	    // swf文件路径
  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
  	  	duplicate :true,
  	    auto: true,
  	    // 文件接收服务端。
  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
  	    // 选择文件的按钮。可选。
  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
  	    pick: '#btnFileUpload',
  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
  	    resize: false
  	 });
  	fileUploader.on( 'uploadAccept', function( obj, response ) {
  	  	if(0 == response.error){
  	   	   var filePath = response.url;
  	   		$("#filePath").val(filePath);
  	   	    $("#fileName").val(response.name);
  	   	    $("#fileSize").val(response.size);
  	  	}else{
  	  		alert(response.message,2);
  	  	}
  	});
  }
}

//在文件列表添加新添加的文件列
function addFileItem(){
	var filePath=$("#filePath").val();
	var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
	var fileName=$("#fileName").val();
	var fileSize = $("#fileSize").val();
	var fileBlackItem={fileName:fileName,fileType:fileType,filePath:filePath,fileSize:fileSize,remark:""};
	editFileTable.addRow(fileBlackItem);
	$('.fixed-dialog').hide();
}

//改变行数量
function changeGride(){
	var count=$("#selectCount").find("option:selected").val();
	var arr=new Array();
	for(var i=0;i<count;i++){
		var ind=parseInt(i)+parseInt(1);
		arr[i]={roundsNumber:ind,biddingBeginDate:"",biddingEndDate:"",biddingStatus:"0"};
	}
	itemGrid.removeRow();
	itemGrid.addRows(arr);
}

//初始化联系人弹窗,将联系人的列表传人
function initContact(list, dir, had) {
	if(list && list.length) {
		var oldArr = list;
		$('body').data('cacheOldArr',oldArr);
    	var txt ="";
    	if(dir == 'left') {
    		$('.box-left').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">left</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-left').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-left').find('.contact-people').eq(ind).hide();
    			}
    		}
    		leftScroll.resize();
    		
    	} 
    	else if(dir == 'right') {
    		$('.box-right').html('');
    		for(var i =0;i<oldArr.length;i++) {
        		txt +='<p class="contact-people" style="display:none;margin:0;padding-top:6px;padding-left:10px;padding-bottom: 6px;cursor: pointer;"><span class="storeData-from">right</span><span class="people-index">'+oldArr[i].fromIndex+'</span><span class="storeData">'+ JSON.stringify(oldArr[i])+'</span><span class="friend-name">'+oldArr[i].friendElsAccount+"_"+oldArr[i].friendCompanyName+'</span></p>';
        	}
    		$('.box-right').append(txt);
    		if(had && had.length) {
    			for(var j=0;j<had.length;j++) {
    				var ind = parseInt(had[j].toFromIndex);
    				$('.box-right').find('.contact-people').eq(ind).show();
    			}
    		}
    		rightScroll.resize();
    	}
	}
};

//显示文件列表
function showFileList(){
	var fileParam = { 'elsAccount':elsAccount, 'elsSubAccount':elsSubAccount};
	editFileTable=$('#add-file-project').mmGrid({
	    cols: file_cols,
	    url: '<%=basePath%>rest/PurchaseEnquiryBargainService/queryReceiveEnquiryFileByCondtion',
	    params: fileParam,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	    fullWidthRows:true,
	    indexCol: false,
	    plugins: [
              $('#enquiryFilePage').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                  , limit: null
                  , limitList: [5,10,15,20]
              })
          ]
	});
}

//添加供应商信息
function initFriend(){
		$.ajax({
 			url :"<%=basePath%>rest/FriendsService/findMyFriendsByType",
 			type :"POST",
 			contentType : "application/json",
 			dataType : "json",
 			data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
 			success : function(data) {
 				var rows = data.rows;
 				for(var i = 0 ; i < rows.length ; i ++){
 					rows[i]["fromIndex"]=i;
 				}
 				//首次进入初始化
 				initContact(rows,'left');
 				initContact(rows,'right');
 			},
 			error: function (xhr, type, exception) {//获取ajax的错误信息
                 alert(xhr.responseText, "Failed"); 
        }
 		});
    rightScroll=(rightScroll||$('.box-right').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
    leftScroll=(leftScroll||$('.box-left').niceScroll({cursorcolor : "#ddd",cursorwidth : '2px'})).resize();
}
;
//存储临时的选择数据
var cacheData = {};
$('.contact-people').live('mouseover',function() {
	$('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact');
});
$('.contact-people').live('click',function() {
    /* $('.contacts-box').find('p').removeClass('add-contact');
    $(this).addClass('add-contact'); */
    //cacheData.text = JSON.parse($(this).find('.storeData').text());
    cacheData.index = parseInt($(this).find('.people-index').text());
    cacheData.dir = $(this).find('.storeData-from').text();
    $('body').data('cachePeople',cacheData);
    var oldObj = $('body').data('cachePeople');
    if(oldObj && oldObj.dir=='left') {
    	$('.box-left').find('.contact-people').eq(oldObj.index).hide();
    	$('.box-right').find('.contact-people').eq(oldObj.index).show();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	rightScroll.resize();
   } else if(oldObj && oldObj.dir=='right') {
       	$('.box-left').find('.contact-people').eq(oldObj.index).show();
    	$('.box-right').find('.contact-people').eq(oldObj.index).hide();
    	//$('.contacts-box').find('p').removeClass('add-contact');
    	//清空临时存储的数据
//     	$('body').data('cachePeople','');
//     	leftScroll.resize();
	}
});

$('.contact-search').keyup(function() {
	var val = $(this).val();
	var all = $('.box-left').find('p').hide();
	if(!val){
		all.show();
	} else {
		all.filter(function(index,html) {
    		var oldText=$(html).find('.friend-name').text();
    		return oldText.indexOf(val) != -1;
    	}).show();
	}
});
//选择左边全部
$('.all-pre').click(function() {
	var left =$('.box-left').find('.contact-people');
	var right =$('.box-right').find('.contact-people');
	left.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.people-index').text();
            right.eq(showInd).show();
        }
	});
	$('.box-left').find('.contact-people').hide();
	//清空临时存储的数据
	$('body').data('cachePeople','right');
	rightScroll.resize();
});
//选择右边全部
$('.all-back').click(function() {
	var left =$('.box-left').find('.contact-people');
	var right =$('.box-right').find('.contact-people');
	right.each(function() {
		if($(this).css("display")=="block"){
            var showInd = $(this).find('.people-index').text();
            left.eq(showInd).show();
        }
	});
	$('.box-right').find('.contact-people').hide();
	//清空临时存储的数据
	$('body').data('cachePeople','left');
	leftScroll.resize();
});
	
function addItem(){
	//contractGrid.addRows([contentBlackItem]);
	contractGrid.addRow({});
}

function removeItem(){
	var seletectIndexArr=contractGrid.selectedRowsIndex();
	if(seletectIndexArr.length<=0){
		alert("请选择要删除的行!",2);
		return;
	}
// 	for(var i=0;i<seletectIndexArr.length;i++){
// 		console.log(seletectIndexArr[i])
		contractGrid.removeRow(seletectIndexArr);
// 	}
}

//发送样品
function sendSample(){
 	var toElsAccounts="";
 	var toElsDescs ="";
	debugger;
 	$('.box-right').find(".contact-people").each(function(index ,val){
 		if(jQuery(this).css("display")!="none"){ 
 			var textObj = JSON.parse($(this).find('.storeData').text());
 			toElsAccounts+=","+textObj.friendElsAccount;
 			toElsDescs+=","+textObj.friendCompanyName;
 		}
 	});
     /*if(toElsAccounts.length>=10
    		 || toElsAccounts.length<=2) {
     	alert("请选择一个受邀方!",2);
     	return ;
     }*/

	 if($("#sampleOrderName").val()==''){
		 alert("样品订单名称不能为空!",2);
		 return;
	 }
    
    var formObj = $("#form").serializeJSON();
    var materialListJson = [];
    var contractClauseJson = [];
    formObj["elsAccount"]=elsAccount;
    formObj["toElsAccount"] = toElsAccounts.replace(",","");
    formObj["toCompanyShortName"] = toElsDescs.replace(",","");

    parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_enquiry_alert_confirmpublish" defaultValue="是否确认保存？" />',closeEvent:function(){
    parent.elsDeskTop.showLoading('样品信息保存中');
	$.ajax({
		url : "<%=basePath%>rest/PurchaseSampleService/sendSampleUpd",
		type : "post",
		contentType : "application/json",
 		data : JSON.stringify(formObj),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.statusCode=="-100"){
				alert(data.message,2);
			}else{
				alert("保存成功!");
				parent.elsDeskTop.closeCurWin('purchaseSampleManageUpd',callBack);
			}
			console.log(data.statusCode+"   "+data.message);
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		}
	});
	
    }});
}

//回掉函数  ——调用上一个页面的方法，触发查询按钮 刷新列表
function callBack(){
	if(parent.frames['iframeApp_purchaseSampleManage']) {
		parent.frames['iframeApp_purchaseSampleManage'].purchQuery();
	}

}

//文件下载
$("#downloadFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
	    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
	
 });
 
//在线预览
$("#lookFile").click(function(){
	var selectRows = editFileTable.selectedRows();
	if(selectRows.length > 0){
		selectRow = selectRows[0];
		var filePath = selectRow.filePath;
		previewFile(filePath);
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
	}
});

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
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : message});
				}
			},
			error : function(data) {
				parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
			}
		});
	} else {
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "不支持在线预览的文档类型!"});
	}
}
//根据所属项目编号，自动带出项目名称
$('#biddingProjectNumber').live('blur',function() {
    var biddingProjectNumber = $("#biddingProjectNumber").val();
    if(biddingProjectNumber){
    	//头信息
    	$.ajax({
			url :"<%=basePath%>rest/ProjectManageService/queryProjectManageHead",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"elsAccount":elsAccount,"projectNumber":biddingProjectNumber}),
			success : function(data) {
				if(data.statusCode == null){
					if(data.rows != null && data.rows != ""){
						$("#biddingProjectName").val(data.rows[0].projectDesc);
					}else{
						$("#biddingProjectName").val("");
					}
				}else{
					$("#biddingProjectName").val("");
				}
			}
		});
    	//行信息
    	$.ajax({
			url :"<%=basePath%>rest/ProjectManageService/queryProjectManageItem",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify({"elsAccount":elsAccount,"projectNumber":biddingProjectNumber}),
			success : function(data) {
				if(data.statusCode == null){
					if(data.rows != null && data.rows != ""){
						contractGrid.load();
						for(var i = 0 ; i < data.rows.length ; i++ ){
							var row = data.rows[i];
							var contentBlackItem={biddingProjectNumber:row.projectItemNumber,materialNumber:"",materialDesc:row.projectItemDesc,quantity:"",priceIncludingVat:"",materialSpecification:"",unitQuantity:"",deliveryDate:"",remark:"",property1:"",property2:"",property3:"",property4:"",property5:"",fbk2:""};
							contractGrid.addRows([contentBlackItem]);
						}
					}else{
						//contractGrid.load();
					}
				}else{
					contractGrid.load();
				}
			}
		});
    }else{
    	//contractGrid.load();
    	$("#biddingProjectName").val("");
    }
});


//=================================================合同查找======================================================测试
$('.findTemplate').live("click", function(event) {
    //兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'contractTypeManagerFind',
        'windowTitle':'选择合同类型',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>contractmanage/purchase/contractTypeManagerFind.jsp?frameAppId=contractManagerAdd',
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 960,
        'windowMinHeight': 500,
        'windowPositionTop':24,
        'windowWidth':960,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
});

//回调
function selectContractTypeCallbackFunc(rows){
	debugger;
	$("#contractTypeCode").val(rows.contractTypeCode);
	$("#contractDesc").val(rows.contractTypeName);
	
	var supplierContractItemList = rows.supplierContractItemList;
	for(var i = 0 ; i < supplierContractItemList.length ; i++ ){
		var row = supplierContractItemList[i];
		var contentBlackItem={'contractManageClauseVOList[][contractClauseCode]':row.contractClauseCode, 'contractManageClauseVOList[][contractClauseName]':row.contractClauseName, 'contractManageClauseVOList[][detailContent]':row.detailContent, 'contractManageClauseVOList[][superiorClauseCode]':"", 'contractManageClauseVOList[][remark]':row.remark};
		contractGrid.addRows([contentBlackItem]);
	}
}


//加载供应商列表-------------------begin---------------------
var colsSupplie = [
               { title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="供应商ELS账号"/>', name:'toElsAccount' , width:150, align:'center'},
               { title:'<i18n:I18n key="i18n_common_title_suppliername" defaultValue="供应商名称"/>', name:'toCompanyShortName' , width:130, align:'center'}
           ];

$(".add-supplie-sheet").click(function() {
	 if(!editSupplieTable){
		 editSupplieTable=$('#add-supplie-project').mmGrid({
            cols: colsSupplie,
            url : "${pageContext.request.contextPath}/rest/PurchaseSampleService/queryPurchaseSampleHead",
            params:{"elsAccount":elsAccount,"toElsAccount":toElsAccount,"purchaseSampleNumber":purchaseSampleNumber},
            width:400,
            method: 'post',
            root: 'rows',
            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
            fullWidthRows:true,
            plugins: [
                      $('#enquirySuppliePage').mmPaginator({
                          style: 'plain'
                          , totalCountName: 'total'
                          , page: 1
                          , pageParamName: 'currentPage'
                          , limitParamName: 'pageSize'
                          , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                          , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                          , limit: null
                          , limitList: [10, 30, 40, 50]
                      })
                  ]
          });
	 }
});
//加载供应商列表-------------------end---------------------
</script>
</body>
</html>