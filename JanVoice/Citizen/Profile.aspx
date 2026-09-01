<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="JanVoice.Citizen.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/CitizenProfile.css" rel="stylesheet" />
    <style>
        /* =========================================================
   JANVOICE - CITIZEN PROFILE
   COMPLETE DARK THEME CSS
   Matches Citizen Dashboard Global Theme
========================================================= */


/* =========================================================
   PAGE
========================================================= */

.profile-page {
    width: 100%;
    min-height: 100vh;
    padding: 35px 25px 50px;
    box-sizing: border-box;
    background: #0B1120;
    color: #E5E7EB;
    font-family: Arial, Helvetica, sans-serif;
}

.profile-container {
    width: 100%;
    max-width: 1250px;
    margin: 0 auto;
}


/* =========================================================
   PROFILE HERO
========================================================= */

.profile-hero {
    width: 100%;
    min-height: 190px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 30px;
    padding: 40px 45px;
    margin-bottom: 25px;
    box-sizing: border-box;
    border-radius: 20px;

    background: linear-gradient(
        135deg,
        #172554,
        #1E40AF
    );

    color: #FFFFFF;

    border: 1px solid rgba(255, 255, 255, 0.08);

    box-shadow:
        0 15px 40px rgba(0, 0, 0, 0.25);
}

.profile-hero-content {
    flex: 1;
    min-width: 0;
}

.profile-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;

    padding: 8px 14px;
    margin-bottom: 15px;

    border-radius: 30px;

    background: rgba(56, 189, 248, 0.10);
    border: 1px solid rgba(56, 189, 248, 0.20);

    color: #7DD3FC;

    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.8px;
}

.profile-hero h1 {
    margin: 0 0 12px;

    color: #F8FAFC;

    font-size: 36px;
    font-weight: 800;
    line-height: 1.2;
}

.profile-hero p {
    max-width: 700px;

    margin: 0;

    color: #CBD5E1;

    font-size: 15px;
    line-height: 1.7;
}

.profile-hero-icon {
    width: 105px;
    height: 105px;

    flex-shrink: 0;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 50%;

    background: rgba(56, 189, 248, 0.10);
    border: 1px solid rgba(56, 189, 248, 0.20);

    color: #38BDF8;

    font-size: 42px;

    box-shadow:
        0 10px 30px rgba(0, 0, 0, 0.15);
}


/* =========================================================
   MAIN GRID
========================================================= */

.profile-main-grid {
    display: grid;

    grid-template-columns:
        320px
        minmax(0, 1fr);

    gap: 25px;

    margin-bottom: 25px;

    align-items: start;
}


/* =========================================================
   PROFILE SUMMARY CARD
========================================================= */

.profile-summary-card {
    width: 100%;

    padding: 30px 25px;

    box-sizing: border-box;

    text-align: center;

    border-radius: 18px;

    background: #1E293B;

    border: 1px solid rgba(255, 255, 255, 0.08);

    box-shadow:
        0 10px 30px rgba(0, 0, 0, 0.18);

    transition:
        transform 0.3s ease,
        box-shadow 0.3s ease;
}

.profile-summary-card:hover {
    transform: translateY(-3px);

    box-shadow:
        0 15px 35px rgba(0, 0, 0, 0.25);
}


/* =========================================================
   PROFILE AVATAR
========================================================= */

.profile-avatar {
    width: 110px;
    height: 110px;

    margin: 0 auto 18px;

    display: flex;
    align-items: center;
    justify-content: center;

    overflow: hidden;

    border-radius: 50%;

    background: #0F172A;

    border: 4px solid rgba(56, 189, 248, 0.15);

    box-sizing: border-box;

    box-shadow:
        0 8px 25px rgba(0, 0, 0, 0.25);
}

.citizen-profile-image {
    width: 100%;
    height: 100%;

    display: block;

    object-fit: cover;
    object-position: center;

    border-radius: 50%;
}


/* =========================================================
   SUMMARY TEXT
========================================================= */

.profile-summary-card h2 {
    margin: 0 0 6px;

    color: #F8FAFC;

    font-size: 22px;
    font-weight: 700;
    line-height: 1.35;

    word-break: break-word;
}

.profile-summary-card > p {
    margin: 0 0 15px;

    color: #94A3B8;

    font-size: 14px;
}


/* =========================================================
   PROFILE STATUS
========================================================= */

.profile-status {
    display: inline-flex;
    align-items: center;
    gap: 7px;

    padding: 7px 13px;

    border-radius: 20px;

    background: rgba(34, 197, 94, 0.12);

    border: 1px solid rgba(34, 197, 94, 0.18);

    color: #4ADE80;

    font-size: 12px;
    font-weight: 700;
}

