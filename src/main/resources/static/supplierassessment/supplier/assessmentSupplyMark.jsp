<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String assessmentNumber = request.getParameter("assessmentNumber");
%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">
table tbody tr td {
margin:0px;
padding:0px;
width: 80px;
}
</style>
<body>
	<div class="pos-relative public-wrap">
	<form id="queryForm" onsubmit="return false;" method="POST" action="">
	
		  <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="enquiryMarkBtn" class="button-wrap" ><i18n:I18n key="test" defaultValue="评分" /></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>
		
		 <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></span>
            
            <div class="common-box-line">
               <div class="dis-in-b input-and-tip">
            	<table>
					<tbody>
						<tr>
							<td colspan="1" align="right"><strong><i18n:I18n key="test" defaultValue="评估编号" />：</strong></td>
							<td colspan="1" align="left"><span id="assessmentNumberDis"/></td>
							<td colspan="1" align="right"><strong><i18n:I18n key="test" defaultValue="评估名称" />：</strong></td>
							<td colspan="1" align="left"><span id="assessmentTemplateNameDis"/></td>
						</tr>
						<tr>
							<td colspan="1" align="right"><strong><i18n:I18n key="test" defaultValue="供应商" />：</strong></td>
							<td colspan="1" align="left"><span id="toCompanyShortNameDis"/></td>
							<td colspan="1" align="right"><strong><i18n:I18n key="test" defaultValue="得分" />：</strong></td>
							<td colspan="1" align="left"><span id="gradesDis" style="color: red;"/></td>
						</tr>
					</tbody>
				</table>
				</div>
            </div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="头信息" /></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="行信息" /></span>
            <div class="common-box-line">
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
	
	<div class="fixed-dialog" id="integrationInfoDialog" >
	<div class="dialog-tip bg-common" style="width: 603px;height: 220px;margin-left: -251px;margin-top: -190px;">
	    <div class="dialog-close-btn" id="integrationInfoDialogDialogClose"></div>
        <div class="tip-head">
            <img class="icon" src="../../icon/destop-icon/desktop_icon_93.gif" />
	        <span class="integrationInfoDialogTitle"></span>
	    </div>
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"></span>
	            <form id="addIntegrationInfoForm">
	            <input type="hidden" id="hidden_elsAccount" name="elsAccount">
	            <input type="hidden" id="hidden_assessmentClassNumber" name="assessmentClassNumber">
	            <input type="hidden" id="hidden_createUser" name="createUser">
	            <div class="common-box-line">
	                  <span class="input1"></span>:
	                  <input type="text" class="click-input" id="input1" name="input1" onkeyup="value=value.replace(/[^(\d)]/g,'')"/>
	                  <span class="input2"></span>:
	                  <input type="text" class="click-input" id="input2" name="input2" onkeyup="value=value.replace(/[^(\d)]/g,'')"/><br>
	                  <span class="percentage"></span>=( <span class="input1"></span>/ <span class="input2"></span>) * 100% <br>
                                   <span class="equality1"></span> <br>
                                   <span class="equality2"></span><br>
                      <span class="percentage"></span>得分<span class="equality3"></span><br>
	                
	            </div>
	            </form>
	            <div class="mt-20 text-center" >
	                <button id="integrationInfoOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                <button id="integrationInfoCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	            </div>
	        </div>
    </div>
