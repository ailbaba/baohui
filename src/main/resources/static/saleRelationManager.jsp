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
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
				<button class="button-wrap" id="saveBtn"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button class="button-wrap" id="queryHeadBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
<%--				<button class="button-wrap" id="excelModelExport">Excel模板下载</button>--%>
<%--				<button id="excelImport" class="button-wrap btnUpload" style="height: 24px;line-height:24px;"><span>Excel导入</span></button>--%>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_clientName" defaultValue="客户名称" /></span>
					<input type="text" id="templateName" name="templateName" />
				</div>
			</div>
		</div>
		
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_saleRelationList" defaultValue="销售关系表" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="saleRelation">
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
	 var saleRelation;
	 var type="";
	 var roleCode="";
	 var excelUploader; //上传Excel控件 
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	
	 //初始化记载信息 
	 $(document).ready(function(){
		initExcelUploader();
	 });
	 
	 //添加记录
	 var isFirst=true; 
	 var arr = new Array('elsName','toElsName','toErpCode','toErpName','logUser','fbk1','fbk2','fbk3','fbk4','fbk5','fbk6','fbk7','fbk8','fbk9','fbk10');
	 var arr2 = new Array('elsHandle');
	 var arr3 = new Array('toElsAccount');
	 $("#addBtn").click(function(){
		 if(isFirst){
			 saleRelation.removeRow();
			 isFirst = false;
		 }
		 var data = saleRelation.opts.cols;
		 for(var i= 0; i<=data.length-1; i++) {
			 var row = data[i];
			 if(row.name && arr.indexOf(row.name) != -1)
				 row.renderer = initInputAny;
			 else if(row.name && arr2.indexOf(row.name) != -1)
			     row.renderer = enquiryHandle2;
			 else if(row.name && arr3.indexOf(row.name) != -1)
				 row.renderer = initCompanyName;
		 } 
		 var RelationRow = {"elsAccount":elsAccount,"elsName":companyName,'logtime':new Date().getTime()};
		 saleRelation.addRow(RelationRow);
		 
	 });
	  
	 //保存记录
	 $("#saveBtn").click(function(){
		if(isFirst){
			alert('<i18n:I18n key="i18n_common_title_pleaseAddRecord" defaultValue="请先添加记录!" />',2);
	 		return;
		}
	 	var saleRows = saleRelation.selectedRows();
	 	if(saleRows.length==0){
	 		alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择记录!" />',2);
	 		return;
	 	}
	 	for(var j= 0; j<=saleRows.length-1; j++) {
	 		var elsName = document.getElementsByName("elsName")[j].value;
	 		var toElsAccount = document.getElementsByName("toElsAccount")[j].value;
	 		var toElsName = document.getElementsByName("toElsName")[j].value;
	 		var toErpCode = document.getElementsByName("toErpCode")[j].value;
	 		var toErpName = document.getElementsByName("toErpName")[j].value;
	 		var logUser = document.getElementsByName("logUser")[j].value;
	 		var fbk1 = document.getElementsByName("fbk1")[j].value;
	 		var fbk2 = document.getElementsByName("fbk2")[j].value;
	 		var fbk3 = document.getElementsByName("fbk3")[j].value;
	 		var fbk4 = document.getElementsByName("fbk4")[j].value;
	 		var fbk5 = document.getElementsByName("fbk5")[j].value;
	 		var fbk6 = document.getElementsByName("fbk6")[j].value;
	 		var fbk7 = document.getElementsByName("fbk7")[j].value;
	 		var fbk8 = document.getElementsByName("fbk8")[j].value;
	 		var fbk9 = document.getElementsByName("fbk9")[j].value;
	 		var fbk10 = document.getElementsByName("fbk10")[j].value;
	 		saleRows[j].elsName = elsName;
	 		saleRows[j].toElsAccount = toElsAccount;
	 		saleRows[j].toElsName = toElsName;
	 		saleRows[j].toErpCode = toErpCode;
	 		saleRows[j].toErpName = toErpName;
	 		saleRows[j].logUser = logUser;
	 		saleRows[j].fbk1 = fbk1;
	 		saleRows[j].fbk2 = fbk2;
	 		saleRows[j].fbk3 = fbk3;
	 		saleRows[j].fbk4 = fbk4;
	 		saleRows[j].fbk5 = fbk5;
	 		saleRows[j].fbk6 = fbk6;
	 		saleRows[j].fbk7 = fbk7;
	 		saleRows[j].fbk8 = fbk8;
	 		saleRows[j].fbk9 = fbk9;
	 		saleRows[j].fbk10 = fbk10;
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
	     			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
	     		}
	 		});
	 	}});
	 });
	 
	 //查询
	 $("#queryHeadBtn").click(function(){
		 var templateName = $("#templateName").val();
		 var GobalparamStr={"elsAccount":elsAccount,"toElsName":templateName};
		 saleRelation.load(GobalparamStr);
		 reset();
	 });
	 
	 
	//重新加载
	var query = function() {
	 	saleRelation.load({});
	 	reset();
	};
	var reset = function() {
	 	if(!isFirst){
	 		 var data = saleRelation.opts.cols;
			 for(var i= 0; i<=data.length-1; i++) {
				 var row = data[i];
				 if(row.name && arr.indexOf(row.name) != -1)
					 row.renderer = null;
				 else if(row.name && arr2.indexOf(row.name) != -1)
				     row.renderer = enquiryHandle;
				 else if(row.name && arr3.indexOf(row.name) != -1)
				     row.renderer = null;
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
	 
	
   var cols = [{title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />',clickDisable:true, name:'elsHandle' ,width:90, align:'center', renderer: enquiryHandle},
    	        {title:'<i18n:I18n key="i18n_common_label_elsAccount" defaultValue="ELS帐号" />', name:'elsAccount', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_title_salerName" defaultValue="销售方名称" />', name:'elsName', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_title_clientElsAccount" defaultValue="客户ELS帐号" />', name:'toElsAccount' ,width:120, align:'center'},
    	        {title:'<i18n:I18n key="i18n_common_title_clientName" defaultValue="客户名称" />', name:'toElsName', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_enquiry_label_ErpCode" defaultValue="ERP编码" />', name:'toErpCode', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_ErpSystem" defaultValue="ERP系统" />', name:'toErpName', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_loginUserName" defaultValue="登记用户名称" />', name:'logUser', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_ErpSystem" defaultValue="ERP系统" />', name:'fbk1', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司名称" />', name:'fbk2', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_elsSubAccount" defaultValue="ELS子帐号" />', name:'fbk3', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_elsSubAccount_name" defaultValue="ELS子帐号名称" />', name:'fbk4', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_interface" defaultValue="接口方式" />', name:'fbk5', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_elsMessage_lable_enterpriseServiceAddress" defaultValue="服务器地址" />', name:'fbk6', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_port" defaultValue="端口" />', name:'fbk7', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_interface_user" defaultValue="接口访问用户名 " />', name:'fbk8', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_interface_pwd" defaultValue="接口访问密码 " />', name:'fbk9', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径" />', name:'fbk10', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />', name:'logtime' ,width:200, align:'center', renderer:function(val){
     		    	if (!val) return "";
    	        	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
     		    }}];

  	var GobalparamStr={"elsAccount":elsAccount};
  	var height=$(document).height()-155;
  	saleRelation= $('#roleTable').mmGrid({
  	    	 		cols: cols,
  	         		url: '<%=basePath%>rest/SaleRelationService/querySaleRelationByCondtion',
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
  				saleRelation.on('loadSuccess', function(e, data) {
  					 if (data.total > 0) {
  						saleRelation.select(0);
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
    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
    		}
    	}); 
		}});
		
	});
	
	//修改
	$('.updateBtn').live("click", function() {
		var editCol = $(this).next();
        var editContent = editCol.text();
        var ind = $(this).parents('tr').index();
        var editContentObj = JSON.parse(editContent);
        var colsData = saleRelation.opts.cols;
        for (var i in colsData) {
        	if(colsData[i].name && arr.indexOf(colsData[i].name) != -1) {
        		colsData[i].renderer = initInputAny;
        	}else if (colsData[i].name && arr2.indexOf(colsData[i].name) != -1){
        		colsData[i].renderer = enquiryHandle3;
        	}else if(colsData[i].name  && arr3.indexOf(colsData[i].name) != -1){
        		colsData[i].renderer = initCompanyName;
        	}
        }
        saleRelation.updateRow(editContentObj,ind);
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
		
		var elsName = document.getElementsByName("elsName")[0].value;
 		var toElsAccount = document.getElementsByName("toElsAccount")[0].value;
 		var toElsName = document.getElementsByName("toElsName")[0].value;
 		var toErpCode = document.getElementsByName("toErpCode")[0].value;
 		var toErpName = document.getElementsByName("toErpName")[0].value;
 		var fbk1 = document.getElementsByName("fbk1")[0].value;
 		var fbk2 = document.getElementsByName("fbk2")[0].value;
 		var fbk3 = document.getElementsByName("fbk3")[0].value;
 		var fbk4 = document.getElementsByName("fbk4")[0].value;
 		var fbk5 = document.getElementsByName("fbk5")[0].value;
 		var fbk6 = document.getElementsByName("fbk6")[0].value;
 		var fbk7 = document.getElementsByName("fbk7")[0].value;
 		var fbk8 = document.getElementsByName("fbk8")[0].value;
 		var fbk9 = document.getElementsByName("fbk9")[0].value;
 		var fbk10 = document.getElementsByName("fbk10")[0].value;
 		var logUser = document.getElementsByName("logUser")[0].value;
 		item.elsName = elsName;
 		item.toElsAccount = toElsAccount;
 		item.toElsName = toElsName;
 		item.toErpCode = toErpCode;
 		item.toErpName = toErpName;
 		item.fbk1 = fbk1;
 		item.fbk2 = fbk2;
 		item.fbk3 = fbk3;
 		item.fbk4 = fbk4;
 		item.fbk5 = fbk5;
 		item.fbk6 = fbk6;
 		item.fbk7 = fbk7;
 		item.fbk8 = fbk8;
 		item.fbk9 = fbk9;
 		item.fbk10 = fbk10;
 		item.logUser = logUser;
 		
 		
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
	     			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
	     		}
	 		});
	 	}});
		
	});
	


    //模板下载
    $("#excelModelExport").click(function(){
	    var filePath = "download/template/客户关系模板.xlsx";
		window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	});
	 

	
	//查询企业名称
	function findSupplyName(elsAccount){
		$.ajax({
				url :"<%=basePath%>rest/AccountService/queryPurchaseEnquirySupplyByCondtion",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount}),
				success : function(data) {
					var option ="";
					if(data!=null&&data!="" ){
						var companyShortName = data["shortName"];
							$("#companyShortName").val(companyShortName);
						
					}
				},
				error: function (xhr, type, exception) {
	            	alert(xhr.responseText, "Failed"); 
	        	}
			});
	}
	
	//通过获取json数组将数组解析一一执行插入数据库内
	function excelPush(jsonParams){
		
		$.ajax({
    		url: '<%=basePath%>rest/SupplierService/insertSupplier',
    		type :"post",
    		contentType : "application/json",
    		data : JSON.stringify(jsonParams),
    		dataType : "json",
    		success : function(data) {
				if(data.statusCode==-100){
    				alert(data.message,3);
    			}else{
    				//alert("添加成功!",1);
    			}
    		},
    		error : function(data) {
    			//alert("系统异常!",3);
    		}
    	}); 
	}
	

	
	//excel导入-------------begin-------------------
    function initExcelUploader(){
 		if(!excelUploader){
 			excelUploader = WebUploader.create({
 			    // swf文件路径
 			    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
 			    auto: true,
 			    duplicate :true,
 			    accept:{
 			    	extensions:"xls,xlsx"
 			    },
 			    // 文件接收服务端。
 			    server: '<%=basePath%>servlet/UploadServlet',
 			    // 选择文件的按钮。可选。
 			    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
 			    pick: '#excelImport',
 			    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
 			    resize: false,
 			    formData : {
     		     	elsAccount : elsAccount
     		     }
 			});
 			
 			excelUploader.on( 'uploadAccept', function( obj, response ) {
 			  	var filePath = response.url;
 			  	var fileParams = {"filePath":filePath};
 			  	var venderForm = $("#VenderForm").serializeJSON();
 			  	venderForm["fbk20"] = filePath;
 			  	// 通过封装在对象将 对方fbk20临时存储 文件路径并且上传 
 			  	
 			  	console.log(filePath);
 			  	parent.elsDeskTop.showLoading();
 			  	$.ajax({
 					url :"<%=basePath%>rest/SupplierService/importExcel"  ,
 					type :"POST",
 					contentType : "application/json",
 					dataType : "json",
 					data:JSON.stringify(venderForm),
 					//data: filePath,
 					success : function(data) {
 						//var obj = JSON.parse(data);
 						if(data.statusCode=="-100"){
 							parent.elsDeskTop.hideLoading();
 							parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
 						}else{
 							parent.elsDeskTop.hideLoading();
 							if(data != "" && data != null){
 								var jsonArray = [];      //将数据库json 数组将数据情况进行封装入json数组里面 
 								var insertStr = $("#VenderForm").serializeJSON();  //获取原来格式的json形式 
 							for(var i = 0 ; i < data.length ; i++ ){ //设置初始值
 								/* console.log(data.length);
 								console.log(data[i].companyShortName); */
 								insertStr["elsAccount"] = data[i].elsAccount;
 								insertStr["elsdfid"] = data[i].elsdfid;
 								insertStr["vender"] = data[i].vender;
 								insertStr["logtime"] = data[i].logtime;
 								insertStr["logUser"] = data[i].logUser;
 								insertStr["fbk1"] = data[i].fbk1;
 								insertStr["fbk2"] = data[i].fbk2;
 								insertStr["companyShortName"] = data[i].companyShortName;
 								console.log("insertStr" + insertStr);
 								excelPush(insertStr);
 							}
 							parent.elsDeskTop.tip.init({type: 'alert', displayType: 1, message: '<i18n:I18n key="i18n_common_alert_successfulImprot" defaultValue="导入成功!" />'});
 							saleRelation.load();
 						 }
 						}
 					},
 					error: function (data) {//获取ajax的错误信息
 						parent.elsDeskTop.hideLoading();
 						parent.elsDeskTop.tip.init({type: 'alert',displayType: 3, message: '<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误!" />'});
 		            }
 				});
 			});
 		}
 	}
  //excel导入-------------end-------------------
		
		</script>
</body>
</html>