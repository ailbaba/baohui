<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	 <div>
	 <div class="box-wrap pos-relative bg-common" >
            <span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
            <div class="common-box-line">
            	<div class="dis-in-b input-and-tip"> 
					<button id="queryUpperOrgCategoryBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query"/></button>
				</div>
				<div class="dis-in-b input-and-tip"> 
					<button id="queryUpperOrgCategoryOKBtn" class="button-wrap">确定</button>
				</div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common" >
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查询条件" key="i18n_additionCost_queryCondition"/></span>
            <div class="common-box-line">
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="上级组织类别" key=""/>:</span>
					<input type="text" id="queryUpperOrgCategoryId" />
				</div>
            	<div class="dis-in-b input-and-tip"> 
					<span><i18n:I18n defaultValue="上级组织类别名称" key=""/>:</span>
					<input type="text" id="queryUpperOrgCategoryDesc" />
				</div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <main class="bg-common p-6">
                   <div class="grid-100" >
                       <table id="queryUpperOrgCategoryTable"></table>
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
				windowsId: 'upperOrgStructure_select' 
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
		var upperOrgCategoryCols = [
        		{ title:"<i18n:I18n defaultValue='上级组织类别' key=''/>", name:"upperOrgCategoryId" , width:150, align:"center"},
        		{ title:"<i18n:I18n defaultValue='上级组织类别名称' key=''/>", name:"upperOrgCategoryDesc" , width:200, align:"center"},
        		{ title:"<i18n:I18n defaultValue='备注' key=''/>", name:"remark" , width:200, align:"center"},
            ];
		var initParams = {
				elsAccount : elsAccount,
				fbk1 : '',
				fbk2 : '',
				pageSize : 1000,
		  };
		var upperOrgCategoryGrid = $("#queryUpperOrgCategoryTable").mmGrid({
			cols : upperOrgCategoryCols,
			url : "${pageContext.request.contextPath}/rest/ElsOrganizationService/queryUpperOrganizationCategory",
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
		 $("#queryUpperOrgCategoryBtn").click(function(){
			 var fbk1 = $("#queryUpperOrgCategoryId").val();
			 var fbk2 = $("#queryUpperOrgCategoryDesc").val();
			 var params = {
					elsAccount : elsAccount,
					fbk1 : fbk1,
					fbk2 : fbk2,
					pageSize : 1000,
			  };
			 upperOrgCategoryGrid.load(params);
			});
		/**
		 * 确认提交()
		 */
		 $('#queryUpperOrgCategoryOKBtn').click(function() {
			 var ifSelect = upperOrgCategoryGrid.selectedRows();
			 if(ifSelect&&ifSelect.length) {
				 parent.elsDeskTop.closeCurWin("upperOrgStructure_select",callFunction); 
			 } else {
				 parent.elsDeskTop.tip.init({"type": 'alert',"displayType":2,"message":"您还没选择上级组织成员"})
			 }
		 });
	 	/**
		 * 页面初关闭后回调函数,将选中的表数据带回上一级页面hadSelected
		 */
		 function callFunction(){
				if(parentParam) {
					var hadSelected = upperOrgCategoryGrid.selectedRows();
					var strId=parentParam.parentWinId
					var iframeId = "iframeApp_"+strId;
					if (parent.frames[iframeId]) {
						parent.frames[iframeId].selectUpperOrgInfo(hadSelected);
					}
				}
				
			}
	});
</script>
</body>
</html>