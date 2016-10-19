<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AEMenu.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.PageData.AEMenu" %>

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
                data: { "action": "UploadImage", SaveImageAddress: "/MemberManage/images/Menu/", Width: 2000, Height: 1000,ReturnType:1, r: Math.random() },
                success: function (data) {
                    if (data.status == 1) {
                        $("#imgMenus").attr("src", data.msg);
                        $("#imgMenus").show();
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
        <form method="post" runat="server" action="/TowGAdmin/Ajax/TX_Handler.ashx?action=AEMenu" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
            <input type="hidden" name="pid" value="<%=Menus==null?0: Menus.KeyID %>" />
            <div class="pageFormContent" layouth="56" style="height: auto;">
                <fieldset>
                    <legend>菜单栏信息</legend>
                    <dl class="nowrap">
                        <dt>标题：</dt>
                        <dd>
                            <input name="Title" style="width: 200px;" class=" textInput" type="text" value="<%=Menus==null?"": Menus.Title %>" />
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>英文名：</dt>
                        <dd>
                            <input name="Detail" style="width: 200px;" class=" textInput" type="text" value="<%=Menus==null?"":Menus.Detail %>" />
                        </dd>
                    </dl>
                    <dl class="nowrap">
                        <dt>页面一句话：</dt>
                        <dd>
                            <input name="Remark" style="width: 200px;" class=" textInput" type="text" value="<%=Menus==null?"":Menus.Remark %>" />
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>轮播展示图片：<br /><span style="color:red;">标准尺寸:2000*1000</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl" value="<%=Menus==null?"":Menus.ImgUrl %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus" height="75" src="<%=Menus==null?"":Menus.ImgUrl %>" onerror="$(this).hide();" />
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
            <input type="file" name="file" value="" accept="image/*" saveimageaddress="/MemberManage/images/Menu/" onchange="UploadImgUrl()" width="2000" height="1000" />
        </form>
    </div>
</body>
</html>
