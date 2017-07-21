<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
    <div class="pos-relative public-wrap">
        <div id="btnArea" class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="commitBtn" class="button-wrap">提交</button>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_sry" defaultValue="设计文档" /></span>
            <div class="common-box-line">
                <form style="margin:0;" id="form" onsubmit="return false;">
            	<input type="hidden" name="elsAccount" value="${elsAccount}"/>
            	<input type="hidden" name="elsSubAccount" value="${elsSubAccount}"/>
            	<input type="hidden" name="userName" value="${username}"/>
            	<input type="hidden" id="toElsAccount" name="toElsAccount"/>
            	<input type="hidden" id="designNumber" name="designNumber"/>
            	<input type="hidden" id="changeContentHidden" name="changeContent"/>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">供应商响应状态: </span>
            	<select id="statusConfirm" name="statusConfirm">
            	   <option value="1">接受</option>
            	   <option value="2">拒绝</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">供应商备注: </span>
            	<input type="text" id="fbk1" name="fbk1" style="max-width:384px;width:384px;"/></div>
            	<br>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计师: </span>
                <input type="text" id="designer" readonly /></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">采购员: </span>
                <input type="text" id="purchaseInCharge" readonly /></div>
                <div class="dis-in-b input-and-tip"><span class="text-right w-72">设计单号: </span>
                <input type="text" id="designNum" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">物料编码: </span>
            	<input type="text" id="materialNumber" name="materialNumber" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">物料名称: </span>
            	<input type="text" id="materialDesc" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">尺寸: </span>
            	<input type="text" id="attribute1" name="attribute1" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">材质工艺: </span>
            	<input type="text" id="attribute2" name="attribute2" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">改版内容: </span>
            	<select id="changeContent" disabled>
            	   <option value="0">图案文字</option>
            	   <option value="1">材质工艺</option>
            	   <option value="2">尺寸</option>
            	   <option value="3">其他</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">版次: </span>
            	<input type="text" id="revision" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">变更编号: </span>
            	<input type="text" id="changeNumber" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">是否打样: </span>
            	<select id="makeSample" disabled>
            	   <option value="0">打样</option>
            	   <option value="1">不打样</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">制版处理: </span>
            	<select id="plateProcess" disabled>
            	   <option value="0">新制版</option>
            	   <option value="1">改版原版保留</option>
            	   <option value="2">改版原版作废</option>
            	</select>
            	</div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">制版数量: </span>
            	<input type="text" id="plateQuantity" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">规格: </span>
            	<input type="text" id="materialSpec" readonly /></div>
            	<br>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">产品经理: </span>
            	<input type="text" id="productManager" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">特殊要求: </span>
            	<input type="text" id="specRequirement" readonly /></div>
            	<div class="dis-in-b input-and-tip"><span class="text-right w-72">业务日期: </span>
            	<input type="text" id="orderDate" readonly /></div>
            	</form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
           <div class="tab-wrap" id="sheet-project">
           <ul>
	          <li><a href="#sheet-project-one"><i18n:I18n key="i18n_enquiry_title_fossfile" defaultValue="设计文件" /></a></li>
	       </ul>
		   <div id="sheet-project-one">
				<div class="box-wrap pos-relative bg-common">
					<div class="common-box-line p-zero">
						<div class="pos-relative upload-wrap">
							<div class="pos-absolute file-list">
								<main class="grid-container">
								<div class="grid-100">
									<table id="table-file"></table>
								</div>
								</main>
							</div>
							<div class="file-scan">
								<div class="file-option-zoom">
									<div class="dis-in-b text-left">
										<button id="btnDownloadFile" class="button-wrap"><i18n:I18n key="i18n_common_title_downfile" defaultValue="下载文件" /></button>
										<button id="btnViewFile" class="button-wrap"><i18n:I18n key="i18n_common_button_viewfileonline" defaultValue="在线预览文件" /></button>
									</div>
								</div>
								<div class="file-display" id="file-display">
									<a id="viewerPlaceHolder"></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
        </div>
        <div class="saying-dialog">
            <div class="fl-left left-content pos-relative">
                <div class="dis-block pos-absolute option-bar pre-active next"></div>
            </div>
            <div class="fl-left right-content pos-relative none-active">
                <div class="saying-box-wrap">
                   <iframe class="testIframe" id="chatIframe" frameborder="0" width="100%">
                   </iframe>
                </div>
            </div>
            <div class="clear-both"></div>
       </div>
    </div>
