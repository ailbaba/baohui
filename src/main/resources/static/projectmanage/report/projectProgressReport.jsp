<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style>
.show-management .arrow-down {
	display: block;
	float: left;
	margin-top: 7px;
	cursor: pointer;
}

.show-management .arrow-right {
	display: block;
	float: left;
	margin-top: 3px;
	cursor: pointer;
}

.treeSel {
	margin-right: 5px !important;
}

.tree-leval a.active {
	font-weight: 800;
	text-decoration: underline;
	color: #FF5722;
}

.left-box {
	width: 300px;
	float: left;
	padding: 8px;
	height: 100%;
}

.left-box .tree-leval {
	border: 1px solid #ddd;
	background: none;
	margin-top: 5px;
	right: auto;
	overflow: auto;
	padding: 10px 5px;
	font-size: 13px;
	position: absolute;
	left: 8px;
	width: 288px;
	top: 5px;
	bottom: 30px;
}
</style>
<body>
	<div class="pos-relative show-management left-box">
		<div class="tree-leval"></div>
	</div>
	<div class="pos-relative public-wrap right-box">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button class="button-wrap" id="queryBtn">
					<i18n:I18n key="i18n_common_button_query" defaultValue="查询" />
				</button>
				<button class="button-wrap" id="addBtn">
					<i18n:I18n key="i18n_button_add" defaultValue="新增" />
				</button>
				<button class="button-wrap" id="copyAddBtn">
					<i18n:I18n key="i18n_button_copyAdd" defaultValue="复制新增" />
				</button>
				<button class="button-wrap" id="updBtn">
					<i18n:I18n key="i18n_button_update" defaultValue="修改" />
				</button>
				<button class="button-wrap" id="delBtn">
					<i18n:I18n key="i18n_button_delete" defaultValue="删除" />
				</button>
				<base:auditConfig elsAccount="${elsAccount }" businessType="project">
					<%-- 				<button id="entryBtn" class="button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批" /></button> --%>
					<button id="cancelEntryBtn" class="button-wrap">
						<i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" />
					</button>
					<button id="flowBtn" class="button-wrap">
						<i18n:I18n key="i18n_approval_flow" defaultValue="流程" />
					</button>
				</base:auditConfig>
				<button id="btnAuditConfig" class="button-wrap">
					<i18n:I18n key="xxx" defaultValue="创建审批" />
				</button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectNumber"
							defaultValue="项目编号" />:</span> <input type="text" id="projectNumber"
						name="projectNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectDesc"
							defaultValue="项目描述" />:</span> <input type="text" id="projectDesc"
						name="projectDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectLeader"
							defaultValue="项目负责人" />:</span> <input type="text" id="projectLeader"
						name="projectLeader" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectStatus"
							defaultValue="项目状态" />:</span> <select id="projectStatus"
						name="projectStatus">
						<option value="">请选择</option>
						<option value="0">新建</option>
						<option value="1">进行中</option>
						<option value="2">完成</option>
						<option value="3">关闭</option>
					</select>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectCreateDate"
							defaultValue="项目创建日期" />:</span> <input type="radio" name="dateArea"
						value="lastMonth" checked="checked">
					<i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
					<input type="radio" name="dateArea" value="lastThreeMonth">
					<i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
					<input type="radio" name="dateArea" value="defineDateArea">
					<i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
				</div>
				<div class="dis-in-b input-and-tip" style="display: none;">
					<input type="text" class="Wdate" onfocus="WdatePicker()"
						id="startCreateDate" name="startCreateDate" />
				</div>
				<div class="dis-in-b input-and-tip" style="display: none;">
					<span><i18n:I18n key="i18n_enquiry_label_enquirydateend"
							defaultValue="到" /></span> <input type="text" class="Wdate"
						onfocus="WdatePicker()" id="endCreateDate" name="endCreateDate" />
				</div>
			</div>
		</div>
		
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					defaultValue="物料属性条件"
					key="i18n_materialList_title_materialAttributeCondition" /></span>
			<div class="common-box-line" id="attrSelectDiv">
				<div class="dis-in-b input-and-tip" style="margin:5px;">
					<select name="attr">
					    <option value="0"></option>
						<option value="brand">品牌</option>
						<option value="color">颜色</option>
					</select>
					<input type="text" name="attr" />
				</div>
				<button id="addAttrCondBtn" class="button-wrap">+</button>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_projectManage_title_projectHead" defaultValue="项目管理头" /></span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100" id="headDiv">
					<table id="headTable"></table>
					<div id="headPage" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
					key="i18n_projectManage_title_projectDetail" defaultValue="项目管理明细" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
					<ul>
						<li><a href="#sheet-project-one"><i18n:I18n
									key="i18n_projectManage_title_projectItem" defaultValue="项目管理行" /></a></li>
					</ul>
					<div id="sheet-project-one">
						<main class="grid-container">
							<div class="grid-100" id="itemDiv">
								<table id="itemTable"></table>
							</div>
						</main>
					</div>

				</div>
			</div>
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

		<div class="fixed-dialog" id="projectEditForm">
			<div class="dialog-tip bg-common"
				style="width: 502px; height: 340px; margin-left: -251px; margin-top: -190px;">
				<div class="dialog-close-btn" id="btnAddClose"></div>
				<div class="tip-head">
					<img class="icon"
						src="${pageContext.request.contextPath}/icon/els.PNG" /> <span
						class="dialogTitle"><i18n:I18n defaultValue="新增项目" key="" /></span>
				</div>
				<div class="box-wrap pos-relative bg-common">
					<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n
							defaultValue="项目信息" key="" /></span>
					<div class="common-box-line">
						<table>
							<tr class="line-height-tr">
								<td><i18n:I18n defaultValue="项目编号" key="" />:</td>
								<td><input type="text" id="projectNumber1" /></td>
							</tr>
							<tr class="line-height-tr">
								<td><i18n:I18n defaultValue="项目描述" key="" />:</td>
								<td><input type="text" id="projectDesc1" /></td>
							</tr>
							<tr class="line-height-tr">
								<td><i18n:I18n defaultValue="项目类型" key="" />:</td>
								<td><input type="text" id="projectType1" /></td>
							</tr>
							<tr class="line-height-tr">
								<td><i18n:I18n defaultValue="项目状态" key="" />:</td>
								<td><input type="text" id="projectStatus1" /></td>
							</tr>
							<tr class="line-height-tr">
								<td><i18n:I18n defaultValue="项目负责人" key="" />:</td>
								<td><input type="text" id="projectLeader1" /></td>
							</tr>
						</table>
					</div>
					<div class="mt-40 text-center">
						<button id="btnAddOK" class="button-wrap ">
							<i18n:I18n defaultValue="确定" key="i18n_common_button_ok" />
						</button>
						<button id="btnAddCancel" class="button-wrap tip-option-btn">
							<i18n:I18n defaultValue="取消" key="i18n_common_button_cancel" />
						</button>
					</div>
				</div>
			</div>
		</div>

	</div>

