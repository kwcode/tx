<%@ Page Title="" Language="C#" MasterPageFile="~/MobileSongShe/songshe.Master" AutoEventWireup="true" CodeBehind="MonthOfMeals.aspx.cs" Inherits="Maticsoft.Web.MobileSongShe.MonthOfMeals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            $("#navul li a").eq(4).addClass("current");
            $(".logo").html("月子膳食");
        });
    </script>
    <style>
        .pagecontent {
            font-size: 12px;
            margin-top: 40px;
        }

        .content {
            padding: 10px !important;
        }

        .title {
            height: 40px;
            line-height: 40px;
            border-bottom: 1px dotted #F09192;
            width: 100%;
            color: #F09192;
            margin-top: 20px;
            overflow: hidden;
            text-align: center;
        }

            .title span {
                font-size: 21px;
                font-weight: bold;
                font-family: KaiTi;
            }

            .title label {
                display: inline;
                margin-left: 14px;
                font-size: 12px;
                display: none !important;
            }

        .pagecontent li .descript {
            line-height: 30px;
            margin-top: 15px;
            color: #898989;
            text-indent: 30px;
            width: 100%;
        }

            .pagecontent li .descript .detitle {
                font-size: 18px;
                margin-top: 30px;
            }

        .pagecontent li .swimg {
            margin-top: 20px;
        }

            .pagecontent li .swimg img {
                width: 100%;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigimg">
        <%pc = PageContentList.Where(p => p.KeyID == 4).FirstOrDefault(); %>
        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/scorll_4.jpg'" />
        <div class="bigimgtext" <%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"style='display:none;'":"" %>><%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"幸福的味道":pc.Remark %> </div>
    </div>
    <div id="MonthOfMeals" class="pagecontent">
        <%pc = PageContentList.Where(p => p.KeyID == 33).FirstOrDefault(); %>
        <div class="title"><span><%=pc==null?"月子营养膳食":pc.Title %></span><label><%=pc==null?"CONFINEMENT NUTRITION":pc.Remark %></label></div>
        <div class="introduct">
            <%string[] strContents = pc.Description.Replace(" ", "&nbsp;").Replace("\r\n", " ").Replace("\r", " ").Replace("\n", " ").Split(' ');
              for (int i = 0; i < strContents.Length; i++)
              {
                  if (i % 2 == 1)
                  {%>
            <div class="fuwu">
                <%} %>
                <%=strContents[i] %>
                <% if (i % 2 == 1)
                   {%>
            </div>
            <%} %>
            <%}%>
            <div>
                <ul>
                    <%foreach (Maticsoft.Model.PageContent pcontent in PageContentList.Where(p => p.PageID == 4 && p.GroupID == 1 && p.TypeID == 0))
                      {%>
                    <li>
                        <div class="descript">
                            <div class="detitle"><%=pcontent.Title %></div>
                            <div><%=pcontent.Detail %></div>
                        </div>
                        <div class="swimg">
                            <img src="<%=pcontent.ImgUrl %>" onerror="$(this).hide();" />
                        </div>
                    </li>
                    <%} %>
                    <%--<li>
                        <div class="descript">
                            <div class="detitle"></div>
                            <div>颂玺结合了现代医学与养生的概念，将中国传统之月子餐呈现符合个人体质所需的营养健康诉求，调制出专业、养生、关怀的高品质月子膳食。</div>
                        </div>
                        <div class="swimg">
                            <img src="/Image/h_37.jpg" /></div>
                    </li>
                    <li>
                        <div class="descript">
                            <div class="detitle">根据体质，个性化定制</div>
                            <div>有专业的营养师与中医师一起为产后妈妈精心调配出适合妈妈体质的美味月子餐。</div>
                        </div>
                        <div class="swimg">
                            <img src="/Image/h_38.jpg" /></div>
                    </li>
                    <li>
                        <div class="descript">
                            <div class="detitle">阶段性补养食膳</div>
                            <div>针对产妇个人体质调配阶段食膳，让每一位产后妈妈都能享有属于自己最好营养补给时机。</div>
                        </div>
                        <div class="swimg">
                            <img src="/Image/h_39.jpg" /></div>
                    </li>
                    <li>
                        <div class="descript">
                            <div class="detitle">坚持传统，用料实在</div>
                            <div>不添加任何调味料，严选把控食材安全，检测各项食材无药物残留。</div>
                        </div>
                        <div class="swimg">
                            <img src="/Image/h_40.jpg" /></div>
                    </li>
                    <li>
                        <div class="descript">
                            <div class="detitle">精致更养生</div>
                            <div>营养价值在于您吸收了多少；而不是吃了多少。用了传统的药膳食材，搭配现代之循环调理，让每一餐都能够享有丰富变化，每一餐都能开心回味。</div>
                        </div>
                        <div class="swimg">
                            <img src="/Image/h_41.jpg" /></div>
                    </li>--%>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
