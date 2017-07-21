<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
		    <input type="hidden" id="elsAccount" name="elsAccount" value="<%=session.getAttribute("elsSubAccount")%>"/>
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="queryHeadBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
					<button class="button-wrap" id="selcetModel"><i18n:I18n key="i18n_common_button_ok" defaultValue="确认" /></button>
			</div>
		</div>
		
		<form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span>编号:</span>
					<input type="text" id="templateNumber" name="templateNumber"/>
				</div>
				<div class="dis-in-b input-and-tip">
					<span>名称:</span>
					<input type="text" id="templateName" name="templateName" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />:</span>
					<input type="text" id="createUser" name="createUser" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_applyDate" defaultValue="申请日期" />:</span>
	                <input type="radio" name="dateArea" value="lastMonth" checked="checked"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
	                <input type="radio" name="dateArea" value="lastThreeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
	                <input type="radio" name="dateArea" value="defineDateArea"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
				</div>
                <div class="dis-in-b input-and-tip" style="display:none;">
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="startCreateDate" name="startCreateDate"/>
                </div>
                <div class="dis-in-b input-and-tip" style="display:none;">
	                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="endCreateDate" name="endCreateDate" />
                </div>
			</div>
		</div>
		</form>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="模版列表" /></span>
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
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="条例列表" /></span>
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
		
	</div>

	<script>
	 var headTable;
	 var itemTable;
	 var type="";
	 var roleCode="";
	 var elsAccount = <%=session.getAttribute("elsAccount")%>;
	 var companyName = "<%=session.getAttribute("companyShortName")%>";
	 var frameAppId ="<%=request.getParameter("frameAppId") %>";
	 var rowIndexSelect=0;
	
	 //初始化记载信息 
	 $(document).ready(function(){
		 $("input[name='dateArea']").click(function(){
				var dateArea = $(this).val();
				var currDate = new Date();
				
				if("lastMonth" == dateArea){
					$("#startCreateDate").parent().hide();
					$("#endCreateDate").parent().hide();
					
				    var currDateMill = currDate.getTime();
					var startDate = new Date();
				    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
				    var currMonthMaxDay = startDate.getDate();//本月天数
				    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
				    
					$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
					$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
				} else if("lastThreeMonth" == dateArea){
					$("#startCreateDate").parent().hide();
					$("#endCreateDate").parent().hide();
					
					var currDateMill = currDate.getTime();
					var startDate = new Date();
				    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
				    var currMonthMaxDay = startDate.getDate();//本月天数
				    startDate.setMonth(currDate.getMonth(), 0);//上月最后一日
				    var lastMonthMaxDay = startDate.getDate();//上月天数
				    startDate.setMonth(currDate.getMonth()-1, 0);//前第二月最后一日
				    var last2MonthMaxDay = startDate.getDate();//前第二月天数
				    
				    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay+lastMonthMaxDay+last2MonthMaxDay-1));
					$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
					$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
				} else if("defineDateArea" == dateArea) {
					$("#startCreateDate").val("");
					$("#endCreateDate").val("");
					$("#startCreateDate").parent().show();
					$("#endCreateDate").parent().show();
				} else {//默认查最近一月
					$("#startCreateDate").parent().hide();
					$("#endCreateDate").parent().hide();
					
					var currDateMill = currDate.getTime();
					var startDate = new Date();
				    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
				    var currMonthMaxDay = startDate.getDate();//本月天数
				    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
				    
					$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
					$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
				}
			});
	 });
	 
	 // 渲染   @author jiangzhidong 20160120  begin
		
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
		
		var initParticipants = function(val,item,index) {
			if(!val) { val = '';}
			if (val == "purchese") return '<i18n:I18n key="test" defaultValue="采购方" />';
			else if (val == "sale") return '<i18n:I18n key="test" defaultValue="销售方" />';
		};
		
		//评分类型   1-百分比   2-合格/不合格
		var initScoreType = function(val,item,index) {
			if(!val) { val = '';}
			if (val == "1") return '<i18n:I18n key="test" defaultValue="百分比" />';
			else if (val == "2") return '<i18n:I18n key="test" defaultValue="合格/不合格" />';
		}; 

		//企业名称
	    var initCompanyName = function (val, item, index){
	    	if(!val) { val = '';}
	    	var name = this.name;
	    	var value = this.value;
			return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
	    }
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
				return '<span style = "color:blue;cursor:pointer"  class = "findSelection"  ><i18n:I18n key="test" defaultValue="查看" /> </span><span style="display: none;">'+JSON.stringify(item)+'</span>';
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
	 
	 //查询
	 $("#queryHeadBtn").click(function(){
		 var formObj = $("#queryForm").serializeJSON();
		 formObj["elsAccount"]=elsAccount;
		 
		 headTable.opts.params = formObj;
		 headTable.load({page:1});
	 });
	 
	window.purchQuery = function() {
		headTable.load({});
	}
	
	
	//确定
	$("#selcetModel").click(function() {
		var selectRows = headTable.selectedRows();
		if(selectRows.length > 0){
			var headRow = selectRows[0];
			parent.frames['iframeApp_'+frameAppId].selectModelCallbackFunc(headRow);
		    parent.elsDeskTop.closeCurWin('findModelInfo');
			
		}else{
			parent.elsDeskTop.closeCurWin('findModelInfo');
		}
	});
 
	   var colst_head = [
	            { title:'<i18n:I18n key="" defaultValue="编号" />', name:'templateNumber', width: 200, align: 'center'},
	        	{ title:'<i18n:I18n key="" defaultValue="名称" />', name:'templateName' ,width:200, align:'center' },
	        	{ title:'<i18n:I18n key="" defaultValue="条例编号" />', name:'regulationNumber' ,width:200,hidden:true,align:'center' },
	        	{ title:'<i18n:I18n key="" defaultValue="描述" />', name:'templateDesc' ,width:200, align:'center' },
	        	{ title:'<i18n:I18n key="i18n_common_title_createuser" defaultValue="创建人" />', name:'createUser' ,width:150, align:'center' },
	        	{ title:'<i18n:I18n key="i18n_fileManage_title_createDate" defaultValue="创建日期" />', name:'createDate' ,width:150, align:'center', renderer:formatDateTime}
	        	];
	   

  	  var GobalparamStr={"elsAccount":elsAccount};
  	  var height=$(document).height()-155;
  	  headTable= $('#headTable').mmGrid({
  	    	 		cols: colst_head,
  	         		url: '<%=basePath%>rest/RegulationService/getTemplateList',
  					params : GobalparamStr,
  					method : 'post',
  					root : "rows",
  					loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
  			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
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
			    });
  	 
  				headTable.on('loadSuccess', function(e, data) {
  					//itemTable.removeRow();
  					if (data.total > 0) {
  						headTable.select(rowIndexSelect);
  						loadItem();
  					} 
  				});

	
	//===========================================表体===========================================
	 var cols_item = [
	                  { title:'条例编号', name:'regulationNumber', width: 200, align: 'center'},
		   	        	{ title:'条例名称', name:'regulationName' ,width:200, align:'center' },
		   	        	{ title:'条例类型', name:'regulationTypeName' ,width:200, align:'center' },
			        	{ title:'条例明细', name:'regulationDetail' ,width:250, align:'center'  },
			        	{ title:'关联选项', name:'selectId' ,width:100, align:'center',renderer: selectRelation },
		   	        	{ title:'参与对象', name:'participants' ,width:200, align:'center',renderer:initParticipants },
		   	        	{ title:'评分类型', name:'scoreType' ,width:200, align:'center',renderer:initScoreType },
		   	        	{ title:'评分账户', name:'scoreAccount' ,width:200, align:'center' },
		   	        	{ title:'评分标准说明', name:'scoreStandard' ,width:200, align:'center' },
		   	        	{ title:'权重', name:'weight' ,width:200, align:'center' },
		   	        	{ title:'输入类型', name:'inputType' ,width:200, align:'center' , renderer:initInputType},
			        	{ title:'是否需要附件', name:'uploadFileFlag' ,width:100, align:'center', renderer:initUploadType},
		   	        	{ title:'创建人', name:'createUser' ,width:150, align:'center' },
		   	        	{ title:'创建日期', name:'createDate' ,width:150, align:'center', renderer:formatDateTime}
	   	       ];
	
		 itemTable = $('#itemTable').mmGrid({
		        cols: cols_item,
		        height: 300,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        multiSelect: true
		    });
		 
		//加载行
		 var loadItem = function() {
		 	    var obj = headTable.selectedRows();
	 	    	if(obj.length<=0){return;}
		 	    var head = obj[0];
		 		$.ajax({
		 			url : '<%=basePath%>rest/RegulationService/getTemplateByNumber' + "?t="+new Date().getTime(),
		 			type : 'POST',
		 			contentType : "application/json",
		 			data : JSON.stringify(head),
		 			dataType : "json",
		 			success : function(data) {
		 				itemTable.load(data.rows);
		 			},
		 			error : function(data) {
		 				if (!permissionError(data)) {
		 					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						}
		 			}
		 		});
		 }
		
			
</script>
</body>
</html>