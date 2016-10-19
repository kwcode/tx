<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AETeam.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.SystemSet.AETeam" %>

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
                data: { "action": "UploadImage", SaveImageAddress: "/MemberManage/images/Team/", Width: 450, Height: 450,ReturnType:1, r: Math.random() },
                success: function (data) {
                    if (data.status == 1) {
                        $("#imgTeam").attr("src", data.msg);
                        $("#imgTeam").show();
                        $("input[name=ImgUrl]").val(data.msg);
                    } else
                        alert(data.msg);
                }, error: function () {
                    alert("error");
                }
            });
        }
    </script>
</head>
<body>

    <div class="pageContent">
        <form method="post" runat="server" action="/TowGAdmin/Ajax/TX_Handler.ashx?action=AETeam" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
            <input type="hidden" name="tid" value="<%=Team==null?0: Team.KeyID %>" />
            <div class="pageFormContent" layouth="56" style="height: auto;">
                <fieldset>
                    <legend>新闻信息</legend>
                    <dl class="nowrap">
                        <dt>姓名：</dt>
                        <dd>
                            <input name="Name" style="width: 200px;" class=" textInput" type="text" value="<%=Team==null?"": Team.Name %>" />
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>职位：</dt>
                        <dd>
                            <input name="Position" style="width: 200px;" class=" textInput" type="text" value="<%=Team==null?"":Team.Position %>" />
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>简介：</dt>
                        <dd>
                            <textarea cols="31" rows="4" name="Description"><%=Team==null?"":Team.Description %></textarea>
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>头像：<br /><span style="color:red;">标准尺寸:300*300</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl" value="<%=Team==null?"":Team.ImgUrl %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgTeam" height="75" src="<%=Team==null?"":Team.ImgUrl %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>是否显示：</dt>
                        <dd>
                            <select name="IsShow">
                                <option value="1" <%=Team==null?"":Team.Status==1?"selected='selected'":"" %>>显示</option>
                                <option value="0" <%=Team==null?"":Team.Status==0?"selected='selected'":"" %>>不显示</option>
                            </select>
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>优先值：</dt>
                        <dd>
                            <input name="Sort" style="width: 200px;" class="textInput" type="text" value="<%=Team==null?0:Team.Sort %>" /></dd>
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
            <input type="file" name="file" value="" accept="image/*" saveimageaddress="/MemberManage/images/Team/" onchange="UploadImgUrl()" width="0" height="0" />
        </form>
    </div>
</body>
</html>
