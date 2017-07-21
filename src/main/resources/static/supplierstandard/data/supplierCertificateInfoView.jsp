<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<%  String standardNumber = request.getParameter("standardNumber"); %>
<%  String standardItemNumber = request.getParameter("standardItemNumber"); %>
<%  String toElsAccount = request.getParameter("toElsAccount"); %>
<body>
<div class="pos-relative ">
	<div class="box-wrap pos-relative bg-common">
		<span class="dis-in-b pos-absolute box-tip bg-common">
			证书认证列表
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
	
	//渲染   @author jiangzhidong 20160120  begin
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
    
    var initDefault = function (val, item, index){
    	if(!val){
    		val ='';
    		return'<span>'+ val +'</span>';
    	}else if(val == "1"){
    		return '<span>'+ "否" +'</span>';
    	}else if(val == "2"){
    		return '<span>'+ "是" +'</span>';
    	}
    }
   
	// 渲染   @author jiangzhidong 20160120  end
	// var headCols = <base:tableColumn elsAccount="${elsAccount}" elsSubAccount="${elsSubAccount}" tableCode="smsTemplateManage"/>;
	var headCols = [{title:'id',         name:'certificateId'     , width: 120, align: 'center' ,hidden:true},
			        {title:'ELS号码',    name:'elsAccount'        , width: 120, align: 'center'},
			        {title:'认证类型',   name:'certificateType'   , width: 120, align: 'center'},
			        {title:'证书编号',   name:'certificateNumber' , width: 120, align: 'center'},
			        {title:'认证机构名', name:'agencyName'        , width: 250, align: 'center'},
			        {title:'认证状态',   name:'state'             , width: 250, align: 'center',renderer:initCertificateInfo},
			        {title:'认证时间',   name:'logtime'           , width: 250, align: 'center' ,renderer:function(val){ if (!val) return ""; return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }},
  			        {title:'证书生效期', name:'validBeginTime'    , width: 250, align: 'center' ,renderer:function(val){ if (!val) return ""; return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }},
 			        {title:'证书失效期', name:'validEndTime'      , width: 250, align: 'center' ,renderer:function(val){ if (!val) return ""; return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }},
			        {title:'备注说明',   name:'remark'            , width: 250, align: 'center'},
			        {title:'证书附件',   name:'attachments'       , width: 250, align: 'center'},]; 
	
	
	
	$(document).ready(function(){
		init();
	});
	
	//初始化控件
	function init() {
	    $("button").button();
	    var gobalStr           = {"elsAccount":toElsAccount,"standardNumber":standardNumber,"standardItemNumber":standardItemNumber} ;
	     headGrid = $("#headTable").mmGrid({
			url         : "${pageContext.request.contextPath}/rest/SupplierDataService/queryStandardCertificateInfo/" ,
			method      : "POST",
			cols        : headCols,
			params      : gobalStr,
			height      : "400px",
			root        : "rows",
			loadingText : "正在载入",
			noDataText  : "暂无数据",
			checkCol    : true,
			indexCol    : false,
			plugins : [
				$("#headPage").mmPaginator({
					style           : "plain",
					totalCountName  : "total",
					page            :  1,
					pageParamName   : "currentPage",
					limitParamName  : "pageSize",
					limitLabel      : "每页{0}条",
					totalCountLabel : "共<span>{0}</span>条记录",
					limit           :  null,
					limitList       :  [10,20]
				})
			]
	});
	    //headGrid.load(gobalStr);
	}
	
	$("#addBtn").click(function(){
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'supplierCertificateInfo',
	        'windowTitle':'添加认证信息',
	        'iframSrc':'<%=basePath%>supplierstandard/data/addSupplierCertificateInfo.jsp?standardNumber='
        		+ standardNumber + '&standardItemNumber=' +standardItemNumber,
	        windowStatus: 'regular',
	        windowMinWidth: 500,
	        windowMinHeight: 530,
	        windowPositionTop:24,
	        'windowWidth':500,
	        'windowHeight':530,
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
		 var rowid = head[0].certificateId;
		parent.elsDeskTop.defineWin({
			'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
	        'windowsId':'supplierCertificateInfo',
	        'windowTitle':'修改认证信息',
	        'iframSrc':'<%=basePath%>supplierstandard/data/SupplierCertificateInfoUpd.jsp?standardNumber='
        		+ standardNumber + '&standardItemNumber=' +standardItemNumber
        		+"&certificateId="+ rowid,
	        windowStatus: 'regular',
	        windowMinWidth: 500,
	        windowMinHeight: 530,
	        windowPositionTop:24,
	        'windowWidth':500,
	        'windowHeight':530,
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
		var selectRows = headGrid.selectedRows();
		var selectRow = selectRows[0];
		if("undefied" != typeof(selectRows) && "[]" != selectRows && "" != selectRows){
			parent.elsDeskTop.tip.init({type:"confirm",message:"是否确认删除?",closeEvent:function(){
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/SupplierDataService/deleteStandardCertificateInfo",
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
			parent.elsDeskTop.tip.init({type : "alert",displayType : 2,message : "请选择删除认证信息!"});
		}
	});
</script>
</body>
</html>