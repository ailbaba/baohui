<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>

<div class="pos-relative public-wrap">
    <form id="requirementsplanningForm" onsubmit="return false;">
        <input type="hidden" id="elsAccount" name="elsAccount">  
        <input type="hidden" id="requirementsPlanningNumber" name="requirementsPlanningNumber">          
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip" id="isShow">
                     <button id="save-requirementsplanning" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
                </div>
                <div class="dis-in-b input-and-tip" id="isShow">
                     <button id="close-requirementsplanning" class="button-wrap"><i18n:I18n key="i18n_js_close" defaultValue="关闭" /></button>
                </div>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_requirementsPlanning_table_projectInformation" defaultValue="项目信息" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="headTable"></table>
                    </div>
                </main>
            </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="需求明细" /></span>
            <div class="common-box-line">
                <div class="tab-wrap" id="sheet-project">
                    <ul>
                        <li><a href="#sheet-project-one"><i18n:I18n defaultValue="物料信息" key="i18n_enquiry_title_materialsinformation"/></a></li>
                    </ul>
                    <div id="sheet-project-one">
                        <main class="grid-container nest-table">
                            <div class="grid-100">
                                <table id="itemTable"></table>
                            </div>
                        </main>
                    </div>
                </div>
            </div>
        </div>
        
   </form>
</div>

<div class="fixed-dialog" id="addFileDialog">
    <div class="dialog-tip bg-common" style="width: 262px;height: auto; margin-left: -131px;margin-top: -190px;">
        <div class="dialog-close-btn" id="dialogFileClose"></div>
        <div class="tip-head">
            <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
            <span class="dialogTitle"><i18n:I18n defaultValue="选择表单文件" key="i18n_common_title_chooseformfile"/></span>
        </div>
        <div class="">
            <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                <div class="common-box-line">
                    <div class="input-and-tip"><span><i18n:I18n defaultValue="文件名称" key="i18n_common_label_filename"/>：</span><input id="fileName" name="fileName" type="text" /></div>
                    <div class="input-and-tip"><span><i18n:I18n defaultValue="文件路径" key="i18n_common_label_filepath"/>：</span><input id="filePath" name="filePath" type="text" /></div>
                    <div class="input-and-tip text-right">                 
                        <div id="btnFileUpload" class="btn btnUpload">
                            <i18n:I18n defaultValue="选择表单文件" key="i18n_common_button_chooseformfile"/>
                        </div>           
                        <input id="fileType" name="fileType" type="hidden" />
                    </div>
                    <div class="mt-20 text-center">
                        <button id="addFileBtnOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
                        <button id="addFileBtnCancel" class="button-wrap "><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="fixed-dialog" id="selectFriendElsAccountDialog" >
    <div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
        <div class="dialog-close-btn" id="selectFriendElsAccountDialogClose"></div>
        <div class="tip-head">
            <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
            <span class="dialogTitle"><i18n:I18n defaultValue="请选择" key="i18n_common_title_pleasechoose"/></span>
        </div>
        <div class="">
            <div class="box-wrap pos-relative bg-common">
                <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="selectFriendElsAccountTable"></table>
                    </div>
                    <div class="mt-40 text-center" style="margin-top: 14px;">
                        <button id="selectFriendOKBtn" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
                        <button id="selectFriendCancelBtn" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
                    </div>
                 </main>
            </div>
        </div>
    </div>
</div>

<script>
var elsAccount = "${sessionScope.elsAccount}";
var elsSubAccount = "${sessionScope.elsSubAccount}";
var elsDesc = "${sessionScope.companyShortName}";
var userName = "${sessionScope.username}";
var headGrid;
var itemGrid;
var fileUploader;
var uploadFileType;
var itemRowIndex;
var materialAttrList = [];
var operationType = "${param.operationType}";
var isNotUpdate = !("update"==operationType);//!运算优先于==运算,加()以先进行==运算
var frameAppId = "${param.frameAppId}";
var toElsAccount = "${param.toElsAccount}";
var requirementsPlanningNumber = "${param.requirementsPlanningNumber}";
var projectNumber = "${param.projectNumber}";
var projectItemNumber = "${param.projectItemNumber}";

