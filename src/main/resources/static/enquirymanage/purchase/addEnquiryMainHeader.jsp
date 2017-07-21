<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<style type="text/css" media="screen">  
html, body   { height:100%; }  
body { margin :0; padding:0; overflow:auto ; }    
#flashContent { display :none; } 

.progress{
		margin-top:2px;
	    width: 200px;
	    height: 14px;
	    margin-bottom: 10px;
	    overflow: hidden;
	    background-color: #f5f5f5;
	    border-radius: 4px;
	    -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
	    box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
	}
	.progress-bar{ 
		background-color: rgb(92, 184, 92);
		background-image: linear-gradient(45deg, rgba(255, 255, 255, 0.14902) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, 0.14902) 50%, rgba(255, 255, 255, 0.14902) 75%, transparent 75%, transparent);
		background-size: 40px 40px;
		box-shadow: rgba(0, 0, 0, 0.14902) 0px -1px 0px 0px inset;
		box-sizing: border-box;
		color: rgb(255, 255, 255);
		display: block;
		float: left; 
		font-size: 12px;
		height: 20px;
		line-height: 20px;
		text-align: center;
		transition-delay: 0s;
		transition-duration: 0.6s;
		transition-property: width;
		transition-timing-function: ease;
		width: 266.188px;
	} 
</style>
<body>
  <div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
        <button class="button-wrap" id="publishEnquiry"><i18n:I18n key="i18n_common_button_issue" defaultValue="发布" /></button>
        <button class="button-wrap" id="saveEnquiry"><i18n:I18n key="" defaultValue="保存" /></button>
		&nbsp;&nbsp;&nbsp;
		<div class="dis-in-b input-and-tip">
			<input type="checkbox" id="isAlibabaPublish" name="isAlibabaPublish" value="1688" checked="checked" />
			<span><i18n:I18n key="" defaultValue="发布到阿里巴巴" /></span>
		</div>
			<!-- <button class="button-wrap" id="loadHisSupplier"><i18n:I18n key="" defaultValue="加载供应商" /></button>
        <button class="button-wrap isShowQuote" id="loadSupplierQuota"><i18n:I18n key="" defaultValue="加载配额" /></button> -->
    </div>
</div>
<form id="purchaseEnquiryForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
 <div class="box-wrap pos-relative bg-common">
	 <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></span>
	 <input id="orderSendStatus" name="orderSendStatus" type="hidden" />
	 <div class="common-box-line">
	     <div class="dis-in-b input-and-tip">
			<span>询价单号：</span><input id="purchaseEnquiryNumber" name="purchaseEnquiryNumber" type="text" readonly/>
		 </div>
		 <div class="dis-in-b input-and-tip"> 
		 			<span><i18n:I18n key="i18n_enquiry_label_enquirytype" defaultValue="询价单类型" />：</span>
					<select class="" id="orderType" name="orderType" >
						<!-- <option value="0"><i18n:I18n key="i18n_enquiry_select_enquirytype_market" defaultValue="行情询价" /></option> -->
						<option value="1" selected="selected"><i18n:I18n key="i18n_enquiry_select_enquirytype_material" defaultValue="物料询价" /></option>
						<!-- <option value="2"><i18n:I18n key="i18n_enquiry_select_enquirytype_texture" defaultValue="材质询价" /></option> -->
					</select>
		</div>
		 <div class="dis-in-b input-and-tip">
		    <span><i18n:I18n key="i18n_enquiry_label_enquirydate" defaultValue="供询价日期" />：</span>
		    <input type="text" class="Wdate" onfocus="WdatePicker({minDate: '%y-%M-%d' })" id="beginDate" name="beginDate"/>
		 </div>
         <div class="dis-in-b input-and-tip">
            <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
            <input type="text"  class="Wdate" onfocus="WdatePicker({minDate: '%y-%M-%d'  })" id="endDate" name="endDate"/>
         </div>
         
          <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_purchasegroup" defaultValue="采购组" />：</span><input id="purchaseGroup" name="purchaseGroup" type="text" style="width:200px;"/>
		 </div>
		 <div class="dis-in-b input-and-tip">
			<!-- <span><i18n:I18n key="i18n_common_label_purchaseorganization" defaultValue="采购组织" />：</span> --><input id="purchaseOrganization" name="purchaseOrganization" type="hidden" style="width:200px;" value="1010"/>
		 </div>
		 <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_describe" defaultValue="描述" />：</span><input id="enquiryDesc" name="enquiryDesc" type="text" style="width:200px;"/>
		 </div>
         <div class="dis-in-b input-and-tip pos-relative">
            <span><i18n:I18n key="i18n_enquiry_label_principal" defaultValue="负责人" />：</span><input id="FBK4" name="FBK4" type="text"  readonly style="width:279px;max-width:279px;padding-right:20px;" />
            <img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 7px;cursor: pointer;" id="queryPrincipal" title="查找负责人" />
	     </div>	
	    
	 </div>
