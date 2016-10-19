<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeamList.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.SystemSet.TeamList" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>团队信息管理</title>
    <style>
        #tbodyTeamList div {
            height: auto;
        }
    </style>
    <script>
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
        function deleteConfirmMsg(url) {
            alertMsg.confirm("确定要删除吗？", {
                okCall: function () {
                    //方法体
                    $.ajax({
                        url: url,
                        dataType: 'json',
                        //data: data,
                        success: function (data) {
                            dialogAjaxDone(data);
                        },
                        error: function () {
                            navTab.reload("", { navTabId: "TeamList" });
                        }
                    });
                }
            });
        }

    </script>
</head>
<body>
    <form rel="TeamList" runat="server" onsubmit="return navTabSearch(this);" action="/TowGAdmin/SystemSet/TeamList.aspx" method="post">
        <div class="pageContent j-resizeGrid">
            <input type="hidden" name="pageNum" value="1" />
            <input type="hidden" name="numPerPage" value="<%=page.numPerPage %>" />
            <div class="panelBar" style="display: block;">
                <ul class="toolBar">
                    <li class=""><a title="添加" target="dialog" class="add" href="/TowGAdmin/SystemSet/AETeam.aspx" fresh="false" width="800" height="410"><span>添加</span></a></li>
                </ul>
            </div>
            <table class="table" layouth="138">
                <thead>
                    <tr>
                        <th width="100">头像</th>
                        <th width="100">姓名</th>
                        <th width="100">职位</th>
                        <th width="300">简介</th>
                        <th width="70">是否显示</th>
                        <th width="60">优先值</th>
                        <%--<th>发布者</th>--%>
                        <th width="130">创建时间</th>
                        <th class="operate" width="60">操作</th>
                    </tr>
                </thead>
                <tbody id="tbodyTeamList">
                    <%if (dt != null)
                      {
                          foreach (System.Data.DataRow dr in dt.Rows)
                          {%>
                    <tr>
                        <td><img src="<%= dr["ImgUrl"] %>" style="max-height:100px;max-width:100px;" onerror="$(this).hide()" /> </td>
                        <td><%= dr["Name"] %></td>
                        <td><%= dr["Position"] %></td>
                        <td><span><%= dr["Description"]==null?"":dr["Description"].ToString().Replace("\r\n","<br/>").Replace("\r","<br/>").Replace("\n","<br/>").Replace(" ","&nbsp;") %></span></td>
                        <td><%= Maticsoft.Common.CommonHelper.Toint(dr["Status"])==1?"显示中":"不显示" %></td>
                        <td><%= dr["Sort"] %></td>
                        <%--<td><%= dr["ManagerID"] %></td>--%>
                        <td class="operate"><%=dr["AddTime"] %> </td>
                        <td>
                            <a title="编辑" class="btnEdit" href="/TowGAdmin/SystemSet/AETeam.aspx?tid=<%=dr["KeyID"] %>" target="dialog" fresh="false" width="800" height="410">编辑</a>
                            <a title="删除" class="btnDel" href="javascript:void();" onclick="deleteConfirmMsg('/TowGAdmin/Ajax/TX_Handler.ashx?action=DeleteTeam&tid=<%= dr["KeyID"] %>')">删除</a>
                        </td>
                    </tr>
                    <%}
                  } %>
                </tbody>
            </table>
            <div class="panelBar" style="display: block;">
                <div class="pages">
                    <span>显示</span>
                    <select class="combox" onchange="navTabPageBreak({numPerPage:this.value},'TeamList')">
                        <option value="20" <%=page.numPerPage==20?"selected='selected'":"" %>>20</option>
                        <option value="50" <%=page.numPerPage==50?"selected='selected'":"" %>>50</option>
                        <option value="100" <%=page.numPerPage==100?"selected='selected'":"" %>>100</option>
                        <option value="200" <%=page.numPerPage==200?"selected='selected'":"" %>>200</option>
                    </select>
                    <span>条，共<%=page.totalCount %>条</span>
                </div>
                <div style="display: block;" class="pagination" rel="TeamList" targettype="navTab" totalcount="<%=page.totalCount %>" numperpage="<%=page.numPerPage %>" pagenumshown="5" currentpage="<%=page.pageNum %>"></div>
            </div>
        </div>
    </form>
</body>
</html>
