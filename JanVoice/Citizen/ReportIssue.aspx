<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="ReportIssue.aspx.cs" Inherits="JanVoice.Citizen.ReportIssue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="report-container">

    <!-- Page Header -->

    <div class="page-header">

        <h2>

            <i class="fa-solid fa-triangle-exclamation"></i>

            Report Civic Issue

        </h2>

        <p>

            Help improve your community by reporting civic issues.

        </p>

    </div>

    <!-- Form Card -->

    <div class="report-card">

        <div class="row">

            <!-- Category -->

            <div class="col-md-6 mb-4">

                <label>

                    Category

                </label>

                <asp:DropDownList
                    ID="ddlCategory"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem>Select Category</asp:ListItem>

                </asp:DropDownList>

            </div>

            <!-- Ward -->

            <div class="col-md-6 mb-4">

                <label>

                    Ward

                </label>

                <asp:DropDownList
                    ID="ddlWard"
                    runat="server"
                    CssClass="form-control">

                    <asp:ListItem>Select Ward</asp:ListItem>

                </asp:DropDownList>

            </div>

            <!-- Complaint Title -->

            <div class="col-md-12 mb-4">

                <label>

                    Complaint Title

                </label>

                <asp:TextBox
                    ID="txtTitle"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Enter complaint title">
                </asp:TextBox>

            </div>

            <!-- Description -->

<div class="col-md-12 mb-4">

    <label>Description</label>

    <asp:TextBox
        ID="txtDescription"
        runat="server"
        CssClass="form-control"
        TextMode="MultiLine"
        Rows="6"
        MaxLength="500"
        placeholder="Describe the issue in detail...">
    </asp:TextBox>

    <small id="charCount">

        0 / 500 Characters

    </small>

</div>

            <!-- Location -->

            <div class="col-md-12 mb-4">

                <label>

                    Location

                </label>

                <asp:TextBox
                    ID="txtLocation"
                    runat="server"
                    CssClass="form-control"
                    placeholder="Enter issue location">
                </asp:TextBox>

            </div>

          <!-- Upload Images -->

<div class="col-md-12 mb-4">

    <label>Complaint Images</label>

    <div class="upload-box" id="uploadBox">

        <i class="fa-solid fa-cloud-arrow-up upload-icon"></i>

        <h5>Drag & Drop Images Here</h5>

        <p>or click to browse</p>

        <asp:FileUpload
            ID="fuComplaintImage"
            runat="server"
            CssClass="d-none"
            AllowMultiple="true" />

        <button
            type="button"
            class="browse-btn"
            id="browseBtn">

            Browse Images

        </button>

    </div>

</div>

<!-- Preview -->

<div class="col-md-12">

    <div id="imagePreview" class="preview-area">

    </div>

</div>

            <!-- Preview Area -->

            <div class="col-md-12">

                <div id="imagePreview">

                </div>

            </div>

            <!-- Submit Button -->

            <div class="col-md-12 text-center mt-4">

                <asp:Button
                    ID="btnSubmitComplaint"
                    runat="server"
                    CssClass="btn-submit"
                    Text="Submit Complaint"
                    OnClick="btnSubmitComplaint_Click" />

            </div>

        </div>

    </div>

</div>
<script>
    window.reportIssueIds = {
        fileUpload: "<%= fuComplaintImage.ClientID %>",
        description: "<%= txtDescription.ClientID %>"
    };
</script>

<script src="../JS/reportissue.js"></script>


</asp:Content>