</div>

<div class="tab-wrap tab-wrap-change" id="add-enq-sheet">
    <ul>
        <li><a href="#edit-line-one"><i18n:I18n key="i18n_enquiry_title_formlineitem" defaultValue="表单行项目" /></a></li>
        <li class="add-file-sheet"><a href="#edit-line-two"><i18n:I18n key="i18n_enquiry_title_formfile" defaultValue="表单文件" /></a></li>
        <li class="add-supplier-sheet"><a href="#edit-line-three"><i18n:I18n key="i18n_enquiry_title_supplierinformation" defaultValue="供应商信息" /></a></li>
        <li class="supplier-isShow"><a href="#edit-line-four"><i18n:I18n key="" defaultValue="供应商配额" /></a></li>
    </ul>
    <div class="p-zero" id="edit-line-one">
        <main class="bg-common p-6">
            <div class="edit-box-wrap" style="padding-top: 5px;">
                 <%-- <button id="addPurchaseEnquiry" class="button-wrap"><i18n:I18n key="i18n_common_button_fromerp" defaultValue="从ERP获取" /></button> --%>
                <button id="btnManuAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_handworkAddition" defaultValue="手工添加" /></button>
                <button id="btnQueryTexture" class="button-wrap ishowTexture"><i18n:I18n key="" defaultValue="选择材质" /></button>
                <button id="btnQueryMaterial" class="button-wrap ishowMaterial"><i18n:I18n key="" defaultValue="选择物料" /></button>
                <button id="excelImport" class="btn btnUpload" style="height: 24px;line-height:24px;"><span><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></span></button>
                <button id="downloadTemplate" class="button-wrap"><i18n:I18n key="i18n_common_button_downloadexceltemplate" defaultValue="Excel模板下载" /></button>
                <button id="batchSetBtn" class="button-wrap"><i18n:I18n key="" defaultValue="批量设置" /></button>
                <button id="columnDefineBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_columncustom" defaultValue="列自定义" /></button>
                <button id="btnManuDel" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button>
           		<button id="btnGetPLMFile" class="button-wrap"><i18n:I18n key="" defaultValue="获取PLM文件" /></button>
           		<button id="removeFile" class="button-wrap"><i18n:I18n key="" defaultValue="移除附件" /></button>
            </div>
            <div class="grid-100" id="reCreate">
                <table id="add-enq-project"></table>
            </div>
        </main>
    </div>
    <div class="p-zero" id="edit-line-two">
        <div class="box-wrap pos-relative bg-common">
		            <div class="common-box-line p-zero">
		                <div class="pos-relative upload-wrap">
		                    <div class="pos-absolute file-list">
								<div class="file-list-head" id="file-list-head"><span><i18n:I18n key="i18n_common_label_filetype" defaultValue="文件类型" /></span>
			                       <select class="" id="selectFileType" name="selectFileType" >
				                   </select>
				                 </div>
								<main class="grid-container">
									<div class="grid-100" id="reCreateFile">
										<table id="add-file-project"></table>
									</div>
								</main>
		                    </div>
			                 <div class="file-scan">
	   							<div class="file-option-zoom">
				                  <div class="dis-in-b text-left">
						             <button id="addFileBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                                     <button id="deleteSelectBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button>
                                     <!-- <button id="deleteBtn" class="btn" >保存</button>
                                     <button id="sendBtn" class="btn">发送</button> -->
						         </div>
							     </div>
							     <div class="file-display" id="file-display">
							     	<a id="viewerPlaceHolder"></a>
							     </div>
							</div>
					</div>
					</div>
		 </div>
    </div>
    <div class="p-zero" id="edit-line-three">
    <div class="box-wrap pos-relative bg-common">
		            <div class="common-box-line p-zero">
		                <div class="pos-relative upload-wrap">
		                    <div class="pos-absolute file-list">
							    <main class="bg-common p-6">
						            <div class="edit-box-wrap" style="padding-top: 5px;">
						                <button id="btnAddSupplie" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
						                <button id="btnDelSupplie" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button>
						            </div>
						            <div class="grid-100" >
						                <table id="add-supplie-project"></table>
						            </div>
						        </main>
		                    </div>
			                 <div class="file-scan">
	   							 <!-- 替代料 @author jiangzhidong @date 20160622 begin -->
	   							  <!-- <div class="edit-box-wrap" style="padding-top: 10px;padding-bottom: 0px;">
	   							  <button id="queryMaterialReplace" class="button-wrap"><i18n:I18n key="test" defaultValue="替代物料供应商信息" /></button>
						          </div> -->
						         <main class="bg-common p-6">
						            <div class="grid-100" style="padding-left: 20px;">
						                <table id="query-material-replace-table"></table>
						            </div>
						        </main>
						        <!-- 替代料 @author jiangzhidong @date 20160622 end -->
							</div>
					</div>
					</div>
		 </div>
    </div>
    <div class="p-zero" id="edit-line-four">
        <main class="bg-common p-6">
            <%-- <div class="edit-box-wrap" style="padding-top: 5px;">
                 <button id="btnAddSupplie" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                <button id="btnDelSupplie" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button>
            </div> --%>
            <div class="grid-100" >
                <table id="supplie-quota"></table>
            </div>
        </main>
    </div>
  </div>
