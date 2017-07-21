<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="auditPreBiddingOne.jsp"%>
<body>

<script type="text/javascript">
//TODO:	招标内容开始 
	/* =============================================招标内容  start================================================ */
		var biddingDetailContentGrid;
		var biddingStandardGrid;
		var perbiddingItemNumberValue;
		var biddingContentItemStandardArray;
		var biddingQualificationArray;
		var contentItemArray=new Array();
		var contentStandardArray=new Array();
		var biddingDetailContentItem=[
                {title:'序号',name:'sequenceNumber', width: 120, align: 'center',renderer:function(val,item,rowIndex){
               		return rowIndex+1;
               	}},
              	{title:'需求类型编码',name:'requirementTypeCode', width : 120, align : 'center',renderer : hiddenRendder},
              	{title:'需求类型名称',name:'requirementTypeName', width : 120, align : 'center',renderer : hiddenRendder},
               	{ title:'<i18n:I18n key="" defaultValue="方案/设计图纸"/>', name:'attachmentFile' , width:80, align:'center',
               		clickDisable:true,renderer:function(val, item, rowIndex){
               			var viewFlag = false;
               			var extendFields = item.extendFields;
               			if(extendFields){
               				extendFields = JSON.parse(extendFields);
               				var fileList = extendFields.fileList;
               				viewFlag = (fileList && fileList!="");
               			}
               			return '<span class="uploadFile-item" id="attachmentFile_upload_'+rowIndex+'" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span>'
            		    +'&nbsp;&nbsp;<span class="downloadFile-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span>';
               	}},
        		{ title:'<i18n:I18n key="" defaultValue="图片"/>', name:'attachmentImage' , width:100, align:'center',
               		clickDisable:true,renderer:function(val, item, rowIndex){
               			var viewFlag = false;
               			var extendFields = item.extendFields;
               			if(extendFields){
               				extendFields = JSON.parse(extendFields);
               				var imageList = extendFields.imageList;
               				viewFlag = (imageList && imageList!="");
               			}
               			return '<span class="previewImage-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span>'
            		    +'&nbsp;&nbsp;<span class="uploadImage-item" id="attachmentImage_upload_'+rowIndex+'" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span>'
            		    +'&nbsp;&nbsp;<span class="downloadImage-item" style="display:'+(viewFlag?'inline':'none')+';color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" />';
        		}},
              	{title:'招标编号',name:'biddingNumber',hidden:true,width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentItem[][biddingNumber]' type='text' readonly='readonly' value='"+$("#biddingNumber").val()+"'/>";
              	}},     
              	{title:'标段号',name:'biddingItemNumber', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentItem[][biddingItemNumber]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},     
              	{title:'招标内容行项目号',name:'biddingContentItemNumber', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentItem[][biddingContentItemNumber]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},     
              	{title:'项目编号',name:'biddingProjectNumber', width: 120, align: 'center',renderer:function(val,item,rowIndex){
              		return "<input name='biddingContentItem[][biddingProjectNumber]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},     
              	{title:'物料编号',name:'materialNumber', width: 120, align: 'center',renderer:function(val){
              		return val + "<input name='biddingContentItem[][materialNumber]' type='hidden' value='"+val+"'/>";
              	}},     
              	{title:'名称描述',name:'materialDesc', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentItem[][materialDesc]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
              	}},     
              	{title:'型号',name:'materialModel', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentItem[][materialModel]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
              	}},    
              	{title:'规格&性能',name:'materialSpecification', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentItem[][materialSpecification]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
              	}},     
              	{title:'单位',name:'units', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentItem[][units]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
              	}}, 
              	{title:'数量',name:'quantity', width: 120, align: 'center',renderer:function(val){
              		if(!val || val ==null){
              		   val = "";
              	   	}
              		return "<input name='biddingContentItem[][quantity]' type='text' class='biddingDetailContentColsEdit' onkeyup='value=value.replace(/[^(\\d\\.)]/g,\"\")'  value='"+val+"'/>";
              	}},
              	{title:'目标价',name:'fbk2', width: 120, align: 'center',renderer:function(val){
              		if(!val){
              			val="";
              		}
              		return "<input name='biddingContentItem[][fbk2]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
              	}},
              	{title:'参考价',name:'fbk3', width: 120, align: 'center',renderer:function(val){
              		if(!val){
              			val="";
              		}
              		return "<input name='biddingContentItem[][fbk3]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
              	}},
              	{title:'交货日期',name:'deliveryDate', width: 120, align: 'center',renderer:function(val){
              		if(val&&val !=""){
             		   val = new Date(val).format('yyyy-MM-dd');
             	   }else{
             		   val = "";
             	   }
              		return '<input type="text" id="" name="biddingContentItem[][deliveryDate]"  class="Wdate" onfocus=\'WdatePicker({dateFmt:\"yyyy-MM-dd\",alwaysUseStartDate:true})\' value="'+val+'" />'; 
              	}},     
              	{title:'备注',name:'remark', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentItem[][remark]' type='text' class='biddingDetailContentColsEdit' value='"+val+"'/>";
              	}}
       	];

		var biddingStandardItem=[
              	{title:'序号',name:'sequenceNumber', width: 100, align: 'center',renderer:function(val,item,rowIndex){
              		return rowIndex+1;
              	}},     
            	{title:'招标编号',name:'biddingNumber',hidden:true, width: 100, align: 'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][biddingNumber]' readonly='readonly' type='text'  value='"+$("#biddingNumber").val()+"'/>";
              	}},     
              	{title:'标段号',name:'biddingItemNumber', width: 100, align: 'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][biddingItemNumber]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},   
                { title:'评分类别编号', name:'scoreTypeCode' ,width:100, align:'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][scoreTypeCode]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},
                { title:'评分类别名称', name:'scoreTypeName' ,width:100, align:'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][scoreTypeName]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},
              	{title:'评分标准编号',name:'standardNumber', width: 100, align: 'center',renderer:function(val,item,rowIndex){
              		return "<input name='biddingContentStandard[][standardNumber]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},     
              	{title:'评分标准名称',name:'standardName', width: 100, align: 'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][standardName]' type='text' readonly='readonly' value='"+val+"'/>";
              	}},     
              	{title:'权重',name:'ratio', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][ratio]' type='text'  value='"+val+"' onblur='this.value=toNum(this.value);'/>";
              	}},    
              	{title:'负责人',name:'person', width: 120, align: 'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][person]' type='text'  value='"+val+"'/>";
              	}},     
              	{title:'具体标准',name:'standardDocument', width: 80, align: 'center',renderer:function(val, item, rowIndex){
              		var text = '<span class="downloadFile-contentItem" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
              		return text;
              	}},  
                { title:'详细说明', name:'standardDetail' ,width:120, align:'center',renderer:function(val){
              		return "<input name='biddingContentStandard[][standardDetail]' type='text'  value='"+val+"'/>";
              	}}
              ];
		
		
		///////////////////////////////////////////////////////////////////////////////////////////	
		function initInput(val,item,index){
	    	if(!val) { val = '';}
	    	var name = $(this)[0].name;
			return '<input name="biddingContentItem[]['+name+']" id="'+name+'_'+index+'" type="text" class="biddingDetailContentColsEdit" value="'+val+'"/>';
	    }
		//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

/**----------============需求类型和编码选择（BEGIN）============----------*/

function selectRequirementTypeCode(rowIndex){
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    var getData = function(data) {
    	requirementTypeCallback(data,rowIndex);
	};
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'requirementTypeCheck',
        'windowTitle':'<i18n:I18n key="" defaultValue="需求类型"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>requirement/requirementtype/requirementTypeCheck.jsp?frameAppId=addBiddingThree',
        'showAdv': false,
 	   	'mask' : true,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop",
        data: getData
    });
}

