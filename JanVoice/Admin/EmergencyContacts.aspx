<%@ Page Title="Emergency Contacts"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="EmergencyContacts.aspx.cs"
    Inherits="JanVoice.Admin.EmergencyContacts" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/EmergencyContacts.css"
        rel="stylesheet" />
    <style>
        


/*==========================================
        MODAL
==========================================*/

.modal-overlay {
    position: fixed;
    z-index: 9999;
    inset: 0;
    padding: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(2,6,23,.78);
    backdrop-filter: blur(8px);
}

.contact-modal {
    width: 100%;
    max-width: 620px;
    max-height: 90vh;
    overflow-y: auto;
    background: #1E293B;
    border: 1px solid rgba(255,255,255,.10);
    border-radius: 20px;
    box-shadow: 0 30px 80px rgba(0,0,0,.45);
}

.modal-header {
    padding: 22px 24px;
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 20px;
    border-bottom: 1px solid rgba(255,255,255,.07);
}

.modal-label {
    color: #38BDF8;
    font-size: 9px;
    font-weight: 700;
    letter-spacing: 1.7px;
}

.modal-header h2 {
    margin: 6px 0 0;
    color: #F8FAFC;
    font-size: 21px;
}

.modal-close {
    width: 34px;
    height: 34px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 9px;
    background: rgba(255,255,255,.05);
    color: #94A3B8;
    text-decoration: none;
    font-size: 22px;
    transition: .25s;
}

    .modal-close:hover {
        background: rgba(239,68,68,.12);
        color: #F87171;
    }

.modal-body {
    padding: 24px;
}

.form-group {
    margin-bottom: 18px;
}

    .form-group label {
        display: block;
        margin-bottom: 7px;
        color: #CBD5E1;
        font-size: 11px;
        font-weight: 600;
    }

        .form-group label span {
            color: #F87171;
        }

.form-control {
    width: 100%;
    box-sizing: border-box;
    min-height: 42px;
    padding: 10px 12px;
    border: 1px solid rgba(255,255,255,.09);
    border-radius: 10px;
    outline: none;
    background: #0F172A;
    color: #E2E8F0;
    font-family: inherit;
    font-size: 12px;
}

    .form-control:focus {
        border-color: rgba(59,130,246,.55);
        box-shadow: 0 0 0 3px rgba(59,130,246,.08);
    }

.textarea-control {
    resize: vertical;
    min-height: 80px;
}

.checkbox-row {
    padding: 13px;
    margin-bottom: 18px;
    border-radius: 11px;
    background: rgba(59,130,246,.05);
    border: 1px solid rgba(59,130,246,.10);
}

    .checkbox-row input {
        margin-right: 8px;
    }

    .checkbox-row label {
        color: #CBD5E1;
        font-size: 12px;
    }

    .checkbox-row span {
        display: block;
        margin: 6px 0 0 23px;
        color: #64748B;
        font-size: 10px;
    }

.modal-footer {
    padding: 17px 24px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 10px;
    border-top: 1px solid rgba(255,255,255,.07);
}

.cancel-btn,
.save-contact-btn {
    height: 40px;
    padding: 0 18px;
    border-radius: 9px;
    font-family: inherit;
    font-size: 11px;
    font-weight: 600;
    cursor: pointer;
}

.cancel-btn {
    border: 1px solid rgba(255,255,255,.09);
    background: rgba(255,255,255,.04);
    color: #94A3B8;
}

    .cancel-btn:hover {
        background: rgba(255,255,255,.08);
        color: #E2E8F0;
    }

.save-contact-btn {
    border: none;
    background: linear-gradient(135deg,#EF4444,#DC2626);
    color: white;
}

    .save-contact-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 8px 20px rgba(239,68,68,.25);
    }



/*==========================================
        VIEW MODAL
==========================================*/

.view-modal {
    max-width: 650px;
}

.view-body {
    padding: 24px;
}

.view-contact-top {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 16px;
    margin-bottom: 20px;
    border-radius: 14px;
    background: rgba(15,23,42,.45);
    border: 1px solid rgba(255,255,255,.06);
}

