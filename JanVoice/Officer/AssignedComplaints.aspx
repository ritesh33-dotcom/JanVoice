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
                                        ID="lnkResolutionDetails"
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
