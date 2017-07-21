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
    			<input type="hidden" id="templateNumber" name="templateNumber"/>
    			<input type="hidden" id="regulationNumber" name="regulationNumber"/>
				<div class="dis-in-b input-and-tip">
					<span>编号:</span>
					<input type="text" id="templateNumber1" readonly="readonly" name="templateNumber1" />
				</div>
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
					<span>名称:</span>
					<input type="text" id="name" name="name" placeholder="请输入条例名称或组名称" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span>类型:</span>
					<input type="text" id=regulationTypeName name="regulationTypeName" placeholder="输入条例类型或组类型" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span>创建人:</span>
					<input type="text" id="createUser" name="createUser" placeholder="输入条例创建人或组创建人" />
				</div>
				
				<button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			</div>
		</div>
		
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="所选组条例列表" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="addBtn"><i18n:I18n key="" defaultValue="添加到模版" /></button>
				<button class="button-wrap" id="addReBtn"><i18n:I18n key="test" defaultValue="新增条例" /></button>
				<button class="button-wrap" id="addGrBtn"><i18n:I18n key="test" defaultValue="新增组" /></button>
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
            	<button id="delBtn"><i18n:I18n key="test" defaultValue="从模版删除" /></button>
            	&nbsp;&nbsp;&nbsp;&nbsp;评分账户：
				<input id="scoreAccountBegin" name="standardDesc" type="text" style="width: 80px; max-width: 180px;" />
				<button class="button-wrap" id="replaceBtn"><i18n:I18n key="test" defaultValue="替换" /></button>
				<input id="scoreAccountEnd" name="standardDesc" type="text" style="width: 80px; max-width: 180px;" />
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
	 var number = GetQueryString("templateNumber");
	 $(document).ready(function(){
		 var name =GetQueryString("templateName");
		 var desc =GetQueryString("templateDesc");
		 var rNumber =GetQueryString("regulationNumber");
		 var cy =GetQueryString("cy");
		 if(number!=""&&cy!="1"){
			 $("#templateNumber").val(number);
			 $("#templateNumber1").val(number);
		 }
		 $("#templateName").val(decodeURI(name));
		 $("#templateDesc").val(decodeURI(desc));
		 $("#regulationNumber").val(rNumber);
	 });
	
		
		//只允许数字输入框
		var initInputNumber = function(val, item, index){
			if(!val) { val = 0;}
			return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="templateList[]['+this.name+']" value="'+val+'"/>';
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
		
		var initInputText = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text"  name="templateList[]['+this.name+']" value="'+val+'"/>';
		};
		
		var initScoreAccount = function(val, item, index){
			debugger;
			if(!val) { val = '';}
			else{
				var scoreAccount = item.scoreAccount.split("_")[0];
			}
			return '<input type="text" name="templateList[]['+this.name+']" id="'+this.name+'_'+index+'" value="'+scoreAccount+'"  style="width:200px;padding-right:20px;" onkeyup="value=value.replace(/[^(\d,)]/g,"")"/>'+
			'<img class="scoreAccount dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 2px;cursor: pointer;" id='+index+' title="<i18n:I18n key="" defaultValue="查找帐号" />" />';
			
		};
		
		//1-sale：销售方 purchese：采购方
		var initParticipants = function(val,item,index) {
			var selected = '<select name="templateList[][participants]" id="templateList[][participants]"  style="min-width:70px; padding:5px;">'
							+'<option value="purchese"><i18n:I18n key="test" defaultValue="采购方" /></option>'
							+'<option value="sale" selected="selected"><i18n:I18n key="test" defaultValue="销售方" /></option></select>'
							+'<img style="display:none" src="data:image/gif;base64,R0lGODlhAwADAIABAL6+vv///yH5BAEAAAEALAAAAAADAAMAAAIDjA9WADs=" '
							+'onload="this.previousSibling.value=\''+val+'\'""/>';
			var selected1 = '<select name="templateList[][participants]" id="templateList[][participants]"  style="min-width:70px; padding:5px;">'
				+'<option value="purchese"><i18n:I18n key="test" defaultValue="采购方" /></option>'
				+'<option value="sale" selected="selected"><i18n:I18n key="test" defaultValue="销售方" /></option></select>';
			return typeof(val)=="undefined"?selected1:selected;
		};
		//评分类型   1-百分比   2-合格/不合格
		var initScoreType = function(val,item,index) {
			var selected = '<select name="templateList[][scoreType]" id="templateList[][scoreType]"  style="min-width:80px; padding:5px;">'
							+'<option value="1"><i18n:I18n key="test" defaultValue="百分比" /></option>'
							+'<option value="2"><i18n:I18n key="test" defaultValue="合格/不合格" /></option></select>'
							+'<img style="display:none" src="data:image/gif;base64,R0lGODlhAwADAIABAL6+vv///yH5BAEAAAEALAAAAAADAAMAAAIDjA9WADs=" '
							+'onload="this.previousSibling.value='+val+'"/>';
			var selected1 = '<select name="templateList[][scoreType]" id="templateList[][scoreType]"  style="min-width:80px; padding:5px;">'
				+'<option value="1"><i18n:I18n key="test" defaultValue="百分比" /></option>'
				+'<option value="2"><i18n:I18n key="test" defaultValue="合格/不合格" /></option></select>';
			return typeof(val)=="undefined"?selected1:selected;
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
		        iframSrc : "${pageContext.request.contextPath}/regulation/regulationSelect.jsp?pid=editTemplate&regulationNumber=" + headRows.regulationNumber,
		        showAdv : true,
		        windowMinWidth : 800,
		        windowMinHeight : 600,
		        windowWidth : 800,
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

	    
	    function showAccount(belond,index,colIndex){
	    	$("#selectAccountDialog").show();
	    	var sParam= belond+','+index+','+ colIndex;
	    	$("#selectAccountIndex").val(sParam);
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
			var indexArr = $("#selectAccountIndex").val().split(',');
			if(selectedRows != "" ){
				var subAccounts = selectedRows[0].elsSubAccount;
				for(var i=1;i<selectedRows.length;i++){
					subAccounts = subAccounts+","+selectedRows[i].elsSubAccount;
				}
				//$("#scoreAccount_"+index).val(subAccounts);
				$(''+indexArr[0]).find('tr').eq(indexArr[1]).find('td').eq(indexArr[2]).find('input').val(subAccounts);
			}else{
				alert("<i18n:I18n defaultValue='请选择一条记录！' key='i18n_common_title_pleaseSelectOneRecord'/>",2);
				return;
			}
			$("#selectAccountDialog").hide();
		});
	    //add regulation
		 $("#addReBtn").click(function(e){
			 	e.stopPropagation();
			  	e.preventDefault();
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "RegulationAdd",
			        windowTitle : "<i18n:I18n defaultValue='新建条例' key='test'/>",
			        iframSrc : "${pageContext.request.contextPath}/regulation/addRegulation.jsp?pid=editTemplate",
			        showAdv : true,
			        windowMinWidth : 800,
			        windowMinHeight : 300,
			        windowWidth : 800,
			        windowHeight : 500,
			        parentPanel : ".currDesktop"
			    });
			});
		  //add group
		 $("#addGrBtn").click(function(){
					 parent.elsDeskTop.defineWin({
				        iconSrc : "icon/icon9.png",
				        windowsId : "addGroup",
				        windowTitle : "<i18n:I18n defaultValue='添加条例组' key=''/>",
				        iframSrc : "${pageContext.request.contextPath}/regulation/group/addGroupList.jsp?pid=editTemplate",
				        showAdv : true,
				        windowMinWidth : 750,
				        windowMinHeight : 500,
				        windowWidth : 750,
				        windowHeight : 500,
				        parentPanel: ".currDesktop"
				    });
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
			var wbool = false;
			var isZero = false;
			var weights = 0;
			$("input[name='templateList[][weight]']").each(function(){
				var value = $(this).val();
				if(value!=""){
					weights = weights+parseFloat(value);
				}else{
					wbool = true;	
				}
// 				if(parseInt(value)==0){
// 					isZero = true;
// 				}
			});
// 			if(isZero){
// 				 alert('<i18n:I18n key="" defaultValue="权重之必须大于0!" />',2);
// 				 return;
// 			}
				debugger;
			if(!(weights<=100&&weights>parseFloat(99.99))||wbool){
				alert("权重之和必须为100!权重目前="+weights,2);
// 				 alert('<i18n:I18n key="" defaultValue="权重之和必须为100!权重="/>'+'$("#weights").val()',2);
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
		 	  var cache={};
		 	  for(var i=head.length-1;i>-1;i--){
		 		  var id = head[i].regulationNumber;
		 		  if(cache[id]){
		 			  head.splice(i,1);
		 		  }else{
		 			  cache[id]=regulationNumber;
		 		  }
		 	  }
		 	  
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
		//替换评分账号
			$("#replaceBtn").click(function(){
				    var itemTableRows = itemTable.rows();
				    var begin = $("#scoreAccountBegin").val();
				    var end = $("#scoreAccountEnd").val();
				    if(end==null || end ==""){
			       	 		alert('评分账号帐号不能为空!',2);
			       	 		return;
			    		}
			        //判断评分账号格式
			        	if(end.length!=4){
			        		alert("评分账号格式不正确",2);
			        		return;
			        	}
				    for(var i = 0 ; i < itemTableRows.length ; i ++ ){
						var item = itemTableRows[i];
						var fbk10End = $('#scoreAccount_'+i).val();
						if(fbk10End==null||fbk10End=='')
							fbk10End = item.fbk10;
						$('#scoreAccount_'+i).val(fbk10End.replace(begin,end));
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
		 	itemTable.removeRow(seletectIndexArr);
		});
	 
	 //查询
	 $("#queryBtn").click(function(e){
		 queryRegulation();
	 });
	 
	 function queryRegulation(){
		 var name = $("#name").val();
		 var createUser = $("#createUser").val();
		 var typeName = $("#regulationTypeName").val();
		 headTable.opts.params = {elsAccount:elsAccount,regulationName:name,regulationTypeName:typeName,createUser:createUser};
		 headTable.load({page:1});
	 }
	 
	 
	 
	 function closeWin(){
		parent.frames['iframeApp_regulationTemplate'].headTable.load();
        parent.elsDeskTop.closeCurWin('editTemplate');
	 }
	 
	 //条例组表
	 var group_cols = [
	    	        	{ title:'条例编号', name:'regulationNumber', width: 100, align: 'center'},
	 	   	        	{ title:'条例名称', name:'regulationName' ,width:200, align:'center' },
	 	   	        	{ title:'条例类型', name:'regulationTypeName' ,width:200, align:'center' },
	 	   	        	{ title:'输入类型', name:'inputType' ,width:200, align:'center' , renderer:initInputType},
	    	            { title:'<i18n:I18n key="" defaultValue="条例组编号" />', name:'regulationGroupNumber', width: 200, align: 'center'},
	    	        	{ title:'<i18n:I18n key="" defaultValue="条例组名称" />', name:'regulationGroupName' ,width:200, align:'center' },
	 		        	{ title:'是否需要附件', name:'uploadFileFlag' ,width:100, align:'center', renderer:initUploadType},
	 		        	{ title:'条例明细', name:'regulationDetail' ,width:250, align:'center'  },
	 		        	{ title:'关联选项', name:'selectId' ,width:100, align:'center',renderer: selectRelation },
	 	   	        	{ title:'创建人', name:'createUser' ,width:150, align:'center' },
	 	   	        	{ title:'创建日期', name:'createDate' ,width:150, align:'center', renderer:formatDate},
	     	        	];
	   	   	   

	   	     	 var GobalparamStr={"elsAccount":elsAccount};
	   	     	 var height=$(document).height()-155;
	   	     	 headTable= $('#headTable').mmGrid({
	   	     	    	 		cols: group_cols,
	   	     	         		url: '<%=basePath%>rest/RegulationService/getRegulationOrGroup',
	   	     					params : GobalparamStr,
	   	     					method : 'post',
	   	     					root : "rows",
	   	     					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	   	     			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	   	     			        multiSelect : true,
	   	     			        checkCol : true,
	   	     			        indexCol : false,
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
	   	     	 	
	   	     
	   	 
	     	  
	//===========================================表体===========================================
	  var cols_item = [
   	   	            { title:'条例编号', name:'regulationNumber', width: 200, align: 'center',renderer:initInputHidden},
   	   	        	{ title:'条例名称', name:'regulationName' ,width:200, align:'center',renderer:initInputHidden},
   	   	        	{ title:'参与对象', name:'participants' ,width:200, align:'center' ,renderer:initParticipants},
   	   	        	{ title:'评分类型', name:'scoreType' ,width:200, align:'center' ,renderer:initScoreType},
   	   	        	{ title:'评分账户', name:'scoreAccount' ,width:200, align:'center' ,renderer:initScoreAccount},
   	   	        	{ title:'评分标准说明', name:'scoreStandard' ,width:200, align:'center',renderer:initInputText},
   	   	        	{ title:'权重', name:'weight' ,width:200, align:'center' ,renderer:initInputNumber},
	   	       ];
	
		 if(number!=""){
	     	 var itemParam = {"elsAccount":elsAccount,"templateNumber":number};
			 itemTable = $('#itemTable').mmGrid({
			        cols: cols_item,
			        height: 300,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        checkCol: true,
			        multiSelect: true,
			        url : '<%=basePath%>rest/RegulationService/getTemplateByNumber' + "?t="+new Date().getTime(),
					params : itemParam,
					method : 'post',
					root : "rows",
					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        indexCol : false,
					plugins : [ 
					           $('#itemPage').mmPaginator({
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
			 itemTable.on('cellSelected',function(e, item, rowIndex, colIndex){
					var _this=$(e.target);
					if(_this.hasClass("scoreAccount")) {
						showAccount('#itemTable',rowIndex,colIndex);
					} 
				});
			 
		 }
		 
		
			
</script>
</body>
</html>