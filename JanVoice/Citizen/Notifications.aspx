<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="JanVoice.Citizen.Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/notifications.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="notification-page">

        <!-- Page Header -->

        <div class="page-header">

            <h1>Notifications</h1>

            <p>Stay updated with every activity on your complaints.</p>

        </div>

        <!-- Notification List -->

        <div class="notification-container">

            <asp:Repeater
                ID="rptNotifications"
                runat="server">

                <ItemTemplate>

                    <div class='notification-card <%# Convert.ToBoolean(Eval("IsRead")) ? "read" : "unread" %>'>

                        <!-- Left Icon -->

                        <div class="notification-icon">
                            🔔

                        </div>

                        <!-- Content -->

                        <div class="notification-content">

                            <h3>

                                <%# Eval("Title") %>

                            </h3>

                            <p>

                                <%# Eval("Message") %>
                            </p>

                            <small>

                                <%# Eval("CreatedDate","{0:dd MMM yyyy hh:mm tt}") %>

                            </small>

                        </div>

                        <!-- View Button -->

                        <div>

                           <asp:Button
                            ID="btnOpen"
                            runat="server"
                            Text="View"
                            CssClass="view-btn"
                            CommandArgument='<%# Eval("NotificationID") + "|" + Eval("ComplaintID") %>'
                            OnCommand="btnOpen_Command" />

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

            <div id="divNoNotification"
                runat="server"
                class="empty-message"
                visible="false">

                <img src="../Assets/Images/no-notification.png"
                    class="empty-image" />

                <h2>No Notifications</h2>

                <p>
                    You don't have any notifications yet.
                </p>

            </div>



        </div>

    </div>

</asp:Content>
