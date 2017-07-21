update service_url_mapping set serviceURL = 'srmbs.noposion.com';
update service_url_mapping set serviceURL = 'srm1.noposion.com';


/*数据库询报价迁移脚本*/
DELETE FROM purchase_enquiry_header ;
DELETE FROM purchase_enquiry_header_his ;
DELETE FROM purchase_enquiry_item ;
DELETE FROM purchase_enquiry_item_his ;
DELETE FROM purchase_enquiry_ladder_price ;
DELETE FROM purchase_enquiry_ladder_price_his ;
DELETE FROM purchase_receive_enquiry_file ;
DELETE FROM purchase_set_enquiry_header ;
DELETE FROM purchase_enquiry_material ;
DELETE FROM purchase_enquiry_material_set ;
DELETE FROM purchase_receive_enquiry_file ;
DELETE FROM sale_enquiry_header ;
DELETE FROM sale_enquiry_header_his ;
DELETE FROM sale_enquiry_item ;
DELETE FROM sale_enquiry_item_his ;
DELETE FROM sale_enquiry_ladder_price ;
DELETE FROM sale_enquiry_ladder_price_his ;
DELETE FROM sale_create_enquiry_file ;
DELETE FROM sale_set_enquiry_header ;
DELETE FROM sale_enquiry_material ;
DELETE FROM sale_enquiry_ladder_price_set ;
DELETE FROM sale_receive_enquiry_file ;

===============================================================================采购方==============================================================
/*第1步 采购方询价单头表*/
INSERT INTO purchase_enquiry_header(elsAccount,toElsAccount,purchaseEnquiryNumber,
orderType,logtime,orderStatus,
orderSendStatus,auditStatus,beginDate,
endDate,maker,remark,
fbk4,fbk5,toCompanyShortName )
SELECT elsno,elsno_df,ebeln,
ddtype, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),ddstatu,
fsstatu,shstatu,DATE_FORMAT( bedat, '%Y-%m-%d'), 
DATE_FORMAT( endat, '%Y-%m-%d'),zdr,remark,
fbk4,fbk5,elsjc_df  FROM xjekko;


/*第2步 采购方询价单头历史表----------可以不移植*/
INSERT INTO purchase_enquiry_header_his(elsAccount,toElsAccount,purchaseEnquiryNumber,
orderType,logtime,orderStatus,
orderSendStatus,beginDate,endDate
,maker,remark )
SELECT elsno,elsno_df,ebeln,
ddtype, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),ddstatu,
fsstatu,DATE_FORMAT( bedat, '%Y-%m-%d'), 
DATE_FORMAT( endat, '%Y-%m-%d'),zdr,remark  FROM xjekkohis;


/*第3步 采购方询价单行项目表*/
DELETE FROM purchase_enquiry_item ;
INSERT INTO purchase_enquiry_item(
elsAccount,toElsAccount,purchaseEnquiryNumber,
purchaseRequestNumber,purchaseRequestLineProjectNumber,materialNumber,
materialDesc,purchaseRequestDate,purchaseDeliveryDate,
logtime,quantity,auditStatus,
quoteMethod,maker,accessoryRequire,priceIncludingVat,
price,remark,materialLineNumber)
SELECT elsno,elsno_df,ebeln,prnum,pritem,ematn,txz01,DATE_FORMAT( prsqrq, '%Y-%m-%d'),DATE_FORMAT( pryhrq, '%Y-%m-%d'),DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),menge,shstatu,bjfs,zdr,fjyq,netpr,netpr,remark,prnum+pritem+ematn
FROM xjekpo 
where ebeln!=401600000352 and prnum+pritem+ematn!=3186 and ebeln!=401600000479 and prnum+pritem+ematn!=1030142028;

/*查询重复   手工处理*/
select ebeln,prnum+pritem+ematn,count(*) as count from xjekpo group by elsno,elsno_df,ebeln,prnum+pritem+ematn having count>1
401600000352	3186	2
401600000479	1030142028	2


