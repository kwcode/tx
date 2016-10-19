using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin.SystemSet
{
    public partial class ManagerList : BasePage.BasePage
    {
        public BasePage.BasePage.DwzPageParam page = null;
        public DataTable dt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (page == null)
                page = new DwzPageParam(Context);
            if (IsSessionTimeOut())
                return;
            GetManagerCount(Context);
            GetManager(Context);
        }

        /// <summary>
        /// 获取条数
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private void GetManagerCount(HttpContext context)
        {
            int count = new Maticsoft.BLL.Manager().GetRecordCount("");
            if (page == null)
                page = new DwzPageParam(Context);
            page.totalCount = count;
        }
        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <param name="context"></param>
        private void GetManager(HttpContext context)
        {
            int count = new Maticsoft.BLL.Manager().GetRecordCount("");
            if (page == null)
            {
                page = new DwzPageParam(Context);
                page.totalCount = count;
            }
            dt = new Maticsoft.BLL.Manager().GetListByPage("","KeyID desc",(page.pageNum - 1) * page.numPerPage + 1, page.pageNum * page.numPerPage).Tables[0];
        }
    }
}