</div>

	<script>
	 var headTable;
	 var itemTable;
	 var type             = "";
	 var roleCode         = "";
	 var elsAccount       = "<%=session.getAttribute("elsAccount")%>";
	 var elsSubAccount    = "<%=session.getAttribute("elsSubAccount")%>";
	 var companyName      = "<%=session.getAttribute("companyShortName")%>";
	 var rowIndexSelect   = 0 ;
	 var excelUploader        ;
	 var assessmentNumber = '<%=assessmentNumber%>';
	
	 //初始化记载信息 
	 $(document).ready(function(){
		 
	 });
	 
	 // 渲染   @author jiangzhidong 20160120  begin
		//按钮
		var enquiryHandle = function(val, item, index){
			return '<span class="col-price-his" style="color:blue;"><i18n:I18n key="test" defaultValue="历史" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';

		};
		//只允许数字输入框
		var initInputNumber = function(val, item, index){
			if(!val) { val = '';}
			return '<input id="'+this.name+'_'+index+'" type="text" onkeyup="value=(parseInt(value.replace(/[^(\\d\\.)]/g,\'\'))||0)%101" name="'+this.name+'" value="'+val+'"/>';
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
		//企业名称
	    var initCompanyName = function (val, item, index){
	    	if(!val) { val = '';}
	    	var name = this.name;
	    	var value = this.value;
			return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
	    }
		//日期input
		var formatDateInput = function (val, item, index){
			if (!val) {val = "";}
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
			return '<input name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
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
			return new Date(val).format("yyyy-MM-dd hh:mm:ss");
		};
		//时间input
		var formatDateTimeInput = function (val, item, index){
			if (!val) {val = "";}
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd hh:mm:ss");}
			return '<input name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		};
		//审批方式 select
		var initAuditModeSelect = function(val,item,index) {
			//1-审批流 2-自动 3-人工
			var selected = '<select name="auditModeSelect" id="auditModeSelect"  style="color:blue; min-width:70px; padding:5px;">'
							+'<option value="1"><i18n:I18n key="test" defaultValue="审批流" /></option>'
							+'<option value="2"><i18n:I18n key="test" defaultValue="自动" /></option>'
							+'<option value="3"><i18n:I18n key="test" defaultValue="人工" /></option></select>'
			return selected;
		};
		//审批方式
		var initAuditMode = function (val,item,index){
			//1-审批流 2-自动 3-人工
			if (val == "1" || val == null) return '<i18n:I18n key="test" defaultValue="审批流" />';
			else if (val == "2") return '<i18n:I18n key="test" defaultValue="自动" />';
			else if (val == "3") return '<i18n:I18n key="test" defaultValue="人工" />';
		};
		//总评分  人工
		var initTotalScore = function(val, item, index){
			if (!val) {val = "";}
			return '<div style="color: red;">' +val+ '</div>';
		};
		//发送状态
		var initSendStatus = function (val,item,index){
			//0:未发送 1:已发送
			if (val == "0") return '<i18n:I18n key="test" defaultValue="未发送" />'
			else if (val == "1") return '<i18n:I18n key="test" defaultValue="已发送" />';
		};
		//单据状态
		var initStandardStatus = function (val,item,index){
			//0:新建 1:销售方填写中 2:采购方评估中 3:待审批中 4:审批中
			if (val == "0") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />'
			else if (val == "1") return '<i18n:I18n key="test" defaultValue="填写中" />';
			else if (val == "2") return '<i18n:I18n key="test" defaultValue="评估中" />';
			else if (val == "3") return '<i18n:I18n key="test" defaultValue="审批中" />';
		};
		//审批状态
		var initAuditStatus = function (val,item,index){
			//0:审批通过  1:未审批  2:审批中  3:审批拒绝
			if (val == "0") return '<i18n:I18n key="test" defaultValue="审批通过" />'
			else if (val == "1") return '<i18n:I18n key="test" defaultValue="未审批" />'
			else if (val == "2") return '<i18n:I18n key="test" defaultValue="审批中" />';
			else if (val == "3") return '<i18n:I18n key="test" defaultValue="审批拒绝" />';
		};
		//审批状态 select
		var initAuditStatusSelect = function(val,item,index) {
			if(item.auditMode==3){
				var sel=' selected="true"';
				var selected = '<select name="auditStatusSelect" id="auditStatusSelect" style="color:blue; min-width:70px;"><option value="0"';
				if(val==0) selected = selected +sel;
				selected =selected + '><i18n:I18n key="test" defaultValue="审批通过" /></option><option value="1"'
				if(val==1) selected = selected +sel;
				selected =selected + '><i18n:I18n key="test" defaultValue="未审批" /></option><option value="2"'
				if(val==2) selected = selected +sel;
				selected =selected + '><i18n:I18n key="test" defaultValue="审批中" /></option><option value="3"'
				if(val==3) selected = selected +sel;
				selected =selected + '><i18n:I18n key="test" defaultValue="审批拒绝" /></option></select>'
				return selected;
			}
			return initAuditStatus(val,item,index);
		};
		//供应商els帐号
		var initSupplierElsAccount = function (val,item,index){
			return '<span class="elsAccountBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		};
		//评分状态
		var initStatus = function (val,item,index){
			//'评分状态：\n 0:已评分\n 1:未评分\n ',
			if (val == "0") return '<i18n:I18n key="test" defaultValue="已评分" />'
			else if (val == "1") return '<i18n:I18n key="test" defaultValue="未评分" />';
		};
	 // 渲染   @author jiangzhidong 20160120  end
	 
	 //退出
	 $("#exitBtn").click(function(){
			parent.elsDeskTop.closeCurWin('assessmentSupplyMark');
		});
	 
	var colst_head = [{ title:'操作', clickDisable:true, name:'standardDesc' ,width:50, align:'center',renderer:enquiryHandle },
	                  { title:'供应商编码'    , name:'toElsAccount', width: 100, align: 'center'},
    	  	          { title:'供应商名称'    , name:'toCompanyShortName' ,width:150, align:'center' },
	  	        	  { title:'评估编号'      , name:'assessmentNumber' ,width:90, align:'center' },
	  	        	  { title:'评估名称'  , name:'assessmentTemplateName' ,width:150, align:'center' },
	  	          	  { title:'评估模板编号'  , name:'assessmentTemplateNumber' ,width:90, align:'center' },
	  	        	  { title:'评估模板版本号', name:'templateVersionNumber' ,width:80, align:'center' },
	  	        	  { title:'评分状态'      , name:'status' ,width:150, align:'center',renderer:initStatus },
	  	        	  { title:'得分'          , name:'grades' ,width:70, align:'center' },
	  	        	  { title:'最后操作人'     , name:'createUser' ,width:140, align:'center'},
	  	        	  { title:'操作时间'      , name:'createDate' ,width:140, align:'center',renderer:formatDate},
	  	        	  { title:'备注'          , name:'remark' ,width:100, align:'center'}];
	   

  	  var GobalparamStr={"elsAccount":elsAccount,"assessmentNumber":assessmentNumber};
  	  var height=$(document).height()-155;
  	  headTable= $('#headTable').mmGrid({
  	    	 		cols: colst_head,
  	         		url: '<%=basePath%>rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentCheckItemByCondtion/'+elsAccount,
  					params : GobalparamStr,
  					method : 'post',
  					root : "rows",
  					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
  			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
  			        height: 200,
  			        multiSelect : false,
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
  	  
  				headTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
			     	rowIndexSelect=rowIndex;
			     	loadItem();
			     	 $("#assessmentNumberDis").text(item.assessmentNumber);
					 $("#assessmentTemplateNameDis").text(item.assessmentTemplateName);
					 $("#toCompanyShortNameDis").text(item.toCompanyShortName);
					 if(item.grades!=null)
					 $("#gradesDis").text(item.grades);
			    });
  	 
  				headTable.on('loadSuccess', function(e, data) {
  					if (data.total > 0) {
  						headTable.select(rowIndexSelect);
  						loadItem();
  						 $("#assessmentNumberDis").text(data.rows[0].assessmentNumber);
  						 $("#assessmentTemplateNameDis").text(data.rows[0].assessmentTemplateName);
  						 $("#toCompanyShortNameDis").text(data.rows[0].toCompanyShortName);
  						 if(data.rows[0].grades!=null)
  						 $("#gradesDis").text(data.rows[0].grades);
  					} 
  				});


	//评分
	$('#enquiryMarkBtn').live("click", function() {
		var itemRows = itemTable.selectedRows()      ;
		var itemIndex=itemTable.selectedRowsIndex()  ;
		var frm           = $("#queryForm")          ;
		var jsonObj       = frm.serializeJSON()      ;
		var head          = headTable.selectedRows() ;
		var toElsAccount  = head[0].toElsAccount     ;

	 	if(itemRows.length == 0){
	 		alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择记录!" />',2);
	 		return;
	 	}else if (itemRows.length > 0 ){
			if( null != itemRows && itemRows != "" ){
				jsonObj["elsAccount"]            = elsAccount       ;
				jsonObj["toElsAccount"]          = toElsAccount     ;
				jsonObj["elsSubAccount"]         = elsSubAccount    ;
				jsonObj["assessmentNumber"]      = assessmentNumber ;

				var sATCSVO = [] ;
				for(var i = 0; i < itemRows.length; i++){
					var singleRow   = itemRows[i] ;
					singleRow       = inputSetValue(singleRow,itemIndex[i]) ;
					sATCSVO.push(JSON.stringify(singleRow));
				}
				jsonObj['sATCSVO'] = eval('['+sATCSVO+']');
			}
		}

		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="test" defaultValue="是否确认评分?" />',closeEvent:function(){
			$.ajax({
				url         : "<%=basePath%>rest/PurchaseEnquiryAssessmentService/insertAssessmentTemplateContentSub",
				type        : "post"                  ,
				contentType : "application/json"      ,
				data 		: JSON.stringify(jsonObj) ,
				dataType    : "json"                  ,
				success : function(data) {
					alert("评分成功!",1)               ;
					headTable.load()                  ;
					for(var i = 0; i < itemRows.length; i++){
						var singleRow   = itemRows[i] ;
						singleRow.grades = ""         ;
					}					
				}                                     ,
				error : function(data) {
					alert("评分失败!",3)              ;
				}
			});
		}});

	});
	
	//历史
    $('.col-price-his').live("click", function() {
    	debugger;
        var scanCol = $(this).next().text();
        var item = JSON.parse(scanCol);
        parent.elsDeskTop.defineWin({
            'iconSrc':'icon/els-icon.png',
            'windowsId':'assessmentSupplyMarkSub',
            'windowTitle':'历史评分记录',
            //windowSubTitle: '评分记录',
            'iframSrc':'<%=basePath%>supplierassessment/supplier/assessmentSupplyMarkSub.jsp?assessmentNumber='+item.assessmentNumber+'&toElsAccount='+item.toElsAccount,
            windowStatus: 'regular',
            windowMinWidth: 1100,
            windowMinHeight: 450,
            'windowWidth':1100,
            'windowHeight':450,
            'parentPanel':".currDesktop"
        });
    });
	
    //获取input 对象里面的值
	function inputSetValue(row,index){
		var grades = $("#grades_" + index).val();
		row["grades"]=grades;
	    return row;
	}
    
	//只允许数字输入框
	var initInputNumber = function (val,item,index){
		if(!val) { val= '';}
		if(item.fbk2 == '1'){
			return '<input type="text" readOnly="readOnly" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'" id="'+this.name+'_'+index+'"/>';
		}else{
			return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'" id="'+this.name+'_'+index+'"/>';
		}
	};
    
	//指标类型
	function rendererAssessmentFlag(val,item,rowIndex){
	   if(val == "1" ){
		   var text = '<span class="click-assessmentFlag" style="color:blue;cursor:pointer;">定量指标</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
		  return text;
	   }else{
		  return "定性指标";
	   }
    }
	
	$('.click-assessmentFlag').live("click", function() {
	    var scanCol = $(this).next();
	    var sanContent = scanCol.text();
	    var item = JSON.parse(sanContent);
	    
	    var rowIndex = $(this).closest("tr").index();
	    $('body').data("rowIndex",rowIndex);
	    
	    $(".equality1").text("");
		$(".equality2").text("");
		$(".equality3").text("");
		$("#input1").val("");
		$("#input2").val("");
	    
	    var rationFormula = item.fbk3;
	    if(rationFormula == '0'){
	    	$(".integrationInfoDialogTitle").text("交货及时率");
	    	$(".input1").text("交货及时次数");
	    	$(".input2").text("交货总次数");
	    	$(".percentage").text("交货及时率");
	    }else{
	    	$(".integrationInfoDialogTitle").text("入库合格率");
	    	$(".input1").text("抽检合格数量");
	    	$(".input2").text("抽检总数量");
	    	$(".percentage").text("入库合格率");
	    }
		$("#integrationInfoDialog").show();
	});
	
	//===========================================行信息===========================================
	 var cols_item = [{ title:'行号', name:'assessmentItemNumber' ,width:100, align:'center' },
	                  { title:'供应商编码', name:'toElsAccount', width: 120, align: 'center'},
	                  { title:'评估编号', name:'assessmentNumber', width: 120, align: 'center'},
              	      { title:'评估模板编号', name:'assessmentTemplateNumber' ,width:100, align:'center' },
              	      { title:'评估类型编号', name:'assessmentClassNumber' ,width:100, align:'center' },
              	 	  { title:'评估项编号', name:'fbk1' ,width:100, align:'center' },
              		  { title:'评估类型名', name:'assessmentClassName' ,width:100, align:'center' },
           	          { title:'规则名', name:'assessmentItemName' ,width:150, align:'center' },
           	          { title:'权重%', name:'share' ,width:100, align:'center' },
				      { title:'评分', clickDisable:true, name:'grades' ,width:70, align:'center',renderer: initInputNumber},
				      { title:'指标类型', name:'fbk2' ,width:100, align:'center',clickDisable:true,renderer: rendererAssessmentFlag},
				      { title:'说明', name:'remark' ,width:100, align:'center'},
           	          { title:'时间戳', name:'logtime' ,width:100, align:'center',renderer:formatDate}];

	
		 itemTable = $('#itemTable').mmGrid({
		        cols        : cols_item,
		        height      : 300,
		        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol    : true,
		        multiSelect : true
		    });
		 //全选
		 itemTable.on('loadSuccess',function(e, data) {
			 itemTable.select("all");
		  });
		 //加载行
		 var loadItem = function() {
		 	   var head = headTable.selectedRows();
		 	   var paramStr={"elsAccount":elsAccount,
		 			   "assessmentNumber":assessmentNumber,
		 			   "toElsAccount":head[0].toElsAccount};
		 		$.ajax({
		 			url: '<%=basePath%>rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentTemplateContentByCondtion/'+elsAccount,
		 			type : 'POST',
		 			contentType : "application/json",
		 			data : JSON.stringify(paramStr),
		 			dataType : "json",
		 			success : function(data) {
		 				itemTable.load(data.rows);
		 			},
		 			error : function(data) {
		 				alert('<i18n:I18n key="i18n_common_loadDataFailed" defaultValue="加载数据失败!" />',3);
		 			}
		 		});
		 		 
		 }
			
		 