.view-contact-icon {
    width: 52px;
    height: 52px;
    flex-shrink: 0;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(239,68,68,.12);
    color: #F87171;
    font-size: 22px;
}

    .view-contact-icon.medical {
        background: rgba(34,197,94,.12);
        color: #4ADE80;
    }

    .view-contact-icon.fire {
        background: rgba(245,158,11,.12);
        color: #FBBF24;
    }

    .view-contact-icon.other {
        background: rgba(168,85,247,.12);
        color: #C084FC;
    }

.view-contact-top h3 {
    margin: 0 0 5px;
    color: #F8FAFC;
    font-size: 17px;
}

.view-contact-top span {
    color: #64748B;
    font-size: 11px;
}

.view-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
}

.view-item {
    padding: 14px;
    border-radius: 11px;
    background: rgba(15,23,42,.40);
    border: 1px solid rgba(255,255,255,.05);
}

    .view-item.full {
        grid-column: 1 / -1;
    }

    .view-item span {
        display: block;
        margin-bottom: 6px;
        color: #64748B;
        font-size: 9px;
        font-weight: 700;
        letter-spacing: 1px;
    }

    .view-item strong {
        color: #CBD5E1;
        font-size: 12px;
        line-height: 1.5;
        word-break: break-word;
    }

.view-phone {
    color: #F8FAFC !important;
    font-size: 15px !important;
}

.view-status.active {
    color: #4ADE80;
}

.view-status.inactive {
    color: #F87171;
}

    </style>
