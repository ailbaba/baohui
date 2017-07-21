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
				<button id="deleteBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_label_delete"></i18n:I18n></button>
				<button id="importExcel" class="button-wrap btnUpload"><i18n:I18n defaultValue="Excel导入" key="i18n_common_button_excelimport"></i18n:I18n></button>
				<button id="excelModel" class="button-wrap"><i18n:I18n defaultValue="Excel模板下载" key="i18n_common_button_downloadexceltemplate"></i18n:I18n></button>
			</div>
		</div>
		<form id="relationForm" onsubmit="return false;" method="POST"
			action="">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
				<div class="common-box-line">
					<div class="tab-wrap" id="sheet-head">
						<div id="sheet-item-one">
							<main class="grid-container">
							<div class="grid-100" id="enterpriseInfoGrid">
								<table id="EnterpriseInfoTable"></table>
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
		
	 var enterpriseInfoGrid;
	 var date = new Date().format("yyyy-MM-dd");
	 var excelUploader; //上传Excel控件 
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
    					
    					$("#excelModel").click(function(){
    						var filePath = "template/企业信息表导入模板.xlsx";
    						window.location.href = "<%=basePath%>"  + filePath;
    					});
    				  
    				  
    					$("#editBtn").click(function(){			
    						var selectedIndexs = enterpriseInfoGrid.selectedRowsIndex();
    						if (selectedIndexs.length == 0||selectedIndexs.length=="") {
    							alert('<i18n:I18n defaultValue="请选择至少一行" key="i18n_alert_atLeast_select_oneItem"></i18n:I18n>',2);
    							return;
    						}
    						parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="是否保存选中行的修改?" key="i18n_common_cofirm_editRow"></i18n:I18n>',closeEvent:function(){
    						updatejson();
    						//转化选择行的json 
    						var rowjson = JSON.stringify(enterpriseInfoGrid.selectedRows());
    						
    						updateForm(rowjson);
    						}});
    					});
    				  
    					$("#deleteBtn").click(function(){		
    						//删除多选的数量 
    						var selectRows = enterpriseInfoGrid.selectedRows();
    						var selectIndex = enterpriseInfoGrid.selectedRowsIndex;

    						var deleletRowjson = JSON.stringify(selectRows);
    						//设置删除的时候也同样需要将对应的额外字段设置为空 
    						//deleletRowjson.purchaseMaterialList = null;
    						var deleteCount =  selectRows.length;
    						var selectedIndexs = enterpriseInfoGrid.selectedRowsIndex();
    						if (selectedIndexs.length == 0||selectedIndexs.length=="") {
    							alert('<i18n:I18n defaultValue="请选择至少一行" key="i18n_alert_atLeast_select_oneItem"></i18n:I18n>',2);
    							return;
    						}
    						parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="是否删除选中行?" key="i18n_common_cofirm_deleteRow"></i18n:I18n>',closeEvent:function(){
    							
    							for(var i = 0;i<deleteCount;i++){
    								enterpriseInfoGrid.removeRow(selectedIndexs[0]);
    							}
    						}});
    					});
    	

	  
	 //初始化加载信息 
	$(document).ready(function(){
		initGrid();      //初始化表格数据和事件 
		initExcelUploader();
	});


     var cols = [
    	        {title:'<i18n:I18n key="i18n_enterprise_elsAccount" defaultValue="ELS企业号" />', name:'elsAccount', width: 120, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n key="i18n_enterprise_nature" defaultValue="企业性质" />', name:'nature', width: 120, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n key="i18n_enterprise_fullName" defaultValue="企业全称" />', name:'fullName' ,width:120, align:'center' ,renderer:initInput},
    	        {title:'<i18n:I18n key="i18n_enterprise_companyShortName" defaultValue="企业简称" />', name:'companyShortName', width: 250, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_countryCode" defaultValue="国家" />', name:'countryCode', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_province" defaultValue="省份" />', name:'province', width: 120, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n key="i18n_enterprise_city" defaultValue="城市" />', name:'city', width: 120, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n key="i18n_enterprise_address" defaultValue="详细地址" />', name:'address', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_telphone" defaultValue="电话" />', name:'telphone', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_fax" defaultValue="传真" />', name:'fax', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_email" defaultValue="电子邮件" />', name:'email', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_website" defaultValue="公司网站" />', name:'website', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_industry" defaultValue="行业大类" />', name:'industry', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_industryDetail" defaultValue="业务范围" />', name:'industryDetail', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n key="i18n_enterprise_erp" defaultValue="ERP系统" />', name:'erp', width: 120, align: 'center',renderer:initInput},
    	    ]; 
    
    
    function inputSetValue(materialLine,index){
	       //获取input 对象里面的值
	       var elsAccount = $("#elsAccount_" + index).val();
	       materialLine["elsAccount"]=elsAccount;
	       
	       var nature = $("#nature_" + index).val();
	       materialLine["nature"]=nature;
	       
	       var fullName = $("#fullName_" + index).val();
	       materialLine["fullName"]=fullName;
	       
	       var companyShortName = $("#companyShortName_" + index).val();
	       materialLine["companyShortName"]=companyShortName;
	       
	       var countryCode = $("#countryCode_" + index).val();
	       materialLine["countryCode"]=countryCode;
	       
	       var province = $("#province_" + index).val();
	       materialLine["province"]=province;
	       
	       var city = $("#city_" + index).val();
	       materialLine["city"]=city;
	       
	       var address = $("#address_" + index).val();
	       materialLine["address"]=address;
	       
	       var telphone = $("#telphone_" + index).val();
	       materialLine["telphone"]=telphone;
	       
	       var fax = $("#fax_" + index).val();
	       materialLine["fax"]=fax;
	       
	       var email = $("#email_" + index).val();
	       materialLine["email"]=email;
	       
	       var website = $("#website_" + index).val();
	       materialLine["website"]=website;
	       
	       var industry = $("#industry_" + index).val();
	       materialLine["industry"]=industry;
	       
	       var industryDetail = $("#industryDetail_" + index).val();
	       materialLine["industryDetail"]=industryDetail;
	       
	       var erp = $("#erp_" + index).val();
	       materialLine["erp"]=erp;
	       
	       return materialLine;
	   }

        // 初始化表格及表格事件 
   		function initGrid(){
   			var height=$(document).height()-155;
       		enterpriseInfoGrid= $('#EnterpriseInfoTable').mmGrid({
      	    	    cols: cols,
  					root : "rows",
  				    height:450,
  					loadingText : '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>',
  					noDataText : '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>',
  					checkCol : true,
  					multiSelect: true,
  					indexCol: true
  				});
       		
       		enterpriseInfoGrid.on('loadSuccess', function(e, data) {
				//
			});

			enterpriseInfoGrid.on('rowInserted',function(e,item,index){
			 	for(var i = total ;i<=index;i++){
					enterpriseInfoGrid.select(i);
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
				return '<select  class = "quantityunitSelect"  name="'+name+'" id="'+name+'_'+index+'"  >' +' <option  value = ""> 请选择单位</option></select>';
	    	}
	    }
	    
	    function initInputDouble(val,item,index){
	    	if(!val) { val = '';}
	    	var name = $(this)[0].name;
			return '<input onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"    name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
	    }		
		    
	    //更新所有的json数据
	    function updatejson(){
	    	var materialRelationRow =  enterpriseInfoGrid.rows();
	    	if(null!=materialRelationRow&&materialRelationRow!=""){
	    		for(var i = 0;i<materialRelationRow.length;i++){
	    			var singleRow = materialRelationRow[i];
	    			singleRow = inputSetValue(singleRow,i);
	    		}
	    	}
	    }
		    
		    
	    function updateForm(data){
	    	parent.elsDeskTop.showLoading("<i18n:I18n defaultValue='保存中' key='i18n_requirementsPlanning_alert_inTheSave'/>");
	    	$.ajax({
	    		url: "<%=basePath%>rest/BatchImportService/batchImportEnterpriseInfo/",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:data,
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					var option ="";
					if(data=="Success"){
						alert("已导入", 1); 
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
	 			    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
	 			    auto: true,
	 			    duplicate :true,
	 			    accept:{
	 			    	extensions:"xls,xlsx"
	 			    },
	 			    server: '<%=basePath%>servlet/UploadServlet',
	 			    pick: '#importExcel',
	 			    resize: false,
	 			    formData : {
	     		     	elsAccount : elsAccount
	     		     }
	 			});
	 			
	 			excelUploader.on( 'uploadAccept', function( obj, response ) {
	 			   var filePath = response.url;
	 			  	parent.elsDeskTop.showLoading('正在导入');
	 			  	$.ajax({
	 					url :"<%=basePath%>rest/BatchImportService/EnterpriseInfoExcelImport/" + elsAccount + "?filePath="  + filePath,
	 					type :"POST",
	 					contentType : "application/json",
	 					dataType : "json",
	 					data:"",
	 					success : function(data) {
	 						if(data.statusCode=="-100"){
	 							parent.elsDeskTop.hideLoading();
	 							parent.elsDeskTop.tip.init({type:'alert', displayType:3, message:data.message});
	 						}else{
	 							parent.elsDeskTop.hideLoading();
	 							enterpriseInfoGrid.load(data.rows);
	 						}
	 					},
	 					error: function (data) {
	 						parent.elsDeskTop.hideLoading();
	 						parent.elsDeskTop.tip.init({type:'alert', displayType:3, message:"系统错误！"});
	 		            }
	 				});
	 			});
	 		}
	 	}
	  //excel导入-------------end-------------------
    			    
    			    
		</script>
</body>
</html>