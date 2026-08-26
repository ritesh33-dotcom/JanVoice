<%@ Page Title="Manage Complaints"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageComplaints.aspx.cs"
    Inherits="JanVoice.Admin.ManageComplaints" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ManageComplaints.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="complaints-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="complaints-header">

            <div>

                <span class="page-label">JANVOICE ADMINISTRATION
                </span>

                <h1>Manage Complaints
                </h1>

                <p>
                    Review, monitor and manage civic issues reported by citizens.
                </p>

            </div>


            <!-- DYNAMIC SUMMARY -->

            <div class="header-summary">

                <div class="summary-item">

                    <span>Total
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblTotalComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>


                <div class="summary-item pending-summary">

                    <span>Pending
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblPendingComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>


                <div class="summary-item resolved-summary">

                    <span>Resolved
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblResolvedComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>

        </div>



        <!-- =====================================
             FILTER / SEARCH CARD
        ====================================== -->

        <div class="filter-card">


            <div class="filter-header">

                <div>

                    <h3>Find Complaints
                    </h3>

                    <p>
                        Search and filter reported civic issues.
                    </p>

                </div>

            </div>


            <div class="filter-row">


                <!-- SEARCH -->

                <div class="filter-field search-field">

                    <label>
                        Search
                    </label>

                    <div class="search-input-wrapper">

                        <span class="search-icon">🔍
                        </span>

                        <asp:TextBox
                            ID="txtSearch"
                            runat="server"
                            CssClass="filter-input"
                            placeholder="Search by complaint title or ID...">
                        </asp:TextBox>

                    </div>

                </div>



                <!-- STATUS -->

                <div class="filter-field">

                    <label>
                        Status
                    </label>

                    <asp:DropDownList
                        ID="ddlStatus"
                        runat="server"
                        CssClass="filter-input">

                        <asp:ListItem
                            Text="All Status"
                            Value="">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Pending"
                            Value="Pending">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Accepted"
                            Value="Accepted">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="In Progress"
                            Value="In Progress">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Resolved"
                            Value="Resolved">
                        </asp:ListItem>

                        <asp:ListItem
                            Text="Rejected"
                            Value="Rejected">
                        </asp:ListItem>

                    </asp:DropDownList>

                </div>



                <!-- CATEGORY -->

                <div class="filter-field">

                    <label>
                        Category
                    </label>

                    <asp:DropDownList
                        ID="ddlCategory"
                        runat="server"
                        CssClass="filter-input">
                    </asp:DropDownList>

                </div>



                <!-- WARD -->

                <div class="filter-field">

                    <label>
                        Ward
                    </label>

                    <asp:DropDownList
                        ID="ddlWard"
                        runat="server"
                        CssClass="filter-input">
                    </asp:DropDownList>

                </div>



                <!-- BUTTON -->

                <div class="filter-action">

                    <asp:Button
                        ID="btnFilter"
                        runat="server"
                        Text="Apply Filters"
                        CssClass="btn-filter"
                        OnClick="btnFilter_Click" />

                </div>


            </div>

        </div>



        <!-- =====================================
             COMPLAINT TABLE
        ====================================== -->

        <div class="complaints-card">


            <!-- TABLE HEADER -->

            <div class="table-header">

                <div>

                    <h3>All Complaints
                    </h3>

                    <p>
                        Latest civic issues reported by citizens.
                    </p>

                </div>


                <span class="record-count">

                    <asp:Label
                        ID="lblRecordCount"
                        runat="server"
                        Text="0 Complaints">
                    </asp:Label>

                </span>

            </div>



            <!-- TABLE -->

            <div class="table-wrapper">

                <asp:Repeater
                    ID="rptComplaints"
                    runat="server"
                    OnItemDataBound="rptComplaints_ItemDataBound">

                    <HeaderTemplate>

                        <table class="complaints-table">

                            <thead>

                                <tr>

                                    <th>ID</th>

                                    <th>Complaint</th>

                                    <th>Citizen</th>

                                    <th>Category</th>

                                    <th>Ward</th>

                                    <th>Priority</th>

                                    <th>Status</th>

                                    <th>Date</th>

                                    <th>Action</th>

                                </tr>

                            </thead>

                            <tbody>
                    </HeaderTemplate>


                    <ItemTemplate>

                        <tr>

                            <!-- ID -->

                            <td>

                                <span class="complaint-id">#<%# Eval("ComplaintID") %>

                                </span>

                            </td>



                            <!-- COMPLAINT -->

                            <td>

                                <div class="complaint-info">

                                    <strong>

                                        <%# Eval("Title") %>

                                    </strong>

                                    <span>

                                        <%# Eval("Description") %>

                                    </span>

                                </div>

                            </td>



                            <!-- CITIZEN -->

                            <td>

                                <div class="citizen-info">

                                    <div class="citizen-avatar">

                                        <%# GetInitial(Eval("FullName")) %>
                                    </div>

                                    <span>

                                        <%# Eval("FullName") %>

                                    </span>

                                </div>

                            </td>



                            <!-- CATEGORY -->

                            <td>

                                <span class="category-badge">

                                    <%# Eval("CategoryName") %>

                                </span>

                            </td>



                            <!-- WARD -->

                            <td>

                                <%# Eval("WardName") %>

                            </td>



                            <!-- PRIORITY -->

                            <td>

                                <span
                                    class='<%# "priority " + GetPriorityClass(Eval("Priority")) %>'>

                                    <%# Eval("Priority") %>

                                </span>

                            </td>



                            <!-- STATUS -->

                            <td>

                                <span
                                    class='<%# "status-badge " + GetStatusClass(Eval("Status")) %>'>

                                    <%# Eval("Status") %>

                                </span>

                            </td>



                            <!-- DATE -->

                            <td>

                                <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>

                            </td>



                            <!-- ACTION -->

                            <td>

                                <a
                                    href='<%# "ComplaintDetails.aspx?id=" + Eval("ComplaintID") %>'
                                    class="view-btn">View

                                    <span>→
                                    </span>

                                </a>

                            </td>

                        </tr>

                    </ItemTemplate>


                    <FooterTemplate>
                        </tbody>

                        </table>

                    </FooterTemplate>

                </asp:Repeater>


                <!-- NO DATA -->

                <asp:Panel
                    ID="pnlNoComplaints"
                    runat="server"
                    CssClass="no-complaints"
                    Visible="false">

                    <div class="no-complaints-icon">
                        📋
                    </div>

                    <h4>No complaints found
                    </h4>

                    <p>
                        Try changing your search or filter criteria.
                    </p>

                </asp:Panel>

            </div>



            <!-- =====================================
                 PAGINATION
            ====================================== -->

            <div class="table-footer">

                <span>

                    <asp:Label
                        ID="lblShowing"
                        runat="server"
                        Text="Showing 0 of 0 complaints">
                    </asp:Label>

                </span>


                <div class="pagination">

                    <asp:LinkButton
                        ID="btnPrevious"
                        runat="server"
                        CssClass="page-btn"
                        OnClick="btnPrevious_Click"
                        Text="←">
                    </asp:LinkButton>


                    <asp:Repeater
                        ID="rptPages"
                        runat="server"
                        OnItemCommand="rptPages_ItemCommand">

                        <ItemTemplate>

                            <asp:LinkButton
                                ID="btnPage"
                                runat="server"
                                CommandName="Page"
                                CommandArgument='<%# Eval("PageNumber") %>'
                                Text='<%# Eval("PageNumber") %>'
                                CssClass='<%# GetPageButtonClass(Eval("PageNumber")) %>'>
                            </asp:LinkButton>

                        </ItemTemplate>

                    </asp:Repeater>


                    <asp:LinkButton
                        ID="btnNext"
                        runat="server"
                        CssClass="page-btn"
                        OnClick="btnNext_Click"
                        Text="→">
                    </asp:LinkButton>

                </div>

            </div>


        </div>


    </div>


</asp:Content>
