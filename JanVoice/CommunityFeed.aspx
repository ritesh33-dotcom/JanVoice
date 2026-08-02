<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="CommunityFeed.aspx.cs" Inherits="JanVoice.CommunityFeed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="CSS/CommunityFeed.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--==================================
        COMMUNITY HERO
===================================-->

    <section class="community-hero">

        <div class="container">

            <div class="hero-content">

                <span class="section-badge">🌍 Community Driven Platform

                </span>

                <h1>Together We Build
                <span>Better Cities</span>

                </h1>

                <p>
                    Explore civic issues reported by your community,
                support important problems, follow updates,
                and help make your city smarter.

                </p>

            </div>

        </div>

    </section>

    <!--==================================
      TRENDING ISSUE
===================================-->

    <section class="trending-section">

        <div class="container">

            <div class="trending-card">

                <div class="trending-left">

                    <span class="trending-badge">🔥 Trending Issue

                    </span>

                    <h2>Garbage Overflow Near Bus Stand

                    </h2>

                    <p>
                        More than 120 citizens have supported this issue.
                    Municipal officer has already been assigned.

                    </p>

                </div>

                <div class="trending-right">

                    <div class="status pending">
                        Pending

                    </div>

                    <div class="support-count">
                        ❤️ 120 Supports

                    </div>

                </div>

            </div>

        </div>

    </section>

    <!--==================================
      SEARCH & FILTER
===================================-->

    <section class="feed-filter">

        <div class="container">

            <div class="filter-box">

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="search-box"
                    placeholder="Search issues...">
                </asp:TextBox>

                <asp:DropDownList
                    ID="ddlCategory"
                    runat="server"
                    CssClass="filter-dropdown">

                    <asp:ListItem>All Categories</asp:ListItem>
                    <asp:ListItem>Garbage</asp:ListItem>
                    <asp:ListItem>Road</asp:ListItem>
                    <asp:ListItem>Street Light</asp:ListItem>
                    <asp:ListItem>Drainage</asp:ListItem>

                </asp:DropDownList>

                <asp:DropDownList
                    ID="ddlStatus"
                    runat="server"
                    CssClass="filter-dropdown">

                    <asp:ListItem>All Status</asp:ListItem>
                    <asp:ListItem>Pending</asp:ListItem>
                    <asp:ListItem>Accepted</asp:ListItem>
                    <asp:ListItem>Resolved</asp:ListItem>

                </asp:DropDownList>

            </div>

        </div>

    </section>

    <!--==================================
      FEED SECTION
===================================-->

    <section class="community-feed">

        <div class="container">

            <div class="feed-grid">

                <!-- Card 1 -->

                <asp:Repeater ID="rptComplaints" runat="server">

                    <ItemTemplate>

                        <div class="issue-card">

                            <div class="issue-header">

                                <div class="user-info">

                                    <img src="Assets/Images/user.png"
                                        class="user-avatar" />

                                    <div>

                                        <h5>

                                            <%# Eval("FullName") %>

                                        </h5>

                                        <span>📍 <%# Eval("WardName") %>

                                        </span>

                                    </div>

                                </div>

                            </div>

                            <img src='<%# Eval("ImagePath") %>'
                                class="issue-image" />

                            <div class="issue-body">

                                <div class="issue-top">

                                    <span class="category">

                                        <%# Eval("CategoryName") %>

                                    </span>

                                    <span class="status pending">

                                        <%# Eval("Status") %>

                                    </span>

                                </div>

                                <h3>

                                    <%# Eval("Title") %>

                                </h3>

                                <p>

                                    <%# Eval("Description") %>
                                </p>

                                <div class="issue-footer">

                                    <span>❤️ <%# Eval("SupportCount") %>

                                    </span>

                                    <span>💬 <%# Eval("CommentCount") %>

                                    </span>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <img src="Assets/Images/demo1.jpg"
                    class="issue-image"
                    alt="Issue" />

                <div class="issue-body">

                    <div class="issue-top">

                        <span class="category">Garbage

                        </span>

                        <span class="priority high">High Priority

                        </span>

                    </div>

                    <h3>Garbage Overflow Near School

                    </h3>

                    <p>
                        Garbage has not been collected for more than five days.
            Citizens are facing health issues due to bad smell.

                    </p>

                    <div class="issue-location">
                        📍 Near Government School, Ward 3

                    </div>

                    <div class="issue-footer">

                        <span>❤️ 126 Supports</span>

                        <span>💬 28 Comments</span>

                    </div>

                    <div class="issue-buttons">

                        <button class="btn-support">
                            ❤️ Support

                        </button>

                        <button class="btn-comment">
                            💬 Comment

                        </button>

                    </div>
                    <br />

                    <div class="issue-buttons mt-3">

                        <button class="btn-map">
                            📍 View Map

                        </button>

                        <button class="btn-share">
                            🔗 Share

                        </button>

                    </div>

                </div>

            </div>

            <!-- More cards will come from database -->

        </div>

        </div>

    </section>

    <!-- Floating Button -->

    <a href="ReportIssue.aspx" class="floating-report">+

    </a>



    <script>

        document.querySelectorAll(".btn-support").forEach(function (btn) {

            btn.addEventListener("click", function () {

                this.classList.toggle("liked");

                if (this.classList.contains("liked")) {

                    this.innerHTML = "❤️ Supported";

                }

                else {

                    this.innerHTML = "❤️ Support";

                }

            });

        });

    </script>


</asp:Content>
