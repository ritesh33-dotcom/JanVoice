<%@ Page Title="Assigned Complaints"
    Language="C#"
    MasterPageFile="~/MasterPages/Officer.Master"
    AutoEventWireup="true"
    CodeBehind="AssignedComplaints.aspx.cs"
    Inherits="JanVoice.Officer.AssignedComplaints" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/AssignedComplaints.css" rel="stylesheet" />

    <style>
        /* =========================================================
   JANVOICE - ASSIGNED COMPLAINTS
   MAIN CSS
========================================================= */


/* =========================================================
   PAGE
========================================================= */

.assigned-complaints-page {
    min-height: 100vh;
    padding: 35px 25px 60px;
    background: #f5f7fb;
    color: #35425b;
}


/* =========================================================
   CONTAINER
========================================================= */

.assigned-container {
    width: 100%;
    max-width: 1450px;
    margin: 0 auto;
}


/* =========================================================
   PAGE HEADER
========================================================= */

.assigned-page-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 30px;
    padding: 25px 28px;
    border: 1px solid #e3e8f2;
    border-radius: 18px;
    background: linear-gradient(145deg, #ffffff, #f8faff);
    box-shadow: 0 12px 35px rgba(21, 38, 74, 0.07);
}

.page-header-content {
    flex: 1;
}

.page-badge {
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

.assigned-page-header h1 {
    margin: 15px 0 8px;
    color: #17233d;
    font-size: 34px;
    font-weight: 700;
}

.assigned-page-header p {
    margin: 0;
    color: #7d899e;
    font-size: 14px;
    line-height: 1.6;
}

.page-header-icon {
    width: 65px;
    height: 65px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 16px;
    background: #edf4ff;
    color: #3478ef;
    font-size: 26px;
}


/* =========================================================
   STATISTICS GRID
========================================================= */

.statistics-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-top: 25px;
}


/* =========================================================
   STATISTICS CARD
========================================================= */

.statistics-card {
    display: flex;
    align-items: center;
    justify-content: space-between;
    min-height: 125px;
    padding: 22px;
    border: 1px solid #e3e8f2;
    border-radius: 16px;
    background: #ffffff;
    box-shadow: 0 10px 30px rgba(21, 38, 74, 0.07);
    transition: 0.25s ease;
}

    .statistics-card:hover {
        transform: translateY(-4px);
        border-color: #d5e2fb;
        box-shadow: 0 15px 35px rgba(21, 38, 74, 0.12);
    }


/* =========================================================
   STATISTICS CONTENT
========================================================= */

.statistics-content {
    min-width: 0;
}

.statistics-title {
    display: block;
    color: #7d899e;
    font-size: 13px;
    font-weight: 600;
}

.statistics-card h2 {
    margin: 7px 0 0;
    color: #17233d;
    font-size: 30px;
    font-weight: 700;
}

.statistics-description {
    display: block;
    margin-top: 5px;
    color: #929caf;
    font-size: 11px;
}


/* =========================================================
   STATISTICS ICON
========================================================= */

.statistics-icon {
    width: 52px;
    height: 52px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 14px;
    background: #edf4ff;
    color: #3478ef;
    font-size: 20px;
}

    .statistics-icon.total {
        background: #edf4ff;
        color: #3478ef;
    }

    .statistics-icon.pending {
        background: #fff6e8;
        color: #ed9000;
    }

    .statistics-icon.progress {
        background: #edf4ff;
        color: #3478ef;
    }

    .statistics-icon.resolved {
        background: #eafaf3;
        color: #0ba56c;
    }


/* =========================================================
   FILTER CARD
========================================================= */

.filter-card {
    margin-top: 30px;
    padding: 25px;
    border: 1px solid #e3e8f2;
    border-radius: 18px;
    background: #ffffff;
    box-shadow: 0 12px 35px rgba(21, 38, 74, 0.06);
}


/* =========================================================
   FILTER HEADER
========================================================= */

.filter-header {
    margin-bottom: 22px;
}

.filter-title {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #17233d;
    font-size: 18px;
    font-weight: 650;
}

    .filter-title i {
        color: #3478ef;
    }

.filter-header p {
    margin: 7px 0 0;
    color: #7d899e;
    font-size: 13px;
}


/* =========================================================
   FILTER GRID
========================================================= */

