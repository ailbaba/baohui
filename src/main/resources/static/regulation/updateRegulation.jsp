<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String regulationNumber = request.getParameter("regulationNumber"); %>
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
	<form id="regulationForm" onsubmit="return false;" action=""
		method="post">

		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="test"
					defaultValue="条例名称" />：</span> <input class="" type="hidden"
				id="elsAccount" name="elsAccount" /> <input class="" type="text"
				id=regulationName name="regulationName" /> <input type="hidden"
				type="text" id="regulationNumber" name="regulationNumber" />
		</div>
		<input type="hidden" id="regulationType" name="regulationType" /> <input
			type="hidden" id="regulationTypeName" name="regulationTypeName" />
		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="test"
					defaultValue="条例类型" />:</span> <select id="regulationGroupTypeTemp"
				name="regulationGroupTypeTemp"></select>
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
			</select> &nbsp; <input readonly class="" type="text" id="fbk2" name="fbk2"
				style="width: 180px; max-width: 180px;" />
			<button class="button-wrap" id="uploadFile">
				<i18n:I18n key="test" defaultValue="上传模板" />

				<button class="button-wrap" id="downFile">
					<i18n:I18n key="test" defaultValue="下载模板" />
		</div>

		<input readonly class="" type="hidden" id="fbk3" name="fbk3"
			style="width: 130px; max-width: 180px;" />
		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="test"
					defaultValue="输入类型" />：</span> <select class="" id="inputType"
				name="inputType">
				<option value="1"><i18n:I18n key="test" defaultValue="手工输入" /></option>
				<option value="2"><i18n:I18n key="test" defaultValue="单选" /></option>
				<option value="3"><i18n:I18n key="test" defaultValue="多选" /></option>
				<option value="4"><i18n:I18n key="test" defaultValue="数据导入" /></option>
			</select>
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


		<div style="text-align: center; padding: 5px">
			<button id="updRegulation" class="button-wrap">
				<i18n:I18n key="i18n_common_button_ok" defaultValue="确定" />
			</button>
			<button id="closeWin" class="button-wrap">
				<i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " />
			</button>
		</div>
	</form>
	<!-- 添加文件弹出框 -->
	<div class="fixed-dialog" id="addFileDialog">
		<div class="dialog-tip bg-common"
			style="width: 362px; height: auto; margin-left: -131px; margin-top: -190px;">
			<div class="dialog-close-btn" id="dialogFileClose"></div>
			<div class="tip-head">
				<img class="icon" src="../../icon/els.PNG" /> <span
					class="dialogTitle"><i18n:I18n
						key="i18n_common_title_chooseformfile" defaultValue="选择表单文件" /></span>
			</div>
			<div class="">
				<div class="box-wrap pos-relative bg-common"
					style="padding-bottom: 10px;">
					<div class="common-box-line">
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filename"
									defaultValue="文件名称" />：</span><input id="fileName"
								style="max-width: 248px; width: 248px;" name="fileName"
								type="text" />
						</div>
						<div class="input-and-tip">
							<span><i18n:I18n key="i18n_common_label_filepath"
									defaultValue="文件路径" />：</span><input id="filePath"
								style="max-width: 248px; width: 248px;" name="filePath"
								type="text" />
						</div>
						<div class="input-and-tip text-right">
							<span><div id="btnFileUpload" class="btn btnUpload">
									<i18n:I18n key="i18n_common_button_chooseformfile"
										defaultValue="选择表单文件" />
								</div></span> <input id="fileType" name="fileType" type="hidden" />
						</div>
						<div class="mt-20 text-center">
							<button id="addFileBtnOK" class="button-wrap ">
								<i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" />
							</button>
							<button id="addFileBtnCancel" class="button-wrap ">
								<i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" />
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	var headTable;
	var elsAccount='<%=session.getAttribute("elsAccount") %>';
	var regulationNumber = '<%= regulationNumber%>';
	var cy =GetQueryString("cy");
	$(function() {
		$("#elsAccount").val(elsAccount);
		if(cy!="1"){
			$("#regulationNumber").val(regulationNumber);
		}
		//$("#RegulationSelection").hide();
		 var param = {elsAccount:elsAccount,regulationType:0};
		 $.ajax({
				url : '<%=basePath%>rest/RegulationService/getRegulationTypeByNumber',
				type : "POST",
				async:false,
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
		 initRegulation();
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
   	  			$("#fbk2").val("");
   	  			$("#fileName").val("");
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
	     	$("#fbk2").val("");
	     });
	     //关闭按钮处理
	     $("#dialogFileClose").click(function(){
	     	$("#addFileDialog").hide();
	     	clearAddFileInfo();
	     	$("#fbk2").val("");
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
	//初始化条例信息
	function initRegulation(){
		//initFileUploader(fileUploader);
		var paramStr = {"elsAccount":elsAccount,"regulationNumber":regulationNumber};
		 $.ajax({
				url :"../rest/RegulationService/getRegulation",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(paramStr),
				dataType : "json",
				success : function(data) {
					$("#fbk3").val(data.fbk3);
					if(data.fbk2!=null&&data.fbk2!=""){
		 				$("#fbk2").val(data.fbk2);
	 				}
					//判断附件属性 1 为需要 2为不需要 
	 				if(data.uploadFileFlag=="1"){
	 					
	 				}else if(data.uploadFileFlag=="2"){
	 					$("#uploadFileFlag").val("不需要");
	 				}
					$("#regulationName").val(data.regulationName);
					$("#regulationGroupTypeTemp").val(data.regulationType);
					$("#regulationDetail").val(data.regulationDetail);
					 $("#inputType  option[value='" + data.inputType +"'] ").attr("selected",true);
					 $("#uploadFileFlag  option[value='" + data.uploadFileFlag +"'] ").attr("selected",true);
					 if(data.inputType!=1 && data.inputType !=4){
						 $("#selectTable").show();
					 }else {
						 $("#selectTable").hide();
					 }
					//$("#uploadFileFlag").val(data.uploadFileFlag);
					 $("#revenueEnrolFile").val(data["revenueEnrolFile"]); 
					 if(data["revenueEnrolFile"]!=''&&data["revenueEnrolFile"]!=null)
						 $("#revenueEnrolFileTest").empty().append('<div style="width: 48px;">已上载</div>');
				},
				error : function(data) {
					if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
	}
	 $("#downFile").click(function(){
    	 var filePath = $("#fbk3").val();
    	 if(filePath==''||filePath==null){
			alert('附件为空,不能下载!',2);
	 		return;
		 }
	     window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
	 });
	
		//允许任何字符输入框
		var initInputAny = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" name="selections[]['+this.name+']" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		
		//只允许数字输入框
		var initInputABC = function(val, item, index){
			if(!val) { val = '';}
			return '<input type="text" onkeyup="value=value.replace(/[^a-zA-Z]$/g,\'\')" placeholder="请输入英文字母" maxlength="1" name="selections[]['+this.name+']" value="'+val+'"/>';
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
	
	$("#inputType").change(function(){
		var type =$("#inputType").val();
		if(type!="1" && type!="4"){
			$("#selectTable").show();
			
		}else{
			$("#selectTable").hide();
		}
	});
	
	$("#RegulationSelection").click(function(){
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "RegulationSelection",
	        windowTitle : "<i18n:I18n defaultValue='修改条例选项' key='test'/>",
	        iframSrc : "${pageContext.request.contextPath}/regulation/regulationSelect.jsp?regulationNumber=" + regulationNumber,
	        showAdv : true,
	        windowMinWidth : 500,
	        windowMinHeight : 600,
	        windowWidth : 500,
	        windowHeight : 600,
	        parentPanel : ".currDesktop"
	    });
	});
	$("#updRegulation").click(function(){
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
		 var method = "updateRegulation";
		 if(cy=="1"){
		 	method = "insertRegulation";
		 }
		 $.ajax({
				url :"../rest/RegulationService/"+method,
				type :"POST",
				async:false,
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="test" defaultValue="操作成功" />',1);
					setTimeout(function(){				     
						closeWin();
					 }, "2000"); 
				},
				error : function(data) {
					if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
	});

	$("#closeWin").click(function(){
		closeWin();
	});
	
	function closeWin(){
		parent.frames['iframeApp_regulationManager'].queryRegulation();
		 parent.elsDeskTop.closeCurWin('regulationUpd');
		 parent.elsDeskTop.closeCurWin('regulationCopy');
		 
		
       
	}
	

   var colst_head = [
        	{ title:'els帐号', name:'elsAccount' ,width:200, hidden:true,align:'center',renderer:initInputAny},
        	{ title:'名称', name:'regulationSelectName' ,width:200, align:'center' ,renderer:initInputAny},
        	{ title:'选项值', name:'regulationSelectValue' ,width:200, align:'center',renderer:initInputABC},
        	{ title:'备注', name:'fbk1' ,width:200, align:'center' ,renderer:initInputAny},
       ];

 	  var GobalparamStr={"elsAccount":elsAccount,"regulationSelectID":regulationNumber};
 	  var height=$(document).height()-155;
 	 headTable= $('#headTable').mmGrid({
 	    	 		cols: colst_head,
 	         		url: '<%=basePath%>rest/RegulationService/getRegulationSelectionList',
							params : GobalparamStr,
							method : 'post',
							root : "rows",
							loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
							noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
							multiSelect : false,
							checkCol : true,
							indexCol : false,
							plugins : [ $('#enquiryPage')
									.mmPaginator(
											{
												style : 'plain',
												totalCountName : 'total',
												page : 1,
												pageParamName : 'currentPage',
												limitParamName : 'pageSize',
												limitLabel : '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />',
												totalCountLabel : '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />',
												limit : null,
												limitList : [ 10, 30, 40, 50 ]
											}) ]
						});
	</script>

</body>
</html>