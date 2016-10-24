using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.MobileSongShe
{
    public partial class Index : System.Web.UI.Page
    {
        public List<Model.PageContent> PageContentList = new List<Model.PageContent>();
        public Model.PageContent pc = new Model.PageContent();
        public Model.PageContent pc1 = new Model.PageContent();
        public DataTable NewsList = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            PageContentList = new BLL.PageContent().GetModelList("(KeyID>=1 and KeyID<=6) or (PageID=0 and GroupID=2)");
            NewsList = new BLL.News().GetListByPage("TypeID=1", "Sort desc,EditTime desc", 1, 4).Tables[0];
            if (NewsList != null && NewsList.Rows.Count <= 0)
            {
                NewsList = null;
            }
        }
    }
}