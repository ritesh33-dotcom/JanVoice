<%@ Page Title="Manage Complaints"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageComplaints.aspx.cs"
    Inherits="JanVoice.Admin.ManageComplaints" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ManageComplaints.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="complaints-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="complaints-header">

            <div>

                <span class="page-label">JANVOICE ADMINISTRATION
                </span>

                <h1>Manage Complaints
                </h1>

                <p>
                    Review, monitor and manage civic issues reported by citizens.
                </p>

            </div>


            <div class="header-summary">

                <div class="summary-item">

                    <span>Total</span>

                    <strong>24</strong>

                </div>


                <div class="summary-item pending-summary">

                    <span>Pending</span>

                    <strong>8</strong>

                </div>


                <div class="summary-item resolved-summary">

                    <span>Resolved</span>

                    <strong>10</strong>

                </div>

            </div>

        </div>



        <!-- =====================================
             FILTER / SEARCH CARD
        ====================================== -->

        <div class="filter-card">


            <div class="filter-header">

                <div>

                    <h3>Find Complaints
                    </h3>

                    <p>
                        Search and filter reported civic issues.
                    </p>

                </div>

            </div>


            <div class="filter-row">


                <!-- SEARCH -->

                <div class="filter-field search-field">

                    <label>
                        Search
                    </label>

                    <div class="search-input-wrapper">

                        <span class="search-icon">🔍
                        </span>

                        <input
                            type="text"
                            class="filter-input"
                            placeholder="Search by complaint title or ID..." />

                    </div>

                </div>


                <!-- STATUS -->

                <div class="filter-field">

                    <label>
                        Status
                    </label>

                    <select class="filter-input">

                        <option>All Status</option>
                        <option>Pending</option>
                        <option>Accepted</option>
                        <option>In Progress</option>
                        <option>Resolved</option>
                        <option>Rejected</option>

                    </select>

                </div>


                <!-- CATEGORY -->

                <div class="filter-field">

                    <label>
                        Category
                    </label>

                    <select class="filter-input">

                        <option>All Categories</option>
                        <option>Road</option>
                        <option>Street Light</option>
                        <option>Water Supply</option>
                        <option>Garbage</option>
                        <option>Drainage</option>

                    </select>

                </div>


                <!-- WARD -->

                <div class="filter-field">

                    <label>
                        Ward
                    </label>

                    <select class="filter-input">

                        <option>All Wards</option>
                        <option>Ward 1</option>
                        <option>Ward 2</option>
                        <option>Ward 3</option>
                        <option>Ward 4</option>

                    </select>

                </div>


                <!-- BUTTON -->

                <div class="filter-action">

                    <button type="button"
                        class="btn-filter">
                        Apply Filters

                    </button>

                </div>


            </div>

        </div>



        <!-- =====================================
             COMPLAINT TABLE
        ====================================== -->

        <div class="complaints-card">


            <!-- TABLE HEADER -->

            <div class="table-header">

                <div>

                    <h3>All Complaints
                    </h3>

                    <p>
                        Latest civic issues reported by citizens.
                    </p>

                </div>


                <span class="record-count">24 Complaints
                </span>

            </div>



            <!-- TABLE -->

            <div class="table-wrapper">

                <table class="complaints-table">


                    <thead>

                        <tr>

                            <th>ID
                            </th>

                            <th>Complaint
                            </th>

                            <th>Citizen
                            </th>

                            <th>Category
                            </th>

                            <th>Ward
                            </th>

                            <th>Priority
                            </th>

                            <th>Status
                            </th>

                            <th>Date
                            </th>

                            <th>Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                        <!-- ROW 1 -->

                        <tr>

                            <td>
                                <span class="complaint-id">#1024
                                </span>
                            </td>


                            <td>

                                <div class="complaint-info">

                                    <strong>Damaged road near market
                                    </strong>

                                    <span>Large potholes causing traffic problems
                                    </span>

                                </div>

                            </td>


                            <td>

                                <div class="citizen-info">

                                    <div class="citizen-avatar">
                                        R
                                    </div>

                                    <span>Ritesh J.
                                    </span>

                                </div>

                            </td>


                            <td>

                                <span class="category-badge">Road
                                </span>

                            </td>


                            <td>Ward 2
                            </td>


                            <td>

                                <span class="priority high">High
                                </span>

                            </td>


                            <td>

                                <span class="status-badge pending">Pending
                                </span>

                            </td>


                            <td>18 Aug 2026
                            </td>


                            <td>

                                <a href="#"
                                    class="view-btn">View

                                    <span>→
                                    </span>

                                </a>

                            </td>

                        </tr>



                        <!-- ROW 2 -->

                        <tr>

                            <td>

                                <span class="complaint-id">#1023
                                </span>

                            </td>


                            <td>

                                <div class="complaint-info">

                                    <strong>Street light not working
                                    </strong>

                                    <span>Street remains dark at night
                                    </span>

                                </div>

                            </td>


                            <td>

                                <div class="citizen-info">

                                    <div class="citizen-avatar">
                                        A
                                    </div>

                                    <span>Akshay P.
                                    </span>

                                </div>

                            </td>


                            <td>

                                <span class="category-badge">Street Light
                                </span>

                            </td>


                            <td>Ward 1
                            </td>


                            <td>

                                <span class="priority medium">Medium
                                </span>

                            </td>


                            <td>

                                <span class="status-badge progress">In Progress
                                </span>

                            </td>


                            <td>17 Aug 2026
                            </td>


                            <td>

                                <a href="#"
                                    class="view-btn">View

                                    <span>→
                                    </span>

                                </a>

                            </td>

                        </tr>



                        <!-- ROW 3 -->

                        <tr>

                            <td>

                                <span class="complaint-id">#1022
                                </span>

                            </td>


                            <td>

                                <div class="complaint-info">

                                    <strong>Garbage collection issue
                                    </strong>

                                    <span>Waste has not been collected
                                    </span>

                                </div>

                            </td>


                            <td>

                                <div class="citizen-info">

                                    <div class="citizen-avatar">
                                        S
                                    </div>

                                    <span>Sneha M.
                                    </span>

                                </div>

                            </td>


                            <td>

                                <span class="category-badge">Garbage
                                </span>

                            </td>


                            <td>Ward 3
                            </td>


                            <td>

                                <span class="priority low">Low
                                </span>

                            </td>


                            <td>

                                <span class="status-badge resolved">Resolved
                                </span>

                            </td>


                            <td>16 Aug 2026
                            </td>


                            <td>

                                <a href="#"
                                    class="view-btn">View

                                    <span>→
                                    </span>

                                </a>

                            </td>

                        </tr>



                        <!-- ROW 4 -->

                        <tr>

                            <td>

                                <span class="complaint-id">#1021
                                </span>

                            </td>


                            <td>

                                <div class="complaint-info">

                                    <strong>Water supply interruption
                                    </strong>

                                    <span>No water supply since morning
                                    </span>

                                </div>

                            </td>


                            <td>

                                <div class="citizen-info">

                                    <div class="citizen-avatar">
                                        M
                                    </div>

                                    <span>Mahesh K.
                                    </span>

                                </div>

                            </td>


                            <td>

                                <span class="category-badge">Water Supply
                                </span>

                            </td>


                            <td>Ward 4
                            </td>


                            <td>

                                <span class="priority high">High
                                </span>

                            </td>


                            <td>

                                <span class="status-badge accepted">Accepted
                                </span>

                            </td>


                            <td>15 Aug 2026
                            </td>


                            <td>

                                <a href="ComplaintDetails.aspx?id=1024"
                                    class="view-btn">View

                                    <span>→
                                    </span>

                                </a>

                            </td>

                        </tr>


                    </tbody>

                </table>

            </div>



            <!-- PAGINATION -->

            <div class="table-footer">

                <span>Showing 1–4 of 24 complaints
                </span>


                <div class="pagination">

                    <button class="page-btn disabled">
                        ←
                    </button>

                    <button class="page-btn active">
                        1
                    </button>

                    <button class="page-btn">
                        2
                    </button>

                    <button class="page-btn">
                        3
                    </button>

                    <button class="page-btn">
                        4
                    </button>

                    <button class="page-btn">
                        →
                    </button>

                </div>

            </div>


        </div>


    </div>


</asp:Content>
