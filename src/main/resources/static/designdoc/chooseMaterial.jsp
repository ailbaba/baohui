<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<div class="box-wrap pos-relative bg-common">
<%-- <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span> --%>
     <form style="margin:0;" id="form" onsubmit="return false;">
          <input type="hidden" name="elsAccount" value="${elsAccount}"/>
          <div class="common-box-line">
             <div class="dis-in-b input-and-tip"><span class="text-right w-72">物料编号：</span><input name="materialNumber" type="text"/></div>
             <div class="dis-in-b input-and-tip"><span class="text-right w-72">物料名称：</span><input name="materialName" type="text"/></div>
             <button id="queryBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查询" /></button>
          </div>
     </form>
</div>
<div class="box-wrap pos-relative bg-common">
<%--     <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_material_list" defaultValue="物料列表" /></span> --%>
         <div class="common-box-line">
            	<main class="grid-container">
                    <div class="grid-100">
                        <table id="table"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
         </div>
 </div>
<script type="text/javascript">
var grid;
var cols = [
            { title:'<i18n:I18n key="i18n_common_lable_materialnumber" defaultValue="物料编号" />', name:'materialNumber' ,width:120, align:'center'},
            { title:'<i18n:I18n key="i18n_material_name" defaultValue="物料名称" />', name:'materialName' ,width:120, align:'center'},
            { title:'<i18n:I18n key="gg" defaultValue="尺寸" />', name:'fbk3' ,width:120, align:'center'},
            { title:'<i18n:I18n key="rr" defaultValue="材质工艺" />', name:'fbk4' ,width:120, align:'center'},
            { title:'<i18n:I18n key="rr" defaultValue="版次" />', name:'fbk8' ,width:120, align:'center'}
          ];

$().ready(function(){
	init();
});
function init(){
	var height=$(document).height()-150;
	var frm = $("#form");
	grid = $('#table').mmGrid({
        cols: cols,
        url : "<%=basePath%>rest/MaterialService/queryMaterialList",
        params: frm.serializeJSON(),
        method: "POST",
        root:"rows",
        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入" />',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据" />',
        height:height,
        plugins: [
                  $('#pg').mmPaginator({
                      style: 'plain'
                      , totalCountName: 'total'
                      , page: 1
                      , pageParamName: 'currentPage'
                      , limitParamName: 'pageSize'
                      , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条" />'
                      , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录" />'
                      , limit:null
                      , limitList: [10,20]
                  })
              ]
    });
    grid.on('cellSelected',function(e, item, rowIndex, colIndex){
    	parent.elsDeskTop.closeCurWin('chooseMaterial',closeCallback(item));
	});
    
    $("#queryBtn").click(function(){
    	query();
    });
}

function query() {
	var frm = $("#form");
	grid.opts.params = frm.serializeJSON();
	grid.load({});
}

function closeCallback(item){
 	if (parent.frames["iframeApp_createDesignDoc"]) {
		parent.frames["iframeApp_createDesignDoc"].fillMaterialInfo(item);
	}
}
</script>
</body>
</html>