<script type="text/javascript">
	var elsAccount = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc = "${sessionScope.companyShortName}";
	var userName = "${sessionScope.username}";
	var btnPjAdd, btnPjEdit, btnPjDel,btnPjCancel;
	var activeTreeNode;// 当前点击的树节点
	var currentHeaderRecord;
	var cloneNode;

// 树数据适配器
var treeDataAdapter = function(d,isNew){
	if(isNew)d=[d];
	var tree,root,all,wait;
	var getSubTree = function(n){
		return n.nextSibling;
	};
	var initArrow  =function(elm){
		[].forEach.call((elm||getSubTree(this)).children,function(c){
			c.n.resetArrow();
			c.n.resetChildArrow();
		});
		return elm||this;
	};
	var iNode = function(d){
		var subN = treeDataAdapter(d,true);
		var n = definedDom(subN);
		n.children[2].resetArrow();
		this.nextSibling.appendChild(n);
		if(this.resetArrow)this.resetArrow();
	};
	var nodeClick = function(){
		if(activeTreeNode){
			activeTreeNode.className = ''
		}
		activeTreeNode=this;
		activeTreeNode.className='active';
		//debugger;
		//headGrid.load(this._d);
		
		refreshData();
		
	};
	// 来页面自初始化
	if(!isNew){
		tree = {
			tag: 'div',
			resetChildArrow: function () {
				initArrow(this.children[2]);
				return this
			},
			children: [{
				tag: 'input',
				type: 'checkbox',
				class: 'treeSel',
				css: {display: 'none'}
			}, {tag: 'a', text: '所有项目',_d:{elsAccount:elsAccount},onclick:nodeClick,insertNode:iNode}, {tag: 'ul', children: []}]
		};
		root =tree.children[2].children;
		wait={};
		all={};
	}
	var ard = 'dis-in-b arrow-down';
	var arr = 'dis-in-b arrow-right';
	d.forEach(function(t){
		var arrow = definedDom('span',{
			class:arr,
			onclick:function(){
				if(this.className===arr)this.nextSibling.showChildren();
				else this.nextSibling.hideChildren();
			}
		});
		var k =  t.projectNumber;
		var p = t.parentId;
		var cb = definedDom({
			tag:'input',
			type:'checkbox',
			class:'treeSel',
			css:{display:'none'}
		});
		var node = definedDom({
			checkBox:cb,
			resetChildArrow:initArrow,
			resetArrow :function(){
				if(0===getSubTree(this).children.length)arrow.className ='';
				else if(''===arrow.className){
					arrow.className=arr
				}
			},
			tag:'a',
			text: t.projectDesc,
			arrow:arrow,
			_d:t,
			showChildren:function(){
				if(getSubTree(this).children.length){
					arrow.className = ard;
					getSubTree(this).style.display='';
				}
			},
			hideChildren:function(){
				if(getSubTree(this).children.length){
					arrow.className = arr;
					getSubTree(this).style.display='none';
				}
			},
			// 点击树的节点时候
			onclick:nodeClick,
			// 插入节点
			insertNode:iNode,
		});
		var _d = {tag:'li', n:node,children:[cb,arrow,node,{tag:'ul', css:{display:'none'},children:[]}]};
		if(isNew)return tree = _d; // 来自手动插入
		all[k] = _d;
		if(!t.level) {
			root.push(_d);
		}else {
			var f = all[p];
			if(f)f.children[3].children.push(_d);
			else {
				wait[p] = wait[p]||[];
				wait[p].push(_d);
			}
		}
		var w = wait[k];
		if(w){
			[].push.apply(_d.children[3].children,w);
			wait[k] = undefined;
		}
	});
	return tree;
};
// 初始化树
var initTree = function(){
	ajaxWorker(location.origin+'${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectStructure',{
		type: "post",
		contentType: "application/json",
		data: JSON.stringify({elsAccount:elsAccount}),
		dataType: "json"
	}).done(function(data){
		data = data||[];
		var root = document.querySelector('.tree-leval');
		root.appendChild(definedDom(treeDataAdapter(data)).resetChildArrow());
	}).fail(function(){

	})
};

