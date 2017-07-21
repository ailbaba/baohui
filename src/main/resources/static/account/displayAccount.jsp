<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>

<%
String elsAccountNumber = request.getParameter("elsAccountNumber");
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
			<span id="updateSupplySpanId" class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_label_suppleInfoList" defaultValue="供应商信息列表" /></span>
			  <div id="updateSupplyFormId" class="common-box-line">
			    <table id="updateSupplyTableId">
			    	<tbody>
			    		<tr>
			    			<td colspan="5" align="right" style="width: 130px; max-width: 155px;"><i18n:I18n key="i18n_enterprise_elsAccount" defaultValue="ELS企业号" />：</td>
			    			<td colspan="5" align="left"><input id="elsAccountNumber" name="elsAccountNumber" type="text"  readonly = "readonly"></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_toElsAccount" defaultValue="邀请企业号" />：</td>
			    			<td colspan="5" align="left"><input id="toElsAccount" name="toElsAccount" type="text"  readonly = "readonly"/></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_sexElsAccount" defaultValue="邓白氏企业号" />：</td>
			    			<td colspan="5" align="left"><input id="sexElsAccount" name="sexElsAccount" type="text" readonly = "readonly"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_industry" defaultValue="行业大类" />：</td>
			    			<td colspan="5" align="left"><input id="industry" name="industry" type="text" readonly = "readonly"/></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<span>*</span><i18n:I18n key="i18n_enterprise_industryDetail" defaultValue="业务范围" />：</td>
			    			<td colspan="15" rowspan="2" align="left">
			    			<textarea id="industryDetail" name="industryDetail"  readonly = "readonly" style="width: 425px; max-width: 425px; height: 36px; resize: none; margin: 0px;" ></textarea>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_secondIndustry" defaultValue="行业中类" />：</td>
			    			<td colspan="25" align="left"><input id="secondIndustry" name="secondIndustry" type="text" readonly = "readonly"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_publicSupply" defaultValue="公布-对供应商" />：</td>
			    			<td colspan="15" align="left"><input id="publicSupply" name="publicSupply" type="text" style="width: 412px; max-width: 412px;" readonly = "readonly"/></td>
			    			<td colspan="10" align="left" rowspan="8">&nbsp;&nbsp;
			    				<!-- LOGO图 -->
			    				<img id = "logoImage" style="border: solid 0.5px #CCC; width: 257px; max-width: 257px; height: 200px;" src="<%=basePath%>images/starting_logo.gif" readonly = "readonly"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_publicClient" defaultValue="公布-对客户" />：</td>
			    			<td colspan="25" align="left"><input id="publicClient" name="publicClient" type="text" style="width: 412px; max-width: 412px;" readonly = "readonly"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_nature" defaultValue="企业性质" />：</td>
			    			<td colspan="5" align="left"><input id="nature" name="nature" type="text"  readonly = "readonly"/></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_erp" defaultValue="ERP系统" />：</td>
			    			<td colspan="15" align="left"><input id="erp" name="erp" type="text"  readonly = "readonly"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><span>*</span><i18n:I18n key="i18n_enterprise_fullName" defaultValue="企业全称" />：</td>
			    			<td colspan="25" align="left"><input id="fullName" name="fullName" type="text" style="width: 412px; max-width: 412px;" readonly = "readonly"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><span>*</span><i18n:I18n key="i18n_enterprise_shortName" defaultValue="企业简称" />：</td>
			    			<td colspan="25" align="left"><input id="shortName" name="shortName" type="text" style="width: 412px; max-width: 412px;" readonly = "readonly"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_website" defaultValue="公司网站" />：
							</td>
							<td colspan="15" align="left"><input id="website" name="website" type="text" readonly = "readonly" style="width: 412px; max-width: 412px;" /></td>
							<%-- 			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_businessRegisterNo" defaultValue="工商注册号" />：</td> --%>
							<!-- 			    			<td colspan="25" align="left"><input id="businessRegisterNo" name="businessRegisterNo" type="text" style="width: 407px; max-width: 407px;"/></td> -->
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="统一社会信用代码" />：</td>
			    			<td colspan="10" align="left"><input id="fbk3" name="fbk3" type="text"  readonly = "readonly" style="width: 240px; max-width: 240px;"/></td>
			    			<td colspan="10" align="left">&nbsp;&nbsp;
			    				<input id="fbk4" name="fbk4" type="hidden" /> 
			    				<button id="fbk4btn" class="button-wrap downLoadFileBtn" style="width: 50px;height: 23px;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="税务登记证" />：</td>
			    			<td colspan="10" align="left"><input id="revenueEnrolPlace" name="revenueEnrolPlace" type="text"  readonly = "readonly" style="width: 240px; max-width: 240px;"/></td>
			    			<td colspan="10" align="left">&nbsp;&nbsp;
			    				<input id="revenueEnrolFile" name="revenueEnrolFile" type="hidden" /> 
			    				<button id="revenueEnrolFilebtn" class="button-wrap downLoadFileBtn" style="width: 50px;height: 23px;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_organizationNo" defaultValue="组织机构码" />：</td>
			    			<td colspan="10" align="left"><input id="organizationNo" name="organizationNo" type="text"  readonly = "readonly" style="width: 240px; max-width: 240px;"/></td>
			    			<td colspan="10" align="left">&nbsp;&nbsp;
			    					<input id="organizationFile" name="organizationFile" type="hidden" />
									<button id="organizationFilebtn" class="button-wrap downLoadFileBtn" style="width: 50px;height: 23px;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
			    				
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_businessLicence" defaultValue="营业执照" />：</td>
			    			<td colspan="10" align="left"><input id="businessLicence" name="businessLicence" type="text"  readonly = "readonly" style="width: 240px; max-width: 240px;"/></td>
			    			<td colspan="10" align="left">&nbsp;&nbsp;
			    					<input id="businessLicenceFile" name="businessLicenceFile" type="hidden" />
									<button id="businessLicenceFilebtn" class="button-wrap downLoadFileBtn" style="width: 50px;height: 23px;"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
			    			</td>
			    			<td colspan="5" align="left">
			    				<input id="logo" name="logo" type="hidden" />
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><span>*</span><i18n:I18n key="i18n_enterprise_countryCode" defaultValue="国家" />：</td>
			    			<td colspan="5" align="left">
			    				<select id="countryCode" name="countryCode"   readonly = "readonly" style="width: 164px; max-width: 164px;">
					            </select>
			    			</td>
			    			<td colspan="5" align="right"><span>*</span><i18n:I18n key="i18n_enterprise_province" defaultValue="省份" />：</td>
			    			<td colspan="5" align="left">
			    				<select id="province" name="province"  readonly = "readonly" style="width: 164px; max-width: 164px;">
					            </select>
			    			</td>
			    			<td colspan="5" align="right"><span>*</span><i18n:I18n key="i18n_enterprise_city" defaultValue="城市" />：</td>
			    			<td colspan="5" align="left">
			    				<select  id="city" name="city"  readonly = "readonly"  style="width: 164px; max-width: 164px;">
					            </select>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_address" defaultValue="详细地址" />：</td>
			    			<td colspan="25" align="left"><input id="address" name="address" type="text"  readonly = "readonly" style="width: 688px; max-width: 688px;"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="test" defaultValue="电话/手机号码" />：</td>
			    			<td colspan="5" align="left"><input id="telphone" name="telphone" type="text" readonly = "readonly" /></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="i18n_enterprise_email" defaultValue="电子邮件" />：</td>
			    			<td colspan="15" align="left"><input id="email" name="email" type="text"  readonly = "readonly" style="width: 426px; max-width: 426px;"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_fax" defaultValue="传真" />：</td>
			    			<td colspan="5" align="left"><input id="fax" name="fax" type="text"  readonly = "readonly" /></td>
			    			<td colspan="5" align="right">&nbsp;&nbsp;<i18n:I18n key="test" defaultValue="联络人" />：</td>
			    			<td colspan="15" align="left"><input id="fbk2" name="fbk2" type="text"  readonly = "readonly"/></td>
			    		</tr>
			    		<tr>
			    			<td colspan="5" align="right"><i18n:I18n key="i18n_enterprise_parentElsAccount" defaultValue="上级ELS账号" />：</td>
			    			<td colspan="5" align="left"><input id="parentElsAccount" name="parentElsAccount" type="text" readonly="readonly"/></td>
			    			<td colspan="5" align="right"></td>
			    			<td colspan="5" align="left"></td>
			    			<td colspan="5" align="right"></td>
			    			<td colspan="5" align="left"></td>
			    		</tr>
			    	</tbody>
			    </table>
			  </div>
			</div>
		</div>
		
	<!-- 对话框 -->
