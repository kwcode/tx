var PageHtml = "";//html字符串
var curIndex = 1; //当前页默认为1
var sumCount = 0;//总条数默认100
var curNumber = 10;//默认每次加载10条
var sumPage = 0; //总共的页码数
function RunPage() {
    sumPage = Math.ceil(sumCount / curNumber); //总共21.2页取最大22页
    if (sumPage == 0 || curIndex == 0) { return; }
    PageHtml = "当前:" + curIndex + "/" + sumPage + "页&nbsp;&nbsp;&nbsp;";
    
    //控制首页
    if (curIndex == 1) {
        PageHtml += "<a style='cursor:default;'>首页</a> <a style='cursor:default;'>上一页</a>";
    } else {
        PageHtml += "<a onclick='curIndex=1;RunPage()'>首页</a> <a onclick='--curIndex;RunPage()'>上一页</a>";
    }
   
    //控制数字点击页
    for (var i = curIndex - 3; i <= curIndex; i++) {
        if (i <= 0) { continue; }
        if (i == curIndex) {
            PageHtml += " <a style='color:#FFFFFF;background-color:#FF6100;cursor:text'>" + i + "</a> ";
        } else {
            PageHtml += " <a onclick='curIndex=" + i + ";RunPage()'>" + i + "</a> ";
        }

    }

    var num = parseFloat(curIndex) + 3;
    for (var j = curIndex; j <= num && j <= sumPage; j++) {

        if (j != curIndex) {
            PageHtml += " <a onclick='curIndex=" + j + ";RunPage()'>" + j + "</a> ";
        }

    }
   
    //控制尾页
    if (curIndex == sumPage) {
        PageHtml += " <a style='cursor:pointer;'>下一页</a> <a style='cursor:pointer; '>尾页&nbsp;</a>";
    } else {
        PageHtml += " <a onclick='++curIndex;RunPage()'>下一页</a> <a onclick='curIndex=" + sumPage + ";RunPage()'>尾页&nbsp;</a>";
    }
    PageHtml += "&nbsp;<input type='input' name='page' id='page' onkeypress='EnterKey()' onkeyup='usePageChange(this.value)' size='4' style='width:50px;border:1px solid #ddd;height:22px;margin-top:-3;'>";
    PageHtml += "&nbsp;<input type='button' value='跳转' onclick='tiaozhuan()' style='padding:3px 5px 3px 5px;cursor:pointer;'>";
    //class='pagebtn'
    $(".pages").html(PageHtml);

    LoadData(curIndex, curNumber); //当前页码 每页条数
}


function usePageChange(values) {
    var reg = new RegExp("^[0-9]*$");
    if (!reg.test(values)) {
        alert("请输入数字!");
        $("#page").val(1);
    }
    if (values > sumPage) {
        $("#page").val(sumPage);
    }
}

function tiaozhuan() {
    curIndex = $("#page").val();

    RunPage();
}
function EnterKey() {

    if (event.keyCode == 13) {
        usePageChange($("#page").val());
        tiaozhuan();
    }

}