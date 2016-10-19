<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageIndex.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.PageData.PageIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
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
            var width = $('#formUploadImg input[type=file]').attr('width');
            var height = $('#formUploadImg input[type=file]').attr('height');
            var kid = $('#formUploadImg input[type=file]').attr('kid');
            $("#formUploadImg").ajaxSubmit({
                type: "post",
                url: "/TowGAdmin/Ajax/UploadImgHandler.ashx",
                dataType: "json",
                type: "POST",
                data: { "action": "UploadImage", SaveImageAddress: "/MemberManage/images/PageIndex/" + kid + "/", Width: width, Height: height, ReturnType: 1, r: Math.random() },
                success: function (data) {
                    if (data.status == 1) {
                        $("#imgMenus" + kid).attr("src", data.msg);
                        $("#imgMenus" + kid).show();
                        $("input[name=ImgUrl" + kid + "]").val(data.msg);
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
        <form method="post" rel="PageIndex" runat="server" action="/TowGAdmin/Ajax/TX_Handler.ashx?action=AEPageIndex" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
            <div class="pageFormContent" layouth="56" style="height: auto;">
                <fieldset>
                    <legend>大图</legend>
                    <dl class="nowrap" style="height: auto;">
                        <dt>区域一大图：<br />
                            <span style="color: red;">标准尺寸:400*200</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl11" value="<%=pc1.Title %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').attr('width',400);$('#formUploadImg input[type=file]').attr('height',200);$('#formUploadImg input[type=file]').attr('kid',11);$('#formUploadImg input[type=file]').attr('width',400); $('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus11" height="75" src="<%=pc1.Title %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>区域二大图：<br />
                            <span style="color: red;">标准尺寸:400*200</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl21" value="<%=pc1.Detail %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').attr('width',400);$('#formUploadImg input[type=file]').attr('height',200);$('#formUploadImg input[type=file]').attr('kid',21);$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus21" height="75" src="<%=pc1.Detail %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>区域三大图：<br />
                            <span style="color: red;">标准尺寸:400*200</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl31" value="<%=pc2.Remark %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').attr('width',400);$('#formUploadImg input[type=file]').attr('height',200);$('#formUploadImg input[type=file]').attr('kid',31);$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus31" height="75" src="<%=pc2.Remark %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>区域四大图：<br />
                            <span style="color: red;">标准尺寸:400*200</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl41" value="<%=pc2.ImgUrl%>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').attr('width',400);$('#formUploadImg input[type=file]').attr('height',200);$('#formUploadImg input[type=file]').attr('kid',41);$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus41" height="75" src="<%=pc2.ImgUrl %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                </fieldset>
                <fieldset>
                    <legend>小图</legend>
                    <dl class="nowrap" style="height: auto;">
                        <dt>区域一小图：<br />
                            <span style="color: red;">标准尺寸:200*200</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl12" value="<%=pc2.Title %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').attr('width',200);$('#formUploadImg input[type=file]').attr('height',200);$('#formUploadImg input[type=file]').attr('kid',12);$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus12" height="75" src="<%=pc2.Title %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>区域二小图：<br />
                            <span style="color: red;">标准尺寸:200*200</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl22" value="<%=pc2.Detail %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').attr('width',200);$('#formUploadImg input[type=file]').attr('height',200);$('#formUploadImg input[type=file]').attr('kid',22);$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus22" height="75" src="<%=pc2.Detail %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>区域三小图：<br />
                            <span style="color: red;">标准尺寸:200*200</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl32" value="<%=pc1.Remark %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').attr('width',200);$('#formUploadImg input[type=file]').attr('height',200);$('#formUploadImg input[type=file]').attr('kid',32);$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus32" height="75" src="<%=pc1.Remark %>" onerror="$(this).hide();" />
                        </dd>
                    </dl>
                    <dl class="nowrap" style="height: auto;">
                        <dt>区域四小图：<br />
                            <span style="color: red;">标准尺寸:200*200</span></dt>
                        <dd>
                            <input type="hidden" name="ImgUrl42" value="<%=pc1.ImgUrl %>" />
                            <a href="javascript:void(0)" style="color: blue;" onclick="$('#formUploadImg input[type=file]').attr('width',200);$('#formUploadImg input[type=file]').attr('height',200);$('#formUploadImg input[type=file]').attr('kid',42);$('#formUploadImg input[type=file]').val('');$('#formUploadImg input[type=file]').click();">上传图片</a>
                            <br />
                            <img id="imgMenus42" height="75" src="<%=pc1.ImgUrl %>" onerror="$(this).hide();" />
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