<div class="fixed-dialog" id="addFileDialog">
           <div class="dialog-tip bg-common" style="width: 262px;height: auto; margin-left: -131px;margin-top: -190px;">
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
		//初始化控件
	    var fileUploader;
		var elsAccountNumber = '<%=elsAccountNumber%>';
	 
		$(function(){
		    initEnterpriseInfo(elsAccountNumber);
		    getEnterpriseLogo(elsAccountNumber);
		})
	
		//国家
		function showCountry(Country) {
			var country = Country;
			$.ajax({
				url: "<%=basePath%>rest/BaseInfoService/findAllCountry",
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function(data) {
					var countryCode = $("#countryCode");
					countryCode.empty();
					for (var i = 0; i < data.length; i++) {
						if(country==data[i].gj){
							var option = $("<option>").text(data[i].mc).val(data[i].gj)
							countryCode.append(option);
						}
					}
				}
			});
		}
		
		//省
		function showProvince(country,province) {
			var provinceCode = province;
			$.ajax({
				url: "<%=basePath%>rest/BaseInfoService/provices/" + country,
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function(data) {
					var province = $("#province");
					province.empty();
					for (var i = 0; i < data.length; i++) {
						if(provinceCode == data[i].aj){
							var option = $("<option>").text(data[i].mc).val(data[i].aj)
							province.append(option);
						}
						
					}
				}
			});
		}
		$("#countryCode").change(function(e) {
			//showProvince($(this).val());
		});

		//城市
		function showCity(province,city) {
			var cityCode = city;
			$.ajax({
				url: "<%=basePath%>rest/BaseInfoService/citys/" + province,
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function(data) {
					var city = $("#city");
					city.empty();
					debugger;
					for (var i = 0; i < data.length; i++) {
						if(cityCode == (data[i].aj + "_" + data[i].mc).trim()){
							var option = $("<option>").text(data[i].mc).val(data[i].aj + "_" + data[i].mc)
							city.append(option);
						}
						
					}
				}
			});
		}
		$("#province").change(function(e) {
			console.log($(this).val());
			//showCity($(this).val());
		});
		$("#city").change(function(e) {
			console.log($(this).val());
		});
		
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
		 	  	    // swf文件路径
		 	  	    swf: '<%=basePath%>jsLib/webuploader/Uploader.swf',
		 	  	    auto: true,
		 	  	    // 文件接收服务端。
		 	  	    server: '<%=basePath%>servlet/UploadServlet',
		 	  	    // 选择文件的按钮。可选。
		 	  	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		 	  	    pick: '#btnFileUpload',
		 	  	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		 	  	    resize: false,
		 	  	    formData : {
		 		     	elsAccount : elsAccount
		 		     }
		 	  	});
		 	  	
		 	  	fileUploader.on( 'uploadAccept', function( obj, response ) {
		 	  	   var filePath = response.url;
		 	  	   var fileType = filePath.substring(filePath.lastIndexOf('.')+1);
		 	  	   var test = id.replace('Test','');
		 	       $("#filePath").val(filePath);//页面显示url
		 	       $("#"+id).empty().append('<div style="color: red; width: 48px;"><i18n:I18n key="ac_up_done" defaultValue="已上载"/></div>');//上载成功标识
		 	       $("#"+test).val(filePath);//提交到数据库url
		 	      
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
	    })
	    
		
		//根据els号初始化 企业信息 
		function initEnterpriseInfo(data){
			var elsAccount = data;
			var params = {"elsAccount":elsAccount};
			parent.elsDeskTop.showLoading();
			$.ajax({
				url: "<%=basePath%>rest/AccountService/queryPurchaseEnquirySupplyByCondtion",
				type: "POST",
				contentType: "application/json",
				dataType: "json",
				data:JSON.stringify(params),
				success: function(data) {
					console.log(JSON.stringify(data));
					var enterpriseData = JSON.stringify(data);
					//console.log(data["shortName"]);
					//console.log(data);
					//console.log(data[0]);
					//将ajax信息一样插入到对应表格内 
					//或者将对应的data插入到隐藏json 里面 然后对应的将他提取 
					$("#elsAccountNumber").val(data["elsAccount"]);
					$("#toElsAccount").val(data["toElsAccount"]);
					$("#nature").val(data["nature"]);
					$("#fullName").val(data["fullName"]);
					$("#shortName").val(data["shortName"]);
					$("#address").val(data["address"]);
					$("#telphone").val(data["telphone"]);
					$("#fax").val(data["fax"]);
					$("#fbk2").val(data["fbk2"]);
					$("#erp").val(data["erp"]);
					$("#email").val(data["email"]);
					$("#website").val(data["website"]);
					$("#email").val(data["email"]);  
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
					 $("#fbk3").val(data["fbk3"]); 
					 
					 //初始化文件路径信息
					 $("#fbk4").val(data["fbk4"]); 
					 $("#revenueEnrolFile").val(data["revenueEnrolFile"]); 
					 $("#organizationFile").val(data["organizationFile"]); 
					 $("#businessLicenceFile").val(data["businessLicenceFile"]); 
					 
					 //默认查询国家省份方法 
					 var countryCode =  data["countryCode"];
					 var province = data["province"];
					 var city =  data["city"];

					 showCountry(countryCode);
					 showProvince(countryCode,province);
					 showCity(province,city);
	
					 var fbk1 = data["fbk1"];
					 //加载 logo  
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
				   
				},error : function(data) {
					alert("发送失败",3);
				},complete : function(data) {
					parent.elsDeskTop.hideLoading();
				}
			});
		}
		
		
		function  setCity(Country,province,city){
			var countryCode = Country;
			var province = province;
			var city = city;
			
			  $("#countryCode  option[value='" + countryCode +"'] ").attr("selected",true);
			  $("#province  option[value='" + province +"'] ").attr("selected",true);
			  $("#city  option[value='" + city +"'] ").attr("selected",true);
		}
		
		
		function  getEnterpriseLogo(elsAccount){
			$.ajax({
				url: "<%=basePath%>rest/AccountService/getEnterpriseLogo/" + elsAccount,
				type: "GET",
				contentType: "application/json",
				dataType: "json",
				success: function(data) {
					console.log(data);
					console.log("<%=basePath%> "  + data);
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
		
		//下载
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