using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;

namespace Maticsoft.Common
{
    public class Keys
    {
        /// <summary>
        /// 商户ID
        /// </summary>
        public const int MerchantID = 1;

        /// <summary>
        /// Cookie中连接Session的ID
        /// </summary>
        public const string SessionID = "ASP.NET_SessionId";
        /// <summary>
        /// 保存全网通用的SessionID
        /// </summary>
        public const string SaveSessionID = "SaveID";
        /// <summary>
        /// 登录验证码
        /// </summary>
        public const string LoginCode = "LoginCode";
        /// <summary>
        /// 管理员ID
        /// </summary>
        public const string ManagerID = "ManagerID";
        /// <summary>
        /// 管理员信息
        /// </summary>
        public const string ManagerInfo = "ManagerInfo";
        

        /// <summary>
        /// 版本号
        /// </summary>
        //public static string VersonID = ConfigurationManager.AppSettings["VersonID"].ToString();
    }
}
