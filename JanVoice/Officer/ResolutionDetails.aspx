<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="ResolutionDetails.aspx.cs" Inherits="JanVoice.Officer.ResolutionDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    
    <!-- =========================================================
         RESOLUTION DETAILS PAGE
    ========================================================== -->

    <section class="resolution-details-page">

        <div class="resolution-container">


            <!-- =================================================
                 PAGE HEADER
            ================================================== -->

            <div class="resolution-page-header">

                <div class="resolution-header-content">

                    <span class="resolution-page-badge">

                        <i class="fa-solid fa-file-circle-check"></i>

                        Complaint Resolution

                    </span>


                    <h1>
                        Resolution Details
                    </h1>


                    <p>
                        Review complaint information and manage
                        its resolution.
                    </p>

                </div>


                <div class="resolution-header-icon">

                    <i class="fa-solid fa-clipboard-check"></i>

                </div>

            </div>



            <!-- =================================================
                 COMPLAINT SUMMARY
            ================================================== -->

            <div class="resolution-card">


                <div class="resolution-card-header">

                    <div>

                        <div class="resolution-card-title">

                            <i class="fa-solid fa-circle-info"></i>

                            Complaint Information

                        </div>

                        <p>
                            Basic information about the selected complaint.
                        </p>

                    </div>


                    <div class="resolution-card-icon">

                        <i class="fa-solid fa-file-lines"></i>

                    </div>

                </div>



                <div class="resolution-info-grid">


                    <!-- COMPLAINT ID -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Complaint ID
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblComplaintID"
                                runat="server"
                                Text="-">
                            </asp:Label>
                        </strong>

                    </div>


                    <!-- TITLE -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Complaint Title
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblComplaintTitle"
                                runat="server"
                                Text="-">
                            </asp:Label>
                        </strong>

                    </div>


                    <!-- CATEGORY -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Category
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblCategory"
                                runat="server"
                                Text="-">
                            </asp:Label>
                        </strong>

                    </div>


                    <!-- WARD -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Ward
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblWard"
                                runat="server"
                                Text="-">
                            </asp:Label>
                        </strong>

                    </div>


                    <!-- PRIORITY -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Priority
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblPriority"
                                runat="server"
                                Text="-">
                            </asp:Label>
                        </strong>

                    </div>


                    <!-- STATUS -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Current Status
                        </span>

                        <span class="resolution-status-badge">

                            <asp:Label
                                ID="lblStatus"
                                runat="server"
                                Text="Pending">
                            </asp:Label>

                        </span>

                    </div>


                    <!-- CREATED DATE -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Created Date
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblCreatedDate"
                                runat="server"
                                Text="-">
                            </asp:Label>
                        </strong>

                    </div>


                    <!-- UPDATED DATE -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Last Updated
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblUpdatedDate"
                                runat="server"
                                Text="-">
                            </asp:Label>
                        </strong>

                    </div>


                </div>

            </div>



            <!-- =================================================
                 COMPLAINT DESCRIPTION
            ================================================== -->

            <div class="resolution-card">


                <div class="resolution-card-header">

                    <div>

                        <div class="resolution-card-title">

                            <i class="fa-solid fa-align-left"></i>

                            Complaint Description

                        </div>

                        <p>
                            Detailed description provided by the citizen.
                        </p>

                    </div>

                </div>


                <div class="complaint-description-box">

                    <asp:Label
                        ID="lblDescription"
                        runat="server"
                        Text="No description available.">
                    </asp:Label>

                </div>

            </div>



            <!-- =================================================
                 CITIZEN INFORMATION
            ================================================== -->

            <div class="resolution-card">


                <div class="resolution-card-header">

                    <div>

                        <div class="resolution-card-title">

                            <i class="fa-solid fa-user"></i>

                            Citizen Information

                        </div>

                        <p>
                            Information about the citizen who submitted
                            this complaint.
                        </p>

                    </div>

                </div>



                <div class="resolution-info-grid">


                    <!-- CITIZEN NAME -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Citizen Name
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblCitizenName"
                                runat="server"
                                Text="-">
                            </asp:Label>

                        </strong>

                    </div>


                    <!-- CITIZEN EMAIL -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Email
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblCitizenEmail"
                                runat="server"
                                Text="-">
                            </asp:Label>

                        </strong>

                    </div>


                    <!-- CITIZEN PHONE -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Contact Number
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblCitizenPhone"
                                runat="server"
                                Text="-">
                            </asp:Label>

                        </strong>

                    </div>


                </div>

            </div>



            <!-- =================================================
                 LOCATION INFORMATION
            ================================================== -->

            <div class="resolution-card">


                <div class="resolution-card-header">

                    <div>

                        <div class="resolution-card-title">

                            <i class="fa-solid fa-location-dot"></i>

                            Complaint Location

                        </div>

                        <p>
                            Location information provided with the complaint.
                        </p>

                    </div>

                </div>



                <div class="resolution-info-grid">


                    <!-- LANDMARK -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Landmark
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblLandmark"
                                runat="server"
                                Text="-">
                            </asp:Label>

                        </strong>

                    </div>


                    <!-- LATITUDE -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Latitude
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblLatitude"
                                runat="server"
                                Text="-">
                            </asp:Label>

                        </strong>

                    </div>


                    <!-- LONGITUDE -->

                    <div class="resolution-info-item">

                        <span class="resolution-info-label">
                            Longitude
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblLongitude"
                                runat="server"
                                Text="-">
                            </asp:Label>

                        </strong>

                    </div>


                </div>

            </div>



            <!-- =================================================
                 COMPLAINT IMAGE
            ================================================== -->

            <div class="resolution-card">


                <div class="resolution-card-header">

                    <div>

                        <div class="resolution-card-title">

                            <i class="fa-solid fa-image"></i>

                            Complaint Evidence

                        </div>

                        <p>
                            Image uploaded by the citizen.
                        </p>

                    </div>

                </div>



                <div class="complaint-image-container">

                    <asp:Image
                        ID="imgComplaint"
                        runat="server"
                        CssClass="complaint-image"
                        AlternateText="Complaint Image"
                        Visible="false" />

                    <asp:Label
                        ID="lblNoImage"
                        runat="server"
                        CssClass="no-image-message"
                        Text="No complaint image available.">
                    </asp:Label>

                </div>

            </div>



            <!-- =================================================
                 RESOLUTION SECTION
            ================================================== -->

            <div class="resolution-card resolution-action-card">


                <div class="resolution-card-header">

                    <div>

                        <div class="resolution-card-title">

                            <i class="fa-solid fa-pen-to-square"></i>

                            Resolution

                        </div>

                        <p>
                            Enter the action taken to resolve this complaint.
                        </p>

                    </div>

                </div>



                <!-- RESOLUTION REMARKS -->

                <div class="resolution-form-group">

                    <label>
                        Resolution Remarks
                    </label>

                    <asp:TextBox
                        ID="txtResolutionRemarks"
                        runat="server"
                        CssClass="resolution-textarea"
                        TextMode="MultiLine"
                        Rows="6"
                        placeholder="Describe the action taken to resolve the complaint...">
                    </asp:TextBox>

                </div>



                <!-- RESOLUTION DATE -->

                <div class="resolution-form-group">

                    <label>
                        Resolution Date
                    </label>

                    <asp:TextBox
                        ID="txtResolutionDate"
                        runat="server"
                        CssClass="resolution-input"
                        TextMode="Date">
                    </asp:TextBox>

                </div>



                <!-- ACTION BUTTONS -->

                <div class="resolution-actions">


                    <asp:Button
                        ID="btnMarkResolved"
                        runat="server"
                        Text="Mark as Resolved"
                        CssClass="btn-mark-resolved"
                        OnClick="btnMarkResolved_Click" />


                    <asp:Button
                        ID="btnCancel"
                        runat="server"
                        Text="Back to Assigned Complaints"
                        CssClass="btn-cancel"
                        CausesValidation="false"
                        OnClick="btnCancel_Click" />


                </div>

            </div>



            <!-- =================================================
                 STATUS HISTORY
            ================================================== -->

            <div class="resolution-card">


                <div class="resolution-card-header">

                    <div>

                        <div class="resolution-card-title">

                            <i class="fa-solid fa-clock-rotate-left"></i>

                            Status History

                        </div>

                        <p>
                            Track the complaint status changes.
                        </p>

                    </div>

                </div>



                <div class="status-history-wrapper">

                    <asp:GridView
                        ID="gvStatusHistory"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="status-history-table"
                        GridLines="None"
                        EmptyDataText="No status history available.">

                        <Columns>

                            <asp:BoundField
                                DataField="OldStatus"
                                HeaderText="Previous Status" />

                            <asp:BoundField
                                DataField="NewStatus"
                                HeaderText="New Status" />

                            <asp:BoundField
                                DataField="Remarks"
                                HeaderText="Remarks" />

                            <asp:BoundField
                                DataField="ChangeDate"
                                HeaderText="Date"
                                DataFormatString="{0:dd MMM yyyy hh:mm tt}" />

                        </Columns>

                    </asp:GridView>

                </div>

            </div>



            <!-- =================================================
                 PAGE INFORMATION
            ================================================== -->

            <div class="resolution-page-information">

                <div>

                    <i class="fa-solid fa-circle-info"></i>

                    Resolution details are recorded for transparency.

                </div>


                <div>

                    <i class="fa-solid fa-shield-halved"></i>

                    JanVoice Officer Panel

                </div>

            </div>


        </div>

    </section>




</asp:Content>
