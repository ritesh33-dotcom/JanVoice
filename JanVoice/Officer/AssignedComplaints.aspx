<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="AssignedComplaints.aspx.cs" Inherits="JanVoice.Officer.AssignedComplaints" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/AssignedComplaints.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <section class="assigned-complaints-section">

        <div class="container-fluid">

            <!-- =========================================
                 PAGE HEADER
            ========================================== -->

            <div class="page-header">

                <div>

                    <span class="page-badge">
                        <i class="fa-solid fa-list-check"></i>
                        Complaint Management
                    </span>

                    <h1>
                        Assigned Complaints
                    </h1>

                    <p>
                        View, monitor and manage complaints assigned
                        to your department and ward.
                    </p>

                </div>

            </div>


            <!-- =========================================
                 STATISTICS
            ========================================== -->

            <div class="row g-4 mt-3">

                <!-- Total -->

                <div class="col-xl-3 col-lg-4 col-md-6">

                    <div class="complaint-stat-card">

                        <div class="stat-icon">

                            <i class="fa-solid fa-folder-open"></i>

                        </div>

                        <div>

                            <h2>
                                <asp:Label
                                    ID="lblTotalAssigned"
                                    runat="server"
                                    Text="0">
                                </asp:Label>
                            </h2>

                            <p>Total Assigned</p>

                        </div>

                    </div>

                </div>


                <!-- Pending -->

                <div class="col-xl-3 col-lg-4 col-md-6">

                    <div class="complaint-stat-card">

                        <div class="stat-icon pending">

                            <i class="fa-solid fa-clock"></i>

                        </div>

                        <div>

                            <h2>
                                <asp:Label
                                    ID="lblPending"
                                    runat="server"
                                    Text="0">
                                </asp:Label>
                            </h2>

                            <p>Pending</p>

                        </div>

                    </div>

                </div>


                <!-- In Progress -->

                <div class="col-xl-3 col-lg-4 col-md-6">

                    <div class="complaint-stat-card">

                        <div class="stat-icon progress">

                            <i class="fa-solid fa-spinner"></i>

                        </div>

                        <div>

                            <h2>
                                <asp:Label
                                    ID="lblInProgress"
                                    runat="server"
                                    Text="0">
                                </asp:Label>
                            </h2>

                            <p>In Progress</p>

                        </div>

                    </div>

                </div>


                <!-- Resolved -->

                <div class="col-xl-3 col-lg-4 col-md-6">

                    <div class="complaint-stat-card">

                        <div class="stat-icon resolved">

                            <i class="fa-solid fa-circle-check"></i>

                        </div>

                        <div>

                            <h2>
                                <asp:Label
                                    ID="lblResolved"
                                    runat="server"
                                    Text="0">
                                </asp:Label>
                            </h2>

                            <p>Resolved</p>

                        </div>

                    </div>

                </div>

            </div>


            <!-- =========================================
                 FILTER / SEARCH BOX
            ========================================== -->

            <div class="complaints-control-box mt-5">

                <div class="control-header">

                    <div>

                        <h3>
                            <i class="fa-solid fa-filter"></i>
                            Search & Filter Complaints
                        </h3>

                        <p>
                            Find a complaint quickly using the available filters.
                        </p>

                    </div>

                </div>


                <div class="row g-3 mt-2 align-items-end">

                    <!-- Search -->

                    <div class="col-lg-4 col-md-12">

                        <label>
                            Search Complaint
                        </label>

                        <div class="input-icon">

                            <i class="fa-solid fa-magnifying-glass"></i>

                            <asp:TextBox
                                ID="txtSearch"
                                runat="server"
                                CssClass="form-control"
                                placeholder="Complaint ID or title">
                            </asp:TextBox>

                        </div>

                    </div>


                    <!-- Status -->

                    <div class="col-lg-2 col-md-4">

                        <label>
                            Status
                        </label>

                        <asp:DropDownList
                            ID="ddlStatus"
                            runat="server"
                            CssClass="form-select">

                            <asp:ListItem
                                Value="">
                                All Status
                            </asp:ListItem>

                            <asp:ListItem
                                Value="Pending">
                                Pending
                            </asp:ListItem>

                            <asp:ListItem
                                Value="In Progress">
                                In Progress
                            </asp:ListItem>

                            <asp:ListItem
                                Value="Resolved">
                                Resolved
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>


                    <!-- Priority -->

                    <div class="col-lg-2 col-md-4">

                        <label>
                            Priority
                        </label>

                        <asp:DropDownList
                            ID="ddlPriority"
                            runat="server"
                            CssClass="form-select">

                            <asp:ListItem
                                Value="">
                                All Priority
                            </asp:ListItem>

                            <asp:ListItem
                                Value="High">
                                High
                            </asp:ListItem>

                            <asp:ListItem
                                Value="Medium">
                                Medium
                            </asp:ListItem>

                            <asp:ListItem
                                Value="Low">
                                Low
                            </asp:ListItem>

                        </asp:DropDownList>

                    </div>


                    <!-- Search Button -->

                    <div class="col-lg-2 col-md-4">

                        <label class="filter-label">
                            &nbsp;
                        </label>

                        <asp:Button
                            ID="btnSearch"
                            runat="server"
                            Text="Search"
                            CssClass="btn btn-primary w-100"
                            OnClick="btnSearch_Click" />

                    </div>


                    <!-- Reset Button -->

                    <div class="col-lg-2 col-md-4">

                        <label class="filter-label">
                            &nbsp;
                        </label>

                        <asp:Button
                            ID="btnReset"
                            runat="server"
                            Text="Reset"
                            CssClass="btn btn-outline-secondary w-100"
                            OnClick="btnReset_Click" />

                    </div>

                </div>

            </div>


            <!-- =========================================
                 COMPLAINT TABLE
            ========================================== -->

            <div class="complaints-table-box mt-4">

                <div class="table-header">

                    <div>

                        <h3>
                            <i class="fa-solid fa-table-list"></i>
                            Assigned Complaints
                        </h3>

                        <p>
                            Complaints currently assigned to you.
                        </p>

                    </div>

                </div>


                <div class="table-responsive">

                    <asp:GridView
                        ID="gvAssignedComplaints"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="table complaint-table"
                        GridLines="None"
                        EmptyDataText="No assigned complaints found."
                        AllowPaging="true"
                        PageSize="10"
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


                            <asp:TemplateField
                                HeaderText="Action">

                                <ItemTemplate>

                                    <a
                                        href='ComplaintDetails.aspx?ComplaintID=<%# Eval("ComplaintID") %>'
                                        class="view-complaint-btn">

                                        <i class="fa-solid fa-eye"></i>

                                        View

                                    </a>

                                </ItemTemplate>

                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>

            </div>


        </div>

    </section>


</asp:Content>
