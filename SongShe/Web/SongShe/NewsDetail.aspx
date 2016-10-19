<%@ Page Title="" Language="C#" MasterPageFile="~/SongShe/songshe.Master" AutoEventWireup="true" CodeBehind="NewsDetail.aspx.cs" Inherits="Maticsoft.Web.SongShe.NewsDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            $(".nav li.linav").eq(4).find(".parentnav").addClass("currenta");
        });
    </script>
    <style>
        .newtitle {
            text-align:center;
            margin-top:50px;
            border-top:1px dotted #F4AEAC;
            border-bottom:1px dotted #F4AEAC;
            padding-top:15px;
            padding-bottom:15px;
        }
            .newtitle .ntitle {
                font-size:30px;
                color:#45BBC5;
                font-weight:bold;
                font-family:KaiTi;
            }
            .newtitle .ntime {
                margin-top:10px;
                color:#7F7F7F;
            }
        .newscontent {
            margin-top:20px;
            line-height:25px;
            text-indent:25px;
        }
        .newsyg {
            border-top:1px dotted #F4AEAC;
            padding-top:20px;
            margin-top:40px;
        }
            .newsyg a {
                display:block;
                color:#45BBC5;
                font-size:18px;
                font-family:KaiTi;
                font-weight:bold;
            }
        .before {
            float:left;
        }
        .after {
            float:right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigimg">
        <img src="/Image/scorll_5.jpg" />   
    </div>
    <div class="pagecontent">
        <div class="newtitle">
            <div class="ntitle">宠爱从第一次接触开始</div>
            <div class="ntime">2016-10-06&nbsp;&nbsp;&nbsp;重庆安琪儿妇产医院</div>
        </div>
        <div class="newscontent">
           宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始宠爱从第一次接触开始
        </div>
        <div class="newsyg">
            <a class="before">上一篇：调研重庆医院，助推民营医院发展</a>
            <a class="after">下一篇：海峡两岸妇产权威聚首山城论道生殖健康</a>
        </div>
    </div>
</asp:Content>
