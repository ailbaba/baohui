<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style>
.edit-sub-title {
	display: inline-block;
	width: 130px;
	padding-left: 20px;
	padding-top: 3px;
	text-align: right;
}
</style>
<body>
	<form id="regulationForm" action="" method="post"
		onsubmit="return false">
		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n
					key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</span> <input
				readonly class="" type="text" id="elsAccount" name="elsAccount" />
		</div>

		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="test"
					defaultValue="条例名称" />：</span> <input class="" type="text"
				id=regulationName name="regulationName" />
		</div>
		<input type="hidden" id="regulationType" name="regulationType" /> <input
			type="hidden" id="regulationTypeName" name="regulationTypeName" />
		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="test"
					defaultValue="条例类型" />:</span> <select id="regulationGroupTypeTemp"
				name="regulationGroupTypeTemp"></select>
			<button id="addRegulationType" class="button-wrap">
				<i18n:I18n key="test" defaultValue="创建条例类型" />
			</button>
		</div>

		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="test"
					defaultValue="条例明细 " />:</span>
			<textarea id="regulationDetail" name="regulationDetail" rows="5"
				cols="300"></textarea>
		</div>


		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="test"
					defaultValue="是否需要附件" />：</span> <select class="" id="uploadFileFlag"
				name="uploadFileFlag">
				<option value="1"><i18n:I18n key="test" defaultValue="需要" /></option>
				<option value="2"><i18n:I18n key="test" defaultValue="不需要" /></option>
			</select>
			&nbsp;&nbsp;
			<button class="button-wrap" id="uploadFile"><i18n:I18n key="test" defaultValue="上传模板" /></button>
			<input readonly  class="" type="text" id="fbk2"  name = "fbk2"  style="width: 180px; max-width: 180px;" />
			
			<%-- 			<button id="revenueEnrolFilebtn" class="button-wrap"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button> --%>
		</div>
       <input readonly  class="" type="hidden" id="fbk3" name="fbk3" style="width: 130px; max-width: 180px;"/>
        <!-- 添加文件弹出框 -->
