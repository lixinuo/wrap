<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<%
Response.CharSet = "utf-8"
Session.CodePage = "65001"
title = request("title")
id = isZero(request("id"),0)
action = request("action")
actionto = request("actionto")
domain = trim(request.Form("domain"))
servers = trim(request.Form("servers"))
upTime = trim(request.Form("upTime"))
versions = trim(request.Form("versions"))
detail = trim(request.Form("detail"))

if actionto = "edit" then
	set rs = server.CreateObject("adodb.recordset")
	sql = "select top 1 * from [configure] order by id desc"
	rs.open sql,conn,1,3
	if rs.eof then
		rs.addnew
		rs("domain") = domain
		rs("servers") = servers
		rs("upTime") = upTime
		rs("versions") = versions
		rs("detail") = getStr(detail)
	else
		if instr(rs("versions"),versions)=0 then
			rs.addnew
			rs("domain") = domain
			rs("servers") = servers
			rs("upTime") = upTime
			rs("versions") = versions
			rs("detail") = getStr(detail)
		else
			rs("domain") = domain
			rs("servers") = servers
			rs("upTime") = upTime
			rs("detail") = getStr(detail)
		end if
	end if
	rs.update
	rs.close
	set rs = nothing
	msg "提交成功！","configure.asp?title="&title&""
end if

dim i,oldVersions,oldDetail
i=0
set rs = server.CreateObject("adodb.recordset")
sql = "select top 5 * from [configure] order by id desc"
rs.open sql,conn,1,1
if not rs.eof then
	do while not rs.eof
		if i=0 then
			domain = rs("domain")
			servers =rs("servers")
			upTime = rs("upTime")
			versions = rs("versions")
			detail = rs("detail")
		else
			oldVersions = oldVersions&rs("versions")&"##"
			oldDetail = oldDetail&rs("detail")&"##"
		end if
		i = i + 1
	rs.movenext
	loop
end if
rs.close
set rs =nothing
'oldVersions = left(oldVersions,len(oldVersions)-2)
'oldDetail = left(oldDetail,len(oldDetail)-2)    '去掉末尾的##
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" type="text/css" href="../../bootstrap-3.3.5/css/bootstrap.min.css" />
<!-- 时间控件css文件-->
<link rel="stylesheet" type="text/css" href="../../bootstrap-3.3.5/css/bootstrap-datetimepicker.min.css" />
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="../../bootstrap-3.3.5/js/jquery-1.11.3.min.js" ></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="../../bootstrap-3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../bootstrap-3.3.5/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="../../bootstrap-3.3.5/js/locales/bootstrap-datetimepicker.fr.js"></script>
<script type="text/javascript" src="../../bootstrap-3.3.5/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
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
                <%if action <> "edit" then%>
                    <table class="table table-bordered">
                        <tr>
                            <td width="10%">域名：</td>
                            <td><%=domain%></td>
                        </tr>
                        <tr>
                            <td>服务器：</td>
                            <td><%=servers%></td>
                        </tr>
                        <tr>
                            <td>上线时间：</td>
                            <td><%=datemate(upTime)%></td>
                        </tr>
                        <tr>
                            <td>当前版本：</td>
                            <td><a style="text-decoration:none" href="javascript:void(0)" onClick="toggleVersion()"><%=versions%>（点击查看更多版本信息）</a></td>
                        </tr>
                    </table>
                    <div id="moreVersion" style="display:none;">
                        <hr>
                        <%if instr(oldVersions,"##")>0 then
                            oldVersions = split(oldVersions,"##")
                            oldDetail = split(oldDetail,"##")
                            for j=0 to ubound(oldVersions)-1
                        %>
                            <p>
                                <strong>版本号：<%=oldVersions(j)%></strong>
                            </p>
                            <p>
                                <%=oldDetail(j)%>
                            </p>
                        <%	next
                          
                          end if
                        %>
                    </div>
                <%else%>
                    <table class="table table-bordered">
                        <tr>
                            <td width="10%" style="height:34px; line-height:34px;">域名：</td>
                            <td><input type="text" class="form-control" required id="domain" name="domain" value="<%=domain%>"></td>
                        </tr>
                        <tr>
                            <td style="height:34px; line-height:34px;">服务器：</td>
                            <td><input type="text" class="form-control" required id="servers" name="servers" value="<%=servers%>"></td>
                        </tr>
                        <tr>
                            <td style="height:34px; line-height:34px;">上线时间：</td>
                            <td><input type="text"  class="form-control" required readonly id="datetimepicker" name="upTime" value="<%=datemate(upTime)%>"></td>
                        </tr>
                        <tr>
                            <td style="height:34px; line-height:34px;">版本号：</td>
                            <td><input type="text" class="form-control" required id="versions" name="versions" value="<%=versions%>"></td>
                        </tr>
                        <tr>
                            <td style="height:34px; line-height:34px;">详细信息：</td>
                            <td><textarea class="form-control" rows="5" id="detail" name="detail"><%=getFxStr(detail)%></textarea></td>
                        </tr>
                    </table>
                <%end if%>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-1 col-sm-1">
                    <%if action <> "edit" then%>
                        <input type="button" onClick="location='?action=edit&title=<%=title%>'" class="btn btn-default" value="编辑">
                    <%else%>
                        <input type="submit" class="btn btn-default" value="提交">
                    <%end if%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<script type="text/javascript">
$("#datetimepicker").datetimepicker({
	format : "yyyy-mm-dd",
	weekStart : 0,		//一周开始的日期
	autoclose : 1,		//选择时间后是否关闭
	todayBtn : 1,		//是否有当天日期按钮
	language : 'zh-CN',
	minView : 'month'
});

function toggleVersion(){
	$("#moreVersion").toggle("slow");
	
}

</script>
</body>
</html>