.profile-status-dot {
    width: 8px;
    height: 8px;

    flex-shrink: 0;

    border-radius: 50%;

    background: #22C55E;

    box-shadow:
        0 0 8px rgba(34, 197, 94, 0.45);
}


/* =========================================================
   SUMMARY DIVIDER
========================================================= */

.profile-summary-divider {
    height: 1px;

    margin: 25px 0 20px;

    background:
        rgba(255, 255, 255, 0.08);
}


/* =========================================================
   SUMMARY ITEMS
========================================================= */

.profile-summary-item {
    display: flex;
    align-items: center;

    gap: 13px;

    padding: 12px 0;

    text-align: left;
}

.profile-summary-item > i {
    width: 38px;
    height: 38px;

    flex-shrink: 0;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 10px;

    background: rgba(56, 189, 248, 0.10);

    color: #38BDF8;
}

.profile-summary-item > div {
    min-width: 0;

    flex: 1;
}

.profile-summary-item span {
    display: block;

    margin-bottom: 4px;

    color: #64748B;

    font-size: 11px;
    font-weight: 600;

    text-transform: uppercase;

    letter-spacing: 0.5px;
}

.profile-summary-item strong {
    display: block;

    overflow: hidden;

    color: #E2E8F0;

    font-size: 14px;

    text-overflow: ellipsis;

    white-space: nowrap;
}


/* =========================================================
   COMMON CARDS
========================================================= */

.profile-information-card,
.profile-account-card,
.profile-password-card {
    width: 100%;

    box-sizing: border-box;

    padding: 30px;

    border-radius: 18px;

    background: #1E293B;

    border: 1px solid rgba(255, 255, 255, 0.08);

    box-shadow:
        0 10px 30px rgba(0, 0, 0, 0.18);
}


/* =========================================================
   CARD HEADER
========================================================= */

.profile-card-header {
    display: flex;

    align-items: flex-start;

    justify-content: space-between;

    gap: 20px;

    margin-bottom: 28px;
}

.profile-card-header > div:first-child {
    min-width: 0;
}


/* =========================================================
   SECTION BADGE
========================================================= */

.profile-section-badge {
    display: inline-flex;

    align-items: center;

    gap: 7px;

    margin-bottom: 8px;

    color: #38BDF8;

    font-size: 11px;

    font-weight: 800;

    letter-spacing: 0.8px;
}


/* =========================================================
   CARD TITLES
========================================================= */

.profile-card-header h2 {
    margin: 0 0 6px;

    color: #F8FAFC;

    font-size: 23px;

    font-weight: 700;

    line-height: 1.3;
}

.profile-card-header p {
    margin: 0;

    color: #94A3B8;

    font-size: 14px;

    line-height: 1.5;
}


/* =========================================================
   CARD ICON
========================================================= */

.profile-card-header-icon {
    width: 48px;
    height: 48px;

    flex-shrink: 0;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 12px;

    background: rgba(56, 189, 248, 0.10);

    border: 1px solid rgba(56, 189, 248, 0.12);

    color: #38BDF8;

    font-size: 20px;
}


/* =========================================================
   PERSONAL DETAILS GRID
========================================================= */

.profile-details-grid {
    display: grid;

    grid-template-columns:
        repeat(2, minmax(0, 1fr));

    gap: 16px;
}

.profile-detail-item {
    min-width: 0;

    padding: 18px;

    box-sizing: border-box;

    border-radius: 12px;

    background: #0F172A;

    border: 1px solid rgba(255, 255, 255, 0.07);
}

.profile-detail-full {
    grid-column: 1 / -1;
}


/* =========================================================
   DETAIL LABEL
========================================================= */

.profile-detail-label {
    display: flex;

    align-items: center;

    gap: 8px;

    margin-bottom: 9px;

    color: #94A3B8;

    font-size: 12px;

    font-weight: 700;
}

.profile-detail-label i {
    color: #38BDF8;
}


/* =========================================================
   DETAIL VALUE
========================================================= */

.profile-detail-item strong {
    display: block;

    color: #E2E8F0;

    font-size: 14px;

    line-height: 1.5;

    word-break: break-word;
}


/* =========================================================
   EDIT PROFILE FORM
========================================================= */

.profile-edit-form {
    width: 100%;

    max-width: 100%;

    margin-top: 25px;

    padding: 25px;

    box-sizing: border-box;

    border-radius: 16px;

    background: #0F172A;

    border: 1px solid rgba(255, 255, 255, 0.07);
}

