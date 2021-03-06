<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="查看密码更改记录" key="i18n_account_button_passwordrecord"></i18n:I18n></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="RecordGrid">
							<table id="recordTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 对话框 -->
		<script>
	var elsAccount=GetQueryString("elsAccount");
	var elsSubAccount=GetQueryString("elsSubAccount");
	 var RecordGrid;
	 
	function initGrid(){
		$('#RecordGrid').html('<table id="recordTable"></table><div id="pg" style="text-align: right;"></div>');
		//列
	    var cols = [
	        {title:'<i18n:I18n defaultValue="ELS账号" key="i18n_label_elsAccount"></i18n:I18n>', name:'elsAccount', width: 120, align: 'center'},
	        {title:'<i18n:I18n defaultValue="个人账号" key="i18n_label_elsSubAccount"></i18n:I18n>', name:'elsSubAccount' ,width:120, align:'center' },
	        {title:'<i18n:I18n defaultValue="账号姓名" key="i18n_common_title_username"></i18n:I18n>', name:'userName', width: 120, align: 'center'},
	        {title:'<i18n:I18n defaultValue="更新时间" key="i18n_common_title_lastupdate"></i18n:I18n>', name:'passWordUpdateDate' ,width:125, align:'center', renderer:function(val){
 		    	if (!val) 
	        		return "";
	        	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
 		    }},
 		   {title:'<i18n:I18n defaultValue="更新账号" key="i18n_password_title_updateAccount"></i18n:I18n>', name:'passWordUpdateAccount', width: 120, align: 'center'},
 		  {title:'<i18n:I18n defaultValue="更新用户" key="i18n_password_title_updateUser"></i18n:I18n>', name:'passWordUpdateUser', width: 120, align: 'center'},
	    ];

		var paramStr={"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};

		var height=$(document).height()-155;
	     RecordGrid= $('#recordTable').mmGrid({
	    	 cols: cols,
	         url: '<%=basePath%>rest/PassWordService/getPassWordRecordList',
					params : paramStr,
					method : 'post',
					root : "rows",
					loadingText : '<i18n:I18n defaultValue="正在载入" key="i18n_common_mmgrid_loadingtext"></i18n:I18n>',
					noDataText : '<i18n:I18n defaultValue="暂无数据" key="i18n_common_mmgrid_nodatatext"></i18n:I18n>',
					checkCol : true,
					plugins : [ $('#pg').mmPaginator({
						style : 'plain',
						totalCountName : 'total',
						page : 1,
						pageParamName : 'currentPage',
						limitParamName : 'pageSize',
						limitLabel : '<i18n:I18n defaultValue="每页{0}条" key="i18n_common_mmgrid_limitlabel"></i18n:I18n>',
						height:height,
						totalCountLabel : '<i18n:I18n defaultValue="共<span>{0}</span>条记录" key="i18n_common_mmgrid_totalcountlabel"></i18n:I18n>',
						limit : null,
						limitList : [ 10, 20 ]
					}) ]
				});

				RecordGrid.on('loadSuccess', function(e, data) {
					if (data.total > 0) {
						RecordGrid.select(0);
					}
				});
			}

			 //初始化加载信息 
			$(document).ready(function(){
			
				initGrid();      //初始化表格数据和事件 
			});

			//关闭对话框
			$("#cancelBtn,.dialog-close-btn").click(function() {
				$('.fixed-dialog').hide();
			});
			
		</script>
</body>
</html>