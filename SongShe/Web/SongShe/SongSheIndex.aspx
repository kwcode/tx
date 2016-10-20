<%@ Page Title="" Language="C#" MasterPageFile="~/SongShe/songshe.Master" AutoEventWireup="true" CodeBehind="SongSheIndex.aspx.cs" Inherits="Maticsoft.Web.SongShe.SongSheIndex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/CSS/SongSheIndex.css" rel="stylesheet" />
    <script src="/SongShe/JS/SongSheIndex.js"></script>
    <script src="/UserJs/jquery.dotdotdot.min.js"></script>
    <style>
    </style>
    <script type="text/javascript">
        $(function () {
            var width = $("#focus").width();
            if (width > 0) {
                $("#focus").height(width / 3);
                $("#focus li").height(width / 3);
                $("#focus a").height(width / 3);
                $("#focus img").height(width / 3);
            }
            //imgscorll
            if ($("#imgscorll a").length > 0)
                $($("#imgscorll a")[0]).click();
        });
        function ShowTeamInfo(obj) {
            //alert(obj);
            var Name = $(obj).attr("Name");
            var Position = $(obj).attr("Position");
            var Description = $(obj).attr("Description");
            var ImgUrl = $(obj).attr("ImgUrl");
            $("#imgTeam").attr("src", ImgUrl);
            $("#divTeamName").text(Name); Position
            $("#divTeamPosition").text(Position);
            $("#divTeamDescription").text(Description);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="focus">
        <ul>
            <li>
                <a href="/SongShe/SongSheBrand.aspx">
                    <%pc = PageContentList.Where(p => p.KeyID == 1).FirstOrDefault(); %>
                    <img src="<%=(pc==null)?"/Image/scorll_1.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_1.jpg'" /></a>
            </li>
            <li>
                <a href="/SongShe/InfantCare.aspx" style="">
                    <%pc = PageContentList.Where(p => p.KeyID == 2).FirstOrDefault(); %>
                    <img src="<%=(pc==null)?"/Image/scorll_2.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_2.jpg'" /></a>
            </li>
            <li>
                <a href="/SongShe/SongSheEnvironment.aspx">
                    <%pc = PageContentList.Where(p => p.KeyID == 3).FirstOrDefault(); %>
                    <img src="<%=(pc==null)?"/Image/scorll_3.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_3.jpg'" /></a>
            </li>
            <li>
                <a href="/SongShe/MonthOfMeals.aspx">
                    <%pc = PageContentList.Where(p => p.KeyID == 4).FirstOrDefault(); %>
                    <img src="<%=(pc==null)?"/Image/scorll_4.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_4.jpg'" /></a>
            </li>
            <li>
                <a href="/SongShe/NewsInfo.aspx">
                    <%pc = PageContentList.Where(p => p.KeyID == 5).FirstOrDefault(); %>
                    <img src="<%=(pc==null)?"/Image/scorll_5.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_5.jpg'" /></a>
            </li>
            <li>
                <a href="/SongShe/UserCenter.aspx">
                    <%pc = PageContentList.Where(p => p.KeyID == 6).FirstOrDefault(); %>
                    <img src="<%=(pc==null)?"/Image/scorll_6.jpg":pc.ImgUrl %>" onerror="this.src='/Image/scorll_6.jpg'" /></a>
            </li>
        </ul>
    </div>
    <div class="cline"></div>
    <div class="pagecontent">
        <div class="newscenter">
            <div class="title">新闻中心/<span>News center</span></div>
            <div class="line"></div>
            <div style="margin-top: 20px;">
                <div style="float: left;">
                    <div>
                        <% System.Data.DataRow dr = NewsList != null ? NewsList.Rows[0] : null; %>
                        <div class="newimg">
                            <%--新闻图建议尺寸 width:330px; height:215px;--%>
                            <img src="<%=dr!=null?dr["ImgUrl"]:"" %>" /><%--/Image/newsimg.jpg--%>
                        </div>
                        <div class="newsinfo">
                            <div class="newstitle" style="font-weight: 800; font-family: SimSun;"><a href="NewsDetail.aspx"><%=dr!=null?dr["Title"]:"" %></a></div>
                            <div class="newscontent" style="font-family: SimSun;"><a href="NewsDetail.aspx"><%=dr!=null?dr["Description"]:"" %></a></div>
                            <%--<div class="newstitle" style="font-weight:800;font-family:SimSun;"><a href="NewsDetail.aspx">重庆市渝北区卫纪委党委副书记倪桂华一行莅临</a></div>
                            <div class="newscontent" style="font-family:SimSun;"><a href="NewsDetail.aspx">9月9日，重庆市渝北区卫纪委党委副书记倪桂华等相关领导、渝北区妇幼保健院等区多家9月9日，重庆市渝北区卫纪委党委副书记倪桂华等相关领导、渝北区妇幼保健院等区多家9月9日，重庆市渝北区卫纪委党委副书记倪桂华等相关领导、渝北区妇幼保健院等区多家9月9日，重庆市渝北区卫纪委党委副书记倪桂华等相关领导、渝北区妇幼保健院等区多家9月9日，重庆市渝北区卫纪委党委副书记倪桂华等相关领导、渝北区妇幼保健院等区多家</a></div>--%>
                        </div>
                    </div>
                    <ul class="newslist">
                        <%for (int i = 1; i < (NewsList == null ? 0 : NewsList.Rows.Count); i++)
                          {%>
                        <li><a href="NewsDetail.aspx?nid=<%=NewsList.Rows[i]["KeyID"] %>">
                            <div class="news" style="font-family: SimSun;">[新闻中心]</div>
                            <div class="newtitle" style="font-family: SimSun;"><%=NewsList.Rows[i]["Title"] %></div>
                            <div class="newtime" style="font-family: SimSun;"><%=Maticsoft.Common.CommonHelper.ToDateTime( NewsList.Rows[i]["EditTime"]).ToString("yyyy-MM-dd") %></div>
                        </a></li>
                        <%} %>

                        <%--<li><a href="NewsDetail.aspx">
                            <div class="news" style="font-family:SimSun;">[新闻中心]</div>
                            <div class="newtitle" style="font-family:SimSun;">宠爱从第一次接触开始</div>
                            <div class="newtime" style="font-family:SimSun;">2016-09-07</div>
                        </a></li>
                        <li><a href="NewsDetail.aspx">
                            <div class="news" style="font-family:SimSun;">[新闻中心]</div>
                            <div class="newtitle" style="font-family:SimSun;">安琪儿“一站式孕产照护服务”产品发布会成功举办</div>
                            <span class="newtime" style="font-family:SimSun;">2016-09-05</span></a></li>
                        <li><a href="NewsDetail.aspx">
                            <div class="news" style="font-family:SimSun;">[新闻中心]</div>
                            <div class="newtitle" style="font-family:SimSun;">调研重庆安琪儿妇产医院，助推民营医院发展</div>
                            <span class="newtime" style="font-family:SimSun;">2016-09-05</span></a></li>--%>
                    </ul>
                </div>
                <div class="shipindiv">
                    <%--多种格式，浏览器会自动筛选，各种浏览器自动选择支持的一种格式--%>
                    <video controls>
                        <source src="movie.mp4" type="video/mp4" />
                        <source src="movie.ogg" type="video/ogg" />
                        <source src="movie.webm" type="video/webm" />
                        <object data="movie.mp4">
                            <embed src="movie.swf" />
                        </object>
                    </video>
                </div>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div class="myzh">
            <div class="title">母婴照护/<span>infant care</span></div>
            <div class="line"></div>
            <div class="muzhdiv">
                <ul>
                    <li>
                        <a href="/SongShe/InfantCare.aspx#motherzh">
                            <img src="/Image/mmzh.png" /></a>
                    </li>
                    <li>
                        <a href="/SongShe/InfantCare.aspx#babyhl">
                            <img src="/Image/bbzh.png" /></a>
                    </li>
                    <li>
                        <a href="/SongShe/MonthOfMeals.aspx#MonthOfMeals">
                            <img src="/Image/yzss.png" /></a>
                    </li>
                    <li>
                        <a href="/SongShe/InfantCare.aspx#xrtn">
                            <img src="/Image/xrtn.png" /></a>
                    </li>
                    <li>
                        <a href="/SongShe/InfantCare.aspx#motherzh">
                            <img src="/Image/chxf.png" /></a>
                    </li>
                    <li>
                        <a href="/SongShe/InfantCare.aspx#motherjs">
                            <img src="/Image/mmjs.png" /></a>
                    </li>
                    <li>
                        <a href="/SongShe/UserCenter.aspx#UserCenter">
                            <img src="/Image/hyzx.png" /></a>
                    </li>
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div class="zjtd">
            <div class="title">专家团队/<span>Medical team</span></div>
            <div class="line"></div>
            <div style="margin-top: 20px;">
                <div class="doctorimg">
                    <%--建议尺寸300*300--%>
                    <img id="imgTeam" src="/Image/doctor_1.jpg" />
                </div>
                <div class="doctors">
                    <div class="doctordescript">
                        <div class="name" id="divTeamName" style="font-family: SimSun;font-weight:900;">漆洪波</div>
                        <div class="zc" id="divTeamPosition" style="font-family: SimSun;font-weight:500;font-size:20px;">教授、医学博士、博士生导师</div>
                        <div style="border-bottom: 1px dashed #43BCC5;"></div>
                        <div class="introduct" id="divTeamDescription" style="font-family: SimSun;overflow:hidden;word-break: break-all;display: -webkit-box;-webkit-box-orient: vertical;overflow: hidden;-webkit-line-clamp: 3;height:75px;">重庆医科大学附属第一医院妇产科主任、重庆市高危妊娠诊治中心、重庆市产前诊断中心和重庆市胎儿医学中心主任，“中国-加拿大-新西兰联合母胎医学实验室”主任。</div>
                    </div>
                    <div class="docotrimgscorll">
                        <div class="leftbutton"></div>
                        <div id="imgscorll">
                            <ul>
                                <%foreach (System.Data.DataRow drt in TeamList.Rows)
                                  {%>
                                      <li><a onclick="ShowTeamInfo(this);" name="<%=drt["Name"] %>" ImgUrl="<%=drt["ImgUrl"] %>" Position="<%=drt["Position"] %>" Description="<%=drt["Description"].ToString().Replace(" ","&nbsp;") %>" >
                                    <img src="<%=drt["ImgUrl"] %>" /></a></li>
                                  <%} %>
                                <%--<li><a>
                                    <img src="/Image/doctor_2.jpg" /></a></li>
                                <li><a>
                                    <img src="/Image/doctor_1.jpg" /></a></li>
                                <li><a>
                                    <img src="/Image/doctor_2.jpg" /></a></li>
                                <li><a>
                                    <img src="/Image/doctor_1.jpg" /></a></li>
                                <li><a>
                                    <img src="/Image/doctor_2.jpg" /></a></li>
                                <li><a>
                                    <img src="/Image/doctor_1.jpg" /></a></li>
                                <li><a>
                                    <img src="/Image/doctor_2.jpg" /></a></li>--%>
                            </ul>
                        </div>
                        <div class="rightbutton"></div>
                    </div>
                </div>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div class="hjzs">
            <div class="title">环境展示/<span>Environment</span></div>
            <div class="line"></div>
            <div class="environmentshow">
                <ul>
                    <%--大图尺寸：376*200，小图尺寸：203*200--%>
                    <li class="hbigimg">
                        <%pc = PageContentList.Where(p => p.KeyID == 20).FirstOrDefault();
                          pc1 = PageContentList.Where(p => p.KeyID == 21).FirstOrDefault(); %>
                        <img src="<%=pc!=null?pc.Title:"" %>" onerror="this.src='/Image/h_1.jpg'" /></li>
                    <li class="hsmallimg">
                        <img src="<%=pc1!=null?pc1.Title:"" %>" onerror="this.src='/Image/h_2.jpg'" /></li>
                    <li class="hbigimg">
                        <img src="<%=pc!=null?pc.Detail:"" %>" onerror="this.src='/Image/h_3.jpg'" /></li>
                    <li class="hsmallimg">
                        <img src="<%=pc1!=null?pc1.Detail:"" %>" onerror="this.src='/Image/h_4.jpg'" /></li>
                    <li class="hsmallimg">
                        <img src="<%=pc!=null?pc.Remark:"" %>" onerror="this.src='/Image/h_5.jpg'" /></li>
                    <li class="hbigimg">
                        <img src="<%=pc1!=null?pc1.Remark:"" %>" onerror="this.src='/Image/h_6.jpg'" /></li>
                    <li class="hsmallimg">
                        <img src="<%=pc!=null?pc.ImgUrl:"" %>" onerror="this.src='/Image/h_7.jpg'" /></li>
                    <li class="hbigimg">
                        <img src="<%=pc1!=null?pc1.ImgUrl:"" %>" onerror="this.src='/Image/h_8.jpg'" /></li>
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>
    </div>
</asp:Content>
