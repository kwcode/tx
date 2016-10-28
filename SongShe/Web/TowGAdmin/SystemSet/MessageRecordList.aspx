<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MessageRecordList.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.SystemSet.MessageRecordList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>留言信息管理</title>
    <style>
        #tbodyMessageRecordList div {
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
                            navTab.reload("", { navTabId: "MessageRecordList" });
                        }
                    });
                }
            });
        }
        function updateConfirmMsg(url) {
            alertMsg.confirm("确定要更改为已处理状态吗？", {
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
                            navTab.reload("", { navTabId: "MessageRecordList" });
                        }
                    });
                }
            });
        }
    </script>
</head>
<body>
    <form rel="ManagerList" runat="server" onsubmit="return navTabSearch(this);" action="/TowGAdmin/SystemSet/MessageRecordList.aspx" method="post">
        <div class="pageContent j-resizeGrid">
            <input type="hidden" name="pageNum" value="1" />
            <input type="hidden" name="numPerPage" value="<%=page.numPerPage %>" />
            <div class="pageHeader">
                <div class="searchBar" style="margin-top: 5px; margin-bottom: 5px;">
                    <table class="searchContent">
                        <tr>
                            <td></td>
                            <td>检索条件： 留言类型：<select name="GroupName" style="float: none;">
                                <option value="">全部</option>
                                <option value="yycg" <%=GroupName=="yycg"?"selected='selected'":"" %>>预约参观</option>
                                <option value="tsjy" <%=GroupName=="tsjy"?"selected='selected'":"" %>>投诉及建议</option>
                            </select>
                                &nbsp;&nbsp;&nbsp; 处理状态：<select name="Status" style="float: none;">
                                    <option value="-1" <%=Status==-1?"selected='selected'":"" %>>全部</option>
                                    <option value="0" <%=Status==0?"selected='selected'":"" %>>未处理</option>
                                    <option value="1" <%=Status==1?"selected='selected'":"" %>>已处理</option>
                                </select>
                            </td>
                            <td>
                                <div class="buttonActive">
                                    <div class="buttonContent">
                                        <button type="submit">搜索</button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <table class="table" width="1260" layouth="138">
                <thead>
                    <tr>
                        <th width="100">姓名</th>
                        <th width="100">联系电话</th>
                        <th width="80">留言类型</th>
                        <th width="120">邮箱</th>
                        <th width="150">投诉类型</th>
                        <th width="300">投诉内容</th>
                        <th width="80">处理状态</th>
                        <th width="120">留言时间</th>
                        <th class="operate" width="60">操作</th>
                    </tr>
                </thead>
                <tbody id="tbodyMessageRecordList">
                    <%if (dt != null)
                      {
                          foreach (System.Data.DataRow dr in dt.Rows)
                          {
                              Status = Maticsoft.Common.CommonHelper.Toint(dr["Status"]);%>
                    <tr>
                        <td title="<%= dr["Name"] %>">
                            <%= dr["Name"] %>
                        </td>
                        <td title="<%= dr["Phone"] %>"><%= dr["Phone"] %></td>
                        <td title="<%=dGroupName.Where(g=>g.Key.Equals(dr["GroupName"])).Count()>0?dGroupName[dr["GroupName"].ToString()]:dr["GroupName"].ToString() %>"><%=dGroupName.Where(g=>g.Key.Equals(dr["GroupName"])).Count()>0?dGroupName[dr["GroupName"].ToString()]:dr["GroupName"].ToString() %></td>
                        <td title="<%= dr["Email"] %>"><%=dr["Email"] %></td>
                        <td title="<%= dr["ComplaintType"] %>"><%= dr["ComplaintType"] %></td>
                        <td title="<%=dr["Content"]==null?"":dr["Content"].ToString().Replace("\r\n","<br/>").Replace("\r","<br/>").Replace("\n","<br/>").Replace(" ","&nbsp;") %>"><%=dr["Content"]==null?"":dr["Content"].ToString().Replace("\r\n","<br/>").Replace("\r","<br/>").Replace("\n","<br/>").Replace(" ","&nbsp;") %></td>
                        <td><%=Status==1?"已处理":"未处理" %></td>
                        <td class="operate"><%=dr["AddTime"] %> </td>
                        <td>
                            <%if (Status != 1)
                              { %>
                            <a title="处理" class="btnEdit" href="javascript:void();" onclick="updateConfirmMsg('/TowGAdmin/Ajax/TX_Handler.ashx?action=UpdateMessageRecordStatus&mid=<%= dr["KeyID"] %>')">已处理</a>
                            <%} %>
                            <a title="删除" class="btnDel" href="javascript:void();" onclick="deleteConfirmMsg('/TowGAdmin/Ajax/TX_Handler.ashx?action=DeleteMessageRecord&mid=<%= dr["KeyID"] %>')">删除</a>
                        </td>
                    </tr>
                    <%}
                      } %>
                </tbody>
            </table>
            <div class="panelBar" style="display: block;">
                <div class="pages">
                    <span>显示</span>
                    <select class="combox" onchange="navTabPageBreak({numPerPage:this.value},'MessageRecordList')">
                        <option value="20" <%=page.numPerPage==20?"selected='selected'":"" %>>20</option>
                        <option value="50" <%=page.numPerPage==50?"selected='selected'":"" %>>50</option>
                        <option value="100" <%=page.numPerPage==100?"selected='selected'":"" %>>100</option>
                        <option value="200" <%=page.numPerPage==200?"selected='selected'":"" %>>200</option>
                    </select>
                    <span>条，共<%=page.totalCount %>条</span>
                </div>
                <div style="display: block;" class="pagination" rel="MessageRecordList" targettype="navTab" totalcount="<%=page.totalCount %>" numperpage="<%=page.numPerPage %>" pagenumshown="5" currentpage="<%=page.pageNum %>"></div>
            </div>
        </div>
    </form>
</body>
</html>
