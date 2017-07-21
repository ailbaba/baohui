<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/elsHeader.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jsLib/webuploader/css/webuploader.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/webuploader/js/webuploader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsLib/flexpaper/flexpaper_flash.js"></script>
<body>

<div class="box-wrap pos-relative bg-common">
    <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseoperation" defaultValue="基本操作" /></span>
    <div class="common-box-line">
        <div class="dis-in-b input-and-tip" id="isShow">
            <button class="button-wrap" id="publishEnquiry"><i18n:I18n key="i18n_common_button_issue" defaultValue="发布" /></button>
            <button class="button-wrap" id="saveEnquiry"><i18n:I18n key="" defaultValue="保存" /></button>
        <button class="button-wrap" id="close"><i18n:I18n key="" defaultValue="关闭" /></button>
            &nbsp;&nbsp;&nbsp;
		<div class="dis-in-b input-and-tip">
			<input type="checkbox" id="isAlibabaPublish" name="isAlibabaPublish" value="1688" checked="checked" />
			<span><i18n:I18n key="" defaultValue="发布到阿里巴巴" /></span>
		</div>
            <!-- <button class="button-wrap" id="loadHisSupplier"><i18n:I18n key="" defaultValue="加载供应商" /></button>
            <button class="button-wrap isShowQuote" id="loadSupplierQuota"><i18n:I18n key="" defaultValue="加载配额" /></button> -->
        </div>
        
    </div>
</div>
<form id="purchaseEnquiryForm" onsubmit="return false;" onkeydown="if(event.keyCode==13)return false;">
<div class="box-wrap pos-relative bg-common">
	 <span class="dis-in-b pos-absolute box-tip bg-common"><i18n:I18n key="i18n_common_title_baseinformation" defaultValue="基本信息" /></span>
	 <div class="common-box-line">
	     <div class="dis-in-b input-and-tip">
	         <input id="orderSendStatus" name="orderSendStatus" type="hidden" />
			<span><i18n:I18n key="i18n_enquiry_label_enquirynumber" defaultValue="询价单号" />：</span><input id="purchaseEnquiryNumber" name="purchaseEnquiryNumber" type="text" readonly/>
		 </div>
		 <div class="dis-in-b input-and-tip"><i18n:I18n key="i18n_enquiry_label_enquirytype" defaultValue="供询价单类型" />：
					<input type="text"  id="orderType" name="orderType" readonly />
		</div>
		 <div class="dis-in-b input-and-tip">
		    <span class="dis-in-b text-right w-72"><i18n:I18n key="i18n_enquiry_label_enquirydate" defaultValue="供询价日期" />：</span>
		    <input type="text" class="Wdate" onfocus="WdatePicker()"  id="beginDate" name="beginDate"/>
		 </div>
         <div class="dis-in-b input-and-tip">
            <span><i18n:I18n key="i18n_enquiry_label_enquirydateend" defaultValue="到" /></span>
            <input type="text"  class="Wdate" onfocus="WdatePicker()" id="endDate" name="endDate"/>
         </div>
         <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_purchasegroup" defaultValue="采购组" />：</span><input id="purchaseGroup" name="purchaseGroup" type="text" style="width:200px;"/>
		 </div>
		 <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_purchaseorganization" defaultValue="采购组织" />：</span><input id="purchaseOrganization" name="purchaseOrganization" type="text" style="width:200px;"/>
		 </div>
          <div class="dis-in-b input-and-tip">
			<span><i18n:I18n key="i18n_common_label_describe" defaultValue="描述" />：</span><input id="enquiryDesc" name="enquiryDesc" type="text" width="200px"/>
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
               <button id="btnManuAdd" class="button-wrap"><i18n:I18n key="i18n_common_button_handworkAddition" defaultValue="手工添加" /></button>
               <button id="btnQueryTexture" class="button-wrap ishowTexture"><i18n:I18n key="" defaultValue="选择材质" /></button>
               <button id="btnQueryMaterial" class="button-wrap ishowMaterial"><i18n:I18n key="" defaultValue="选择物料" /></button>
                <button id="excelImport" class="btn btnUpload" style="height: 24px;line-height:24px;padding-top: 0px;"><span><i18n:I18n key="i18n_common_button_excelimport" defaultValue="Excel导入" /></span></button>
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
			                       <select class="" id="selectFileType" name="selectFileType" ></select>
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
						             <button id="downloadFile" class="button-wrap"><i18n:I18n key="i18n_common_button_download" defaultValue="下载" /></button>
						             <button id="deleteSelectBtn" class="button-wrap"><i18n:I18n key="i18n_common_button_remove" defaultValue="移除" /></button>
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
						                <div id="enquirySuppliePage" style="text-align: left;"></div>
						            </div>
						        </main>
		                    </div>
			                <div class="file-scan">
	   							<!-- 替代料 @author jiangzhidong @date 20160622 begin -->
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
            <div class="grid-100" >
                <table id="supplie-quota"></table>
            </div>
        </main>
    </div>
