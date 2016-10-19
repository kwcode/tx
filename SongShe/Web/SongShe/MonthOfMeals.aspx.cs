using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.SongShe
{
    public partial class MonthOfMeals : System.Web.UI.Page
    {
        public List<Model.PageContent> PageContentList = new List<Model.PageContent>();
        public Model.PageContent pc = new Model.PageContent();
        protected void Page_Load(object sender, EventArgs e)
        {
            PageContentList = new BLL.PageContent().GetModelList(" KeyID in (4,33) or PageID=4");
        }
    }
}