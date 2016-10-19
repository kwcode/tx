<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagerList.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.SystemSet.ManagerList" %>

<script>
    function deleteConfirmMsg(url) {
        alertMsg.confirm("确定要删除吗？", {
            okCall: function () {
                //方法体
                $.post(url, "", DWZ.ajaxDone, "json");
                navTab.reload('', { navTabId: "managerList" });//刷新当前页面
            }
        });
    }
</script>

<form rel="ManagerList" runat="server" onsubmit="return navTabSearch(this);" action="/TowGAdmin/SystemSet/ManagerList.aspx" method="post">
    <div class="pageContent j-resizeGrid">
        <input type="hidden" name="pageNum" value="1" />
        <%--<input type="hidden" name="numPerPage" value="20" />--%>
        <div class="panelBar" style="display: block;">
            <ul class="toolBar">
                <li class=""><a title="添加" target="dialog" class="add" href="/TowGAdmin/SystemSet/AEManager.aspx" fresh="false" width="600" height="310"><span>添加</span></a></li>
            </ul>
        </div>
        <table class="table" id="table_Manager" width="800" layouth="138">

            <thead>
                <tr>
                    <th>帐号</th>
                    <th>联系电话</th>
                    <th>添加时间</th>
                    <th class="operate">操作</th>
                </tr>
            </thead>
            <tbody id="tbody">
                <%if (dt != null)
                  {
                      foreach (System.Data.DataRow dr in dt.Rows)
                      {
                          
                      %>
                <tr>
                    <td><%= dr["ManagerName"] %></td>
                    <td><%= dr["Phone"] %></td>
                    <td class="operate"><%=dr["AddTime"] %> </td>
                    <td>
                        <a title="编辑" class="btnEdit" href="/TowGAdmin/SystemSet/AEManager.aspx?id=<%=dr["KeyID"] %>" target="dialog" fresh="false">编辑</a>
                        <a title="删除" class="btnDel" href="javascript:void();" onclick="deleteConfirmMsg('/TowGAdmin/Ajax/W_Handler.ashx?action=DeleteManager&id=<%= dr["KeyID"] %>')">删除</a>
                    </td>
                </tr>
                <%}
                  } %>
            </tbody>
        </table>
        <div class="panelBar" style="display: block;">
            <div class="pages">
                <span>显示</span>
                <select class="combox" onchange="navTabPageBreak({numPerPage:this.value},'ManagerList')">
                    <option value="20" <%=page.numPerPage==20?"selected='selected'":"" %>>20</option>
                    <option value="50"  <%=page.numPerPage==50?"selected='selected'":"" %>>50</option>
                    <option value="100"  <%=page.numPerPage==100?"selected='selected'":"" %>>100</option>
                    <option value="200"  <%=page.numPerPage==200?"selected='selected'":"" %>>200</option>
                </select>
                <span>条，共<%=page.totalCount %>条</span>
            </div>
            <div style="display: block;" class="pagination" rel="ManagerList" targettype="navTab" totalcount="<%=page.totalCount %>" numperpage="<%=page.numPerPage %>" pagenumshown="5" currentpage="<%=page.pageNum %>"></div>
        </div>
    </div>
</form>
