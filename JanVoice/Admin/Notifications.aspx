<%@ Page Title="Notifications"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="Notifications.aspx.cs"
    Inherits="JanVoice.Admin.Notifications" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

   
    <link href="../CSS/AdminNotifications.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="notifications-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="notifications-header">


            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Notifications
                </h1>

                <p>
                    Stay updated with important activities and system alerts.
                </p>

            </div>


            <div class="notification-header-actions">

                <button type="button"
                    class="mark-read-btn">

                    ✓

                    <span>
                        Mark All as Read
                    </span>

                </button>

            </div>


        </div>



        <!-- =====================================
             NOTIFICATION SUMMARY
        ====================================== -->

        <div class="notification-summary">


            <div class="notification-summary-card">


                <div class="summary-icon">
                    🔔
                </div>


                <div>

                    <span>
                        Total Notifications
                    </span>

                    <strong>
                        0
                    </strong>

                </div>


            </div>



            <div class="notification-summary-card unread">


                <div class="summary-icon unread-icon">
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



            <div class="notification-summary-card">


                <div class="summary-icon warning-icon">
                    ⚠
                </div>


                <div>

                    <span>
                        Important
                    </span>

                    <strong>
                        0
                    </strong>

                </div>


            </div>


        </div>



        <!-- =====================================
             FILTER BAR
        ====================================== -->

        <div class="notifications-toolbar">


            <div class="notification-tabs">

                <button type="button"
                    class="notification-tab active">

                    All

                </button>


                <button type="button"
                    class="notification-tab">

                    Unread

                </button>


                <button type="button"
                    class="notification-tab">

                    Important

                </button>

            </div>


            <select class="notification-filter">

                <option>
                    All Types
                </option>

                <option>
                    Complaint
                </option>

                <option>
                    User
                </option>

                <option>
                    Officer
                </option>

                <option>
                    System
                </option>

            </select>


        </div>



        <!-- =====================================
             NOTIFICATIONS CARD
        ====================================== -->

        <div class="notifications-card">


            <div class="notifications-card-header">


                <div>

                    <h3>
                        Recent Notifications
                    </h3>

                    <p>
                        Latest system and civic activity notifications.
                    </p>

                </div>


                <span class="notification-count">
                    0 Notifications
                </span>


            </div>



            <!-- =====================================
                 NOTIFICATION LIST
            ====================================== -->

            <div class="notification-list">



                <!-- NOTIFICATION 1 -->

                <div class="notification-item unread-item">


                    <div class="notification-icon complaint-notification">
                        📋
                    </div>


                    <div class="notification-content">


                        <div class="notification-title-row">

                            <strong>
                                New Complaint Reported
                            </strong>

                            <span class="unread-dot"></span>

                        </div>


                        <p>
                            A new civic complaint has been submitted by a citizen.
                        </p>


                        <div class="notification-meta">

                            <span>
                                Complaint
                            </span>

                            <span>
                                •
                            </span>

                            <span>
                                10 minutes ago
                            </span>

                        </div>


                    </div>


                    <a href="ManageComplaints.aspx"
                        class="notification-view-btn">

                        View

                    </a>


                </div>



                <!-- NOTIFICATION 2 -->

                <div class="notification-item unread-item">


                    <div class="notification-icon user-notification">
                        👤
                    </div>


                    <div class="notification-content">


                        <div class="notification-title-row">

                            <strong>
                                New Citizen Registered
                            </strong>

                            <span class="unread-dot"></span>

                        </div>


                        <p>
                            A new citizen account has been successfully registered.
                        </p>


                        <div class="notification-meta">

                            <span>
                                User
                            </span>

                            <span>
                                •
                            </span>

                            <span>
                                35 minutes ago
                            </span>

                        </div>


                    </div>


                    <a href="ManageUsers.aspx"
                        class="notification-view-btn">

                        View

                    </a>


                </div>



                <!-- NOTIFICATION 3 -->

                <div class="notification-item">


                    <div class="notification-icon officer-notification">
                        👨‍💼
                    </div>


                    <div class="notification-content">


                        <div class="notification-title-row">

                            <strong>
                                Officer Updated Complaint
                            </strong>

                        </div>


                        <p>
                            An assigned officer has updated the status of a complaint.
                        </p>


                        <div class="notification-meta">

                            <span>
                                Officer Activity
                            </span>

                            <span>
                                •
                            </span>

                            <span>
                                1 hour ago
                            </span>

                        </div>


                    </div>


                    <a href="ManageComplaints.aspx"
                        class="notification-view-btn">

                        View

                    </a>


                </div>



                <!-- NOTIFICATION 4 -->

                <div class="notification-item">


                    <div class="notification-icon success-notification">
                        ✓
                    </div>


                    <div class="notification-content">


                        <div class="notification-title-row">

                            <strong>
                                Complaint Resolved
                            </strong>

                        </div>


                        <p>
                            A reported civic issue has been marked as resolved.
                        </p>


                        <div class="notification-meta">

                            <span>
                                Complaint
                            </span>

                            <span>
                                •
                            </span>

                            <span>
                                2 hours ago
                            </span>

                        </div>


                    </div>


                    <a href="ManageComplaints.aspx"
                        class="notification-view-btn">

                        View

                    </a>


                </div>



                <!-- NOTIFICATION 5 -->

                <div class="notification-item important-item">


                    <div class="notification-icon warning-notification">
                        ⚠
                    </div>


                    <div class="notification-content">


                        <div class="notification-title-row">

                            <strong>
                                High Priority Complaint
                            </strong>

                            <span class="important-badge">
                                Important
                            </span>

                        </div>


                        <p>
                            A high-priority civic issue requires immediate attention.
                        </p>


                        <div class="notification-meta">

                            <span>
                                Priority Alert
                            </span>

                            <span>
                                •
                            </span>

                            <span>
                                3 hours ago
                            </span>

                        </div>


                    </div>


                    <a href="ManageComplaints.aspx"
                        class="notification-view-btn">

                        View

                    </a>


                </div>



            </div>



            <!-- =====================================
                 EMPTY STATE
            ====================================== -->

            <!--

            <div class="notifications-empty">

                <div class="empty-notification-icon">
                    🔔
                </div>

                <h4>
                    No Notifications
                </h4>

                <p>
                    New system activities and alerts will appear here.
                </p>

            </div>

            -->


        </div>


    </div>


</asp:Content>