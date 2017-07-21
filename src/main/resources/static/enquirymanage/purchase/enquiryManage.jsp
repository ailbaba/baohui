<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<base:supplierAuth elsAccount="${elsAccount }" authCode="enquiry" toElsAccount="${param['toElsAccount'] }"></base:supplierAuth>
<style>
.bgred{background-color:rgba(213, 58, 58, 0.1)}
</style>
<script type="text/javascript" src="<%=basePath%>js/crypto.js"></script>
<script>

var selectSupplierTable; 
var elsAccount = "<%=session.getAttribute("elsAccount") %>";
var elsSubAccount = "<%=session.getAttribute("elsSubAccount") %>";
var companyShortName = "<%=session.getAttribute("companyShortName") %>";
var toElsAccount ="<%=request.getParameter("toElsAccount") %>";
//@author update/jiangzhidong @data 20160528 begin
<%
String language = "en";
if(session.getAttribute("language")!=null&&session.getAttribute("language")!=""){
	language = String.valueOf(session.getAttribute("language")).replace("_","-");
}
%>
// @author update/jiangzhidong @data 20160528 end

var enquiryManageTable;
$(document).ready(function() {
	     var endDate = new Date();
        var endDate_milliseconds=endDate.getTime()-1000*60*60*24*30; 
        var beginDate=new Date(); 
        beginDate.setTime(endDate_milliseconds); 
        $("#beginDate").val(beginDate.format('yyyy-MM-dd'));
        
        if(toElsAccount && toElsAccount !='null'){
        	$("#toElsAccount").val(toElsAccount);
        }
        
		initSubAcount();
		var name = "<%=session.getAttribute("username")%>";
		var totalCount = 0;
		var pageSize = 20;
		var currentPage = 1;
		var frm = $("#queryForm");
		var frmObj = frm.serializeJSON();
		frmObj["FBK4"]=elsSubAccount;
		//打开询价单议价页面
		$('.enquiry-bargain').live("click", function() {
			var currId=$(window.frameElement).attr('id')
	         var scanCol = $(this).next();
	         
	         var sanContent = scanCol.text();
	         var item = JSON.parse(sanContent);
	         
	         var beginDate = item.beginDate;
	        	if (beginDate!=null&&beginDate.length!=10) {
	        		beginDate = new Date(beginDate).format("yyyy-MM-dd");
	        	}	
	        	var endDate = item.endDate;
	        	if (endDate!=null&&endDate.length!=10) {
	        		endDate = new Date(endDate).format("yyyy-MM-dd");
	        	}
	        	//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
			        'windowsId':'purchaseBargainManage',
			        'windowTitle':'<i18n:I18n key="i18n_enquiry_windowtitle_purchaseenquirybargain" defaultValue="采购询价单议价" />',
			        windowSubTitle: companyShortName,
			        'iframSrc':'<%=basePath%>enquirymanage/purchase/purchaseBargainManage.jsp?purchaseEnquiryNumber='+item.purchaseEnquiryNumber+
	        		'&orderType='+item.orderType+  
	        		'&beginDate='+beginDate+
	        		'&endDate='+endDate+
	        		'&currId='+currId,
			        showAdv: false,
			        windowStatus: 'maximized',
			        windowMinWidth: 960,
			        windowMinHeight: 700,
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop"
			    });
	        	
	     });
		
		//打开询价单明细页面
		$('.enquiry-detail').live("click", function() {
			 var currId=$(window.frameElement).attr('id')
	         var scanCol = $(this).next();
	         
	         var sanContent = scanCol.text();
	         var item = JSON.parse(sanContent);
	         
	         var beginDate = item.beginDate;
	        	if (beginDate!=null&&beginDate.length!=10) {
	        		beginDate = new Date(beginDate).format("yyyy-MM-dd");
	        	}	
	        	var endDate = item.endDate;
	        	if (endDate!=null&&endDate.length!=10) {
	        		endDate = new Date(endDate).format("yyyy-MM-dd");
	        	}
	        	//兼容ie 冒泡事件
			    if (event && event.preventDefault) {
			        event.preventDefault();
			        event.stopPropagation();
			    } else {
			        window.event.returnValue = false;
			    }
			    parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
			        'windowsId':'PurchaseEnquiryDetail',
			        'windowTitle':'<i18n:I18n key="i18n_enquiry_windowtitle_purchaseenquirydetail" defaultValue="采购询价单明细查看" />',
			        windowSubTitle: companyShortName,
			        'iframSrc':'<%=basePath%>enquirymanage/purchase/purchaseEnquiryDetail.jsp?purchaseEnquiryNumber='+item.purchaseEnquiryNumber+
	        		'&orderType='+item.orderType+  
	        		'&beginDate='+beginDate+
	        		'&FBK4='+item.FBK4+
	        		'&FBK9='+item.FBK9+
	        		'&FBK10='+item.FBK10+
	        		'&purchaseGroup='+item.purchaseGroup+
	        		'&purchaseOrganization='+item.purchaseOrganization+
	        		'&enquiryDesc='+item.enquiryDesc+
	        		'&orderStatus='+item.orderStatus+
	        		'&endDate='+endDate+'&currId='+currId,
			        showAdv: false,
			        windowStatus: 'maximized',
			        windowMinWidth: 960,
			        windowMinHeight: 700,
			        'windowWidth':960,
			        'windowHeight':700,
			        'parentPanel':".currDesktop",
			        data:{'enquiryDesc':item.enquiryDesc}
			    });
	        	
	     });
		
		
		//渲染议价/查看按钮
		function enquiryHandle(val, item, rowIndex){
			var text = '&nbsp;&nbsp;<span class="enquiry-detail" style="color:blue;"><i18n:I18n key="" defaultValue="详情" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
			if(item.orderStatus != 0){
				text = '<span class="enquiry-bargain" style="color:blue;"><i18n:I18n key="i18n_enquiry_label_bargain" defaultValue="议价" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>' +text;
			}
			return text;
		}
		
		//渲染询价单发送状态
		function rendererSendStatus(val,item,index){
			if(val == 0){
				return "未发送";
			}else if(val == 2){
				return "已发送";
			}
			/* var total_count = item.total_count;
			var answer_count = item.answer_count;
			var not_answer_count = total_count-answer_count;
			if(val == 0){
				return "未发送";
				/* return '<i18n:I18n key="i18n_enquiry_label_sendStatus_proceedone" defaultValue="已发送至" />'+
				total_count+'<i18n:I18n key="i18n_enquiry_label_sendStatus_proceedtwo" defaultValue="个供应商，等待接收中" />'; */
			/* }else if(total_count == answer_count){
				return '<i18n:I18n key="i18n_enquiry_label_sendStatus_allreceived" defaultValue="全部已接收" />';
			}else{
				return answer_count+'<i18n:I18n key="i18n_enquiry_label_sendStatus_partreceivedone" defaultValue="个供应商已接收," />'+
				not_answer_count+'<i18n:I18n key="i18n_enquiry_label_sendStatus_partreceivedtwo" defaultValue="个供应商等待接收" />';
			} */ 
		}
		//渲染订单状态
		function rendererOrderStatus(val){
	        	if(val==0){
	        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />';
	        	}else if(val==1){
	        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed" defaultValue="报价中" />';
	        	}else if(val==4){
	        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价" />';
	        	}else if(val==3){
	        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
	        	}else if(val==5){
	        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价" />';
	        	}else if(val==6){
	        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝" />';
	        	}else if(val==7){
	        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束" />';
	        	}else if(val==8){
	        		return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价" />';
	        	}else if(val==10){
	        		return '已作废';
	        	}
		}
		//渲染日期
		function formatDate(val){
			if (!val) {val = "";}
			if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
			     return val;
		}
		
		function rendererAuditStatus(val){
			if(val == 0){
				return '<i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审核通过" />';
			}else if(val == 1){
				return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notApprove" defaultValue="未审核" />';
			}else if(val == 2){
				return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审核中" />';
			}else if(val == 3){
				return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="未审核通过" />';
			}
		}
		
		function rendererOrderType(val){
			if(val==0){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirytype_market" defaultValue="行情询价" />';
        	}else if(val==1){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirytype_material" defaultValue="物料询价" />';
        	}else if(val==2){
        		return '<i18n:I18n key="i18n_enquiry_select_enquirytype_texture" defaultValue="材质询价" />';
        	}
		}
		
		function rendererDesc(val, item, rowIndex){
			if(item.materialNumber && item.materialDesc){
				return item.materialNumber+" - "+item.materialDesc;
			}
        	return "";
        }
		var cols =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchaseEnquiryHead_mt"/>;
		/* var cols = [
						{name:'operation',title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作" />',width:100, align:'center',renderer: enquiryHandle},
	        			{name:'purchaseEnquiryNumber',title:'<i18n:I18n key="i18n_enquiry_title_enquirynumber" defaultValue="询价单号" />',width:100, align:'center'},
	        			{name:'enquiryDesc',title:'<i18n:I18n key="i18n_enquiry_title_describe" defaultValue="描述"/>',width:100, align:'center'},
	        			{name:'purchaseGroup',title:'<i18n:I18n key="i18n_enquiry_title_purchasegroup" defaultValue="采购组"/>',width:100, align:'center'},//todo
	        			{name:'orderType', title:'<i18n:I18n key="i18n_enquiry_title_enquirytype" defaultValue="询价类型"/>', width:100, align:'center', renderer: rendererOrderType},
				        {name:'orderStatus', title:'<i18n:I18n key="i18n_enquiry_title_enquirystatus" defaultValue="询价单状态"/>', width:100, align:'center',renderer: rendererOrderStatus},
	        			{name:'auditStatus',title:'<i18n:I18n key="i18n_enquiry_title_auditStatus" defaultValue="审核状态"/>',width:100,align:'center', renderer: rendererAuditStatus},
	        			{name:'orderSendStatus',title:'<i18n:I18n key="i18n_enquiry_title_sendstatus" defaultValue="发送状态"/>',width:120,align:'center', renderer: rendererSendStatus},
	        			{name:'beginDate', title:'<i18n:I18n key="i18n_enquiry_title_enquirybegindate" defaultValue="询价开始日期"/>', width:100, align:'center',renderer:formatDate},
					    {name:'endDate', title:'<i18n:I18n key="i18n_enquiry_title_enquiryenddate" defaultValue="询价结束日期"/>', width:100, align:'center',renderer:formatDate},	
	        			{name:'total_count',title:'<i18n:I18n key="i18n_enquiry_title_invitesuppliercount" defaultValue="邀请供应商数量"/>',width:100, align:'center'},
	        			{name:'answer_count',title:'<i18n:I18n key="i18n_enquiry_title_replysuppliercount" defaultValue="回复供应商数量"/>',width:100, align:'center'},
	        			{name:'maker',title:'<i18n:I18n key="i18n_enquiry_title_maker" defaultValue="制单人"/>',width:70, align:'center'},
	        			{name:'writeSap',title:'<i18n:I18n key="i18n_enquiry_title_writesap" defaultValue="回写SAP"/>',width:80, align:'center'},
	        			{name:'readPurchaseOrder',title:'<i18n:I18n key="i18n_enquiry_title_extractpurchaseorder" defaultValue="提取采购订单"/>',width:90, align:'center'},
	        			{name:'purchaseOrderNumber',title:'<i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号"/>',width:90, align:'center'},//todo
	        			{name:'FBK4',title:'负责人',width:100, align:'center',hidden:true}
	        		]; */
	  enquiryManageTable =  $('#enquiryManageTable').mmGrid({
		cols: cols,
        url:"<%=basePath%>rest/PurchaseEnquiryItemService/findEnquiryList/"+elsAccount,
        method: 'post',
        params: frmObj,
        height:350,
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        root: 'rows',
        remoteSort:true,
        indexCol: true,
        checkCol:true,
        plugins: [
            $('#enquiryPage').mmPaginator({
                style: 'plain'
                , totalCountName: 'total'
                , page: 1
                , pageParamName: 'currentPage'
                , limitParamName: 'pageSize'
                , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                , limit: null
                , limitList: [100, 50, 30 , 10]
            })
        ]
      });
	  enquiryManageTable.on('loadSuccess',function(e,data) {
	       $('#enquiryManageTable').find("tr").each(function(){
	           var item = $(this).data("item");
	           if (item&&item.orderStatus == "10") {
	               $(this).css("background-color","rgba(213, 58, 58, 0.1)");
	           }
	       });
	   });
		window.purchQuery = function() {
			/* var orderType = $("#orderType").val();
			var purchaseEnquiryNumber = $("#purchaseEnquiryNumber").val();
			var beginDate = $("#beginDate").val();
			var endDate = $("#endDate").val();
			var FBK4 = $("#FBK4").val();
			var toElsAccount = $("#toElsAccount").val();
			var orderStatus = $("#orderStatus").val();
			var datas={"orderType":orderType,"purchaseEnquiryNumber":purchaseEnquiryNumber,"beginDate":beginDate,"endDate":endDate,"orderStatus":orderStatus,"FBK4":FBK4,"toElsAccount":toElsAccount};

			enquiryManageTable.load(datas); */
			var frm = $("#queryForm");
			enquiryManageTable.opts.params = frm.serializeJSON();
			enquiryManageTable.load({page:1});
		}
        //设置条件查询
		$("#enquirySeachBtn").click(function(){
			purchQuery();
		});

		 //初始化供应商下拉框
		 initSupplie();
		
        //打开新增采购询价单页面
		$("#addPurchaseEnquiry").click(function(){
			
			insertPurchaseOrder();
		});
        
		 $("#columnDefineBtn").click(function(){
			 parent.elsDeskTop.defineWin({
			     'iconSrc':'icon/els-icon.png',
			     'windowsId':'subAccountColumnSetting',
			     'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
			     windowSubTitle: "",
			     'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=purchaseEnquiryHead_mt" + "&window=iframeApp_purchaseEnquiryManage",
			     windowMinWidth: 480,
			     windowMinHeight: 600,
			     'windowWidth':480,
			     'windowHeight':600,
			     'parentPanel':".currDesktop"
			  });
			 });
		  //选择计量单位相关------------------begin--------------
		    function i18n(val,item,index){
			 	   if(val){
			 		   var arrayVal = val.split(":");
			 		   if(arrayVal.length == 2){
			 			   return '<i18n:I18n key="'+arrayVal[0]+'" defaultValue="'+arrayVal[1]+'"/>';
			 		   }else{
			 			   return val;
			 		   }
			 	   }else{
			 		   return "";
			 	   }
			     }
		  //触发弹出选择计量单位窗口事件
		  $("#querySupplier").click(function(){
		  	$("#selectUnitOfMeasurementDialog").show();
		  	if(selectSupplierTable == null || selectSupplierTable ==""){
		  	    var colsUnitOfMeasurement = [
		  			                { title:'<i18n:I18n key="i18n_common_title_supplierelsaccount" defaultValue="对方ElS帐号"/>', name:'friendElsAccount' , width:100, align:'center'},
		  			                { title:'<i18n:I18n key="i18n_common_title_suppliername" defaultValue="对方公司名称"/>', name:'friendCompanyName' , width:120, align:'center'},
		  			                { title:'<i18n:I18n key="i18n_common_title_supplierStairType" defaultValue="对方公司一级类型"/>', name:'groupIdAName' , width:100, align:'center',renderer:i18n},
		  			                { title:'<i18n:I18n key="i18n_common_title_supplierSecondType" defaultValue="对方公司二级类型"/>', name:'groupIdBName' , width:100, align:'center'}
		  			            ];
		  		     //初始化table
		  		     selectSupplierTable=$('#unit-of-measurement-table').mmGrid({
		  		         	height: 180,
		  		         	width: 410,
		  		            cols: colsUnitOfMeasurement,
		  		            url: "<%=basePath%>rest/FriendsService/findMyFriendsByType",
		  		            params: {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"groupIdAName":"供应商","friendCompanyName":""},
		  		  	        method: 'post',
		  	    	        height:280,
		  	    	        root: 'rows',
		  	    	        loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
		  	    	        noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
		  	    	        checkCol: true,
		  	    	        indexCol:true
		  		         });
		  		   selectSupplierTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
		  		    	 $('body').data('unitRow',item);
		  		     });
		  	}else{
		  		selectSupplierTable.load({"friendCompanyName":""});
			}
		  });
		    //选择供商弹出框确认按钮单击事件
		    $("#btnUnitOfMeasurementOK").click(function(){
		    	var selectedRows = selectSupplierTable.selectedRows();
		    	var suppliers ="";
		    	if(selectedRows != "" ){
		    		for(var i = 0 ; i < selectedRows.length ; i ++){
		    			var singleRow = selectedRows[i];
		    			var elsAccount = singleRow.friendElsAccount;
		    			if(i == 0){
		    				suppliers += elsAccount;
		    			}else{
		    				suppliers += ","+elsAccount;
		    			}
		    		}
		    	}
		    	$("#toElsAccount").val(suppliers);
		    	$("#selectUnitOfMeasurementDialog").hide();
		    });
		    $("#btnSelectSupplierDialogClose").click(function(){
		    	$("#selectUnitOfMeasurementDialog").hide();
		    });
		    $("#btnUnitOfMeasurementCancel").click(function(){
		    	$("#selectUnitOfMeasurementDialog").hide();
		    });
		  //模糊查询键入事件
		  $("#friendCompanyName").keyup(function(){
		  	var friendCompanyName = $("#friendCompanyName").val();
		  	selectSupplierTable.load({"friendCompanyName":friendCompanyName});f
		  });		    
	});
	 function initSupplie(){
		 $.ajax({
				url :"<%=basePath%>rest/FriendsService/findMyFriendsAndGroups",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"pageSize":1000}),
				success : function(data) {
					//var obj = JSON.parse(data);
					var option ="";
					if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							option += '<option value='+ data.rows[i].friendElsAccount+'>'+data.rows[i].friendCompanyName+'</option>';
						}
					}
					$('#toElsAccount').append(option);
					// rt(data.rows);
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(xhr.responseText, "Failed"); 
	        }
			});
	 }
	 function initSubAcount(){
		 $.ajax({
				url :"<%=basePath%>rest/AccountService/subAccountList",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount,"station":"purchase"}),
				success : function(data) {
					//var obj = JSON.parse(data);
					var option ="";
					if(data && data.rows && data.rows.length) {
						for(var i=0; i<=data.rows.length-1;i++) {
							if(data.rows[i].elsSubAccount == elsSubAccount){
								option += '<option value='+ data.rows[i].elsSubAccount+' selected>'+data.rows[i].name+'</option>';
							}else{
							    option += '<option value='+ data.rows[i].elsSubAccount+'>'+data.rows[i].name+'</option>';
							}
						}
					}
					$('#FBK4').append(option);
					// rt(data.rows);
				},
				error: function (xhr, type, exception) {//获取ajax的错误信息
	            alert(xhr.responseText, "Failed"); 
	        }
			});
		}
	
	 function insertPurchaseOrder(){
		    var currId=$(window.frameElement).attr('id');
			//获取对方elsAccount
			var toElsAccount = "<%=request.getParameter("toElsAccount")%>";
		    parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/destop-icon/desktop_icon_120.gif',
		        'windowsId':'PurchaseEnquiryAdd',
		        'windowTitle':'<i18n:I18n key="i18n_enquiry_windowtitle_purchaseenquirycreate" defaultValue="新建采购询价单" />',
		        windowSubTitle: companyShortName,
		        'iframSrc':'<%=basePath%>enquirymanage/purchase/addEnquiryMain.jsp?toElsAccount=' + toElsAccount+"&currId="+currId,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
		}
