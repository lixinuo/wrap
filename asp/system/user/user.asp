<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<!--#include file="../../check/MD5.asp"-->
<%
title = request("title")
userName = trim(request.Form("userName"))
userPwd = md5(md5(trim(request.Form("userPwd"))))
id = isZero(request("id"),0)
action = request("action")
actionto = request("actionto")

if actionto = "edit" or actionto = "add" then
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [user] where id = "&id&""
	rs.open sql,conn,1,3
	if rs.eof then
		rs.addnew
		rs("username") = userName
		rs("password") = userPwd
		rs("setTime") = datemate(now())
	else
		if trim(request.Form("userPwd")) <> "" then
			rs("username") = userName
			rs("password") = userPwd
		end if
	end if
	rs.update
	rs.close
	set rs = nothing
	msg "提交成功！","userList.asp?title="&title&""
end if

set rs = server.CreateObject("adodb.recordset")
sql = "select * from [user] where id = "&id&""
rs.open sql,conn,1,1
if not rs.eof then
	userName = rs("username")
	userPwd = rs("password")
else
	userName = ""
	userPwd = ""
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
                    <span class="input-group-addon" style="width:80px;">用户名：</span>
                    <input type="text" class="form-control" id="userName" name="userName" value="<%=userName%>">
                </div><br>
                <div class="input-group">
                    <span class="input-group-addon" style="width:80px;">密码：</span>
                    <input type="password" class="form-control" id="userPwd" name="userPwd" placeholder="留空不修改密码">
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
