<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="pos-relative public-wrap">
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
var grid;
var cols = [
            { title:'<i18n:I18n key="i18n_common_lable_ssss" defaultValue="操作人" />', name:'maker' ,width:120, align:'center'},
            { title:'<i18n:I18n key="gg" defaultValue="操作时间" />', name:'logtime' ,width:130, align:'center',renderer:function(val){
              	 if(!val)
           	     return "";
           	 else
           		 return new Date(val).format("yyyy-MM-dd hh:mm:ss"); }
            },
            { title:'<i18n:I18n key="i18n_ssss_xx" defaultValue="设计单历史状态" />', name:'orderStatus' ,width:120, align:'center',renderer:function(val){
        	 if (val==0) return "设计师新建文档";
        	 else if(val==1) return "采购分配供应商";
        	 else if(val==2) return "内部流程审核";
        	 else if(val==3) return "供应商处理";
        	 else if(val==4) return "完结";
        	 else if(val==5) return "作废";
        	 else return "";}
            },
            { title:'<i18n:I18n key="xx" defaultValue="操作" />', name:'cause' ,width:130, align:'center'},
            { title:'<i18n:I18n key="rr" defaultValue="备注" />', name:'remark' ,width:160, align:'center'}
          ];

$().ready(function(){
	init();
});
function init(){
	var height=$(document).height()-50;
	var data = {"elsAccount":elsAccount,"designNumber":designNumber};
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/DesignDocService/queryPurchaseDesignDocHis",
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