<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">  
				<button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
		
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_priceautochecksettingtable" defaultValue="价格自动检查设置表" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="priceCheckSetup">
							<table id="roleTable"></table>
							<div id="enquiryPage" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	 var priceCheckSetup;
	 var type="";
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	
	 //初始化记载信息 
	 $(document).ready(function(){
		initExcelUploader();
	 });
	 
	 //添加记录
	 var isFirst=true; 
	 var arr = new Array('priceType','beginTime','endTime','percentage','logtime');
	 var arr2 = new Array('elsHandle');
	 $("#addBtn").click(function(){
		 if(isFirst){
			 priceCheckSetup.removeRow();
			 isFirst = false;
		 }
		 var data = priceCheckSetup.opts.cols;
		 for(var i= 0; i<=data.length-1; i++) {
			 var row = data[i];
			 if(row.name && arr.indexOf(row.name) != -1)
				 row.renderer = initInputAny;
			 else if(row.name && arr2.indexOf(row.name) != -1)
			     row.renderer = enquiryHandle2;
		 }
		 var RelationRow = {"elsAccount":elsAccount,'logtime':'2016-02-18'};
		 priceCheckSetup.addRow(RelationRow);
		 
	 });
	  
	 //保存记录
	 $("#saveBtn").click(function(){
		
	 	var saleRows = priceCheckSetup.selectedRows();
	 	if(saleRows.length==0){
	 		alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择记录!" />',2);
	 		return;
	 	}
	 	for(var j= 0; j<=saleRows.length-1; j++) {
	 		
	 	}
	 	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_title_saveSelectRecord" defaultValue="是否确认保存选中记录?" />',closeEvent:function(){
	 		$.ajax({
	 			url: '<%=basePath%>rest/SaleRelationService/batchAddSaleRelation' + "?t="+new Date().getTime(),
	 			type: 'POST',
	 			contentType: "application/json",
	 			data: JSON.stringify(saleRows),
	 			dataType: "json",
	 			success: function(data) {
	     			alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
	     			query();
	     		},
	     		error: function(data) {
	     			alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
	     			query();
	     		}
	 		});
	 	}});
	 });
	 
	//退出
	$("#exitBtn").click(function(){
		parent.elsDeskTop.closeCurWin('priceCheckSetupManager');
	});
	 
	 
	//重新加载
	var query = function() {
	 	priceCheckSetup.load({});
	 	reset();
	};
	var reset = function() {
	 	if(!isFirst){
	 		 var data = priceCheckSetup.opts.cols;
			 for(var i= 0; i<=data.length-1; i++) {
				 var row = data[i];
				 if(row.name && arr.indexOf(row.name) != -1)
					 row.renderer = null;
				 else if(row.name && arr2.indexOf(row.name) != -1)
				     row.renderer = enquiryHandle;
			 }
	 	}
	 	isFirst=true;
	};
 
	// 渲染   @author jiangzhidong 20160120  begin
	//按钮
	var enquiryHandle = function(val, item, index){
		return '<span class="deleteBtn" style="color:blue;"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
		      +'&nbsp;&nbsp;<span class="updateBtn" name="updateBtn" style="color:blue;"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	var enquiryHandle2 = function(val, item, index){
		return '<span class="addDeleteBtn" style="color:blue;"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	var enquiryHandle3 = function(val, item, index){
		return '<span class="deleteBtn" style="color:blue;"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
		      +'&nbsp;&nbsp;<span class="saveBtn" name="saveBtn" style="color:blue;"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	//只允许数字输入框
	var initInputNumber = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//企业名称
    var initCompanyName = function (val, item, index){
    	if(!val) { val = '';}
    	var name = this.name;
    	var value = this.value;
		return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
    }
    //多选
	var multiSelect = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="checkbox" name="checkboxName" id="checkboxId"/>';
	};
   
	// 渲染   @author jiangzhidong 20160120  end
    
    //添加企业名称
	var addEnterpriseName = function(val,index){
		var selectRows = val;
		if(val.length>=6)
			autoGetEnterpriseName(selectRows,index); 
	}
	
	//查询企业名称
	var autoGetEnterpriseName = function (val,index){
		if(val!=null&&val!=""){
				var elsAccount = val;
				var id ="#toElsName_" + index;
				$.ajax({
						url :"<%=basePath%>rest/AccountService/queryPurchaseEnquirySupplyByCondtion",
						type :"POST",
						contentType : "application/json",
						dataType : "json",
						data:JSON.stringify({"elsAccount":elsAccount}),
						success : function(data) {
							var option ="";
							if(data.statusCode==-100){
								 var error = "该els账号为空";
								 $ (id).val(error);
			    			}
							if(data!=null&&data!="" ){
								enterpriseName =  data["shortName"];
								$ (id).val(enterpriseName);
							}
						},
						error: function (xhr, type, exception) {
			            	alert(xhr.responseText, "Failed"); 
			        	}
					});
		}

	}
	 
	
   var cols = [{title:'<i18n:I18n key="i18n_quotation_priceType" defaultValue="价格类型" />', name:'priceType', width: 120, align: 'center', renderer:initInputAny},
    	       {title:'<i18n:I18n key="i18n_requirementsPlanning_lable_startDate" defaultValue="开始日期" />', name:'beginTime' ,width:130, align:'center', renderer:initInputAny},
    	       {title:'<i18n:I18n key="i18n_requirementsPlanning_lable_endDate" defaultValue="结束日期" />', name:'endTime', width: 130, align: 'center', renderer:initInputAny},
    	       {title:'<i18n:I18n key="i18n_common_title_outofpercentage" defaultValue="超出百分比" />', name:'percentage', width: 90, align: 'center', renderer:initInputAny},
    	       {title:'<i18n:I18n key="i18n_label_auditDate" defaultValue="操作日期" />', name:'logtime' ,width:160, align:'center', renderer:initInputAny}];

  	var GobalparamStr={"elsAccount":elsAccount};
  	var height=$(document).height()-155;
  	priceCheckSetup= $('#roleTable').mmGrid({
  	    	 		cols: cols,
  	         		url: '<%=basePath%>rest/PriceCheckSetupService/queryPriceCheckSetupByCondtion',
  					params : GobalparamStr,
  					method : 'post',
  					root : "rows",
  					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
  			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
  					checkCol : true,
  			        multiSelect: true,
  					plugins : [ 
 					           $('#enquiryPage').mmPaginator({
 					                style: 'plain'
 					                , totalCountName: 'total'
 					                , page: 1
 					                , pageParamName: 'currentPage'
 					                , limitParamName: 'pageSize'
 					                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
 					                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
 					                , limit: null
 					                , limitList: [10, 30, 40, 50]
 					            })
				]
  				});
  				priceCheckSetup.on('loadSuccess', function(e, data) {
  					 if (data.total > 0) {
  						priceCheckSetup.select(0);
  					} 
  				});


	//删除
	$('.deleteBtn').live("click", function() {
		var scanCol = $(this).next();
        var sanContent = scanCol.text();
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除?" />',closeEvent:function(){
		$.ajax({
    		url :"<%=basePath%>rest/SaleRelationService/deleteSaleRelation",
    		type :"post",
    		contentType : "application/json",
    		data : sanContent,
    		dataType : "json",
    		success : function(data) {
    			alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
    			query();
    		},
    		error : function(data) {
    			if (!permissionError(data)) {
 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
 				}
    		}
    	}); 
		}});
		
	});
	
	//修改
	$('.updateBtn').live("click", function() {
		debugger;
		var editCol = $(this).next();
        var editContent = editCol.text();
        var ind = $(this).parents('tr').index();
        var editContentObj = JSON.parse(editContent);
        var colsData = priceCheckSetup.opts.cols;
        for (var i in colsData) {
        	if(colsData[i].name && arr.indexOf(colsData[i].name) != -1) {
        		colsData[i].renderer = initInputAny;
        	}else if (colsData[i].name && arr2.indexOf(colsData[i].name) != -1){
        		colsData[i].renderer = enquiryHandle3;
        	}
        }
        priceCheckSetup.updateRow(editContentObj,ind);
        isFirst = false;
	});
	
	//保存
	$('.saveBtn').live("click", function() {
		
		debugger;
		var editCol = $(this).next().text();
		var item = JSON.parse(editCol);
		
		var selectvalue =document.getElementsByName("saveBtn");
		if(selectvalue.length!=1){
			alert('<i18n:I18n key="i18n_common_alert_saveOneRecord" defaultValue="只能保存一条记录!" />',2);
			return;
		}
		
 		
 		
	 	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_alert_SaveRecord" defaultValue="是否确认保存记录?" />',closeEvent:function(){
	 		$.ajax({
	 			url: '<%=basePath%>rest/SaleRelationService/updateSaleRelation' + "?t="+new Date().getTime(),
	 			type: 'POST',
	 			contentType: "application/json",
	 			data: JSON.stringify(item),
	 			dataType: "json",
	 			success: function(data) {
	     			alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
	     			query();
	     		},
	     		error: function(data) {
	     			alert('<i18n:I18n key="i18n_common_alert_savesuccess" defaultValue="保存成功!" />',1);
	     			query();
	     		}
	 		});
	 	}});
		
	});

		</script>
</body>
</html>