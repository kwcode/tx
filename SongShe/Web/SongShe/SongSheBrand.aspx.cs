using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.SongShe
{
    public partial class SongSheBrand : System.Web.UI.Page
    {
        public List<Model.PageContent> PageContentList = new List<Model.PageContent>();
        public Model.PageContent pc = new Model.PageContent();
        protected void Page_Load(object sender, EventArgs e)
        {
            PageContentList = new BLL.PageContent().GetModelList("(KeyID>=7 and KeyID<=10) or KeyID in (1)");
        }
    }
}