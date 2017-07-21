<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation"></i18n:I18n></span>
			<div class="common-box-line">
			<button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create"></i18n:I18n></button>
			<button id="saveBtn" class="button-wrap" ><i18n:I18n defaultValue="保存" key="i18n_button_save"></i18n:I18n></button>
			<button id="importBtn" class="button-wrap"><i18n:I18n defaultValue="导入" key="i18n_common_button_import"></i18n:I18n></button>
			<button class="button-wrap" id="exitBtn"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
	</div>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common">
			<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
		</span>
		<div class="common-box-line">
			<div class="dis-in-b input-and-tip">
				<span><i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" /></span>
				<input type="text" id="templateName"/>
				<button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			</div>
		</div>
	</div>
	<div class="pos-relative public-wrap">
		<form id="relationForm" onsubmit="return false;" method="POST"  action="">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
				<div class="common-box-line">
					<div class="tab-wrap" id="sheet-head">
						<div id="sheet-item-one">
							<main class="grid-container">
							<div class="grid-100" id="templateGrid">
								<table id="templateTable"></table>
								<div id="pg" style="text-align: right;"></div>
							</div>
							</main>
						</div>
					</div>
				</div>
			</div>
		</form>

	</div>
	</div>
	<script>
		
	 var templateGrid;
	 var date = new Date().format("yyyy-MM-dd");
	 var excelUploader; //上传Excel控件 
	 var total = 0 ;
	 var templateRow = {};
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var frameAppId ="<%=request.getParameter("frameAppId") %>";//模板导入   @author jiangzhidong @date 20160129
	 var isFirst=true; 
	 var GobalparamStr = {"elsAccount" : elsAccount};
	 var arr = new Array('templateCode','templateName','keyValue1','keyValue2','keyValue3',
	 					 'keyValue4','keyValue5','keyValue6','keyValue7','keyValue8',
	 					 'keyValue9','keyValue10','keyValue11','keyValue12','keyValue13',
	 					 'keyValue14','keyValue15','keyValue16','keyValue17','keyValue18',
	 					 'keyValue19','keyValue20');
	 var arr2 = new Array('elsHandle');
    					
    					$("#excelModel").click(function(){
    						var filePath = "template/企业开户行导入模板.xlsx";
    						window.location.href = "<%=basePath%>"  + filePath;
    					});
    					
							$("#addBtn").click(function(){
								 if(isFirst){
									 templateGrid.removeRow();
									 isFirst = false;
								 }
								 var data = templateGrid.opts.cols;
								 for(var i= 0; i<=data.length-1; i++) {
									 var row = data[i];
									 if(row.name && arr.indexOf(row.name) != -1)
										 row.renderer = initInputAny;
									 else if(row.name && arr2.indexOf(row.name) != -1)
									     row.renderer = enquiryHandle2;
								 }
								 var templateRow = {"elsAccount":elsAccount};
								 templateGrid.addRow(templateRow);
    					 });
							
							$("#queryBtn").click(function(){
								var templateName = $("#templateName").val();
								templateGrid.load({"elsAccount":elsAccount,"templateName":templateName});
								reset();
   					 		});
    					
    					$("#saveBtn").click(function(){			
    						var selectedIndexs = templateGrid.selectedRowsIndex();
    						if (selectedIndexs.length == 0||selectedIndexs.length=="") {
    							alert('<i18n:I18n defaultValue="请选择至少一行" key="i18n_alert_atLeast_select_oneItem"></i18n:I18n>',2);
    							return;
    						}
    						parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_alert_SaveRecord" defaultValue="是否确认保存记录?" />',closeEvent:function(){
    						updatejson();
    						//转化选择行的json 
    						var rowjson = JSON.stringify(templateGrid.selectedRows());
    						updateForm(rowjson);
    						reset();
    						}});
    					});
    				  	

	  
	 //初始化加载信息 
	$(document).ready(function(){
		initGrid();      //初始化表格数据和事件 
		initExcelUploader();
	});

	 
	 
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
     var cols = [
	     {title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />',clickDisable:true, name:'elsHandle' ,width:90, align:'center', renderer: enquiryHandle},
	     {title:'<i18n:I18n key="ti18n_label_elsAccount" defaultValue="ELS号码" />', name:'elsAccount', width: 100, align: 'center'},
	     {title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />', name:'templateCode', width: 120, align: 'center'},
// 	     {title:'模板名称', name:'templateName' ,width:200, align:'center'},
	     {title:'<i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />', name:'keyValue1', width: 250, align: 'center'},
	     {title:'<i18n:I18n key="i18n_common_title_downloadtemplate" defaultValue="模板下载" />', name:'keyValue2', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="i18n_common_title_templatecommit" defaultValue="模板提交" />', name:'keyValue3', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="i18n_common_title_templatedesc" defaultValue="模板描述" />', name:'keyValue4', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue5" />', name:'keyValue5', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue6" />', name:'keyValue6', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue7" />', name:'keyValue7', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue8" />', name:'keyValue8', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue9" />', name:'keyValue9', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue10" />', name:'keyValue10', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue11"/>', name:'keyValue11', width: 250, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue12" />', name:'keyValue12', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue13" />', name:'keyValue13', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue14" />', name:'keyValue14', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue15" />', name:'keyValue15', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue16" />', name:'keyValue16', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue17" />', name:'keyValue17', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue18" />', name:'keyValue18', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue19" />', name:'keyValue19', width: 200, align: 'center'},
	     {title:'<i18n:I18n key="test" defaultValue="keyValue20" />', name:'keyValue20', width: 200, align: 'center'},
 ]; 
    

    // 初始化表格及表格事件 
    		function initGrid(){
    			
    			var height=$(document).height()-155;
        		templateGrid= $('#templateTable').mmGrid({
        	    	 cols: cols,
        	         url: '<%=basePath%>rest/SupplierStandardService/getModelList' ,
        	     			params: GobalparamStr,
        					method : 'post',
        					root : "rows",
        					loadingText : '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>',
        					noDataText : '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>',
        					checkCol : true,
        					multiSelect: true,
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
        		
        		
        		templateGrid.on('loadSuccess', function(e, data) {
					if(data!=null&&data!=""){					
					}
				});

				templateGrid.on('rowInserted',function(e,item,index){
					//添加行时自动选择
					//total是还未更新前的行数,index 是最后一行行数,来两者之间的差获取新增的行数
				 	for(var i = total ;i<=index;i++){
						templateGrid.select(i);
					} 
						
				});
        		
    		}
    								 			
    
    		 function inputSetValue(materialLine,index){
    		       //获取input 对象里面的值
    		       //var elsAccount = $("#elsAccount_" + index).val();
    		       materialLine["elsAccount"]=elsAccount;
    		       
    		       var templateCode = $("#templateCode_" + index).val();
    		       materialLine["templateCode"]=templateCode;
    		       
    		       var templateName = $("#templateName_" + index).val();
    		       materialLine["templateName"]=templateName;
    		       
    		       var keyValue1 = $("#keyValue1_" + index).val();
    		       materialLine["keyValue1"]=keyValue1;
    		     
    		       var keyValue2 = $("#keyValue2_" + index).val();
    		       materialLine["keyValue2"]=keyValue2;
    		       
    		       var keyValue3 = $("#keyValue3_" + index).val();
    		       materialLine["keyValue4"]=keyValue3;
    		       
    		       var keyValue4 = $("#keyValue4_" + index).val();
    		       materialLine["keyValue4"]=keyValue4;
    		     
    		       var keyValue5 = $("#keyValue5_" + index).val();
    		       materialLine["keyValue5"]=keyValue5;
    		       
    		       var keyValue6 = $("#keyValue6_" + index).val();
    		       materialLine["keyValue6"]=keyValue6;
    		     
    		       var keyValue7 = $("#keyValue7_" + index).val();
    		       materialLine["keyValue7"]=keyValue7;
    		       
    		       var keyValue8 = $("#keyValue8_" + index).val();
    		       materialLine["keyValue8"]=keyValue8;
    		     
    		       var keyValue9 = $("#keyValue9_" + index).val();
    		       materialLine["keyValue9"]=keyValue9;
    		       
    		       var keyValue10 = $("#keyValue10_" + index).val();
    		       materialLine["keyValue10"]=keyValue10;
    		       
    		       var keyValue11 = $("#keyValue11_" + index).val();
    		       materialLine["keyValue11"]=keyValue11;
    		     
    		       var keyValue12 = $("#keyValue12_" + index).val();
    		       materialLine["keyValue12"]=keyValue12;
    		       
    		       var keyValue13 = $("#keyValue13_" + index).val();
    		       materialLine["keyValue13"]=keyValue13;
    		     
    		       var keyValue14 = $("#keyValue14_" + index).val();
    		       materialLine["keyValue14"]=keyValue14;
    		       
    		       var keyValue15 = $("#keyValue15_" + index).val();
    		       materialLine["keyValue15"]=keyValue15;
    		     
    		       var keyValue16 = $("#keyValue16_" + index).val();
    		       materialLine["keyValue16"]=keyValue16;
    		       
    		       var keyValue17 = $("#keyValue17_" + index).val();
    		       materialLine["keyValue17"]=keyValue17;
    		     
    		       var keyValue18 = $("#keyValue18_" + index).val();
    		       materialLine["keyValue18"]=keyValue18;
    		       
    		       var keyValue19 = $("#keyValue19_" + index).val();
    		       materialLine["keyValue1"]=keyValue1;
    		     
    		       var keyValue20 = $("#keyValue20_" + index).val();
    		       materialLine["keyValue20"]=keyValue20;
    		      
    		       
    		       return materialLine;
    		   }
    		
    	    //数据
		    function initInput(val,item,index){
		    	if(!val) { val = '';}
		    	var name = $(this)[0].name;
				return '<input   name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
		    }
    	    
		    //更新所有的json数据
		    function updatejson(){
		    	var materialRelationRow =  templateGrid.rows();
		    	if(null!=materialRelationRow&&materialRelationRow!=""){
		    		for(var i = 0;i<materialRelationRow.length;i++){
		    			var singleRow = materialRelationRow[i];
		    			singleRow = inputSetValue(singleRow,i);
		    		}
		    	}
		    }
		    
		    function updateForm(data){
		    	$.ajax({
			    		url: "<%=basePath%>rest/SupplierStandardService/batchInsertModel/",
					type :"POST",
					contentType : "application/json",
					dataType : "json",
					data:data,
					success : function(data) {
						var option ="";
						if(data!=null&&data!=""){
							alert("<i18n:I18n key="i18n_js_moded" defaultValue="已修改" />",1);
						}
						templateGrid.load(GobalparamStr);
					},
					error: function (xhr, type, exception) {
		            	alert(xhr.responseText, "Failed"); 
		        	}
				});
		    }
		    
		    function insertModel(data){
		    	$.ajax({
			    		url: "<%=basePath%>rest/SupplierStandardService/insertModel/",
					type :"POST",
					contentType : "application/json",
					dataType : "json",
					data:data,
					success : function(data) {
						var option ="";
						if(data=="Success"){
							alert("<i18n:I18n key="i18n_common_title_alreadyadd" defaultValue="已添加" />", 1); 
						}
					},
					error: function (xhr, type, exception) {
		            	alert(xhr.responseText, "Failed"); 
		        	}
				});
		    }
		    
		    
		    var query = function() {
		    	templateGrid.load(GobalparamStr);
			 	reset();
			};
			var reset = function() {
			 	if(!isFirst){
			 		 var data = templateGrid.opts.cols;
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
		    
			//删除
			$('.deleteBtn').live("click", function() {
				var scanCol = $(this).next();
		        var sanContent = scanCol.text();
				parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除?" />',closeEvent:function(){
				$.ajax({
		    		url :"<%=basePath%>rest/SupplierStandardService/deleteModel",
		    		type :"post",
		    		contentType : "application/json",
		    		data : sanContent,
		    		dataType : "json",
		    		success : function(data) {
		    			alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
		    			templateGrid.load(GobalparamStr);
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
				var editCol = $(this).next();
		        var editContent = editCol.text();
		        var ind = $(this).parents('tr').index();
		        var editContentObj = JSON.parse(editContent);
		        var colsData = templateGrid.opts.cols;
		        for (var i in colsData) {
		        	if(colsData[i].name && arr.indexOf(colsData[i].name) != -1) {
		        		colsData[i].renderer = initInputAny;
		        	}else if (colsData[i].name && arr2.indexOf(colsData[i].name) != -1){
		        		colsData[i].renderer = enquiryHandle3;
		        	}
		        }
		        templateGrid.updateRow(editContentObj,ind);
		        isFirst = false;
			});
			
			//保存
			$('.saveBtn').live("click", function() {
				
				var editCol = $(this).next().text();
				var item = JSON.parse(editCol);
				
				var selectvalue =document.getElementsByName("saveBtn");
				if(selectvalue.length!=1){
					alert('<i18n:I18n key="i18n_common_alert_saveOneRecord" defaultValue="只能保存一条记录!" />',2);
					return;
				}
				
				var templateCode = document.getElementsByName("templateCode")[0].value;
				var templateName = document.getElementsByName("templateName")[0].value;
				var keyValue1 = document.getElementsByName("keyValue1")[0].value;
				var keyValue2 = document.getElementsByName("keyValue2")[0].value;
				var keyValue3 = document.getElementsByName("keyValue3")[0].value;
				var keyValue4 = document.getElementsByName("keyValue4")[0].value;
				var keyValue5 = document.getElementsByName("keyValue5")[0].value;
				var keyValue6 = document.getElementsByName("keyValue6")[0].value;
				var keyValue7 = document.getElementsByName("keyValue7")[0].value;
				var keyValue8 = document.getElementsByName("keyValue8")[0].value;
				var keyValue9 = document.getElementsByName("keyValue9")[0].value;
				var keyValue10 = document.getElementsByName("keyValue10")[0].value;
				var keyValue11 = document.getElementsByName("keyValue11")[0].value;
				var keyValue12 = document.getElementsByName("keyValue12")[0].value;
				var keyValue13 = document.getElementsByName("keyValue13")[0].value;
				var keyValue14 = document.getElementsByName("keyValue14")[0].value;
				var keyValue15 = document.getElementsByName("keyValue15")[0].value;
				var keyValue16 = document.getElementsByName("keyValue16")[0].value;
				var keyValue17 = document.getElementsByName("keyValue17")[0].value;
				var keyValue18 = document.getElementsByName("keyValue18")[0].value;
				var keyValue19 = document.getElementsByName("keyValue19")[0].value;
				var keyValue20 = document.getElementsByName("keyValue20")[0].value;
				
				item.elsAccount = elsAccount;
				item.templateCode =templateCode;
				item.templateName = templateName;
				item.keyValue1 = keyValue1;
				item.keyValue2 = keyValue2;
				item.keyValue3 = keyValue3;
				item.keyValue4 = keyValue4;
				item.keyValue5 = keyValue5;
				item.keyValue6 = keyValue6;
				item.keyValue7 = keyValue7;
				item.keyValue8 = keyValue8;
				item.keyValue9 = keyValue9;
				item.keyValue10 = keyValue10;
				item.keyValue11 = keyValue11;
				item.keyValue12 = keyValue12;
				item.keyValue13 = keyValue13;
				item.keyValue14 = keyValue14;
				item.keyValue15 = keyValue15;
				item.keyValue16 = keyValue16;
				item.keyValue17 = keyValue17;
				item.keyValue18 = keyValue18;
				item.keyValue19 = keyValue19;
				item.keyValue20 = keyValue20;
				
		 		
			 	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_alert_SaveRecord" defaultValue="是否确认保存记录?" />',closeEvent:function(){
			 		$.ajax({
			 			url: '<%=basePath%>rest/SupplierStandardService/updateModel',
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
    			 			  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
    			 			  	$.ajax({
    			 					url :"<%=basePath%>rest/BatchImportService/DepostiBankExcelImport/" + elsAccount + "?filePath="  + filePath,
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
    			 						    //var selectedIndexs = templateGrid.rows().length + 1;
    			 							var selectIndex = templateGrid.rowsLength();
    			 							for(var i = 0;i<data.length;i++){
    			 								var Row = data[i];
    			 									templateGrid.addRow(Row,selectIndex);
    			 									selectIndex++;
    			 							}
    			 							
    			 						}
    			 					},
    			 					error: function (data) {//获取ajax的错误信息
    			 						parent.elsDeskTop.hideLoading();
    			 						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误！" />"});
    			 		            }
    			 				});
    			 			});
    			 		}
    			 	}
    			  //excel导入-------------end-------------------
    			    
    	    //模板导入   @author jiangzhidong @date 20160129
   			$("#importBtn").click(function() {
				 var selectRows = templateGrid.selectedRows();
				 var str = JSON.stringify(selectRows);
				 parent.frames['iframeApp_'+frameAppId].setTemplete(str);
			     parent.elsDeskTop.closeCurWin('standTemplateManage');
			});
    			  
   			//退出
   			$("#exitBtn").click(function(){
   				//parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认关闭?修改的内容将不被保存" key=""/>', closeEvent:function(){
   					parent.elsDeskTop.closeCurWin('purchaseTemplateManage');
   				//}});
   			});
    			    
		</script>
</body>
</html>