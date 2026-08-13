<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="TrendingIssues.aspx.cs" Inherits="JanVoice.Officer.TrendingIssues" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../CSS/TrendingIssues.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



        <section class="trending-page">

        <div class="trending-container">


            <!-- =====================================================
                 PAGE HERO
            ====================================================== -->

            <div class="trending-hero">

                <div class="trending-hero-content">

                    <span class="trending-badge">
                        <i class="fa-solid fa-fire"></i>
                        ISSUE ANALYTICS
                    </span>

                    <h1>
                        Trending Issues
                    </h1>

                    <p>
                        Monitor the most reported and high-priority
                        civic issues across assigned areas.
                    </p>

                </div>


                <div class="trending-hero-icon">

                    <i class="fa-solid fa-chart-line"></i>

                </div>

            </div>



            <!-- =====================================================
                 STATISTICS
            ====================================================== -->

            <div class="trending-stats-grid">


                <!-- TOTAL ISSUES -->

                <div class="trend-stat-card">

                    <div class="trend-stat-icon blue">
                        <i class="fa-solid fa-layer-group"></i>
                    </div>

                    <div class="trend-stat-content">

                        <span class="trend-stat-label">
                            Total Issues
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblTotalIssues"
                                runat="server"
                                Text="0">
                            </asp:Label>
                        </strong>

                        <small>
                            Reported complaints
                        </small>

                    </div>

                </div>



                <!-- TOP ISSUE -->

                <div class="trend-stat-card">

                    <div class="trend-stat-icon red">
                        <i class="fa-solid fa-fire"></i>
                    </div>

                    <div class="trend-stat-content">

                        <span class="trend-stat-label">
                            Top Issue
                        </span>

                        <strong class="trend-stat-title">

                            <asp:Label
                                ID="lblTopIssue"
                                runat="server"
                                Text="No Data">
                            </asp:Label>

                        </strong>

                        <small>
                            Most reported category
                        </small>

                    </div>

                </div>



                <!-- HIGH PRIORITY -->

                <div class="trend-stat-card">

                    <div class="trend-stat-icon orange">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>

                    <div class="trend-stat-content">

                        <span class="trend-stat-label">
                            High Priority
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblHighPriority"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>

                        <small>
                            Issues requiring attention
                        </small>

                    </div>

                </div>



                <!-- ACTIVE ISSUES -->

                <div class="trend-stat-card">

                    <div class="trend-stat-icon green">
                        <i class="fa-solid fa-bolt"></i>
                    </div>

                    <div class="trend-stat-content">

                        <span class="trend-stat-label">
                            Active Issues
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblActiveIssues"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>

                        <small>
                            Currently unresolved
                        </small>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 MOST REPORTED ISSUES
            ====================================================== -->

            <div class="trending-card">

                <div class="trending-card-header">

                    <div>

                        <div class="trending-card-title">

                            <i class="fa-solid fa-ranking-star"></i>

                            Most Reported Issues

                        </div>

                        <p>
                            Categories with the highest number
                            of reported complaints.
                        </p>

                    </div>

                    <div class="trending-card-header-icon">

                        <i class="fa-solid fa-chart-column"></i>

                    </div>

                </div>


                <div class="most-reported-list">

                    <asp:Repeater
                        ID="rptMostReported"
                        runat="server">

                        <ItemTemplate>

                            <div class="reported-issue-item">

                                <div class="reported-rank">

                                    <%# Container.ItemIndex + 1 %>

                                </div>


                                <div class="reported-icon">

                                    <i class="fa-solid fa-circle-exclamation"></i>

                                </div>


                                <div class="reported-info">

                                    <strong>
                                        <%# Eval("CategoryName") %>
                                    </strong>

                                    <span>
                                        <%# Eval("IssueCount") %>
                                        reported complaints
                                    </span>

                                </div>


                                <div class="reported-count">

                                    <%# Eval("IssueCount") %>

                                </div>

                            </div>

                        </ItemTemplate>

                    </asp:Repeater>


                    <asp:Panel
                        ID="pnlNoReportedIssues"
                        runat="server"
                        CssClass="empty-trending"
                        Visible="false">

                        <i class="fa-solid fa-chart-column"></i>

                        <h3>
                            No Issue Data Available
                        </h3>

                        <p>
                            There are no reported issues available
                            for analysis.
                        </p>

                    </asp:Panel>

                </div>

            </div>



            <!-- =====================================================
                 ISSUE ANALYTICS GRID
            ====================================================== -->

            <div class="trending-analysis-grid">


                <!-- =================================================
                     HIGH PRIORITY ISSUES
                ================================================== -->

                <div class="trending-card">

                    <div class="trending-card-header">

                        <div>

                            <div class="trending-card-title">

                                <i class="fa-solid fa-triangle-exclamation"></i>

                                High Priority Issues

                            </div>

                            <p>
                                Complaints requiring immediate attention.
                            </p>

                        </div>

                    </div>


                    <div class="priority-list">

                        <asp:Repeater
                            ID="rptHighPriority"
                            runat="server">

                            <ItemTemplate>

                                <div class="priority-item">

                                    <div class="priority-item-icon">

                                        <i class="fa-solid fa-bolt"></i>

                                    </div>


                                    <div class="priority-item-content">

                                        <strong>
                                            <%# Eval("Title") %>
                                        </strong>

                                        <span>
                                            <%# Eval("CategoryName") %>
                                        </span>

                                    </div>


                                    <span class="priority-badge">
                                        <%# Eval("Priority") %>
                                    </span>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>


                        <asp:Panel
                            ID="pnlNoHighPriority"
                            runat="server"
                            CssClass="empty-trending"
                            Visible="false">

                            <i class="fa-solid fa-circle-check"></i>

                            <p>
                                No high-priority issues found.
                            </p>

                        </asp:Panel>

                    </div>

                </div>



                <!-- =================================================
                     ACTIVE ISSUES
                ================================================== -->

                <div class="trending-card">

                    <div class="trending-card-header">

                        <div>

                            <div class="trending-card-title">

                                <i class="fa-solid fa-bolt"></i>

                                Active Issues

                            </div>

                            <p>
                                Currently unresolved complaints.
                            </p>

                        </div>

                    </div>


                    <div class="active-issues-list">

                        <asp:Repeater
                            ID="rptActiveIssues"
                            runat="server">

                            <ItemTemplate>

                                <div class="active-issue-item">

                                    <div class="active-status-dot">
                                    </div>


                                    <div class="active-issue-content">

                                        <strong>
                                            <%# Eval("Title") %>
                                        </strong>

                                        <span>
                                            <%# Eval("Status") %>
                                        </span>

                                    </div>


                                    <div class="active-issue-date">

                                        <%#
                                            Eval(
                                                "CreatedDate",
                                                "{0:dd MMM yyyy}"
                                            )
                                        %>

                                    </div>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>


                        <asp:Panel
                            ID="pnlNoActiveIssues"
                            runat="server"
                            CssClass="empty-trending"
                            Visible="false">

                            <i class="fa-solid fa-circle-check"></i>

                            <p>
                                No active issues available.
                            </p>

                        </asp:Panel>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 CATEGORY PERFORMANCE
            ====================================================== -->

            <div class="trending-card">

                <div class="trending-card-header">

                    <div>

                        <div class="trending-card-title">

                            <i class="fa-solid fa-chart-pie"></i>

                            Category-wise Issue Overview

                        </div>

                        <p>
                            Compare reported complaints across
                            different civic issue categories.
                        </p>

                    </div>

                </div>


                <div class="category-table-wrapper">

                    <asp:GridView
                        ID="gvCategoryIssues"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="category-issues-table"
                        GridLines="None"
                        EmptyDataText="No category data available.">

                        <Columns>

                            <asp:BoundField
                                DataField="CategoryName"
                                HeaderText="Category" />

                            <asp:BoundField
                                DataField="TotalIssues"
                                HeaderText="Total Issues" />

                            <asp:BoundField
                                DataField="ActiveIssues"
                                HeaderText="Active" />

                            <asp:BoundField
                                DataField="ResolvedIssues"
                                HeaderText="Resolved" />

                            <asp:BoundField
                                DataField="HighPriorityIssues"
                                HeaderText="High Priority" />

                        </Columns>

                    </asp:GridView>

                </div>

            </div>



            <!-- =====================================================
                 INFORMATION FOOTER
            ====================================================== -->

            <div class="trending-information">

                <div>

                    <i class="fa-solid fa-circle-info"></i>

                    Trending data is calculated from reported
                    civic complaints.

                </div>


                <div>

                    <i class="fa-solid fa-shield-halved"></i>

                    JanVoice Officer Analytics

                </div>

            </div>


        </div>

    </section>

</asp:Content>
