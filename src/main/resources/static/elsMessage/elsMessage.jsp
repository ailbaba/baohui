<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ include file="../elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="elsMessageForm">
                    <input type="hidden" id="elsAccount"    name="elsAccount"  >
					<input type="hidden" id="pageSize"    name="pageSize"    value="20" >
					<input type="hidden" id="currentPage" name="currentPage" value="1"  >
					<input type="hidden" id="businessType"    name="businessType"    value=""   >
		        <div class="dis-in-b input-and-tip">
			        <i18n:I18n defaultValue="业务区分：" key="i18n_elsMessage_list_businessToDistinguish"/><select class="" id="businessType" name="businessType">
			                     <option value=""><i18n:I18n defaultValue="全部" key="i18n_common_select_all"/></option> 
			                     <option value="0"><i18n:I18n defaultValue="密码管理" key="i18n_label_passWordManage"/></option>
								 <option value="1"><i18n:I18n defaultValue="好友管理" key="i18n_label_friendmanager"/></option>
								 <option value="2"><i18n:I18n defaultValue="询价单" key="i18n_businessType_bargainEnquiry"/></option>
								 <option value="3"><i18n:I18n defaultValue="报价单" key="i18n_businessType_saleEnquiry"/></option>
								 <option value="4"><i18n:I18n defaultValue="采购订单" key="i18n_title_purchaseorder"/></option>
								 <option value="5"><i18n:I18n defaultValue="销售订单" key="i18n_title_saleOrder"/></option>
								 <option value="6"><i18n:I18n defaultValue="送货单" key="i18n_elsMessage_lable_deliveryNote"/></option>
								 <option value="7"><i18n:I18n defaultValue="入库单" key="i18n_elsMessage_lable_godownEntry"/></option>
								 <option value="8"><i18n:I18n defaultValue="对账单" key="i18n_elsMessage_lable_statementOfAccount"/></option>
	              </select>		 
		            </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="btnQuery" iconCls="icon-search"  onclick="queryAccountInfo()" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>

                <div class="dis-in-b input-and-tip">
                     <button id="addAccountInfo" class="button-wrap" ><i18n:I18n defaultValue="增加" key="i18n_common_button_create"/></button>
                </div>
                
		        <div class="dis-in-b input-and-tip">
                     <button id="updateAccountInfo" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_common_button_update"/></button>
                </div>
                
                <div class="dis-in-b input-and-tip">
                     <button id="deleteAccountInfo" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>

           </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line ">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="elsMessageList"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>
<script>

var accountGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>' ;

$(document).ready(function(){
	init();
});	

function init(){
	$("#elsAccount").val(elsAccount);
	var frm = $("#elsMessageForm");
	var accountCols = [
                        {title:'<i18n:I18n defaultValue="ELS账号" key="i18n_label_elsAccount"></i18n:I18n>', name:'elsAccount' , width:80, align:'center',renderer:renderPublic},
                        { title:'<i18n:I18n defaultValue="业务区分" key="i18n_elsMessage_list_businessToDistinguish"></i18n:I18n>', name:'businessType' , width:100, align:'center',renderer: rendererOrderStatus},
                        {title:'<i18n:I18n defaultValue="ELS消息" key="i18n_elsMessage_lable_elsAPP"></i18n:I18n>', name:'elsMessage' , width:80, align:'center',renderer: renderOderMessage},
                        { title:'<i18n:I18n defaultValue="企企通APP" key="i18n_elsMessage_lable_qqtAPP"></i18n:I18n>', name:'qqtApp' , width:100, align:'center',renderer: renderOderMessage},
                        {title:'<i18n:I18n defaultValue="短信" key="i18n_elsMessage_lable_sms"></i18n:I18n>', name:'sms' , width:80, align:'center',renderer: renderOderMessage},
                        { title:'<i18n:I18n defaultValue="微信" key="i18n_elsMessage_lable_weChat"></i18n:I18n>', name:'weChat' , width:100, align:'center',renderer: renderOderMessage},
                        { title:'<i18n:I18n defaultValue="邮件" key="i18n_enterprise_email"></i18n:I18n>', name:'email' ,width:90, align:'center',renderer: renderOderMessage}
                        ];	 
	accountGrid=$('#elsMessageList').mmGrid({
        cols: accountCols,
	    url: '<%=basePath%>rest/ElsMessageService/findMessageList',
	    params: frm.serializeJSON(),
	    height: 450,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    fullWidthRows:true,
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
                  , limitList: [15,30,35]
              })
          ]
	});
};
//渲染十万号为系统公共号
function renderPublic(val){
	if(val=="100000"){
		return '<i18n:I18n key="i18n_common_alert_systemPublicNumber" defaultValue="系统默认"/>';
	}else{
		return elsAccount;
	}
	
}
//渲染业务区分状态
function rendererOrderStatus(val){
    	 if(val==0){
    		return '<i18n:I18n defaultValue="密码管理" key="i18n_label_passWordManage"/>';
    	}else if(val==1){
    		return '<i18n:I18n defaultValue="好友管理" key="i18n_label_friendmanager"/>';
    	}else if(val==2){
    		return '<i18n:I18n defaultValue="询价单" key="i18n_businessType_bargainEnquiry"/>';
    	}else if(val==3){
    		return '<i18n:I18n defaultValue="报价单" key="i18n_businessType_saleEnquiry"/>';
    	}else if(val==4){
    		return '<i18n:I18n defaultValue="采购订单" key="i18n_title_purchaseorder"/>';
    	}else if(val==5){
    		return '<i18n:I18n defaultValue="销售订单" key="i18n_title_saleOrder"/>';
    	}else if(val==6){
    		return '<i18n:I18n defaultValue="送货单" key="i18n_elsMessage_lable_deliveryNote"/>';
    	}else if(val==7){
    		return '<i18n:I18n defaultValue="入库单" key="i18n_elsMessage_lable_godownEntry"/>';
    	}else if(val==8){
    		return '<i18n:I18n defaultValue="对账单" key="i18n_elsMessage_lable_statementOfAccount"/>';
    	}else if(val==9){
    		return '<i18n:I18n defaultValue="准入评估单" key="test"/>';
    	}
}
//渲染消息是否配置
function renderOderMessage(val){
	if(val=='Y'){
		return '<i18n:I18n defaultValue="是" key="i18n_common_yes"/>';
	}else if(val=='N'){
       		return '<i18n:I18n defaultValue="否" key="i18n_common_no"/>';
	}
}


