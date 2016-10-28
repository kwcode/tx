using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Maticsoft.Web.TowGAdmin.Ajax
{
    /// <summary>
    /// TX_Handler 的摘要说明
    /// </summary>
    public class TX_Handler : IHttpHandler,System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string action = context.Request["action"];
            switch (action)
            {
                case "DeleteManager":
                    DeleteManager(context);//删除管理员
                    break;
                case "AEManager"://
                    AEManager(context);
                    break;
                case "AENews"://添加修改新闻
                    AENews(context);
                    break;
                case "DeleteNews"://删除新闻
                    DeleteNews(context);
                    break;
                case "AETeam"://添加修改团队信息
                    AETeam(context);
                    break;
                case "DeleteTeam"://删除团队信息
                    DeleteTeam(context);
                    break;
                case "AEMenu"://修改菜单栏信息
                    AEMenu(context);
                    break;
                case "AEPageIndex"://修改首页环境展示图
                    AEPageIndex(context);
                    break;
                case "DeleteMessageRecord"://删除留言信息
                    DeleteMessageRecord(context);
                    break;
                case "UpdateMessageRecordStatus"://更改留言信息状态为已处理
                    UpdateMessageRecordStatus(context);
                    break;
            }
        }
        /// <summary>
        /// 更改留言信息状态为已处理
        /// </summary>
        private void UpdateMessageRecordStatus(HttpContext context)
        {
            int MessageID = CommonHelper.Toint(context.Request["mid"]);
            if (MessageID > 0)
            {
                string strSql = "Update MessageRecord set Status=1 where KeyID=" + MessageID;
                DBUtility.DbHelperSQL.ExecuteSql(strSql);
            }
            context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "留言信息更改为已处理状态成功", navTabId: "MessageRecordList", rel: "MessageRecordList"));
            return;
        }
        /// <summary>
        /// 删除留言信息
        /// </summary>
        private void DeleteMessageRecord(HttpContext context)
        {
            int MessageID = CommonHelper.Toint(context.Request["mid"]);
            if (MessageID > 0)
            {
                new BLL.MessageRecord().Delete(MessageID);
            }
            context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "留言信息删除成功", navTabId: "MessageRecordList", rel: "MessageRecordList"));
            return;
        }
        /// <summary>
        /// 修改首页环境展示图
        /// </summary>
        private void AEPageIndex(HttpContext context)
        {
            string ImgUrl11 = context.Request["ImgUrl11"];
            string ImgUrl21 = context.Request["ImgUrl21"];
            string ImgUrl31 = context.Request["ImgUrl31"];
            string ImgUrl41 = context.Request["ImgUrl41"];
            string ImgUrl12 = context.Request["ImgUrl12"];
            string ImgUrl22 = context.Request["ImgUrl22"];
            string ImgUrl32 = context.Request["ImgUrl32"];
            string ImgUrl42 = context.Request["ImgUrl42"];
            Model.PageContent pc1 = new BLL.PageContent().GetModel(20);
            Model.PageContent pc2 = new BLL.PageContent().GetModel(21);
            if (pc1 != null)
            {
                pc1.Title = ImgUrl11;
                pc1.Detail = ImgUrl21;
                pc1.Remark = ImgUrl32;
                pc1.ImgUrl = ImgUrl42;
                new BLL.PageContent().Update(pc1);
            }
            if (pc2 != null)
            {
                pc2.Title = ImgUrl12;
                pc2.Detail = ImgUrl22;
                pc2.Remark = ImgUrl31;
                pc2.ImgUrl = ImgUrl41;
                new BLL.PageContent().Update(pc2);
            }
            context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "首页环境展示图修改成功", navTabId: "PageIndex", rel: "PageIndex"));
            return;
        }
        /// <summary>
        /// 修改菜单栏信息
        /// </summary>
        private void AEMenu(HttpContext context)
        {
            int PageContentID = CommonHelper.Toint(context.Request["pid"]);
            Model.PageContent pc = new BLL.PageContent().GetModel(PageContentID);
            if (pc == null)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "菜单栏信息不存在"));
                return;
            }
            pc.Title = context.Request["Title"];
            if (pc.Title.Length > 100)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "标题不能超过100字"));
                return;
            }
            pc.Detail = context.Request["Detail"];
            if (pc.Detail.Length > 100)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "英文名不能超过100字"));
                return;
            }
            pc.Remark = context.Request["Remark"];
            if (pc.Remark.Length > 100)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "页面一句话不能超过100字"));
                return;
            }
            pc.ImgUrl = context.Request["ImgUrl"];
            if (string.IsNullOrWhiteSpace(pc.ImgUrl))
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "请上传轮播展示图片"));
                return;
            }
            if (pc.ImgUrl.Length > 200)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "轮播展示图片超过最大长度限制"));
                return;
            }
            new BLL.PageContent().Update(pc);
            context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "轮播展示图片修改成功", navTabId: "MenuList", rel: "MenuList", callbackType: "closeCurrent"));
            return;
        }
        /// <summary>
        /// 删除团队信息
        /// </summary>
        private void DeleteTeam(HttpContext context)
        {
            try
            {
                int TeamID = CommonHelper.Toint(context.Request["tid"]);
                if (TeamID > 0)
                {
                    new BLL.Team().Delete(TeamID);
                }
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "团队信息删除成功", navTabId: "TeamList", rel: "TeamList"));
                return;
            }
            catch (Exception err)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "团队信息删除失败，失败原因：" + err.Message));
                return;
            }
        }
        /// <summary>
        /// 添加修改团队信息
        /// </summary>
        private void AETeam(HttpContext context)
        {
            try
            {
                int ManagerID = CommonHelper.Toint(context.Session[Keys.ManagerID]);//当前管理员ID
                int TeamID = CommonHelper.Toint(context.Request["tid"]);
                Model.Team Team = null;
                if (TeamID > 0)
                    Team = new BLL.Team().GetModel(TeamID);
                if (TeamID > 0 && Team == null)
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "准备修改的团队信息不存在，请重试"));
                    return;
                }
                string Name = context.Request["Name"];
                if (string.IsNullOrWhiteSpace(Name))
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "姓名不能为空，请输入"));
                    return;
                }
                if (Name.Length > 10)
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "姓名不能超过10字，请重新输入"));
                    return;
                }
                string Position = context.Request["Position"];
                if (string.IsNullOrWhiteSpace(Position))
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "职位不能为空，请输入"));
                    return;
                }
                if (Position.Length > 40)
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "职位不能超过40字，请重新输入"));
                    return;
                }
                string Description = context.Request["Description"];
                if (string.IsNullOrWhiteSpace(Description))
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "简介不能为空，请输入"));
                    return;
                }
                if (Description.Length > 200)
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "简介不能超过200字，请重新输入"));
                    return;
                }
                string ImgUrl = context.Request["ImgUrl"];
                if (string.IsNullOrWhiteSpace(ImgUrl))
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "头像必须上传，请上传"));
                    return;
                }
                int IsShow = 1;
                if (int.TryParse(context.Request["IsShow"], out IsShow) || (IsShow != 0 && IsShow != 1))
                {
                    IsShow = 1;
                }
                int Sort = CommonHelper.Toint(context.Request["Sort"]);

                if (Team == null)
                    Team = new Model.Team();
                Team.Name = Name;
                Team.Position = Position;
                Team.Description = Description;
                Team.ImgUrl = ImgUrl;
                Team.Status = IsShow;
                Team.Sort = Sort;
                if (Team.KeyID <= 0)
                {
                    Team.AddTime = DateTime.Now;
                    Team.KeyID = new BLL.Team().Add(Team);
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "团队信息添加成功", navTabId: "TeamList", rel: "TeamList"));
                    return;
                }
                else
                {
                    new BLL.Team().Update(Team);
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "团队信息修改成功", navTabId: "TeamList", rel: "TeamList"));
                    return;
                }
            }
            catch (Exception err)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "团队信息保存失败，失败原因:" + err.Message));
                return;
            }
        }
        /// <summary>
        /// 删除新闻
        /// </summary>
        private void DeleteNews(HttpContext context)
        {
            try
            {
                int NewsID = CommonHelper.Toint(context.Request["nid"]);
                if (NewsID > 0)
                {
                    new BLL.News().Delete(NewsID);
                }
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "新闻信息删除成功", navTabId: "NewsList", rel: "NewsList"));
                return;
            }
            catch (Exception err)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "新闻信息删除失败，失败原因："+err.Message));
                return;
            }
        }
        /// <summary>
        /// 添加修改新闻
        /// </summary>
        private void AENews(HttpContext context)
        {
            try
            {
                int ManagerID = CommonHelper.Toint(context.Session[Keys.ManagerID]);//当前管理员ID
                int NewsID = CommonHelper.Toint(context.Request["nid"]);
                Model.News News = null;
                if (NewsID > 0)
                    News = new BLL.News().GetModel(NewsID);
                if (NewsID > 0 && News == null)
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "准备修改的新闻不存在，请重试"));
                    return;
                }
                string Title = context.Request["Title"];
                if (string.IsNullOrWhiteSpace(Title))
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "新闻标题不能为空，请输入"));
                    return;
                }
                if (Title.Length > 100)
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "新闻标题不能超过100字，请重新输入"));
                    return;
                }
                string Source = context.Request["Source"];
                if (string.IsNullOrWhiteSpace(Source))
                    Source = "";
                if (Source.Length > 20 && Source != "")
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "新闻来源不能超过20字，请重新输入"));
                    return;
                }
                int NewsType = CommonHelper.Toint(context.Request["NewsType"]);
                if (NewsType != 1 && NewsType != 2)
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "请选择正确的新闻类型"));
                    return;
                }
                string ImgUrl = context.Request["ImgUrl"];
                int IsShow = 1;
                if (int.TryParse(context.Request["IsShow"], out IsShow) || (IsShow != 0 && IsShow != 1))
                {
                    IsShow = 1;
                }
                int Sort = CommonHelper.Toint(context.Request["Sort"]);
                string Detail = context.Request["Detail"];

                if (News == null)
                    News = new Model.News();
                News.Title = Title;
                News.Source = Source;
                News.TypeID = NewsType;
                if (News.TypeID == 1)
                    News.TypeName = "最新资讯";
                else if (News.TypeID == 2)
                    News.TypeName = "权威发布";
                News.ImgUrl = ImgUrl;
                News.Status = IsShow;
                News.Detail = Detail;
                News.Sort = Sort;
                if (News.KeyID <= 0)
                {
                    News.AddTime = DateTime.Now;
                    News.EditTime = News.AddTime;
                    News.KeyID = new BLL.News().Add(News);
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "新闻信息添加成功", navTabId: "NewsList", rel: "NewsList"));
                    return;
                }
                else
                {
                    News.EditTime = DateTime.Now;
                    new BLL.News().Update(News);
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "新闻信息修改成功", navTabId: "NewsList", rel: "NewsList"));
                    return;
                }
            }
            catch (Exception err)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "新闻信息保存失败，失败原因:"+err.Message));
                return;
            }
            
        }
        /// <summary>
        /// 修改管理员信息
        /// </summary>
        private void AEManager(HttpContext context)
        {
            int ManagerID = CommonHelper.Toint(context.Request["id"]);
            Model.Manager Manager = null;
            if (ManagerID > 0)
                Manager = new BLL.Manager().GetModel(ManagerID);
            if (ManagerID > 0 && Manager == null)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "管理员不存在，请重试"));
                return;
            }
            string ManagerName = context.Request["ManagerName"];
            if (string.IsNullOrWhiteSpace(ManagerName))
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "请填写管理员账号"));
                return;
            }
            if (ManagerName.Length > 20)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "管理员账号不能超过20个字符，请重新输入"));
                return;
            }
            string Phone = context.Request["Phone"];
            if (!string.IsNullOrWhiteSpace(Phone))
            {
                if (Phone.Length != 11 || (!CommonHelper.IsNumber(Phone)))
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "联系方式输入不正确，请重新输入11位电话"));
                    return;
                }
            }
            string Password = context.Request["Password"];
            if (string.IsNullOrWhiteSpace(Password) && ManagerID <= 0)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "请填写管理员密码"));
                return;
            }
            if (!string.IsNullOrWhiteSpace(Password))
            {
                if (Password.Length < 6)
                {
                    context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "密码强度不够，请输入六位数以上的密码"));
                    return;
                }
            }
            int IsExist = CommonHelper.Toint(DBUtility.DbHelperSQL.GetSingle("select count(1) from Manager where ManagerName='" + ManagerName + "' and KeyID<>" + Manager.KeyID.ToString()));
            if (IsExist > 0)
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "管理员账号已存在，请重新输入"));
                return;
            }
            Manager.ManagerName = ManagerName;
            Manager.Phone = Phone;
            if (!string.IsNullOrWhiteSpace(Password))
                Manager.Password = CommonHelper.jiammi(Password);
            if (new BLL.Manager().Update(Manager))
            {
                context.Response.Write(CommonHelper.GetDwzAjaxJsonData("200", "管理员信息修改成功", navTabId: "ManagerList", rel: "ManagerList"));
                return;
            }
            context.Response.Write(CommonHelper.GetDwzAjaxJsonData("300", "管理员信息修改失败"));
            return;

        }
        /// <summary>
        /// 删除管理员
        /// </summary>
        private void DeleteManager(HttpContext context)
        {
            int ManagerID = CommonHelper.Toint(context.Request["id"]);
            if (ManagerID > 0)
            {
                new BLL.Manager().Delete(ManagerID);
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}