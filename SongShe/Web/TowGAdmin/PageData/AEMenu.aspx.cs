using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin.PageData
{
    public partial class AEMenu : BasePage.BasePage
    {
        public Model.PageContent Menus = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsSessionTimeOut())
                return;
            int MenuID = Common.CommonHelper.Toint(Request["pid"]);
            if (MenuID > 0)
                Menus = new BLL.PageContent().GetModel(MenuID);

        }
    }
}