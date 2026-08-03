<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="IssueMap.aspx.cs" Inherits="JanVoice.IssueMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/IssueMap.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <!-- ========================================= -->
<!-- ISSUE MAP PAGE -->
<!-- ========================================= -->

<section id="issueMapPage">

    <!-- ========================================= -->
    <!-- HERO SECTION -->
    <!-- ========================================= -->

    <section id="heroSection">

        <div class="container">

            <div class="heroContent">

                <div class="heroText">

                    <span class="heroBadge">
                        📍 Smart City Monitoring
                    </span>

                    <h1>
                        Explore Issues Across Your City
                    </h1>

                    <p>
                        Track civic complaints, discover nearby issues,
                        and monitor their current status in real time.
                    </p>

                    <div class="heroButtons">

                        <a href="CommunityFeed.aspx">
                            View Community Feed
                        </a>

                        <a href="ReportIssue.aspx">
                            Report Issue
                        </a>

                    </div>

                </div>

                <div class="heroImage">

                    <img src="Assets/Images/map-hero.png"
                        alt="Issue Map" />

                </div>

            </div>

        </div>

    </section>

    <!-- ========================================= -->
<!-- FLOATING SEARCH SECTION -->
<!-- ========================================= -->

<section id="searchSection">

    <div class="container">

        <div class="searchWrapper">

            <div class="searchBar">

                <div class="searchItem">

                    <i class="fa-solid fa-magnifying-glass"></i>

                    <input
                        type="text"
                        placeholder="Search Issue..." />

                </div>

                <div class="searchItem">

                    <i class="fa-solid fa-layer-group"></i>

                    <select>

                        <option>Category</option>

                    </select>

                </div>

                <div class="searchItem">

                    <i class="fa-solid fa-location-dot"></i>

                    <select>

                        <option>Ward</option>

                    </select>

                </div>

                <div class="searchItem">

                    <i class="fa-solid fa-circle-info"></i>

                    <select>

                        <option>Status</option>

                    </select>

                </div>

                <button class="searchBtn">

                    <i class="fa-solid fa-magnifying-glass"></i>

                    Search

                </button>

            </div>

        </div>

    </div>

</section>
    <!-- ========================================= -->
<!-- LIVE STATISTICS -->
<!-- ========================================= -->

<section id="statisticsSection">

    <div class="container">

        <div class="statisticsGrid">

            <div class="statCard">

                <i class="fa-solid fa-map-location-dot"></i>

                <h2>0</h2>

                <p>Total Issues</p>

            </div>

            <div class="statCard">

                <i class="fa-solid fa-hourglass-half"></i>

                <h2>0</h2>

                <p>Pending</p>

            </div>

            <div class="statCard">

                <i class="fa-solid fa-circle-check"></i>

                <h2>0</h2>

                <p>Resolved</p>

            </div>

            <div class="statCard">

                <i class="fa-solid fa-triangle-exclamation"></i>

                <h2>0</h2>

                <p>Critical</p>

            </div>

        </div>

    </div>

</section>


    <!-- ========================================= -->
<!-- LATEST ISSUES SECTION -->
<!-- ========================================= -->

<section id="latestIssuesSection">

    <div class="container">

        <div class="sectionHeader">

            <h2>Latest Reported Issues</h2>

            <p>
                Recently reported complaints by citizens.
            </p>

        </div>

        <div class="issueGrid">

            <asp:Repeater ID="rptLatestIssues" runat="server">

                <ItemTemplate>

                    <div class="issueCard">

                        <div class="issueImage">

                            <img src='<%# Eval("ImagePath") %>'
                                alt="Issue Image" />

                        </div>

                        <div class="issueBody">

                            <span class="issueCategory">

                                <%# Eval("CategoryName") %>

                            </span>

                            <h3>

                                <%# Eval("Title") %>

                            </h3>

                            <p>

                                <%# Eval("Description") %>

                            </p>

                            <div class="issueFooter">

                                <span>

                                    📍 <%# Eval("WardName") %>

                                </span>

                                <span>

                                    <%# Eval("Status") %>

                                </span>

                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </div>

    </div>

</section>


    <!-- ========================================= -->
<!-- TRENDING AREAS -->
<!-- ========================================= -->

<section id="trendingSection">

    <div class="container">

        <div class="sectionHeader">

            <h2>Trending Areas</h2>

            <p>

                Areas with highest number of complaints.

            </p>

        </div>

        <div class="trendingGrid">

            <div class="trendCard">

                <h3>Ward 01</h3>

                <span>24 Issues</span>

            </div>

            <div class="trendCard">

                <h3>Ward 02</h3>

                <span>18 Issues</span>

            </div>

            <div class="trendCard">

                <h3>Ward 03</h3>

                <span>15 Issues</span>

            </div>

            <div class="trendCard">

                <h3>Ward 04</h3>

                <span>12 Issues</span>

            </div>

        </div>

    </div>

</section>


    <!-- ========================================= -->
<!-- MAP LEGEND -->
<!-- ========================================= -->

<section id="legendSection">

    <div class="container">

        <div class="sectionHeader">

            <h2>Map Legend</h2>

        </div>

        <div class="legendGrid">

            <div class="legendItem">

                🔴 Pending

            </div>

            <div class="legendItem">

                🟠 In Progress

            </div>

            <div class="legendItem">

                🟢 Resolved

            </div>

            <div class="legendItem">

                🔵 Verified

            </div>

        </div>

    </div>

</section>

    <!-- ========================================= -->
<!-- CALL TO ACTION -->
<!-- ========================================= -->

<section id="ctaSection">

    <div class="container">

        <div class="ctaBox">

            <h2>

                Found a Civic Issue?

            </h2>

            <p>

                Help your city become better by reporting issues.

            </p>

            <asp:Button

                ID="btnReport"

                runat="server"

                CssClass="ctaButton"

                Text="Report New Issue"

                PostBackUrl="~/ReportIssue.aspx" />

        </div>

    </div>

</section>


    <!-- ========================================= -->
<!-- MAP SECTION -->
<!-- ========================================= -->

<section id="mapSection">

    <div class="container">

        <div class="mapCard">

            <div class="mapHeader">

                <div>

                    <h2>Live Issue Map</h2>

                    <p>Explore reported civic issues across the city.</p>

                </div>

                <div class="mapActions">

                    <button>

                        <i class="fa-solid fa-location-crosshairs"></i>

                    </button>

                    <button>

                        <i class="fa-solid fa-expand"></i>

                    </button>

                </div>

            </div>

            <div id="googleMap">

                Google Maps Integration Here

            </div>

        </div>

    </div>

</section>

    <!-- ========================================= -->
    <!-- LATEST ISSUES -->
    <!-- ========================================= -->

    <section id="latestIssuesSection">

        <div class="container">

            <h2>
                Latest Reported Issues
            </h2>

            <div class="issueCards">

                <div class="issueCard">

                    Issue Card 1

                </div>

                <div class="issueCard">

                    Issue Card 2

                </div>

                <div class="issueCard">

                    Issue Card 3

                </div>

            </div>

        </div>

    </section>

    <!-- ========================================= -->
    <!-- MAP LEGEND -->
    <!-- ========================================= -->

    <section id="legendSection">

        <div class="container">

            <h2>

                Map Legend

            </h2>

            <div class="legendGrid">

                <div>

                    🔴 Pending

                </div>

                <div>

                    🟠 In Progress

                </div>

                <div>

                    🟢 Resolved

                </div>

                <div>

                    🔵 Verified

                </div>

            </div>

        </div>

    </section>

</section>


</asp:Content>
