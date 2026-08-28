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
    <style>
        
/*==========================================
        MESSAGE MODAL
==========================================*/

.message-modal-overlay {
    position: fixed;
    inset: 0;
    z-index: 9999;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    background: rgba(2, 6, 23, .78);
    backdrop-filter: blur(7px);
}

.message-modal {
    width: 100%;
    max-width: 650px;
    max-height: 90vh;
    overflow-y: auto;
    background: #1E293B;
    border: 1px solid rgba(255,255,255,.10);
    border-radius: 18px;
    box-shadow: 0 30px 80px rgba(0,0,0,.45);
}

.message-modal-header {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 20px;
    padding: 22px;
    border-bottom: 1px solid rgba(255,255,255,.07);
}

    .message-modal-header h3 {
        margin: 8px 0 0;
        color: #F8FAFC;
        font-size: 18px;
    }

.modal-close-btn {
    width: 34px;
    height: 34px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 9px;
    background: rgba(255,255,255,.06);
    color: #94A3B8;
    font-size: 22px;
    text-decoration: none;
    transition: .2s;
}

    .modal-close-btn:hover {
        background: rgba(239,68,68,.12);
        color: #FCA5A5;
    }

.message-modal-body {
    padding: 22px;
}

.message-detail-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
    margin-bottom: 22px;
}

    .message-detail-grid > div {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .message-detail-grid span,
    .message-content-box > span {
        color: #64748B;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 1px;
    }

    .message-detail-grid strong {
        color: #E2E8F0;
        font-size: 13px;
        word-break: break-word;
    }

.message-content-box {
    padding: 18px;
    border-radius: 12px;
    background: rgba(15,23,42,.55);
    border: 1px solid rgba(255,255,255,.06);
}

    .message-content-box p {
        margin: 10px 0 0;
        color: #CBD5E1;
        font-size: 13px;
        line-height: 1.7;
        white-space: pre-wrap;
    }

.message-modal-footer {
    display: flex;
    justify-content: flex-end;
    margin-top: 20px;
}

.messages-empty {
    padding: 55px 20px;
    text-align: center;
}

    .messages-empty > div {
        width: 58px;
        height: 58px;
        margin: auto;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 16px;
        background: rgba(59,130,246,.08);
        font-size: 24px;
    }

    .messages-empty h3 {
        margin: 15px 0 7px;
        color: #E2E8F0;
        font-size: 15px;
    }

    .messages-empty p {
        margin: 0;
        color: #64748B;
        font-size: 12px;
    }


@media (max-width: 650px) {

    .message-detail-grid {
        grid-template-columns: 1fr;
    }

    .message-modal {
        max-height: 94vh;
    }

    .message-modal-header,
    .message-modal-body {
        padding: 18px;
    }
}
    </style>

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

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Contact Messages
                </h1>

                <p>
                    Review and manage messages received from citizens.
                </p>

            </div>


            <div class="messages-header-info">

                <span>INBOX</span>

                <strong>
                    Citizen Communication
                </strong>

            </div>

        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="message-stats">

            <!-- TOTAL -->

            <div class="message-stat-card">

                <div class="message-stat-icon">
                    ✉
                </div>

                <div>

                    <span>Total Messages</span>

                    <strong>
                        <asp:Label
                            ID="lblTotalMessages"
                            runat="server"
                            Text="0" />
                    </strong>

                </div>

            </div>


            <!-- UNREAD -->

            <div class="message-stat-card">

                <div class="message-stat-icon unread-icon">
                    ●
                </div>

                <div>

                    <span>Unread</span>

                    <strong>
                        <asp:Label
                            ID="lblUnreadMessages"
                            runat="server"
                            Text="0" />
                    </strong>

                </div>

            </div>


            <!-- READ -->

            <div class="message-stat-card">

                <div class="message-stat-icon read-icon">
                    ✓
                </div>

                <div>

                    <span>Read</span>

                    <strong>
                        <asp:Label
                            ID="lblReadMessages"
                            runat="server"
                            Text="0" />
                    </strong>

                </div>

            </div>


            <!-- MONTH -->

            <div class="message-stat-card">

                <div class="message-stat-icon month-icon">
                    ◷
                </div>

                <div>

                    <span>This Month</span>

                    <strong>
                        <asp:Label
                            ID="lblMonthMessages"
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

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    placeholder="Search by name, email or subject..." />

            </div>


            <asp:DropDownList
                ID="ddlStatus"
                runat="server"
                CssClass="message-filter">

                <asp:ListItem
                    Text="All Status"
                    Value="" />

                <asp:ListItem
                    Text="Unread"
                    Value="0" />

                <asp:ListItem
                    Text="Read"
                    Value="1" />

            </asp:DropDownList>


            <asp:DropDownList
                ID="ddlTime"
                runat="server"
                CssClass="message-filter">

                <asp:ListItem
                    Text="All Time"
                    Value="" />

                <asp:ListItem
                    Text="Today"
                    Value="Today" />

                <asp:ListItem
                    Text="This Week"
                    Value="Week" />

                <asp:ListItem
                    Text="This Month"
                    Value="Month" />

            </asp:DropDownList>


            <asp:Button
                ID="btnApplyFilters"
                runat="server"
                Text="Apply Filters"
                CssClass="filter-btn"
                OnClick="btnApplyFilters_Click" />

        </div>



        <!-- =====================================
             MESSAGES CARD
        ====================================== -->

        <div class="messages-card">

            <!-- CARD HEADER -->

            <div class="messages-card-header">

                <div>

                    <h3>
                        Received Messages
                    </h3>

                    <p>
                        Messages submitted through the JanVoice contact form.
                    </p>

                </div>


                <span class="record-count">

                    <asp:Label
                        ID="lblRecordCount"
                        runat="server"
                        Text="0" />

                    Messages

                </span>

            </div>



            <!-- =====================================
                 TABLE
            ====================================== -->

            <div class="messages-table-wrapper">

                <asp:Repeater
                    ID="rptMessages"
                    runat="server"
                    OnItemCommand="rptMessages_ItemCommand">

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

                            <!-- SENDER -->

                            <td>

                                <div class="sender-cell">

                                    <div class='sender-avatar <%# GetAvatarClass(Eval("FullName")) %>'>

                                        <%# GetInitial(Eval("FullName")) %>

                                    </div>


                                    <div class="sender-info">

                                        <strong>
                                            <%#: Eval("FullName") %>
                                        </strong>

                                        <span>
                                            Citizen
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <!-- SUBJECT -->

                            <td>

                                <div class="subject-cell">

                                    <strong>
                                        <%#: Eval("Subject") %>
                                    </strong>

                                    <span>
                                        <%# GetMessagePreview(Eval("Message")) %>
                                    </span>

                                </div>

                            </td>



                            <!-- EMAIL -->

                            <td>

                                <span class="email-text">
                                    <%#: Eval("Email") %>
                                </span>

                            </td>



                            <!-- DATE -->

                            <td>

                                <%# Convert.ToDateTime(
                                        Eval("SubmittedDate")
                                    ).ToString("dd MMM yyyy") %>

                            </td>



                            <!-- STATUS -->

                            <td>

                                <span class='message-status <%# Convert.ToBoolean(Eval("IsRead")) ? "read" : "unread" %>'>

                                    <%# Convert.ToBoolean(Eval("IsRead"))
                                        ? "Read"
                                        : "Unread" %>

                                </span>

                            </td>



                            <!-- ACTION -->

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

            </div>



            <!-- =====================================
                 EMPTY STATE
            ====================================== -->

            <asp:Panel
                ID="pnlEmpty"
                runat="server"
                CssClass="messages-empty"
                Visible="false">

                <div class="empty-icon">
                    ✉
                </div>

                <h3>
                    No Messages Found
                </h3>

                <p>
                    There are no contact messages matching your current filters.
                </p>

            </asp:Panel>

        </div>



        <!-- =====================================
             MESSAGE MODAL
        ====================================== -->

        <asp:Panel
            ID="pnlViewMessage"
            runat="server"
            Visible="false"
            CssClass="message-modal-overlay">

            <div class="message-modal">

                <!-- MODAL HEADER -->

                <div class="message-modal-header">

                    <div>

                        <span class="page-label">
                            CITIZEN MESSAGE
                        </span>

                        <h3>

                            <asp:Label
                                ID="lblViewSubject"
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



                <!-- MODAL BODY -->

                <div class="message-modal-body">


                    <div class="message-detail-grid">

                        <!-- NAME -->

                        <div>

                            <span>
                                FROM
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewName"
                                    runat="server" />

                            </strong>

                        </div>



                        <!-- EMAIL -->

                        <div>

                            <span>
                                EMAIL
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewEmail"
                                    runat="server" />

                            </strong>

                        </div>



                        <!-- MOBILE -->

                        <div>

                            <span>
                                MOBILE
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewMobile"
                                    runat="server" />

                            </strong>

                        </div>



                        <!-- DATE -->

                        <div>

                            <span>
                                RECEIVED
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewDate"
                                    runat="server" />

                            </strong>

                        </div>

                    </div>



                    <!-- MESSAGE -->

                    <div class="message-content-box">

                        <span>
                            MESSAGE
                        </span>

                        <p>

                            <asp:Label
                                ID="lblViewMessage"
                                runat="server" />

                        </p>

                    </div>



                    <!-- FOOTER -->

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



    <!-- =====================================
         SELECTED MESSAGE ID
    ====================================== -->

    <asp:HiddenField
        ID="hfMessageID"
        runat="server"
        Value="0" />

</asp:Content>