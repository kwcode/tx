<%@ Page Title="" Language="C#" MasterPageFile="~/SongShe/songshe.Master" AutoEventWireup="true" CodeBehind="UserCenter.aspx.cs" Inherits="Maticsoft.Web.SongShe.UserCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            $(".nav li.linav").eq(5).find(".parentnav").addClass("currenta");
        });
    </script>
    <style>
        .title {
            height: 40px;
            border-bottom: 1px dotted #F09192;
            width: 550px;
            color: #F09192;
            margin-top: 40px;
        }

            .title span {
                font-size: 30px;
                font-weight: bold;
                font-family: KaiTi;
            }

            .title label {
                margin-left: 15px;
                font-size: 16px;
            }

        .membercardcontent {
            color: #8C8C8C;
            line-height: 25px;
            margin-top: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%pc = PageContentList.Where(p => p.KeyID == 6).FirstOrDefault(); %>
    <div class="bigimg">
        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/scorll_6.jpg'" />
        <div class="bigimgtext" <%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"style='display:none;'":"" %>><%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"":pc.Remark %> </div>
    </div>
    <div class="pagecontent">
        <div class="membercardtype">
            <%pc = PageContentList.Where(p => p.KeyID == 39).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"会员卡类别":pc.Title %></span><label><%=pc==null?"MEMBERCARDTRPE":pc.Remark %></label></div>
            <div class="membercardcontent">
                <%=pc==null?"有专业的营养师与中医师一起为产后妈妈精心调配出适合妈妈体质的美味月子餐。有专业的营养师与中医师一起为产后妈妈精心调配出适合妈妈体质的美味月子餐有专业的营养师与中医师一起为产后妈妈精心调配出适合妈妈体质的美味月子餐有专业的营养师与中医师一起为产后妈妈精心调配出适合妈妈体质的美味月子餐":pc.Description.Replace(" ","&nbsp;").Replace("\r\n","<br/>").Replace("\r","<br/>").Replace("\n","<br/>") %>
            </div>
        </div>
        <div class="membercardql">
            <%pc = PageContentList.Where(p => p.KeyID == 40).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"会员卡权利":pc.Title %></span><label><%=pc==null?"MEMBERCARDRIGHT":pc.Remark %></label></div>
            <div class="membercardcontent">
                <%=pc==null?"有专业的营养师与中医师一起为产后妈妈精心调配出适合妈妈体质的美味月子餐":pc.Description.Replace(" ","&nbsp;").Replace("\r\n","<br/>").Replace("\r","<br/>").Replace("\n","<br/>") %>
            </div>
        </div>
        <div class="membercardblway">
            <%pc = PageContentList.Where(p => p.KeyID == 41).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"会员卡办理方式":pc.Title %></span><label><%=pc==null?"MEMBERCARDMANAGEMENT MODE":pc.Remark %></label></div>
            <div class="membercardcontent">
                <%=pc==null?"有专业的营养师与中医师一起为产后妈妈精心调配出适合妈妈体质的美味月子餐。":pc.Description.Replace(" ","&nbsp;").Replace("\r\n","<br/>").Replace("\r","<br/>").Replace("\n","<br/>") %>
            </div>
        </div>
    </div>
</asp:Content>