.profile-edit-group {
    width: 100%;

    margin-bottom: 20px;

    box-sizing: border-box;
}


/* =========================================================
   FORM LABEL
========================================================= */

.profile-edit-group label {
    display: block;

    margin-bottom: 8px;

    color: #CBD5E1;

    font-size: 14px;

    font-weight: 600;
}


/* =========================================================
   FORM INPUT
========================================================= */

.profile-edit-input {
    display: block;

    width: 100%;

    min-height: 48px;

    padding: 12px 15px;

    box-sizing: border-box;

    border: 1px solid #334155;

    border-radius: 10px;

    outline: none;

    background: #0B1120;

    color: #E5E7EB;

    font-family: inherit;

    font-size: 15px;

    transition:
        border-color 0.2s ease,
        box-shadow 0.2s ease,
        background 0.2s ease;
}


/* =========================================================
   INPUT FOCUS
========================================================= */

.profile-edit-input:focus {
    border-color: #38BDF8;

    background: #0B1120;

    color: #F8FAFC;

    box-shadow:
        0 0 0 3px rgba(56, 189, 248, 0.10);
}


/* =========================================================
   PLACEHOLDER
========================================================= */

.profile-edit-input::placeholder {
    color: #64748B;
}


/* =========================================================
   TEXTAREA
========================================================= */

.profile-edit-textarea {
    min-height: 120px;

    height: auto;

    resize: vertical;

    line-height: 1.5;
}


/* =========================================================
   DROPDOWN
========================================================= */

select.profile-edit-input {
    cursor: pointer;
}


/* =========================================================
   FILE UPLOAD
========================================================= */

input[type="file"].profile-edit-input {
    min-height: 48px;

    padding: 10px 12px;

    cursor: pointer;
}


/* FILE BUTTON */

input[type="file"].profile-edit-input::file-selector-button {
    margin-right: 12px;

    padding: 8px 14px;

    border: none;

    border-radius: 8px;

    background: rgba(56, 189, 248, 0.10);

    color: #38BDF8;

    font-family: inherit;

    font-size: 13px;

    font-weight: 700;

    cursor: pointer;

    transition:
        background 0.2s ease;
}

input[type="file"].profile-edit-input::file-selector-button:hover {
    background: rgba(56, 189, 248, 0.18);
}


/* =========================================================
   EDIT ACTIONS
========================================================= */

.profile-edit-actions {
    display: flex;

    align-items: center;

    justify-content: flex-end;

    gap: 12px;

    margin-top: 20px;
}


/* =========================================================
   SAVE BUTTON
========================================================= */

.profile-save-button {
    min-width: 145px;

    min-height: 46px;

    padding: 0 22px;

    border: none;

    border-radius: 10px;

    background: #2563EB;

    color: #FFFFFF;

    font-family: inherit;

    font-size: 14px;

    font-weight: 700;

    cursor: pointer;

    transition: all 0.2s ease;
}

.profile-save-button:hover {
    background: #1D4ED8;

    box-shadow:
        0 5px 18px rgba(37, 99, 235, 0.25);

    transform: translateY(-1px);
}

.profile-save-button:active {
    transform: translateY(0);
}


/* =========================================================
   CANCEL BUTTON
========================================================= */

.profile-cancel-button {
    min-width: 105px;

    min-height: 46px;

    padding: 0 20px;

    border: 1px solid #334155;

    border-radius: 10px;

    background: transparent;

    color: #CBD5E1;

    font-family: inherit;

    font-size: 14px;

    font-weight: 700;

    cursor: pointer;

    transition: all 0.2s ease;
}

.profile-cancel-button:hover {
    background: #1E293B;

    border-color: #475569;

    color: #FFFFFF;
}


/* =========================================================
   MESSAGE
========================================================= */

.profile-message {
    display: block;

    margin-top: 15px;

    padding: 10px 13px;

    border-radius: 9px;

    font-size: 14px;

    font-weight: 500;

    line-height: 1.5;
}


/* SUCCESS */

.profile-success {
    background: rgba(34, 197, 94, 0.10);

    color: #4ADE80;

    border: 1px solid rgba(34, 197, 94, 0.20);
}


/* ERROR */

.profile-error {
    background: rgba(239, 68, 68, 0.10);

    color: #F87171;

    border: 1px solid rgba(239, 68, 68, 0.20);
}


/* =========================================================
   PROFILE PHOTO MANAGEMENT
========================================================= */