var renderFormatDate = function(val,item,rowIndex){
	if("undefined"==typeof(val) || "" == val){
		return "";
	} else {
		return new Date(val).format("yyyy-MM-dd");
	}
};

var renderFormatStatus = function(val,item,rowIndex){
	if("0"==val){
		return "新建";
	} else if("1"==val){
		return "进行中";
	} else if("2"==val){
		return "完成";
	} else if("3"==val){
		return "关闭";
	} else {
		return "";
	}
};
var renderFormatApprove = function(val,item,rowIndex){
	if("0"==val){
		return "审批通过";
	} else if("1"==val){
		return "未审批";
	} else if("2"==val){
		return "审批中";
	} else if("3"==val){
		return "审批拒绝";
	} else {
		return "";
	}
};
var renderFormatMark = function(val,item,rowIndex){
	if("Y"==val){
		return "是";
	} else {
		return "否";
	}
};

var headCols = [
	{ title:"ELS企业号", name:"elsAccount", width:100, align:"center"},
	{ title:"企业名称", name:"elsDesc", width:100, align:"center"},
	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
	{ title:"项目描述", name:"projectDesc", width:100, align:"center"},
	{ title:"项目类型", name:"projectType", width:100, align:"center"},
	{ title:"项目阶段", name:"projectStatus" , width:100, align:"center"},
	{ title:"项目负责人", name:"projectLeader" , width:100, align:"center"},
	{ title:"预算金额", name:"budgetAmount" , width:100, align:"center"},
	{ title:"实际金额", name:"actualAmount" , width:100, align:"center"}
];

var headDatas = [
	{parentId:"[201600000003],[20160000000301],[2016000000030101]",elsAccount:"201555",elsDesc:"晶宫装饰",projectNumber:"201600000003010101",projectDesc:"主楼1#墙面主体（3A）",projectType:"内装",projectStatus:"启动",projectLeader:"程刚",budgetAmount:"6500000",actualAmount:""},
	{parentId:"[201600000003],[20160000000301],[2016000000030101]",elsAccount:"201555",elsDesc:"晶宫装饰",projectNumber:"201600000003010102",projectDesc:"主楼1#3-7层吊顶安装",projectType:"劳务",projectStatus:"启动",projectLeader:"程刚",budgetAmount:"1500000",actualAmount:""}
];
  	
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageHead",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : headCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : false,
	checkCol : true,
	indexCol : false,
	plugins : [
	    $("#headPage").mmPaginator({
	        style : "plain",
	        totalCountName : "total",
	        page : 1,
	        pageParamName : "currentPage",
	        limitParamName : "pageSize",
	        limitLabel : "<i18n:I18n defaultValue='每页{0}条' key='i18n_common_mmgrid_limitlabel'/>",
	        totalCountLabel : "<i18n:I18n defaultValue='共<span>{0}</span>条记录' key='i18n_common_mmgrid_totalcountlabel'/>",
	        limit : null,
	        limitList : [10,20]
	    })
	]
});

headGrid.on("loadSuccess",function(e, data){
	if(headGrid.rowsLength()>0){
		headGrid.select(0);//默认选中第一条数据
		loadItem(headGrid.selectedRows()[0]);
		loadContact(headGrid.selectedRows()[0]);
		loadFile(headGrid.selectedRows()[0]);
	} else {
		clearItemTable();
		clearContactTable();
		clearFileTable();
	}
});

headGrid.on("cellSelected",function(e, item, rowIndex, colIndex){
	loadItem(item);
	loadContact(item);
	loadFile(item);
});