function queryAccountInfo() {
	var frm = $("#elsMessageForm");
	accountGrid.opts.params = frm.serializeJSON();
	accountGrid.load();
}
//查询
$("#btnQuery").click(function() {
	queryAccountInfo();
});
//增加
$("#addAccountInfo").click(function() {
	parent.elsDeskTop.defineWin({
	  'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
      'windowsId':'addElsMessage',
      'windowTitle':'<i18n:I18n defaultValue="添加资源" key="i18n_label_add_key"/>',
      'iframSrc':'<%=basePath%>elsMessage/addElsMessage.jsp',        
       windowStatus: 'regular',
       windowMinWidth: 300,
       windowMinHeight: 380,     
       windowPositionTop:24,
      'windowWidth':300,
      'windowHeight':380,
      'parentPanel':".currDesktop"
  });
});

//修改
$("#updateAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url='<%=basePath%>elsMessage/editMessage.jsp?businessType='+selectRow[0].
	businessType+'&elsAccount='+selectRow[0].elsAccount+'&id='+selectRow[0].id+'&elsMessage='+selectRow[0].elsMessage+'&qqtApp='+selectRow[0].
	qqtApp+'&sms='+selectRow[0].sms+'&weChat='+selectRow[0].
	weChat+'&email='+selectRow[0].email;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'editMessage',
        'windowTitle':'<i18n:I18n defaultValue="编辑" key="i18n_label_edit_I18n"/>',
        'iframSrc':url,
         windowStatus: 'regular',
         windowMinWidth: 300,
         windowMinHeight: 380,
         windowPositionTop:24,
        'windowWidth':300,
        'windowHeight':380,
        'parentPanel':".currDesktop"
    });
});
//删除
$("#deleteAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	if(selectRow[0].elsAccount=="100000"){
		alert('<i18n:I18n defaultValue="系统默认号不能删除,请重新选择!" key="i18n_common_alert_SystemDefaultNumber"/>',2);
		return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除?" key="i18n_common_alert_confirmdelete"/>',closeEvent:function(){		
		  for(var i = 0 ; i < selectRow.length; i ++){
			   var row = selectRow[i];
			   var param={"id":row.id};
			   $.ajax({
					url :"<%=basePath%>rest/ElsMessageService/deleteElsMessage",
					type :"POST",
					contentType : "application/json",
					dataType : "json",
					data:JSON.stringify(param),
					success : function(data) {
						if(data.statusCode == "-100"){
							alert(data.message,3);
						}else{
							alert("<i18n:I18n key="il8n_common_alert_successfulOperation" defaultValue="操作成功"/>！",1);
							queryAccountInfo();
						}
					},
					error: function (xhr, type, exception) {//获取ajax的错误信息
			            alert(exception,3); 
			        }
			  });
		    }
		
	    }});
});

</script>

</body>
</html>