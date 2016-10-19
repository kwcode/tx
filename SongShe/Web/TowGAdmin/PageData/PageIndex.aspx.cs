using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin.PageData
{
    public partial class PageIndex : System.Web.UI.Page
    {
        public Model.PageContent pc1 = new Model.PageContent();
        public Model.PageContent pc2 = new Model.PageContent();
        protected void Page_Load(object sender, EventArgs e)
        {
            pc1 = new BLL.PageContent().GetModel(20);
            if (pc1 == null)
                pc1 = new Model.PageContent();
            pc2 = new BLL.PageContent().GetModel(21);
            if (pc2 == null)
                pc2 = new Model.PageContent();
        }
    }
}