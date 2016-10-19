//轮播图
$(function () {
    var sWidth = $("#focus").width(); //获取焦点图的宽度（显示面积）
    var len = $("#focus ul li").length; //获取焦点图个数
    var index = 0;
    var picTimer;

    //以下代码添加数字按钮和按钮后的半透明条，还有上一页、下一页两个按钮
    var btn = "<div class='btn'>";
    for (var i = 0; i < len; i++) {
        btn += "<span></span>";
    }
    btn += "</div>";
    $("#focus").append(btn);
    //为小按钮添加鼠标滑入事件，以显示相应的内容
    $("#focus .btn span").mouseover(function () {
        index = $("#focus .btn span").index(this);
        showPics(index);
    }).eq(0).trigger("mouseover");
    //本例为左右滚动，即所有li元素都是在同一排向左浮动，所以这里需要计算出外围ul元素的宽度
    $("#focus ul").css("width", sWidth * (len));
    $("#focus ul li").css("width", sWidth * (len) / len);
    //鼠标滑上焦点图时停止自动播放，滑出时开始自动播放
    $("#focus").hover(function () {
        clearInterval(picTimer);
    }, function () {
        picTimer = setInterval(function () {
            showPics(index);
            index++;
            if (index == len) { index = 0; }
        }, 3000); //此3000代表自动播放的间隔，单位：毫秒
    }).trigger("mouseleave");

    //显示图片函数，根据接收的index值显示相应的内容
    function showPics(index) { //普通切换
        var nowLeft = -index * sWidth; //根据index值计算ul元素的left值
        $("#focus ul").stop(true, false).animate({ "left": nowLeft }, 300); //通过animate()调整ul元素滚动到计算出的position

        $("#focus .btn span").stop(true, false).css("background", "#ccc").animate({ "opacity": "1" }, 300).eq(index).stop(true, false).css("background", "#43BCC6").animate({ "opacity": "1" }, 300); //为当前的按钮切换到选中的效果
    }
});

$(function () {
    //新闻中心显示省略号
    $(".newscontent").dotdotdot();
    photoscroll();
});
function photoscroll() {
    $li1 = $("#imgscorll li");
    $window1 = $("#imgscorll ul");
    $left1 = $(".docotrimgscorll .leftbutton");
    $right1 = $(".docotrimgscorll .rightbutton");

    $window1.css("width", $li1.length * 134);

    var lc1 = 0;
    var rc1 = $li1.length - 6;
    $left1.click(function () {
        if (lc1 < 1) {
            //alert("已经是第一张啦");
            return;
        }
        lc1--;
        rc1++;
        $window1.animate({ left: '+=134px' }, 1000);
    });

    $right1.click(function () {
        if (rc1 < 1) {
            //alert("已经没有更多图片啦");
            return;
        }
        lc1++;
        rc1--;
        $window1.animate({ left: '-=134px' }, 1000);
    });
}