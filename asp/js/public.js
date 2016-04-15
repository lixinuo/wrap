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





