<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

<%
    String standardElsAccount = request.getParameter("standardElsAccount");
%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>

<style>
table tbody tr td{
  padding-top: 1px;
  padding-bottom: 1px;
}
</style>

<body>
	<div class="pos-relative public-wrap">
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
			<div class="common-box-line">
				<button id="UpdateBtn" class="button-wrap"><i18n:I18n key="i18n_button_save" defaultValue="保存" /></button>
				<button id="ResetBtn" class="button-wrap"><i18n:I18n key="i18n_button_reset" defaultValue="重置" /></button>
			</div>
		</div>
		<div class="box-wrap pos-relative bg-common">
			<span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_suppleInfoList" defaultValue="供应商信息列表" /></span>
			  <div class="common-box-line" id="updateSupplyFormId">
			    <table>
			    	<tbody>
			    		<tr>
			    			<td colspan="5" align="right" style="width: 130px; max-width: 155px;"><i18n:I18n key="i18n_enterprise_elsAccount" defaultValue="ELS企业号" />：</td>
			    			<td colspan="5" align="left"><input id="elsAccount" name="elsAccount" type="text" readonly = "readonly"></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_toElsAccount" defaultValue="邀请企业号" />：</td>
			    			<td colspan="5" align="left"><input id="toElsAccount" name="toElsAccount" type="text" /></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_sexElsAccount" defaultValue="邓白氏企业号" />：</td>
			    			<td colspan="5" align="left"><input id="sexElsAccount" name="sexElsAccount" type="text" /></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_industry" defaultValue="行业大类" />：</td>
			    			<td colspan="5" align="left"><input id="industry" name="industry" type="text" /></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<span style="color: red;">*</span><i18n:I18n key="i18n_enterprise_industryDetail" defaultValue="业务范围" />：</td>
			    			<td colspan="15" rowspan="2" align="left">
			    			<textarea id="industryDetail" name="industryDetail" style="width: 420px; max-width: 420px; height: 36px; resize: none; margin: 0px;" ></textarea>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_secondIndustry" defaultValue="行业中类" />：</td>
			    			<td colspan="25" align="left"><input id="secondIndustry" name="secondIndustry" type="text" /></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_publicSupply" defaultValue="公布-对供应商" />：</td>
			    			<td colspan="15" align="left"><input id="publicSupply" name="publicSupply" type="text" style="width: 407px; max-width: 407px;"/></td>
			    			<td colspan="10" align="left" rowspan="8">
			    			<!-- LOGO图 -->&nbsp;&nbsp;
			    				<img id = "logoImage" style="border: solid 0.5px #CCC; width: 257px; max-width: 257px; height: 200px;" src="<%=basePath%>images/starting_logo.gif"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_publicClient" defaultValue="公布-对客户" />：</td>
			    			<td colspan="25" align="left"><input id="publicClient" name="publicClient" type="text" style="width: 407px; max-width: 407px;"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_nature" defaultValue="企业性质" />：</td>
			    			<td colspan="5" align="left"><input id="nature" name="nature" type="text" /></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_erp" defaultValue="ERP系统" />：</td>
			    			<td colspan="15" align="left"><input id="erp" name="erp" type="text" /></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><span style="color: red;">*</span><i18n:I18n key="i18n_enterprise_fullName" defaultValue="企业全称" />：</td>
			    			<td colspan="25" align="left"><input id="fullName" name="fullName" type="text" style="width: 407px; max-width: 407px;"/></td>
			    		</tr>
						<tr>
							<td colspan="5" align="right"><span style="color: red;">*</span><i18n:I18n key="i18n_enterprise_shortName" defaultValue="企业简称" />：</td>
							<td colspan="25" align="left"><input id="shortName"	name="shortName" type="text"style="width: 407px; max-width: 407px;" /></td>
						</tr>
						<tr>
							<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_website" defaultValue="公司网站" />：
							</td>
							<td colspan="25" align="left"><input id="website" name="website" type="text" style="width: 407px; max-width: 407px;" /></td>
							<%-- 			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_businessRegisterNo" defaultValue="工商注册号" />：</td> --%>
							<!-- 			    			<td colspan="25" align="left"><input id="businessRegisterNo" name="businessRegisterNo" type="text" style="width: 407px; max-width: 407px;"/></td> -->
						</tr>
						<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="统一社会信用代码" />：</td>
			    			<td colspan="10" align="left"><input id="fbk3" name="fbk3" type="text" style="width: 240px; max-width: 240px;"/></td>
			    			<td colspan="10" align="left">
			    				&nbsp;&nbsp;
			    				<button id="fbk4Test" class="button-wrap uploadFileBtn"><i18n:I18n key="i18n_enterprise_file" defaultValue="附件" /></button>
			    				<input id="fbk4" name="fbk4" type="hidden" />
								<button id="fbk4btn" class="button-wrap downLoadFileBtn"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
			    			</td>
			    		</tr>
						<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="税务登记证" />：</td>
			    			<td colspan="10" align="left"><input id="revenueEnrolPlace" name="revenueEnrolPlace" type="text" style="width: 240px; max-width: 240px;"/></td>
			    			<td colspan="10" align="left">
			    				&nbsp;&nbsp;
			    				<button id="revenueEnrolFileTest" class="button-wrap uploadFileBtn"><i18n:I18n key="i18n_enterprise_file" defaultValue="附件" /></button>
			    				<input id="revenueEnrolFile" name="revenueEnrolFile" type="hidden" />
								<button id="revenueEnrolFilebtn" class="button-wrap downLoadFileBtn"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_organizationNo" defaultValue="组织机构码" />：</td>
			    			<td colspan="10" align="left"><input id="organizationNo" name="organizationNo" type="text" style="width: 240px; max-width: 240px;"/></td>
			    			<td colspan="10" align="left">
			    				&nbsp;&nbsp;
			    				<button id="organizationFileTest" class="button-wrap uploadFileBtn"><i18n:I18n key="i18n_enterprise_file" defaultValue="附件" /></button>
			    				<input  id="organizationFile" name="organizationFile" type="hidden" />
								<button id="organizationFilebtn" class="button-wrap downLoadFileBtn"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_businessLicence" defaultValue="营业执照" />：</td>
			    			<td colspan="10" align="left"><input id="businessLicence" name="businessLicence" type="text" style="width: 240px; max-width: 240px;"/></td>
			    			<td colspan="10" align="left">
			    				&nbsp;&nbsp;
			    				<button id="businessLicenceFileTest" class="button-wrap uploadFileBtn"><i18n:I18n key="i18n_enterprise_file" defaultValue="附件" /></button>
			    				<input  id="businessLicenceFile" name="businessLicenceFile" type="hidden" />
								<button id="businessLicenceFilebtn" class="button-wrap downLoadFileBtn"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
			    			</td>
			    			<td colspan="5" align="left">
			    				<button id="logoTest" class="button-wrap uploadFileBtn"><i18n:I18n key="i18n_enterprise_logo" defaultValue="企业LOGO上传" /></button>
			    				<input id="logo" name="logo" type="hidden" />
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><span style="color: red;">*</span><i18n:I18n key="i18n_enterprise_countryCode" defaultValue="国家" />：</td>
			    			<td colspan="5" align="left">
							    <div id="country"   els-dp></div>
							    <input type = "hidden"  id = "countryCode" name = "countryCode" style="border: solid 1px red;"/>
			    			</td>
			    			<td colspan="5" align="right"><span style="color: red;">*</span><i18n:I18n key="i18n_enterprise_province" defaultValue="省份" />：</td>
			    			<td colspan="5" align="left">
							    <div id="province"  els-dp></div>
							      <input type = "hidden"  id = "provinceCode" name = "province"/>
			    			</td>
			    			<td colspan="5" align="right"><span style="color: red;">*</span><i18n:I18n key="i18n_enterprise_city" defaultValue="城市" />：</td>
			    			<td colspan="5" align="left">
							    <div id="city" name = "city" els-dp></div>
							      <input type = "hidden"  id = "cityCode" name = "city"/>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><span style="color: red;">*</span><i18n:I18n key="i18n_enterprise_address" defaultValue="详细地址" />：</td>
			    			<td colspan="25" align="left"><input id="address" name="address" type="text" style="width: 676px; max-width: 676px;"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><span style="color: red;">*</span><i18n:I18n key="test" defaultValue="电话/手机号码" />：</td>
			    			<td colspan="5" align="left"><input id="telphone" name="telphone" type="text" /></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<span style="color: red;">*</span><i18n:I18n key="i18n_enterprise_email" defaultValue="电子邮件" />：</td>
			    			<td colspan="15" align="left"><input id="email" name="email" type="text" style="width: 420px; max-width: 420px;"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_fax" defaultValue="传真" />：</td>
			    			<td colspan="5" align="left"><input id="fax" name="fax" type="text" /></td>
			    			<td colspan="5" align="right"><span style="color: red;">*</span><i18n:I18n key="test" defaultValue="联络人" />：</td>
			    			<td colspan="5" align="left"><input id="fbk2" name="fbk2" type="text" /></td>
