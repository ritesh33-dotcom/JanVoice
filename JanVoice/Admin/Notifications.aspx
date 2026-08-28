<%@ Page Title="Notifications"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="Notifications.aspx.cs"
    Inherits="JanVoice.Admin.Notifications" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/AdminNotifications.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="notifications-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="notifications-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Notifications
                </h1>

                <p>
                    Stay updated with important activities and system alerts.
                </p>

            </div>


            <div class="notification-header-actions">

                <asp:LinkButton
                    ID="btnMarkAllRead"
                    runat="server"
                    CssClass="mark-all-btn"
                    OnClick="btnMarkAllRead_Click">

                    <span class="mark-read-icon">✓</span>

                    <span>
                        Mark All as Read
                    </span>

                </asp:LinkButton>

            </div>

        </div>



        <!-- =====================================
             NOTIFICATION SUMMARY
        ====================================== -->

        <div class="notification-summary">


            <!-- TOTAL -->

            <div class="notification-summary-card">

                <div class="summary-icon total-icon">
                    🔔
                </div>

                <div class="summary-info">

                    <span>
                        Total Notifications
                    </span>

                    <asp:Label
                        ID="lblTotalNotifications"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </div>

            </div>



            <!-- UNREAD -->

            <div class="notification-summary-card">

                <div class="summary-icon unread-icon">
                    ●
                </div>

                <div class="summary-info">

                    <span>
                        Unread
                    </span>

                    <asp:Label
                        ID="lblUnreadNotifications"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </div>

            </div>



            <!-- IMPORTANT -->

            <div class="notification-summary-card">

                <div class="summary-icon warning-icon">
                    ⚠
                </div>

                <div class="summary-info">

                    <span>
                        Important
                    </span>

                    <asp:Label
                        ID="lblImportantNotifications"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </div>

            </div>


        </div>



        <!-- =====================================
             FILTER BAR
        ====================================== -->

        <div class="notifications-toolbar">


            <!-- TABS -->

            <div class="notification-tabs">

                <asp:LinkButton
                    ID="btnAll"
                    runat="server"
                    CssClass="notification-tab active"
                    CommandArgument="All"
                    OnClick="NotificationTab_Click">

                    All

                </asp:LinkButton>


                <asp:LinkButton
                    ID="btnUnread"
                    runat="server"
                    CssClass="notification-tab"
                    CommandArgument="Unread"
                    OnClick="NotificationTab_Click">

                    Unread

                </asp:LinkButton>


                <asp:LinkButton
                    ID="btnImportant"
                    runat="server"
                    CssClass="notification-tab"
                    CommandArgument="Important"
                    OnClick="NotificationTab_Click">

                    Important

                </asp:LinkButton>

            </div>



            <!-- SEARCH -->

            <div class="notification-search">

                <span>
                    🔍
                </span>

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="notification-search-input"
                    placeholder="Search notifications..."
                    MaxLength="100">
                </asp:TextBox>

            </div>



            <!-- TYPE -->

            <asp:DropDownList
                ID="ddlNotificationType"
                runat="server"
                CssClass="notification-filter">

                <asp:ListItem
                    Text="All Types"
                    Value="">
                </asp:ListItem>

            </asp:DropDownList>



            <!-- APPLY -->

            <asp:Button
                ID="btnApplyFilter"
                runat="server"
                Text="Apply Filters"
                CssClass="filter-btn"
                OnClick="btnApplyFilter_Click" />

        </div>



        <!-- =====================================
             MAIN NOTIFICATIONS CARD
        ====================================== -->

        <div class="notifications-card">


            <!-- CARD HEADER -->

            <div class="notifications-card-header">

                <div>

                    <h3>
                        Recent Notifications
                    </h3>

                    <p>
                        Latest activities and alerts relevant to your administration.
                    </p>

                </div>


                <asp:Label
                    ID="lblNotificationCount"
                    runat="server"
                    CssClass="notification-count"
                    Text="0 Notifications">
                </asp:Label>

            </div>



            <!-- =====================================
                 DYNAMIC NOTIFICATION LIST
            ====================================== -->

            <asp:Repeater
                ID="rptNotifications"
                runat="server"
                OnItemDataBound="rptNotifications_ItemDataBound">

                <HeaderTemplate>

                    <div class="notification-list">

                </HeaderTemplate>


                <ItemTemplate>

                    <div class='<%# GetNotificationItemClass(Eval("IsRead")) %>'>


                        <!-- ICON -->

                        <div class='<%# GetNotificationIconClass(Eval("NotificationType")) %>'>

                            <%# GetNotificationIcon(Eval("NotificationType")) %>

                        </div>



                        <!-- CONTENT -->

                        <div class="notification-content">

                            <div class="notification-title-row">

                                <strong>
                                    <%# Server.HtmlEncode(Convert.ToString(Eval("Title"))) %>
                                </strong>

                                <%# GetUnreadDot(Eval("IsRead")) %>

                                <%# GetImportantBadge(
                                        Eval("NotificationType"),
                                        Eval("Title")) %>

                            </div>


                            <p>
                                <%# Server.HtmlEncode(Convert.ToString(Eval("Message"))) %>
                            </p>


                            <div class="notification-meta">

                                <span>
                                    <%# Server.HtmlEncode(
                                            Convert.ToString(
                                                Eval("NotificationType"))) %>
                                </span>

                                <span>
                                    •
                                </span>

                                <span>
                                    <%# GetTimeAgo(Eval("CreatedDate")) %>
                                </span>

                            </div>

                        </div>



                        <!-- VIEW -->

                        <div class="notification-action">

                            <asp:HyperLink
                                ID="lnkView"
                                runat="server"
                                CssClass="notification-view-btn"
                                Text="View">
                            </asp:HyperLink>

                        </div>

                    </div>

                </ItemTemplate>


                <FooterTemplate>

                    </div>

                </FooterTemplate>

            </asp:Repeater>



            <!-- =====================================
                 EMPTY STATE
            ====================================== -->

            <asp:Panel
                ID="pnlEmpty"
                runat="server"
                CssClass="notifications-empty"
                Visible="false">

                <div class="notifications-empty-icon">
                    🔔
                </div>

                <h4>
                    No Notifications
                </h4>

                <p>
                    There are no notifications matching your current filters.
                </p>

            </asp:Panel>


        </div>

    </div>

</asp:Content>