<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%
String assessmentNumber = request.getParameter("assessmentNumber");
String toElsAccount = request.getParameter("toElsAccount");
%>
<body>
	<div class="pos-relative public-wrap">
		  <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
            </div>
        </div>
		
		 <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="test" defaultValue="历史行信息" /></span>
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
	 var isloadItemGrid = false;
	 var assessmentNumber='<%=assessmentNumber%>';
	 var toElsAccount='<%=toElsAccount%>';
	 
	
	 //初始化记载信息 
	 $(document).ready(function(){
		 loadItem()
	 });
	 
	 // 渲染   @author jiangzhidong 20160120  begin
		//日期
		var formatDate = function (val, item, index){
			if (!val) {val = "";}
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
			return val;
		};
	 // 渲染   @author jiangzhidong 20160120  end
	 
	 //退出
	 $("#exitBtn").click(function(){
		 parent.elsDeskTop.closeCurWin('assessmentSupplyMarkSub');
	 });
	 
	 var item_cols = [{ title:'供应商编码', name:'toElsAccount', width: 80, align: 'center'},
	                  { title:'评估编号', name:'assessmentNumber', width: 120, align: 'center'},
              	      { title:'评估模板编号', name:'assessmentTemplateNumber' ,width:100, align:'center' },
              	      { title:'评估类型编号', name:'assessmentClassNumber' ,width:100, align:'center' },
              	 	  { title:'评估项编号', name:'assessmentItemNumber' ,width:100, align:'center' },
              		  { title:'评估类型名', name:'assessmentClassName' ,width:100, align:'center' },
           	          { title:'规则名', name:'assessmentItemName' ,width:150, align:'center' },
           	          { title:'权重%', name:'share' ,width:100, align:'center' },
           	          { title:'评分', name:'grades' ,width:140, align:'center'},
				      { title:'实计评分', name:'meterScores' ,width:70, align:'center' },           	          
           	          { title:'说明', name:'remark' ,width:100, align:'center'},
           	          { title:'时间戳', name:'logtime' ,width:100, align:'center',renderer:formatDate}];

	 
	//历史记录
	 function loadItem() {
	    
		 var paramStr={"elsAccount":elsAccount,
				   "assessmentNumber":assessmentNumber,
				   "toElsAccount":toElsAccount};
		
	     if(!isloadItemGrid){
	 		isloadItemGrid = true;
	 		 itemGrid = $('#itemTable').mmGrid({
	 				height: 300,
	 		        cols: item_cols,
	 		        url: '<%=basePath%>rest/PurchaseEnquiryAssessmentService/querySupplierAssessmentTemplateContentSubByCondtion/'+elsAccount,
	 		        params: paramStr,
	 		        method:  'POST',
	 		        root:"rows",
	 		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	 		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	 		        plugins: [
	 		            $('#pg-price').mmPaginator({
	 		                style: 'plain'
	 		                , totalCountName: 'total'
	 		                , page: 1
	 		                , pageParamName: 'currentPage'
	 		                , limitParamName: 'pageSize'
	 		                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
	 		  	            , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
	 		                , limit:null
	 		                , limitList: [5,10,15,20]
	 		            })
	 		        ]
	 		    });
	 	}else{
	 		itemGrid.load(paramStr);
	 	}
	     
	}; 
			
		 

		</script>
</body>
</html>