<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../asp/conn/conn.asp"-->
<%
pass = request("pass")

if pass = "about" then
	json = "{"
	'获取个人信息
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [aboutme]"  
	rs.open sql,conn,1,1
		if not rs.eof then
			netName = rs("netName")
			fullName = rs("fullName")
			root = rs("root")
			living = rs("living")
			job = rs("job")
			selfDetail = rs("detail")
		end if
	rs.close
	set rs = nothing
	
	'获取网站配置
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [configure]"
	rs.open sql,conn,1,1
		if not rs.eof then
			domain = rs("domain")
			servers = rs("servers")
			upTime = rs("upTime")
			versions = rs("versions")
			detail = rs("detail")
		end if
	rs.close
	set rs = nothing
	
	
	json = json&"""netName"":""" & netName & """,""fullName"":""" & fullName & """,""root"":""" & root & """,""living"":""" & living & """,""job"":""" & job & """,""selfDetail"":""" & selfDetail & """"
	
	json = json&"}"
	response.Write json
end if

%>
