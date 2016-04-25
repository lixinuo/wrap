<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<%
title = request("title")
id = isZero(request("id"),0)
action = request("action")

set rs = server.CreateObject("adodb.recordset")
sql = "select * from [column] where id="&id&""
rs.open sql,conn,1,1
	if not rs.eof then
		parentID = rs("id")
		parentName = rs("linkname")
	end if
rs.close
set rs = nothing

if action = "del" then
	conn.execute("delete from [column] where id = "&id&"")
	msg "删除成功","columnList.asp?title="&title&""
end if
if action = "sort" then
	sortID = request("sortID")
	conn.execute("update [column] set sort = "&sortID&" where id = "&id&"")
	response.Redirect(request.ServerVariables("HTTP_REFERER"))
end if
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" type="text/css" href="../../bootstrap-3.3.5/css/bootstrap.min.css" />
<link rel="stylesheet" href="../../bootstrap-3.3.5/css/bootstrap-theme.min.css">
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="../../bootstrap-3.3.5/js/jquery-1.11.3.min.js" ></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="../../bootstrap-3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../js/public.js"></script>
<title><%=title%></title>
</head>

<body>
<div class="lead">
    <ol class="breadcrumb">
        <li class="active"><p class="label label-info"><%=title%>&nbsp;<span class="badge" id="countNum"><%=conn.execute("select count(*) from [column] where parentID = "&id&"")(0)%></span></p></li>
        <input type="button" value="返回" class="btn btn-primary btn-sm pull-right" onClick="javascript:history.go(-1);">
        <input type="button" value="新增" class="btn btn-success btn-sm pull-right" style="margin:0 10px" onClick="location='column.asp?title=<%=title%>&action=add&parentID=<%=id%>'">
    </ol>
</div>
<table class="table table-striped table-bordered table-hover">
    <thead>
        <tr>
            <td>栏目名称</td>
            <td>创建日期</td>
            <td width="10%">排序</td>
            <td width="10%">编辑</td>
            <td width="10%">删除</td>
        </tr>
    </thead>
    <tbody>
        <%
        set rs = server.CreateObject("adodb.recordset")
        sql = "select * from [column] where parentID="&id&" order by sort asc,id asc"
        rs.open sql,conn,1,1
        if not rs.eof then
            do while not rs.eof
        %>
        <tr>
            <td><a href="columnList.asp?title=<%=rs("linkname")%>&id=<%=rs("id")%>"><%=rs("linkname")%></a></td>
            <td><%=rs("setTime")%></td>
            <td><input type="text" id="sort" onBlur="location='?id=<%=rs("id")%>&action=sort&sortID=' + this.value" class="input-sm" value="<%=rs("sort")%>" style="width:60px;"></td>
            <td><a href="column.asp?title=<%=title%>&id=<%=rs("id")%>&action=edit"><span class="glyphicon glyphicon-pencil"></span><a></td>
            <td><a onClick="return del()" href="?title=<%=title%>&id=<%=rs("id")%>&action=del"><span class="glyphicon glyphicon-trash"></span><a></td> 
        </tr>
        <%  rs.movenext
            loop
        else
            response.Write "<td colspan='6'>&nbsp;暂无栏目！</td>"
        end if
        rs.close
        set rs = nothing
        %>
        <tr>
            <td colspan="6">
                 <div id="pageNav" class="text-center"></div>
            </td>
        </tr>
    </tbody>
</table>
</body>
<script type="text/javascript">
var listsize = 10;    //每页显示的记录数
$(function(){
	testPage(1);
});
function testPage(curPage){
	supage('pageNav','testPage','',curPage,$('#countNum').html(),listsize);
}
</script>
</html>
