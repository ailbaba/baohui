<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
		"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<style type="text/css">
		table {
			width: 100%;
			border-collapse: collapse;
		}
		.area1 .l,
		.area2 .l {
			width: 120px
		}
		.area1 table{
			table-layout: fixed;
		}
		.area2 td {
			border: 1px solid;
			font-size: 13px;
		}
		.area1 .r,
		.area2 .r{
			padding-bottom: 30px;
		}
		.h {
			text-align: center;
			font-size: 20px;
			font-weight: 600;
			padding-bottom: 30px;
		}
	</style>
</head>
<body style="font-family:'Arial Unicode MS'">
<div>
	<table class="area1">
		<tr>
			<td colspan="4" class="h">${elsDesc!""}采购合同</td>
		</tr>
		<tr>
			<td class="l">合同编号:</td>
			<td>${contractNumber!""}</td>
			<td class="l">合同名称:</td>
			<td>${contractDesc!""}</td>
		</tr>
		<tr>
			<td class="l">合同日期:</td>
			<td>
				<#if contractSignedDate??>${contractSignedDate?string('yyyy-MM-dd')}<#else></#if>
			</td>
			<td class="l"></td>
			<td></td>
		</tr>
		<tr>
			<td class="r" colspan="4"></td>
		</tr>
		<tr>
			<td class="l">买方:</td>
			<td>${elsDesc!""}</td>
			<td class="l">卖方:</td>
			<td>${toElsDesc!""}</td>
		</tr>
		<tr>
			<td class="l">买方联系人:</td>
			<td></td>
			<td class="l">卖方联系人:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">买方联系电话:</td>
			<td></td>
			<td class="l">卖方联系电话:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">签订地点:</td>
			<td></td>
			<td class="l">签订日期:</td>
			<td></td>
		</tr>
		<tr>
			<td class="r" colspan="4"></td>
		</tr>
		<tr>
			<td colspan="4" class="d">鉴于买方同意按照下述条款购买，卖方同意出售下列产品，买卖双方根据《中华人民共和国合同法》在平等基础上通过友好协商，订立本合同，以使共同遵守。</td>
		</tr>
		<tr><td colspan="4" class="r"></td></tr>
		<tr>
			<td colspan="4" class="h1">一、购买产品明细清单</td>
		</tr>
	</table>
	<table class="area2">
		<tr align="center">
			<td>物料名称</td>
			<td>品牌</td>
			<td>颜色</td>
			<td>长</td>
			<td>宽</td>
			<td>高</td>
			<td>需求日期</td>
			<td>收货地点</td>
			<td>单价</td>
			<td>数量</td>
			<td>金额</td>
			<td>备注</td>
		</tr>
		<#if materialList?exists >
		<#list materialList as m>
		<tr align="center">
			<td>${m.materialDesc!""}</td>
			<td>${m.attribute1!""}</td>
			<td>${m.attribute2!""}</td>
			<td>${m.attribute3!""}</td>
			<td>${m.attribute4!""}</td>
			<td>${m.attribute5!""}</td>
			<td><#if m.requireDate??>${m.requireDate?string('yyyy-MM-dd')}<#else></#if></td>
			<td>${m.receiptAddr!""}</td>
			<td>${m.price!""}</td>
			<td>${m.quantity!""}</td>
			<td>${m.amount!""}</td>
			<td>${m.remark!""}</td>
		</tr>
		</#list>
		</#if>
	</table>
	<table class="area1">
		<tr><td colspan="4" class="r"></td></tr>
		<tr>
			<td colspan="4" class="h1">二、合同条款细则</td>
		</tr>
		<tr>
			<td colspan="4">
				<table>
					<#if clauseList?exists >
						<#list clauseList as c>
							<tr align="left">
								<td>${c_index+1}. ${c.detailContent!""}</td>
							</tr>
						</#list>
					</#if>
				</table>
			</td>
		</tr>
		<tr><td colspan="4" class="r"></td></tr>
		<tr>
			<td class="l">买方</td><td></td>
			<td class="l">卖方</td><td></td>
		</tr>
		<tr>
			<td class="l">单位名称（章）:</td>
			<td></td>
			<td class="l">单位名称（章）:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">法定代表人:</td>
			<td></td>
			<td class="l">法定代表人:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">授权代表:</td>
			<td></td>
			<td class="l">授权代表:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">电话/传真:</td>
			<td></td>
			<td class="l">电话/传真:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">开户银行:</td>
			<td></td>
			<td class="l">开户银行:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">银行账号:</td>
			<td></td>
			<td class="l">银行账号:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">税号:</td>
			<td></td>
			<td class="l">税号:</td>
			<td></td>
		</tr>
	</table>
</div>
</body>
</html>