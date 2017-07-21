<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<base:supplierAuth elsAccount="${elsAccount }" authCode="enquiry" toElsAccount="${param['toElsAccount'] }"></base:supplierAuth>
<body>
<div class="box-wrap pos-relative bg-common">
       <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="enquirySeachBtn" class="button-wrap" ><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                <button id="deleteBtn" class="button-wrap">删除</button>
                <button id="addTemplate" class="button-wrap"><i18n:I18n key="test" defaultValue="新建模板" /></button>
                <button class="button-wrap" id="affirmBtn"><i18n:I18n key="test" defaultValue="生成招标" /></button>
                <%--
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                --%>
            </div>
        </div>
        <form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <input type="hidden" id="elsAccount" name="elsAccount"/>
            <input type="hidden" id="elsSubAccount" name="elsSubAccount"/>
            <input type="hidden" id="pageSize" name="pageSize" value="10">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
			<div class="common-box-line">
				<div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="test" defaultValue="招标模板编号名称" />：</span>
						<input id="biddingNumber" name="biddingNumber" type="text" />
					</div>
				</div>
			</div>
		</div>
	   </form>
		
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100"  id="biddingHeaderGrid">
                        <table id="biddingManageTable"></table>
                        <div id="biddingPage" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
	</div>
</body>
<script>

window.beforeClose=function(close){
	// 做其他处理
	//top.elsDeskTop.closeCurWin('biddingEvalTempSel');
	close();
};
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var biddingManageTable;
var biddingNumberArr = [];
$(document).ready(function() {
	    $("#elsAccount").val(elsAccount);
		var frm = $("#queryForm");
		var frmObj = frm.serializeJSON();

		//渲染议价/查看按钮
		function enquiryHandle(val, item, rowIndex) {
			var text = '<span class="enquiry-detail bidding-detail" style="color:blue;"><i18n:I18n key="test" defaultValue="详情" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			return text;
		}
		function biddingMngRender(val, item, rowIndex) {
			if (!val) {val = "";}
			/* val = hasNextRowView(item, rowIndex) ? val : ""; */
			return val;
		}
		var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="biddingPurchaseTemplateManage_mt"/>;
         biddingManageTable =  $('#biddingManageTable').mmGrid({
             cols: cols,
             url:"<%=basePath%>rest/PurchaseBiddingService/findTemplateList/",
             method: 'post',
             params: frmObj,
             height:400,
             loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
             noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
             root: 'rows',
             multiSelect : false,
             checkCol: true,
             remoteSort:true,
             plugins: [
             $('#biddingPage').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                  , limit: null
                  , limitList: [10, 30, 40, 50]
             })
             ]
         });
         var mkPatchLoad = biddingManageTable._loadAjax;
         biddingManageTable._loadAjax = function() {
        	 biddingNumberArr = [];
        	 mkPatchLoad.call(biddingManageTable);
         };
        biddingManageTable.opts.params = frmObj;
		biddingManageTable.load({page:1});
});
		// 采购招标模板明细查看
		$('.bidding-detail').live("click", function() {
	            var scanCol = $(this).next();
	            var sanContent = scanCol.text();
	            var item = JSON.parse(sanContent);
	        	//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
			        'windowsId':'addBiddingOneTemplate',
			        'windowTitle':'<i18n:I18n key="test" defaultValue="采购招标模板明细查看" />',
			        'windowSubTitle': companyShortName,
			        'iframSrc':'<%=basePath%>biddingmanage/purchase/addBiddingOneTemplate.jsp?biddingNumber='+item.biddingNumber,
			        'showAdv': false,
			        'windowStatus': 'maximized',
			        'windowMinWidth': 960,
			        'windowMinHeight': 700,
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop"
			    });
	        	
	     });
		
		window.purchQuery = function() {
			var frm = $("#queryForm");
			biddingManageTable.opts.params = frm.serializeJSON();
			biddingManageTable.load({page:1});
		}
        //设置条件查询
		$("#enquirySeachBtn").click(function(){
			purchQuery();
		});
        
	 //列自定义