</form>
<div class="fixed-dialog supplie-groud" >
           <div class="dialog-tip bg-common contacts-box">
               <div class="dialog-close-btn" id="contactClose"></div>
               <div class="tip-head pos-relative">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="i18n_common_title_addcontact" defaultValue="添加供应商" /></span>
                   <button class="button-wrap sure-selct" style="position: absolute;right: 44px;top: 11px;"><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
               </div>
               <div class="box-wrap pos-relative bg-common">
               <!-- <span class="dis-in-b pos-absolute" style="left: 16px;">可添加供应商列表：</span> -->
               <input class="dis-in-b pos-absolute contact-search" type="text" style="left: 16px;width: 220px;max-width: 220px;padding-right: 20px;" placeholder="输入查找关键字" />
               <img class="dis-in-b pos-absolute" src="../../img/icon_search.png" style="width:14px; left: 244px;top:14px;" />
               <span class="dis-in-b pos-absolute" style="left: 345px;"><i18n:I18n key="i18n_common_title_alreadyaddcontact" defaultValue="已添加的供应商列表" />：</span>
                   <div class="fl-left box-left mt-27"></div>
                   <div class="fl-left box-middle mt-27">
                        <p class="all-pre text-center">
                            <button class="contact-option-btn button-wrap" title="全部右移" >>></button>
                        </p>
                        <p class="all-back text-center">
                            <button class="contact-option-btn button-wrap"  title="全部左移" ><<</button>
                        </p>
                    </div>
                   <div class="fl-left box-right mt-27"></div>
                   <div class="clear-both"></div>
               </div>
           </div>
