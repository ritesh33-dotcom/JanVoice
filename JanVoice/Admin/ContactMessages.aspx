<%@ Page Title="Contact Messages"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ContactMessages.aspx.cs"
    Inherits="JanVoice.Admin.ContactMessages" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ContactMessages.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="contact-messages-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="messages-header">

            <div>

                <span class="page-label">JANVOICE ADMINISTRATION
                </span>

                <h1>Contact Messages
                </h1>

                <p>
                    Review and manage messages received from citizens.
                </p>

            </div>


            <div class="messages-header-info">

                <span>INBOX
                </span>

                <strong>Citizen Communication
                </strong>

            </div>

        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->


        <div class="message-stats">

            <div class="message-stat-card">

                <div class="message-stat-icon">
                    ✉
                </div>

                <div>
                    <span>Total Messages</span>

                    <strong>
                        <asp:Label ID="lblTotalMessages"
                            runat="server"
                            Text="0" />
                    </strong>
                </div>

            </div>


            <div class="message-stat-card">

                <div class="message-stat-icon unread-icon">
                    ●
                </div>

                <div>
                    <span>Unread</span>

                    <strong>
                        <asp:Label ID="lblUnreadMessages"
                            runat="server"
                            Text="0" />
                    </strong>
                </div>

            </div>


            <div class="message-stat-card">

                <div class="message-stat-icon read-icon">
                    ✓
                </div>

                <div>
                    <span>Read</span>

                    <strong>
                        <asp:Label ID="lblReadMessages"
                            runat="server"
                            Text="0" />
                    </strong>
                </div>

            </div>


            <div class="message-stat-card">

                <div class="message-stat-icon month-icon">
                    ◷
                </div>

                <div>
                    <span>This Month</span>

                    <strong>
                        <asp:Label ID="lblMonthMessages"
                            runat="server"
                            Text="0" />
                    </strong>
                </div>

            </div>

        </div>

        <!-- =====================================
             SEARCH / FILTER TOOLBAR
        ====================================== -->

        <div class="messages-toolbar">

            <div class="message-search">

                <span>🔍</span>

                <asp:TextBox ID="txtSearch"
                    runat="server"
                    placeholder="Search by name, email or subject..." />

            </div>


            <asp:DropDownList ID="ddlStatus"
                runat="server"
                CssClass="message-filter">

                <asp:ListItem Text="All Status"
                    Value="" />

                <asp:ListItem Text="Unread"
                    Value="0" />

                <asp:ListItem Text="Read"
                    Value="1" />

            </asp:DropDownList>


            <asp:DropDownList ID="ddlTime"
                runat="server"
                CssClass="message-filter">

                <asp:ListItem Text="All Time"
                    Value="" />

                <asp:ListItem Text="Today"
                    Value="Today" />

                <asp:ListItem Text="This Week"
                    Value="Week" />

                <asp:ListItem Text="This Month"
                    Value="Month" />

            </asp:DropDownList>


            <asp:Button ID="btnApplyFilters"
                runat="server"
                Text="Apply Filters"
                CssClass="filter-btn"
                OnClick="btnApplyFilters_Click" />

        </div>


        <!-- =====================================
             MESSAGES CARD
        ====================================== -->

        <div class="messages-card">

            <div class="messages-card-header">

                <div>

                    <h3>Received Messages
                    </h3>

                    <p>
                        Messages submitted through the JanVoice contact form.
                    </p>

                </div>


                <span class="record-count">

                    <asp:Label ID="lblRecordCount"
                        runat="server"
                        Text="0" />

                    Messages

                </span>

            </div>


            <div class="messages-table-wrapper">

                <table class="messages-table">

                    <thead>

                        <tr>

                            <th>SENDER</th>

                            <th>SUBJECT</th>

                            <th>EMAIL</th>

                            <th>RECEIVED</th>

                            <th>STATUS</th>

                            <th>ACTION</th>

                        </tr>

                    </thead>


                    <tbody>

                        <asp:Repeater ID="rptMessages"
                            runat="server">

                            <HeaderTemplate>

                                <table class="messages-table">

                                    <thead>
                                        <tr>
                                            <th>SENDER</th>
                                            <th>SUBJECT</th>
                                            <th>EMAIL</th>
                                            <th>RECEIVED</th>
                                            <th>STATUS</th>
                                            <th>ACTION</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>


                            <ItemTemplate>

                                <tr>

                                    <td>
                                        <%# Eval("FullName") %>
                                    </td>

                                    <td>
                                        <%# Eval("Subject") %>
                                    </td>

                                    <td>
                                        <%# Eval("Email") %>
                                    </td>

                                    <td>
                                        <%# Convert.ToDateTime(Eval("SubmittedDate"))
                    .ToString("dd MMM yyyy") %>
                                    </td>

                                    <td>
                                        <%# Convert.ToBoolean(Eval("IsReplied"))
                    ? "Read"
                    : "Unread" %>
                                    </td>

                                    <td>
                                        <asp:LinkButton
                                            ID="btnView"
                                            runat="server"
                                            CommandName="ViewMessage"
                                            CommandArgument='<%# Eval("MessageID") %>'
                                            CssClass="view-message-btn">

                    View

                                        </asp:LinkButton>
                                    </td>

                                </tr>

                            </ItemTemplate>


                            <FooterTemplate>
                                </tbody>

        </table>

                            </FooterTemplate>

                        </asp:Repeater>


                        <!-- EMPTY STATE -->

                        <asp:Panel ID="pnlEmpty"
                            runat="server"
                            CssClass="messages-empty"
                            Visible="false">

                            <div class="empty-icon">
                                ✉
                            </div>

                            <h3>No Messages Found
                            </h3>

                            <p>
                                There are no contact messages matching your current filters.
                            </p>

                        </asp:Panel>

                    </tbody>

                </table>

            </div>

        </div>

        <asp:Panel ID="pnlViewMessage"
            runat="server"
            Visible="false"
            CssClass="message-modal-overlay">

            <div class="message-modal">

                <div class="message-modal-header">

                    <div>

                        <span class="page-label">CITIZEN MESSAGE
                        </span>

                        <h3>
                            <asp:Label ID="lblViewSubject"
                                runat="server" />
                        </h3>

                    </div>


                    <asp:LinkButton
                        ID="btnCloseMessage"
                        runat="server"
                        CssClass="modal-close-btn"
                        OnClick="btnCloseMessage_Click">

                ×

                    </asp:LinkButton>

                </div>


                <div class="message-modal-body">


                    <div class="message-detail-grid">

                        <div>

                            <span>FROM
                            </span>

                            <strong>
                                <asp:Label ID="lblViewName"
                                    runat="server" />
                            </strong>

                        </div>


                        <div>

                            <span>EMAIL
                            </span>

                            <strong>
                                <asp:Label ID="lblViewEmail"
                                    runat="server" />
                            </strong>

                        </div>


                        <div>

                            <span>MOBILE
                            </span>

                            <strong>
                                <asp:Label ID="lblViewMobile"
                                    runat="server" />
                            </strong>

                        </div>


                        <div>

                            <span>RECEIVED
                            </span>

                            <strong>
                                <asp:Label ID="lblViewDate"
                                    runat="server" />
                            </strong>

                        </div>

                    </div>


                    <div class="message-content-box">

                        <span>MESSAGE
                        </span>

                        <p>
                            <asp:Label ID="lblViewMessage"
                                runat="server" />
                        </p>

                    </div>


                    <div class="message-modal-footer">

                        <asp:Button
                            ID="btnMarkReplied"
                            runat="server"
                            Text="Mark as Replied"
                            CssClass="filter-btn"
                            OnClick="btnMarkReplied_Click" />

                    </div>

                </div>

            </div>

        </asp:Panel>
    </div>
    <asp:HiddenField
        ID="hfMessageID"
        runat="server"
        Value="0" />

</asp:Content>
