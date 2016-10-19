using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Maticsoft.Common;
using Maticsoft.Model;
using Maticsoft.BLL;

namespace Maticsoft.BasePage
{
    public abstract class BasePage : System.Web.UI.Page
    {
        public int ManagerID { get { if ((Session[Keys.ManagerID]) != null) return CommonHelper.Toint(Session[Keys.ManagerID]); else return 0; } }
        public Model.Manager ManagerInfo { get { if (((Model.Manager)Session[Keys.ManagerInfo]) != null) return ((Model.Manager)Session[Keys.ManagerInfo]); else return null; } }

        public class DwzPageParam
        {
            public DwzPageParam(HttpContext context)
            {
                numPerPage = CommonHelper.Toint(context.Request.Form["numPerPage"]) == 0 ? 20 : CommonHelper.Toint(context.Request.Form["numPerPage"]);
                pageNumShown = CommonHelper.Toint(context.Request.Form["pageNumShown"]) == 0 ? 5 : CommonHelper.Toint(context.Request.Form["pageNumShown"]);
                pageNum = CommonHelper.Toint(context.Request.Form["pageNum"]) == 0 ? 1 : CommonHelper.Toint(context.Request.Form["pageNum"]);
                totalCount = 0;
                keywords = context.Request.Form["keywords"];
                orderField = context.Request.Form["orderField"];
            }
            #region 分页变量，与UI绑定
            /// <summary>
            /// 每页显示的条数
            /// </summary>
            public int numPerPage { get; set; }

            /// <summary>
            /// 页数导航的个数
            /// </summary>            
            public int pageNumShown { get; set; }

            /// <summary>
            /// 当前显示的页数
            /// </summary>
            public int pageNum { get; set; }

            /// <summary>
            /// 总条数
            /// </summary>
            public int totalCount { get; set; }

            /// <summary>
            /// where语句，不加where与空格
            /// </summary>
            public string keywords { get; set; }

            /// <summary>
            /// 排序关键字
            /// </summary>
            public string orderField { get; set; }
            #endregion
        }

        /// <summary>
        /// 判断登陆session是否超时丢失的操作，超时则返回登陆界面
        /// </summary>
        /// <returns>true 已丢失 false 未丢失</returns>
        public bool IsSessionTimeOut()
        {
            if (ManagerID <= 0)
            {
                int mid =CommonHelper.Toint( CommonHelper.GetCookie(Keys.ManagerID));
                if (mid > 0)
                    Session[Keys.ManagerID] = mid;
            }
            if (ManagerInfo == null && ManagerID > 0)
                Session[Keys.ManagerInfo] = new BLL.Manager().GetModel(ManagerID);
            if (ManagerID > 0&&ManagerInfo!=null)
                return false;

            Session[Keys.ManagerInfo] = null;
            Session[Keys.ManagerID] = null;
            System.Text.StringBuilder strHtml = new System.Text.StringBuilder();
            strHtml.Append("<script type='text/javascript'>");
            strHtml.Append("alert('您的登陆信息丢失，请重新登陆！');");
            strHtml.Append("window.top.location.href='/TowGAdmin/Login.aspx';");
            strHtml.Append("</script>");
            ClientScript.RegisterClientScriptBlock(GetType(), "close", strHtml.ToString());
            return true;
        }
    }
}