/*第4步 采购方询价单行项目历史表----------可以不移植*/
DELETE FROM purchase_enquiry_item_his ;
INSERT INTO purchase_enquiry_item_his(
elsAccount,toElsAccount,purchaseEnquiryNumber,
purchaseRequestNumber,purchaseRequestLineProjectNumber,materialNumber,
materialDesc,purchaseRequestDate,purchaseDeliveryDate,
logtime,quantity,
quoteMethod,maker,accessoryRequire,
price,remark,materialLineNumber)
SELECT elsno,elsno_df,ebeln,prnum,pritem,ematn,txz01,DATE_FORMAT( prsqrq, '%Y-%m-%d'),DATE_FORMAT( pryhrq, '%Y-%m-%d'),DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),menge,bjfs,zdrmc,fjyq,netpr,remark,prnum+pritem+ematn
FROM xjekpohis
where ebeln!=401600000352 and prnum+pritem+ematn!=3186 
and ebeln!=401600000315 and prnum+pritem+ematn!=1030140316
and ebeln!=401600000482 and prnum+pritem+ematn!=1040147422
and ebeln!=401600000479 and prnum+pritem+ematn!=1030142028;

/*查询重复   手工处理*/
select ebeln,prnum+pritem+ematn,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),count(*) as count from xjekpohis group by elsno,elsno_df,ebeln,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),prnum+pritem+ematn having count>1
401600000352	3186	2016-04-15 04:04:26	2
401600000315	1030140316	2016-03-23 02:03:02	2
401600000482	1040147422	2016-05-03 06:05:07	2
401600000479	1030142028	2016-05-03 03:05:11	2

/*第5步 采购方询价阶梯报价表*/
INSERT INTO purchase_enquiry_ladder_price(elsAccount,toElsAccount,purchaseEnquiryNumber,orderItemNumber,materialNumber,materialDesc,beginQuantity,endQuantity,price,logtime,materialLineNumber)
SELECT elsno,elsno_df,ebeln,pritem,ematn,txz01,mengeb,mengee,netpr,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),prnum+pritem+ematn 
FROM xjjtbjek
where ebeln!=401600000352 and prnum+pritem+ematn!=3186;

/*查询重复   手工处理*/
select ebeln,prnum+pritem+ematn,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),count(*) as count from xjjtbjek group by elsno,elsno_df,ebeln,mengeb,mengee,prnum+pritem+ematn having count>1
401600000352	3186	2016-04-15 04:04:00	2
401600000352	3186	2016-04-15 04:04:00	2

/*第6步 采购方询价阶梯报价历史表----------可以不移植*/
INSERT INTO purchase_enquiry_ladder_price_his(elsAccount,toElsAccount,purchaseEnquiryNumber,orderItemNumber,materialNumber,materialDesc,beginQuantity,endQuantity,price,logtime,materialLineNumber)
SELECT elsno,elsno_df,ebeln,pritem,ematn,txz01,mengeb,mengee,netpr, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s') ,prnum+pritem+ematn 
FROM xjjtbjekhis  GROUP BY elsno,elsno_df,ebeln,pritem,ematn,mengeb,mengee, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s') ;

/*第7步 采购方-询价表单文件数据表*/
INSERT INTO purchase_receive_enquiry_file(
elsAccount,toElsAccount,purchaseEnquiryNumber,
purchaseApplyNumber,purchaseApplyItemNumber,purchaseMaterialNumber,
purchaseMaterialDesc,fileType,fileName,
logtime,fileStatus,purchaseElsSubaccount,purchasePerson,remark,materialLineNumber)
SELECT 
elsno,elsno_df,ebeln,
prnum,pritem,ematn,
txz01,wjlx,wjm,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),fsstatu,zdr,zdrmc,remark,prnum+pritem+ematn FROM xjekbdwjsj;


