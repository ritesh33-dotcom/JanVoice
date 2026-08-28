<%@ Page Title="Reports"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="Reports.aspx.cs"
    Inherits="JanVoice.Admin.Reports" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/Reports.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="reports-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="reports-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Reports & Analytics
                </h1>

                <p>
                    Analyze civic activity, complaints, and community performance.
                </p>

            </div>


            <div class="reports-header-actions">

                <button type="button"
                    class="report-action-btn"
                    onclick="window.print();">

                    ⬇

                    <span>
                        Export Report
                    </span>

                </button>

            </div>

        </div>



        <!-- =====================================
             FILTER BAR
        ====================================== -->

        <div class="reports-filter-card">


            <div class="filter-item">

                <label>
                    REPORT PERIOD
                </label>

                <asp:DropDownList
                    ID="ddlPeriod"
                    runat="server"
                    CssClass="report-filter">

                    <asp:ListItem Text="This Month"
                        Value="ThisMonth" />

                    <asp:ListItem Text="Last Month"
                        Value="LastMonth" />

                    <asp:ListItem Text="Last 3 Months"
                        Value="Last3Months" />

                    <asp:ListItem Text="This Year"
                        Value="ThisYear" />

                    <asp:ListItem Text="All Time"
                        Value="AllTime" />

                </asp:DropDownList>

            </div>



            <div class="filter-item">

                <label>
                    WARD
                </label>

                <asp:DropDownList
                    ID="ddlWard"
                    runat="server"
                    CssClass="report-filter">

                </asp:DropDownList>

            </div>



            <div class="filter-item">

                <label>
                    CATEGORY
                </label>

                <asp:DropDownList
                    ID="ddlCategory"
                    runat="server"
                    CssClass="report-filter">

                </asp:DropDownList>

            </div>



            <asp:Button
                ID="btnApplyFilters"
                runat="server"
                Text="Apply Filters"
                CssClass="apply-report-btn"
                OnClick="btnApplyFilters_Click" />


        </div>



        <!-- =====================================
             SUMMARY STATISTICS
        ====================================== -->

        <div class="report-stats">


            <!-- TOTAL -->

            <div class="report-stat-card">

                <div class="report-stat-icon">
                    📋
                </div>

                <div>

                    <span>
                        Total Complaints
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblTotalComplaints"
                            runat="server"
                            Text="0" />
                    </strong>

                    <small>
                        Reported this period
                    </small>

                </div>

            </div>



            <!-- PENDING -->

            <div class="report-stat-card">

                <div class="report-stat-icon pending">
                    ⏳
                </div>

                <div>

                    <span>
                        Pending
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblPending"
                            runat="server"
                            Text="0" />
                    </strong>

                    <small>
                        Require attention
                    </small>

                </div>

            </div>



            <!-- IN PROGRESS -->

            <div class="report-stat-card">

                <div class="report-stat-icon progress">
                    ◷
                </div>

                <div>

                    <span>
                        In Progress
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblInProgress"
                            runat="server"
                            Text="0" />
                    </strong>

                    <small>
                        Currently handled
                    </small>

                </div>

            </div>



            <!-- RESOLVED -->

            <div class="report-stat-card">

                <div class="report-stat-icon resolved">
                    ✓
                </div>

                <div>

                    <span>
                        Resolved
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblResolved"
                            runat="server"
                            Text="0" />
                    </strong>

                    <small>
                        Successfully completed
                    </small>

                </div>

            </div>


        </div>



        <!-- =====================================
             REPORT GRID
        ====================================== -->

        <div class="reports-grid">


            <!-- =================================
                 COMPLAINT STATUS
            ================================== -->

            <div class="report-card">


                <div class="report-card-header">

                    <div>

                        <h3>
                            Complaint Status
                        </h3>

                        <p>
                            Distribution of complaints by current status.
                        </p>

                    </div>

                    <span class="report-period">
                        <asp:Label
                            ID="lblSelectedPeriod"
                            runat="server"
                            Text="This Month" />
                    </span>

                </div>



                <div class="status-report">


                    <asp:Repeater
                        ID="rptStatusReport"
                        runat="server">

                        <ItemTemplate>

                            <div class="status-row">

                                <div class="status-info">

                                    <span class='<%# GetStatusDotClass(Eval("Status")) %>'>
                                    </span>

                                    <strong>
                                        <%# Eval("Status") %>
                                    </strong>

                                </div>

                                <span>
                                    <%# Eval("Count") %>
                                </span>

                            </div>


                            <div class="status-bar">

                                <div class='<%# GetStatusFillClass(Eval("Status")) %>'
                                    style='<%# "width:" + Eval("Percentage") + "%;" %>'>
                                </div>

                            </div>

                        </ItemTemplate>

                    </asp:Repeater>


                </div>

            </div>



            <!-- =================================
                 CATEGORY REPORT
            ================================== -->

            <div class="report-card">


                <div class="report-card-header">

                    <div>

                        <h3>
                            Complaints by Category
                        </h3>

                        <p>
                            Most reported civic issue categories.
                        </p>

                    </div>

                </div>



                <div class="category-report">


                    <asp:Repeater
                        ID="rptCategoryReport"
                        runat="server">

                        <ItemTemplate>

                            <div class="category-row">


                                <div class="category-name">

                                    <span class="category-icon">
                                        📌
                                    </span>

                                    <strong>
                                        <%# Eval("CategoryName") %>
                                    </strong>

                                </div>


                                <div class="category-value">

                                    <span>
                                        <%# Eval("ComplaintCount") %>
                                    </span>

                                    <small>
                                        <%# Eval("Percentage") %>%
                                    </small>

                                </div>


                            </div>

                        </ItemTemplate>

                    </asp:Repeater>


                </div>

            </div>


        </div>



        <!-- =====================================
             WARD PERFORMANCE
        ====================================== -->

        <div class="report-card ward-performance">


            <div class="report-card-header">

                <div>

                    <h3>
                        Ward-wise Performance
                    </h3>

                    <p>
                        Complaint activity and resolution performance across wards.
                    </p>

                </div>

            </div>



            <div class="ward-table-wrapper">


                <table class="ward-report-table">


                    <thead>

                        <tr>

                            <th>
                                WARD
                            </th>

                            <th>
                                COMPLAINTS
                            </th>

                            <th>
                                PENDING
                            </th>

                            <th>
                                RESOLVED
                            </th>

                            <th>
                                RESOLUTION RATE
                            </th>

                            <th>
                                PERFORMANCE
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                        <asp:Repeater
                            ID="rptWardPerformance"
                            runat="server">

                            <ItemTemplate>

                                <tr>

                                    <td>

                                        <strong>
                                            <%# Eval("WardName") %>
                                        </strong>

                                    </td>


                                    <td>
                                        <%# Eval("TotalComplaints") %>
                                    </td>


                                    <td>
                                        <%# Eval("Pending") %>
                                    </td>


                                    <td>
                                        <%# Eval("Resolved") %>
                                    </td>


                                    <td>
                                        <%# Eval("ResolutionRate") %>%
                                    </td>


                                    <td>

                                        <span class='<%# GetPerformanceClass(Eval("ResolutionRate")) %>'>

                                            <%# GetPerformanceText(Eval("ResolutionRate")) %>

                                        </span>

                                    </td>

                                </tr>

                            </ItemTemplate>

                        </asp:Repeater>


                    </tbody>


                </table>


            </div>


        </div>



        <!-- =====================================
             ADDITIONAL INSIGHTS
        ====================================== -->

        <div class="insights-grid">


            <!-- ACTIVE CITIZENS -->

            <div class="insight-card">

                <div class="insight-icon">
                    👥
                </div>

                <div>

                    <span>
                        Active Citizens
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblActiveCitizens"
                            runat="server"
                            Text="0" />
                    </strong>

                    <small>
                        Citizens who reported complaints
                    </small>

                </div>

            </div>



            <!-- HIGH PRIORITY -->

            <div class="insight-card">

                <div class="insight-icon">
                    ⚡
                </div>

                <div>

                    <span>
                        High Priority Issues
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblHighPriority"
                            runat="server"
                            Text="0" />
                    </strong>

                    <small>
                        Require immediate attention
                    </small>

                </div>

            </div>



            <!-- AVG RESOLUTION -->

            <div class="insight-card">

                <div class="insight-icon">
                    ⏱
                </div>

                <div>

                    <span>
                        Avg. Resolution Time
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblAverageResolution"
                            runat="server"
                            Text="0 Days" />
                    </strong>

                    <small>
                        Based on resolved complaints
                    </small>

                </div>

            </div>


        </div>


    </div>


</asp:Content>