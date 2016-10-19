using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.SongShe
{
    public partial class SongSheIndex : System.Web.UI.Page
    {
        public List<Model.PageContent> PageContentList = new List<Model.PageContent>();
        public Model.PageContent pc = new Model.PageContent();
        public Model.PageContent pc1 = new Model.PageContent();
        protected void Page_Load(object sender, EventArgs e)
        {
            PageContentList = new BLL.PageContent().GetModelList("(KeyID>=1 and KeyID<=6) or (PageID=0 and GroupID=2)");
        }
    }
}