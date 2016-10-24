using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.MobileSongShe
{
    public partial class NewsDetail : System.Web.UI.Page
    {
        public List<Model.PageContent> PageContentList = new List<Model.PageContent>();
        public Model.PageContent pc = new Model.PageContent();
        public DataTable NewsInfo = new DataTable();
        public DataTable BeforeNewsInfo = new DataTable();
        public DataTable AfterNewsInfo = new DataTable();
        public int NewsID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            PageContentList = new BLL.PageContent().GetModelList(" KeyID in (5)");
            NewsID = Common.CommonHelper.Toint(Request["nid"]);
            DataSet ds = DBUtility.DbHelperSQL.Query("select * from news where keyid=@NewsID;select top 1 * from news where keyid>@NewsID order by KeyID asc;select top 1 * from news where keyid<@NewsID order by KeyID desc", new System.Data.SqlClient.SqlParameter("@NewsID", NewsID));
            NewsInfo = ds.Tables[0];
            BeforeNewsInfo = ds.Tables[1];
            AfterNewsInfo = ds.Tables[2];
            if (NewsInfo.Rows.Count <= 0)
                Response.Redirect("/SongShe/NewsInfo.aspx");
        }
    }
}