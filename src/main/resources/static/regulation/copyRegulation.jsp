<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String regulationNumber = request.getParameter("regulationNumber"); %>

<body>
<style type="text/css">
	.edit-sub-title {
		display: inline-block;
		width: 130px;
		padding-left: 20px;
		padding-top: 3px ;
		text-align: right;
	}
</style>

<form id="regulationForm" action="" method="post">
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="i18n_common_title_elsaccount" defaultValue="ELS账号" />：</span>
			<input readonly class="" type="text" id="elsAccount" name="elsAccount" />
		</div>

		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="条例名称" />：</span>
			<input  class="" type="text" id=regulationName name="regulationName" />
			<input  type = "hidden" type="text" id="regulationNumber" name="regulationNumber" />
		</div>
		<input type="hidden" id="regulationType" name="regulationType"/>
		<input type="hidden" id="regulationTypeName" name="regulationTypeName" />
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="条例类型" />:</span>
			<select id="regulationGroupTypeTemp" name="regulationGroupTypeTemp" ></select>
		</div>
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="条例明细 "/>:</span>
		    <textarea id="regulationDetail" name="regulationDetail" rows="5" cols="300"></textarea>
		</div>
		
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="输入类型" />：</span>
			<select class="" id="inputType" name="inputType">
				<option value="1"><i18n:I18n key="test" defaultValue="手工输入" /></option>
				<option value="2"><i18n:I18n key="test" defaultValue="单选" /></option>
				<option value="3"><i18n:I18n key="test" defaultValue="多选" /></option>
			</select>
			  <button id="RegulationSelection" class="button-wrap" ><i18n:I18n key="test" defaultValue="选项编辑" /></button>
		</div>
		
	<!-- 	<div class="input-and-tip text-left ">
		       <input hidden = "true"  class="" type="button"  id = "select"  name="" />
		</div> -->
		
		<div class="input-and-tip text-left ">
		    <span class="edit-sub-title"><i18n:I18n key="test" defaultValue="是否需要附件" />：</span>
			<select  class="" id="uploadFileFlag" name="uploadFileFlag">
				<option value="1"><i18n:I18n key="test" defaultValue="不需要" /></option>
				<option value="2"><i18n:I18n key="test" defaultValue="需要" /></option>
			</select>
			
		</div>

		
</form>	
		<div style="text-align: center; padding: 5px">
            <button id="updRegulation" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
            <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
        </div>

<script type="text/javascript">
	elsAccount='<%=session.getAttribute("elsAccount") %>';
	var regulationNumber = '<%= regulationNumber%>';
	
	$(function() {
		$("#elsAccount").val(elsAccount);
		$("#regulationNumber").val(regulationNumber);
		$("#RegulationSelection").hide();
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
	
	//初始化条例信息
	function initRegulation(){
		var paramStr = {"elsAccount":elsAccount,"regulationNumber":regulationNumber};
		 $.ajax({
				url :"../rest/RegulationService/getRegulation",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(paramStr),
				dataType : "json",
				success : function(data) {
					$("#regulationName").val(data.regulationName);
					$("#regulationGroupTypeTemp").val(data.regulationType);
					$("#regulationDetail").val(data.regulationDetail);
					 $("#inputType  option[value='" + data.inputType +"'] ").attr("selected",true);
					 $("#uploadFileFlag  option[value='" + data.uploadFileFlag +"'] ").attr("selected",true);
					 if(data.inputType!=1){
						 $("#RegulationSelection").show();
					 }
					//$("#uploadFileFlag").val(data.uploadFileFlag);
				},
				error : function(data) {
					if (!permissionError(data)) {
	 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
	}
	$("#inputType").change(function(){
		if($("#inputType").val()!=1){
			$("#RegulationSelection").show();
		}
	});
	$("#RegulationSelection").click(function(){
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "RegulationSelection",
	        windowTitle : "<i18n:I18n defaultValue='修改条例选项' key='test'/>",
	        iframSrc : "${pageContext.request.contextPath}/regulation/copyregulationSelect.jsp?regulationNumber=" + regulationNumber,
	        showAdv : true,
	        windowMinWidth : 500,
	        windowMinHeight : 600,
	        windowWidth : 500,
	        windowHeight : 600,
	        parentPanel : ".currDesktop"
	    });
	});
	$("#updRegulation").click(function(){
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
		 var frm = $("#regulationForm").serializeJSON();
		 $.ajax({
				url :"../rest/RegulationService/copyRegulation",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm),
				dataType : "json",
				success : function(data) {
					alert('<i18n:I18n key="test" defaultValue="复制成功" />',1);
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
        parent.elsDeskTop.closeCurWin('regulationCopy');
	}
	
	
</script>

</body>
</html>