/*第8步 采购方询价单头表*/
INSERT INTO purchase_set_enquiry_header(elsAccount,elsShortName,purchaseEnquiryNumber,
orderType,logtime,orderStatus,
orderSendStatus,auditStatus,beginDate,
endDate,maker,remark,
fbk4,fbk5 )
SELECT elsno,elsjc,ebeln,
ddtype, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),ddstatu,
fsstatu,shstatu,DATE_FORMAT( bedat, '%Y-%m-%d'), 
DATE_FORMAT( endat, '%Y-%m-%d'),zdr,remark,
fbk4,fbk5  FROM rfqheader;


/*第9-------步 采购方询价单物料表*/
DELETE FROM purchase_enquiry_material ;
INSERT INTO purchase_enquiry_material(
elsAccount,elsAccountForshort,toElsAccount,toElsAccountForshort,purchaseEnquiryNumber,
purchaseOrderNumber,orderItemNumber,materialNumber,materialDesc,requestDate,deliveryDate,logtime,quantity,
priceQuantity,priceMetricQuantity,quoteMethod,accessoryRequire,orderStatus,
auditStatus,remark,purchaseOrganize,purchaseGroup,purchaseGroupDesc,materialGroup,materialGroupDesc,stockPoint,stockPointDesc,factory,factoryDesc,
orderClasses,itemClasses,purchaseOrderItemNumber,materialLineNumber)
SELECT elsno,elsjc,elsno_df,elsjc_df,ebeln,
prnum,pritem,ematn,txz01,DATE_FORMAT( prsqrq, '%Y-%m-%d'),DATE_FORMAT( pryhrq, '%Y-%m-%d'),DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),menge,
peinh,bprme,bjfs,fjyq,ddstatu,
shstatu,shremark,ekorg,ekgrp,ekgrp_desc,matkl,matkl_desc,lgort,lgort_desc,werks,werks_desc,
bsart,pstyp,pono,prnum+pritem+ematn
FROM rfqmaterial
where ebeln not in ( select ebeln from (select distinct ebeln,count(*) as count from xjjtbjek group by ebeln,elsno,prnum+pritem+ematn having count>1) test)
and ebeln!='401600000479'

/*查询重复   手工处理*/
select ebeln,elsno,elsno_df,prnum+pritem+ematn,count(*) as count from xjjtbjek group by ebeln,elsno,prnum+pritem+ematn having count>1
select ebeln from (select distinct ebeln,count(*) as count from xjjtbjek group by ebeln,elsno,prnum+pritem+ematn having count>1) test
401600000059	4
401600000060	4
401600000111	4
401600000112	4
401600000124	5
401600000125	4
401600000126	4
401600000133	4
401600000146	4
401600000203	4
401600000230	5
401600000232	5
401600000237	5
401600000239	5
401600000345	2----已处理20160623
401600000346    2----已处理20160623   行表没有-----有问题
401600000347	2----已处理20160623
401600000348	2----已处理20160623
401600000349	3----已处理20160623
401600000350	2----已处理20160623
401600000351	2----已处理20160623
401600000352	4----已处理20160623
401600000355	5
401600000356	4
401600000357	4
401600000358	4
401600000360	4
401600000361	5
401600000361	2
401600000363	4
401600000366	5
401600000367	5
401600000368	5
401600000369	5
401600000370	5
401600000371	5
401600000372	5
401600000373	5
401600000374	5
401600000375	5
401600000424	5
401600000425	5
401600000426	5
401600000427	5
401600000428	5
401600000429	5
401600000430	5
401600000431	5
401600000432	5
401600000433	5
401600000436	12
401600000446	2----已处理20160623
401600000498	3
401600000499	3
401600000500	3
401600000501	3

/*第10----------步 采购方询价单阶梯报价设置*/
DELETE FROM purchase_enquiry_material_set;
INSERT INTO purchase_enquiry_material_set(elsAccount,purchaseEnquiryNumber,purchaseOrderNumber,orderItemNumber,materialNumber,materialDesc,beginQuantity,endQuantity,logtime,materialLineNumber)
SELECT elsno,ebeln,prnum,pritem,ematn,txz01,mengeb,mengee,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),prnum+pritem+ematn FROM rfqquote;
where ebeln!='401600000352'

