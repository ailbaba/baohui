<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ include file="../../elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 130px;
		padding-left: 20px;
		padding-top: 10px ;
		text-align: right;
	}
</style>

<body>
	<div class="pos-relative public-wrap">
		<form id="iForm" onsubmit="return false;">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="输入模版基本信息" /></span>
			<div class="common-box-line">
		   	 	<input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsAccount") %>" >
    			<input type="hidden" id="elsDesc" name="elsDesc" value="<%=session.getAttribute("companyShortName") %>">
				<div class="dis-in-b input-and-tip">
					<span>名称:</span>
					<input type="text" id="templateName" name="templateName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span>描述:</span>
					<input type="text" id="templateDesc" name="templateDesc" />
				</div>
				<button  id="addTemplate" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>编号:</span>
					<input type="text" id="regulationGroupNumber" name="regulationGroupNumber"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span>名称:</span>
					<input type="text" id="regulationGroupName" name="regulationGroupName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />:</span>
					<input type="text" id="createUser" name="createUser" />
				</div>
				<button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
                <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
			</div>
		</div>
		
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="条例组列表" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100">
							<table id="groupTable"></table>
							<div id="groupPage" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="所选组条例列表" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100">
							<table id="headTable"></table>
							<div id="enquiryPage" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
		
		 <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="添加到模版列表" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <div id="sheet-project-one">
                         <main class="grid-container nest-table">
		                    <div class="grid-100" id="reCreate">
		                        <table id="itemTable"></table>
		                        <div id="itempPage" style="text-align: right;"></div>
		                    </div>
		                </main>
                    </div>
                </div>
            </div>
        </div>
		</form>
         <div class="fixed-dialog" id="selectAccountDialog" >
			<div class="dialog-tip bg-common" style="width: 480px;height:400px;margin-left: -215px;margin-top: -270px;">
			    <div class="dialog-close-btn" id="btnSelectAccountDialogClose"></div>
		        <div class="tip-head">
			        <img class="icon" src="../../icon/els.PNG" />
			        <span class="dialogTitle" id="titleSelectAccountDialog"><i18n:I18n key="" defaultValue="帐号选择" /></span>
			    </div>
			    <input type="hidden" id="selectAccountIndex">
			    <div class="">
			        <div class="box-wrap pos-relative bg-common">
			            <main class="bg-common p-6">
		                    <div class="grid-100" >
		                        <table id="select-supplier-table"></table>
		                    </div>
		                    <div class="mt-40 text-center" style="margin-top: 14px;">
			                    <button id="selectAccountOKBtn" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
			                    <button id="btnSelectAccountCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
			                </div>
		                 </main>
			        </div>
			    </div>
		    </div>
		</div>
	</div>

	<script>
	 var headTable;
	 var groupTable;
	 var itemTable;
	 var type="";
	 var roleCode="";
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	 var rowIndexSelect=0;
	 var excelUploader;
	 $(document).ready(function(){


	 });
		
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
		
		//允许任何字符输入框 只读
		var initInputAny2 = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" readonly="readonly" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		
		var initInputHidden = function(val, item, index){
			if(!val) { val = '';}
			return val+'<input type="hidden"  name="templateList[]['+this.name+']" value="'+val+'"/>';
		};
		
		var initScoreAccount = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" name="templateList[]['+this.name+']" id="'+this.name+'_'+index+'" value="'+val+'"  style="width:200px;padding-right:20px;" onkeyup="value=value.replace(/[^(\d,)]/g,"")"/>'+
			'<img class="scoreAccount dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 2px;cursor: pointer;" id='+index+' title="<i18n:I18n key="" defaultValue="查找帐号" />" />';
			
		};
		
		//1-sale：销售方 purchese：采购方
		var initParticipants = function(val,item,index) {
			var selected = '<select name="templateList[][participants]" id="templateList[][participants]"  style="min-width:70px; padding:5px;">'
							+'<option value="purchese"><i18n:I18n key="test" defaultValue="采购方" /></option>'
							+'<option value="sale" selected="selected"><i18n:I18n key="test" defaultValue="销售方" /></option></select>'
			return selected;
		};
		//评分类型   1-百分比   2-合格/不合格
		var initScoreType = function(val,item,index) {
			var selected = '<select name="templateList[][scoreType]" id="templateList[][scoreType]"  style="min-width:80px; padding:5px;">'
							+'<option value="1"><i18n:I18n key="test" defaultValue="百分比" /></option>'
							+'<option value="2"><i18n:I18n key="test" defaultValue="合格/不合格" /></option></select>'
			return selected;
		};
		//日期
		var formatDate = function (val, item, index){
			if (!val) {val = "";}
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
			return val;
		};
		//时间
		var formatDateTime = function (val, item, index){
			if (!val) {val = "";}
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
			return val;
		};
		
		//渲染手工输入格式 1为手动输入,2为单选 3为多选
		var initInputType = function(val,item,index){
			if(!val){
				val = '';
				return ;
			}
			if(val==1){
				return '<i18n:I18n key="test" defaultValue="手工输入" />';
			}else if(val == 2){
				return '<i18n:I18n key="test" defaultValue="单选" />';
			}else if(val == 3){
				return '<i18n:I18n key="test" defaultValue="多选" />';
			}else{
				return '<i18n:I18n key="test" defaultValue="其他" />';
			}
		}
		
		//渲染附件信息
		var initUploadType = function(val,item,index){
			if(!val){
				val = '';
				return ;
			}
			if(val==1){
				return '<i18n:I18n key="test" defaultValue="需要" />';
			}else if(val == 2){
				return '<i18n:I18n key="test" defaultValue="不需要" />';
			}else{
				return '<i18n:I18n key="test" defaultValue="其他" />';
			}
		}
		
		//渲染选项信息 
		var selectRelation = function(val,item,index){
			//判断手工输入还是选项
			if(item.inputType=="1"){
				return '<i18n:I18n key="test" defaultValue="无" />';
			}else{
				return '<span style = "color:blue;cursor:pointer"  class =  "findSelection" ><i18n:I18n key="test" defaultValue="查看" /> </span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			}
		}
		
		$('.findSelection').live("click", function() {
			var editCol = $(this).next().text();
			var headRows = JSON.parse(editCol);
			parent.elsDeskTop.defineWin({
		        iconSrc : "icon/icon9.png",
		        windowsId : "RegulationSelection",
		        windowTitle : "<i18n:I18n defaultValue='查看条例选项' key='test'/>",
		        iframSrc : "${pageContext.request.contextPath}/regulation/regulationSelect.jsp?regulationNumber=" + headRows.regulationNumber,
		        showAdv : true,
		        windowMinWidth : 500,
		        windowMinHeight : 600,
		        windowWidth : 500,
		        windowHeight : 600,
		        parentPanel : ".currDesktop"
		    });
		 });
		
		$("#btnSelectAccountDialogClose").click(function(){
	    	$("#selectAccountDialog").hide();
	    });
	    $("#btnSelectAccountCancel").click(function(){
	    	$("#selectAccountDialog").hide();
	    });
	    var selectAccountable;
	    var accountCols = [
	                       { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:80, align:'center'},
	                       { title:'<i18n:I18n defaultValue="子账号" key="i18n_common_title_elssubaccount"></i18n:I18n>', name:'elsSubAccount' , width:100, align:'center'},
	                       { title:'<i18n:I18n defaultValue="姓名" key="i18n_common_title_username"></i18n:I18n>', name:'name' ,width:140, align:'center'},
	                ];

	    
	    function showAccount(index){
	    	$("#selectAccountDialog").show();
	    	$("#selectAccountIndex").val(index);
	    	if(!selectAccountable){
	    		selectAccountable=$('#select-supplier-table').mmGrid({
	    	        cols: accountCols,
	    	        url: "<%=basePath%>rest/AccountService/subAccountList",
	    	        params: {"elsAccount":elsAccount},
	    	        method: 'post',
	    	        height:280,
	    	        root: 'rows',
	    	        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	    	        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	    	        multiSelect: true,
	    	        checkCol: true,
	    	    });
	    	} 
	    };
	    
	    $("#selectAccountOKBtn").click(function(){
			var selectedRows = selectAccountable.selectedRows();
			var index = $("#selectAccountIndex").val();
			if(selectedRows != "" ){
				var subAccounts = selectedRows[0].elsSubAccount;
				for(var i=1;i<selectedRows.length;i++){
					subAccounts = subAccounts+","+selectedRows[i].elsSubAccount;
				}
				$("#scoreAccount_"+index).val(subAccounts);
			}else{
				alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
				return;
			}
			$("#selectAccountDialog").hide();
		});
	    
	  //新增
	 $("#addTemplate").click(function(e){
		    var templateName = $("#templateName").val();
			if (templateName.length == 0) {
				 alert('<i18n:I18n key="" defaultValue="请输入名称!" />',2);
				 $("#templateName").focus();
				 return;
			}
			var bool = false;
			$("input[name='templateList[][scoreAccount]']").each(function(){
				var value = $(this).val();
				if(value==""){
					bool = true;
					return;
				}
			});
			if(bool){
				alert('<i18n:I18n key="" defaultValue="评分帐号不能为空!" />',2);
				return;
			}
			var weights = 0;
			$("input[name='templateList[][weight]']").each(function(){
				var value = $(this).val();
				if(value!=""){
					weights = weights+parseInt(value);
				}
			});
			if(weights!=100){
				 alert('<i18n:I18n key="" defaultValue="权重之和必须为100!" />',2);
				 return;
			}
			var frm = $("#iForm").serializeJSON();
			var frmData = JSON.stringify(frm);
			  $.ajax({
				url : '<%=basePath%>rest/RegulationService/saveTemplate',
				type : "POST",
				contentType : "application/json",
				data :frmData ,
				dataType : "json",
				success : function(data) {
					if(data==-100){
						alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
					}else {
						 alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />',1);
						 setTimeout(function(){				     
							closeWin();
						 }, "3000");  
					}
				},
				error : function(data) {
					if (data.responseText.indexOf('<i18n:I18n key="i18n_account_alert_noPermissionOperation" defaultValue="你没有权限进行此操作" />') > 0) {
						alert('<i18n:I18n key="i18n_account_alert_noPermissionOperation" defaultValue="你没有权限进行此操作" />',3);
		            }else{
		            	alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
		            }
				}
			});  
		});
	 	
	 
		 //添加到组
		 $("#addBtn").click(function(e){
			  e.stopPropagation();
			  e.preventDefault();
		 	  var head = headTable.selectedRows();
		 	  if(head.length<=0){
				 alert("<i18n:I18n key="i18n_alert_must_select_oneItem" defaultValue="必须选择一行！" />",2);
				 return;
			  }
		 	  var item = itemTable.rows();
		 	  if(typeof(item[0])=="undefined"){
					 itemTable.addRow(head);
		 	  }else {
			 	  for(var i=0;i<head.length;i++){
			 		 var bool = true;
			 		 for(var j=0;j<item.length;j++){
					  	 if(item[j].regulationNumber==head[i].regulationNumber){
						 	bool = false;	 
					  	 }
				 	 }
			 		 if(bool){
			 			itemTable.addRow(head[i]);
			 		 }
			 	  }
		 	  }
		 		  
		});
	 
		//删除
		$("#delBtn").click(function(e){
			e.stopPropagation();
		    e.preventDefault();
			var seletectIndexArr=itemTable.selectedRowsIndex();
			if(seletectIndexArr.length<=0){
				alert("请选择要删除的行!",2);
				return;
			}
		 	for(var i=0;i<seletectIndexArr.length;i++){
		 		itemTable.removeRow(seletectIndexArr);
	 		}
		});
	 
	 //查询
	 $("#queryBtn").click(function(e){
		 var regulationGroupNumber = $("#regulationGroupNumber").val();
		 var regulationGroupName = $("#regulationGroupName").val();
		 groupTable.opts.params = {elsAccount:elsAccount,regulationGroupNumber:regulationGroupNumber,regulationGroupName:regulationGroupName};
		 groupTable.load({page:1});
	 });
	 
	 function closeWin(){
		parent.frames['iframeApp_regulationTemplate'].headTable.load();
        parent.elsDeskTop.closeCurWin('addTemplate');
	 }
	 
	 //条例组表
	 var group_cols = [
	    	            { title:'<i18n:I18n key="" defaultValue="编号" />', name:'regulationGroupNumber', width: 200, align: 'center'},
	    	        	{ title:'<i18n:I18n key="" defaultValue="名称" />', name:'regulationGroupName' ,width:200, align:'center' },
	    	        	{ title:'<i18n:I18n key="" defaultValue="条例编号" />', name:'regulationNumber' ,width:200,hidden:true,align:'center' },
	    	        	{ title:'<i18n:I18n key="" defaultValue="类型" />', name:'typeName' ,width:200, align:'center' },
	    	        	{ title:'<i18n:I18n key="" defaultValue="描述" />', name:'regulationGroupDesc' ,width:200, align:'center' },
	    	        	{ title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:150, align:'center' },
	    	        	{ title:'<i18n:I18n key="i18n_fileManage_title_createDate" defaultValue="创建日期" />', name:'createDate' ,width:150, align:'center', renderer:formatDateTime},
	    	        	//{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark' ,width:200, align:'center'}
	     	        	];
	   	   	   

	   	     	 var GobalparamStr={"elsAccount":elsAccount};
	   	     	 var height=$(document).height()-155;
	   	     	 groupTable= $('#groupTable').mmGrid({
	   	     	    	 		cols: group_cols,
	   	     	         		url: '<%=basePath%>rest/RegulationService/getRegulationGroupList',
	   	     					params : GobalparamStr,
	   	     					method : 'post',
	   	     					root : "rows",
	   	     					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	   	     			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	   	     			        multiSelect : true,
	   	     			        checkCol : true,
	   	     			        indexCol : false,
	   	     					plugins : [ 
	   	    					           $('#groupPage').mmPaginator({
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
	   	     	 	
	   	     	groupTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
			     	rowIndexSelect=rowIndex;
			     	loadRegulation(item);
			    });
	   	     	 
  
	 var colst_head = [
	   	            { title:'条例编号', name:'regulationGroupNumber', width: 200, align: 'center'},
	   	        	{ title:'条例名称', name:'regulationName' ,width:200, align:'center' },
	   	        	{ title:'条例类型', name:'regulationTypeName' ,width:200, align:'center' },
	   	        	{ title:'输入类型', name:'inputType' ,width:200, align:'center' , renderer:initInputType},
		        	{ title:'是否需要附件', name:'uploadFileFlag' ,width:200, align:'center', renderer:initUploadType},
		        	{ title:'关联选项', name:'selectId' ,width:200, align:'center',renderer: selectRelation },
	   	        	{ title:'创建人', name:'createUser' ,width:150, align:'center' },
	   	        	{ title:'创建日期', name:'createDate' ,width:150, align:'center', renderer:formatDate},
	   	       ];

	     	  var height=$(document).height()-155;
	     	  headTable= $('#headTable').mmGrid({
	     	    	 		cols: colst_head,
	     					method : 'post',
	     					root : "rows",
	     					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	     			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	     			        multiSelect : true,
	     			        checkCol : true,
	     			        indexCol : false,
	     				});
	     	 
	  		//加载行
	  		 var loadRegulation = function(sel) {
	  		 		$.ajax({
	  		 			url : '<%=basePath%>rest/RegulationService/getRegulationByGroupNumber' + "?t="+new Date().getTime(),
	  		 			type : 'POST',
	  		 			contentType : "application/json",
	  		 			data : JSON.stringify(sel),
	  		 			dataType : "json",
	  		 			success : function(data) {
	  		 				var head = headTable.rows();
	  		 				var regulationGroupNumber =  sel.regulationGroupNumber;
	  		 				var item = data.rows;
	  		 				if(head[0] === undefined){
	  		 					item.forEach(function(d){
	  		 						d.regulationGroupNumber = regulationGroupNumber;
	  		 					});
	  							 headTable.addRow(item);
	  		 				}else {
		  		 				for(var i=0;i<item.length;i++){
		  					 		 var bool = true;
		  					 		 for(var j=0;j<head.length;j++){
		  							  	 if(item[i].regulationNumber==head[j].regulationNumber){
		  								 	bool = false;	 
		  							  	 }
		  						 	 }
		  					 		 if(bool){
		  					 			item[i].regulationGroupNumber = regulationGroupNumber;
		  		 						headTable.addRow(item[i]);
		  					 		 }
		  					 	  }
	  		 				}
	  		 			},
	  		 			error : function(data) {
	  		 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
	  		 			}
	  		 		});
	  		 }
	     	  
	//===========================================表体===========================================
	  var cols_item = [
   	   	            { title:'条例编号', name:'regulationNumber', width: 200, align: 'center',renderer:initInputHidden},
   	   	        	{ title:'条例名称', name:'regulationName' ,width:200, align:'center',renderer:initInputHidden},
   	   	        	{ title:'参与对象', name:'participants' ,width:200, align:'center' ,renderer:initParticipants},
   	   	        	{ title:'评分类型', name:'scoreType' ,width:200, align:'center' ,renderer:initScoreType},
   	   	        	{ title:'评分账户', name:'scoreAccount' ,width:200, align:'center' ,renderer:initScoreAccount},
   	   	        	{ title:'评分标准说明', name:'templateList[][scoreStandard]' ,width:200, align:'center',renderer:initInputAny},
   	   	        	{ title:'权重', name:'templateList[][weight]' ,width:200, align:'center' ,renderer:initInputNumber},
	   	       ];
	
		 itemTable = $('#itemTable').mmGrid({
		        cols: cols_item,
		        height: 300,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol: true,
		        multiSelect: true
		    });
		 
		 itemTable.on('cellSelected',function(e, item, rowIndex, colIndex){
				var _this=$(e.target);
				if(_this.hasClass("scoreAccount")) {
					showAccount(rowIndex);
				} 
			});
		 
		
			
</script>
</body>
</html>