#pnlPhotoManagement {
    margin-bottom: 25px;
}

#pnlPhotoManagement .profile-edit-form {
    max-width: 100%;

    margin-top: 0;

    background: #0F172A;
}

#pnlPhotoManagement .profile-edit-group {
    max-width: 650px;

    margin-bottom: 0;
}

#pnlPhotoManagement .profile-edit-actions {
    margin-top: 20px;
}


/* =========================================================
   ACCOUNT INFORMATION
========================================================= */

.profile-account-card {
    margin-bottom: 25px;
}

.profile-account-grid {
    display: grid;

    grid-template-columns:
        repeat(4, minmax(0, 1fr));

    gap: 16px;
}

.profile-account-item {
    min-width: 0;

    padding: 18px;

    box-sizing: border-box;

    border-radius: 12px;

    background: #0F172A;

    border: 1px solid rgba(255, 255, 255, 0.07);
}


/* ACCOUNT LABEL */

.profile-account-item > span:first-child {
    display: block;

    margin-bottom: 8px;

    color: #64748B;

    font-size: 12px;

    font-weight: 600;
}


/* ACCOUNT VALUE */

.profile-account-item > strong {
    display: block;

    color: #E2E8F0;

    font-size: 15px;

    line-height: 1.4;

    word-break: break-word;
}


/* =========================================================
   ACCOUNT STATUS
========================================================= */

.account-active {
    display: inline-flex !important;

    align-items: center;

    gap: 7px;

    color: #4ADE80 !important;
}

.account-status-dot {
    width: 8px;

    height: 8px;

    flex-shrink: 0;

    border-radius: 50%;

    background: #22C55E;

    box-shadow:
        0 0 8px rgba(34, 197, 94, 0.40);
}

.account-status-text {
    color: #4ADE80 !important;
}


/* =========================================================
   PROFILE ACTIONS
========================================================= */

.profile-actions {
    display: flex;

    justify-content: flex-end;

    align-items: center;

    gap: 12px;

    margin-bottom: 25px;
}

.profile-edit-button,
.profile-password-button {
    min-width: 160px;

    min-height: 46px;

    padding: 0 20px;

    box-sizing: border-box;

    border-radius: 10px;

    font-family: inherit;

    font-size: 14px;

    font-weight: 700;

    cursor: pointer;

    transition: all 0.2s ease;
}


/* EDIT */

.profile-edit-button {
    border: none;

    background: #2563EB;

    color: #FFFFFF;
}

.profile-edit-button:hover {
    background: #1D4ED8;

    box-shadow:
        0 5px 18px rgba(37, 99, 235, 0.22);

    transform: translateY(-1px);
}


/* PASSWORD */

.profile-password-button {
    border: 1px solid #334155;

    background: #1E293B;

    color: #CBD5E1;
}

.profile-password-button:hover {
    background: #263449;

    border-color: #475569;

    color: #FFFFFF;
}


/* =========================================================
   CHANGE PASSWORD
========================================================= */

.profile-password-card {
    margin-bottom: 25px;
}

.profile-password-form {
    width: 100%;

    max-width: 700px;
}

.profile-password-form .profile-edit-group {
    margin-bottom: 20px;
}

.profile-password-form .profile-edit-actions {
    margin-top: 25px;
}


/* =========================================================
   INFORMATION FOOTER
========================================================= */

.profile-information {
    display: flex;

    align-items: center;

    justify-content: space-between;

    gap: 20px;

    padding: 18px 22px;

    box-sizing: border-box;

    border-radius: 14px;

    background: #1E293B;

    border: 1px solid rgba(255, 255, 255, 0.08);

    color: #94A3B8;

    font-size: 13px;
}

.profile-information div {
    display: flex;

    align-items: center;

    gap: 8px;
}

.profile-information i {
    color: #38BDF8;
}


/* =========================================================
   HOVER EFFECTS
========================================================= */

.profile-detail-item,
.profile-account-item {
    transition:
        border-color 0.2s ease,
        background 0.2s ease,
        transform 0.2s ease;
}

.profile-detail-item:hover,
.profile-account-item:hover {
    background: #162033;

    border-color:
        rgba(56, 189, 248, 0.12);
}


/* =========================================================
   DARK SELECT OPTIONS
========================================================= */

.profile-edit-input option {
    background: #0F172A;

    color: #E5E7EB;
}


/* =========================================================
   DISABLED INPUT
========================================================= */

.profile-edit-input:disabled {
    background: #111827;

    color: #64748B;

    border-color: #263244;

    cursor: not-allowed;

    opacity: 0.8;
}