//复制询价单
$("#copyBtn").live("click", function() {
	var selectRow = enquiryManageTable.selectedRows();
	if(selectRow.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var row = selectRow[0];
	var param = {"elsAccount":elsAccount,"purchaseEnquiryNumber":row.purchaseEnquiryNumber};
	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认是否复制该询价单？",closeEvent:function(){
		parent.elsDeskTop.showLoading("复制中");
		$.ajax({
			url :"<%=basePath%>rest/PurchaseEnquiryItemService/copyPurchaseEnquiry",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("复制询价单成功！询价单号为: "+data.purchaseEnquiryNumber,1);
				purchQuery();
			},
			error: function (msg) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("询价单复制失败:"+msg.responseText,3); 
	        }
		});
	}});
    
});
//校验比价
function checkPrice(purchaseEnquiryNum){
	var material = [{
    	'elsAccount':elsAccount,
    	'purchaseEnquiryNumber':purchaseEnquiryNum
    }];
	var flag = true;
	$.ajax({
		url : '<%=basePath%>rest/inquiry/PurchaseEnquiryBargainService/queryEnquiryItemsByCondtion' + "?t="+new Date().getTime(),
		type : 'POST',
		async: false,
		contentType : "application/json",
		data : JSON.stringify(material),
		dataType : "json",
		success : function(data) {
			if(data != null){
				var rows = data.rows;
				for(i=0;i<rows.length;i++){
					console.log(rows[i].orderStatus);
					if(rows[i].orderStatus != 8){//为报价状态
						console.log(rows[i].orderStatus);
						flag = false;
					}
				}
			}
		}
	});
	return flag;
}

