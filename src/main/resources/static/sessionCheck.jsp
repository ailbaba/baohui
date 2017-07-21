
<%
if(request.getSession().getAttribute("username")==null){
	//response.sendRedirect("login/login.html");
	out.print("<script>location.href='login/login.html'</script>");
}
%>