var itemCols = [
	{ title:"方案/设计图纸", name:"designPlan", width:100, align:"center",clickDisable:true,renderer:function(val, item, rowIndex){
		return '<span class="uploadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	    +'&nbsp;&nbsp;<span class="downloadFile-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	}},
	{ title:"物料图片", name:"materialPicture", width:100, align:"center",clickDisable:true,renderer:function(val, item, rowIndex){
		return '<span class="previewImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_skin_preview" defaultValue="预览" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	    +'&nbsp;&nbsp;<span class="uploadImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_enquiry_label_upload" defaultValue="上传" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>'
	    +'&nbsp;&nbsp;<span class="downloadImage-item" style="color:blue;cursor:pointer;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></span><span style="display: none;">'+JSON.stringify(item)+'</span>';
	}},
	{ title:"需求类型", name:"demandType", width:100, align:"center"},
	{ title:"物料编码", name:"materialNumber", width:100, align:"center"},
	{ title:"物料名称", name:"materialName", width:100, align:"center"},
	{ title:"需求数量", name:"demandQuantity", width:100, align:"center"},
	{ title:"采购订单数量", name:"orderQuantity" , width:100, align:"center"},
	{ title:"到货数量", name:"arrivedQuantity" , width:100, align:"center"},
	{ title:"入库数量", name:"acceptedQuantity" , width:100, align:"center"},
	{ title:"退货数量", name:"returnedQuantity" , width:100, align:"center"},
	{ title:"单价", name:"unitPrice" , width:100, align:"center"},
	{ title:"应付总金额", name:"totalAmount" , width:100, align:"center"},
	{ title:"未付金额", name:"unpaidAmount" , width:100, align:"center"},
	{ title:"供应商ELS号", name:"supplierElsAccount" , width:100, align:"center"},
	{ title:"供应商名称", name:"supplierElsDesc" , width:100, align:"center"},
	{ title:"品牌", name:"brand" , width:100, align:"center"},
	{ title:"颜色", name:"color" , width:100, align:"center"}
];

var itemDatas = [
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"设计",materialNumber:"A-1000",materialName:"设计",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"300000",totalAmount:"300000",unpaidAmount:"300000",supplierElsAccount:"201551",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"制图",materialNumber:"A-2000",materialName:"制图",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"200000",totalAmount:"200000",unpaidAmount:"200000",supplierElsAccount:"201552",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"审计",materialNumber:"A-3000",materialName:"审计",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"350000",totalAmount:"350000",unpaidAmount:"350000",supplierElsAccount:"201552",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"找平",materialNumber:"DC_MC-001",materialName:"腻子",demandQuantity:"2000",orderQuantity:"2000",arrivedQuantity:"2100",acceptedQuantity:"2100",returnedQuantity:"0",unitPrice:"500",totalAmount:"1050000",unpaidAmount:"1050000",supplierElsAccount:"201553",supplierElsDesc:"",brand:"美巢",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"找平",materialNumber:"DC_MC-002",materialName:"网格",demandQuantity:"150",orderQuantity:"150",arrivedQuantity:"150",acceptedQuantity:"150",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201553",supplierElsDesc:"",brand:"美巢",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"找平",materialNumber:"DC_MC-003",materialName:"防水",demandQuantity:"150",orderQuantity:"150",arrivedQuantity:"150",acceptedQuantity:"150",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201553",supplierElsDesc:"",brand:"美巢",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"找平",materialNumber:"DC_MC-004",materialName:"石膏",demandQuantity:"600",orderQuantity:"600",arrivedQuantity:"300",acceptedQuantity:"300",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201553",supplierElsDesc:"",brand:"美巢",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"粉刷",materialNumber:"DC_LB-557",materialName:"油漆（1+2）",demandQuantity:"500",orderQuantity:"500",arrivedQuantity:"650",acceptedQuantity:"200",returnedQuantity:"450",unitPrice:"8000",totalAmount:"1600000",unpaidAmount:"1600000",supplierElsAccount:"201553",supplierElsDesc:"",brand:"立邦",color:"白"},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"背景装饰",materialNumber:"DC_BB-001",materialName:"背景墙",demandQuantity:"6000",orderQuantity:"0",arrivedQuantity:"0",acceptedQuantity:"0",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201553",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"背景装饰",materialNumber:"DC_BB-002",materialName:"木质图案",demandQuantity:"3000",orderQuantity:"0",arrivedQuantity:"0",acceptedQuantity:"0",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"背景装饰",materialNumber:"DC_BB-003",materialName:"大理石米黄",demandQuantity:"3000",orderQuantity:"0",arrivedQuantity:"0",acceptedQuantity:"0",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:"米黄"},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"石膏线美化",materialNumber:"DC_AD-001",materialName:"石膏（含施工）",demandQuantity:"200",orderQuantity:"0",arrivedQuantity:"0",acceptedQuantity:"0",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201554",supplierElsDesc:"",brand:"三棵树",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"踢脚包装",materialNumber:"DC_MM-001",materialName:"木质（复合防划）",demandQuantity:"1400",orderQuantity:"0",arrivedQuantity:"0",acceptedQuantity:"0",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"踢脚包装",materialNumber:"DC_MM-002",materialName:"大理石国产",demandQuantity:"6000",orderQuantity:"0",arrivedQuantity:"0",acceptedQuantity:"0",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010101",designPlan:"",materialPicture:"",demandType:"踢脚包装",materialNumber:"DC_MM-003",materialName:"大理石西班牙",demandQuantity:"3000",orderQuantity:"0",arrivedQuantity:"0",acceptedQuantity:"0",returnedQuantity:"0",unitPrice:"0",totalAmount:"0",unpaidAmount:"0",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010102",designPlan:"",materialPicture:"",demandType:"设计",materialNumber:"A-1000",materialName:"设计",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"500000",totalAmount:"500000",unpaidAmount:"500000",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010102",designPlan:"",materialPicture:"",demandType:"制图",materialNumber:"A-2000",materialName:"制图",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"200000",totalAmount:"200000",unpaidAmount:"200000",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010102",designPlan:"",materialPicture:"",demandType:"审计",materialNumber:"A-3000",materialName:"审计",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"100000",totalAmount:"100000",unpaidAmount:"100000",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010102",designPlan:"",materialPicture:"",demandType:"施工人工",materialNumber:"A-4000",materialName:"施工人工",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"450000",totalAmount:"450000",unpaidAmount:"450000",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010102",designPlan:"",materialPicture:"",demandType:"监理",materialNumber:"A-5000",materialName:"监理",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"100000",totalAmount:"100000",unpaidAmount:"100000",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""},
    {projectNumber:"201600000003010102",designPlan:"",materialPicture:"",demandType:"乙自备材料",materialNumber:"D-2000",materialName:"乙自备材料",demandQuantity:"1",orderQuantity:"1",arrivedQuantity:"1",acceptedQuantity:"1",returnedQuantity:"1",unitPrice:"500000",totalAmount:"500000",unpaidAmount:"500000",supplierElsAccount:"201554",supplierElsDesc:"",brand:"",color:""}

];
  	
var itemGrid = $("#itemTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageItem",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : itemCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : true,
	checkCol : true,
	indexCol : false,
});

