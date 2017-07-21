<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
		 <div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">  
				<button class="button-wrap" id="sendBtn"><i18n:I18n key="i18n_button_send" defaultValue="发送" /></button>
				<button class="edit-btn button-wrap btnUpload" id="excelimport"><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></button>
				<button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
			</div>
		</div> 
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_label_elsAccount" defaultValue="ELS帐号" /></span>
					<input type="text" id="checkElsAccount" name="checkElsAccount" />
				</div>
				
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_label_userName" defaultValue="用户名称" /></span>
					<input type="text" id="checkUserName" name="checkUserName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司简称" /></span>
					<input type="text" id="checkCompanyName" name="checkCompanyName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_label_handleFlag" defaultValue="处理状态" />:</span>
					<select id="status" name="status">
						<option value="">请选择</option>
						<option value="0">已填写</option>
						<option value="1">未填写</option>
					</select>
				</div>
				<br>
				<div class="dis-in-b input-and-tip"><span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_common_title_createdate" defaultValue="创建日期" />：</span></div>
                <input type="radio" name="dateArea" value="week"><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" />
                <input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
                <input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
                <input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b input-and-tip" style="display:none;"><input type="text" class="Wdate" onfocus="WdatePicker()" id="startCreateDate" name="startCreateDate"/></div>
                <div class="dis-in-b input-and-tip" style="display:none;"><span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span><input type="text" id="endCreateDate" class="Wdate" onfocus="WdatePicker()" name="endCreateDate" /></div>
            	<%-- <button style="margin-left: 39px;" id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button> --%>
			</div>
		</div>
		
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">调查问卷表</span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="questionnaire">
							<table id="questionnaireTable"></table>
							<div id="enquiryPage" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	 var questionnaire;
	 var excelUploader      ; //上传Excel控件 
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var elsSubAccount = <%=session.getAttribute("elsSubAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	
	 //初始化记载信息 
	 $(document).ready(function(){
		$("[name=dateArea]").click(changeDateArea);
		 initExcelUploader();
	 });
	 
	 //查询
	 $("#queryBtn").click(function(){
		 changeDateArea();
		 var elsAccount = $("#checkElsAccount").val();
		 var userName = $("#checkUserName").val();
		 var companyName = $("#checkCompanyName").val();
		 var startCreateDate =$("#startCreateDate").val();
		 var endCreateDate =$("#endCreateDate").val();
		 var status =$("#status").val();
		 var GobalparamStr={"elsAccount":elsAccount,"userName":userName,"companyName":companyName,"startCreateDate":startCreateDate,"endCreateDate":endCreateDate,"status":status};
		 //questionnaire.load(GobalparamStr);
		 $.extend(questionnaire.opts.params,GobalparamStr);
		 questionnaire.load(); 
		// reset();
	 });
	 
	 //发送
	 $("#sendBtn").click(function(){
		 	var questionnaireRows = questionnaire.selectedRows();
		 	console.log(questionnaireRows);
		 	if(questionnaireRows.length==0){
		 		alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择记录!" />',2);
		 		return;
		 	}
		 	if(confirm("确定发送所选项提示消息?")) {
				 $.ajax({
					url :"<%=basePath%>rest/QuestionnaireService/sendQuestionnaire/"+elsAccount+"/"+elsSubAccount,
					type :"POST",
					contentType : "application/json",
					dataType : "json",
					data:JSON.stringify(questionnaireRows),
					success : function(data) {
						if(data.statusCode==-100){
		    				alert("发送失败!");
		    			}else {
		    				alert("发送成功!");
		    			}
					},
					error: function (xhr, type, exception) {
		            	alert(xhr.responseText, "Failed"); 
		        	}
				});
		 	};
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
				    server: '<%=basePath%>rest/QuestionnaireService/uploadFile',
				    // 选择文件的按钮。可选。
				    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
				    pick: '#excelimport',
				    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
				    resize: false,
				    formData : {
	    		     	elsAccount : elsAccount
	    		     }
				});
				
				excelUploader.on('uploadAccept', function(obj, response ) {
					var fileName = response._raw;
				  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
				   	$.ajax({
							url :"<%=basePath%>rest/QuestionnaireService/excelImport",
							type :"POST",
							contentType : "application/json",
							dataType : "json",
							data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"fileName":fileName}),
							success : function(data) {
								if(data.statusCode=="-100"){
									alert(data.message,2);
								}else{
									alert("<i18n:I18n key="i18n_common_alert_successfulImprot" defaultValue="导入成功！" />");
								}
								questionnaire.removeRow();
								questionnaire.addRows(data);
							},
							error: function (data) {//获取ajax的错误信息
								parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误！" />'});
				            }
						});
				   	parent.elsDeskTop.hideLoading();
			  
				});   
			}
		}
	   //excel导入-------------end-------------------
	 
	 function changeDateArea() {
		var dateArea = $("input:radio[name=dateArea]:checked").val();
		if (dateArea == "define") {
			//$("#startCreateDate").val("");
			//$("#endCreateDate").val(""); 
			$("#startCreateDate").parent().show();
			$("#endCreateDate").parent().show();
		} else {
			$("#startCreateDate").parent().hide();
			$("#endCreateDate").parent().hide();
			$("#endCreateDate").val(new Date().format("yyyy-MM-dd"));
			var startOrderDate = "";
			if (dateArea == "week") {
				startOrderDate = getDate(-7);
			} else if (dateArea == "month") {
				startOrderDate = getDate(-30);
			} else if (dateArea == "threeMonth") {
				startOrderDate = getDate(-90);
			}
			
			$("#startCreateDate").val(startOrderDate);
		}
	}
	 
	 function getDate(dates){
		var dd = new Date();
		dd.setDate(dd.getDate()+dates);
		return dd.format("yyyy-MM-dd");
	 }
	 
	var reset = function() {
	 	if(!isFirst){
	 		 var data = questionnaire.opts.cols;
			 for(var i= 0; i<=data.length-1; i++) {
				 var row = data[i];
				 if(row.name && arr.indexOf(row.name) != -1)
					 row.renderer = null;
				 else if(row.name && arr2.indexOf(row.name) != -1)
				     row.renderer = enquiryHandle;
				 else if(row.name && arr3.indexOf(row.name) != -1)
				     row.renderer = null;
			 }
	 	}
	 	isFirst=true;
	};
 
	//按钮
	var enquiryHandle = function(val, item, index){
		return '&nbsp;&nbsp;<span class="enquiry-detail"  id="checkBtn" name="checkBtn" style="color:blue;"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
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
	
   var cols = [ {title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />',clickDisable:true, name:'elsHandle' ,width:90, align:'center', renderer: enquiryHandle},
    	        {title:'<i18n:I18n key="i18n_common_label_elsAccount" defaultValue="ELS帐号" />', name:'elsAccount', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_elsSubAccount" defaultValue="子帐号" />', name:'elsSubAccount', width: 120, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_label_userName" defaultValue="用户名称" />', name:'userName', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_account_title_telephone" defaultValue="电话号码" />', name:'telphone', width: 250, align: 'center'},
    	        {title:'<i18n:I18n key="i18n_common_lable_companyname" defaultValue="公司名称" />', name:'companyName', width: 250, align: 'center'},
    	        {title:'总得分', name:'totalScore', width: 250, align: 'center'},
    	     /*    {title:'总百分比', name:'percent', width: 250, align: 'center'}, */
    	        {title:'<i18n:I18n key="i18n_common_title_createdate" defaultValue="创建时间" />', name:'createDate' ,width:200, align:'center',renderer:function(val){
     		    	if (!val) return "";
    	        	return new Date(val).format("yyyy-MM-dd hh:mm:ss");}
    	        }];
   

   var frm = {elsAccount:null};
  	var height=$(document).height()-155;
  	questionnaire= $('#questionnaireTable').mmGrid({
  	    	 		cols: cols,
  	         		url: '<%=basePath%>rest/QuestionnaireService/selectQuestionnaire',
  					params : frm,
  					method : 'post',
  					root : "rows",
  					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
  			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
  					checkCol : true,
  			        multiSelect: true,
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
  				questionnaire.on('loadSuccess', function(e, data) {
  					 if (data.total > 0) {
  						questionnaire.select(0);
  					} 
  				});


	//删除
	$('.deleteBtn').live("click", function() {
		var scanCol = $(this).next();
        var sanContent = scanCol.text();
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除?" />',closeEvent:function(){
		$.ajax({
    		url :"<%=basePath%>rest/SaleRelationService/deleteSaleRelation",
    		type :"post",
    		contentType : "application/json",
    		data : sanContent,
    		dataType : "json",
    		success : function(data) {
    			alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
    			query();
    		},
    		error : function(data) {
    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
    		}
    	}); 
		}});
		
	});
	
	$('.enquiry-detail').live("click", function() {
		var editCol = $(this).next();
        var editContent = editCol.text();
        var editContentObj = JSON.parse(editContent);
        var elsAcct=editContentObj.elsAccount;
        var elsSubAcct=editContentObj.elsSubAccount;
        var type=editContentObj.type;
		var url="<%=basePath%>questionnaire/serviceQuestionnaireDetail.jsp?elsAcct="+elsAcct+"&elsSubAcct="+elsSubAcct+"&type="+type;
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop2_icon_181.png',
	        'windowsId':'serviceQuestionnaireDetail',
	        'windowTitle':'问卷信息',
	        'iframSrc':url,
	        windowMinWidth: 1600,
	        windowMinHeight: 900,
	        'windowWidth':1080,
	        'windowHeight':600,
	        windowPositionTop:25,
	        'parentPanel':".currDesktop"
	    });
	});
	
	
		</script>
</body>
</html>