<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body> 
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="queryHeadBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
				<button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
				<button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
				<button class="button-wrap" id="clauseManagerBtn"><i18n:I18n key="i18n_basicClauseManage_clauseManager" defaultValue="基本条款管理" /></button>
                <%-- <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
                <button class="button-wrap" id="previewPdfBtn"><i18n:I18n key="i18n_title_theOnlinePreview" defaultValue="预览" /></button> --%>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				<i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" />
			</span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_contractTemplate_templateDesc" defaultValue="模板名称" /></span>
					<input type="text" id="templateDesc" name="templateDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_contractTemplate_templateType" defaultValue="模板类型" />:</span>
					<select id="templateType">
						<option value=""><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></option>
						<option value='附件类'>
							<i18n:I18n key="i18n_contractTemplate_attachmentType" defaultValue="附件类" />
						</option>
						<option value='条款类'>
							<i18n:I18n key="i18n_contractTemplate_clauseType" defaultValue="条款类" />
						</option>
					</select>
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_contractTemplate_businessType" defaultValue="业务类型" />:</span>
					<input type="text" id="businessType" name="businessType" />
				</div>
				<br>
                <div class="dis-in-b input-and-tip">
                	<span><i18n:I18n key="i18n_common_title_createdate" defaultValue="创建时间" />:</span>
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="fromCreateDate" name="fromCreateDate"/>
                </div>
                <div class="dis-in-b input-and-tip">
	                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="toCreateDate" name="toCreateDate" />
                </div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_header" defaultValue="表头信息" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100">
							<table id="headTable"></table>
							<div id="headPage" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="合同条款" key="i18n_common_title_contractterms"/></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="合同条款" key="i18n_common_title_contractterms"/></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n defaultValue="附件预览" key="i18n_title_filePreview"/></a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container nest-table">
		                    <div class="grid-100" id="clauseDiv">
		                        <table id="clauseTable"></table>
		                        <div id="clausePage" style="text-align: right;"></div>
		                    </div>
		                </main>
                    </div>
                    <div id="sheet-project-two">
               			<div class="file-scan">
						<div class="file-display" id="file-display">
							<a id="viewerPlaceHolder"></a>
						</div>
					</div>
					</div>
                </div>
            </div>
        </div>
	</div>

<script>
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";
var $sob;

//模板状态
var showTemplateStatus = function (val,item,index){
	//0:无效  1:有效
	if (val == "1") return '<i18n:I18n key="i18n_basicClauseManage_enabled" defaultValue="有效" />'
	else return '<i18n:I18n key="i18n_basicClauseManage_disabled" defaultValue="无效" />'
};

var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="contractTemplateHeadManage"/>;
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ContractManageService/queryContractTemplateHead",
	method :  "POST",
	autoLoad : false,
	cols : headCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : false,
    checkCol : true,
    indexCol : false,
	plugins : [
	    $("#headPage").mmPaginator({
	        style : "plain",
	        totalCountName : "total",
	        page : 1,
	        pageParamName : "currentPage",
	        limitParamName : "pageSize",
	        limitLabel : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	        totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	        limit : null,
	        limitList : [10,20,30,50]
	    })
	]
});

headGrid.on("loadSuccess",function(e, data) {
	if ("undefined" != typeof(data.rows) && data.rows.length > 0) {
		headGrid.select(0);//默认选中第一行
        //初始化聊天控制状态
		loadClause(data.rows[0].elsAccount,data.rows[0].templateNumber,data.rows[0].language,data.rows[0].templateVersion);//根据头表选中项加载行项目信息
		var filePath = data.rows[0].attachmentFilePath;
		if(filePath != ""){
			previewFile(filePath);
		}
	} else {//无Head数据则将clause表清空
		clearClauseTable();
	}
	
});

headGrid.on("cellSelected", function(e, item, rowIndex, colIndex){
	loadClause(item.elsAccount,item.templateNumber,item.language,item.templateVersion);//根据头表选中项加载行项目信息
	var filePath = item.attachmentFilePath;
	if(filePath != ""){
		previewFile(filePath);
	}
});

