//是否删除
function del(){
	if(!confirm('确认删除吗？')){
		return false;
	}	
}

$(function(){
	$(document).on('input propertychange', 'textarea', function(e){
		var target = e.target;
		//保留初始高度，之后需要重新设置一下初始高度，避免高度只增不减
		var bh = $(target).attr('defaultHeight') || 0;
		if (!bh) {
			bh = target.clientHeight;
			$(target).attr('defaultHeight', bh);	
		}
		target.style.height = bh + 'px';
		var clientHeight = target.clientHeight;
		var scrollHeight = target.scrollHeight;
		if (clientHeight !== scrollHeight ){
			target.style.height = scrollHeight + 10 + 'px';	
		}	
	});
});

/** 
* @param {String} divName 分页导航渲染到的dom对象ID 
* @param {String} funName 点击页码需要执行后台查询数据的JS函数 
* @param {Object} params 后台查询数据函数的参数，参数顺序就是该对象的顺序，当前页面一定要设置在里面的 
* @param {String} total 后台返回的总记录数 
* @param {Boolean} pageSize 每页显示的记录数，默认是10 
*/  
function supage(divId, funName, params, curPage, total, pageSize){  
    var output = '<ul class="pagination">';  
    var pageSize = parseInt(pageSize)>0 ? parseInt(pageSize) : 10;  
    if(parseInt(total) == 0 || parseInt(total) == 'NaN') return;  
    var totalPage = Math.ceil(total/pageSize);  
    var curPage = parseInt(curPage)>0 ? parseInt(curPage) : 1;  
      
    //从参数对象中解析出来各个参数  
    var param_str = '';  
    if(typeof params == 'object'){  
        for(o in params){  
            if(typeof params[o] == 'string'){  
               param_str += '\'' + params[o] + '\',';  
            }  
            else{  
               param_str += params[o] + ',';  
            }  
        }   
    }  
    //设置起始页码  
    if (totalPage > 5) {  
        if ((curPage - 2) > 0 && curPage < totalPage - 2) {  
            var start = curPage - 2;  
            var end = curPage + 2;  
        }  
        else if (curPage >= (totalPage - 2)) {  
            var start = totalPage - 4;  
            var end = totalPage;  
        }  
        else {  
            var start = 1;  
            var end = 5;  
        }  
    }  
    else {  
        var start = 1;  
        var end = totalPage;  
    }  
      
    //首页控制  
    if(curPage>1){  
        output += '<li><a href="javascript:'+funName+'(' + param_str + '1);" title="首页">首页</a></li>';  
    }  
    else  
    {  
        output += '<li class="disabled"><a>首页</a></li>';  
    }  
    //上一页菜单控制  
    if(curPage>1){  
        output += '<li><a href="javascript:'+funName+'(' + param_str + (curPage-1)+');" title="上一页">上一页</a></li>';  
    }  
    else{  
        output += '<li class="disabled"><a>上一页</a></li>';  
    }  
    //页码展示  
    for (i = start; i <= end; i++) {  
        if (i == curPage) {  
            output += '<li class="active"><a href="javascript:void(0);">' + curPage + '</a></li>';  
        }  
        else {  
            output += '<li><a href="javascript:'+funName+'(' + param_str + i + ');">' + i + '</a></li>';  
        }  
    }  
    //下一页菜单控制  
    if(totalPage>1 && curPage<totalPage){  
        output += '<li><a title="下一页" href="javascript:'+funName+'('+param_str + (curPage+1)+');">下一页</a></li>';  
    }  
    else{  
        output += '<li class="disabled"><a>下一页</a></li>';  
    }  
    //最后页控制  
    if(curPage<totalPage){  
        output += '<li><a title="尾页" href="javascript:'+funName+'('+param_str + totalPage+');">尾页</a></li>';  
    }  
    else{  
        output += '<li class="disabled"><a>尾页</a></li>';  
    }  
      
    output += '</ul>';  
    //渲染到dom中  
	$("#" + divId).html(output); 
};  



