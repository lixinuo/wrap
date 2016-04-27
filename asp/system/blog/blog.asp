<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../../conn/conn.asp"-->
<%
title = request("title")
id = isZero(request("id"),0)
action = request("action")
actionto = request("actionto")

if actionto = "edit" or actionto = "add" then
	blogTitle = request.Form("blogTitle")
	author = request.Form("author")
	upTime = request.Form("upTime")
	categories = request.Form("categories")
	'inputFile = request.Form("inputFile")
	detail = request.Form("detail")	
	
	set rs = server.CreateObject("adodb.recordset")
	sql = "select * from [blog] where id = "&id&""
	rs.open sql,conn,1,3
	if rs.eof then
		rs.addnew
		rs("blogTitle") = blogTitle
		rs("author") = author
		rs("upTime") = upTime
		rs("categories") = categories
		'rs("inputFile") = inputFile
		rs("detail") = detail
	else
		rs("blogTitle") = blogTitle
		rs("author") = author
		rs("upTime") = upTime
		rs("categories") = categories
		'rs("inputFile") = inputFile
		rs("detail") = detail
	end if
	rs.update
	rs.close
	set rs = nothing
	msg "提交成功！","blogList.asp?title="&title&""
end if

set rs = server.CreateObject("adodb.recordset")
sql = "select * from [blog] where id = "&id&""
rs.open sql,conn,1,1
if not rs.eof then
	blogTitle = rs("blogTitle")
	author = rs("author")
	upTime = rs("upTime")
	categories = rs("categories")
	inputFile = rs("inputFile")
	detail = rs("detail")
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
<script type="text/javascript" src="../../bootstrap-3.3.5/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="../../bootstrap-3.3.5/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="../../js/choseTime.js"></script>
<script type="text/javascript" src="../../js/public.js"></script>
<script type="text/javascript" src="../../richTextBox/ueditor.config.js"></script>
<script type="text/javascript" src="../../richTextBox/ueditor.all.min.js"></script>
<script type="text/javascript" src="../../richTextBox/lang/zh-cn/zh-cn.js"></script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->

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
                	<div class="input-group">
                        <span class="input-group-addon" >标题：</span>
                        <input type="text" class="form-control" required id="blogTitle" name="blogTitle" value="<%=blogTitle%>">
                    </div><br>
                    <div class="input-group">
                        <span class="input-group-addon" >作者：</span>
                        <input type="text" class="form-control" required id="author" name="author" value="<%=author%>">
                    </div><br>
                    <div class="input-group">
                        <span class="input-group-addon" >时间：</span>
                        <input type="text" class="form-control" required readonly id="upTime" name="upTime" value="<%if upTime="" then response.Write now() else response.Write upTime%>">
                    </div><br>
                    <div class="input-group">
                    	<span class="input-group-addon">分类：</span>
                    	<select class="form-control" id="categories" name="categories">
                        <%  set rs = server.CreateObject("adodb.recordset")
							sql = "select typename from blogtype where show =1 order by sort asc, id asc"
							rs.open sql,conn,1,1
							do while not rs.eof 
						%>
                        	<option value="<%=rs("typename")%>" <%if rs("typename")=categories then response.Write "selected"%>><%=rs("typename")%></option>
                        <%	rs.movenext
							loop
							rs.close
							set rs = nothing
						%>
                        </select>
                    </div><br>
                    <!--<div class="input-group">
                        <span class="input-group-addon" >文件：</span>
                        <input type="file" class="form-control" multiple id="inputFile" name="inputFile">
                    </div><br>-->
                    <script id="editor" name="detail" type="text/plain" style="width:100%;height:400px;"><%=detail%></script>
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
<script type="text/javascript">
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	var ue = UE.getEditor('editor');
</script>
</html>
