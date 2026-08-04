<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="JanVoice.Citizen.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/dashboard.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="dashboard-container">

        <!-- Welcome -->

        <div class="welcome-card">

            <h2>Welcome,
           
                <asp:Label ID="lblName" runat="server"></asp:Label>
                👋
            </h2>

            <p>
                Welcome back to JanVoice. Manage your complaints and
            contribute to improving your city.
       
            </p>

        </div>

        <!-- Statistics -->

        <div class="stats-grid">

            <div class="stat-card">

                <i class="fa-solid fa-file-circle-check"></i>

                <h3>
                    <asp:Label
                        ID="lblTotalComplaints"
                        runat="server"
                        Text="0" />
                </h3>

                <p>Total Complaints</p>

            </div>

            <div class="stat-card">

                <i class="fa-solid fa-hourglass-half"></i>

                <h3>
                    <asp:Label
                        ID="lblPending"
                        runat="server"
                        Text="0" />
                </h3>

                <p>Pending</p>

            </div>

            <div class="stat-card">

                <i class="fa-solid fa-circle-check"></i>

                <h3>
                    <asp:Label
                        ID="lblResolved"
                        runat="server"
                        Text="0" />
                </h3>

                <p>Resolved</p>

            </div>

            <div class="stat-card">

                <i class="fa-solid fa-bell"></i>

                <h3>
                    <asp:Label
                        ID="lblNotifications"
                        runat="server"
                        Text="0" />
                </h3>

                <p>Notifications</p>

            </div>

        </div>

        <!-- Quick Actions -->

        <div class="quick-actions">

            <h3>Quick Actions</h3>

            <a href="ReportIssue.aspx" class="action-btn">

                <i class="fa-solid fa-plus"></i>

                Report New Issue

            </a>

            <a href="MyComplaints.aspx" class="action-btn">

                <i class="fa-solid fa-list"></i>

                My Complaints

            </a>

        </div>

        <div class="recent-card">

    <h3>Recent Complaints</h3>

    <asp:Repeater
        ID="rptRecentComplaints"
        runat="server">

        <ItemTemplate>

            <div class="recent-item">

                <div>

                    <h4>
                        <%# Eval("Title") %>
                    </h4>

                    <small>
                        <%# Eval("CreatedDate","{0:dd MMM yyyy}") %>
                    </small>

                </div>

                <div>

                    <span class='status <%# Eval("Status").ToString().Replace(" ","") %>'>

                        <%# Eval("Status") %>

                    </span>

                </div>

            </div>

        </ItemTemplate>

    </asp:Repeater>

</div>

    </div>
</asp:Content>
