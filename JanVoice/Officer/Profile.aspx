<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="JanVoice.Officer.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../CSS/profile.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- =========================================================
         OFFICER PROFILE PAGE
    ========================================================== -->

    <section class="profile-page">

        <div class="profile-container">


            <!-- =====================================================
                 PROFILE HERO
            ====================================================== -->

            <div class="profile-hero">

                <div class="profile-hero-content">

                    <span class="profile-badge">

                        <i class="fa-solid fa-user-shield"></i>

                        OFFICER ACCOUNT

                    </span>


                    <h1>Officer Profile
                    </h1>


                    <p>
                        View your personal information, professional
                        details and account information.
                   
                    </p>

                </div>


                <div class="profile-hero-icon">

                    <i class="fa-solid fa-user"></i>

                </div>

            </div>



            <!-- =====================================================
                 PROFILE MAIN GRID
            ====================================================== -->

            <div class="profile-main-grid">


                <!-- =================================================
                     PROFILE SUMMARY
                ================================================== -->

                <div class="profile-summary-card">


                    <!-- AVATAR -->

                    <div class="profile-avatar">

                        <i class="fa-solid fa-user"></i>

                    </div>


                    <h2>Officer Profile
                    </h2>


                    <p>
                        JanVoice Officer
                   
                    </p>


                    <!-- STATUS -->

                    <span class="profile-status">

                        <span class="profile-status-dot"></span>

                        Active Account

                    </span>


                    <div class="profile-summary-divider"></div>


                    <!-- OFFICER ID -->

                    <div class="profile-summary-item">

                        <i class="fa-solid fa-id-card"></i>

                        <div>

                            <span>Officer ID
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblOfficerID"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>

                    </div>


                    <!-- DEPARTMENT -->

                    <div class="profile-summary-item">

                        <i class="fa-solid fa-building"></i>

                        <div>

                            <span>Department
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblDepartment"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>

                    </div>


                </div>



                <!-- =================================================
                     PERSONAL INFORMATION CARD
                ================================================== -->

                <div class="profile-information-card">


                    <!-- =================================================
                         CARD HEADER
                    ================================================== -->

                    <div class="profile-card-header">

                        <div>

                            <span class="profile-section-badge">

                                <i class="fa-solid fa-user"></i>

                                PERSONAL INFORMATION

                            </span>


                            <h2>Personal Details
                            </h2>


                            <p>
                                View and update your registered
                                personal information.
                           
                            </p>

                        </div>


                        <div class="profile-card-header-icon">

                            <i class="fa-solid fa-address-card"></i>

                        </div>

                    </div>



                    <!-- =================================================
                         VIEW MODE
                    ================================================== -->

                    <asp:Panel
                        ID="pnlPersonalView"
                        runat="server"
                        CssClass="profile-details-grid">


                        <!-- FULL NAME -->

                        <div class="profile-detail-item">

                            <span class="profile-detail-label">

                                <i class="fa-solid fa-user"></i>

                                Full Name

                            </span>


                            <strong>

                                <asp:Label
                                    ID="lblFullName"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- EMAIL -->

                        <div class="profile-detail-item">

                            <span class="profile-detail-label">

                                <i class="fa-solid fa-envelope"></i>

                                Email Address

                            </span>


                            <strong>

                                <asp:Label
                                    ID="lblEmail"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- MOBILE -->

                        <div class="profile-detail-item">

                            <span class="profile-detail-label">

                                <i class="fa-solid fa-phone"></i>

                                Mobile Number

                            </span>


                            <strong>

                                <asp:Label
                                    ID="lblMobile"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- USERNAME -->

                        <div class="profile-detail-item">

                            <span class="profile-detail-label">

                                <i class="fa-solid fa-at"></i>

                                Username

                            </span>


                            <strong>

                                <asp:Label
                                    ID="lblUsername"
                                    runat="server"
                                    Text="Officer">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- ROLE -->

                        <div class="profile-detail-item">

                            <span class="profile-detail-label">

                                <i class="fa-solid fa-user-tie"></i>

                                Role

                            </span>


                            <strong>

                                <asp:Label
                                    ID="lblDesignation"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- ASSIGNED AREA -->

                        <div class="profile-detail-item">

                            <span class="profile-detail-label">

                                <i class="fa-solid fa-location-dot"></i>

                                Assigned Area

                            </span>


                            <strong>

                                <asp:Label
                                    ID="lblAssignedArea"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- ADDRESS -->

                        <div class="profile-detail-item profile-detail-full">

                            <span class="profile-detail-label">

                                <i class="fa-solid fa-house"></i>

                                Address

                            </span>


                            <strong>

                                <asp:Label
                                    ID="lblAddress"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>


                    </asp:Panel>



                    <!-- =================================================
                         EDIT MODE
                    ================================================== -->

                    <!-- =================================================
     EDIT MODE