//点击附件预览
$("#sheet-project ul li").eq(1).click(function(){
	var filePath = headGrid.selectedRows()[0].attachmentFilePath;
	if(filePath != ""){
		previewFile(filePath);
	}
});

var clauseCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="contractTemplateClauseManage"/>;
var clauseGrid = $("#clauseTable").mmGrid({
    url : "${pageContext.request.contextPath}/rest/ContractManageService/queryContractTemplateClause",
    method:  "POST",
    autoLoad : false,
    cols : clauseCols,
    root:"rows",
    loadingText: "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
    noDataText: "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
    plugins: [
        $("#clausePage").mmPaginator({
            style: "plain",
            totalCountName: "total",
            page: 1,
            pageParamName: "currentPage",
            limitParamName: "pageSize",
            limitLabel: "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
            totalCountLabel: "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
            limit:null,
            limitList: [10,20,30,50]
        })
    ]
});

$(document).ready(function(){
	init();
});

$("#queryHeadBtn").click(function(){
	refreshHead();
});

$("#addBtn").click(function(){
	parent.elsDeskTop.defineWin({
        iconSrc : "icon/icon9.png",
        windowsId : "contractTemplateAdd",
        windowTitle : "<i18n:I18n defaultValue='新建合同模板' key=''/>",
        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/contractTemplateAdd.jsp",
        showAdv : true,
        windowStatus : "maximized",
        windowMinWidth : 960,
        windowMinHeight : 700,
        windowWidth : 960,
        windowHeight : 700,
        parentPanel : ".currDesktop"
    });
});

$("#updBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var status = headRecord.status;
		var createElsAccount = headRecord.elsAccount;//subAccount_name
		var createUser = headRecord.createUser;//subAccount_name
		if( status == "1"){
			if(elsAccount == createElsAccount && userName == createUser){
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "contractTemplateUpd",
			        windowTitle : "<i18n:I18n defaultValue='修改合同模板' key=''/>",
			        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/contractTemplateUpd.jsp?"
			        		+"elsAccount="+headRecord.elsAccount
			        		+"&templateNumber="+headRecord.templateNumber
			        		+"&language="+headRecord.language
			        		+"&templateVersion="+ headRecord.templateVersion,
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
			} else {
				alert("<i18n:I18n defaultValue='非模板创建人,禁止修改' key=''/>",2);
			}
		} else {
			alert("<i18n:I18n defaultValue='模板已无效' key=''/>",2);
		}
	}
});

$("#delBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var status = headRecord.status;
		var createElsAccount = headRecord.elsAccount;//subAccount_name
		var createUser = headRecord.createUser;//subAccount_name
		if(elsAccount == createElsAccount && userName == createUser){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/ContractManageService/delContractTemplate",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(selectRows),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
						refreshHead();
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='删除出错' key='i18n_delivery_deletefail'/>",3);
					}
				});
			}});
		} else {
			alert("<i18n:I18n defaultValue='非模板创建人,禁止删除' key=''/>",2);
		}
	}
});

$("#previewPdfBtn").click(function(){
	
});
//基本条款管理
$("#clauseManagerBtn").click(function(){
			parent.elsDeskTop.defineWin({
		        iconSrc : "icon/icon9.png",
		        windowsId : "clauseManage",
		        windowTitle : "<i18n:I18n defaultValue='条款管理' key='i18n_basicClauseManage_clauseManager'/>",
		        iframSrc : "${pageContext.request.contextPath}/contractmanage/purchase/basicContractClauseManage.jsp",
		        showAdv : true,
		        windowStatus : "maximized",
		        windowMinWidth : 960,
		        windowMinHeight : 700,
		        windowWidth : 960,
		        windowHeight : 700,
		        parentPanel : ".currDesktop"
		    });
	});
//初始化控件
function init() {
    $("button").button();
    $("#sheet-project").tabs();
    var currDate = new Date();
    var startOrderDate = new Date();
    var currDateMill = startOrderDate.getTime();
    startOrderDate.setMonth(startOrderDate.getMonth()+1, 0);//本月最后一日
    var currMonthMaxDay = startOrderDate.getDate();
    startOrderDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
    $("#fromCreateDate").val(startOrderDate.format('yyyy-MM-dd'));
    $("#toCreateDate").val(currDate.format("yyyy-MM-dd"));
    
    refreshHead();
}

