<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style>
	.show-management .arrow-down{
		display: block;
		float: left;
		margin-top: 7px;
		cursor: pointer;
	}
	.show-management .arrow-right{
		display: block;
		float: left;
		margin-top: 3px;
		cursor: pointer;
	}
	.treeSel{
		margin-right: 5px!important;
	}
	.tree-leval a.active{
		font-weight: 800;
		text-decoration: underline;
		color: #FF5722;
	}
	.left-box{
		width: 300px;
		float: left;
		padding: 8px;
		height: 100%;
	}
	.left-box .tree-leval{
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
		top: 60px;
		bottom: 30px;
	}
</style>
<body>
	<div class="pos-relative show-management left-box">
		<div class="common-box-line">
			<button class="button-wrap" id="btnPjAdd"><i18n:I18n key="" defaultValue="新增项目" /></button>
			<button class="button-wrap" id="btnPjEdit"><i18n:I18n key="" defaultValue="修改项目" /></button>
			<!-- <div style="clear: both;height: 5px;width: 100%"></div> -->
			<button class="button-wrap" id="btnPjDel"><i18n:I18n key="" defaultValue="删除项目" /></button>
			<!-- <button class="button-wrap" id="btnPjCancel"><i18n:I18n key="" defaultValue="取消" /></button> -->
		</div>
		<div class="tree-leval">
		</div>
	</div>
	<div class="pos-relative public-wrap right-box">
		<div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <button class="button-wrap" id="queryBtn"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
                <button class="button-wrap" id="addBtn"><i18n:I18n key="i18n_button_add" defaultValue="新增" /></button>
                <button class="button-wrap" id="copyAddBtn"><i18n:I18n key="i18n_button_copyAdd" defaultValue="复制新增" /></button>
                <button class="button-wrap" id="updBtn"><i18n:I18n key="i18n_button_update" defaultValue="修改" /></button>
                <button class="button-wrap" id="delBtn"><i18n:I18n key="i18n_button_delete" defaultValue="删除" /></button>
                
                <base:auditConfig elsAccount="${elsAccount }" businessType="project">
					<button id="entryBtn" class="button-wrap"><i18n:I18n key="i18n_approval_report" defaultValue="提交审批" /></button>
					<button id="cancelEntryBtn" class="button-wrap"><i18n:I18n key="i18n_undo_Report" defaultValue="撤销审批" /></button>
					<button id="flowBtn" class="button-wrap"><i18n:I18n key="i18n_approval_flow" defaultValue="流程" /></button>
				</base:auditConfig>
				
				<button id="btnAuditConfig" class="button-wrap"><i18n:I18n key="xxx" defaultValue="创建审批" /></button>
				
				<button id="examinePass" class="button-wrap"><i18n:I18n key="xxx" defaultValue="审批通过" /></button>
            
            </div>
        </div>
        <form id="projectForm">
		<div class="box-wrap pos-relative bg-common">
			<input type="hidden" id="elsAccount" name="elsAccount">
            <input type="hidden" id="pageSize" name="pageSize" value="10">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
			<div class="common-box-line">
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectNumber" defaultValue="项目编号" />:</span>
					<input type="text" id="projectNumber" name="projectNumber" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectDesc" defaultValue="项目描述" />:</span>
					<input type="text" id="projectDesc" name="projectDesc" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectLeader" defaultValue="项目负责人" />:</span>
					<input type="text" id="projectLeader" name="projectLeader" />
				</div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectStatus" defaultValue="项目状态" />:</span>
					<select id="projectStatus" name="projectStatus">
						<option value="">请选择</option>
						<option value="0">新建</option>
						<option value="1">进行中</option>
						<option value="2">完成</option>
						<option value="3">关闭</option>
					</select>
				</div>
				<br>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_projectManage_projectCreateDate" defaultValue="项目创建日期" />:</span>
	                <input type="radio" name="dateArea" value="lastMonth" checked="checked"><i18n:I18n key="i18n_label_lastmonth" defaultValue="最近一个月" />
	                <input type="radio" name="dateArea" value="lastThreeMonth"><i18n:I18n key="i18n_label_lastthreemonths" defaultValue="最近三个月" />
	                <input type="radio" name="dateArea" value="defineDateArea"><i18n:I18n key="i18n_label_custom" defaultValue="自定义" />
				</div>
                <div class="dis-in-b input-and-tip" style="display:none;">
                	<input type="text" class="Wdate" onfocus="WdatePicker()" id="startCreateDate" name="startCreateDate"/>
                </div>
                <div class="dis-in-b input-and-tip" style="display:none;">
	                <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
	                <input type="text" class="Wdate" onfocus="WdatePicker()" id="endCreateDate" name="endCreateDate" />
                </div>
			</div>
		</div>
		</form>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_projectManage_title_projectHead" defaultValue="项目管理头" /></span>
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
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_projectManage_title_projectDetail" defaultValue="项目管理明细" /></span>
			<div class="common-box-line">
				<div class="tab-wrap" id="sheet-project">
				 	<ul>
                        <li><a href="#sheet-project-one"><i18n:I18n key="i18n_projectManage_title_projectItem" defaultValue="项目管理行" /></a></li>
                        <li><a href="#sheet-project-two"><i18n:I18n key="i18n_projectManage_title_projectContact" defaultValue="项目联系人" /></a></li>
                        <li><a href="#sheet-project-three"><i18n:I18n key="i18n_projectManage_title_projectFile" defaultValue="项目文件" /></a></li>
                    </ul>
					<div id="sheet-project-one">
						<main class="grid-container">
							<div class="grid-100" id="itemDiv">
								<table id="itemTable"></table>
							</div>
						</main>
					</div>
					<div id="sheet-project-two">
						<main class="grid-container">
							<div class="grid-100" id="contactDiv">
								<table id="contactTable"></table>
							</div>
						</main>
					</div>
					<div id="sheet-project-three">
                        <div class="box-wrap pos-relative bg-common">
				            <div class="common-box-line p-zero">
				                <div class="pos-relative upload-wrap">
				                    <div class="pos-absolute file-list">
										<div class="file-list-head">
											<%-- <select id="selectFileType" name="selectFileType" style="width: 165px;">
												<option value="all"><i18n:I18n defaultValue="所有文件" key="i18n_common_select_filetype_all"/></option>
												<option value="common"><i18n:I18n defaultValue="公共文件" key="i18n_common_select_filetype_public"/></option>
											</select> --%>
						                </div>
										<main class="grid-container">
											<div class="grid-100" id="fileDiv">
												<table id="fileTable" style="width: 300px;"></table>
											</div>
										</main>
				                    </div>
					                <div class="file-scan">
			   							<div class="file-option-zoom">
							                <%-- <div class="dis-in-b text-left">
										        <button class="button-wrap" id="addFileBtn"><i18n:I18n key="i18n_common_button_addfile" defaultValue="新增文件" /></button>
												<button class="button-wrap" id="delFileBtn"><i18n:I18n key="i18n_common_button_deletefile" defaultValue="删除文件" /></button>
									        </div> --%>
									    </div>
										<div class="file-display" id="file-display">
											<a id="viewerPlaceHolder"></a>
										</div>
									</div>
								</div>
							</div>
					  	</div>
                    </div>
				</div>
			</div>
		</div>
		
		<div class="fixed-dialog" id="projectEditForm" >
			<div class="dialog-tip bg-common" style="width: 502px;height: 340px;margin-left: -251px;margin-top: -190px;">
			    <div class="dialog-close-btn" id="btnAddClose"></div>
		        <div class="tip-head">
			        <img class="icon" src="${pageContext.request.contextPath}/icon/els.PNG" />
			        <span class="dialogTitle"><i18n:I18n defaultValue="新增项目" key=""/></span>
			    </div>
			        <div class="box-wrap pos-relative bg-common">
			            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n defaultValue="项目信息" key=""/></span>
			            <div class="common-box-line">
			                <table>
			                	<tr class="line-height-tr">
			                		<td><i18n:I18n defaultValue="项目编号" key=""/>:</td>
			                		<td><input type="text" id="projectNumber1" /></td>
			                	</tr>
			                	<tr class="line-height-tr">
			                		<td><i18n:I18n defaultValue="项目描述" key=""/>:</td>
			                		<td><input  type="text" id="projectDesc1" /></td>
			                	</tr>
			                	<tr class="line-height-tr">
			                		<td><i18n:I18n defaultValue="项目类型" key=""/>:</td>
			                		<td><input type="text" id="projectType1" /></td>
			                	</tr>
			                	<tr class="line-height-tr">
			                		<td><i18n:I18n defaultValue="项目状态" key=""/>:</td>
			                		<td><input type="text" id="projectStatus1" /></td>
			                	</tr>
			                	<tr class="line-height-tr">
			                		<td><i18n:I18n defaultValue="项目负责人" key=""/>:</td>
			                		<td><input type="text" id="projectLeader1" /></td>
			                	</tr>
			                </table>
			            </div>
			            <div class="mt-40 text-center" >
			                <button id="btnAddOK" class="button-wrap "><i18n:I18n defaultValue="确定" key="i18n_common_button_ok"/></button>
			                <button id="btnAddCancel" class="button-wrap tip-option-btn"><i18n:I18n defaultValue="取消" key="i18n_common_button_cancel"/></button>
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
	var operate;//判断是保存还是修改

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
	
