<%@ Page Title="" Language="C#" MasterPageFile="~/MobileSongShe/songshe.Master" AutoEventWireup="true" CodeBehind="NewsInfo.aspx.cs" Inherits="Maticsoft.Web.MobileSongShe.NewsInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            $("#navul li a").eq(5).addClass("current");
            $(".logo").html("新闻中心");
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

        .newzx .newsinfo {
            margin-top: 30px;
        }

            .newzx .newsinfo .newsimg img {
                width: 100%;
            }

            .newzx .newsinfo .newscontent {
                width: 100%;
                line-height: 25px;
                color: #898989;
                text-indent: 30px;
            }

        .qwfb .qwimg {
            margin-top: 20px;
        }

            .qwfb .qwimg img {
                width: 100%;
            }

        .newslist {
            margin-top: 40px;
            margin-left: 20px;
        }

            .newslist li {
                list-style-type: disc;
                border: 1px solid white;
            }

            .newslist li {
                clear: both;
                line-height: 25px;
            }

                .newslist li .newstitle {
                    float: left;
                    width: 70%;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .newslist li a {
                    color: #898989 !important;
                }

                    .newslist li a:hover {
                        color: #43BCC5;
                    }

                .newslist li .newstime {
                    float: right;
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
        <div id="newzx" class="newzx">
            <%pc = PageContentList.Where(p => p.KeyID == 18).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"最新资讯":pc.Title %></span><label><%=pc==null?"LATEST NEWS":pc.Remark %></label></div>
            <div class="newsinfo">
                <div class="newsimg">
                    <%--图片尺寸建议：width: 700px;height:445px;--%>
                    <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_42.jpg'" />
                </div>
                <div class="newscontent">
                    <%if (pc == null) { pc = new Maticsoft.Model.PageContent(); pc.Description = ""; }
                      string[] strContents = pc.Description.Replace(" ", "&nbsp;").Replace("\r\n", " ").Replace("\r", " ").Replace("\n", " ").Split(' ');
                      foreach (string strContent in strContents)
                      {%>
                    <div><%=strContent %></div>
                    <%}%>
                    <%--<div>重庆颂玺母婴照护中心由重庆力杨实业（集团）投资，与台湾母婴照护知名连锁品牌机构合作共同打造的两岸跨界健康服务产业项目，具备中国妇产科最专业权威的医学团队资源、专业技术技能与硬件设备。作为重庆市唯一拥有母婴产后四大照护体系的中心会所，我们秉持建立荣耀在您、信任于我、喜悦共享、追求创新、医学人文关怀一体的全方位母婴照护服务体系。</div>
                    <div>我们提供围产期妈妈完整的产前、生产、产后三个时期的人性化的专业照护服务，营造亲子共享优质的休养环境。满足妈妈及家庭成员的生理和心理需要，让家庭成员的共同参与，促进产妇到母亲的角色转换。</div>--%>
                </div>
                <div style="clear: both;"></div>
                <div class="newslist">
                    <ul>
                        <%foreach (System.Data.DataRow dr in News1List.Rows)
                          {%>
                        <li>
                            <a href="NewsDetail.aspx?nid=<%=dr["KeyID"] %>" data-ajax="false">
                                <div class="newstitle"><%=dr["Title"] %></div>
                                <div class="newstime"><%=Maticsoft.Common.CommonHelper.ToDateTime(dr["EditTime"]).ToString("yyyy-MM-dd") %></div>
                            </a>
                        </li>
                        <%} %>
                        <%--<li>
                            <a href="NewsDetail.aspx">
                                <div class="newstitle">有专业营养师与中医师为产后妈妈精心调配出适合妈妈体质的美味月子餐。</div>
                                <div class="newstime">2016-09-10</div>
                            </a>
                        </li>
                        <li>
                            <a href="NewsDetail.aspx">
                                <div class="newstitle">有专业营养师与中医师为产后妈妈精心调配出适合妈妈体质的美味月子餐。</div>
                                <div class="newstime">2016-09-10</div>
                            </a>
                        </li>
                        <li>
                            <a href="NewsDetail.aspx">
                                <div class="newstitle">有专业营养师与中医师为产后妈妈精心调配出适合妈妈体质的美味月子餐。</div>
                                <div class="newstime">2016-09-10</div>
                            </a>
                        </li>--%>
                    </ul>
                </div>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div id="qwfb" class="qwfb">
            <%pc = PageContentList.Where(p => p.KeyID == 19).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"权威发布":pc.Title %></span><label><%=pc==null?"AUTHORITATIVE RELEASE":pc.Remark %></label></div>
            <div class="qwimg">
                <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_43.jpg'" />
            </div>
            <div class="introduct">
                <%if (pc == null) { pc = new Maticsoft.Model.PageContent(); pc.Description = ""; }
                  strContents = pc.Description.Replace(" ", "&nbsp;").Replace("\r\n", " ").Replace("\r", " ").Replace("\n", " ").Split(' ');
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
            </div>
            <div class="newslist">
                <ul>
                    <%foreach (System.Data.DataRow dr in News2List.Rows)
                      {%>
                    <li>
                        <a href="NewsDetail.aspx?nid=<%=dr["KeyID"] %>" data-ajax="false">
                            <div class="newstitle"><%=dr["Title"] %></div>
                            <div class="newstime"><%=Maticsoft.Common.CommonHelper.ToDateTime(dr["EditTime"]).ToString("yyyy-MM-dd") %></div>
                        </a>
                    </li>
                    <%} %>
                    <%--<li>
                        <a href="NewsDetail.aspx">
                            <div class="newstitle">有专业营养师与中医师为产后妈妈精心调配出适合妈妈体质的美味月子餐。</div>
                            <div class="newstime">2016-09-10</div>
                        </a>
                    </li>
                    <li>
                        <a href="NewsDetail.aspx">
                            <div class="newstitle">有专业营养师与中医师为产后妈妈精心调配出适合妈妈体质的美味月子餐。</div>
                            <div class="newstime">2016-09-10</div>
                        </a>
                    </li>
                    <li>
                        <a href="NewsDetail.aspx">
                            <div class="newstitle">有专业营养师与中医师为产后妈妈精心调配出适合妈妈体质的美味月子餐。</div>
                            <div class="newstime">2016-09-10</div>
                        </a>
                    </li>--%>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
