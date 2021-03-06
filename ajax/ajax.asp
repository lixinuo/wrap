<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../asp/conn/conn.asp"-->
<%
Response.CharSet = "utf-8"
Session.CodePage = "65001"
pass = request("pass")

'ajax获取首页信息
if pass = "index" then 
	curPage = request("curPage")  '当前页面 
	listSize = request("listSize")	'每页显示的记录数
	blogCount = conn.execute("select count(*) from [blog] where show=1")(0)  '获取总的笔记数量

	json = "{"
	json = json&"""blogCount"":""" & blogCount & """"
	call getFriendLink()
	if blogCount<>0 then
		call getBlogList()
	end if
	json = json&"}"
	response.Write json
end if

if pass = "addLink" then
	webName = request("webName")
	webURL = request("webURL")
	webEmail = request("webEmail")
	webDetail = request("webDetail")
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [link] where id=0"
	rs.open sql,conn,1,3
	if rs.eof then
		rs.addnew
		rs("linkname") = webName
		rs("url") = webURL
		rs("linkEmail") = webEmail
		rs("detail") = webDetail
		rs("setTime") = now()
		rs("show") = 0
		rs.update
	end if
	rs.close
	set rs=nothing	

end if

'关于我页面ajax返回
if pass = "about" then
	json = "{"
	'获取个人信息
	call getSelfMes()
	'获取网站配置
	call getConfigure()
	json = json&"}"
	'返回前台json数据
	response.Write json
end if

'ajax获取个人笔记列表信息
if pass = "note" then 
	curPage = request("curPage")  '当前页面 
	listSize = request("listSize")	'每页显示的记录数
	noteCount = conn.execute("select count(*) from [note] where show=1")(0)  '获取总的笔记数量
	preNum = curPage*listSize   '已经显示过的数量
	if noteCount<preNum then
		listSize = noteCount - (curPage-1)*listSize
	end if
	json = "{"
	json = json&"""noteCount"":""" & noteCount & """"
	if noteCount<>0 then
		call getNoteList(preNum,listSize)
	end if
	json = json&"}"
	response.Write json
end if

'ajax获取blog列表
if pass = "blog" then
	curPage = request("curPage")  '当前页面 
	listSize = request("listSize")	'每页显示的记录数
	blogtype = request("blogtype")  '
	rightCon = request("rightCon")
	if blogtype = "" then
		blogCount = conn.execute("select count(*) from [blog] where show=1 ")(0)  '获取总的blog数量
	else
		blogCount = conn.execute("select count(*) from [blog] where show=1 and categories='"&blogtype&"' ")(0)  '获取总的blog数量
	end if
	preNum = curPage*listSize   '显示的数量
	if blogCount<preNum then
		listSize = blogCount - (curPage-1)*listSize
	end if
	
	json = "{"
	json = json&"""blogCount"":""" & blogCount & """"
	'获取blogtype列表
	if rightCon=1 then
		call getBlogType()
		call getFriendLink()
	end if
	if blogCount<>0 and curPage<>"" then
		call getBlog(preNum,listSize,blogtype)
	end if
	
	json = json&"}"
	response.Write json
end if

'blog具体内容ajax返回
if pass = "content" then
	id = request("id")  '当前页面 
	conn.execute("update blog set views=(views+1) where id = "&id&"")
	json = "{"
	'blog具体内容
	call getBlogMes(id)
	json = json&"}"
	'返回前台json数据
	response.Write json
end if

'留言板页面ajax返回
if pass = "guest" then
	json = "{"
	'获取个人信息
	call getSelfMes()
	json = left(json,len(json)-1)  '去掉最后一个，
	json = json&"}"
	'返回前台json数据
	response.Write json
end if

'获取blog文章
function getBlogMes(id)
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [blog] where id="&id&""
	rs.open sql,conn,1,1
	if not rs.eof then
		json = json&"""blogTitle"":""" & rs("blogTitle") & """,""author"":""" & rs("author") & """,""categories"":""" & rs("categories") & """,""detail"":""" & replace(rs("detail"),chr(34),"'") & """,""upTime"":""" & datemate(rs("upTime")) & """,""id"":""" & rs("id") & """,""views"":""" & rs("views") & """"
	end if
	rs.close
	set rs=nothing	
end function