var contactCols = [
	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
	{ title:"项目行编号", name:"projectItemNumber", width:100, align:"center"},
	{ title:"项目行描述", name:"projectItemDesc", width:100, align:"center"},
	{ title:"联系人职责", name:"contactDuty", width:100, align:"center"},
	{ title:"联系人岗位", name:"contactPosition" , width:100, align:"center"},
	{ title:"联系人姓名", name:"contactName" , width:100, align:"center"},
	{ title:"联系人姓名", name:"contactTelephone" , width:100, align:"center"},
	{ title:"联系人固话", name:"contactTelephone" , width:100, align:"center"},
	{ title:"联系人手机", name:"contactMobilePhone" , width:100, align:"center"},
	{ title:"联系人邮箱", name:"contactEmail" , width:100, align:"center"},
	{ title:"备注", name:"remark" , width:100, align:"center"},
];
  	
var contactGrid = $("#contactTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageContact",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : contactCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : true,
	checkCol : true,
	indexCol : false,
});

var fileCols = [
	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
	{ title:"项目行编号", name:"projectItemNumber", width:100, align:"center"},
	{ title:"项目行描述", name:"projectItemDesc", width:100, align:"center"},
	{ title:"文件序号", name:"fileSequence", width:100, align:"center"},
	{ title:"文件名称", name:"fileName" , width:100, align:"center"},
	{ title:"文件描述", name:"fileDesc" , width:100, align:"center"},
	{ title:"文件版本", name:"fileVersion" , width:100, align:"center"},
	{ title:"文件路径", name:"filePath" , width:100, align:"center",hidden:true},
	{ title:"备注", name:"remark" , width:100, align:"center"},
];
  	
var fileGrid = $("#fileTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageFile",
	method :  "POST",
	autoLoad : false,
	height : "350px",
	cols : fileCols,
	root : "rows",
	loadingText : "<i18n:I18n defaultValue='正在载入' key='i18n_common_mmgrid_loadingtext'/>",
	noDataText : "<i18n:I18n defaultValue='暂无数据' key='i18n_common_mmgrid_nodatatext'/>",
	multiSelect : true,
	checkCol : true,
	indexCol : false,
});
var currShowFile;
fileGrid.on('cellSelected', function(e, item, rowIndex, colIndex){
	var filePath = item.filePath;
	if(currShowFile == filePath){//如果选中的为当前显示文件则不做其他操作
	} else {//如果选中的不是当前显示文件则重新刷新右侧显示文件
		currShowFile = filePath;
		previewFile(filePath);
	}
});
	
$(document).ready(function(){
	cloneNode = $("#attrSelectDiv>div").clone();
	
	//初始化控件
	$("button").button();
    $("#sheet-project").tabs();
	initTree();
    init();
});