//查看是否重新报价
function checkHistory(purchaseEnquiryNumber,materialNumber){
	var flag = false;
	var material = {"purchaseEnquiryNumber":purchaseEnquiryNumber,"elsAccount":elsAccount};
	$.ajax({
		url : '<%=basePath%>rest/inquiry/PurchaseEnquiryBargainService/queryPriceHistory' + "?t="+new Date().getTime(),
		type : 'POST',
		async: false,
		contentType : "application/json",
		data : JSON.stringify(material),
		dataType : "json",
		success : function(data) {
			if(data.rows != null && data.rows.length>0){
				flag = true;
			}
		}
	});
	return flag;
}
//撤回询价单
$("#recallBtn").live("click", function() {
	var selectRow = enquiryManageTable.selectedRows();
	if(selectRow.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var row = selectRow[0];
	var auditStatus = row.auditStatus;
	var orderStatus = row.orderStatus;
	if(auditStatus != 1 && auditStatus != 2 || orderStatus == 10){
		alert("当前状态不可撤回！",2);
		return;
	}
	if(row.orderStatus == 0 ){
		alert("当前状态无需撤回！",2);
		return;
	}
	var param = {"elsAccount":elsAccount,"purchaseEnquiryNumber":row.purchaseEnquiryNumber};
	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认是否撤回该询价单？",closeEvent:function(){
		parent.elsDeskTop.showLoading("撤回中");
		$.ajax({
			url :"<%=basePath%>rest/SaleEnquiryService/cancelSaleEnquiryInfo",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				if(data&&data.statusCode=="-100"){
					alert(data.message,2);
				}else if(data&&data.statusCode=="-200"){
					alert(data.message,3);
				}else{
					alert("撤回询价单成功！",1);
					purchQuery();
				}
				parent.elsDeskTop.hideLoading();
			},
			error: function (msg) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("询价单撤回失败:"+msg.responseText,3); 
	        }
		});
	}});
    
});