</div>
<!-- 添加文件弹出框 -->
<div class="fixed-dialog" id="addFileDialog">
           <div class="dialog-tip bg-common" style="width: 362px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="dialogFileClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="i18n_common_title_chooseformfile" defaultValue="选择表单文件" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                       <div class="common-box-line">
                           <div class="input-and-tip"><span><i18n:I18n key="i18n_common_label_filename" defaultValue="文件名称" />：</span><input id="fileName" style="max-width: 248px; width: 248px;" name="fileName" type="text" /></div>
	                       <div class="input-and-tip"><span><i18n:I18n key="i18n_common_label_filepath" defaultValue="文件路径" />：</span><input id="filePath" style="max-width: 248px; width: 248px;" name="filePath" type="text" /></div>
	                       <div id="ossfile"></div>
	                       <div class="input-and-tip text-right">
		                       <span><div id="btnFileUpload" class="btn btnUpload"><i18n:I18n key="i18n_common_button_chooseformfile" defaultValue="选择表单文件" /></div></span>
		                       <input id="fileType" name="fileType" type="hidden" />
	                       </div>
	                       <div class="mt-20 text-center">
	                          <button id="addFileBtnOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                      <button id="addFileBtnCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
                       </div>
                   </div>
               </div>
        </div>
</div>


<!-- 选择责任人弹出框 -->
<div class="fixed-dialog" id="selectPrincipalDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height:auto;margin-left: -215px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectPrincipalDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectPrincipalDialog"><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择" /></span>
	    </div>
	    <div class="box-wrap">
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filtercondition" defaultValue="过滤条件" /></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td width="80px"><input  type="text" id="principalName" name="principalName" /></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="select-principal-table"></table>
                    </div>
                    <div class="text-center" style="margin-top: 14px;">
	                    <button id="btnSelectPrincipalOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnSelectPrincipalCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>



<!-- 设置成本组成弹出框 -->
<div class="fixed-dialog" id="selectCostConstituteTemplateItemDialog">
	<div class="dialog-tip bg-common" style="width: 630px;height: 403px;margin-left: -315px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectCostConstituteTemplateItemDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleCostConstituteTemplateItemDialog"><i18n:I18n key="test" defaultValue="成本组成设置"/></span>
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" style="border-bottom-left-radius: 0;border-bottom-right-radius: 0;">
	            <input type="hidden" id ="costConstitute_materialNumber"/>
	            <input type="hidden" id ="costConstitute_materialDesc"/>
	            <input type="hidden" id ="costConstituteTemplateJson"/>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td width="100px"><button id="btnSelectCostConstituteTemplate" class="button-wrap"><i18n:I18n key="i18n_coststructure_button_selecttemplate" defaultValue="模板选择" /></button></td>
	                	    <td width="110px"><button id="btnCustomAdd" class="button-wrap"><i18n:I18n key="i18n_coststructure_button_customadd" defaultValue="自定义添加" /></button></td>
	                	    <td width="110px"><button id="btnRemoveCostConstituteItem" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button></td>
	                	    <td width="50px"></td>
	                	    <td width="200px"><span style="font-size: 8px;"><i18n:I18n key="i18n_coststructure_label_savetemplate" defaultValue="保存到模板库 " /></span>&nbsp;<input type="checkbox" id="checkboxCostConstitute" disabled></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="cost-constitute-template-item-table"></table>
                    </div>
                    <div class="mt-40 text-center" >
	                    <button id="btnCostConstituteTemplateItemOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnCostConstituteTemplateItemCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<!-- 选择成本组成项模板弹出框 -->
<div class="fixed-dialog" id="selectCostConstituteTemplateDialog" >
	<div class="dialog-tip bg-common" style="width: 530px;height: 403px;margin-left: -205px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectCostConstituteTemplateDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectCostConstituteTemplateDialog"><i18n:I18n key="i18n_coststructure_title_selecttemplate" defaultValue="请选报价组成模板" /></span>
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filtercondition" defaultValue="过滤条件" /></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td width="80px"><input  type="text" id="costTemplateNumber" name="costTemplateNumber" /></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="cost-constitute-template-table"></table>
                    </div>
                    <div class="mt-40 text-center" >
	                    <button id="btnCostConstituteTemplateOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnCostConstituteTemplateCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>