$("#columnDefineBtn").click(function(){
	parent.elsDeskTop.defineWin({
	    'iconSrc':'icon/els-icon.png',
	    'windowsId':'subAccountColumnSetting',
	    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
	    windowSubTitle: "",
	    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=biddingPurchaseManage_mt" + "&window=iframeApp_biddingPurchaseManage_mt",
	    windowMinWidth: 480,
	    windowMinHeight: 600,
	    'windowWidth':480,
	    'windowHeight':600,
	    'parentPanel':".currDesktop"
	 });
});

//删除招投标信息
$("#deleteBtn").live("click",function(){
	var selectedRecords = biddingManageTable.selectedRows();
	if("undefined" != typeof(selectedRecords) && selectedRecords != "" && selectedRecords != "[]"){
		var selectedRecord = selectedRecords[0];
		var biddingNumber = selectedRecord.biddingNumber;
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="" defaultValue="是否确认删除？" />',closeEvent:function(){
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : '<%=basePath%>rest/PurchaseBiddingService/deleteBiddingByPrimaryKey',
				type : 'POST',
				contentType : "application/json",
				data : JSON.stringify({"elsAccount":elsAccount,"biddingNumber":biddingNumber}),
				dataType : "json",
				success : function(data) {
	    			alert("删除招投标模板成功!",1);
	    			purchQuery();
	    		},error : function(data) {
	    			alert("删除招投标模板失败!",3);
	    		},complete : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    		}
			});
		}});
	}else {
		alert("请选择删除招投标行",2);
	}
});

//打开新增采购招标模板页面
$("#addTemplate").click(function(){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
        'windowsId':'addBiddingOneTemplate',
        'windowTitle':'新增招投标模板',
        windowSubTitle: companyShortName,
        'iframSrc':'<%=basePath%>biddingmanage/purchase/addBiddingOneTemplate.jsp',
        windowStatus: 'maximized',
        windowMinWidth: 960,
        windowMinHeight: 700,
        'windowWidth':960,
        'windowHeight':700,
        'parentPanel':".currDesktop"
    });
});
function rendererBiddingType(val, item, rowIndex){
		if(val==0){
    		return '<i18n:I18n key="test" defaultValue="邀请招标" />';
    	}else if(val==1){
    		return '<i18n:I18n key="test" defaultValue="公开招标" />';
    	}else if(val==2){
    		return '<i18n:I18n key="test" defaultValue="在线竞标-邀请" />';
    	}else if(val==3){
    		return '<i18n:I18n key="test" defaultValue="在线竞标-公开" />';
    	}else if(val==4){
    		return '<i18n:I18n key="test" defaultValue="暂定招标-邀请" />';
    	}else if(val==5){
    		return '<i18n:I18n key="test" defaultValue="暂定招标-公开" />';
    	}else if(val==6){
    		return '<i18n:I18n key="test" defaultValue="竞争性谈判" />';
    	}else{
    		return '<i18n:I18n key="test" defaultValue="邀请招标" />';
    	}
}
function formatDate(val){
	if (!val) {val = "";}
	if (val!=""&&val.length != 10) {
		val = new Date(val).format("yyyy-MM-dd");
	}
	return val;
}

var formatDateTime = function (val,item,index){
	if (!val) {val = "";}
	if (val!=""&&val.length != 19) {
		val = new Date(val).format("yyyy-MM-dd hh:mm:ss");
	}
    return val;
};
$("#affirmBtn").live("click",function(){
	var templateRecords = biddingManageTable.selectedRows();
	if(null != typeof(templateRecords) && templateRecords != "" && templateRecords != "[]"){
		var item = templateRecords[0];
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
	        'windowsId':'addBiddingThree',
	        'windowTitle':'<i18n:I18n key="test" defaultValue="采购招标明细查看" />',
	        'windowSubTitle': companyShortName,
	        'iframSrc':'<%=basePath%>biddingmanage/purchase/addBiddingThree.jsp?biddingNumber='+item.biddingNumber+
	        '&biddingStatus=0'+'&type=from_template',
	        'showAdv': false,
	        'windowStatus': 'maximized',
	        'windowMinWidth': 960,
	        'windowMinHeight': 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}else {
		alert("请选择招标模板行!",2);
	}
});
</script>

</html>