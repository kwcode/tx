<%@ Page Title="" Language="C#" MasterPageFile="~/SongShe/songshe.Master" AutoEventWireup="true" CodeBehind="SongSheBrand.aspx.cs" Inherits="Maticsoft.Web.SongShe.SongSheBrand" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/CSS/SongSheBrand.css" rel="stylesheet" />
    <script>
        $(function () {
            $(".nav li.linav").eq(0).find(".parentnav").addClass("currenta");


        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bigimg">
        <%pc = PageContentList.Where(p => p.KeyID == 1).FirstOrDefault(); %>
        <img src="<%=pc==null?"":pc.ImgUrl %>" onerror="this.src='/Image/scorll_1.jpg'" />
        <div class="bigimgtext" <%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"style='display:none;'":"" %>><%=(pc==null||string.IsNullOrWhiteSpace(pc.Remark))?"":pc.Remark %> </div>
    </div>
    <div class="pagecontent">
        <div id="brandintroduct" class="brandintroduct">
            <%pc = PageContentList.Where(p => p.KeyID == 7).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"品牌介绍":pc.Title %></span><label><%=pc==null?"BRAND INTRODCUTION":pc.Remark %></label></div>
            <div class="introduct">
                <%=pc==null?"重庆颂玺母婴照护中心由重庆力杨实业（集团）投资，与台湾母婴照护知名连锁品牌机构合作共同打造的两岸跨界健康服务产业项目，具备中国妇产科最专业权威的医学团队资源、专业技术技能与硬件设备，是重庆市唯一拥有母婴产后四大照护体系的中心会所，我们秉持建立荣耀在您、信任与我、喜悦共享、追求创新、医学人文关怀一体的全方位母婴照护体系。我们提供围产期妈妈完整的产前、生产、产后三个时期的人性化的专业照护服务，营造亲子共享优质的修养环境。满足妈妈及家庭成员的生理和心理需要，让家庭成员的共同参与，促进产妇到母亲的角色转换。":pc.Description %>
            </div>
            <div class="introductimg">
                <%=pc==null?"<img src='/Image/h_9.jpg' />":"<img src='"+pc.ImgUrl+"' onerror=\"this.src='/Image/h_9.jpg'\" />" %>
                <%--<img src="/Image/h_9.jpg" onerror="this.src='/Image/h_9.jpg'" />--%>
            </div>
        </div>
        <div id="doctorteam" class="doctorteam">
            <%pc = PageContentList.Where(p => p.KeyID == 8).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"医疗团队":pc.Title %></span><label><%=pc==null?"MEDICAL TEAM":pc.Remark %></label></div>
            <div class="introduct">
                <%=pc==null?"拥有重庆市三甲医院强大的医疗团队支持，以及融入现代医学、心理学、营养学、产科及新生儿科护理学等综合学科的知识，引进台湾专业的医学母婴照护模式管理，让每位妈妈及宝宝都能获得最优质的照顾及服务":pc.Description %>
            </div>
            <div class="doctorlist">
                <ul>
                    <%foreach (System.Data.DataRow dr in TeamList.Rows)
                      {%>
                    <li>
                        <div class="doctorimg">
                            <img src="<%=dr["ImgUrl"] %>" /></div>
                        <div class="doctorinfo">
                            <div class="name"><%=dr["Name"] %></div>
                            <div class="job" style="font-size:20px;"><%=dr["Position"] %></div>
                            <div class="descript"><%=dr["Description"].ToString().Replace(" ","&nbsp;") %></div>
                        </div>
                    </li>
                    <%} %>
                    <%--<li>
                        <div class="doctorimg">
                            <img src="/Image/doctor_1.jpg" /></div>
                        <div class="doctorinfo">
                            <div class="name">漆洪波</div>
                            <div class="job">教授、医学博士、博士生导师</div>
                            <div class="descript">重庆医科大学附属第一医院妇产科主任、重庆市高危妊娠诊治中心、重庆市产前诊断中心和重庆市胎儿医学中心主任，“中国-加拿大-新西兰联合母胎医学实验室”主任。</div>
                        </div>
                    </li>
                    <li>
                        <div class="doctorimg">
                            <img src="/Image/doctor_2.jpg" /></div>
                        <div class="doctorinfo">
                            <div class="name">漆洪波</div>
                            <div class="job">教授、医学博士、博士生导师</div>
                            <div class="descript">重庆医科大学附属第一医院妇产科主任、重庆市高危妊娠诊治中心、重庆市产前诊断中心和重庆市胎儿医学中心主任，“中国-加拿大-新西兰联合母胎医学实验室”主任。</div>
                        </div>
                    </li>
                    <li>
                        <div class="doctorimg">
                            <img src="/Image/doctor_2.jpg" /></div>
                        <div class="doctorinfo">
                            <div class="name">漆洪波</div>
                            <div class="job">教授、医学博士、博士生导师</div>
                            <div class="descript">重庆医科大学附属第一医院妇产科主任、重庆市高危妊娠诊治中心、重庆市产前诊断中心和重庆市胎儿医学中心主任，“中国-加拿大-新西兰联合母胎医学实验室”主任。</div>
                        </div>
                    </li>
                    <li>
                        <div class="doctorimg">
                            <img src="/Image/doctor_1.jpg" /></div>
                        <div class="doctorinfo">
                            <div class="name">漆洪波</div>
                            <div class="job">教授、医学博士、博士生导师</div>
                            <div class="descript">重庆医科大学附属第一医院妇产科主任、重庆市高危妊娠诊治中心、重庆市产前诊断中心和重庆市胎儿医学中心主任，“中国-加拿大-新西兰联合母胎医学实验室”主任。</div>
                        </div>
                    </li>--%>
                </ul>
            </div>
            <div class="introductimg">
                <%=pc==null?"<img src='/Image/h_10.jpg' />":"<img src='"+pc.ImgUrl+"' onerror=\"this.src='/Image/h_10.jpg'\" />" %>
                <%--<img src="/Image/h_10.jpg" />--%>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div id="serviceteam" class="serviceteam">
            <%pc = PageContentList.Where(p => p.KeyID == 9).FirstOrDefault(); %>
            <div class="title"><span><%=pc==null?"服务团队":pc.Title %></span><label><%=pc==null?"SERVICE TEAM":pc.Remark %></label></div>
            <div class="introductimg">
                <%=pc==null?"<img src='/Image/h_11.jpg' />":"<img src='"+pc.ImgUrl+"' onerror=\"this.src='/Image/h_11.jpg'\" />" %>
                <%--<img src="/Image/h_11.jpg" />--%>
            </div>
        </div>
    </div>
</asp:Content>
