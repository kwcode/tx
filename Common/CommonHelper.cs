using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using Maticsoft.DBUtility;
using System.Reflection;

namespace Maticsoft.Common
{
    public class CommonHelper
    {
        /// <summary>
        /// 过滤SQL不安全的字符串
        /// </summary>
        /// <param name="Str"></param>
        /// <returns></returns>
        public static string FilteSQLStr(string Str)
        {
            if (!string.IsNullOrEmpty(Str) && Str != "")
            {
                Str = Str.ToLower();

                Str = Str.Replace("\t", "");
                Str = Str.Replace("'", "");
                Str = Str.Replace("\"", "");
                Str = Str.Replace("&", "&amp");
                Str = Str.Replace("<", "&lt");
                Str = Str.Replace(">", "&gt");
                Str = Str.Replace("--", "");
                Str = Str.Replace("__", "");

                //Str = Str.Replace("@", "＠");
                //Str = Str.Replace("+", "＋");
                //Str = Str.Replace("*", "＊");
                //Str = Str.Replace("&", "＆");
                //Str = Str.Replace("#", "＃");
                //Str = Str.Replace("%", "％");
                //Str = Str.Replace("$", "￥");

                Str = Str.Replace("delete", "");
                Str = Str.Replace("update", "");
                Str = Str.Replace("insert", "");
                Str = Str.Replace("drop", "");

                Str = Str.Replace("exec", "");
                Str = Str.Replace("execute", "");

                //去除系统存储过程或扩展存储过程关键字
                Str = Str.Replace("xp_", "x p_");
                Str = Str.Replace("sp_", "s p_");

                //防止16进制注入
                Str = Str.Replace("0x", "0 x");
            }
            return Str;
        }
        public static string FilteSQLStr_1(string Str)
        {
            Str = Str.ToLower();
            Str = Str.Replace("delete", "");
            Str = Str.Replace("update", "");
            Str = Str.Replace("insert", "");
            Str = Str.Replace("drop", "");

            Str = Str.Replace("exec", "");
            Str = Str.Replace("execute", "");

            Str = Str.Replace("\t", "");
            //去除系统存储过程或扩展存储过程关键字
            Str = Str.Replace("xp_", "x p_");
            Str = Str.Replace("sp_", "s p_");

            //防止16进制注入
            Str = Str.Replace("0x", "0 x");

            return Str;
        }

        /// <summary>
        /// 加密
        /// </summary>
        /// <param name="pwd"></param>
        /// <returns></returns>
        public static string jiammi(string pwd)
        {
            string md5pwd = NewMd5(pwd).ToUpper();
            string md5new = md5pwd.Substring(0, 20);
            md5pwd = NewMd5(md5new).ToUpper();
            md5pwd = md5pwd.Substring(10);
            return md5pwd;
        }
        /// <summary>
        /// 加密 已过时
        /// </summary>
        /// <param name="pwd"></param>
        /// <returns></returns>
        public static string jiammi(string pwd, int x)
        {
            string md5pwd = FormsAuthentication.HashPasswordForStoringInConfigFile(pwd, "MD5").ToUpper();
            string md5new = md5pwd.Substring(0, 20);
            md5pwd = FormsAuthentication.HashPasswordForStoringInConfigFile(md5new, "MD5").ToUpper();
            md5pwd = md5pwd.Substring(10);
            return md5pwd;
        }

