<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_conditionquery" defaultValue="条件查询" /></span>
            <div class="common-box-line">
               <form id="I18nForm" action="../../rest/I18nService/findI18nKeyContent" method="post">
					<input type="hidden" id="pageSize"    name="pageSize"    value="20" >
					<input type="hidden" id="currentPage" name="currentPage" value="1"  >
					<input type="hidden" id="language"    name="language"    value=""   >
                <div class="dis-in-b input-and-tip">
			       <span><i18n:I18n defaultValue="资源Key" key="i18n_common_title_key"/></span><input id="key" name="key" style="width:200px;"/>
		        </div>
				<div class="dis-in-b input-and-tip">
					<span><i18n:I18n key="i18n_common_title_Value" defaultValue="资源Value:" /></span>
					<input type="text" id="value" name="value" />
				</div>
		        <div class="dis-in-b input-and-tip">
			        <i18n:I18n defaultValue="语言选择：" key="i18n_common_title_language"/><select class="" id="language" name="language">
			        										<option value=""><i18n:I18n defaultValue="默认" key="i18n_label_default"/></option>
															<option value="en"><i18n:I18n defaultValue="英语" key="i18n_common_title_en"/></option>
															<option value="zh_cn"><i18n:I18n defaultValue="简体" key="i18n_common_title_zh_cn"/></option>
															<option value="zh_tw"><i18n:I18n defaultValue="繁體" key="i18n_common_title_zh_tw"/></option>
															<option value="ja"><i18n:I18n defaultValue="日语" key="i18n_common_title_ja"/></option>
															<option value="ko"><i18n:I18n defaultValue="韩语" key="i18n_common_title_ko"/></option>
															<option value="fr"><i18n:I18n defaultValue="法语" key="i18n_common_title_fr"/></option>
															<option value="ru"><i18n:I18n defaultValue="俄语" key="i18n_common_title_ru"/></option>
															<option value="de"><i18n:I18n defaultValue="德语" key="i18n_common_title_de"/></option>
															<option value="es"><i18n:I18n defaultValue="西班牙语" key="i18n_common_title_es"/></option>
															<option value="pt"><i18n:I18n defaultValue="葡萄牙语" key="i18n_common_title_pt"/></option>
															<option value="it"><i18n:I18n defaultValue="意大利语" key="i18n_common_title_it"/></option>
															<option value="el"><i18n:I18n defaultValue="希腊语" key="i18n_common_title_el"/></option>
															<option value="nl"><i18n:I18n defaultValue="荷兰语" key="i18n_common_title_nl"/></option>
															<option value="sv"><i18n:I18n defaultValue="瑞典语" key="i18n_common_title_sv"/></option>
															<option value="ar"><i18n:I18n defaultValue="阿拉伯语" key="i18n_common_title_ar"/></option>
															<option value="lwa_cs"><i18n:I18n defaultValue="捷克语" key="i18n_common_title_lwa_cs"/></option>
															<option value="lwa_da"><i18n:I18n defaultValue="丹麦语" key="i18n_common_title_lwa_da"/></option>
															<option value="lwa_fi"><i18n:I18n defaultValue="芬兰语" key="i18n_common_title_lwa_fi"/></option>
															<option value="lwa_no"><i18n:I18n defaultValue="挪威语" key="i18n_common_title_lwa_no"/></option>
															<option value="lwa_bg"><i18n:I18n defaultValue="保加利亚语" key="i18n_common_title_lwa_bg"/></option>
															<option value="lwa_fa"><i18n:I18n defaultValue="波斯语" key="i18n_common_title_lwa_fa"/></option>
															<option value="lwa_ha"><i18n:I18n defaultValue="豪萨语" key="i18n_common_title_lwa_ha"/></option>
															<option value="lwa_he"><i18n:I18n defaultValue="希伯来语" key="i18n_common_title_lwa_he"/></option>
															<option value="lwa_hi"><i18n:I18n defaultValue="印地语" key="i18n_common_title_lwa_hi"/></option>
															<option value="lwa_hu"><i18n:I18n defaultValue="匈牙利语" key="i18n_common_title_lwa_hu"/></option>
															<option value="lwa_ps"><i18n:I18n defaultValue="普什图语" key="i18n_common_title_lwa_ps"/></option>
															<option value="lwa_pl"><i18n:I18n defaultValue="波兰语" key="i18n_common_title_lwa_pl"/></option>
															<option value="lwa_ro"><i18n:I18n defaultValue="罗马尼亚语" key="i18n_common_title_ro"/></option>
															<option value="lwa_sr"><i18n:I18n defaultValue="塞尔维亚语" key="i18n_common_title_sr"/></option>
															<option value="lwa_th"><i18n:I18n defaultValue="泰语" key="i18n_common_title_th"/></option>
															<option value="lwa_tr"><i18n:I18n defaultValue="土耳其语" key="i18n_common_title_tr"/> </option>
															<option value="lwa_ur"><i18n:I18n defaultValue="乌尔都语" key="i18n_common_title_ur"/></option>
					</select>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="btnQuery" iconCls="icon-search"  onclick="queryAccountInfo()" class="button-wrap"><i18n:I18n key="i18n_common_button_query" defaultValue="查  询" /></button>
                </div>

                <div class="dis-in-b input-and-tip">
                     <button id="addAccountInfo" class="button-wrap" ><i18n:I18n defaultValue="增加" key="i18n_common_button_create"/></button>
                </div>
                
		        <div class="dis-in-b input-and-tip">
                     <button id="updateAccountInfo" class="button-wrap"><i18n:I18n defaultValue="修改" key="i18n_common_button_update"/></button>
                </div>
                
                <div class="dis-in-b input-and-tip">
                     <button id="deleteAccountInfo" class="button-wrap"><i18n:I18n defaultValue="删除" key="i18n_common_button_remove"/></button>
                </div>
                
                <div class="dis-in-b input-and-tip">
                     <button id="excelModelExport" class="button-wrap"><i18n:I18n defaultValue="Excel模板下载" key="i18n_common_button_downloadexceltemplate"/></button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="excelImport" class="btn btnUpload" style="height: 24px;line-height:24px;"><i18n:I18n defaultValue="Excel导入" key="i18n_common_button_excelImport"/></button>
                </div>
                
                <div class="dis-in-b input-and-tip">
                     <button id="translationManage" class="button-wrap"><i18n:I18n defaultValue="翻译管理" key=""/></button>
                </div>
           </div>
        </div>
        
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_informationbrowsing" defaultValue="信息浏览" /></span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="I18nList"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
        