function requirementTypeCallback(dataRows,rowIndex){
    if("undefined"!=typeof(dataRows) && dataRows.length > 0){
        var itemRow = biddingDetailContentGrid.row(rowIndex);
        itemRow["requirementTypeCode"] = dataRows[0].requirementTypeCode;
        itemRow["requirementTypeName"] = dataRows[0].requirementTypeName;
        $("#requirementTypeCode_"+rowIndex).val(itemRow["requirementTypeCode"]);
        $("#requirementTypeName_"+rowIndex).val(itemRow["requirementTypeName"]);
        biddingDetailContentGrid.updateRow(itemRow, rowIndex);
    }
}

function selectMaterialNumber(rowIndex){
	//兼容ie 冒泡事件
	if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    var getData = function(data) {
    	materialCallback(data,rowIndex);
	};
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'materialCheck',
        'windowTitle':'<i18n:I18n key="" defaultValue="物料基础数据"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'<%=basePath%>materialmanage/materialCheck.jsp?frameAppId=addBiddingThree',
        'showAdv': false,
 	   	'mask' : true,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop",
        data: getData
    });
}

function materialCallback(dataRows,rowIndex){
    if("undefined"!=typeof(dataRows) && dataRows.length > 0){
        var itemRow = biddingDetailContentGrid.row(rowIndex);
    	var materialNumber = itemRow.materialNumber;
    	var updateFlag = (materialNumber && null!=materialNumber && $.trim(materialNumber)!="");
        var curRowIndex = biddingDetailContentGrid.rowsLength();
        for(var i=0; i<dataRows.length; i++) {
			var contentBiddingProjectNumber = $("#contentBiddingProjectNumber").val();
			var contentBiddingItemNumber = $("#contentBiddingItemNumber").val();
			if(i==0 && !updateFlag) {
				itemRow["biddingProjectNumber"] = contentBiddingProjectNumber;
				itemRow["biddingItemNumber"] = contentBiddingItemNumber;
				itemRow["materialNumber"] = dataRows[i].materialNumber;
				itemRow["materialDesc"] = dataRows[i].materialName;
				itemRow["extendFields"] = dataRows[i].extendFields;
				itemRow["deliveryDate"] = new Date().format('yyyy-MM-dd');
				biddingDetailContentGrid.updateRow(itemRow,rowIndex);//更新改行数据
				continue ;
			}
			var maxNumber = getMaxContentItemNum();
			var data = {
					biddingProjectNumber : contentBiddingProjectNumber,
					biddingItemNumber : contentBiddingItemNumber,
					biddingContentItemNumber : maxNumber+1,
					materialNumber : dataRows[i].materialNumber,
					materialDesc : dataRows[i].materialName,
					quantity : 0.0,
					materialModel : "",
					materialSpecification : "",
					units : "",
					deliveryDate : new Date().format('yyyy-MM-dd'),remark:"",
					extendFields : dataRows[i].extendFields
			};
			biddingDetailContentGrid.addRow(data,(curRowIndex+i));//插入到表格最后
        }
    }
}