$().ready(function(){
    $("button").button();
    $("#sheet-project").tabs();
    
    init();
     window.beforeClose = function(close){
        top.elsDeskTop.tip.init({
            type            : 'confirm',
            displayType     : 2, 
            message         :'<i18n:I18n key="i18n_common_alert_confirmTheShutDown" defaultValue="确认关闭" />?',
            closeEvent : function () {
               close();
            }
        });
    }; 
});    

var headRender = function(val, item, rowIndex){
    var thisRecord = $(this);
    var colName = thisRecord[0].name;
    if("undefined"==typeof(val) || null == val){
        val = ""; 
    }
    if("status"==colName ){
        if("0"==val){
            return "新建";
        } else if("1"==val){
            return "审批中";
        } else if("2"==val){
            return "审批通过";
        } else if("3"==val){
            return "关闭";
        } else {
            return val;
        }
    } else if("operation" == colName){
        var text = '<span class="add-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_requirementsPlanning_table_addRequire" defaultValue="添加需求" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	    return text;
	} else if("approveDate"==colName || "actualStartDate"==colName || "actualEndDate"==colName){
        if(""!=val){
            return new Date(val).format("yyyy-MM-dd");
        } else {
            return "";
        }
    } else {
        if("update"==operationType){
            return "<input typpe='text' name='"+colName+"' class='headColsEdit' value='"+val+"' />";
        } else {
            return val;
        }
    }
}