<!-- 添加成本组成项弹出框 -->
<div class="fixed-dialog" id="customCostConstituteTemplateDialog" >
	<div class="dialog-tip bg-common" style="width: 400px;height: 153px;margin-left: -205px;margin-top: -170px;">
	    <div class="dialog-close-btn" id="btnCustomCostConstituteTemplateDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleCustomCostConstituteTemplateDialogDialog"><i18n:I18n key="i18n_coststructure_title_customaddcostitem" defaultValue="自定义添加成本组成项" /></span>
	    </div>
	    <div class="" style="background-color: #fdfdfd;">
	        <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                	    <td  class="tb-p"><i18n:I18n key="i18n_coststructure_label_costitemcode" defaultValue="成本项目代码" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="costItemCode" /></td>
	                	</tr>
	                	<tr class="line-height-tr">
	                	    <td  class="tb-p"><i18n:I18n key="i18n_coststructure_label_costitemname" defaultValue="成本项目名称" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="costItemName" /></td>
	                	</tr>
	                </table>
	          </div>
	        <div class="box-wrap pos-relative bg-common text-center" >
	                    <button id="btncustomCostConstituteTemplateOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btncustomCostConstituteTemplateCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	        </div>
	    </div>
    </div>
</div>
<!-- 保存成本组成模板弹出框 -->
<div class="fixed-dialog" id="addcustomCostConstituteTemplateNameDialog" >
	<div class="dialog-tip bg-common" style="width: 400px;height: 153px;margin-left: -205px;margin-top: -170px;">
	    <div class="dialog-close-btn" id="btnAddcustomCostConstituteTemplateNameClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleaddcustomCostConstituteTemplateNameDialog"><i18n:I18n key="i18n_coststructure_title_customaddcostitem" defaultValue="自定义添加成本组成项" /></span>
	    </div>
	    <div class="" style="background-color: #fdfdfd;">
	        <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                	    <td  class="tb-p"><i18n:I18n key="i18n_coststructure_label_templatename" defaultValue="模板名称" />:</td>
	                		<td><input class="easyui-textbox" type="text" id="costTemplateDesc" /></td>
	                	</tr>
	                </table>
	          </div>
	        <div class="box-wrap pos-relative bg-common text-center" >
	                    <button id="btnaddcustomCostConstituteTemplateNameOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnaddcustomCostConstituteTemplateNameCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	        </div>
	    </div>
    </div>
</div>
<!-- 批量设置弹出框 -->
<div class="fixed-dialog" id="batchSetDialog">
           <div class="dialog-tip bg-common" style="width: 362px;height: auto; margin-left: -131px;margin-top: -190px;">
               <div class="dialog-close-btn" id="batchSetClose"></div>
               <div class="tip-head">
                   <img class="icon" src="../../icon/els.PNG" />
                   <span class="dialogTitle"><i18n:I18n key="" defaultValue="批量设置" /></span>
               </div>
               <div class="">
                   <div class="box-wrap pos-relative bg-common" style="padding-bottom: 10px;">
                     <form id="batchSetForm" onsubmit="return false;">
                       <div class="common-box-line" >
                           <div class="input-and-tip">
                               <span>报价方式：</span>
                               <select name="quoteMethod" id="batchSet_quoteMethod">
                                   <option value="0">常规报价</option>
                                   <option value="1">阶梯报价</option>
                               </select>
                               <button id="setLadder" class="button-wrap "><i18n:I18n key="" defaultValue="设置阶梯" /></button>
                           </div>