'获取blog文章列表
function getBlogList()
	set rs = server.CreateObject("adodb.recordset")
	sql = "select top 10 * from [blog] where show=1 order by upTime desc,id desc"
	rs.open sql,conn,1,1
	json = json&",""detail"":["
	if not rs.eof then
		do while not rs.eof 
			json = json&"{""blogTitle"":""" & rs("blogTitle") & """,""author"":""" & rs("author") & """,""categories"":""" & rs("categories") & """,""detail"":""" & replace(rs("detail"),chr(34),"'") & """,""upTime"":""" & datemate(rs("upTime")) & """,""id"":""" & rs("id") & """,""views"":""" & rs("views") & """},"
		rs.movenext
		loop
		json = left(json,len(json)-1)  '去掉最后一个，
	end if
	json = json&"]"
	rs.close
	set rs=nothing	
end function

'获取blog文章
function getBlog(preNum,listSize,blogtype)
	set rs = server.CreateObject("adodb.recordset")
	if blogtype = "" then
		sql = "select top "&listSize&" * from (select top "&preNum&" * from [blog] where show=1 order by id desc)top_1 order by id asc"
	else
		sql = "select top "&listSize&" * from (select top "&preNum&" * from [blog] where show=1 and categories='"&blogtype&"' order by id desc)top_1 order by id asc"
	end if
	rs.open sql,conn,1,1
	json = json&",""detail"":["
	if not rs.eof then
		do while not rs.eof 
			json = json&"{""blogTitle"":""" & rs("blogTitle") & """,""author"":""" & rs("author") & """,""categories"":""" & rs("categories") & """,""detail"":""" & replace(rs("detail"),chr(34),"'") & """,""upTime"":""" & datemate(rs("upTime")) & """,""id"":""" & rs("id") & """,""views"":""" & rs("views") & """},"
		rs.movenext
		loop
		json = left(json,len(json)-1)  '去掉最后一个，
	end if
	json = json&"]"
	rs.close
	set rs=nothing	
end function

'获取友情链接
function getFriendLink()
	set rs = server.CreateObject("adodb.recordset")
	sql = "select linkname,url from link where show=1 order by sort asc,id asc"
	rs.open sql,conn,1,1
	json = json&",""friendlinks"":["
	if not rs.eof then
		do while not rs.eof 
			json = json&"{""linkname"":""" &rs("linkname")& """,""linkurl"":""" & rs("url") & """},"
		rs.movenext
		loop
		json = left(json,len(json)-1)  '去掉最后一个，
	end if
	json = json&"]"
	rs.close
	set rs = nothing
end function

'获取blog类别
function getBlogType()
	set rs = server.CreateObject("adodb.recordset")
	sql = "select typename from blogtype where show=1"
	rs.open sql,conn,1,1
	json = json&",""blogtypes"":["
	if not rs.eof then
		do while not rs.eof 
			json = json&"{""name"":""" &rs("typename")& """},"
		rs.movenext
		loop
		json = left(json,len(json)-1)  '去掉最后一个，
	end if
	json = json&"]"
	rs.close
	set rs = nothing
end function

'获取个人笔记列表信息
function getNoteList(preNum,listSize)
	set rs = server.CreateObject("adodb.recordset")
	sql = "select top "&listSize&" * from (select top "&preNum&" * from [note] where show=1 order by id desc)top_1 order by id asc"
	rs.open sql,conn,1,1
	json = json&",""detail"":["
	if not rs.eof then
		do while not rs.eof 
			json = json&"{""details"":""" & replace(rs("detail"),chr(34),"'") & """,""setTimes"":""" & datemate(rs("setTime")) & """,""id"":""" & rs("id") & """},"
		rs.movenext
		loop
		json = left(json,len(json)-1)  '去掉最后一个，
	end if
	json = json&"]"
	rs.close
	set rs=nothing	
end function

'获取网站配置
function getConfigure()
	set rs = server.CreateObject("adodb.recordset")
	sql = "select top 5 * from [configure] order by id desc"
	rs.open sql,conn,1,1
	json = json&"""versions"":["
	if not rs.eof then
		do while not rs.eof 
			json = json&"{""versionss"":""" & rs("versions") & """,""details"":""" & replace(rs("detail"),chr(34),"'") & """,""domain"":""" & rs("domain") & """,""servers"":""" & rs("servers") & """,""upTime"":""" & datemate(rs("upTime")) & """},"
		rs.movenext
		loop
		json = left(json,len(json)-1)  '去掉最后一个，
	end if
	json = json&"]"
	rs.close
	set rs = nothing
end function

'获取个人信息
function getSelfMes()
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [aboutme]"  
	rs.open sql,conn,1,1
		if not rs.eof then
			netName = rs("netName")
			fullName = rs("fullName")
			root = rs("root")
			living = rs("living")
			job = rs("job")
			selfDetail = replace(rs("detail"),chr(34),"'")
		end if
	rs.close
	set rs = nothing
	json = json&"""netName"":""" & netName & """,""fullName"":""" & fullName & """,""root"":""" & root & """,""living"":""" & living & """,""job"":""" & job & """,""selfDetail"":""" & selfDetail & ""","
end function



%>
