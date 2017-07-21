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
							<div class="grid-100" id="subAccountBusinessPartnerGridPartnerGrid">
								<table id="SubAccountBusinessPartnerTable"></table>
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
		
	 var subAccountBusinessPartnerGrid;
	 var date = new Date().format("yyyy-MM-dd");
	 var excelUploader; //上传Excel控件 
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var selectRows=[];
	 var createUser = '<%=session.getAttribute("username")%>';
    					
    					$("#excelModel").click(function(){
    						var filePath = "template/合作伙伴导入模板.xlsx";
    						
    						window.location.href = "<%=basePath%>"  + filePath;
    					});
    				  
    					$("#editBtn").click(function(){
    						debugger;
    						selectRows = subAccountBusinessPartnerGrid.find('tr.selected');
    						var selectedElsAccount = subAccountBusinessPartnerGrid.find('input[name=elsAccount]').toArray().map(function(v){
    							return v.value;
    						})
    						var selectedIndexs = subAccountBusinessPartnerGrid.selectedRowsIndex();
    						if (selectedIndexs.length == 0||selectedIndexs.length=="") {
    							alert('<i18n:I18n defaultValue="请选择至少一行" key="i18n_alert_atLeast_select_oneItem"></i18n:I18n>',2);
    							return;
    						}else{
    							for(var i=0; i<selectedElsAccount.length;i++){
//         							if(selectedElsAccount[i] != elsAccount && selectedElsAccount[i] != ''){
//         								alert('<i18n:I18n defaultValue="您没有权限导入其他els账号的信息！" key=""></i18n:I18n>',2);
//             							return;
//         							}else 
        								if(selectedElsAccount[i] == ''){
        								alert('<i18n:I18n defaultValue="els账号信息不能为空！" key=""></i18n:I18n>',2);
            							return;
        							}
        						}
    						}
    						parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="是否保存选中行的修改?" key="i18n_common_cofirm_editRow"></i18n:I18n>',closeEvent:function(){
    						updatejson();
    						//转化选择行的json 
    						var rowjson = JSON.stringify(subAccountBusinessPartnerGrid.selectedRows());
    						
    						updateForm(rowjson);
    						}});
    					});
    				  
    					$("#deleteBtn").click(function(){		
    						//删除多选的数量 
    						var selectRows = subAccountBusinessPartnerGrid.selectedRows();
    						var selectIndex = subAccountBusinessPartnerGrid.selectedRowsIndex;

    						var deleletRowjson = JSON.stringify(selectRows);
    						//设置删除的时候也同样需要将对应的额外字段设置为空 
    						//deleletRowjson.purchaseMaterialList = null;
    						var deleteCount =  selectRows.length;
    						var selectedIndexs = subAccountBusinessPartnerGrid.selectedRowsIndex();
    						if (selectedIndexs.length == 0||selectedIndexs.length=="") {
    							alert('<i18n:I18n defaultValue="请选择至少一行" key="i18n_alert_atLeast_select_oneItem"></i18n:I18n>',2);
    							return;
    						}
    						parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="是否删除选中行?" key="i18n_common_cofirm_deleteRow"></i18n:I18n>',closeEvent:function(){
    							
    							for(var i = 0;i<deleteCount;i++){
    								subAccountBusinessPartnerGrid.removeRow(selectedIndexs[0]);
    							}
    						}});
    					});
    	

	  
	 //初始化加载信息 
	$(document).ready(function(){
		initGrid();      //初始化表格数据和事件 
		initExcelUploader();
	});

     var cols = [
    	        {title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount', width: 120, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n defaultValue="企业全称" key=""></i18n:I18n>', name:'fullName', width: 150, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n defaultValue="子账号" key="i18n_common_title_elssubaccount"/>', name:'elsSubAccount', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n defaultValue="企业简称" key=""></i18n:I18n>', name:'shortName', width: 120, align: 'center',renderer:initInput},
                {title:'<i18n:I18n defaultValue="一级分类" key=""/>', name:'groupIdAName', width: 120, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n defaultValue="二级分类" key=""></i18n:I18n>', name:'groupIdBName',width: 120, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n defaultValue="对方ELS号" key=""></i18n:I18n>', name:'friendElsAccount', width: 120, align: 'center',renderer:initInput},
    	        {title:'<i18n:I18n defaultValue="对方子账号" key=""></i18n:I18n>', name:'friendElsSubAccount', width: 150, align: 'center',renderer:initInput},
                {title:'<i18n:I18n defaultValue="对方公司名称" key=""></i18n:I18n>', name:'friendCompanyName', width: 150, align: 'center',renderer:initInput},
                {title:'<i18n:I18n defaultValue="数据导入状态" key=""></i18n:I18n>', name:'insertState', width: 150, align: 'center',renderer:initInput},
    	    ]; 
    
    
    function inputSetValue(materialLine,index){
    	
	       //获取input 对象里面的值
	       var elsAccount = $("#elsAccount_" + index).val();
	       materialLine["elsAccount"]=elsAccount;
	       
	       var fullName = $("#fullName_" + index).val();
	       materialLine["fullName"]=fullName;
	       
	       var elsSubAccount = $("#elsSubAccount_" + index).val();
	       materialLine["elsSubAccount"]=elsSubAccount;
	       
	       var shortName = $("#shortName_" + index).val();
	       materialLine["shortName"]=shortName;
	       
	       var groupIdAName = $("#groupIdAName_" + index).val();
	       materialLine["groupIdAName"]=groupIdAName;
	       
	       var groupIdBName = $("#groupIdBName_" + index).val();
	       materialLine["groupIdBName"]=groupIdBName;
	       
	       var friendElsAccount = $("#friendElsAccount_" + index).val();
	       materialLine["friendElsAccount"]=friendElsAccount;
	       
	       var friendElsSubAccount = $("#friendElsSubAccount" + index).val();
	       materialLine["friendElsAccount"]=friendElsAccount;
	       
	       var friendCompanyName = $("#friendCompanyName_" + index).val();
	       materialLine["friendCompanyName"]=friendCompanyName;
	       
	       var insertState = $("#insertState_" + index).val();
	       materialLine["insertState"]=insertState;
	       
	       return materialLine;
	   }

    // 初始化表格及表格事件 
    		function initGrid(){
    			
    			var height=$(document).height()-155;
        		subAccountBusinessPartnerGrid= $('#SubAccountBusinessPartnerTable').mmGrid({
        			cols: cols,
					root : "rows",
				    height:450,
					loadingText : '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>',
					noDataText : '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>',
					checkCol : true,
  					multiSelect: true,
  					indexCol: true
        			});
        		
        		subAccountBusinessPartnerGrid.on('loadSuccess', function(e, data) {
        			debugger;
				});

				subAccountBusinessPartnerGrid.on('rowInserted',function(e,item,index){
					//添加行时自动选择
					 
					//total是还未更新前的行数,index 是最后一行行数,来两者之间的差获取新增的行数
				 	for(var i = total ;i<=index;i++){
						subAccountBusinessPartnerGrid.select(i);
					} 
						
				});
        		
    		}
    				
    			    //数据
    			    function initInput(val,item,index){
    			    	if(!val) { val = '';}
    			    	var name = $(this)[0].name;
    					return '<input   name="'+name+'" id="'+name+'_'+index+'" type="text" value="'+val+'"/>';
    			    }
    			    
    			    
    			    //更新所有的json数据
    			    function updatejson(){
    			    	debugger;
    			    	var materialRelationRow =  subAccountBusinessPartnerGrid.rows();
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
	   			    		url: "<%=basePath%>rest/BatchImportService/batchImportSubAccountBusinessPartner/",
							type :"POST",
							contentType : "application/json",
							dataType : "json",
							data:data,
							success : function(data) {
								if(data!=null&&data.statusCode=="-100"){
									parent.elsDeskTop.hideLoading();
									alert(data.message,3);
								}else{
									parent.elsDeskTop.hideLoading();
									alert("<i18n:I18n defaultValue='保存成功' key='i18n_common_alert_savesuccess'/>",1);
									selectRows.each(function(i,r){
										$(r).find('input[name=insertState]').val(data[i].insertState);
									})
								}
							},
							error: function (xhr, type, exception) {
								parent.elsDeskTop.hideLoading();
								alert(data.message,3);
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
    			 					url :"<%=basePath%>rest/BatchImportService/SubAccountBusinessPartnerExcelImport/" + elsAccount + "?filePath="  + filePath,
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
    			 							debugger;
    			 							subAccountBusinessPartnerGrid.load(data.rows);
    			 							
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