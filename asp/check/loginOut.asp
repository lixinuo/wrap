<%
Response.CharSet = "utf-8"
Session.CodePage = "65001"
if session("login") <> true then
	msg "登陆状态过期，请重新登录！","../index.asp"
end if
%>
