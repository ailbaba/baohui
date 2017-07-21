<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../elsHeader.jsp"%>
<%
String toElsAccount = request.getParameter("toElsAccount");
String companyShortName = request.getParameter("companyShortName");
%>
<body>

<div class="pos-relative public-wrap">
<!--         <div class="box-wrap pos-relative bg-common"> -->
<%--             <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span> --%>
<!--             <div class="common-box-line"> -->
<!--                <form id="supplierForzenForm"> -->
<!--                 <input type="hidden" id="elsAccount" name="elsAccount"> -->
<!--                 <input type="hidden" id="pageSize" name="pageSize" value="10"> -->
<!-- 		        <input type="hidden" id="currentPage" name="currentPage" value="1">  -->
<!--                 <div class="dis-in-b input-and-tip"> -->
<%-- 			       <span><i18n:I18n key="" defaultValue="对方ELS账号:" /></span> --%>
<!-- 			       <input id="assessmentClassNumber" name="assessmentClassNumber" type="text" style="width:200px;"/> -->
<!-- 		        </div> -->
<!--                 </form> -->
<!--             </div> -->
<!--         </div> -->
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
               <div class="dis-in-b input-and-tip">
                     <button id="queryIntegrationInfo" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="addFrozenRecord" class="button-wrap" ><i18n:I18n defaultValue="增加ERP冻结" key=""/></button>
                </div>
                 <div class="dis-in-b input-and-tip">
                     <button id="ERPUnFrozenRecord" class="button-wrap" ><i18n:I18n defaultValue="ERP解冻" key=""/></button>
                </div>
                
		        
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
            
               <main class="grid-container">
               <form id = "form" onsubmit="false">
                    <div class="grid-100">
                        <table id="table-supplierForzen"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                        </form>
                </main>
            
            </div>
        </div>
</div>



<script>
var supplierForzenGrid;
var elsAccount='<%=session.getAttribute("elsAccount") %>';
var createUser='<%=session.getAttribute("username") %>';
var toElsAccount = '<%=toElsAccount%>';
var companyShortName = '<%=companyShortName%>';
var GobalparamStr = {"elsAccount":elsAccount,"toElsAccount":toElsAccount};
var rowIndexId;
$(document).ready(function(){
	init();
});	


function rendererOperation(val, item, rowIndex){      
	var text = '<span class="deleteBtn" style="color:blue;cursor:pointer;"><i18n:I18n key="" defaultValue="删除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
  /*  var text = '<span class="deleteBtn" style="color:blue;cursor:pointer;"><i18n:I18n key="" defaultValue="删除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	           +'&nbsp;&nbsp;<span class="updateBtn" style="color:blue;cursor:pointer;"><i18n:I18n key="" defaultValue="修改" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'; */
	return text;
}


//日期格式渲染 yyyy-MM-dd hh:mm:ss
function rendererCheckBox(val,item,index){
	if(val=="1"){
		return '<input type="checkbox" value = "1"  checked="checked" name="'+this.name+'"  id="'+this.name+'_'+index+'"></input>';
	}else{
		return '<input type="checkbox"  value =  "0"  name="'+this.name+'"  id="'+this.name+'_'+index+'" />';
	}
}

function rendererInput(val,item,index){
	return '<input type="text" value= "' +val +'"  name="'+this.name+'"  id="'+this.name+'_'+index+'"  ></input>';
}

function rendererButton(val,item,index){
	return '<span class = "materialSource"  style="color:blue;cursor:pointer;" >货源清单</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
}

//时间
var formatDateTime = function (val,item,index){
	if (!val) {val = "";}
	return new Date(val).format("yyyy-MM-dd hh:mm:ss");
};