</div>
<script>

var accountGrid;
var excelUploader      ; //上传Excel控件 
var elsAccount	  = '<%=session.getAttribute("elsAccount") %>' ;
$(document).ready(function(){
	init();
	initExcelUploader();
});	      
function init(){	
	var frm = $("#I18nForm");
	var accountCols = [
                        {title:'<i18n:I18n defaultValue="语言" key="i18n_js_language"></i18n:I18n>', name:'language' , width:80, align:'center'},
                        { title:'<i18n:I18n defaultValue="资源Key" key="i18n_common_title_key"></i18n:I18n>', name:'key' , width:100, align:'center'},
                        { title:'<i18n:I18n defaultValue="资源Value" key="i18n_common_title_value"></i18n:I18n>', name:'value' ,width:90, align:'center'}
                        ];	 
	accountGrid=$('#I18nList').mmGrid({
        cols: accountCols,
	    url: '<%=basePath%>rest/I18nService/findI18nKeyContent',
	    params: frm.serializeJSON(),
	    height: 450,
	    method: 'post',
	    root: 'rows',
	    loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	    indexCol: true,
	    checkCol:true,
	    fullWidthRows:true,
	    multiSelect:true,
	    plugins: [
              $('#pg').mmPaginator({
                    style: 'plain'
                  , totalCountName: 'total'
                  , page: 1
                  , pageParamName: 'currentPage'
                  , limitParamName: 'pageSize'
                  , limitLabel: '<i18n:I18n key="i18n_common_mmgrid_limitlabel" defaultValue="每页{0}条"/>'
                  , totalCountLabel: '<i18n:I18n key="i18n_common_mmgrid_totalcountlabel" defaultValue="共<span>{0}</span>条记录"/>'
                  , limit: null
                  , limitList: [10,15,20]
              })
          ]
	});
};


function queryAccountInfo() {
	var frm = $("#I18nForm");
	accountGrid.opts.params = frm.serializeJSON();
	accountGrid.load();
}
//查询
$("#btnQuery").click(function() {
	queryAccountInfo();
});
//增加
$("#addAccountInfo").click(function() {
	parent.elsDeskTop.defineWin({
	  'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
      'windowsId':'addI18n',
      'windowTitle':'<i18n:I18n defaultValue="添加资源" key="i18n_label_add_key"/>',
      'iframSrc':'<%=basePath%>systemset/I18n/addI18n.jsp',        
       windowStatus: 'regular',
       windowMinWidth: 350,
       windowMinHeight: 420,
       windowPositionTop:24,
      'windowWidth':350,
      'windowHeight':420,
      'parentPanel':".currDesktop"
  });
});

