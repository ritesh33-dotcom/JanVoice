<%@ Page Title="Manage Officers"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageOfficers.aspx.cs"
    Inherits="JanVoice.Admin.ManageOfficers" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ManageOfficers.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="manage-officers-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="officers-header">

            <div>

                <span class="page-label">JANVOICE ADMINISTRATION
                </span>

                <h1>Manage Officers
                </h1>

                <p>
                    View and manage officers responsible for handling civic complaints.
                </p>

            </div>


            <div class="officers-header-info">

                <span>Officer Accounts
                </span>

                <strong>Active
                </strong>

            </div>

        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="officer-stats">


            <!-- TOTAL OFFICERS -->

            <div class="officer-stat-card">

                <div class="officer-stat-icon">
                    👨‍💼
                </div>

                <div>

                    <span>Total Officers
                    </span>

                    <strong>0
                    </strong>

                </div>

            </div>



            <!-- ACTIVE OFFICERS -->

            <div class="officer-stat-card">

                <div class="officer-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>Active Officers
                    </span>

                    <strong>0
                    </strong>

                </div>

            </div>



            <!-- INACTIVE OFFICERS -->

            <div class="officer-stat-card">

                <div class="officer-stat-icon inactive-icon">
                    ●
                </div>

                <div>

                    <span>Inactive Officers
                    </span>

                    <strong>0
                    </strong>

                </div>

            </div>



            <!-- ACTIVE COMPLAINTS -->

            <div class="officer-stat-card">

                <div class="officer-stat-icon complaint-icon">
                    📋
                </div>

                <div>

                    <span>Active Complaints
                    </span>

                    <strong>0
                    </strong>

                </div>

            </div>


        </div>



        <!-- =====================================
             SEARCH / FILTER
        ====================================== -->

        <div class="officers-toolbar">


            <!-- SEARCH -->

            <div class="officer-search">

                <span>🔍
                </span>

                <input
                    type="text"
                    placeholder="Search by officer name or email..." />

            </div>



            <!-- WARD FILTER -->

            <select class="officer-filter">

                <option value="">All Wards
                </option>

                <option value="1">Ward 1
                </option>

                <option value="2">Ward 2
                </option>

                <option value="3">Ward 3
                </option>

            </select>



            <!-- STATUS FILTER -->

            <select class="officer-filter">

                <option value="">All Status
                </option>

                <option value="Active">Active
                </option>

                <option value="Inactive">Inactive
                </option>

            </select>



            <!-- APPLY -->

            <button type="button"
                class="filter-btn">
                Apply Filters

            </button>


        </div>



        <!-- =====================================
             OFFICERS TABLE
        ====================================== -->

        <div class="officers-card">


            <!-- TABLE HEADER -->

            <div class="officers-card-header">

                <div>

                    <h3>Registered Officers
                    </h3>

                    <p>
                        Officers currently registered on JanVoice.
                    </p>

                </div>


                <span class="record-count">0 Officers
                </span>

            </div>



            <!-- TABLE -->

            <div class="officers-table-wrapper">


                <table class="officers-table">


                    <thead>

                        <tr>

                            <th>OFFICER
                            </th>

                            <th>CONTACT
                            </th>

                            <th>WARD
                            </th>

                            <th>ACTIVE COMPLAINTS
                            </th>

                            <th>JOINED
                            </th>

                            <th>STATUS
                            </th>

                            <th>ACTION
                            </th>

                        </tr>

                    </thead>



                    <tbody>


                        <!-- =====================================
                             DEMO OFFICER 1
                        ====================================== -->

                        <tr>


                            <!-- OFFICER -->

                            <td>

                                <div class="officer-cell">

                                    <div class="officer-avatar">
                                        S
                                    </div>

                                    <div>

                                        <strong>Suresh Patil
                                        </strong>

                                        <span>Officer ID: #001
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <!-- CONTACT -->

                            <td>

                                <div class="contact-cell">

                                    <span>suresh@example.com
                                    </span>

                                    <small>+91 XXXXX XXXXX
                                    </small>

                                </div>

                            </td>



                            <!-- WARD -->

                            <td>Ward 1
                            </td>



                            <!-- COMPLAINTS -->

                            <td>

                                <strong class="complaint-count">6
                                </strong>

                            </td>



                            <!-- JOINED -->

                            <td>10 Aug 2026
                            </td>



                            <!-- STATUS -->

                            <td>

                                <span class="officer-status active">Active
                                </span>

                            </td>



                            <!-- ACTION -->

                            <td>

                                <a href="#"
                                    class="view-officer-btn">View

                                </a>

                            </td>


                        </tr>



                        <!-- =====================================
                             DEMO OFFICER 2
                        ====================================== -->

                        <tr>


                            <!-- OFFICER -->

                            <td>

                                <div class="officer-cell">

                                    <div class="officer-avatar purple">
                                        P
                                    </div>

                                    <div>

                                        <strong>Prakash More
                                        </strong>

                                        <span>Officer ID: #002
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <!-- CONTACT -->

                            <td>

                                <div class="contact-cell">

                                    <span>prakash@example.com
                                    </span>

                                    <small>+91 XXXXX XXXXX
                                    </small>

                                </div>

                            </td>



                            <!-- WARD -->

                            <td>Ward 2
                            </td>



                            <!-- COMPLAINTS -->

                            <td>

                                <strong class="complaint-count">3
                                </strong>

                            </td>



                            <!-- JOINED -->

                            <td>05 Aug 2026
                            </td>



                            <!-- STATUS -->

                            <td>

                                <span class="officer-status active">Active
                                </span>

                            </td>



                            <!-- ACTION -->

                            <td>

                                <a href="#"
                                    class="view-officer-btn">View

                                </a>

                            </td>


                        </tr>



                        <!-- =====================================
                             EMPTY STATE
                        ====================================== -->

                        <!--

                        <tr>

                            <td colspan="7">

                                <div class="officers-empty">

                                    <div>
                                        👨‍💼
                                    </div>

                                    <h4>
                                        No Officers Found
                                    </h4>

                                    <p>
                                        Registered officers will appear here.
                                    </p>

                                </div>

                            </td>

                        </tr>

                        -->


                    </tbody>


                </table>


            </div>


        </div>


    </div>


</asp:Content>
