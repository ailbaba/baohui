<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<%=basePath %>jsLib/webuploader/css/webuploader.css" />
<!--引入JS-->
<script type="text/javascript" src="<%=basePath %>jsLib/webuploader/js/webuploader.js"></script>
<body>
	<div class="pos-relative public-wrap">
	<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button class="button-wrap" id="inputSession"><i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" /></button>
             	<button class="button-wrap" id="updateSchedule"><i18n:I18n key="i18n_button_updateprogress" defaultValue="更新进度" /></button>
             	<button class="editBtn button-wrap" id="downloadBtn" >进度导出</button>
                <button class="button-wrap" id="uploadBtn">进度导入</button>
                <button class="button-wrap" id="toErp"><i18n:I18n key="i18n_button_toERP" defaultValue="写入ERP" /></button>
	            <button class="button-wrap" id="exportBtn">订单导出</button>
	            <button id="printBtn" class="button-wrap"><i18n:I18n key="i18n_button_print" defaultValue="打印" /></button>
                <button class="button-wrap" id="scheduleReport"><i18n:I18n key="i18n_label_scheduleReport" defaultValue="订单进度汇总查询报表" /></button>
<%--            <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出" /></button> --%>
            </div>
        </div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_purchaseels" defaultValue="采购方ELS号" />：</span>
					<input id="toElsAccounts" name="toElsAccounts" type="text" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_label_saleOrderNumber" defaultValue="销售订单号" />：</span>
					<input id="saleOrderNumber" name="saleOrderNumbers" type="text" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />：</span>
					<input id="purchaseOrderNumber" name="purchaseOrderNumbers" type="text" />
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
				<span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_label_orderdate" defaultValue="订单日期" />：</span>
				</div>
                <input type="radio" name="dateArea" value="week" checked><i18n:I18n key="i18n_label_lastweek" defaultValue="最近一周" />
                <input type="radio" name="dateArea" value="month"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
                <input type="radio" name="dateArea" value="threeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
                <input type="radio" name="dateArea" value="define"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
                <div class="dis-in-b input-and-tip" style="display:none;">
                <input type="text" class="Wdate" onfocus="WdatePicker()" id="startOrderDate" name="startOrderDate"/>
                </div>
                <div class="dis-in-b input-and-tip" style="display:none;">
                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /> </span>
                <input type="text" id="endOrderDate" class="Wdate" onfocus="WdatePicker()" name="endOrderDate" />
                </div>
				<div class="dis-in-b input-and-tip">
					<button class="button-wrap" id="seachBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
					<button style="margin-left: 15px;" id="columnDefineBtn" class="button-wrap">
					<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />
					</button>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_saleOrder_head" defaultValue="销售订单头" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-head">
					<div id="sheet-item-one">
						<main class="grid-container">
						<div class="grid-100" id="saleOrderHeaderGrid">
							<table id="saleOrderHeaderTable"></table>
							<div id="pg" style="text-align: right;"></div>
						</div>
						</main>
					</div>
				</div>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_title_saleOrder_item" defaultValue="销售行项目" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
				 	<ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_title_saleOrder_item" defaultValue="销售行项目" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
                    </ul>
					<div id="sheet-project-one">
					<button style="margin-left: 10px;margin-bottom:10px;" id="itemColumnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
