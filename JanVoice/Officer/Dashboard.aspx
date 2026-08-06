<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="JanVoice.Officer.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/OfficerDashBoard.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <section class="dashboard-section">

<div class="container-fluid">

    <!-- ===========================
            WELCOME
    ============================-->

    <div class="dashboard-header">

        <div>

            <span class="dashboard-badge">
                Officer Dashboard
            </span>

            <h1>

                Welcome,

                <asp:Label ID="lblOfficerName"
                    runat="server"
                    Text="Officer">
                </asp:Label>

            </h1>

            <p>
                Manage complaints, monitor progress and serve citizens efficiently.
            </p>

        </div>

    </div>

    <!-- ===========================
         DASHBOARD STATISTICS
    ============================-->

    <div class="row g-4 mt-3">

        <!-- Total Assigned -->

        <div class="col-xl-2 col-lg-4 col-md-6">

            <div class="dashboard-card">

                <i class="fa-solid fa-folder-open card-icon"></i>

                <h2>

                    <asp:Label ID="lblTotalAssigned"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </h2>

                <p>Total Assigned</p>

            </div>

        </div>

        <!-- Pending -->

        <div class="col-xl-2 col-lg-4 col-md-6">

            <div class="dashboard-card">

                <i class="fa-solid fa-clock card-icon pending"></i>

                <h2>

                    <asp:Label ID="lblPending"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </h2>

                <p>Pending</p>

            </div>

        </div>

        <!-- In Progress -->

        <div class="col-xl-2 col-lg-4 col-md-6">

            <div class="dashboard-card">

                <i class="fa-solid fa-spinner card-icon progress"></i>

                <h2>

                    <asp:Label ID="lblInProgress"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </h2>

                <p>In Progress</p>

            </div>

        </div>

        <!-- Resolved -->

        <div class="col-xl-2 col-lg-4 col-md-6">

            <div class="dashboard-card">

                <i class="fa-solid fa-circle-check card-icon resolved"></i>

                <h2>

                    <asp:Label ID="lblResolved"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </h2>

                <p>Resolved</p>

            </div>

        </div>

        <!-- High Priority -->

        <div class="col-xl-2 col-lg-4 col-md-6">

            <div class="dashboard-card">

                <i class="fa-solid fa-triangle-exclamation card-icon high"></i>

                <h2>

                    <asp:Label ID="lblHighPriority"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </h2>

                <p>High Priority</p>

            </div>

        </div>

        <!-- Today's Complaints -->

        <div class="col-xl-2 col-lg-4 col-md-6">

            <div class="dashboard-card">

                <i class="fa-solid fa-calendar-day card-icon today"></i>

                <h2>

                    <asp:Label ID="lblToday"
                        runat="server"
                        Text="0">
                    </asp:Label>

                </h2>

                <p>Today's Complaints</p>

            </div>

        </div>

    </div>
    <!-- ===============================
            SECOND ROW
    ================================= -->

    <div class="row mt-5">

        <!-- Complaint Status Chart -->

        <div class="col-lg-8 mb-4">

            <div class="dashboard-box">

                <div class="box-header">

                    <h3>

                        <i class="fa-solid fa-chart-column"></i>

                        Complaint Status Overview

                    </h3>

                </div>

                <div class="chart-area">

                    <canvas id="complaintChart" height="250"></canvas>

                </div>

            </div>

        </div>

        <!-- Officer Profile -->

        <div class="col-lg-4 mb-4">

            <div class="dashboard-box officer-card">

                <div class="officer-photo">

                    <i class="fa-solid fa-user-shield"></i>

                </div>

                <h4>

                    <asp:Label
                        ID="lblOfficer"
                        runat="server" > 
                    </asp:Label>

                </h4>

                <p>

                    <asp:Label
                        ID="lblDepartment"
                        runat="server">
                       
                    </asp:Label>

                </p>

                <hr />

                <div class="officer-info">

                    <div>

                        <span>Ward</span>

                        <strong>

                            <asp:Label
                                ID="lblWard"
                                runat="server">
                                
                            </asp:Label>

                        </strong>

                    </div>

                    <div>

                        <span>Resolved</span>

                        <strong>

                            <asp:Label
                                ID="lblOfficerResolved"
                                runat="server">
                                
                            </asp:Label>

                        </strong>

                    </div>

                </div>

                <hr />

                <div class="officer-info">

                    <div>

                        <span>Email</span>

                        <strong>

                            <asp:Label
                                ID="lblEmail"
                                runat="server">
                               
                            </asp:Label>

                        </strong>

                    </div>

                    <div>

                        <span>Mobile</span>

                        <strong>

                            <asp:Label
                                ID="lblMobile"
                                runat="server">
                               
                            </asp:Label>

                        </strong>

                    </div>

                </div>

            </div>

        </div>

    </div>

    <!-- ==================================================
            RECENTLY ASSIGNED COMPLAINTS
================================================== -->

