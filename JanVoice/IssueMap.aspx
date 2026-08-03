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

                <button class="search-btn">
                    Search

           
                </button>

            </div>

            <!-- Main Layout -->

            <div class="map-layout">

                <!-- Left Sidebar -->

                <aside class="map-sidebar">

                    <h3>Filters

                </h3>

                    <hr />

                    <label>

                        <input type="checkbox" checked />

                        Garbage

               
                    </label>

                    <label>

                        <input type="checkbox" checked />

                        Road Damage

               
                    </label>

                    <label>

                        <input type="checkbox" checked />

                        Water Leakage

               
                    </label>

                    <label>

                        <input type="checkbox" checked />

                        Street Light

               
                    </label>

                    <label>

                        <input type="checkbox" checked />

                        Drainage

               
                    </label>

                    <hr />

                    <h3>Statistics

                </h3>

                    <div class="stat-card">

                        <h2>250</h2>

                        <p>Total Issues</p>

                    </div>

                    <div class="stat-card">

                        <h2>110</h2>

                        <p>Resolved</p>

                    </div>

                    <div class="stat-card">

                        <h2>70</h2>

                        <p>In Progress</p>

                    </div>

                    <div class="stat-card">

                        <h2>70</h2>

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

            // Pune Location

            var map = L.map('map').setView([18.5204, 73.8567], 12);

            // OpenStreetMap

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {

                maxZoom: 19,

                attribution: '© OpenStreetMap'

            }).addTo(map);


            // Garbage Issue

            L.marker([18.5204, 73.8567])

                .addTo(map)

                .bindPopup(`

<div class="issue-popup">

<img src="https://picsum.photos/300/200?1">

<span class="status pending">

Pending

</span>

<h4>

Garbage Overflow

</h4>

<p>

📍 Shivaji Nagar

</p>

<p>

👤 Reported by Rahul

</p>

<p>

📅 02 Aug 2026

</p>

<a href="#" class="popup-btn">

View Details

</a>

</div>

`);

            // Road Issue

            L.marker([18.5350, 73.8470])

                .addTo(map)

                .bindPopup(`

<div class="issue-popup">

<img src="https://picsum.photos/300/200?2">

<span class="status progress">

In Progress

</span>

<h4>

Road Damage

</h4>

<p>

📍 JM Road

</p>

<p>

👤 Reported by Sneha

</p>

<p>

📅 01 Aug 2026

</p>

<a href="#" class="popup-btn">

View Details

</a>

</div>

`);

            // Street Light

            L.marker([18.5100, 73.8650])

                .addTo(map)

                .bindPopup(`

<div class="issue-popup">

<img src="https://picsum.photos/300/200?3">

<span class="status resolved">

Resolved

</span>

<h4>

Street Light Fixed

</h4>

<p>

📍 Kothrud

</p>

<p>

👤 Reported by Amit

</p>

<p>

📅 30 Jul 2026

</p>

<a href="#" class="popup-btn">

View Details

</a>

</div>

`);

            // Sample Markers

            L.marker([18.5204, 73.8567])

                .addTo(map)

                .bindPopup("<b>Garbage Issue</b><br>Pending");

            L.marker([18.5350, 73.8470])

                .addTo(map)

                .bindPopup("<b>Road Damage</b><br>In Progress");

            L.marker([18.5100, 73.8650])

                .addTo(map)

                .bindPopup("<b>Street Light</b><br>Resolved");

            L.marker([18.5000, 73.8800])

                .addTo(map)

                .bindPopup("<b>Water Leakage</b><br>Pending");

        });

    </script>

</asp:Content>
