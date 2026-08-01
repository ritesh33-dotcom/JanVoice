<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="ReportIssue.aspx.cs" Inherits="JanVoice.Citizen.ReportIssue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/reportissue.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="report-page">

        <!-- Page Header -->

        <div class="page-header">

            <div>

                <h1>Report a Civic Issue</h1>

                <p>
                    Help improve your city by reporting issues in your area.
           
                </p>

            </div>

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

                        <asp:ListItem>Select Category</asp:ListItem>

                    </asp:DropDownList>

                </div>

                <!-- Ward -->

                <div class="form-group">

                    <label>Ward</label>

                    <asp:DropDownList
                        ID="ddlWard"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem>Select Ward</asp:ListItem>

                    </asp:DropDownList>

                </div>

                <!-- Landmark -->

                <div class="form-group full">

                    <label>Nearest Landmark</label>

                    <asp:TextBox
                        ID="txtLandmark"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Example: Near Bus Stand">
                </asp:TextBox>

                </div>

                <!-- Description -->

                <div class="form-group full">

                    <label>Description</label>

                    <asp:TextBox
                        ID="txtDescription"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="6"
                        placeholder="Describe the issue in detail">
                </asp:TextBox>

                </div>

                <!-- Add Location -->

                <div class="form-group full">

                    <label>Complaint Location</label>

                    <button type="button"
                        id="btnLocation"
                        class="location-btn">

                        <i class="fa-solid fa-location-crosshairs"></i>

                        Use My Current Location

                    </button>

                    <small id="locationStatus"></small>

                </div>




                <!-- Image -->

                <div class="form-group full">

                    <label>Upload Image</label>

                    <asp:FileUpload
                        ID="fuComplaintImage"
                        runat="server"
                        CssClass="file-upload" />

                </div>


                <!-- Image Preview -->

                <div class="form-group full">

                    <img id="imagePreview"
                        src=""
                        style="display: none;"
                        class="preview-image" />

                </div>

                <!-- Hidden Coordinates -->

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
                    Text="Submit Complaint"
                    CssClass="btn-submit"
                    OnClientClick="return validateComplaint();" />

                <asp:Button
                    ID="btnReset"
                    runat="server"
                    Text="Reset"
                    CssClass="btn-reset"
                    OnClientClick="this.form.reset();return false;" />

            </div>

        </div>

    </div>

    <script>

        document.addEventListener("DOMContentLoaded", function () {

            //--------------------------
            // IMAGE PREVIEW
            //--------------------------

            const fileUpload =
                document.getElementById("<%= fuComplaintImage.ClientID %>");

            const preview =
                document.getElementById("imagePreview");

            fileUpload.addEventListener("change", function () {

                if (this.files.length > 0) {

                    const reader = new FileReader();

                    reader.onload = function (e) {

                        preview.src = e.target.result;

                        preview.style.display = "block";

                    };

                    reader.readAsDataURL(this.files[0]);

                }

            });

            //--------------------------
            // CURRENT LOCATION
            //--------------------------

            const btn =
                document.getElementById("btnLocation");

            const status =
                document.getElementById("locationStatus");

            btn.addEventListener("click", function () {

                if (!navigator.geolocation) {

                    status.innerHTML = "Geolocation not supported.";

                    return;

                }

                status.innerHTML = "Getting location...";

                navigator.geolocation.getCurrentPosition(

                    function (position) {

                        document.getElementById("<%= hfLatitude.ClientID %>").value =
                            position.coords.latitude;

                        document.getElementById("<%= hfLongitude.ClientID %>").value =
                            position.coords.longitude;

                        status.innerHTML =
                            "✅ Location Captured Successfully";

                    },

                    function () {

                        status.innerHTML =
                            "Unable to fetch location.";

                    }

                );

            });

        });

        function validateComplaint() {

            var title =
                document.getElementById("<%= txtTitle.ClientID %>");

            var category =
                document.getElementById("<%= ddlCategory.ClientID %>");

            var ward =
                document.getElementById("<%= ddlWard.ClientID %>");

            var description =
                document.getElementById("<%= txtDescription.ClientID %>");

            if (title.value.trim() == "") {

                alert("Enter Complaint Title");

                title.focus();

                return false;

            }

            if (category.selectedIndex == 0) {

                alert("Select Category");

                return false;

            }

            if (ward.selectedIndex == 0) {

                alert("Select Ward");

                return false;

            }

            if (description.value.trim() == "") {

                alert("Enter Description");

                description.focus();

                return false;

            }

            return true;

        }
    </script>


</asp:Content>
