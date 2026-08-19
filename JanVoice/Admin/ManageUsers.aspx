<%@ Page Title="Manage Users"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageUsers.aspx.cs"
    Inherits="JanVoice.Admin.ManageUsers" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">
    <link href="../CSS/ManageUsers.css" rel="stylesheet" />
    
</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="manage-users-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="users-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Manage Users
                </h1>

                <p>
                    View and manage registered citizens across JanVoice.
                </p>

            </div>


            <div class="users-header-info">

                <span>
                    Citizen Accounts
                </span>

                <strong>
                    Active
                </strong>

            </div>

        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="user-stats">


            <div class="user-stat-card">

                <div class="user-stat-icon">
                    👥
                </div>

                <div>

                    <span>
                        Total Users
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>


            <div class="user-stat-card">

                <div class="user-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Active Users
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>


            <div class="user-stat-card">

                <div class="user-stat-icon inactive-icon">
                    ●
                </div>

                <div>

                    <span>
                        Inactive Users
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>


            <div class="user-stat-card">

                <div class="user-stat-icon complaint-icon">
                    📋
                </div>

                <div>

                    <span>
                        Registered This Month
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>


        </div>



        <!-- =====================================
             SEARCH / FILTER
        ====================================== -->

        <div class="users-toolbar">


            <div class="user-search">

                <span>
                    🔍
                </span>

                <input
                    type="text"
                    placeholder="Search by name or email..." />

            </div>


            <select class="user-filter">

                <option value="">
                    All Wards
                </option>

                <option value="1">
                    Ward 1
                </option>

                <option value="2">
                    Ward 2
                </option>

                <option value="3">
                    Ward 3
                </option>

            </select>


            <select class="user-filter">

                <option value="">
                    All Status
                </option>

                <option value="Active">
                    Active
                </option>

                <option value="Inactive">
                    Inactive
                </option>

            </select>


            <button type="button"
                class="filter-btn">

                Apply Filters

            </button>


        </div>



        <!-- =====================================
             USERS TABLE
        ====================================== -->

        <div class="users-card">


            <div class="users-card-header">

                <div>

                    <h3>
                        Registered Citizens
                    </h3>

                    <p>
                        Citizens currently registered on JanVoice.
                    </p>

                </div>


                <span class="record-count">
                    0 Users
                </span>

            </div>


            <div class="users-table-wrapper">


                <table class="users-table">

                    <thead>

                        <tr>

                            <th>
                                USER
                            </th>

                            <th>
                                CONTACT
                            </th>

                            <th>
                                WARD
                            </th>

                            <th>
                                COMPLAINTS
                            </th>

                            <th>
                                REGISTERED
                            </th>

                            <th>
                                STATUS
                            </th>

                            <th>
                                ACTION
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                        <!-- DEMO USER 1 -->

                        <tr>

                            <td>

                                <div class="user-cell">

                                    <div class="user-avatar">
                                        R
                                    </div>

                                    <div>

                                        <strong>
                                            Ritesh Jadhav
                                        </strong>

                                        <span>
                                            User ID: #001
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td>

                                <div class="contact-cell">

                                    <span>
                                        ritesh@example.com
                                    </span>

                                    <small>
                                        +91 XXXXX XXXXX
                                    </small>

                                </div>

                            </td>


                            <td>
                                Ward 2
                            </td>


                            <td>
                                <strong class="complaint-count">
                                    4
                                </strong>
                            </td>


                            <td>
                                18 Aug 2026
                            </td>


                            <td>

                                <span class="user-status active">
                                    Active
                                </span>

                            </td>


                            <td>

                                <a href="#"
                                   class="view-user-btn">

                                    View

                                </a>

                            </td>

                        </tr>



                        <!-- DEMO USER 2 -->

                        <tr>

                            <td>

                                <div class="user-cell">

                                    <div class="user-avatar purple">
                                        A
                                    </div>

                                    <div>

                                        <strong>
                                            Amit Patil
                                        </strong>

                                        <span>
                                            User ID: #002
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td>

                                <div class="contact-cell">

                                    <span>
                                        amit@example.com
                                    </span>

                                    <small>
                                        +91 XXXXX XXXXX
                                    </small>

                                </div>

                            </td>


                            <td>
                                Ward 1
                            </td>


                            <td>
                                <strong class="complaint-count">
                                    2
                                </strong>
                            </td>


                            <td>
                                17 Aug 2026
                            </td>


                            <td>

                                <span class="user-status active">
                                    Active
                                </span>

                            </td>


                            <td>

                                <a href="#"
                                   class="view-user-btn">

                                    View

                                </a>

                            </td>

                        </tr>



                        <!-- EMPTY STATE -->

                        <!--

                        <tr>

                            <td colspan="7">

                                <div class="users-empty">

                                    <div>
                                        👥
                                    </div>

                                    <h4>
                                        No Users Found
                                    </h4>

                                    <p>
                                        Registered citizens will appear here.
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