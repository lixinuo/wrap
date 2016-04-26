<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<%
title = request("title")
id = isZero(request("id"),0)
action = request("action")

if action = "del" then 
	conn.execute("delete from [user] where id = "&id&"")
end if

if action = "show" then
	showList = request("showList")
	if showList = 1 then
		conn.execute("update [user] set show=0 where id = "&id&"")
	else
		conn.execute("update [user] set show=1 where id = "&id&"")
	end if
	response.Redirect("userList.asp?title="&title&"")
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
                    <input type="button" value="新增" class="btn btn-success btn-sm pull-right" style="margin:0 10px" onClick="location='user.asp?action=add&title=<%=title%>'">
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <td>用户名</td>
                                <td width="20%">创建日期</td>
                                <td width="10%">状态</td>
                                <td width="10%">编辑</td>
                                <td width="10%">删除</td>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        set rs = server.CreateObject("adodb.recordset")
                        sql = "select * from [user] order by sort asc,id desc"
                        rs.open sql,conn,1,1
                        if not rs.eof then
                            do while not rs.eof
                            %>
                                <tr>
                                    <td title="<%=rs("username")%>"><%=rs("username")%></td>
                                    <td><%=datemate(rs("setTime"))%></td>
                                    <td><a href="?action=show&title=<%=title%>&id=<%=rs("id")%>&showList=<%=rs("show")%>" id="showList"><%if rs("show")=1 then response.Write "显示" else response.Write "隐藏"%></a></td>
                                    <td><a href="user.asp?id=<%=rs("id")%>&action=edit&title=<%=title%>"><span class="glyphicon glyphicon-pencil"></span></a></td>
                                    <td><a onClick="return del()" href="?id=<%=rs("id")%>&action=del&title=<%=title%>"><span class="glyphicon glyphicon-trash"></span></a></td>
                                </tr>
                            <%
                            rs.movenext
                            loop
                        else
                            response.Write "<td colspan='5'>&nbsp;暂无笔记</td>"
                        end if
                        rs.close
                        set rs = nothing
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>
