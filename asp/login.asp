<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet = "utf-8"
Session.CodePage = "65001"
title = "后台登录"

%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" type="text/css" href="bootstrap-3.3.5/css/bootstrap.min.css" />
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="bootstrap-3.3.5/js/jquery-1.11.3.min.js" ></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="bootstrap-3.3.5/js/bootstrap.min.js"></script>
<title><%=title%></title>
</head>
<body>
<div class="modal fade in" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" style="display:block; font-size:18px;">
	<div class="modal-dialog" role="document">
        <div class="modal-content">
        	<form role="form" method="post" action="check/checklogin.asp">
                <div class="modal-header">
                    <h4 class="modal-title"><%=title%></h4>
                </div>
                <div class="modal-body">
                    <br />
                    <input type="text" required placeholder="用户名" class="form-control input_lg" id="userName" name="userName" />
                    <br />
                    <input type="password" required placeholder="密码" class="form-control input_lg" id="userPwd" name="userPwd" />
                    <br />
                    <input type="text" required placeholder="验证码" class="form-control pull-left" style="width:50%;" maxlength="4" id="checkCode" name="checkCode">
                    <img src="check/checkCode.asp" alt="验证码,看不清楚?请点击刷新验证码" title="点击刷新验证码" style="cursor:pointer; margin-left:10px; padding-top:5px; height:19px; line-height:14px;" onClick="this.src='check/checkCode.asp?t='+(new Date().getTime())" >
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-default" value="关闭" />
                    <input type="submit" class="btn btn-primary" value="进入" />
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal-backdrop fade in"></div>

</body>
</html>