function refreshHead(){
	var templateDesc = $("#templateDesc").val();
    var templateType = $("#templateType").val();
    var businessType = $("#businessType").val();
    var fromCreateDate = $("#fromCreateDate").val();
	var toCreateDate = $("#toCreateDate").val();
	
	var queryParam = {
    	elsAccount : elsAccount,
    	templateDesc : templateDesc,
    	templateType : templateType,
    	businessType : businessType,
    	fromCreateDate : fromCreateDate,
    	toCreateDate : toCreateDate
    };
	$.extend(headGrid.opts.params,queryParam);
    headGrid.load();
}

function loadClause(elsAccount,templateNumber,language,templateVersion){
	var queryParam = {
    	elsAccount : elsAccount,
    	templateNumber : templateNumber,
    	language : language,
    	templateVersion : templateVersion
    };
	$.extend(clauseGrid.opts.params,queryParam);
	clauseGrid.load();
}

function clearClauseTable(){
	if(clauseGrid.rowsLength() > 0){
		for(var i=clauseGrid.rowsLength();i-1>=0;i--){
			clauseGrid.removeRow(i-1);
		}
	}
}
//在线预览文件
function previewFile(filePath){
	var showDiv = $("#file-display");
	var viewerPlaceA = $("#viewerPlaceHolder");
	viewerPlaceA.empty();
	var param = {
			elsAccount : elsAccount,
			filePath : filePath
	};   	
	if(isSupportImage(filePath)){//系统支持的图片,直接显示
		showDiv.css("overflow","auto");
		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
	} else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
    	$.ajax({
			url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
			type :"POST",
			data : JSON.stringify(param),
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				var resStatus = data.statusCode;
				var message = data.message;
				if("200" == resStatus){
					var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
					var width=$("#file-display").width();
					var height=$("#file-display").height();
					$("#viewerPlaceHolder").css("width",width+"px");  
					$("#viewerPlaceHolder").css("height",height+"px");  
					$("#viewerPlaceHolder").css("display","block" );  

					var fp = new FlexPaperViewer(
					            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
					            'viewerPlaceHolder', 
					            {config : {
					                SwfFile : swfPath,//要显示的swf文件位置(相对根目录)
					                Scale : 1.5,//初始化缩放比例(1=100%)
					                ZoomTransition : 'easeOut',//缩放样式,默认easeOut,其他可选值easenone,easeout,linear,easeoutquad
					                ZoomTime : 0.5,//切换缩放比例延迟显示时间
					                ZoomInterval : 0.2,//缩放比例值间隔,默认0.1
					                FitPageOnLoad : false,//初始化时自适应页面
					                FitWidthOnLoad : false,//初始化时自适应宽度
					                FullScreenAsMaxWindow : false,//全屏时是否打开新窗口,为true时单击全屏按钮,打开一个Flexpaper最大化的新窗口而不是全屏页面
					                ProgressiveLoading : true,//是否逐步加载文档,为true时展示文档不会加载完整个文档而是逐步加载(需要文档转化为9以上版本才支持)
					                MinZoomSize : 0.2,//最小缩放比例
					                MaxZoomSize : 5,//最大缩放比例
					                SearchMatchAll : false,//搜索时是否高亮显示所有符合条件的地方
					                InitViewMode : 'Portrait',//启动模式 portrait,SinglePage,TwoPage...
					                ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
					                ZoomToolsVisible : true,//工具浪是否显示缩放工具
					                NavToolsVisible : true,//工具栏是否显示导航工具
					                CursorToolsVisible : true,//工具栏是否显示光标
					                SearchToolsVisible : true,//工具栏是否显示搜索工具
					                localeChain: 'zh_CN'//地区语言(en_US:English,)
					            	}
					            });
				} else {
					alert(message,3); 
				}
			},
			error : function(data) {
				alert(data.message,3); 
			}
		});
	} else {
		alert("<i18n:I18n defaultValue='不支持在线预览的文档类型' key='i18n_alert_filetypenotsupport'/>!",3);
	}
}
</script>
</body>
</html>