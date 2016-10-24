<%@ Page Title="" Language="C#" MasterPageFile="~/MobileSongShe/songshe.Master" AutoEventWireup="true" CodeBehind="InfantCare.aspx.cs" Inherits="Maticsoft.Web.MobileSongShe.InfantCare" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/MobileSongShe/CSS/InfantCare.css" rel="stylesheet" />
    <script>
        $(function () {
            $("#navul li a").eq(2).addClass("current");
            $(".logo").html("母婴照护");
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigimg">
        <%pc = PageContentList.Where(p => p.KeyID == 2).FirstOrDefault(); %>
        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/scorll_2.jpg'" />
        <div class="bigimgtext" <%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"style='display:none;'":"" %>><%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"":pc.Remark %> </div>
    </div>
    <div class="pagecontent">
        <div id="motherzh" class="motherzh">
            <%pc = PageContentList.Where(p => p.KeyID == 11).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"妈妈照护":pc.Title %></span><label><%=pc==null?"MOTHER CARE":pc.Remark %></label></div>
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
                <%--恭喜您成为一位妈妈，不知从那时候起，您可能会兴奋，可能会消沉，有时候会开心地整天看着孩子傻笑，有时候会失落地摸着伤疤望着天花板思考人生，所以我们为您准备这些：
                <div class="fuwu">妈妈入住健康检查评估、心理测试及评估、乳房疏通按摩、产后子宫修复、母乳喂养指导、营养师制定月子餐、中医师调理保健、健康管理、产后运动指导等等。</div>
                    凡此种种，我们希望您每天开心的次数多一些，久一些，我们希望您的身体恢复到原来的样子，或者更进一步，达到您所向往的目标。总之，我们希望您更好。--%>
            </div>
            <div class="zhimage">
                <ul>
                    <%pc = PageContentList.Where(p => p.KeyID == 22).FirstOrDefault(); %>
                    <%--大图建议尺寸：width:800px;height:380px;
                    小图建议尺寸： width:360px;height:380px;--%>
                    <li class="zbigimg">
                        <img src="<%=pc==null?"":pc.Title %>" onerror="this.src='/Image/h_12.jpg'" /></li>
                    <li class="zsmallimg">
                        <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_13.jpg'" /></li>
                    <li class="zsmallimg">
                        <img src="<%=pc==null?"":pc.Remark %>" onerror="this.src='/Image/h_14.jpg'" /></li>
                    <li class="zbigimg">
                        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_15.jpg'" /></li>
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div id="babyhl" class="babyhl">
            <%pc = PageContentList.Where(p => p.KeyID == 12).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"宝宝护理":pc.Title %></span><label><%=pc==null?"BABY NURSED":pc.Remark %></label></div>
            <div class="introduct">
                <%strContents = pc.Description.Replace(" ", "&nbsp;").Replace("\r\n", " ").Replace("\r", " ").Replace("\n", " ").Split(' ');
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
                <%--成为爸妈的那一刻起，您便下定决心，要竭尽所有的关怀及爱来呵护宝宝。这也意味着您需要选择正确的照顾方式，让宝宝能健康快乐地成长。0-1岁的宝宝成长迅速，身体情况不同，也有自己的个性。宝宝在颂玺时，我们的专业医疗护理深入到每一天专家量身制定宝宝成长计划方案
                <div class="fuwu">每日体温测量、体重测量、脐部护理、口腔护理、臀部护理、宝宝洗澡、宝宝游泳、意外急救的预防和处理尿布疹、湿疹、红屁屁预防和护理宝宝情绪与哭闹安抚、宝宝良好生活作息的培养、儿科专家、营养师、早教专家指导。</div>--%>
            </div>
            <div class="zhimage">
                <ul>
                    <%pc = PageContentList.Where(p => p.KeyID == 23).FirstOrDefault(); %>
                    <%--大图建议尺寸：width:800px;height:380px;
                    小图建议尺寸： width:360px;height:380px;--%>
                    <li class="zbigimg">
                        <img src="<%=pc==null?"":pc.Title %>" onerror="this.src='/Image/h_16.jpg'" /></li>
                    <li class="zsmallimg">
                        <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_17.jpg'" /></li>
                    <li class="zsmallimg">
                        <img src="<%=pc==null?"":pc.Remark %>" onerror="this.src='/Image/h_18.jpg'" /></li>
                    <li class="zbigimg">
                        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_19.jpg'" /></li>
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div id="xrtn" class="xrtn">
            <%pc = PageContentList.Where(p => p.KeyID == 13).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"小儿推拿":pc.Title %></span><label><%=pc==null?"INFANTILE TUINA":pc.Remark %></label></div>
            <div class="introduct">
                <%strContents = pc.Description.Replace(" ", "&nbsp;").Replace("\r\n", " ").Replace("\r", " ").Replace("\n", " ").Split(' ');
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
                <%--我们的每一个服务都以宝宝健康为首要选择。小儿推拿属于中医推拿的一种，通过对宝宝的身体穴位进行推拿，从而达到治愈疾病、缓解不适、促进宝宝身体健康成长的目的。通过小儿急性疾病、慢性疾病调理，以及日常保健，让宝宝在出世的最初得到最温柔的呵护。--%>
            </div>
            <div class="zhimage">
                <ul>
                    <%pc = PageContentList.Where(p => p.KeyID == 24).FirstOrDefault(); %>
                    <%--大图建议尺寸：width:800px;height:380px;
                    小图建议尺寸： width:360px;height:380px;--%>
                    <li class="zbigimg">
                        <img src="<%=pc==null?"":pc.Title %>" onerror="this.src='/Image/h_16.jpg'" /></li>
                    <li class="zsmallimg">
                        <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_17.jpg'" /></li>
                    <li class="zsmallimg">
                        <img src="<%=pc==null?"":pc.Remark %>" onerror="this.src='/Image/h_18.jpg'" /></li>
                    <li class="zbigimg">
                        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_19.jpg'" /></li>
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div id="motherjs" class="motherjs">
            <%pc = PageContentList.Where(p => p.KeyID == 14).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"妈妈教室":pc.Title %></span><label><%=pc==null?"MOTHER CLASSROOM":pc.Remark %></label></div>
            <div class="introduct">
                <%strContents = pc.Description.Replace(" ", "&nbsp;").Replace("\r\n", " ").Replace("\r", " ").Replace("\n", " ").Split(' ');
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
                <%--提供最轻松舒适的房间，有特聘医师及各界专业讲师，安排各类课程与会谈，针对产后妈妈、满月妈妈在各阶段需求的卫教知识，提供各种咨询与指导，让妈咪在月子期满月后也能轻松获得新生儿照护和产后保健等知识。--%>
            </div>
            <div class="zhimage">
                <ul>
                    <%pc = PageContentList.Where(p => p.KeyID == 24).FirstOrDefault(); %>
                    <%--大图建议尺寸：width:800px;height:380px;
                    小图建议尺寸： width:360px;height:380px;--%>
                    <li class="zbigimg">
                        <img src="<%=pc==null?"":pc.Title %>" onerror="this.src='/Image/h_20.jpg'" /></li>
                    <li class="zsmallimg">
                        <img src="<%=pc==null?"":pc.Detail %>" onerror="this.src='/Image/h_21.jpg'" /></li>
                    <li class="zsmallimg">
                        <img src="<%=pc==null?"":pc.Remark %>" onerror="this.src='/Image/h_22.jpg'" /></li>
                    <li class="zbigimg">
                        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/h_23.jpg'" /></li>
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>
    </div>
</asp:Content>
