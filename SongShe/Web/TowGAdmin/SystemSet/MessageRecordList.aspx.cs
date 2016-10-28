using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin.SystemSet
{
    public partial class MessageRecordList : BasePage.BasePage
    {
        public BasePage.BasePage.DwzPageParam page = null;
        public DataTable dt = null;
        public int Status = 0;//-1全部 0未处理 1已处理
        public string GroupName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (page == null)
                page = new DwzPageParam(Context);
            if (IsSessionTimeOut())
                return;
            int.TryParse(Request["Status"], out Status);
            GroupName = Request["GroupName"];
            if (string.IsNullOrWhiteSpace(GroupName))
                GroupName = "";
            GetMessageRecordCount(Context);
            GetMessageRecord(Context);
        }
        /// <summary>
        /// 获取条数
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private void GetMessageRecordCount(HttpContext context)
        {
            string strWhere = "1>0";
            if (Status == 0)
                strWhere += " and Status=0";
            else if (Status == 1)
                strWhere += " and Status=1";
            if (GroupName != "")
                strWhere += " and GroupName='" + GroupName + "'";
            int count = new Maticsoft.BLL.MessageRecord().GetRecordCount(strWhere);
            if (page == null)
                page = new DwzPageParam(Context);
            page.totalCount = count;
        }
        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <param name="context"></param>
        private void GetMessageRecord(HttpContext context)
        {
            string strWhere = "1>0";
            if (Status == 0)
                strWhere += " and Status=0";
            else if (Status == 1)
                strWhere += " and Status=1";
            if (GroupName != "")
                strWhere += " and GroupName='" + GroupName + "'";
            int count = new Maticsoft.BLL.MessageRecord().GetRecordCount(strWhere);
            if (page == null)
            {
                page = new DwzPageParam(Context);
                page.totalCount = count;
            }
            dt = new Maticsoft.BLL.MessageRecord().GetListByPage(strWhere, "AddTime desc", (page.pageNum - 1) * page.numPerPage + 1, page.pageNum * page.numPerPage).Tables[0];
        }
        public Dictionary<string, string> dGroupName = new Dictionary<string, string>{
            {"yycg","预约参观"},
            {"tsjy","投诉及建议"}
        };
        public Dictionary<int, string> StatusName = new Dictionary<int, string>{
            {0,"未处理"},
            {1,"已处理"}
        };
    }
}