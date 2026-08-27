<%@ Page Title="Manage Wards"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageWards.aspx.cs"
    Inherits="JanVoice.Admin.ManageWards" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ManageWards.css"
        rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="manage-wards-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="wards-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Manage Wards
                </h1>

                <p>
                    Manage administrative wards and monitor civic activity.
                </p>

            </div>


            <div class="wards-header-action">

                <asp:Button
                    ID="btnAddWard"
                    runat="server"
                    Text="＋  Add New Ward"
                    CssClass="add-ward-btn"
                    CausesValidation="false"
                    OnClick="btnAddWard_Click" />

            </div>

        </div>



        <!-- =====================================
             MESSAGE
        ====================================== -->

        <asp:Panel
            ID="pnlMessage"
            runat="server"
            CssClass="ward-message"
            Visible="false">

            <asp:Label
                ID="lblMessage"
                runat="server">
            </asp:Label>

        </asp:Panel>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="ward-stats">


            <!-- TOTAL -->

            <div class="ward-stat-card">

                <div class="ward-stat-icon">
                    ◇
                </div>

                <div>

                    <span>
                        Total Wards
                    </span>

                    <strong>

                        <asp:Label
                            ID="lblTotalWards"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </strong>

                    <small>
                        Registered wards
                    </small>

                </div>

            </div>



            <!-- ACTIVE -->

            <div class="ward-stat-card">

                <div class="ward-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Active Wards
                    </span>

                    <strong>

                        <asp:Label
                            ID="lblActiveWards"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </strong>

                    <small>
                        Currently active
                    </small>

                </div>

            </div>



            <!-- OFFICERS -->

            <div class="ward-stat-card">

                <div class="ward-stat-icon officer-icon">
                    👨‍💼
                </div>

                <div>

                    <span>
                        Assigned Officers
                    </span>

                    <strong>

                        <asp:Label
                            ID="lblAssignedOfficers"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </strong>

                    <small>
                        Across all wards
                    </small>

                </div>

            </div>



            <!-- COMPLAINTS -->

            <div class="ward-stat-card">

                <div class="ward-stat-icon complaint-icon">
                    📋
                </div>

                <div>

                    <span>
                        Total Complaints
                    </span>

                    <strong>

                        <asp:Label
                            ID="lblTotalComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>

                    </strong>

                    <small>
                        Reported across wards
                    </small>

                </div>

            </div>


        </div>



        <!-- =====================================
             SEARCH / FILTER
        ====================================== -->

        <div class="wards-toolbar">


            <!-- SEARCH -->

            <div class="ward-search">

                <span>
                    🔍
                </span>

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="ward-search-input"
                    placeholder="Search by ward name or number...">
                </asp:TextBox>

            </div>



            <!-- STATUS -->

            <asp:DropDownList
                ID="ddlStatus"
                runat="server"
                CssClass="ward-filter">

                <asp:ListItem
                    Text="All Status"
                    Value="" />

                <asp:ListItem
                    Text="Active"
                    Value="1" />

                <asp:ListItem
                    Text="Inactive"
                    Value="0" />

            </asp:DropDownList>



            <!-- APPLY -->

            <asp:Button
                ID="btnApplyFilters"
                runat="server"
                Text="Apply Filters"
                CssClass="filter-btn"
                CausesValidation="false"
                OnClick="btnApplyFilters_Click" />

        </div>



        <!-- =====================================
             WARDS CARD
        ====================================== -->

        <div class="wards-card">


            <!-- CARD HEADER -->

            <div class="wards-card-header">

                <div>

                    <h3>
                        Registered Wards
                    </h3>

                    <p>
                        Administrative wards configured in JanVoice.
                    </p>

                </div>


                <span class="record-count">

                    <asp:Label
                        ID="lblRecordCount"
                        runat="server"
                        Text="0">
                    </asp:Label>

                    Wards

                </span>

            </div>



            <!-- =====================================
                 TABLE
            ====================================== -->

            <div class="wards-table-wrapper">

                <table class="wards-table">

                    <thead>

                        <tr>

                            <th>
                                WARD
                            </th>

                            <th>
                                WARD NUMBER
                            </th>

                            <th>
                                OFFICERS
                            </th>

                            <th>
                                COMPLAINTS
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

                        <asp:Repeater
                            ID="rptWards"
                            runat="server"
                            OnItemCommand="rptWards_ItemCommand">

                            <ItemTemplate>

                                <tr>


                                    <!-- WARD -->

                                    <td>

                                        <div class="ward-cell">

                                            <div class='ward-icon <%# GetWardIconClass(Eval("WardNumber")) %>'>

                                                <%#
                                                    GetWardIcon(
                                                        Eval("WardNumber")
                                                    )
                                                %>

                                            </div>


                                            <div class="ward-info">

                                                <strong>

                                                    <%#
                                                        Server.HtmlEncode(
                                                            Eval("WardName").ToString()
                                                        )
                                                    %>

                                                </strong>


                                                <span>

                                                    <%#
                                                        Eval("Description") == DBNull.Value
                                                        ||
                                                        string.IsNullOrWhiteSpace(
                                                            Eval("Description").ToString()
                                                        )
                                                        ? "Ward administrative area"
                                                        : Server.HtmlEncode(
                                                            Eval("Description").ToString()
                                                        )
                                                    %>

                                                </span>

                                            </div>

                                        </div>

                                    </td>



                                    <!-- WARD NUMBER -->

                                    <td>

                                        <span class="ward-number">

                                            <%#
                                                Eval("WardNumber")
                                            %>

                                        </span>

                                    </td>



                                    <!-- OFFICERS -->

                                    <td>

                                        <strong class="ward-count">

                                            <%#
                                                Eval("OfficerCount")
                                            %>

                                        </strong>

                                    </td>



                                    <!-- COMPLAINTS -->

                                    <td>

                                        <strong class="complaint-count">

                                            <%#
                                                Eval("ComplaintCount")
                                            %>

                                        </strong>

                                    </td>



                                    <!-- STATUS -->

                                    <td>

                                        <span class='ward-status
                                            <%#
                                                Convert.ToBoolean(
                                                    Eval("IsActive")
                                                )
                                                ? "active"
                                                : "inactive"
                                            %>'>

                                            <%#
                                                Convert.ToBoolean(
                                                    Eval("IsActive")
                                                )
                                                ? "Active"
                                                : "Inactive"
                                            %>

                                        </span>

                                    </td>



                                    <!-- ACTION -->

                                    <td>

                                        <div class="ward-actions">


                                            <!-- VIEW -->

                                            <asp:LinkButton
                                                ID="btnView"
                                                runat="server"
                                                CssClass="ward-action view"
                                                CommandName="ViewWard"
                                                CommandArgument='<%# Eval("WardID") %>'
                                                CausesValidation="false">

                                                View

                                            </asp:LinkButton>



                                            <!-- EDIT -->

                                            <asp:LinkButton
                                                ID="btnEdit"
                                                runat="server"
                                                CssClass="ward-action edit"
                                                CommandName="EditWard"
                                                CommandArgument='<%# Eval("WardID") %>'
                                                CausesValidation="false">

                                                Edit

                                            </asp:LinkButton>



                                            <!-- TOGGLE -->

                                            <asp:LinkButton
                                                ID="btnToggle"
                                                runat="server"
                                                CssClass='<%#
                                                    Convert.ToBoolean(
                                                        Eval("IsActive")
                                                    )
                                                    ? "ward-action deactivate"
                                                    : "ward-action activate"
                                                %>'
                                                CommandName="ToggleWard"
                                                CommandArgument='<%# Eval("WardID") %>'
                                                CausesValidation="false">

                                                <%#
                                                    Convert.ToBoolean(
                                                        Eval("IsActive")
                                                    )
                                                    ? "Deactivate"
                                                    : "Activate"
                                                %>

                                            </asp:LinkButton>



                                            <!-- DELETE -->

                                            <asp:LinkButton
                                                ID="btnDelete"
                                                runat="server"
                                                CssClass="ward-action delete"
                                                CommandName="DeleteWard"
                                                CommandArgument='<%# Eval("WardID") %>'
                                                CausesValidation="false"
                                                OnClientClick="return confirm('Are you sure you want to delete this ward?');">

                                                Delete

                                            </asp:LinkButton>


                                        </div>

                                    </td>


                                </tr>

                            </ItemTemplate>

                        </asp:Repeater>



                        <!-- EMPTY STATE -->

                        <asp:Panel
                            ID="pnlEmpty"
                            runat="server"
                            Visible="false">

                            <tr>

                                <td colspan="6">

                                    <div class="wards-empty">

                                        <div>
                                            ◇
                                        </div>

                                        <h4>
                                            No Wards Found
                                        </h4>

                                        <p>
                                            No wards match your current search or filter.
                                        </p>

                                    </div>

                                </td>

                            </tr>

                        </asp:Panel>


                    </tbody>

                </table>

            </div>

        </div>



        <!-- =====================================
             ADD / EDIT WARD MODAL
        ====================================== -->

        <asp:Panel
            ID="pnlWardModal"
            runat="server"
            CssClass="ward-modal-overlay"
            Visible="false">


            <div class="ward-modal">


                <!-- HEADER -->

                <div class="ward-modal-header">

                    <div>

                        <span>
                            JANVOICE ADMINISTRATION
                        </span>

                        <h2>

                            <asp:Label
                                ID="lblModalTitle"
                                runat="server"
                                Text="Add New Ward">
                            </asp:Label>

                        </h2>

                    </div>


                    <asp:LinkButton
                        ID="btnCloseModal"
                        runat="server"
                        CssClass="modal-close-btn"
                        CausesValidation="false"
                        OnClick="btnCloseModal_Click">

                        ×

                    </asp:LinkButton>

                </div>



                <!-- BODY -->

                <div class="ward-modal-body">


                    <asp:HiddenField
                        ID="hfWardID"
                        runat="server"
                        Value="0" />



                    <!-- WARD NUMBER -->

                    <div class="form-group">

                        <label>
                            Ward Number
                            <span>*</span>
                        </label>

                        <asp:TextBox
                            ID="txtWardNumber"
                            runat="server"
                            CssClass="ward-form-input"
                            MaxLength="10"
                            placeholder="e.g. 01">
                        </asp:TextBox>

                    </div>



                    <!-- WARD NAME -->

                    <div class="form-group">

                        <label>
                            Ward Name
                            <span>*</span>
                        </label>

                        <asp:TextBox
                            ID="txtWardName"
                            runat="server"
                            CssClass="ward-form-input"
                            MaxLength="100"
                            placeholder="e.g. Central Ward">
                        </asp:TextBox>

                    </div>



                    <!-- DESCRIPTION -->

                    <div class="form-group">

                        <label>
                            Description
                        </label>

                        <asp:TextBox
                            ID="txtWardDescription"
                            runat="server"
                            CssClass="ward-form-input ward-textarea"
                            TextMode="MultiLine"
                            Rows="4"
                            MaxLength="250"
                            placeholder="Describe the administrative area covered by this ward...">
                        </asp:TextBox>

                    </div>



                    <!-- STATUS -->

                    <div
                        id="wardStatusGroup"
                        runat="server"
                        class="form-group">

                        <label>
                            Status
                        </label>

                        <asp:DropDownList
                            ID="ddlModalStatus"
                            runat="server"
                            CssClass="ward-form-input">

                            <asp:ListItem
                                Text="Active"
                                Value="1" />

                            <asp:ListItem
                                Text="Inactive"
                                Value="0" />

                        </asp:DropDownList>

                    </div>


                </div>



                <!-- FOOTER -->

                <div class="ward-modal-footer">

                    <asp:Button
                        ID="btnCancelModal"
                        runat="server"
                        Text="Cancel"
                        CssClass="modal-cancel-btn"
                        CausesValidation="false"
                        OnClick="btnCloseModal_Click" />


                    <asp:Button
                        ID="btnSaveWard"
                        runat="server"
                        Text="Save Ward"
                        CssClass="modal-save-btn"
                        CausesValidation="false"
                        OnClick="btnSaveWard_Click" />

                </div>


            </div>

        </asp:Panel>



        <!-- =====================================
             VIEW WARD MODAL
        ====================================== -->

        <asp:Panel
            ID="pnlViewModal"
            runat="server"
            CssClass="ward-modal-overlay"
            Visible="false">


            <div class="ward-modal view-modal">


                <!-- HEADER -->

                <div class="ward-modal-header">

                    <div>

                        <span>
                            WARD DETAILS
                        </span>

                        <h2>

                            <asp:Label
                                ID="lblViewWardName"
                                runat="server">
                            </asp:Label>

                        </h2>

                    </div>


                    <asp:LinkButton
                        ID="btnCloseViewModal"
                        runat="server"
                        CssClass="modal-close-btn"
                        CausesValidation="false"
                        OnClick="btnCloseViewModal_Click">

                        ×

                    </asp:LinkButton>

                </div>



                <!-- BODY -->

                <div class="ward-view-body">


                    <div class="view-ward-icon">

                        <asp:Label
                            ID="lblViewWardIcon"
                            runat="server">
                        </asp:Label>

                    </div>



                    <div class="view-ward-info">


                        <!-- WARD ID -->

                        <div class="view-info-item">

                            <span>
                                Ward ID
                            </span>

                            <strong>

                                #<asp:Label
                                    ID="lblViewWardID"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- WARD NUMBER -->

                        <div class="view-info-item">

                            <span>
                                Ward Number
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewWardNumber"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- STATUS -->

                        <div class="view-info-item">

                            <span>
                                Status
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewStatus"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- CREATED -->

                        <div class="view-info-item">

                            <span>
                                Created
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewCreatedDate"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- OFFICERS -->

                        <div class="view-info-item">

                            <span>
                                Assigned Officers
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewOfficerCount"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>



                        <!-- COMPLAINTS -->

                        <div class="view-info-item">

                            <span>
                                Total Complaints
                            </span>

                            <strong>

                                <asp:Label
                                    ID="lblViewComplaintCount"
                                    runat="server">
                                </asp:Label>

                            </strong>

                        </div>


                    </div>



                    <!-- DESCRIPTION -->

                    <div class="view-description">

                        <span>
                            DESCRIPTION
                        </span>

                        <p>

                            <asp:Label
                                ID="lblViewDescription"
                                runat="server">
                            </asp:Label>

                        </p>

                    </div>


                </div>



                <!-- FOOTER -->

                <div class="ward-modal-footer">

                    <asp:Button
                        ID="btnCloseView"
                        runat="server"
                        Text="Close"
                        CssClass="modal-cancel-btn"
                        CausesValidation="false"
                        OnClick="btnCloseViewModal_Click" />

                </div>


            </div>

        </asp:Panel>


    </div>

</asp:Content>