// 	ajaxWorker('${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectStructure',{
// 		type: "post",
// 		contentType: "application/json",
// 		data: JSON.stringify({elsAccount:elsAccount}),
// 		dataType: "json"
// 	}).done(function(data){
// 		debugger;
// 		data = data||[];
// 		var root = document.querySelector('.tree-leval');
// 		root.appendChild(definedDom(treeDataAdapter(data)).resetChildArrow());
// 	}).fail(function(){

// 	})
	
	$.ajax({
		url :"${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectStructure",
		type :"post",
		contentType : "application/json",
		data : JSON.stringify({elsAccount:elsAccount}),
		dataType : "json",
		success : function(data) {
			data = data||[];
			var root = document.querySelector('.tree-leval');
			root.innerHTML='';
			root.appendChild(definedDom(treeDataAdapter(data)).resetChildArrow());
		},
		error : function(data) {

		}
	});
};

var renderFormatDate = function(val,item,rowIndex){
	if("undefined"==typeof(val) || "" == val || null == val){
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
	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
	{ title:"项目描述", name:"projectDesc", width:100, align:"center"},
	{ title:"项目概述", name:"projectSummary", width:100, align:"center"},
	{ title:"外部参考项目编号", name:"refProjectNumber", width:100, align:"center"},
	{ title:"项目类型", name:"projectType", width:100, align:"center"},
	{ title:"项目状态", name:"projectStatus" , width:100, align:"center",renderer:renderFormatStatus},
	{ title:"项目总负责人", name:"projectLeader" , width:100, align:"center"},
	{ title:"审批状态", name:"auditStatus" , width:100, align:"center",renderer:renderFormatApprove},
	{ title:"项目客户名称", name:"customerDesc" , width:100, align:"center"},
	{ title:"项目地址", name:"projectAddress" , width:100, align:"center"},
	{ title:"币别", name:"currency" , width:100, align:"center"},
	{ title:"预算金额", name:"budgetAmount" , width:100, align:"center"},
	{ title:"实际金额", name:"actualAmount" , width:100, align:"center"},
	{ title:"计划周期(天)", name:"planCycle" , width:100, align:"center"},
	{ title:"实际周期(天)", name:"actualCycle" , width:100, align:"center"},
	{ title:"计划开始日期", name:"planStartDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"计划结束日期", name:"planEndDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"实际开始日期", name:"actualStartDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"实际结束日期", name:"actualEndDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"备注", name:"remark" , width:100, align:"center"},
	{ title:"创建人", name:"createUser" , width:100, align:"center"},
	{ title:"流程编码", name:"flowCode", width:100, align:"center",hidden:true}
];

var frm = $("#projectForm");
var headGrid = $("#headTable").mmGrid({
	url : "${pageContext.request.contextPath}/rest/ProjectManageService/queryProjectManageHead",
	params: frm.serializeJSON(),
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
	{ title:"ELS号", name:"elsAccount", width:100, align:"center"},
	{ title:"ELS描述", name:"elsDesc", width:100, align:"center"},
	{ title:"项目编号", name:"projectNumber", width:100, align:"center"},
	{ title:"项目行编号", name:"projectItemNumber", width:100, align:"center"},
	{ title:"项目行描述", name:"projectItemDesc", width:100, align:"center"},
	{ title:"外部参考项目行编号", name:"refProjectItemNumber", width:100, align:"center"},
	{ title:"项目行状态", name:"projectItemStatus" , width:100, align:"center",renderer:renderFormatStatus},
	{ title:"项目行负责人", name:"projectLeader" , width:100, align:"center"},
	{ title:"里程碑标识", name:"milestoneMark" , width:100, align:"center",renderer:renderFormatMark},
	{ title:"币别", name:"currency" , width:100, align:"center"},
	{ title:"预算金额", name:"budgetAmount" , width:100, align:"center"},
	{ title:"预算占比", name:"budgetPercentage" , width:100, align:"center"},
	{ title:"实际金额", name:"actualAmount" , width:100, align:"center"},
	{ title:"计划周期(天)", name:"planCycle" , width:100, align:"center"},
	{ title:"实际周期(天)", name:"actualCycle" , width:100, align:"center"},
	{ title:"计划开始日期", name:"planStartDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"计划结束日期", name:"planEndDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"实际开始日期", name:"actualStartDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"实际结束日期", name:"actualEndDate" , width:100, align:"center",renderer:renderFormatDate},
	{ title:"完成百分比", name:"completePercentage" , width:100, align:"center"},
	{ title:"备注", name:"remark" , width:100, align:"center"},
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
//复制新增
$("#copyAddBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	var itemRecords = itemGrid.rows();
	var contactRecords = contactGrid.rows();
	var fileRecords = fileGrid.rows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		headRecord["stretegyCode"] = "";
		headRecord["flowCode"] = "";
		var parentId="";
		if(activeTreeNode && activeTreeNode._d.fullPath){
			parentId = activeTreeNode._d.fullPath;
		}
		parent.elsDeskTop.defineWin({
	        iconSrc : "icon/icon9.png",
	        windowsId : "projectManageAdd",
	        windowTitle : "<i18n:I18n defaultValue='新建项目管理' key='i18n_windowTitle_projectManageAdd'/>",
	        iframSrc : "${pageContext.request.contextPath}/projectmanage/projectManageAdd.jsp?parentId="+parentId+"&type=copyAdd",
	        showAdv : true,
	        data : {headRecord : headRecord,itemRecords : itemRecords,contactRecords : contactRecords,fileRecords : fileRecords},
	        windowStatus : "maximized",
	        windowMinWidth : 960,
	        windowMinHeight : 700,
	        windowWidth : 960,
	        windowHeight : 700,
	        parentPanel : ".currDesktop"
	    });
	}else{
		alert("请选择要复制新增的数据行！",2);
	}
	
});

$("#updBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var flowCode = headRecord.flowCode;
		var auditStatus = headRecord.auditStatus;
		if(flowCode != null && flowCode != "00"){
			alert("<i18n:I18n defaultValue='项目已提交审批,禁止修改' key='i18n_alert_canotUpd_hasSendToAudit'/>",2);
			return;
		}
		if(auditStatus == 0){
			alert("<i18n:I18n defaultValue='项目审批通过,禁止修改' key=''/>",2);
			return;
		}else if(auditStatus == 2 || auditStatus == 4){
			alert("<i18n:I18n defaultValue='项目审批中,禁止修改' key=''/>",2);
			return;
		}else{
			//do nothing
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
	}else{
		alert("请选择要修改的数据行！",2);
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
		var auditStatus = headRecord.auditStatus;
		var projectNumber = headRecord.projectNumber;
		var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"projectNumber":projectNumber};
		if(auditStatus == null || auditStatus == "1"){			
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
			alert("已提交的审批不能再次创建审批！",2);
		}
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}
});
//提交审批
$("#entryBtn").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var projectNumber = headRecord.projectNumber;
		var auditStatus = headRecord.auditStatus;
		if(auditStatus == "1" || auditStatus == "3"){//未审批或者审批拒绝可以再次提交审批		
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
		} else {//审批中或者审批通过
			alert("已在审批中或审批通过的禁止再次提交审批！",2);
		}
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}
});


