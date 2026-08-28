<%@ Page Title="Officer Details"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="OfficerDetails.aspx.cs"
    Inherits="JanVoice.Admin.OfficerDetails" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/OfficerDetails.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="officer-details-page">


        <!-- ==========================================
             PAGE TOP
        =========================================== -->

        <div class="details-top">

            <div>

                <a href="ManageOfficers.aspx"
                   class="back-link">
                    ← Back to Manage Officers
                </a>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Officer Details
                </h1>

                <p>
                    View officer information and complaint activity.
                </p>

            </div>

        </div>



        <!-- ==========================================
             OFFICER PROFILE CARD
        =========================================== -->

        <div class="officer-profile-card">


            <!-- PROFILE LEFT -->

            <div class="profile-main">

                <div class="large-officer-avatar">

                    <asp:Label
                        ID="lblInitials"
                        runat="server"
                        Text="--">
                    </asp:Label>

                </div>


                <div class="profile-name">

                    <span class="profile-role">
                        CIVIC OFFICER
                    </span>

                    <h2>

                        <asp:Label
                            ID="lblFullName"
                            runat="server"
                            Text="Officer Name">
                        </asp:Label>

                    </h2>

                    <p>
                        Officer ID:
                        <strong>#<asp:Label
                            ID="lblUserID"
                            runat="server"
                            Text="0">
                        </asp:Label>
                        </strong>
                    </p>

                </div>

            </div>



            <!-- PROFILE STATUS -->

            <div class="profile-status-area">

                <span class="status-label">
                    ACCOUNT STATUS
                </span>

                <asp:Label
                    ID="lblStatus"
                    runat="server"
                    CssClass="detail-status"
                    Text="Active">
                </asp:Label>


                <asp:Button
                    ID="btnToggleStatus"
                    runat="server"
                    Text="Deactivate Officer"
                    CssClass="toggle-status-btn"
                    OnClick="btnToggleStatus_Click"
                    CausesValidation="false" />

            </div>


        </div>



        <!-- ==========================================
             INFORMATION + STATISTICS
        =========================================== -->

        <div class="details-grid">


            <!-- ======================================
                 OFFICER INFORMATION
            ======================================= -->

            <div class="details-card">

                <div class="details-card-header">

                    <div>

                        <h3>
                            Officer Information
                        </h3>

                        <p>
                            Registered account information.
                        </p>

                    </div>

                    <div class="header-icon">
                        👤
                    </div>

                </div>



                <div class="information-list">


                    <!-- FULL NAME -->

                    <div class="information-item">

                        <span class="info-label">
                            FULL NAME
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblInfoName"
                                runat="server">
                            </asp:Label>
                        </strong>

                    </div>



                    <!-- EMAIL -->

                    <div class="information-item">

                        <span class="info-label">
                            EMAIL ADDRESS
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblEmail"
                                runat="server">
                            </asp:Label>
                        </strong>

                    </div>



                    <!-- MOBILE -->

                    <div class="information-item">

                        <span class="info-label">
                            MOBILE NUMBER
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblMobile"
                                runat="server">
                            </asp:Label>
                        </strong>

                    </div>



                    <!-- ADDRESS -->

                    <div class="information-item">

                        <span class="info-label">
                            ADDRESS
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblAddress"
                                runat="server"
                                Text="Not provided">
                            </asp:Label>
                        </strong>

                    </div>



                    <!-- WARD -->

                    <div class="information-item">

                        <span class="info-label">
                            ASSIGNED WARD
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblWard"
                                runat="server">
                            </asp:Label>
                        </strong>

                    </div>



                    <!-- JOINED -->

                    <div class="information-item">

                        <span class="info-label">
                            JOINED DATE
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblCreatedDate"
                                runat="server">
                            </asp:Label>
                        </strong>

                    </div>


                </div>

            </div>



            <!-- ======================================
                 COMPLAINT STATISTICS
            ======================================= -->

            <div class="details-card">

                <div class="details-card-header">

                    <div>

                        <h3>
                            Complaint Overview
                        </h3>

                        <p>
                            Current complaint workload.
                        </p>

                    </div>

                    <div class="header-icon complaint-header-icon">
                        📋
                    </div>

                </div>



                <div class="complaint-stat-grid">


                    <!-- TOTAL -->

                    <div class="complaint-stat">

                        <span class="complaint-stat-icon">
                            📊
                        </span>

                        <span class="complaint-stat-label">
                            Total Assigned
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblTotalComplaints"
                                runat="server"
                                Text="0">
                            </asp:Label>
                        </strong>

                    </div>



                    <!-- ACTIVE -->

                    <div class="complaint-stat active-stat">

                        <span class="complaint-stat-icon">
                            ⏳
                        </span>

                        <span class="complaint-stat-label">
                            Active
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblActiveComplaints"
                                runat="server"
                                Text="0">
                            </asp:Label>
                        </strong>

                    </div>



                    <!-- RESOLVED -->

                    <div class="complaint-stat resolved-stat">

                        <span class="complaint-stat-icon">
                            ✓
                        </span>

                        <span class="complaint-stat-label">
                            Resolved
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblResolvedComplaints"
                                runat="server"
                                Text="0">
                            </asp:Label>
                        </strong>

                    </div>


                </div>



                <!-- ACCOUNT INFORMATION -->

                <div class="account-summary">

                    <div>

                        <span>
                            Account Type
                        </span>

                        <strong>
                            Officer
                        </strong>

                    </div>


                    <div>

                        <span>
                            Account Status
                        </span>

                        <asp:Label
                            ID="lblAccountStatus"
                            runat="server"
                            CssClass="mini-status"
                            Text="Active">
                        </asp:Label>

                    </div>

                </div>

            </div>


        </div>



        <!-- ==========================================
             RECENT COMPLAINTS
        =========================================== -->

        <div class="details-card complaints-card">


            <!-- HEADER -->

            <div class="details-card-header">

                <div>

                    <h3>
                        Assigned Complaints
                    </h3>

                    <p>
                        Complaints currently assigned to this officer.
                    </p>

                </div>


                <span class="complaint-record-count">

                    <asp:Label
                        ID="lblComplaintCount"
                        runat="server"
                        Text="0">
                    </asp:Label>

                    Complaints

                </span>

            </div>



            <!-- TABLE -->

            <div class="complaints-table-wrapper">

                <table class="complaints-table">

                    <thead>

                        <tr>

                            <th>
                                COMPLAINT
                            </th>

                            <th>
                                CATEGORY
                            </th>

                            <th>
                                PRIORITY
                            </th>

                            <th>
                                STATUS
                            </th>

                            <th>
                                CREATED
                            </th>

                        </tr>

                    </thead>


                    <tbody>

                        <asp:Repeater
                            ID="rptComplaints"
                            runat="server">

                            <ItemTemplate>

                                <tr>


                                    <!-- COMPLAINT -->

                                    <td>

                                        <div class="complaint-title-cell">

                                            <strong>
                                                <%# Eval("Title") %>
                                            </strong>

                                            <span>
                                                Complaint #<%# Eval("ComplaintID") %>
                                            </span>

                                        </div>

                                    </td>



                                    <!-- CATEGORY -->

                                    <td>
                                        <%# Eval("CategoryName") %>
                                    </td>



                                    <!-- PRIORITY -->

                                    <td>

                                        <span class='priority-badge
                                        <%#
                                            Eval("Priority")
                                                .ToString()
                                                .ToLower()
                                        %>'>

                                            <%# Eval("Priority") %>

                                        </span>

                                    </td>



                                    <!-- STATUS -->

                                    <td>

                                        <span class='complaint-status
                                        <%#
                                            Eval("Status")
                                                .ToString()
                                                .ToLower()
                                                .Replace(" ", "-")
                                        %>'>

                                            <%# Eval("Status") %>

                                        </span>

                                    </td>



                                    <!-- CREATED -->

                                    <td>

                                        <%#
                                            Convert.ToDateTime(
                                                Eval("CreatedDate")
                                            ).ToString("dd MMM yyyy")
                                        %>

                                    </td>


                                </tr>

                            </ItemTemplate>


                            <FooterTemplate>

                                <asp:PlaceHolder
                                    ID="phEmpty"
                                    runat="server">

                                    <tr>

                                        <td colspan="5">

                                            <div class="complaints-empty">

                                                <div>
                                                    📋
                                                </div>

                                                <h4>
                                                    No Complaints Assigned
                                                </h4>

                                                <p>
                                                    Complaints assigned to this officer will appear here.
                                                </p>

                                            </div>

                                        </td>

                                    </tr>

                                </asp:PlaceHolder>

                            </FooterTemplate>

                        </asp:Repeater>

                    </tbody>

                </table>

            </div>


        </div>



        <!-- ==========================================
             ADMIN NOTE
        =========================================== -->

        <div class="admin-note">

            <span class="admin-note-icon">
                🔒
            </span>

            <div>

                <strong>
                    Officer Account Protection
                </strong>

                <p>
                    Officer profile information is view-only from the Admin panel.
                    Password information is never displayed or accessible to administrators.
                </p>

            </div>

        </div>


    </div>

</asp:Content>