<%-- 			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_website" defaultValue="公司网站" />：</td> --%>
<!-- 			    			<td colspan="15" align="left"><input id="website" name="website" type="text" style="width: 420px; max-width: 420px;"/></td> -->
			    		</tr>
			    		<!-- <tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_admin" defaultValue="管理员姓名" />：</td>
			    			<td colspan="5" align="left"><input id="admin" name="admin" type="text" /></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_adminpassword" defaultValue="管理员密码" />：</td>
			    			<td colspan="5" align="left"><input id="adminpassword" name="adminpassword" type="password" /></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_confirmpassword" defaultValue="再次输入密码" />：</td>
			    			<td colspan="5" align="left"><input id="confirmpassword" name="confirmpassword" type="password" /></td>
			    		</tr> -->
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_parentElsAccount" defaultValue="上级ELS账号" />：</td>
			    			<td colspan="5" align="left"><input id="parentElsAccount" name="parentElsAccount" type="text" /></td>
			    			<td colspan="5" align="right" class="fbk5">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="系统公告栏" />：</td>
			    			<td colspan="15" align="left" class="fbk5"><input id="fbk5" name="fbk5" type="text" style="width: 420px; max-width: 420px;"/></td>
			    		</tr>
			    	</tbody>
			    </table>
			  </div>
			</div>
		</div>
	<!-- 对话框 -->