<script type="text/javascript">
var designNumber = "<%=request.getParameter("designNumber")%>";
var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
var $sob;
var itemGrid;
var cols_item = [
                 {title:"文件编号",name:"fileNumber",align:"center",width:80,hidden:true},
                 {title:"文件名称",name:"fileName",align:"center",width:120},
                 {title:"文件路径",name:"filePath",align:"center",width:120,hidden:true},
                 {title:"文件类别",name:"fileType",align:"center",width:120,renderer:function(val){
                	 if(val == "0")
                	     return "设计文件";
                	 else
                		 return "图片文件"; }
                 },
                 {title:"文件备注",name:"fbk1",align:"center",width:120},
                 {title:"上传人",name:"createUser",align:"center",width:100},
                 {title:"上传时间",name:"createDate",align:"center",width:130,renderer:function(val){
                	 if(!val)
                	     return "";
                	 else
                		 return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }
                 }
                ];

$().ready(function(){
    $("#sheet-project").tabs();
    $("#designNumber").val(designNumber);
    $("#toElsAccount").val(toElsAccount);
	init();
});

function init() {
	//加载数据
	initData();
	
	$("#commitBtn").click(function(){
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认提交？',closeEvent:function(){
			var frm = $("#form");
			parent.elsDeskTop.showLoading();
			$.ajax({
				url : "<%=basePath%>rest/DesignDocService/updateSaleDesignDoc",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					alert("<i18n:I18n key="i18n_alert_stretegyxxx" defaultValue="操作成功" />");
					parent.elsDeskTop.closeCurWin('saleConfirmDesignDoc',closeCallback);
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
					}
				}
			});
		}});	
	});
	
	$("#btnDownloadFile").click(function(){
		var selectedRows = itemGrid.selectedRows();
		if(selectedRows.length == 0){
			alert("<i18n:I18n key="i18n_delivery_choosefilesssease" defaultValue="请选择文件" />",2);
			return;
		}
		var filePath = selectedRows[0].filePath;
		window.location.href = "<%=basePath%>servlet/downloadServlet?filePath=" + filePath;
	});
    
    $("#btnViewFile").click(function(){
    	var selectedRows = itemGrid.selectedRows();
    	if(selectedRows.length == 0){
    		alert("<i18n:I18n key="i18n_delivery_choossssplease" defaultValue="请选择文件" />",2);
    		return;
    	}
    	var showDiv = $("#file-display");
    	var viewerPlaceA = $("#viewerPlaceHolder");
    	viewerPlaceA.empty();
    	var filePath = selectedRows[0].filePath;
    	var data = {"elsAccount":elsAccount,"filePath":filePath};
    	if(isSupportImage(filePath)){//系统支持的图片,直接显示
    		showDiv.css("overflow","auto");
    		$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(viewerPlaceA);
    	}else if(isSupportFile(filePath)){//系统支持在线预览的文档则转为swf文件在线预览
    		showDiv.css("overflow","hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
    	    parent.elsDeskTop.showLoading();
    	    $.ajax({
			url :"${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data : JSON.stringify(data),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				var resStatus = data.statusCode;
				var filePath = data.message;
				if("200" == resStatus){
					var width=$("#file-display").width();
					var height=$("#file-display").height();
					$("#viewerPlaceHolder").css("width",width*0.94+"px");  
					$("#viewerPlaceHolder").css("height",height+"px");  
					$("#viewerPlaceHolder").css("padding-left",width*0.03+"px");  
					$("#viewerPlaceHolder").css("display","block" );  

					var fp = new FlexPaperViewer(
					            '${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
					            'viewerPlaceHolder', 
					            {config : {
					                SwfFile : filePath,
					                Scale : 1.5,
					                ZoomTransition : 'easeOut',
					                ZoomTime : 0.5,
					                ZoomInterval : 0.2,
					                FitPageOnLoad : false,
					                FitWidthOnLoad : false,
					                FullScreenAsMaxWindow : false,
					                ProgressiveLoading : false,
					                MinZoomSize : 0.2,
					                MaxZoomSize : 5,
					                SearchMatchAll : false,
					                InitViewMode : 'SinglePage',
					                ViewModeToolsVisible : true,
					                ZoomToolsVisible : true,
					                NavToolsVisible : true,
					                CursorToolsVisible : true,
					                SearchToolsVisible : true,
					                localeChain: 'zh_CN'
					            	}
					            });
				}else{
					alert(data.message,2);
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
				}
			}
		});
    	}else {
    		alert("该文件不支持在线预览，请下载查看",2);
    	}
    });
}
function initData(){
	var data = {"elsAccount":elsAccount,"toElsAccount":toElsAccount,"designNumber":designNumber};
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/DesignDocService/getSaleDesignDoc",
		dataType : "json",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			if(data.statusConfirm != 0){
				$("#btnArea").hide();
				$("#statusConfirm").val(data.statusConfirm);
				$("#fbk1").val(data.fbk1);
			}else{
				//未确认就已经完结了(即已经有别的供应商接受了)
				if(data.orderStatus == 4)
					$("#btnArea").hide();
			}
			$("#designNum").val(data.designNumber);
			$("#designer").val(data.designer);
			$("#purchaseInCharge").val(data.purchaseInCharge);
			$("#materialNumber").val(data.materialNumber);
			$("#materialDesc").val(data.materialDesc);
			$("#attribute1").val(data.attribute1);
			$("#attribute2").val(data.attribute2);
			$("#changeContent").val(data.changeContent);
			$("#changeContentHidden").val(data.changeContent);
			$("#revision").val(data.revision);
			$("#changeNumber").val(data.changeNumber);
			$("#makeSample").val(data.makeSample);
			$("#plateProcess").val(data.plateProcess);
			$("#plateQuantity").val(data.plateQuantity);
			$("#materialSpec").val(data.materialSpec);
			$("#productManager").val(data.productManager);
			$("#specRequirement").val(data.specRequirement);
			if(data.orderDate)
				$("#orderDate").val(new Date(data.orderDate).format("yyyy-MM-dd"));
			//初始化文件列表
			initItemGrid(data.fileList);
			//初始化聊天
			$sob = $('.saying-dialog .option-bar');
			initChat(data);
			if($sob[0].toggleState)
				$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
            $sob.click();
		},
		error : function(data) {
			parent.elsDeskTop.hideLoading();
			if (!permissionError(data)) {
				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
			}
		}
	});
}

