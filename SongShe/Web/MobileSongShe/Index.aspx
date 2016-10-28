<%@ Page Title="" Language="C#" MasterPageFile="~/MobileSongShe/songshe.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Maticsoft.Web.MobileSongShe.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/MobileSongShe/CSS/index.css" rel="stylesheet" />
    <script src="/UserJs/jquery.event.drag-1.5.min.js"></script>
    <script src="/UserJs/jquery.touchSlider.js"></script>
    <script>
        //轮播图
        $(document).ready(function () {
            $dragBln = false;
            $(".main_image").touchSlider({
                flexible: true,
                speed: 200,
                btn_prev: $("#btn_prev"),
                btn_next: $("#btn_next"),
                paging: $(".flicking_con a"),
                counter: function (e) {
                    $(".flicking_con a").removeClass("on").eq(e.current - 1).addClass("on");
                }
            });
            $(".main_image").bind("mousedown", function () {
                $dragBln = false;
            })
            $(".main_image").bind("dragstart", function () {
                $dragBln = true;
            })
            $(".main_image a").click(function () {
                if ($dragBln) {
                    return false;
                }
            })
            timer = setInterval(function () { $("#btn_next").click(); }, 3000);
            $(".main_visual").hover(function () {
                clearInterval(timer);
            }, function () {
                timer = setInterval(function () { $("#btn_next").click(); }, 3000);
            })
            $(".main_image").bind("touchstart", function () {
                clearInterval(timer);
            }).bind("touchend", function () {
                timer = setInterval(function () { $("#btn_next").click(); }, 3000);
            });
        });
        $(function () {
            $("#navul li a").eq(0).addClass("current");
            var width = $(".main_image").width();
            if (width > 0) {
                $(".main_visual").height(width / 3);
                $(".main_image").height(width / 3);
                $(".main_image li").height(width / 3);
                $(".main_image a").height(width / 3);
                $(".main_image img").height(width / 3);
                $("div.flicking_con").css("top", width / 3-15);
            }
            $("div[class=muzhdiv] img").attr("height", ($(".main_image").width()-50) / 5);
            //alert($(".main_image").width());
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--轮播图片开始--%>
    <div class="main_visual">
        <div class="flicking_con">
            <div class="flicking_inner">
                <a>1</a><a>2</a><a>3</a><a>4</a><a>5</a><a>6</a>
            </div>
        </div>
        <div class="main_image">
            <ul>
                <li>
                    <a href="/SongShe/SongSheBrand.aspx" data-ajax="false"> 
                        <%pc = PageContentList.Where(p => p.KeyID == 1).FirstOrDefault(); %>
                        <img src="<%=(pc==null)?"/Image/scorll_1.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_1.jpg'" /></a>
                </li>
                <li>
                    <a href="/SongShe/InfantCare.aspx" data-ajax="false">
                        <%pc = PageContentList.Where(p => p.KeyID == 2).FirstOrDefault(); %>
                        <img src="<%=(pc==null)?"/Image/scorll_2.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_2.jpg'" /></a>
                </li>
                <li>
                    <a href="/SongShe/SongSheEnvironment.aspx" data-ajax="false">
                        <%pc = PageContentList.Where(p => p.KeyID == 3).FirstOrDefault(); %>
                        <img src="<%=(pc==null)?"/Image/scorll_3.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_3.jpg'" /></a>
                </li>
                <li>
                    <a href="/SongShe/MonthOfMeals.aspx" data-ajax="false">
                        <%pc = PageContentList.Where(p => p.KeyID == 4).FirstOrDefault(); %>
                        <img src="<%=(pc==null)?"/Image/scorll_4.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_4.jpg'" /></a>
                </li>
                <li>
                    <a href="/SongShe/NewsInfo.aspx" data-ajax="false">
                        <%pc = PageContentList.Where(p => p.KeyID == 5).FirstOrDefault(); %>
                        <img src="<%=(pc==null)?"/Image/scorll_5.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_5.jpg'" /></a>
                </li>
                <li>
                    <a href="/SongShe/UserCenter.aspx" data-ajax="false">
                        <%pc = PageContentList.Where(p => p.KeyID == 6).FirstOrDefault(); %>
                        <img src="<%=(pc==null)?"/Image/scorll_6.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_6.jpg'" /></a>
                </li>
            </ul>
            <a href="javascript:;" id="btn_prev" style="display: none;"></a>
            <a href="javascript:;" id="btn_next" style="display: none;"></a>
        </div>
    </div>
    <%--轮播图片结束--%>
    <div style="position: relative; z-index: 20;">
        <div class="muzhdiv">
            <ul>
                <li>
                    <a href="/MobileSongShe/InfantCare.aspx#motherzh" data-ajax="false">
                        <img src="/Image/mmzh.png" /></a>
                </li>
                <li>
                    <a href="/MobileSongShe/InfantCare.aspx#babyhl" data-ajax="false">
                        <img src="/Image/bbzh.png" /></a>
                </li>
                <li>
                    <a href="/MobileSongShe/MonthOfMeals.aspx" data-ajax="false">
                        <img src="/Image/yzss.png" /></a>
                </li>
                <li>
                    <a href="/MobileSongShe/InfantCare.aspx#motherzh" data-ajax="false">
                        <img src="/Image/chxf.png" /></a>
                </li>
                <li>
                    <a href="/MobileSongShe/SongSheEnvironment.aspx" data-ajax="false">
                        <img src="/MobileSongShe/Image/sxhj.png" /></a>
                </li>
            </ul>
            <div style="clear: both;"></div>
        </div>
        <div class="title">
            新闻中心/活动预告
        </div>
        <div class="news">
            <ul>
                <%for (int i = 1; i < (NewsList == null ? 0 : NewsList.Rows.Count); i++)
                  {%>
                <li><a href="NewsDetail.aspx?nid=<%=NewsList.Rows[i]["KeyID"] %>" data-ajax="false">
                    <div class="sxy"></div>
                    <div class="newstitle"><%=NewsList.Rows[i]["Title"] %></div>
                    <div class="newtime"><%=Maticsoft.Common.CommonHelper.ToDateTime( NewsList.Rows[i]["EditTime"]).ToString("yyyy-MM-dd") %></div>
                </a></li>
                <%} %>
            </ul>
        </div>
    </div>
</asp:Content>
