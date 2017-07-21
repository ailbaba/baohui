<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String standardNumber = request.getParameter("standardNumber"); %>
<%  String standardItemNumber = request.getParameter("standardItemNumber"); %>
<%  String toElsAccount = request.getParameter("toElsAccount"); %>
<body>
	<div class="pos-relative ">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">
				银行账号信息列表
			</span>
			<div class="common-box-line">
				<main class="grid-container">
				<div class="grid-100">
					<table id="headTable"></table>
					<div id="headPage" style="text-align: right;"></div>
				</div>
				</main>
			</div>
		</div>
	</div>
<script type="text/javascript">
	var elsAccount    = "${sessionScope.elsAccount}";
	var elsSubAccount = "${sessionScope.elsSubAccount}";
	var elsDesc       = "${sessionScope.companyShortName}";
	var userName      = "${sessionScope.username}";
	var headGrid;
	var standardNumber     = '<%=standardNumber %>' ;
	var standardItemNumber = '<%= standardItemNumber%>' ;
	var toElsAccount = '<%= toElsAccount%>' ;
	   var gobalStr           = {"elsAccount":toElsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber} ;
	// 渲染   @author jiangzhidong 20160120  begin

	//只允许数字输入框
	var initInputNumber = function(val,item,index){
		if(!val) { val = '';}
		return '<input type="text" onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')" name="'+this.name+'" value="'+val+'"/>';
	};
	//允许任何字符输入框
	var initInputAny = function(val, item, index){
		if(!val) { val = '';}
		return '<input type="text" name="'+this.name+'" id="'+this.name+'_'+index+'" value="'+val+'"/>';
	};
	//企业名称
    var initCompanyName = function (val, item, index){
    	if(!val) { val = '';}
    	var name = this.name;
    	var value = this.value;
		return '<input type="text" class = initCompany onkeyup="addEnterpriseName(this.value,' + index+')" name="'+name+'" id="'+name+'_'+index+'" value="'+val+'"/>';
    }
	
	//渲染结构化数据默认类型 
    var initDefault = function (val, item, index){
    	if(!val){
    		val ='';
    		return'<span>'+ val +'</span>';
    	}else if(val == "1"){
    		return '<span>'+ "否"  +'</span>';
    	}else if(val == "2"){
    		return '<span>'+ "是"  +'</span>';
    	}
    }
    
	//证书类型
    var initCertificateInfo = function (val, item, index){
    	if(!val){
    		val ='';
    		return'<span>'+ val +'</span>';
    	}
    	if(val == "1"){
    		return '<span>'+ "未认证" +'</span>';
    	}else if(val == "2"){
    		return '<span>'+  "已认证" +'</span>';
    	}
    }
   
	//渲染 @author jiangzhidong 20160120  end
	
	//var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="smsTemplateManage"/>;
	
	var headCols = [{title:'id',                 name:'bankId',             width: 120, align: 'center',hidden:true},
					{title:'ELS号码',            name:'elsAccount',         width: 120, align: 'center'},
					{title:'standardNumber',     name:'standardNumber',     width: 120, align: 'center',hidden:true},
					{title:'standardItemNumber', name:'standardItemNumber', width: 120, align: 'center',hidden:true},
					{title:'国家',               name:'countryName',        width: 120, align: 'center'},
					{title:'银行名',             name:'bankName' ,          width: 120, align: 'center'},
					{title:'开户网点名称',       name:'bankBranch',         width: 250, align: 'center'},
					{title:'银行账号',           name:'bankAccount',        width: 250, align: 'center'},
					{title:'银行账号名',         name:'bankAccountName',    width: 250, align: 'center'},
					{title:'是否默认',           name:'isDefault',          width: 250, align: 'center',renderer:initDefault},
					{title:'银行代码',           name:'backCode',           width: 250, align: 'center'},
					{title:'国家银行标准账号',   name:'standardAccount',    width: 250, align: 'center'},
					{title:'开户网点银行地址',   name:'bankBranchAddress',  width: 250, align: 'center'},
					{title:'创建时间',           name:'logtime',            width: 250, align: 'center',renderer:function(val){	if (!val) 	return "";  return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }},
			       ]; 
	

	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    var gobalStr           = {"elsAccount":toElsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber} ;
		 headGrid = $("#headTable").mmGrid({
			url : "${pageContext.request.contextPath}/rest/SupplierDataService/queryStandardBankInfo/" ,
			method :  "POST",
			cols : headCols,
			params:gobalStr,
			height : "400px",
			root : "rows",
			loadingText : "正在载入",
			noDataText : "暂无数据",
		    checkCol : true,
		    indexCol : false,
			plugins : [
			    $("#headPage").mmPaginator({
			        style : "plain",
			        totalCountName : "total",
			        page : 1,
			        pageParamName : "currentPage",
			        limitParamName : "pageSize",
			        limitLabel : "每页{0}条",
			        totalCountLabel : "共<span>{0}</span>条记录",
			        limit : null,
			        limitList : [10,20]
			    })
			]
		});
	    // headGrid.load(gobalStr);
	}
	
	$("#addBtn").click(function(){
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'supplierBankInfo',
	        'windowTitle':'添加账号银行信息',
	        'iframSrc':'<%=basePath%>supplierstandard/data/addSupplierBankInfo.jsp?standardNumber='
        		+ standardNumber + '&standardItemNumber=' +standardItemNumber,
	        windowStatus: 'regular',
	        windowMinWidth: 400,
	        windowMinHeight: 500,
	        windowPositionTop:24,
	        'windowWidth':400,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
	});
	
    
	$("#saveBtn").click(function(){			
		
	});
	
	$("#editBtn").click(function(){			
		   var head = headGrid.selectedRows();
			 if(head.length<=0){
				 alert("必须选择一行！",2);
				 return;
			 }
			 var rowid = head[0].bankId;
			 console.log(rowid);
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'supplierBankInfo',
	        'windowTitle':'修改账号银行信息',
	        'iframSrc':'<%=basePath%>supplierstandard/data/SupplierBankInfoUpd.jsp?standardNumber='
      		+ standardNumber + '&standardItemNumber=' +standardItemNumber
      		+"&bankId=" + rowid,
	        windowStatus: 'regular',
	        windowMinWidth: 400,
	        windowMinHeight: 500,
	        windowPositionTop:24,
	        'windowWidth':400,
	        'windowHeight':500,
	        'parentPanel':".currDesktop"
	    });
	});
	
	$("#queryHeadBtn").click(function(){			
		queryInfo();
	});
    
	//查询信息 
	function queryInfo(){
		headGrid.load(gobalStr);
	}
	
	$("#delBtn").click(function(){
		//删除默认单选
		var selectRows = headGrid.selectedRows();
		var selectRow = selectRows[0];
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			parent.elsDeskTop.tip.init({type:"confirm",message:"是否确认删除?",closeEvent:function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/SupplierDataService/deleteStandardBankInfo",
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(selectRow),  
					dataType : "json",
					success : function(data) {
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type:"alert",displayType:1,message:"删除成功!"});
						
						var selectedIndexes = headGrid.selectedRowsIndex();
						headGrid.removeRow(selectedIndexes);
					},
					error : function(data) {
						parent.elsDeskTop.hideLoading();
						parent.elsDeskTop.tip.init({type:"alert",message:"删除失败!"});
					}
				});
			}});
		}else {
			parent.elsDeskTop.tip.init({type : "alert",displayType : 2,message : "请选择删除银行账号信息!"});
		}
	});
	
</script>
</body>
</html>