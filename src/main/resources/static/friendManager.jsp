<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="elsHeader.jsp"%>

<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
            	<form id="accoutForm">
	                <input type="hidden" id="elsAccount" name="elsAccount">
	                <input type="hidden" id="elsSubAccount" name="elsSubAccount">
	                <input type="hidden" id="pageSize" name="pageSize" value="10">
			        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
			        <div class="dis-in-b input-and-tip"> 
						<span><i18n:I18n key="test" defaultValue="一级类型" />:</span>
						<select id="groupIdA" name="groupIdA" style="width: 120px; max-width: 120px;"></select>
					</div>
					<div class="dis-in-b input-and-tip"> 
						<span><i18n:I18n key="test" defaultValue="二级类型" />:</span>
						<select id="groupIdB" name="groupIdB" style="width: 120px; max-width: 120px;"></select>
					</div>
	                <div class="dis-in-b input-and-tip">
				        <span><i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"/>:</span>
				        <input id="friendElsAccount" name="friendElsAccount" type="text" style="width:200px;"/>
			        </div>
	                <div class="dis-in-b input-and-tip">
				        <span><i18n:I18n defaultValue="企业名称" key=""/>:</span>
				        <input id="friendCompanyName" name="friendCompanyName" type="text" style="width:200px;"/>
			        </div>
	                <div class="dis-in-b input-and-tip">
				        <span><i18n:I18n defaultValue="邓白氏企业编号" key=""/>:</span>
				        <input id="sexElsAccount" name="sexElsAccount" type="text" style="width:200px;"/>
			        </div>
	                <div class="dis-in-b input-and-tip">
				        <span><i18n:I18n defaultValue="行业分类" key=""/>:</span>
				        <input id="industry" name="industry" type="text" style="width:200px;"/>
			        </div>
            	</form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryAccountInfo" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="updateAccountInfo" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_common_button_update"/></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteAccountInfo" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="checkAccountInfo" class="button-wrap" ><i18n:I18n defaultValue="查看" key="i18n_enquiry_label_check"/></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="sendMessageInfo" class="button-wrap" ><i18n:I18n defaultValue="消息发送" key="i18n_enquiry_Message_is_sent"/></button>
                </div>                
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-account"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>

<!-- 对话框 -->
<div class="fixed-dialog" id="sendMsgDialog">
           <div class="dialog-tip bg-common" style="width: 270px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="icon/destop-icon/desktop_icon_122.gif" />
                   <span class="dialogTitle"><i18n:I18n key="test" defaultValue="填写信息" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <textarea id="msgArea" style="width: 100%; box-sizing: border-box;margin: 0; display: block;resize: none;height: 100px;"></textarea>
	                       <div class="mt-20 text-center">
	                          <button id="sendMsgBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
		                      <button id="sendMsgBtnCancel" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>



<script>

var accountGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';

$(function(){
	init();
	//加载 一级类型 二级类型 @author jiangzhidong @date 20160130
	showGroupSelect(1);
	showGroupSelect(2);
	$('.mmg-title:first').text('');
});	

var accountCols = [{ title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'elsAccount' , width:120, align:'center',hidden:true},
                   { title:'<i18n:I18n defaultValue="ELS账号" key="i18n_common_title_elsaccount"></i18n:I18n>', name:'friendElsAccount' , width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="公司名称" key="i18n_common_lable_companyname"></i18n:I18n>', name:'friendCompanyName' ,width:120, align:'center'},
                   { title:'<i18n:I18n defaultValue="对方公司一级类型" key="i18n_common_title_stairType"/>', name:'groupIdAName' ,width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="对方公司二级类型" key="i18n_common_title_secondType"/>', name:'groupIdBName' ,width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="邓白氏企业编号" key=""/>', name:'sexElsAccount' ,width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="行业" key=""/>', name:'industry' ,width:200, align:'center'},
                   { title:'<i18n:I18n defaultValue="行业细类" key=""/>', name:'industryDetail' ,width:200, align:'center'}
            ];

function init(){
	$("#elsAccount").val(elsAccount);//设置当前登录账号
	$("#elsSubAccount").val(elsSubAccount);
	var frm = $("#accoutForm");
	 //初始化控件
    $('button').button();
	accountGrid=$('#table-account').mmGrid({
	    cols: accountCols,
	    url: '<%=basePath%>rest/FriendsService/findMyFriendsAndGroups',
	    params: frm.serializeJSON(),
	    height: 340,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    multiSelect:true,
	    plugins: [
              $('#pg').mmPaginator({
                  style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                  , limit: null
                  , limitList: [10,15,20]
              })
          ]
	});
	
	accountGrid.on('cellSelected',function(e, item, rowIndex, colIndex) {
   	    $('body').data('account',item);
    });
}

function queryAccountInfo() {
	var frm = $("#accoutForm");
	accountGrid.opts.params = frm.serializeJSON();
	accountGrid.load({page:1});
}

//查询
$("#queryAccountInfo").click(function() {
	queryAccountInfo();
});

//编辑账号信息
$("#updateAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length != 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择一行需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url='<%=basePath%>friends/editFriendRelation.jsp?elsAccount='+selectRow[0].elsAccount+'&elsSubAccount='+selectRow[0].elsSubAccount
	+'&friendElsAccount='+selectRow[0].friendElsAccount+"&t="+new Date().getTime();;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop2_icon_181.png',
        'windowsId':'editFriendRelation',
        'windowTitle':'<i18n:I18n defaultValue="编辑好友关系" key="i18n_account_title_editFriendRelation"/>',
        'iframSrc':url,
         windowStatus: 'regular',
         windowMinWidth: 300,
         windowMinHeight: 300,
        'windowWidth':350,
        'windowHeight':300,
         windowPositionTop:50,
        'parentPanel':".currDesktop"
    });
});
//删除账号
$("#deleteAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length != 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择一行需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除?" key="i18n_common_alert_confirmdelete"/>',closeEvent:function(){
		$.ajax({
			url         : "<%=basePath%>rest/FriendsService/deleteMyFriends",
			type        : "POST",
			contentType : "application/json",
			data        : JSON.stringify(selectRow),
			dataType    : "json",
			success  : function(data) {
				parent.elsDeskTop.tip.init({type: 'alert',displayType:1,message:'<i18n:I18n defaultValue="删除成功" key="i18n_common_alert_deletesuccess"></i18n:I18n>'});
				queryAccountInfo();   
			},
			error : function(data) {
				parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n defaultValue="请求出错" key="i18n_common_alert_requestfail"></i18n:I18n>'});
			}
		});
	}});
});