<div class="fixed-dialog" id="addFileDialog">
           <div class="dialog-tip bg-common" style="width: 362px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <div class="input-and-tip"><span><i18n:I18n key="i18n_common_label_filename" defaultValue="文件名称" />：</span><input id="fileName" style="max-width: 248px; width: 248px;" name="fileName" type="text" /></div>
	                       <div class="input-and-tip"><span><i18n:I18n key="i18n_common_label_filepath" defaultValue="文件路径" />：</span><input id="filePath" style="max-width: 248px; width: 248px;" name="filePath" type="text" /></div>
	                       <div class="input-and-tip text-right">
		                       <span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /></div></span>
		                       <input id="fileType" name="fileType" type="hidden" />
	                       </div>
	                       <div class="mt-20 text-center">
	                          <button id="addFileBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                      <button id="addFileBtnCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>
		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="test"
					defaultValue="输入类型" />：</span> <select class="" id="inputType"
				name="inputType">
				<option value="1"><i18n:I18n key="test" defaultValue="手工输入" /></option>
				<option value="2"><i18n:I18n key="test" defaultValue="单选" /></option>
				<option value="3"><i18n:I18n key="test" defaultValue="多选" /></option>
				<option value="4"><i18n:I18n key="test" defaultValue="数据导入" /></option>
				<option value="5"><i18n:I18n key="test" defaultValue="后台获取" /></option>
			</select>
			<button id="RegulationSelection" class="button-wrap">
				<i18n:I18n key="test" defaultValue="选项编辑" />
			</button>
		</div>
		
		<div class="grid-100" id="selectTable">
			<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common">条例选项</span>
				<div class="common-box-line">
					<button class="button-wrap" id="addBtn">
						<i18n:I18n key="test" defaultValue="新增选项" />
					</button>
					<button class="button-wrap" id="delBtn">
						<i18n:I18n key="test" defaultValue="删除选项" />
					</button>
					<div class="tab-wrap" id="sheet-head">
						<div id="sheet-item-one">
							<main class="grid-container">
							<div class="grid-80">
								<table id="headTable"></table>
								<div id="enquiryPage" style="text-align: right;"></div>
							</div>
							</main>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 	<div class="input-and-tip text-left ">
		       <input hidden = "true"  class="" type="button"  id = "select"  name="" />
		</div> -->

		

	</form>
	<div style="text-align: center; padding: 5px">
		<button id="addRegulation" class="button-wrap">
			<i18n:I18n key="i18n_common_button_ok" defaultValue="确定" />
		</button>
		<button id="closeWin" class="button-wrap">
			<i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " />
		</button>
	</div>

	<script type="text/javascript">
	elsAccount='<%=session.getAttribute("elsAccount")%>';
	var itemTable;
	var selectionValue = [];
	var pid = GetQueryString("pid");

		
	////////渲染////////////////
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	
	////////////////渲染//////////////////////////////////////////////
	
	
	$(function() {
		$("#elsAccount").val(elsAccount);
		$("#RegulationSelection").hide();
		$("#selectTable").hide();
		initType();
	});
	
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="selections[]['+this.name+']" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	
	//只允许数字输入框
	var initInputABC = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^a-zA-Z]/g,\'\')" placeholder="请输入英文字母" maxlength="1" name="selections[]['+this.name+']" value="'+val+'"/>';
	};
	
	 $("#addBtn").click(function(e){
		 var cols={elsAccount:elsAccount,regulationSelectName:"",regulationSelectValue:"",fbk1:""};
		 headTable.addRows([cols]);
 	 });

	//删除
	$("#delBtn").click(function(e){
		var seletectIndexArr=headTable.selectedRowsIndex();
		if(seletectIndexArr.length<=0){
			alert("请选择要删除的行!",2);
			return;
		}
	 	headTable.removeRow(seletectIndexArr);
	});
	
	var fileUploader;
	$("#uploadFile").click(function(){
		$("#addFileDialog").show();
     	initFileUploader(fileUploader);
	});
	 function initFileUploader(fileUploader){
	   	    //新增表单文件
	   	    if (!fileUploader) {
	   	  	fileUploader = WebUploader.create({
	   	  	    // swf文件路径
	   	  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
	   	  	    auto: true,
	   	  	    // 文件接收服务端。
	   	  	    server: '<%=basePath%>servlet/UploadServlet',
	   	  	    // 选择文件的按钮。可选。
	   	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	   	  	    pick: '#btnFileUpload',
	   	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	   	  	    resize: false,
	   	  	    formData : {
	   		     	elsAccount : elsAccount
	   		     }
	   	  	});
	   	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
	   	  		if(!response.error) {
	   	  			var filePath = response.url;
	   	    	  	   var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
	   	    	       $("#filePath").val(filePath);
	   	  		} else {
	   	  			alert(response.message,3);
	   	  		}
	   	  		
	   	  	   
	   	  	});
	   	 // 当有文件添加进来的时候
	   		fileUploader.on("fileQueued",function(file){
	   			var fileName = file.name;
	   			$("#fileName").val(fileName);
	   			$("#fileType").val(file.ext);
	   			$("#fbk2").val(fileName);
	   			$('body').data("selectedFile",true);
	   		});
	   	    }
	   	}
		   
		   //添加文件弹出框取消按钮
		     $("#addFileBtnCancel").click(function(){
		     	$("#addFileDialog").hide();
		     	clearAddFileInfo();
		     });
		     //关闭按钮处理
		     $("#dialogFileClose").click(function(){
		     	$("#addFileDialog").hide();
		     	clearAddFileInfo();
		     });
		     //clear
		     function clearAddFileInfo(){
		     	$("#fileName").val("");
		     	$("#filePath").val("");
		     }

		     $("#closeWin").click(function(){
		    	 parent.elsDeskTop.closeCurWin('regulationInfo');
		     });
		     
		     //添加文件窗口确认按钮
		     $("#addFileBtnOK").click(function(){
		    	 var flag = $('body').data("selectedFile");
		    	 if(!flag){
		    		 alert("请选择文件！",2);
		    		 return;
		    	 }
		    	$('body').data("selectedFile",false);
		     	$("#addFileDialog").hide();
		     	var filePath = $("#filePath").val();
				$("#fbk3").val(filePath);
		     	clearAddFileInfo();
		     });
		     
 
	function initType(){
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
					   $("#regulationGroupTypeTemp").html(html);
					}
				},
				error : function(data) {
					if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});  
	}
	$("#RegulationSelection").click(function(){
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "RegulationSelection",
	        windowTitle : "<i18n:I18n defaultValue='新建条例选项' key='test'/>",
	        iframSrc : "${pageContext.request.contextPath}/regulation/regulationSelect.jsp",
	        showAdv : true,
	        windowMinWidth : 500,
	        windowMinHeight : 600,
	        windowWidth : 500,
	        windowHeight : 600,
	        parentPanel : ".currDesktop"
	    });
	});
	$("#addRegulation").click(function(){
		debugger;
		var regulationName = $("#regulationName").val();
		var regulationDetail = $("#regulationDetail").val();
		$("#regulationType").val($("#regulationGroupTypeTemp").val());
		$("#regulationTypeName").val($("#regulationGroupTypeTemp").find("option:selected").text());
		 if(regulationName==null || regulationName.length==0){
			 alert('<i18n:I18n key="test" defaultValue="请输入条例名称" />',2);
			 $("#regulationName").focus();
			 return;
		 }
		 var typeNumber = $("#regulationGroupTypeTemp").val();
		 if (typeNumber.length == 0) {
			 alert('<i18n:I18n key="" defaultValue="请选择类型" />',2);
			 $("#regulationGroupTypeTemp").focus();
			 return;
		 }
		 if(regulationDetail==null || regulationDetail.length==0){
			 alert('<i18n:I18n key="test" defaultValue="请输入条例明细" />',2);
			 $("#regulationDetail").focus();
			 return;
		 }
		 var type =$("#inputType").val();
		 if(type!="1"){
			 var bool = false;
			 $("input[name='selections[][regulationSelectName]']").each(function(){
					var value = $(this).val();
					if(value==""){
						bool = true;
						return;
					}
				});
			 if(bool){
				 alert('<i18n:I18n key="" defaultValue="请输入选项名称!" />',2);
				 $("#headTable").focus();
				 return;
			 }
			 var isNull = false;
			 var isSame = false;
			 var arr = $("input[name='selections[][regulationSelectValue]']");
			 var hash = {};
			 for(var i=0;i<arr.length;i++) {
				 var value = arr[i].value.toUpperCase();
		         if(hash[value]){
		        	 isSame = true;
		              break;  
		         }
		         hash[value] = true;  
		     }   
			 if(isSame){
				 alert('<i18n:I18n key="" defaultValue="选项值不能相同!" />',2);
				 $("#headTable").focus();
				 return;
			 }
			 if(isNull){
				 alert('<i18n:I18n key="" defaultValue="选项值不能为空!" />',2);
				 $("#headTable").focus();
				 return;
			 }
		 }
		 var frm = $("#regulationForm");
		 var jsonObj = frm.serializeJSON();
		 $.ajax({
				url :"../rest/RegulationService/insertRegulation",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(jsonObj),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="test" defaultValue="新增成功:" />',1);
					setTimeout(function(){				     
						closeWin();
					 }, "2000"); 
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});
	});

	$("#closeWin").click(function(){
		parent.frames['iframeApp_'+pid].queryRegulation();
		closeWin();
	});
	
	function closeWin(){
		parent.frames['iframeApp_'+pid].queryRegulation();
        parent.elsDeskTop.closeCurWin('RegulationAdd');
	}
	
	//输入类型切换之后
	$("#inputType").change(function(){
		var type =$("#inputType").val();
		if(type=="2" || type=="3"){
			$("#selectTable").show();
			initTable();
		}else{
			$("#selectTable").hide();
		}
	});
	function initTable(){
	 var head = headTable.rows();
	 if(typeof(head[0])=="undefined"){
		 var arr = ["A","B","C","D","E"];
		 for(var i=0;i<5;i++){
			 var cols={elsAccount:elsAccount,regulationSelectName:arr[i],regulationSelectValue:arr[i],fbk1:""};
			 headTable.addRows([cols]);
		 }
	 }
	}
	/*  //加载选项框选项
	 function showSelectionTable(){
		 
			 itemTable = $('#itemTable').mmGrid({
			        cols:cols_item ,
			        height: 100,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        items:initData
			    });
	 } */
	 
	 //获取选项的值信息 
	 function getSelectionValue(){
		 if(itemTable){
			 //获取选项框的值 
			 var select1 = $("#selection1_0").val();
			 var select2 = $("#selection2_0").val();
			 var select3 = $("#selection3_0").val();
			 var select4 = $("#selection4_0").val();
			 var select5 = $("#selection5_0").val();
			 var select6 = $("#selection6_0").val(); 
			 selectionValue = [{"regulationSelectName":$("#selection1_0").val()},{"regulationSelectName":$("#selection2_0").val()},
			 {"regulationSelectName":$("#selection3_0").val()},{"regulationSelectName":$("#selection4_0").val()},
			 {"regulationSelectName":$("#selection5_0").val()},{"regulationSelectName":$("#selection6_0").val()}]
		 }
	 }
	 
	 // 新建类型
	 $("#addRegulationType").click(function(){
		 parent.elsDeskTop.defineWin({
				'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
		        'windowsId':'addType',
		        'windowTitle':"<i18n:I18n defaultValue='添加' key='i18n_common_button_addition'/>",
		        'iframSrc':"${pageContext.request.contextPath}/regulation/type/addType.jsp?pid=RegulationAdd",
		        windowStatus: 'regular',
		        windowMinWidth: 400,
		        windowMinHeight: 340,
		        'windowWidth':400,
		        'windowHeight':340,
		        windowPositionTop:100,
		        'parentPanel':".currDesktop"
		    });
	});
		
	var colst_head = [
	            	{ title:'els帐号', name:'elsAccount' ,width:200, hidden:true,align:'center',renderer:initInputAny},
	            	{ title:'名称', name:'regulationSelectName' ,width:200, align:'center' ,renderer:initInputAny},
	            	{ title:'选项值', name:'regulationSelectValue' ,width:200, align:'center',renderer:initInputABC},
	            	{ title:'备注', name:'fbk1' ,width:200, align:'center' ,renderer:initInputAny},
	           ];
	
	headTable= $('#headTable').mmGrid({
	   	 		cols: colst_head,
	   	 		loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        checkCol:true,
			        multiSelect:true,
			        items: []
			});
	
</script>

</body>
</html>