/*第11步 采购方询价单表单文件设置*/
DELETE FROM purchase_receive_enquiry_file;
INSERT INTO purchase_receive_enquiry_file(
elsAccount,purchaseEnquiryNumber,
purchaseApplyNumber,purchaseApplyItemNumber,purchaseMaterialNumber,
purchaseMaterialDesc,fileType,fileName,
logtime,fileStatus,purchaseElsSubaccount,purchasePerson,remark,materialLineNumber)
SELECT 
elsno,ebeln,
prnum,pritem,ematn,
txz01,wjlx,wjm,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),fsstatu,zdr,zdrmc,remark,prnum+pritem+ematn FROM rfqfile;

===============================================================================销售方==============================================================

/*第1步 销售方询价单头表*/
DELETE FROM sale_enquiry_header;
INSERT INTO sale_enquiry_header(elsAccount,toElsAccount,toCompanyShortName,purchaseEnquiryNumber,
orderType,logtime,orderStatus,
orderSendStatus,auditStatus,beginDate,
endDate,remark,
fbk4,fbk5 )
SELECT elsno,elsno_df,elsjc_df,ebeln,
ddtype, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),ddstatu,
fsstatu,shstatu,DATE_FORMAT( bedat, '%Y-%m-%d'), 
DATE_FORMAT( endat, '%Y-%m-%d'),remark,
fbk4,fbk5  FROM xjvbak;


/*第2步 销售方询价单头历史表----------可以不移植*/
DELETE FROM sale_enquiry_header_his;
INSERT INTO sale_enquiry_header_his(elsAccount,toElsAccount,toCompanyShortName,purchaseEnquiryNumber,
orderType,logtime,orderStatus,
orderSendStatus,auditStatus,beginDate,
endDate,remark,
fbk4,fbk5 )
SELECT elsno,elsno_df,elsjc_df,ebeln,
ddtype, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),ddstatu,
fsstatu,shstatu,DATE_FORMAT( bedat, '%Y-%m-%d'), 
DATE_FORMAT( endat, '%Y-%m-%d'),remark,
fbk4,fbk5  FROM xjvbakhis;


/*第3步 销售方询价单行项目表*/
delete from sale_enquiry_item;
INSERT INTO sale_enquiry_item(
elsAccount,toElsAccount,purchaseEnquiryNumber,
purchaseRequestNumber,purchaseRequestLineProjectNumber,materialNumber,
materialDesc,purchaseRequestDate,purchaseDeliveryDate,
logtime,quantity,orderstatus,
quoteMethod,maker,accessoryRequire,priceIncludingVat,
price,taxescode,remark,pricevalidbegindate,pricevalidenddate,materialLineNumber)
SELECT elsno,elsno_df,ebeln,prnum,pritem,ematn,txz01,DATE_FORMAT( prsqrq, '%Y-%m-%d'),DATE_FORMAT( pryhrq, '%Y-%m-%d'),
DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),menge,ddstatu,bjfs,zdrmc,fjyq,netpr,netpr,mwskz,remark,DATE_FORMAT( bedat, '%Y-%m-%d'),DATE_FORMAT( endat, '%Y-%m-%d'),prnum+pritem+ematn
FROM xjvbap
where ebeln!=401600000352 and prnum+pritem+ematn!=3186 and ebeln!=401600000479 and prnum+pritem+ematn!=1030142028;

/*查询重复   手工处理*/
select ebeln,prnum+pritem+ematn,count(*) as count from xjvbap group by elsno,elsno_df,ebeln,prnum+pritem+ematn having count>1
401600000352	3186	2----已处理20160623
401600000479	1030142028	2


