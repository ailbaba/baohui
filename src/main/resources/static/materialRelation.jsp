<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation"></i18n:I18n></span>
			<div class="common-box-line">
				<button class="button-wrap" id="editBtn" ><i18n:I18n defaultValue="保存" key="i18n_button_save"></i18n:I18n></button>
				<button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create"></i18n:I18n></button>
				<button id="deleteBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_label_delete"></i18n:I18n></button>
				<button id="importExcel" class="button-wrap btnUpload"><i18n:I18n defaultValue="Excel导入" key="i18n_common_button_excelimport"></i18n:I18n></button>
				<button id="excelModel" class="button-wrap"><i18n:I18n defaultValue="Excel模板下载" key="i18n_common_button_downloadexceltemplate"></i18n:I18n></button>
			</div>
		</div>
		<form id="relationForm" onsubmit="return false;" method="POST"
			action="">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="供应关系表" key="i18n_materialRelation_title_supplyRelationTable"></i18n:I18n></span>
				<div class="common-box-line">
					<div class="tab-wrap" id="sheet-head">
						<div id="sheet-item-one">
							<main class="grid-container">
							<div class="grid-100" id="materialRelationGrid">
								<table id="materialRelationTable"></table>
								<div id="pg" style="text-align: right;"></div>
							</div>
							</main>
						</div>
					</div>
				</div>
			</div>
		</form>

	</div>
	<script>
		
	 var materialRelationGrid;
	 var LocalCompany =   "<%=session.getAttribute("companyShortName")%>";
	 var type="";
	 var roleCode="";
	 var date = new Date().format("yyyy-MM-dd");
	 var excelUploader; //上传Excel控件 
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var RelationRow = {"saleElsAccount":elsAccount,"companyShortName":LocalCompany};
	 var tota ;                //总行数 ,用于选择行数 
	 var quantityUnitData = [];              //用来存储ajax获取的计量单位 
	 var enterpriseName ;                      //用于存放自动获取的企业名称  
	<%--  <%=session.getAttribute("elsSubAccount")%> --%>
<%-- 	<%=request.getParameter("elsAccount")%> --%>
	  //获取elsid账号
	
    			
    					
    					$("#excelModel").click(function(){
    						var filePath = "template/物料关系模板.xlsx";
    						
    						window.location.href = "<%=basePath%>"  + filePath;
    					});
    				  
    				  
    					$("#addBtn").click(function(){
    						
    						//var row = $.extend({}, RelationRow);
    						var selectedIndexs = materialRelationGrid.rows().length + 1;
    						//materialRelationGrid.addRow(row);
    						materialRelationGrid.addRow(RelationRow,materialRelationGrid.rowsLength());
    						total = total + 1;  //目前行数加1
    					 });
    				  
    					$("#editBtn").click(function(){			
    						var selectedIndexs = materialRelationGrid.selectedRowsIndex();
    						if (selectedIndexs.length == 0||selectedIndexs.length=="") {
    							alert('<i18n:I18n defaultValue="请选择至少一行" key="i18n_alert_atLeast_select_oneItem"></i18n:I18n>',2);
    							return;
    						}
    						parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="是否保存选中行的修改?" key="i18n_common_cofirm_editRow"></i18n:I18n>',closeEvent:function(){
    						updatejson();
    						//转化选择行的json 
    						var rowjson = JSON.stringify(materialRelationGrid.selectedRows());
    						
    						updateForm(rowjson);
    						}});
    					});
    				  
    					$("#deleteBtn").click(function(){		
    						//删除多选的数量 
    						var selectRows = materialRelationGrid.selectedRows();
    						var selectIndex = materialRelationGrid.selectedRowsIndex;

    						var deleletRowjson = JSON.stringify(selectRows);
    						//设置删除的时候也同样需要将对应的额外字段设置为空 
    						//deleletRowjson.purchaseMaterialList = null;
    						var deleteCount =  selectRows.length;
    						var selectedIndexs = materialRelationGrid.selectedRowsIndex();
    						if (selectedIndexs.length == 0||selectedIndexs.length=="") {
    							alert('<i18n:I18n defaultValue="请选择至少一行" key="i18n_alert_atLeast_select_oneItem"></i18n:I18n>',2);
    							return;
    						}
    						parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="是否删除选中行?" key="i18n_common_cofirm_deleteRow"></i18n:I18n>',closeEvent:function(){
    							
    							//删除之前需要将有purchaseList数据的处理下 
    							deletematerialRelationList(deleletRowjson);
    							for(var i = 0;i<deleteCount;i++){
    								materialRelationGrid.removeRow(selectedIndexs[0]);
	    							materialRelationGrid.load();
    							}
    						}});
    					});
    	
		
		
	 
	  
	 //初始化加载信息 
	$(document).ready(function(){
// 		 获取计价单位		
// 		getQuantityUnit(elsAccount); 
	
		initGrid();      //初始化表格数据和事件 
		initExcelUploader();
	});

	 
	var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="materialRelation"/>;

