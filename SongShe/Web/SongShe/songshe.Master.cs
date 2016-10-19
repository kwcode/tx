using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.SongShe
{
    public partial class songshe : System.Web.UI.MasterPage
    {
        public List<Model.PageContent> PageContentList = new List<Model.PageContent>();
        public Maticsoft.Model.PageContent pc = new Maticsoft.Model.PageContent();
        protected void Page_Load(object sender, EventArgs e)
        {
            PageContentList = new BLL.PageContent().GetModelList("");
        }
    }
}