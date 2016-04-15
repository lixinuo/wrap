<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#INCLUDE file="../conn/conn.asp"-->
<!--#INCLUDE file="../check/loginOut.asp"-->
<%
Response.CharSet = "utf-8"
Session.CodePage = "65001"
title = "后台管理"
id = isZero(request("id"),0)
action = request("action")

%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" type="text/css" href="../bootstrap-3.3.5/css/bootstrap.min.css" />
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="../bootstrap-3.3.5/js/jquery-1.11.3.min.js" ></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="../bootstrap-3.3.5/js/bootstrap.min.js"></script>
<title><%=title%></title>
</head>

<body style="background-color:#ccc;">
<div class="container" style="background-color:#fff;">
	<div class="navbar navbar-default alert-info" style="background-color:#fff;">
    	<div class="navbar-header">
        	<a class="navbar-brand" href=""><%=title%></a>
        </div>
		<div>
            <ul class="nav navbar-nav">
            	<%
				set rs = server.CreateObject("adodb.recordset")
				sql = "select * from [column] where parentID = 0 order by sort asc,id asc"
				rs.open sql,conn,1,1
				do while not rs.eof
				%>
                	<li><a href="<%=rs("linkURL")%>"><%=rs("name")%></a></li>
                <%
				rs.movenext
				loop
				rs.close
				set rs = nothing
				%>
            </ul>
            <div>
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input type="text" required class="form-control" placeholder="搜索">
                    </div>
                    <input type="submit" class="btn btn-default" value="提交">
                </form>
            </div>
        </div>
    </div>
    <div class="row">
    	<div class="col-md-2">
        	<div class="panel panel-info">
			<%
            set rs = server.CreateObject("adodb.recordset")
            sql = "select * from [column] where parentID = 0 order by sort asc,id asc"
            rs.open sql,conn,1,1
            do while not rs.eof
            %>
            	<div class="panel-heading">
                	<h4 class="panel-title">
                    	<a data-toggle="collapse" href="#column<%=rs("id")%>"><%=rs("name")%></a>
                    </h4>
                </div>
            <%
                set rs1 =server.CreateObject("adodb.recordset")
                sql1 = "select * from [column] where parentID = "&rs("id")&" order by sort asc,id asc"
                rs1.open sql1,conn,1,1
				if not rs1.eof then
			%>
            	<div id="column<%=rs("id")%>" class="panel-collapse collapse in">
            <%	
                	do while not rs1.eof
            %>
                	<div class="panel-body">
                    	<a href="javascript:void(0);" onClick="mainLink('<%=rs1("linkURL")&"?title="&rs1("name")%>')"><%=rs1("name")%></a>
                    </div>
            <%
					rs1.movenext
					loop
			%>
            	</div>
            <%
				end if
                rs1.close
                set rs1 = nothing
            rs.movenext
            loop
            rs.close
            set rs = nothing
            %>
            </div>
        </div>
        <div class="col-md-10">
        	<iframe src="configure/configure.asp?title=网站配置" id="main" width="100%" scrolling="no" frameborder="0" marginheight="0" marginwidth="0"></iframe>
        </div>
    </div>
</div>
<script type="text/javascript">
function reinitIframe(){  
	var iframe = document.getElementById("main");  
	try{  
		var bHeight = iframe.contentWindow.document.body.scrollHeight;  
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;  
		var height = Math.max(bHeight, dHeight);  
		iframe.height =  height;  
	}catch (ex){}  
}  
window.setInterval("reinitIframe()", 200); 

function mainLink(e){
	$("#main").attr('src',e);
}
</script>
</body>
</html>