.filter-grid {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr auto auto;
    gap: 15px;
    align-items: end;
}


/* =========================================================
   FILTER GROUP
========================================================= */

.filter-group label {
    display: block;
    margin-bottom: 7px;
    color: #536078;
    font-size: 13px;
    font-weight: 600;
}


/* =========================================================
   SEARCH INPUT
========================================================= */

.search-input-wrapper {
    position: relative;
}

    .search-input-wrapper i {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: #929caf;
        pointer-events: none;
    }

.filter-input {
    width: 100%;
    min-height: 45px;
    padding: 10px 14px 10px 40px;
    border: 1px solid #dfe5ef;
    border-radius: 10px;
    outline: none;
    background: #ffffff;
    color: #35425b;
    font-size: 13px;
    transition: 0.2s ease;
}

    .filter-input::placeholder {
        color: #929caf;
    }

    .filter-input:focus {
        border-color: #3478ef;
        box-shadow: 0 0 0 3px rgba(52, 120, 239, 0.12);
    }


/* =========================================================
   SELECT
========================================================= */

.filter-select {
    width: 100%;
    min-height: 45px;
    padding: 8px 12px;
    border: 1px solid #dfe5ef;
    border-radius: 10px;
    outline: none;
    background: #ffffff;
    color: #35425b;
    font-size: 13px;
}

    .filter-select:focus {
        border-color: #3478ef;
        box-shadow: 0 0 0 3px rgba(52, 120, 239, 0.12);
    }


/* =========================================================
   FILTER BUTTONS
========================================================= */

.filter-action {
    display: flex;
    align-items: end;
}

.btn-search,
.btn-reset {
    min-height: 45px;
    padding: 0 20px;
    border-radius: 10px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.2s ease;
}


/* SEARCH */

.btn-search {
    border: none;
    background: linear-gradient(135deg, #3478ef, #23428f);
    color: #ffffff;
}

    .btn-search:hover {
        transform: translateY(-1px);
        box-shadow: 0 8px 20px rgba(52, 120, 239, 0.25);
    }


/* RESET */

.btn-reset {
    border: 1px solid #d5dce8;
    background: #ffffff;
    color: #536078;
}

    .btn-reset:hover {
        border-color: #c5d6f3;
        background: #f6f8fc;
        color: #17233d;
    }


/* =========================================================
   COMPLAINTS CARD
========================================================= */

.complaints-card {
    margin-top: 30px;
    overflow: hidden;
    border: 1px solid #e3e8f2;
    border-radius: 18px;
    background: #ffffff;
    box-shadow: 0 12px 35px rgba(21, 38, 74, 0.06);
}


/* =========================================================
   COMPLAINT HEADER
========================================================= */

.complaints-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 24px 25px;
    border-bottom: 1px solid #edf0f5;
}

.complaints-title {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #17233d;
    font-size: 18px;
    font-weight: 650;
}

    .complaints-title i {
        color: #3478ef;
    }

.complaints-header p {
    margin: 7px 0 0;
    color: #7d899e;
    font-size: 13px;
}

.complaints-header-icon {
    width: 45px;
    height: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    background: #edf4ff;
    color: #3478ef;
}


/* =========================================================
   TABLE WRAPPER
========================================================= */

.complaints-table-wrapper {
    width: 100%;
    overflow-x: auto;
}


/* =========================================================
   GRIDVIEW TABLE
========================================================= */

.complaints-table {
    width: 100%;
    min-width: 1000px;
    margin: 0;
    border-collapse: separate;
    border-spacing: 0;
    background: transparent;
    color: #35425b;
}


    /* =========================================================
   TABLE HEADER
========================================================= */

    .complaints-table th {
        padding: 16px 15px;
        border-bottom: 1px solid #e5e9f1;
        background: #f6f8fc;
        color: #66738a;
        font-size: 12px;
        font-weight: 650;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }


    /* =========================================================
   TABLE BODY
========================================================= */

    .complaints-table td {
        padding: 16px 15px;
        border-bottom: 1px solid #edf0f5;
        background: transparent;
        color: #35425b;
        font-size: 13px;
        vertical-align: middle;
        white-space: nowrap;
    }


    /* =========================================================
   TABLE ROW
========================================================= */

    .complaints-table tr {
        transition: background 0.2s ease;
    }

        .complaints-table tr:hover td {
            background: #f8faff;
        }


