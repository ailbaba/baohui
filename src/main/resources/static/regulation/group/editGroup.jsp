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
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="输入条例组基本信息" /></span>
			<div class="common-box-line">
				<form id="iForm">
		   	 	<input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsAccount") %>" >
    			<input type="hidden" id="elsDesc" name="elsDesc" value="<%=session.getAttribute("companyShortName") %>">
		   	 	<input type="hidden" id="regulationGroupNumber" name="regulationGroupNumber"/>
		   	 	<input type="hidden" id="typeNumber" name="typeNumber"/>
		   	 	<input type="hidden" id="regulationNumber" name="regulationNumber"/>
		   	 	<input type="hidden" id="typeName" name="typeName" />
				<div class="dis-in-b input-and-tip">
					<span>编号:</span>
					<input type="text" id="regulationGroupNumber1" name="regulationGroupNumber"   disabled="disabled"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span>名称:</span>
					<input type="text" id="regulationGroupName" name="regulationGroupName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span>类型:</span>
					<select id="regulationGroupTypeTemp" name="regulationGroupTypeTemp" ></select>
				</div>
				<div class="dis-in-b input-and-tip">
					<span>描述:</span>
					<input type="text" id="regulationGroupDesc" name="regulationGroupDesc" />
				</div>
				<button  id="addGroup" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				</form>
			</div>
		</div>
		
		<form id="queryForm" onsubmit="return false;">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>条例编号:</span>
					<input type="text" id="regulationNumberTemp" name="regulationNumberTemp"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span>条例名称:</span>
					<input type="text" id="regulationName" name="regulationName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span>条例类型:</span>
					<select id="regulationType" name="regulationType" ></select>
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />:</span>
					<input type="text" id="createUser" name="createUser" />
				</div>
				<button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			</div>
		</div>
		
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="条例列表" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="addBtn"><i18n:I18n key="" defaultValue="添加到条例组"/></button>
				<button class="button-wrap" id="addReBtn"><i18n:I18n key="test" defaultValue="新增条例" /></button>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="添加到组列表" /></span>
            <div class="common-box-line">
	            <button class="button-wrap" id="delBtn"><i18n:I18n key="test" defaultValue="从条例组删除" /></button>
                <div class="tab-wrap" id="sheet-project">
                    <div id="sheet-project-one">
                         <main class="grid-container nest-table">
		                    <div class="grid-100" id="reCreate">
		                        <table id="itemTable"></table>
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
	 var itemTable;
	 var type="";
	 var roleCode="";
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	 var rowIndexSelect=0;
	 var excelUploader;
	 var number =GetQueryString("regulationGroupNumber");
	 var tNumber = GetQueryString("typeNumber");
	 
	 $(document).ready(function(){
		 var name =GetQueryString("regulationGroupName");
		 var desc =GetQueryString("regulationGroupDesc");
		 var cy =GetQueryString("cy");
		 var regulationNumber = GetQueryString("regulationNumber");
		 initRegulationGroupType();
		 initRegulationType();
		 if(number!=""&&cy!="1"){
			 $("#regulationGroupNumber").val(number);
			 $("#regulationGroupNumber1").val(number);
		 }
		 if(name!=""){
			 $("#regulationGroupName").val(decodeURI(name));
		 }
		 if(desc!=""){
			 $("#regulationGroupDesc").val(decodeURI(desc));
		 }
		  $("#regulationNumber").val(regulationNumber);
	 });
	
	 	var initRegulationType = function(){
	 		$.ajax({
				url : '<%=basePath%>rest/RegulationService/getRegulationTypeByNumber',
				type : "POST",
				contentType : "application/json",
				data :JSON.stringify(param) ,
				dataType : "json",
				success : function(data) {
					if(data!=-100){
			           var html = "<option value=''>请选择</option>";  
						$.each(data,function(n,type) {  
							 html += '<option value="' + type.typeNumber + '">' + type.typeName + '</option>';
			           }); 
					   $("#regulationType").html(html);
					}
				},
				error : function(data) {
					if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});  
	 	}
	 	var initRegulationGroupType = function(){
	 		 var param = {elsAccount:elsAccount,regulationType:1};
			 $.ajax({
					url : '<%=basePath%>rest/RegulationService/getRegulationTypeByNumber',
					type : "POST",
					contentType : "application/json",
					data :JSON.stringify(param) ,
					dataType : "json",
					success : function(data) {
						if(data!=-100){
							var html = "<option value=''>请选择</option>";
							$.each(data,function(n,type) {  
								 html += '<option value="' + type.typeNumber + '">' + type.typeName + '</option>';
				           }); 
						   $("#regulationGroupTypeTemp").html(html);
						   if(tNumber!=""){
								 $("#regulationGroupTypeTemp").val(tNumber);
							 }
						}
					},
					error : function(data) {
						if (!permissionError(data)) {
		 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						}
					}
				});
	 	}
	 	var initRegulationType = function(){
	 		var param = {elsAccount:elsAccount,regulationType:0};
	 		$.ajax({
				url : '<%=basePath%>rest/RegulationService/getRegulationTypeByNumber',
				type : "POST",
				contentType : "application/json",
				data :JSON.stringify(param) ,
				dataType : "json",
				success : function(data) {
					if(data!=-100){
			           var html = "<option value=''>请选择</option>";  
						$.each(data,function(n,type) {  
							 html += '<option value="' + type.typeNumber + '">' + type.typeName + '</option>';
			           }); 
					   $("#regulationType").html(html);
					}
				},
				error : function(data) {
		            alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});  
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
		//允许任何字符输入框 只读
		var initInputAny2 = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" readonly="readonly" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
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
		        iframSrc : "${pageContext.request.contextPath}/regulation/regulationSelect.jsp?pid=editGroup&regulationNumber=" + headRows.regulationNumber,
		        showAdv : true,
		        windowMinWidth : 800,
		        windowMinHeight : 600,
		        windowWidth : 800,
		        windowHeight : 600,
		        parentPanel : ".currDesktop"
		    });
		 });
		 //add regulation
		 $("#addReBtn").click(function(e){
			 	e.stopPropagation();
			  	e.preventDefault();
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "RegulationAdd",
			        windowTitle : "<i18n:I18n defaultValue='新建条例' key='test'/>",
			        iframSrc : "${pageContext.request.contextPath}/regulation/addRegulation.jsp?pid=editGroup",
			        showAdv : true,
			        windowMinWidth : 800,
			        windowMinHeight : 300,
			        windowWidth : 800,
			        windowHeight : 500,
			        parentPanel : ".currDesktop"
			    });
			});
	  //update
	 $("#addGroup").click(function(e){
		    e.stopPropagation();
		    e.preventDefault();
		    var typeName = $("#regulationGroupName").val();
			if (typeName.length == 0) {
				 alert('<i18n:I18n key="" defaultValue="请输入条例组名称" />',2);
				 $("#regulationGroupName").focus();
				 return;
			}
			$("#typeNumber").val($("#regulationGroupTypeTemp").val());
			$("#typeName").val($("#regulationGroupTypeTemp").find("option:selected").text());
			var typeNumber = $("#regulationGroupTypeTemp").val();
			if (typeNumber.length == 0) {
				 alert('<i18n:I18n key="" defaultValue="请选择类型" />',2);
				 $("#regulationGroupTypeTemp").focus();
				 return;
			}
			var frm = $("#iForm").serializeJSON();
			var item = itemTable.rows();
		 	if(typeof(item[0])!="undefined"){
				frm["regulationList"]=item;
		 	}
			var frmData = JSON.stringify(frm);
			  $.ajax({
				url : '<%=basePath%>rest/RegulationService/saveRegulationGroup',
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
						 }, "2000");  
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
			itemTable.removeRow(seletectIndexArr);
		});
	 
	 //查询
	 $("#queryBtn").click(function(e){
		 e.stopPropagation();
		 e.preventDefault();
		 queryRegulation();
	 });
	 
	 function queryRegulation(){
		 var name = $("#regulationName").val();
		 var regulationNumber = $("#regulationNumberTemp").val();
		 var createUser = $("#createUser").val();
		 var typeName = $("#regulationType").val();
		 headTable.opts.params = {elsAccount:elsAccount,regulationName:name,regulationNumber:regulationNumber,regulationType:typeName,createUser:createUser};
		 headTable.load({page:1});
	 }
	 
	 function closeWin(){
		parent.frames['iframeApp_regulationGroup'].headTable.load();
        parent.elsDeskTop.closeCurWin('editGroup');
	 }

  
	 var colst_head = [
	   	            { title:'条例编号', name:'regulationNumber', width: 100, align: 'center'},
	   	        	{ title:'条例名称', name:'regulationName' ,width:200, align:'center' },
	   	        	{ title:'条例类型', name:'regulationTypeName' ,width:200, align:'center' },
	   	        	{ title:'输入类型', name:'inputType' ,width:100, align:'center' , renderer:initInputType},
		        	{ title:'是否需要附件', name:'uploadFileFlag' ,width:100, align:'center', renderer:initUploadType},
		        	{ title:'关联选项', name:'selectId' ,width:100, align:'center',renderer: selectRelation },
		        	{ title:'条例明细', name:'regulationDetail' ,width:250, align:'center'  },
	   	        	{ title:'创建人', name:'createUser' ,width:150, align:'center' },
	   	        	{ title:'创建日期', name:'createDate' ,width:150, align:'center', renderer:formatDate},
	   	       ];
	   	   

	     	  var GobalparamStr={"elsAccount":elsAccount};
	     	  var height=$(document).height()-155;
	     	  headTable= $('#headTable').mmGrid({
	     	    	 		cols: colst_head,
	     	         		url: '<%=basePath%>rest/RegulationService/getRegulationList',
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
	   	            { title:'条例编号', name:'regulationNumber', width: 100, align: 'center'},
	   	        	{ title:'条例名称', name:'regulationName' ,width:200, align:'center' },
	   	        	{ title:'条例类型', name:'regulationTypeName' ,width:200, align:'center' },
		   	     	{ title:'输入类型', name:'inputType' ,width:200, align:'center' , renderer:initInputType},
		        	{ title:'是否需要附件', name:'uploadFileFlag' ,width:100, align:'center', renderer:initUploadType},
		        	{ title:'关联选项', name:'selectId' ,width:100, align:'center',renderer: selectRelation },
		        	{ title:'条例明细', name:'regulationDetail' ,width:250, align:'center'  },
	   	        	{ title:'创建人', name:'createUser' ,width:150, align:'center' },
	   	        	{ title:'创建日期', name:'createDate' ,width:150, align:'center', renderer:formatDate},
	   	       ];
		 if(number!=""){
	     	 var itemParam = {"elsAccount":elsAccount,"regulationGroupNumber":number};
			 itemTable = $('#itemTable').mmGrid({
			        cols: cols_item,
			        height: 300,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        checkCol: true,
			        multiSelect: true,
			        url : '<%=basePath%>rest/RegulationService/getRegulationByGroupNumber' + "?t="+new Date().getTime(),
					params : itemParam,
					method : 'post',
					root : "rows",
					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        indexCol : false,
			});
		 }
		
			
</script>
</body>
</html>