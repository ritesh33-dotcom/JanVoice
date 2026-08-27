<%@ Page Title="Manage Officers"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageOfficers.aspx.cs"
    Inherits="JanVoice.Admin.ManageOfficers" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ManageOfficers.css" rel="stylesheet" />
    <style>
        

/* ADD OFFICER BUTTON */

.add-officer-btn {
    height: 44px;
    padding: 0 17px;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    border: none;
    border-radius: 11px;
    background: linear-gradient( 135deg, #3B82F6, #2563EB );
    color: #FFFFFF;
    font-family: inherit;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: .25s;
    margin-top:1rem;
}

    .add-officer-btn span {
        font-size: 20px;
        line-height: 1;
    }

    .add-officer-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(59,130,246,.25);
    }

/*==========================================
        ADD OFFICER MODAL
==========================================*/

.officer-modal {
    position: fixed;
    inset: 0;
    z-index: 9999;
    display: none;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

    .officer-modal.show {
        display: flex;
    }

.officer-modal-overlay {
    position: absolute;
    inset: 0;
    background: rgba(2,6,23,.78);
    backdrop-filter: blur(5px);
}

.officer-modal-card {
    position: relative;
    z-index: 2;
    width: 100%;
    max-width: 560px;
    max-height: 90vh;
    overflow-y: auto;
    background: #1E293B;
    border: 1px solid rgba(255,255,255,.10);
    border-radius: 20px;
    box-shadow: 0 30px 80px rgba(0,0,0,.45);
}


/* MODAL HEADER */

.officer-modal-header {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    padding: 24px 25px 20px;
    border-bottom: 1px solid rgba(255,255,255,.07);
}

    .officer-modal-header span {
        color: #38BDF8;
        font-size: 9px;
        font-weight: 700;
        letter-spacing: 1.8px;
    }

    .officer-modal-header h2 {
        margin: 7px 0;
        color: #F8FAFC;
        font-size: 21px;
    }

    .officer-modal-header p {
        margin: 0;
        color: #64748B;
        font-size: 12px;
    }

.modal-close-btn {
    width: 32px;
    height: 32px;
    border: none;
    border-radius: 8px;
    background: rgba(255,255,255,.05);
    color: #94A3B8;
    font-size: 22px;
    cursor: pointer;
}

    .modal-close-btn:hover {
        background: rgba(239,68,68,.12);
        color: #F87171;
    }


/* FORM */

.officer-form {
    padding: 22px 25px 25px;
}

.form-group {
    margin-bottom: 17px;
}

    .form-group label {
        display: block;
        margin-bottom: 7px;
        color: #CBD5E1;
        font-size: 12px;
        font-weight: 600;
    }

.form-control {
    width: 100%;
    height: 43px;
    box-sizing: border-box;
    padding: 0 13px;
    border: 1px solid rgba(255,255,255,.08);
    border-radius: 9px;
    outline: none;
    background: rgba(15,23,42,.65);
    color: #E2E8F0;
    font-family: inherit;
    font-size: 13px;
}

    .form-control:focus {
        border-color: rgba(59,130,246,.55);
        box-shadow: 0 0 0 3px rgba(59,130,246,.08);
    }

    .form-control::placeholder {
        color: #64748B;
    }


/* VALIDATION */

.field-error {
    display: block;
    margin-top: 5px;
    color: #F87171;
    font-size: 10px;
}


/* FORM ACTIONS */

.officer-form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 22px;
    padding-top: 18px;
    border-top: 1px solid rgba(255,255,255,.06);
}

.modal-cancel-btn {
    height: 41px;
    padding: 0 17px;
    border: 1px solid rgba(255,255,255,.08);
    border-radius: 9px;
    background: rgba(255,255,255,.04);
    color: #94A3B8;
    font-family: inherit;
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
}

    .modal-cancel-btn:hover {
        background: rgba(255,255,255,.08);
        color: #E2E8F0;
    }

.modal-submit-btn {
    height: 41px;
    padding: 0 18px;
    border: none;
    border-radius: 9px;
    background: linear-gradient( 135deg, #3B82F6, #2563EB );
    color: white;
    font-family: inherit;
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
}

    .modal-submit-btn:hover {
        box-shadow: 0 8px 20px rgba(59,130,246,.25);
    }

    

/*==========================================
        ACTIONS
==========================================*/

.officer-actions {
    display: flex;
    align-items: center;
    gap: 6px;
}

.action-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-height: 30px;
    padding: 6px 10px;
    border-radius: 7px;
    font-size: 10px;
    font-weight: 600;
    text-decoration: none;
    cursor: pointer;
    transition: .2s;
}


