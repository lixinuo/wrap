<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<%
Response.CharSet = "utf-8"
Session.CodePage = "65001"
title = request("title")
id = isZero(request("id"),0)
action = request("action")
actionto = request("actionto")

if actionto = "edit" or actionto = "add" then
	linkName = trim(request.Form("linkName"))
	linkUrl = trim(request.Form("linkUrl"))
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [link] where id = "&id&""
	rs.open sql,conn,1,3
	if rs.eof then
		rs.addnew
		rs("name") = linkName
		rs("url") = linkUrl
		rs("setTime") = datemate(now())
	else
		rs("name") = linkName
		rs("url") = linkUrl
	end if
	rs.update
	rs.close
	set rs = nothing
	msg "提交成功！","linkList.asp?title="&title&""
end if

set rs = server.CreateObject("adodb.recordset")
sql = "select * from [link] where id = "&id&""
rs.open sql,conn,1,1
if not rs.eof then
	linkName = rs("name")
	linkUrl = rs("url")
end if
rs.close
set rs =nothing
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" type="text/css" href="../../bootstrap-3.3.5/css/bootstrap.min.css" />
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="../../bootstrap-3.3.5/js/jquery-1.11.3.min.js" ></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="../../bootstrap-3.3.5/js/bootstrap.min.js"></script>
<title><%=title%></title>
</head>

<body>
<form class="form-horizontal" role="form" method="post" action="">
    <input type="hidden" id="actionto" name="actionto" value="<%=action%>">
    <div class="col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <span><%=title%></span>
                <input type="button" value="返回" class="btn btn-primary btn-sm pull-right" onClick="javascript:history.go(-1);">
            </div>
            <div class="panel-body">
                <div class="input-group">
                    <span class="input-group-addon">链接名字：</span>
                    <input type="text" class="form-control" id="linkName" name="linkName" value="<%=linkName%>">
                </div><br>
                <div class="input-group">
                    <span class="input-group-addon">链接地址：</span>
                    <input type="text" class="form-control" id="linkUrl" name="linkUrl" value="<%=linkUrl%>">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-1 col-sm-1">
                <input type="submit" class="btn btn-default" value="提交">
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>
