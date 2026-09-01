<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="ResolutionDetails.aspx.cs" Inherits="JanVoice.Officer.ResolutionDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../CSS/ResolutionDetails.css" rel="stylesheet" />

    <style>
        /* =========================================================
   RESOLUTION DETAILS
   JanVoice - Officer Panel
   LIGHT THEME
   ========================================================= */


/* =========================================================
   PAGE
========================================================= */

.resolution-details-page {
    min-height: 100vh;
    padding: 35px 25px 60px;
    background: #f5f7fb;
    color: #35425b;
}


/* =========================================================
   CONTAINER
========================================================= */

.resolution-container {
    width: 100%;
    max-width: 1400px;
    margin: 0 auto;
}


/* =========================================================
   PAGE HEADER
========================================================= */

.resolution-page-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 25px;
    margin-bottom: 30px;
    padding: 30px;
    border: 1px solid #e3e8f2;
    border-radius: 20px;
    background: #ffffff;
    box-shadow: 0 12px 32px rgba(21, 38, 74, 0.06);
}


.resolution-header-content {
    min-width: 0;
}


.resolution-page-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 7px 14px;
    border: 1px solid #dbe7ff;
    border-radius: 30px;
    background: #edf4ff;
    color: #3478ef;
    font-size: 12px;
    font-weight: 600;
}


.resolution-page-header h1 {
    margin: 15px 0 8px;
    color: #17233d;
    font-size: 34px;
    font-weight: 700;
    line-height: 1.2;
}


.resolution-page-header p {
    margin: 0;
    color: #7d899e;
    font-size: 14px;
    line-height: 1.6;
}


.resolution-header-icon {
    width: 70px;
    height: 70px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #dbe7ff;
    border-radius: 18px;
    background: #edf4ff;
    color: #3478ef;
    font-size: 28px;
}


/* =========================================================
   COMMON CARD
========================================================= */

.resolution-card {
    margin-top: 25px;
    overflow: hidden;
    border: 1px solid #e3e8f2;
    border-radius: 18px;
    background: #ffffff;
    box-shadow: 0 12px 32px rgba(21, 38, 74, 0.06);
}


/* =========================================================
   CARD HEADER
========================================================= */

.resolution-card-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
    padding: 23px 25px;
    border-bottom: 1px solid #edf0f5;
}


.resolution-card-title {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #17233d;
    font-size: 18px;
    font-weight: 650;
}


    .resolution-card-title i {
        color: #3478ef;
    }


.resolution-card-header p {
    margin: 7px 0 0;
    color: #7d899e;
    font-size: 13px;
    line-height: 1.5;
}


.resolution-card-icon {
    width: 42px;
    height: 42px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    background: #edf4ff;
    color: #3478ef;
    font-size: 17px;
}


/* =========================================================
   INFORMATION GRID
========================================================= */

.resolution-info-grid {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 1px;
    background: #edf0f5;
}


.resolution-info-item {
    min-width: 0;
    padding: 20px;
    background: #ffffff;
}


.resolution-info-label {
    display: block;
    margin-bottom: 8px;
    color: #929caf;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.6px;
}


.resolution-info-item strong {
    display: block;
    overflow: hidden;
    color: #26334c;
    font-size: 14px;
    font-weight: 600;
    line-height: 1.5;
    text-overflow: ellipsis;
}


/* =========================================================
   STATUS BADGE
========================================================= */

.resolution-status-badge {
    display: inline-flex;
    align-items: center;
    min-height: 27px;
    padding: 5px 10px;
    border: 1px solid #f7dca8;
    border-radius: 20px;
    background: #fff6e8;
    color: #ed9000;
    font-size: 11px;
    font-weight: 600;
}


/* =========================================================
   DESCRIPTION
========================================================= */

.complaint-description-box {
    min-height: 120px;
    padding: 25px;
    color: #536078;
    font-size: 14px;
    line-height: 1.8;
    white-space: pre-line;
}


/* =========================================================
   IMAGE
========================================================= */

.complaint-image-container {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 250px;
    padding: 25px;
    background: #f6f8fc;
}


.complaint-image {
    display: block;
    max-width: 100%;
    max-height: 500px;
    border: 1px solid #e3e8f2;
    border-radius: 14px;
    object-fit: contain;
    box-shadow: 0 12px 30px rgba(21, 38, 74, 0.10);
}


.no-image-message {
    color: #929caf;
    font-size: 13px;
}


/* =========================================================
   RESOLUTION ACTION CARD
========================================================= */

.resolution-action-card {
    border-color: #dcefe5;
}


    .resolution-action-card .resolution-card-title i {
        color: #0ba56c;
    }


/* =========================================================
   FORM
========================================================= */