//审批通过Start
$("#examinePass").click(function(){
	var selectRows = headGrid.selectedRows();
	if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
		var headRecord = selectRows[0];
		var projectNumber = headRecord.projectNumber;
		var auditStatus = headRecord.auditStatus;
		if(auditStatus != "0" && auditStatus != 3){//未审批通过和审批未拒绝的	
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="xx" defaultValue="确认直接审批通过？" />',closeEvent:function(){
				var data = {"elsAccount":elsAccount,"elsSubAccount":elsSubAccount,"projectNumber":projectNumber};
				parent.elsDeskTop.showLoading();
				$.ajax({
					url :"${pageContext.request.contextPath}/rest/ProjectManageService/passProject",
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
						alert("<i18n:I18n key="xx" defaultValue="审批已通过" />");
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
		}else if(auditStatus == 3){//审批拒绝
			alert("审批已被拒绝的不能直接审批通过！",2);
		} else {//审批通过
			alert("已审批通过的禁止再次审批！",2);
		}
	} else {
		alert("<i18n:I18n defaultValue='请选择项目' key='i18n_alert_pleaseSelectProject'/>",2);
	}
});
//审批通过end







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
	btnPjAdd = document.querySelector('#btnPjAdd');
	btnPjEdit = document.querySelector('#btnPjEdit');
	btnPjDel = document.querySelector('#btnPjDel');
	btnPjCancel = document.querySelector('#btnPjCancel');
	
	$("#elsAccount").val(elsAccount);
	btnPjAdd.onclick = function(){
		
		operate = "save";
		
		var data = activeTreeNode._d;
		
		$("#projectNumber1").val(data.projectNumber).attr("readonly",false);
		
		$("#projectLeader1").val(userName);
		
		$("#projectEditForm").show();
		
		//var data = activeTreeNode._d;

		// 节点模拟数据
		//var data = {"reqCode":null,"integrateCode":null,"urlStr":null,"statusCode":null,"message":null,"language":null,"tablename":null,"pageSize":2147483647,"recordCount":0,"currentPage":1,"fromIndex":0,"createDate":1463119847000,"createUser":"1001_chanson","lastUpdateDate":1463126018000,"lastUpdateUser":null,"permissionObject":null,"permissionObjectAlia":null,"elsAccount":"105158","elsSubAccount":null,"companyShortName":null,"sort":null,"auditOpinion":null,"version":0,"errMessage":null,"extendFields":null,"projectNumber":"1001","elsDesc":"chanson","projectDesc":"项目A","projectType":"内装","parentId":null,"fullPath":"[1001]","level":0,"logtime":1463126020000,"fbk1":null,"fbk2":null,"fbk3":null,"fbk4":null,"fbk5":null,"fbk6":null,"fbk7":null,"fbk8":null,"fbk9":null,"fbk10":null,"pageCount":0,"toIndex":0};
		// 取父节点数据 activeTreeNode._d
		// 执行插入
		//activeTreeNode.insertNode(data);
	};
	btnPjEdit.onclick = function(){
		
		operate = "update";
		
		var activeObj = activeTreeNode._d;
		$("#projectNumber1").val(activeObj.projectNumber).attr("readonly",true);
		$("#projectDesc1").val(activeObj.projectDesc);
		$("#projectType1").val(activeObj.projectType);
		$("#projectStatus1").val(activeObj.projectStatus);
		$("#projectLeader1").val(activeObj.projectLeader);
		$("#projectEditForm").show();
		
		//$('.treeSel').show();
	};
	btnPjDel.onclick = function(){
		var d = activeTreeNode._d;
		if(d.projectNumber){
			top.elsDeskTop.tip.init({
				type:'confirm',displayType:'2',message:'确定要删除[' + d.projectNumber + " - " +  d.projectDesc + ']吗？',
				closeEvent: function () {
					var l = $(activeTreeNode).parents('li:first').hide();
					ajaxWorker(location.origin+'${pageContext.request.contextPath}/rest/ProjectManageService/delProjectStructureNode',{
						type: "post",
						contentType: "application/json",
						data: JSON.stringify(activeTreeNode._d),
						dataType: "json"
					}).done(function(){
						l.remove();
					}).fail(function(){
						alert('删除项目'+ d.projectDesc+'['+ d.projectNumber+']失败!',3);
						l.show();
					})
				}}
			);
		}
	};
// 	btnPjCancel.onclick = function(){
// 		//$('.treeSel').hide();
// 	};

	$("#btnAddOK").click(function(){
		
		if(operate != "" && operate == "save"){//保存项目节点结构信息
			var parentId = activeTreeNode._d.projectNumber;
			var level = 0;
			var fullPath = "[" + $("#projectNumber1").val() + "]";
			
			if(parentId!=undefined && parentId!=null && parentId!=""){
				level = activeTreeNode._d.level + 1;
				fullPath = activeTreeNode._d.fullPath + ",[" + $("#projectNumber1").val() + "]";			
			}
			var newProject = {
					projectNumber : $("#projectNumber1").val(),
					projectDesc : $("#projectDesc1").val(),
					projectType : $("#projectType1").val(),
					projectStatus : $("#projectStatus1").val(),
					projectLeader : $("#projectLeader1").val(),
					elsAccount : elsAccount,
					elsDesc : elsDesc,
					parentId : parentId,
					level : level,
					fullPath : fullPath
			};
			$.ajax({
				url :"<%=basePath%>rest/ProjectManageService/addProjectStructureNode",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(newProject),
				dataType : "json",
				success : function(data) {
					debugger;
					if(data.statusCode=="-100"){
						alert(data.message,3);
					}else{
						activeTreeNode.insertNode(newProject);
						clearAddInfo();
						$("#projectEditForm").hide();
					}
					operate = "";
				},
				error : function(data) {
					debugger;
					alert(data,3);
				}
			});
		}else {//修改项目节点结构信息
			var parentId = activeTreeNode._d.parentId;
			var level = activeTreeNode._d.level;
			var fullPath = activeTreeNode._d.fullPath;
			var newProject = {
					projectNumber : $("#projectNumber1").val(),
					projectDesc : $("#projectDesc1").val(),
					projectType : $("#projectType1").val(),
					projectStatus : $("#projectStatus1").val(),
					projectLeader : $("#projectLeader1").val(),
					elsAccount : elsAccount,
					elsDesc : elsDesc,
					parentId : parentId,
					level : level,
					fullPath : fullPath
			};
			$.ajax({
				url :"<%=basePath%>rest/ProjectManageService/updateProjectStructureNode",
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(newProject),
				dataType : "json",
				success : function(data) {
					debugger;
					if(data.statusCode=="-100"){
						alert(data.message,3);
					}else{
						clearAddInfo();
						$("#projectEditForm").hide();
					}
					operate = "";
					initTree();
				},
				error : function(data) {
					debugger;
					alert(data,3);
				}
			});
		}
		

	});
	
	$("#btnAddCancel").click(function(){
		$("#projectEditForm").hide();
		clearAddInfo();
	});
	
	$("#btnAddClose").click(function(){
		$("#projectEditForm").hide();
		clearAddInfo();
	});

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
        'iframSrc':'<%=basePath%>audit/selfCreateAuditConfig.jsp?businessType=project&propertyCode=projectNumber&winId=projectManage&propertyValue=' + projectNumber,
        'windowWidth':800,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
}

