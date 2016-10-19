<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsList.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.SystemSet.NewsList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        #tbodyNewsList div {
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
                            navTab.reload("", { navTabId: "NewsList" });
                        }
                    });
                }
            });
        }
    </script>
</head>
<body>
    <form rel="ManagerList" runat="server" onsubmit="return navTabSearch(this);" action="/TowGAdmin/SystemSet/NewsList.aspx" method="post">
        <div class="pageContent j-resizeGrid">
            <input type="hidden" name="pageNum" value="1" />
            <input type="hidden" name="numPerPage" value="<%=page.numPerPage %>" />
            <div class="panelBar" style="display: block;">
                <ul class="toolBar">
                    <li class=""><a title="添加" target="dialog" class="add" href="/TowGAdmin/SystemSet/AENews.aspx" fresh="false" width="1000" height="610"><span>添加</span></a></li>
                </ul>
            </div>
            <table class="table" width="1260" layouth="138">
                <thead>
                    <tr>
                        <th width="100">新闻图片</th>
                        <th width="200">新闻标题</th>
                        <th width="300">新闻简介</th>
                        <th width="100">新闻来源</th>
                        <th width="70">新闻类型</th>
                        <th width="70">是否显示</th>
                        <th width="60">优先值</th>
                        <%--<th>发布者</th>--%>
                        <th width="130">发布时间</th>
                        <th width="130">修改时间</th>
                        <th class="operate" width="60">操作</th>
                    </tr>
                </thead>
                <tbody id="tbodyNewsList">
                    <%if (dt != null)
                      {
                          foreach (System.Data.DataRow dr in dt.Rows)
                          {%>
                    <tr>
                        <td>
                            <img src="<%= dr["ImgUrl"] %>" style="max-height: 100px; max-width: 100px;" onerror="$(this).hide()" />
                        </td>
                        <td title="<%= dr["Title"] %>"><%= dr["Title"] %></td>
                        <td title="<%= dr["Description"] %>"><%= dr["Description"] %></td>
                        <td><%= dr["Source"] %></td>
                        <td><%= dr["TypeName"] %></td>
                        <td><%= Maticsoft.Common.CommonHelper.Toint(dr["Status"])==1?"显示中":"不显示" %></td>
                        <td><%= dr["Sort"] %></td>
                        <%--<td><%= dr["ManagerID"] %></td>--%>
                        <td class="operate"><%=dr["AddTime"] %> </td>
                        <td class="operate"><%=dr["EditTime"] %> </td>
                        <td>
                            <a title="编辑" class="btnEdit" href="/TowGAdmin/SystemSet/AENews.aspx?nid=<%=dr["KeyID"] %>" target="dialog" fresh="false" width="1000" height="610">编辑</a>
                            <a title="删除" class="btnDel" href="javascript:void();" onclick="deleteConfirmMsg('/TowGAdmin/Ajax/TX_Handler.ashx?action=DeleteNews&nid=<%= dr["KeyID"] %>')">删除</a>
                        </td>
                    </tr>
                    <%}
                      } %>
                </tbody>
            </table>
            <div class="panelBar" style="display: block;">
                <div class="pages">
                    <span>显示</span>
                    <select class="combox" onchange="navTabPageBreak({numPerPage:this.value},'NewsList')">
                        <option value="20" <%=page.numPerPage==20?"selected='selected'":"" %>>20</option>
                        <option value="50" <%=page.numPerPage==50?"selected='selected'":"" %>>50</option>
                        <option value="100" <%=page.numPerPage==100?"selected='selected'":"" %>>100</option>
                        <option value="200" <%=page.numPerPage==200?"selected='selected'":"" %>>200</option>
                    </select>
                    <span>条，共<%=page.totalCount %>条</span>
                </div>
                <div style="display: block;" class="pagination" rel="NewsList" targettype="navTab" totalcount="<%=page.totalCount %>" numperpage="<%=page.numPerPage %>" pagenumshown="5" currentpage="<%=page.pageNum %>"></div>
            </div>
        </div>
    </form>
</body>
</html>
