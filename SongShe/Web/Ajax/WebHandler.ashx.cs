using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Maticsoft.Web.Ajax
{
    /// <summary>
    /// WebHandler 的摘要说明
    /// </summary>
    public class WebHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string Action = context.Request["action"];
            switch (Action)
            {
                case "SubmitMessage":
                    SubmitMessage(context);//提交留言信息
                    break;
            }
        }
        /// <summary>
        /// 提交留言信息
        /// </summary>
        private void SubmitMessage(HttpContext context)
        {
            LitJson.JsonData js = new LitJson.JsonData();
            js["status"] = 0;
            js["msg"] = "提交留言信息失败，请重新提交";
            string GroupName = context.Request["GroupName"];
            string Name = context.Request["Name"];
            string Phone = context.Request["Phone"];
            string Email = context.Request["Email"];
            string ComplaintType = context.Request["ComplaintType"];
            string Content = context.Request["Content"];
            if (string.IsNullOrWhiteSpace(Name))
            {
                js["msg"] = "请输入您的姓名";
                context.Response.Write(LitJson.JsonMapper.ToJson(js));
                return;
            }
            if (string.IsNullOrWhiteSpace(Phone))
            {
                js["msg"] = "请输入您的联系电话";
                context.Response.Write(LitJson.JsonMapper.ToJson(js));
                return;
            }
            if ((!Common.CommonHelper.IsNumber(Phone)) || Phone.Length != 11)
            {
                js["msg"] = "您输入的联系电话有误，请重新输入您的11位联系电话!";
                context.Response.Write(LitJson.JsonMapper.ToJson(js));
                return;
            }
            if (GroupName == "tsjy")
            {
                if (string.IsNullOrWhiteSpace(ComplaintType))
                {
                    js["msg"] = "请输入您的投诉类型";
                    context.Response.Write(LitJson.JsonMapper.ToJson(js));
                    return;
                }
            }
            else if (GroupName == "yycg")
            {
                if (string.IsNullOrWhiteSpace(Email))
                {
                    js["msg"] = "请输入您的邮箱";
                    context.Response.Write(LitJson.JsonMapper.ToJson(js));
                    return;
                }
            }
            else
            {
                js["msg"] = "提交的留言信息有误，请刷新页面重试";
                context.Response.Write(LitJson.JsonMapper.ToJson(js));
                return;
            }
            Model.MessageRecord Message = new Model.MessageRecord();
            Message.Name = Name;
            Message.Phone = Phone;
            Message.Email = Email;
            Message.ComplaintType = ComplaintType;
            Message.Content = Content;
            Message.GroupName = GroupName;
            Message.KeyID= new BLL.MessageRecord().Add(Message);
            js["status"] = 1;
            js["msg"] = "您的留言已成功提交，我们将尽快处理您提交的留言信息，请保持您的电话通畅";
            context.Response.Write(LitJson.JsonMapper.ToJson(js));
            return;
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