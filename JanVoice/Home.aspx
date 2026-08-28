<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="JanVoice.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!-- =========================================================
         HERO
    ========================================================== -->

    <section class="hero">

        <div class="container hero-content">

            <div class="hero-left">

                <span class="badge">
                    🇮🇳 Smart Community Platform
                </span>

                <h1>
                    Your Voice.<br />
                    Your Community.<br />
                    Your Change.
                </h1>

                <p>
                    JanVoice helps citizens report civic issues,
                    connect with their community,
                    and track resolutions in one place.
                </p>

                <div class="hero-buttons">

                    <a href="Citizen/ReportIssue.aspx" class="btn-primary">
                        Report Issue
                    </a>

                    <a href="CommunityFeed.aspx" class="btn-outline">
                        Community Feed
                    </a>

                </div>

            </div>


            <div class="hero-right">

                <img src="Images/Logo/logoIllustration.png"
                     alt="JanVoice Logo" />

            </div>

        </div>

    </section>



    <!-- =========================================================
         LIVE STATISTICS
    ========================================================== -->

    <section class="statistics">

        <div class="container">

            <div class="section-title">

                <h2>Trusted by Thousands of Citizens</h2>

                <p>
                    Building cleaner, smarter and safer communities together.
                </p>

            </div>


            <div class="stats-grid">


                <!-- TOTAL REPORTS -->

                <div class="stat-card">

                    <i class="fa-solid fa-file-circle-check"></i>

                    <h3 class="counter"
                        data-target="<%= TotalReports %>">

                        <%= TotalReports %>

                    </h3>

                    <p>Total Reports</p>

                </div>


                <!-- RESOLVED ISSUES -->

                <div class="stat-card">

                    <i class="fa-solid fa-circle-check"></i>

                    <h3 class="counter"
                        data-target="<%= ResolvedIssues %>">

                        <%= ResolvedIssues %>

                    </h3>

                    <p>Resolved Issues</p>

                </div>


                <!-- ACTIVE CITIZENS -->

                <div class="stat-card">

                    <i class="fa-solid fa-users"></i>

                    <h3 class="counter"
                        data-target="<%= ActiveCitizens %>">

                        <%= ActiveCitizens %>

                    </h3>

                    <p>Active Citizens</p>

                </div>


                <!-- SUCCESS RATE -->

                <div class="stat-card">

                    <i class="fa-solid fa-star"></i>

                    <h3>
                        <%= SuccessRate %>%
                    </h3>

                    <p>Success Rate</p>

                </div>


            </div>

        </div>

    </section>



    <!-- =========================================================
         WHY CHOOSE JANVOICE
    ========================================================== -->

    <section class="features">

        <div class="container">

            <div class="section-title">

                <h2>Why Choose JanVoice?</h2>

                <p>
                    A modern platform designed to connect citizens,
                    communities, and local authorities.
                </p>

            </div>


            <div class="feature-grid">


                <div class="feature-card">

                    <i class="fa-solid fa-shield-halved"></i>

                    <h3>Secure Reporting</h3>

                    <p>
                        Your complaints are securely stored and managed
                        with proper authentication.
                    </p>

                </div>


                <div class="feature-card">

                    <i class="fa-solid fa-users"></i>

                    <h3>Community Driven</h3>

                    <p>
                        Citizens can support, verify and follow issues
                        together.
                    </p>

                </div>


                <div class="feature-card">

                    <i class="fa-solid fa-bolt"></i>

                    <h3>Real-Time Updates</h3>

                    <p>
                        Receive instant notifications whenever the status
                        of your complaint changes.
                    </p>

                </div>


                <div class="feature-card">

                    <i class="fa-solid fa-map-location-dot"></i>

                    <h3>Smart Mapping</h3>

                    <p>
                        Explore nearby civic issues using an interactive
                        location-based map.
                    </p>

                </div>


                <div class="feature-card">

                    <i class="fa-solid fa-bell"></i>

                    <h3>Instant Alerts</h3>

                    <p>
                        Stay informed with notifications about comments,
                        updates and resolutions.
                    </p>

                </div>


                <div class="feature-card">

                    <i class="fa-solid fa-chart-line"></i>

                    <h3>Transparent Process</h3>

                    <p>
                        Track every complaint from reporting to resolution
                        with complete transparency.
                    </p>

                </div>


            </div>

        </div>

    </section>



    <!-- =========================================================
         HOW JANVOICE WORKS
    ========================================================== -->

    <section class="workflow">

        <div class="container">

            <div class="section-title">

                <h2>How JanVoice Works</h2>

                <p>
                    A simple, transparent and community-driven process to
                    solve civic issues efficiently.
                </p>

            </div>


            <div class="workflow-grid">


                <div class="workflow-card">

                    <div class="step-number">1</div>

                    <div class="workflow-icon">
                        <i class="fa-solid fa-file-circle-plus"></i>
                    </div>

                    <h3>Report Issue</h3>

                    <p>
                        Citizens submit issues with photos, category and
                        exact location.
                    </p>

                </div>


                <div class="workflow-card">

                    <div class="step-number">2</div>

                    <div class="workflow-icon">
                        <i class="fa-solid fa-user-check"></i>
                    </div>

                    <h3>Community Verification</h3>

                    <p>
                        Nearby citizens confirm, support and comment on
                        the reported issue.
                    </p>

                </div>


                <div class="workflow-card">

                    <div class="step-number">3</div>

                    <div class="workflow-icon">
                        <i class="fa-solid fa-user-gear"></i>
                    </div>

                    <h3>Officer Action</h3>

                    <p>
                        Officers review the complaint, update progress and
                        upload work photos.
                    </p>

                </div>


                <div class="workflow-card">

                    <div class="step-number">4</div>

                    <div class="workflow-icon">
                        <i class="fa-solid fa-circle-check"></i>
                    </div>

                    <h3>Issue Resolved</h3>

                    <p>
                        Citizens receive notifications and can verify the
                        completed work.
                    </p>

                </div>


            </div>

        </div>

    </section>



    <!-- =========================================================
         COMMUNITY FEED
    ========================================================== -->

    <section class="community-preview">

        <div class="container">

            <div class="section-title">

                <h2>Community Feed</h2>

                <p>
                    Discover issues reported by citizens in your nearby area.
                    Support, comment and follow updates together.
                </p>

            </div>


            <div class="community-grid">


                <asp:Repeater
                    ID="rptCommunityFeed"
                    runat="server">

                    <ItemTemplate>


                        <div class="community-card">


                            <div class="card-header">


                                <span class="ward">

                                    <i class="fa-solid fa-location-dot"></i>

                                    <%# HttpUtility.HtmlEncode(Eval("WardName").ToString()) %>

                                </span>


                                <span class='<%# GetStatusCssClass(Eval("Status").ToString()) %>'>

                                    <%# HttpUtility.HtmlEncode(Eval("Status").ToString()) %>

                                </span>


                            </div>


                            <h3>

                                <%# HttpUtility.HtmlEncode(Eval("Title").ToString()) %>

                            </h3>


                            <p>

                                <%# HttpUtility.HtmlEncode(Eval("Description").ToString()) %>

                            </p>


                            <div class="card-stats">


                                <span>

                                    <i class="fa-solid fa-thumbs-up"></i>

                                    <%# Eval("SupportCount") %>

                                </span>


                                <span>

                                    <i class="fa-solid fa-comments"></i>

                                    <%# Eval("CommentCount") %>

                                </span>


                                <span>

                                    <i class="fa-solid fa-camera"></i>

                                    <%# Eval("ImageCount") %>

                                </span>


                            </div>


                            <a href="CommunityFeed.aspx"
                               class="card-btn">

                                View Details →

                            </a>


                        </div>


                    </ItemTemplate>

                </asp:Repeater>


            </div>

        </div>

    </section>



    <!-- =========================================================
         ISSUE CATEGORIES
    ========================================================== -->

    <section class="categories">

        <div class="container">

            <div class="section-title">

                <h2>Issue Categories</h2>

                <p>
                    Select a category to report a civic issue or explore
                    similar reports in your community.
                </p>

            </div>


            <div class="category-grid">


                <asp:Repeater
                    ID="rptCategories"
                    runat="server">

                    <ItemTemplate>


                        <a href="Citizen/ReportIssue.aspx"
                           class="category-card">


                            <div class="category-icon">

                                <i class='<%# GetCategoryIcon(Eval("CategoryName").ToString()) %>'></i>

                            </div>


                            <h3>

                                <%# HttpUtility.HtmlEncode(Eval("CategoryName").ToString()) %>

                            </h3>


                            <span>

                                <%# Eval("IssueCount") %> Issues

                            </span>


                        </a>


                    </ItemTemplate>

                </asp:Repeater>


            </div>

        </div>

    </section>



    <!-- =========================================================
         EMERGENCY CONTACTS
    ========================================================== -->

    <section class="emergency">

        <div class="container">

            <div class="section-title">

                <h2>Emergency Contacts</h2>

                <p>
                    Quick access to important emergency services whenever you need them.
                </p>

            </div>


            <div class="emergency-grid">


                <div class="emergency-card">

                    <div class="emergency-icon police">

                        <i class="fa-solid fa-shield-halved"></i>

                    </div>

                    <h3>Police</h3>

                    <p>Emergency Number</p>

                    <h4>100</h4>

                    <a href="tel:100" class="call-btn">

                        <i class="fa-solid fa-phone"></i>
                        Call Now

                    </a>

                </div>


                <div class="emergency-card">

                    <div class="emergency-icon ambulance">

                        <i class="fa-solid fa-truck-medical"></i>

                    </div>

                    <h3>Ambulance</h3>

                    <p>Emergency Number</p>

                    <h4>108</h4>

                    <a href="tel:108" class="call-btn">

                        <i class="fa-solid fa-phone"></i>
                        Call Now

                    </a>

                </div>


                <div class="emergency-card">

                    <div class="emergency-icon fire">

                        <i class="fa-solid fa-fire-extinguisher"></i>

                    </div>

                    <h3>Fire Brigade</h3>

                    <p>Emergency Number</p>

                    <h4>101</h4>

                    <a href="tel:101" class="call-btn">

                        <i class="fa-solid fa-phone"></i>
                        Call Now

                    </a>

                </div>


                <div class="emergency-card">

                    <div class="emergency-icon electricity">

                        <i class="fa-solid fa-bolt"></i>

                    </div>

                    <h3>Electricity</h3>

                    <p>Helpline</p>

                    <h4>1912</h4>

                    <a href="tel:1912" class="call-btn">

                        <i class="fa-solid fa-phone"></i>
                        Call Now

                    </a>

                </div>


            </div>

        </div>

    </section>



    <!-- =========================================================
         CALL TO ACTION
    ========================================================== -->

    <section class="cta">

        <div class="container">

            <div class="cta-content">

                <span class="cta-badge">
                    🚀 Join the JanVoice Community
                </span>


                <h2>

                    Together We Can Build
                    <span>Cleaner</span>,
                    <span>Safer</span> &
                    <span>Smarter</span> Cities

                </h2>


                <p>

                    Every report matters.
                    Every citizen counts.

                    Join thousands of citizens who are helping
                    local authorities solve civic problems
                    efficiently.

                </p>


                <div class="cta-buttons">


                    <a href="Citizen/ReportIssue.aspx"
                       class="btn-primary">

                        <i class="fa-solid fa-triangle-exclamation"></i>

                        Report Issue

                    </a>


                    <a href="CommunityFeed.aspx"
                       class="btn-secondary">

                        <i class="fa-solid fa-users"></i>

                        Community Feed

                    </a>


                </div>

            </div>

        </div>

    </section>




</asp:Content>