var ForzenCols = [
                           { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />', name:'operation' , width:80, align:'center',clickDisable:true,renderer: rendererOperation},
                           { title:'<i18n:I18n key="" defaultValue="对方ELS账号" />', name:'toElsAccount' , width:80, align:'center'},
                           { title:'<i18n:I18n key="" defaultValue="对方公司名称" />', name:'toCompanyShortName' ,width:150, align:'center'},
                           { title:'<i18n:I18n key="" defaultValue="整体" />', name:'entirety' ,width:60, align:'center',renderer:rendererCheckBox},
                           { title:'<i18n:I18n defaultValue="采购组织" key=""></i18n:I18n>', name:'purchaseOrganize' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="公司" key=""></i18n:I18n>', name:'company' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="工厂" key=""></i18n:I18n>', name:'factory' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="聊天" key=""></i18n:I18n>', name:'chat' ,width:60, align:'center',renderer:rendererCheckBox},
                           { title:'<i18n:I18n defaultValue="招投标" key=""></i18n:I18n>', name:'bidding' ,width:60, align:'center',renderer:rendererCheckBox},
                           { title:'<i18n:I18n defaultValue="询报价" key=""></i18n:I18n>', name:'enquiry' ,width:60, align:'center',renderer:rendererCheckBox},
                           { title:'<i18n:I18n defaultValue="订单" key=""></i18n:I18n>', name:'orders' ,width:60, align:'center',renderer:rendererCheckBox},
                           { title:'<i18n:I18n defaultValue="收发货" key=""></i18n:I18n>', name:'voucher' ,width:60, align:'center',renderer:rendererCheckBox},
                           { title:'<i18n:I18n defaultValue="对账" key=""></i18n:I18n>', name:'busRecon' ,width:60, align:'center',renderer:rendererCheckBox},
                           { title:'<i18n:I18n defaultValue="货源" key=""></i18n:I18n>', name:'supply' ,width:80, align:'center',renderer: rendererButton},
                           { title:'<i18n:I18n defaultValue="预留1" key=""></i18n:I18n>', name:'14' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="预留2" key=""></i18n:I18n>', name:'15' ,width:100, align:'center'},
                           { title:'<i18n:I18n defaultValue="预留3" key=""></i18n:I18n>', name:'16' ,width:100, align:'center'}
                           
                    ];

function init(){
	
    supplierForzenGrid=$('#table-supplierForzen').mmGrid({
    	
	    cols: ForzenCols,
	    //items:addData,
 	    params: GobalparamStr,
 	   url: '<%=basePath%>rest/SupplierFreezeOptService/querySupplierFreezeOptByCondtion',
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
}

function queryIntegrationInfo() {
// 	var frm = $("#supplierForzenForm");
// 	supplierForzenGrid.opts.params = frm.serializeJSON();
// 	supplierForzenGrid.load({page:1});
	supplierForzenGrid.load(GobalparamStr);

}

//ERP解冻
$("#ERPUnFrozenRecord").click(function() {
	var selectRow = supplierForzenGrid.selectedRows();
	if(selectRow.length<=0){
		alert("请选择行项目",2);
		return;
	}
	var toElsAccount = selectRow[0].toElsAccount;
	var companyShortName = selectRow[0].toCompanyShortName;
	var purchaseOrganize = selectRow[0].purchaseOrganize;
	var company = selectRow[0].company;
	var factory = selectRow[0].factory;
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'addFrozenRecord',
        'windowTitle':'<i18n:I18n defaultValue="修改冻结记录" key="test"></i18n:I18n>',
        'iframSrc':'<%=basePath%>supplierfrozen/ForzenRecordUpd.jsp?toElsAccount=' + toElsAccount
        		+"&companyShortName="  + companyShortName
        		+"&purchaseOrganize=" +purchaseOrganize
        		+"&company=" + company
        		+"&factory=" +factory,
        windowMinWidth: 300,
        windowMinHeight: 600,
        windowPositionTop:24,
        'windowWidth':500,
        'windowHeight':650,
        'parentPanel':".currDesktop"
    });
});

//查询
$("#queryIntegrationInfo").click(function() {
	queryIntegrationInfo();
});

/* //增加
$("#addFrozenRecord").click(function() {
	clearaddFrozenRecord();
	$(".integrationInfoDialogTitle").text("新增考评条列");
	$('body').data("operationType","add");
	$("#integrationInfoDialog").show();
}); */

//弹出框取消按钮
$("#integrationInfoCancel").click(function(){
	$("#integrationInfoDialog").hide();
});
//关闭按钮处理
$("#integrationInfoDialogDialogClose").click(function(){
	$("#integrationInfoDialog").hide();
});

//添加冻结记录
$("#addFrozenRecord").click(function(){
	
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'addFrozenRecord',
        'windowTitle':'<i18n:I18n defaultValue="添加冻结记录" key="test"></i18n:I18n>',
        'iframSrc':'<%=basePath%>supplierfrozen/addForzenRecord.jsp?toElsAccount=' + toElsAccount
        		+"&companyShortName="  + companyShortName,
        windowMinWidth: 500,
        windowMinHeight: 400,
        windowPositionTop:24,
        'windowWidth':800,
        'windowHeight':450,
        'parentPanel':".currDesktop"
    });

});

//删除
$('.deleteBtn').live("click", function() {
	var scanCol = $(this).next();
    var sanContent = scanCol.text();
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除?" />',closeEvent:function(){
	$.ajax({
		url:"<%=basePath%>rest/SupplierFreezeOptService/deleteSupplierFreezeOpt",
		type:"post",
		contentType: "application/json",
		data: sanContent,
		dataType: "json",
		success: function(data) {
			alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
			queryIntegrationInfo();
		},
		error: function(data) {
			alert('<i18n:I18n key="i18n_common_alert_deletesuccess" defaultValue="删除成功!" />',1);
			queryIntegrationInfo();
		}
	}); 
	}});
});