<!-- 	                       <div class="input-and-tip"> -->
<!-- 	                         <span>计价单位：</span> -->
<!-- 	                         <input class="easyui-textbox"  name="priceQuantity" id="batchSet_priceQuantity" type="text" /> -->
<!-- 	                         <img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 117px;top: 61px;cursor: pointer;" id="queryPriceQuantity" title="查找计价单位" /> -->
<!-- 	                       </div> -->
<!-- 	                       <div class="input-and-tip"> -->
<!-- 	                         <span>计量单位：</span> -->
<!-- 	                         <input class="easyui-textbox"  name="unitQuantity" id="batchSet_unitQuantity" type="text" /> -->
<!-- 	                         <img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 117px;top: 92px;cursor: pointer;" id="queryUnitQuantity" title="查找计量单位" /> -->
<!-- 	                       </div> -->
	                       <div class="input-and-tip deliveryDate-show">
	                         <span>需求日期：</span>
	                         <input name="deliveryDate" id="batchSet_deliveryDate" class="Wdate" onfocus="WdatePicker()" type="text" />
	                       </div>
	                       <div class="input-and-tip">
	                         <span>需求数量：</span>
	                         <input name="quantity" id="batchSet_quantity" type="text" />
	                       </div>
	                       <div class="mt-20 text-center">
	                          <button id="batchSetOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
		                      <button id="batchSetCancel" class="button-wrap "><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                       </div>
	                     </form>
                       </div>
                   </div>
               </div>
        </div>
</div>
<!-- 设置阶梯报价弹出框 -->
<div class="fixed-dialog" id="setLadderPriceDialog" >
	<div class="dialog-tip bg-common" style="width: 580px;height: 448px;margin-left: -315px;margin-top: -250px;">
	    <div class="dialog-close-btn" id="btnsetLadderPriceDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleLadderPriceDialog"><i18n:I18n key="test" defaultValue="物料阶梯设置"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common">
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_ladderprice_title_ladderset" defaultValue="阶梯设置" /></span>
	            <input type="hidden" id ="ladderPrice_purchaseOrderNumber"/>
	            <input type="hidden" id ="ladderPrice_orderItemNumber"/>
	            <input type="hidden" id ="ladderPrice_materialNumber"/>
	            <input type="hidden" id ="ladderPrice_materialDesc"/>
	            <input type="hidden" id ="materialLineJson"/>
	            <input type="hidden" id ="materialLineJson_ladder"/>
	            <input type="hidden" id ="materialRowIndex"/>
	            <input type="hidden" id ="oldMaterialRowIndex"/>
	            <input type="hidden" id ="materialLineJson-File"/>
	            <input type="hidden" id ="fileTableJson"/>
	            <input type="hidden" id ="publicFileTableJson"/>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td ><i18n:I18n key="i18n_ladderprice_label_quantity" defaultValue="数量" />:</td>
	                		<td width="40px"><input class="" type="text" id="beginNumber" value="1" onkeyup="value=value.replace(/[^(\d)]/g,'')"  readonly= "readonly"/></td>
	                		<td class="tb-p"><i18n:I18n key="i18n_ladderprice_label_quantityto" defaultValue="到" />:</td>
	                		<td width="40px"><input class="" type="text" id="endNumber" onkeyup="value=value.replace(/[^(\d)]/g,'')"/></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common">
	            <main class="bg-common p-6">
                    <div class="edit-box-wrap">
                      <button id="btnAddLadderPrice" class="button-wrap"><i18n:I18n key="i18n_common_button_addition" defaultValue="添加" /></button>
                      <button id="btnDelLadderPrice" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="删除" /></button>
                    </div>
                    <div class="grid-100" >
                        <table id="add-ladder-price-table"></table>
                    </div>
                    <div class="mt-40 text-center" >
	                    <button id="btnAddLadderPriceOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnAddLadderPriceCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>
