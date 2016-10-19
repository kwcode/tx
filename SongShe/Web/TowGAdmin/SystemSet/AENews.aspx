<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AENews.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.SystemSet.AENews" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <%--<script src="/UserJs/jquery-1.11.3.min.js"></script>--%>
    <script src="/UserJs/jquery.form.js"></script>
    <script type="text/javascript">
        function dialogAjaxDone(json) {
            DWZ.ajaxDone(json);
            if (json.statusCode == DWZ.statusCode.ok) {
                if (json.navTabId) {
                    navTab.reload(json.forwardUrl, { navTabId: json.navTabId });
                } else if (json.rel) {
                    navTabPageBreak({}, json.rel);
                }
                if ("closeCurrent" == json.callbackType) {
                    $.pdialog.closeCurrent();
                }
            }
        }
        function UploadImgUrl() {
            $("#formUploadImg").ajaxSubmit({
                type: "post",
                url: "/TowGAdmin/Ajax/UploadImgHandler.ashx",
                dataType: "json",
                type: "POST",
                data: { "action": "UploadImage", SaveImageAddress: "/MemberManage/images/News/", Width: 445, Height: 330,ReturnType:1, r: Math.random() },
                success: function (data) {
                    if (data.status == 1) {
                        $("#imgNews").attr("src", data.msg);
                        $("#imgNews").show();
                        $("input[name=ImgUrl]").val(data.msg);
                    } else
                        alert(data.msg);
                }, error: function () {
                    alert("error");
                }
            });

            //$("#formUploadImg").submit(function (event) {
            //    alert("Handler for .submit() called.");
            //    event.preventDefault();
            //});
        }
    </script>
</head>
<body>

    <div class="pageContent">
        <form method="post" runat="server" action="/TowGAdmin/Ajax/TX_Handler.ashx?action=AENews" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
            <input type="hidden" name="nid" value="<%=News==null?0: News.KeyID %>" />
            <div class="pageFormContent" layouth="56" style="height: auto;">
                <fieldset>
                    <legend>新闻信息</legend>
                    <dl class="nowrap">
                        <dt>新闻标题：</dt>
                        <dd>
                            <input name="Title" style="width: 200px;" class=" textInput" type="text" value="<%=News==null?"": News.Title %>" />
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>新闻标题：</dt>
                        <dd>
                            <textarea name="Description" rows="4" cols="60" class="textInput" ><%=News==null?"": News.Description %></textarea>
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>新闻来源：</dt>
                        <dd>
                            <input name="Source" style="width: 200px;" class=" textInput" type="text" value="<%=News==null?"":News.Source %>" />
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>新闻类型：</dt>
                        <dd>
                            <select name="NewsType">
                                <option value="1" <%=News==null?"":News.TypeID==1?"selected='selected'":"" %>>最新资讯</option>
                                <option value="2" <%=News==null?"":News.TypeID==2?"selected='selected'":"" %>>权威发布</option>
                            </select>
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>新闻图片：<br /><span style="color:red;">标准尺寸:330*215</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl" value="<%=News==null?"":News.ImgUrl %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgNews" height="75" src="<%=News==null?"":News.ImgUrl %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>是否显示：</dt>
                        <dd>
                            <select name="IsShow">
                                <option value="1" <%=News==null?"":News.Status==1?"selected='selected'":"" %>>显示</option>
                                <option value="0" <%=News==null?"":News.Status==0?"selected='selected'":"" %>>不显示</option>
                            </select>
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>优先值：</dt>
                        <dd>
                            <input name="Sort" style="width: 200px;" class="textInput" type="text" value="<%=News==null?0:News.Sort %>" /></dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>新闻详情：</dt>
                    </dl>
                    <dl class="nowrap">
                        <dd>
                            <textarea class="editor" name="Detail" upimgurl="/TowGAdmin/Ajax/UploadImgHandler.ashx?action=UploadImage&ReturnType=0&SaveImageAddress=/MemberManage/NewsContentImg/" upimgext="jpg,jpeg,gif,png" rows="40" cols="130"><%=News==null?"":News.Detail %></textarea>
                        </dd>
                    </dl>
                </fieldset>
            </div>
            <div class="formBar">
                <ul>
                    <li>
                        <div class="buttonActive">
                            <div class="buttonContent">
                                <button type="submit">保存</button>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="button">
                            <div class="buttonContent">
                                <button type="button" class="close">取消</button>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </form>
        <form id="formUploadImg" style="display: none;">
            <input type="file" name="file" value="" accept="image/*" saveimageaddress="/MemberManage/images/News/" onchange="UploadImgUrl()" width="0" height="0" />
        </form>
    </div>
</body>
</html>
