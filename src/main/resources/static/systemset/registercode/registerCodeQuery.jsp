<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript"
	src="<%=basePath%>extend/zclip/jquery.zclip.min.js?version=<%=version%>"></script>
<body>
	<div class="pos-relative public-wrap ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <form id="queryForm" onsubmit="return false;" method="POST" action="<%=basePath%>rest/">
            <input type="hidden" id="elsAccount"    name="elsAccount"/>
            <input type="hidden" id="elsSubAccount" name="elsSubAccount"/>			
			<div class="common-box-line">
				<input id="receiveEls" name="receiveEls" type="hidden" value="${elsAccount }"/> 
				<div class="dis-in-b input-and-tip">
					<div class="">&nbsp;激活码状态： <select class="" id="codeStatus" name="codeStatus">
											            <option value="1">已领取</option>		
											            <option value="2">已注册</option>				
												    </select>
					</div>
				</div>					
				<div class="dis-in-b input-and-tip">
				    &nbsp;&nbsp;
					<button class="button-wrap" id = "seachBtn" >查  询</button>&nbsp;&nbsp;
				</div>
				<div class="dis-in-b input-and-tip">
					<button class="button-wrap" id = "applyBtn">申请激活码</button>
				</div>			
				<div class="dis-in-b input-and-tip">
					<button class="button-wrap" id = "linkBtn">复制企业链接</button>
				</div>
			</div>
			</form>
		</div>
		
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
                <main class="grid-container">
                <div class="grid-100"  id="RegisterCodeGrid">
                    <table id="registerCodeTable"></table>
                    <div id="pg" style="text-align: right;"></div>
                </div>
                </main>
            </div>
        </div>
        
	</div>
	<script>
	var RegisterCodeGrid    = null ;
	var elsAccount			= '<%=session.getAttribute("elsAccount") %>'       ;
	var elsSubAccount		= '<%=session.getAttribute("elsSubAccount") %>'    ;
	var companyShortName    = '<%=session.getAttribute("companyShortName") %>' ;	

	$(document).ready(function()
	{
		$("#linkBtn").zclip({
			path: "<%=basePath%>extend/zclip/ZeroClipboard.swf",
			copy: function(){
				return "<%=basePath%>login/registerByEls.html?elsAccount=" + elsAccount;
			},
			afterCopy:function(){/* 复制成功后的操作 */
				alert("复制成功");
	        }
		});
		var toElsAccount          = GetQueryString("toElsAccount");	
		var purchaseEnquiryNumber = null;
		
		$('button').button() ;
		$("#toElsAccount").val(toElsAccount) ;
		$("#elsAccount").val(elsAccount)     ;
		
		//列
		var cols = [ { title:'序号'        , name:'id'           ,width:75, align:'center'},
			         { title:'注册编码'    , name:'registerCode' ,width:160, align:'center'},
			         { title:'注册链接'    , name:'url' ,width:80, align:'center',renderer:function(val,item){
				         	return "<a code='"+item.registerCode+"'class='copy' href='javascript:void(0)'>复制链接</a>"
				      }},
			         { title:'注册ELS号'   , name:'registerElsAccount' ,width:80, align:'center'},
			         { title:'注册公司'   , name:'companyName' ,width:180, align:'center'},
					 { title:'注册时间'    , name:'registerTime'   ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}
						if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='registerTime' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					 }},  			         
			         { title:'领用人'      , name:'companyName'  ,width:100, align:'center'},
			         { title:'接收ELS号'   , name:'receiveEls'   ,width:80, align:'center'},
			         { title:'注册描述'    , name:'regDesc'      ,width:150, align:'center'},
 			         { title:'创建人ELS号' , name:'createEls'    ,width:80, align:'center'},
 			         { title:'激活码状态'  , name:'codeStatus'   ,width:80, align:'center' , renderer : function (val){ return ["未领取","已领取","已注册"][parseInt(val)]; }},  			         
 			         { title:'创建人'      , name:'createNick'   ,width:100, align:'center'},
					 { title:'时间截'      , name:'createTime'   ,width:100, align:'center',renderer:function(val){	if (!val) {val = "";}
						if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
						return "<span class='showText'>" + val + "</span>" + "<input name='createTime' class='Wdate' onfocus='WdatePicker({position:{left:100,top:50})' type='text' style='display:none' value='"+val+"'/>";
					 }} 			         
					];

		var paramStr =  {"elsAccount":elsAccount,"createNick":$("#createNick").val(),"receiveEls":$("#receiveEls").val(),"codeStatus":$("#codeStatus").val()};
		var frm      =  $("#queryForm");
		
		RegisterCodeGrid = $('#registerCodeTable').mmGrid({
	    	 cols        : cols       ,
	         url         : '<%=basePath%>rest/ElsRegisterCodeService/queryRegisterCodeLists' ,
	         params      : paramStr   ,
	         method      : 'post'     ,
	         root        : 'rows'     ,
	         loadingText : '正在载入' ,
	         noDataText  : '暂无数据' ,
	         indexCol    : true       ,
		     checkCol    : true       ,	    
	         multiSelect : true       ,
	         plugins: [
	             $('#pg').mmPaginator({
	                  	   style: 'plain'
	  	                 , totalCountName: 'total'
	  	                 , page: 1
	  	                 , pageParamName: 'currentPage'
	  	                 , limitParamName: 'pageSize'
	  	                 , limitLabel:      '<i18n:I18n key="i18n_common_mmgrid_limitlabel"      defaultValue="每页{0}条"/>'
	  	                 , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
	  	                 , limit:null
	  	                 , limitList: [10,20]
	             })
	         ]
	    }); 
		RegisterCodeGrid.on("loadSuccess",function(){
			$(".copy").zclip({
				path: "<%=basePath%>extend/zclip/ZeroClipboard.swf",
				copy: function(){
					return "<%=basePath%>login/register.html?registerCode=" + $(this).attr("code");
				},
				afterCopy:function(){/* 复制成功后的操作 */
					alert("复制成功");
		        }
			});
		});
		//查询     $("#setLadderPriceDialog").show();
		$("#seachBtn").click(function(){
			var paramStr =  {"elsAccount":elsAccount,"createNick":$("#createNick").val(),"receiveEls":$("#receiveEls").val(),"codeStatus":$("#codeStatus").val()};
			RegisterCodeGrid.load(paramStr);
		});
		
		$("#applyBtn").click(function(){
			var pageData = getIframeData() || {};
			var title = "与 企企通客服聊天中...";
			var toElsAccount = "100000";
			var toElsSubAccount = "2001";
			var url = "chat2.jsp?fromElsAccount="
				+ elsAccount
				+ "&fromElsSubAccount="
				+ elsSubAccount
				+ "&toElsAccount="
				+ toElsAccount
				+ "&toElsSubAccount="
				+ toElsSubAccount
				+ "&t=" + new Date().getTime();

		parent.elsDeskTop.defineWin($.extend({}, pageData, {
			'windowCls': 'ui-themeA',
			'iconSrc': 'icon/destop-icon/kefu.png',
			'windowsId': 'chatWin' + toElsAccount + toElsSubAccount,
			'windowTitle': title,
			'windowMinWidth': 500,
			'windowMinHeight': 600,
			'windowPositionTop': 'top',
			'windowPositionLeft': 'center',
			'iframSrc': url,
			'parentPanel': '.currDesktop',
			'windowWidth': 520,
			'windowHeight': 590,
		}));
		});
		
	});
	</script>
</body>
</html>