$("input[name='dateArea']").click(function(){
	var dateArea = $(this).val();
	var currDate = new Date();
	
	if("lastMonth" == dateArea){
		$("#startCreateDate").parent().hide();
		$("#endCreateDate").parent().hide();
		
	    var currDateMill = currDate.getTime();
		var startDate = new Date();
	    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
	    var currMonthMaxDay = startDate.getDate();//本月天数
	    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
	    
		$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
		$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
	} else if("lastThreeMonth" == dateArea){
		$("#startCreateDate").parent().hide();
		$("#endCreateDate").parent().hide();
		
		var currDateMill = currDate.getTime();
		var startDate = new Date();
	    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
	    var currMonthMaxDay = startDate.getDate();//本月天数
	    startDate.setMonth(currDate.getMonth(), 0);//上月最后一日
	    var lastMonthMaxDay = startDate.getDate();//上月天数
	    startDate.setMonth(currDate.getMonth()-1, 0);//前第二月最后一日
	    var last2MonthMaxDay = startDate.getDate();//前第二月天数
	    
	    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay+lastMonthMaxDay+last2MonthMaxDay-1));
		$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
		$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
	} else if("defineDateArea" == dateArea) {
		$("#startCreateDate").val("");
		$("#endCreateDate").val("");
		$("#startCreateDate").parent().show();
		$("#endCreateDate").parent().show();
	} else {//默认查最近一月
		$("#startCreateDate").parent().hide();
		$("#endCreateDate").parent().hide();
		
		var currDateMill = currDate.getTime();
		var startDate = new Date();
	    startDate.setMonth(currDate.getMonth()+1, 0);//本月最后一日
	    var currMonthMaxDay = startDate.getDate();//本月天数
	    startDate.setTime(currDateMill-1000*60*60*24*(currMonthMaxDay-1));
	    
		$("#startCreateDate").val(startDate.format("yyyy-MM-dd"));
		$("#endCreateDate").val(currDate.format("yyyy-MM-dd"));
	}
});

$("#queryBtn").click(function(){
	refreshData();
});

$("#addBtn").click(function(){
	var parentId="";
	
	if(activeTreeNode && activeTreeNode._d.fullPath){
		parentId = activeTreeNode._d.fullPath;
	}
	
	parent.elsDeskTop.defineWin({
        iconSrc : "icon/icon9.png",
        windowsId : "projectManageAdd",
        windowTitle : "<i18n:I18n defaultValue='新建项目管理' key='i18n_windowTitle_projectManageAdd'/>",
        iframSrc : "${pageContext.request.contextPath}/projectmanage/projectManageAdd.jsp?parentId=" + parentId,
        showAdv : true,
        windowStatus : "maximized",
        windowMinWidth : 960,
        windowMinHeight : 700,
        windowWidth : 960,
        windowHeight : 700,
        parentPanel : ".currDesktop"
    });
});

$("#copyAddBtn").click(function(){
	
});

$("#updBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var flowCode = headRecord.flowCode;
		if(flowCode != null && flowCode != "00"){
			alert("<i18n:I18n defaultValue='项目已提交审批,禁止修改' key='i18n_alert_canotUpd_hasSendToAudit'/>",2);
			return;
		}
		var projectStatus = headRecord.projectStatus;
		var createUser = headRecord.createUser;//subAccount_name
		var currPerson = userName;
		if(projectStatus == "0" || projectStatus == "1"){
			if(createUser == currPerson){
				parent.elsDeskTop.defineWin({
			        iconSrc : "icon/icon9.png",
			        windowsId : "projectManageUpd",
			        windowTitle : "<i18n:I18n defaultValue='修改项目管理' key='i18n_windowTitle_projectManageUpd'/>",
			        iframSrc : "${pageContext.request.contextPath}/projectmanage/projectManageUpd.jsp?"
			        		+"elsAccount="+headRecord.elsAccount
			        		+"&projectNumber="+headRecord.projectNumber,
			        showAdv : true,
			        windowStatus : "maximized",
			        windowMinWidth : 960,
			        windowMinHeight : 700,
			        windowWidth : 960,
			        windowHeight : 700,
			        parentPanel : ".currDesktop"
			    });
			} else {
				alert("<i18n:I18n defaultValue='非创建人,禁止修改' key='i18n_alert_canotUpd_notCreator'/>",2);
			}
		} else {
			alert("<i18n:I18n defaultValue='项目已完成或关闭了,禁止修改' key='i18n_alert_canotUpd_hasComplete'/>",2);
		}
	}
});

$("#delBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var flowCode = headRecord.flowCode;
		if(flowCode != null && flowCode != "00"){
			alert("<i18n:I18n defaultValue='项目已提交审批,禁止删除' key='i18n_alert_canotDel_hasSendToAudit'/>",2);
			return;
		}
		var projectStatus = headRecord.projectStatus;
		var createUser = headRecord.createUser;
		if(projectStatus == "0" && createUser.indexOf(userName)>=0){
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_common_confirm_delete" defaultValue="是否确认删除？" />',closeEvent:function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/ProjectManageService/delProjectManage",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(selectRows[0]),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='删除成功' key='i18n_common_alert_deletesuccess'/>",1);
						
						var selectedIndexes = headGrid.selectedRowsIndex();
						headGrid.removeRow(selectedIndexes);
						
						clearItemTable();
						clearContactTable();
						clearFileTable();
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n defaultValue='删除失败' key='i18n_delivery_deletefail'/>",3);
					}
				});
			}});
		} else {
			alert("<i18n:I18n defaultValue='非负责人或非新建项目禁止删除' key='i18n_alert_canotUpd_notCreatorOrNotNewStatus'/>",2);

		}
	} else {
		alert("<i18n:I18n defaultValue='请选择删除项目' key='i18n_alert_pleaseSelectDelRow'/>",2);
	}
});

