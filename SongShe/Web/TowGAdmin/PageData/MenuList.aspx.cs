using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin.PageData
{
    public partial class MenuList : BasePage.BasePage
    {
        public BasePage.BasePage.DwzPageParam page = null;
        public DataTable dt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (page == null)
                page = new DwzPageParam(Context);
            if (IsSessionTimeOut())
                return;
            GetDataCount(Context);
            GetData(Context);
        }
        /// <summary>
        /// 获取条数
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private void GetDataCount(HttpContext context)
        {
            int count = new Maticsoft.BLL.PageContent().GetRecordCount("KeyID in (1,2,3,4,5,6)");
            if (page == null)
                page = new DwzPageParam(Context);
            page.totalCount = count;
        }
        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <param name="context"></param>
        private void GetData(HttpContext context)
        {
            int count = new Maticsoft.BLL.PageContent().GetRecordCount("");
            if (page == null)
            {
                page = new DwzPageParam(Context);
                page.totalCount = count;
            }
            dt = new Maticsoft.BLL.PageContent().GetListByPage("KeyID in (1,2,3,4,5,6)", "KeyID desc", (page.pageNum - 1) * page.numPerPage + 1, page.pageNum * page.numPerPage).Tables[0];
        }
    }
}