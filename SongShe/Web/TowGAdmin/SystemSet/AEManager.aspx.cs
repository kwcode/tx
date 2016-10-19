using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin.SystemSet
{
    public partial class AEManager : BasePage.BasePage
    {
        protected Maticsoft.Model.Manager manager = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsSessionTimeOut())
                return;
            if (!IsPostBack)
            {
                int id = Maticsoft.Common.CommonHelper.Toint(Request["id"]);
                if (id > 0)
                    manager = new Maticsoft.BLL.Manager().GetModel(id);
                if (manager == null)
                    manager = new Maticsoft.Model.Manager();
            }
        }
    }
}