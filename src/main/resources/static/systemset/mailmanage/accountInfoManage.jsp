<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n defaultValue="基本操作" key="i18n_common_title_baseoperation" />
			</span>
			<div class="common-box-line">
				<button id="queryHeadBtn" class="button-wrap"><i18n:I18n defaultValue="查询" key="i18n_common_button_query" /></button>
				<button id="addBtn" class="button-wrap"><i18n:I18n defaultValue="新建" key="i18n_common_button_create" /></button>
				<button id="updBtn" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_button_update" /></button>
				<button id="delBtn" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_button_delete" /></button>
				<button id="columnDefineBtn" class="button-wrap"><i18n:I18n defaultValue="列自定义" key="i18n_common_button_columncustom" /></button>
			</div>
		</div>

       <form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
				<span class="dis-in-b pos-absolute box-tip bg-common">
					<i18n:I18n defaultValue="条件查询" key="i18n_common_title_conditionquery" />
				</span>
				<div class="common-box-line">
					<div class="dis-in-b input-and-tip">
						<span>邮箱账号：</span>
						<input id="mailAccount" name="mailAccount" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span>邮箱类型：</span>
						<select class="mailType" id="mailType" name="mailType">
				            <option value="">请选择</option>	
				            <option value="0">POP3</option>	
				            <option value="1">IMAP</option>		
				            <option value="2">SMTP</option>				
					    </select>
					</div>
				</div>
		</div>
		</form>
			
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n defaultValue="邮箱帐号列表" key="i18n_title_smsTemplate_list" />
			</span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100">
					<table id="headTable"></table>
					<div id="headPage" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>
	</div>
<script type="text/javascript">
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	
	// 渲染   @author jiangzhidong 20160314  begin
	//日期
	var formatDate = function (val, item, index){
		if (!val) {val = "";}
		if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
		return val;
	};
	
	//邮箱类型
	var initMailType = function(val, item, index){
		//if(!val) { val = '';}
		return ["POP3","IMAP","SMTP"][parseInt(val)];
	};
	// 渲染   @author jiangzhidong 20160314  end
	
	//列
	var headCols = [ 
			         { title:'邮箱类型'     , name:'mailType'        ,width:80   , align:'center'  , renderer:initMailType}, 
			         { title:'邮箱账号'     , name:'mailAccount'     ,width:220  , align:'center' },
			         { title:'收件服务器'   , name:'receiptServer'   ,width:150  , align:'center' },	
			         //{ title:'收件SSL选中值'  , name:'receiptSslCheck'  ,width:80   , align:'center'},
			         { title:'收件SSL端口'  , name:'receiptSslPort'  ,width:80   , align:'center' },
			         { title:'发件服务器'   , name:'sendServer'      ,width:150  , align:'center'},
			         //{ title:'发件SSL选中值'   , name:'sendSslCheck'      ,width:150  , align:'center' },
			         { title:'发件SSL端口'  , name:'sendSslServer'   ,width:80   , align:'center' },
			         { title:'企业ELS'      , name:'elsAccount'      ,width:120  , align:'center' },
			         { title:'个人账号'     , name:'elsSubAccount'   ,width:100  , align:'center' },
			         { title:'个人邮箱'     , name:'email'           ,width:220  , align:'center' },
			         { title:'创建人'     , name:'createUser'        ,width:120  , align:'center' },
			         { title:'创建时间'   , name:'createDate'        ,width:120  , align:'center' ,renderer:formatDate},
			         { title:'备注'      , name:'remark'      ,width:150  , align:'center' },];

	var frm = $("#queryForm");
	var frmObj = frm.serializeJSON();
	frmObj["elsAccount"] = elsAccount;
	
	var headGrid =  $('#headTable').mmGrid({
		cols: headCols,
		url: '<%=basePath%>rest/MailInfoManageService/queryMailAccountInfoList',
        method: 'post',
        params: frmObj,
        height: 350,
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        root: 'rows',
        indexCol: true,
        checkCol:true,
        plugins: [
            $('#headPage').mmPaginator({
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
	
	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
		
	}
	
	//查询
	$("#queryHeadBtn").click(function(){
	    var formObj = $("#queryForm").serializeJSON();
		formObj["elsAccount"]=elsAccount;
		headGrid.opts.params = formObj;
		headGrid.load({page:1});
	});
	
	//下拉
	$(".mailType").change(function(){
	    var formObj = $("#queryForm").serializeJSON();
		formObj["elsAccount"]=elsAccount;
		headGrid.opts.params = formObj;
		headGrid.load({page:1});
	});
	
	$("#addBtn").click(function(){
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "accountInfoManageAdd",
	        windowTitle : "新建邮箱帐号",
	        iframSrc : "${pageContext.request.contextPath}/systemset/mailmanage/accountInfoManageAdd.jsp",
	        showAdv : true,
	        windowStatus : "regular",
	        windowMinWidth : 600,
	        windowMinHeight : 500,
	        windowWidth : 600,
	        windowHeight : 500,
	        parentPanel : ".currDesktop"
	    });
	});
	
	$("#updBtn").click(function(){
		var head = headGrid.selectedRows();
		if(head.length<=0){
			alert("必须选择一行！",2);
			return;
		}
		var accountId = head[0].accountId;
		var mailAccount = head[0].mailAccount;
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "accountInfoManageUpd",
	        windowTitle : "修改邮箱帐号",
	        iframSrc : "${pageContext.request.contextPath}/systemset/mailmanage/accountInfoManageUpd.jsp?accountId=" + accountId
	        		+"&mailAccount=" + mailAccount,
	        showAdv : true,
	        windowStatus : "regular",
	        windowMinWidth : 600,
	        windowMinHeight : 500,
	        windowWidth : 600,
	        windowHeight : 500,
	        parentPanel : ".currDesktop"
	    });
	});
	
	$("#delBtn").click(function(){
		var selectRows = headGrid.selectedRows();
		var selectRow = selectRows[0];
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			parent.elsDeskTop.tip.init({type:"confirm",message:"是否确认删除?",closeEvent:function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/MailInfoManageService/deleteMailAccountInfo",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(selectRow),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type:"alert",displayType:1,message:"删除成功!"});
						headGrid.load({});
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type:"alert",message:"删除失败!"});
					}
				});
			}});
		}else {
			parent.elsDeskTop.tip.init({type : "alert",displayType : 2,message : "请选择删除邮箱帐号单!"});
		}
	});
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    iconSrc : "icon/els-icon.png",
		    windowsId :"subAccountColumnSetting",
		    windowTitle :"列自定义",
		    windowSubTitle : "",
		    iframSrc : "${pageContext.request.contextPath}/tablecolumn/subAccountColumnSetting.jsp?elsAccount=" + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=smsTemplateManage&window=iframeApp_smsTemplateManage",
		    showAdv : true,
		    advArr : ["icon/test-car.png","icon/test-car2.png"],
		    windowMinWidth : 480,
		    windowMinHeight : 600,
		    windowWidth :480,
		    windowHeight :600,
		    parentPanel : ".currDesktop"
		});
	});
	
	//回调
	window.purchQuery = function() {
		headGrid.load({});
	}
</script>
</body>
</html>