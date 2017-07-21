<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
<div class="box-wrap pos-relative bg-common">
    <div class="common-box-line">
		列表供应商相应状态说明：<span id="supplierStatus"></span>。
		第一位"<span id="first"></span>"表示供应商总数。
                       第二位"<span id="second"></span>"表示【已接受】供应商数量。
                       第三位"<span id="third"></span>"表示【未处理】供应商数量。
                       第四位"<span id="forth"></span>"表示【已拒绝】供应商数量。
    </div>
</div>
<div class="box-wrap pos-relative bg-common">
    <div class="common-box-line">
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table"></table>
                    </div>
                </main>
    </div>
</div>
</div>
<script type="text/javascript">
var designNumber = "<%=request.getParameter("designNumber")%>";
var supplierStatus = "<%=request.getParameter("supplierStatus")%>";
var first = supplierStatus.substring(0,supplierStatus.indexOf('('));
var temp = supplierStatus.substring(supplierStatus.indexOf('(')+1,supplierStatus.indexOf(')'));
var second = temp.split("/")[0];
var third = temp.split("/")[1];
var forth = temp.split("/")[2];
var grid;
var cols = [
            { title:'<i18n:I18n key="i18n_common_lable_masssr" defaultValue="供应商名称" />', name:'companyShortName' ,width:142, align:'center'},
            { title:'<i18n:I18n key="i18n_ssss_name" defaultValue="处理状态" />', name:'statusConfirm' ,width:120, align:'center',renderer:function(val){
           	 if (val==0) return "未处理";
        	 else if(val==1) return "已接受";
        	 else if(val==2) return "已拒绝";
        	 else return "";}
            },
            { title:'<i18n:I18n key="gg" defaultValue="处理时间" />', name:'logtime' ,width:130, align:'center',renderer:function(val){
           	 if(!val)
        	     return "";
        	 else
        		 return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }
            },
            { title:'<i18n:I18n key="rr" defaultValue="备注" />', name:'fbk1' ,width:140, align:'center'}
          ];

$().ready(function(){
	$("#supplierStatus").text(supplierStatus);
	$("#first").text(first);
	$("#second").text(second);
	$("#third").text(third);
	$("#forth").text(forth);
	init();
});
function init(){
	var height=$(document).height()-135;
	var data = {"elsAccount":elsAccount,"designNumber":designNumber};
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/DesignDocService/queryAssignedSupplierList",
        params: data,
        method: "POST",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:height
    });
}
</script>
</body>
</html>