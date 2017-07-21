<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/elsHeader.jsp" %>
<%
    String businessElsAccount = request.getParameter("businessElsAccount");
    String standardNumber = request.getParameter("standardNumber");
    String stretegyCode = request.getParameter("stretegyCode");
    String flowCode = request.getParameter("flowCode");
    String auditType = request.getParameter("auditType");
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<script type="text/javascript">  var hasRight = false; </script>
<div class="pos-relative public-wrap">
    <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作"/></span>
        <div class="common-box-line">
            <div>
                <base:audit elsSubAccount="${elsSubAccount }" businessElsAccount="${param.businessElsAccount }"
                            businessId="${param.standardNumber }" elsAccount="${elsAccount }"
                            businessType="standardSupplier">
                    <button id="passBtn" class="todo button-wrap"><i18n:I18n
                            key="i18n_enquiry_select_enquirystatus_approvePass" defaultValue="审批通过"/></button>
                    <button id="noPassBtn" class="todo button-wrap"><i18n:I18n
                            key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝"/></button>
                    <script type="text/javascript">
                        hasRight = true;
                    </script>
                </base:audit>
                <button id="cancelBtn" class="done button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批"/></button>
                <button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程"/></button>
                <button id="exitBtn" class="button-wrap"><i18n:I18n key="i18n_button_exit" defaultValue="退出"/></button>
            </div>
        </div>
    </div>

    <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_headerinformation" defaultValue="抬头信息"/></span>
        <div class="common-box-line">
            <div class="tab-wrap" id="sheet-head">
                <div id="sheet-item-one">
                    <main class="grid-container">
                        <div class="grid-100" id="headTable">
                            <table id="headTable"></table>
                            <div id="enquiryPage"
                                 style="text-align: right;display: inline-block;position: absolute;top: -49px;right: 19px;"></div>
                        </div>
                    </main>
                </div>
            </div>
        </div>
    </div>

    <div class="box-wrap pos-relative bg-common">
        <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
                key="i18n_requirementsPlanning_table_projectInformation" defaultValue="项目信息(表单文件)"/></span>
        <div class="common-box-line">
            <div class="tab-wrap" id="sheet-project">
                <div id="sheet-project-one">
                    <main class="grid-container nest-table">
                        <div class="grid-100" id="reCreate">
                            <table id="itemTable"></table>
                        </div>
                    </main>
                </div>
            </div>
        </div>
    </div>
</div>

    <!-- 对话框 -->
<div class="fixed-dialog" id="sendMsgDialog">
           <div class="dialog-tip bg-common" style="width: 420px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="<%=basePath%>/icon/destop-icon/desktop_icon_09.gif" />
                   <span class="dialogTitle"><i18n:I18n key="test" defaultValue="填写审批意见" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <textarea id="msgArea" style="width: 100%; box-sizing: border-box;margin: 0; display: block;resize: none; height: 150px;" maxlength="200"  onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0,200)" ></textarea>
	                       <div class="mt-20 text-center">
	                          <button id="sendMsgBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>

