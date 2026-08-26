<%@ Page Title="Admin Profile"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="AdminProfile.aspx.cs"
    Inherits="JanVoice.Admin.AdminProfile" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/AdminProfile.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="admin-profile-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="profile-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Admin Profile
                </h1>

                <p>
                    View and manage your administrator account information.
                </p>

            </div>

        </div>



        <!-- =====================================
             PROFILE OVERVIEW
        ====================================== -->

        <div class="profile-overview-card">


            <div class="profile-main-info">


                <div class="profile-avatar">
                    A
                </div>


                <div class="profile-identity">

                    <h2>
                        Administrator
                    </h2>

                    <p>
                        System Administrator
                    </p>

                    <span class="profile-status">
                        ● Active
                    </span>

                </div>


            </div>


            <div class="profile-role">

                <span>
                    ACCOUNT ROLE
                </span>

                <strong>
                    Administrator
                </strong>

            </div>


        </div>



        <!-- =====================================
             ACCOUNT INFORMATION
        ====================================== -->

        <div class="profile-grid">


            <!-- PERSONAL INFORMATION -->

            <div class="profile-card">


                <div class="profile-card-header">

                    <div>

                        <h3>
                            Personal Information
                        </h3>

                        <p>
                            Basic administrator account details.
                        </p>

                    </div>

                </div>


                <div class="profile-details">


                    <div class="profile-detail-item">

                        <span>
                            FULL NAME
                        </span>

                        <strong>
                            Administrator
                        </strong>

                    </div>


                    <div class="profile-detail-item">

                        <span>
                            EMAIL ADDRESS
                        </span>

                        <strong>
                            admin@janvoice.com
                        </strong>

                    </div>


                    <div class="profile-detail-item">

                        <span>
                            CONTACT NUMBER
                        </span>

                        <strong>
                            +91 XXXXX XXXXX
                        </strong>

                    </div>


                    <div class="profile-detail-item">

                        <span>
                            ROLE
                        </span>

                        <strong>
                            System Administrator
                        </strong>

                    </div>


                </div>


            </div>



            <!-- ACCOUNT INFORMATION -->

            <div class="profile-card">


                <div class="profile-card-header">

                    <div>

                        <h3>
                            Account Information
                        </h3>

                        <p>
                            Information about your JanVoice account.
                        </p>

                    </div>

                </div>


                <div class="profile-details">


                    <div class="profile-detail-item">

                        <span>
                            USER ID
                        </span>

                        <strong>
                            #ADMIN001
                        </strong>

                    </div>


                    <div class="profile-detail-item">

                        <span>
                            ACCOUNT STATUS
                        </span>

                        <strong class="active-text">
                            Active
                        </strong>

                    </div>


                    <div class="profile-detail-item">

                        <span>
                            ACCOUNT CREATED
                        </span>

                        <strong>
                            01 Aug 2026
                        </strong>

                    </div>


                    <div class="profile-detail-item">

                        <span>
                            LAST LOGIN
                        </span>

                        <strong>
                            Recently
                        </strong>

                    </div>


                </div>


            </div>


        </div>



        <!-- =====================================
             SECURITY
        ====================================== -->

        <div class="profile-card security-card">


            <div class="profile-card-header">

                <div>

                    <h3>
                        Security
                    </h3>

                    <p>
                        Manage your administrator account security.
                    </p>

                </div>

            </div>


            <div class="security-item">


                <div class="security-icon">
                    🔐
                </div>


                <div class="security-info">

                    <strong>
                        Password
                    </strong>

                    <span>
                        Keep your administrator password secure.
                    </span>

                </div>


                <button type="button"
                    class="security-btn">

                    Change Password

                </button>


            </div>


        </div>



        <!-- =====================================
             ACCOUNT ACTIVITY
        ====================================== -->

        <div class="profile-card activity-card">


            <div class="profile-card-header">

                <div>

                    <h3>
                        Account Activity
                    </h3>

                    <p>
                        Recent administrator account activity.
                    </p>

                </div>

            </div>


            <div class="activity-list">


                <div class="activity-item">

                    <div class="activity-icon">
                        ✓
                    </div>

                    <div>

                        <strong>
                            Successful login
                        </strong>

                        <span>
                            Administrator logged into JanVoice.
                        </span>

                    </div>

                    <small>
                        Recently
                    </small>

                </div>


                <div class="activity-item">

                    <div class="activity-icon">
                        ⚙
                    </div>

                    <div>

                        <strong>
                            Profile accessed
                        </strong>

                        <span>
                            Administrator profile was viewed.
                        </span>

                    </div>

                    <small>
                        Recently
                    </small>

                </div>


            </div>


        </div>


    </div>


</asp:Content>