<!-- 						<input type="checkbox" id="showDelete"/>显示删除行 -->
						<main class="grid-container">
						<div class="grid-100" id="saleOrderItemGrid">
							<table id="saleOrderItemTable"></table>
						</div>
						</main>
					</div>
					<div id="sheet-project-two">
                        <main class="grid-container">
		                    <div class="grid-100" id="table-file-grid">
		                        <table id="table-file"></table>
		                    </div>
		                </main>
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
	var $sob;
	var cols;
	var headGrid;
	var itemGrid;
	var peopleList;
	var printData ={};
	var isNull=false;
	var chatFromUrlFlag = false;
	var currentPurchaseOrderNumber;
	var saleOrderNumber;
	var elsAccount='<%=session.getAttribute("elsAccount") %>';
	var elsSubAccount='<%=session.getAttribute("elsSubAccount") %>';
	var toElsAccount = "";
	
	$(document).ready(function() {
		$("#sheet-project").tabs();
		isDisplayIntefaceButton();
		changeDateArea();
		$("[name=dateArea]").click(changeDateArea);
		//获取查看消息采购订单号
		$("#elsAccount").val(elsAccount);
		var initpurchaseOrderNumber = window.queryChats('q');
		if(initpurchaseOrderNumber && initpurchaseOrderNumber.length) {
			if(initpurchaseOrderNumber.lastIndexOf(',')!=-1 ) {
				$("#purchaseOrderNumber").val(initpurchaseOrderNumber.substring(0,initpurchaseOrderNumber.length-1));
				$(':radio[name="dateArea"]').eq(0).attr("checked",false);
				$(':radio[name="dateArea"]').eq(3).attr("checked",true);
			} else {
				$(':radio[name="dateArea"]').eq(0).attr("checked",false);
				$(':radio[name="dateArea"]').eq(3).attr("checked",true);
			}
		}
	});
	
	//载入销售订单头数据
	insertSaleOrderHeaderTable();
	  
	function getDate(dates){
		var dd = new Date();
		dd.setDate(dd.getDate()+dates);
		return dd.format("yyyy-MM-dd");
	}
	
	function changeDateArea() {
		var dateArea = $("[name=dateArea]:checked").val();
		if (dateArea == "define") {
			$("#startOrderDate").val("");
			$("#endOrderDate").val("");
			$("#startOrderDate").parent().show();
			$("#endOrderDate").parent().show();
		} else {
			$("#startOrderDate").parent().hide();
			$("#endOrderDate").parent().hide();
			$("#endOrderDate").val(new Date().format("yyyy-MM-dd"));
			var startOrderDate = "";
			if (dateArea == "week") {
				startOrderDate = getDate(-7);
			} else if (dateArea == "month") {
				startOrderDate = getDate(-30);
			} else if (dateArea == "threeMonth") {
				startOrderDate = getDate(-90);
			}
			$("#startOrderDate").val(startOrderDate);
		}
	}
		
	 //初始化聊天窗口
	 //ELS账号+订单号 作为 businessID,fbk4采购方,fbk5销售方
	 function initChat(businessID,fbk4, hadSelected) {
			if (toElsAccount == "") {
				$('.testIframe').attr('src','');
				return;
			}
	  		//采购凭证号
	  		var purchaseOrderNumberList = [];
	  		//订单号
	  		var bIdList = [];
	  		//聊天显示列表
	  		var chatList = [];
	  		if(hadSelected && hadSelected.length) {
	  			hadSelected.forEach(function(d,i){
	  				var obj ={};
	  				obj[d.purchaseOrderNumber] = d.fbk4 || '' ;
	  				bIdList.push(obj); 
	  				chatList.push(d.purchaseOrderNumber);
	  			});
	  			chatList=chatList.map(function(d){
	  				return {name:d}
	  			});
           }
		    //初始化iframe
	  		var toElsSubAccount;
	  	  	//多人聊天  type=multi 一对一 type=single  list 用来显示列表人
	  	  	bIdString = bIdList&&bIdList.length?'['+bIdList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	  	peopleListString = peopleList&&peopleList.length?'['+peopleList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	  	chatListString = chatList&&chatList.length?'['+chatList.map(function(obj) {return JSON.stringify(obj)}).join()+']': '';
	  	  	var url = "multiChatTest.jsp?type=multi&fromElsAccount="
	  				+ elsAccount
	  				+ "&fromElsSubAccount="
	  				+ elsSubAccount
	  				+ "&toElsAccount="
	  				+ toElsAccount
	  				+ "&toElsSubAccount="+peopleListString
	  				+ "&businessType=order"
	  				+ "&businessID="+bIdString
	                  + "&list="+ (chatListString&&chatListString.length?chatListString : peopleListString)
	  				+"&t="+new Date().getTime();
	  	   
	  	   $('.testIframe').attr('src','<%=basePath%>'+ url);
	  	   //滚动条美化niceScroll
	  	   $('.public-wrap').niceScroll({cursorcolor : "#ddd",cursorwidth:"4px"});
	  }

	//将销售订单表头数据插入表格中
	function insertSaleOrderHeaderTable(){
			$sob = $('.saying-dialog .option-bar');
			$('#saleOrderHeaderGrid').html('<table id="saleOrderHeaderTable"></table><div id="pg" style="text-align: right;"></div>');
			//列
			var cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleOrderBatchManage"/>;
			var paramStr={"elsAccount":elsAccount,"saleOrderNumbers":$("#saleOrderNumber").val().trim(),
					      "purchaseOrderNumbers":$("#purchaseOrderNumber").val().trim(),
					      "startOrderDate":$("#startOrderDate").val().trim(),
					      "endOrderDate":$("#endOrderDate").val().trim()
					      };
		    //本地示例
		     headGrid= $('#saleOrderHeaderTable').mmGrid({
		    	 cols: cols,
		         url: "<%=basePath%>rest/SaleOrderService/querySaleOrderHeadByCondtion",
		         params:paramStr,
		         method:'post',
		         root:"rows",
		         loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		         noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		         multiSelect: true,
		         checkCol:true,
		         remoteSort:true,
		         plugins: [
		             $('#pg').mmPaginator({
		                 style: 'plain'
		                 , totalCountName: 'total'
		                 , page: 1
		                 , pageParamName: 'currentPage'
		                 , limitParamName: 'pageSize'
		                 , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
		                 , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
		                 , limit:null
		                 , limitList: [10,20]
		             })
		         ]
		    });
		    
		     headGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
		    	
		    	toElsAccount = item.toElsAccount;
	        	currentPurchaseOrderNumber = item.purchaseOrderNumber;
		    	saleOrderNumber = item.saleOrderNumber;
		    	
		    	$('body').data('selectHead',headGrid.selectedRows());
		    	
		    	//初始化上传按钮
		    	uploadSchedule();
		    	
		    	var itemIds = "";
		    	var hadSelected = headGrid.selectedRows();
		    	var multiToEls = false;
	        	hadSelected.forEach(function(val){
	        		if (val.toElsAccount != toElsAccount) {
	        			multiToEls = true;
	        		}
	        		itemIds = itemIds + "," + val.saleOrderNumber;
	        	});
	        	if(itemIds != ""){
	        		itemIds = itemIds.substring(1);
	        	} else {
	        		toElsAccount = "";
	        	}
	        	if (multiToEls) {
	        		toElsAccount = "";
	        	}
		     	
		    	insertSaleOrderItemTable(itemIds);
		    	insertSaleOrderFileTable(1,itemIds);
		    	
	        	// 动态加载聊天窗口
	    		if(hadSelected && hadSelected.length) {
	    			if(chatFromUrlFlag) {
	    				initChat(elsAccount+"_"+item.saleOrderNumber,item.fbk4,hadSelected);
	    			}
	        	} else {
	        		initChat();
	        	}
		     });
		    
		    headGrid.on('loadSuccess',function(e, data) {
		    	
		    	if (data.rows && data.rows.length > 0){
		    		headGrid.select(0);
		    		toElsAccount = headGrid.row(0).toElsAccount;
		    		uploadSchedule();
		    	}
		    		    	
		    	if(data.rows && data.rows.length > 0){
		    		
		    		isNull=false;
		    		
		    		// 初始化聊天参数
		    		var flag = window.queryChats('flag');
		    		var chatString = window.queryChats('q');
		    		var chatArr =[];
		    		if(chatString && chatString.length) {
		    			if(chatString.lastIndexOf(',') != -1 ) {
		    				chatArr = chatString.substring(0,chatString.length-1).split(',');
		    			} else {
		    				chatArr = chatString.substring(0,chatString.length).split(',');
		    			}
					}
		    		var hadSelected = [];
		    		if(flag !='businessObj' || !flag) {
		 					chatArr=chatArr.map(function(d){
		 	   					return {name:d}
		 	   				}); 
		   				var listName = [];
		   				data.rows.forEach(function(d){
		    				if(d.fbk4&&listName.indexOf(d.fbk4)===-1){
		    					listName.push(d.fbk4);
		    				}
		    			});
		   				listName=listName.map(function(d){
		   					return {name:d}
		   				}); 
		   				peopleList = chatArr && chatArr.length?chatArr:listName;
		   				initChat();
		    		} else if(flag == 'businessObj') {
		    			//订单
		    			var rows = data.rows;
		    			for(var i=0;i < rows.length;i++) {
			   				for(var j=0;j<chatArr.length;j++) {
			       					if(rows[i].purchaseOrderNumber==chatArr[j]) {
			       						headGrid.select(i)
			       					}
			       				}
		    			}
		    			//存储选中的的行数据，用作打印判断
		    			if(headGrid.selectedRows() && headGrid.selectedRows().length) {
		    				$('body').data('selectHead',headGrid.selectedRows());
		    				hadSelected = headGrid.selectedRows()
		    			} else {
		    				hadSelected = chatArr.map(function(d){
		    					return {purchaseOrderNumber:d,fbk4:''};
		    				});
		    			}
		    			peopleList = [];
		    			data.rows.forEach(function(d){
		    				if(d.fbk4&&peopleList.indexOf(d.fbk4)===-1){
		    					peopleList.push(d.fbk4);
		    				}
		    			});
		    			peopleList=peopleList.map(function(d){
		   					return {name:d}
		   				}); 
		    			initChat('','',hadSelected);
		    		}
		    		//打开聊天行选择开关
		    		chatFromUrlFlag = true;
		            currentPurchaseOrderNumber = data.rows[0].purchaseOrderNumber;
		    		saleOrderNumber=data.rows[0].saleOrderNumber;
					//初始化聊天控制状态
		            if($sob[0].toggleState)$sob[0].toggleState = ($sob[0].toggleState+3) % 4;
		            $sob.click();
		    	}

	    		isNull=true;
	    		insertSaleOrderItemTable("");
	    		insertSaleOrderFileTable(1,"");
	    		//全选事件  @author jiangzhidong @date 20161010 begin
	    	    $('#saleOrderHeaderGrid').find('.mmg-head .checkAll').bind('click',function() {
	    	    	if($(this).attr('checked')) {
	    	    		headGrid.select('all');
	    	    		var itemIds = "";
	    		    	var hadSelected = headGrid.selectedRows();
	    		    	var multiToEls = false;
	    	        	hadSelected.forEach(function(val){
	    	        		if (val.toElsAccount != toElsAccount) {
	    	        			multiToEls = true;
	    	        		}
	    	        		itemIds = itemIds + "," + val.saleOrderNumber;
	    	        	});
	    	        	if(itemIds != ""){
	    	        		itemIds = itemIds.substring(1);
	    	        	} else {
	    	        		toElsAccount = "";
	    	        	}
	    	        	if (multiToEls) {
	    	        		toElsAccount = "";
	    	        	}
	    		    	insertSaleOrderItemTable(itemIds);
	    		    	insertSaleOrderFileTable(1,itemIds);
	    	    	} else {
	    	    		headGrid.deselect('all');
	    	    		var itemIds = "";
	    		    	var hadSelected = headGrid.selectedRows();
	    		    	var multiToEls = false;
	    	        	hadSelected.forEach(function(val){
	    	        		if (val.toElsAccount != toElsAccount) {
	    	        			multiToEls = true;
	    	        		}
	    	        		itemIds = itemIds + "," + val.saleOrderNumber;
	    	        	});
	    	        	if(itemIds != ""){
	    	        		itemIds = itemIds.substring(1);
	    	        	} else {
	    	        		toElsAccount = "";
	    	        	}
	    	        	if (multiToEls) {
	    	        		toElsAccount = "";
	    	        	}
	    		    	insertSaleOrderItemTable(itemIds);
	    		    	insertSaleOrderFileTable(1,itemIds);
	    	    	}
	    	    });
	    	    //全选事件  @author jiangzhidong @date 20161010 end
		    });
		}
		
		$("#downloadBtn").click(function(){
			var rows = headGrid.selectedRows();
			if (rows.length == 0) {
				alert("<i18n:I18n key='i18n_pleasechoose' defaultValue='请选择订单' />",2);
				return;
			}
			var purchaseOrderNumbers = "";
			for (var i=0;i< rows.length;i++) {
				purchaseOrderNumbers += rows[i].purchaseOrderNumber + ",";
			}
			purchaseOrderNumbers = purchaseOrderNumbers.substring(0,purchaseOrderNumbers.length - 1);
			window.location.href = "<%=basePath%>rest/OrderScheduleService/downloadTemplateBatch/"+elsAccount+"/"+ toElsAccount + "/" + purchaseOrderNumbers;
		});
		
		//点击查询
		$("#toErp").click(function(){
			toErp();
		});
		
		//点击查询
		$("#seachBtn").click(function(){
			insertSaleOrderHeaderTable();
		});
		$("#updateSchedule").click(function(){
			updateSchedule();
		});
		$("#scheduleReport").click(function(){
			//兼容ie 冒泡事件
		    if (event && event.preventDefault) {
		        event.preventDefault();
		        event.stopPropagation();
		    } else {
		        window.event.returnValue = false;
		    }
		    parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'saleOrderScheduleReport',
		        'windowTitle':'<i18n:I18n key="i18n_label_scheduleReport" defaultValue="订单进度汇总查询报表" />',
		        windowSubTitle: saleOrderNumber,
		        'iframSrc':'<%=basePath%>report/saleOrderScheduleReport.jsp?toElsAccount=' + toElsAccount,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
		});
		//将销售订单项数据插入表格中
		function insertSaleOrderItemTable(itemIds){
			cols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="saleOrderItem"/>;
			//增加删除标识
			cols.push({
				"title":"删除标识",
				"name":"deleteFlag",
				"align":"center",
				renderer:function(val){
					var txt = "";
					if(!val) val="";
					if (val=="C") {
						txt = "删除待确认";
					} else if (val=="X") {
						txt = "已删除";
					}
					return txt;
				}
			});
			if (!itemGrid) {
				itemGrid = $('#saleOrderItemTable').mmGrid({
			        cols: cols,
			        items:[],
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
				itemGrid.on("loadSuccess",function(e,d){
					if (d) {
						initModifyFiled(itemGrid.rows());
					}
				});
			}
			//列
		    if(itemIds==""){
		    	//本地示例
		    	itemGrid.load([]);
		    }else{
		    	var paramStr={"elsAccount":elsAccount,"itemIds":itemIds};
		    	//本地示例
				$.ajax({
					url : "<%=basePath%>rest/SaleOrderService/findSaleOrderItem",
					type : "post",
					dataType : "json",
					contentType : "application/json",
					data:JSON.stringify(paramStr),
					success : function(data) {
						$('body').data('findSaleOrderItem',data);
						if (data.length > 200) {
							loadPartItem(0,200,data);
						} else {
							if (itemGrid) {
								itemGrid.load(data);
							} else {
								itemGrid = $('#saleOrderItemTable').mmGrid({
							        cols: cols,
							        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
							        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
							        checkCol:true,
							        items: data
							    });
							}
						}
					},
					error : function(data) {
		    			if (!permissionError(data)) {
		    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
		    			}
					}
				});
		    }
		}
		
		function loadPartItem(start,size,data) {
			var array = [];
			for (var i=0;i<size;i++) {
				array[i] = data[start+i];
			}
			start = start + size;
			if (itemGrid) {
				itemGrid.addRows(array);
			} else {
				itemGrid = $('#saleOrderItemTable').mmGrid({
			        cols: cols,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
			        checkCol:true,
			        items: array
			    });
			}
			if (start < data.length) {
				setTimeout(function(){
					if (data.length - start > 200) {
						loadPartItem(start,200,data);
					} else {
						loadPartItem(start,data.length-start,data);
					}
				},200);
			}
		}
		
		function insertSaleOrderFileTable(status,itemIds){
			$('#table-file-grid').html('<table id="table-file"></table>');
			var cols_file = [
				             { title:'<i18n:I18n key="i18n_label_creator" defaultValue="创建者" />', name:'createBy' ,width:80, align:'center',renderer:function(val){
				                 	if (val != "" && val!=null&& val!=elsAccount) {
				                 		return "<i18n:I18n key="i18n_common_purchase;" defaultValue=";采购方;" />";;
				                	} else {
				                		return "<i18n:I18n key="i18n_common_sale;" defaultValue=";销售方;" />";;
				                	} 
				             }},
			                 { title:'<i18n:I18n key="i18n_enquiry_label_check" defaultValue="查看" />', name:'filePath', width: 80, align: 'center',renderer:function(val,item,index){
			                	 if(!item.fbk1){
			                		 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/downloadServlet?filePath="+ val +"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
			                	 }else{
			                		 var fileType = item.fileType;
			                 		 var fileName = item.fileName+"."+fileType;
			                 		 return "<a name='rowBtn' class='button-wrap' href='<%=basePath%>servlet/download4OSSServlet?filePath="+ val +"&fileName="+fileName+"'><i18n:I18n key='i18n_enquiry_label_check' defaultValue='查看' /></a>";
			                	 }
			                 }},
			                 { title:'<i18n:I18n key="i18n_common_saleels" defaultValue="销售方ELS号" />', name:'elsAccount', width: 150, align: 'center'},
			                 { title:'<i18n:I18n key="i18n_common_purchaseels" defaultValue="采购方ELS号" />', name:'toElsAccount' ,width:150, align:'center'},
			                 { title:'<i18n:I18n key="i18n_enquiry_title_purchaseordernumber" defaultValue="采购订单号" />', name:'purchaseOrderNumber' ,width:200, align:'center'},
			                 { title:'<i18n:I18n key="i18n_common_label_filetype" defaultValue="文件类型" />', name:'orderItemNumber' ,width:100, align:'center',renderer:function(val){
				                 	if (val == ""||val== null) {
				                		return '<i18n:I18n key="i18n_label_headfile" defaultValue="订单头文件" />';
				                	} else{
				                		return '<i18n:I18n key="i18n_label_itemfile" defaultValue="订单项文件" />';
				                	}
				                }},
			                 { title:'<i18n:I18n key="i18n_common_label_lineitemnumber" defaultValue="行项目编号" />', name:'orderItemNumber' ,width:150, align:'center'},
			                 { title:'<i18n:I18n key="i18n_common_label_filename" defaultValue="文件名称" />', name:'fileName' ,width:200, align:'center'},
			                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态" />', name:'fileStatus' ,width:150, align:'center',renderer:function(val){
			                	 if (val == "0") {
			                 		return '<i18n:I18n key="i18n_label_notSent" defaultValue="未发送" />';
			                 	} else {
			                 		return '<i18n:I18n key="i18n_label_sent" defaultValue="已发送" />';
			                 	} 
			                }}
			             ];
			
			if(itemIds==""){
				//本地示例
			    $('#table-file').mmGrid({
			        cols: cols_file,
			        items:[],
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}else{
				var param={"elsAccount":elsAccount,"itemIds":itemIds};
				//本地示例
			    $('#table-file').mmGrid({
			        cols: cols_file,
			        url : "<%=basePath%>rest/SaleFormFileService/order/findSaleFormFile",
			       method:'post',
			       root:"rows",
					params:param,
			        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
			        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />'
			    });
			}
		}
		
		$("#inputSession").click(function(){
			saleOrderConfirm();
		});
		
		function saleOrderConfirm(){
			if(!checkSelected()){
				return;
			}
			
			//兼容ie 冒泡事件
		    if (event && event.preventDefault) {
		        event.preventDefault();
		        event.stopPropagation();
		    } else {
		        window.event.returnValue = false;
		    }
			parent.elsDeskTop.defineWin({
		        'iconSrc':'icon/els-icon.png',
		        'windowsId':'saleOrderConfirm',
		        'windowTitle':'<i18n:I18n key="i18n_title_saleOrder" defaultValue="销售订单" />',
		        windowSubTitle: saleOrderNumber,
		        'iframSrc':"<%=basePath%>ordermanage/saleorder/saleOrderConfirm.jsp?saleOrderNumber="+saleOrderNumber,
		        windowStatus: 'maximized',
		        windowMinWidth: 960,
		        windowMinHeight: 700,
		        'windowWidth':960,
		        'windowHeight':700,
		        'parentPanel':".currDesktop"
		    });
		}
	
	//退出
	$("#exitBtn").click(function(){
		if (winId) {
			parent.elsDeskTop.closeCurWin(winId,closeCallback());
		} else {
			parent.elsDeskTop.closeCurWin('OrderManage'+toElsAccount,closeCallback);
		}
	});
	
	function closeCallback() {
// 		if (parent.frames["iframeApp_OrderManage"]) {
// 			parent.frames["iframeApp_OrderManage"].insertSaleOrderHeaderTable();
// 		}
	}
	
	$("#columnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    'iconSrc':'icon/els-icon.png',
		    'windowsId':'subAccountColumnSetting',
		    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		    windowSubTitle: "",
		    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleOrderBatchManage" + "&window=iframeApp_OrderManage"+toElsAccount,
		    windowMinWidth: 480,
		    windowMinHeight: 600,
		    'windowWidth':480,
		    'windowHeight':600,
		    'parentPanel':".currDesktop"
		});
	});
	$("#itemColumnDefineBtn").click(function(){
		parent.elsDeskTop.defineWin({
		    'iconSrc':'icon/els-icon.png',
		    'windowsId':'subAccountColumnSetting',
		    'windowTitle':'<i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" />',
		    windowSubTitle: "",
		    'iframSrc':'<%=basePath%>tablecolumn/subAccountColumnSetting.jsp?elsAccount=' + elsAccount + "&elsSubAccount="+elsSubAccount + "&tableCode=saleOrderItem" + "&window=iframeApp_OrderManage"+toElsAccount,
		    windowMinWidth: 480,
		    windowMinHeight: 600,
		    'windowWidth':480,
		    'windowHeight':600,
		    'parentPanel':".currDesktop"
		});
	});
	function updateSchedule() {
		if(!checkSelected()){
			return;
		}
		
		//兼容ie 冒泡事件
	    if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
	    parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editOrderSchedule',
	        'windowTitle':'<i18n:I18n key="i18n_button_viewprogress" defaultValue="查看进度" />',
	        windowSubTitle: saleOrderNumber,
	        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderSchedule.jsp?businessElsAccount=' + toElsAccount + "&purchaseOrderNumber="+currentPurchaseOrderNumber,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
	function renderProductionStatus(val,item) {
		if (!val) {
			return "";
		}
		return "<a href=\"javascript:showProductionStatus('"+item.toElsAccount+"','"+item.purchaseOrderNumber+"','"+item.orderItemNumber+"');\">"+val+"</a>";
	}
	function showProductionStatus(els,orderNumber,orderItemNumber) {
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'editOrderSchedule',
	        'windowTitle':'<i18n:I18n key="i18n_button_viewprogress" defaultValue="查看进度" />',
	        windowSubTitle: saleOrderNumber,
	        'iframSrc':'<%=basePath%>ordermanage/schedule/editOrderSchedule.jsp?businessElsAccount=' + els + "&purchaseOrderNumber="+orderNumber+"&orderItemNumber="+orderItemNumber,
	        windowStatus: 'maximized',
	        windowMinWidth: 960,
	        windowMinHeight: 700,
	        'windowWidth':960,
	        'windowHeight':700,
	        'parentPanel':".currDesktop"
	    });
	}
	
	function renderPurchaseType(val,item) {
		if(val == '0')
			return "<i18n:I18n key='i18n_common_select_procurementtype_standard' defaultValue='标准' />";
		else if(val == '1')
			return "<i18n:I18n key='i18n_common_select_procurementtype_restrict' defaultValue='限制' />";
		else if(val == '2')
			return "<i18n:I18n key='i18n_common_select_procurementtype_consignment' defaultValue='寄售' />";
		else if(val == '3')
			return "<i18n:I18n key='i18n_common_select_procurementtype_subcontract' defaultValue='分包' />";
		else if(val == '4')
			return "<i18n:I18n key='i18n_common_select_procurementtype_anunknowncommodity' defaultValue='未知的商品' />";
		else if(val == '5')
			return "<i18n:I18n key='i18n_common_select_procurementtype_thirdparty' defaultValue='第三方' />";
		else if(val == '6')
			return "<i18n:I18n key='i18n_common_select_procurementtype_text' defaultValue='文本' />";
		else if(val == '7')
			return "<i18n:I18n key='i18n_common_select_procurementtype_stocktransfer' defaultValue='库存转储' />";
		else if(val == '8')
			return "<i18n:I18n key='i18n_common_select_procurementtype_commoditytype' defaultValue='商品类目' />";
		else if(val == '9')
			return "<i18n:I18n key='i18n_common_select_procurementtype_service' defaultValue='服务' />";
		else
			return "";	
	}
	
	function checkSelected(){
		var hadSelected = headGrid.selectedRows();
		if(hadSelected==null){
			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
			return false;
		}else if(hadSelected.length<=0){
			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
			return false;
		}else if(hadSelected.length>1){
			alert('<i18n:I18n key="i18n_alert_onlyOneOrder" defaultValue="只能选择一条订单"/>',2);
			return false;
	 	}else{
	 		saleOrderNumber=hadSelected[0].saleOrderNumber;
	 		currentPurchaseOrderNumber = hadSelected[0].purchaseOrderNumber;
	 	}
		return true;
	}
	
	function toErp(){
		var hadSelected = headGrid.selectedRows();
		if(hadSelected==null){
			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
			return false;
		}else if(hadSelected.length<=0){
			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
			return false;
		}
		var saleOrderNumbers="";
		for(var i=0;i<hadSelected.length;i++){
			console.log(hadSelected[i].saleOrderNumber);
			saleOrderNumbers+=","+hadSelected[i].saleOrderNumber;
		}
		var paramStr={"elsAccount":elsAccount,"toElsAccount":toElsAccount,"itemIds":saleOrderNumbers};
		console.log(JSON.stringify(paramStr));
		$.ajax({
			url : "<%=basePath%>rest/SaleOrderService/toErp",
			type : "post",
			dataType : "json",
			contentType : "application/json",
			data:JSON.stringify(paramStr),
			success : function(data) {
				if (data!=null&&data.statusCode == "-100") {
					alert('<i18n:I18n key="i18n_label_toERPErrorLeft" defaultValue="公司商号为" />'+data.message+'<i18n:I18n key="i18n_label_toERPErrorRight" defaultValue="的订单因找不到供应商ERP编码而未插入" />',2);
				} else {
					alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
				}
			},
			error : function(data) {
    			if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
			}
		});
		
	}
	$('#exportBtn').click(function() {
		var hadSelected = headGrid.selectedRows();
 		if(hadSelected==null){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}else if(hadSelected.length<=0){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}
 		var saleOrderNumbers = "";
 		for (var i=0;i<hadSelected.length;i++) {
 			saleOrderNumbers += hadSelected[i].saleOrderNumber + ",";
 		}
 		saleOrderNumbers = saleOrderNumbers.substring(0,saleOrderNumbers.length-1);
 		window.location.href = "<%=basePath%>rest/SaleOrderService/exportExcel/"+elsAccount + "/" + saleOrderNumbers;
	});
     //打印
     $('#printBtn').click(function() {
    	 var hadSelected = headGrid.selectedRows();
 		if(hadSelected==null){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}else if(hadSelected.length<=0){
 			alert('<i18n:I18n key="i18n_enquiry_pleaseSelectTheOrder" defaultValue="请选择订单" />',2);
 			return false;
 		}else if(hadSelected.length>1){
 			alert('只能打印一个订单！',2);
 			return false;
 		}
 		currentPurchaseOrderNumber = hadSelected[0].purchaseOrderNumber;
    	 //判断是调用sap的合同，还是使用我们自己的模板打印
    	 $.ajax({
     		url : "<%=basePath%>rest/PurchaseOrderService/isMyself/"+toElsAccount,
     		type : "get",
     		contentType : "application/json",
     		dataType : "json",
     		success : function(data) {
     			if (data!=null&&data.statusCode == "-100") {
     				alert(data.message,2);
     			}else{
     				if(data=="0"){//使用sap的合同
     					printERP();
     				}else{//使用我们自己的模板生成合同
     					printMyself();
     				}
     			}
     		},
     		error : function(data) {
 	    		alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
     		}
     	});
     });
    
    //打印erp合同
    function printERP(){
    	//打印采购订单
        	$.ajax({
        		url : "<%=basePath%>rest/PurchaseOrderService/printERPPurchaseOrde/"+currentPurchaseOrderNumber+"/"+toElsAccount,
        		type : "get",
        		contentType : "application/json",
        		dataType : "json",
        		success : function(data) {
        			if (data!=null&&data.statusCode == "-100") {
        				alert(data.message,2);
        			}else{
        				window.location.href = "${pageContext.request.contextPath}/temp/"+data.fileName;
        			}
        		},
        		error : function(data) {
    	    		alert("<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />",3);
        		}
        	});
    }
	
	//使用自己的模板打印
	function printMyself(){
		// 组合打印数据
		var bodyData = $('body').data();
		var rowsData = (bodyData['findSaleOrderItem']||{});
		var datas = bodyData['selectHead'];
		if(datas && datas.length && rowsData && rowsData.length) {
			datas.forEach(function(d){
				var rows =[];
				rowsData.forEach(function(r){
					if(d.purchaseOrderNumber=== r.purchaseOrderNumber){
						var mixData = $.extend(true,{},d,r);
						rows.push(mixData);
					}
				});
				d.rows = rows;
			});
			$.extend(printData, datas);

			//存储打印需要的数据
			var printWin = parent.elsDeskTop.defineWin({
				'iconSrc':'icon/els-icon.png',
				'windowsId':'ePrintTemplatesManager',
				'windowTitle':'<i18n:I18n key="i18n_windowtitle_orderprint" defaultValue="订单打印" />',
				'iframSrc':'<%=basePath%>ePrintTemplatesManager.jsp',
				'windowStatus': 'maximized',
				'windowMinWidth': 960,
				'windowMinHeight': 700,
				'windowWidth':960,
				'windowHeight':700,
				'parentPanel':".currDesktop"
			});
			printWin.setIframeData(printData);
		}else {
				parent.elsDeskTop.tip.init({
					type: 'alert',displayType: 3,
					message:'<i18n:I18n key="i18n_message_whichordertoprint" defaultValue="您还没选择要打印的表单" />'
				});
			}
	}
	
	
	//判断是否显隐接口按钮
	function isDisplayIntefaceButton(){
		//批量获取erp订单按钮
		$.ajax({
			url :"<%=basePath%>rest/IntefaceService/isExit/" + elsAccount + "/ToErpSaleOrder",
			type :"get",
			contentType : "application/json",
			dataType : "json",
			success : function(data) {
				if(data!=null&&data.statusCode=="-100"){
					$("#toErp").css("display","none");
				}else{
					$("#toErp").css("display","");
				}
			},
			error : function(data) {
//				if (!permissionError(data)) {
//					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
//				}
			}
		});
	}
	
	function uploadSchedule() {
		var uploader = WebUploader.create({
		    // swf文件路径
		    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		    auto: true,
		    duplicate :true,
		    accept:{
		    	extensions:"xls,xlsx"
		    },
		    // 文件接收服务端。
		    server: '<%=basePath%>rest/OrderScheduleService/uploadScheduleBatch/' + elsAccount + "/" + toElsAccount,
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#uploadBtn',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false
		});
		
		uploader.on( 'uploadAccept', function( file, response ) {
			if(response.statusCode=="-100"){
				alert("<i18n:I18n key="i18n_alert_importFormatError" defaultValue="导入文件格式不正确" />",3);
			}else{
				alert('<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />');
			}
		});
	}
	$("#showDelete").click(function(){
		var itemList = itemGrid.rows();
		if($(this).attr("checked")=="checked") {
			for (var i in itemList) {
				var deleteFlag = itemList[i].deleteFlag;
				if (deleteFlag && deleteFlag == "X") {
					$("#saleOrderItemTable").find("tr").eq(i).show();
				}
			}
		} else {
			for (var i in itemList) {
				var deleteFlag = itemList[i].deleteFlag;
				if (deleteFlag && deleteFlag == "X") {
					$("#saleOrderItemTable").find("tr").eq(i).hide();
				}
			}
		}
	});
	
	function renderIsFinish(val,item){
		if(val && val == "X")
			return "是";
		else
			return "否";
	}
	
	function renderItemIsFinish(val,item){
		if(val && val == "X")
			return "是";
		else
			return "否";
	}
	
	function initModifyFiled(itemList) {
		var map = {};
		for (var i in cols) {
			map[cols[i].name] = i;
		}
		var showDeleteFlag = false;
		if ($("#showDelete").attr("checked") == "checked") {
			showDeleteFlag = true;
		}
		for (var i in itemList) {
			var fbk50 = itemList[i].fbk50;
			if (fbk50) {
				var changeFields = fbk50.split(",");
				for (var j in changeFields) {
					if (changeFields[j]=="materialNumber"||changeFields[j]=="materialDesc") {
						changeFields[j] = "purchaseM" + changeFields[j].substring(1);
					}
					$("#saleOrderItemTable").find("tr").eq(i).find("td").eq(parseInt(map[changeFields[j]])).css("background","yellow");
				}
			}
			// 删除待确认的标识
			if (itemList[i].deleteFlag && itemList[i].deleteFlag=="C") {
				$("#saleOrderItemTable").find("tr").eq(i).find("td").css("background","yellow");
			}
			if (itemList[i].deleteFlag && itemList[i].deleteFlag=="X") {
				$("#saleOrderItemTable").find("tr").eq(i).css("background-color","rgba(213, 58, 58, 0.0980392)");
				if (!showDeleteFlag) {
					$("#saleOrderItemTable").find("tr").eq(i).hide();
				}
			}
		}
	}
</script>
</body>
</html>