<script>
    var headTable;
    var itemTable;
    var type = "";
    var roleCode = "";
    var companyName = "<%=session.getAttribute("companyShortName")%>";
    var rowIndexSelect = 0;
    var excelUploader;
    var auditType = "<%=auditType%>";
    var elsAccount = "<%=businessElsAccount%>";
    var standardNumber = "<%=standardNumber%>";
    var strs = new Array();
    strs = standardNumber.split(",");
    $("#standardNumber").val(strs[1]);
    standardNumber = strs[1];
    //初始化加载信息
    $(document).ready(function () {
        //initExcelUploader();
    });
	// 渲染   @author jiangzhidong 20160120  begin 
	//只允许数字输入框
	var initInputNumber = function(val, item, index){
		debugger;
		if(val===null) { val = '';}
		//评分类型为合格/不合格
		if(item.scoreType == "2"){
			var val0 ='';
			var val100 ='';
			if(val==0) val0='selected';
			if(val==100) val100='selected';
			var selected = '<select name="'+this.name+'" id="'+this.name+'_'+index+'"  style="min-width:80px; padding:5px;">'
					+'<option value="100"'+val100+'><i18n:I18n key="test" defaultValue="合格" /></option>'
					+'<option value="0"'+val0+'><i18n:I18n key="test" defaultValue="不合格" /></option></select>'
			return selected;
		}else{//评分类型为记分制
			return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
		}
	};
    //允许任何字符输入框
    var initInputAny = function (val, item, index) {
        if (!val) {
            val = '';
        }
        return '<input type="text" name="' + this.name + '" id="' + this.name + '_' + index + '" value="' + val + '"/>';
    };
    //允许任何字符输入框 只读
    var initInputAny2 = function (val, item, index) {
        if (!val) {
            val = '';
        }
        return '<input type="text" readonly="readonly" name="' + this.name + '" id="' + this.name + '_' + index + '" value="' + val + '"/>';
    };
    //企业名称
    var initCompanyName = function (val, item, index) {
        if (!val) {
            val = '';
        }
        var name = this.name;
        var value = this.value;
        return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index + ')" name="' + name + '" id="' + name + '_' + index + '" value="' + val + '"/>';
    }
    //日期input
    var formatDateInput = function (val, item, index) {
        if (!val) {
            val = "";
        }
        if (val != "" && val.length != 10) {
            val = new Date(val).format("yyyy-MM-dd");
        }
        return '<input name="' + this.name + '" id="' + this.name + '_' + index + '" value="' + val + '"/>';
    };
    //日期
    var formatDate = function (val, item, index) {
        if (!val) {
            val = "";
        }
        if (val != "" && val.length != 10) {
            val = new Date(val).format("yyyy-MM-dd");
        }
        return val;
    };
    //时间
    var formatDateTime = function (val, item, index) {
        if (!val) {
            val = "";
        }
        return new Date(val).format("yyyy-MM-dd hh:mm:ss");
    };
    //时间input
    var formatDateTimeInput = function (val, item, index) {
        if (!val) {
            val = "";
        }
        if (val != "" && val.length != 10) {
            val = new Date(val).format("yyyy-MM-dd hh:mm:ss");
        }
        return '<input name="' + this.name + '" id="' + this.name + '_' + index + '" value="' + val + '"/>';
    };
    //档案管理
    var initTemplatePath = function (val, item, index) {
        return '<span class="templatePath" style="color:blue;"><i18n:I18n key="i18n_label_fileManagement" defaultValue="档案管理" /></span><span style="display: none;">' + JSON.stringify(item) + '</span>';
    };
    //审批方式 select
    var initAuditModeSelect = function (val, item, index) {
        var selected = '<select name  = "selected" id="selected"  style="color:blue; min-width:70px; padding:5px;">'
                + '<option value = "审批流"><i18n:I18n key="i18n_title_auditflow" defaultValue="审批流" /></option>'
                + '<option value = "自动"><i18n:I18n   key="i18n_title_autoaudit" defaultValue="自动" /></option>'
                + '<option value = "人工"><i18n:I18n   key="i18n_title_artificialaudit" defaultValue="人工" /></option></select>'
        return selected;
    };
    //审批方式
    var initAuditMode = function (val, item, index) {
        //审批方式  1-审批流 2-自动 3-人工
        if (val == "1" || val == null) return '<i18n:I18n key="i18n_title_auditflow" defaultValue="审批流" />';
        else if (val == "2")           return '<i18n:I18n key="i18n_title_autoaudit" defaultValue="自动" />';
        else if (val == "3")           return '<i18n:I18n key="i18n_title_artificialaudit" defaultValue="人工" />';
    };
    //总评分  人工
    var initTotalScore = function (val, item, index) {
        if (!val) {
            val = "";
        }
        return '<div style="color: red;">' + val + '</div>';
    };
    //发送状态
    var initSendStatus = function (val, item, index) {
        //0:未发送 1:已发送
        if (val == "0")      return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
        else if (val == "1") return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送" />';
    };
    //单据状态
    var initStandardStatus = function (val, item, index) {
        //0:新建 1:销售方填写中 2:采购方评估中 3:待审批中 4:审批中
        if (val == "0")      return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_create" defaultValue="新建" />';
        else if (val == "1") return '<i18n:I18n key="i18n_common_fillIn" defaultValue="填写中" />';
        else if (val == "2") return '<i18n:I18n key="i18n_common_inEvaluation" defaultValue="评估中" />';
        else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
    };
    //审批状态
    var initAuditStatus = function (val, item, index) {
        //0:审批通过  1:未审批  2:审批中  3:审批拒绝
        if (val == "0")      return '<i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" />';
        else if (val == "1") return '<i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" />';
        else if (val == "2") return '<i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" />';
        else if (val == "3") return '<i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" />';
    };
    //审批状态 select
    var initAuditStatusSelect = function (val, item, index) {
        if (!val) {
            val = "";
        }
        if (item.auditMode == 1) {
            var selected = '<select name="selected" id="selected" style="color:blue; min-width:70px;">'
                    + '<option value="0"><i18n:I18n key="i18n_enquiry_select_auditStatus_pass" defaultValue="审批通过" /></option>'
                    + '<option value="1" selected="selected"><i18n:I18n key="i18n_select_auditStatus_notapproved" defaultValue="未审批" /></option>'
                    + '<option value="2"><i18n:I18n key="i18n_enquiry_select_enquirystatus_approveproceed" defaultValue="审批中" /></option>'
                    + '<option value="3"><i18n:I18n key="i18n_enquiry_select_auditStatus_notpass" defaultValue="审批拒绝" /></option></select>'
            return selected;
        }
        return initAuditStatus(val, item, index);
    };
    //供应商els帐号
    var initToElsAccount = function (val, item, index) {
        return '<span class="elsAccountBtn" style="color:blue;">' + val + '</span><span style="display: none;">' + JSON.stringify(item) + '</span>'
    };
    //供应商分类   0-供应商  1-潜在供应商  2-陌生供应商  3-失效供应商
    var initGroupName = function (val, item, index) {
        if (val == "0") return '<i18n:I18n key="test" defaultValue="供应商" />'
        else if (val == "1") return '<i18n:I18n key="test" defaultValue="潜在供应商" />'
        else if (val == "2") return '<i18n:I18n key="test" defaultValue="陌生供应商" />'
        else if (val == "3") return '<i18n:I18n key="test" defaultValue="失效供应商" />'
    };
    // 渲染   @author jiangzhidong 20160120  end
    //重新加载
    var query = function () {
        headTable.load({});
    };

    //添加企业名称
    var addEnterpriseName = function (val, index) {
        var selectRows = val;
        if (val.length >= 6)
            autoGetEnterpriseName(selectRows, index);
    };
    
	//评分账户
	var initScoreAccount = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="templateList[]['+this.name+']" id="'+this.name+'_'+index+'" value="'+val+'"  style="width:200px;padding-right:20px;" readonly="readonly" onkeyup="value=value.replace(/[^(\d,)]/g,"")"/>'//+
