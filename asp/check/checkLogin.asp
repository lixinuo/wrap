<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../conn/conn.asp"-->
<!--#include file="MD5.asp"-->
<%
Response.Charset="utf-8"
userName = trim(request.Form("userName"))
userPwd = md5(md5(trim(request.Form("userPwd"))))
checkCode = trim(request.Form("checkCode"))

if session("validateCode") <> checkCode then msg "验证码错误！","../index.asp"
set rs = server.CreateObject("adodb.recordset")
sql = "select id,username,password from [user] where username = '"&userName&"'"
rs.open sql,conn,1,1
if not rs.eof then
	if rs("password") <> userPwd then
		msg "密码错误!","../index.asp"
	else
		Session("lastLoginTime") = now()
		Session("username") = userName
		Session("ID") = rs("id")
		Session("login") = true
		Session.Timeout = 30  '30分钟
		response.Redirect("../system/main.asp")
	end if
else
	msg "无此用户!","../index.asp"
end if
rs.close
set rs = nothing

%>




