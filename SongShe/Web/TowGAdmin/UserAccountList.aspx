<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserAccountList.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.UserAccountList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script>
        function deleteConfirmMsg(url) {
            alertMsg.confirm("确定要删除吗？", {
                okCall: function () {
                    //方法体
                    $.post(url, "", DWZ.ajaxDone, "json");
                    navTab.reload('', { navTabId: "UserAccountList" });//刷新当前页面
                }
            });
        }
    </script>
</head>
<body>
    <form id="UserAccountList" runat="server" onsubmit="return navTabSearch(this);" action="/TowGAdmin/UserAccountList.aspx" method="post">
        <div class="pageContent j-resizeGrid">
            <input type="hidden" name="pageNum" value="1" />
            <input type="hidden" name="numPerPage" value="<%=page.numPerPage %>" />
            <div class="panelBar" style="display: block;">
                <ul class="toolBar">
                    <li class=""><a title="添加" target="dialog" class="add" href="/TowGAdmin/AEUserAccount.aspx" fresh="false" width="600" height="310"><span>添加</span></a></li>
                </ul>
            </div>
            <table class="table" id="table_UserAccount" width="100%" layouth="88">
                <thead>
                    <tr>
                        <th>编号</th>
                        <th>用户名</th>
                        <th>是否管理员</th>
                        <th>添加时间</th>
                        <th width="80" class="operate">操作</th>
                    </tr>
                </thead>
                <tbody id="tbody">
                    <asp:Repeater ID="RepeaterData" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("ID") %></td>
                                <td><%# Eval("UserName") %></td>
                                <td><%# Maticsoft.Common.CommonHelper.ToBool( Eval("IsAdmin"))==true?"是":"否" %></td>
                                <td class="operate"><%# Eval("AddTime") %> </td>
                                <td>
                                    <a title="编辑" class="btnEdit" href="/TowGAdmin/AEUserAccount.aspx?id=<%# Eval("ID") %>" rel="AEUserAccount" target="dialog" fresh="false">编辑</a>
                                    <a title="删除" class="btnDel" href="javascript:void();" onclick="deleteConfirmMsg('/TowGAdmin/Ajax/ComputerHandler.ashx?action=DeleteUserAccount&id=<%# Eval("ID") %>')">删除</a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <div class="panelBar" style="display: block;">
                <div class="pages">
                    <span>显示</span>
                    <select id="numPerPage_UserAccount" runat="server" class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value},'UserAccountList')">
                        <option value="20">20</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="200">200</option>
                    </select>
                    <span>条，共<%=page.totalCount %>条</span>
                </div>

                <div style="display: block;" class="pagination" rel="UserAccountList" targettype="navTab" totalcount="<%=page.totalCount %>" numperpage="<%=page.numPerPage %>" pagenumshown="5" currentpage="<%=page.pageNum %>"></div>

            </div>
        </div>
    </form>
</body>
</html>
