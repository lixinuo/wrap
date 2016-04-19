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
	sql = "select top 5 * from [configure] order by id desc"
	rs.open sql,conn,1,1
		if not rs.eof then
			i = 0
			do while not rs.eof 
				if i=0 then
					domain = rs("domain")
					servers = rs("servers")
					upTime = datemate(rs("upTime"))
					versions = rs("versions")
					detail = rs("detail")
				else
					
				end if
				
				i = i + 1
			rs.movenext
			loop
		end if
	rs.close
	set rs = nothing
	
	
	json = json&"""netName"":""" & netName & """,""fullName"":""" & fullName & """,""root"":""" & root & """,""living"":""" & living & """,""job"":""" & job & """,""selfDetail"":""" & selfDetail & """,""domain"":""" & domain & """,""servers"":""" & servers & """,""upTime"":""" & upTime & """,""versions"":""" & versions & """,""detail"":""" & detail & """"
	
	json = json&"}"
	response.Write json
end if

%>
