using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace Maticsoft.Web.TowGAdmin.Ajax
{
    /// <summary>
    /// UploadImgHandler 的摘要说明
    /// </summary>
    public class UploadImgHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string action = context.Request["action"];
            try
            {
                switch (action)
                {
                    case "UploadImage":
                        UploadImage(context);
                        break;
                    case "deleteImg":
                        deleteImg(context);
                        break;
                    default:
                        break;
                }
            }
            catch (Exception err)
            {
                context.Response.Write("");
            }
        }
        /// <summary>
        /// 图片上传
        /// </summary>
        /// <param name="context"></param>
        private void UploadImage(HttpContext context)
        {
            result r = new result()
            {
                status = 0,
                msg = "图片上传失败"
            };
            string SaveImageAddress = context.Request["SaveImageAddress"];//保存图片地址,根目录
            int Width = 0;
            int Height = 0;
            int.TryParse(context.Request["Width"], out Width);
            int.TryParse(context.Request["Height"], out Height);
            HttpPostedFile file = context.Request.Files[0];
            if (SaveImageAddress != null && SaveImageAddress != "")//UploadImageAddress != null && UploadImageAddress != "" &&
            {
                //图片保存的文件夹路径
                string path = context.Server.MapPath("~" + SaveImageAddress);//  /MemberManage/images/UserPhone/
                //每月上传的图片一个文件夹
                string folder = DateTime.Now.ToString("yyyyMM");
                //上传图片的扩展名
                string type = file.FileName.Substring(file.FileName.LastIndexOf('.'));

                if (isImage(type))
                {
                    //保存图片的文件名
                    string saveName = Guid.NewGuid().ToString() + type;
                    //保存图片
                    //file.SaveAs(path + folder + "/" + saveName);

                    //file.InputStream

                    System.Drawing.Image originalImage = System.Drawing.Image.FromStream(file.InputStream);//System.Drawing.Image.FromFile(path + folder + "\\" + saveName);
                    if (Width <= 0)
                    {
                        Width = originalImage.Width;
                    }
                    if (Height <= 0)
                    {
                        Height = originalImage.Height;
                    }

                    //新建一个bmp图片
                    System.Drawing.Image bitmap = new System.Drawing.Bitmap(Width, Height);

                    //新建一个画板
                    System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bitmap);
                    //设置高质量插值法
                    g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.Default;
                    //设置高质量,低速度呈现平滑程度
                    g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                    //清空画布并以透明背景色填充
                    g.Clear(System.Drawing.Color.Transparent);
                    //在指定位置并且按指定大小绘制原图片的指定部分
                    g.DrawImage(originalImage, new System.Drawing.Rectangle(0, 0, Width, Height),
                        new System.Drawing.Rectangle(0, 0, originalImage.Width, originalImage.Height),
                        System.Drawing.GraphicsUnit.Pixel);
                    //如果文件夹不存在，则创建
                    if (!Directory.Exists(path + folder))
                    {
                        Directory.CreateDirectory(path + folder);
                    }
                    bitmap.Save(path + folder + "/" + saveName);
                    context.Response.Clear();
                    r.status = 1;
                    r.msg = SaveImageAddress + folder + "/" + saveName;
                }
                else
                {
                    r.msg = "上传格式不正确，请上传gif,jpg,jpeg,png,bmp格式的图片";
                }
            }
            else
            {
                r.msg = "请选择要上传的路径";
            }
            int ReturnType = CommonHelper.Toint(context.Request["ReturnType"]);
            if (ReturnType == 1)
                context.Response.Write(LitJson.JsonMapper.ToJson(r));
            else
                if (r.status == 1)
                    context.Response.Write(r.msg);
                else
                    context.Response.Write("");
            context.Response.End();
        }

        public void deleteImg(HttpContext context)
        {
            string url = context.Request.Params["imgUrl"];
            if (url != null)
                DeleFile(context.Server.MapPath("~" + url.ToString()));
        }

        /// <summary>
        /// 删除文件
        /// </summary>
        /// <param name="filePath">文件绝对路径</param>
        public void DeleFile(string filePath)
        {
            try
            {
                System.IO.FileInfo DeleFile = new System.IO.FileInfo(filePath);
                if (DeleFile.Exists)
                {
                    DeleFile.Delete();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 验证是否是图片格式
        /// </summary>
        /// <param name="expends"></param>
        /// <returns></returns>
        public bool isImage(string type)
        {
            if (type == ".gif" || type == ".jpg" || type == ".jpeg" || type == ".png" || type == ".bmp")
            {
                return true;
            }
            return false;
        }
        public class result
        {
            public int status { get; set; }
            public string msg { get; set; }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}