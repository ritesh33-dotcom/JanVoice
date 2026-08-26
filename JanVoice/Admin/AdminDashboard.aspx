<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="JanVoice.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../CSS/AdminDashboard.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="dashboard-page">


        <!-- PAGE HEADER -->

        <div class="dashboard-header">

            <div>

                <span class="dashboard-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Dashboard
                </h1>

                <p>
                    Monitor and manage civic activity across JanVoice.
                </p>

            </div>

        </div>



        <!-- STATISTICS -->

        <div class="dashboard-stats">


            <!-- TOTAL CITIZENS -->

            <div class="stat-card">

                <div class="stat-icon">
                    👥
                </div>

                <div class="stat-info">

                    <span>Total Citizens</span>

                    <h2>
                        <asp:Label ID="lblTotalCitizens"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </h2>

                    <small>
                        Registered users
                    </small>

                </div>

            </div>



            <!-- TOTAL COMPLAINTS -->

            <div class="stat-card">

                <div class="stat-icon">
                    📋
                </div>

                <div class="stat-info">

                    <span>Total Complaints</span>

                    <h2>
                        <asp:Label ID="lblTotalComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </h2>

                    <small>
                        Civic issues reported
                    </small>

                </div>

            </div>



            <!-- PENDING COMPLAINTS -->

            <div class="stat-card">

                <div class="stat-icon warning">
                    ⏳
                </div>

                <div class="stat-info">

                    <span>Pending Complaints</span>

                    <h2>
                        <asp:Label ID="lblPendingComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </h2>

                    <small>
                        Require attention
                    </small>

                </div>

            </div>



            <!-- RESOLVED COMPLAINTS -->

            <div class="stat-card">

                <div class="stat-icon success">
                    ✓
                </div>

                <div class="stat-info">

                    <span>Resolved Complaints</span>

                    <h2>
                        <asp:Label ID="lblResolvedComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </h2>

                    <small>
                        Successfully resolved
                    </small>

                </div>

            </div>


        </div>



        <!-- MAIN DASHBOARD GRID -->

        <div class="dashboard-grid">


            <!-- COMPLAINT OVERVIEW -->

            <div class="dashboard-card complaint-overview">


                <div class="card-header">

                    <div>

                        <h3>
                            Complaint Overview
                        </h3>

                        <p>
                            Current status of reported civic issues
                        </p>

                    </div>

                    <span class="card-badge">
                        Live
                    </span>

                </div>



                <div class="overview-content">


                    <!-- PENDING -->

                    <div class="overview-item">

                        <span class="overview-dot pending-dot"></span>

                        <div>

                            <strong>
                                Pending
                            </strong>

                            <small>
                                Waiting for action
                            </small>

                        </div>

                        <b>
                            <asp:Label ID="lblPendingOverview"
                                runat="server"
                                Text="0">
                            </asp:Label>
                        </b>

                    </div>



                    <!-- ACCEPTED -->

                    <div class="overview-item">

                        <span class="overview-dot accepted-dot"></span>

                        <div>

                            <strong>
                                Accepted
                            </strong>

                            <small>
                                Officer assigned
                            </small>

                        </div>

                        <b>
                            <asp:Label ID="lblAcceptedOverview"
                                runat="server"
                                Text="0">
                            </asp:Label>
                        </b>

                    </div>



                    <!-- IN PROGRESS -->

                    <div class="overview-item">

                        <span class="overview-dot progress-dot"></span>

                        <div>

                            <strong>
                                In Progress
                            </strong>

                            <small>
                                Currently being handled
                            </small>

                        </div>

                        <b>
                            <asp:Label ID="lblProgressOverview"
                                runat="server"
                                Text="0">
                            </asp:Label>
                        </b>

                    </div>



                    <!-- RESOLVED -->

                    <div class="overview-item">

                        <span class="overview-dot resolved-dot"></span>

                        <div>

                            <strong>
                                Resolved
                            </strong>

                            <small>
                                Issue completed
                            </small>

                        </div>

                        <b>
                            <asp:Label ID="lblResolvedOverview"
                                runat="server"
                                Text="0">
                            </asp:Label>
                        </b>

                    </div>


                </div>

            </div>



            <!-- QUICK ACTIONS -->

            <div class="dashboard-card">


                <div class="card-header">

                    <div>

                        <h3>
                            Quick Actions
                        </h3>

                        <p>
                            Frequently used administration tools
                        </p>

                    </div>

                </div>



                <div class="quick-actions">


                    <a href="ManageComplaints.aspx"
                       class="quick-action">

                        <span>📋</span>

                        <div>

                            <strong>
                                Manage Complaints
                            </strong>

                            <small>
                                Review civic issues
                            </small>

                        </div>

                        <b>
                            →
                        </b>

                    </a>



                    <a href="ManageUsers.aspx"
                       class="quick-action">

                        <span>👥</span>

                        <div>

                            <strong>
                                Manage Users
                            </strong>

                            <small>
                                View registered citizens
                            </small>

                        </div>

                        <b>
                            →
                        </b>

                    </a>



                    <a href="ManageOfficers.aspx"
                       class="quick-action">

                        <span>👨‍💼</span>

                        <div>

                            <strong>
                                Manage Officers
                            </strong>

                            <small>
                                Manage officer accounts
                            </small>

                        </div>

                        <b>
                            →
                        </b>

                    </a>



                    <a href="Reports.aspx"
                       class="quick-action">

                        <span>📊</span>

                        <div>

                            <strong>
                                View Reports
                            </strong>

                            <small>
                                Analyze civic activity
                            </small>

                        </div>

                        <b>
                            →
                        </b>

                    </a>


                </div>

            </div>


        </div>



        <!-- RECENT COMPLAINTS -->

        <div class="dashboard-card recent-complaints">


            <div class="card-header">

                <div>

                    <h3>
                        Recent Complaints
                    </h3>

                    <p>
                        Latest issues reported by citizens
                    </p>

                </div>

                <a href="ManageComplaints.aspx"
                   class="view-all">
                    View All →
                </a>

            </div>



            <!-- RECENT COMPLAINTS TABLE -->

            <div class="recent-table-wrapper">

    <asp:GridView
        ID="gvRecentComplaints"
        runat="server"
        AutoGenerateColumns="False"
        CssClass="recent-complaints-table"
        GridLines="None"
        EmptyDataText="No complaints to display."
        ShowHeaderWhenEmpty="true">

        <Columns>

            <asp:BoundField
                DataField="ComplaintID"
                HeaderText="ID"
                ItemStyle-CssClass="complaint-id" />

            <asp:BoundField
                DataField="Title"
                HeaderText="Complaint"
                ItemStyle-CssClass="complaint-title" />

            <asp:BoundField
                DataField="CategoryName"
                HeaderText="Category" />

            <asp:BoundField
                DataField="WardName"
                HeaderText="Ward" />

            <asp:BoundField
                DataField="Status"
                HeaderText="Status"
                ItemStyle-CssClass="complaint-status" />

            <asp:BoundField
                DataField="CreatedDate"
                HeaderText="Reported"
                DataFormatString="{0:dd MMM yyyy}"
                ItemStyle-CssClass="complaint-date" />

        </Columns>

    </asp:GridView>

</div>

        </div>


    </div>


</asp:Content>