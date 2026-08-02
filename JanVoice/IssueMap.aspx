<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="IssueMap.aspx.cs" Inherits="JanVoice.IssueMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- =========================
      ISSUE MAP HERO
========================== -->

    <section class="issue-map-hero">

        <div class="container">

            <div class="map-header">

                <h1>Smart <span>Issue Map</span>
                </h1>

                <p>
                    Explore reported civic issues across your city.
                Find nearby complaints, monitor issue status and help build a better community with JanVoice.
                </p>

            </div>

        </div>

    </section>



    <!-- =========================
        FILTER BAR
========================== -->

    <section class="map-filter-section">

        <div class="container">

            <div class="map-filter">

                <input type="text"
                    class="search-location"
                    placeholder="🔍 Search Area..." />

                <select class="filter-select">

                    <option>All Categories</option>

                    <option>Garbage</option>

                    <option>Road Damage</option>

                    <option>Water Supply</option>

                    <option>Street Light</option>

                    <option>Drainage</option>

                </select>

                <select class="filter-select">

                    <option>All Status</option>

                    <option>Pending</option>

                    <option>In Progress</option>

                    <option>Resolved</option>

                </select>

                <button class="filter-btn">
                    Search

                </button>

            </div>

        </div>

    </section>



    <!-- =========================
        MAP SECTION
========================== -->

    <section class="map-section">

        <div class="container">

            <div class="map-layout">


                <!-- LEFT -->

                <div class="map-box">

                    <div class="map-placeholder">

                        <div class="location-btn">
                            📍 My Location

                        </div>

                        <div class="map-pin pin1"></div>

                        <div class="map-pin pin2"></div>

                        <div class="map-pin pin3"></div>

                        <div class="map-pin pin4"></div>

                        <div class="map-pin pin5"></div>

                        <h2>Smart Civic Map

                        </h2>

                        <p>
                            Google Maps integration will display
        live complaint locations here.

                        </p>

                    </div>



                    <!-- RIGHT -->

                    <div class="side-panel">

                        <div class="glass-card">

                            <h3>📊 City Overview

                            </h3>

                            <ul>

                                <li>🔴 Pending :
                                    <span class="counter">48

                                    </span>

                                </li>

                                <li>🟡 In Progress :
                                    <span class="counter">16

                                    </span>

                                </li>

                                <li>🟢 Resolved :
                                    <span class="counter">82

                                    </span>

                                </li>

                                <li>📍 Total :
                                    <span class="counter">146

                                    </span>

                                </li>

                            </ul>

                        </div>



                        <div class="glass-card mt-4">

                            <h3>🔥 Trending Areas

                            </h3>

                            <ul>

                                <li>Ward 1</li>

                                <li>Ward 3</li>

                                <li>Ward 6</li>

                                <li>Ward 10</li>

                            </ul>

                        </div>



                        <div class="glass-card mt-4">

                            <h3>📢 Latest Reports

                            </h3>

                            <ul>

                                <li>Garbage Overflow</li>

                                <li>Water Leakage</li>

                                <li>Broken Road</li>

                                <li>Street Light Off</li>

                            </ul>

                            <div class="glass-card mt-4">

                                <h3>🗺 Map Legend

                                </h3>

                                <ul>

                                    <li>🔴 High Priority</li>

                                    <li>🟠 Medium Priority</li>

                                    <li>🟢 Resolved Issue</li>

                                    <li>🔵 Your Location</li>

                                </ul>

                            </div>

                        </div>


                    </div>

                </div>

            </div>
            </div>
    </section>




    <script>

        document.querySelectorAll(".glass-card").forEach(function (card) {

            card.addEventListener("mouseenter", function () {

                this.style.transform = "translateY(-8px)";

            });

            card.addEventListener("mouseleave", function () {

                this.style.transform = "translateY(0px)";

            });

        });

    </script>

</asp:Content>
