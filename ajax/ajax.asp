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

'ajax获取个人笔记列表信息
if pass = "note" then 
	curPage = request("curPage")  '当前页面 
	listSize = request("listSize")	'每页显示的记录数
	noteCount = conn.execute("select count(*) from [note]")(0)  '获取总的笔记数量
	preNum = curPage*listSize   '已结显示过的数量
	if noteCount<preNum then
		listSize = noteCount - (curPage-1)*listSize
	end if
	
	json = "{"
	set rs = server.CreateObject("adodb.recordset")
	sql = "select top "&listSize&" * from (select top "&curPage*listSize&" * from [note] order by id desc)top_1 order by id asc"
	rs.open sql,conn,1,1
	if not rs.eof then
		i=0
		dim details,setTimes
		do while not rs.eof 
			if i=0 then
				redim details(i+1),setTimes(i+1)
			else
				redim preserve details(i+1),setTimes(i+1)
			end if
			details(i) = rs("detail")
			setTimes(i) = rs("setTime")
			i = i+1
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing	
	
	json = json&"""noteCount"":""" & noteCount & ""","
	json = json&"""detail"":["
	for j=0 to ubound(details)-1
		json = json&"{""details"":""" & details(j) & """,""setTimes"":""" & setTimes(j) & """},"
	next
	json = left(json,len(json)-1)  '去掉最后一个，
	
	json = json&"]}"
	response.Write json
end if

%>