</div>
</form>     


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
	<div class="dialog-tip bg-common" style="width: 400px;height: 203px;margin-left: -205px;margin-top: -170px;">
	    <div class="dialog-close-btn" id="btnCustomCostConstituteTemplateDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleCustomCostConstituteTemplateDialogDialog"><i18n:I18n key="i18n_coststructure_title_customaddcostitem" defaultValue="自定义添加成本组成项" /></span>
	    </div>
	    <div class="" style="background-color: #fdfdfd;" >
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
	<div class="dialog-tip bg-common" style="width: 400px;height: 213px;margin-left: -205px;margin-top: -170px;">
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
<!-- 供应商选择 -->
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
	                       <div class="input-and-tip">
	                         <span>计价单位：</span>
	                         <input class="easyui-textbox"  name="priceQuantity" id="batchSet_priceQuantity" type="text" />
	                         <img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 117px;top: 61px;cursor: pointer;" id="queryPriceQuantity" title="查找计价单位" />
	                       </div>
	                       <div class="input-and-tip">
	                         <span>计量单位：</span>
	                         <input class="easyui-textbox"  name="unitQuantity" id="batchSet_unitQuantity" type="text" />
	                         <img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 117px;top: 92px;cursor: pointer;" id="queryUnitQuantity" title="查找计量单位" />
	                       </div>
	                       <div class="input-and-tip deliveryDate-show">
	                         <span>需求日期：</span>
	                         <input name="deliveryDate" id="batchSet_deliveryDate" class="Wdate" onfocus="WdatePicker()" type="text" />
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
	<div class="dialog-tip bg-common" style="width: 580px;height: 438px;margin-left: -315px;margin-top: -250px;">
	    <div class="dialog-close-btn" id="btnsetLadderPriceDialogClose"></div>
        <div class="tip-head">
	        <img class="icon" src="../../icon/els.PNG" />
	        <span class="dialogTitle" id="titleLadderPriceDialog"><i18n:I18n key="test" defaultValue="物料阶梯设置"/></span>
	    </div>
	    <div class="">
	        <div class="box-wrap pos-relative bg-common" style="border-bottom-left-radius: 0;border-bottom-right-radius: 0;">
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
	                		<td width="40px"><input class="" type="text" id="beginNumber" value="1" onkeyup="value=value.replace(/[^(\d)]/g,'')" readonly = "readonly"/></td>
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
						<span><i18n:I18n key="" defaultValue="材质编码/名称" />：</span>
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

