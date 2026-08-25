<%@ Page Title="Manage Wards"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageWards.aspx.cs"
    Inherits="JanVoice.Admin.ManageWards" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ManageWards.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="manage-wards-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="wards-header">


            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Manage Wards
                </h1>

                <p>
                    Manage administrative wards and monitor civic activity.
                </p>

            </div>


            <button type="button"
                class="add-ward-btn">

                <span>＋</span>

                Add New Ward

            </button>


        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="ward-stats">


            <!-- TOTAL WARDS -->

            <div class="ward-stat-card">

                <div class="ward-stat-icon">
                    ◇
                </div>

                <div>

                    <span>
                        Total Wards
                    </span>

                    <strong>
                        0
                    </strong>

                    <small>
                        Registered wards
                    </small>

                </div>

            </div>



            <!-- ACTIVE WARDS -->

            <div class="ward-stat-card">

                <div class="ward-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Active Wards
                    </span>

                    <strong>
                        0
                    </strong>

                    <small>
                        Currently active
                    </small>

                </div>

            </div>



            <!-- OFFICERS -->

            <div class="ward-stat-card">

                <div class="ward-stat-icon officer-icon">
                    👨‍💼
                </div>

                <div>

                    <span>
                        Assigned Officers
                    </span>

                    <strong>
                        0
                    </strong>

                    <small>
                        Across all wards
                    </small>

                </div>

            </div>



            <!-- COMPLAINTS -->

            <div class="ward-stat-card">

                <div class="ward-stat-icon complaint-icon">
                    📋
                </div>

                <div>

                    <span>
                        Total Complaints
                    </span>

                    <strong>
                        0
                    </strong>

                    <small>
                        Reported across wards
                    </small>

                </div>

            </div>


        </div>



        <!-- =====================================
             SEARCH / FILTER
        ====================================== -->

        <div class="wards-toolbar">


            <div class="ward-search">

                <span>
                    🔍
                </span>

                <input type="text"
                    placeholder="Search by ward name or number..." />

            </div>


            <select class="ward-filter">

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
             WARDS TABLE
        ====================================== -->

        <div class="wards-card">


            <!-- CARD HEADER -->

            <div class="wards-card-header">


                <div>

                    <h3>
                        Registered Wards
                    </h3>

                    <p>
                        Administrative wards configured in JanVoice.
                    </p>

                </div>


                <span class="record-count">
                    0 Wards
                </span>


            </div>



            <!-- TABLE -->

            <div class="wards-table-wrapper">


                <table class="wards-table">


                    <thead>

                        <tr>

                            <th>
                                WARD
                            </th>

                            <th>
                                WARD NUMBER
                            </th>

                            <th>
                                OFFICERS
                            </th>

                            <th>
                                COMPLAINTS
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


                        <!-- DEMO WARD 1 -->

                        <tr>


                            <td>

                                <div class="ward-cell">

                                    <div class="ward-icon">
                                        W1
                                    </div>

                                    <div>

                                        <strong>
                                            Central Ward
                                        </strong>

                                        <span>
                                            Ward administrative area
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td>

                                <span class="ward-number">
                                    01
                                </span>

                            </td>


                            <td>

                                <strong class="ward-count">
                                    2
                                </strong>

                            </td>


                            <td>

                                <strong class="complaint-count">
                                    24
                                </strong>

                            </td>


                            <td>

                                <span class="ward-status active">
                                    Active
                                </span>

                            </td>


                            <td>

                                <div class="ward-actions">

                                    <a href="#"
                                        class="ward-action view">
                                        View
                                    </a>

                                    <a href="#"
                                        class="ward-action edit">
                                        Edit
                                    </a>

                                </div>

                            </td>


                        </tr>



                        <!-- DEMO WARD 2 -->

                        <tr>


                            <td>

                                <div class="ward-cell">

                                    <div class="ward-icon purple">
                                        W2
                                    </div>

                                    <div>

                                        <strong>
                                            East Ward
                                        </strong>

                                        <span>
                                            Ward administrative area
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td>

                                <span class="ward-number">
                                    02
                                </span>

                            </td>


                            <td>

                                <strong class="ward-count">
                                    3
                                </strong>

                            </td>


                            <td>

                                <strong class="complaint-count">
                                    18
                                </strong>

                            </td>


                            <td>

                                <span class="ward-status active">
                                    Active
                                </span>

                            </td>


                            <td>

                                <div class="ward-actions">

                                    <a href="#"
                                        class="ward-action view">
                                        View
                                    </a>

                                    <a href="#"
                                        class="ward-action edit">
                                        Edit
                                    </a>

                                </div>

                            </td>


                        </tr>



                        <!-- DEMO WARD 3 -->

                        <tr>


                            <td>

                                <div class="ward-cell">

                                    <div class="ward-icon cyan">
                                        W3
                                    </div>

                                    <div>

                                        <strong>
                                            North Ward
                                        </strong>

                                        <span>
                                            Ward administrative area
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td>

                                <span class="ward-number">
                                    03
                                </span>

                            </td>


                            <td>

                                <strong class="ward-count">
                                    1
                                </strong>

                            </td>


                            <td>

                                <strong class="complaint-count">
                                    11
                                </strong>

                            </td>


                            <td>

                                <span class="ward-status active">
                                    Active
                                </span>

                            </td>


                            <td>

                                <div class="ward-actions">

                                    <a href="#"
                                        class="ward-action view">
                                        View
                                    </a>

                                    <a href="#"
                                        class="ward-action edit">
                                        Edit
                                    </a>

                                </div>

                            </td>


                        </tr>



                        <!-- EMPTY STATE -->

                        <!--

                        <tr>

                            <td colspan="6">

                                <div class="wards-empty">

                                    <div>
                                        ◇
                                    </div>

                                    <h4>
                                        No Wards Found
                                    </h4>

                                    <p>
                                        Registered wards will appear here.
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