        /// <summary>
        /// 最新md5
        /// </summary>
        /// <param name="pwd"></param>
        /// <returns></returns>
        public static string NewMd5(string pwd)
        {
            System.Security.Cryptography.MD5CryptoServiceProvider md5Hasher = new System.Security.Cryptography.MD5CryptoServiceProvider();
            byte[] data = md5Hasher.ComputeHash(System.Text.Encoding.Default.GetBytes(pwd));
            System.Text.StringBuilder sBuilder = new System.Text.StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("X2"));
            }
            return sBuilder.ToString();
        }
        ///// <summary>
        ///// MD5加密
        ///// </summary>
        ///// <param name="passWord">要加密的字符串</param>
        ///// <returns>加密后的字符串</returns>
        //public static string MD5Encrypt(string passWord)
        //{
        //    string newPass = "";
        //    if (!string.IsNullOrEmpty(passWord))
        //    {
        //        newPass = FormsAuthentication.HashPasswordForStoringInConfigFile(passWord, "MD5").ToLower();

        //    }
        //    return newPass;
        //}
        /// <summary>
        /// MD5加密
        /// </summary>
        /// <param name="passWord">要加密的字符串</param>
        /// <returns>加密后的字符串</returns>
        public static string MD5Encrypt(string passWord)
        {
            string newPass = "";
            if (!string.IsNullOrEmpty(passWord))
            {
                newPass = NewMd5(passWord);

            }
            return newPass;
        }

        /// <summary>
        /// MD5加密（32位）
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static String md5(String s)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] bytes = System.Text.Encoding.UTF8.GetBytes(s);
            bytes = md5.ComputeHash(bytes);
            md5.Clear();

            string ret = "";
            for (int i = 0; i < bytes.Length; i++)
            {
                ret += Convert.ToString(bytes[i], 16).PadLeft(2, '0');
            }

            return ret.PadLeft(32, '0');
        }
        /// <summary>
        /// post请求
        /// </summary>
        /// <param name="Url"></param>
        /// <param name="postDataStr"></param>
        /// <returns></returns>
        public static string HttpPost(string Url, string postDataStr, CookieContainer cookie = null)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = Encoding.UTF8.GetByteCount(postDataStr);
            if (cookie != null)
                request.CookieContainer = cookie;
            Stream myRequestStream = request.GetRequestStream();
            StreamWriter myStreamWriter = new StreamWriter(myRequestStream, Encoding.GetEncoding("gb2312"));
            myStreamWriter.Write(postDataStr);
            myStreamWriter.Close();

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            if (cookie != null)
                response.Cookies = cookie.GetCookies(response.ResponseUri);
            Stream myResponseStream = response.GetResponseStream();
            StreamReader myStreamReader = new StreamReader(myResponseStream, Encoding.GetEncoding("utf-8"));
            string retString = myStreamReader.ReadToEnd();
            myStreamReader.Close();
            myResponseStream.Close();
            return retString;
        }



        #region Methods
        /// <summary>
        /// Email格式验证
        /// </summary>
        /// <param name="Email">Email</param>
        /// <returns>true/false</returns>
        public static bool IsValidEmail(string Email)
        {
            return Regex.IsMatch(Email, @"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
        }

        /// <summary>
        /// 截取字符串
        /// </summary>
        /// <param name="len"></param>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string GetSubString(int len, object obj)
        {
            string str = "";
            if (obj != null)
            {
                str = obj.ToString();
                if (str.Length > len)
                    str = str.Substring(0, len) + "...";
            }
            return str;
        }

        // <summary>
        /// 指定的数据是否为Null或string.Empty
        /// </summary>
        /// <param name="obj">数据</param>
        /// <returns></returns>
        public static bool IsNullOrEmpty(object obj)
        {
            return obj == null || obj.ToString().Trim() == "";
        }


        /// <summary>
        /// 转换为字符串
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string Tostring(object value)
        {
            if (value != null)
            {
                return value.ToString();
            }

            return string.Empty;

        }

        //public static DateTime ToDatetime(object value)
        //{
        //    if (!IsNullOrEmpty(value))
        //    {
        //        try
        //        {
        //         return  Convert.ToDateTime(value);

        //        }
        //        catch
        //        {

        //        }
        //    }

        //}

        public static int Toint(object value)
        {
            int returnValue = 0;
            if (!IsNullOrEmpty(value))
            {
                int.TryParse(value.ToString(), out returnValue);

            }
            return returnValue;
        }

        public static long Tolong(object value)
        {
            long returnValue = 0;
            if (!IsNullOrEmpty(value))
            {
                long.TryParse(value.ToString(), out returnValue);

            }
            return returnValue;
        }
        /// <summary>
        /// 对象转换成decimal
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static decimal Todecimal(object value)
        {
            decimal returnValue = 0;
            if (!IsNullOrEmpty(value))
            {
                decimal.TryParse(value.ToString(), out returnValue);

            }
            return returnValue;
        }

        /// <summary>
        /// 对象转换成double
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static double ToDouble(object value)
        {
            double returnValue = 0;
            if (!IsNullOrEmpty(value))
            {
                double.TryParse(value.ToString(), out returnValue);

            }
            return returnValue;
        }
        /// <summary>
        /// 对象转换成DateTime
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static DateTime ToDateTime(object value)
        {
            DateTime returnValue = new DateTime();
            if (!IsNullOrEmpty(value))
            {
                DateTime.TryParse(value.ToString(), out returnValue);

            }
            return returnValue;
        }

        /// <summary>
        /// 转换为Bool型
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static bool ToBool(object value)
        {
            bool status = false;
            if (!IsNullOrEmpty(value))
            {
                bool.TryParse(value.ToString(), out status);
            }
            return status;
        }

        /// <summary>
        /// 时间转换为字符串
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static string DateTimeTostring(DateTime date)
        {
            if (!IsNullOrEmpty(date))
            {
                return date.ToString("yyyy-MM-dd");
            }
            return "--";

        }

        /// <summary>
        /// 获取地址栏参数
        /// </summary>
        /// <param name="Name">参数名称</param>
        /// <returns>返回值</returns>
        public static string QueryString(string Name)
        {
            string result = string.Empty;
            if (HttpContext.Current != null && HttpContext.Current.Request.QueryString[Name] != null)
                result = HttpContext.Current.Request.QueryString[Name].ToString();
            return result;
        }

        /// <summary>
        ///地址栏获取
        /// </summary>
        /// <param name="Name">Parameter name</param>
        /// <returns>Query string value</returns>
        public static bool QueryStringBool(string Name)
        {
            string resultStr = QueryString(Name).ToUpperInvariant();
            return (resultStr == "YES" || resultStr == "TRUE" || resultStr == "1");
        }

        /// <summary>
        ///获取地址栏INT类型参数
        /// </summary>
        /// <param name="Name">参数名称</param>
        /// <returns>INT</returns>
        public static int QueryStringInt(string Name)
        {
            string resultStr = QueryString(Name).ToUpperInvariant();
            int result;
            Int32.TryParse(resultStr, out result);
            return result;
        }

        /// <summary>
        /// 获取地址栏INT参数，失败时返回默认值
        /// </summary>
        /// <param name="Name"></param>
        /// <param name="DefaultValue">默认值</param>
        /// <returns></returns>
        public static int QueryStringInt(string Name, int DefaultValue)
        {
            string resultStr = QueryString(Name).ToUpperInvariant();
            if (resultStr.Length > 0)
            {
                return Int32.Parse(resultStr);
            }
            return DefaultValue;
        }

        /// <summary>
        /// 将指定的字符串分割为数组
        /// </summary>
        /// <param name="inputString">输入的字符串</param>
        /// <param name="separator">字符分隔符</param>
        /// <returns>分隔后的数组</returns>
        public static List<string> Split(object inputString, string separator)
        {
            List<string> list = new List<string>();
            if (!IsNullOrEmpty(inputString))
            {
                string data = inputString.ToString().Trim();
                //string[] datas = data.Split(new string[] { separator }, StringSplitOptions.RemoveEmptyEntries);
                string[] datas = data.Split(new string[] { separator }, StringSplitOptions.None);
                int count = datas.Length;
                for (int i = 0; i < count; i++)
                {
                    list.Add(datas[i]);
                }
            }
            return list;
        }

        /// <summary>
        /// 判断是否是Boolean数据类型
        /// </summary>
        /// <param name="value">要判断的数据</param>  
        /// <returns></returns>
        public static bool IsBoolean(object inputString)
        {
            string value = "";
            if (!IsNullOrEmpty(inputString))
            {
                value = inputString.ToString().ToUpper();
            }
            return value == "TRUE" || value == "FALSE" || value == "1" || value == "0";
        }
        /// <summary>
        /// 单表通用分页查询
        /// </summary>
        /// <returns></returns>
        public static DataSet QueryPage(int Pagesize, int currentPage, string where, string order, string table, string pageid)
        {
            string sql = "select top(" + Pagesize + ")* from " + table + " where 1=1{0} and  " + pageid + " not in(select top(" + (currentPage - 1) * Pagesize + ") " + pageid + " from " + table + " where 1=1{0} order by " + order + ")order by " + order + "";
            sql = string.Format(sql, where);
            DataSet ds = DbHelperSQL.Query(sql);
            return ds;
        }

        /// <summary>
        /// 下拉框选中某项值
        /// </summary>
        /// <param name="List">List</param>
        /// <param name="Value">选中值</param>
        public static void SelectListItem(DropDownList List, object Value)
        {
            if (List.Items.Count != 0)
            {
                ListItem selectedItem = List.SelectedItem;
                if (selectedItem != null)
                    selectedItem.Selected = false;
                if (Value != null)
                {
                    selectedItem = List.Items.FindByValue(Value.ToString());
                    if (selectedItem != null)
                        selectedItem.Selected = true;
                }
            }
        }
        /// <summary>
        /// 修改查询地址栏查询参数
        /// </summary>
        /// <param name="url"></param>
        /// <param name="queryStringModification"></param>
        /// <param name="targetLocationModification"></param>
        /// <returns>New url</returns>
        public static string ModifyQueryString(string url, string queryStringModification, string targetLocationModification)
        {
            string str = string.Empty;
            string str2 = string.Empty;
            if (url.Contains("#"))
            {
                str2 = url.Substring(url.IndexOf("#") + 1);
                url = url.Substring(0, url.IndexOf("#"));
            }
            if (url.Contains("?"))
            {
                str = url.Substring(url.IndexOf("?") + 1);
                url = url.Substring(0, url.IndexOf("?"));
            }
            if (!string.IsNullOrEmpty(queryStringModification))
            {
                if (!string.IsNullOrEmpty(str))
                {
                    Dictionary<string, string> dictionary = new Dictionary<string, string>();
                    foreach (string str3 in str.Split(new char[] { '&' }))
                    {
                        if (!string.IsNullOrEmpty(str3))
                        {
                            string[] strArray = str3.Split(new char[] { '=' });
                            if (strArray.Length == 2)
                            {
                                dictionary[strArray[0]] = strArray[1];
                            }
                            else
                            {
                                dictionary[str3] = null;
                            }
                        }
                    }
                    foreach (string str4 in queryStringModification.Split(new char[] { '&' }))
                    {
                        if (!string.IsNullOrEmpty(str4))
                        {
                            string[] strArray2 = str4.Split(new char[] { '=' });
                            if (strArray2.Length == 2)
                            {
                                dictionary[strArray2[0]] = strArray2[1];
                            }
                            else
                            {
                                dictionary[str4] = null;
                            }
                        }
                    }
                    StringBuilder builder = new StringBuilder();
                    foreach (string str5 in dictionary.Keys)
                    {
                        if (builder.Length > 0)
                        {
                            builder.Append("&");
                        }
                        builder.Append(str5);
                        if (dictionary[str5] != null)
                        {
                            builder.Append("=");
                            builder.Append(dictionary[str5]);
                        }
                    }
                    str = builder.ToString();
                }
                else
                {
                    str = queryStringModification;
                }
            }
            if (!string.IsNullOrEmpty(targetLocationModification))
            {
                str2 = targetLocationModification;
            }
            return (url + (string.IsNullOrEmpty(str) ? "" : ("?" + str)) + (string.IsNullOrEmpty(str2) ? "" : ("#" + str2)));
        }

        /// <summary>
        /// 重地址栏移除参数
        /// </summary>
        /// <param name="url"></param>
        /// <param name="queryString"></param>
        /// <returns>New url</returns>
        public static string RemoveQueryString(string url, string queryString)
        {
            string str = string.Empty;
            if (url.Contains("?"))
            {
                str = url.Substring(url.IndexOf("?") + 1);
                url = url.Substring(0, url.IndexOf("?"));
            }
            if (!string.IsNullOrEmpty(queryString))
            {
                if (!string.IsNullOrEmpty(str))
                {
                    Dictionary<string, string> dictionary = new Dictionary<string, string>();
                    foreach (string str3 in str.Split(new char[] { '&' }))
                    {
                        if (!string.IsNullOrEmpty(str3))
                        {
                            string[] strArray = str3.Split(new char[] { '=' });
                            if (strArray.Length == 2)
                            {
                                dictionary[strArray[0]] = strArray[1];
                            }
                            else
                            {
                                dictionary[str3] = null;
                            }
                        }
                    }
                    dictionary.Remove(queryString);

                    StringBuilder builder = new StringBuilder();
                    foreach (string str5 in dictionary.Keys)
                    {
                        if (builder.Length > 0)
                        {
                            builder.Append("&");
                        }
                        builder.Append(str5);
                        if (dictionary[str5] != null)
                        {
                            builder.Append("=");
                            builder.Append(dictionary[str5]);
                        }
                    }
                    str = builder.ToString();
                }
            }
            return (url + (string.IsNullOrEmpty(str) ? "" : ("?" + str)));
        }

        /// <summary>
        /// 返回dwz需要的json数据格式
        /// </summary>
        /// <param name="status">状态码 200成功  300错误  301超时</param>
        /// <param name="message">提示消息</param>
        /// <param name="navTabId">服务器转回navTabId可以把那个navTab标记为reloadFlag=1，下次切换到那个navTab时会重新载入内容,一般无需传入</param>
        /// <param name="rel">无需传入</param>
        /// <param name="callbackType">callbackType如果是closeCurrent就会关闭当前tab，否则不传入</param>
        /// <param name="forwardUrl">callbackType如果是closeCurrent传入的url</param>
        /// <returns></returns>
        public static string GetDwzAjaxJsonData(string status, string message, string navTabId = "", string rel = "", string callbackType = "", string forwardUrl = "")
        {
            return "{\"statusCode\":\"" + status + "\",\"message\":\"" + message + "\",\"navTabId\":\"" + navTabId + "\",\"rel\":\"" + rel + "\",\"callbackType\":\"" + callbackType
                + "\",\"forwardUrl\":\"" + forwardUrl + "\"}";
        }

        #region 操作Cookie
        /// <summary>
        /// 读cookie值
        /// </summary>
        /// <param name="strName">名称</param>
        /// <returns>cookie值</returns>
        public static string GetCookie(string strName)
        {
            if (HttpContext.Current.Request.Cookies != null && HttpContext.Current.Request.Cookies[strName] != null)
                return HttpContext.Current.Server.UrlDecode(HttpContext.Current.Request.Cookies[strName].Value.ToString());
            return "";
        }

        /// <summary>
        /// 创建cookie
        /// </summary>
        /// <param name="cookieName">Cookie名称</param>
        /// <param name="cookieValue">Cookie值</param>
        /// <param name="ts">有效期</param>
        public static void SetCookie(string cookieName, string cookieValue, TimeSpan? ts = null, bool IsCliendRead = true)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
                if (cookie == null)
                {
                    cookie = new HttpCookie(cookieName);
                }
                //cookie.HttpOnly = true;
                //cookie.Secure = false;
                //cookie.Domain = ".fagf520.com";
                if (HttpContext.Current.Request.Url.Host.Contains("192.168.1.137"))
                {
                    cookie.Domain = "192.168.1.137";
                }
                if (HttpContext.Current.Request.Url.Host.Contains("fagf520.com"))
                {
                    cookie.Domain = "fagf520.com";
                }
                if (HttpContext.Current.Request.Url.Host.Contains("a1036657054.xicp.net"))
                {
                    cookie.Domain = "a1036657054.xicp.net";
                }
                cookie.Value = HttpContext.Current.Server.UrlEncode(cookieValue);
                if (ts != null)
                {
                    DateTime dt = DateTime.Now;
                    cookie.Expires = dt.AddDays(((TimeSpan)ts).Days);
                }
                if (cookieName == Keys.SessionID)
                {
                    cookie.HttpOnly = true;
                    cookie.Secure = false;
                    HttpContext.Current.Request.Cookies.Remove(Keys.SessionID);
                }
                if (!IsCliendRead)
                {
                    cookie.HttpOnly = true;
                    cookie.Secure = false;
                    HttpContext.Current.Request.Cookies.Remove(cookieName);
                }
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
            catch (Exception exc)
            {
                throw exc;
            }
        }

        /// <summary>
        /// 获取Cookie
        /// </summary>
        /// <param name="cookieName">Cookie名</param>
        /// <param name="decode">是否解码</param>
        /// <returns>Cookie string</returns>
        public static string GetCookieString(string cookieName, bool decode)
        {
            if (HttpContext.Current.Request.Cookies[cookieName] == null)
            {
                return string.Empty;
            }
            try
            {
                string tmp = HttpContext.Current.Request.Cookies[cookieName].Value.ToString();
                if (decode)
                    tmp = HttpContext.Current.Server.UrlDecode(tmp);
                return tmp;
            }
            catch
            {
                return string.Empty;
            }
        }

        /// <summary>
        /// cookie中获取BOLL值
        /// </summary>
        /// <param name="cookieName">Cookie name</param>
        /// <returns>Result</returns>
        public static bool GetCookieBool(string cookieName)
        {
            string str1 = GetCookieString(cookieName, true).ToUpperInvariant();
            return (str1 == "TRUE" || str1 == "YES" || str1 == "1");
        }

        /// <summary>
        ///cookie获取Int型值
        /// </summary>
        /// <param name="cookieName">Cookie name</param>
        /// <returns>Result</returns>
        public static int GetCookieInt(String cookieName)
        {
            string str1 = GetCookieString(cookieName, true);
            if (!String.IsNullOrEmpty(str1))
                return Convert.ToInt32(str1);
            else
                return 0;
        }
        #endregion

        /// <summary>
        /// 获取客户端用户IP
        /// </summary>
        /// <returns></returns>
        public static string GetUserIP()
        {
            if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null)
                return System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].Split(new char[] { ',' })[0];
            else
                return System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        /// <summary>
        /// 泛型转为C#实体
        /// </summary>
        /// <typeparam name="T">实体</typeparam>
        /// <param name="table">传入表</param>
        /// <returns>相应实体</returns>
        public static List<T> GetEntity<T>(DataTable table) where T : new()
        {
            List<T> list = new List<T>();
            if (table == null || table.Rows.Count == 0)
                return list;
            //读取数据，填充T
            foreach (DataRow dr in table.Rows)
            {
                //获取T类型的属性类型和值
                T t = new T();
                PropertyInfo[] pis = t.GetType().GetProperties();
                //获取数据库返回数据的列数
                int intColCount = table.Columns.Count;
                int value_number = 0;
                for (int i = 0; i < intColCount; i++)
                {
                    pis[i].SetValue(t, dr[value_number] == DBNull.Value ? null : dr[value_number], null);
                    value_number++;
                }
                list.Add(t);
            }
            return list;
        }
        /// <summary>
        /// datatable转json
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string DataTableToJson(System.Data.DataTable dt)
        {
            //System.Text.StringBuilder jsonBuilder = new System.Text.StringBuilder();
            //jsonBuilder.Append("[");
            //if (dt != null)
            //{
            //    for (int i = 0; i < dt.Rows.Count; i++)
            //    {
            //        jsonBuilder.Append("{");
            //        for (int j = 0; j < dt.Columns.Count; j++)
            //        {
            //            jsonBuilder.Append("\"");
            //            jsonBuilder.Append(dt.Columns[j].ColumnName);
            //            jsonBuilder.Append("\":\"");
            //            if (dt.Columns[j].ColumnName == "tixianprice")
            //                jsonBuilder.Append(Common.CommonHelper.ToDouble(dt.Rows[i][j].ToString()).ToString("0.00"));
            //            else
            //                jsonBuilder.Append(dt.Rows[i][j].ToString().Replace("\n", "\\n"));
            //            jsonBuilder.Append("\",");
            //        }
            //        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            //        jsonBuilder.Append("},");
            //    }
            //    if (dt.Rows.Count > 0)
            //        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            //}
            //jsonBuilder.Append("]");
            //return jsonBuilder.ToString();

            LitJson.JsonData data = new LitJson.JsonData();
            data.SetJsonType(LitJson.JsonType.Array);
            foreach (DataRow dr in dt.Rows)
            {
                LitJson.JsonData drow = new LitJson.JsonData();
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    drow[dt.Columns[j].ColumnName] = dr[j].ToString();
                }
                data.Add(drow);
            }
            return LitJson.JsonMapper.ToJson(data);
        }
        /// <summary>
        /// 字典转json
        /// </summary>
        /// <param name="?"></param>
        /// <returns></returns>
        public static string DictionaryToJson(Dictionary<int, string> dic)
        {
            System.Text.StringBuilder jsonBuilder = new System.Text.StringBuilder();
            jsonBuilder.Append("[");
            if (dic != null && dic.Count > 0)
            {
                int i = 0;
                foreach (var item in dic)
                {
                    if (i != 0)
                        jsonBuilder.Append(",");
                    jsonBuilder.Append("{");
                    jsonBuilder.Append("\"id");
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(i.ToString());
                    jsonBuilder.Append("\",");
                    jsonBuilder.Append("\"title");
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(item.Value.ToString());
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append("}");
                    i++;
                }
            }
            jsonBuilder.Append("]");
            return jsonBuilder.ToString();
        }
        public static string DictionaryToJson(Dictionary<string, string> dic)
        {
            System.Text.StringBuilder jsonBuilder = new System.Text.StringBuilder();
            jsonBuilder.Append("[");
            if (dic != null && dic.Count > 0)
            {
                int i = 0;
                foreach (var item in dic)
                {
                    if (i != 0)
                        jsonBuilder.Append(",");
                    jsonBuilder.Append("{");
                    jsonBuilder.Append("\"id");
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(i.ToString());
                    jsonBuilder.Append("\",");
                    jsonBuilder.Append("\"title");
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(item.Value.ToString());
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append("}");
                    i++;
                }
            }
            jsonBuilder.Append("]");
            return jsonBuilder.ToString();
        }
        /// <summary>
        /// 根据传入的自增ID值获取订单编号或者流水号
        /// 弃用 新方法在BLL.IdentityExtend.GetOrderNo
        /// </summary>
        /// <param name="IdentityID"></param>
        /// <returns></returns>
        public static string GetOrderNo(int IdentityID)
        {

            DateTime Now = DateTime.Now;
            string OrderNo = Now.ToString("yyyMMdd");
            if (IdentityID.ToString().Length <= 6)
            {
                for (int i = IdentityID.ToString().Length; i < 6; i++)
                {
                    OrderNo += "0";
                }
            }
            OrderNo += IdentityID.ToString();
            return OrderNo;
        }
        #endregion


        #region 短信发送
        /// <summary>
        /// 短信发送
        /// </summary>
        /// <param name="phone">手机号</param>
        /// <param name="yzCode">验证码</param>
        /// <returns></returns>
        public static bool sendMessage(string phone, string content)
        {
            HttpWebResponse response = null;
            HttpWebRequest request = null;
            string baseurl = "http://sms.jx106.cn/api/api.asp";
            string apitype = "2";
            string smsname = "AZYJ";
            string pwd = "123456a";
            string postParams = "apitype=" + apitype + "&smsname=" + smsname + "&smspwd=" + pwd + "&mobile=" + phone + "&content=" + content;
            byte[] data = System.Text.Encoding.GetEncoding("GB2312").GetBytes(postParams);
            request = WebRequest.Create(baseurl) as HttpWebRequest;
            CookieContainer cookieContainer = new CookieContainer();
            request.CookieContainer = cookieContainer;
            request.AllowAutoRedirect = true;
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;
            Stream outstream = request.GetRequestStream();
            outstream.Write(data, 0, data.Length);
            outstream.Close();
            response = request.GetResponse() as HttpWebResponse;
            Stream instream = response.GetResponseStream();
            StreamReader sr = new StreamReader(instream, System.Text.Encoding.GetEncoding("GB2312"));
            string returnContent = sr.ReadToEnd().Split('|')[0];
            return (returnContent == "1");
        }
        /// <summary>
        /// 发送团购码至手机
        /// </summary>
        /// <param name="phone">手机号</param>
        /// <param name="GBVerifierCode">团购码</param>
        /// <param name="GoodsName">团购名称</param>
        /// <param name="EndStartDate">团购结束时间</param>
        /// <returns></returns>
        public static bool sendGBVerifierCode(string phone, string GBVerifierCode, string GoodsName, DateTime EndStartDate)
        {
            string content = "恭喜您成功购买[" + GoodsName + "],消费码:" + GBVerifierCode.Substring(0, 12) + ",将于" + EndStartDate.ToString("yyyy-MM-dd") + "失效.【奉爱股份】";
            HttpWebResponse response = null;
            HttpWebRequest request = null;
            string baseurl = "http://sms.jx106.cn/api/api.asp";
            string apitype = "2";
            string smsname = "AZYJ";
            string pwd = "123456a";
            string postParams = "apitype=" + apitype + "&smsname=" + smsname + "&smspwd=" + pwd + "&mobile=" + phone + "&content=" + content;
            byte[] data = System.Text.Encoding.GetEncoding("GB2312").GetBytes(postParams);
            request = WebRequest.Create(baseurl) as HttpWebRequest;
            CookieContainer cookieContainer = new CookieContainer();
            request.CookieContainer = cookieContainer;
            request.AllowAutoRedirect = true;
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;
            Stream outstream = request.GetRequestStream();
            outstream.Write(data, 0, data.Length);
            outstream.Close();
            response = request.GetResponse() as HttpWebResponse;
            Stream instream = response.GetResponseStream();
            StreamReader sr = new StreamReader(instream, System.Text.Encoding.GetEncoding("GB2312"));
            string returnContent = sr.ReadToEnd().Split('|')[0];
            return (returnContent == "1");
        }
        #endregion

        private static Random rand = new Random();
        /// <summary>
        /// 获取随机12位的验证码
        /// 月日+八位随机数字
        /// 例 2015年10月15日 1015 1248 6581
        /// </summary>
        /// <returns></returns>
        public static string GetVerifierCodeBy12()
        {

            string VerifierCode = DateTime.Now.ToString("MMdd");
            for (int i = 0; i < 2; i++)
            {
                int Rand = rand.Next(1000, 9999);
                VerifierCode += Rand.ToString();
            }
            if (VerifierCode.Length == 12)
            {
                return VerifierCode;
            }
            else
            {
                return GetVerifierCodeBy12();
            }
        }

        #region 系统参数帮助
        public static Dictionary<string, string> systemPhone = new Dictionary<string, string>{
            {"adminPhone","18888888888"},
            {"lovePhone","15555555555"},
            {"companyLevelPhone","13333333333"},
            {"loveMoney","2"},
            {"Agent198","200"}
        };

        //可为他人升级代理列表
        public static int[] intArray1 = new int[] { 1, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15 };

        /// <summary>
        /// 系统会员等级
        /// </summary>
        public static Dictionary<int, string> systemGrades = new Dictionary<int, string>
        {
                {0,"V代"},
                {1,"镇代"},
                {2,"区代"},
                {3,"市代"},
                {4,"省代"},
                {5,"社区代理"},
                {100,"总代"}
        };

        /// <summary>
        /// 系统会员等级(最新) 2015-12-09
        /// </summary>
        public static Dictionary<int, string> systemGradesNew = new Dictionary<int, string>
        {
                {22,"创业会员"},
                {1041,"小区代理"},
                {1038,"社区代理"},
                {24,"镇代"},
                {25,"区代"},
                {26,"市代"},
                {27,"省代"},
                {28,"总代"}
        };

        public static Dictionary<int, string> systemDeductType = new Dictionary<int, string> { 
            {0,"公司收益"},
            {1,"销售奖"},
            {2,"管理奖"},
            {3,"服务奖"},
            {4,"v代奖"},
            {5,"镇代奖"},
            {6,"区代奖"},
            {7,"市代奖"},
            {8,"省代奖"},
            {9,"总代奖"},
            {10,"加权平分奖"}
        };

        public static Dictionary<int, string> systemDeductStatus = new Dictionary<int, string>
        {
            {0,"冻结"},
            {1,"成功"},
            {2,"作废"}
        };

        public static Dictionary<string, string> sysDeliveryDate = new Dictionary<string, string>
        {
            {"1天内","1"},
            {"2天内","2"},
            {"3天内","3"}
        };

        public enum systemAgentParam
        {
            fristDeduct = 1,
            secondDeduct = 2,
            threedDeduct = 3,
            payMoneyDeduct = 4,
            fenzhuDeduct = 5,
            ownerDeduct = 6,
            payMoneyFristDeduct = 7,
            payMoneySocendDeduct = 8,
            payMoneyThreedDeduct = 9,
            jsMoneyDeduct = 10,
            market200Deduct = 11,
            market500Deduct = 12,
            market1000Deduct = 13,
            market2000Deduct = 14,
            market4000Deduct = 15,
            totalDevelopment = 16,
            shengDevelopment = 17,
            shiDevelopment = 18,
            quDevelopment = 19,
            zhenDevelopment = 20,
            vDevelopment = 21,
            agent198 = 22,
            agentV = 23,
            agentZhen = 24,
            agentQu = 25,
            agentShi = 26,
            agentSheng = 27,
            agentAll = 28,
            //代理消费返利暂时不用这里面的参数。先直接在数据库中写入
            zhenRebute = 1028,
            quRebute = 1029,
            shiRebute = 1030,
            shengRebute = 1031,
            /// <summary>
            /// 代升298的提成
            /// </summary>
            upOtherRebute298 = 2046,
            /// <summary>
            /// 代升小区代的提成
            /// </summary>
            upOtherRebutexq = 2047,
            /// <summary>
            /// 代升社区代的提成
            /// </summary>
            upOtherRebutesq = 2048,
            /// <summary>
            /// 代升镇代的提成
            /// </summary>
            upOtherRebutezd = 2049,
            /// <summary>
            /// 代升区代的提成
            /// </summary>
            upOtherRebuteqd = 2050,
            /// <summary>
            /// 代升市代的提成
            /// </summary>
            upOtherRebutesd = 2051,
            /// <summary>
            /// 代升省代的提成
            /// </summary>
            upOtherRebuteshd = 2052,
            /// <summary>
            /// 代升总代的提成
            /// </summary>
            upOtherRebutezod = 2053
        }
        /// <summary>
        /// 订单状态 
        /// </summary>
        public static Dictionary<int, string> orderStatus = new Dictionary<int, string>()
        {
            {0,"等待支付"},
            {1,"已支付，等待发货"},
            {2,"已发货，等待签收"},
            {3,"已收货"},
            {10,"订单已取消"},
            {100,"订单完成"}
        };

        /// <summary>
        /// 订单退款状态
        /// </summary>
        public static Dictionary<int, string> orderRefundStatus = new Dictionary<int, string>()
        {
            {0,"未退款"},//若为0，前台不进行显示
            {1,"退款申请中"},
            {2,"退款已拒绝"},
            {3,"同意退款，退款中"},
            {4,"退款成功"},
            {5,"退款失败"}
        };
        /// <summary>
        /// 订单超时天数
        /// </summary>
        public static Dictionary<int, string> TimeoutDate = new Dictionary<int, string>()
        {
            {0,"未退款"},//若为0，前台不进行显示
            {1,"退款申请中"},
            {2,"退款已拒绝"},
            {3,"同意退款，退款中"},
            {4,"退款成功"},
            {5,"退款失败"}
        };
        /// <summary>
        /// 状态等待超时天数常量
        /// </summary>
        public class TimeoutDateDay
        {
            /// <summary>
            /// 等待付款超时天数
            /// </summary>
            public const int NotPaid = 1;
            /// <summary>
            /// 等待发货超时时间
            /// </summary>
            public const int NotDelivery = 3;
            /// <summary>
            /// 等待收货超时天数
            /// </summary>
            public const int NotReceiving = 7;
            /// <summary>
            /// 退款申请超时天数
            /// </summary>
            public const int RefundApply = 3;
            /// <summary>
            /// 退款中超时天数
            /// </summary>
            public const int Refunding = 7;
            /// <summary>
            /// 不能申请退款超时的天数
            /// </summary>
            public const int NotRefundApply = 14;
        }

        /// <summary>
        /// 系统颜色 暂时使用，后期将会迁入规格里面
        /// </summary>
        public static Dictionary<int, string> GoodsColor = new Dictionary<int, string>(){
                {1,"红色"},
                {2,"橙色"},
                {3,"黄色"},
                {4,"绿色"},
                {5,"青色"},
                {6,"蓝色"},
                {7,"紫色"},
                {8,"白色"},
                {9,"黑色"},
                {10,"其他"}
        };
        /// <summary>
        /// 快递公司列表
        /// </summary>
        public static Dictionary<string, string> ExpressCompany = new Dictionary<string, string>(){
            {"申通","申通"},
            {"圆通","圆通"},
            {"韵达","韵达"},
            {"天天","天天"},
            {"顺风","顺风"},
            {"中通","中通"}
        };
        /// <summary>
        /// 公司性质
        /// </summary>
        public static Dictionary<string, string> marketType = new Dictionary<string, string>(){
            {"国有企业","国有企业"},
            {"集体企业","集体企业"},
            {"联营企业","联营企业"},
            {"股份合作制企业","股份合作制企业"},
            {"私营企业","私营企业"},
            {"个体户","个体户"},
            {"合伙企业","合伙企业"},
            {"有限责任公司","有限责任公司"},
            {"股份有限公司","股份有限公司"},
            {"其他","其他"}
        };
        /// <summary>
        /// 情感状况
        /// </summary>
        public static Dictionary<int, string> EmotionalState = new Dictionary<int, string>(){
            {0,"保密"},
            {1,"未婚"},
            {2,"已婚"},
            //{3,"离异"},
            //{4,"丧偶"},
            //{5,"无配偶"},
            //{6,"同居"}
        };
        /// <summary>
        /// 学历等级
        /// </summary>
        public static Dictionary<int, string> Education = new Dictionary<int, string>(){
            //{0,"保密"},
            //{1,"幼儿班"},
            //{2,"学前班"},
            //{3,"小学"},
            //{4,"初中"},
            {5,"高中及以下"},
            {6,"大专"},
            {7,"本科"},
            //{8,"一本"},
            {9,"硕士生"},
            //{10,"博士生"},
            //{11,"留学生"},
            //{12,"海归"}
        };
        /// <summary>
        /// 工作年限
        /// </summary>
        public static Dictionary<int, string> WorkExperience = new Dictionary<int, string>(){
            {0,"无工作经验"},
            {1,"一年以下工作经验"},
            {2,"一年至三年工作经验"},
            {3,"三年至五年工作经验"},
            {4,"五年至十年工作经验"},
            {5,"十年以上工作经验"}
        };
        /// <summary>
        /// 公司规模
        /// </summary>
        public static Dictionary<int, string> CompanyScale = new Dictionary<int, string>(){
            {1,"10人以下"},
            {2,"10至50人"},
            {3,"50至100人"},
            {4,"100至300人"},
            {5,"300至500人"},
            {6,"500人至1000人"},
            {7,"1000人以上"}
        };
        #endregion
        /// <summary>
        /// 获取拼音方法
        /// </summary>
        public static int[] pyvalue = new int[]{
                                            -20319,-20317,-20304,-20295,-20292,-20283,-20265,-20257,-20242,-20230,-20051,-20036,-20032,-20026,
 
                                            -20002,-19990,-19986,-19982,-19976,-19805,-19784,-19775,-19774,-19763,-19756,-19751,-19746,-19741,-19739,-19728, 
                                            
                                            -19725,-19715,-19540,-19531,-19525,-19515,-19500,-19484,-19479,-19467,-19289,-19288,-19281,-19275,-19270,-19263, 
                                            
                                            -19261,-19249,-19243,-19242,-19238,-19235,-19227,-19224,-19218,-19212,-19038,-19023,-19018,-19006,-19003,-18996, 
                                            
                                            -18977,-18961,-18952,-18783,-18774,-18773,-18763,-18756,-18741,-18735,-18731,-18722,-18710,-18697,-18696,-18526, 
                                            
                                            -18518,-18501,-18490,-18478,-18463,-18448,-18447,-18446,-18239,-18237,-18231,-18220,-18211,-18201,-18184,-18183, 
                                            
                                            -18181,-18012,-17997,-17988,-17970,-17964,-17961,-17950,-17947,-17931,-17928,-17922,-17759,-17752,-17733,-17730, 
                                            
                                            -17721,-17703,-17701,-17697,-17692,-17683,-17676,-17496,-17487,-17482,-17468,-17454,-17433,-17427,-17417,-17202, 
                                            
                                            -17185,-16983,-16970,-16942,-16915,-16733,-16708,-16706,-16689,-16664,-16657,-16647,-16474,-16470,-16465,-16459, 
                                            
                                            -16452,-16448,-16433,-16429,-16427,-16423,-16419,-16412,-16407,-16403,-16401,-16393,-16220,-16216,-16212,-16205, 
                                            
                                            -16202,-16187,-16180,-16171,-16169,-16158,-16155,-15959,-15958,-15944,-15933,-15920,-15915,-15903,-15889,-15878, 
                                            
                                            -15707,-15701,-15681,-15667,-15661,-15659,-15652,-15640,-15631,-15625,-15454,-15448,-15436,-15435,-15419,-15416, 
                                            
                                            -15408,-15394,-15385,-15377,-15375,-15369,-15363,-15362,-15183,-15180,-15165,-15158,-15153,-15150,-15149,-15144, 
                                            
                                            -15143,-15141,-15140,-15139,-15128,-15121,-15119,-15117,-15110,-15109,-14941,-14937,-14933,-14930,-14929,-14928, 
                                            
                                            -14926,-14922,-14921,-14914,-14908,-14902,-14894,-14889,-14882,-14873,-14871,-14857,-14678,-14674,-14670,-14668, 
                                            
                                            -14663,-14654,-14645,-14630,-14594,-14429,-14407,-14399,-14384,-14379,-14368,-14355,-14353,-14345,-14170,-14159, 
                                            
                                            -14151,-14149,-14145,-14140,-14137,-14135,-14125,-14123,-14122,-14112,-14109,-14099,-14097,-14094,-14092,-14090, 
                                            
                                            -14087,-14083,-13917,-13914,-13910,-13907,-13906,-13905,-13896,-13894,-13878,-13870,-13859,-13847,-13831,-13658, 
                                            
                                            -13611,-13601,-13406,-13404,-13400,-13398,-13395,-13391,-13387,-13383,-13367,-13359,-13356,-13343,-13340,-13329, 
                                            
                                            -13326,-13318,-13147,-13138,-13120,-13107,-13096,-13095,-13091,-13076,-13068,-13063,-13060,-12888,-12875,-12871, 
                                            
                                            -12860,-12858,-12852,-12849,-12838,-12831,-12829,-12812,-12802,-12607,-12597,-12594,-12585,-12556,-12359,-12346, 
                                            
                                            -12320,-12300,-12120,-12099,-12089,-12074,-12067,-12058,-12039,-11867,-11861,-11847,-11831,-11798,-11781,-11604, 
                                            
                                            -11589,-11536,-11358,-11340,-11339,-11324,-11303,-11097,-11077,-11067,-11055,-11052,-11045,-11041,-11038,-11024, 
                                            
                                            -11020,-11019,-11018,-11014,-10838,-10832,-10815,-10800,-10790,-10780,-10764,-10587,-10544,-10533,-10519,-10331, 
                                            
                                            -10329,-10328,-10322,-10315,-10309,-10307,-10296,-10281,-10274,-10270,-10262,-10260,-10256,-10254};

        public static string[] pystr = new string[]{"a","ai","an","ang","ao","ba","bai","ban","bang","bao","bei","ben","beng","bi","bian","biao", 

                                                "bie","bin","bing","bo","bu","ca","cai","can","cang","cao","ce","ceng","cha","chai","chan","chang","chao","che","chen", 
                                                
                                                "cheng","chi","chong","chou","chu","chuai","chuan","chuang","chui","chun","chuo","ci","cong","cou","cu","cuan","cui", 
                                                
                                                "cun","cuo","da","dai","dan","dang","dao","de","deng","di","dian","diao","die","ding","diu","dong","dou","du","duan", 
                                                
                                                "dui","dun","duo","e","en","er","fa","fan","fang","fei","fen","feng","fo","fou","fu","ga","gai","gan","gang","gao", 
                                                
                                                "ge","gei","gen","geng","gong","gou","gu","gua","guai","guan","guang","gui","gun","guo","ha","hai","han","hang", 
                                                
                                                "hao","he","hei","hen","heng","hong","hou","hu","hua","huai","huan","huang","hui","hun","huo","ji","jia","jian", 
                                                
                                                "jiang","jiao","jie","jin","jing","jiong","jiu","ju","juan","jue","jun","ka","kai","kan","kang","kao","ke","ken", 
                                                
                                                "keng","kong","kou","ku","kua","kuai","kuan","kuang","kui","kun","kuo","la","lai","lan","lang","lao","le","lei", 
                                                
                                                "leng","li","lia","lian","liang","liao","lie","lin","ling","liu","long","lou","lu","lv","luan","lue","lun","luo", 
                                                
                                                "ma","mai","man","mang","mao","me","mei","men","meng","mi","mian","miao","mie","min","ming","miu","mo","mou","mu", 
                                                
                                                "na","nai","nan","nang","nao","ne","nei","nen","neng","ni","nian","niang","niao","nie","nin","ning","niu","nong", 
                                                
                                                "nu","nv","nuan","nue","nuo","o","ou","pa","pai","pan","pang","pao","pei","pen","peng","pi","pian","piao","pie", 
                                                
                                                "pin","ping","po","pu","qi","qia","qian","qiang","qiao","qie","qin","qing","qiong","qiu","qu","quan","que","qun", 
                                                
                                                "ran","rang","rao","re","ren","reng","ri","rong","rou","ru","ruan","rui","run","ruo","sa","sai","san","sang", 
                                                
                                                "sao","se","sen","seng","sha","shai","shan","shang","shao","she","shen","sheng","shi","shou","shu","shua", 
                                                
                                                "shuai","shuan","shuang","shui","shun","shuo","si","song","sou","su","suan","sui","sun","suo","ta","tai", 
                                                
                                                "tan","tang","tao","te","teng","ti","tian","tiao","tie","ting","tong","tou","tu","tuan","tui","tun","tuo", 
                                                
                                                "wa","wai","wan","wang","wei","wen","weng","wo","wu","xi","xia","xian","xiang","xiao","xie","xin","xing", 
                                                
                                                "xiong","xiu","xu","xuan","xue","xun","ya","yan","yang","yao","ye","yi","yin","ying","yo","yong","you", 
                                                
                                                "yu","yuan","yue","yun","za","zai","zan","zang","zao","ze","zei","zen","zeng","zha","zhai","zhan","zhang", 
                                                
                                                "zhao","zhe","zhen","zheng","zhi","zhong","zhou","zhu","zhua","zhuai","zhuan","zhuang","zhui","zhun","zhuo", 
                                                
                                                "zi","zong","zou","zu","zuan","zui","zun","zuo"
                                                  };

        /// <summary>
        /// 转化汉字的全部拼音
        /// </summary> 
        public static string ConvertAllSpell(string chrstr)
        {
            // Regex MyRegex = new Regex("^[\u4e00-\u9fa5]$"); //汉字的正则表达式.eg: if(MyRegex.IsMatch(chrstr.ToString()))
            Regex MyRegex = new Regex("^[一-龥]$");
            byte[] array = new byte[2];
            string returnstr = "";
            int chrasc = 0;
            int i1 = 0;
            int i2 = 0;
            char[] nowchar = chrstr.ToCharArray();
            for (int j = 0; j < nowchar.Length; j++)
            {

                if (MyRegex.IsMatch(nowchar[j].ToString()))
                {
                    array = System.Text.Encoding.Default.GetBytes(nowchar[j].ToString());
                    i1 = (short)(array[0]);
                    i2 = (short)(array[1]);
                    chrasc = i1 * 256 + i2 - 65536;
                    if (chrasc > 0 && chrasc < 160)
                    {
                        returnstr += nowchar[j];
                    }
                    else
                    {
                        for (int i = (pyvalue.Length - 1); i >= 0; i--)
                        {
                            if (pyvalue[i] <= chrasc)
                            {
                                returnstr += pystr[i];
                                break;
                            }
                        }
                    }
                }
                else
                {
                    returnstr += nowchar[j].ToString();
                }
            }
            return returnstr;
        }

        /// <summary>
        /// 添加注册记录日志
        /// </summary>
        /// <param name="Phone"></param>
        /// <param name="Remark"></param>
        public static void AddResgisteRecord(string Phone, string Remark, string CnNumber)
        {
            string path = System.Web.HttpContext.Current.Server.MapPath("~/MemberManage/RegisteRecord/");
            string name = DateTime.Now.ToString("yyyyMMdd") + ".txt";
            //如果文件夹不存在，则创建
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            DirectoryInfo dir = new DirectoryInfo(path);
            System.IO.File.AppendAllText(path + name, "用户：" + Phone + ",上级：" + (CnNumber == "" ? "无上级" : CnNumber) + "，注册时间：" + DateTime.Now.ToString("yyyy年MM月dd日HH时ss分mm秒") + "，注册记录：" + Remark + "\r\n");
        }

        /// <summary>
        /// 生成八位数编号（KeyID）  CnNumber
        /// </summary>
        /// <param name="KeyID"></param>
        /// <returns></returns>
        public static string GetSixNumber(int KeyID)
        {
            if (KeyID < 0)
                KeyID = Math.Abs(KeyID);
            string SixNumber = "cn";
            for (int i = 0; i < 8 - KeyID.ToString().Length; i++)
            {
                SixNumber += "0";
            }
            return SixNumber + KeyID.ToString();
        }

        /// <summary>
        /// 判断是否是全数字
        /// </summary>
        /// <param name="strNum"></param>
        /// <returns></returns>
        public static bool IsNumber(string strNum)
        {
            if (strNum == null || strNum == "")
                return false;
            for (int i = 0; i < strNum.Length; i++)
            {
                byte tempByte = Convert.ToByte(strNum[i]);
                if (tempByte < 48 || tempByte > 57)
                    return false;
            }
            return true;
        }

        /// <summary>
        ///  获取当前系统时间  
        ///  生成流水号
        ///  格式：T20160218094539157
        /// </summary>
        /// <param name="prefix">前缀</param>
        /// <returns></returns>
        public static string GetSerialNumber(string prefix)
        {
            //TimeSpan ts = DateTime.UtcNow - new DateTime(1970, DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second, DateTime.Now.Millisecond);//获取时间戳
            //return prefix + ts.TotalMilliseconds.ToString().Replace(".", "");//生成流水号
            //return prefix + ts.TotalMilliseconds.ToString();//生成流水号
            return prefix + DateTime.Now.ToString("yyyyMMddHHmmssfff");
        }
        /// <summary>
        /// DataTable通过流导出Excel
        /// </summary>
        /// <param name="ds">数据源DataSet</param>
        /// <param name="columns">DataTable中列对应的列名(可以是中文),若为null则取DataTable中的字段名</param>
        /// <param name="fileName">保存文件名(例如：a.xls)</param>
        /// <returns></returns>
        public static bool StreamExport(DataTable dt, string[] columns, string fileName, HttpContext context)
        {
            if (dt.Rows.Count > 65535) //总行数大于Excel的行数 
            {
                throw new Exception("预导出的数据总行数大于excel的行数");
            }
            if (string.IsNullOrEmpty(fileName)) return false;

            StringBuilder content = new StringBuilder();
            StringBuilder strtitle = new StringBuilder();
            content.Append("<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40'>");
            content.Append("<head><title></title><meta http-equiv='Content-Type' content=\"text/html; charset=gb2312\">");
            //注意：[if gte mso 9]到[endif]之间的代码，用于显示Excel的网格线，若不想显示Excel的网格线，可以去掉此代码
            content.Append("<!--[if gte mso 9]>");
            content.Append("<xml>");
            content.Append(" <x:ExcelWorkbook>");
            content.Append("  <x:ExcelWorksheets>");
            content.Append("   <x:ExcelWorksheet>");
            content.Append("    <x:Name>Sheet1</x:Name>");
            content.Append("    <x:WorksheetOptions>");
            content.Append("      <x:Print>");
            content.Append("       <x:ValidPrinterInfo />");
            content.Append("      </x:Print>");
            content.Append("    </x:WorksheetOptions>");
            content.Append("   </x:ExcelWorksheet>");
            content.Append("  </x:ExcelWorksheets>");
            content.Append("</x:ExcelWorkbook>");
            content.Append("</xml>");
            content.Append("<![endif]-->");
            content.Append("</head><body><table style='border-collapse:collapse;table-layout:fixed;'><tr>");

            if (columns != null)
            {
                for (int i = 0; i < columns.Length; i++)
                {
                    if (columns[i] != null && columns[i] != "")
                    {
                        content.Append("<td><b>" + columns[i] + "</b></td>");
                    }
                    else
                    {
                        content.Append("<td><b>" + dt.Columns[i].ColumnName + "</b></td>");
                    }
                }
            }
            else
            {
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    content.Append("<td><b>" + dt.Columns[j].ColumnName + "</b></td>");
                }
            }
            content.Append("</tr>\n");

            for (int j = 0; j < dt.Rows.Count; j++)
            {
                content.Append("<tr>");
                for (int k = 0; k < dt.Columns.Count; k++)
                {
                    object obj = dt.Rows[j][k];
                    Type type = obj.GetType();
                    if (type.Name == "Int32" || type.Name == "Single" || type.Name == "Double" || type.Name == "Decimal")
                    {
                        double d = obj == DBNull.Value ? 0.0d : Convert.ToDouble(obj);
                        if (type.Name == "Int32" || (d - Math.Truncate(d) == 0))
                            content.AppendFormat("<td style='vnd.ms-excel.numberformat:#,##0'>{0}</td>", obj);
                        else
                            content.AppendFormat("<td style='vnd.ms-excel.numberformat:#,##0.00'>{0}</td>", obj);
                    }
                    else
                        content.AppendFormat("<td style='vnd.ms-excel.numberformat:@'>{0}</td>", obj);
                }
                content.Append("</tr>\n");
            }
            content.Append("</table></body></html>");
            content.Replace("&nbsp;", "");
            context.Response.Clear();
            context.Response.Buffer = true;
            context.Response.ContentType = "application/ms-excel";  //"application/ms-excel";
            context.Response.Charset = "UTF-8";
            context.Response.ContentEncoding = System.Text.Encoding.UTF7;
            fileName = System.Web.HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8);
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
            context.Response.Write(content.ToString());
            //pages.Response.End();  //注意，若使用此代码结束响应可能会出现“由于代码已经过优化或者本机框架位于调用堆栈之上,无法计算表达式的值。”的异常。
            HttpContext.Current.ApplicationInstance.CompleteRequest(); //用此行代码代替上一行代码，则不会出现上面所说的异常。
            return true;
        }

        /// <summary>
        /// 获取服务器相应时间
        /// </summary>
        /// <returns></returns>
        public static DateTime GetNowDate()
        {
            string sql = @"select getdate() as nowDate";
            object obj = DbHelperSQL.GetSingle(sql);
            return DateTime.Parse(obj.ToString());
        }
    }
}
