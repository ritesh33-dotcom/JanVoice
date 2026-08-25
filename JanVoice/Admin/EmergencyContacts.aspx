<%@ Page Title="Emergency Contacts"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="EmergencyContacts.aspx.cs"
    Inherits="JanVoice.Admin.EmergencyContacts" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/EmergencyContacts.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="emergency-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="emergency-header">


            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Emergency Contacts
                </h1>

                <p>
                    Manage important emergency contacts available to citizens.
                </p>

            </div>


            <div class="emergency-header-info">

                <span>
                    PUBLIC SAFETY
                </span>

                <strong>
                    Emergency Directory
                </strong>

            </div>


        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="emergency-stats">


            <!-- TOTAL -->

            <div class="emergency-stat-card">

                <div class="emergency-stat-icon">
                    ☎
                </div>

                <div>

                    <span>
                        Total Contacts
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- ACTIVE -->

            <div class="emergency-stat-card">

                <div class="emergency-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Active Contacts
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- DEPARTMENT -->

            <div class="emergency-stat-card">

                <div class="emergency-stat-icon department-icon">
                    ✚
                </div>

                <div>

                    <span>
                        Departments
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- UPDATED -->

            <div class="emergency-stat-card">

                <div class="emergency-stat-icon update-icon">
                    ◷
                </div>

                <div>

                    <span>
                        Recently Updated
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>


        </div>



        <!-- =====================================
             TOOLBAR
        ====================================== -->

        <div class="emergency-toolbar">


            <div class="emergency-search">

                <span>
                    🔍
                </span>

                <input
                    type="text"
                    placeholder="Search emergency contact..." />

            </div>


            <select class="emergency-filter">

                <option value="">
                    All Categories
                </option>

                <option value="Police">
                    Police
                </option>

                <option value="Medical">
                    Medical
                </option>

                <option value="Fire">
                    Fire & Rescue
                </option>

                <option value="Other">
                    Other
                </option>

            </select>


            <select class="emergency-filter">

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


            <button type="button"
                class="add-contact-btn">

                + Add Contact

            </button>


        </div>



        <!-- =====================================
             CONTACTS CARD
        ====================================== -->

        <div class="emergency-card">


            <!-- CARD HEADER -->

            <div class="emergency-card-header">


                <div>

                    <h3>
                        Emergency Directory
                    </h3>

                    <p>
                        Emergency information displayed to JanVoice citizens.
                    </p>

                </div>


                <span class="record-count">
                    0 Contacts
                </span>


            </div>



            <!-- =================================
                 CONTACT TABLE
            ================================== -->

            <div class="emergency-table-wrapper">


                <table class="emergency-table">


                    <thead>

                        <tr>

                            <th>
                                CONTACT
                            </th>

                            <th>
                                CATEGORY
                            </th>

                            <th>
                                PHONE
                            </th>

                            <th>
                                DESCRIPTION
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


                        <!-- =========================
                             DEMO CONTACT 1
                        ========================== -->

                        <tr>


                            <td>

                                <div class="contact-cell">

                                    <div class="contact-icon police">
                                        ⚠
                                    </div>

                                    <div class="contact-info">

                                        <strong>
                                            Police
                                        </strong>

                                        <span>
                                            Emergency Police Services
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td>

                                <span class="category-badge police-badge">
                                    Police
                                </span>

                            </td>


                            <td>

                                <strong class="phone-number">
                                    100
                                </strong>

                            </td>


                            <td>

                                <span class="description-text">
                                    Police emergency assistance.
                                </span>

                            </td>


                            <td>

                                <span class="contact-status active">
                                    Active
                                </span>

                            </td>


                            <td>

                                <div class="contact-actions">

                                    <a href="#"
                                       class="edit-contact-btn">

                                        Edit

                                    </a>

                                    <a href="#"
                                       class="delete-contact-btn">

                                        Remove

                                    </a>

                                </div>

                            </td>


                        </tr>



                        <!-- =========================
                             DEMO CONTACT 2
                        ========================== -->

                        <tr>


                            <td>

                                <div class="contact-cell">

                                    <div class="contact-icon medical">
                                        +
                                    </div>

                                    <div class="contact-info">

                                        <strong>
                                            Ambulance
                                        </strong>

                                        <span>
                                            Medical Emergency Services
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td>

                                <span class="category-badge medical-badge">
                                    Medical
                                </span>

                            </td>


                            <td>

                                <strong class="phone-number">
                                    108
                                </strong>

                            </td>


                            <td>

                                <span class="description-text">
                                    Emergency medical assistance.
                                </span>

                            </td>


                            <td>

                                <span class="contact-status active">
                                    Active
                                </span>

                            </td>


                            <td>

                                <div class="contact-actions">

                                    <a href="#"
                                       class="edit-contact-btn">

                                        Edit

                                    </a>

                                    <a href="#"
                                       class="delete-contact-btn">

                                        Remove

                                    </a>

                                </div>

                            </td>


                        </tr>



                        <!-- =========================
                             DEMO CONTACT 3
                        ========================== -->

                        <tr>


                            <td>

                                <div class="contact-cell">

                                    <div class="contact-icon fire">
                                        🔥
                                    </div>

                                    <div class="contact-info">

                                        <strong>
                                            Fire & Rescue
                                        </strong>

                                        <span>
                                            Fire Emergency Services
                                        </span>

                                    </div>

                                </div>

                            </td>


                            <td>

                                <span class="category-badge fire-badge">
                                    Fire & Rescue
                                </span>

                            </td>


                            <td>

                                <strong class="phone-number">
                                    101
                                </strong>

                            </td>


                            <td>

                                <span class="description-text">
                                    Fire and rescue emergency assistance.
                                </span>

                            </td>


                            <td>

                                <span class="contact-status active">
                                    Active
                                </span>

                            </td>


                            <td>

                                <div class="contact-actions">

                                    <a href="#"
                                       class="edit-contact-btn">

                                        Edit

                                    </a>

                                    <a href="#"
                                       class="delete-contact-btn">

                                        Remove

                                    </a>

                                </div>

                            </td>


                        </tr>



                    </tbody>


                </table>


            </div>


        </div>


    </div>


</asp:Content>