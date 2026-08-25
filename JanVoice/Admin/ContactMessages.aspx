<%@ Page Title="Contact Messages"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ContactMessages.aspx.cs"
    Inherits="JanVoice.Admin.ContactMessages" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ContactMessages.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="contact-messages-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="messages-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Contact Messages
                </h1>

                <p>
                    Review and manage messages received from citizens.
                </p>

            </div>


            <div class="messages-header-info">

                <span>
                    INBOX
                </span>

                <strong>
                    Citizen Communication
                </strong>

            </div>

        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="message-stats">


            <!-- TOTAL -->

            <div class="message-stat-card">

                <div class="message-stat-icon">
                    ✉
                </div>

                <div>

                    <span>
                        Total Messages
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- UNREAD -->

            <div class="message-stat-card">

                <div class="message-stat-icon unread-icon">
                    ●
                </div>

                <div>

                    <span>
                        Unread
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- READ -->

            <div class="message-stat-card">

                <div class="message-stat-icon read-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Read
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>



            <!-- THIS MONTH -->

            <div class="message-stat-card">

                <div class="message-stat-icon month-icon">
                    ◷
                </div>

                <div>

                    <span>
                        This Month
                    </span>

                    <strong>
                        0
                    </strong>

                </div>

            </div>


        </div>



        <!-- =====================================
             SEARCH / FILTER TOOLBAR
        ====================================== -->

        <div class="messages-toolbar">


            <div class="message-search">

                <span>
                    🔍
                </span>

                <input
                    type="text"
                    placeholder="Search by name, email or subject..." />

            </div>


            <select class="message-filter">

                <option value="">
                    All Status
                </option>

                <option value="Unread">
                    Unread
                </option>

                <option value="Read">
                    Read
                </option>

            </select>


            <select class="message-filter">

                <option value="">
                    All Time
                </option>

                <option value="Today">
                    Today
                </option>

                <option value="Week">
                    This Week
                </option>

                <option value="Month">
                    This Month
                </option>

            </select>


            <button type="button"
                class="filter-btn">

                Apply Filters

            </button>


        </div>



        <!-- =====================================
             MESSAGES CARD
        ====================================== -->

        <div class="messages-card">


            <!-- CARD HEADER -->

            <div class="messages-card-header">

                <div>

                    <h3>
                        Received Messages
                    </h3>

                    <p>
                        Messages submitted through the JanVoice contact form.
                    </p>

                </div>


                <span class="record-count">
                    0 Messages
                </span>

            </div>



            <!-- =================================
                 TABLE
            ================================== -->

            <div class="messages-table-wrapper">


                <table class="messages-table">


                    <thead>

                        <tr>

                            <th>
                                SENDER
                            </th>

                            <th>
                                SUBJECT
                            </th>

                            <th>
                                EMAIL
                            </th>

                            <th>
                                RECEIVED
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
                             DEMO MESSAGE 1
                        ========================== -->

                        <tr>


                            <td>

                                <div class="sender-cell">

                                    <div class="sender-avatar">
                                        R
                                    </div>

                                    <div class="sender-info">

                                        <strong>
                                            Ritesh Jadhav
                                        </strong>

                                        <span>
                                            Citizen
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <td>

                                <div class="subject-cell">

                                    <strong>
                                        Query regarding complaint status
                                    </strong>

                                    <span>
                                        I would like to know the current status...
                                    </span>

                                </div>

                            </td>



                            <td>

                                <span class="email-text">
                                    ritesh@example.com
                                </span>

                            </td>



                            <td>
                                25 Aug 2026
                            </td>



                            <td>

                                <span class="message-status unread">
                                    Unread
                                </span>

                            </td>



                            <td>

                                <a href="#"
                                   class="view-message-btn">

                                    View

                                </a>

                            </td>


                        </tr>



                        <!-- =========================
                             DEMO MESSAGE 2
                        ========================== -->

                        <tr>


                            <td>

                                <div class="sender-cell">

                                    <div class="sender-avatar purple">
                                        A
                                    </div>

                                    <div class="sender-info">

                                        <strong>
                                            Amit Patil
                                        </strong>

                                        <span>
                                            Citizen
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <td>

                                <div class="subject-cell">

                                    <strong>
                                        Suggestion for Ward 1
                                    </strong>

                                    <span>
                                        I have a suggestion regarding...
                                    </span>

                                </div>

                            </td>



                            <td>

                                <span class="email-text">
                                    amit@example.com
                                </span>

                            </td>



                            <td>
                                24 Aug 2026
                            </td>



                            <td>

                                <span class="message-status read">
                                    Read
                                </span>

                            </td>



                            <td>

                                <a href="#"
                                   class="view-message-btn">

                                    View

                                </a>

                            </td>


                        </tr>



                        <!-- =========================
                             DEMO MESSAGE 3
                        ========================== -->

                        <tr>


                            <td>

                                <div class="sender-cell">

                                    <div class="sender-avatar green">
                                        S
                                    </div>

                                    <div class="sender-info">

                                        <strong>
                                            Sneha Deshmukh
                                        </strong>

                                        <span>
                                            Citizen
                                        </span>

                                    </div>

                                </div>

                            </td>



                            <td>

                                <div class="subject-cell">

                                    <strong>
                                        Help regarding registration
                                    </strong>

                                    <span>
                                        I am facing an issue while...
                                    </span>

                                </div>

                            </td>



                            <td>

                                <span class="email-text">
                                    sneha@example.com
                                </span>

                            </td>



                            <td>
                                23 Aug 2026
                            </td>



                            <td>

                                <span class="message-status read">
                                    Read
                                </span>

                            </td>



                            <td>

                                <a href="#"
                                   class="view-message-btn">

                                    View

                                </a>

                            </td>


                        </tr>


                    </tbody>


                </table>


            </div>


        </div>


    </div>


</asp:Content>