// 		'<img class="scoreAccount dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 2px;cursor: pointer;" id='+index+' title="<i18n:I18n key="" defaultValue="查找帐号" />" />';
		
	};
    
  //模板条例明细 
	var initModelRegulation  = function (val,item,index){
		return '<span class="regulationDetailBtn" style="color:blue;">'+val+'</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	
	//查看准入条例
	var ModelRegulationCheck  = function (val,item,index){
		return '<span class="regulationCheckBtn" style="color:blue;">供应商条例选项</span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	};
	
	//评分类型   1-百分比   2-合格/不合格
	var initScoreType = function(val,item,index) {
		if (val == "1") return '<i18n:I18n key="test" defaultValue="百分比" />';
		else if (val == "2") return '<i18n:I18n key="test" defaultValue="合格/不合格" />';
	};
	
	//行信息有效期
	var initFBK14 = function(val, item, index){
		if(!val) { val = '未输入';}
		if(item.fbk14 != "" && item.fbk14 != null){
			var date = new Date().format("yyyy-MM-dd");
			if(date.localeCompare(item.fbk14) > 0){
				return '已过期';
			}else{
				return item.fbk14;
			}
		}else{
			return '未输入';
		}
	};
	
	//参与对象
	var initParticipants = function(val,item,index) {
		if (val == "sale") return '<i18n:I18n key="test" defaultValue="销售方" />';
		else if (val == "purchese") return '<i18n:I18n key="test" defaultValue="采购方" />';
	};
    
  //准入类型  1:新增准入 2:变更准入 3:公开招投标准入 4:新增准入模板 5:变更准入 模板
	var initStandardType = function (val,item,index){
		if (val == "1") return '<i18n:I18n defaultValue='新增准入' key='test'/>'   ;
		else if (val == "2") return '<i18n:I18n defaultValue='变更准入' key='test'/>'   ;
		else if (val == "3") return '<i18n:I18n defaultValue='公开招标准入' key='i18n_common_title_Opentenderaccess'/>' ;
		else if (val == "4") return '<i18n:I18n defaultValue='变更准入模板' key='test'/>'   ;
		else if (val == "5") return '<i18n:I18n defaultValue='变更准入模板' key='test'/>'   ;
  };
    var colst_head = [{
        title: '<i18n:I18n key="i18n_common_title_standardNumber" defaultValue="准入评估单号" />',
        name: 'standardNumber',
        width: 120,
        align: 'center'
    },
        {
            title: '<i18n:I18n key="i18n_common_title_businesstype" defaultValue="单据类型" />',
            name: 'standardType',
            width: 100,
            align: 'center',
            renderer:initStandardType
        },
        {
            title: '<i18n:I18n key="i18n_common_title_projectDesc" defaultValue="单据描述" />',
            name: 'standardDesc',
            width: 100,
            align: 'center'
        },
        {
            title: '<i18n:I18n key="i18n_common_title_applyDate" defaultValue="申请日期" />',
            name: 'applyDate',
            width: 150,
            align: 'center',
            renderer: formatDate
        },
        {
            title: '<i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />',
            name: 'person',
            width: 100,
            align: 'center'
        },
        {
            title: '<i18n:I18n key="i18n_enquiry_label_toElsAccount" defaultValue="供应商els帐号" />',
            clickDisable: true,
            name: 'toElsAccount',
            width: 90,
            align: 'center',
            renderer: initToElsAccount
        },
        {
            title: '<i18n:I18n key="i18n_common_title_supplieelsDesc" defaultValue="供应商els名称" />',
            name: 'supplierElsDesc',
            width: 140,
            align: 'center'
        },
//         {
//             title: '<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态" />',
//             name: 'sendStatus',
//             width: 60,
//             align: 'center',
//             renderer: initSendStatus
//         },
        {
            title: '<i18n:I18n key="i18n_lable_deliverystatus" defaultValue="单据状态" />',
            name: 'standardStatus',
            width: 60,
            align: 'center',
            renderer: initStandardStatus
        },
        {
            title: '<i18n:I18n key="i18n_common_auditmode" defaultValue="审批方式" />',
            name: 'auditMode',
            width: 70,
            align: 'center',
            clickDisable: true,
            renderer: initAuditMode
        },
        {
            title: '<i18n:I18n key="i18n_common_auditstatus" defaultValue="审批状态" />',
            clickDisable: true,
            name: 'auditStatus',
            width: 75,
            align: 'center',
            renderer: initAuditStatus
        },
        {title: '<i18n:I18n key="test" defaultValue="采购组" />', name: 'purchaseGroup', width: 100, align: 'center'},
        {
            title: '<i18n:I18n key="test" defaultValue="供应商分类" />',
            name: 'groupName',
            width: 100,
            align: 'center',
            renderer: initGroupName
        },
        {title: '<i18n:I18n key="test" defaultValue="ERP供应商编码" />', name: 'vender', width: 100, align: 'center'},
        {
            title: '<i18n:I18n key="i18n__supplierrassessreport_table_totalscore" defaultValue="总评分" />',
            name: 'totalScore',
            width: 100,
            align: 'center',
            renderer: initTotalScore
        },
        {
            title: '<i18n:I18n key="i18n_password_title_updateUser" defaultValue="更新用户" />',
            name: 'updateName',
            width: 100,
            align: 'center'
        }];

    var GobalparamStr = {"elsAccount": elsAccount, "standardNumber": standardNumber};
    var height = $(document).height() - 155;
    headTable = $('#headTable').mmGrid({
        cols: colst_head,
        url: '<%=basePath%>rest/SupplierStandardService/queryStandardSupplierHeadByCondtion',
        params: GobalparamStr,
        method: 'post',
        root: "rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol: true,
        multiSelect: true,
        height: 100,
        plugins: [$('#enquiryPage').mmPaginator({
            style: 'plain'
            ,
            totalCountName: 'total'
            ,
            page: 1
            ,
            pageParamName: 'currentPage'
            ,
            limitParamName: 'pageSize'
            ,
            limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
            ,
            totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
            ,
            limit: null
            ,
            limitList: [100, 50, 30 , 10]
        })]
    });

    headTable.on('cellSelected', function (e, item, rowIndex, colIndex) {
        rowIndexSelect = rowIndex;
        loadItem();
    });

    headTable.on('loadSuccess', function (e, data) {
        if (data.total > 0) {
            headTable.select(rowIndexSelect);
            loadItem();
        }
    });
  //模板条例  查看
	$('.regulationDetailBtn').live("click", function() {
		var editCol = $(this).next().text();
		var headRows = JSON.parse(editCol);
		var url='<%=basePath%>regulation/regulationDetail.jsp?elsAccount='+elsAccount
				+ "&regulationNumber=" +  headRows.regulationNumber;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
			'windowsId':'regulationDetail',
			'windowTitle':'<i18n:I18n defaultValue="条例信息" key="test"></i18n:I18n>',
			'iframSrc':url,
			windowStatus: 'regular',
			windowMinWidth: 900,
			windowMinHeight: 500,
			'windowWidth':900,
			'windowHeight':500,
			windowPositionTop:40,
			'parentPanel':".currDesktop"
		});
	});
    
  //供应商条例选项 (查看供应的准入条例资料)
	$('.regulationCheckBtn').live("click", function() {
		var editCol = $(this).next().text();
		var headRows = JSON.parse(editCol);
		var url='<%=basePath%>regulation/regulationCheck.jsp?elsAccount='+elsAccount
				+ "&regulationNumber=" +  headRows.regulationNumber
				+ "&standardNumber=" + headRows.standardNumber
				+  "&standardItemNumber=" + headRows.standardItemNumber;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_91.gif',
			'windowsId':'regulationInfo',
			'windowTitle':'<i18n:I18n defaultValue="条例信息" key="test"></i18n:I18n>',
			'iframSrc':url,
			windowStatus: 'regular',
			windowMinWidth: 700,
			windowMinHeight: 300,
			'windowWidth':700,
			'windowHeight':300,
			windowPositionTop:40,
			'parentPanel':".currDesktop"
		});
	});

    //项目信息(表单文件)----------------------------------------------------------------------------------------
  	var cols_item =  <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="purchase_supply_item_mt"/>;
    
