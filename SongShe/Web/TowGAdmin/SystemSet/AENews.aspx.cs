using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin.SystemSet
{
    public partial class AENews : BasePage.BasePage
    {
        public Model.News News = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsSessionTimeOut())
                return;
            int NewsID = Common.CommonHelper.Toint(Request["nid"]);
            if (NewsID > 0)
                News = new BLL.News().GetModel(NewsID);
            
        }
    }
}