<div class="fixed-dialog" id="addFileDialog">
           <div class="dialog-tip bg-common" style="width: 270px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="i18n_select_the_file" defaultValue="选择文件" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <div class="input-and-tip"><span><i18n:I18n key="i18n_common_label_filename" defaultValue="文件名称" />：</span><input id="fileName" name="fileName" type="text" /></div>
	                       <div class="input-and-tip"><span><i18n:I18n key="i18n_common_label_filepath" defaultValue="文件路径" />：</span><input id="filePath" name="filePath" type="text" /></div>
	                       <div class="input-and-tip text-right">
		                       <span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_select_the_file" defaultValue="选择文件" /></div></span>
		                       <input id="fileType" name="fileType" type="hidden" />
	                       </div>
	                       <div class="mt-20 text-center">
	                          <button id="addFileBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_ok" defaultValue="确定" /></button>
		                      <button id="addFileBtnCancel" class="button-wrap"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>

	<script>
	
		/*window.beforeClose = function(close){
		    top.elsDeskTop.tip.init({
		        type            : 'confirm',
		        displayType     : 2, 
		        message         : '确认关闭?',
		        closeEvent : function () {
		           //callBack();
		           close();
		        }
		    });
		}; */
		//初始化控件
	    var fileUploader,country,province,city;
	    var standardElsAccount = "<%=standardElsAccount%>";
		var afterRender = function(){this.value=''};
	    if(standardElsAccount!=''&&standardElsAccount!=null&&standardElsAccount!='null')
	    elsAccount = standardElsAccount;
		
		$(function(){
			//迈腾-系统公告栏  @author jiangzhidong date @date 20161009 begin
			if('160000'!=elsAccount) $(".fbk5").empty();
			//迈腾-系统公告栏  @author jiangzhidong date @date 20161009 end
			country = document.querySelector('#country');
			province = document.querySelector('#province');
			city = document.querySelector('#city');
			country.kName  = 'gj';
			province.kName = 'aj';
			city.kName='ct';
			country.vName = province.vName = city.vName='mc';
			country.data=[{mc:'请选择国家',gj:''}];

			country.afterRender=afterRender;
			province.afterRender=afterRender;
			city.afterRender=afterRender;

			city.handler = function(d){
				if(d.aj)d.ct = (d.aj+'_'+ d.mc).replace(/^\s+|\s+$/,'');
			};
			country.onchange = function(){
				province.data=[{mc:'请选择省份',aj:''}];
				getAreaBy('province',this.value).done(function(data){
					if(Array.isArray(data)){
						province.data = province.data.concat(data);
					}
				})
			};
			province.onchange = function(){
				city.data=[{mc:'请选择城市',ct:''}];
				getAreaBy('city',this.value).done(function(data){
					if(Array.isArray(data)){
						city.data = city.data.concat(data);
					}
				})
			};

			getAreaBy('country').done(function(data){
				if(Array.isArray(data)){
					country.data=country.data.concat(data);
				}
			});

			  initEnterpriseInfo();
		});

		var areaApi={
			country:"<%=basePath%>rest/BaseInfoService/findAllCountry",
			province:"<%=basePath%>rest/BaseInfoService/provices/",
			city:"<%=basePath%>rest/BaseInfoService/citys/"
		};
		var getAreaBy = function(name,param){
			return ajaxWorker(areaApi[name]+(param||''),{
				type: "GET",
				contentType: "application/json",
				dataType: "json"
			})
		};

		//税务登记处,组织机构码,营业执照,企业LOGO上传
		$('.uploadFileBtn').live("click", function() {
			 clearAddFileInfo();
	         $("#addFileDialog").show();
	         initFileUploader(fileUploader,this.id);
	    });
		
		
		//关闭按钮处理
	     $("#dialogFileClose,#addFileBtnCancel").click(function(){
	    	clearAddFileInfo();
	     	$("#addFileDialog").hide();
	     });
			
		//文件上载初始化
	     function initFileUploader(fileUploader,id){
	 	    //新增表单文件
	 	    if (!fileUploader) {
		 	  	fileUploader = WebUploader.create({
		 	  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		 	  	    auto: true,
		 	  	    server: '<%=basePath%>servlet/UploadServlet',
		 	  	    pick: '#btnFileUpload',
		 	  	    resize: false,
		 	  	    formData: {
		 		     	elsAccount : elsAccount
		 		     }
		 	  	});
		 	  	
		 	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
		 	  	   var filePath = response.url;
		 	  	   var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
		 	  	   var test = id.replace('Test','');
		 	       $("#filePath").val(filePath);//页面显示url
		 	       $("#"+id).empty().append('<div style="color: red; width: 48px;">已上载</div>');//上载成功标识
		 	       $("#"+test).val(filePath);//提交到数据库url
		 	       if("logo"==test){
		 	    	  getEnterpriseLogo(filePath);
		 	 	   }
		 	  	});
		 	  	
		 	    // 当有文件添加进来的时候
		 		fileUploader.on("fileQueued",function(file){
		 			var fileName = file.name;
		 			$("#fileName").val(fileName);
		 			$("#fileType").val(file.ext);
		 		});
	 	    }
	 	}
		
	     //清空
	    function clearAddFileInfo(){
	     	$("#fileName").val("");
	     	$("#filePath").val("");
	     }
		
		//确认上载
	    $("#addFileBtnOK").click(function(){
	      	$("#addFileDialog").hide();
	    });
	    
		
		//调用后台注册供应商ajax
		$("#UpdateBtn").click(function(){
			var industryDetail = $('#industryDetail').val();
			var fullName = $('#fullName').val();
			var shortName = $('#shortName').val();
			var countryCode  = $("#country").val();
			$("#countryCode").val(countryCode);
			var provinceCode = $("#province").val();
			$("#provinceCode").val(provinceCode);
			var cityCode = $("#city").val();
			$("#cityCode").val(cityCode);
			var address = $("#address").val();
			var telphone = $("#telphone").val();
			var email = $("#email").val();
			var fbk2 = $("#fbk2").val();
			/*	var fbk4 = $("#fbk4").val();
			var businessLicenceFile = $("#businessLicenceFile").val();
			
			if((businessLicenceFile==''||businessLicenceFile==null)&&(fbk4==null||fbk4=='')){
				alert('<i18n:I18n key="test" defaultValue="“统一社会信用代码”与“营业执照”是二选一的必填项" />',2);
				return;
		    }*/
			
			if(industryDetail==null||industryDetail=='') {
				alert('<i18n:I18n key="test" defaultValue="业务范围必填项" />',2);
				$("#industryDetail").focus();
				return;
			}
			if(fullName==null||fullName=='') {
				alert('<i18n:I18n key="test" defaultValue="企业全称必填项" />',2);
				$("#fullName").focus();
				return;
			}
			if(shortName==null||shortName=='') {
				alert('<i18n:I18n key="test" defaultValue="企业简称必填项" />',2);
				$("#shortName").focus();
				return;
			}
			if(countryCode==null||countryCode=='') {
				alert('<i18n:I18n key="test" defaultValue="国家必填项" />',2);
				$("#countryCode").focus();
				return;
			}
			if(provinceCode==null||provinceCode=='') {
				alert('<i18n:I18n key="test" defaultValue="省份必填项" />',2);
				$("#provinceCode").focus();
				return;
			}
			if(cityCode==null||cityCode=='') {
				alert('<i18n:I18n key="test" defaultValue="城市必填项" />',2);
				$("#cityCode").focus();
				return;
			}
			if(telphone===null || telphone.length==0){
				 alert('<i18n:I18n key="" defaultValue="请输入电话/手机号码!" />',2);
				 $("#telphone").focus();
				 return;
			 }
			if(address===null || address.length==0){
				 alert('<i18n:I18n key="" defaultValue="请输入详细地址!" />',2);
				 $("#address").focus();
				 return;
			 }
			if(fbk2===null || fbk2.length==0){
				 alert('<i18n:I18n key="" defaultValue="请输入联络人!" />',2);
				 $("#fbk2").focus();
				 return;
			 }
			if(email===null || email.length==0){
				 alert('<i18n:I18n key="i18n_account_alert_emailRequired" defaultValue="请输入邮箱" />',2);
				 $("#email").focus();
				 return;
			 }
// 			else if(!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)){
// 				 alert('<i18n:I18n key="" defaultValue="电子邮箱格式不正确！" />',2);
// 				 $("#email").focus();
// 				 return;
// 			 }
			
			parent.elsDeskTop.tip.init({type: 'confirm',message:'<i18n:I18n key="i18n_label_confirmmodification" defaultValue="是否确认修改?" />',closeEvent:function(){
				//增加form表单序列化
				$("#updateSupplyFormId").wrap("<form id='updateSupplyForm'></form>");
					var paramStr = $("#updateSupplyForm").serializeJSON();
				    
					parent.elsDeskTop.showLoading();
					$.ajax({
			    		url: '<%=basePath%>rest/AccountService/updatePurchaseEnquirySupply',
			    		type:"post",
			    		contentType : "application/json",
			    		data: JSON.stringify(paramStr),
			    		dataType: "json",
			    		success: function(data) {
							if(data.statusCode==-100){
			    				alert(data.message,3);
			    			}else{
			    				alert('<i18n:I18n key="i18n_common_alert_updatesuccess" defaultValue="修改成功!" />',1);
			    			}
			    		},
			    		error: function(data) {
			    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
			    		},complete: function(data) {
			    			$("#updateSupplyFormId").unwrap();
			    			parent.elsDeskTop.hideLoading();
			    		}
			    		
			    	}); 
			}});
			
		});  
		
		
		//根据els号初始化 企业信息 
		function initEnterpriseInfo(){
			var params = {"elsAccount":elsAccount};
			$.ajax({
				url: "<%=basePath%>rest/AccountService/queryPurchaseEnquirySupplyByCondtion",
				type: "POST",
				contentType: "application/json",
				dataType: "json",
				data:JSON.stringify(params),
				success: function(data) {
					var firstLoad = function(c,k){
						var v = data[k];
						if(v)c.afterRender = function(){
							if(this.data.length>1){
								this.value = v;
								this.afterRender = afterRender;
							}
						};
						c.value=v;
					};

					firstLoad(country,'countryCode');
					firstLoad(province,'province');
					firstLoad(city,'city');

					 $("#elsAccount").val(data["elsAccount"]);
					 $("#toElsAccount").val(data["toElsAccount"]);
					 $("#nature").val(data["nature"]);
					 $("#fullName").val(data["fullName"]);
					 $("#shortName").val(data["shortName"]);
					 $("#address").val(data["address"]);
					 $("#telphone").val(data["telphone"]);
					 $("#fax").val(data["fax"]);
					 $("#erp").val(data["erp"]);
					 $("#email").val(data["email"]);
					 $("#website").val(data["website"]);
					 $("#industry").val(data["industry"]);
					 $("#secondIndustry").val(data["secondIndustry"]);
					 $("#industryDetail").val(data["industryDetail"]);
					 $("#sexElsAccount").val(data["sexElsAccount"]);
					 $("#publicSupply").val(data["publicSupply"]);
					 $("#publicClient").val(data["publicClient"]);
					 $("#businessRegisterNo").val(data["businessRegisterNo"]);
					 $("#businessLicence").val(data["businessLicence"]); 
					 $("#revenueEnrolPlace").val(data["revenueEnrolPlace"]); 
					 $("#organizationNo").val(data["organizationNo"]); 
					 $("#parentElsAccount").val(data["parentElsAccount"]); 
					 $("#revenueEnrolFile").val(data["revenueEnrolFile"]); 
					 $("#organizationFile").val(data["organizationFile"]); 
					 $("#businessLicenceFile").val(data["businessLicenceFile"]);
					 $("#fbk2").val(data["fbk2"]); 
					 $("#fbk3").val(data["fbk3"]); 
					 $("#fbk4").val(data["fbk4"]);
					 $("#fbk5").val(data["fbk5"]); //迈腾-系统公告栏  @author jiangzhidong date @date 20161009
					 if(data["revenueEnrolFile"]!=''&&data["revenueEnrolFile"]!=null)
					 $("#revenueEnrolFileTest").empty().append('<div style="width: 48px;">已上载</div>');
					 if(data["organizationFile"]!=''&&data["organizationFile"]!=null)
					 $("#organizationFileTest").empty().append('<div style="width: 48px;">已上载</div>');
					 if(data["businessLicenceFile"]!=''&&data["businessLicenceFile"]!=null)
					 $("#businessLicenceFileTest").empty().append('<div style="width: 48px;">已上载</div>');
					 if(data["fbk4"]!=''&&data["fbk4"]!=null)
					 $("#fbk4Test").empty().append('<div style="width: 48px;">已上载</div>'); 
					 
					 var fbk1 = data["fbk1"];
					 //处理logo图片 @authoer jiangzhidong 20151215
					 if(fbk1!=null&&fbk1!=""){
						 var basePath = '<%=basePath%>';
						 var path = '<%=path%>';
						 var pathNum = basePath.lastIndexOf(path);
						 logoPath = basePath.substring(0, pathNum);
						 //windows
						 fbk1 = fbk1.substring(fbk1.lastIndexOf(':')+1);
						 $("#logoImage").attr("src",logoPath+fbk1);
						 //linux
						 //$("#logoImage").attr("src",logoPath+fbk1);
					 }
				   
				},
				error : function(data) {
	    			alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
	    		}
			});
		}
		
	 	//重置
		$("#ResetBtn").click(function(){
			initEnterpriseInfo();
		}); 
	 	
	 	//处理图片URL
	 	function getEnterpriseLogo(logoURL){
			$.ajax({
				url: "<%=basePath%>rest/AccountService/doLogoURL?logoURL="+logoURL,
				type: "POST",
				contentType: "application/json",
				dataType: "text",
				success: function(data) {
					  fbk1 = data;
					  //处理logo图片 @authoer jiangzhidong 20151215
					  if(fbk1!=null&&fbk1!=""){
						 var basePath = '<%=basePath%>';
						 var path = '<%=path%>';
						 var pathNum = basePath.lastIndexOf(path);
						 logoPath = basePath.substring(0, pathNum);
						 //windows
						 fbk1 = fbk1.substring(fbk1.lastIndexOf(':')+1);
						 $("#logoImage").attr("src",logoPath+fbk1);
						 //linux
						 //$("#logoImage").attr("src",logoPath+fbk1);
					  }
				},
				error : function(data) {
					alert('<i18n:I18n key="i18n_delivery_syserror" defaultValue="系统异常!" />',3);
	    		}
		 	});
	 	}
	 	
	 	//中英文长度截取
		var cutstr = function(str,len){ 
		        var newLength = 0; 
		        var newStr = ""; 
		        var chineseRegex = /[^\x00-\xff]/g; 
		        var singleChar = ""; 
		        var strLength = str.replace(chineseRegex,"**").length; 
		        for(var i = 0;i < strLength;i++) { 
		                singleChar = str.charAt(i).toString(); 
		                if(singleChar.match(chineseRegex) != null) { 
		                        newLength += 2; 
		                }else { 
		                        newLength++; 
		                } 
		                if(newLength > len) { 
		               /*  if(newLength > len) {  */
		                        break; 
		                } 
		                        newStr += singleChar; 
		        } 
		        if(strLength > len) { 
		                newStr += ".："; 
		        } 
		        return newStr; 
		}
		        
		var language='<%=session.getAttribute("language") %>';
		
		if(language=="en"){
			//按钮提示
			$('table tbody tr td[align="right"]').not('.none-title').each(function(i,b){
					var txt = $(b).text();
					if(txt && txt.length) {
						b.title=b.title||$(b).text();
						$(b).text(cutstr(txt,9));
					}
			   });
		}
		
		//下载 @author jiangzhidong  @date 20160217
		$('.downLoadFileBtn').live("click", function() {
			var id = this.id.replace('btn','');
    		var filePath = $("#"+id).val();
    		if(filePath==''||filePath==null){
    			alert('附件为空,不能下载!',2);
    	 		return;
    		}
		    window.location.href = "<%=basePath%>" + "servlet/downloadServlet?filePath=" + filePath;
    	 });
		
		
		</script>
</body>
</html>