/* =========================================================
   VIEW BUTTON
========================================================= */

.view-complaint-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 7px;
    padding: 7px 13px;
    border: 1px solid #d5e2fb;
    border-radius: 8px;
    background: #edf4ff;
    color: #3478ef !important;
    font-size: 12px;
    font-weight: 600;
    text-decoration: none;
    transition: 0.2s ease;
}

    .view-complaint-btn:hover {
        background: #dfeaff;
        border-color: #c5d8fa;
        color: #23428f !important;
        transform: translateY(-1px);
    }


/* =========================================================
   PAGE INFORMATION
========================================================= */

.page-information {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
    margin-top: 20px;
    padding: 15px 20px;
    border: 1px solid #e3e8f2;
    border-radius: 12px;
    background: #ffffff;
    color: #7d899e;
    font-size: 12px;
    box-shadow: 0 8px 20px rgba(21, 38, 74, 0.04);
}

    .page-information div {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .page-information i {
        color: #3478ef;
    }


/* =========================================================
   SCROLLBAR
========================================================= */

.complaints-table-wrapper::-webkit-scrollbar {
    height: 7px;
}

.complaints-table-wrapper::-webkit-scrollbar-track {
    background: #f5f7fb;
}

.complaints-table-wrapper::-webkit-scrollbar-thumb {
    border-radius: 10px;
    background: #c9d9f5;
}

    .complaints-table-wrapper::-webkit-scrollbar-thumb:hover {
        background: #a9c1ea;
    }


/* =========================================================
   RESPONSIVE - 1200px
========================================================= */

@media (max-width: 1200px) {

    .statistics-grid {
        grid-template-columns: repeat(2, 1fr);
    }

    .filter-grid {
        grid-template-columns: 2fr 1fr 1fr;
    }

    .filter-action {
        margin-top: 5px;
    }
}


/* =========================================================
   RESPONSIVE - 991px
========================================================= */

@media (max-width: 991px) {

    .assigned-complaints-page {
        padding: 28px 18px 45px;
    }

    .assigned-page-header h1 {
        font-size: 28px;
    }

    .statistics-card {
        min-height: 110px;
        padding: 18px;
    }

    .filter-card {
        padding: 20px;
    }

    .filter-grid {
        grid-template-columns: 1fr 1fr;
    }

    .search-group {
        grid-column: 1 / -1;
    }

    .filter-action {
        width: 100%;
    }

    .btn-search,
    .btn-reset {
        width: 100%;
    }
}


/* =========================================================
   RESPONSIVE - 767px
========================================================= */

@media (max-width: 767px) {

    .assigned-complaints-page {
        padding: 22px 14px 35px;
    }

    .assigned-page-header {
        padding: 20px;
    }

        .assigned-page-header h1 {
            font-size: 25px;
        }

        .assigned-page-header p {
            font-size: 13px;
        }

    .page-header-icon {
        width: 52px;
        height: 52px;
        font-size: 21px;
    }

    .statistics-grid {
        grid-template-columns: 1fr;
        gap: 14px;
    }

    .statistics-card {
        min-height: 95px;
        padding: 16px;
        border-radius: 14px;
    }

    .statistics-icon {
        width: 42px;
        height: 42px;
        font-size: 17px;
    }

    .statistics-card h2 {
        font-size: 24px;
    }

    .filter-grid {
        grid-template-columns: 1fr;
    }

    .search-group {
        grid-column: auto;
    }

    .complaints-header {
        padding: 18px;
    }

    .complaints-title {
        font-size: 16px;
    }

    .complaints-header-icon {
        display: none;
    }

    .page-information {
        flex-direction: column;
        align-items: flex-start;
    }
}


/* =========================================================
   RESPONSIVE - 575px
========================================================= */

@media (max-width: 575px) {

    .assigned-complaints-page {
        padding: 20px 12px 30px;
    }

    .assigned-page-header {
        padding: 17px;
    }

        .assigned-page-header h1 {
            font-size: 23px;
        }

        .assigned-page-header p {
            font-size: 12px;
        }

    .page-header-icon {
        display: none;
    }

    .statistics-card {
        padding: 15px;
        min-height: 90px;
    }

        .statistics-card h2 {
            font-size: 21px;
        }

    .filter-card {
        padding: 15px;
        border-radius: 13px;
    }

    .complaints-card {
        border-radius: 15px;
    }
}


/* =========================================================
   RESPONSIVE - 400px
========================================================= */

@media (max-width: 400px) {

    .assigned-complaints-page {
        padding: 18px 10px 28px;
    }

    .assigned-page-header h1 {
        font-size: 21px;
    }

    .assigned-page-header p {
        font-size: 11px;
    }

    .page-badge {
        padding: 5px 9px;
        font-size: 10px;
    }

    .statistics-card {
        gap: 10px;
        padding: 13px;
    }

    .statistics-icon {
        width: 37px;
        height: 37px;
        font-size: 15px;
    }

    .statistics-card h2 {
        font-size: 19px;
    }

    .statistics-description {
        font-size: 10px;
    }

    .filter-card {
        padding: 13px;
    }
}


/* =========================================================
   END OF ASSIGNED COMPLAINTS CSS
========================================================= */

    </style>
</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <!-- =========================================
         ASSIGNED COMPLAINTS PAGE
    ========================================== -->

    <section class="assigned-complaints-page">

        <div class="assigned-container">


            <!-- =========================================
                 PAGE HEADER
            ========================================== -->

            <div class="assigned-page-header">

                <div class="page-header-content">

                    <span class="page-badge">
                        <i class="fa-solid fa-list-check"></i>
                        Complaint Management
                    </span>

                    <h1>Assigned Complaints
                    </h1>

                    <p>
                        View, monitor and manage complaints
                        assigned to you.
                    </p>

                </div>


                <div class="page-header-icon">

                    <i class="fa-solid fa-clipboard-list"></i>

                </div>

            </div>


            <!-- =========================================
                 STATISTICS
            ========================================== -->

            <div class="statistics-grid">


                <!-- TOTAL ASSIGNED -->

                <div class="statistics-card">

                    <div class="statistics-content">

                        <span class="statistics-title">Total Assigned
                        </span>

                        <h2>

                            <asp:Label
                                ID="lblTotalAssigned"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </h2>

                        <span class="statistics-description">Complaints assigned to you
                        </span>

                    </div>


                    <div class="statistics-icon total">

                        <i class="fa-solid fa-folder-open"></i>

                    </div>

                </div>



                <!-- PENDING -->

                <div class="statistics-card">

                    <div class="statistics-content">

                        <span class="statistics-title">Pending
                        </span>

                        <h2>

                            <asp:Label
                                ID="lblPending"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </h2>

                        <span class="statistics-description">Waiting for action
                        </span>

                    </div>


                    <div class="statistics-icon pending">

                        <i class="fa-solid fa-clock"></i>

                    </div>

                </div>



                <!-- IN PROGRESS -->

                <div class="statistics-card">

                    <div class="statistics-content">

                        <span class="statistics-title">In Progress
                        </span>

                        <h2>

                            <asp:Label
                                ID="lblInProgress"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </h2>

                        <span class="statistics-description">Currently being handled
                        </span>

                    </div>


                    <div class="statistics-icon progress">

                        <i class="fa-solid fa-spinner"></i>

                    </div>

                </div>



                <!-- RESOLVED -->

                <div class="statistics-card">

                    <div class="statistics-content">

                        <span class="statistics-title">Resolved
                        </span>

                        <h2>

                            <asp:Label
                                ID="lblResolved"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </h2>

                        <span class="statistics-description">Successfully resolved
                        </span>

                    </div>


                    <div class="statistics-icon resolved">

                        <i class="fa-solid fa-circle-check"></i>

                    </div>

                </div>


            </div>



            <!-- =========================================
                 SEARCH & FILTER
            ========================================== -->

            <div class="filter-card">


                <div class="filter-header">

                    <div>

                        <div class="filter-title">

                            <i class="fa-solid fa-filter"></i>

                            Search & Filter Complaints

                        </div>

                        <p>
                            Find assigned complaints quickly
                            using search and filters.
                        </p>

                    </div>

                </div>



                <div class="filter-grid">


                    <!-- SEARCH -->

                    <div class="filter-group search-group">

                        <label>
                            Search Complaint
                        </label>

                        <div class="search-input-wrapper">

                            <i class="fa-solid fa-magnifying-glass"></i>

                            <asp:TextBox
                                ID="txtSearch"
                                runat="server"
                                CssClass="filter-input"
                                placeholder="Complaint ID or title">
                            </asp:TextBox>

                        </div>

                    </div>



                    <!-- STATUS -->

                    <div class="filter-group">

                        <label>
                            Status
                        </label>

                        <asp:DropDownList
                            ID="ddlStatus"
                            runat="server"
                            CssClass="filter-select">

                            <asp:ListItem
                                Text="All Status"
                                Value="">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Pending"
                                Value="Pending">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="In Progress"
                                Value="In Progress">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Resolved"
                                Value="Resolved">
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>



                    <!-- PRIORITY -->

                    <div class="filter-group">

                        <label>
                            Priority
                        </label>

                        <asp:DropDownList
                            ID="ddlPriority"
                            runat="server"
                            CssClass="filter-select">

                            <asp:ListItem
                                Text="All Priority"
                                Value="">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="High"
                                Value="High">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Medium"
                                Value="Medium">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Low"
                                Value="Low">
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>



                    <!-- SEARCH BUTTON -->

                    <div class="filter-action">

                        <asp:Button
                            ID="btnSearch"
                            runat="server"
                            Text="Search"
                            CssClass="btn-search"
                            OnClick="btnSearch_Click" />

                    </div>



                    <!-- RESET BUTTON -->

                    <div class="filter-action">

                        <asp:Button
                            ID="btnReset"
                            runat="server"
                            Text="Reset"
                            CssClass="btn-reset"
                            OnClick="btnReset_Click" />

                    </div>


                </div>

            </div>



            <!-- =========================================
                 ASSIGNED COMPLAINTS TABLE
            ========================================== -->

            <div class="complaints-card">


                <!-- TABLE HEADER -->

                <div class="complaints-header">

                    <div>

                        <div class="complaints-title">

                            <i class="fa-solid fa-table-list"></i>

                            Assigned Complaints

                        </div>

                        <p>
                            Complaints currently assigned to you.
                        </p>

                    </div>


                    <div class="complaints-header-icon">

                        <i class="fa-solid fa-layer-group"></i>

                    </div>

                </div>



                <!-- TABLE -->

                <div class="complaints-table-wrapper">

                    <asp:GridView
                        ID="gvAssignedComplaints"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="complaints-table"
                        GridLines="None"
                        AllowPaging="true"
                        PageSize="10"
                        EmptyDataText="No assigned complaints found."
                        OnPageIndexChanging="gvAssignedComplaints_PageIndexChanging">

                        <Columns>

                            <asp:BoundField
                                DataField="ComplaintID"
                                HeaderText="Complaint ID" />

                            <asp:BoundField
                                DataField="Title"
                                HeaderText="Complaint" />

                            <asp:BoundField
                                DataField="CitizenName"
                                HeaderText="Citizen" />

                            <asp:BoundField
                                DataField="CategoryName"
                                HeaderText="Category" />

                            <asp:BoundField
                                DataField="WardName"
                                HeaderText="Ward" />

                            <asp:BoundField
                                DataField="Priority"
                                HeaderText="Priority" />

                            <asp:BoundField
                                DataField="Status"
                                HeaderText="Status" />

                            <asp:BoundField
                                DataField="CreatedDate"
                                HeaderText="Created"
                                DataFormatString="{0:dd MMM yyyy}" />

                          <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>

                            <asp:HyperLink
                                ID="btnResolution"
                                runat="server"
                                Text="Resolution Details"
                                CssClass="btn-resolution"
                                NavigateUrl='<%# ResolveUrl("~/Officer/ResolutionDetails.aspx?ComplaintID=" + Eval("ComplaintID")) %>'>
                            </asp:HyperLink>

                        </ItemTemplate>
                    </asp:TemplateField>

                 </Columns>

                    </asp:GridView>

                </div>


            </div>



            <!-- =========================================
                 PAGE INFORMATION
            ========================================== -->

            <div class="page-information">

                <div>

                    <i class="fa-solid fa-circle-info"></i>

                    Showing complaints assigned to your account.

                </div>


                <div>

                    <i class="fa-solid fa-shield-halved"></i>

                    JanVoice Officer Panel

                </div>

            </div>


        </div>

    </section>

</asp:Content>
