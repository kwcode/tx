<%@ Page Title="" Language="C#" MasterPageFile="~/SongShe/songshe.Master" AutoEventWireup="true" CodeBehind="SongSheEnvironment.aspx.cs" Inherits="Maticsoft.Web.SongShe.SongSheEnvironment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            $(".nav li.linav").eq(2).find(".parentnav").addClass("currenta");
        });
    </script>
    <style>
        .title {
            height: 40px;
            border-bottom: 1px dotted #F09192;
            width: 450px;
            color: #F09192;
            margin-top: 40px;
        }

            .title span {
                font-size: 21px;
                font-weight: bold;
                font-family: KaiTi;
            }

            .title label {
                margin-left: 12px;
                font-size: 16px;
            }

        .introduct, .environment .descript {
            line-height: 25px;
            margin-top: 20px;
            color: #898989;
            text-indent: 30px;
            width: 900px;
        }

            .environment .descript .detitle {
                font-size: 18px;
                margin-top: 30px;
            }

        .environment ul li {
            float: left;
            margin-top: 15px;
            margin-right: 15px;
        }

            .environment ul li.ebigimg img {
                width: 780px;
                height: 380px;
            }

            .environment ul li.esmallimg img {
                width: 380px;
                height: 380px;
            }

        .pthj ul li.liimg {
            float: left;
            margin-right: 15px;
            text-align: center;
            font-size: 18px;
            color: #898989;
            margin-top: 20px;
        }

            .pthj ul li.liimg img {
                margin-top: 20px;
                width: 382px;
                height: 228px;
            }
        .wztf, .gztf {
            float:left;
        }
        .gztf {
            margin-left:40px;
        }
        .wztf .tfimg, .gztf .tfimg {
            margin-top:20px;
        }
            .wztf .tfimg img, .gztf .tfimg img {
                width:570px;
                height:540px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigimg">
        <%pc = PageContentList.Where(p => p.KeyID == 3).FirstOrDefault(); %>
        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/scorll_3.jpg'" />
        <div class="bigimgtext" <%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"style='display:none;'":"" %>><%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"隐身都市的世外桃源":pc.Remark %> </div>
    </div>
    <div class="pagecontent">
        <div id="pthj" class="pthj">
            <%pc = PageContentList.Where(p => p.KeyID == 15).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"配套环境":pc.Title %></span><label><%=pc==null?"ALIGNED ENVIRONMENT":pc.Remark %></label></div>
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
                <%--颂玺母婴照护位于繁华的城市中心大坪，离重庆医科大学附属医院仅3分钟，为妈妈和宝宝提供安全的医疗保障。房间独特的落地窗，远眺城市美景，俯拥商业繁华。闹中取静能将城市喧嚣彻底屏蔽。环境优雅，温馨私密，配备高档完善的母婴专护配套设施，独立新风，除尘除菌，绿色环保空气净化系统，三重高科技安防体系确保安全，是您月子期休养的最佳选择。--%>
            </div>
            <div class="environment">
                <div>
                    <div class="descript">
                        <%pc = PageContentList.Where(p => p.KeyID == 26).FirstOrDefault(); %>
                        <div class="detitle"><%=pc==null?"阳光明媚，自然环保":pc.Title %></div>
                        <div><%=pc==null?"每一房间都通透无比，看得见四季的变化，享受到阳光的温暖与明媚。采用国外进口的装修材料，精心挑选的专属家具，自然环保。":pc.Detail %></div>
                    </div>
                    <ul>
                        <%pc = PageContentList.Where(p => p.KeyID == 28).FirstOrDefault(); %>
                        <%--大图建议尺寸：width:780px;height:380px;
                    小图建议尺寸： width:380px;height:380px;--%>
                        <li class="ebigimg">
                            <img src="<%=pc==null?"":pc.Title %>" onerror="this.src='/Image/h_24.jpg'" /></li>
                        <li class="esmallimg">
                            <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_25.jpg'" /></li>
                        <li class="esmallimg">
                            <img src="<%=pc==null?"":pc.Remark %>" onerror="this.src='/Image/h_26.jpg'" /></li>
                        <li class="ebigimg">
                            <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_27.jpg'" /></li>
                    </ul>
                </div>
                <div style="clear: both;"></div>
                <div>
                    <div class="descript">
                        <%pc = PageContentList.Where(p => p.KeyID == 27).FirstOrDefault(); %>
                        <div class="detitle"><%=pc==null?"功能区 纯白洁净":pc.Title %></div>
                        <div><%=pc==null?"宝宝SPA室一天两次医疗标准消毒，育婴室一天两次医疗标准消毒，杜绝交叉感染，婴儿床使用前消毒，床上用品每周换洗，理疗室舒适环保。":pc.Detail %></div>
                    </div>
                    <ul>
                        <%pc = PageContentList.Where(p => p.KeyID == 29).FirstOrDefault(); %>
                        <%--大图建议尺寸：width:780px;height:380px;
                    小图建议尺寸： width:380px;height:380px;--%>
                        <li class="ebigimg">
                            <img src="<%=pc==null?"":pc.Title %>" onerror="this.src='/Image/h_28.jpg'" /></li>
                        <li class="esmallimg">
                            <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_29.jpg'" /></li>
                        <li class="esmallimg">
                            <img src="<%=pc==null?"":pc.Remark %>" onerror="this.src='/Image/h_30.jpg'" /></li>
                        <li class="ebigimg">
                            <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_31.jpg'" /></li>
                    </ul>
                </div>
                <div style="clear: both;"></div>
            </div>
            <div>
                <ul>
                    
                    <%--图片建议尺寸：width:382px;height:228px;--%>
                    <li class="liimg">
                        <%pc = PageContentList.Where(p => p.KeyID == 30).FirstOrDefault(); %>
                        <div><%=pc==null?"书吧-爸爸的育儿角落":pc.Title %></div>
                        <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_32.jpg'" /></li>
                    <li class="liimg">
                        <%pc = PageContentList.Where(p => p.KeyID == 31).FirstOrDefault(); %>
                        <div><%=pc==null?"多功能健身房-找回曾经的自己":pc.Title %></div>
                        <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_33.jpg'" /></li>
                    <li class="liimg">
                        <%pc = PageContentList.Where(p => p.KeyID == 32).FirstOrDefault(); %>
                        <div><%=pc==null?"阳光休息房-每一天新的开始":pc.Title %></div>
                        <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_34.jpg'" /></li>
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div id="wztf" class="wztf">
            <%pc = PageContentList.Where(p => p.KeyID == 16).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"王子套房":pc.Title %></span><label><%=pc==null?"PRINCE SUITE":pc.Remark %></label></div>
            <%--图片尺寸建议：width:570px;height:540px;--%>
            <div class="tfimg"><img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_35.jpg'" /></div>
        </div>
        <div id="gztf" class="gztf">
            <%pc = PageContentList.Where(p => p.KeyID == 17).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"公主套房":pc.Title %></span><label><%=pc==null?"PRINCESS SUITE":pc.Remark %></label></div>
            <%--图片尺寸建议：width:570px;height:540px;--%>
            <div class="tfimg"><img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_36.jpg'" /></div>
        </div>
        <div style="clear:both;"></div>
    </div>
</asp:Content>