/*第4步 销售方询价单行项目历史表----------可以不移植*/
delete from sale_enquiry_item_his;
INSERT INTO sale_enquiry_item_his(
elsAccount,toElsAccount,purchaseEnquiryNumber,
purchaseRequestNumber,purchaseRequestLineProjectNumber,materialNumber,
materialDesc,purchaseRequestDate,purchaseDeliveryDate,
logtime,quantity,orderstatus,
quoteMethod,maker,accessoryRequire,
price,taxescode,remark,pricevalidbegindate,pricevalidenddate,materialLineNumber)
SELECT elsno,elsno_df,ebeln,prnum,pritem,ematn,txz01,DATE_FORMAT( prsqrq, '%Y-%m-%d'),DATE_FORMAT( pryhrq, '%Y-%m-%d'),
DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),menge,ddstatu,bjfs,zdrmc,fjyq,netpr,mwskz,remark,DATE_FORMAT( bedat, '%Y-%m-%d'),DATE_FORMAT( endat, '%Y-%m-%d'),prnum+pritem+ematn
FROM xjvbaphis
where ebeln!=401600000352
and ebeln!=401600000005
and ebeln!=401600000007
and ebeln!=401600000432
and ebeln!=401600000479;

/*查询重复   手工处理*/
select DISTINCT ebeln from (select ebeln,prnum+pritem+ematn,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),count(*) as count from xjvbaphis group by elsno,elsno_df,ebeln,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),prnum+pritem+ematn having count>1) test
401600000352
401600000005
401600000007
401600000432
401600000479


/*第5步 销售方询价阶梯报价表*/
INSERT INTO sale_enquiry_ladder_price(elsAccount,toElsAccount,purchaseEnquiryNumber,supplierEnquiryNumber,orderItemNumber,materialNumber,materialDesc,beginQuantity,endQuantity,price,logtime,materialLineNumber)
SELECT elsno,elsno_df,ebeln,prnum,pritem,ematn,txz01,mengeb,mengee,netpr,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),prnum+pritem+ematn FROM xjjtbjvb
where ebeln!=401600000352;

/*查询重复   手工处理*/
select ebeln,prnum+pritem+ematn,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),count(*) as count from xjjtbjvb group by elsno,elsno_df,ebeln,mengeb,mengee,prnum+pritem+ematn having count>1
401600000352	3186	2016-04-15 04:04:00	2
401600000352	3186	2016-04-15 04:04:00	2


/*第5步 销售方询价阶梯报价历史表----------可以不移植*/
delete from sale_enquiry_item_his;
INSERT INTO sale_enquiry_item_his(
elsAccount,toElsAccount,purchaseEnquiryNumber,
purchaseRequestNumber,purchaseRequestLineProjectNumber,materialNumber,
materialDesc,purchaseRequestDate,purchaseDeliveryDate,
logtime,quantity,orderstatus,
quoteMethod,maker,accessoryRequire,
price,taxescode,remark,pricevalidbegindate,pricevalidenddate,materialLineNumber)
SELECT elsno,elsno_df,ebeln,prnum,pritem,ematn,txz01,DATE_FORMAT( prsqrq, '%Y-%m-%d'),DATE_FORMAT( pryhrq, '%Y-%m-%d'),
DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),menge,ddstatu,bjfs,zdrmc,fjyq,netpr,mwskz,remark,DATE_FORMAT( bedat, '%Y-%m-%d'),DATE_FORMAT( endat, '%Y-%m-%d'),prnum+pritem+ematn
FROM xjvbaphis 
where ebeln!=401600000352
and ebeln!=401600000005
and ebeln!=401600000007
and ebeln!=401600000432
and ebeln!=401600000479
GROUP BY elsno,elsno_df,ebeln,pritem,ematn, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s');

/*查询重复   手工处理*/
select DISTINCT ebeln from (select ebeln,prnum+pritem+ematn,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),count(*) as count from xjvbaphis group by elsno,elsno_df,ebeln,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),prnum+pritem+ematn having count>1) test
401600000352
401600000005
401600000007
401600000432
401600000479

/*第6步 销售方-询价表单文件数据表*/
INSERT INTO sale_create_enquiry_file(
elsAccount,toElsAccount,purchaseEnquiryNumber,
purchaseMaterialNumber,
purchaseMaterialDesc,fileType,fileName,
logtime,fileStatus,purchaseElsSubaccount,purchasePerson,remark,materialLineNumber)
SELECT 
elsno,elsno_df,ebeln,
ematn,
txz01,wjlx,wjm,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),fsstatu,zdr,zdrmc,remark,prnum+pritem+ematn FROM xjvbbdwjsj;