//查看流程
$("#flowBtn").click(function(){
var headRows      = headTable.selectedRows();
var headRowsIndex = headTable.selectedRowsIndex();
	if(headRows.length != 1){
		alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
		return;
	}		
	var tstandardNumber = elsAccount + "," + headRows[0].standardNumber ;
	parent.elsDeskTop.defineWin({
	   	'iconSrc'       : 'icon/els-icon.png' ,
		'windowsId'     : 'auditFlowList'     ,
		'windowTitle'   : '<i18n:I18n key="i18n_common_viewflow"    defaultValue="查看流程" />',
		 windowSubTitle : ""                  ,
		'iframSrc'      : '<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=standardSupplier&businessId='+ tstandardNumber,
		 showAdv        : true                ,
		 advArr         : ['icon/test-car.png','icon/test-car2.png'] ,
		 windowMinWidth : 480 ,
		 windowMinHeight: 600 ,
		'windowWidth'   : 680 ,
		'windowHeight'  : 600 ,
		'parentPanel'   : ".currDesktop"
	});
});
	
//撤销上报
$("#cancelEntryBtn").click(function(){
 	var headRows      = headTable.selectedRows();
 	var headRowsIndex = headTable.selectedRowsIndex();
		if(headRows.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		//contentType : "application/json",
		//dataType : "json",
		//data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
		var paramStr={"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"standardNumber":headRows[0].standardNumber};
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_are_you_sure_you_want_to_do_this"    defaultValue="您确定要执行此操作吗？" />',closeEvent:function(){
	parent.elsDeskTop.showLoading();
	$.ajax({  url         : "<%=basePath%>rest/SupplierStandardService/cancelAudit",
			  type        : "post",
			  contentType : "application/json",
			  data 		  : JSON.stringify(paramStr),
			  dataType    : "json",
			  success     : function(data) {
				  parent.elsDeskTop.hideLoading();
				  alert('<i18n:I18n key="i18n_delivery_revokesuccess"    defaultValue="撤销成功" />');
				  query();
		      },
		      error : function(data) {
				  parent.elsDeskTop.hideLoading();
				       if (data.status == "401") {  alert('<i18n:I18n key="i18n_audit_overcantcancel"    defaultValue="流程结束的单据不能撤销审批" />'  ,3);  } 
				  else if (data.status == "403") {  alert('<i18n:I18n key="i18n_audit_higherlevelcando"  defaultValue="只有上一级处理人才能撤销审批" />',3);  } 
				  else {  alert('<i18n:I18n key = "i18n_common_alert_requestfail" defaultValue="请求出错！" />',3);	  }
			 },
			 complete : function(data) {
				  query();
	    	 }
	    });
	}
	});
});


