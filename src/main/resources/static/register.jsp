


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="http://www.51zxzb.com:80/">
    
    	<title>注册会员</title>
    
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">		
		<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
		}
		.style1 {color: #FFFFFF}
		p{margin:0;padding:0;border:0;}
		-->
		</style>
		<link href="CSS/style.css" rel="stylesheet" type="text/css">
		<style type="text/css">
		<!--
		.STYLE3 {color: #FFFFFF; font-weight: bold; }
		.STYLE6 {color: #000000}
.STYLE8 {font-size: 14}
		-->
		</style>

	<script>
function check(){
	if(frm.yonghuming.value==""||frm.yonghuming.value.length<6)
	{
		alert("用户名不能少于6位!");
		frm.yonghuming.focus();
		return false;
	}
	
	if(frm.mima.value==""||frm.mima.value.length<6)
	{
		alert("密码不能少于6位!");
		frm.mima.focus();
		return false;
	}

	if(frm.mima.value!=frm.mima2.value)
	{
		alert("密码与确认密码不一致!");
		frm.mima.focus();
		return false;
	}
	
	if(frm.danweimingcheng.value==""||frm.danweimingcheng.value==null)
	{
		alert("请输单位名称!");
		frm.danweimingcheng.focus();
		return false;
	}
	
	if(frm.qiyefaren.value==""||frm.qiyefaren.value==null)
	{
		alert("请输入企业法人名称!");
		frm.qiyefaren.focus();
		return false;
	}
	
	if(frm.lianxiren.value==""||frm.lianxiren.value==null)
	{
		alert("请输入联系人!");
		frm.lianxiren.focus();
		return false;
	}
	
	if(frm.lianxidianhua.value==""||frm.lianxidianhua.value==null)
	{
		alert("请输入联系电话!");
		frm.lianxidianhua.focus();
		return false;
	}
	
	if(frm.dianziyouxiang.value==""||frm.dianziyouxiang.value==null)
	{
		alert("请输入电子邮箱!");
		frm.dianziyouxiang.focus();
		return false;
	}
	
	if(IsValidEmail(frm.dianziyouxiang.value)!="")
	{
		alert(IsValidEmail(frm.dianziyouxiang.value));
		frm.dianziyouxiang.focus();
		return false;		
	}
	
	if(frm.diqu.value==""||frm.diqu.value==null)
	{
		alert("请选择企业所在地区!");
		frm.diqu.focus();
		return false;
	}	
	frm.submit();
}
</script>

<script language="vbscript">
Function IsValidEmail(Byval sEmail)
	IsValidEmail = ""
	If Len(sEmail) = 0 Then
		IsValidEmail = "请输入合法Email'!"
		Exit Function
	End If
	
	ArrEmail = Split(sEmail,"@")
	
	If UBound(ArrEmail) = 0 Then
		IsValidEmail = "请输入合法Email,缺少'@'!"
		Exit Function
	End If
	
	If UBound(ArrEmail) > 1 Then 
		IsValidEmail = "请输入合法Email,格式有错误!"
		Exit Function
	End If
	
	sEMailName = Trim(ArrEmail(0))
	sEMailDomain = Trim(ArrEmail(1))
	
	If sEMailName = "" Then
		IsValidEmail = "请输入合法Email,格式有错误!"
		Exit Function
	End If
	
	If sEMailDomain = "" Then
		IsValidEmail = "请输入合法Email,需要域名!"
		Exit Function
	End If
	
	If IsValidChar(sEmail) Then
		IsValidEmail = "Email地址只能包括0-9,a-z,A-Z,'_','.'!"
		Exit Function
	End If
	
	ArrDomain = Split(sEmailDomain,".")
	If UBound(ArrDomain) = 0 Then
		IsValidEmail = "域名错误,请输入合法域名!"
		Exit Function
	End If
	
	If ArrDomain(0) = "" Or ArrDomain(UBound(ArrDomain)) = "" Then
		IsValidEmail = "域名错误,请输入合法域名"
		Exit Function
	End If
End Function

Function IsValidChar(sEmail)
	IsValidChar = False
	For iLocalCount=1 To Len(sEmail)
		atChr = Asc(Mid(sEmail,iLocalCount,1))
		If (atChr < 47 And atChr > 58) And _
		   (atChr < 64 And atChr > 91) And _
		   (atChr < 96 And atChr > 123) And _
		   (atChr <> 64 And atChr <> 46 And atChr <> 95 And atChr <> 45) Then
			Exit Function
		End If
	Next
	IsValidChat = True
End Function

function IsYzbm(str)
IsYzbm=true
l=len(trim(cstr(str)))
if l=6 then
for i=1 to l
if not (mid(str,i,1)>="0" and mid(str,i,1)<="9") then
IsYzbm=false 
exit function
end if
next
else
IsYzbm=false
end if
if err.number<>0 then err.clear
end function

function IsValidTel(para)
on error resume next
dim str
dim l,i
if isNUll(para) then 
IsValidTel=false
exit function
end if
str=cstr(para)
if len(trim(str))<7 then
IsValidTel=false
exit function
end if
l=len(str)
for i=1 to l
if not (mid(str,i,1)>="0" and mid(str,i,1)<="9" or mid(str,i,1)="-") then
IsValidTel=false 
exit function
end if
next
IsValidTel=true
if err.number<>0 then err.clear
end function

function pdrq(rqz)
 if (not isnull(rqz)) and rqz<>"" then
  if isdate(rqz) then
   pdrq=true
  else
   pdrq=false
  end if
 else
   pdrq=true
 end if
 end function
</script>

<script language="JavaScript"> 
<!-- 
function moveOption(e1, e2){ 
try{ 
for(var i = 0; i < e1.options.length; i++){ 
if(e1.options[i].selected){ 
var e = e1.options[i]; 
e2.options.add(new Option(e.text, e.value)); 
e1.remove(i); 
i = i - 1; 
} 
} 
document.frm.suoshuhangye.value=getvalue(document.frm.trade_list2);
document.frm.yewukaizhandi.value=getvalue(document.frm.zone_list2);
} 
catch(e){} 
} 
function getvalue(geto){ 
var allvalue = ""; 
for(var i = 0; i < geto.options.length; i++){ 
allvalue += geto.options[i].value + ","; 
} 
return allvalue; 
} 
function moveAllOption(e1, e2){ 
try{ 
for(var i = 0;i < e1.options.length; i++){ 
var e = e1.options[i]; 
e2.options.add(new Option(e.text, e.value)); 
e1.remove(i); 
i = i - 1; 
} 
document.frm.suoshuhangye.value=getvalue(document.frm.trade_list2);
document.frm.yewukaizhandi.value=getvalue(document.frm.zone_list2);
} 
catch(e){ 
} 
} 
//--> 
</script> 

  </head>
  
  <body oncontextmenu="event.returnValue=false" onselectstart="event.returnValue=false">
    <center>
    	<table width="966" border="0" align="center">
    	<tr><td>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<META name=description content=中国在线招标网是依法发布的民用建筑项目招标公告的媒介！最新最快的招标信息尽在中国在线招标网！>
                <META name=keywords content=中国在线招标,南京招标,江苏省招标,招标公告,招标预告,招标信息,招标网>	
		<title>中国在线招标网</title>
		<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
		}
		.zftj{
		color:#FF0000;				
		}
		.style1 {color: #FFFFFF}
		p{margin:0;padding:0;border:0;}
		-->
		</style>
		<link href="CSS/style.css" rel="stylesheet" type="text/css">
		<style type="text/css">
		<!--
		.STYLE3 {color: #FFFFFF; font-weight: bold; }
		.STYLE6 {color: #000000}
		.STYLE7 {font-weight: bold}
		-->
		</style>
		
		<SCRIPT language=JavaScript>
		<!--
		Day=new Array(7);
		Day[0]="日"; Day[1]="一";
		Day[2]="二"; Day[3]="三";
		Day[4]="四"; Day[5]="五";
		Day[6]="六";
		
		today=new Date();
		month=today.getMonth()+1;
		day=today.getDate();
		year=today.getYear();
		weekly=today.getDay();
		
		mydate="今天是："+year+"年"+month+"月"+day+"日 星期"+Day[weekly];
		// -->
		</script>
		
<SCRIPT language=javascript>
function key()
{
	document.form2.keyword.value='';document.form2.keyword.style.color='#000000';
}

function key1()
{
	var k = document.form2.keyword.value;
	if(k=='')
	{
		document.form2.keyword.value='请输入关键字';
		document.form2.keyword.style.color='#999999';
	}	
}

function check1(){
	if(zcfrm1.yonghuming.value==""||zcfrm1.yonghuming.value.length<6)
	{
		alert("用户名不能少于6位!");
		zcfrm1.yonghuming.focus();
		return false;
	}
	
	if(zcfrm1.mima.value==""||zcfrm1.mima.value.length<6)
	{
		alert("密码不能少于6位!");
		zcfrm1.mima.focus();
		return false;
	}
		zcfrm1.submit();
}
  </SCRIPT>	
  
  <script language="javascript">
function form2_onsubmit()
{
	 if(form2.keyword.value=='' || form2.keyword.value=='请输入关键字')
	 {
		   alert('关键字不能为空!');
		   form2.keyword.focus();
		   return false;
	 }
	
	 return true;
}
</script>	

</head>
<body oncontextmenu="event.returnValue=false" onselectstart="event.returnValue=false">

<div align="center" >

	<table border="0" width="960" id="table1" cellspacing="0" cellpadding="0" bgcolor="#F2F2F2" height="27" style="width: 960px; height: 27px;">
		<FORM method=post name=zcfrm1 action=servlet/logininCheck>
		<tr>
			<td width="6" height="24" colspan="2" rowspan="2">　</td>
			<td width="30" height="24" colspan="2" rowspan="2">用户:</td>
			<td width="134" height="24" colspan="2" rowspan="2"> 
            <input name="yonghuming" size="18" style="border: 1px solid #A5ACB2; color:#A5ACB2"></td>
			<td width="6" height="24" colspan="2" rowspan="2">　</td>
			<td width="30" height="24" colspan="2" rowspan="2">密码:</td>
			<td width="151" height="24" colspan="2" rowspan="2">&nbsp;<input type=password name=mima size="18" style="border: 1px solid #A5ACB2; color:#A5ACB2">
                            </td>
			<td width="138" height="24" colspan="1" rowspan="2" valign="middle"><img src="img/LAND.GIF" width="51" height="20" style="CURSOR: hand" onClick="check1();"> &nbsp;&nbsp;<a href="register.jsp" target="_blank"><img src="img/REGISTER.GIF" width="51" height="20" border="0"></a></td>
			<td width="200" height="24" colspan="1" rowspan="2">
			
            &nbsp;
            还没有注册?，请点击<A href='register.jsp'><font color=red>注册</font></A>
            &nbsp;
             
			</td>
		  <td height="24" colspan="2" rowspan="2" align="right"><script>document.write(mydate);</script>&nbsp;&nbsp;		
		</td></tr>
		<tr><td height="1" colspan="16" rowspan="2"></td></tr>
		</form>
	</table>
	
	<table border="0" width="960" id="table2" cellspacing="0" cellpadding="0" height="107" background="img/loge_bj.gif">
		<tr>
			<td width="18">　</td>
			<td width="302">
			<img border="0" src="img/LOGO.gif" width="295" height="59" style="margin-top: -1"></td>
			<td>
			<div align="center">
			<table border="0" width="650" id="table3" cellspacing="3" cellpadding="0">
				<tr>
					<td>
					<p align="center"><span class="STYLE7" style="font-size: 14px"><font style="font-weight:700">
				  <a style="font-size: 14px; font-weight: 700" href="index.jsp">首页</a>|
                  <a style="font-size: 14px; font-weight: 700" href="zbyg.jsp" target="_blank">招标预告</a>|
                  <a style="font-size: 14px; font-weight: 700" href="zbgg.jsp" target="_blank">招标公告</a>|
                  <a style="font-size: 14px; font-weight: 700" href="zbtg.jsp" target="_blank">中标公告</a>|
                  <a style="font-size: 14px; font-weight: 700" href="bctg.jsp" target="_blank">补充公告</a>|
                  <a style="font-size: 14px; font-weight: 700" href="xmxx.jsp" target="_blank">项目信息</a>|
                  <a style="font-size: 14px; font-weight: 700" href="zcfg.jsp" target="_blank">政策法规</a>|
                  <a style="font-size: 14px; font-weight: 700" href="gqxx.jsp" target="_blank">采购公告</a>|
                  <a style="font-size: 14px; font-weight: 700" href="lx.jsp" target="_blank">联系我们</a></font></span></td>
			  </tr>
				<tr>
					<td height="1" bgcolor="#DCDCDC">
					<p align="center">
					<img border="0" src="img/dh.gif" width="630" height="5"></td>
			  </tr>
				<tr>
					<td>
					<div align="right">
						<table border="0" width="650" id="table4" cellspacing="0" cellpadding="0" style="margin-top: 3">
							<tr>
								<td class = "zftj" style="text-align:center; font-size:22px; margin-top:5px; padding-top:10px;"><strong>★政府推荐招标信息网站★</strong></td>
								<td align="right"><a href="fbzb.jsp" target="_blank">
								<img border="0" src="img/L_fbzb.gif" width="82" height="23"></a></td>
								<td align="right"><a href="gqxx.jsp" target="_blank">
								<img border="0" src="img/L_wycg.gif" width="82" height="23"></a></td>
								<td align="right"><a href="bsxz.jsp" target="_blank">
								<img border="0" src="img/L_bsxz.gif" width="82" height="23"></a></td>
								<td align="right"><a href="http://www.51zxzb.com:6080/" target="_blank"> 
								<img border="0" src="img/L_qyyx.gif" width="82" height="23"></a></td>
							</tr>
						</table>
					</div>
					</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
	</table>
	<table border="0" width="960" id="table5" cellspacing="0" cellpadding="0" height="161" style="background-image:url(img/ss_bj.gif)">
		<tr>
			<td valign="top">
			<table border="0" width="100%" id="table6" height="161"><tr>
			<td height="50">
			
				<table border="0" width="805" id="table7" cellpadding="5" cellspacing="0">
						<FORM id=form2 method=post name=form2 action=find2.jsp target=_blank onSubmit="return form2_onsubmit()" >
						<tr valign=middle>
							<td width="5">&nbsp;</td>
                            <td align='center' width="150"><input value="请输入关键字" name="keyword" size="20" style="border: 1px solid #999999; color:#999999" onMouseDown='key()' onBlur='key1()' onKeyDown='return event.keyCode != 13'></td>  
							<td width="80">
							<select class=ze name=zhonglei onmouseover=this.focus()>
			                <option selected value="招标信息">招标信息</option>                
			                <option value="招标预告">招标预告</option>
			                <option value="招标公告">招标公告</option>
			                <option value="中标公告">中标公告</option>
			                <option value="补充通告">补充通告</option>
			                </select>
							</td>     
							<td width="138">
							<select name="hangye" onmouseover=this.focus()>
                			<option selected="selected" value="所有行业">所有行业</option>
				 
		            		<option value="交通工程">交通工程</option>
		            
		            		<option value="水利水电">水利水电</option>
		            
		            		<option value="市政工程">市政工程</option>
		            
		            		<option value="机电设备">机电设备</option>
		            
		            		<option value="建筑工程">建筑工程</option>
		            
		            		<option value="建筑装饰与幕墙">建筑装饰与幕墙</option>
		            
		            		<option value="系统工程">系统工程</option>
		            
		            		<option value="照明亮化">照明亮化</option>
		            
		            		<option value="环保绿化">环保绿化</option>
		            
		            		<option value="工业控制与自动化">工业控制与自动化</option>
		            
		            		<option value="建筑工程项目及设备">建筑工程项目及设备</option>
		            
		            		<option value="交通运输工程及设备">交通运输工程及设备</option>
		            
		            		<option value="金融设备">金融设备</option>
		            
		            		<option value="造纸印刷及包装">造纸印刷及包装</option>
		            
		            		<option value="电气设备">电气设备</option>
		            
		            		<option value="冶金矿产">冶金矿产</option>
		            
		            		<option value="水利工程及设备">水利工程及设备</option>
		            
		            		<option value="办公家具">办公家具</option>
		            
		            		<option value="文教产品">文教产品</option>
		            
		            		<option value="体育设施器材">体育设施器材</option>
		            
		            		<option value="医疗卫生">医疗卫生</option>
		            
		            		<option value="安全防护">安全防护</option>
		            
		            		<option value="弱电智能">弱电智能</option>
		            		
		            		<option value="石油化工">石油化工</option>
		            
		            		<option value="机械仪表">机械仪表</option>
		            		
		            		<option value="通讯设备及电子产品">通讯设备及电子产品</option>
		            		
		            		<option value="厨房设备">厨房设备</option>
		            		
		            		<option value="电力项目">电力项目</option>
							<option value="文艺体育及旅游设备">文艺体育及旅游设备</option>
						<option value="服务及其他">服务及其他</option>
						<option value="政府采购品目">政府采购品目</option>
						<option value="纺织服装与皮革">纺织服装与皮革</option>
						<option value="农林牧渔">农林牧渔</option>
						<option value="能源物资">能源物资</option>
						<option value="金融设备">金融设备</option>
		            		
		            		<option value="其他">其他</option>
	                		</select>
							</td> 
							<td width="75">
							<SELECT class=bd1 onmouseover=this.focus() name=diqu> 
		                    <OPTION selected value="所有省份">所有省份</OPTION> 
		                    <OPTION value=北京市>北京市</OPTION> 
		                    <OPTION value=天津市>天津市</OPTION> 
		                    <OPTION 
		                    value=河北省>河北省</OPTION> 
		                    <OPTION value=山西省>山西省</OPTION> 
		                    <OPTION value=内蒙古自治区>内蒙古自治区</OPTION> 
		                    <OPTION 
		                    value=辽宁省>辽宁省</OPTION> 
		                    <OPTION value=吉林省>吉林省</OPTION> 
		                    <OPTION value=黑龙江省>黑龙江省</OPTION> 
		                    <OPTION 
		                    value=上海市>上海市</OPTION> 
		                    <OPTION value=江苏省>江苏省</OPTION> 
		                    <OPTION value=浙江省>浙江省</OPTION> 
		                    <OPTION 
		                    value=安徽省>安徽省</OPTION> 
		                    <OPTION value=福建省>福建省</OPTION> 
		                    <OPTION value=江西省>江西省</OPTION> 
		                    <OPTION 
		                    value=山东省>山东省</OPTION> 
		                    <OPTION value=河南省>河南省</OPTION> 
		                    <OPTION value=湖北省>湖北省</OPTION> 
		                    <OPTION 
		                    value=湖南省>湖南省</OPTION> 
		                    <OPTION value=广东省>广东省</OPTION> 
		                    <OPTION value=广西壮族自治区>广西壮族自治区</OPTION> 
		                    <OPTION 
		                    value=海南省>海南省</OPTION> 
		                    <OPTION value=重庆市>重庆市</OPTION> 
		                    <OPTION value=四川省>四川省</OPTION> 
		                    <OPTION 
		                    value=贵州省>贵州省</OPTION> 
		                    <OPTION value=云南省>云南省</OPTION> 
		                    <OPTION value=西藏自治区>西藏自治区</OPTION> 
		                    <OPTION 
		                    value=陕西省>陕西省</OPTION> 
		                    <OPTION value=甘肃省>甘肃省</OPTION> 
		                    <OPTION value=青海省>青海省</OPTION> 
		                    <OPTION 
		                    value=宁夏回族自治区>宁夏回族自治区</OPTION> 
		                    <OPTION 
		                    value=新疆维吾尔自治区>新疆维吾尔自治区</OPTION> 
		                    <OPTION 
		                    value=台湾省>台湾省</OPTION> 
		                    <OPTION 
		                    value=香港特别行政区>香港特别行政区</OPTION> 
		                    <OPTION 
		                    value=澳门特别行政区>澳门特别行政区</OPTION>
		                  	</SELECT>
							</td>   
							<td width="72">
							<select name="shijian" id="select3" onmouseover=this.focus()>
	                          <option value="不限" selected>时间不限</option>
	                          <option value="一天以内">一天以内</option>
	                          <option value="三天以内">三天以内</option>
	                          <option value="一周以内">一周以内</option>
	                          <option value="一月以内">一月以内</option>
	                        </select>
							</td>
							<td width="78">
							<select name="fanwei" id="fanwei" onmouseover=this.focus()>
				            <option value="标题" selected>标题</option>
				            <option value="内容">内容</option>
				          	</select>
							</td>     
							<td width="106">
							<input name="Login2" type="submit" id="Login2" style="background:url(images/ss2.gif);border:0px;width:83px;height:20px" value="" /></td>     
					    <td width="13"></td>    
					  </tr></FORM>
					</table>
					</td>
				</tr>
				<tr>
					<td height="76">
					<table border="0" width="100%" id="table8" cellspacing="3">
						<tr>
							<td valign="top">
						  	<p align="center" class="style1 STYLE6"><b>热门检索:</b></td>
							<td width="874">
							<span class="style1 STYLE6"><b>交通工程：</b>
							<a href='find2.jsp?keyword=高速公路&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>高速公路</a>
							<a href='find2.jsp?keyword=伸缩缝&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>伸缩缝</a>
							<a href='find2.jsp?keyword=航道&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>航道</a>
							&nbsp; <b>&nbsp;市政工程：</b>
							<a href='find2.jsp?keyword=市政道路&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>市政道路</a>
							<a href='find2.jsp?keyword=污水处理&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>污水处理</a> 
							<a href='find2.jsp?keyword=管道&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>管道</a> 
							<a href='find2.jsp?keyword=广场&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>广场</a>
							&nbsp;&nbsp; <b>水利水电：</b>
							<a href='find2.jsp?keyword=机械仪表&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>机械仪表</a> 
							<a href='find2.jsp?keyword=规划设计&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>规划设计</a> 
							<a href='find2.jsp?keyword=勘测勘察&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>勘测勘察</a>
							&nbsp; <b>&nbsp;&nbsp; 暖通：</b>
							<a href='find2.jsp?keyword=空调&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>空调</a> 
							<a href='find2.jsp?keyword=机房&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>机房</a> 
							<a href='find2.jsp?keyword=锅炉&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>锅炉</a>&nbsp; 
							</span>
							<span class="style1 STYLE6"><b>机电行业：</b>
							<a href='find2.jsp?keyword=钢结构&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>钢结构</a> 
							<a href='find2.jsp?keyword=磨具&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>磨具</a> 
							<a href='find2.jsp?keyword=起重机&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>起重机</a>
							&nbsp;&nbsp;&nbsp;&nbsp; <b>体育设施：</b>
							<a href='find2.jsp?keyword=塑胶跑道&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>塑胶跑道</a> 
							<a href='find2.jsp?keyword=运动场地&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>运动场地</a> 
							<a href='find2.jsp?keyword=草坪&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>草坪</a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>电气设备：</b>
							<a href='find2.jsp?keyword=电气&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>电气</a> 
							<a href='find2.jsp?keyword=开关柜&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>开关柜</a> 
							<a href='find2.jsp?keyword=变压器&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>变压器</a>
							&nbsp;&nbsp;&nbsp;&nbsp;<b>办公家具：</b>
							<a href='find2.jsp?keyword=办公用品&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>办公用品</a>
							</span>
							<p class="style1 STYLE6"><b>安全防护：</b>
							<a href='find2.jsp?keyword=监控&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>监控</a> 
							<a href='find2.jsp?keyword=弱电智能&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>弱电智能</a>
							&nbsp;&nbsp;&nbsp; <b>&nbsp;&nbsp;&nbsp;&nbsp; 
							厨房设备：</b>
							<a href='find2.jsp?keyword=橱柜&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>橱柜</a> 
							<a href='find2.jsp?keyword=厨具&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>厨具</a>
							&nbsp;&nbsp;&nbsp; <b>&nbsp; 建筑工程与设备：</b>
							<a href='find2.jsp?keyword=钢材&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>钢材</a> 
							<a href='find2.jsp?keyword=装饰&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>装饰</a> 
							<a href='find2.jsp?keyword=地基&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>地基</a>
							&nbsp;&nbsp; <b>绿化：</b>
							<a href='find2.jsp?keyword=景观&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>景观</a> 
							<a href='find2.jsp?keyword=古建&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>古建</a> 
							<a href='find2.jsp?keyword=养护&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>养护</a>
							&nbsp;&nbsp; <b>照明：</b>
							<a href='find2.jsp?keyword=亮化&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>亮化</a> 
							<a href='find2.jsp?keyword=LED&zhonglei=招标信息&hangye=所有行业&diqu=所有省份&shijian=不限&fanwei=内容'>LED</a></p>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td>
					<table border="0" width="100%" id="table9">
						<tr>
							<td width="21"><div align="right"></div></td>
						  <td><MARQUEE behavior=scroll scrollAmount=2 scrollDelay=30 onMouseOut="this.start()" onMouseOver="this.stop()">
                          <font color="#FF0000"><b>欢迎光临中国在线招标网！ 
						  一切商机，尽在中国在线招标网！ 中国在线招标网，助您实现心中的梦想！客服热线：025-86310809、市场部：025-86527486、传真：025-86527476 QQ号：1253196607 欢迎来电或在线咨询！我们将竭诚为您服务！ </b></font>
						  </MARQUEE></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
	  </tr>
	</table>
</div>
</body>
</html></td></tr>
<TR>
<TD bgColor=#ffffff height=208 vAlign="middle">
            <div align="center"></div>
            <div align="left"></div>
            <div align="center"></div>
            <FORM method=post name=frm action=servlet/adduserCheck>
            <input type="hidden" id="jiaose" name="jiaose" value="免费会员">
     <TABLE class=z border=1 cellSpacing=0 cellPadding=0 width="962" align=center>
              
              <TBODY>
              <TR>
                <TD class=table1  background="img/bg3.jpg" colSpan=3><p><font color="#ff0000"><span class="STYLE16 STYLE19"><br> 
                请认真填写资料：（注意带<span class="STYLE12">(*)</span>号为必填选项）<br> 
                <br> 
                注：为了方便中国在线招标网更好地为您服务，请您仔细填写单位名称和联系方式。</span></font></p>
                  <p><BR>
                  </p></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff height=50 width="19%">
                <DIV align=center class="STYLE19">用户账号</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50 vAlign="middle" 
                width="48%"><INPUT style="WIDTH: 90%" id=yonghuming class=bd 
                  name=yonghuming> <SPAN class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></TD>
                <TD class=table1 bgColor=#ffffff height=50 
                  width="33%"><div align="left">可使用6-20个英文字母或数字，区分英文字母大小写。 请不要用除下划线外的符号或空格！</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">用户密码</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><INPUT 
                  style="WIDTH: 90%" class=bd type=password id=mima name=mima> <SPAN 
                  class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></TD>
                <TD class=table1 
                  bgColor=#ffffff><div align="left">密码由6-20个英文字母(区分大小写)或数字组成，建议使用易记；难猜的英文数字组合。</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">确认密码</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><INPUT 
                  style="WIDTH: 90%" class=bd type=password name=mima2> <SPAN 
                  class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">请再次输入与上面一样的密码</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff height=50>
                <DIV align=center class="STYLE19">单位名称</DIV></TD>
                <TD class=table1 bgColor=#ffffff><INPUT style="WIDTH: 90%" 
                  class=bd name=danweimingcheng id=danweimingcheng> <SPAN 
                class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">填写您单位的全称</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff height="50">
                <div align="center" class="STYLE19">单位地址</div></TD>
                <TD class=table1 bgColor=#ffffff height=50><div align="left">
                  <input style="WIDTH: 90%" class=bd name=danweidizhi>
                </div></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">填写您单位的详细地址</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">企业法人</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><INPUT 
                  style="WIDTH: 90%" id=qiyefaren class=bd name=qiyefaren> <SPAN 
                  class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">正确填写您单位的企业法人名称</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">联系人员</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><INPUT 
                  style="WIDTH: 90%" class=bd name=lianxiren> <SPAN 
                  class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">填写能够联系到的联系人姓名</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">联系电话</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><INPUT 
                  style="WIDTH: 90%" class=bd name=lianxidianhua> <SPAN 
                  class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">填写有效的联系电话</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">联系传真</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><INPUT style="WIDTH: 90%" id=lianxichuanzhen class=bd name=lianxichuanzhen></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">填写有效的联系传真</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">电子邮箱</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><INPUT 
                  style="WIDTH: 90%" class=bd name=dianziyouxiang> <SPAN 
                  class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">请输入您常用的电子邮箱。</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">网站地址</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><INPUT style="WIDTH: 90%" class=bd name=wangzhandizhi></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">如果您的企业已有网站，请您输入您的网站地址。</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">所属地区</DIV></TD>
                <TD class=table1 bgColor=#ffffff height=50><div align="left">
                  <SELECT class=bd1 
                  onmouseover=this.focus() name=diqu> 
                    <OPTION selected value="">所有省份</OPTION> 
                    <OPTION value=北京市>北京市</OPTION> 
                    <OPTION value=天津市>天津市</OPTION> 
                    <OPTION 
                    value=河北省>河北省</OPTION> 
                    <OPTION value=山西省>山西省</OPTION> 
                    <OPTION value=内蒙古自治区>内蒙古自治区</OPTION> 
                    <OPTION 
                    value=辽宁省>辽宁省</OPTION> 
                    <OPTION value=吉林省>吉林省</OPTION> 
                    <OPTION value=黑龙江省>黑龙江省</OPTION> 
                    <OPTION 
                    value=上海市>上海市</OPTION> 
                    <OPTION value=江苏省>江苏省</OPTION> 
                    <OPTION value=浙江省>浙江省</OPTION> 
                    <OPTION 
                    value=安徽省>安徽省</OPTION> 
                    <OPTION value=福建省>福建省</OPTION> 
                    <OPTION value=江西省>江西省</OPTION> 
                    <OPTION 
                    value=山东省>山东省</OPTION> 
                    <OPTION value=河南省>河南省</OPTION> 
                    <OPTION value=湖北省>湖北省</OPTION> 
                    <OPTION 
                    value=湖南省>湖南省</OPTION> 
                    <OPTION value=广东省>广东省</OPTION> 
                    <OPTION value=广西壮族自治区>广西壮族自治区</OPTION> 
                    <OPTION 
                    value=海南省>海南省</OPTION> 
                    <OPTION value=重庆市>重庆市</OPTION> 
                    <OPTION value=四川省>四川省</OPTION> 
                    <OPTION 
                    value=贵州省>贵州省</OPTION> 
                    <OPTION value=云南省>云南省</OPTION> 
                    <OPTION value=西藏自治区>西藏自治区</OPTION> 
                    <OPTION 
                    value=陕西省>陕西省</OPTION> 
                    <OPTION value=甘肃省>甘肃省</OPTION> 
                    <OPTION value=青海省>青海省</OPTION> 
                    <OPTION 
                    value=宁夏回族自治区>宁夏回族自治区</OPTION> 
                    <OPTION 
                    value=新疆维吾尔自治区>新疆维吾尔自治区</OPTION> 
                    <OPTION 
                    value=台湾省>台湾省</OPTION> 
                    <OPTION 
                    value=香港特别行政区>香港特别行政区</OPTION> 
                    <OPTION 
                    value=澳门特别行政区>澳门特别行政区</OPTION>
                  </SELECT> 
                <SPAN 
                  class="z STYLE6 STYLE2 STYLE12">(*)</SPAN></div></TD>
                <TD class=table1 bgColor=#ffffff><div align="left">选择您企业所在地区</div></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">企业资质</DIV></TD>
                <TD class=table1 bgColor=#ffffff><TEXTAREA style="WIDTH: 100%" rows=7 cols=30 name=qiyezizhi></TEXTAREA></TD>
                <TD class=table1 bgColor=#ffffff>　
                <div align="left">请填写您企业获得的等级资质</div></TD></TR>
              <TR>
                <TD bgColor=#eff4ff class=table1>
                  <DIV align=center class="STYLE19">业务范围</DIV>
                  <DIV align=center></DIV>
                  <DIV align=center></DIV>
                  <DIV align=center></DIV>
                  <DIV align=center></DIV></TD>
                <TD class=table1 bgColor=#ffffff colSpan=2>
                  <TABLE id=buyonline2 class=z cellSpacing=0 cellPadding=0 
                  width="100%" border="1">
                    <TBODY>
                    <TR>
                      <TD width="49%" height="30"><div align="center" class="STYLE18">所属行业</div></TD>
                      <TD width="51%" ><div align="center" class="STYLE18">业务开展地</div></TD>
                    </TR>
                    <TR>
                      <TD>
                        <TABLE border=0 width=300>
                          <TBODY>
                          <TR style="width: 330px">
                            <TD width="10%"></TD>
                            <TD width="25%"><select style="WIDTH: 120px" 
                              ondblclick="moveOption(document.frm.trade_list1, document.frm.trade_list2)" 
                              multiple size=6 name=trade_list1>
                              <option value="交通工程">交通工程</option>
	            
	            		<option value="水利水电">水利水电</option>
	            
	            		<option value="市政工程">市政工程</option>
	            
	            		<option value="机电设备">机电设备</option>
	            
	            		<option value="建筑工程">建筑工程</option>
	            
	            		<option value="建筑装饰与幕墙">建筑装饰与幕墙</option>
	            
	            		<option value="系统工程">系统工程</option>
	            
	            		<option value="照明亮化">照明亮化</option>
	            
	            		<option value="环保绿化">环保绿化</option>
	            
	            		<option value="工业控制与自动化">工业控制与自动化</option>
	            
	            		<option value="建筑工程项目及设备">建筑工程项目及设备</option>
	            
	            		<option value="交通运输工程及设备">交通运输工程及设备</option>
	            
	            		<option value="金融设备">金融设备</option>
	            
	            		<option value="造纸印刷及包装">造纸印刷及包装</option>
	            
	            		<option value="电气设备">电气设备</option>
	            
	            		<option value="冶金矿产">冶金矿产</option>
	            
	            		<option value="水利工程及设备">水利工程及设备</option>
	            
	            		<option value="办公家具">办公家具</option>
	            
	            		<option value="文教产品">文教产品</option>
	            
	            		<option value="体育设施器材">体育设施器材</option>
	            
	            		<option value="医疗卫生">医疗卫生</option>
	            
	            		<option value="安全防护">安全防护</option>
	            
	            		<option value="弱电智能">弱电智能</option>
	            		
	            		<option value="石油化工">石油化工</option>
	            
	            		<option value="机械仪表">机械仪表</option>
	            		
	            		<option value="通讯设备及电子产品">通讯设备及电子产品</option>
	            		
	            		<option value="厨房设备">厨房设备</option>
	            		
	            		<option value="电力项目">电力项目</option>
	            		
                            </select></TD>
                            <TD><SELECT style="WIDTH: 120px" 
                              ondblclick="moveOption(document.frm.trade_list2, document.frm.trade_list1)" 
                              multiple size=6 name=trade_list2></SELECT></TD></TR></TBODY></TABLE>
                              <INPUT size=40 type=hidden 
                        name=suoshuhangye> <INPUT size=40 type=hidden 
                        name=yewukaizhandi> </TD>
                      <TD>
                        <TABLE border=0 width=300>
                          <TBODY>
                          <TR>
                            <TD width="25%"><SELECT style="WIDTH: 120px" 
                              ondblclick="moveOption(document.frm.zone_list1, document.frm.zone_list2)" 
                              multiple size=6 name=zone_list1> <OPTION 
                                value=新疆维吾尔自治区>新疆维吾尔自治区</OPTION> <OPTION 
                                value=西藏自治区>西藏自治区</OPTION> <OPTION 
                                value=青海省>青海省</OPTION> <OPTION 
                                value=内蒙古自治区>内蒙古自治区</OPTION> <OPTION 
                                value=宁夏自治区>宁夏自治区</OPTION> <OPTION 
                                value=四川省>四川省</OPTION> <OPTION 
                                value=云南省>云南省</OPTION> <OPTION 
                                value=陕西省>陕西省</OPTION> <OPTION 
                                value=湖北省>湖北省</OPTION> <OPTION 
                                value=湖南省>湖南省</OPTION> <OPTION 
                                value=贵州省>贵州省</OPTION> <OPTION 
                                value=广西壮族自治区>广西壮族自治区</OPTION> <OPTION 
                                value=河北省>河北省</OPTION> <OPTION 
                                value=北京市>北京市</OPTION> <OPTION 
                                value=河南省>河南省</OPTION> <OPTION 
                                value=安徽省>安徽省</OPTION> <OPTION 
                                value=江西省>江西省</OPTION> <OPTION 
                                value=黑龙江省>黑龙江省</OPTION> <OPTION 
                                value=吉林省>吉林省</OPTION> <OPTION 
                                value=辽宁省>辽宁省</OPTION> <OPTION 
                                value=天津市>天津市</OPTION> <OPTION 
                                value=山东省>山东省</OPTION> <OPTION 
                                value=江苏省>江苏省</OPTION> <OPTION 
                                value=上海市>上海市</OPTION> <OPTION 
                                value=浙江省>浙江省</OPTION> <OPTION 
                                value=福建省>福建省</OPTION> <OPTION 
                                value=广东省>广东省</OPTION> <OPTION 
                                value=海南省>海南省</OPTION> <OPTION 
                                value=山西省>山西省</OPTION> <OPTION 
                                value=甘肃省>甘肃省</OPTION> <OPTION 
                                value=重庆市>重庆市</OPTION> <OPTION 
                                value=香港特别行政区>香港特别行政区</OPTION> <OPTION 
                                value=澳门特别行政区>澳门特别行政区</OPTION></SELECT> </TD>
                            <TD width="25%" valign=middle><INPUT onClick="moveOption(document.frm.zone_list1, document.frm.zone_list2)" value=添加 type=button><BR><INPUT onClick="moveOption(document.frm.zone_list2, document.frm.zone_list1)" value=删除 type=button><BR>
                            <INPUT onClick="moveAllOption(document.frm.zone_list1, document.frm.zone_list2)" value=全选 type=button><BR><INPUT onClick="moveAllOption(document.frm.zone_list2, document.frm.zone_list1)" value=全删 type=button></TD>
                          <TD width="25%"><SELECT style="WIDTH: 120px" 
                              ondblclick="moveOption(document.frm.zone_list2, document.frm.zone_list1)" 
                              multiple size=6 name=zone_list2></SELECT>                          </TD></TR></TBODY></TABLE></TD></TR>
                    <TR>
                      <TD colSpan=2 height="40"><FONT 
                        color=#ff0000>★注：选择订阅您所关心的行业与地区信息，双击条目名称即可添加到选择结果栏内，如果想删除您选择的条目，在选择结果栏中双击产品名称即可删除您所选择的条目！<STRONG>地区范围如果为全国,可以不必选择!</STRONG></FONT></TD>
                    </TR>
                <TR>                </TR></TBODY></TABLE></TD></TR>
              <TR>
                <TD class=table1 bgColor=#eff4ff>
                <DIV align=center class="STYLE19">企业简介</DIV></TD>
                <TD class=table1 bgColor=#ffffff vAlign="middle" colSpan=2><TEXTAREA style="WIDTH: 100%" rows=7 cols=70 name=qiyejianjie></TEXTAREA></TD></TR>
              <TR>
                <TD bgColor=#eff4ff>
                <DIV align=center class="STYLE19">成功案例</DIV></TD>
                <TD bgColor=#ffffff colSpan=2><TEXTAREA style="WIDTH: 100%" rows=7 cols=70 name=chenggonganli></TEXTAREA></TD></TR>
              <TR>
                <TD bgColor=#eff4ff height=36>
                <DIV align=center class="STYLE19">服务条款</DIV></TD>
                <TD bgColor=#ffffff colSpan=2>
                  <DIV 
                  onclick="MM_openBrWindow('fwtk.jsp','中国在线招标网服务条款','scrollbars=yes,width=600,height=500')" 
                  align=left><div align="center">
                    <h1><A href="fwtk.jsp" class="STYLE16" target=_blank valign="middle">《阅读中国在线招标网会员服务条款》</A></h1>
                  </div>
                  </DIV></TD></TR>
              <TR>
                <TD bgColor=#eff4ff rowSpan=2>
                  <DIV align=center><span class="STYLE19">提交注册</span></DIV></TD>
                <TD bgColor=#ffffff height=56 colSpan=2><LABEL>
                  <DIV align="center"><INPUT onclick=check(); value=同意服务条款，提交注册信息 type=button name=Submit2> 
                  </DIV></LABEL></TD></TR>            
              <TR>
                <TD bgColor=#bbcefb colSpan=3>
                  <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" 
                  height=1>
                    <TBODY>
                    <TR>
   <TD></TD></TR></TBODY></TABLE></TD></TR></TABLE></FORM></TD></TR>
 <script>
function check(){
	if(frm.yonghuming.value==""||frm.yonghuming.value.length<6)
	{
		alert("用户名不能少于6位!");
		frm.yonghuming.focus();
		return false;
	}
	
	if(frm.mima.value==""||frm.mima.value.length<6)
	{
		alert("密码不能少于6位!");
		frm.mima.focus();
		return false;
	}

	if(frm.mima.value!=frm.mima2.value)
	{
		alert("密码与确认密码不一致!");
		frm.mima.focus();
		return false;
	}
	
	if(frm.danweimingcheng.value==""||frm.danweimingcheng.value==null)
	{
		alert("请输单位名称!");
		frm.danweimingcheng.focus();
		return false;
	}
	
	if(frm.qiyefaren.value==""||frm.qiyefaren.value==null)
	{
		alert("请输入企业法人名称!");
		frm.qiyefaren.focus();
		return false;
	}
	
	if(frm.lianxiren.value==""||frm.lianxiren.value==null)
	{
		alert("请输入联系人!");
		frm.lianxiren.focus();
		return false;
	}
	
	if(frm.lianxidianhua.value==""||frm.lianxidianhua.value==null)
	{
		alert("请输入联系电话!");
		frm.lianxidianhua.focus();
		return false;
	}
	
	if(frm.dianziyouxiang.value==""||frm.dianziyouxiang.value==null)
	{
		alert("请输入电子邮箱!");
		frm.dianziyouxiang.focus();
		return false;
	}
	
	if(IsValidEmail(frm.dianziyouxiang.value)!="")
	{
		alert(IsValidEmail(frm.dianziyouxiang.value));
		frm.dianziyouxiang.focus();
		return false;		
	}
	
	if(frm.diqu.value==""||frm.diqu.value==null)
	{
		alert("请选择企业所在地区!");
		frm.diqu.focus();
		return false;
	}	
	frm.submit();
}
</script>  
   
    	<tr><td align="center">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>end</title>
</head>
<body oncontextmenu="event.returnValue=false" onselectstart="event.returnValue=false">
	<table border="0" width="966" id="table67" cellspacing="0" cellpadding="0" style="margin-top: 6; margin-bottom: 6">
		<tr>
			<td width="21">
			<img border="0" src="img/d_01.gif" width="21" height="77"></td>
			<td background="img/d_02.gif">
			<table border="0" width="100%" id="table68" height="77">
    <tr>
					
				  <td width="16%">
					<font size="2"><img width="143" height="24" border="0" src="img/d_logo.gif"></font></td>
				  <td width="100%"><div align="center"><font size="2">地址：南京市鼓楼区凤凰西街219号 客服热线：025-86527486、市场部：025-86527486、传真：025-86527476 <br>
				    QQ号：1253196607</font></div></td>
			  </tr>
				<tr>
					<td height="27" colspan="3">
					<p align="center"><font size="2">COPYRIGHT&copy; 2006-2009 ALL RIGHTS RESERVED  
					中国在线招标网 版权所有 苏ICP备：09081385号 </font><script src="http://s20.cnzz.com/stat.php?id=3978161&web_id=3978161&show=pic" language="JavaScript"></script>
</td>
				</tr>
			</table>
		  </td>
			<td width="21">
			<img border="0" src="img/d_03.gif" width="21" height="77"></td>
		</tr>
	</table>
</body>
</html></td></tr>
    </table>
    </center>
  </body>
</html>