/* =========================================================
   SCROLLBAR
========================================================= */

.profile-page ::-webkit-scrollbar {
    width: 7px;

    height: 7px;
}

.profile-page ::-webkit-scrollbar-track {
    background: #0B1120;
}

.profile-page ::-webkit-scrollbar-thumb {
    border-radius: 10px;

    background: #334155;
}

.profile-page ::-webkit-scrollbar-thumb:hover {
    background: #475569;
}


/* =========================================================
   TABLET
========================================================= */

@media (max-width: 1000px) {

    .profile-main-grid {
        grid-template-columns: 1fr;
    }

    .profile-summary-card {
        text-align: center;
    }

    .profile-summary-item {
        max-width: 450px;

        margin: 0 auto;
    }

    .profile-account-grid {
        grid-template-columns:
            repeat(2, minmax(0, 1fr));
    }
}


/* =========================================================
   TABLET / MOBILE
========================================================= */

@media (max-width: 768px) {

    .profile-page {
        padding: 25px 18px 40px;
    }


    /* HERO */

    .profile-hero {
        padding: 30px 25px;

        flex-direction: column;

        align-items: flex-start;
    }

    .profile-hero-icon {
        width: 80px;

        height: 80px;

        font-size: 32px;
    }

    .profile-hero h1 {
        font-size: 30px;
    }


    /* CARDS */

    .profile-information-card,
    .profile-account-card,
    .profile-password-card {
        padding: 22px;
    }


    /* DETAILS */

    .profile-details-grid {
        grid-template-columns: 1fr;
    }

    .profile-detail-full {
        grid-column: auto;
    }


    /* ACCOUNT */

    .profile-account-grid {
        grid-template-columns: 1fr;
    }


    /* FORM */

    .profile-edit-form {
        padding: 20px;
    }


    /* EDIT ACTIONS */

    .profile-edit-actions {
        flex-direction: column;

        align-items: stretch;
    }

    .profile-save-button,
    .profile-cancel-button {
        width: 100%;
    }


    /* PROFILE ACTIONS */

    .profile-actions {
        flex-direction: column;

        align-items: stretch;
    }

    .profile-edit-button,
    .profile-password-button {
        width: 100%;
    }


    /* FOOTER */

    .profile-information {
        flex-direction: column;

        align-items: flex-start;
    }
}


/* =========================================================
   MOBILE
========================================================= */

@media (max-width: 480px) {

    .profile-page {
        padding: 18px 12px 30px;
    }


    /* HERO */

    .profile-hero {
        padding: 25px 20px;

        border-radius: 16px;
    }

    .profile-hero h1 {
        font-size: 25px;
    }

    .profile-hero p {
        font-size: 13px;
    }

    .profile-badge {
        font-size: 10px;
    }


    /* AVATAR */

    .profile-avatar {
        width: 95px;

        height: 95px;
    }


    /* CARDS */

    .profile-information-card,
    .profile-account-card,
    .profile-password-card {
        padding: 18px;

        border-radius: 15px;
    }


    /* CARD HEADER */

    .profile-card-header {
        gap: 12px;
    }

    .profile-card-header h2 {
        font-size: 19px;
    }

    .profile-card-header p {
        font-size: 13px;
    }

    .profile-card-header-icon {
        width: 40px;

        height: 40px;

        font-size: 16px;
    }


    /* ITEMS */

    .profile-detail-item,
    .profile-account-item {
        padding: 15px;
    }


    /* FORM */

    .profile-edit-form {
        padding: 16px;

        border-radius: 13px;
    }

    .profile-edit-input {
        min-height: 46px;

        font-size: 14px;
    }

    .profile-edit-textarea {
        min-height: 110px;
    }


    /* FOOTER */

    .profile-information {
        padding: 16px;

        font-size: 12px;
    }
}


/* =========================================================
   VERY SMALL MOBILE
========================================================= */

@media (max-width: 360px) {

    .profile-page {
        padding: 14px 9px 25px;
    }

    .profile-hero {
        padding: 20px 16px;
    }

    .profile-hero h1 {
        font-size: 23px;
    }

    .profile-hero p {
        font-size: 12px;
    }

    .profile-information-card,
    .profile-account-card,
    .profile-password-card {
        padding: 15px;
    }

    .profile-card-header h2 {
        font-size: 18px;
    }

    .profile-edit-form {
        padding: 14px;
    }

    .profile-detail-item,
    .profile-account-item {
        padding: 13px;
    }
}
    </style>

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