<!-- 选择计量单位弹出框 -->
<div class="fixed-dialog" id="selectUnitOfMeasurementDialog" >
	<div class="dialog-tip bg-common" style="width: 430px;height: 383px;margin-left: -205px;margin-top: -270px;">
	    <div class="dialog-close-btn" id="btnSelectUnitOfMeasurementClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleSelectUnitOfMeasurementDialog"><i18n:I18n key="i18n_common_title_pleasechoose" defaultValue="请选择计量单位" /></span>
	        <input type="hidden" id ="price_index"/>
	        <input type="hidden" id ="price_materialLineJson"/>
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_filtercondition" defaultValue="过滤条件" /></span>
	            <div class="common-box-line">
	                <table>
	                	<tr class="line-height-tr">
	                		<td width="80px"><input  type="text" id="unitName" name="unitName" /></td>
	                	</tr>
	                </table>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="unit-of-measurement-table"></table>
                    </div>
                    <div class="mt-20 text-center" >
	                    <button id="btnUnitOfMeasurementOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnUnitOfMeasurementCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
    </div>
</div>

<!-- 材质询价选择材质信息 -->
<div class="fixed-dialog" id="selectTextureDialog" >
	<div class="dialog-tip bg-common" style="width: 630px;height: 403px;margin-left: -205px;margin-top: -270px;">
	  <div class="dialog-close-btn" id="btnSelectTextureDialogClose"></div>
       <form id="selectTextureForm" onsubmit="return false;">
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" ><i18n:I18n key="" defaultValue="请选材质信息" /></span>
		    <input type="hidden" id="pageSize" name="pageSize" value="20">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
		    <input type="hidden" id="fbk1" name="fbk1" value="CZ">	
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="查询条件" /></span>
	            <div class="common-box-line">
	               <div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料编码/名称" />：</span>
						<input id="materialNumber" name="materialNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料组" />：</span>
						<input id="materialGroup" name="materialGroup" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<button id="queryTexture" class="button-wrap "><i18n:I18n key="" defaultValue="查询" /></button>
					</div>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="query-texture-table"></table>
                        <div id="query-texture-page" style="text-align: right;"></div>
                    </div>
                    <div class="mt-20 text-center" >
	                    <button id="btnQueryTextureOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnQueryTextureCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
	   </form>
    </div>
</div>

<!-- 选择物料询价信息相关@author jiangzhidong @date 20160621 -->
<div class="fixed-dialog" id="selectMaterialDialog" >
	<div class="dialog-tip bg-common" style="width: 630px;height: 403px;margin-left: -205px;margin-top: -270px;">
	  <div class="dialog-close-btn" id="btnSelectMaterialDialogClose"></div>
       <form id="selectMaterialForm" onsubmit="return false;">
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" ><i18n:I18n key="" defaultValue="请选物料信息" /></span>
		    <input type="hidden" id="pageSize" name="pageSize" value="20">
		    <input type="hidden" id="currentPage" name="currentPage" value="1">
		    <input type="hidden" id="fbk1" name="fbk1" value="WL">	
	    </div>
	    <div class="" >
	        <div class="box-wrap pos-relative bg-common" >
	            <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="" defaultValue="查询条件" /></span>
	            <div class="common-box-line">
	               <div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料编码/名称" />：</span>
						<input id="materialNumber" name="materialNumber" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<span><i18n:I18n key="" defaultValue="物料组" />：</span>
						<input id="materialGroup" name="materialGroup" type="text" />
					</div>
					<div class="dis-in-b input-and-tip">
						<button id="queryMaterial" class="button-wrap "><i18n:I18n key="" defaultValue="查询" /></button>
					</div>
	            </div>
	        </div>
	        <div class="box-wrap pos-relative bg-common" >
	            <main class="bg-common p-6">
                    <div class="grid-100" >
                        <table id="query-material-table"></table>
                        <div id="query-material-page" style="text-align: right;"></div>
                    </div>
                    <div class="mt-20 text-center" >
	                    <button id="btnQueryMaterialOK" class="button-wrap "><i18n:I18n key="i18n_common_button_confirm" defaultValue="确定" /></button>
	                    <button id="btnQueryMaterialCancel" class="button-wrap tip-option-btn"><i18n:I18n key="i18n_common_button_cancel" defaultValue="取消" /></button>
	                </div>
                 </main>
	        </div>
	    </div>
	   </form>
    </div>
</div>
</body>
</html>