//上报
$("#entryBtn").click(function(){	
	parent.elsDeskTop.tip.init({type: 'confirm',message:'确认要上报吗？',closeEvent:function(){
	var headRows      = headTable.selectedRows();
	var headRowsIndex = headTable.selectedRowsIndex();
		if(headRows.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		//contentType : "application/json",
		//dataType : "json",
		//data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商"}),
		var paramStr={"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"standardNumber":headRows[0].standardNumber};
		
		$.ajax({	url     : "<%=basePath%>rest/SupplierStandardService/entryStandardSupplier",
				type        : "post",
				contentType : "application/json",
				//data 		: JSON.stringify(headRows[0]),
				data 		: JSON.stringify(paramStr),
				dataType    : "json",
				success 	: function(data) {
					parent.elsDeskTop.hideLoading();
					alert('<i18n:I18n key="i18n_common_report_success" defaultValue="发送成功" />');
					query();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.status == "401") {    alert('<i18n:I18n key="i18n_common_orders_cannot_be_repeated_to_report"    defaultValue="供应商准入不能重复上报" />',3);    } 
					else {	alert('<i18n:I18n key="i18n_common_alert_requestfail"    defaultValue="请求出错" />',3);	};
				}
		});
	}});
});

//定量考评相关------begin--------

//弹出框取消按钮
$("#integrationInfoCancel").click(function(){
	$("#integrationInfoDialog").hide();
});
//关闭按钮处理
$("#integrationInfoDialogDialogClose").click(function(){
	$("#integrationInfoDialog").hide();
});

/*<span class="input1"></span>:
<input type="text" id="input1" name="input1"/>
<span class="input2"></span>:
<input type="text" id="input2" name="input2"/><br>
<span class="percentage"></span>=( <span class="input1"></span>/ <span class="input2"></span>) * 100% <br>
             <span class="equality1"></span> <br>
             <span class="equality2"></span><br>
<span class="percentage">得分</span><span class="equality3"></span><br>
*/

$('.click-input').keyup(function() {
	var input1 = $("#input1").val();
	var input2 = $("#input2").val();
	if(input1&&input2&&parseInt(input1)<=parseInt(input2)){
		var percentage = (input1/input2);
		var result = (percentage*100).toFixed(2);
		$('body').data("jsResult",result);
		$(".equality1").text("= ( "+input1+"/"+input2+" ) * 100%");
		$(".equality2").text("= "+result+"%");
		$(".equality3").text("= 100 * "+result+"% = "+result+"分");
	}else{
		$(".equality1").text("");
		$(".equality2").text("");
		$(".equality3").text("");
	}
});

$("#integrationInfoOK").click(function(){
	var input1 = $("#input1").val();
	var input2 = $("#input2").val();
	if(input1&&input2){
		if(parseInt(input1) <= parseInt(input2)){
			var result = $('body').data("jsResult");
			var rowIndex = $('body').data("rowIndex");
			$("#grades_"+rowIndex).val(result);
			$("#integrationInfoDialog").hide();
		}else{
			alert($(".input2").eq(0).text() +" 不能比 "+$(".input1").eq(0).text() +"少！" ,2);
		}
	}else{
		alert("请先输入计算数据！",2)
	}
});


//定量考评相关------end--------
</script>
</body>
</html>