//查看
$("#checkAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length != 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择一行需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url='<%=basePath%>account/displayAccount.jsp?elsAccountNumber='+selectRow[0].friendElsAccount;
	parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/destop-icon/desktop2_icon_181.png',
	        'windowsId':'PurchaseEnHisPrice',
	        'windowTitle':'<i18n:I18n defaultValue="账户信息" key="i18n_account_title_accountInformation"></i18n:I18n>',
	        'iframSrc':url,
	        windowMinWidth: 900,
	        windowMinHeight: 550,
	        'windowWidth':900,
	        'windowHeight':550,
	        windowPositionTop:25,
	        'parentPanel':".currDesktop"
	    });
});

$('#table-account').on('dblclick','tr',function() {
	var account = $('body').data('account');
	var url='<%=basePath%>account/displayAccount.jsp?elsAccountNumber='+account.friendElsAccount;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
        'windowsId':'PurchaseEnHisPrice',
        'windowTitle':'<i18n:I18n defaultValue="账户信息" key="i18n_account_title_accountInformation"></i18n:I18n>',
        'iframSrc':url,
        windowStatus: 'regular',
        windowMinWidth: 900,
        windowMinHeight: 550,
        'windowWidth':900,
        'windowHeight':550,
        windowPositionTop:25,
        'parentPanel':".currDesktop"
    });
});

//加载 一级类型 二级类型  @author jiangzhidong @date 20160130 begin
var showGroupSelect = function(groupClass){
	var groupIdA=$("#groupIdA");
	var groupIdB=$("#groupIdB");
	var url='<%=basePath%>rest/FriendsService/findMyFriendsGroup/'+elsAccount+'/'+elsSubAccount+'/'+groupClass+'?t='+new Date().getTime();
	$.getJSON(url, function(data) {
				if(groupClass==1){
					var optionA = $("<option>").text('ALL_一级').val('');
					groupIdA.empty().append(optionA);
				}else{
					var optionB = $("<option>").text('ALL_二级').val('');
					groupIdB.empty().append(optionB);
				}
		        $.each(data, function(index, item) {
		        	var option = $("<option>").text(item.groupName).val(item.groupId);
		        	if(groupClass==1) groupIdA.append(option);
		        	else groupIdB.append(option);
		        })
		});
}

//筛选  
$("#groupIdA,#groupIdB").change(function() {
	queryAccountInfo();
});
//@author jiangzhidong @date 20160130 end

//信息发送  @author jiangzhidong @date 20160130  begin
$("#sendMessageInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1 && elsAccount!=superAdmin){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:2,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}else {
		$("#sendMsgDialog").show();
		reset();
	}
});

//发送
$("#sendMsgBtnOK").click(function() {
	var msgArea = $("#msgArea").val();
  	var itemRows = accountGrid.selectedRows();
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_alert_bargain_reallySent" defaultValue="确认发送?" />',closeEvent:function(){
		parent.elsDeskTop.showLoading();
		
		var reqData=JSON.stringify(itemRows);
		var requrl='<%=basePath%>rest/FriendsService/sendMessageFriends/'+msgArea+ "?t="+new Date().getTime();
		
		if(elsAccount==superAdmin){
			//平台公告发送
			reqData=JSON.stringify(msgArea);
			requrl='rest/MsgService/sendNoticeToAllAccount';
		}
			
			$.ajax({
				url : requrl,
				type : 'POST',
				contentType : "application/json",
				data : reqData,
				dataType : "json",
				success : function(data) {
	    			alert('<i18n:I18n key="i18n_common_sendsuccess" defaultValue="发送成功" />',1);
	    		},error : function(data) {
	    			alert('<i18n:I18n key="i18n_common_sendfail" defaultValue="发送失败" />',3);
	    		},complete : function(data) {
	    			parent.elsDeskTop.hideLoading();
	    			$("#sendMsgDialog").hide();
	    			reset();
	    		}
			});
			
	
		
	}});
});

//关闭
 $("#dialogFileClose,#sendMsgBtnCancel").click(function(){
	 $("#sendMsgDialog").hide();
	 reset();
 });
 
//重新加载
 var reset = function() {
	 $("#msgArea").val('你有一条消息通知!');
 }
 
//@author jiangzhidong @date 20160130  end

</script>

</body>
</html>