<script type="text/javascript">
var cols;
var colsfile;
var editFileTable;
var colsfile1 = [
	                
                 { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>', name:'fileName' , width:80, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>', name:'filePath' , width:60, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型"/>', name:'fileType' , width:60, align:'center',hidden:true},
                 { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态"/>', name:'fileStatus' ,width:100, align:'center', renderer: redererFileSendStatus},
                 { title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="请求单号"/>', name:'purchaseApplyNumber' ,width:140, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行项目号"/>', name:'purchaseApplyItemNumber' ,width:140, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_materialnumber" defaultValue="物料编码"/>', name:'purchaseMaterialNumber' ,width:130, align:'center'},
                 { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述"/>', name:'purchaseMaterialDesc' ,width:120, align:'center'}
            ];
var colsfile2 = [
                
                { title:'<i18n:I18n key="i18n_common_title_filename" defaultValue="文件名称"/>', name:'fileName' , width:80, align:'center'},
                { title:'<i18n:I18n key="i18n_common_title_filepath" defaultValue="文件路径"/>', name:'filePath' , width:80, align:'center',hidden:true},
                { title:'<i18n:I18n key="i18n_common_title_filetype" defaultValue="文件类型"/>', name:'fileType' , width:80, align:'center',hidden:true},
                { title:'<i18n:I18n key="i18n_common_title_sendstatus" defaultValue="发送状态"/>', name:'fileStatus' ,width:100, align:'center', renderer: redererFileSendStatus},
                { title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="请求单号"/>', name:'purchaseApplyNumber' ,width:140, align:'center'},
                { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行项目号"/>', name:'purchaseApplyItemNumber' ,width:140, align:'center'},
	            { title:'<i18n:I18n key="i18n_enquiry_title_texturenumber" defaultValue="材质编码"/>', name:'purchaseMaterialNumber' ,width:60, align:'center'},
	            { title:'<i18n:I18n key="i18n_enquiry_title_texturedescribe" defaultValue="材质描述"/>', name:'purchaseMaterialDesc' ,width:120, align:'center'}
            ];
var supplieQuotaClos = [
	                       { title:'<i18n:I18n key="" defaultValue="行号" />', name:'materialLineNumber' ,width:100, align:'center',renderer:function(val){
		           				return val+"<input name='purchaseEnquiryItemVOs[][materialLineNumber]' style='display:none;'  type='text' value='"+val+"'/>";
	           			     }},
	           			    { title:'<i18n:I18n key="" defaultValue="物料编号" />', name:'materialNumber' ,width:100, align:'center',renderer:function(val){
		           				return val+"<input name='purchaseEnquiryItemVOs[][materialNumber]' style='display:none;'  type='text' value='"+val+"'/>";
	           			     }},
	        			    { title:'<i18n:I18n key="" defaultValue="物料描述" />', name:'materialDesc' ,width:150, align:'center',renderer:function(val){
		           				return val+"<input name='purchaseEnquiryItemVOs[][materialDesc]' style='display:none;'  type='text' value='"+val+"'/>";
	           			     }},
	                           { title:'<i18n:I18n key="" defaultValue="需求数量" />', name:'FBK3' ,width:100, align:'center',renderer:function(val){
	               				return val+"<input name='purchaseEnquiryItemVOs[][FBK3]' style='display:none;'  type='text' value='"+val+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="单位" />', name:'unitQuantity' ,width:100, align:'center',renderer:function(val){
	               				return val+"<input name='purchaseEnquiryItemVOs[][unitQuantity]' style='display:none;'  type='text' value='"+val+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="供应商ELS" />', name:'toElsAccount' ,width:100, align:'center',renderer:function(val){
	               				return val+"<input name='purchaseEnquiryItemVOs[][toElsAccount]' style='display:none;'  type='text' value='"+val+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="供应商名称" />', name:'FBK4' ,width:100, align:'center',renderer:function(val){
	               				if(!val){val = ""}
	               				return val+"<input name='purchaseEnquiryItemVOs[][FBK4]' style='display:none;'  type='text' value='"+val+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="配额权数" />', name:'FBK1' ,width:100, align:'center',renderer:function(val,item,index){
	               				return "<input name='purchaseEnquiryItemVOs[][FBK1]' onkeyup='value=value.replace(/[^(\\d\\.)]/g,\"\")'  class='onkeyup-compute'  type='text' value='"+val+"'/>"+
	               				'<span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="比率(%)" />', name:'FBK2' ,width:100, align:'center',renderer:function(val,item,index){
	               				return "<input name='purchaseEnquiryItemVOs[][FBK2]' readonly  type='text' value='"+val+"' id='FBK2_"+index+"'/>";
	               			}},
	               			{ title:'<i18n:I18n key="" defaultValue="分配需求量" />', name:'quantity' ,width:100, align:'center',renderer:function(val,item,index){
	               				return "<input name='purchaseEnquiryItemVOs[][quantity]' readonly  type='text' value='"+val+"' id='FBK3_"+index+"'/>";
	               			}}
	           ];
	           
var colsLadderPrice = [
                       { title:'<i18n:I18n key="i18n_common_title_requisitionnumber" defaultValue="申请订单号"/>', name:'purchaseOrderNumber' ,hidden:true, width:60, align:'center'},
                       { title:'<i18n:I18n key="i18n_common_title_lineitemnumber" defaultValue="行号"/>', name:'orderItemNumber' ,hidden:true, width:60, align:'center'},
                       { title:'<i18n:I18n key="i18n_common_title_materialnumber" defaultValue="物料编码"/>', name:'materialNumber' , width:100, align:'center'},
                       { title:'<i18n:I18n key="i18n_common_title_materialdescribe" defaultValue="物料描述"/>', name:'materialDesc' , width:180, align:'center'},
                       { title:'<i18n:I18n key="i18n_ladderprice_title_quantity" defaultValue="数量从"/>', name:'beginQuantity' , width:80, align:'center'},
                       { title:'<i18n:I18n key="i18n_ladderprice_title_quantityto" defaultValue="数量到"/>', name:'endQuantity' , width:80, align:'center'}
                   ];	

var colsUnitOfMeasurement = [
	         	                { title:'<i18n:I18n key="i18n_common_title_unitcode" defaultValue="单位代码"/>', name:'unitCode' , width:100, align:'center'},
	         	                { title:'<i18n:I18n key="i18n_common_title_unitname" defaultValue="单位名称"/>', name:'unitName' , width:180, align:'center'}
	         	            ];

//渲染文件发送状态
function redererFileSendStatus(val){
	if(val == 0){
		return '<i18n:I18n key="i18n_common_select_sendstatus_notsent" defaultValue="未发送" />';
	}else if(val == 1){
		return '<i18n:I18n key="i18n_common_select_sendstatus_saapunut" defaultValue="已送达" />';
	}else if(val == 2){
		return '<i18n:I18n key="i18n_common_select_sendstatus_sent" defaultValue="已发送"/>';
	}else{
		return "";
	}
}
//选择负责人相关-----------------begin---------------
var selectPrincipalTable;
var selectUnitOfMeasurementTable;

var colsPrincipal = [
	                { title:'<i18n:I18n key="i18n_common_title_elssubaccount" defaultValue="子账号"/>', name:'elsSubAccount' , width:110, align:'center'},
	                { title:'<i18n:I18n key="i18n_common_title_username" defaultValue="用户名称"/>', name:'name' , width:100, align:'center'}
	                
	            ];

//触发负责人弹出框事件，并用负责人文本框数据初始化窗口table的选中数据
$("#queryPrincipal").click(function(){
	$("#selectPrincipalDialog").show();
	if(!selectPrincipalTable){
		selectPrincipalTable=$('#select-principal-table').mmGrid({
	        cols: colsPrincipal,
	        url: "<%=basePath%>rest/AccountService/subAccountList",
	        params: {"elsAccount":elsAccount,"station":"purchase","name":"","pageSize":"10000"},
	        method: 'post',
	        root: 'rows',
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	        multiSelect: true,
	        checkCol: true,
	        indexCol:true
	    });
	    
	    selectPrincipalTable.on('loadSuccess', function(e, data){
	    	var principalName = $("#principalName").val();
	    	selectedByInput();
		});
	}
	selectedByInput();
});
//用责任人框值初始化选中责任人列表的值
function selectedByInput(){
	var principal = $("#FBK4").val();
	var principalArray = principal.split(";");//根据“;”获取以选择的负责人数组
	var totalRows = selectPrincipalTable.rows();
	if(totalRows != "" &&totalRows != null && principalArray){
		for(var i = 0 ; i < totalRows.length ; i ++){
			for(var j = 0 ; j < principalArray.length ; j ++ ){
				var elsSubAccount = totalRows[i].elsSubAccount;
				var name = totalRows[i].name;
				var _principal = principalArray[j];
				var _principalArray = _principal.split("_");
				var _elsSubAccount = _principalArray[0];
				var _name = _principalArray[1];
				if(elsSubAccount == _elsSubAccount && name == _name){ //判断该行数据是否已经在负责人文本框中，如果有则设置这一行为选中
					selectPrincipalTable.select(i);
					continue;
				}
			}
		}
	}
}

//模糊查询键入事件
$("#principalName").keyup(function(){
	var principalName = $("#principalName").val();
	selectPrincipalTable.load({"elsAccount":elsAccount,"station":"purchase","name":principalName,"pageSize":"10000"});
});
//选择负责人弹出框确认按钮单击事件
$("#btnSelectPrincipalOK").click(function(){
	    var selectedRows = selectPrincipalTable.selectedRows();
	    var principals ="";
	    var fbk4 = $("#FBK4").val();
	    var fbk4Array = fbk4.split(";");
	    //循环去重
		for(var i = 0 ; i < fbk4Array.length ; i ++){
			for(var j = 0 ; j < selectedRows.length ; j ++){
				var _principal = fbk4Array[i];
				var _principalArray = _principal.split("_");
				var _elsSubAccount = _principalArray[0];
				var elsSubAccount = selectedRows[j].elsSubAccount;
				if(elsSubAccount == _elsSubAccount){ //判断该行数据是否已经在负责人文本框中，如果有则去除重复数据
					selectedRows.splice(j,1);
					continue;
				}
			}
		}
		//移除已选中的数据，判断依据若责任人在fbk4input框中且又在过滤后的责任人的列表中且状态不是选中状态，则认为该责任人是要从fbk4责任人框中移除的
		var rows = selectPrincipalTable.rows();
		var selectedRowsIndex = selectPrincipalTable.selectedRowsIndex();
		for(var i = selectedRowsIndex.length-1 ; i >= 0 ; i --){
			rows.splice(selectedRowsIndex[i],1); //去掉选中的行
		}
		for(var i = 0 ; i < rows.length ; i ++){
			for(var j = 0 ; j < fbk4Array.length ; j ++){
				var _principal = fbk4Array[j];
				var _principalArray = _principal.split("_");
				var _elsSubAccount = _principalArray[0];
				var elsSubAccount = rows[i].elsSubAccount;
				if(elsSubAccount == _elsSubAccount){ //判断该行数据是否已经在负责人文本框中，如果有则移除
					fbk4Array.splice(j,1);
					continue;
				}
			}
		}
		for(var i = 0 ; i < fbk4Array.length ; i ++){
			if(i == 0){
				principals += fbk4Array[i];
			}else{
				principals += ";"+fbk4Array[i];
			}
		}
		for(var i = 0 ; i < selectedRows.length ; i ++){
			var singleRow = selectedRows[i];
			var elsSubAaccount = singleRow.elsSubAccount;
			var name = singleRow.name;
			if(i == 0){
				if(principals == ""){
					principals += elsSubAaccount+"_"+name;
				}else{
					principals += ";"+elsSubAaccount+"_"+name;
				}
			}else{
			    principals += ";"+elsSubAaccount+"_"+name;
			}
		}
		
	if(principals != ""){
		$("#FBK4").val(principals);
	}else{
		parent.elsDeskTop.tip.init({type : 'alert',displayType : 0,message : '<i18n:I18n key="i18n_common_alert_selectAtLeastOneRecord" defaultValue="至少选择一条记录！" />'});
		return;
	}
	$("#selectPrincipalDialog").hide();
});
$("#btnSelectPrincipalDialogClose").click(function(){
	$("#selectPrincipalDialog").hide();
});
$("#btnSelectPrincipalCancel").click(function(){
	$("#selectPrincipalDialog").hide();
});
//选择负责人相关-----------------end---------------

//判断是否是从erp获取，如果是则字段不可编辑
    function isFromERP(val,item,index){
    	if(!val) { val = '';}
    	var isERP = item.isERP;
    	var name = $(this)[0].name;
    	if(isERP == null || isERP != "yes"){
    		return '<input  style="width:46px;height: 14px;" class="blur_'+name+'"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}else{
    		return '<input readonly style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}
    }
    
    function initInput(val,item,index){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
		return '<input  style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    }
    function initInputInteger(val,item,index){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
		return '<input  onkeyup="value=value.replace(/[^(\\d)]/g,\'\')"  style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    }
    function initInputDouble(val,item,index,colName){
    	if(!val) { val = '';}
    	var name = $(this)[0].name;
    	if (colName == "quantity" && item.purchaseOrderNumber && item.purchaseOrderNumber !='') {
    		return '<input readOnly onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}
		return '<input  onkeyup="value=value.replace(/[^(\\d\\.)]/g,\'\')"  style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    }
    
    function initInputDate(val,item,index){
    	if(!val) { val = '';}
    	if (val!=""&&val.length != 10) {val = new Date(val).format("yyyy-MM-dd");}
    	var isERP = item.isERP;
    	var name = $(this)[0].name;
    	if(isERP == null || isERP != "yes"){
    		return '<input class="Wdate" onfocus="WdatePicker({minDate: \'%y-%M-%d\'})" style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}else{
    		return '<input  readonly style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="'+name+'_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
    	}
    }
  //渲染计价单位表格
    function priceQuantity(val,item,index){
		 if(!val) { val = '';}
		 var name = $(this)[0].name;
		return '<input style="width:46px;height: 14px;"  name="purchaseEnquiryMaterialVOs[]['+name+']" id="priceQuantity_'+index+'" type="text" value="'+val+'"/>'+
		'<img class="dis-in-b" src="../../icon/min/search_gray.png" style="width: 17px; height: 17px;position: absolute;right: 2px;top: 4px;cursor: pointer;" id="input-priceQuantity" title="查找计价单位" />'+
		'<span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+name+'</span>';
    }
  
  //选择计量单位相关------------------begin--------------
  //table中单击计价单位框
      $('#input-priceQuantity').live("click", function() {
  		 var rowIndex = $(this).closest("tr").index();
  		 var scanCol = $(this).next();
  		 var sanContentText = scanCol.text();
  		 var sanContent = sanContentText.split("@enquiry@");
  	     $("#oldMaterialRowIndex").val(sanContent[1]);
  		 $("#price_index").val(rowIndex);
  	     $('body').data('currentLineObj',JSON.parse(sanContent[0]));
  	     $("#selectUnitOfMeasurementDialog").show();
  	 	if(selectUnitOfMeasurementTable == null || selectUnitOfMeasurementTable ==""){
  	 		     //初始化table
  	 		     selectUnitOfMeasurementTable=$('#unit-of-measurement-table').mmGrid({
  	 		         	height: 180,
  	 		         	width: 410,
  	 		            cols: colsUnitOfMeasurement,
  	 		            url: "<%=basePath%>rest/UnitOfMeasurementService/findSupplierContent/"+elsAccount,
  	 		            params: {"unitName":""},
  	 		            method: 'post',
  	 		            root: 'rows',
  	 		            loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
  	 		            noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
  	 		            indexCol:true
  	 		         });
  	 		     selectUnitOfMeasurementTable.on('cellSelected',function(e, item, rowIndex, colIndex) {
  	 		    	 $('body').data('unitRow',item);
  	 		     });
  	 	}
       });

  //模糊查询键入事件
  $("#unitName").keyup(function(){
  	var unitName = $("#unitName").val();
  	selectUnitOfMeasurementTable.load({"unitName":unitName});
  });

  //选择计量单位弹出框确认按钮单击事件
  $("#btnUnitOfMeasurementOK").click(function(){
	  var selectedRows = selectUnitOfMeasurementTable.selectedRows();
		if(selectedRows != "" && selectedRows != null ){
			var unitCode = selectedRows[0].unitCode;
			var busType = $("body").data("busType");
			if(busType){//判断是否批量设置弹出框
				$("#"+busType).val(unitCode);
				$("body").data("busType",null);
			}else{
				var price_index = $("#price_index").val();
				var name = $("#oldMaterialRowIndex").val();//列名
				var currentLineObj = $('body').data('currentLineObj');
				var frmObj = $("#purchaseEnquiryForm").serializeJSON();
				var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[price_index];
				materialLineJsonObj[name]=unitCode;
				materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
				editTable.updateRow(materialLineJsonObj,price_index);
			}
		}
		$("#selectUnitOfMeasurementDialog").hide();
  });
  
//计量单位表单双击功能
	$('#unit-of-measurement-table').on('dblclick','tr',function() {
		var storeRow = $('body').data('unitRow');
		var busType = $("body").data("busType");
		if(busType){
			$("#"+busType).val(storeRow.unitCode);
			$("body").data("busType",null);
		}else{
			var price_index = $("#price_index").val();
			var name = $("#oldMaterialRowIndex").val();//列名
			var frmObj = $("#purchaseEnquiryForm").serializeJSON();
			var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[price_index];
			materialLineJsonObj[name]=storeRow.unitCode;
			var currentLineObj = $('body').data('currentLineObj');
			materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
			editTable.updateRow(materialLineJsonObj,price_index);
		}
		$("#selectUnitOfMeasurementDialog").hide();
	});
//关闭窗口
$("#btnSelectUnitOfMeasurementClose").click(function(){
	$("#selectUnitOfMeasurementDialog").hide();
	$("body").data("busType",null);
	$("#price_index").val("");
});
//关闭窗口
$("#btnUnitOfMeasurementCancel").click(function(){
	$("#selectUnitOfMeasurementDialog").hide();
	$("body").data("busType",null);
	$("#price_index").val("");
});
//选择计量单位相关------------------end--------------
  
//渲染计价亮度单位表格
  function priceMetricQuantity(val,item,index){
		 if(!val) { val = '';}
		return '<input  style="width:46px;height: 14px;" name="purchaseEnquiryMaterialVOs[][priceMetricQuantity]" id="priceMetricQuantity_'+index+'" type="text" value="'+val+'"/><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+index+'</span>';
  }
  
//**********阶梯报价相关 *****begin***********************************
  function selectDown(val,item,rowIndex) {
       var sel = '<div><p style="display: none;">'+JSON.stringify(item)+'</p><select name="purchaseEnquiryMaterialVOs[][quoteMethod]" class="select-tag" style="padding: 0;height: 25px;width: 100px;">';
       if(val == "0"){
     	  sel += '<option value="0" selected>常规报价</option><option value="1">阶梯报价</option>';
       }else{
     	  sel += '<option value="0" >常规报价</option><option value="1" selected>阶梯报价</option>';
       }
     return sel;
 }
 //TODO:设置阶梯报价下拉事件
 $('.select-tag').live('change',function(e) {
     e.stopPropagation();
     var value = $(this).find("option:selected").val();
     var rowIndex = $(this).closest("tr").index();
     var frmObj = $("#purchaseEnquiryForm").serializeJSON();
		var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
		materialLineJsonObj["quoteMethod"]=value;
		var materialLineJson = $(this).siblings('p').text();
		var currentLineObj = JSON.parse(materialLineJson);
		materialLineJsonObj = initUpdateObj(currentLineObj,materialLineJsonObj);
		editTable.updateRow(materialLineJsonObj,rowIndex);
 });
 //阶梯报价单击按钮
 function scanCol(val, item, rowIndex){
     if(item.quoteMethod == '1') {
         return '<span class="col-scan" style="cursor: pointer;color:blue;" ><i18n:I18n key="i18n_common_label_settings" defaultValue="设置" /></span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
     } else {
         return '<span></span>';
     }
 };
//增加阶梯报价
 $("#btnAddLadderPrice").click(function(){
	 var beginNumberTxt = $("#beginNumber");
	 var endNumberTxt = $("#endNumber");
	 if(beginNumberTxt.val() == ""){
		 parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n key="i18n_ladderprice_alert_startnumbernotempty" defaultValue="起始数量不能为空！" />'});
		 beginNumberTxt.focus();
		 return;
	 }
	 if(endNumberTxt.val() == ""){
		 parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n key="i18n_ladderprice_alert_endnumbernotempty" defaultValue="截止数量不能为空！" />'});
		 endNumberTxt.focus();
		 return;
	 }
	 var beginNumber = parseInt(beginNumberTxt.val());
	 var endNumber = parseInt(endNumberTxt.val());
	 var purchaseOrderNumber = $("#ladderPrice_purchaseOrderNumber").val();
	 var orderItemNumber = $("#ladderPrice_orderItemNumber").val();
	 var materialNumber = $("#ladderPrice_materialNumber").val();
	 var materialDesc = $("#ladderPrice_materialDesc").val();
	 if(beginNumber > endNumber){
		 parent.elsDeskTop.tip.init({type: 'alert',message:'<i18n:I18n key="i18n_ladderprice_alert_maxmustGTmin" defaultValue="最大数量不能小于最少数量！" />'});
		 endNumberTxt.val("");
		 endNumberTxt.focus();
	 }else{
		 var data = {
        		 purchaseOrderNumber : purchaseOrderNumber,
        		 orderItemNumber : orderItemNumber,
        		 materialNumber : materialNumber,
        		 materialDesc : materialDesc,
        		 beginQuantity : beginNumber,
        		 endQuantity : endNumber
			};
		 addLadderPriceTable.addRow(data);
		 beginNumberTxt.val(endNumber+1);
		 endNumberTxt.val("");
		 endNumberTxt.focus();
	 }
 });
//删除阶梯报价
 $("#btnDelLadderPrice").click(function(){
	   var selectedIndexes = addLadderPriceTable.selectedRowsIndex();
	   addLadderPriceTable.removeRow(selectedIndexes);
 });
//单击设置阶梯报价按钮
 $('.col-scan').live("click", function() {
	   $("#setLadderPriceDialog").show();
     var scanCol = $(this).next();
     var sanContentText = scanCol.text();
     var sanContent = sanContentText.split("@enquiry@"); 
     var oldRowIndex = sanContent[1];
     var rowIndex = $(this).closest("tr").index();
		var materialLineJsonObj = JSON.parse(sanContent[0]);
     $("#materialRowIndex").val(rowIndex);
     var jsonObj = $("#purchaseEnquiryForm").serializeJSON();
	 var purchaseEnquiryMaterialVOs = jsonObj.purchaseEnquiryMaterialVOs;//获得input框输入的物料信息
	 var purchaseOrderNumber = purchaseEnquiryMaterialVOs[rowIndex].purchaseOrderNumber;
	 var orderItemNumber = purchaseEnquiryMaterialVOs[rowIndex].orderItemNumber;
	 var materialNumber = purchaseEnquiryMaterialVOs[rowIndex].materialNumber;
	 var materialDesc = purchaseEnquiryMaterialVOs[rowIndex].materialDesc;
     $('body').data("materialLineJsonObj",materialLineJsonObj);
     //取出并判断存放价格阶梯json是否为空
     var ladderPriceJson = JSON.parse(materialLineJsonObj.ladderPriceJson);
     $("#beginNumber").val(1);
     var items = [];
     if(ladderPriceJson != null && ladderPriceJson != ""){
    	    var priceObj = ladderPriceJson[ladderPriceJson.length-1];
    	    var endNumber = priceObj.endQuantity;
    	    $("#beginNumber").val(endNumber+1);
    	    for(var itemObj in ladderPriceJson){
       	    	ladderPriceJson[itemObj].materialNumber = materialNumber;
       	    	ladderPriceJson[itemObj].materialDesc = materialDesc;
       	    	ladderPriceJson[itemObj].purchaseOrderNumber = purchaseOrderNumber;
       	    	ladderPriceJson[itemObj].orderItemNumber = orderItemNumber;
       	    }
    	    if(addLadderPriceTable){
    	    	addLadderPriceTable.load(ladderPriceJson);
    	    }else{
    	    	items=ladderPriceJson;
    	    }
     }else{
    	 if(addLadderPriceTable){
 	    	addLadderPriceTable.load([]);
 	    }
     }
     if(!addLadderPriceTable){
		 addLadderPriceTable = $('#add-ladder-price-table').mmGrid({
 	       	   height:180,
 	           cols: colsLadderPrice,
 	           items: items,
 	           nowrap: true,
 	           loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
 	           noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
 	           multiSelect: true,
 	           checkCol: true,
 	           indexCol:true
 	       });
	    }
     $("#ladderPrice_purchaseOrderNumber").val(purchaseOrderNumber);
     $("#ladderPrice_orderItemNumber").val(orderItemNumber);
     $("#ladderPrice_materialNumber").val(materialNumber);
     $("#ladderPrice_materialDesc").val(materialDesc);
     $("#titleLadderPriceDialog").text('<i18n:I18n key="i18n_enquiry_title_materialsinformation" defaultValue=" 物料信息" />： '+materialNumber+" "+materialDesc);
 });
 //阶梯报价窗口确定按钮
 $("#btnAddLadderPriceOK").click(function(){
	    var flag = $("body").data("setLadder");
 	    var ladderPriceJson = [];
	    var ladderPriceItmes = addLadderPriceTable.rows();
	    for(var i=0; i< ladderPriceItmes.length;i++){
		    ladderPriceJson.push(ladderPriceItmes[i]);
        }
	    if(flag){
	    	$("body").data("ladderPriceItmes",ladderPriceItmes);
	    }else{
	    	var materialLineJson = $('body').data("materialLineJsonObj");
	   	    var rowIndex = $("#materialRowIndex").val();
	   	    materialLineJson['ladderPriceJson']= JSON.stringify(ladderPriceJson);
	   	    materialLineJson["changeFlag"]=rowIndex;
	   	    var frmObj = $("#purchaseEnquiryForm").serializeJSON();
	   	    var materialLineJsonObj = frmObj.purchaseEnquiryMaterialVOs[rowIndex];
	        materialLineJsonObj = initUpdateObj(materialLineJson,materialLineJsonObj);
		    editTable.updateRow(materialLineJsonObj,rowIndex);
	    }
	    $("body").data("setLadder",false);
	    $("#setLadderPriceDialog").hide();
	    $("#beginNumber").val(1);
 });
 //阶梯报价窗口取消按钮
 $("#btnAddLadderPriceCancel").click(function(){
 	$("#setLadderPriceDialog").hide();
 });
 //关闭阶梯报价设置窗口按钮
 $("#btnsetLadderPriceDialogClose").click(function(){
	    $("#setLadderPriceDialog").hide();
  });
//**********设置阶梯报价相关*****end*********************************************
function scanAddFile(val, item, rowIndex){
	 if(!item.fbk10) {
         return '<span class="col-scan-file" style="cursor: pointer;color:blue;"><i18n:I18n key="i18n_common_label_addition" defaultValue="添加" /></span><span style="display: none;">'+JSON.stringify(item)+"@enquiry@"+rowIndex+'</span>';
     } else {
    	 var showText='';
     	if(!item.fbk10){
//      		showText="添加";
     		item.fbk10 = "";
     	}else{
     		var fileArray = item.fbk10.split(";");
     		for(var i in fileArray){
     			var file = fileArray[i];
     			showText += file.substring(file.indexOf("_")+1,file.length)+";"
     		}
     		showText=showText.substring(0,showText.length-1);
     	}
//      	return '<span class="click-addFile" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><input style="display: none;"  name="purchaseOrderItemList[][fbk27]"  type="text" value="'+val+'"/>';
         return '<span class="click-addFile" style="color:blue;white-space: nowrap;cursor: pointer;display: inline-block">'+showText+'</span><input style="display: none;"  name="purchaseEnquiryMaterialVOs[][accessoryRequire_AddFile]"  type="text" value="'+item.fbk10+'"/>';
     }
     };

//TODO:在update行的时候，把mmgrid上的数据；阶梯报价，所属附件，成本组成 初始化带到将被更新的物料行
function initUpdateObj(mmgridObj,frmObj){
     frmObj["ladderPriceJson"]=mmgridObj.ladderPriceJson;
     frmObj["materialFileJson"]=mmgridObj.materialFileJson;
     frmObj["costConstituteTemplateJson"]=mmgridObj.costConstituteTemplateJson;
     frmObj["changeFlag"]=mmgridObj.changeFlag;
     frmObj["isERP"]=mmgridObj.isERP;
     return frmObj;
}

$('.add-file-sheet').live("click", function() {
	if(!editFileTable) {
		editFileTable=$('#add-file-project').mmGrid({
			autoLoad:false,
	        cols: colsfile,
	        loadingText: '<i18n:I18n key="i18n_common_mmgrid_loadingtext" defaultValue="正在载入"/>',
	        noDataText: '<i18n:I18n key="i18n_common_mmgrid_nodatatext" defaultValue="暂无数据"/>',
	        multiSelect: false,
	        checkCol: true,
	        fullWidthRows: true,
	        indexCol:false
	    }); 
		editFileTable.on('cellSelected', function(e, item, rowIndex, colIndex){
			var seled=editFileTable.selectedRows();
			if(seled && seled.length) {
				var filePath = item.filePath;
    			//增加文件选择控制
    			if(filePath && filePath.length) {
    				previewFile(filePath);
    			} else {
    				alert('<i18n:I18n key="i18n_enquiry_alert_notfoundfilepath" defaultValue="服务器异常，找不到文件上传的路径" />',3);
    			}
			}
		});
	}
	//初始化文件tag的文件下拉类型----------begin------------
	var frmObj = $("#purchaseEnquiryForm").serializeJSON();
	var rows = frmObj.purchaseEnquiryMaterialVOs;
	//每次进来都是初始化一个默认的下拉列表
	$('#file-list-head').html('<span><i18n:I18n key="i18n_common_label_filetype" defaultValue="文件类型" />：'+
			'</span><select class="" id="selectFileType" name="selectFileType" onchange="selectFileTypeChange();">'+
			'<option value="" store=""><i18n:I18n key="i18n_common_select_filetype_all" defaultValue="所有文件" />'+
			'</option><option value="" store=""><i18n:I18n key="i18n_common_select_filetype_public" defaultValue="公共文件" /></option>');
	if(rows != "" && rows != null){
		for(var i = 0 ; i < rows.length ; i ++){
			var singleRow = rows[i];
			//调用materialLineAddEvent方法给下拉列表增加项
			materialLineAddEvent(singleRow.purchaseOrderNumber,singleRow.orderItemNumber,singleRow.materialNumber,singleRow.materialDesc,i);
		}
	}
	var showTable = [];
	showTable = loadAllFile(showTable);
	editFileTable.load(showTable);
});

function materialLineAddEvent(enquiryApplyNumber,enquiryApplyItemNumber,materialNumber,materialDesc,rows){
	//设置表单文件tag页的文件类型下拉列表值
	var option = '<option value="'+rows+'" store="'+enquiryApplyNumber+"@enquiry@"+enquiryApplyItemNumber+"@enquiry@"+materialNumber+"@enquiry@"+materialDesc+'"  >'+materialNumber+" "+materialDesc+'</option>';
	$('#selectFileType').append(option);
}

function loadAllFile(showTable){
	   var rows = editTable.rows();
		 if(rows != "" && rows != null){
			for(var i = 0 ; i < rows.length ; i ++){
 			 var singleRow = rows[i];
 			 var materialFileJson = JSON.parse(singleRow.materialFileJson);
 			 if(materialFileJson != "" && materialFileJson != null){
 				for(var j = 0 ; j < materialFileJson.length ; j ++){
 					var singleFileJson = materialFileJson[j];
 					singleFileJson["materialIndex"]=i;
 					showTable = showTable.concat(singleFileJson);
 				}
 			 }
 		 }
		 }
		 var publicFileTableJson = $("#publicFileTableJson").val();
		 if(publicFileTableJson != ""){
			 publicFileTableJsonObj = JSON.parse(publicFileTableJson);
 		 showTable = showTable.concat(publicFileTableJsonObj);
		 }
		 return showTable;
}

//表单文件tag页 文件类型更改事件
function selectFileTypeChange(){
	 var selected = $("#selectFileType").find("option:selected");
	 var selectFileTypeVal = selected.attr('store');
	 var selectFileTypeText = selected.text();
	 
	 var index = $("#selectFileType").val();//对应的物料行索引
	 var valArray = selectFileTypeVal.split("@enquiry@");
	 var showTable = [];
	 if(index != ""){//查看特定物料的文件列表
		 var row = editTable.row(index);
		 var fileJson = JSON.parse(row.materialFileJson);
		 if(fileJson != "" && fileJson != null){
			 for(var i = 0 ; i < fileJson.length ; i ++){
				 var singleFileJson = fileJson[i];
				 singleFileJson["materialIndex"]=index;
				showTable = showTable.concat(singleFileJson);
			 }
		 }
	 }else if(selectFileTypeText == "公共文件" || selectFileTypeText == "Public File"){
		 var publicFileTableJson = $("#publicFileTableJson").val();
		 if(publicFileTableJson != ""){
			showTable = JSON.parse(publicFileTableJson);
		 }
	 }else{//查看所有文件
		showTable = loadAllFile(showTable);
	 }
	 editFileTable.load(showTable);
 }
 
$("#btnManuAdd").click(function(){
	var data = {
			purchaseOrderNumber : "",
			orderItemNumber : "",
			requestDate : new Date().format('yyyy-MM-dd'),
			deliveryDate : "",
			materialNumber : "",
			materialDesc : "",
			quantity : "",
			unitQuantity : "",
			priceMetricQuantity:1,
			priceQuantity:"",
			quoteMethod:0,
			currency:"CNY",
			factory: "",
			stockPoint: "",
			purchaseType: "",
			purchaseGroup: "",
	        accessoryRequire:"",
	        ladderPriceJson:null,
	        costConstituteTemplateJson:null,
	        materialFileJson:null,
	        remark:"",
	        taxCode:"J1"
	    };
	
	editTable.addRow(data);//插入到表格最后
	//设置询价单类型下拉框为不可用
	$("#columnDefineBtn").attr("disabled",true);
	
});

$("#close").click(function(){
	parent.elsDeskTop.closeCurWin('PurchaseEnquiryDetail',callBack);
});
     
</script>
</body>
</html>