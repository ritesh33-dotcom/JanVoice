<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="IssueMap.aspx.cs" Inherits="JanVoice.IssueMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/IssueMap.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!--==================================
        ISSUE MAP
===================================-->

    <section class="issue-map-section">

        <div class="container-fluid">

            <!-- Header -->

            <div class="map-header">

                <div>

                    <span class="section-badge">📍 Live Issue Map

                </span>

                    <h1>Explore Civic Issues Across
                   
                        <span>Your City</span>

                    </h1>

                    <p>
                        View complaints submitted by citizens,
                    track their status and help improve
                    your neighbourhood.

               
                    </p>

                </div>

                <div class="header-buttons">

                    <a href="ReportIssue.aspx" class="primary-btn">+ Report Issue

                </a>

                </div>

            </div>

            <!-- Search -->

            <div class="search-panel">

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="search-box"
                    placeholder="Search location, landmark or complaint...">
            </asp:TextBox>

                <asp:Button ID="btnSearch"
                    runat="server"
                    Text="Search"
                    CssClass="search-btn"
                    OnClick="btnSearch_Click" />

            </div>

            <!-- Main Layout -->

            <div class="map-layout">

                <!-- Left Sidebar -->

                <aside class="map-sidebar">

                    <h3>Filters

                </h3>

                    <hr />

                    <h3>Filters</h3>

                    <hr />

                    <asp:DropDownList ID="ddlCategory"
                        runat="server"
                        CssClass="search-box">
                    </asp:DropDownList>

                    <br />
                    <br />

                    <asp:DropDownList ID="ddlStatus"
                        runat="server"
                        CssClass="search-box">

                        <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                        <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                        <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
                        <asp:ListItem Text="Resolved" Value="Resolved"></asp:ListItem>

                    </asp:DropDownList>

                    <br />
                    <br />

                    <asp:Button
                        ID="btnFilter"
                        runat="server"
                        Text="Apply Filter"
                        CssClass="search-btn"
                        OnClick="btnFilter_Click" /><br /><br />

                    <div class="stat-card">

                        <h2>
                            <asp:Label ID="lblTotalIssues" runat="server" Text="0"></asp:Label>
                        </h2>
                        <p>Total Issues</p>

                    </div>

                    <div class="stat-card">

                        <h2>
                            <asp:Label ID="lblResolved" runat="server" Text="0"></asp:Label>
                        </h2>

                        <p>Resolved</p>

                    </div>

                    <div class="stat-card">

                        <h2>
                            <asp:Label ID="lblProgress" runat="server" Text="0"></asp:Label>
                        </h2>

                        <p>In Progress</p>

                    </div>

                    <div class="stat-card">

                        <h2>
                            <asp:Label ID="lblPending" runat="server" Text="0"></asp:Label>
                        </h2>

                        <p>Pending</p>

                    </div>

                </aside>

                <!-- Map Area -->

                <div class="map-container">

                    <div id="map">

                        <!-- Leaflet Map will come here -->



                    </div>

                </div>

            </div>
        </div>

    </section>


   <script>

       document.addEventListener("DOMContentLoaded", function () {

           // Pune Default Location
           var map = L.map('map').setView([18.5204, 73.8567], 13);

           // OpenStreetMap
           L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
               maxZoom: 19,
               attribution: '© OpenStreetMap'
           }).addTo(map);

           // Complaint JSON from Backend
           var complaints = <%= string.IsNullOrEmpty(ComplaintJson) ? "[]" : ComplaintJson %>;

    // Add Markers
    complaints.forEach(function (issue) {

        if (issue.Latitude && issue.Longitude) {

            L.marker([
                parseFloat(issue.Latitude),
                parseFloat(issue.Longitude)
            ])
                .addTo(map)
                .bindPopup(
                    "<b>" + issue.Title + "</b><br/>" +
                    issue.Description + "<br/><br/>" +
                    "<b>Status :</b> " + issue.Status + "<br/>" +
                    "<b>Location :</b> " + issue.Landmark
                );

        }

    });

});

       


</asp:Content>
