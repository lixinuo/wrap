//创建全局对象
var Wrap = {};
$(function(){
    //计算时间
    Wrap.countTime();
    //改变图片大小  用css实现
    //Wrap.changePic("content_image");
    //右侧图标事件
    Wrap.rightBar();

});

//计算时间
Wrap.countTime = function(){
    setTimeout(Wrap.countTime,1000);
    var seconds = 1000;
    var minutes = seconds*60;
    var hours = minutes*60;
    var days = hours*24;
    var years = days*365;
    var today = new Date();
    var todayYear = today.getFullYear();
    var todayMouth = today.getMonth();
    var todayDate = today.getDate();
    var todayHour = today.getHours();
    var todayMinutes = today.getMinutes();
    var todaySeconds = today.getSeconds();
    var startTime = Date.UTC(2016, 2, 27, 0, 0, 0);
    var nowTime = Date.UTC(todayYear, todayMouth, todayDate, todayHour, todayMinutes, todaySeconds);
    var diff = nowTime - startTime;
    var diffYears = Math.floor(diff/years);
    var diffDays = Math.floor((diff - diffYears*years)/days);
    var diffHours = Math.floor((diff - diffYears*years - diffDays*days)/hours);
    var diffMinutes = Math.floor((diff - diffYears*years - diffDays*days - diffHours*hours)/minutes);
    var diffSeconds = Math.floor((diff - diffYears*years - diffDays*days - diffHours*hours - diffMinutes*minutes)/seconds);
    $("#runTime").html(/*diffYears +" 年 "+*/ diffDays + " 天 " + diffHours + " 小时 " + diffMinutes + " 分钟 " + diffSeconds + " 秒 ");
};

//改变图片大小 传入img的父元素的class值，图片会按照距离父层最小的距离变大
Wrap.changePic = function(e){
    $("."+e).find("img").hover(function(){
        imgHei = $(this).height();
        imgWid = $(this).width();
        var sizeHei = $(this).parent().height() - imgHei -1; //边框
        var sizeWid = $(this).parent().width() - imgWid -1;
        var size = sizeHei>sizeWid? sizeWid: sizeHei;
        $(this).animate({"height":imgHei+size,"width":imgWid+size});
    },function(){
        $(this).stop().animate({"height":imgHei,"width":imgWid});
    });
};

//右侧图标事件
Wrap.rightBar = function(){
    $(window).scroll(function(){  //上下滚动，图标出现和隐藏
        if ($(window).scrollTop() <= 10) {
            $("#back_to_head").hide();
        } else {
            $("#back_to_head").show();
        }
    });
    $("#back_to_head").mouseover(function(){   //右侧回到顶部事件
        $(this).css({"background":"#df328c"}).html("回到顶部");
    }).mouseout(function(){
        $(this).css({"background":""}).html("");
    }).click(function(){
        $("html, body").animate({scrollTop: 0}, 500);
    });
    $("#weiXin").mouseover(function(){        //右侧微信图片事件
        $(this).css({"background-image":"url(../../../HTML/wrap/images/weiXin2.png)"});
        $("#weiXin_pic").show();
    }).mouseout(function(){
        var weiXinPic = $("#weiXin_pic");
        weiXinPic.mouseover(function(){
            $(this).show();
        }).mouseout(function(){
            //$("#weiXin").css({"background-image":"url(../../../HTML/wrap/images/weiXin1.png)"});
            $(this).hide();
        });
        $(this).css({"background-image":"url(../../../HTML/wrap/images/weiXin1.png)"});
        weiXinPic.hide();
    });
};

//快速排序
Wrap.quickSort = function(arr){
	if(arr.length<=1){  //长度小于1，直接返回
		return arr;	
	}
	//找到中间数的索引，向下取整
	var mid = Math.floor(arr.length/2);   
	//找到中间数
	var midValue = arr.splice(mid,1);
	var left = [],
		right = [];
	for(var i = 0;i<arr.length;i++){
		if(arr[i]<midValue){
			left.push(arr[i]);	//基准点左边的数，传到left数组
		}else{
			right.push(arr[i]);	 //基准点右边的数，传到right数组
		}
	}
	return Wrap.quickSort(left).concat([midValue],Wrap.quickSort(right));  //递归比较
}