.resolution-form-group {
    padding: 20px 25px 0;
}


    .resolution-form-group label {
        display: block;
        margin-bottom: 8px;
        color: #536078;
        font-size: 13px;
        font-weight: 600;
    }


.resolution-input,
.resolution-textarea {
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #dfe5ef;
    border-radius: 10px;
    outline: none;
    background: #ffffff;
    color: #35425b;
    font-family: inherit;
    font-size: 13px;
    transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
}


.resolution-input {
    min-height: 45px;
    padding: 10px 13px;
}


.resolution-textarea {
    min-height: 140px;
    padding: 13px;
    resize: vertical;
    line-height: 1.6;
}


    .resolution-input::placeholder,
    .resolution-textarea::placeholder {
        color: #929caf;
    }


    .resolution-input:focus,
    .resolution-textarea:focus {
        border-color: #3478ef;
        background: #ffffff;
        color: #26334c;
        box-shadow: 0 0 0 3px rgba(52, 120, 239, 0.10);
    }


/* =========================================================
   ACTION BUTTONS
========================================================= */

.resolution-actions {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 12px;
    padding: 25px;
}


.btn-mark-resolved,
.btn-cancel {
    min-height: 44px;
    padding: 10px 18px;
    border-radius: 10px;
    font-family: inherit;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease, border-color 0.2s ease;
}


/* =========================================================
   RESOLVE BUTTON
========================================================= */

