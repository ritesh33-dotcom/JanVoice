<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="JanVoice.Citizen.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

                <h3>0</h3>

                <p>Total Complaints</p>

            </div>

            <div class="stat-card">

                <i class="fa-solid fa-hourglass-half"></i>

                <h3>0</h3>

                <p>Pending</p>

            </div>

            <div class="stat-card">

                <i class="fa-solid fa-circle-check"></i>

                <h3>0</h3>

                <p>Resolved</p>

            </div>

            <div class="stat-card">

                <i class="fa-solid fa-bell"></i>

                <h3>0</h3>

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

    </div>
</asp:Content>