/*第6步 销售方询价单头表*/
INSERT INTO sale_set_enquiry_header(elsAccount,elsShortName,purchaseEnquiryNumber,
orderType,logtime,orderStatus,
orderSendStatus,beginDate,
endDate,maker,remark,
fbk4,fbk5 )
SELECT elsno,elsjc,ebeln,
ddtype, DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),ddstatu,
fsstatu,DATE_FORMAT( bedat, '%Y-%m-%d'), 
DATE_FORMAT( endat, '%Y-%m-%d'),zdr,remark,
fbk4,fbk5  FROM sprfqheader;


/*第7步 销售方询价单物料表*/
INSERT INTO sale_enquiry_material(
elsAccount,elsAccountForshort,toElsAccount,toElsAccountForshort,purchaseEnquiryNumber,
purchaseOrderNumber,orderItemNumber,materialNumber,materialDesc,requestDate,deliveryDate,logtime,quantity,
priceQuantity,priceMetricQuantity,quoteMethod,orderStatus,
selectstatus,remark,purchasegroup,purchasegroupdesc,stockpoint,stockpointdesc,materialLineNumber)
SELECT elsno,elsjc,elsno_df,elsjc_df,ebeln,
prnum,pritem,ematn,txz01,DATE_FORMAT( prsqrq, '%Y-%m-%d'),DATE_FORMAT( pryhrq, '%Y-%m-%d'),DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),menge,
peinh,bprme,bjfs,ddstatu,
zbstatu,remark,matkl,matkl_desc,lgort,lgort_desc,prnum+pritem+ematn
FROM sprfqmaterial
where ebeln not in ( select ebeln from (select distinct ebeln,count(*) as count from sprfqmaterial group by ebeln,elsno,prnum+pritem+ematn having count>1) test);

/*查询重复   手工处理*/
select ebeln,elsno,elsno_df,prnum+pritem+ematn,count(*) as count from sprfqmaterial group by ebeln,elsno,prnum+pritem+ematn having count>1
select ebeln from (select distinct ebeln,count(*) as count from sprfqmaterial group by ebeln,elsno,prnum+pritem+ematn having count>1) test
401600000352	101280	180000	3186	2
401600000479	102513	180000	1030142028	2

/*第8步 销售方询价单阶梯报价设置*/
INSERT INTO sale_enquiry_ladder_price_set(elsAccount,toElsAccount,purchaseEnquiryNumber,orderItemNumber,materialNumber,materialDesc,beginQuantity,endQuantity,logtime,materialLineNumber)
SELECT elsno,elsno_df,ebeln,pritem,ematn,txz01,mengeb,mengee,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),prnum+pritem+ematn FROM sprfqquote
where ebeln!=401600000352 and prnum+pritem+ematn!=3186;

/*查询重复   手工处理*/
select ebeln,prnum+pritem+ematn,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),count(*) as count from sprfqquote group by elsno,elsno_df,ebeln,mengeb,mengee,prnum+pritem+ematn having count>1
401600000352	3186	2016-04-15 04:04:00	2
401600000352	3186	2016-04-15 04:04:00	2

/*第9步 销售方询价单表单文件设置*/
INSERT INTO sale_receive_enquiry_file(
elsAccount,toElsAccount,purchaseEnquiryNumber,
purchaseMaterialNumber,
purchaseMaterialDesc,fileType,fileName,
logtime,fileStatus,purchaseElsSubaccount,purchasePerson,materialLineNumber)
SELECT 
elsno,elsno_df,ebeln,
ematn,
txz01,wjlx,wjm,DATE_FORMAT( LOGTIM, '%Y-%m-%d %h:%m:%s'),fsstatu,zdr,zdrmc,prnum+pritem+ematn FROM rfqfile ;
