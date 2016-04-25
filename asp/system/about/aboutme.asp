<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<%
title = request("title")
action = request("action")

if action = "edit" then
	netName = request.Form("netName")
	fullName = request.Form("fullName")
	root = request.Form("root")
	living = request.Form("living")
	job = request.Form("job")
	detail = request.Form("detail")
	
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [aboutme]"
	rs.open sql,conn,1,3
	if rs.eof then
		rs.addnew
		rs("setTime") = now()
		rs("netName") = netName
		rs("fullName") = fullName
		rs("root") = root
		rs("living") = living
		rs("job") = job
		rs("detail") = getStr(detail)
	else
		rs("netName") = netName
		rs("fullName") = fullName
		rs("root") = root
		rs("living") = living
		rs("job") = job
		rs("detail") = getStr(detail)
		rs("detail") = getStr(detail)
	end if
	rs.update
	rs.close
	set rs = nothing
	msg "提交成功！","aboutme.asp?title="&title&""
end if

set rs = server.CreateObject("adodb.recordset")
sql = "select * from [aboutme]"
rs.open sql,conn,1,1
if not rs.eof then
	netName = rs("netName")
	fullName = rs("fullName")
	root = rs("root")
	living = rs("living")
	job = rs("job")
	detail = (rs("detail"))
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
	<input type="hidden" id="action" name="action" value="edit">
    <div class="form-group">
        <div class="col-sm-12">
            <div class="panel panel-default">
                <div class="panel-heading clearfix">
                    <span><%=title%></span>
                    <input type="button" value="返回" class="btn btn-primary btn-sm pull-right" onClick="javascript:history.go(-1);">
                </div>
                <div class="panel-body">
                    <div class="input-group">
                    	<div class="input-group-addon">网名：</div>
                    	<input type="text" class="form-control" required id="netName" name="netName" value="<%=netName%>" >
                    </div><br>
                    <div class="input-group">
                    	<div class="input-group-addon">姓名：</div>
                    	<input type="text" class="form-control" required id="fullName" name="fullName" value="<%=fullName%>" >
                    </div><br>
                    <div class="input-group">
                    	<div class="input-group-addon">籍贯：</div>
                    	<input type="text" class="form-control" required id="root" name="root" value="<%=root%>" >
                    </div><br>
                    <div class="input-group">
                    	<div class="input-group-addon">现居：</div>
                    	<input type="text" class="form-control" required id="living" name="living" value="<%=living%>" >
                    </div><br>
                    <div class="input-group">
                    	<div class="input-group-addon">职业：</div>
                        <input type="text" class="form-control" required id="job" name="job" value="<%=job%>" >
                    </div><br>
                    <div class="input-group">
                    	<div class="input-group-addon">说明：</div>
                    	<textarea class="form-control" rows="10" id="detail" name="detail"><%=getFxStr(detail)%></textarea>
                    </div><br>
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
