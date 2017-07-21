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
			<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加"/></button>
                <button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
                <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
                <button class="button-wrap" id="createTypeBtn"><i18n:I18n key="" defaultValue="创建类型" /></button>
			</div>
		</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="条例组列表" /></span>
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
		</form>
	</div>

	<script>
	 var headTable;
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	 var pid = GetQueryString("pid");
		//只允许数字输入框
		var initInputNumber = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
		};
		//允许任何字符输入框
		var initInputAny = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" name="groupList[]['+this.name+']" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		
		//type
		var initType = function(val, item, index){
			if(!val) { val = '';}
			 var select= '<select onchange="$(typeName_'+index+').val(this.selectedOptions[0].textContent)" id="'+this.name+'_'+index+'" name="groupList[]['+this.name+']">';
			 var param = {elsAccount:elsAccount,regulationType:1};
			 $.ajax({
					url : '<%=basePath%>rest/RegulationService/getRegulationTypeByNumber',
					type : "POST",
					async:false,
					contentType : "application/json",
					data :JSON.stringify(param) ,
					dataType : "json",
					success : function(data) {
						if(data!=-100){
				            select+= "<option value=''>请选择</option>";  
							$.each(data,function(n,type) {  
								 select += '<option value="' + type.typeNumber + '">' + type.typeName + '</option>';
				           }); 
						}
					},
					error : function(data) {
						if (!permissionError(data)) {
		 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						}
					}
				});  
			 select+="</select>";
			 
			return select;
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
		
	  $("#addBtn").click(function(e){
			 var addGroupCols={elsAccount:elsAccount,elsDesc:companyName,regulationGroupName:"",regulationGroupDesc:"",typeName:""};
			 headTable.addRows([addGroupCols]);
	  });
	  //新增
	 $("#saveBtn").click(function(e){
			var form =$("#iForm").serializeJSON();;
			var head = form.groupList;
			for(var i=0;i<head.length;i++){
				var num = i+1;
				if(head[i].regulationGroupName==""){
				 	alert('<i18n:I18n key="" defaultValue="请输入第['+num+']行条例组名称" />',2);
					return;
				}
				if(head[i].typeNumber==""){
				 	alert('<i18n:I18n key="" defaultValue="请选择第['+num+']行类型" />',2);
					return;
				}
				
			}
			var frmData = JSON.stringify(head);
			  $.ajax({
				url : '<%=basePath%>rest/RegulationService/saveGroupList',
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
	 
	 
		//删除
		$("#delBtn").click(function(e){
			var seletectIndexArr=headTable.selectedRowsIndex();
			if(seletectIndexArr.length<=0){
				alert("请选择要删除的行!",2);
				return;
			}
		 //	for(var i=seletectIndexArr.length;i<-1;i--){
		 		headTable.removeRow(seletectIndexArr);
	 		//}
		});
	 	
		  //新增
		 $("#createTypeBtn").click(function(){
			 parent.elsDeskTop.defineWin({
					'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
			        'windowsId':'addType',
			        'windowTitle':"<i18n:I18n defaultValue='添加' key='i18n_common_button_addition'/>",
			        'iframSrc':"${pageContext.request.contextPath}/regulation/type/addType.jsp?pid=addGroup",
			        windowStatus: 'regular',
			        windowMinWidth: 400,
			        windowMinHeight: 340,
			        'windowWidth':400,
			        'windowHeight':340,
			        windowPositionTop:100,
			        'parentPanel':".currDesktop"
			    });
			});
	 
	 function closeWin(){
		 parent.frames['iframeApp_'+pid].queryRegulation();
        parent.elsDeskTop.closeCurWin('addGroup');
	 }

  
	 var colst_head = [
	   	           // { title:'<i18n:I18n key="" defaultValue="编号" />', name:'regulationGroupNumber', width: 200, align: 'center'},
	   	        	{ title:'<i18n:I18n key="" defaultValue="ELS帐号" />', name:'elsAccount' ,width:200,hidden:true, align:'center', renderer:initInputAny},
	   	        	{ title:'<i18n:I18n key="" defaultValue="公司名称" />', name:'elsDesc' ,width:200, hidden:true,align:'center', renderer:initInputAny},
	   	        	{ title:'<i18n:I18n key="" defaultValue="名称" />', name:'regulationGroupName' ,width:200, align:'center', renderer:initInputAny},
	   	        	{ title:'<i18n:I18n key="" defaultValue="类型" />', name:'typeNumber' ,width:200, align:'center',renderer:initType },
	   	        	{ title:'<i18n:I18n key="" defaultValue="类型名称" />', name:'typeName' ,width:200,hidden:true, align:'center',renderer:initInputAny },
	   	        	{ title:'<i18n:I18n key="" defaultValue="描述" />', name:'regulationGroupDesc' ,width:200, align:'center' ,renderer:initInputAny},
	   	        	//{ title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:150, align:'center' },
	   	        	//{ title:'<i18n:I18n key="i18n_fileManage_title_createDate" defaultValue="创建日期" />', name:'createDate' ,width:150, align:'center', renderer:formatDateTime},
	   	        	//{ title:'<i18n:I18n key="i18n_common_title_remarks" defaultValue="备注" />', name:'remark' ,width:200, align:'center'}
	   	        	];
	 if(!headTable){
		 headTable=$('#headTable').mmGrid({
		        cols: colst_head,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol:true,
		        multiSelect:true,
		        items: []
		    });
	 }
	     	 
	
	
		 
		
			
</script>
</body>
</html>