$("#btnAuditConfig").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var projectNumber = headRecord.projectNumber;
		var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"projectNumber":projectNumber};
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/ProjectManageService/checkIsEntried",
			type :"post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.hideLoading();
				if(data > 0){
					alert('<i18n:I18n key="xx" defaultValue="单据已提交审批，不能重复创建审批" />',3);
				}else{
					selfCreateAuditConfig(projectNumber);
				}
			},
			error : function(data) {
				parent.elsDeskTop.hideLoading();
				if (!permissionError(data)) {
					alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
				}
			}
		});	
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}
});

$("#entryBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var projectNumber = headRecord.projectNumber;
		parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="xx" defaultValue="是否确认提交审批？" />',closeEvent:function(){
			var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"projectNumber":projectNumber};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url :"${pageContext.request.contextPath}/rest/ProjectManageService/entryProject",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json",
				success : function(data) {
					parent.elsDeskTop.hideLoading();
					if (data.statusCode != "200") {
						alert(data.message,3);
						return;
					}
					alert("<i18n:I18n key="xx" defaultValue="上报成功" />");
					refreshData();
				},
				error : function(data) {
					parent.elsDeskTop.hideLoading();
					if (!permissionError(data)) {
						if (data.status == "401") {
							alert("<i18n:I18n key="xx" defaultValue="项目不能重复上报" />",3);
						} else {
							alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
						};
					}
				}
			});
		}});
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}
});
$("#flowBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var projectNumber = headRecord.projectNumber;
		var flowCode = headRecord.flowCode;
		 if (flowCode == null || flowCode == "00") {
				alert('<i18n:I18n key="xx" defaultValue="项目尚未上报" />',2);
			} else {
				parent.elsDeskTop.defineWin({
			        'iconSrc':'icon/els-icon.png',
			        'windowsId':'auditFlowList',
			        'windowTitle':'<i18n:I18n key="i18n_common_viewflow" defaultValue="查看流程" />',
			        'iframSrc':'<%=basePath%>audit/auditFlowList.jsp?elsAccount=' + elsAccount + '&businessType=project&businessId=' + projectNumber,
			        windowMinWidth: 480,
			        windowMinHeight: 600,
			        'windowWidth':680,
			        'windowHeight':500,
			        'parentPanel':".currDesktop"
			    });
			}
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}	
});
$("#cancelEntryBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var projectNumber = headRecord.projectNumber;
		var flowCode = headRecord.flowCode;
		if (flowCode == null || flowCode == "00") {
			alert("<i18n:I18n key="xx" defaultValue="项目尚未上报" />",2);
		} else {
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="xx" defaultValue="您确定要撤销审批吗？" />',closeEvent:function(){
				parent.elsDeskTop.showLoading();
				var param = {"businessElsAccount":elsAccount,"projectNumber":projectNumber,"elsAccount":elsAccount,"elsSubAccount":elsSubAccount};
				$.ajax({
					url :"<%=basePath%>rest/ProjectManageService/cancelAudit",
					type :"post",
					contentType : "application/json",
					data : JSON.stringify(param),
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						alert("<i18n:I18n key="i18n_delivery_revokesuccess" defaultValue="撤销成功" />");
						refreshData();
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						if (!permissionError(data)) {
							if (data.status == "401") {
								alert("<i18n:I18n key="xx" defaultValue="流程结束的项目不能撤销审批" />",3);
							} else if (data.status == "403") {
								alert("<i18n:I18n key="i18n_audit_higherlevelcando" defaultValue="只有上一级处理人才能撤销审批" />",3);
							} else {
								alert('<i18n:I18n key="i18n_common_request_error" defaultValue="请求出错" />',3);
							}
						}
					}
				});
			}});
		}
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}
});

function init(){
	refreshData();
}

function clearAddInfo(){
	$("#projectNumber1").val("");
	$("#projectDesc1").val("");
	$("#projectType1").val("");
	$("#projectStatus1").val("");
	$("#projectLeader1").val(userName);
}

