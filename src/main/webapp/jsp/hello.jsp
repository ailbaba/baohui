<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="elsHeader.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线竞标专业版</title>
<style type="text/css">
	h1{
		font-family: 微软雅黑;
		color:darkred;
	}
	img{
		position: absolute;
		left: 525px;
		top: 150px;
	}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/function.js"></script>
</head>
<body>
<div class="pos-relative public-wrap">
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common"></span>
            <div class="common-box-line">
               <form id="accoutForm">
                <input type="hidden" id="elsAccount" name="elsAccount">
                <input type="hidden" id="pageSize" name="pageSize" value="10">
		        <input type="hidden" id="currentPage" name="currentPage" value="1"> 
                <div class="dis-in-b input-and-tip">
			       <span>子账号:</span><input id="elsSubAccount" name="elsSubAccount" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			       <span>姓名:</span><input id="name" name="name" type="text" style="width:200px;"/>
		        </div>
		        <div class="dis-in-b input-and-tip">
			        <select class="" id="station" name="station">
						<option value="">全部岗位</i18n:I18n></option>
						<option value="purchase">采购岗位</option>
						<option value="sale">销售岗位</option>
					</select>
		        </div>
                </form>
            </div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">基本操作</span>
            <div class="common-box-line">
                <div class="dis-in-b input-and-tip">
                     <button id="queryAccountInfo" class="button-wrap">查询</button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="addAccountInfo" class="button-wrap" >增加</button>
                </div>
		        <div class="dis-in-b input-and-tip">
                     <button id="updateAccountInfo" class="button-wrap">修改</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="deleteAccountInfo" class="button-wrap">删除</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="assignRole" class="button-wrap">分配角色</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="assignPermission" class="button-wrap">分配权限</button>
                </div>
                <div class="dis-in-b input-and-tip">
                     <button id="assignApp" class="button-wrap">分配应用</button>
                </div>
            	</div>
        </div>
        <div class="box-wrap pos-relative bg-common">
            <span class="dis-in-b pos-absolute box-tip bg-common">信息浏览</span>
            <div class="common-box-line">
               <main class="grid-container">
                    <div class="grid-100">
                        <table id="table-account"></table>
                        <div id="pg" style="text-align: right;"></div>
                    </div>
                </main>
            </div>
        </div>
</div>
<tbody><tr>
			<td width="6" height="24" colspan="2" rowspan="2">　</td>
			<td width="30" height="24" colspan="2" rowspan="2">手机号：</td>
			<td width="134" height="24" colspan="2" rowspan="2"> 
            <input name="yonghuming" size="18" style="border: 1px solid #A5ACB2; color:#A5ACB2"></td>
			<td width="6" height="24" colspan="2" rowspan="2">　</td>
			<td width="30" height="24" colspan="2" rowspan="2">密码:</td>
			<td width="151" height="24" colspan="2" rowspan="2">&nbsp;<input type="password" name="mima" size="18" style="border: 1px solid #A5ACB2; color:#A5ACB2">
                            </td>
			<td width="138" height="24" colspan="1" rowspan="2" valign="middle"><img src="${pageContext.request.contextPath}/image/LAND.GIF" width="51" height="20" style="CURSOR: hand" onclick="check1();"> &nbsp;&nbsp;<a href="register.jsp" target="_blank"><img src="${pageContext.request.contextPath}/image/REGISTER.GIF" width="51" height="20" border="0"></a></td>
			<td width="200" height="24" colspan="1" rowspan="2">
			
            &nbsp;
            还没有注册?，请点击<a href="register.jsp"><font color="red">注册</font></a>
            &nbsp;
             
			</td>
		  </tr>
		<tr><td height="1" colspan="16" rowspan="2"></td></tr>
		
	</tbody>
    =================helloworld jsp=================
	<h1 align="center" style="display: none">携凌云之势,御苍穹之风</h1><br/>
	<h3>填写资料,立即报名</h3>  
 <form method="post" action="/activity/saveActivityIndividual" class="form1">  
  <h3>个人报名</h3>  
  <p> 姓名:<input type="text" name="name" /></p>  
  <p> 性别: <input type="text" name="sex" /></p>  
  <p> 星座:<input type="text" name="constellation" /></p>  
  <p> 电话: <input type="text" name="telephoneNumber" /></p>  
  <input type="button" value="Submit" class="btn1" />  
</form> 
	<img align="middle" style="display: none" src="${pageContext.request.contextPath}/image/1.jpg" alt="萌妹子">
</body>
<script>
$(".btn1").on("click",function(){  
    var json1 = $(".form1").serialize();  
    $.ajax({  
url:"/activity/saveActivityIndividual?format=json",  
type: "POST",  
data:json1,  
success: function(data, textStatus){  
     alert(data.scode); // 1 success  -1 error  
},  
error: function(data){   
            alert("Connection error");  
      }  
});  
}); 
</script>
</html>