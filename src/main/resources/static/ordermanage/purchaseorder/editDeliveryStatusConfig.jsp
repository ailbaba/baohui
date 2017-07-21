<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
	<div class="pos-relative">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
			<div class="common-box-line">
				<button class="button-wrap" id="saveBtn">保存</button>
			</div>
		</div>

		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common">表格项明细</span>
			<div class="common-box-line">
				<main class="grid-container">
				<form id="form" onsubmit="return false;">
				<input type="hidden" id="elsAccount" name="elsAccount" />
				<div class="edit-box-wrap">
					<button id="addBtn" class="button-wrap">添加</button>
					<button id="deleteBtn" class="button-wrap">删除</button>
				</div>
				<div class="grid-100" id="planStatusGrid">
					<table id="planStatusTable"></table>
				</div>
				</form>
				</main>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$("#elsAccount").val(elsAccount);
	
	var itemGrid;
	var height=$(document).height()-140;
	var blackItem={"elsAccount":elsAccount,"configType":"","daysStart":"","daysEnd":"","numStart":"","numEnd":"","deliveryStatus":""};
	var itemCols = [
	                {title:'序号', name:'sortOrder', width: 100, align: 'center', renderer:function(val,item,rowIndex){
	             	    if (!val) {val = "";}
	            	    return "<span class='showText'>" + (rowIndex+1) + "</span>" + "<input name='deliveryStatusConfigList[][sortOrder]' type='text' class='sortInput' style='display:none' value='"+(rowIndex+1)+"'/>";
	                 }},
		        {title:'els账号', name:'elsAccount', width: 100, align: 'center', renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<span class='showText'>" + val + "</span>" + "<input name='deliveryStatusConfigList[][elsAccount]' type='text' class='elsAccountInput' style='display:none' value='"+elsAccount+"'/>";
                 }},
		        { title:'配置类型', name:'configType' ,width:80, align:'center' , renderer:function(val){
             	    if (!val) {val = "";}
             	   return "<select name='deliveryStatusConfigList[][configType]' class='configTypeSelect' valAttr='"+val+"' >"+
		        	"<option value='1' >时间</option> <option value='2' >数量</option></select>";
                 }},
		        { title:'差异天数从', name:'daysStart' ,width:120, align:'center' , renderer:function(val){
             	    if (!val) {val = "";}
            	    return "<input name='deliveryStatusConfigList[][daysStart]' type='text' class='dateType' value='"+val+"'/>";
                 }},
		        { title:'差异天数到', name:'daysEnd' ,width:120, align:'center', renderer:function(val){
             	    if (!val) {val = "";}
            	    return  "<input name='deliveryStatusConfigList[][daysEnd]' type='text' class='dateType'  value='"+val+"'/>";
                 } },
		        { title:'差异数量从(%)', name:'numStart' ,width:120, align:'center',renderer:function(val){
					if (!val) {val = "";}
				    return  "<input  name='deliveryStatusConfigList[][numStart]' type='text' class='numType' readonly='readonly' value='"+val+"'/>";
				}},
		        { title:'差异数量到(%)', name:'numEnd' ,width:120, align:'center' ,renderer:function(val){
		        	if (!val) {val = "";}
				    return  "<input  name='deliveryStatusConfigList[][numEnd]' type='text' class='numType' readonly='readonly' value='"+val+"'/>";

		        }},
		        { title:'显示状态', name:'deliveryStatus' ,width:80, align:'center',renderer:function(val){
		        	if (!val) {val = "";}
		        	return "<select name='deliveryStatusConfigList[][deliveryStatus]' class='dataTypeSelect' valAttr='"+val+"' >"+
		        	"<option value='1' >红灯</option> <option value='2' >黄灯</option> <option value='3' >绿灯</option></select>";
		        }}];
	
	$().ready(function(){
		itemGrid=$('#planStatusTable').mmGrid({
	 		cols : itemCols,
	 		items : [],
	 		height:height,
	 		multiSelect: true,
	 		checkCol : true,
	 		loadingText : '正在载入',
	 		noDataText : '暂无数据',
	 	});
		
		//查询
		query();
		
		//添加计划状态配置项
		$("#addBtn").click(function(){
			addItem();
		});
		
		//删除计划状态配置项
		$("#deleteBtn").click(function(){
			removeItem();
		});
		
		//保存
		$("#saveBtn").click(function(){
			save();
		});
		
	});
	
	//获取计划状态
	function query(){
		var param={"elsAccount":elsAccount};
		$.ajax({url :"<%=basePath%>rest/PurchaseOrderService/getDeliveryStatusConfig",
			 	type : "post",
			 	dataType : "json",
			 	contentType : "application/json",
			 	data : JSON.stringify(param),
			 	success : function(data) {
			 		if(data!=null&&data.statusCode=="-100"){
			 			alert(data.message,2);
			 		}else{
			 			itemGrid.removeRow();
			 			itemGrid.addRow(data.deliveryStatusConfigList);
			 			init();
			 		}
			 	itemGrid.on('loadSuccess', function(e, dat) {
			 		init(data);
			 	});
			 },
			 error : function(data) {
			 	alert("系统异常",3);
			 }
		});
	}
	
	//添加计划状态配置项
	function addItem(){
		itemGrid.addRow(blackItem);
		init();
	}
	
	//删除计划状态配置项
	function removeItem(){
		var trItem=$("#planStatusTable").find(".selected");
		if(trItem.length<=0){
			alert("请选择操作项！",2);
			return;
		}
		trItem.remove();
		
		var rowCount=$("#planStatusTable").find("tr").length;
		if(rowCount<=0){
			$(".mmg-message").css("display","block");
		}
	}
	
	//初始化
	function init(){
		//初始化下拉框
		$("#planStatusTable").find("td").each(function(){
			var selectObj=$(this).find("select");
			if(selectObj.length>0){
				var val=selectObj.attr("valAttr");
				var idName=selectObj.attr("class");
				selectObj.find("option[value='"+val+"']").attr("selected",true);
				if(idName=="configTypeSelect"){
					changeType(selectObj);
				}
			}
		});
		
		//添加配置类型改变事件
		$(".configTypeSelect").change(function(){
			changeType(this);
		});
	}
	
	function changeType(obj){
		var selectedVal=$(obj).find("option:selected").val();
		if(selectedVal=="1"){//时间
			$(obj).parent().parent().parent().find(".dateType").removeAttr("readonly");
			$(obj).parent().parent().parent().find(".numType").attr("readonly","readonly");
			$(obj).parent().parent().parent().find(".numType").val("");
		}else if(selectedVal=="2"){//数量
			$(obj).parent().parent().parent().find(".numType").removeAttr("readonly");
			$(obj).parent().parent().parent().find(".dateType").attr("readonly","readonly");
			$(obj).parent().parent().parent().find(".dateType").val("");
		}
	}
	
	//保存
	function save(){
		if(!check()){
			return;
		}
		parent.elsDeskTop.tip.init({type: 'confirm',message:'是否确认保存？',closeEvent:function(){
			var url = "<%=basePath%>rest/PurchaseOrderService/updateDeliveryStatusConfig";
			var frm = $("#form");
			$.ajax({
				url :url,
				type :"post",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					if(data!=null&&data.statusCode=="-100"){
						alert(data.message,2);
					}else{
						alert("保存成功！");
					}
				},
				error : function(data) {
					alert("系统异常",3);
				}
			});
		}});
	}
	
	function check(){
		var tag=false;
		$(".numType").each(function(){
			var attr=$(this).attr("readonly");
			if(attr!="readonly"){//如果是需要输入的
				var val=$(this).val();
				if(!val||val==""){
					var sortNum=$(this).parent().parent().parent().find(".sortInput").val();
					alert("请填写第"+sortNum+"行数量差的项!",2);
					tag=true;
					return false;
				}
				var pattern =/^([+-])?([1-9][0-9])?([0-9])?([0])?(.[0-9]{1,2})?$/ ;
				if (!pattern.test(val)) {
					var sortNum=$(this).parent().parent().parent().find(".sortInput").val();
					alert("第"+sortNum+"行数量差百分比只能输入最多包含两位小数的数字！",2);
					tag=true;
					return false;
				}
			}
		});
		if(tag){
			return false;
		}
		
		$(".dateType").each(function(){
			var attr=$(this).attr("readonly");
			if(attr!="readonly"){//如果是需要输入的
				var val=$(this).val();
				if(!val||val==""){
					var sortNum=$(this).parent().parent().parent().find(".sortInput").val();
					alert("请填写第"+sortNum+"行日期差的项!",2);
					tag=true;
					return false;
				}
				var pattern = /^([+-])?([1-9][0-9]*)?([0])?$/ ;
				if (!pattern.test(val)) {
					var sortNum=$(this).parent().parent().parent().find(".sortInput").val();
					alert("第"+sortNum+"行日期差数只能输入整数！",2);
					tag=true;
					return false;
				}
			}
		});
		if(tag){
			return false;
		}
		return true;
	}
	
</script>
</html>