//作废询价单
$("#cancellationBtn").live("click", function() {
	var selectRow = enquiryManageTable.selectedRows();
	if(selectRow.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var row = selectRow[0];
	var orderStatus = row.orderStatus;
	if(orderStatus == 10){
		alert("当前已经是作废状态",1);
		return;
	}
	var param = {"elsAccount":elsAccount,"purchaseEnquiryNumber":row.purchaseEnquiryNumber};
	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认是否作废该询价单？",closeEvent:function(){
		parent.elsDeskTop.showLoading("作废中");
		$.ajax({
			url :"<%=basePath%>rest/SaleEnquiryService/invalidateSaleEnquiryInfo",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				alert("作废询价单成功！",1);
				purchQuery();
			},
			error: function (msg) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert("询价单作废失败:"+msg.responseText,3); 
	        }
		});
	}});
    
});

var oceanApp = {
        sequence : 1,
        server:"auth.1688.com",
        appSignature: function(url, secretPassphrase){
            var msg = "";
            var msgArray = [];
            var tmp = url.split('&');
            for(var i=0;i<tmp.length;i++){
                var f = tmp[i].indexOf('=');
                if(f>0){
                	msgArray.push(tmp[i].substring(0, f) + tmp[i].substr(f + 1));
                }else{
                	msgArray.push(tmp[i]);
                }
            }
            msgArray.sort();
            msg += msgArray.join('');
            var hmacBytes = Crypto.HMAC(Crypto.SHA1, msg, secretPassphrase, { asBytes: true });
            var hmacString = Crypto.util.bytesToHex(hmacBytes);
            return [msg,hmacString.toUpperCase()];
        },
        apiSignature: function(url, data, secretPassphrase){
			var flag = url.indexOf('?');
			var msg;
			var msgArray = new Array();
			if(flag>0){
				msg = url.substring(0, flag);
				var tmp = url.substr(flag + 1).split('&');
				for(var i=0;i<tmp.length;i++){
					var f = tmp[i].indexOf('=');
					if(f>0){
						msgArray.push(tmp[i].substring(0, f) + tmp[i].substr(f + 1));
					}else{
						msgArray.push(tmp[i]);
					}
				}
			}else{
				msg = url;
			}
			if(data){
				var tmp = data.split('&');
				for(var i=0;i<tmp.length;i++){
					var f = tmp[i].indexOf('=');
					if(f>0){
						msgArray.push(tmp[i].substring(0, f) + tmp[i].substr(f + 1));
					}else{
						msgArray.push(tmp[i]);
					}
				}
			}
			msgArray.sort();
			msg += msgArray.join("");
			//var hmac = Crypto.HMAC(Crypto.SHA1, "Message", "Secret Passphrase");
	
	        //var hmacString = Crypto.HMAC(Crypto.SHA1, msg, secretPassphrase, { asString: true });
			var hmacBytes = Crypto.HMAC(Crypto.SHA1, msg, secretPassphrase, { asBytes: true });
	        var hmacString = Crypto.util.bytesToHex(hmacBytes);
	        return [msg,hmacString.toUpperCase()];
		}};