//修改
$('.updateBtn').live("click", function(event) {
	var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var jsonObject = JSON.parse(sanContent);
/*     var obj=event.target;
	if(obj) 
		rowIndexId = obj.id; */
	
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'addFrozenRecord',
        'windowTitle':'<i18n:I18n defaultValue="修改冻结信息" key="test"></i18n:I18n>',
        'iframSrc':'<%=basePath%>supplierfrozen/ForzenRecordUpd.jsp?toElsAccount=' + toElsAccount
        		+"&companyShortName="  + companyShortName,
        windowMinWidth: 300,
        windowMinHeight: 600,
        windowPositionTop:24,
        'windowWidth':500,
        'windowHeight':650,
        'parentPanel':".currDesktop"
    });
});


//货源清单 
$('.materialSource').live("click", function() {
	var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var jsonObject = JSON.parse(sanContent);
	var toElsAccount = jsonObject.toElsAccount;
    
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'materialsource',
        'windowTitle':'<i18n:I18n defaultValue="货源清单" key="test"></i18n:I18n>',
        'iframSrc':'<%=basePath%>materialsource/materialSourceListManage.jsp?toElsAccount=' + toElsAccount,
        windowMinWidth: 600,
        windowMinHeight: 800,
        windowPositionTop:24,
        'windowWidth':600,
        'windowHeight':800,
        'parentPanel':".currDesktop"
    });
	
});

//初始化修改值
function initObject(jsonObject,index){
	jsonObject.entirety =  $("#entirety_" + index).val();
	jsonObject.purchaseOrganize =  $("#purchaseOrganize_" + index).val();
	jsonObject.company =  $("#company_" + index).val();
	jsonObject.factory =  $("#factory_" + index).val();
	jsonObject.chat =  $("#chat_" + index).val();
	jsonObject.bidding =  $("#bidding_" + index).val();
	jsonObject.enquiry =  $("#enquiry_" + index).val();
	jsonObject.orders =  $("#orders_" + index).val();
	jsonObject.voucher =  $("#voucher_" + index).val();
	jsonObject.busRecon =  $("#busRecon_" + index).val();
	jsonObject.supply =  $("#supply_" + index).val();
}

</script>

</body>
</html>