<div class="dashboard-box mt-4">

    <div class="box-header">

        <h3>

            <i class="fa-solid fa-list-check"></i>

            Recently Assigned Complaints

        </h3>

    </div>

    <div class="table-responsive">

        <asp:GridView
            ID="gvRecentComplaints"
            runat="server"
            AutoGenerateColumns="False"
            CssClass="table table-dark table-hover align-middle"
            GridLines="None"
            EmptyDataText="No complaints assigned yet.">

            <Columns>

                <asp:BoundField
                    DataField="ComplaintID"
                    HeaderText="Complaint ID" />

                <asp:BoundField
                    DataField="Title"
                    HeaderText="Title" />

                <asp:BoundField
                    DataField="CitizenName"
                    HeaderText="Citizen" />

                <asp:BoundField
                    DataField="CategoryName"
                    HeaderText="Category" />

                <asp:BoundField
                    DataField="Priority"
                    HeaderText="Priority" />

                <asp:BoundField
                    DataField="Status"
                    HeaderText="Status" />

                <asp:BoundField
                    DataField="CreatedDate"
                    HeaderText="Created"
                    DataFormatString="{0:dd MMM yyyy}" />

            </Columns>

        </asp:GridView>

    </div>

</div>

<!-- ==================================================
                QUICK ACTIONS
================================================== -->

<div class="row mt-4">

    <div class="col-lg-8">

        <div class="dashboard-box">

            <div class="box-header">

                <h3>

                    <i class="fa-solid fa-bolt"></i>

                    Quick Actions

                </h3>

            </div>

            <div class="row g-4 mt-2">

                <div class="col-md-3">

                    <a href="AssignComplaint.aspx"
                        class="action-card">

                        <i class="fa-solid fa-list-check"></i>

                        <h5>Assign Complaint</h5>

                    </a>

                </div>

                <div class="col-md-3">

                    <a href="ResolutionDetails.aspx"
                        class="action-card">

                        <i class="fa-solid fa-circle-check"></i>

                        <h5>Resolution</h5>

                    </a>

                </div>

                <div class="col-md-3">

                    <a href="TrendingIssue.aspx"
                        class="action-card">

                        <i class="fa-solid fa-fire"></i>

                        <h5>Trending Issues</h5>

                    </a>

                </div>

                <div class="col-md-3">

                    <a href="Profile.aspx"
                        class="action-card">

                        <i class="fa-solid fa-user"></i>

                        <h5>Profile</h5>

                    </a>

                </div>

            </div>

        </div>

    </div>

    <!-- ======================================
            LATEST NOTIFICATIONS
    ======================================= -->

    <div class="col-lg-4">

        <div class="dashboard-box">

            <div class="box-header">

                <h3>

                    <i class="fa-solid fa-bell"></i>

                    Latest Notifications

                </h3>

            </div>

            <ul class="notification-list">

                <asp:Repeater
                    ID="rptNotifications"
                    runat="server">

                    <ItemTemplate>

                        <li>

                            <i class="fa-solid fa-circle text-info"></i>

                            <%# Eval("Message") %>

                            <br />

                            <small class="text">

                                <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy hh:mm tt") %>

                            </small>

                        </li>

                    </ItemTemplate>

                </asp:Repeater>

            </ul>

        </div>

    </div>

</div>

<!-- ======================================================
                RECENT ACTIVITY
=======================================================-->

<div class="dashboard-box mt-4">

    <div class="box-header">

        <h3>

            <i class="fa-solid fa-clock-rotate-left"></i>

            Recent Activity

        </h3>

    </div>

    <div class="timeline">

        <asp:Repeater ID="rptRecentActivity" runat="server">

            <ItemTemplate>

                <div class="timeline-item">

                    <span class="timeline-dot"></span>

                    <div>

                        <h5>

                            <%# Eval("NewStatus") %>

                        </h5>

                        <p>

                            <%# Eval("Remarks") %>

                        </p>

                        <small class="text">

                            <%# Convert.ToDateTime(Eval("ChangeDate")).ToString("dd MMM yyyy hh:mm tt") %>

                        </small>

                    </div>

                </div>

            </ItemTemplate>

        </asp:Repeater>

    </div>

</div>

</div>

</section>

<!-- ===========================
        HIDDEN FIELDS
===========================-->

<asp:HiddenField ID="hfPending" runat="server" />

<asp:HiddenField ID="hfInProgress" runat="server" />

<asp:HiddenField ID="hfResolved" runat="server" />

<!-- ===========================
          CHART JS
===========================-->

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>

    function LoadChart() {

        var pending =
            Number(document.getElementById('<%=hfPending.ClientID%>').value);

        var progress =
            Number(document.getElementById('<%=hfInProgress.ClientID%>').value);

    var resolved =
            Number(document.getElementById('<%=hfResolved.ClientID%>').value);

        const ctx =
            document.getElementById("complaintChart");

        if (window.myChart) {
            window.myChart.destroy();
        }

        window.myChart = new Chart(ctx, {

            type: 'doughnut',

            data: {

                labels: [

                    'Pending',

                    'In Progress',

                    'Resolved'

                ],

                datasets: [{

                    data: [

                        pending,

                        progress,

                        resolved

                    ],

                    backgroundColor: [

                        '#f59e0b',

                        '#3b82f6',

                        '#22c55e'

                    ]

                }]

            }

        });

    }

    window.onload = LoadChart;
    </script>
</asp:Content>

