//id为upTime的时间控件下拉显示
$(function(){
	$("#upTime").datetimepicker({
		format : "yyyy/m/d hh:ii:ss",
		weekStart : 0,		//一周开始的日期
		autoclose : 1,		//选择时间后是否关闭
		todayBtn : 1,		//是否有当天日期按钮
		language : 'zh-CN'
	});
});


