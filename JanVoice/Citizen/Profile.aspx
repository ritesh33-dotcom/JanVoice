<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="JanVoice.Citizen.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="profile-page">

        <!-- ============================= -->
        <!-- PAGE HEADER -->
        <!-- ============================= -->

        <div class="page-header">

            <h1>My Profile</h1>

            <p>
                Manage your personal information and account details.
       
            </p>

        </div>

        <!-- ============================= -->
        <!-- PROFILE HEADER -->
        <!-- ============================= -->

        <div class="profile-card">

            <div class="profile-left">

                <asp:Image
                    ID="imgProfile"
                    runat="server"
                    CssClass="profile-image" />

            </div>

            <div class="profile-right">

                <h2>

                    <asp:Label
                        ID="lblFullName"
                        runat="server" />

                </h2>

                <span class="role-badge">

                    <asp:Label
                        ID="lblRole"
                        runat="server" />

                </span>

                <p class="joined-date">
                    Member Since :

               

                    <asp:Label
                        ID="lblCreatedDate"
                        runat="server" />

                </p>

            </div>

        </div>

        <!-- ============================= -->
        <!-- PERSONAL INFORMATION -->
        <!-- ============================= -->

        <div class="info-card">

            <h3>Personal Information</h3>

            <div class="info-grid">

                <div>

                    <strong>Full Name</strong>

                    <asp:Label
                        ID="lblName"
                        runat="server" />

                </div>

                <div>

                    <strong>Email</strong>

                    <asp:Label
                        ID="lblEmail"
                        runat="server" />

                </div>

                <div>

                    <strong>Mobile</strong>

                    <asp:Label
                        ID="lblMobile"
                        runat="server" />

                </div>

                <div>

                    <strong>Ward</strong>

                    <asp:Label
                        ID="lblWard"
                        runat="server" />

                </div>

                <div class="full-width">

                    <strong>Address</strong>

                    <asp:Label
                        ID="lblAddress"
                        runat="server" />

                </div>

            </div>

        </div>

        <!-- ============================= -->
        <!-- ACCOUNT DETAILS -->
        <!-- ============================= -->

        <div class="account-card">

            <h3>Account Details</h3>

            <div class="account-grid">

                <div class="account-box">

                    <h4>Account Status</h4>

                    <asp:Label
                        ID="lblStatus"
                        runat="server"
                        CssClass="active-status" />

                </div>

                <div class="account-box">

                    <h4>Role</h4>

                    <asp:Label
                        ID="lblRole2"
                        runat="server" />

                </div>

                <div class="account-box">

                    <h4>Registered On</h4>

                    <asp:Label
                        ID="lblRegistered"
                        runat="server" />

                </div>

            </div>

        </div>

        <!-- ============================= -->
        <!-- STATISTICS -->
        <!-- ============================= -->

        <div class="stats-section">

            <div class="stat-card">

                <h2>

                    <asp:Label
                        ID="lblTotal"
                        runat="server"
                        Text="0" />

                </h2>

                <p>Total Complaints</p>

            </div>

            <div class="stat-card">

                <h2>

                    <asp:Label
                        ID="lblPending"
                        runat="server"
                        Text="0" />

                </h2>

                <p>Pending</p>

            </div>

            <div class="stat-card">

                <h2>

                    <asp:Label
                        ID="lblProgress"
                        runat="server"
                        Text="0" />

                </h2>

                <p>In Progress</p>

            </div>

            <div class="stat-card">

                <h2>

                    <asp:Label
                        ID="lblResolved"
                        runat="server"
                        Text="0" />

                </h2>

                <p>Resolved</p>

            </div>

        </div>

        <!-- ============================= -->
        <!-- ACTION BUTTONS -->
        <!-- ============================= -->

        <div class="action-buttons">

            <asp:Button
                ID="btnEditProfile"
                runat="server"
                Text="Edit Profile"
                CssClass="primary-btn" />

            <asp:Button
                ID="btnChangePassword"
                runat="server"
                Text="Change Password"
                CssClass="secondary-btn" />

        </div>

    </div>


</asp:Content>
