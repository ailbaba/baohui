<%@ include file="/elsHeader.jsp"%>

<%
String elsAccount = (String) session.getAttribute("elsAccount");
String elsSubAccount = (String) session.getAttribute("elsSubAccount");
com.els.dao.RedisClusterDao redisDao=new com.els.dao.RedisClusterDao();
if(elsAccount!=null){
 	redisDao.lrem("key_onlineElsAccountList#", 1, elsAccount+"_"+elsSubAccount);
}

com.baomidou.kisso.SSOHelper.clearLogin(request, response);
request.getSession().invalidate();
request.getSession().removeAttribute("elsAccount");
request.getSession().removeAttribute("elsSubAccount");
request.getSession().removeAttribute("username");
request.getSession().removeAttribute("role");
request.getSession().removeAttribute("companyShortName");
request.getSession().removeAttribute("language");
request.getSession().removeAttribute("logo");
//统一登录 @author jiangzhidong @date 20160711 begin
if(basePath.indexOf("www")>0){
	if(basePath.lastIndexOf("ELSServer")>0){
		String basePathBefore = basePath.substring(0, basePath.lastIndexOf("ELSServer"));
		basePath = basePathBefore +"ELSLogin/";
	}
}
//统一登录 @author jiangzhidong @date 20160711 end
response.sendRedirect(basePath+"login/login.html?ltype=logout");
%>