function refreshData(){
	/* var projectNumber = $("#projectNumber").val();
	var projectDesc = $("#projectDesc").val();
	var projectLeader = $("#projectLeader").val();
	var projectStatus = $("#projectStatus").val();
	var startCreateDate = $("#startCreateDate").val();
	var endCreateDate = $("#endCreateDate").val();
	var elsAccount = $("#elsAccount").val(); */
	
	var parentId = "";
	if(activeTreeNode && activeTreeNode._d.fullPath){
		parentId = activeTreeNode._d.fullPath;
	}
	
	var frm = $("#projectForm");
	var queryDataObj = frm.serializeJSON();
	queryDataObj["parentId"] = parentId;
	
	/* var queryParam = {
    	elsAccount : elsAccount,
    	projectNumber : projectNumber,
    	projectDesc : projectDesc,
    	projectLeader : projectLeader,
    	projectStatus : projectStatus,
    	startCreateDate : startCreateDate,
    	endCreateDate : endCreateDate,
    	parentId :  parentId
    }; */
    //$.extend(headGrid.opts.params,queryParam);
    //headGrid.load(queryParam);
    
    headGrid.opts.params = queryDataObj;
    headGrid.load({page:1});
}

function loadItem(headRecord){
	var queryParam = {
    	elsAccount : headRecord.elsAccount,
    	projectNumber : headRecord.projectNumber
    };
	itemGrid.load(queryParam);
}

function loadContact(headRecord){
	var queryParam = {
    	elsAccount : headRecord.elsAccount,
    	projectNumber : headRecord.projectNumber
    };
	contactGrid.load(queryParam);
}

function loadFile(headRecord){
	var queryParam = {
    	elsAccount : headRecord.elsAccount,
    	projectNumber : headRecord.projectNumber
    };
	fileGrid.load(queryParam);
}

function clearItemTable(){
	if(itemGrid.rowsLength() > 0){
		for(var i=itemGrid.rowsLength();i-1>=0;i--){
			itemGrid.removeRow(i-1);
		}
	}
}

function clearContactTable(){
	if(contactGrid.rowsLength() > 0){
		for(var i=contactGrid.rowsLength();i-1>=0;i--){
			contactGrid.removeRow(i-1);
		}
	}
}

function clearFileTable(){
	if(fileGrid.rowsLength() > 0){
		for(var i=fileGrid.rowsLength();i-1>=0;i--){
			fileGrid.removeRow(i-1);
		}
	}
}

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
					alert("文件预览转换失败",3); 
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
</script>
</body>
</html>