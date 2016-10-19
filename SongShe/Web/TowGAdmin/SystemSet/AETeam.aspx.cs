using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin.SystemSet
{
    public partial class AETeam : BasePage.BasePage
    {
        public Model.Team Team = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsSessionTimeOut())
                return;
            int TeamID = Common.CommonHelper.Toint(Request["tid"]);
            if (TeamID > 0)
                Team = new BLL.Team().GetModel(TeamID);

        }
    }
}