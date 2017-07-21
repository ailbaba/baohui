<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	 <div>
	 <div class="box-wrap pos-relative bg-common" >
            <span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
            <div class="common-box-line">
            	<div class="dis-in-b input-and-tip"> 
					<button id="queryOrgCategoryBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
				</div>
				<div class="dis-in-b input-and-tip"> 
					<button id="queryOrgCategoryOKBtn" class="button-wrap">确定</button>
				</div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common" >
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查询条件" key="i18n_additionCost_queryCondition"/></span>
            <div class="common-box-line">
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="组织类别" key=""/>:</span>
					<input type="text" id="queryOrgCategoryId" />
				</div>
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="组织类别名称" key=""/>:</span>
					<input type="text" id="queryOrgCategoryDesc" />
				</div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <main class="bg-common p-6">
                   <div class="grid-100" >
                       <table id="queryOrgCategoryTable"></table>
                   </div>
             </main>
        </div>
    </div>
<script type="text/javascript">
	/**
	 * 页面初始化,直接打开窗口
	 var obj={
				windowTitle: '组织架构',
				data:{"parentWinId":"orgInfoManage"},//传递上一级的窗口iframe id用parentWinId,其他数据自定
				windowMaximize: false,
				windowMinimize: false,
				windowStatus: 'regular',
				windowWidth: 639,
				windowHeight: 480,
				iframSrc: 'OrgStructure.jsp',
				windowsId: 'OrgStructure_select' 
			};
			parent.elsDeskTop.defineWin(obj)
	 */
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	$(document).ready(function() {
		/**
		 * 获取iframe 传参
		 */
		var parentParam = getIframeData() || {};
		/**
		 *组织架构数据初始化
		 */
		var orgCategoryCols = [
        		{ title:"<i18n:I18n defaultValue='组织类别' key=''/>", name:"orgCategoryId" , width:150, align:"center"},
        		{ title:"<i18n:I18n defaultValue='组织类别名称' key=''/>", name:"orgCategoryDesc" , width:200, align:"center"},
        		{ title:"<i18n:I18n defaultValue='备注' key=''/>", name:"remark" , width:200, align:"center"},
            ];
		var initParams = {
				elsAccount : elsAccount,
				orgCategoryId : '',
				orgCategoryDesc : '',
				pageSize : 1000,
		  };
		var orgCategoryGrid = $("#queryOrgCategoryTable").mmGrid({
			cols : orgCategoryCols,
			url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/queryOrganizationCategory",
			params: initParams,
			autoLoad : true,
			method : "post",
			root : "rows",
			loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
			noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
			multiSelect : false,
			checkCol : true,
			indexCol : true
		});
		/**
		 * 查询
		 */
		 $("#queryOrgCategoryBtn").click(function(){
			 var queryOrgCategoryId = $("#queryOrgCategoryId").val();
			 var queryOrgCategoryDesc = $("#queryOrgCategoryDesc").val();
			 var params = {
					elsAccount : elsAccount,
					orgCategoryId : queryOrgCategoryId,
					orgCategoryDesc : queryOrgCategoryDesc,
					pageSize : 1000,
			  };
			  orgCategoryGrid.load(params);
			});
		/**
		 * 确认提交()
		 */
		 $('#queryOrgCategoryOKBtn').click(function() {
			 var ifSelect = orgCategoryGrid.selectedRows();
			 if(ifSelect&&ifSelect.length) {
				 parent.elsDeskTop.closeCurWin("OrgStructure_select",callFunction); 
			 } else {
				 parent.elsDeskTop.tip.init({"type": 'alert',"displayType":2,"message":"您还没选择组织成员"})
			 }
		 });
	 	/**
		 * 页面初关闭后回调函数,将选中的表数据带回上一级页面hadSelected
		 */
		 function callFunction(){
				if(parentParam) {
					var hadSelected = orgCategoryGrid.selectedRows();
					var strId=parentParam.parentWinId
					var iframeId = "iframeApp_"+strId;
					if (parent.frames[iframeId]) {
						parent.frames[iframeId].selectOrgInfo(hadSelected);
					}
				}
				
			}
	});
</script>
</body>
</html>