/**----------============需求类型和编码选择（END）============----------*/
		
	//单击招标内容tag页时触发 
	$('.edit-line-content').click(function() {
		//set标段
		initImportExlModual(bdContentItemUploader);
		if(biddingDetailContentGrid ===undefined) {
			biddingDetailContentGrid=$('#biddingDetailContentTable').mmGrid({
		        cols: biddingDetailContentItem,
		        items: contentItemArray,
		        heigth: 350,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol:true,
		        multiSelect:true,
		        hasJsonOption : "extendFields"
		    });
			biddingDetailContentGrid.resize();
			if(biddingStatus == 0 || biddingStatus == 1) {
			 	biddingDetailContentGrid.on("cellSelected",function(e, item, rowIndex, colIndex){
			    	var colsObj = biddingDetailContentGrid.opts.cols;
			    	var thisColName = colsObj[colIndex].name;
			    	if("requirementTypeCode"==thisColName){
			    		selectRequirementTypeCode(rowIndex);//弹出选择需求类型页面进行选择
			    	} else if("materialNumber"==thisColName){
			    		selectMaterialNumber(rowIndex);//弹出物料选择页面进行选择
			    	} else {
			    		//do nothing
			    	}
			    });
			}			
		}
		if(biddingStandardGrid ===undefined) {
			biddingStandardGrid=$('#biddingStandardTable').mmGrid({
		        cols: biddingStandardItem,
		        items: contentStandardArray,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol:true,
		        multiSelect:true
		    });
			biddingStandardGrid.resize();
		}
		 var setItemNumberObj = $("#contentBiddingItemNumber");
		 var biddingPhases = $("#biddingPhases");
		 var biddingPhasesValue = biddingPhases.val();
		 
		//如果是不区分标段，就把“必须全部投标、可以部分投标”单选按钮显示出来		
		if(biddingPhasesValue=="1"){
			$("#controlBidding").show();
		}
		 
		 if(typeof(biddingContentItemStandardArray) == "undefined"){
			 if(biddingPhasesValue=="1"){
				 setItemNumberObj.empty();
				 setItemNumberObj.append("<option value='0'>"+biddingPhases.find("option:selected").text()+"</option>");
				 if(!$.isArray(biddingContentItemStandardArray)){
				 		biddingContentItemStandardArray= new Array(0);
					 }
			 }else {
				 setItemNumberObj.empty();
				 var items = $("#form").serializeJSON().biddingPhasesItems;
				 for(var i=0;i<items.length;i++){
					 setItemNumberObj.append("<option value='"+items[i].biddingItemNumber+"'>标段"
							 +items[i].biddingItemNumber+" "+items[i].biddingItemName+"</option>");
					 
				 }
				 if(!$.isArray(biddingContentItemStandardArray)){
			 		biddingContentItemStandardArray= new Array(items.length-1);
				 }
			 }
		 }
		//set项目编号
		$("#contentBiddingProjectNumber").val($("#biddingProjectNumber").val());
		if($("#contentBiddingProjectNumber").val()!=""){
			loadProjectName();
		}
		
		if(typeof(perbiddingItemNumberValue)=="undefined"){
			perbiddingItemNumberValue=setItemNumberObj.get(0).selectedIndex;
		}
		
		if(biddingDetailContentGrid){
			biddingDetailContentGrid.resize();
			return;
		}
		//招标详细内容
		if(!biddingDetailContentGrid) {
			biddingDetailContentGrid=$('#biddingDetailContentTable').mmGrid({
		        cols: biddingDetailContentItem,
		        heigth: 350,
		        hasJsonOption : 'extendFields',
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol:true,
		        multiSelect:true,
		        items: []
		    });
			biddingDetailContentGrid.resize();
		}
		//评标标准内容
		if(!biddingStandardGrid) {
			biddingStandardGrid=$('#biddingStandardTable').mmGrid({
		        cols: biddingStandardItem,
		        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol:true,
		        multiSelect:true,
		        items: []
		    });
			biddingStandardGrid.resize();
		}
		
	});
	
	function biddingDetailContentAddItem(){
		var rows = biddingDetailContentGrid.rows();
		var maxContentItemNumber = 0;
		for(var i=0;i<rows.length;i++){
			if(typeof(rows[i]) != "undefined" && rows[i] != null){
				var biddingContentItemNumber = rows[i].biddingContentItemNumber;
				if(biddingContentItemNumber != null && typeof(biddingContentItemNumber) != "undefined" && biddingContentItemNumber>maxContentItemNumber){
					maxContentItemNumber = biddingContentItemNumber;
				}
			}
		}
		var maxNumber = parseInt(maxContentItemNumber);
		if($("#biddingType").val() == "3" && rows[0]){
			alert("在线竞标只能添加一条物料信息！",2);
			return;
		}
		var contentBiddingProjectNumber = $("#contentBiddingProjectNumber").val();
		var contentBiddingItemNumber = $("#contentBiddingItemNumber").val();		
		var biddingDetailBlackItem={
				biddingProjectNumber:contentBiddingProjectNumber,biddingItemNumber:contentBiddingItemNumber,biddingContentItemNumber:maxNumber+1,
				materialNumber:"",materialDesc:"",quantity:0.0,fbk2:"",fbk3:"",
				materialModel:"",materialSpecification:"",units:"",deliveryDate:new Date().format('yyyy-MM-dd'),remark:"",
				};
		biddingDetailContentGrid.addRows([biddingDetailBlackItem]);
	}
	
	function biddingDetailContentRemoveItem(){
		var seletectIndexArr=biddingDetailContentGrid.selectedRowsIndex();
		if(seletectIndexArr.length<=0){
			alert("请选择要删除的行!",2);
			return;
		}
	 	for(var i=0;i<seletectIndexArr.length;i++){
			biddingDetailContentGrid.removeRow(seletectIndexArr);
 		}
	}
	
	function biddingStandardAddItem(){
		var rows = biddingStandardGrid.rows();
		if($("#biddingType").val() == "3" && rows[0]){
			alert("在线竞标只能添加一条物料信息！",2);
			return;
		}
		var contentBiddingItemNumber = $("#contentBiddingItemNumber").val();
		var standardIndex = biddingStandardGrid.rowsLength()+1;
		var biddingStandardBlackItem={biddingItemNumber:contentBiddingItemNumber,standardNumber:standardIndex,standardName:"",ratio:0,person:"",standardDetail:""};
		biddingStandardGrid.addRow(biddingStandardBlackItem,standardIndex);
	}
	
	function biddingStandardRemoveItem(){
		var seletectIndexArr=biddingStandardGrid.selectedRowsIndex();
		if(seletectIndexArr.length<=0){
			alert("请选择要删除的行!",2);
			return;
		}
	 	for(var i=0;i<seletectIndexArr.length;i++){
	 		biddingStandardGrid.removeRow(seletectIndexArr);
 		}
	}
	
	function loadProjectName(){
		var biddingProjectNumber = $("#contentBiddingProjectNumber").val();
	    if(biddingProjectNumber){
	    	//头信息
	    	$.ajax({
				url :"<%=basePath%>rest/ProjectManageService/queryProjectManageHead",
				type :"POST",
				contentType : "application/json",
				dataType : "json",
				data:JSON.stringify({"elsAccount":elsAccount,"projectNumber":biddingProjectNumber}),
				success : function(data) {
					if(data.statusCode == null){
						if(data.rows != null && data.rows != ""){
							$("#contentBiddingProjectName").val(data.rows[0].projectDesc);
						}else{
							$("#contentBiddingProjectName").val("");
						}
					}else{
						$("#contentBiddingProjectName").val("");
					}
				}
			});
	    }else{
	    	$("#contentBiddingProjectName").val("");
	    }
	}
	
	//添加招标详细内容
	$("#biddingDetailContentAdd").click(function(){
		biddingDetailContentAddItem();
	});
	
	//删除招标详细内容
	$("#biddingDetailContentRemove").click(function(){
		biddingDetailContentRemoveItem();
	});
	
	//添加 评标标准内容
	$("#biddingStandardAdd").click(function(){
		biddingStandardAddItem();
	});
	
	//删除 评标标准内容
	$("#biddingStandardRemove").click(function(){
		biddingStandardRemoveItem();
	});
	
 	$("#contentBiddingItemNumber").change(function(){
 		//改变标段select前时触发事件-把当前标段页面信息存入biddingContentItemStandardArray，原标段信息回填
		var form = $("#form").serializeJSON();
 		//////////////////////////////////////////////////////////////////////////
		form["biddingContent"]["summary"] = $("#contentSummary").val();
		form["biddingContent"]["biddingProjectNumber"] = $("#contentBiddingProjectNumber").val();
		form["biddingContent"]["biddingProjectName"] = $("#contentBiddingProjectName").val();
		form["biddingContent"]["deliveryStartDate"] = $("#contentDeliveryStartDate").val();
		form["biddingContent"]["deliveryEndDate"] = $("#contentDeliveryEndDate").val();
		form["biddingContent"]["address"] = $("#contentAddress").val();
		form["biddingContent"]["quality"] = $("#contentQuality").val();
		//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
			
		var records = biddingDetailContentGrid.rows();
		if(records!="") {
			for(var i=0;i<records.length;i++){
	    		form["biddingContentItem"][i]["extendFields"] = records[i].extendFields;
			}
		}
		var biddingContent = form.biddingContent;
		var biddingItemNumber = $("body").data("contentBiddingItemNumber_local");//获取标段---原标段
		
		if(typeof(biddingItemNumber) == "undefined"){
			biddingItemNumber = form.biddingContentItem[0].biddingItemNumber;
		}
		
		biddingContent["biddingItemNumber"]=biddingItemNumber;
		biddingContent["biddingContentItem"]=typeof(form.biddingContentItem)=="undefined"?[]:form.biddingContentItem;
		biddingContent["biddingContentStandard"]=typeof(form.biddingContentStandard)=="undefined"?[]:form.biddingContentStandard;
		biddingContentItemStandardArray[perbiddingItemNumberValue]= biddingContent;
		$("#contentSummary").val("");
		$("#contentBiddingProjectNumber").val($("#biddingProjectNumber").val());
		$("#contentDeliveryStartDate").val("");
		$("#contentDeliveryEndDate").val("");
		$("#contentAddress").val("");
		$("#contentQuality").val("");
		biddingDetailContentGrid.removeRow();
		biddingStandardGrid.removeRow();
		var selectValue = $(this).get(0).selectedIndex;
		perbiddingItemNumberValue=selectValue;
		if("undefined" !=typeof(biddingContentItemStandardArray[selectValue])){
			var setBiddingContent = biddingContentItemStandardArray[selectValue];
			var setBiddingContentItem = setBiddingContent.biddingContentItem;
			var setBiddingContentStandard = setBiddingContent.biddingContentStandard;
			$("#contentSummary").val(setBiddingContent.summary);
			$("#contentBiddingProjectNumber").val(setBiddingContent.biddingProjectNumber);
			$("#contentBiddingProjectName").val(setBiddingContent.biddingProjectName);
			$("#contentDeliveryStartDate").val(new Date(setBiddingContent.deliveryStartDate).format('yyyy-MM-dd'));
			$("#contentDeliveryEndDate").val(new Date(setBiddingContent.deliveryEndDate).format('yyyy-MM-dd'));
			$("#contentAddress").val(setBiddingContent.address);
			$("#contentQuality").val(setBiddingContent.quality);
			biddingDetailContentGrid.load(setBiddingContentItem);
			biddingStandardGrid.load(setBiddingContentStandard);
		}
		$("body").data("contentBiddingItemNumber_local",$(this).val());
	}); 
	
	$('#contentBiddingProjectNumber').live('blur',function() {
		loadProjectName();
	});


