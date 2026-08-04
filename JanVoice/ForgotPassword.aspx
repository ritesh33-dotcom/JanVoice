<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="JanVoice.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="CSS/forgotpassword.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="forgot-page">

    <div class="forgot-card">

        <h2>Forgot Password</h2>

        <p>
            Enter your registered email and create a new password.
        </p>

        <div class="form-group">

            <label>Email</label>

            <asp:TextBox
                ID="txtEmail"
                runat="server"
                CssClass="form-control"
                TextMode="Email" />

        </div>

        <div class="form-group">

            <label>New Password</label>

            <asp:TextBox
                ID="txtNewPassword"
                runat="server"
                CssClass="form-control"
                TextMode="Password" />

        </div>

        <div class="form-group">

            <label>Confirm Password</label>

            <asp:TextBox
                ID="txtConfirmPassword"
                runat="server"
                CssClass="form-control"
                TextMode="Password" />

        </div>

        <asp:Button
            ID="btnResetPassword"
            runat="server"
            Text="Reset Password"
            CssClass="reset-btn"
            OnClick="btnResetPassword_Click" />

    </div>

</div>

</asp:Content>