var requirementsPlanningHeadCols = [
		{ title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作"/>', name:'operation' , width:120, align:'center',clickDisable:true,renderer:headRender},
        { title:'<i18n:I18n key="" defaultValue="对方ELS号"/>', name:'toElsAccount' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_common_title_orderitemnumber" defaultValue="项目编号"/>', name:'projectNumber' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_quotation_itemnumber" defaultValue="行项目编号"/>', name:'projectItemNumber' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_table_projectName" defaultValue="项目名称"/>', name:'projectDesc' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_projectItemDescription" defaultValue="项目行描述"/>', name:'projectItemDesc' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_table_responsiblePerson" defaultValue="责任人"/>', name:'projectLeader' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_startDate" defaultValue="开始日期"/>', name:'actualStartDate' , width:120, align:'center',renderer:headRender},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_endDate" defaultValue="结束日期"/>', name:'actualEndDate' , width:120, align:'center',renderer:headRender},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_table_projectSite" defaultValue="项目地点"/>', name:'projectAddress' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_documentStatus" defaultValue="单据状态"/>', name:'status' , width:120, align:'center',renderer:headRender},
        { title:'<i18n:I18n key="i18n_audit_lable_auditpersons" defaultValue="审批人"/>', name:'approvePerson' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_approvalTime" defaultValue="审批时间"/>', name:'approveDate' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_label_remark" defaultValue="备注"/>', name:'remark' , width:120, align:'center'}
    ];

var itemRender = function(val, item, rowIndex){
    var thisRecord = $(this);
    var colName = thisRecord[0].name;
    if("undefined"==typeof(val) || null == val){
        val = ""; 
    }
    
    if("operation" == colName){
        var text = '<span class="copyAdd-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_button_copyAdd" defaultValue="复制新增" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
            +'&nbsp;&nbsp;<span class="remove-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        return text;
    } else if("attachmentFile" == colName){
        var text = "";
        if("update"==operationType){
            text = '<span class="uploadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
                +'&nbsp;&nbsp;<span class="downloadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        } else {
            text = '<span class="downloadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        }
        return text;
    } else if("attachmentImage" == colName){
        var text = "";
        if("update"==operationType){
            text = '<span class="previewImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
                +'&nbsp;&nbsp;<span class="uploadImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
                +'&nbsp;&nbsp;<span class="downloadImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        } else {
            text = '<span class="previewImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
                +'&nbsp;&nbsp;<span class="downloadImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
        }
        return text;
    } else if("dateRequired"==colName){
        if("update"==operationType){
            if(""!=val){
                return "<input typpe='text' name='"+colName+"' class='Wdate' onfocus=\"WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})\" value='"+new Date(val).format("yyyy-MM-dd hh:mm:ss")+"' />";
            } else {
                return "<input typpe='text' name='"+colName+"' class='Wdate' onfocus=\"WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})\" value='' />";
            }
        } else {
            if(""!=val){
                return new Date(val).format("yyyy-MM-dd hh:mm:ss");
            } else {
                return "";
            }
        }
    } else {
        if("update"==operationType){
            return "<input typpe='text' name='"+colName+"' class='itemColsEdit' value='"+val+"' />";
        } else {
            return val;
        }
    }
}
var requirementsPlanningItemCols = [
		isNotUpdate ? null : { title:'<i18n:I18n key="i18n_enquiry_title_operation" defaultValue="操作"/>', name:'operation' , width:80, align:'center',clickDisable:true,renderer:itemRender},
        { title:'<i18n:I18n key="" defaultValue="对方ELS号"/>', name:'toElsAccount' , width:120, align:'center'},
        { title:'<i18n:I18n key="" defaultValue="需求类型编码"/>', name:'requirementTypeCode' , width:120, align:'center',clickDisable:isNotUpdate,renderer:itemRender},
        { title:'<i18n:I18n key="" defaultValue="需求类型名称"/>', name:'requirementTypeName' , width:120, align:'center',renderer:itemRender},
        { title:'<i18n:I18n key="" defaultValue="方案/设计图纸"/>', name:'attachmentFile' , width:80, align:'center',clickDisable:true,renderer:itemRender},
        { title:'<i18n:I18n key="" defaultValue="图片"/>', name:'attachmentImage' , width:100, align:'center',clickDisable:true,renderer:itemRender},
        { title:'<i18n:I18n key="i18n_common_title_orderitemnumber" defaultValue="项目编号"/>', name:'projectNumber' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_quotation_itemnumber" defaultValue="行项目编号"/>', name:'projectItemNumber' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber' , width:120, align:'center',clickDisable:isNotUpdate,renderer:itemRender},
        { title:'<i18n:I18n key="i18n_common_lable_materialname" defaultValue="物料名称" />', name:'materialName' , width:120, align:'center',renderer:itemRender},
        { title:'<i18n:I18n key="i18n_common_label_unitofmeasurement" defaultValue="计量单位" />', name:'unitOfMeasurement' , width:120, align:'center',renderer:itemRender},
        { title:'<i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />', name:'fbk1' , width:120, align:'center',renderer:itemRender},
        { title:'<i18n:I18n key="i18n_common_label_deliverydate" defaultValue="需求日期" />', name:'dateRequired' , width:150, align:'center',renderer:itemRender},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_placeOfReceipt" defaultValue="收货地点" />', name:'placeOfReceipt' , width:120, align:'center'},
        { title:'<i18n:I18n key="i18n_requirementsPlanning_lable_proposedPurchasePrice" defaultValue="建议采购价格" />', name:'suggestPrice' , width:120, align:'center',renderer:itemRender},
        { title:'<i18n:I18n key="i18n_label_remark" defaultValue="备注"/>', name:'remark' , width:120, align:'center',renderer:itemRender}
     ];

if(isNotUpdate){
    requirementsPlanningHeadCols.splice(0,1);
    requirementsPlanningItemCols.splice(0,1);
}

$(".headColsEdit").live('change',function(){
    var thisVal = $(this).val();
    var thisName = $(this).attr("name");
    var rowIndex = $(this).closest("tr").index();
    var rowData = headGrid.row(rowIndex);
    rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
});

$('.add-item').live("click", function() {
    var scanCol = $(this).next();
    var sanContent = scanCol.text();
    var item = JSON.parse(sanContent);
    var row = {
            "elsAccount":item.elsAccount,
            "toElsAccount":item.toElsAccount,
            "projectNumber":item.projectNumber,
            "projectItemNumber":item.projectItemNumber,
            "requirementTypeCode":"",
            "requirementTypeName":"",
            "materialNumber":"",
            "materialName":"",
            "property1":"",
            "property2":"",
            "property3":"",
            "property4":"",
            "property5":"",
            "unitOfMeasurement":"",
            "fbk1":"",
            "dateRequired":"",
            "placeOfReceipt":"",
            "suggestPrice":"",
            "remark":""
    };
    itemGrid.addRow(row);
});

$(".itemColsEdit").live('change',function(){
    var thisVal = $(this).val();
    var thisName = $(this).attr("name");
    var rowIndex = $(this).closest("tr").index();
    var rowData =itemGrid.row(rowIndex);
    rowData[""+thisName] = thisVal;//将值赋给mmgrid对象对应属性
});

$(".copyAdd-item").live("click",function(){
    var rowIndex = $(this).closest("tr").index();
    var rowRecord = itemGrid.row(rowIndex);
    //dateRequired输入框使用Wdate插件不会触发change事件,需要重新赋值
    var dateRequired = $("#itemTable tbody tr").eq(rowIndex).find("input[name='dateRequired']").val();
    rowRecord["dateRequired"]=dateRequired;
    var newRowData = JSON.parse(JSON.stringify(rowRecord));//复制rowRecord数据,直接使用rowRecord会导致两行引用指向同一条数据数据
    itemGrid.addRow(newRowData,rowIndex+1);//新增一行到rowIndex+1位置,但mmGrid已经加载在页面的行数据不会自动更新其行序号
    reLoadItems();//重新加载行表数据
});

function reLoadItems(){
	itemsData = itemGrid.rows();
    if(itemsData.length > 0){
    	for(var i=0;i<itemsData.length;i++){
    		var rowData = itemsData[i];
    		rowData["dateRequired"]=$("#itemTable tbody tr").eq(i).find("input[name='dateRequired']").val();
    	}
    }
    itemGrid.load(itemsData);
}

$('.remove-item').live("click", function() {
    var rowIndex = $(this).closest("tr").index();
    itemGrid.removeRow(rowIndex);
});

$('.uploadFile-item').live("click", function() {
    var itemRowIndex = $(this).closest("tr").index();
    uploadFileType="file";
    uploadFileRowIndex=itemRowIndex;
    uploadFile();
});

$('.downloadFile-item').live("click", function() {
    var itemRowIndex = $(this).closest("tr").index();
    var itemRow = itemGrid.row(itemRowIndex);
    var fileList = itemRow.fileList;
    if("undefined"!=typeof(fileList) && fileList.length > 0){
        downloadFile("file",itemRowIndex);
    } else {
        alert("没有文件可下载",2);
    }
});

$(".previewImage-item").live("click", function() {
    var itemRowIndex = $(this).closest("tr").index();
    var itemRow = itemGrid.row(itemRowIndex);
    var imageList = itemRow.imageList;
    if("undefined"!=typeof(imageList) && imageList.length > 0){
        var obj={
                windowTitle: "图片预览",
                data:{
                    defaultShow:"1",
                    imageList : imageList
                },
                windowMaximize: false,
                windowMinimize: false,
                windowStatus: "regular",
                windowWidth: 860,
                windowHeight: 700,
                iframSrc: "projectmanage/requirementsplanning/showPicture.jsp",
                windowsId: "showPicture",//传递上一级的窗口iframe id用parentWinId,其他数据自定
            };
        parent.elsDeskTop.defineWin(obj);
    } else {
        alert("没有图片可预览",2);
    }
});

$('.uploadImage-item').live("click", function() {
    var itemRowIndex = $(this).closest("tr").index();
    uploadFileType="image";
    uploadFileRowIndex=itemRowIndex;
    uploadFile();
});

$('.downloadImage-item').live("click", function() {
    var itemRowIndex = $(this).closest("tr").index();
    var itemRow = itemGrid.row(itemRowIndex);
    var imageList = itemRow.imageList;
    if("undefined"!=typeof(imageList) && imageList.length > 0){
        downloadFile("image",itemRowIndex);
    } else {
        alert("没有图片可下载",2);
    }
});

function init(){
    if(operationType == "check"){
        $("#isShow").hide();
    }
    
    $("#elsAccount").val(elsAccount);
    $("#toElsAccount").val(toElsAccount);
    $("#requirementsPlanningNumber").val(requirementsPlanningNumber);
   
    var param = {
            elsAccount : elsAccount,
            toElsAccount : toElsAccount,
            requirementsPlanningNumber : requirementsPlanningNumber,
            projectNumber : projectNumber,
            projectItemNumber : projectItemNumber
    }
    
    $.ajax({
        url : "${pageContext.request.contextPath}/rest/MaterialCateService/queryMaterialSpecList",
        type : "POST",
        contentType : "application/json",
        dataType : "json",
        async : false,//发送同步请求,锁住浏览器,待请求完成获得物料属性数据再加载后面的,因为后面item表需要加载物料属性数据来决定显示列
        data : JSON.stringify({elsAccount : toElsAccount}),
        success : function(data) {
            var specList = data.rows;
            if("undefined"!=typeof(data.rows) && data.rows.length > 0){
                materialAttrList = data.rows;
                for(var i=0;i<materialAttrList.length;i++){
                    var colRecord = {
                            title : materialAttrList[i].materialSpecName, 
                            name : materialAttrList[i].materialSpecCode,
                            width : 120, 
                            align : "center",
                            renderer : itemRender
                    };
                    requirementsPlanningItemCols.push(colRecord);
                }
            }
        },
        error: function (xhr, type, exception) {//获取ajax的错误信息
            alert(exception,3); 
        }
    });
    
    headGrid=$('#headTable').mmGrid({
        cols : requirementsPlanningHeadCols,
        url : "${pageContext.request.contextPath}/rest/SaleRequirementPlanService/findHeadList",
        params : param,
        height : 100,
        method : 'post',
        root : 'rows',
        loadingText : '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText : '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        indexCol : true,
        multiSelect :false
    });
    
    itemGrid=$('#itemTable').mmGrid({
        cols: requirementsPlanningItemCols,
        url: '${pageContext.request.contextPath}/rest/SaleRequirementPlanService/findItemList',
        params: param,
        height: 300,
        method: 'post',
        root: 'rows',
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
        indexCol: true,
        multiSelect:false,
    });
    
    itemGrid.on("loadSuccess",function(e, data){
        if("undefined"!=typeof(data.rows) && data.rows.length > 0){
            for(var i=0;i<data.rows.length;i++){
                var itemRow = data.rows[i];
                var attrArr = itemRow.attrList;
                if("undefined"!=typeof(attrArr) && attrArr.length > 0){
                    for(var j=0;j<attrArr.length;j++){
                        itemRow[attrArr[j].materialAttrCode]=attrArr[j].materialAttrValue;
                    }
                    itemGrid.updateRow(itemRow,i);
                }
            }
        }
    });

}

$("#save-requirementsplanning").click(function() {
    var rows = headGrid.rows();
    var headRow;
    if(rows == null || headGrid.rowsLength() == 0){
        alert('<i18n:I18n key="i18n_requirementsPlanning_alert_atLeastOneItemIsAdded" defaultValue="至少添加一条物料信息！"/>',2);
        return;
    }  else {
        headRow = rows[0];
        headRow["actualStartDate"]= $("#headTable tbody tr").eq(0).find("input[name='actualStartDate']").val();
        headRow["actualEndDate"]= $("#headTable tbody tr").eq(0).find("input[name='actualEndDate']").val();
        headRow["approveDate"]= $("#headTable tbody tr").eq(0).find("input[name='approveDate']").val();
    }
    
    var itemRows = itemGrid.rows();
    if(itemRows == null || itemGrid.rowsLength() == 0){
        alert('<i18n:I18n key="i18n_requirementsPlanning_alert_atLeastOneItemIsAdded" defaultValue="至少添加一条物料信息！"/>',2);
        return;
    } else {
        for(var i=0;i<itemGrid.rowsLength();i++){
            var itemRow = itemRows[i];
            //itemRow["dateRequired"]= $("#itemTable tbody").find("tr").eq(i).find("input[name='dateRequired']").val();
            var dateRequired = $("#itemTable tbody").find("tr").eq(i).find("input[name='dateRequired']").val();
            if("undefined"!=typeof(dateRequired) && dateRequired!=null && ""!=dateRequired){
                itemRow["dateRequired"]=new Date(dateRequired).getTime();//jackson不支持yyyy-MM-dd hh-mmm-ss格式时间转换
            }
            var attrList = [];
            if("undefined"!=typeof(materialAttrList) && materialAttrList.length > 0){
                for(var j=0;j<materialAttrList.length;j++){
                    var attrRecord = {
                            elsAccount : elsAccount,
                            toElsAccount : toElsAccount,
                            requirementsPlanningNumber : itemRow.requirementsPlanningNumber,
                            projectNumber : itemRow.projectNumber,
                            projectItemNumber : itemRow.projectItemNumber,
                            materialNumber : itemRow.materialNumber,
                            materialItemNumber : itemRow.materialItemNumber,
                            requirementTypeCode : itemRow.requirementTypeCode,
                            materialAttrCode : materialAttrList[j].materialSpecCode,
                            materialAttrName : materialAttrList[j].materialSpecName,
                            materialAttrIndex : j,
                            materialAttrValue : itemRow[materialAttrList[j].materialSpecCode],
                            remark : "",
                    };
                    attrList.push(attrRecord);
                }
                itemRow["attrList"] = attrList;
            }
        }
    }
    
    headRow["itemList"] = itemRows;
    
    parent.elsDeskTop.showLoading('<i18n:I18n key="i18n_requirementsPlanning_alert_inTheSave" defaultValue="保存中..." />');
    $.ajax({
        url : "${pageContext.request.contextPath}/rest/SaleRequirementPlanService/update",
        type : "POST",
        contentType : "application/json",
        dataType : "json",
        data:JSON.stringify(headRow),
        success : function(data) {
            if(data.statusCode == "200"){
                parent.elsDeskTop.hideLoading();
                alert("<i18n:I18n key='i18n_common_alert_successfulOperation' defaultValue='操作成功'/>！",1);
                parent.frames['iframeApp_saleRequirePlanManage'].queryRequirementsplanning();
                parent.elsDeskTop.closeCurWin('saleRequirePlanDetail');
            }else{
                parent.elsDeskTop.hideLoading();
                alert(data.message,3);
            }
        },
        error: function (xhr, type, exception) {//获取ajax的错误信息
            parent.elsDeskTop.hideLoading();
            alert(exception,3); 
        }
  });
    
});

$("#close-requirementsplanning").click(function() {
    parent.elsDeskTop.closeCurWin('saleRequirePlanDetail');
});

function selectRequirementTypeCode(item,rowIndex){
    //兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'requirementTypeCheck',
        'windowTitle':'<i18n:I18n key="" defaultValue="需求类型"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'${pageContext.request.contextPath}/requirement/requirementtype/requirementTypeCheck.jsp?frameAppId=detailsRequirementsPlanning&rowIndex='+rowIndex,
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
}

function requirementTypeCallback(dataRows,rowIndex){
    if("undefined"!=typeof(dataRows) && dataRows.length > 0){
        var itemRow = itemGrid.row(rowIndex);
        //选择行的需求类型为空,则先给选择行选择需求类型再复制新增
        if("undefined"==typeof(itemRow.requirementTypeCode) || ""==itemRow.requirementTypeCode){
            itemRow["requirementTypeCode"] = dataRows[0].requirementTypeCode;
            itemRow["requirementTypeName"] = dataRows[0].requirementTypeName;
            itemGrid.updateRow(itemRow,rowIndex);
            for(var i=1;i<dataRows.length;i++){
                var newRow = $.extend({},itemRow);
                newRow["requirementTypeCode"]=dataRows[i].requirementTypeCode;
                newRow["requirementTypeName"]=dataRows[i].requirementTypeName;
                itemGrid.addRow(newRow,rowIndex+i);
            }
        } else {//选择行不为空则直接往下复制新增
            for(var i=1;i<=dataRows.length;i++){
                var newRow = $.extend({},itemRow);
                newRow["requirementTypeCode"]=dataRows[i-1].requirementTypeCode;//i从1开始的,减一
                newRow["requirementTypeName"]=dataRows[i-1].requirementTypeName;//i从1开始的,减一
                itemGrid.addRow(newRow,rowIndex+i);
            }
        }
        
        itemGrid.load(itemGrid.rows());//重新加载一次数据行(新增指定行时mmGrid的已经渲染行的行数并不会自动更新,需重新加载更新)
    }
}

function selectMaterialNumber(item,rowIndex){
    //兼容ie 冒泡事件
    if (event && event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
    } else {
        window.event.returnValue = false;
    }
    parent.elsDeskTop.defineWin({
        'iconSrc':'icon/destop-icon/desktop_icon_93.gif',
        'windowsId':'materialCheck',
        'windowTitle':'<i18n:I18n key="" defaultValue="物料基础数据"/>',
        'windowSubTitle': companyShortName,
        'iframSrc':'${pageContext.request.contextPath}/materialmanage/materialCheck.jsp?frameAppId=detailsRequirementsPlanning&rowIndex='+rowIndex,
        'showAdv': false,
        'windowStatus': 'regular',
        'windowMinWidth': 1024,
        'windowMinHeight': 580,
        'windowPositionTop':14,
        'windowWidth':1024,
        'windowHeight':580,
        'parentPanel':".currDesktop"
    });
}

function materialCallback(dataRows,rowIndex){
    if("undefined"!=typeof(dataRows) && dataRows.length > 0){
        var itemRow = itemGrid.row(rowIndex);
        //选择行的需求类型为空,则先给选择行选择需求类型再复制新增
        if("undefined"==typeof(itemRow.materialNumber) || ""==itemRow.materialNumber){
            itemRow["materialNumber"] = dataRows[0].materialNumber;
            itemRow["materialName"] = dataRows[0].materialName;
            itemRow["unitOfMeasurement"] = dataRows[0].purchaseUnit;
            itemGrid.updateRow(itemRow,rowIndex);
            for(var i=1;i<dataRows.length;i++){
                var newRow = $.extend({},itemRow);
                newRow["materialNumber"]=dataRows[i].materialNumber;
                newRow["materialName"]=dataRows[i].materialName;
                newRow["unitOfMeasurement"]=dataRows[i].purchaseUnit;
                itemGrid.addRow(newRow,rowIndex+i);
            }
        } else {//选择行不为空则直接往下复制新增
            for(var i=1;i<=dataRows.length;i++){
                var newRow = $.extend({},itemRow);
                newRow["materialNumber"]=dataRows[i-1].materialNumber;//i从1开始的,减一
                newRow["materialName"]=dataRows[i-1].materialName;//i从1开始的,减一
                newRow["unitOfMeasurement"]=dataRows[i-1].purchaseUnit;//i从1开始的,减一
                itemGrid.addRow(newRow,rowIndex+i);
            }
        }
        
        itemGrid.load(itemGrid.rows());//重新加载一次数据行(新增指定行时mmGrid的已经渲染行的行数并不会自动更新,需重新加载更新)
    }
}

$("#addFileBtnOK").click(function(){
    $("#addFileDialog").hide();
    var filePath = $("#filePath").val();
    if(filePath == ""){
        alert("<i18n:I18n defaultValue='请选择上传文件！' key='i18n_please_select_a_file_to_upload'/>",1);
        return false;
    }
    var fileName = $("#fileName").val();
    var filePath = $("#filePath").val();
    
    var itemRow = itemGrid.row(uploadFileRowIndex);

    if("file"==uploadFileType){
        var fileList = itemRow.fileList;
        if("undefined"==typeof(fileList)){
            fileList = [];
        }
        fileList.push({requirementFileType: "file",requirementFileName:fileName,requirementFilePath:filePath});
        itemRow["fileList"]=fileList;
    } else if("image"==uploadFileType){
        var imageList = itemRow.imageList;
        if("undefined"==typeof(imageList)){
            imageList = [];
        }
        imageList.push({requirementFileType: "image",requirementFileName:fileName,requirementFilePath:filePath});
        itemRow["imageList"]=imageList;
    } else{}
    
    clearAddFileInfo();
});

//添加文件弹出框取消按钮
$("#addFileBtnCancel").click(function(){
    $("#addFileDialog").hide();
    clearAddFileInfo();
});

//关闭按钮处理
$("#dialogFileClose").click(function(){
    $("#addFileDialog").hide();
    clearAddFileInfo();
});

function uploadFile(){
    clearAddFileInfo();
    $("#addFileDialog").show();
    initFileUploader(fileUploader);
}

function downloadFile(type,rowIndex){
    var itemRow = itemGrid.row(rowIndex);
    if("file"==type){
        var fileList = itemRow.fileList;
        if("undefined"!=typeof(fileList) && fileList.length > 0){
            for(var i=0;i<fileList.length;i++){
                //window.location.href = "${pageContext.request.contextPath}/servlet/downloadServlet?filePath="+fileList[i].requirementFilePath;
                window.open("${pageContext.request.contextPath}/servlet/downloadServlet?filePath="+fileList[i].requirementFilePath);
            }
        }
    } else if("image"==type){
        var imageList = itemRow.imageList;
        if("undefined"!=typeof(imageList) && imageList.length > 0){
            for(var i=0;i<imageList.length;i++){
                window.open("${pageContext.request.contextPath}/servlet/downloadServlet?filePath="+imageList[i].requirementFilePath);
            }
        }
    } else{}
}

function clearAddFileInfo(){
    $("#fileName").val("");
    $("#filePath").val("");
    $("#fileType").val("");
}

function initFileUploader(fileUploader){
    //新增表单文件
    if (!fileUploader) {
          fileUploader = WebUploader.create({
              swf : "${pageContext.request.contextPath}/jsLib/webuploader/Uploader.swf",// swf文件路径
              auto : true,//是否选择文件后自动上传
              server : "${pageContext.request.contextPath}/servlet/UploadServlet",// 文件接收服务端。
              pick : "#btnFileUpload",//选择文件的按钮,可选.内部根据当前运行时创建,可能是input元素,也可能是flash/
              resize : false,// 不压缩image,默认如果是jpeg,文件上传前会压缩再上传.
              formData : {
                 elsAccount : elsAccount
            }
          });
      
         // 当有文件添加进来的时候
        fileUploader.on("fileQueued",function(file){
            var fileName = file.name;
            $("#fileName").val(fileName);
            $("#fileType").val(file.ext);
        });
         //上传到服务器响应后触发
        fileUploader.on("uploadAccept", function( obj, response ) {
            var errorNumber = response.error;
            if(errorNumber == 0){
                var filePath = response.url;
                $("#filePath").val(filePath);
            } else {
                   var errorMessage = response.message;
                   alert(errorMessage,3);
            }
              });
        //上传出错时触发
        fileUploader.on( "uploadError", function( obj, reason  ) {
                     var errorMessage = response.message;
                      alert(reason,3); 
          });
    }
}
</script>
</body>
</html>