.btn-mark-resolved {
    border: 1px solid #0ba56c;
    background: linear-gradient(135deg, #0ba56c, #16b978);
    color: #ffffff;
}


    .btn-mark-resolved:hover {
        transform: translateY(-1px);
        box-shadow: 0 8px 22px rgba(11, 165, 108, 0.20);
    }


/* =========================================================
   CANCEL BUTTON
========================================================= */

.btn-cancel {
    border: 1px solid #d5dce8;
    background: #ffffff;
    color: #536078;
}


    .btn-cancel:hover {
        transform: translateY(-1px);
        border-color: #c4cedd;
        background: #f6f8fc;
        color: #26334c;
    }


/* =========================================================
   STATUS HISTORY
========================================================= */

.status-history-wrapper {
    width: 100%;
    overflow-x: auto;
}


.status-history-table {
    width: 100%;
    min-width: 700px;
    border-collapse: separate;
    border-spacing: 0;
    background: transparent;
    color: #536078;
}


    .status-history-table th {
        padding: 15px;
        border-bottom: 1px solid #e5e9f1;
        background: #f6f8fc;
        color: #66738a;
        font-size: 11px;
        font-weight: 650;
        text-align: left;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }


    .status-history-table td {
        padding: 15px;
        border-bottom: 1px solid #edf0f5;
        background: #ffffff;
        color: #536078;
        font-size: 13px;
        vertical-align: middle;
    }


    .status-history-table tr {
        transition: background 0.2s ease;
    }


    .status-history-table tbody tr:hover td {
        background: #f8faff;
    }


/* =========================================================
   PAGE INFORMATION
========================================================= */

.resolution-page-information {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    margin-top: 20px;
    padding: 14px 18px;
    border: 1px solid #e3e8f2;
    border-radius: 12px;
    background: #ffffff;
    color: #7d899e;
    font-size: 12px;
    box-shadow: 0 8px 20px rgba(21, 38, 74, 0.04);
}


    .resolution-page-information div {
        display: flex;
        align-items: center;
        gap: 7px;
    }


    .resolution-page-information i {
        color: #3478ef;
    }


/* =========================================================
   SCROLLBAR
========================================================= */

.resolution-details-page ::-webkit-scrollbar {
    width: 7px;
    height: 7px;
}


.resolution-details-page ::-webkit-scrollbar-track {
    background: #f5f7fb;
}


.resolution-details-page ::-webkit-scrollbar-thumb {
    border-radius: 10px;
    background: #c9d9f5;
}


    .resolution-details-page ::-webkit-scrollbar-thumb:hover {
        background: #a9c2ed;
    }


/* =========================================================
   RESOLUTION DETAILS - RESPONSIVE DESIGN
========================================================= */


/* =========================================================
   TABLET
========================================================= */

@media (max-width: 1100px) {

    .resolution-container {
        padding: 25px 20px;
    }

    .resolution-header {
        padding: 28px;
    }

        .resolution-header h1 {
            font-size: 34px;
        }

    .complaint-summary {
        grid-template-columns: repeat(2, 1fr);
    }

    .resolution-grid {
        grid-template-columns: 1fr;
    }

    .location-grid {
        grid-template-columns: 1fr 1fr;
    }
}


/* =========================================================
   TABLET / SMALL LAPTOP
========================================================= */

@media (max-width: 900px) {

    .resolution-container {
        padding: 20px 15px;
    }

    .resolution-header {
        padding: 24px;
    }

        .resolution-header h1 {
            font-size: 30px;
        }

        .resolution-header p {
            font-size: 14px;
        }

    .complaint-summary {
        grid-template-columns: 1fr 1fr;
        gap: 15px;
    }

    .summary-card {
        padding: 18px;
    }

    .resolution-card {
        padding: 22px;
    }

    .location-grid {
        grid-template-columns: 1fr;
    }
}


/* =========================================================
   MOBILE
========================================================= */

@media (max-width: 600px) {

    .resolution-container {
        padding: 15px 10px;
    }


    /* -------------------------
       HEADER
    ------------------------- */

    .resolution-header {
        padding: 20px;
        border-radius: 15px;
    }

        .resolution-header h1 {
            font-size: 26px;
            line-height: 1.2;
        }

        .resolution-header p {
            font-size: 13px;
            line-height: 1.6;
        }


    /* -------------------------
       SUMMARY CARDS
    ------------------------- */

    .complaint-summary {
        grid-template-columns: 1fr;
        gap: 12px;
    }

    .summary-card {
        padding: 17px;
        border-radius: 14px;
    }

        .summary-card h3 {
            font-size: 13px;
        }

        .summary-card p {
            font-size: 15px;
        }


    /* -------------------------
       MAIN CARDS
    ------------------------- */

    .resolution-card {
        padding: 18px;
        border-radius: 15px;
    }

        .resolution-card h2 {
            font-size: 21px;
        }


    /* -------------------------
       FORM
    ------------------------- */

    .form-group {
        margin-bottom: 16px;
    }

        .form-group label {
            font-size: 13px;
        }

    .form-control {
        width: 100%;
        box-sizing: border-box;
        font-size: 14px;
        padding: 12px;
    }

    textarea.form-control {
        min-height: 120px;
    }


    /* -------------------------
       LOCATION
    ------------------------- */

    .location-grid {
        grid-template-columns: 1fr;
        gap: 12px;
    }


    /* -------------------------
       IMAGE / EVIDENCE
    ------------------------- */

    .evidence-image {
        width: 100%;
        height: auto;
        max-height: 350px;
        object-fit: cover;
    }


    /* -------------------------
       BUTTONS
    ------------------------- */

    .resolution-actions {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

        .resolution-actions .btn {
            width: 100%;
            box-sizing: border-box;
            text-align: center;
        }


    /* -------------------------
       STATUS HISTORY
    ------------------------- */

    .status-history {
        overflow-x: auto;
        width: 100%;
    }

        .status-history table {
            min-width: 650px;
        }


    /* -------------------------
       GRIDVIEW
    ------------------------- */

    .table-responsive {
        overflow-x: auto;
        width: 100%;
    }

        .table-responsive table {
            min-width: 700px;
        }
}


/* =========================================================
   VERY SMALL MOBILE
========================================================= */

@media (max-width: 400px) {

    .resolution-container {
        padding: 10px 7px;
    }

    .resolution-header {
        padding: 17px;
    }

        .resolution-header h1 {
            font-size: 23px;
        }

        .resolution-header p {
            font-size: 12px;
        }

    .resolution-card {
        padding: 15px;
    }

        .resolution-card h2 {
            font-size: 19px;
        }

    .summary-card {
        padding: 14px;
    }

    .form-control {
        font-size: 13px;
        padding: 10px;
    }
}


/* =========================================================
   END OF RESOLUTION DETAILS CSS
========================================================= */
    </style>
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


                    <h1>Resolution Details
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

                        <span class="resolution-info-label">Complaint ID
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

                        <span class="resolution-info-label">Complaint Title
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

                        <span class="resolution-info-label">Category
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

                        <span class="resolution-info-label">Ward
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

                        <span class="resolution-info-label">Priority
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

                        <span class="resolution-info-label">Current Status
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

                        <span class="resolution-info-label">Created Date
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

                        <span class="resolution-info-label">Last Updated
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

                        <span class="resolution-info-label">Citizen Name
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

                        <span class="resolution-info-label">Email
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

                        <span class="resolution-info-label">Contact Number
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

                        <span class="resolution-info-label">Landmark
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

                        <span class="resolution-info-label">Latitude
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

                        <span class="resolution-info-label">Longitude
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
                                HeaderText="Old Status" />

                            <asp:BoundField
                                DataField="NewStatus"
                                HeaderText="New Status" />

                            <asp:BoundField
                                DataField="ChangedByName"
                                HeaderText="Changed By" />

                            <asp:BoundField
                                DataField="Remarks"
                                HeaderText="Remarks" />

                            <asp:BoundField
                                DataField="ChangeDate"
                                HeaderText="Date"
                                DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />

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
