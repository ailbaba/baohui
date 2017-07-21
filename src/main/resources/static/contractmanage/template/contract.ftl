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
			<td colspan="4" class="h">${elsDesc!""}�ɹ���ͬ</td>
		</tr>
		<tr>
			<td class="l">��ͬ���:</td>
			<td>${contractNumber!""}</td>
			<td class="l">��ͬ����:</td>
			<td>${contractDesc!""}</td>
		</tr>
		<tr>
			<td class="l">��ͬ����:</td>
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
			<td class="l">��:</td>
			<td>${elsDesc!""}</td>
			<td class="l">����:</td>
			<td>${toElsDesc!""}</td>
		</tr>
		<tr>
			<td class="l">����ϵ��:</td>
			<td></td>
			<td class="l">������ϵ��:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">����ϵ�绰:</td>
			<td></td>
			<td class="l">������ϵ�绰:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">ǩ���ص�:</td>
			<td></td>
			<td class="l">ǩ������:</td>
			<td></td>
		</tr>
		<tr>
			<td class="r" colspan="4"></td>
		</tr>
		<tr>
			<td colspan="4" class="d">������ͬ�ⰴ���������������ͬ��������в�Ʒ������˫�����ݡ��л����񹲺͹���ͬ������ƽ�Ȼ�����ͨ���Ѻ�Э�̣���������ͬ����ʹ��ͬ���ء�</td>
		</tr>
		<tr><td colspan="4" class="r"></td></tr>
		<tr>
			<td colspan="4" class="h1">һ�������Ʒ��ϸ�嵥</td>
		</tr>
	</table>
	<table class="area2">
		<tr align="center">
			<td>��������</td>
			<td>Ʒ��</td>
			<td>��ɫ</td>
			<td>��</td>
			<td>��</td>
			<td>��</td>
			<td>��������</td>
			<td>�ջ��ص�</td>
			<td>����</td>
			<td>����</td>
			<td>���</td>
			<td>��ע</td>
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
			<td colspan="4" class="h1">������ͬ����ϸ��</td>
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
			<td class="l">��</td><td></td>
			<td class="l">����</td><td></td>
		</tr>
		<tr>
			<td class="l">��λ���ƣ��£�:</td>
			<td></td>
			<td class="l">��λ���ƣ��£�:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">����������:</td>
			<td></td>
			<td class="l">����������:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">��Ȩ����:</td>
			<td></td>
			<td class="l">��Ȩ����:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">�绰/����:</td>
			<td></td>
			<td class="l">�绰/����:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">��������:</td>
			<td></td>
			<td class="l">��������:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">�����˺�:</td>
			<td></td>
			<td class="l">�����˺�:</td>
			<td></td>
		</tr>
		<tr>
			<td class="l">˰��:</td>
			<td></td>
			<td class="l">˰��:</td>
			<td></td>
		</tr>
	</table>
</div>
</body>
</html>