</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="emergency-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="emergency-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Emergency Contacts
                </h1>

                <p>
                    Manage important emergency contacts available to citizens.
                </p>

            </div>


            <div class="emergency-header-info">

                <span>
                    PUBLIC SAFETY
                </span>

                <strong>
                    Emergency Directory
                </strong>

            </div>

        </div>



        <!-- =====================================
             MESSAGE
        ====================================== -->

        <asp:Panel ID="pnlMessage"
            runat="server"
            Visible="false"
            CssClass="emergency-message">

            <asp:Label ID="lblMessage"
                runat="server">
            </asp:Label>

        </asp:Panel>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="emergency-stats">


            <!-- TOTAL -->

            <div class="emergency-stat-card">

                <div class="emergency-stat-icon">
                    ☎
                </div>

                <div>

                    <span>
                        Total Contacts
                    </span>

                    <asp:Label ID="lblTotalContacts"
                        runat="server"
                        CssClass="stat-number">
                        0
                    </asp:Label>

                </div>

            </div>



            <!-- ACTIVE -->

            <div class="emergency-stat-card">

                <div class="emergency-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Active Contacts
                    </span>

                    <asp:Label ID="lblActiveContacts"
                        runat="server"
                        CssClass="stat-number">
                        0
                    </asp:Label>

                </div>

            </div>



            <!-- DEPARTMENTS -->

            <div class="emergency-stat-card">

                <div class="emergency-stat-icon department-icon">
                    ✚
                </div>

                <div>

                    <span>
                        Departments
                    </span>

                    <asp:Label ID="lblDepartments"
                        runat="server"
                        CssClass="stat-number">
                        0
                    </asp:Label>

                </div>

            </div>



            <!-- RECENT -->

            <div class="emergency-stat-card">

                <div class="emergency-stat-icon update-icon">
                    ◷
                </div>

                <div>

                    <span>
                        Added Last 30 Days
                    </span>

                    <asp:Label ID="lblRecentContacts"
                        runat="server"
                        CssClass="stat-number">
                        0
                    </asp:Label>

                </div>

            </div>


        </div>



        <!-- =====================================
             TOOLBAR
        ====================================== -->

        <div class="emergency-toolbar">


            <!-- SEARCH -->

            <div class="emergency-search">

                <span>
                    🔍
                </span>

                <asp:TextBox ID="txtSearch"
                    runat="server"
                    CssClass="emergency-search-input"
                    placeholder="Search department, person or phone...">
                </asp:TextBox>

            </div>



            <!-- CATEGORY -->

            <asp:DropDownList ID="ddlCategory"
                runat="server"
                CssClass="emergency-filter">

                <asp:ListItem Text="All Categories"
                    Value="">
                </asp:ListItem>

                <asp:ListItem Text="Police"
                    Value="Police">
                </asp:ListItem>

                <asp:ListItem Text="Medical"
                    Value="Medical">
                </asp:ListItem>

                <asp:ListItem Text="Fire &amp; Rescue"
                    Value="Fire">
                </asp:ListItem>

                <asp:ListItem Text="Other"
                    Value="Other">
                </asp:ListItem>

            </asp:DropDownList>



            <!-- STATUS -->

            <asp:DropDownList ID="ddlStatus"
                runat="server"
                CssClass="emergency-filter">

                <asp:ListItem Text="All Status"
                    Value="">
                </asp:ListItem>

                <asp:ListItem Text="Active"
                    Value="1">
                </asp:ListItem>

                <asp:ListItem Text="Inactive"
                    Value="0">
                </asp:ListItem>

            </asp:DropDownList>



            <!-- APPLY -->

            <asp:Button ID="btnApplyFilters"
                runat="server"
                Text="Apply Filters"
                CssClass="filter-btn"
                OnClick="btnApplyFilters_Click" />



            <!-- ADD -->

            <asp:Button ID="btnAddContact"
                runat="server"
                Text="+ Add Contact"
                CssClass="add-contact-btn"
                OnClick="btnAddContact_Click" />

        </div>



        <!-- =====================================
             MAIN CARD
        ====================================== -->

        <div class="emergency-card">


            <!-- CARD HEADER -->

            <div class="emergency-card-header">

                <div>

                    <h3>
                        Emergency Directory
                    </h3>

                    <p>
                        Emergency information displayed to JanVoice citizens.
                    </p>

                </div>


                <span class="record-count">

                    <asp:Label ID="lblRecordCount"
                        runat="server">
                        0
                    </asp:Label>

                    Contacts

                </span>

            </div>



            <!-- =================================
                 TABLE
            ================================== -->

            <div class="emergency-table-wrapper">


                <asp:Repeater ID="rptContacts"
                    runat="server"
                    OnItemCommand="rptContacts_ItemCommand">


                    <HeaderTemplate>

                        <table class="emergency-table">

                            <thead>

                                <tr>

                                    <th>
                                        CONTACT
                                    </th>

                                    <th>
                                        CATEGORY
                                    </th>

                                    <th>
                                        PHONE
                                    </th>

                                    <th>
                                        DETAILS
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

                    </HeaderTemplate>



                    <ItemTemplate>

                        <tr>


                            <!-- CONTACT -->

                            <td>

                                <div class="contact-cell">


                                    <div class='contact-icon <%# GetContactIconClass(Eval("DepartmentName")) %>'>

                                        <%# GetContactIcon(Eval("DepartmentName")) %>

                                    </div>


                                    <div class="contact-info">

                                        <strong>
                                            <%# Eval("DepartmentName") %>
                                        </strong>

                                        <span>

                                            <%# GetContactPerson(Eval("ContactPerson")) %>

                                        </span>

                                    </div>

                                </div>

                            </td>



                            <!-- CATEGORY -->

                            <td>

                                <span class='category-badge <%# GetCategoryClass(Eval("DepartmentName")) %>'>

                                    <%# GetCategory(Eval("DepartmentName")) %>

                                </span>

                            </td>



                            <!-- PHONE -->

                            <td>

                                <strong class="phone-number">

                                    <%# Eval("PhoneNumber") %>

                                </strong>

                            </td>



                            <!-- DETAILS -->

                            <td>

                                <div class="details-cell">

                                    <span class="email-text">

                                        <%# GetDisplayValue(Eval("Email")) %>

                                    </span>

                                    <span class="address-text">

                                        <%# GetDisplayAddress(Eval("Address")) %>

                                    </span>

                                </div>

                            </td>



                            <!-- STATUS -->

                            <td>

                                <span class='contact-status <%# GetStatusClass(Eval("IsActive")) %>'>

                                    <%# GetStatusText(Eval("IsActive")) %>

                                </span>

                                <span class="availability-text">

                                    <%# GetAvailabilityText(Eval("IsAvailable24x7")) %>

                                </span>

                            </td>



                            <!-- ACTIONS -->

                            <td>

                                <div class="contact-actions">


                                    <!-- VIEW -->

                                    <asp:LinkButton
                                        ID="btnView"
                                        runat="server"
                                        CommandName="ViewContact"
                                        CommandArgument='<%# Eval("ContactID") %>'
                                        CssClass="view-contact-btn">

                                        View

                                    </asp:LinkButton>



                                    <!-- EDIT -->

                                    <asp:LinkButton
                                        ID="btnEdit"
                                        runat="server"
                                        CommandName="EditContact"
                                        CommandArgument='<%# Eval("ContactID") %>'
                                        CssClass="edit-contact-btn">

                                        Edit

                                    </asp:LinkButton>



                                    <!-- TOGGLE -->

                                    <asp:LinkButton
                                        ID="btnToggle"
                                        runat="server"
                                        CommandName="ToggleContact"
                                        CommandArgument='<%# Eval("ContactID") %>'
                                        CssClass="toggle-contact-btn"
                                        OnClientClick="return confirm('Are you sure you want to change this contact status?');">

                                        <%# GetToggleText(Eval("IsActive")) %>

                                    </asp:LinkButton>



                                    <!-- DELETE -->

                                    <asp:LinkButton
                                        ID="btnDelete"
                                        runat="server"
                                        CommandName="DeleteContact"
                                        CommandArgument='<%# Eval("ContactID") %>'
                                        CssClass="delete-contact-btn"
                                        OnClientClick="return confirm('Are you sure you want to permanently remove this emergency contact?');">

                                        Remove

                                    </asp:LinkButton>

                                </div>

                            </td>


                        </tr>

                    </ItemTemplate>



                    <FooterTemplate>

                            </tbody>

                        </table>

                    </FooterTemplate>


                </asp:Repeater>



                <!-- EMPTY STATE -->

                <asp:Panel ID="pnlEmpty"
                    runat="server"
                    Visible="false"
                    CssClass="empty-state">

                    <div class="empty-icon">
                        ☎
                    </div>

                    <h3>
                        No Emergency Contacts Found
                    </h3>

                    <p>
                        No contacts match the selected search or filter criteria.
                    </p>

                </asp:Panel>


            </div>


        </div>


    </div>



    <!-- ==========================================
         ADD / EDIT MODAL
    =========================================== -->

    <asp:Panel ID="pnlContactModal"
        runat="server"
        Visible="false"
        CssClass="modal-overlay">


        <div class="contact-modal">


            <!-- MODAL HEADER -->

            <div class="modal-header">

                <div>

                    <span class="modal-label">
                        EMERGENCY DIRECTORY
                    </span>

                    <h2>

                        <asp:Label ID="lblModalTitle"
                            runat="server"
                            Text="Add Emergency Contact">
                        </asp:Label>

                    </h2>

                </div>


                <asp:LinkButton ID="btnCloseModal"
                    runat="server"
                    CssClass="modal-close"
                    OnClick="btnCloseModal_Click">

                    ×

                </asp:LinkButton>

            </div>



            <!-- FORM -->

            <div class="modal-body">


                <asp:HiddenField ID="hfContactID"
                    runat="server"
                    Value="0" />



                <!-- DEPARTMENT -->

                <div class="form-group">

                    <label>
                        Department Name
                        <span>*</span>
                    </label>

                    <asp:TextBox ID="txtDepartmentName"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="150"
                        placeholder="e.g. Police Department">
                    </asp:TextBox>

                </div>



                <!-- CONTACT PERSON -->

                <div class="form-group">

                    <label>
                        Contact Person
                    </label>

                    <asp:TextBox ID="txtContactPerson"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="100"
                        placeholder="Enter contact person's name">
                    </asp:TextBox>

                </div>



                <!-- PHONE -->

                <div class="form-group">

                    <label>
                        Phone Number
                        <span>*</span>
                    </label>

                    <asp:TextBox ID="txtPhoneNumber"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="20"
                        placeholder="e.g. 100 or 108">
                    </asp:TextBox>

                </div>



                <!-- EMAIL -->

                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <asp:TextBox ID="txtEmail"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="150"
                        placeholder="department@example.com">
                    </asp:TextBox>

                </div>



                <!-- ADDRESS -->

                <div class="form-group">

                    <label>
                        Address
                    </label>

                    <asp:TextBox ID="txtAddress"
                        runat="server"
                        CssClass="form-control textarea-control"
                        TextMode="MultiLine"
                        Rows="3"
                        MaxLength="500"
                        placeholder="Enter department address">
                    </asp:TextBox>

                </div>



                <!-- 24x7 -->

                <div class="checkbox-row">

                    <asp:CheckBox ID="chk24x7"
                        runat="server"
                        Text="Available 24x7" />

                    <span>
                        Citizens can contact this service at any time.
                    </span>

                </div>



                <!-- STATUS -->

                <asp:Panel ID="pnlModalStatus"
                    runat="server"
                    CssClass="form-group">

                    <label>
                        Status
                    </label>

                    <asp:DropDownList ID="ddlModalStatus"
                        runat="server"
                        CssClass="form-control">

                        <asp:ListItem Text="Active"
                            Value="1">
                        </asp:ListItem>

                        <asp:ListItem Text="Inactive"
                            Value="0">
                        </asp:ListItem>

                    </asp:DropDownList>

                </asp:Panel>


            </div>



            <!-- MODAL FOOTER -->

            <div class="modal-footer">

                <asp:Button ID="btnCancelModal"
                    runat="server"
                    Text="Cancel"
                    CssClass="cancel-btn"
                    OnClick="btnCloseModal_Click" />

                <asp:Button ID="btnSaveContact"
                    runat="server"
                    Text="Save Contact"
                    CssClass="save-contact-btn"
                    OnClick="btnSaveContact_Click" />

            </div>


        </div>

    </asp:Panel>



    <!-- ==========================================
         VIEW MODAL
    =========================================== -->

    <asp:Panel ID="pnlViewModal"
        runat="server"
        Visible="false"
        CssClass="modal-overlay">


        <div class="contact-modal view-modal">


            <!-- HEADER -->

            <div class="modal-header">

                <div>

                    <span class="modal-label">
                        EMERGENCY CONTACT
                    </span>

                    <h2>
                        Contact Details
                    </h2>

                </div>


                <asp:LinkButton ID="btnCloseViewModal"
                    runat="server"
                    CssClass="modal-close"
                    OnClick="btnCloseViewModal_Click">

                    ×

                </asp:LinkButton>

            </div>



            <!-- VIEW BODY -->

            <div class="view-body">


                <div class="view-contact-top">

                    <div id="viewIcon"
                        runat="server"
                        class="view-contact-icon">

                        ☎

                    </div>

                    <div>

                        <h3>

                            <asp:Label ID="lblViewDepartment"
                                runat="server">
                            </asp:Label>

                        </h3>

                        <span>

                            <asp:Label ID="lblViewCategory"
                                runat="server">
                            </asp:Label>

                        </span>

                    </div>

                </div>



                <div class="view-grid">


                    <div class="view-item">

                        <span>
                            CONTACT PERSON
                        </span>

                        <strong>

                            <asp:Label ID="lblViewContactPerson"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>



                    <div class="view-item">

                        <span>
                            PHONE NUMBER
                        </span>

                        <strong class="view-phone">

                            <asp:Label ID="lblViewPhone"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>



                    <div class="view-item">

                        <span>
                            EMAIL
                        </span>

                        <strong>

                            <asp:Label ID="lblViewEmail"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>



                    <div class="view-item">

                        <span>
                            STATUS
                        </span>

                        <strong>

                            <asp:Label ID="lblViewStatus"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>



                    <div class="view-item full">

                        <span>
                            AVAILABILITY
                        </span>

                        <strong>

                            <asp:Label ID="lblViewAvailability"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>



                    <div class="view-item full">

                        <span>
                            ADDRESS
                        </span>

                        <strong>

                            <asp:Label ID="lblViewAddress"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>



                    <div class="view-item">

                        <span>
                            CONTACT ID
                        </span>

                        <strong>

                            <asp:Label ID="lblViewID"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>



                    <div class="view-item">

                        <span>
                            CREATED DATE
                        </span>

                        <strong>

                            <asp:Label ID="lblViewCreatedDate"
                                runat="server">
                            </asp:Label>

                        </strong>

                    </div>


                </div>


            </div>



            <div class="modal-footer">

                <asp:Button ID="btnCloseView"
                    runat="server"
                    Text="Close"
                    CssClass="cancel-btn"
                    OnClick="btnCloseViewModal_Click" />

            </div>


        </div>

    </asp:Panel>


</asp:Content>