//      var cols = [
//                 {title:'id', name:'id', width: 120, align: 'center',hidden:true},
//     	        {title:'ELS号码', name:'saleElsAccount', width: 120, align: 'center',renderer:initInput},
//     	        {title:'采购方名称', name:'companyShortName', width: 120, align: 'center',renderer:initInput},
//     	        {title:'供应商ELS号码', name:'purchaseElsAccount' ,width:120, align:'center' ,renderer:initCompanyName},
//     	        {title:'供应商名称', name:'toCompanyShortName', width: 250, align: 'center',renderer:initInput},
//                 {title:'采购方物料编号', name:'purchaseMaterial', width: 120, align: 'center',renderer:initInput},
//                 {title:'采购方物料描述', name:'purchaseMaterialDesc', width: 120, align: 'center',renderer:initInput},
//     	        {title:'销售方物料编号', name:'saleMaterial', width: 120, align: 'center',renderer:initInput},
//     	        {title:'销售方物料描述', name:'saleMaterialDesc', width: 120, align: 'center',renderer:initInput},
//                 {title:'采购方计价单位', name:'unitQuantity', width: 120, align: 'center',renderer:initInput},
//                 {title:'销售方计价单位', name:'toUnitQuantity', width: 120, align: 'center',renderer:initInput},
//                 {title:'采购方物品属性1', name:'property1', width: 120, align: 'center',renderer:initInput},
//                 {title:'采购方物品属性2', name:'property2', width: 120, align: 'center',renderer:initInput},
//                 {title:'采购方物品属性3', name:'property3', width: 120, align: 'center',renderer:initInput},
//                 {title:'采购方物品属性4', name:'property4', width: 120, align: 'center',renderer:initInput},
//                 {title:'采购方物品属性5', name:'property5', width: 120, align: 'center',renderer:initInput},
//                 {title:'销售方物品属性1', name:'toProperty1', width: 120, align: 'center',renderer:initInput},
//                 {title:'销售方物品属性2', name:'toProperty2', width: 120, align: 'center',renderer:initInput},
//                 {title:'销售方物品属性3', name:'toProperty3', width: 120, align: 'center',renderer:initInput},
//                 {title:'销售方物品属性4', name:'toProperty4', width: 120, align: 'center',renderer:initInput},
//                 {title:'销售方物品属性5', name:'toProperty5', width: 120, align: 'center',renderer:initInput},
//     	        {title:'创建用户名称', name:'createUser', width: 250, align: 'center',renderer:function(val){
//                 	if (!val) {val = "";}
//                 	return "<span>" + val +"</span>";
//                 }},
//                 {title:'创建时间', name:'createDate', width: 250, align: 'center',renderer:function(val){
//                 	if (!val) 
//     	        		return "";
//     	        	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
//                 }},
//                 {title:'最后修改用户名称', name:'lastUpdateUser', width: 250, align: 'center',renderer:function(val){
//                 	if (!val) {val = "";}
//                 	return "<span>" + val +"</span>";
//                 }},
//     	        {title:'最后修改时间', name:'lastUpdateDate' ,width:200, align:'center', renderer:function(val){
//      		    	if (!val) 
//     	        		return "";
//     	        	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
//      		    }},
//     	    ]; 
    
    
    function inputSetValue(materialLine,index){
	       //获取input 对象里面的值
	       var PurchaseElsAccount = $("#purchaseElsAccount_" + index).val();
	       materialLine["purchaseElsAccount"]=PurchaseElsAccount;
	       
	       var ToCompanyShortName = $("#toCompanyShortName_" + index).val();
	       materialLine["toCompanyShortName"]=ToCompanyShortName;
	       
	       var PurchaseMaterial = $("#purchaseMaterial_" + index).val();
	       materialLine["purchaseMaterial"]=PurchaseMaterial;
	       
	       var PurchaseMaterialDesc = $("#purchaseMaterialDesc_" + index).val();
	       materialLine["purchaseMaterialDesc"]=PurchaseMaterialDesc;
	       
	       var SaleMaterial = $("#saleMaterial_" + index).val();
	       materialLine["saleMaterial"]=SaleMaterial;
	       
	       var SaleMaterialDesc = $("#saleMaterialDesc_" + index).val();
	       materialLine["saleMaterialDesc"]=SaleMaterialDesc;
	       
	       var UnitQuantity = $("#unitQuantity_" + index).val();
	       materialLine["unitQuantity"]=UnitQuantity;
	       
	       var ToUnitQuantity = $("#toUnitQuantity_" + index).val();
	       materialLine["toUnitQuantity"]=ToUnitQuantity;
	       
	       var Property1 = $("#property1_" + index).val();
	       materialLine["property1"]=Property1;
	       
	       var Property2 = $("#property2_" + index).val();
	       materialLine["property2"]=Property2;
	       
	       var Property3 = $("#property3_" + index).val();
	       materialLine["property3"]=Property3;
	       
	       var Property4 = $("#property4_" + index).val();
	       materialLine["property4"]=Property4;
	       
	       var Property5 = $("#property5_" + index).val();
	       materialLine["property5"]=Property5;
	       
	       var ToProperty1 = $("#toProperty1_" + index).val();
	       materialLine["toProperty1"]=ToProperty1;
	       
	       var ToProperty2 = $("#toProperty2_" + index).val();
	       materialLine["toProperty2"]=ToProperty2;
	       
	       var ToProperty3 = $("#toProperty3_" + index).val();
	       materialLine["toProperty3"]=ToProperty3;
	       
	       var ToProperty4 = $("#toProperty4_" + index).val();
	       materialLine["toProperty4"]=ToProperty4;
	       
	       var ToProperty5 = $("#toProperty5_" + index).val();
	       materialLine["toProperty5"]=ToProperty5;
	       
	       //加载对应的purchaseMaterialList 不属于对象的字段,不设置为空会报错.
	       materialLine["purchaseMaterialList"] = null;
	      
	       
	       return materialLine;
	   }

    // 初始化表格及表格事件 
    		function initGrid(){
    			
    			var height=$(document).height()-155;
        		materialRelationGrid= $('#materialRelationTable').mmGrid({
        	    	 cols: cols,
        	         url: '<%=basePath%>rest/MaterialRelationService/materialRelationList/' + elsAccount,
        					method : 'post',
        					root : "rows",
        				    multiSelect: true,
        					loadingText : '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>',
        					noDataText : '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>',
        					checkCol : true,
        					plugins : [ $('#pg').mmPaginator({
        						style : 'plain',
        						totalCountName : 'total',
        						page : 1,
        						pageParamName : 'currentPage',
        						limitParamName : 'pageSize',
        						limitLabel : '<i18n:I18n defaultValue="每页{0}条" key="i18n_common_mmgrid_limitlabel"></i18n:I18n>',
        						height:height,
        						totalCountLabel : '<i18n:I18n defaultValue="共<span>{0}</span>条记录" key="i18n_common_mmgrid_totalcountlabel"></i18n:I18n>',
        						limit : null, 
        						limitList : [ 20, 30 ]
        					}) ]
        				});
        		
        		
        		materialRelationGrid.on('loadSuccess', function(e, data) {
					if(data!=null&&data!=""){					
							total = data.rows.length;
					//console.log("更新完的total " + total);
					//initEvent();     //初始化事件
					}
				});

				materialRelationGrid.on('rowInserted',function(e,item,index){
					//添加行时自动选择
					 
					//total是还未更新前的行数,index 是最后一行行数,来两者之间的差获取新增的行数
				 	for(var i = total ;i<=index;i++){
						materialRelationGrid.select(i);
					} 
						
				});
        		
    		}
    		
			
    				
    				//查询企业名称
    				function findSupplyName(elsid,id){
    					$.ajax({
    							url :"<%=basePath%>rest/AccountService/queryPurchaseEnquirySupplyByCondtion",
    							type :"POST",
    							contentType : "application/json",
    							dataType : "json",
    							data:JSON.stringify({"elsAccount":elsid}),
    							success : function(data) {
    								var option ="";
    								if(data.statusCode==-100){
    									 var error = "该els账号为空";
	    								 $ (id).val(error);
    				    			}
    								if(data!=null&&data!="" ){
    									//将根据 els账号获取企业名称 
    									enterpriseName =  data["shortName"];
    									$ (id).val(enterpriseName);
    								}else{
	
    								}
    							},
    							error: function (xhr, type, exception) {
    				            	alert(xhr.responseText, "Failed"); 
    				        	}
    						});
    				}
    				
    				
    				 				
    				
    			    //数据
    			    function initInput(val,item,index){
    			    	if(!val) { val = '';}
    			    	var name = $(this)[0].name;
    					return '<input   name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
    			    }
    			    
    			    function initSelect(val,item,index){
    			    	if(!val) { val = '';}
    			    	var name = $(this)[0].name;
    			    	if(val!=""&&val!=null){
    			    		return   '<select  class = "quantityunitSelect"  name="'+name+'" id="'+name+'_'+index+'"  value = ' + val+'>' +' <option >'+val+'</option></select>';
    			    	}else{
    						return '<select  class = "quantityunitSelect"  name="'+name+'" id="'+name+'_'+index+'"  >' +' <option  value = ""> <i18n:I18n key="i18n_materualrelation_choose_unit" defaultValue="请选择单位"/></option></select>';
    			    	}
    			    }
    			    
    			    function initInputDouble(val,item,index){
    			    	if(!val) { val = '';}
    			    	var name = $(this)[0].name;
    					return '<input onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"    name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
    			    }
    			    
    			    function initCompanyName(val,item,index){
    			    	if(!val) { val = '';}
    			    	var name = $(this)[0].name;
    			    	var value = $(this)[0].value;
    					return '<input    class = initCompany   onkeyup="addEnterpriseName(this.value,' + index+')"  name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
    			    }
    			    
			    
    			    //添加企业名称
    				function addEnterpriseName(val,index){
    					var selectRows = val;
						if(val.length>=6){
    						autoGetEnterpriseName(selectRows,index); 
						}
    				}
    			    
    			    //获取计价单位 
    			    function getQuantityUnit(elsAccount){
    			    	$.ajax({
    			    		 url: "<%=basePath%>rest/UnitOfMeasurementService/findSupplierContent/"+elsAccount,
							type :"POST",
							contentType : "application/json",
							dataType : "json",
							data:JSON.stringify({"unitName":""}),
							success : function(data) {
								var option ="";
								if(data!=null&&data!="" ){
									//将获取的数据存放在数组中 
									quantityUnitData = data;
								}
							},
							error: function (xhr, type, exception) {
				            	alert(xhr.responseText, "Failed"); 
				        	}
						});
    			    	
    			    }
    			    
    			    //初始化计量单位 
    			    function initQuantity(data,index){
						if(data!=null&&data!=""){
    			    	for(var i =0;i<data.rows.length;i++){
    			    		 unitCode = data.rows[i].unitCode;
							 unitName =data.rows[i].unitName;
								 $("#unitQuantity_" + index).append("<option  value = " +  unitName +"> " +  unitName +"</option>");
								 $("#toUnitQuantity_" + index).append("<option  value = " +  unitName +"> " +  unitName +"</option>");
    			    	}
						}
    			    
    			    }
		    
    			    
    			    function autoGetEnterpriseName(val,index){
						if(val!=null&&val!=""){
 								var elsAccount = val;
								var id ="#toCompanyShortName_" + index;
								findSupplyName(elsAccount,id);
						}

    			    }
    			    
    			    //更新所有的json数据
    			    function updatejson(){
    			    	var materialRelationRow =  materialRelationGrid.rows();
    			    	if(null!=materialRelationRow&&materialRelationRow!=""){
    			    		for(var i = 0;i<materialRelationRow.length;i++){
    			    			var singleRow = materialRelationRow[i];
    			    			singleRow = inputSetValue(singleRow,i);
    			    		}
    			    	}
    			    }
    			    
    			    
    			    //删除列数据 
    			    function deletematerialRelationList(data){
    			    	$.ajax({
    			    		 url: "<%=basePath%>rest/MaterialRelationService/materialRelationDelList/"+elsAccount,
							type :"POST",
							contentType : "application/json",
							dataType : "json",
							data:data,
							success : function(data) {
								alert("删除成功", 1); 
							},
							error: function (xhr, type, exception) {
				            	alert(xhr.responseText, "Failed"); 
				        	}
						});
    			    	
    			    }
    			    
    			    function updateForm(data){
    			    	$.ajax({
	   			    		url: "<%=basePath%>rest/MaterialRelationService/materialRelationAddList/"+elsAccount,
							type :"POST",
							contentType : "application/json",
							dataType : "json",
							data:data,
							success : function(data) {
								var option ="";
								if(data!=null&&data!="" ){
									materialRelationGrid.load();
									alert("已更新", 1); 
								}
							},
							error: function (xhr, type, exception) {
				            	alert(xhr.responseText, "Failed"); 
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
    			 			    pick: '#importExcel',
    			 			    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
    			 			    resize: false,
    			 			    formData : {
    			     		     	elsAccount : elsAccount
    			     		     }
    			 			});
    			 			
    			 			excelUploader.on( 'uploadAccept', function( obj, response ) {
    			 			   var filePath = response.url;
    			 			  	parent.elsDeskTop.showLoading('正在导入');
    			 			  	$.ajax({
    			 					url :"<%=basePath%>rest/MaterialRelationService/materialRelationExcelImport/" + elsAccount + "?filePath="  + filePath,
    			 					type :"POST",
    			 					contentType : "application/json",
    			 					dataType : "json",
    			 					data:"",
     			 					//data: filePath, 
    			 					success : function(data) {
    			 						if(data.statusCode=="-100"){
    			 							parent.elsDeskTop.hideLoading();
    			 							parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
    			 						}else{
    			 							parent.elsDeskTop.hideLoading();
    			 							// 需要先判断data 数据 然后在 转化成一个个row 再添加导入 
    			 						    //var selectedIndexs = materialRelationGrid.rows().length + 1;
    			 							var selectIndex = materialRelationGrid.rowsLength();
    			 							//console.log("当前的序号: " + selectIndex);
    			 							for(var i = 0;i<data.length;i++){
    			 								//只能添加 els账号为当前用户的数据 
    			 								var Row = data[i];
    			 								var saleElsAccount = data[i].saleElsAccount;
    			 								//避免purchaseMaterialList里面获取值导致转化成对象出错,把它设置为null
    			 								Row.purchaseMaterialList=null;
    			 								if(saleElsAccount==elsAccount){
    			 									materialRelationGrid.addRow(Row,selectIndex);
    			 									selectIndex++;
    			 									
    			 								}
    			 							}
    			 							
    			 						}
    			 					},
    			 					error: function (data) {//获取ajax的错误信息
    			 						parent.elsDeskTop.hideLoading();
    			 						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "系统错误！"});
    			 		            }
    			 				});
    			 			});
    			 		}
    			 	}
    			  //excel导入-------------end-------------------
    			    
    			    
		</script>
</body>
</html>