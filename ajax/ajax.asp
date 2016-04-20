<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../asp/conn/conn.asp"-->
<%
Response.CharSet = "utf-8"
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
			dim versions,detail
			do while not rs.eof 
				if i=0 then
					redim versions(i+1),detail(i+1)
					domain = rs("domain")
					servers = rs("servers")
					upTime = datemate(rs("upTime"))
					versions(i) = rs("versions")
					detail(i) = rs("detail")
				else
					redim preserve versions(i+1),detail(i+1)
					versions(i) = rs("versions")
					detail(i) = rs("detail")
				end if
				
				i = i + 1
			rs.movenext
			loop
		end if
	rs.close
	set rs = nothing
	'返回前台json数据
	json = json&"""netName"":""" & netName & """,""fullName"":""" & fullName & """,""root"":""" & root & """,""living"":""" & living & """,""job"":""" & job & """,""selfDetail"":""" & selfDetail & """,""domain"":""" & domain & """,""servers"":""" & servers & """,""upTime"":""" & upTime & ""","
	json = json&"""versions"":["
	for j=0 to ubound(versions)-1
		json = json&"{""versionss"":""" & versions(j) & """,""details"":""" & detail(j) & """},"
	next
	json = left(json,len(json)-1)  '去掉最后一个，
	
	json = json&"]}"
	response.Write json
end if

if pass = "note" then 
	currPage = 1'request("currPage")  '当前页面 1
	listsize = 1'request("listsize")	'每页显示的记录数  1
	noteCount = conn.execute("select count(*) from [note]")(0)
	json = "{"
	set rs = server.CreateObject("adodb.recordset")
	sql = "select top "& listsize &" * from (select top "& currPage*listsize &" * from [note] order by id asc)top_1 order by id desc"
	rs.open sql,conn,1,1
	if not rs.eof then
		detail = rs("detail")
	end if
	rs.close
	set rs=nothing	
	
	json = json&"""noteCount"":""" & noteCount & """"
	
	
	json = json&"}"
	response.Write json
end if

%>
