using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin
{
    public partial class HomeIndex : BasePage.BasePage
    {
        protected StringBuilder sb = new StringBuilder();
        public Model.Manager manager;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsSessionTimeOut())
                return;
            manager = Session[Keys.ManagerInfo] as Maticsoft.Model.Manager;
            

        }
    }
}