using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.SongShe
{
    public partial class NewsInfo : System.Web.UI.Page
    {
        public List<Model.PageContent> PageContentList = new List<Model.PageContent>();
        public Model.PageContent pc = new Model.PageContent();
        public DataTable News1List = new DataTable();
        public DataTable News2List = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            PageContentList = new BLL.PageContent().GetModelList(" KeyID in (5,18,19)");
            News1List = new BLL.News().GetList(3, "TypeID=1", "Sort desc,EditTime desc").Tables[0];
            News2List = new BLL.News().GetList(3, "TypeID=2", "Sort desc,EditTime desc").Tables[0];
        }
    }
}