================================================== -->

                    <asp:Panel
                        ID="pnlPersonalEdit"
                        runat="server"
                        CssClass="profile-edit-form"
                        Visible="false">

                        <!-- FULL NAME -->

                        <div class="profile-edit-group">

                            <label>
                                Full Name
                            </label>

                            <asp:TextBox
                                ID="txtEditFullName"
                                runat="server"
                                CssClass="profile-edit-input"
                                placeholder="Enter your full name">
                            </asp:TextBox>

                        </div>


                        <!-- EMAIL -->

                        <div class="profile-edit-group">

                            <label>
                                Email Address
                            </label>

                            <asp:TextBox
                                ID="txtEditEmail"
                                runat="server"
                                CssClass="profile-edit-input"
                                TextMode="Email"
                                placeholder="Enter your email address">
                            </asp:TextBox>

                        </div>


                        <!-- MOBILE -->

                        <div class="profile-edit-group">

                            <label>
                                Mobile Number
                            </label>

                            <asp:TextBox
                                ID="txtEditMobile"
                                runat="server"
                                CssClass="profile-edit-input"
                                placeholder="Enter your mobile number">
                            </asp:TextBox>

                        </div>


                        <!-- ADDRESS -->

                        <div class="profile-edit-group">

                            <label>
                                Address
                            </label>

                            <asp:TextBox
                                ID="txtEditAddress"
                                runat="server"
                                CssClass="profile-edit-input profile-edit-textarea"
                                TextMode="MultiLine"
                                Rows="4"
                                placeholder="Enter your address">
                            </asp:TextBox>

                        </div>


                        <!-- BUTTONS -->

                        <div class="profile-edit-actions">

                            <asp:Button
                                ID="btnCancelPersonalEdit"
                                runat="server"
                                Text="Cancel"
                                CssClass="profile-cancel-button"
                                CausesValidation="false"
                                OnClick="btnCancelPersonalEdit_Click" />


                            <asp:Button
                                ID="btnSavePersonalDetails"
                                runat="server"
                                Text="Save Changes"
                                CssClass="profile-save-button"
                                OnClick="btnSavePersonalDetails_Click" />

                        </div>


                        <!-- MESSAGE -->

                        <asp:Label
                            ID="lblPersonalMessage"
                            runat="server"
                            CssClass="profile-message">
                        </asp:Label>

                    </asp:Panel>


                </div>

            </div>



            <!-- =====================================================
                 ACCOUNT INFORMATION
            ====================================================== -->

            <div class="profile-account-card">


                <!-- HEADER -->

                <div class="profile-card-header">

                    <div>

                        <span class="profile-section-badge">

                            <i class="fa-solid fa-shield-halved"></i>

                            ACCOUNT INFORMATION

                        </span>


                        <h2>Account Details
                        </h2>


                        <p>
                            Information about your JanVoice account.
                       
                        </p>

                    </div>


                    <div class="profile-card-header-icon">

                        <i class="fa-solid fa-lock"></i>

                    </div>

                </div>



                <!-- ACCOUNT GRID -->

                <div class="profile-account-grid">


                    <!-- ACCOUNT STATUS -->

                    <div class="profile-account-item">

                        <span>Account Status
                        </span>


                        <strong class="account-active">

                            <span></span>

                            Active

                        </strong>

                    </div>



                    <!-- USER TYPE -->

                    <div class="profile-account-item">

                        <span>User Type
                        </span>


                        <strong>Officer
                        </strong>

                    </div>



                    <!-- OFFICER ID -->

                    <div class="profile-account-item">

                        <span>Officer ID
                        </span>


                        <strong>

                            <asp:Label
                                ID="lblAccountOfficerID"
                                runat="server"
                                Text="Loading...">
                            </asp:Label>

                        </strong>

                    </div>


                </div>

            </div>



            <!-- =====================================================
                 PROFILE ACTIONS
            ====================================================== -->

            <div class="profile-actions">


                <!-- EDIT PROFILE -->

                <asp:Button
                    ID="btnEditProfile"
                    runat="server"
                    Text="Edit Profile"
                    CssClass="profile-edit-button"
                    CausesValidation="false"
                    OnClick="btnEditProfile_Click" />


                <!-- CHANGE PASSWORD -->

                <asp:Button
                    ID="btnChangePassword"
                    runat="server"
                    Text="Change Password"
                    CssClass="profile-password-button"
                    CausesValidation="false" />


            </div>

            <!-- =====================================================
                 INFORMATION FOOTER
            ====================================================== -->

            <div class="profile-information">


                <div>

                    <i class="fa-solid fa-circle-info"></i>

                    Keep your profile information accurate
                    and up to date.

                </div>


                <div>

                    <i class="fa-solid fa-shield-halved"></i>

                    JanVoice Officer Account

                </div>


            </div>


        </div>

    </section>


</asp:Content>