//  	 var cols_item = [
// 		{ title:'<i18n:I18n key="i18n_common_title_headerinformation" defaultValue="抬头信息" />', name:'standardNumber', width: 120, align: 'center'},
//  		{ title:'<i18n:I18n key="i18n_common_title_standardItemNumber" defaultValue="准入单行号" />', name:'standardItemNumber', width: 120, align: 'center'},
//  		{ title:'<i18n:I18n key="i18n_label_templateCode" defaultValue="模板编号" />', name:'templateNumber', width: 130, align: 'center'},
//  		{ title:'<i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />', name:'templateName', width: 150, align: 'center'},
//  		{ title:'<i18n:I18n key="i18n_common_title_templatedesc" defaultValue="模板描述" />', name:'templateDesc', width: 120, align: 'center'},
//  		{ title:'<i18n:I18n key="test" defaultValue="条例编号" />', name:'regulationNumber', width: 150, align: 'center', renderer: initModelRegulation},
//  		{ title:'<i18n:I18n key="test" defaultValue="条例名称" />', name:'regulationName', width: 150, align: 'center'},
//  		{ title:'<i18n:I18n key="test" defaultValue="条例明细" />', name:'regulationDetail', width: 150, align: 'center'},
//  		{ title:'<i18n:I18n key="i18n_common_title_participants" defaultValue="参与对象" />', name:'participants' ,width:70, align:'center',renderer: initParticipants},
//  		{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreType" defaultValue="评分类型" />', name:'scoreType', width: 130, align: 'center' ,renderer: initScoreType},
//       	{ title:'评分账户', name:'scoreAccount' ,width:200, align:'center'},
//  		{ title:'<i18n:I18n key="i18n_assesstemplate_table_weight" defaultValue="权重%" />', name:'weight' ,width:100, align:'center'},
//  		{ title:'<i18n:I18n key="test" defaultValue="查看条例" />', name:'score' ,width:100, align:'center',renderer:ModelRegulationCheck},
//  		{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_score" defaultValue="评分结果" />', name:'score' ,width:100, align:'center', renderer: initInputNumber},
//  		{ title:'<i18n:I18n key="i18n__supplierrassessreport_table_scoreStandard" defaultValue="评分标准说明" />', name:'scoreStandard', width: 120, align: 'center'}
//  		{ title:'<i18n:I18n key="i18n_label_logtime" defaultValue="时间戳" />', name:'logtime' ,width:150, align:'center', renderer: formatDateTime}
//  		];
 

    itemTable = $('#itemTable').mmGrid({
        cols: cols_item,
        height: 300,
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        checkCol: true,
//         multiSelect: true
    });

    //加载行
    var loadItem = function () {
        var obj = headTable.selectedRows();
        if (obj.length <= 0) {
            return;
        }
        debugger;
        var head = obj[0];
        head.fbk40 = "@audit@";
        $.ajax({
            url: '<%=basePath%>rest/SupplierStandardService/queryStandardSupplierItemByCondtion' + "?t=" + new Date().getTime(),
            type: 'POST',
            contentType: "application/json",
            data: JSON.stringify(head),
            dataType: "json",
            success: function (data) {
                itemTable.load(data.rows);
            },
            error: function (data) {
                if (!permissionError(data)) {
                    alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />', 3);
                }
            }
        });
    }

    if (hasRight) {
        $("#itemPassBtn").show();
        $("#itemNoPassBtn").show();
        $("#itemPassBtn").click(function () {
            itemPass();
        });
        $("#itemNoPassBtn").click(function () {
            itemNoPass();
        });
    }

    if (auditType == "todo") {
        $(".todo").show();
        $(".done").hide();
    } else {
        $(".todo").hide();
        $(".done").show();
    }
   
    $("#exitBtn").click(function () {
        parent.elsDeskTop.closeCurWin('auditRecord', closeCallback());
    });

    //查看流程
	$("#flowBtn").click(function(){
		var headRows      = headTable.selectedRows();
		var headRowsIndex = headTable.selectedRowsIndex();
		if(headRows.length != 1){
			alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />',2);
			return;
		}
		if(headRows[0].auditMode != "1"){
			alert('<i18n:I18n key="test" defaultValue="非审批流程方式，不能查看!" />',2);
			return;
		}
		if(headRows[0].auditStatus != "2"&&headRows[0].auditStatus != "0"&&headRows[0].auditStatus != "3"){
			alert('<i18n:I18n key="test" defaultValue="未提交审批，不能查看!" />',2);
			return;
		}
		var businessId = headRows[0].toElsAccount + "," + headRows[0].standardNumber ;
		parent.elsDeskTop.defineWin({
			'iconSrc'       : 'icon/els-icon.png' ,
			'windowsId'     : 'auditFlowList'     ,
			'windowTitle'   : '<i18n:I18n key="i18n_common_viewflow"    defaultValue="查看流程" />',
			windowSubTitle : ""                  ,
			'iframSrc'      : '<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=standardSupplier&businessId='+ businessId,
			showAdv        : true                ,
			advArr         : ['icon/test-car.png','icon/test-car2.png'] ,
			windowMinWidth : 480 ,
			windowMinHeight: 600 ,
			'windowWidth'   : 680 ,
			'windowHeight'  : 600 ,
			'parentPanel'   : ".currDesktop"
		});
	});

	//显示当前待审批节点 @author jiangzhidong @date 20160524  begin
	$('.flowBtn').live("click", function() {
		debugger;
	    var scanCol = $(this).next().text();
	    var head = JSON.parse(scanCol);
		var targetElsAccount = head.elsAccount;
		var businessType = "standardSupplier";
		var businessId = head.toElsAccount+","+head.standardNumber;
		parent.elsDeskTop.defineWin({
	        'iconSrc':'icon/els-icon.png',
	        'windowsId':'auditFlowList',
	        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
	        windowSubTitle: "",
	        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + targetElsAccount + '&businessType='+businessType + '&businessId='+businessId,
	        windowMinWidth: 480,
	        windowMinHeight: 600,
	        'windowWidth':680,
	        'windowHeight':600,
	        'parentPanel':".currDesktop"
	    });
	});
	//显示当前待审批节点 @author jiangzhidong @date 20160524  end
	
	//审批通过
	$("#passBtn").click(function () {
		 var headRows = headTable.selectedRows();
		 if (headRows.length != 1) {
	          alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />', 2);
	          return;
	     }
		 for(var i= 0; i<=headRows.length-1; i++) {
			 headRows[i].auditStatus = 0;
		}
		 parent.elsDeskTop.tip.init({type: 'confirm',message: '<i18n:I18n key="i18n_common_confirm_auditpass" defaultValue="确认要审批通过吗？" />',closeEvent: function () {
			 $("body").data("headRowsJson",headRows); 
			 $("#sendMsgDialog").show();  
         }});
    });
	
	//审批拒绝
	$("#noPassBtn").click(function () {
		 var headRows = headTable.selectedRows();
		 if (headRows.length != 1) {
	          alert('<i18n:I18n key="i18n_common_title_pleaseSelectRecord" defaultValue="请选择一条记录!" />', 2);
	          return;
	     }
		 for(var i= 0; i<=headRows.length-1; i++) {
			 headRows[i].auditStatus = 3;
		}
		 parent.elsDeskTop.tip.init({type: 'confirm',message: '<i18n:I18n key="i18n_common_confirm_auditrefuse" defaultValue="确认要审批拒绝吗？" />',closeEvent: function () {
			 $("body").data("headRowsJson",headRows); 
			 $("#sendMsgDialog").show();  
         }});
	 });
	
   //更新头
   $("#sendMsgBtnOK").click(function() {
        var headRows = $("body").data("headRowsJson")
		for(var i= 0; i<=headRows.length-1; i++) {
			headRows[i].remark = $("#msgArea").val();
		}
        parent.elsDeskTop.showLoading();
        $.ajax({
            url: "<%=basePath%>rest/SupplierStandardService/sendStandardSupplierAuditStatus",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify(headRows[0]),
            dataType: "json",
            success: function (data) {
                parent.elsDeskTop.hideLoading();
                alert(data.message,1);
                query();
                parent.elsDeskTop.closeCurWin('auditRecord', closeCallback());
            },
            error: function (data) {
                parent.elsDeskTop.hideLoading();
                if (!permissionError(data)) {
    				alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
    			}
            }
        });
	});
	
	
   //关闭
   $("#dialogFileClose").click(function(){
   	 $("#sendMsgDialog").hide();
   	 reset();
   });

   //重新加载
   var reset = function() {
   	 $("#msgArea").val('');
   }
   var resetYes = function() {
   	 $("#msgArea").val('同意\n');
   }
   var resetNo = function() {
   	 $("#msgArea").val('拒绝\n');
   }

	//审批撤消
	 $("#cancelBtn").click(function () {
		 parent.elsDeskTop.tip.init({
	            type: 'confirm',
	            message: '<i18n:I18n key="i18n_common_confirm_auditcancel" defaultValue="确认要撤销审批吗？" />',
	            closeEvent: function () {
	                parent.elsDeskTop.showLoading();
	                $.ajax({
	                    url: "<%=basePath%>rest/SupplierStandardService/cancelAudit",
	                    type: "post",
	                    contentType: "application/json",
	                    data: JSON.stringify(headRows[0]),
	                    dataType: "json",
	                    success: function (data) {
	                        parent.elsDeskTop.hideLoading();
	                        alert("<i18n:I18n key="i18n_common_alert_successfulOperation" defaultValue="操作成功" />");
	                        parent.elsDeskTop.closeCurWin('auditRecord', closeCallback());
	                    },
	                    error: function (data) {
	                        parent.elsDeskTop.hideLoading();
	                        if (data.status == "401") {
	                            alert("<i18n:I18n key="i18n_audit_overcantcancel" defaultValue="流程结束的单据不能撤销审批" />", 3);
	                        } else if (data.status == "403") {
	                            alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />", 3);
	                        } else {
	                            if (!permissionError(data)) {
	                                alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />', 3);
	                            }
	                        }
	                    }
	                });
	            }
	        });
	 });

    function closeCallback() {
        if (parent.frames["iframeApp_auditList"]) {
            parent.frames["iframeApp_auditList"].query();
        }
    }
</script>
</body>
</html>