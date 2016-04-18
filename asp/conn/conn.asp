
<%
sqldata=1    '数据库类型，1为sql数据库，0为access数据库
if sqldata=0 then
	dbstr="/database/#%slzjiu#com.mdb"  'access数据库地址
	Set conn = Server.CreateObject("ADODB.Connection")
	DBPath = Server.MapPath(dbstr)
	connstr="provider=microsoft.jet.oledb.4.0;data source=" &DBPath
	conn.Open connstr
else
'sql数据库连接参数：数据库名、用户密码、用户名、连接名（本地用local，外地用IP）
  Dim sql_databasename,sql_password,sql_username,sql_localname
	sql_localname = "127.0.0.1" ''服务器ip
	sql_databasename = "lixinBlog"
	sql_username = "sa"
	sql_password = "aA123456"
	connstr = "Provider = Sqloledb; User ID = " & sql_username & "; Password = " & sql_password & "; Initial Catalog = " & sql_databasename & "; Data Source = " & sql_localname & ";"
	Set conn=Server.CreateObject("ADODB.connection")
	conn.open connstr
end if

'处理时间
function datemate(gettime)
	if gettime<>"" then
		getyear = year(gettime)
		getmonth = month(gettime)
		getday = day(gettime)
		gethour = hour(gettime)
		getmin = minute(gettime)
		getsec = second(gettime)
		if len(getmonth) = 1 then getmonth = "0"&getmonth
		if len(getday) = 1 then getday = "0"&getday
		if len(gethour) = 1 then gethour = "0"&gethour
		if len(getmin) = 1 then getmin = "0"&getmin
		if len(getsec) = 1 then getsec = "0"&getsec 
		datemate = getyear&"-"&getmonth&"-"&getday
	end if
end function

'函数作用:'简写response.Write
sub w(fcb_str)
	response.write(fcb_str)
end sub
sub wc(fcb_str)
	response.write(fcb_str&vbCrLf)
end sub
sub wn(fcb_str)
	response.write(fcb_str&"<br />")
end sub
sub we(fcb_str)
 response.write(fcb_str):response.End()
end sub

'函数作用:执行一段js代码
function js(fcb_str)
js="<script type='text/javascript'>"&fcb_str&"</script>"
end function

'函数作用:弹出对话框提示信息
function msg(fcb_str,fc_base_url)
	if isN(fc_base_url) then
	  we(js("alert('"&fcb_str&"');history.back();"))
	else
	  we(js("alert('"&fcb_str&"');location='"&fc_base_url&"';"))
	end if
end Function

'函数作用:'判断是否是无效
Function isN(ByVal str)
	isN = False
	Select Case VarType(str)
		Case vbEmpty, vbNull
			isN = True : Exit Function
		Case vbString
			If str="" Then isN = True : Exit Function
		Case vbObject
			If TypeName(str)="Nothing" Or TypeName(str)="Empty" Then isN = True : Exit Function
		Case vbArray,8194,8204,8209
			If Ubound(str)=-1 Then isN = True : Exit Function
	End Select
End Function

'判断str是否有值，没有赋值为num
function isZero(str,num)
	if trim(str)="" or isNumeric(str) then
		isZero = Int(str)
	else
		isZero = Int(num)
	end if
end function

'处理textarea中出现空格和回车，存入数据库
function getStr(str) 
	str = replace(str, " ", "&nbsp;") 
	str = replace(str, vbCrLf, "<br>")
	getStr = str 
end function

function getFxStr(str) 
	if instr(str,"&nbsp;")>0 then str = replace(str, "&nbsp;", " ")
	if instr(str,"<br>")>0 then str = replace(str, "<br>", vbCrLf)
	getFxStr = str 
end function
%>