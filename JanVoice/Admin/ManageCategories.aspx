<%@ Page Title="Manage Categories"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageCategories.aspx.cs"
    Inherits="JanVoice.Admin.ManageCategories" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ManageCategories.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="manage-categories-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="categories-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Manage Categories
                </h1>

                <p>
                    Manage civic issue categories used across JanVoice.
                </p>

            </div>


            <div class="categories-header-action">

                <button type="button"
                    class="add-category-btn">

                    <span>
                        +
                    </span>

                    Add Category

                </button>

            </div>

        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="category-stats">


            <!-- TOTAL -->

            <div class="category-stat-card">

                <div class="category-stat-icon">
                    #
                </div>

                <div>

                    <span>
                        Total Categories
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- ACTIVE -->

            <div class="category-stat-card">

                <div class="category-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Active Categories
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- INACTIVE -->

            <div class="category-stat-card">

                <div class="category-stat-icon inactive-icon">
                    ●
                </div>

                <div>

                    <span>
                        Inactive Categories
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- COMPLAINTS -->

            <div class="category-stat-card">

                <div class="category-stat-icon complaint-icon">
                    📋
                </div>

                <div>

                    <span>
                        Categorized Complaints
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

        <div class="categories-toolbar">


            <!-- SEARCH -->

            <div class="category-search">

                <span>
                    🔍
                </span>

                <input
                    type="text"
                    placeholder="Search category..." />

            </div>



            <!-- STATUS FILTER -->

            <select class="category-filter">

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



            <!-- APPLY FILTER -->

            <button type="button"
                class="filter-btn">

                Apply Filters

            </button>


        </div>



        <!-- =====================================
             CATEGORY TABLE
        ====================================== -->

        <div class="categories-card">


            <!-- CARD HEADER -->

            <div class="categories-card-header">

                <div>

                    <h3>
                        Civic Categories
                    </h3>

                    <p>
                        Categories available for citizen complaints.
                    </p>

                </div>


                <span class="record-count">
                    0 Categories
                </span>

            </div>



            <!-- TABLE -->

            <div class="categories-table-wrapper">


                <table class="categories-table">


                    <thead>

                        <tr>

                            <th>
                                CATEGORY
                            </th>

                            <th>
                                DESCRIPTION
                            </th>

                            <th>
                                COMPLAINTS
                            </th>

                            <th>
                                CREATED
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


                        <!-- =====================================
                             DEMO CATEGORY 1
                        ====================================== -->

                        <tr>


                            <td>

                                <div class="category-cell">

                                    <div class="category-icon">
                                        🛣️
                                    </div>

                                    <div>

                                        <strong>
                                            Roads & Potholes
                                        </strong>

                                        <span>
                                            Category ID: #001
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <td>

                                <span class="category-description">
                                    Road damage, potholes and related issues.
                                </span>

                            </td>



                            <td>

                                <strong class="complaint-count">
                                    12
                                </strong>

                            </td>



                            <td>
                                10 Aug 2026
                            </td>



                            <td>

                                <span class="category-status active">
                                    Active
                                </span>

                            </td>



                            <td>

                                <div class="category-actions">

                                    <a href="#"
                                       class="edit-category-btn">

                                        Edit

                                    </a>

                                    <a href="#"
                                       class="view-category-btn">

                                        View

                                    </a>

                                </div>

                            </td>


                        </tr>



                        <!-- =====================================
                             DEMO CATEGORY 2
                        ====================================== -->

                        <tr>


                            <td>

                                <div class="category-cell">

                                    <div class="category-icon purple">
                                        💡
                                    </div>

                                    <div>

                                        <strong>
                                            Street Lights
                                        </strong>

                                        <span>
                                            Category ID: #002
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <td>

                                <span class="category-description">
                                    Damaged or non-working street lights.
                                </span>

                            </td>



                            <td>

                                <strong class="complaint-count">
                                    8
                                </strong>

                            </td>



                            <td>
                                10 Aug 2026
                            </td>



                            <td>

                                <span class="category-status active">
                                    Active
                                </span>

                            </td>



                            <td>

                                <div class="category-actions">

                                    <a href="#"
                                       class="edit-category-btn">

                                        Edit

                                    </a>

                                    <a href="#"
                                       class="view-category-btn">

                                        View

                                    </a>

                                </div>

                            </td>


                        </tr>



                        <!-- =====================================
                             DEMO CATEGORY 3
                        ====================================== -->

                        <tr>


                            <td>

                                <div class="category-cell">

                                    <div class="category-icon green">
                                        🗑️
                                    </div>

                                    <div>

                                        <strong>
                                            Garbage & Waste
                                        </strong>

                                        <span>
                                            Category ID: #003
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <td>

                                <span class="category-description">
                                    Garbage collection and waste management issues.
                                </span>

                            </td>



                            <td>

                                <strong class="complaint-count">
                                    15
                                </strong>

                            </td>



                            <td>
                                11 Aug 2026
                            </td>



                            <td>

                                <span class="category-status active">
                                    Active
                                </span>

                            </td>



                            <td>

                                <div class="category-actions">

                                    <a href="#"
                                       class="edit-category-btn">

                                        Edit

                                    </a>

                                    <a href="#"
                                       class="view-category-btn">

                                        View

                                    </a>

                                </div>

                            </td>


                        </tr>



                        <!-- =====================================
                             EMPTY STATE
                        ====================================== -->

                        <!--

                        <tr>

                            <td colspan="6">

                                <div class="categories-empty">

                                    <div>
                                        #
                                    </div>

                                    <h4>
                                        No Categories Found
                                    </h4>

                                    <p>
                                        Create a category to organize citizen complaints.
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