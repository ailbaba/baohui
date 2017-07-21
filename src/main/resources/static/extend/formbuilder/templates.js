/**
 *  @global
 *  前端模板定义
 * */
var templates = {
		'mt-shd': {
			width: '197.3mm',
			height: '284mm',
			templateRule: [{css: 'first'}, {header: 'all'}, {table: 'table'}, {footer: 'all'}, {pagination: 'all'}],
			rowRule: {row: 'tbody.rows'},
			css: "<style>.f-t{font-size:15px;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between;position:absolute;width:174.3mm;bottom:2mm}.f-t>div{-webkit-box-flex:1;-ms-flex:1;flex:1}.tpl.tpl-footer p{font-size:13px;margin:0;padding:8px 0 0 0;}.mt-title{display:table;margin:3mm auto;font-size:24px;padding-bottom:1mm;color:red!important;border-bottom:1px solid;position:relative}.mt-title:after{display:block;content:'';border-bottom:solid 2px red!important;height:0;bottom:-1mm;position:absolute;left:0;width:100%}table.fl{margin:0!important;border:2px solid red!important;table-layout:fixed;float:none!important}table{border-collapse: collapse!important}table td,table th{border:1px solid red!important;font-weight:200}table th{color:red!important}.mt-head-detail+p{margin-top:3mm;margin-bottom:0}.tpl.tpl-header{position:relative}.page .paging{display:none}.page .gp .paging{display:block;position:relative;bottom:0;text-align:left;height:auto}.mt-head-detail{display:-webkit-box;display:-ms-flexbox;display:flex;position:relative;width:100%;margin-top:5mm;font-size:13px}.mt-head-detail .gp{-webkit-box-flex:1;-ms-flex:1;flex:1}.mt-head-detail .gp>div{display:-webkit-box;display:-ms-flexbox;display:flex;font-size:13px;line-height:13px;-webkit-box-align:start;-ms-flex-align:start;align-items:flex-start;min-height:13px}.mt-head-detail .gp+.gp{margin-left:5mm}.mt-head-detail .gp>div>label{width:20mm;font-size:13px;margin:0}.mt-head-detail .gp>div>span{display:block;-webkit-box-flex:1;-ms-flex:1;flex:1;border-bottom:1px solid;min-height:13px}.mt-logo{height:10mm;width:30mm;position:absolute;background-color:transparent;top:0;left:0;border:0}.headInfo *{text-align: center;color:red!important;}.tpl.tpl-css{display:none}.tpl.tpl-title{display:none}</style>",
			footer: '<p>1.质量要求:'
			+ '<br/>1)供方须保证所送货品为完好产品,因品质问题导致需方出现损失供方负全赔责任;'
			+ '<br/>2)抽样方案按MIL-STD-105EII,依原厂技指标样品确认之结果.以双方最后书面确认的数据或样板为准。'
			+ '<br/>2.违约:如延期交货或因品质等造成的延期问题,延误买方出货期,每天扣除货款金额5%(来料不合格换货导致延误亦同),延误二天(含)以上需方可无条件取消部份或全部订单，供方无条件赔偿需方由此造成的一切损失。'
			+ '<br/>3.送货时请在送货单和货物上填写 物料编号、物料名称、规格、数量、备品数量、订单号码、指令单号。'
			+ '<br/>4.对账单(上月26日至本月25日)于本月26日前传真至我公司，逾期未收到对账单，对账和付款将顺延至下个月。'
			+ '<br/>5.制造商如对以上所有条款无异议,请收到订单后8小时内签字回传,否则视为默认同意以上条款,供需方已发生上述一切实际的行为，均以本合同条款执行为准。'
			+ '<br/>6.供应商在每次送货时必须附上当批出厂的合格检验报告,否则拒绝收货,所造成的损失由供应商承担。'
			+ '<br/>7.未尽事宜经双方协商处理.协商处理不成的交由甲方所在地的人民法院诉讼解决。'
			+ '<br/>8.本合同传真签署视为合同确认有效,一式两份供需双方各执一份,双方盖章签名生效。'
			+ '<br/>9.采购合同请签字、盖章回传,否则财务将不给予结款。'
			+ '<br/>10.物料必须符合ROHS标准，供应商送货前需提供SGS报告。</p>'
			+ '<div class="f-t">'
			+ '<div><label>供应商回签：</label><span>　</span></div>'
			+ '<div><label>采购：{{!it.fbk4.split("_")[1]||""}}</label><span></span></span></div>'
			+ '<div><label>审核：</label><span>　</span></div>'
			+ '<div><label>批准：</label><span>　</span></div>'
			+ '<div style="flex-basis: 12mm"><label>批准日期：{{!it.fbk23||""}}</label><span>　</span></div>'
			+ '</div>',
			header: '<img class="mt-logo" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGEAAAAgCAIAAACNYIE9AAAQ7ElEQVRoBe1ZCXRc1Xl+923zZtVotRZkS5a8yJI3iB3iFWzaEMMptkPNatI2aQkQYkjSQ+KEJiTpkp6mdmKIgZITBxrHHMAYsA01FFuJd2x5lxdZsmRZkrVrZjTL2/vd9zSjN6OR23Nykp6Tk4sZ3Xfvf////v/9t/tfYpom86d2QwnwN5y1JiFFVWYYQkTX/w7sgDAig0YsjAHWF2S9OY6Z30tXD/Wa0SEcOOvN5XIK/i80wBlhRlXE+sR6Trl2KVb/OhvI98xfwU+oIOPpkR4Zih95N3HugHb9ipmImoSw3qCrss6z+C9dU265wQ6M+HD0N2/Ej+5SO5qMeASQrCdHmDjDu3i1d+FqiBojavuFwde+y2gKRH8DVDeY4hiTmzY/uOabQBg7umv4w1+qbeeMWAQc816Qq/Esvd+7aPV4GAAZeuvHyvlDpqHbWwIkbxqu5Wu9tz8UP/QOEVymroJx3/K12fVI7bzc//yTfNsJDiyYjGFSVljCsFeO9R/YHvzyRs+8FVnJa73tAy8+TS7sB14YsWEZMqvG+HNd4dP/rTQdD659jvBC4vwh8Xy9YTgOMSu68QddHFErZoK94T1bwlvWu1mDMmvh48K93PneyNl6ve9aYOVXs+KIHXzH/OBFusnkNBgEsywvEF0jgqT1XeMnTGKAFLJLwjj+msbQ1h9K7SeHdRPSyWgeMxx6a4N75m1E8mRMmZrS9/I3XBf3RzMXmrLOCCwT+6+fu+d9TqpbrDSf0nVG1tOwp304UGfRNMLENLOgbpExPBje8VOe0SPq6AKNMWWDEVkm/PZG96ylwuTZo3PJXrzxAMgltBGaHp6IHDOsMu7yGiJKpq655y6XL58gLIsVWWSk93fJ5w4oqjFWQFiQAP9dzWpvu1g+LUlx5O/w3m3kXP0wlCcbu5pBD0ofuA7vJjceCPAEUnM21aDInSPo84Rx4//0Bjwhxi1WzlZaz2oDnWMWUWjFYCQ11v/qdyes/zUR3U4EZjyiXm0kSfZgH3r1fKW0WvL4hZIq6KZ77jLlcgOfV+KqnouFWWSktJ4Blqx8YgHGiRyDk8qQkdbfEXl7AzEpQNYGR6RzLr58OmNovmUP6XIMqp2CJBxHrp5nju6CPFIIIAszt5gsXkM43il40zRy80u43AnRfdtEwiipBSl0Vgd6Kl46HHpvc/DzX3POqNdb9e42bBUN5AxWCD74Hde0+SkY1hOQZt2W+swiI7nlFBQV1pFqkDRPiGIJHpgxq3U2McydKQB0Qm9vFIa64hYM4AWWZJgSlUdhmVBcQVzewKqnnGvtfnjXS9qx3VryeDEIJNyspcEHvz0W2B5RWk5ZMWBkXmSJbpoptcJWdcMcfu8Fz8wl4tRPpZCoV86wqr1T6mRJbjFfNCk1O7YzepIjc6ahtJx2wmETpstrFFcBnd3wFzHLCZNoPBDft80WoqUIrFlehyDqhOFZIlbOZN1+56CzL184DBLW6Y4Mg1uxYpYTxtk3okNyWyOkYA+CrubL11nQGYWCwxGV6MBr3zPlWGpUbm4AkL0MHb606sa5QqaMjHA/ArPzMOENXJNn++/8EmjY1OFw1GsX4aFtqqaSGNr2L6Ku2geIiOOev8J3x1qEZ8duKfOuqptTG83oGJEB9er5FMOUFmE0ThQnjysjtbPFGOwyLEQgZLJc/mMbAn/xBLTJiRzqzDYfC7/zvD1oKnFEjKRg6RglkX6czuXoZ8pI6bikg7DjNDlChIpacfJsk3PZio1ZvbcdKaKNK/LRq0zTJ7K1Bh5EFr2B1U9D0AJyryQ17FpmeLFqXIa1rhZ9YIRhexGUkIMVlExO4sj8q7ae4VSbLI0GXE6ha8q8nJXr9IkzcU4paOxBhcXt/Jl84QgGtZ52tbsVJok+gODaxcpxd2UjGSOjltNCesRHPEIGKJROJm6fTRno9WgYbpuS7G6NvPtCylPDg/g/+9di2ZTE+cMpvwAwykNukVA21aY69hcRitNGGLZnOZYI5dM4X95YYHsEzohLbp8C3zSV9QaI5M175Hsq75QSg50IWmLw1X8wVUXtuEjiYfv06JFLPmHSjPFI2ONJItYXYofcfNKpqujrgstVUYckmy8ss6egMbypqddbsCi0fYMY7kbYRoOSa4WTAnc/rnY2a4gdo2rEWAzXILu36GT5kVtOOs6eAuAkoLyMlaFkWaAm5Cun7RzVnhWr5tgm45qx0L/iUZyWcxWyCrb1VHj7jxNnfgvvQbXIOjm+uILPK3VCju2nxzUkDm3nUokDoCFCRF9uQgX6fOkUve2MHZrBD1x73J8f3/+mDU9dO2MGVj3N+vOiB9/lVGR5aeRc4GHEoaWN48NIxNTWc87oblkBycmW/tmL1Z52rftqKn4ruumfDPwjLbByXffpeqn1lDPhgpbK2zcyHGfaPozKiPCVs4grLXtK4hj9m6ZHyHGQvzuCPj1/ceIM5AtYIZRWp7hGCIvWv9636TFW10ZcNeJ03VLf4nsBKV88goUpIuiqhJNqF6ZGMjpI/C0fMTqMJVwgHzY+OpTe0zqa2MSoyRBPQKioS4HA4nK/8AOVl5y6CbXGQRLremFDYuc3iJspbFSPzFhYvnIWnfipvYwykjiMQJg0qNl9obQKOTRYh6RAj1NiIGkrC1UrzlW05hkGyV4spF457VQKSkL0aP1dTOOhtHHLGMXKOjh4EgunDgDwEDEprWY9fvniJ3AilDlns+6xHDHt46R5eFk1n1fsBEFO6L3rMeWdDbrDLzpjEVCquDpWjkrWudzZpzKKn94X3fQo1NXpQTAO0rJJAkkswqRaQ/KziYhNlP5abAFM4gm7/GHRqgco7Rdxsx2xeIsU3VlieGDzVzNycGqdgnvCD3aqbWcFLi3nBE5UF9S2xt5/uo9RFVQdnJsGPqiDRZwOw2Q4mIyQWboJ3POVnjP1UkuD0+JSeCBZI6+YL61OjYzXobaGvFPiTByLwz4oPKIG68vhk8EIYRjFDVz/nAqMvl8g6qQ5Ocl8HyFW0BWHv7ZIGwZraJypO/+JxGCDhVx+idLUkGIY0JAHojV8sNJ2VtRlljGcq9DnoUBJodG/hBEn1lpk0n5YWNwjzym8JKUzhiW4KuIa6F1wD+cLpq3J9mHrUX0OIRJyPgcEEOF8lNm3C/kjbh8VpOD93+oL9fINu30c9dQgHddMtXZZ/pd+xPpHYpap616eSHDgDmxZu/AW0eq5SEHlpuMBlhGSygK5h3VWKJsS27/dJ0C/sq4eGeRZJiQVBGsXZAVyTZ2X89Czka0/DOjxJHpa6okxgr5oTW62K9FYPFRGfNmUaF5xBkssxzNlU3ORXqOTbKw/t3DdS7EjO+Uz9XqknwsUBWYv9cz7HNLDJAjjW/5wODqo0cwgedapufROnDCeBStRqxSrb1ZMPRltIFzTVziJzSlEBSdu/llqPH31yJfpzyu8/UHEk6yzGPR/9otC5Sz55MdafyeMnQgiX3BTQe1CiG+8JRnj49YhM+B+f5+0EmiHHAcNcsPLgQPwD9H9/5fRH4LL341GWn70u6H6o11NfQ3uFUaol3G5kbYachT+ADVK3M7s1BE1SRLII6g5+IJE8mlXG4Xy6UjSbJGgAMDoGtKClISACmAopAELfnH5Q1RGLquH+2gUR1bd16GFevjCiXzhTawv114Ii5PPH5HSXa8+1G0mYvS5Af4O9ih5uCQ8VsUaPoJnESdOHyFt6ErHZeR3xOMHR4yaIKKHL5qI2uvo3qIhfXhIQKHaboauhfqTNxP4TxYFaETDFLzdsfyxmhj8z+fwDKAP9nDeHCRW2mAP0tb8v/1XAA3/9g24N6X5JNhAUqc0nch/YhOJR5QrZyDKyIe/xE0icPeXUR5HliAUV4Z2/JTmmNGQcu0il1sCvy3NWe5d9sDglu9o3W2odUEWRqiHeIOBux713f6AAciWU5A1amzB+74JrnARp4yZRuT9V+Tzh3Fa9G1GlfOf3MzV3IoyM+IdrhTRj7eKFTNcNQvw+uKauUSq+czgK38PbJw/j/4WlatXL+Q/+TP7FSfReDB+7ANUF0PbN0741lbgBGuQ19Cvvm/EQjgFpKl6X6c4fV7eX/1jhoyoreG1R5q5BE8d2B8bLPLc9gBSI7sUG2/Yo1w8mjjxkRHuM4Z61a5WGvA5Xuu5Gju0AycJsRqD3fGGD2OH39NQbDVN96fuFKvm+u78oj7Ui+zDVbtYmrMMErQfoJBMoiwLhnEYxlA34CGgwV+sly8dNxU5cXpf36bH9d5rdJc01Vhf9Oybvtvux0dwzTNSza0YhnaLFbXYFREErrBc72tHVIVcQAKS5QvL+YIyFO35/FJaV9NViophIjs347Tc2ImmhHZssge1rmYg4XMnsDkFXEEpxKoj9o1pVEYIiomz+2EIYkUdtFe9dkkoneKqpvUwNqeI+PM53IxxsBzK9CIVuaYi0/f/+d9Q7JIXb5N8cIJnwT0orUEdIrtf0mFKpVMgBUgksvdXnMdHE2UYi5KgthYN4UaCWj30HMpClQ4h2SWhaM3wAizXzt8Tp/ZGdr88vHdr+P1XWMkDsYZ3vai0ncOViCutRgELr4OQjnatiZ7ElFuQl2EtXkpQ50bB21QUumcez2RaaMdP9HC/e/5dsYM7gvd+PbzzhaHX/xnArMsDt2DAA2gq582lhokNjGlURiCAIjwjunCHkC8ejbz974Yci538GCLHZV0sn87lFRPeZfEziiDWsCf+yW74CJCRm09E972OOa6gTCivUS4dxz0LwvWtfIrDUwzNlPAf9JnVLB0BTpToCHyWFeOhWawgoQxCf2mGThMrAMDEqJXJcVPT1K4WXPSRcOIy2P/8V5BD4R6LE9ITUWOoB/A4BVgQV1KVOHcQ/it2/ANoHHQcJwoFz33k+7Eju/BaiQtT8MFnjcEeHAz8id7XQVnSVfX6FS6vhOaXY5rls+UYDh+6A1Xs+80bkhY3Bq5773kSpxTZswX6T29q4X4cIEprQG0jIYYh1i6C3sHL8MWVVBOhd24/FFBuOhbb/xY0K3bgLRa65g2iQgp3BmVBtRB84mkbxTMCA0EzDLyawqPj7mrIcdbWWYbxLFqNf5gPvflvWl8nbhUUGOxEBgrXbQ7vfhnlPQbig2w4q3BOWD08YHS2cP6gUDrDhMRdeF+qQ7iAV8JbCOqWeP/o3fR4zqqn4AqBCtLXetpc0z4Nq6SvGLR6k6VRPUqcPWjGh4EruvfXnlvv1ktrEIki7/8HmEGVNv+xn6A8AlMXq2+BKkLnbVtA+MB7JjRO67wcO7Cdzy8BKn2oJ7LnF5AayiywLLXrCh8sip/djwopder5pawVLgEGeYEolgg3Tct7dEPg818HS6if+O9Yi7dD1G3tzWqD1/GggCBlf+IXrgf+DjouVt0s1nwGKmco2BK0XEc/sGodamzyqb3i5Dl6aABv8XRK0/pffFrtah6u36Z1XBr8+TMon1OEqB/llcCB0DMrKNc6mw3KXWajeoQqZ+Deb3DQzNqFXH4ppBNY9TW9pxUOSLIS9njjwZz714uTaqW6hZEPX2OsJz3k+EgSECzI9Fs9n74LtWeKm+W8S+9D/TBxeq/acZkLFhmo6nY2IQJgXO24hBAJnwoZDW75tmgVSUHRDf+qqbB3PI3gORkJAUk+n8Ao4Cm8S9dkbBxictUtRo0JTxpS3RLMEl7ENnxL7k2c3Mv5c73LHlYuHDbxXm61nBV/B2cCjfbd8YVEwx4cP10iuKBidooDAfU9/4SXxofM9qc8O1MiY7//B+srBkLseud7AAAAAElFTkSuQmCC"/>'
			+ '<div class="headInfo" style="padding-top:3mm">'
			+ '<div>深圳市迈腾电子有限公司 SHEN ZHEN MTN ELECTRONIC CO.,LTD</div>'
			+ '<div>地址：深圳市龙岗区坪西街道迈腾工业园</div>'
			+ '<div>总机：0755-89585920 89585923 89585924 89585925 分机：8069 传真：89584975</div>'
			+ '</div>'
			+ '<div class="mt-title">采购订单</div>'
			+ '<div class="mt-head-detail">'
			+ '<div class="gp">'
			+ '<div><label>供应商：</label><span>{{!it.toElsAccountName||"供应商"}}</span></div>'
			+ '<div><label>联系人：</label><span>{{!it.fbk27||"联系人"}}</span></div>'
			+ '<div><label>付款方式：</label><span>{{!it.payTermsText||"付款方式"}}</span></div>'
			+ '<div><label>交货地址：</label><span>{{!it.fbk18||"交货地址"}}</span></div>'
			+ '</div>'
			+ '<div class="gp">'
			+ '<div><label>TEL：</label><span>{{!it.fbk24||""}}</span></div>'
			+ '<div><label>FAX：</label><span>{{!it.fbk26||""}}</span></div>'
			+ '<div><label>手机：</label><span>{{!it.fbk25||""}}</span></div>'
			+ '<div><label>DATE：</label><span>{{!it.orderDate||"DATE"}}</span></div>'
			+ '</div>'
			+ '<div class="gp">'
			+ '<div><label>单据页码：</label><span><span class="paging"><span class="cur"></span>/<span class="total"></span>共（ <span class="total"></span> ）页</span></span></div>'
			+ '<div><label>订单号码：</label><span>{{!it.purchaseOrderNumber||""}}</span></div>'
			+ '<div><label>币 别：</label><span>{{!it.currency||""}}</span></div>'
			+ '<div><label>摘 要：</label><span>{{!it.remark||""}}</span></div>'
			+ '</div>'
			+ '</div>'
			+ '<p>兹向贵公司订购如下材料：</p>'
			,
			table: '<table class="fl"><thead><tr>'
			+ '<th style="width:30px;">行数</th>'
			+ '<th style="width:100px">物料编码</th><th style="width:150px">物料描述</th>'
			+ '<th style="width:30px">单位</th><th style="width:40px">数量</th>'
			+ '<th style="width:40px">单价</th style="width:40px"><th>税率%</th>'
			+ '<th style="width:50px">金额</th>'
			+ '<th style="width:70px">交货日期</th>'
			+ '<th style="width:100px">机型</th>'
			+ '</tr></thead><tbody class="rows"></tbody>'
			+'<tbody class="last"><tr>'
			+ '<td colspan="2">总金额(大写):</td><td colspan="3" style="text-align: right">{{!it.fbk22||"总金额"}}</td>'
			+ '<td colspan="2">小写:</td><td colspan="3">{{!it.fbk30||"小写"}}</td>'
			+ '</tr></tbody>'
			+ '</table>',
			row: '{{~ it.rows:r:index}}<tr>'
			+ '<td>{{!r.orderItemNumber}}</td>'
			+ '<td>{{!r.purchaseMaterialNumber||"物料编码"}}</td><td>{{!r.purchaseMaterialDesc||"物料描述"}}</td>'
			+ '<td>{{!r.fbk49||"单位"}}</td>'
			+ '<td>{{!r.quantity||"数量"}}</td><td>{{!r.price||"单价"}}</td>'
			+ '<td>{{!r.fbk1||"税率%"}}</td><td>{{!r.totalAmount||"金额"}}</td>'
			+ '<td>{{!r.fbk50||"交货日期"}}</td>'
			+ '<td>{{!r.fbk3||""}}</td>'
			+ '</tr>{{~}}'
		},
		
	/**=======================**/
	'sjg': {
		templateRule:[{pageTpl:'first'}],
		pageTpl:'<table border="1" cellspacing="0" cellpadding="0" style="margin:0 auto">'
		+  '<tbody>'
		+  '<tr>'
		+    '<td colspan="6" align="center"><label style="font-size: 22px; font-weight: bold">包装材料设计审批稿</label></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">物料代码：</td>'
		+    '<td style="width: 125px" align="left"><span>{{!it.materialNumber}}</span></td>'
		+    '<td style="width: 100px" align="left">物料名称：</td>'
		+    '<td style="width: 125px" colspan="3" align="left"><span>{{!it.materialDesc}}</span></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">材质工艺：</td>'
		+    '<td style="width: 125px" align="left"><span>{{!it.attribute2}}</span></td>'
		+    '<td style="width: 100px" align="left">规格：</td>'
		+    '<td style="width: 125px" align="left"><span>{{!it.materialSpec}}</span></td>'
		+    '<td style="width: 100px" align="left">尺寸：</td>'
		+    '<td style="width: 125px" align="left"><span>{{!it.attribute1}}</span></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">制版要求：</td>'
		+    '<td style="width: 125px" align="left"><span>{{![\'新制版\',\'改版原版保留\',\'改版原版作废\'][it.plateProcess]}}</span></td>'
		+    '<td style="width: 100px" align="left">改版内容：</td>'
		+    '<td style="width: 125px" align="left"><span>{{![\'文字图案\',\'材质工艺\',\'尺寸\',\'其他\'][it.changeContent]}}</span></td>'
		+    '<td style="width: 100px" align="left">是否打样：</td>'
		+    '<td style="width: 125px" align="left"><span>{{![\'打样\',\'不打样\'][it.makeSample]}}</span></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">制版支数：</td>'
		+    '<td style="width: 125px" align="left"><span>{{!it.plateQuantity}}</span></td>'
		+    '<td style="width: 100px" align="left">版本号：</td>'
		+    '<td style="width: 125px" colspan="3" align="left"><span>{{!it.revision}}</span></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">设计师：</td>'
		+    '<td style="width: 125px" colspan="2" align="left"><span>{{!it.designer}}</span></td>'
		+    '<td style="width: 100px" align="left">产品经理：</td>'
		+    '<td style="width: 125px" colspan="2" align="left"><span>{{!it.productManager}}</span></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">特殊要求：</td>'
		+    '<td style="width: 125px" colspan="5" align="left"><span>{{!it.specRequirement}}</span></td></tr>'
		+  '<tr><td colspan="6" align="center">'
		+ '{{~it.purchaseDesignFileList:r}}<img style="border-right-width: 0px; width: 600px; border-top-width: 0px; border-bottom-width: 0px; height: 600px; border-left-width: 0px" src="{{!fileSystemPath+ \'/\'+r.filePath}}">{{~}}</td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">制版支数：</td>'
		+    '<td style="width: 125px" align="left"><span>{{!it.plateQuantity}}</span></td>'
		+    '<td style="width: 100px" align="left">版费单价：</td>'
		+    '<td style="width: 125px" align="left"><span ></span></td>'
		+    '<td style="width: 100px" align="left">版费总计：</td>'
		+    '<td style="width: 125px" align="left"><span ></span></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">制版厂：</td>'
		+    '<td style="width: 125px" colspan="2" align="left"><span></span></td>'
		+    '<td style="width: 100px" align="left">供应商：</td>'
		+    '<td style="width: 125px" colspan="2" align="left"><span>{{!it.supplier}}</span></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">打样周期：</td>'
		+    '<td style="width: 125px" align="left"><span ></span></td>'
		+    '<td style="width: 100px" align="left">打样时间：</td>'
		+    '<td style="width: 125px" align="left"><span ></span></td>'
		+    '<td style="width: 100px" align="left">完成时间：</td>'
		+    '<td style="width: 125px" align="left"><span>{{!it.orderDate&&new Date(it.orderDate).format("yyyy-MM-dd")}}</span></td></tr>'
		+  '<tr>'
		+    '<td style="width: 100px" align="left">计划物控：</td>'
		+    '<td style="width: 125px" align="left"><span ></span></td>'
		+    '<td style="width: 100px" align="left">采购员：</td>'
		+    '<td style="width: 125px" align="left"><span >{{!it.purchaseInCharge}}</span></td>'
		+    '<td style="width: 100px" align="left">主数据维护：</td>'
		+    '<td style="width: 125px" align="left"><span ></span></td></tr></tbody></table>'
	},

	/**=================汇洁 送货单=================**/
	'hj-shd': {
		width: '297mm',
		height: '210mm',
		templateRule: [{title: 'all'}, {header: 'first'}, {table: 'table'},{footer: 'last'}, {pagination: 'all'}],
		rowRule: {row: 'tbody.rows'},
		title: '<div class="title">送货单</div>',

		footer:
		'<div class="clear"></div>'
		+ '<div class="fl c3"><label>备注：</label><span></span></div>'
		+ '<div class="fl c4"><label>发货方：</label><span></span></div>'
		+ '<div class="fl c4"><label>发货方：</label><span></span></div>'
		+ '<div class="fl c4"><label>收货方：</label><span></span></div>',

		header:
		'<div class="fl c1"><label>送货日期：</label><span>{{!it.voucherDate&&new Date(it.voucherDate).format("yyyy-MM-dd")}}</span></div>'
		+ '<div class="fl c1"><label>送货单号：</label><span>{{!it.materialVoucherNumber}}</span></div>'
		+ '<div class="fl c2 code"><label>条码区</label><span>{{!it.elsAccount+it.materialVoucherNumber}}</span></div>'
		+ '<div class="fl c1"><label>送货方：</label><span class="js-account">{{!it.elsAccount}}</span></div>'
		+ '<div class="fl c1"><label>收货方：</label><span class="js-account">{{!it.toElsAccount}}</span></div>'
		+ '<div class="fl c1"><label>承运方：</label><span>{{!it.fbk1}}</span></div>'
		+ '<div class="fl c1"><label>收货地址：</label><span class="js-address">{{!it.elsAccount}}</span></div>',

		table:
		'<table class="fl"><thead><tr>'
		+ '<th>采购订单</th><th>行号</th><th>物料编号</th><th>物料描述</th><th>物料规格</th><th>单位</th>'
		+ '<th>件数</th><th>送货数量</th><th>实收数量</th><th>批号</th><th>跟踪号</th>'
		+ '</tr></thead><tbody class="rows"></tbody></table>',

 		row:
		'{{~ it.rows:r:index}}<tr>'
 		+ 	'<td rowspan="2">{{!r.purchaseOrderNumber}}</td><td rowspan="2">{{!r.orderItemNumber}}</td>'
 		+ 	'<td>{{!r.purchaseMaterialNumber}}</td><td>{{!r.purchaseMaterialDesc}}</td>'
 		+ 	'<td style="min-width:80px">{{!(r.materialSpecification||"")+(r.fbk21||"")}}</td>'
 		+ 	'<td rowspan="2">{{!r.unitPrice}}</td><td rowspan="2">{{!r.fbk32}}</td>'
		+	'<td rowspan="2">{{!+r.wesbs}}</td>'
		+ 	'<td rowspan="2">　</td><td rowspan="2" style="min-width:60px">{{!r.orderBatch}}</td>'
		+ 	'<td rowspan="2" style="min-width:60px">{{!r.fbk35}}</td></tr><td>{{!r.saleMaterialNumber}}</td><td>{{!r.saleMaterialDesc}}</td>'
		+ 	'<td>{{!(r.fbk26+ r.fbk27)}}</td></tr>'
		+ '{{~}}'
	},


	/**=================汇洁 采购订单=================**/
	//todo: 未使用 字段待确认
	'hj-purchaser':{
		width: '297mm',
		height: '210mm',
		templateRule: [{title: 'all'}, {header: 'first'}, {table: 'table'},{footer: 'last'}, {pagination: 'all'}],
		rowRule: {row: 'tbody.rows'},
		title: '<div class="title com js-account">{{!it.elsAccount}}</div></div><div class="title">采购合同</div>',
		footer:
 		 '<div class="fl tk">$15</div><div class="fl bz"><span>备注:</span><p class="bz">$16</p></div>'
 		+ '<div class="fl c6"><label>卖&nbsp;&nbsp;方：</label><span>$17</span></div>'
 		+ '<div class="fl c6"><label>买&nbsp;&nbsp;方：</label><span>$18</span></div>'
 		+ '<div class="fl c6"><label>代表人签字：</label><span></span></div>'
 		+ '<div class="fl c6"><label>代表人签字：</label><span></span></div>'
 		+ '<div class="fl c6"><label>日&nbsp;&nbsp;期：</label><span></span></div>'
		+ '<div class="fl c6"><label>日&nbsp;&nbsp;期：</label><span></span></div>',

		header:
 		 '<div class="title com js-account">$0</div><div class="title t">采购合同</div>'
 		+ '<div class="fl h">'
 		+ '<div class="fl c5"><label>合同编号：</label><span>$1</span></div>'
 		+ '<div class="fl c5"><label>日&nbsp;&nbsp;&nbsp;&nbsp;期：</label><span>$2</span></div>'
 		+ '</div>'
 		+ '<div class="fl l"></div>'
 		+ '<div class="fl l"></div>'
 		+ '<div class="fl c6"><label>卖&nbsp;&nbsp;方：</label><span class="js-account">$3</span></div>'
 		+ '<div class="fl c6"><label>买&nbsp;&nbsp;方：</label><span class="js-account">$4</span></div>'
 		+ '<div class="fl c6"><label>地&nbsp;&nbsp;址：</label><span>$5</span></div>'
 		+ '<div class="fl c6"><label>地&nbsp;&nbsp;址：</label><span>$6</span></div>'
 		+ '<div class="br fl"></div>'
 		+ '<div class="br fl">'
 		+ '</div><div class="fl c6"><label>联系人：</label><span>$7</span></div>'
 		+ '<div class="fl c6"><label>联系人：</label><span>$8</span></div>'
 		+ '<div class="fl c7"><label>电&nbsp;&nbsp;话：</label><span>$9</span></div>'
 		+ '<div class="fl c7"><label>传真：</label><span>$10</span></div>'
 		+ '<div class="fl c7"><label>电&nbsp;&nbsp;话：</label><span>$11</span></div>'
 		+ '<div class="fl c7"><label>传真：</label><span>$12</span></div>'
 		+ '<div class="fl c6"><label>邮&nbsp;&nbsp;箱：</label><span>$13</span></div>'
		+ '<div class="fl c6"><label>邮&nbsp;&nbsp;箱：</label><span>$14</span></div>',

 		table:
		'<div class="fl l"></div>'
 		+ '<span class="fl">1.订购明细和交货期</span>'
 		+ '<table class="fl"><thead><tr>'
 		+ '<th>物料编号</th><th>色号</th><th>供应商货号</th>'
 		+ '<th>供应商色号</th><th>数量</th><th>单位</th>'
 		+ '<th>含税单价</th><th>币别</th><th>本公司款号</th>'
 		+ '<th>交货期</th><th>允收范围</th>'
 		+ '</tr></thead><tbody></tbody></table>'
		+ '<div class="clear"></div>',

		row:
		'{{~ it.rows:r:index}}<tr>'
		+ 	'<td>{{!r.purchaseOrderNumber}}</td><td>{{!r.orderItemNumber}}</td>'
		+ 	'<td>{{!r.purchaseMaterialNumber}}</td><td>{{!r.purchaseMaterialDesc}}</td>'
		+ 	'<td>{{!(r.materialSpecification||"")+(r.fbk21||"")}}</td><td>{{!r.fbk32}}</td>'
		+ 	'<td></td><td></td>'
		+ '</tr>{{~}}'
 		+'<tr><td></td><td></td><td></td><td>总数:</td>'
 		+ '<td class="totalQ"></td><td></td><td></td>'
 		+ '<td colspan="2" class="totalC"></td><td></td>'
		+ '<td></td></tr>'
	},

	/**=================NPS 送货单=================**/
	// todo : 字段待确认 页面需要调整
	'npx-shd':{
		width: '210mm',
		height: '140mm',
		templateRule: [{css:'first'},{title: 'all'}, {header: 'first'}, {table: 'table'},{footer: 'last'}, {pagination: 'all'}],
		rowRule: {row: 'tbody.rows'},
		css:'<style>.c45{width: 45%}.c30{width: 30%}.code.abs{top: -25mm;}.page table.fl th:nth-child(4){width: auto}.page .fl label, .page .fl span{font-size: 16px}.b32{font-size:32px;font-weight:600;line-height:1}.abs{position: absolute!important;right: 0;bottom: -40px}</style>',

		title: '<div class="title b32">送货单</div>',
		footer:
		'<div class="clear"></div>'
		+ '<div class="fl c33"><label>制单人：</label><span>　</span></div>'
		+ '<div class="fl c33"><label>送货人：</label><span>　</span></div>'
		+ '<div class="fl c33"><label>收货人：</label><span>　</span></div>',

		header: '<div class="fl c45"><label>送货方：</label><span class="js-account">{{!it.elsAccount}}</span></div>'
		+ '<div class="fl c30"><label>送货日期：</label><span>{{!it.voucherDate&&new Date(it.voucherDate).format("yyyy-MM-dd")}}</span></div>'
		+ '<div class="clear"></div>'
		+ '<div class="fl c45"><label>收货公司名称：</label><span class="js-account">{{!it.companyShortName}}</span></div>'
		+ '<div class="fl c30"><label>收货仓库：</label><span class="js-account"></span></div>'
		+ '<div class="clear"></div>'
		+ '<div class="fl c45"><label>收货地址：</label><span class="js-account"></span></div>'
		+ '<div class="fl c30"><label>联系人：</label><span class="js-account"></span></div>'
		+ '<div class="fl c7"><label>联系电话：</label><span class="js-account"></span></div>'
		+ '<div class="clear"></div>'
		+ '<div class="fl c3"><span class="code abs"><label>条码区</label><span>{{!it.elsAccount+it.materialVoucherNumber}}</span></span></div>',

		table:
		'<table class="fl"><thead><tr>'
		+ '<th>采购订单号</th><th>行项目</th><th>物料代码</th><th>物料名称</th><th>尺寸</th>'
		+ '<th>单位</th><th>数量</th><th>订单交期</th><th>含量</th><th>实物数量</th><th>备注</th>'
		+ '</tr></thead><tbody class="rows"></tbody>' +
		'<tbody><tr><td>备注:</td><td colspan="10"></td></tr></tbody></table>',

		row:
		'{{~ it.rows:r:index}}<tr>'
		+ '<td>{{!r.purchaseOrderNumber}}</td><td>{{!r.orderItemNumber}}</td>'
		+ '<td>{{!r.purchaseMaterialNumber}}</td><td>{{!r.purchaseMaterialDesc||""}}</td>'
		+ '<td>{{!(r.materialSpecification||"")+(r.fbk21||"")}}</td><td>{{!r.basicUnit}}</td><td>{{!r.wesbs||""}}</td>'
		+ '<td>{{!r.fbk1}}</td><td>{{!r.conversionParam}}</td><td>{{!r.wesbz||""}}</td><td></td>'
		+ '</tr>{{~}}'
	},

	/**=================龙升 送货单=================**/
	// todo : 字段待确认 页面需要调整
	'ls-shd':{
		width: '217mm',
		height: '140mm',
		templateRule: [{css:'first'},{title: 'all'}, {header: 'first'}, {table: 'table'},{footer: 'last'}, {pagination: 'all'}],
		rowRule: {row: 'tbody.rows'},
		css:	'<style>' +
		'.page .title{font-size: 24px}' +
		'.page {color: #000}' +
		'.b11{font-size: 11px;font-weight: 600}' +
		'.page table tr th{font-size: 11px;font-weight: 600}' +
		'.page table tr td{font-size: 11px;font-weight: 600}' +
		'.b12{font-size: 12px;font-weight: 600}' +
		'.l12{font-size: 12px}' +
		'.b14{font-size: 14px;font-weight: 600}' +
		'.page{font-family: \'宋体\'}' +
		'span.code.ls{bottom: 30px;}'+
		'</style>',

		title: '<div class="title js-account">{{!it.elsAccount}}</div><div class="title">送货单</div>',
		footer:
		'<div class="clear"></div>'
		+ '<div>注：第一联存根（白）、第二联回单（绿）、第三联客户（红）、第四联记账（黄）、第五联业务（蓝）</div><br>'
		+ '<div class="fl c6 "><label class="b14">送货单位(盖章)：</label><span>　</span></div>'
		+ '<div class="fl c6"><label class="b14">收货单位(盖章)：</label><span>　</span></div>',

		header: ''
		+ '<div class="fl c33"><label>客户：</label><span class="js-account b11">{{!it.elsAccount}}</span></div>'
		+ '<div class="fl c33">&nbsp;</div>'
		+ '<div class="fl c33"><label>送货单号：</label><span class="b11">{{!it.materialVoucherNumber}}</span><span class="code ls b11"><span>{{!it.elsAccount+it.materialVoucherNumber}}</span></span></div>'
		+	'<div class="clear"></div>'
		+ '<div class="fl c33"><label>承运方：</label><span class="js-account b11">{{!it.fbk1}}</span></div>'
		+ '<div class="fl c33"><label>货运单号：</label><span class="js-account b11">{{!it.toElsAccount}}</span></div>'
		+ '<div class="fl c33"><label>日期：</label><span class="b11">{{!it.voucherDate&&new Date(it.voucherDate).format("yyyy/MM/dd")}}</span></div>',

		table:
		'<table class="fl"><thead><tr>'
		+'<th>序号</th><th>订单号码</th><th>项目</th><th>品号</th><th>品名规格</th><th>单位</th>'
		+ '<th>数量</th><th>实收数量</th><th>备注</th>'
		+ '</tr></thead><tbody class="rows"></tbody></table>',

		row:
		'{{~ it.rows:r:index}}<tr><td class="l12">{{!index+1}}</td>'
		+ '<td>{{!r.purchaseOrderNumber}}</td><td >{{!r.orderItemNumber}}</td>'
		+ '<td>{{!r.purchaseMaterialNumber}}</td><td >{{!r.purchaseMaterialDesc}}</td>'
		+ '<td>{{!(r.materialSpecification||"")+(r.fbk21||"")}}</td><td >{{!r.totalDeliveryQuantity}}</td>'
		+ '<td></td><td class="l12">{{!r.deliveryTip}}</td>'
		+ '</tr>{{~}}'
	},
	'shd-tag':{
		width: '120mm',
		height: '90mm',
		templateRule: [{css:'first'},{pkg:'table'}],
		rowRule: {row: '.package'},
		css:'<style>.tpl-row+.tpl-row{page-break-before: always;}.package .fl label,.package .fl span{font-size: 13px} .codeB{float:right}.qrcode{position: absolute!important;top: -40px;right: 0}</style>',
		pkg:'<div class="package"></div>',
		row:'{{~it.rows:r}}{{~r.packageList:p}}'+'<div class="tpl-row">'
		+ '<div class="fl c6 "><div class="code"><span>{{=it.purchaseOrderNumber+it.elsAccount+it.materialVoucherNumber}}</span></div></div>'
		+ '<div class="fl c6 "><div class="code codeB" code-b-h="30"><span>{{!p.deliveryNumber}}</span></div></div>'
		+	'<div class="clear"></div>'
		+ '<div class="fl c3 "><label >采购方物料编号：</label><span>{{!r.purchaseMaterialNumber}}</span></div>'
		+ '<div class="fl c3 "><label>采购方物料描述：</label><span>{{!r.purchaseMaterialDesc}}</span></div>'
		+ '<div class="fl c3 "><label>销售方物料编号：</label><span>{{!r.saleMaterialNumber}}</span></div>'
		+ '<div class="fl c3 "><label >数量：</label><span>{{!p.deliveryQuantity}}</span></div>'
		+ '<div class="fl c3 "><label >单位：</label><span>{{!p.unitMeasure}}</span></div>'
		+	'<div class="clear"></div>'
		+ '<div class="fl c6 "><label >采购订单：</label><span>{{!r.purchaseOrderNumber}}</span></div>'
		+ '<div class="fl c6"><span class="qrcode" code-q-w="100" code-q-h="100" >{{!r.purchaseOrderNumber+","+r.orderItemNumber+","+r.quantity+","+r.basicUnit+","+r.saleOrderNumber}}</span></div>'
		+ '<div class="fl c3 "><label >行号：</label><span>{{!r.orderItemNumber}}</span></div>'
		+ '<div class="fl c3 "><label >批次号：</label><span>{{!r.saleOrderNumber}}</span></div>'
		+ '<div class="fl c3 "><label >生产日期：</label><span>　</span></div>'
		+	'<div class="clear"></div>'
		+'</div>'
		+'{{~}}{{~}}'
	}
};

