<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<%
title = request("title")
detail = request.Form("detail")
id = isZero(request("id"),0)
action = request("action")
actionto = request("actionto")

if actionto = "edit" or actionto = "add" then
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [note] where id = "&id&""
	rs.open sql,conn,1,3
	if rs.eof then
		rs.addnew
		rs("setTime") = datemate(now())
		rs("detail") = getStr(detail)
	else
		rs("detail") = getStr(detail)
	end if
	rs.update
	rs.close
	set rs = nothing
	msg "提交成功！","noteList.asp?title="&title&""
end if

set rs = server.CreateObject("adodb.recordset")
sql = "select * from [note] where id = "&id&""
rs.open sql,conn,1,1
if not rs.eof then
	detail = (rs("detail"))
else
	detail = ""
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
<script type="text/javascript" src="../../js/public.js"></script>
<title><%=title%></title>
</head>

<body>
<form class="form-horizontal" role="form" method="post" action="">
    <input type="hidden" id="actionto" name="actionto" value="<%=action%>">
    <div class="form-group">
        <div class="col-sm-12">
            <div class="panel panel-default">
                <div class="panel-heading clearfix">
                    <span><%=title%></span>
                    <input type="button" value="返回" class="btn btn-primary btn-sm pull-right" onClick="javascript:history.go(-1);">
                </div>
                <div class="panel-body">
                    <textarea class="form-control" rows="6" required id="detail" name="detail"><%=getFxStr(detail)%></textarea>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-1 col-sm-1">
                    <input type="submit" class="btn btn-default" value="提交">
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>
