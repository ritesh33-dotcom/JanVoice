<%@ Page Title="Manage Users"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageUsers.aspx.cs"
    Inherits="JanVoice.Admin.ManageUsers" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">
    <link href="../CSS/ManageUsers.css" rel="stylesheet" />
    
</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="manage-users-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="users-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Manage Users
                </h1>

                <p>
                    View and manage registered citizens across JanVoice.
                </p>

            </div>


            <div class="users-header-info">

                <span>
                    Citizen Accounts
                </span>

                <strong>
                    Active
                </strong>

            </div>

        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="user-stats">


            <div class="user-stat-card">

                <div class="user-stat-icon">
                    👥
                </div>

                <div>

                    <span>
                        Total Users
                    </span>

                  <strong>
    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
</strong>
                </div>

            </div>


            <div class="user-stat-card">

                <div class="user-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Active Users
                    </span>

                    <strong>
    <asp:Label ID="lblActiveUsers" runat="server" Text="0"></asp:Label>
</strong>

                </div>

            </div>


            <div class="user-stat-card">

                <div class="user-stat-icon inactive-icon">
                    ●
                </div>

                <div>

                    <span>
                        Inactive Users
                    </span>

                   <strong>
    <asp:Label ID="lblInactiveUsers" runat="server" Text="0"></asp:Label>
</strong>

                </div>

            </div>


            <div class="user-stat-card">

                <div class="user-stat-icon complaint-icon">
                    📋
                </div>

                <div>

                    <span>
                        Registered This Month
                    </span>

                   <strong>
    <asp:Label ID="lblRegisteredThisMonth" runat="server" Text="0"></asp:Label>
</strong>

                </div>

            </div>


        </div>



        <!-- =====================================
             SEARCH / FILTER
        ====================================== -->

        <div class="users-toolbar">


            <div class="user-search">

                <span>
                    🔍
                </span>

               <asp:TextBox
    ID="txtSearch"
    runat="server"
    CssClass="user-search-input"
    placeholder="Search by name or email...">
</asp:TextBox>

            </div>


            <asp:DropDownList
    ID="ddlWard"
    runat="server"
    CssClass="user-filter">
</asp:DropDownList>

                


           <asp:DropDownList
    ID="ddlStatus"
    runat="server"
    CssClass="user-filter">

    <asp:ListItem Text="All Status" Value="" />
    <asp:ListItem Text="Active" Value="1" />
    <asp:ListItem Text="Inactive" Value="0" />

</asp:DropDownList>


            <asp:Button
    ID="btnApplyFilters"
    runat="server"
    Text="Apply Filters"
    CssClass="filter-btn"
    OnClick="btnApplyFilters_Click" />


        </div>



        <!-- =====================================
             USERS TABLE
        ====================================== -->

        <div class="users-card">


            <div class="users-card-header">

                <div>

                    <h3>
                        Registered Citizens
                    </h3>

                    <p>
                        Citizens currently registered on JanVoice.
                    </p>

                </div>


               <span class="record-count">
    <asp:Label ID="lblRecordCount" runat="server" Text="0"></asp:Label>
    Users
</span>

            </div>


            <div class="users-table-wrapper">


                <table class="users-table">

                    <thead>

                        <tr>

                            <th>
                                USER
                            </th>

                            <th>
                                CONTACT
                            </th>

                            <th>
                                WARD
                            </th>

                            <th>
                                COMPLAINTS
                            </th>

                            <th>
                                REGISTERED
                            </th>

                            <th>
                                STATUS
                            </th>

                            <th>
                                ACTION
                            </th>

                        </tr>

                    </thead>


                    <tbody>
<asp:Repeater ID="rptUsers" runat="server">

    <ItemTemplate>

        <tr>

            <!-- USER -->

            <td>

                <div class="user-cell">

                    <div class="user-avatar">
                        <%# GetInitials(Eval("FullName").ToString()) %>
                    </div>

                    <div>

                        <strong>
                            <%# Eval("FullName") %>
                        </strong>

                        <span>
                            User ID: #<%# Eval("UserID") %>
                        </span>

                    </div>

                </div>

            </td>


            <!-- CONTACT -->

            <td>

                <div class="contact-cell">

                    <span>
                        <%# Eval("Email") %>
                    </span>

                    <small>
                        +91 <%# Eval("Mobile") %>
                    </small>

                </div>

            </td>


            <!-- WARD -->

            <td>
                <%# Eval("WardName") %>
            </td>


            <!-- COMPLAINTS -->

            <td>

                <strong class="complaint-count">
                    <%# Eval("ComplaintCount") %>
                </strong>

            </td>


            <!-- REGISTERED -->

            <td>
                <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>
            </td>


            <!-- STATUS -->

            <td>

                <span class='user-status <%# Convert.ToBoolean(Eval("IsActive")) ? "active" : "inactive" %>'>

                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>

                </span>

            </td>


            <!-- ACTION -->

            <td>

                <asp:HyperLink
                    ID="lnkViewUser"
                    runat="server"
                    CssClass="view-user-btn"
                    NavigateUrl='<%# "UserDetails.aspx?UserID=" + Eval("UserID") %>'
                    Text="View">
                </asp:HyperLink>

            </td>

        </tr>

    </ItemTemplate>

</asp:Repeater>

                    </tbody>

                </table>


            </div>


        </div>


    </div>


</asp:Content>