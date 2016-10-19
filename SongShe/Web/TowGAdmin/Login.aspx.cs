using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Maticsoft.Web.TowGAdmin
{
    public partial class Login : BasePage.BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            BLL.Manager bll = new BLL.Manager();
            string ManagerName = txtName.Value;
            string loginPass = txtPwd.Value;
            string yzm = txtYzm.Value;
            if (!string.IsNullOrWhiteSpace(ManagerName) && !string.IsNullOrWhiteSpace(loginPass) && !string.IsNullOrWhiteSpace(yzm))
            {
                //判断验证码              
                if (yzm.ToLower() != Request.Cookies[Keys.LoginCode].Value.ToLower())
                {
                    ClientScript.RegisterStartupScript(typeof(Login), "msgShow", "<script type=\"text/javascript\">alert('验证码输入错误');</script>");
                    return;
                }
                Model.Manager Manager = bll.GetModelList("ManagerName='"+ManagerName+"'").FirstOrDefault();
                if (Manager != null&&Manager.KeyID>0)
                {
                    if (Manager.Password == Maticsoft.Common.CommonHelper.jiammi(loginPass))
                    {
                        //登录成功
                        Session[Keys.ManagerID] = Manager.KeyID;
                        Session[Keys.ManagerInfo] = Manager;
                        Common.CommonHelper.SetCookie(Keys.ManagerID, Manager.KeyID.ToString(), new TimeSpan(1, 0, 0, 0));
                        
                        ClientScript.RegisterStartupScript(typeof(Login), "msgShow", "<script type=\"text/javascript\">alert('登录成功');window.location.href='/TowGAdmin/HomeIndex.aspx';</script>");
                    }
                    else
                        ClientScript.RegisterStartupScript(typeof(Login), "msgShow", "<script type=\"text/javascript\">alert('密码错误');</script>");
                }
                else
                    ClientScript.RegisterStartupScript(typeof(Login), "msgShow", "<script type=\"text/javascript\">alert('用户名不存在');</script>");
            }
            else
                ClientScript.RegisterStartupScript(typeof(Login), "msgShow", "<script type=\"text/javascript\">alert('请填写完整的登录信息');</script>");
        }
    }
}