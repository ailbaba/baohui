<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<body>
<style type="text/css">
	.edit-sub-title {
    display: inline-block;
	width: 70px;
	padding-left: 20px;
	padding-top: 20px;
	text-align: right;
	}
</style>
<form id="editI18nForm" action="" method="post">
		<div class="input-and-tip text-left ">
			<span class="edit-sub-title"><i18n:I18n key="i18n_common_title_key" defaultValue="资源Key:" /></span>
			<input style="max-width:100%;" type="text"  readonly="readonly" enabled =false id="key" name="key" />
		</div>
		<div class="input-and-tip text-left">
			<span class="edit-sub-title"><i18n:I18n key="i18n_common_title_Value" defaultValue="资源Value:" /></span>
			<input style="max-width:100%;"   type="text" id="value" name="value" />
		</div>
		<div class="input-and-tip text-left">
        <span class="edit-sub-title"><i18n:I18n key="i18n_common_title_language"   defaultValue="语言选择:" /></span>
			<select class="" id="language"  name="language">
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
<div style="text-align: center; padding: 10px">
    <button id="editSubAccountOK" class="button-wrap" ><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
    <button id="closeWin" class="button-wrap" ><i18n:I18n key="i18n_common_button_cancel" defaultValue="关闭 " /></button>
</div>
<script type="text/javascript">
var tlanguage ="<%=request.getParameter("language") %>";
var tkey ="<%=request.getParameter("key") %>";
var tvalue ="<%=request.getParameter("value") %>";
$(document).ready(function(){
	 init(); 
	$("#editSubAccountOK").click(function(){
		var key=$("#key").val();
		var value=$("#value").val();
		 if(key===null || key.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_KeyRequired" defaultValue="请输入资源Key" />',2);
			 $("#key").focus();
			 return;
		 }
		 if(value===null || value.length==0){
			 alert('<i18n:I18n key="i18n_account_alert_ValueRequired" defaultValue="请输入资源Value" />',2);
			 $("#value").focus();
			 return;
		 }
		 var frm = $("#editI18nForm");
		 $.ajax({
				url :"../../rest/I18nService/updateResource",
				type :"POST",
				contentType : "application/json",
				data : JSON.stringify(frm.serializeJSON()),
				dataType : "json",
				success : function(data) {
					if(data.statusCode == "-100"){
						alert(data.message,3);
					}else{
						alert('<i18n:I18n key="i18n_delivery_updatesuccess" defaultValue="修改成功" />',1);
						setTimeout(function(){				     
							closeWin();
						 }, "1000"); 
					}					
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				}
			});		 
	});
	
	$("#closeWin").click(function(){
		closeWin();
	});
	
	function closeWin(){
		parent.frames['iframeApp_i18nService'].queryAccountInfo();
        parent.elsDeskTop.closeCurWin('editI18n');

	}
	
});    

function init(){
	$.ajax({
			url :"../../rest/I18nService/getResourceByKey/"+tkey+"/"+tlanguage,
			type :"GET",
			contentType : "application/json",
			dataType : "json", 
			success : function(data) { 
				$("#language").val(tlanguage);
				$("#key").val(tkey);
				$("#value").val(tvalue);
			},
			error : function(data) {
				alert('<i18n:I18n key="i18n_common_alert_requestfail" defaultValue="请求出错" />',3);
				
			}
		}); 
}

</script>
</body>
</html>