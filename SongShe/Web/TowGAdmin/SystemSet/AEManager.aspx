<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AEManager.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.SystemSet.AEManager" %>

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
</script>
<div class="pageContent">
    <form method="post" runat="server" action="/TowGAdmin/Ajax/TX_Handler.ashx?action=AEManager" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
        <input type="hidden" name="id" value="<%=manager.KeyID %>" />
        <div class="pageFormContent" layouth="56" style="height: auto;">
            <fieldset>
                <legend>用户信息</legend>
                <dl>
                    <dt>帐号：</dt>
                    <dd>
                        <input name="ManagerName" style="width: 200px;" class="required textInput" type="text" value="<%=manager.ManagerName %>" AUTOCOMPLETE="off"></dd>
                </dl>
                <%--<%if (manager.KeyID == 0) { 
                  %>--%>
                <dl style="height:auto;">
                    <dt>密码：</dt>
                    <dd>
                        <input name="Password" style="width: 200px;" class="textInput" type="password"  AUTOCOMPLETE="off">
                        <br />
                        <span style="color:red;">*若不填写则不进行密码重置</span>
                    </dd>
                </dl><%--<%
                  } %>--%>
                <dl>
                    <dt>联系电话：</dt>
                    <dd>
                        <input name="Phone" style="width: 200px;" class="required textInput" type="text" value="<%=manager.Phone%>" AUTOCOMPLETE="off">
                    </dd>
                </dl>
                <%--<dl>
                    <dt>是否是超级管理员：</dt>
                    <dd>
                        <%if (manager.IsAdmin == true)
                          { %>
                        <input type="radio" name="rdo_IsAdmin" value="1" checked="checked">是
                        <input type="radio" name="rdo_IsAdmin" value="0">否<%}
                          else
                          {%>
                        <input type="radio" name="rdo_IsAdmin" value="1">是
                        <input type="radio" name="rdo_IsAdmin" value="0" checked="checked">否<% } %>
                    </dd>
                </dl>--%>
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
</div>
