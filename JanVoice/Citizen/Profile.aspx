<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="JanVoice.Citizen.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/CitizenProfile.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- =========================================================
         CITIZEN PROFILE PAGE
    ========================================================== -->

    <section class="profile-page">

        <div class="profile-container">


            <!-- =====================================================
                 PROFILE HERO
            ====================================================== -->

            <div class="profile-hero">

                <div class="profile-hero-content">

                    <span class="profile-badge">

                        <i class="fa-solid fa-user"></i>

                        CITIZEN ACCOUNT

                    </span>


                    <h1>
                        Citizen Profile
                    </h1>


                    <p>
                        View your personal information, account details
                        and manage your JanVoice citizen profile.
                    </p>

                </div>


                <div class="profile-hero-icon">

                    <i class="fa-solid fa-user"></i>

                </div>

            </div>



            <!-- =====================================================
                 MAIN PROFILE GRID
            ====================================================== -->

            <div class="profile-main-grid">


                <!-- =================================================
                     PROFILE SUMMARY
                ================================================== -->

                <div class="profile-summary-card">


                    <!-- =================================================
                         PROFILE PHOTO
                    ================================================== -->

                    <div class="profile-avatar">

                        <asp:Image
                            ID="imgCitizenProfile"
                            runat="server"
                            CssClass="citizen-profile-image"
                            ImageUrl="../Images/default-user.png"
                            AlternateText="Citizen Profile Photo" />

                    </div>


                    <h2>

                        <asp:Label
                            ID="lblSummaryName"
                            runat="server"
                            Text="Loading...">
                        </asp:Label>

                    </h2>


                    <p>
                        JanVoice Citizen
                    </p>


                    <!-- STATUS -->

                    <span class="profile-status">

                        <span class="profile-status-dot"></span>

                        Active Account

                    </span>


                    <div class="profile-summary-divider"></div>


                    <!-- CITIZEN ID -->

                    <div class="profile-summary-item">

                        <i class="fa-solid fa-id-card"></i>

                        <div>

                            <span>
                                Citizen ID
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblCitizenID"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>

                    </div>


                    <!-- USERNAME -->

                    <div class="profile-summary-item">

                        <i class="fa-solid fa-at"></i>

                        <div>

                            <span>
                                Username
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblSummaryUsername"
                                    runat="server"
                                    Text="Loading...">
                                </asp:Label>

                            </strong>

                        </div>

                    </div>


                </div>



                <!-- =================================================
                     PERSONAL INFORMATION
                ================================================== -->

                <div class="profile-information-card">


                    <!-- HEADER -->

                    <div class="profile-card-header">

                        <div>

                            <span class="profile-section-badge">

                                <i class="fa-solid fa-user"></i>

                                PERSONAL INFORMATION

                            </span>


                            <h2>
                                Personal Details
                            </h2>


                            <p>
                                View your registered citizen information.
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
                         EDIT PROFILE
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
                                placeholder="Enter mobile number">
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
                                placeholder="Enter your complete address">
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


                        <asp:Label
                            ID="lblPersonalMessage"
                            runat="server"
                            CssClass="profile-message">
                        </asp:Label>


                    </asp:Panel>

                </div>

            </div>



            <!-- =====================================================
                 PROFILE PHOTO MANAGEMENT
            ====================================================== -->

            <asp:Panel
                ID="pnlPhotoManagement"
                runat="server"
                CssClass="profile-account-card">


                <div class="profile-card-header">

                    <div>

                        <span class="profile-section-badge">

                            <i class="fa-solid fa-camera"></i>

                            PROFILE PHOTO

                        </span>


                        <h2>
                            Manage Profile Photo
                        </h2>


                        <p>
                            Upload or change your citizen profile photo.
                        </p>

                    </div>


                    <div class="profile-card-header-icon">

                        <i class="fa-solid fa-image"></i>

                    </div>

                </div>


                <div class="profile-edit-form">


                    <div class="profile-edit-group">

                        <label>
                            Select Photo
                        </label>


                        <asp:FileUpload
                            ID="fuProfilePhoto"
                            runat="server"
                            CssClass="profile-edit-input" />

                    </div>


                    <div class="profile-edit-actions">

                        <asp:Button
                            ID="btnUploadPhoto"
                            runat="server"
                            Text="Update Photo"
                            CssClass="profile-save-button"
                            OnClick="btnUploadPhoto_Click" />

                    </div>


                    <asp:Label
                        ID="lblPhotoMessage"
                        runat="server"
                        CssClass="profile-message">
                    </asp:Label>

                </div>

            </asp:Panel>



            <!-- =====================================================
                 ACCOUNT INFORMATION
            ====================================================== -->

            <div class="profile-account-card">


                <div class="profile-card-header">

                    <div>

                        <span class="profile-section-badge">

                            <i class="fa-solid fa-shield-halved"></i>

                            ACCOUNT INFORMATION

                        </span>


                        <h2>
                            Account Details
                        </h2>


                        <p>
                            Information about your JanVoice citizen account.
                        </p>

                    </div>


                    <div class="profile-card-header-icon">

                        <i class="fa-solid fa-lock"></i>

                    </div>

                </div>


                <div class="profile-account-grid">

