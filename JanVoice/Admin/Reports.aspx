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
                    class="report-action-btn">

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

                <select class="report-filter">

                    <option>
                        This Month
                    </option>

                    <option>
                        Last Month
                    </option>

                    <option>
                        Last 3 Months
                    </option>

                    <option>
                        This Year
                    </option>

                    <option>
                        All Time
                    </option>

                </select>

            </div>


            <div class="filter-item">

                <label>
                    WARD
                </label>

                <select class="report-filter">

                    <option>
                        All Wards
                    </option>

                    <option>
                        Ward 1
                    </option>

                    <option>
                        Ward 2
                    </option>

                    <option>
                        Ward 3
                    </option>

                </select>

            </div>


            <div class="filter-item">

                <label>
                    CATEGORY
                </label>

                <select class="report-filter">

                    <option>
                        All Categories
                    </option>

                    <option>
                        Roads
                    </option>

                    <option>
                        Water Supply
                    </option>

                    <option>
                        Garbage
                    </option>

                    <option>
                        Street Lights
                    </option>

                </select>

            </div>


            <button type="button"
                class="apply-report-btn">

                Apply Filters

            </button>


        </div>



        <!-- =====================================
             SUMMARY STATISTICS
        ====================================== -->

        <div class="report-stats">


            <div class="report-stat-card">

                <div class="report-stat-icon">
                    📋
                </div>

                <div>

                    <span>
                        Total Complaints
                    </span>

                    <strong>
                        248
                    </strong>

                    <small>
                        Reported this period
                    </small>

                </div>

            </div>


            <div class="report-stat-card">

                <div class="report-stat-icon pending">
                    ⏳
                </div>

                <div>

                    <span>
                        Pending
                    </span>

                    <strong>
                        64
                    </strong>

                    <small>
                        Require attention
                    </small>

                </div>

            </div>


            <div class="report-stat-card">

                <div class="report-stat-icon progress">
                    ◷
                </div>

                <div>

                    <span>
                        In Progress
                    </span>

                    <strong>
                        51
                    </strong>

                    <small>
                        Currently handled
                    </small>

                </div>

            </div>


            <div class="report-stat-card">

                <div class="report-stat-icon resolved">
                    ✓
                </div>

                <div>

                    <span>
                        Resolved
                    </span>

                    <strong>
                        133
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


            <!-- COMPLAINT STATUS -->

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
                        This Month
                    </span>

                </div>


                <div class="status-report">


                    <div class="status-row">

                        <div class="status-info">

                            <span class="status-dot pending-dot"></span>

                            <strong>
                                Pending
                            </strong>

                        </div>

                        <span>
                            64
                        </span>

                    </div>


                    <div class="status-bar">

                        <div class="status-fill pending-fill"
                            style="width:26%;">
                        </div>

                    </div>



                    <div class="status-row">

                        <div class="status-info">

                            <span class="status-dot accepted-dot"></span>

                            <strong>
                                Accepted
                            </strong>

                        </div>

                        <span>
                            32
                        </span>

                    </div>


                    <div class="status-bar">

                        <div class="status-fill accepted-fill"
                            style="width:13%;">
                        </div>

                    </div>



                    <div class="status-row">

                        <div class="status-info">

                            <span class="status-dot progress-dot"></span>

                            <strong>
                                In Progress
                            </strong>

                        </div>

                        <span>
                            51
                        </span>

                    </div>


                    <div class="status-bar">

                        <div class="status-fill progress-fill"
                            style="width:21%;">
                        </div>

                    </div>



                    <div class="status-row">

                        <div class="status-info">

                            <span class="status-dot resolved-dot"></span>

                            <strong>
                                Resolved
                            </strong>

                        </div>

                        <span>
                            101
                        </span>

                    </div>


                    <div class="status-bar">

                        <div class="status-fill resolved-fill"
                            style="width:41%;">
                        </div>

                    </div>


                </div>


            </div>



            <!-- CATEGORY REPORT -->

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


                    <div class="category-row">

                        <div class="category-name">

                            <span class="category-icon">
                                🛣
                            </span>

                            <strong>
                                Roads
                            </strong>

                        </div>

                        <div class="category-value">

                            <span>
                                72
                            </span>

                            <small>
                                29%
                            </small>

                        </div>

                    </div>



                    <div class="category-row">

                        <div class="category-name">

                            <span class="category-icon">
                                💧
                            </span>

                            <strong>
                                Water Supply
                            </strong>

                        </div>

                        <div class="category-value">

                            <span>
                                58
                            </span>

                            <small>
                                23%
                            </small>

                        </div>

                    </div>



                    <div class="category-row">

                        <div class="category-name">

                            <span class="category-icon">
                                🗑
                            </span>

                            <strong>
                                Garbage
                            </strong>

                        </div>

                        <div class="category-value">

                            <span>
                                47
                            </span>

                            <small>
                                19%
                            </small>

                        </div>

                    </div>



                    <div class="category-row">

                        <div class="category-name">

                            <span class="category-icon">
                                💡
                            </span>

                            <strong>
                                Street Lights
                            </strong>

                        </div>

                        <div class="category-value">

                            <span>
                                38
                            </span>

                            <small>
                                15%
                            </small>

                        </div>

                    </div>



                    <div class="category-row">

                        <div class="category-name">

                            <span class="category-icon">
                                📌
                            </span>

                            <strong>
                                Other
                            </strong>

                        </div>

                        <div class="category-value">

                            <span>
                                33
                            </span>

                            <small>
                                14%
                            </small>

                        </div>

                    </div>


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


                        <tr>

                            <td>
                                <strong>
                                    Ward 1
                                </strong>
                            </td>

                            <td>
                                68
                            </td>

                            <td>
                                17
                            </td>

                            <td>
                                42
                            </td>

                            <td>
                                62%
                            </td>

                            <td>

                                <span class="performance good">
                                    Good
                                </span>

                            </td>

                        </tr>



                        <tr>

                            <td>
                                <strong>
                                    Ward 2
                                </strong>
                            </td>

                            <td>
                                74
                            </td>

                            <td>
                                21
                            </td>

                            <td>
                                39
                            </td>

                            <td>
                                53%
                            </td>

                            <td>

                                <span class="performance average">
                                    Average
                                </span>

                            </td>

                        </tr>



                        <tr>

                            <td>
                                <strong>
                                    Ward 3
                                </strong>
                            </td>

                            <td>
                                56
                            </td>

                            <td>
                                13
                            </td>

                            <td>
                                35
                            </td>

                            <td>
                                63%
                            </td>

                            <td>

                                <span class="performance good">
                                    Good
                                </span>

                            </td>

                        </tr>



                        <tr>

                            <td>
                                <strong>
                                    Ward 4
                                </strong>
                            </td>

                            <td>
                                50
                            </td>

                            <td>
                                13
                            </td>

                            <td>
                                30
                            </td>

                            <td>
                                60%
                            </td>

                            <td>

                                <span class="performance good">
                                    Good
                                </span>

                            </td>

                        </tr>


                    </tbody>


                </table>


            </div>


        </div>



        <!-- =====================================
             ADDITIONAL INSIGHTS
        ====================================== -->

        <div class="insights-grid">


            <div class="insight-card">

                <div class="insight-icon">
                    👥
                </div>

                <div>

                    <span>
                        Active Citizens
                    </span>

                    <strong>
                        184
                    </strong>

                    <small>
                        Citizens who interacted this month
                    </small>

                </div>

            </div>



            <div class="insight-card">

                <div class="insight-icon">
                    ⚡
                </div>

                <div>

                    <span>
                        High Priority Issues
                    </span>

                    <strong>
                        18
                    </strong>

                    <small>
                        Require immediate attention
                    </small>

                </div>

            </div>



            <div class="insight-card">

                <div class="insight-icon">
                    ⏱
                </div>

                <div>

                    <span>
                        Avg. Resolution Time
                    </span>

                    <strong>
                        3.4 Days
                    </strong>

                    <small>
                        Based on resolved complaints
                    </small>

                </div>

            </div>


        </div>


    </div>


</asp:Content>