//回调地址
var getRedirectUri = function(){
    return "http://test.51qqt.com:8080/ELSServer_MT/alibabaLoginSuccess.jsp" ;
};
//登录到alibaba
$("#AlibabaLoginBtn").live("click", function() {
	// 授权参数
	var appKey = "9892196";
    var site = "china";
    var redirect_uri = getRedirectUri();
    var secretPassphrase = "YTIiMLP1bS";//密钥
    var urlParam = "client_id=" + appKey +"&site=" + site + "&redirect_uri=" + redirect_uri;
    
    var result = oceanApp.appSignature(urlParam, secretPassphrase);
    var signUrl = urlParam + "&_aop_signature=" + result[1];
	var url = "http://" + oceanApp.server + "/auth/authorize.htm?" + signUrl;
	debugger;
// 	window.open(url);
// 	window.close();
// 	windows.close(url);
	var redirect = "<%=basePath%>rest/AlibabaWebService/invokePostBuyoffer2Alibaba";
	var redirect_uri = encodeURI(redirect);
	var url = "http://auth.1688.com/auth/authorize.htm?client_id=6685013&site=china&redirect_uri="+redirect_uri+"&_aop_signature=C365402217B204830146D865B6519ED3BF04F69E";
// 	window.open("http://auth.1688.com/auth/authorize.htm?client_id=6685013&site=china&redirect_uri=http://localhost:8080&_aop_signature=C365402217B204830146D865B6519ED3BF04F69E");
// 	window.open("http://auth.1688.com/auth/authorize.htm?client_id=6685013&site=china&redirect_uri='+redirect_uri+'&_aop_signature='+aop_sign'");
	var selectRow = enquiryManageTable.selectedRows();
	if(selectRow.length < 1){
		alert('<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>',2);
		return;
	}
	var row = selectRow[0];
	var orderStatus = row.orderStatus;
	if(orderStatus == 10){
		alert("当前已经是作废状态",1);
		return;
	}
	var param = {"elsAccount":elsAccount,"purchaseEnquiryNumber":row.purchaseEnquiryNumber};
// 	parent.elsDeskTop.tip.init({type: 'confirm',message: "确认是否登录到阿里巴巴？",closeEvent:function(){
		parent.elsDeskTop.showLoading("登录中");
		$.ajax({
			url :"<%=basePath%>rest/PurchaseEnquiryItemService/getetQuotationBatchFrom1688",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(param),
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				purchQuery();
			},
			error: function (msg) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	        }
		});