/* VIEW */

.view-btn {
    background: rgba(59,130,246,.10);
    border: 1px solid rgba(59,130,246,.12);
    color: #60A5FA;
}

    .view-btn:hover {
        background: rgba(59,130,246,.18);
        color: #93C5FD;
    }


/* ACTIVATE */

.activate-btn {
    background: rgba(34,197,94,.08);
    border: 1px solid rgba(34,197,94,.15);
    color: #4ADE80;
}

    .activate-btn:hover {
        background: rgba(34,197,94,.15);
    }


/* DEACTIVATE */

.deactivate-btn {
    background: rgba(245,158,11,.08);
    border: 1px solid rgba(245,158,11,.15);
    color: #FBBF24;
}

    .deactivate-btn:hover {
        background: rgba(245,158,11,.15);
    }


/* DELETE */

.delete-btn {
    background: rgba(239,68,68,.08);
    border: 1px solid rgba(239,68,68,.15);
    color: #F87171;
}

    .delete-btn:hover {
        background: rgba(239,68,68,.16);
    }


    </style>

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="manage-officers-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="officers-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Manage Officers
                </h1>

                <p>
                    View, add and manage officers responsible for handling civic complaints.
                </p>

            </div>


            <div class="officers-header-actions">

                <div class="officers-header-info">

                    <span>Officer Accounts</span>

                    <strong>
                        Active Management
                    </strong>

                </div>


                <button type="button"
                    class="add-officer-btn"
                    onclick="openAddOfficerModal()">

                    <span>+</span>
                    Add Officer

                </button>

            </div>

        </div>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="officer-stats">


            <!-- TOTAL -->

            <div class="officer-stat-card">

                <div class="officer-stat-icon">
                    👨‍💼
                </div>

                <div>

                    <span>Total Officers</span>

                    <strong>
                        <asp:Label
                            ID="lblTotalOfficers"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>



            <!-- ACTIVE -->

            <div class="officer-stat-card">

                <div class="officer-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>Active Officers</span>

                    <strong>
                        <asp:Label
                            ID="lblActiveOfficers"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>



            <!-- INACTIVE -->

            <div class="officer-stat-card">

                <div class="officer-stat-icon inactive-icon">
                    ●
                </div>

                <div>

                    <span>Inactive Officers</span>

                    <strong>
                        <asp:Label
                            ID="lblInactiveOfficers"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>



            <!-- ACTIVE COMPLAINTS -->

            <div class="officer-stat-card">

                <div class="officer-stat-icon complaint-icon">
                    📋
                </div>

                <div>

                    <span>Active Complaints</span>

                    <strong>
                        <asp:Label
                            ID="lblActiveComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>

        </div>



        <!-- =====================================
             MESSAGE
        ====================================== -->

        <asp:Panel
            ID="pnlMessage"
            runat="server"
            CssClass="officer-message"
            Visible="false">

            <asp:Label
                ID="lblMessage"
                runat="server">
            </asp:Label>

        </asp:Panel>



        <!-- =====================================
             SEARCH / FILTER
        ====================================== -->

        <div class="officers-toolbar">


            <!-- SEARCH -->

            <div class="officer-search">

                <span>🔍</span>

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="officer-search-input"
                    placeholder="Search by officer name or email...">
                </asp:TextBox>

            </div>



            <!-- WARD -->

            <asp:DropDownList
                ID="ddlWard"
                runat="server"
                CssClass="officer-filter">
            </asp:DropDownList>



            <!-- STATUS -->

            <asp:DropDownList
                ID="ddlStatus"
                runat="server"
                CssClass="officer-filter">

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
                OnClick="btnApplyFilters_Click" />

        </div>



        <!-- =====================================
             OFFICERS CARD
        ====================================== -->

        <div class="officers-card">


            <!-- CARD HEADER -->

            <div class="officers-card-header">

                <div>

                    <h3>
                        Registered Officers
                    </h3>

                    <p>
                        Officers currently registered on JanVoice.
                    </p>

                </div>


                <span class="record-count">

                    <asp:Label
                        ID="lblRecordCount"
                        runat="server"
                        Text="0">
                    </asp:Label>

                    Officers

                </span>

            </div>



            <!-- =====================================
                 TABLE
            ====================================== -->

            <div class="officers-table-wrapper">

                <table class="officers-table">

                    <thead>

                        <tr>

                            <th>OFFICER</th>

                            <th>CONTACT</th>

                            <th>WARD</th>

                            <th>ACTIVE COMPLAINTS</th>

                            <th>JOINED</th>

                            <th>STATUS</th>

                            <th>ACTION</th>

                        </tr>

                    </thead>


                    <tbody>

                        <asp:Repeater
                            ID="rptOfficers"
                            runat="server"
                            OnItemCommand="rptOfficers_ItemCommand">

                            <ItemTemplate>

                                <tr>


                                    <!-- OFFICER -->

                                    <td>

                                        <div class="officer-cell">

                                            <div class="officer-avatar">

                                                <%#
                                                    GetInitials(
                                                        Eval("FullName").ToString()
                                                    )
                                                %>

                                            </div>


                                            <div>

                                                <strong>
                                                    <%# Eval("FullName") %>
                                                </strong>

                                                <span>
                                                    Officer ID:
                                                    #<%# Eval("UserID") %>
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



                                    <!-- ACTIVE COMPLAINTS -->

                                    <td>

                                        <strong class="complaint-count">

                                            <%# Eval("ActiveComplaintCount") %>

                                        </strong>

                                    </td>



                                    <!-- JOINED -->

                                    <td>

                                        <%#
                                            Convert.ToDateTime(
                                                Eval("CreatedDate")
                                            ).ToString("dd MMM yyyy")
                                        %>

                                    </td>



                                    <!-- STATUS -->

                                    <td>

                                        <span class='officer-status
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

                                        <div class="officer-actions">


                                            <!-- VIEW -->

                                            <asp:HyperLink
                                                ID="lnkViewOfficer"
                                                runat="server"
                                                CssClass="action-btn view-btn"
                                                NavigateUrl='<%#
                                                    "OfficerDetails.aspx?UserID="
                                                    + Eval("UserID")
                                                %>'
                                                Text="View">
                                            </asp:HyperLink>



                                            <!-- ACTIVATE / DEACTIVATE -->

                                            <asp:LinkButton
                                                ID="btnToggleStatus"
                                                runat="server"
                                                CssClass='<%#
                                                    Convert.ToBoolean(
                                                        Eval("IsActive")
                                                    )
                                                    ? "action-btn deactivate-btn"
                                                    : "action-btn activate-btn"
                                                %>'
                                                CommandName="ToggleStatus"
                                                CommandArgument='<%# Eval("UserID") %>'
                                                OnClientClick='<%#
                                                    Convert.ToBoolean(
                                                        Eval("IsActive")
                                                    )
                                                    ? "return confirm(\"Are you sure you want to deactivate this officer?\");"
                                                    : "return confirm(\"Activate this officer account?\");"
                                                %>'>

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
                                                ID="btnDeleteOfficer"
                                                runat="server"
                                                CssClass="action-btn delete-btn"
                                                CommandName="DeleteOfficer"
                                                CommandArgument='<%# Eval("UserID") %>'
                                                OnClientClick="return confirm('Are you sure you want to permanently delete this officer account? This action cannot be undone.');">

                                                Delete

                                            </asp:LinkButton>

                                        </div>

                                    </td>

                                </tr>

                            </ItemTemplate>


                        </asp:Repeater>



                        <!-- =====================================
                             EMPTY STATE
                        ====================================== -->

                        <asp:PlaceHolder
                            ID="phEmpty"
                            runat="server"
                            Visible="false">

                            <tr>

                                <td colspan="7">

                                    <div class="officers-empty">

                                        <div>
                                            👨‍💼
                                        </div>

                                        <h4>
                                            No Officers Found
                                        </h4>

                                        <p>
                                            No officer accounts match the selected filters.
                                        </p>

                                    </div>

                                </td>

                            </tr>

                        </asp:PlaceHolder>

                    </tbody>

                </table>

            </div>

        </div>



    </div>



    <!-- =====================================================
         ADD OFFICER MODAL
    ====================================================== -->

    <div
        id="addOfficerModal"
        class="officer-modal">

        <div class="officer-modal-overlay"
            onclick="closeAddOfficerModal()">
        </div>


        <div class="officer-modal-card">


            <!-- HEADER -->

            <div class="officer-modal-header">

                <div>

                    <span>
                        JANVOICE ADMINISTRATION
                    </span>

                    <h2>
                        Add New Officer
                    </h2>

                    <p>
                        Create a new officer account and assign a ward.
                    </p>

                </div>


                <button
                    type="button"
                    class="modal-close-btn"
                    onclick="closeAddOfficerModal()">

                    ×

                </button>

            </div>



            <!-- FORM -->

            <div class="officer-form">


                <!-- NAME -->

                <div class="form-group">

                    <label>
                        Full Name
                    </label>

                    <asp:TextBox
                        ID="txtOfficerName"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Enter officer full name">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvOfficerName"
                        runat="server"
                        ControlToValidate="txtOfficerName"
                        ErrorMessage="Full name is required."
                        CssClass="field-error"
                        ValidationGroup="AddOfficer">
                    </asp:RequiredFieldValidator>

                </div>



                <!-- EMAIL -->

                <div class="form-group">

                    <label>
                        Email Address
                    </label>

                    <asp:TextBox
                        ID="txtOfficerEmail"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Email"
                        placeholder="officer@example.com">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvOfficerEmail"
                        runat="server"
                        ControlToValidate="txtOfficerEmail"
                        ErrorMessage="Email is required."
                        CssClass="field-error"
                        ValidationGroup="AddOfficer">
                    </asp:RequiredFieldValidator>

                </div>



                <!-- PHONE -->

                <div class="form-group">

                    <label>
                        Mobile Number
                    </label>

                    <asp:TextBox
                        ID="txtOfficerPhone"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="10"
                        placeholder="10 digit mobile number">
                    </asp:TextBox>

                </div>



                <!-- WARD -->

                <div class="form-group">

                    <label>
                        Assign Ward
                    </label>

                    <asp:DropDownList
                        ID="ddlOfficerWard"
                        runat="server"
                        CssClass="form-control">
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator
                        ID="rfvOfficerWard"
                        runat="server"
                        ControlToValidate="ddlOfficerWard"
                        InitialValue=""
                        ErrorMessage="Please select a ward."
                        CssClass="field-error"
                        ValidationGroup="AddOfficer">
                    </asp:RequiredFieldValidator>

                </div>



                <!-- PASSWORD -->

                <div class="form-group">

                    <label>
                        Password
                    </label>

                    <asp:TextBox
                        ID="txtOfficerPassword"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Password"
                        placeholder="Create officer password">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvOfficerPassword"
                        runat="server"
                        ControlToValidate="txtOfficerPassword"
                        ErrorMessage="Password is required."
                        CssClass="field-error"
                        ValidationGroup="AddOfficer">
                    </asp:RequiredFieldValidator>

                </div>



                <!-- CONFIRM PASSWORD -->

                <div class="form-group">

                    <label>
                        Confirm Password
                    </label>

                    <asp:TextBox
                        ID="txtOfficerConfirmPassword"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Password"
                        placeholder="Confirm password">
                    </asp:TextBox>

                    <asp:CompareValidator
                        ID="cvOfficerPassword"
                        runat="server"
                        ControlToValidate="txtOfficerConfirmPassword"
                        ControlToCompare="txtOfficerPassword"
                        ErrorMessage="Passwords do not match."
                        CssClass="field-error"
                        ValidationGroup="AddOfficer">
                    </asp:CompareValidator>

                </div>



                <!-- FORM ACTIONS -->

                <div class="officer-form-actions">

                    <button
                        type="button"
                        class="modal-cancel-btn"
                        onclick="closeAddOfficerModal()">

                        Cancel

                    </button>


                    <asp:Button
                        ID="btnAddOfficer"
                        runat="server"
                        Text="Create Officer"
                        CssClass="modal-submit-btn"
                        ValidationGroup="AddOfficer"
                        OnClick="btnAddOfficer_Click" />

                </div>

            </div>

        </div>

    </div>



    <!-- =====================================================
         JAVASCRIPT
    ====================================================== -->

    <script>

        function openAddOfficerModal() {

            document
                .getElementById("addOfficerModal")
                .classList.add("show");

            document.body.classList.add("modal-open");

        }


        function closeAddOfficerModal() {

            document
                .getElementById("addOfficerModal")
                .classList.remove("show");

            document.body.classList.remove("modal-open");

        }

    </script>


</asp:Content>