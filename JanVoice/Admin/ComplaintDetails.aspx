<%@ Page Title="Complaint Details"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ComplaintDetails.aspx.cs"
    Inherits="JanVoice.Admin.ComplaintDetails" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/AdminComplaintDetails.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="complaint-details-page">


        <!-- =====================================
             BACK BUTTON
        ====================================== -->

        <div class="details-back">

            <a href="ManageComplaints.aspx">← Back to Complaints
            </a>

        </div>


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="details-header">

            <div>

                <span class="page-label">COMPLAINT MANAGEMENT
                </span>

                <h1>Complaint Details
                </h1>

                <p>
                    Review the complete information and activity
                    associated with this civic complaint.
                </p>

            </div>


            <div class="header-status">

                <span class="status-badge pending">Pending
                </span>

            </div>

        </div>



        <!-- =====================================
             MAIN GRID
        ====================================== -->

        <div class="details-grid">


            <!-- =================================
                 LEFT COLUMN
            ================================== -->

            <div class="details-main">


                <!-- COMPLAINT INFORMATION -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Complaint Information
                            </h3>

                            <p>
                                Details submitted by the citizen.
                            </p>

                        </div>

                        <span class="complaint-number">#1024
                        </span>

                    </div>


                    <div class="complaint-content">


                        <span class="category-badge">Road
                        </span>


                        <h2>Damaged road near market
                        </h2>


                        <p class="complaint-description">
                            Large potholes have developed on the main
                            road near the market area. The damaged road
                            is creating difficulty for vehicles and may
                            cause accidents.

                        </p>


                        <!-- IMAGE -->

                        <div class="complaint-image">

                            <img src="../Images/#"
                                alt="Complaint Image" />

                        </div>


                        <!-- META -->

                        <div class="complaint-meta">


                            <div class="meta-item">

                                <span>📍
                                </span>

                                <div>

                                    <small>Location
                                    </small>

                                    <strong>Main Market Road
                                    </strong>

                                </div>

                            </div>


                            <div class="meta-item">

                                <span>🏘
                                </span>

                                <div>

                                    <small>Ward
                                    </small>

                                    <strong>Ward 2
                                    </strong>

                                </div>

                            </div>


                            <div class="meta-item">

                                <span>📅
                                </span>

                                <div>

                                    <small>Reported On
                                    </small>

                                    <strong>18 Aug 2026
                                    </strong>

                                </div>

                            </div>


                        </div>


                    </div>

                </div>



                <!-- =================================
                     STATUS HISTORY
                ================================== -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Status History
                            </h3>

                            <p>
                                Track the progress of this complaint.
                            </p>

                        </div>

                    </div>


                    <div class="timeline">


                        <!-- STEP -->

                        <div class="timeline-item completed">

                            <div class="timeline-dot">
                                ✓
                            </div>

                            <div class="timeline-content">

                                <strong>Complaint Submitted
                                </strong>

                                <span>Citizen reported the issue.
                                </span>

                                <small>18 Aug 2026 • 10:30 AM
                                </small>

                            </div>

                        </div>


                        <!-- STEP -->

                        <div class="timeline-item completed">

                            <div class="timeline-dot">
                                ✓
                            </div>

                            <div class="timeline-content">

                                <strong>Complaint Reviewed
                                </strong>

                                <span>Complaint verified by administration.
                                </span>

                                <small>18 Aug 2026 • 11:15 AM
                                </small>

                            </div>

                        </div>


                        <!-- CURRENT -->

                        <div class="timeline-item current">

                            <div class="timeline-dot">
                                !
                            </div>

                            <div class="timeline-content">

                                <strong>Pending Assignment
                                </strong>

                                <span>Waiting for an officer to be assigned.
                                </span>

                                <small>Current Status
                                </small>

                            </div>

                        </div>


                    </div>

                </div>


            </div>



            <!-- =================================
                 RIGHT COLUMN
            ================================== -->

            <div class="details-sidebar">


                <!-- CITIZEN -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Reported By
                            </h3>

                        </div>

                    </div>


                    <div class="citizen-profile">


                        <div class="large-avatar">
                            R
                        </div>


                        <div>

                            <strong>Ritesh Jadhav
                            </strong>

                            <span>Citizen
                            </span>

                        </div>

                    </div>


                    <div class="profile-details">

                        <div>

                            <span>Email
                            </span>

                            <strong>ritesh@example.com
                            </strong>

                        </div>


                        <div>

                            <span>Phone
                            </span>

                            <strong>+91 XXXXX XXXXX
                            </strong>

                        </div>

                    </div>

                </div>



                <!-- PRIORITY -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Complaint Priority
                            </h3>

                            <p>
                                Current priority level.
                            </p>

                        </div>

                    </div>


                    <div class="priority-display high">

                        <span>!
                        </span>

                        <div>

                            <strong>High Priority
                            </strong>

                            <small>Requires attention
                            </small>

                        </div>

                    </div>

                </div>



                <!-- ASSIGNED OFFICER -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Assigned Officer
                            </h3>

                            <p>
                                Officer responsible for this complaint.
                            </p>

                        </div>

                    </div>


                    <div class="officer-empty">

                        <div>
                            👨‍💼
                        </div>

                        <strong>No Officer Assigned
                        </strong>

                        <span>This complaint is waiting for assignment.
                        </span>

                    </div>


                    <button type="button"
                        class="assign-btn">
                        Assign Officer

                    </button>

                </div>



                <!-- ADMIN ACTIONS -->

                <div class="details-card admin-actions-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Admin Actions
                            </h3>

                            <p>
                                Manage this complaint.
                            </p>

                        </div>

                    </div>


                    <div class="admin-actions">


                        <button type="button"
                            class="action-btn primary">
                            Assign Officer

                        </button>


                        <button type="button"
                            class="action-btn warning">
                            Change Priority

                        </button>


                        <button type="button"
                            class="action-btn danger">
                            Reject Complaint

                        </button>

                    </div>

                </div>


            </div>


        </div>


    </div>


</asp:Content>
