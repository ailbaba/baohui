<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css"/>
<!--引入JS-->
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
		<div class="common-box-line">
			<div>
				<button id="btnAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
				<button id="btnDelete" class="button-wrap"><i18n:I18n key="i18n_label_delete" defaultValue="删除" /></button>
				<button id="saveBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button>
			</div>
		</div>
	</div>
<form id="form" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
         <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_schedule_lable_assigned" defaultValue="已分配" /></span>
         <div class="common-box-line">
				<input type="hidden" name="templateCode" id="templateCode" />
				<input type="hidden" name="elsAccount" value="${elsAccount}" />
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table-assign"></table>
                    </div>
                </main>
         </div>
 </div>
</form>
<script type="text/javascript">
var templateCode = "<%=request.getParameter("templateCode")%>";
var assignGrid;
var cols_assign = [
                   { title:'<i18n:I18n key="i18n_saleorderhis_title_elsaccount" defaultValue="ELS号" />', name:'elsAccount' ,width:180, align:'center' ,hidden:true,renderer:function(val){
                  	    if (!val) {val = "";}
                 	    return "<span class='showText'>" + val + "</span>" + "<input name='assignList[][elsAccount]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />', name:'templateCode' ,width:180, align:'center' ,renderer:function(val){
                     	if (!val) {val = "";}
                    	return "<span class='showText'>" + val + "</span>" + "<input name='assignList[][templateCode]' type='hidden' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_enquiry_title_purchasegroup" defaultValue="采购组" />', name:'purchaseGroup' ,width:180, align:'center' ,renderer:function(val){
               	    if (!val) {val = "";}
              	    return "<input name='assignList[][purchaseGroup]' class='purchaseGroup' type='text' value='"+val+"'/>"; 
                   }},
                   { title:'<i18n:I18n key="i18n_label_additionCost_toElsAccount" defaultValue="对方ELS号" />', name:'toElsAccount' , width:180, align:'center' ,renderer:function(val){
                	if (!val) {val = "";}
                	return "<input name='assignList[][toElsAccount]' type='text' class = 'toElsAccount' value='"+val+"'/>"; 
                  }},
                  { title:'<i18n:I18n key="i18n_common_title_tocompanyshortname" defaultValue="对方公司名称" />', name:'companyName' ,width:180, align:'center' ,renderer:function(val){
                	  if(!val){
                		  val="";
                	  }
                	  return "<span class='companyName'>"+val+"</span>";
                  }}
               ];

var blankRow = {"elsAccount":elsAccount,"templateCode":templateCode,"purchaseGroup":"","toElsAccount":""};

$().ready(function(){
	init();
});
function init(){
	
	var height=$(document).height()-295;
	if(!assignGrid){
		assignGrid = $('#table-assign').mmGrid({
	        cols: cols_assign,
	        checkCol:true,
	        height:height,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
	        items: []
	    });
	}
	$("#templateCode").val(templateCode);
	getAssignList();
}
//获取数据
function getAssignList(){
		$.ajax({
			url :"<%=basePath%>rest/OrderScheduleService/getAssignList/" + elsAccount + "/" + templateCode,
			dataType : "json",
			type :"get",
			contentType : "application/json",
			success : function(data) {
				assignGrid.load(data.rows);
				bindEvent();
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
}

function checkEmpty(){
	var hasEmpty = false;
	$('#table-assign').find("tr").each(function(){
 		if ($(this).find(".toElsAccount").val()=="" && $(this).find(".purchaseGroup").val() == "") {
 			hasEmpty = true;
 			return;
 		}
	});
	return hasEmpty;
}

//新增
$("#btnAdd").click(function(){
	assignGrid.addRow(blankRow,assignGrid.rowsLength());
	bindEvent();
});

//保存
$("#saveBtn").click(function(){
	if(checkEmpty()){
        alert("<i18n:I18n key='i18n_schedule_needenter' defaultValue='请填写对方ELS账号或采购组' />",2);
        return;
	}
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_save" defaultValue="是否确认保存？" />',closeEvent:function(){
	var frm = $("#form");
	parent.elsDeskTop.showLoading();
	$.ajax({
		url :"<%=basePath%>rest/OrderScheduleService/saveAssignList",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify(frm.serializeJSON()),
		dataType : "json",
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />！');
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

//删除
$("#btnDelete").click(function(){
	var selectedIndexs = assignGrid.selectedRowsIndex();
	if(selectedIndexs.length<=0){
		alert("<i18n:I18n key='i18n_permission_selectitemstodelete' defaultValue='请选择要删除的项！' />",2);
		return;
	}
	assignGrid.removeRow(selectedIndexs[0]);
});

//退出
$("#exitBtn").click(function(){
	parent.elsDeskTop.closeCurWin('assignOrderScheduleTemplate',closeCallback);
});

function closeCallback() {
 	if (parent.frames["iframeApp_orderScheduleTemplateManage"]) {
		parent.frames["iframeApp_orderScheduleTemplateManage"].query();
	}
}

//绑定获取对方公司名称事件
function bindEvent(){
	$(".grid-100").find("tr").each(function(){
		var trObj=this;
		$(this).find(".toElsAccount").change(function(){
			var toElsAccount=$(this).val();
			var param={"elsAccount":toElsAccount};
			$.ajax({
				url :"<%=basePath%>rest/OrderScheduleService/getCompanyName",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(param),
				dataType : "json",
				success : function(data) {
						var companyName=data.companyName;
						if(!companyName){
							alert("<i18n:I18n key='i18n_schedule_accountnotfound' defaultValue='该账号不存在!' />",2);
						}else{
							$(trObj).find(".companyName").html(companyName);
						}
				},
				error : function(data) {
	    			if (!permissionError(data)) {
	    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
	    			}
				}
			});
		});
	});
}

</script>
</body>
</html>