<!-- ACCOUNT STATUS -->

<div class="profile-account-item">

    <span>
        Account Status
    </span>

    <strong class="account-active">
        <span class="account-status-dot"></span>

        <asp:Label
            ID="lblAccountStatus"
            runat="server"
            Text="Active"
            CssClass="account-status-text">
        </asp:Label>

    </strong>

</div>


                    <!-- USER TYPE -->

                    <div class="profile-account-item">

                        <span>
                            User Type
                        </span>


                        <strong>
                            Citizen
                        </strong>

                    </div>


                    <!-- CITIZEN ID -->

                    <div class="profile-account-item">

                        <span>
                            Citizen ID
                        </span>


                        <strong>

                            <asp:Label
                                ID="lblAccountCitizenID"
                                runat="server"
                                Text="Loading...">
                            </asp:Label>

                        </strong>

                    </div>


                    <!-- JOINED DATE -->

                    <div class="profile-account-item">

                        <span>
                            Joined Date
                        </span>


                        <strong>

                            <asp:Label
                                ID="lblJoinedDate"
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


                <asp:Button
                    ID="btnEditProfile"
                    runat="server"
                    Text="Edit Profile"
                    CssClass="profile-edit-button"
                    CausesValidation="false"
                    OnClick="btnEditProfile_Click" />


                <asp:Button
                    ID="btnChangePassword"
                    runat="server"
                    Text="Change Password"
                    CssClass="profile-password-button"
                    CausesValidation="false"
                    OnClick="btnChangePassword_Click" />

            </div>



            <!-- =====================================================
                 CHANGE PASSWORD
            ====================================================== -->

            <asp:Panel
                ID="pnlChangePassword"
                runat="server"
                CssClass="profile-password-card"
                Visible="false">


                <div class="profile-card-header">

                    <div>

                        <span class="profile-section-badge">

                            <i class="fa-solid fa-key"></i>

                            SECURITY

                        </span>


                        <h2>
                            Change Password
                        </h2>


                        <p>
                            Update your JanVoice citizen account password securely.
                        </p>

                    </div>


                    <div class="profile-card-header-icon">

                        <i class="fa-solid fa-lock"></i>

                    </div>

                </div>


                <div class="profile-password-form">


                    <!-- CURRENT PASSWORD -->

                    <div class="profile-edit-group">

                        <label>
                            Current Password
                        </label>

                        <asp:TextBox
                            ID="txtCurrentPassword"
                            runat="server"
                            CssClass="profile-edit-input"
                            TextMode="Password"
                            placeholder="Enter current password">
                        </asp:TextBox>

                    </div>


                    <!-- NEW PASSWORD -->

                    <div class="profile-edit-group">

                        <label>
                            New Password
                        </label>

                        <asp:TextBox
                            ID="txtNewPassword"
                            runat="server"
                            CssClass="profile-edit-input"
                            TextMode="Password"
                            placeholder="Enter new password">
                        </asp:TextBox>

                    </div>


                    <!-- CONFIRM PASSWORD -->

                    <div class="profile-edit-group">

                        <label>
                            Confirm New Password
                        </label>

                        <asp:TextBox
                            ID="txtConfirmPassword"
                            runat="server"
                            CssClass="profile-edit-input"
                            TextMode="Password"
                            placeholder="Confirm new password">
                        </asp:TextBox>

                    </div>


                    <!-- BUTTONS -->

                    <div class="profile-edit-actions">

                        <asp:Button
                            ID="btnCancelPassword"
                            runat="server"
                            Text="Cancel"
                            CssClass="profile-cancel-button"
                            CausesValidation="false"
                            OnClick="btnCancelPassword_Click" />


                        <asp:Button
                            ID="btnSavePassword"
                            runat="server"
                            Text="Update Password"
                            CssClass="profile-save-button"
                            CausesValidation="false"
                            OnClick="btnSavePassword_Click" />

                    </div>


                    <asp:Label
                        ID="lblPasswordMessage"
                        runat="server"
                        CssClass="profile-message">
                    </asp:Label>


                </div>

            </asp:Panel>



            <!-- =====================================================
                 FOOTER
            ====================================================== -->

            <div class="profile-information">


                <div>

                    <i class="fa-solid fa-circle-info"></i>

                    Keep your profile information accurate
                    and up to date.

                </div>


                <div>

                    <i class="fa-solid fa-shield-halved"></i>

                    JanVoice Citizen Account

                </div>


            </div>


        </div>

    </section>
</asp:Content>