//修改
$("#updateAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var url='<%=basePath%>systemset/I18n/editI18n.jsp?language='+selectRow[0].language+'&key='+selectRow[0].key+'&value='+selectRow[0].value;
	parent.elsDeskTop.defineWin({
		'iconSrc':'icon/destop-icon/desktop_icon_101.gif',
        'windowsId':'editI18n',
        'windowTitle':'<i18n:I18n defaultValue="编辑" key="i18n_label_edit_I18n"/>',
        'iframSrc':url,
         windowStatus: 'regular',
         windowMinWidth: 500,
         windowMinHeight: 500,
         windowPositionTop:24,
        'windowWidth':500,
        'windowHeight':500,
        'parentPanel':".currDesktop"
    });
});
//删除
$("#deleteAccountInfo").click(function() {
	var selectRow = accountGrid.selectedRows();
	if(selectRow.length < 1){
		parent.elsDeskTop.tip.init({type: 'alert',displayType:0,message:'<i18n:I18n defaultValue="请选择需要操作的数据！" key="i18n_common_alert_mustchoosealine"/>'});
		return;
	}
	var key=selectRow[0].key;
	var language=selectRow[0].language;
	parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n defaultValue="确认删除?" key="i18n_common_alert_confirmdelete"/>',closeEvent:function(){
		$.ajax({
			url :"<%=basePath%>rest/I18nService/deleteResourceByKey/"+key+"/"+language,
			type :"get",
			contentType : "application/json",
			data : {},
			dataType : "json",
			success : function(data) {
				parent.elsDeskTop.tip.init({type: 'alert',displayType:1,message:'<i18n:I18n defaultValue="删除成功" key="i18n_common_alert_deletesuccess"></i18n:I18n>'});
				queryAccountInfo();   
			},
			error : function(data) {
				parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n defaultValue="请求出错" key="i18n_common_alert_requestfail"></i18n:I18n>'});
			}
		});
	}});
});


//模板下载
$("#excelModelExport").click(function(e){
	e.preventDefault();
	debugger;
	var nkey      = "-";
	var nlanguage = "-";
	if ($("#key").val() != '' && $("#key").val() != null )
	    nkey = $("#key").val() ;			
	if ($("#language").val() != '' && $("#language").val() != null )
	    nlanguage = $("#language").val() ;
	window.location.href = "../../rest/I18nService/downloadTemplate/" + elsAccount + "/" + nkey + "/" + nlanguage;
});

function initExcelUploader()
{
if(!excelUploader){
	excelUploader = WebUploader.create({
		swf       : '<%=basePath%>jsLib/webuploader/Uploader.swf',
		auto      : true                                 ,
		duplicate : true                                 ,
		accept    : {  extensions:"xls,xlsx"   }         ,
		server    : '<%=basePath%>servlet/UploadServlet' ,
		pick      : '#excelImport'                       ,
		resize    : false                                ,
		formData  : {  elsAccount : elsAccount }
	});
	excelUploader.on( 'uploadAccept', function( obj, response ) {
		var filePath = response.url               ;
		parent.elsDeskTop.showLoading('正在导入') ;
		$.ajax({ url         : "../../rest/I18nService/i18nExcelImport/" + elsAccount + "?filePath="  + filePath,
				 type        : "POST"             ,
				 contentType : "application/json" ,
				 dataType    : "json"             ,
				 data        : ""                 ,
				 success     : function(data) {
					 if(data.statusCode=="-100"){
						parent.elsDeskTop.hideLoading() ;
						parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : data.message});
					 }else{
						parent.elsDeskTop.hideLoading() ;
					 }
				 } ,
				 error: function (data) {
					parent.elsDeskTop.hideLoading()     ;
					parent.elsDeskTop.tip.init({type : 'alert',displayType : 3,message : "系统错误！"});
				 }
		});
	});
}
}	


$("#translationManage").click(function() {
	parent.elsDeskTop.defineWin({
        iconSrc : "icon/icon9.png",
        windowsId : "translationManage",
        windowTitle : "<i18n:I18n defaultValue='翻译管理' key=''/>",
        iframSrc : "${pageContext.request.contextPath}/systemset/I18n/translationManage.jsp",
        showAdv : true,
        windowStatus : "maximized",
        windowMinWidth : 960,
        windowMinHeight : 700,
        windowWidth : 960,
        windowHeight : 700,
        parentPanel : ".currDesktop"
    });
});

</script>

</body>
</html>