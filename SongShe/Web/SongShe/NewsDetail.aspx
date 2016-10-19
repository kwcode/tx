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
        <%pc = PageContentList.Where(p => p.KeyID == 5).FirstOrDefault(); %>
        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/scorll_5.jpg'" />
        <div class="bigimgtext" <%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"style='display:none;'":"" %>><%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"发现最新动态":pc.Remark %> </div>
    </div>
    <div class="pagecontent">
        <div class="newtitle">
            <div class="ntitle"><%=NewsInfo.Rows[0]["Title"] %></div>
            <div class="ntime"><%=Maticsoft.Common.CommonHelper.ToDateTime(NewsInfo.Rows[0]["EditTime"]).ToString("yyyy-MM-dd") %>&nbsp;&nbsp;&nbsp;<%=NewsInfo.Rows[0]["Source"] %></div>
        </div>
        <div class="newscontent">
           <%=NewsInfo.Rows[0]["Detail"] %>
        </div>
        <div class="newsyg">
            <%if(BeforeNewsInfo.Rows.Count>0){ %>
            <a class="before" href="NewsDetail.aspx?nid=<%=BeforeNewsInfo.Rows[0]["KeyID"] %>" style="overflow:hidden;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;overflow: hidden;-webkit-line-clamp: 1;max-width:580px;">上一篇：<%=BeforeNewsInfo.Rows[0]["Title"] %></a>
            <%}
              if(AfterNewsInfo.Rows.Count>0){ %>
            <a class="after" href="NewsDetail.aspx?nid=<%=AfterNewsInfo.Rows[0]["KeyID"] %>" style="overflow:hidden;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;overflow: hidden;-webkit-line-clamp: 1;max-width:580px;">下一篇：<%=AfterNewsInfo.Rows[0]["Title"] %></a>
            <%} %>
        </div>
    </div>
</asp:Content>