/** -----------===============Excel导入导出、评标导入、需求计划提取（开始）===============----------- */
	var bdContentItemUploader ;
	initImportExlModual(bdContentItemUploader);

	$(".biddingDetailContentColsEdit").live('change',function(){
	    var thisVal = $(this).val();
	    var thisName = $(this).attr("name");
	    var splitThisArr = thisName.split("[]");
	    if(splitThisArr.length>0) {
	    	var tempSplitArr1 = splitThisArr[1];
	    	if(tempSplitArr1 && tempSplitArr1.length>2) {
	    		thisName = tempSplitArr1.substr(1,tempSplitArr1.length-2);
			    var rowIndex = $(this).closest("tr").index();
			    var rowData = biddingDetailContentGrid.row(rowIndex);
			    rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
	    	}
	    }
	});

	function initImportExlModual(bdContentItemUploader) {
		if(!bdContentItemUploader) {
	   		bdContentItemUploader = WebUploader.create({
			    // swf文件路径
			    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
			    auto: true,
			    duplicate :true,
			    accept:{
			    	extensions:"xls,xlsx"
			    },
			    // 文件接收服务端。
			    server: '<%=basePath%>servlet/UploadServlet',
			    // 选择文件的按钮。可选。
			    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
			    pick: '#importByMaterial',
			    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			    resize: false,
		  	    formData : {
			     	elsAccount : elsAccount
			    }
			});
	   		bdContentItemUploader.on( 'uploadAccept', function( file, response ) {
	   			debugger;
	   		 	var filePath = response.url;
	   		 	var fbk6 = $("input[name='fbk6']:checked").val();
			  	parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_common_alert_beingImported" defaultValue="正在导入" />');
			  	$.ajax({
					url :"<%=basePath%>rest/PurchaseBiddingService/importExcelByPath",
					type :"POST",
					contentType : "application/json",
					dataType : "json",
					data:JSON.stringify({"fbk9":filePath,"elsAccount":elsAccount,"fbk6":fbk6}),
					success : function(data) {
						//var obj = JSON.parse(data);
						if(data.statusCode=="-100"){
							parent.elsDeskTop.hideLoading();
							parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_importFailure" defaultValue="导入失败！请检查文件内容！" />'});
						}else{
							parent.elsDeskTop.hideLoading();
							biddingDetailContentGrid.load(data.rows);
							parent.elsDeskTop.tip.init({type : 'alert',displayType : 1,message : '<i18n:I18n key="i18n_common_alert_successfulImprot" defaultValue="导入成功！" />'});
						}
					},
					error: function (data) {//获取ajax的错误信息
// 						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : '<i18n:I18n key="i18n_common_alert_systemError" defaultValue="系统错误！" />'});
		            }
				});
			});
		}
	}
	$("#downMaterialModual").click(function() {
		window.location.href = "<%=basePath%>"+"template/招投标物料导入模板.xls";
		<%--
		//兼容ie 冒泡事件
		if (event && event.preventDefault) {
	        event.preventDefault();
	        event.stopPropagation();
	    } else {
	        window.event.returnValue = false;
	    }
		parent.elsDeskTop.showLoading('<i18n:I18n key="xxxxxx" defaultValue="正在下载..." />');
		var jsonData = {
			elsAccount : elsAccount
		};
		$.ajax({
			url :"basePath/rest/PurchaseBiddingService/exportExcelByModual",
			type :"POST",
			contentType : "application/json",
			dataType : "json",
			data:JSON.stringify(jsonData),
			success : function(data) {
				var filePath = data.message;
				window.location.href = "<%=basePath%>servlet/downloadServlet?filePath="+filePath;
				parent.elsDeskTop.hideLoading();
			},
			error: function (xhr, type, exception) {//获取ajax的错误信息
				parent.elsDeskTop.hideLoading();
	            alert(exception,3); 
	        }
	  });
	  --%>
	});
    var getEvaltempData = function(data) {
		var contentBiddingItemNumber = $("#contentBiddingItemNumber").val();
		var biddingStandardRowLength = biddingStandardGrid.rowsLength();
		var biddingStandardGridRows = biddingStandardGrid.rows();
		var biddingStandardTempArr = [];
		if(biddingStandardGridRows != "") {
			for(var j=0; j<biddingStandardGridRows.length; j++) {
				biddingStandardTempArr.push(biddingStandardGridRows[j]["standardNumber"]);
			}
		}
		for(var i=0;i<data.length;i++) {
			var standardIndex = biddingStandardRowLength + i;
			if(jQuery.inArray(data[i].scoreModuleCode,biddingStandardTempArr) != -1)
					continue;
	    	var biddingStandardRetItem={
	    			biddingItemNumber: contentBiddingItemNumber,
	    			standardNumber: data[i].scoreModuleCode,
	    			standardName: data[i].scoreModuleName,
	    			scoreTypeCode: data[i].scoreTypeCode,
	    			scoreTypeName: data[i].scoreTypeName,
	    			ratio: 0,
	    			person: "",
	    			standardDetail: data[i].detailDesc,
	    			standardDocument : ""
	    	};
	    	biddingStandardRetItem.fileList=data[i].fileList;
			biddingStandardGrid.addRow(biddingStandardRetItem,standardIndex);
	    	//$("#scoreTypeCode"+standardIndex).val(data[i].scoreTypeCode);
		}
	};
	$("#obtainByEvaltemp").click(function() {
	    parent.elsDeskTop.defineWin({
	    	   'iconSrc': 'icon/destop-icon/desktop_icon_93.gif',
	    	   'windowsId': 'biddingEvalTempSel',
	    	   	'mask' : true,
	    	   'windowTitle': '<i18n:I18n key="" defaultValue="选择评分模板"/>',
	    	   'windowSubTitle': companyShortName,
	    	   'iframSrc': '<%=basePath%>biddingmanage/purchase/biddingEvalTempSel.jsp'+
	    	   				'?frameAppId=biddingPurchaseManage2&biddingNumber='+$("#biddingNumber").val()+
	    	   				'&elsAccounta='+$("#elsAccount").val()+
	    	   		   		'&biddingItemNumOne='+$("#contentBiddingItemNumber").val(),
	    	   'showAdv': false,
	    	   'windowStatus': 'regular',
	    	   'windowMinWidth': 1024,
	    	   'windowMinHeight': 580,
	    	   'windowPositionTop': 14,
	    	   'windowWidth': 1024,
	    	   'windowHeight': 580,
	    	   'parentPanel': ".currDesktop",
	           data: getEvaltempData
	    	});
	});
	$('.downloadFile-contentItem').live("click", function() {
		var itemRowIndex = $(this).closest("tr").index();
		var itemRow = biddingStandardGrid.row(itemRowIndex);
		var fileList = itemRow.fileList;
		if("undefined"!=typeof(fileList) && fileList.length > 0){
			for(var i=0;i<fileList.length;i++){
				window.open("<%=basePath%>servlet/downloadServlet?filePath="+fileList[i].annexFilePath);
			}
		} else {
			alert("没有文件可下载",2);
		}
	});
	////////////////////////////////////////////////////////////////////////////////////////////////////
	var uploadFileRowIndex;
	var fileUploader1;
	$('.uploadFile-item').live("click", function() {
	    var itemRowIndex = $(this).closest("tr").index();
		var item = biddingDetailContentGrid.row(itemRowIndex);
		var materialNumber = item.materialNumber;
		if(!(materialNumber && null!=materialNumber && $.trim(materialNumber)!="")) {
			alert('物料编号不能为空，请选择物料',2);
			return ;
		}
	    uploadFileType="file";
	    uploadFileRowIndex=itemRowIndex;
	    uploadFile();
	});

	$('.downloadFile-item').live("click", function() {
		var itemRowIndex = $(this).closest("tr").index();
		var itemRow = biddingDetailContentGrid.row(itemRowIndex);
		var extendFields = itemRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var fileList = extendFields.fileList;
			if("undefined"!=typeof(fileList) && fileList.length > 0){
				downloadFile("file",itemRowIndex);
			} else {
				alert("没有文件可下载",2);
			}
		} else {
			alert("没有文件可下载",2);
		}
	});
	
	$(".previewImage-item").live("click", function() {
		var itemRowIndex = $(this).closest("tr").index();
		var itemRow = biddingDetailContentGrid.row(itemRowIndex);
		var extendFields = itemRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var imageList = extendFields.imageList;
			if("undefined"!=typeof(imageList) && imageList.length > 0){
				parent.elsDeskTop.closeCurWin('showPicture');
				for(var i=0;i<imageList.length;i++) {
					imageList[i]["preViewFilePath"] = imageList[i].filePath;
				}
				var obj={
						windowTitle: "图片预览",
						data:{
							defaultShow:"1",
							imageList : imageList
						},
				 	   	mask : true,
						windowMaximize: false,
						windowMinimize: false,
						windowStatus: "regular",
						windowWidth: 860,
						windowHeight: 700,
						iframSrc: elsBasePath+"common/previewimg/showPicture.jsp",
						windowsId: "showPicture",//传递上一级的窗口iframe id用parentWinId,其他数据自定
					};
				parent.elsDeskTop.defineWin(obj);
			} else {
				alert("没有图片可预览",2);
			}
		} else {
			alert("没有图片可预览",2);
		}
	});
	
	$('.uploadImage-item').live("click", function() {
	    var itemRowIndex = $(this).closest("tr").index();
		var item = biddingDetailContentGrid.row(itemRowIndex);
		var materialNumber = item.materialNumber;
		if(!(materialNumber && null!=materialNumber && $.trim(materialNumber)!="")) {
			alert('物料编号不能为空，请选择物料',2);
			return ;
		}
	    uploadFileType="image";
	    uploadFileRowIndex=itemRowIndex;
	    uploadFile();
	});
	
	$('.downloadImage-item').live("click", function() {
		var itemRowIndex = $(this).closest("tr").index();
		var itemRow = biddingDetailContentGrid.row(itemRowIndex);
		var extendFields = itemRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
			var imageList = extendFields.imageList;
			if("undefined"!=typeof(imageList) && imageList.length > 0){
				downloadFile("image",rowIndex);
			} else {
				alert("没有图片可下载",2);
			}
		} else {
			alert("没有图片可下载",2);
		}
	});
	$("#addFileBtnOK").click(function(){
		$("#addFileDialog1").hide();
		var filePath = $("#filePath1").val();
		if(filePath == ""){
			alert("<i18n:I18n defaultValue='请选择上传文件！' key='i18n_please_select_a_file_to_upload'/>",1);
			return false;
		}
		var fileName = $("#fileName1").val();
		var filePath = $("#filePath1").val();
		
		var itemRow = biddingDetailContentGrid.row(uploadFileRowIndex);
		var extendFields = itemRow.extendFields;
		if(extendFields){
			extendFields = JSON.parse(extendFields);
		} else {
			extendFields = {};
		}
	
		if("file"==uploadFileType){
			var fileList = extendFields.fileList;
			if("undefined"==typeof(fileList)){
				fileList = [];
			}
			fileList.push({fileType: "file",fileName:fileName,filePath:filePath});
			extendFields["fileList"]=fileList;
			itemRow["extendFields"]= JSON.stringify(extendFields);
			$("#attachmentFile_upload_"+uploadFileRowIndex).next().show();
		} else if("image"==uploadFileType){
			var imageList = extendFields.imageList;
			if("undefined"==typeof(imageList)){
				imageList = [];
			}
			imageList.push({fileType: "image",fileName:fileName,filePath:filePath});
			extendFields["imageList"]=imageList;
			itemRow["extendFields"]= JSON.stringify(extendFields);
			$("#attachmentImage_upload_"+uploadFileRowIndex).prev().show();
			$("#attachmentImage_upload_"+uploadFileRowIndex).next().show();
		} else{}
		
		clearAddFileInfo();
	});
	//添加文件弹出框取消按钮
	$("#addFileBtnCancel").click(function(){
		$("#addFileDialog1").hide();
		clearAddFileInfo();
	});

	//关闭按钮处理
	$("#dialogFileClose").click(function(){
		$("#addFileDialog1").hide();
		clearAddFileInfo();
	});

	function uploadFile(){
		clearAddFileInfo();
		$("#addFileDialog1").show();
		initFileUploader1(fileUploader1);
	}

	function downloadFile(type,rowIndex){
		var materialRow = biddingDetailContentGrid.row(rowIndex);
		var filePathArrStr = '';
		if("file"==type){
			var extendFields = materialRow.extendFields;
			if(extendFields){
				extendFields = JSON.parse(extendFields);
				var fileList = extendFields.fileList;
				if("undefined"!=typeof(fileList) && fileList.length > 0){
					for(var i=0;i<fileList.length;i++){
						filePathArrStr += (','+fileList[i].filePath);
					}
				} 
			}
		} else if("image"==type){
			var extendFields = materialRow.extendFields;
			if(extendFields){
				extendFields = JSON.parse(extendFields);
				var imageList = extendFields.imageList;
				if("undefined"!=typeof(imageList) && imageList.length > 0){
					for(var i=0;i<imageList.length;i++){
						filePathArrStr += (','+imageList[i].filePath);
					}
				}
			}
		} else{}
		convertToZipFileDown(filePathArrStr);
	}

	function clearAddFileInfo(){
		$("#fileName1").val("");
		$("#filePath1").val("");
		$("#fileType1").val("");
	}

	function initFileUploader1(fileUploader1){
	    //新增表单文件
	    if (!fileUploader1) {
		  	fileUploader1 = WebUploader.create({
		  	    swf : "${pageContext.request.contextPath}/jsLib/webuploader/Uploader.swf",// swf文件路径
		  	    auto : true,//是否选择文件后自动上传
		  	    server : "${pageContext.request.contextPath}/servlet/UploadServlet",// 文件接收服务端。
		  	    pick : "#btnFileUpload1",//选择文件的按钮,可选.内部根据当前运行时创建,可能是input元素,也可能是flash/
		  	    resize : false,// 不压缩image,默认如果是jpeg,文件上传前会压缩再上传.
		  	    formData : {
			     	elsAccount : elsAccount
			    }
		  	});
	  	
		 	// 当有文件添加进来的时候
			fileUploader1.on("fileQueued",function(file){
				var fileName = file.name;
				$("#fileName1").val(fileName);
				$("#fileType1").val(file.ext);
			});
		 	//上传到服务器响应后触发
			fileUploader1.on("uploadAccept", function( obj, response ) {
				var errorNumber = response.error;
				if(errorNumber == 0){
					var filePath = response.url;
					$("#filePath1").val(filePath);
				} else {
		   			var errorMessage = response.message;
		   			alert(errorMessage,3);
				}
			  	});
			//上传出错时触发
			fileUploader1.on( "uploadError", function( obj, reason  ) {
			  	   	var errorMessage = response.message;
			  	        alert(reason,3); 
		  	});
	    }
	}
	//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	$("#btnFromRequrePlan").click(function() {
		//兼容ie 冒泡事件
		if (event && event.preventDefault) {
		   event.preventDefault();
		   event.stopPropagation();
		} else {
		   window.event.returnValue = false;
		}
	    var getData = function(data) {
	    	requirementPlanCallback(data);
		};
		parent.elsDeskTop.defineWin({
		   'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
		   'windowsId':'requirePlanSelect',
		   'windowTitle':'<i18n:I18n key="i18n_order_from_requirementsPlanning" defaultValue="从需求计划提取"/>',
		   'windowSubTitle': companyShortName,
		   'iframSrc':'<%=basePath%>projectmanage/requirementsplanning/requirePlanSelect.jsp?frameAppId=addBiddingThree'
				   +'&projectNumber='+$("#contentBiddingProjectNumber").val()
				   +'&t='+new Date(),
		   'showAdv': false,
	 	   	'mask' : true,
		   'windowStatus': 'regular',
		   'windowMinWidth': 1024,
		   'windowMinHeight': 580,
		   'windowPositionTop':14,
		   'windowWidth':1024,
		   'windowHeight':580,
		   'parentPanel':".currDesktop",
	       data: getData
		});
	});

	function getMaxContentItemNum() {
		var rowsMy = biddingDetailContentGrid.rows();
		var maxContentItemNumber = 0;
		for(var i=0;i<rowsMy.length;i++){
			if(typeof(rowsMy[i]) != "undefined" && rowsMy[i] != null){
				var biddingContentItemNumber = rowsMy[i].biddingContentItemNumber;
				if(biddingContentItemNumber != null && typeof(biddingContentItemNumber) != "undefined" && biddingContentItemNumber>maxContentItemNumber){
					maxContentItemNumber = biddingContentItemNumber;
				}
			}
		}
		return parseInt(maxContentItemNumber);
	}

	function hiddenRendder(val,item,index){
		var thisRecord = $(this);
		var colName = thisRecord[0].name;
		if("undefined"==typeof(val) || null == val){
			val = ""; 
		}
		if("requirementTypeCode"==colName || "requirementTypeName"==colName) {
			return val + "<input name='biddingContentItem[]["+colName+"]' type='hidden' value='"+val+"'/>";
		}
	}
	function requirementPlanCallback(rows){
		var curMaxContentItemNO = getMaxContentItemNum()+1;
		var blankRow = {
				biddingProjectNumber : $("#contentBiddingProjectNumber").val(),
				biddingItemNumber : $("#contentBiddingItemNumber").val(),
				biddingContentItemNumber : curMaxContentItemNO,
				materialNumber : "",
				materialDesc : "",
				quantity : 0.0,
				materialModel : "",
				materialSpecification : "",
				units : "",
				deliveryDate : new Date().format('yyyy-MM-dd'),
				remark : ""
		};
		/*
		for(var mj=0;mj<materialAttrList.length;mj++) {
			blankRow[materialAttrList[mj]] = "";
		}
		*/
		var itemRows = biddingDetailContentGrid.rows();
		var arr = [];
		if(itemRows != "")
			arr = itemRows;
		for(var i = 0 ; i < rows.length ; i ++){
			var row = $.extend({}, blankRow);
			row["biddingContentItemNumber"] = curMaxContentItemNO + i;
			row["materialNumber"]=rows[i].materialNumber;
			row["materialDesc"]=rows[i].materialName;
			row["quantity"]=rows[i].fbk1;
			row["requirementTypeCode"]=rows[i].requirementTypeCode;
			row["requirementTypeCode"].renderer = hiddenRendder;
			row["requirementTypeName"]=rows[i].requirementTypeName;
			row["requirementTypeName"].renderer = hiddenRendder;
			row["attachmentFile"]=rows[i].attachmentFile;
			row["attachmentImage"]=rows[i].attachmentImage;
			row["extendFields"] = rows[i].extendFields;
			arr.push(row);	
		}
		if(arr.length > 0)
			biddingDetailContentGrid.load(arr);
	}

