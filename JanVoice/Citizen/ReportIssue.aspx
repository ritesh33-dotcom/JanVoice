<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="ReportIssue.aspx.cs" Inherits="JanVoice.Citizen.ReportIssue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../CSS/reportissue.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="report-page">

        <!-- Page Header -->

        <div class="page-header">

            <h1>Report a Civic Issue</h1>

            <p>
                Help improve your city by reporting civic issues in your locality.
       
            </p>

        </div>

        <!-- Report Card -->

        <div class="report-card">

            <h2>Complaint Details</h2>

            <div class="form-grid">

                <!-- Complaint Title -->

                <div class="form-group full">

                    <label>Complaint Title</label>

                    <asp:TextBox
                        ID="txtTitle"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="150"
                        placeholder="Enter complaint title">
                </asp:TextBox>

                </div>

                <!-- Category -->

                <div class="form-group">

                    <label>Category</label>

                    <asp:DropDownList
                        ID="ddlCategory"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem Value="">-- Select Category --</asp:ListItem>

                    </asp:DropDownList>

                </div>

                <!-- Ward -->

                <div class="form-group">

                    <label>Ward</label>

                    <asp:DropDownList
                        ID="ddlWard"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem Value="">-- Select Ward --</asp:ListItem>

                    </asp:DropDownList>

                </div>

                <!-- Landmark -->

                <div class="form-group full">

                    <label>Nearest Landmark</label>

                    <asp:TextBox
                        ID="txtLandmark"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="150"
                        placeholder="Example : Near Bus Stand">
                </asp:TextBox>

                </div>

                <!-- Description -->

                <div class="form-group full">

                    <div class="label-row">

                        <label>Description</label>

                        <span id="charCount">0 / 500 Characters

                    </span>

                    </div>

                    <asp:TextBox
                        ID="txtDescription"
                        runat="server"
                        CssClass="form-control textarea"
                        TextMode="MultiLine"
                        Rows="6"
                        MaxLength="500"
                        placeholder="Describe the issue in detail">
                </asp:TextBox>

                </div>

                <!-- Location -->

                <div class="form-group full">

                    <label>Complaint Location</label>

                    <button
                        type="button"
                        id="btnLocation"
                        class="location-btn">

                        <i class="fa-solid fa-location-crosshairs"></i>

                        Use My Current Location

               
                    </button>

                    <small id="locationStatus"></small>

                </div>

                <!-- Upload Section -->

                <div class="form-group full">

                    <label>Upload Complaint Images</label>

                    <div
                        class="upload-box"
                        id="uploadBox">

                        <i class="fa-solid fa-cloud-arrow-up upload-icon"></i>

                        <h3>Drag & Drop Images

                    </h3>

                        <p>
                            JPG, PNG, JPEG (Maximum 2 MB)

                   
                        </p>

                        <button
                            type="button"
                            id="browseBtn"
                            class="browse-btn">
                            Browse Files

                   
                        </button>

                        <asp:FileUpload
                            ID="fuComplaintImage"
                            runat="server"
                            CssClass="hidden-upload" />

                    </div>

                </div>

                <!-- Image Preview -->

                <div class="form-group full">

                    <label>Preview</label>

                    <div
                        id="imagePreview"
                        class="preview-container">
                    </div>

                </div>

                <!-- Hidden Fields -->

                <asp:HiddenField
                    ID="hfLatitude"
                    runat="server" />

                <asp:HiddenField
                    ID="hfLongitude"
                    runat="server" />

            </div>

            <!-- Buttons -->

            <div class="button-area">

                <asp:Button
                    ID="btnSubmit"
                    runat="server"
                    CssClass="btn-submit"
                    Text="Submit Complaint"
                    OnClientClick="return validateComplaint();" />

                <asp:Button
                    ID="btnReset"
                    runat="server"
                    CssClass="btn-reset"
                    Text="Reset"
                    CausesValidation="false"
                    OnClientClick="this.form.reset();return false;" />

            </div>

        </div>

    </div>

   <script>

       window.reportIssueIds = {

           title: "<%= txtTitle.ClientID %>",

    category: "<%= ddlCategory.ClientID %>",

    ward: "<%= ddlWard.ClientID %>",

    description: "<%= txtDescription.ClientID %>",

    fileUpload: "<%= fuComplaintImage.ClientID %>",

    latitude: "<%= hfLatitude.ClientID %>",

    longitude: "<%= hfLongitude.ClientID %>"

       };

       function validateComplaint() {

           const title = document.getElementById(window.reportIssueIds.title);

           const category = document.getElementById(window.reportIssueIds.category);

           const ward = document.getElementById(window.reportIssueIds.ward);

           const description = document.getElementById(window.reportIssueIds.description);

           if (title.value.trim() === "") {
               alert("Please enter Complaint Title.");
               title.focus();
               return false;
           }

           if (category.selectedIndex === 0) {
               alert("Please select Category.");
               category.focus();
               return false;
           }

           if (ward.selectedIndex === 0) {
               alert("Please select Ward.");
               ward.focus();
               return false;
           }

           if (description.value.trim() === "") {
               alert("Please enter Description.");
               description.focus();
               return false;
           }

           return true;
       }

   </script>
    <script src="../JS/reportissue.js"></script>




</asp:Content>