function selfCreateAuditConfig(projectNumber){
	parent.elsDeskTop.defineWin({
        'iconSrc':'icon/els-icon.png',
        'windowsId':'selfCreateAuditConfig',
        'windowTitle':'<i18n:I18n key="xxx" defaultValue="创建审批" />',
        'iframSrc':'<%=basePath%>audit/selfCreateAuditConfig.jsp?businessType=project&propertyCode=projectNumber&propertyValue='
								+ projectNumber,
						'windowWidth' : 800,
						'windowHeight' : 500,
						'parentPanel' : ".currDesktop"
					});
		}

		function refreshData() {

			var datas = [];
			var parentId = "";

			//debugger;

			if (activeTreeNode && activeTreeNode._d.projectNumber) {
				parentId = "[" + activeTreeNode._d.projectNumber + "]";
			}

			for (i = 0; i < headDatas.length; i++) {
				if (parentId == ""
						|| headDatas[i].parentId.indexOf(parentId) >= 0) {
					datas.push(headDatas[i]);
				}
			}

			headGrid.load(datas);
		}

		function loadItem(headRecord) {
			// 	var queryParam = {
			//     	elsAccount : headRecord.elsAccount,
			//     	projectNumber : headRecord.projectNumber
			//     };
			// 	itemGrid.load(queryParam);
			
			if(headRecord){
				currentHeaderRecord = headRecord;
			}else{
				headRecord = currentHeaderRecord;
			}

			var datas = [];
			
			var attrConds = getAttrCond();
			
			var match = true;
			
			//debugger;

			for (var i = 0; i < itemDatas.length; i++) {
				if (itemDatas[i].projectNumber == headRecord.projectNumber) {
					
					match = true;
					
					if(attrConds.length>0){
						for(var j=0;j<attrConds.length;j++){
							if(itemDatas[i][attrConds[j].attrCode]!=attrConds[j].attrValue){
								match = false;
								break;
							}
						}
					}
					
					if(match){
						datas.push(itemDatas[i]);
					}
					
				}
			}

			itemGrid.load(datas);
		}

		function loadContact(headRecord) {
			var queryParam = {
				elsAccount : headRecord.elsAccount,
				projectNumber : headRecord.projectNumber
			};
			contactGrid.load(queryParam);
		}

		function loadFile(headRecord) {
			var queryParam = {
				elsAccount : headRecord.elsAccount,
				projectNumber : headRecord.projectNumber
			};
			fileGrid.load(queryParam);
		}

		function clearItemTable() {
			if (itemGrid.rowsLength() > 0) {
				for (var i = itemGrid.rowsLength(); i - 1 >= 0; i--) {
					itemGrid.removeRow(i - 1);
				}
			}
		}

		function clearContactTable() {
			if (contactGrid.rowsLength() > 0) {
				for (var i = contactGrid.rowsLength(); i - 1 >= 0; i--) {
					contactGrid.removeRow(i - 1);
				}
			}
		}

		function clearFileTable() {
			if (fileGrid.rowsLength() > 0) {
				for (var i = fileGrid.rowsLength(); i - 1 >= 0; i--) {
					fileGrid.removeRow(i - 1);
				}
			}
		}

		function previewFile(filePath) {
			var showDiv = $("#file-display");
			var viewerPlaceA = $("#viewerPlaceHolder");
			viewerPlaceA.empty();
			var param = {
				elsAccount : elsAccount,
				filePath : filePath
			};

			if (isSupportImage(filePath)) {//系统支持的图片,直接显示
				showDiv.css("overflow", "auto");
				$("<img src='${fileSystemPath}/"+filePath+"' />").appendTo(
						viewerPlaceA);
			} else if (isSupportFile(filePath)) {//系统支持在线预览的文档则转为swf文件在线预览
				showDiv.css("overflow", "hidden");//flexPaper显示自带滚动条,并且div滚动条将其覆盖了,去掉div滚动条
				$
						.ajax({
							url : "${pageContext.request.contextPath}/rest/DocConvertService/convert2swf",
							type : "POST",
							data : JSON.stringify(param),
							contentType : "application/json",
							dataType : "json",
							success : function(data) {
								var resStatus = data.statusCode;
								var message = data.message;
								if ("200" == resStatus) {
									var swfPath = message;//后台成功则为返回的swf文件路径(相对根目录)
									var width = $("#file-display").width();
									var height = $("#file-display").height();
									$("#viewerPlaceHolder").css("width",
											width + "px");
									$("#viewerPlaceHolder").css("height",
											height + "px");
									$("#viewerPlaceHolder").css("display",
											"block");

									var fp = new FlexPaperViewer(
											'${pageContext.request.contextPath}/jsLib/flexpaper/FlexPaperViewer',
											'viewerPlaceHolder',
											{
												config : {
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
													localeChain : 'zh_CN'//地区语言(en_US:English,)
												}
											});
								} else {
									alert("文件预览转换失败", 3);
								}
							},
							error : function(data) {
								alert(data.message, 3);
							}
						});
			} else {
				alert(
						"<i18n:I18n defaultValue='不支持在线预览的文档类型' key='i18n_alert_filetypenotsupport'/>!",
						3);
			}
		}
		
		$("#addAttrCondBtn").click(function(){
			$(this).before(cloneNode.clone());
	        $("input[name='attr']").bind('keypress',function(event){
	            if(event.keyCode == "13")    
	            {
	            	loadItem();
	            }
	        });
			
		});
		
        $("input[name='attr']").bind('keypress',function(event){
            if(event.keyCode == "13")    
            {
            	loadItem();
            }
        });
		
		function getAttrCond(){
			var attributeList = [];
		    $("#attrSelectDiv div").each(function(){
		    	var attrCode = $(this).find("select[name='attr']").eq(0).val();
		    	var attrValue = $(this).find("input[name='attr']").eq(0).val();
		    	if(attrCode!="" && attrValue!=""){
			    	attributeList.push({
			    		attrCode : attrCode,
			    		attrValue : attrValue,
			    	});
		    	}

		    });
		    
		    return attributeList;
		}
		
		//------------------------------上传下载相关---------------------------------------------------
		
		var fileUploader;
		
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
		    //debugger;
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