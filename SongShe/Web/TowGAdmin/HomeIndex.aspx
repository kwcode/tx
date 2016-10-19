<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeIndex.aspx.cs" Inherits="Maticsoft.Web.TowGAdmin.HomeIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>颂玺母婴后台管理</title>
    <link href="/TowGAdmin/themes/default/style.css" rel="stylesheet" />
    <link href="/TowGAdmin/themes/css/core.css" rel="stylesheet" />
    <link href="/TowGAdmin/themes/css/print.css" rel="stylesheet" />
    <link href="/OtherResource/uploadify/css/uploadify.css" rel="stylesheet" />
    <%--<script src="/UserJs/jquery-1.11.3.min.js"></script>
    <script src="/OtherResource/DWZ/jquery-2.1.4.min.js"></script>--%>
    <script src="/OtherResource/DWZ/jquery-2.1.4.js"></script>
    <script src="/UserJs/jquery.bgiframe.js"></script>
    <script src="/UserJs/jquery.cookie.js"></script>
    <script src="/UserJs/jquery.validate.js"></script>
    <script src="/OtherResource/xheditor/xheditor-1.2.2.min.js"></script>
    <script src="/OtherResource/xheditor/xheditor_lang/zh-cn.js"></script>
    <script src="/OtherResource/uploadify/scripts/jquery.uploadify.js"></script>

    <script type="text/javascript" src="/OtherResource/chart/raphael-min.js"></script>
    <script type="text/javascript" src="/OtherResource/chart/g.raphael.js"></script>
    <script type="text/javascript" src="/OtherResource/chart/g.bar.js"></script>
    <script type="text/javascript" src="/OtherResource/chart/g.line.js"></script>
    <script type="text/javascript" src="/OtherResource/chart/g.pie.js"></script>
    <script type="text/javascript" src="/OtherResource/chart/g.dot.js"></script>

    <script src="/OtherResource/DWZ/dwz.core.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.util.date.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.validate.method.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.barDrag.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.drag.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.tree.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.accordion.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.ui.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.theme.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.switchEnv.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.alertMsg.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.contextmenu.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.navTab.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.tab.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.resize.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.dialog.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.dialogDrag.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.sortDrag.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.cssTable.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.stable.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.taskBar.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.ajax.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.pagination.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.database.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.datepicker.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.effects.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.panel.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.checkbox.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.history.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.combox.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.print.js" type="text/javascript"></script>
    <script src="/OtherResource/DWZ/dwz.regional.zh.js"></script>

    <script src="/UserJs/jquery.form.js"></script>

    <script type="text/javascript">
        $(function () {
            DWZ.init("dwz.frag.xml", {
                loginUrl: "login_dialog.html", loginTitle: "登录",	// 弹出登录对话框
                //		loginUrl:"login.html",	// 跳到登录页面
                statusCode: { ok: 200, error: 300, timeout: 301 }, //【可选】
                pageInfo: { pageNum: "pageNum", numPerPage: "numPerPage", orderField: "orderField", orderDirection: "orderDirection" }, //【可选】
                keys: { statusCode: "statusCode", message: "message" }, //【可选】
                ui: { hideMode: 'offsets' }, //【可选】hideMode:navTab组件切换的隐藏方式，支持的值有’display’，’offsets’负数偏移位置的值，默认值为’display’
                debug: false,	// 调试模式 【true|false】
                callback: function () {
                    initEnv();
                    $("#themeList").theme({ themeBase: "themes" }); // themeBase 相对于index页面的主题base路径
                }
            });
            $("#a_HomeMain").click();
            showTimes();
        });

        function showTimes() {
            var today = new Date();//获得当前时间
            var hh = today.getHours(); //获得小时、分钟、秒
            var mm = today.getMinutes();
            if (mm.toString().length < 2)
                mm = '0' + mm;
            var ss = today.getSeconds();
            if (ss.toString().length < 2)
                ss = '0' + ss;
            /*设置div的内容为当前时间*/
            document.getElementById("a_Times").innerHTML = "现在是:" + hh + ":" + mm + ":" + ss;
            /*
            使用setTimeout在函数disptime()体内再次调用setTimeout
            设置定时器每隔1秒（1000毫秒），调用函数disptime()执行，刷新时钟显示
            */
            var myTime = setTimeout("showTimes()", 1000);
        }

        function LogOut() {
            $.ajax({
                type: "post",
                url: "/TowGAdmin/Ajax/W_Handler.ashx",
                dataType: "text",
                data: { "action": "LogOut", r: Math.random() },
                success: function (data) { window.location.href = data; window.top.location.href = "/TowGAdmin/Login.aspx" }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="layout" style="display: block;">
            <div id="header">
                <div class="headerNav">
                    <%--<a class="logo" href="#">OHI8</a>--%>
                    <span style="color:white;font-size:26px;position:relative;top:10px;left:15px;font-family:SimHei;">颂玺母婴后台管理系统</span>
                    <ul class="nav" id="ul_TopContent">
                        <li><a href="javascript:void(0);"><%=manager==null?"":manager.ManagerName %>欢迎使用本系统</a></li>
                        <li><a id="a_Times" href="javascript:void(0);"></a></li>
                        <li><a href="#" onclick="LogOut();">退出</a></li>
                    </ul>
                    <ul class="themeList" id="themeList">
                        <li theme="default">
                            <div class="selected">蓝色</div>
                        </li>
                        <li theme="green">
                            <div>绿色</div>
                        </li>
                        <!--<li theme="red"><div>红色</div></li>-->
                        <li theme="purple">
                            <div>紫色</div>
                        </li>
                        <li theme="silver">
                            <div>银色</div>
                        </li>
                        <li theme="azure">
                            <div>天蓝</div>
                        </li>
                    </ul>
                </div>

                <!-- navMenu -->

            </div>

            <div id="leftside">
                <div id="sidebar_s">
                    <div class="collapse">
                        <div class="toggleCollapse">
                            <div></div>
                        </div>
                    </div>
                </div>
                <div id="sidebar">
                    <div class="toggleCollapse">
                        <h2>主菜单</h2>
                        <div>收缩</div>
                    </div>

                    <div class="accordion" fillspace="sidebar">
                        <div class="accordionHeader">
                            <h2>系统管理</h2>
                        </div>
                        <div class="accordionContent">
                            <ul class="tree">
                                <li><a>系统管理</a>
                                    <ul>
                                        <li><a href="/TowGAdmin/SystemSet/ManagerList.aspx" target="navTab" rel="ManagerList" fresh="false">用户管理</a></li>
                                        <li><a href="/TowGAdmin/SystemSet/NewsList.aspx" target="navTab" rel="NewsList" fresh="false">新闻管理</a></li>
                                        <li><a href="/TowGAdmin/SystemSet/TeamList.aspx" target="navTab" rel="TeamList" fresh="false">团队信息管理</a></li>
                                    </ul>
                                </li>
                                <li><a>前台页面数据管理</a>
                                    <ul>
                                        <li><a href="/TowGAdmin/PageData/MenuList.aspx" target="navTab" rel="MenuList">菜单栏目管理</a></li>
                                        <li><a href="/TowGAdmin/PageData/PageIndex.aspx" target="navTab" rel="MenuList">首页环境展示图片管理</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div id="container">
                <div id="navTab" class="tabsPage">
                    <div class="tabsPageHeader">
                        <div class="tabsPageHeaderContent">
                            <!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
                            <ul class="navTab-tab">
                                <li tabid="main" class="main"><a href="javascript:;"><span><span class="home_icon">会员管理</span></span></a></li>
                            </ul>
                        </div>
                        <div class="tabsLeft">left</div>
                        <!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
                        <div class="tabsRight">right</div>
                        <!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
                        <div class="tabsMore">more</div>
                    </div>
                    <ul class="tabsMoreList">
                        <li><a href="/TowGAdmin/Members/MemeberList.aspx" target="navTab" rel="main">会员管理</a></li>
                    </ul>
                    <div class="navTab-panel tabsPageContent layoutBox">
                        <div class="page unitBox">
                            <div class="pageFormContent" layouth="80" style="margin-right: 230px">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div id="footer" style="display: block; height: auto;">本系统所有权归奉爱科技所有</div>
    </form>
</body>
</html>