// 	}
// 	});
    
});

$("#AlibabaGetBtn").live("click", function() {
	var param = {"elsAccount":elsAccount};
	parent.elsDeskTop.showLoading("获取中");
	$.ajax({
		url :"<%=basePath%>rest/PurchaseEnquiryItemService/getQuotationBatchFrom1688",
		type :"POST",
		contentType : "application/json",
		dataType : "json",
		data:JSON.stringify(param),
		success : function(data) {
			parent.elsDeskTop.hideLoading();
			alert("获取成功！",1);
			purchQuery();
		},
		error: function (msg) {//获取ajax的错误信息
			parent.elsDeskTop.hideLoading();
            alert("获取失败:"+msg.responseText,3); 
        }
	});
});

</script>

<body>
<div class="box-wrap pos-relative bg-common">
       <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button id="addPurchaseEnquiry" class="button-wrap"><i18n:I18n key="i18n_common_button_create" defaultValue="新建" /></button>
                <button id="copyBtn" class="button-wrap">复制</button>
                <button id="recallBtn" class="button-wrap">撤回</button>
                <button id="cancellationBtn" class="button-wrap">作废</button>
<!--                 <button id="AlibabaLoginBtn" class="button-wrap">登录到阿里巴巴</button> -->
                <button id="AlibabaGetBtn" class="button-wrap">一键获取阿里巴巴报价</button>
                <button id="enquirySeachBtn" class="button-wrap" ><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
       		</div>
        </div>
        <form id="queryForm">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <input type="hidden" id="elsAccount" name="elsAccount"/>
            <input type="hidden" id="elsSubAccount" name="elsSubAccount"/>	
            <input type="hidden" id="pageSize" name="pageSize" value="20">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">		
			<div class="common-box-line">
			<div>
					<div class="dis-in-b input-and-tip"> 
						<span><i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />：</span>
						<select class="" id="FBK4" name="FBK4">
							<option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
							<!-- <option value="105013">llie</option>
							<option value="105015">Elie</option> -->
						</select>
					</div>	
		        <div class="dis-in-b input-and-tip pos-relative">
			       <span><i18n:I18n key="i18n_enquiry_label_supplier" defaultValue="供应商" />：</span><input id="toElsAccount" name="toElsAccount" type="text" style="width:200px;padding-right:20px;" onkeyup="value=value.replace(/[^(\d,)]/g,'')"/>
			       <img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="querySupplier" title='<i18n:I18n key="i18n_common_title_querySupplier" defaultValue="查找供应商" />' />
		        </div>

					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="i18n_enquiry_label_enquirynumber" defaultValue="供询价单号" />：</span><input id="purchaseEnquiryNumber"
							name="purchaseEnquiryNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip"> 
						<span><i18n:I18n key="i18n_enquiry_label_enquirytype" defaultValue="供询价单类型" />：</span>
						<select class="" id="orderType" name="orderType">
						    <option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
							<option value="0"><i18n:I18n key="i18n_enquiry_select_enquirytype_market" defaultValue="行情询价" /></option>
							<option value="1"><i18n:I18n key="i18n_enquiry_select_enquirytype_material" defaultValue="物料询价" /></option>
							<option value="2"><i18n:I18n key="i18n_enquiry_select_enquirytype_texture" defaultValue="材质询价" /></option>
						</select>
					</div>
	
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="i18n_enquiry_label_enquirystatus" defaultValue="供询价单状态" />：</span>
						<select class="" id="orderStatus" name="orderStatus">
							<option value=""><i18n:I18n key="i18n_common_select_all" defaultValue="全部" /></option>
							<option value="0"><i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" /></option>
							<option value="1"><i18n:I18n key="i18n_enquiry_select_enquirystatus_quoteproceed" defaultValue="报价中" /></option>
							<option value="4"><i18n:I18n key="i18n_enquiry_select_enquirystatus_againquote" defaultValue="重报价" /></option>
							<option value="3"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option>	
							<option value="5"><i18n:I18n key="i18n_enquiry_select_enquirystatus_havepricing" defaultValue="已定价" /></option>	
							<option value="6"><i18n:I18n key="i18n_enquiry_select_enquirystatus_rejected" defaultValue="已拒绝" /></option>
							<option value="7"><i18n:I18n key="i18n_enquiry_select_enquirystatus_finished" defaultValue="已结束" /></option>	
							<option value="8"><i18n:I18n key="i18n_enquiry_select_enquirystatus_quotedprice" defaultValue="已报价" /></option>	
							<option value="10"><i18n:I18n key="" defaultValue="已作废" /></option>					
						</select>
					</div>

				    <div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料描述" />:</span>
						<input id="enquiryDesc" name="enquiryDesc" type="text" />
					</div>	
					<div class="dis-in-b input-and-tip">
					    <span><i18n:I18n key="i18n_enquiry_label_enquirydate" defaultValue="供询价日期" />：</span>
					    <input type="text" class="Wdate" onfocus="WdatePicker({lang:'<%=language%>'})" id="beginDate" name="beginDate"/>
					 </div>
	                <div class="dis-in-b input-and-tip">
	                    <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                    <input type="text"  class="Wdate" onfocus="WdatePicker({lang:'<%=language%>'})" id="endDate" name="endDate"/>
	                </div>
	                
	                 <div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="采购申请单号" />:</span>
						<input id="purchaseOrderNumber" name="purchaseOrderNumber" type="text" />
					</div>
				</div>
			</div>
		</div>
	   </form>
		
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100"  id="enquiryHeaderGrid">
                        <table id="enquiryManageTable"></table>
                        <div id="enquiryPage" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
<div class="fixed-dialog" id="selectUnitOfMeasurementDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height: 383px;margin-left: -205px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectSupplierDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectUnitOfMeasurementDialog"><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择计量单位" /></span>
	        <input type="hidden" id ="price_index"/>
	        <input type="hidden" id ="price_materialLineJson"/>
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filtercondition" defaultValue="过滤条件" /></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td width="80px"><input  type="text" id="friendCompanyName" name="friendCompanyName" /></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="unit-of-measurement-table"></table>
                    </div>
                    <div class="mt-20 text-center" >
	                    <button id="btnUnitOfMeasurementOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnUnitOfMeasurementCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
	</div>
</body>
</html>