/** -----------===============Excel导入导出、评标导入、需求计划提取（结束）===============----------- */
	
	/* ====================================招标内容END================================================= */
	
	/* ====================================表单文件  start ============================================= */
	var editFileTable;
	var editFormTable;
	var fileUploader;
	
	var file_cols = [
		{ title:'标段', name:'biddingItemNumber' , width:60, align:'center',renderer:function(val){
			return val+"<input name='biddingFile[][biddingItemNumber]' type='text' style='display:none;'  value='"+val+"'/>";
		}},
		{ title:'标段名称', name:'biddingItemName' , width:60, align:'center',renderer:function(val){
			return val+"<input name='biddingFile[][biddingItemName]' type='text' style='display:none;'  value='"+val+"'/>";
		}},
		{ title:'轮次', name:'roundNumber', width:60, align:'center',renderer:function(val){
			return val+"<input name='biddingFile[][roundNumber]' type='text' style='display:none;'  value='"+val+"'/>";
		}},
		{ title:'文件类别', name:'fileClass', width:100, align:'center',renderer:function(val){
			if("undefined"==typeof(val)){
				val = "";
			}
			var typeName = "";
			if("1"==val){
				typeName="招标文件";
			} else if("2"==val){
				typeName="报名文件";
			} else if("3"==val){
				typeName="投标文件";
			} else if("4"==val){ 
				typeName="澄清答疑文件";
			} else if("5"==val){ 
				typeName="评标文件";
			} else if("6"==val){ 
				typeName="保证金文件";
			}
			return typeName+"<input name='biddingFile[][fileClass]' style='display:none;' type='text'  value='"+val+"'/>";
		}},
		{ title:'文件名称', name:'fileName' , width:100, align:'center',renderer:function(val){
			return "<input name='biddingFile[][fileName]' type='text'  value='"+val+"'/>";
		}},
		{ title:'文件类型', name:'fileType', width:100, align:'center',renderer:function(val){
			return val+"<input name='biddingFile[][fileType]' type='text' style='display:none;' value='"+val+"'/>";
		}},
		{ title:'文件所属方', name:'fileOwner', width:60,hidden:true ,align:'center',renderer:function(val){
			return val+"<input name='biddingFile[][fileOwner]' type='text' style='display:none;'  value='"+val+"'/>";
		}},
		{ title:'文件大小', name:'fileSize', width:100, align:'center',renderer:function(val){
			if("undefined"==typeof(val)||val==null){
				val = 0;
			}
			return val+"<input name='biddingFile[][fileSize]' type='text' style='display:none;'  value='"+val+"'/>";
		}},
		{ title:'备注', name:'remark', width:100, align:'center',renderer:function(val){
			return "<input name='biddingFile[][remark]' type='text'  value='"+val+"'/>";
		}},
		{ title:'文件路径', name:'filePath', width:100, align:'center',hidden:true,renderer:function(val){
			return "<input name='biddingFile[][filePath]' type='text' value='"+val+"'/>";
		}},
		{ title:'所属文件类型', name:'fbk5', width:100, align:'center',hidden:true,renderer:function(val){
			return "<input name='biddingFile[][fbk5]' type='text' readonly value='"+val+"'/>";
		}}
		];
	var localRoundNumber;
	//标段改变事件
	$("#fileBiddingItemNumber").change(function(){
		var itemNumber = $(this).val();
		if(!totalRoundArr || totalRoundArr.length ==0){
			alert("招标计划不能为空！",2);
		}else{
			var flag = false;
			var tempRound;
			for(var i=0;i<totalRoundArr.length;i++){
				if(totalRoundArr[i].itemNumber == itemNumber){
					tempRound = totalRoundArr[i];
					flag = true;
				}
			}
			if(flag == false){
				alert("招标计划不能为空！",2);
				return;
			}else{
				var setFileRoundNumber= $("#fileRoundNumber");
				 var totalRound = tempRound.totalRound;
				 if(totalRound>0){
					 setFileRoundNumber.empty();
					 for(var i=1;i<=totalRound;i++){
						 setFileRoundNumber.append("<option value='"+i+"'>"+i+"</option>");
					 }
				 }else {
					 setFileRoundNumber.empty();
					 setFileRoundNumber.append("<option value='0'>不区分轮次</option>");
				 }
			}
		}
		var fileRoundNumber = $("#fileRoundNumber").val();
		$("#add-file-project").find("tr").each(function(){
			var biddingItemNumber = $(this).find("input[name='biddingFile[][biddingItemNumber]']").val();
			var roundNumber = $(this).find("input[name='biddingFile[][roundNumber]']").val();
			if(itemNumber != biddingItemNumber || fileRoundNumber != roundNumber){
				$(this).attr("hidden",true);
			}else{
				$(this).attr("hidden",false);
			}
		});
	});
	//轮次改变事件
	$("#fileRoundNumber").change(function(){
		var itemNumber = $("#fileBiddingItemNumber").val();
		var fileRoundNumber = $("#fileRoundNumber").val();
		$("#add-file-project").find("tr").each(function(){
			var biddingItemNumber = $(this).find("input[name='biddingFile[][biddingItemNumber]']").val();
			var roundNumber = $(this).find("input[name='biddingFile[][roundNumber]']").val();
			if(itemNumber != biddingItemNumber || fileRoundNumber != roundNumber){
				$(this).attr("hidden",true);
			}else{
				$(this).attr("hidden",false);
			}
		});
	});
	//点击文件选项卡
	$('.add-file-sheet').click(function() {
		//////////////////////////////////////////////////////////////////////////
		//set标段
		var setItemNumberObj = $("#fileBiddingItemNumber");
		 var biddingPhases = $("#biddingPhases");
		 var biddingPhasesValue = biddingPhases.val();
		 if(biddingPhasesValue=="1"){
			 setItemNumberObj.empty();
			 setItemNumberObj.append("<option value='0'>"+biddingPhases.find("option:selected").text()+"</option>");
		 }else {
			 setItemNumberObj.empty();
		 	 var items = $("#form").serializeJSON().biddingPhasesItems;
			 for(var i=0;i<items.length;i++){
				 setItemNumberObj.append("<option value='"+items[i].biddingItemNumber+"'>标段"
						 +items[i].biddingItemNumber+" "+items[i].biddingItemName+"</option>");
			 }
		 }
		//set轮次
		var fileBiddingItemNumber = $("#fileBiddingItemNumber").val();
		if(!totalRoundArr || totalRoundArr.length ==0){
			alert("招标计划不能为空！",2);
		}else{
			var flag = false;
			var tempRound;
			for(var i=0;i<totalRoundArr.length;i++){
				if(totalRoundArr[i].itemNumber == fileBiddingItemNumber){
					tempRound = totalRoundArr[i];
					flag = true;
				}
			}
			if(flag == false){
				alert("招标计划不能为空！",2);
				return;
			}else{
				var setFileRoundNumber= $("#fileRoundNumber");
				 var totalRound = tempRound.totalRound;
				 if(totalRound>0){
					 setFileRoundNumber.empty();
					 for(var i=1;i<=totalRound;i++){
						 setFileRoundNumber.append("<option value='"+i+"'>"+i+"</option>");
					 }
				 }else {
					 setFileRoundNumber.empty();
					 setFileRoundNumber.append("<option value='0'>不区分轮次</option>");
				 }
			}
		}
		//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
		//set轮次
		/*  var setFileRoundNumber= $("#fileRoundNumber");
		 var biddingRounds = $("#totalRound").val();
		 if(biddingRounds>0){
			 if("undefined"==typeof(localRoundNumber)){
				 setFileRoundNumber.empty();
				 for(var i=1;i<=biddingRounds;i++){
					 setFileRoundNumber.append("<option value='"+i+"'>"+i+"</option>");
				 }
			 }else {
				if(localRoundNumber!=setFileRoundNumber.length){
					setFileRoundNumber.empty();
					for(var i=1;i<=biddingRounds;i++){
						setFileRoundNumber.append("<option value='"+i+"'>"+i+"</option>");
					}
					editFileTable.removeRow();
				} 
			 }
		 }else {
			 setFileRoundNumber.empty();
			 setFileRoundNumber.append("<option value='0'>不区分轮次</option>");
		 } */
		//set标段
		/*  var setItemNumberObj = $("#fileBiddingItemNumber");
		 var biddingPhases = $("#biddingPhases");
		 var biddingPhasesValue = biddingPhases.val();
		 if(biddingPhasesValue=="1"){
			 setItemNumberObj.empty();
			 setItemNumberObj.append("<option value='0'>"+biddingPhases.find("option:selected").text()+"</option>");
		 }else {
			 setItemNumberObj.empty();
		 	 var items = $("#form").serializeJSON().biddingPhasesItems;
			 for(var i=0;i<items.length;i++){
				 setItemNumberObj.append("<option value='"+items[i].biddingItemNumber+"'>标段"
						 +items[i].biddingItemNumber+" "+items[i].biddingItemName+"</option>");
			 }
		 } */
		if(editFileTable){
			return;
		}
		localRoundNumber = setFileRoundNumber.length;
		if(!editFileTable) {
			editFileTable=$('#add-file-project').mmGrid({
			    cols: file_cols,
			    height:650,
			    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol:true,
		        multiSelect:true,
		        items: []
			});
			editFileTable.resize();
		}
	});
	
	// 点击-->回签表单 赋值标段和轮次	
	$('.add-form-sheet').click(function() {
		//set标段
		var setItemNumberObj = $("#fileBiddingItemNumber1");
		 var biddingPhases = $("#biddingPhases");
		 var biddingPhasesValue = biddingPhases.val();
		 if(biddingPhasesValue=="1"){
			 setItemNumberObj.empty();
			 setItemNumberObj.append("<option value='0'>"+biddingPhases.find("option:selected").text()+"</option>");
		 }else {
			 setItemNumberObj.empty();
		 	 var items = $("#form").serializeJSON().biddingPhasesItems;
			 for(var i=0;i<items.length;i++){
				 setItemNumberObj.append("<option value='"+items[i].biddingItemNumber+"'>标段"
						 +items[i].biddingItemNumber+" "+items[i].biddingItemName+"</option>");
			 }
		 }
		//set轮次
		var fileBiddingItemNumber = $("#fileBiddingItemNumber1").val();
		if(!totalRoundArr || totalRoundArr.length ==0){
			alert("招标计划不能为空！",2);
		}else{
			var flag = false;
			var tempRound;
			for(var i=0;i<totalRoundArr.length;i++){
				if(totalRoundArr[i].itemNumber == fileBiddingItemNumber){
					tempRound = totalRoundArr[i];
					flag = true;
				}
			}
			if(flag == false){
				alert("招标计划不能为空！",2);
				return;
			}else{
				var setFileRoundNumber= $("#fileRoundNumber1");
				 var totalRound = tempRound.totalRound;
				 if(totalRound>0){
					 setFileRoundNumber.empty();
					 for(var i=1;i<=totalRound;i++){
						 setFileRoundNumber.append("<option value='"+i+"'>"+i+"</option>");
					 }
				 }else {
					 setFileRoundNumber.empty();
					 setFileRoundNumber.append("<option value='0'>不区分轮次</option>");
				 }
			}
		}
		if(editFormTable){
			return;
		}
		localRoundNumber = setFileRoundNumber.length;
		if(!editFormTable) {
			editFormTable=$('#sign-form-project').mmGrid({
			    cols: file_cols,
			    height:650,
			    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
		        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
		        checkCol:true,
		        multiSelect:true,
		        items: []
			});
			editFormTable.resize();
		}
	});
	
	function initFileUploader(fileUploader){
		   if(!fileUploader){
		    //新增表单文件
		  	fileUploader = WebUploader.create({
		  	    // swf文件路径
		  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		  	  	duplicate :true,
		  	    auto: true,
		  	    // 文件接收服务端。
		  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
		  	    // 选择文件的按钮。可选。
		  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		  	    pick: '#btnFileUpload',
		  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		  	    resize: false
		  	 });
		  	fileUploader.on( 'uploadAccept', function( obj, response ) {
		  	  	if(0 == response.error){
		  	   	   var filePath = response.url;
		  	   		$("#filePath").val(filePath);
		  	   	    $("#fileName").val(response.name);
		  	   	    $("#fileSize").val(response.size);
		  	  	}else{
		  	  		alert(response.message,2);
		  	  	}
		  	});
		  }
		}
	
	function initFileUploader2(fileUploader1){
		   if(!fileUploader1){
		    //新增表单文件
		  	fileUploader1 = WebUploader.create({
		  	    // swf文件路径
		  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		  	  	duplicate :true,
		  	    auto: true,
		  	    // 文件接收服务端。
		  	    server: '<%=basePath%>servlet/UploadServlet?elsAccount='+elsAccount,
		  	    // 选择文件的按钮。可选。
		  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		  	    pick: '#btnFormUpload',
		  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		  	    resize: false
		  	 });
		  	fileUploader1.on( 'uploadAccept', function( obj, response ) {
		  	  	if(0 == response.error){
		  	   	   var filePath = response.url;
		  	   		$("#filePath1").val(filePath);
		  	   	    $("#fileName1").val(response.name);
		  	   	    $("#fileSize1").val(response.size);
		  	  	}else{
		  	  		alert(response.message,2);
		  	  	}
		  	});
		  }
		}
	
		//在文件列表添加新添加的文件列
		function addFileItem(){
			var filePath=$("#filePath").val();
			var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
			var fileName=$("#fileName").val();
			var fileClass=$("#fileClass").val();
			var fileQ=$("#fileQ").val();
			var fileBiddingItemNumber = $("#fileBiddingItemNumber");
			if(fileQ){
				fileBiddingItemNumber = $("#qualificationBiddingItemNumber");
			}
			var fileBiddingItemName = fileBiddingItemNumber.find("option:selected").text();
			var fileRoundNumber = $("#fileRoundNumber").val();
			var fileSize = $("#fileSize").val();
			if(fileSize==null||fileSize==""){
				fileSize=0;
			}
			var fileBlackItem={biddingItemNumber:fileBiddingItemNumber.val(),biddingItemName:fileBiddingItemName,roundNumber:fileRoundNumber,fileName:fileName,fileClass:fileClass,fileType:fileType,filePath:filePath,fileOwner:"0",fileSize:fileSize,remark:"",fbk5:"0"};
			editFileTable.addRow(fileBlackItem);
			$('#addFileDialog').hide();
		}
		
		//在文件列表添加新添加的文件列
		function addFormItem(){
			var filePath=$("#filePath1").val();
			var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
			var fileName=$("#fileName1").val();
			var fileClass=$("#fileClass1").val();
			var fileQ=$("#fileQ1").val();
			var fileBiddingItemNumber = $("#fileBiddingItemNumber1");
			if(fileQ){
				fileBiddingItemNumber = $("#qualificationBiddingItemNumber");
			}
			var fileBiddingItemName = fileBiddingItemNumber.find("option:selected").text();
			var fileRoundNumber = $("#fileRoundNumber1").val();
			var fileSize = $("#fileSize1").val();
			if(fileSize==null||fileSize==""){
				fileSize=0;
			}
			var fileBlackItem={biddingItemNumber:fileBiddingItemNumber.val(),biddingItemName:fileBiddingItemName,roundNumber:fileRoundNumber,fileName:fileName,fileClass:fileClass,fileType:fileType,filePath:filePath,fileOwner:"0",fileSize:fileSize,remark:"",fbk5:"1"};
			editFormTable.addRow(fileBlackItem);
			$('#addFileDialog1').hide();
		}
		
		//显示上传弹框
		$("#uploadFile").click(function(){
			 initFileUploader(fileUploader);
			 $('#addFileDialog').show();
		});
		
		$("#qualificationUploadFile").click(function(){
			 initFileUploader(fileUploader);
			 $("#fileClass").val("2");
			 $("#fileQ").val("1");
			 $("#fileClass").attr("disabled",true);
			 $('#addFileDialog').show();
		});
		
		//关闭上传弹框
		$("#btnFileCancel ,.dialog-close-btn").click(function(){
			 $('#addFileDialog').hide();
		});
		
		//显示上传弹框
		$("#btnFileOK").click(function(){
			addFileItem();
		});
		
		//文件下载
		$("#downloadFile").click(function(){
			var selectRows = editFileTable.selectedRows();
			if(selectRows.length > 0){
				selectRow = selectRows[0];
				var filePath = selectRow.filePath;
			    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
			}else{
				parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
			}
		 });

		//回签文件-->显示上传弹框
		$("#uploadForm").click(function(){
			 initFileUploader2(fileUploader1);
			 $('#addFileDialog1').show();
		});
		
		//回签文件-->关闭上传弹框
		$("#btnFormCancel ,.dialog-close-btn").click(function(){
			 $('#addFileDialog1').hide();
		});
		//回签文件-->显示上传弹框
		$("#btnFormOK").click(function(){
			addFormItem();
		});
		//回签文件-->文件下载
		$("#downloadFile").click(function(){
			var selectRows = editFormTable.selectedRows();
			if(selectRows.length > 0){
				selectRow = selectRows[0];
				var filePath = selectRow.filePath;
			    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
			}else{
				parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
			}
		 });
		 
		//回签文件-->在线预览
		$("#lookForm").click(function(){
			var selectRows = editFormTable.selectedRows();
			if(selectRows.length > 0){
				selectRow = selectRows[0];
				var filePath = selectRow.filePath;
				previewFile(filePath);
			}else{
				parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
			}
		});
		 
		//在线预览
		$("#lookForm").click(function(){
			var selectRows = editFileTable.selectedRows();
			if(selectRows.length > 0){
				selectRow = selectRows[0];
				var filePath = selectRow.filePath;
				previewFile(filePath);
			}else{
				parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_mustchoosealine" defaultValue="请选择需要操作的数据" />'});
			}
		});
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
	/* 表单文件   end */

	/* 报名条件   start */
	
	$('.add-line-apply').click(function() {
		if(typeof(biddingQualificationArray)!="undefined"){
			return;
		}
		
		//set标段
		 var setItemNumberObj = $("#qualificationBiddingItemNumber");
		 var biddingPhases = $("#biddingPhases");
		 var biddingPhasesValue = biddingPhases.val();
		 if(biddingPhasesValue=="1"){
			 $("input[name='biddingQualification[multiSection]']").eq(0).attr("checked",'checked');
			 $("input[name='biddingQualification[multiSection]").attr("disabled",true);
			 $("#qualificationBiddingItemNumber").attr("disabled",true);
			 setItemNumberObj.empty();
			 setItemNumberObj.append("<option value='0'>"+biddingPhases.find("option:selected").text()+"</option>");
			 if(!$.isArray(biddingQualificationArray)){
				 biddingQualificationArray= new Array(0);
				 }
		 }else {
			 $("input[name='biddingQualification[multiSection]']").eq(1).attr("checked",'checked');
			 setItemNumberObj.empty();
			 var items = $("#form").serializeJSON().biddingPhasesItems;
			 for(var i=0;i<items.length;i++){
				 setItemNumberObj.append("<option value='"+items[i].biddingItemNumber+"'>"+items[i].biddingItemName+"</option>");
			 }
			 if(!$.isArray(biddingQualificationArray)){
		 		biddingQualificationArray= new Array(items.length-1);
			 }
		 }
		 
		$("#qualificationBiddingItemNumber").val("1");//默认选择标段1
		$("body").data("qualificationBiddingItemNumber_local","1");
		$("body").data("qualificationIndex_local",setItemNumberObj.get(0).selectedIndex);
	});
	
	$("#qualificationBiddingItemNumber").change(function(){
		//保存之前
		var form = $("#form").serializeJSON();
		var biddingItemNumber = $("body").data("qualificationBiddingItemNumber_local");//获取标段---原标段
		var biddingItemIndex= $("body").data("qualificationIndex_local");
		var biddingQualification = form.biddingQualification;
		biddingQualification["biddingItemNumber"]=biddingItemNumber;
		biddingQualificationArray[biddingItemIndex]= biddingQualification;
		$("#qualificationRegisterEndDate").val("");
		$("#qualificationRegisterEndTime").val("");
		$("#qualificationCapital").val("");
		$("#qualificationJointBidding").val("1");
		$("#qualificationQualification").val("");
		$("#qualificationDeliverability").val("");
		$("#qualificationAuthentication").val("");
		$("#qualificationRemark").val("");
		var selectValue = $(this).get(0).selectedIndex;
		if("undefined" !=typeof(biddingQualificationArray[selectValue])){
			var biddingQualification = biddingQualificationArray[selectValue];
			 $("#qualificationRegisterEndDate").val(new Date(biddingQualification.registerEndDate).format('yyyy-MM-dd'));
			$("#qualificationRegisterEndTime").val(biddingQualification.registerEndTime);
			$("#qualificationCapital").val(biddingQualification.capital);
			$("#qualificationJointBidding").val(biddingQualification.jointBidding);
			$("#qualificationQualification").val(biddingQualification.qualification);
			$("#qualificationDeliverability").val(biddingQualification.deliverability);
			$("#qualificationAuthentication").val(biddingQualification.authentication);
			$("#qualificationRemark").val(biddingQualification.remark);
		}
		$("body").data("qualificationBiddingItemNumber_local",$(this).val());
		$("body").data("qualificationIndex_local",$(this).get(0).selectedIndex);
	});
	
	
	$("input[name='biddingQualification[multiSection]']").click(function(){
		var val = $(this).val();
		if(val == "0"){ //不区分标段
			$("#qualificationBiddingItemNumber").attr("disabled",true);
			$("#qualificationBiddingItemNumber").val("0");//设置为不区分标段
		}else{
			$("#qualificationBiddingItemNumber").attr("disabled",false);
			$("#qualificationBiddingItemNumber").val("1");//设置为标段1
		}
	});
	
	/* ===================================================报名条件  end ===============================================*/
</script>
</body>
</html>