function initItemGrid(fileList){
	var height=$(document).height()-368;
	if(!itemGrid){
		itemGrid = $('#table-file').mmGrid({
	        cols        : cols_item,
	        height      : height,
	        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText  : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items       : fileList
	    });
	}
}

function closeCallback(){
 	if (parent.frames["iframeApp_designDocManageForSale"]) {
		parent.frames["iframeApp_designDocManageForSale"].query();
	}
}

//初始化聊天窗口
//ELS账号+设计单号 作为 businessID
//TODO: 多人聊天需要传值 peopleList
function initChat(data) {
	var elsAccount ='<%=session.getAttribute("elsAccount") %>',
	  elsSubAccount ='<%=session.getAttribute("elsSubAccount") %>',
	  toElsAccount = '',
	  toElsSubAccount = '';
	  var businessId = '';
	  var peopleList = [];
  var toElsAccountList = [];
  var toElsSubAccountList = [];
  if(data) {
			var obj={};
			obj.name = data.toElsAccount + '-' + data.companyShortName;
			businessId = '' + designNumber;
			peopleList.push(obj);
			toElsAccountList.push(data.toElsAccount + '-' + data.companyShortName);
			var t = {};
			t[data.toElsAccount + '-' + data.companyShortName] = [];
			if (data.fbk1) {
				t[data.toElsAccount + '-' + data.companyShortName].push(data.fbk1);
			}
			toElsSubAccountList.push(t);
		}
  	var chatIfr = $('#chatIframe')[0];
	chatIfr.src = '<%=basePath%>' + 'multiChat_n.jsp';
		setIframeData(chatIfr,{
			type:'multi',
			fromElsAccount:elsAccount,
			fromElsSubAccount:elsSubAccount,
			toElsAccount: toElsAccountList,
			toElsSubAccount: toElsSubAccountList,
			businessType:'designDoc',
			businessID:businessId,
			list:peopleList,
			displayType:'1',
			orderType:"1",
			t: new Date().getTime()
	    });
	   //滚动条美化niceScroll
	   $(".public-wrap").niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
}
</script>
</body>
</html>