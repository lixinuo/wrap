<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<%
Response.CharSet = "utf-8"
Session.CodePage = "65001"
title = request("title")
inputName = trim(request.Form("inputName"))
linkURL = trim(request.Form("linkURL"))
parentID = isZero(request("parentID"),0)
id = isZero(request("id"),0)
action = request("action")
actionto = request("actionto")

if actionto = "add" or actionto = "edit" then
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [column] where id = "&id&""
	rs.open sql,conn,1,3
		if actionto = "add" then
			rs.addnew
		end if
		rs("name") = inputName
		rs("linkURL") = linkURL
		if actionto = "add" then
			rs("parentID") = parentID
			rs("setTime") = now()
		end if
	rs.update
	rs.close
	set rs = nothing
	msg "添加、修改成功！","columnList.asp?title=栏目管理"
end if
if  action = "edit" then
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [column] where id = "&id&""
	rs.open sql,conn,1,1
		inputName = rs("name")
		linkURL = rs("linkURL")
	rs.close
	set rs =nothing
end if
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
<div class="lead">
    <ol class="breadcrumb">
        <li class="active"><%=title%></li>
        <input type="button" value="返回" class="btn btn-primary pull-right" onClick="javascript:history.go(-1);">
    </ol>
</div>
<form class="form-horizontal" role="form" method="post" action="">
    <input type="hidden" id="actionto" name="actionto" value="<%=action%>">
    <div class="form-group">
        <label class="control-label col-sm-2">名称</label>
        <div class="col-sm-4">
            <input type="text" required class="form-control" id="inputName" name="inputName" value="<%=inputName%>">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-2">链接地址</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="linkURL" name="linkURL" value="<%=linkURL%>">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-1">
            <input type="submit" class="btn btn-default" value="提交">
        </div>
    </div>
</form>
</body>
</html>
