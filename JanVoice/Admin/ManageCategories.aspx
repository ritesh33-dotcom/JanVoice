<%@ Page Title="Manage Categories"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ManageCategories.aspx.cs"
    Inherits="JanVoice.Admin.ManageCategories" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/ManageCategories.css"
        rel="stylesheet" />
    <style>
/*==========================================
        ACTIONS
==========================================*/

.category-actions {
    display: flex;
    align-items: center;
    gap: 6px;
    flex-wrap: nowrap;
}

.edit-category-btn,
.view-category-btn,
.activate-category-btn,
.deactivate-category-btn,
.delete-category-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 7px 10px;
    border-radius: 8px;
    font-size: 10px;
    font-weight: 600;
    text-decoration: none;
    white-space: nowrap;
    transition: .25s;
}


/* EDIT */

.edit-category-btn {
    background: rgba(245,158,11,.10);
    border: 1px solid rgba(245,158,11,.12);
    color: #FBBF24;
}

    .edit-category-btn:hover {
        background: rgba(245,158,11,.18);
        color: #FCD34D;
    }


/* VIEW */

.view-category-btn {
    background: rgba(59,130,246,.10);
    border: 1px solid rgba(59,130,246,.12);
    color: #60A5FA;
}

    .view-category-btn:hover {
        background: rgba(59,130,246,.18);
        color: #93C5FD;
    }


/* ACTIVATE */

.activate-category-btn {
    background: rgba(34,197,94,.10);
    border: 1px solid rgba(34,197,94,.12);
    color: #4ADE80;
}

    .activate-category-btn:hover {
        background: rgba(34,197,94,.18);
        color: #86EFAC;
    }


/* DEACTIVATE */

.deactivate-category-btn {
    background: rgba(148,163,184,.08);
    border: 1px solid rgba(148,163,184,.12);
    color: #94A3B8;
}

    .deactivate-category-btn:hover {
        background: rgba(148,163,184,.15);
        color: #CBD5E1;
    }


/* DELETE */

.delete-category-btn {
    background: rgba(239,68,68,.08);
    border: 1px solid rgba(239,68,68,.12);
    color: #F87171;
}

    .delete-category-btn:hover {
        background: rgba(239,68,68,.16);
        color: #FCA5A5;
    }


/*==========================================
        EMPTY STATE
==========================================*/

.categories-empty {
    padding: 55px 20px;
    text-align: center;
}

    .categories-empty > div {
        width: 58px;
        height: 58px;
        margin: 0 auto 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 15px;
        background: rgba(59,130,246,.08);
        color: #38BDF8;
        font-size: 24px;
        font-weight: 700;
    }

    .categories-empty h4 {
        margin: 0 0 7px;
        color: #E2E8F0;
        font-size: 15px;
    }

    .categories-empty p {
        margin: 0;
        color: #64748B;
        font-size: 12px;
    }


/*==========================================
        MODAL
==========================================*/

.category-modal-overlay {
    position: fixed;
    inset: 0;
    z-index: 9999;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    background: rgba(2,6,23,.78);
    backdrop-filter: blur(7px);
}


.category-modal {
    width: 100%;
    max-width: 520px;
    max-height: 90vh;
    overflow-y: auto;
    background: #1E293B;
    border: 1px solid rgba(255,255,255,.10);
    border-radius: 18px;
    box-shadow: 0 30px 80px rgba(0,0,0,.45);
}


/* MODAL HEADER */

.category-modal-header {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    padding: 22px;
    border-bottom: 1px solid rgba(255,255,255,.07);
}

    .category-modal-header span {
        color: #38BDF8;
        font-size: 9px;
        font-weight: 700;
        letter-spacing: 1.5px;
    }

    .category-modal-header h2 {
        margin: 6px 0 0;
        color: #F8FAFC;
        font-size: 21px;
    }


.modal-close-btn {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
    background: rgba(255,255,255,.05);
    color: #94A3B8;
    font-size: 23px;
    line-height: 1;
    text-decoration: none;
    transition: .25s;
}

    .modal-close-btn:hover {
        background: rgba(239,68,68,.12);
        color: #F87171;
    }


/* MODAL BODY */

.category-modal-body {
    padding: 24px;
}


/* FORM */

.form-group {
    margin-bottom: 20px;
}

    .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #CBD5E1;
        font-size: 12px;
        font-weight: 600;
    }

        .form-group label span {
            color: #F87171;
        }

.category-form-input {
    width: 100%;
    height: 44px;
    box-sizing: border-box;
    padding: 0 13px;
    border: 1px solid rgba(255,255,255,.09);
    border-radius: 10px;
    outline: none;
    background: rgba(15,23,42,.70);
    color: #E2E8F0;
    font-family: inherit;
    font-size: 13px;
    transition: .25s;
}

    .category-form-input:focus {
        border-color: rgba(59,130,246,.55);
        box-shadow: 0 0 0 3px rgba(59,130,246,.08);
    }

.category-textarea {
    height: auto;
    min-height: 110px;
    padding-top: 12px;
    padding-bottom: 12px;
    resize: vertical;
}


/* MODAL FOOTER */

.category-modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    padding: 18px 22px;
    border-top: 1px solid rgba(255,255,255,.07);
}


/* CANCEL */

.modal-cancel-btn {
    height: 40px;
    padding: 0 17px;
    border: 1px solid rgba(255,255,255,.09);
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
        color: #CBD5E1;
    }


/* SAVE */

.modal-save-btn {
    height: 40px;
    padding: 0 18px;
    border: none;
    border-radius: 9px;
    background: linear-gradient(135deg,#3B82F6,#2563EB);
    color: white;
    font-family: inherit;
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
}

    .modal-save-btn:hover {
        box-shadow: 0 8px 20px rgba(59,130,246,.25);
    }


/*==========================================
        VIEW MODAL
==========================================*/

.category-view-body {
    padding: 25px;
}


.view-category-icon {
    width: 65px;
    height: 65px;
    margin-bottom: 22px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 16px;
    background: rgba(59,130,246,.12);
    font-size: 29px;
}


.view-category-info {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
}


.view-info-item {
    padding: 14px;
    border: 1px solid rgba(255,255,255,.06);
    border-radius: 11px;
    background: rgba(15,23,42,.35);
}


    .view-info-item span {
        display: block;
        margin-bottom: 5px;
        color: #64748B;
        font-size: 10px;
    }


    .view-info-item strong {
        color: #E2E8F0;
        font-size: 13px;
    }


.view-status-active {
    color: #4ADE80 !important;
}


.view-status-inactive {
    color: #F87171 !important;
}


.view-description {
    margin-top: 18px;
    padding: 16px;
    border-radius: 11px;
    background: rgba(15,23,42,.35);
    border: 1px solid rgba(255,255,255,.06);
}


    .view-description > span {
        color: #64748B;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 1px;
    }


    .view-description p {
        margin: 9px 0 0;
        color: #CBD5E1;
        font-size: 13px;
        line-height: 1.6;
    }

</style>
</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="manage-categories-page">


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="categories-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    Manage Categories
                </h1>

                <p>
                    Manage civic issue categories used across JanVoice.
                </p>

            </div>


            <div class="categories-header-action">

                <asp:Button
                    ID="btnAddCategory"
                    runat="server"
                    Text="+  Add Category"
                    CssClass="add-category-btn"
                    CausesValidation="false"
                    OnClick="btnAddCategory_Click" />

            </div>

        </div>



        <!-- =====================================
             MESSAGE
        ====================================== -->

        <asp:Panel
            ID="pnlMessage"
            runat="server"
            CssClass="category-message"
            Visible="false">

            <asp:Label
                ID="lblMessage"
                runat="server">
            </asp:Label>

        </asp:Panel>



        <!-- =====================================
             STATISTICS
        ====================================== -->

        <div class="category-stats">


            <!-- TOTAL -->

            <div class="category-stat-card">

                <div class="category-stat-icon">
                    #
                </div>

                <div>

                    <span>
                        Total Categories
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblTotalCategories"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>



            <!-- ACTIVE -->

            <div class="category-stat-card">

                <div class="category-stat-icon active-icon">
                    ✓
                </div>

                <div>

                    <span>
                        Active Categories
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblActiveCategories"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>



            <!-- INACTIVE -->

            <div class="category-stat-card">

                <div class="category-stat-icon inactive-icon">
                    ●
                </div>

                <div>

                    <span>
                        Inactive Categories
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblInactiveCategories"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>



            <!-- COMPLAINTS -->

            <div class="category-stat-card">

                <div class="category-stat-icon complaint-icon">
                    📋
                </div>

                <div>

                    <span>
                        Categorized Complaints
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblCategorizedComplaints"
                            runat="server"
                            Text="0">
                        </asp:Label>
                    </strong>

                </div>

            </div>


        </div>



        <!-- =====================================
             SEARCH / FILTER
        ====================================== -->

        <div class="categories-toolbar">


            <!-- SEARCH -->

            <div class="category-search">

                <span>
                    🔍
                </span>

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="category-search-input"
                    placeholder="Search category...">
                </asp:TextBox>

            </div>



            <!-- STATUS FILTER -->

            <asp:DropDownList
                ID="ddlStatus"
                runat="server"
                CssClass="category-filter">

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



            <!-- APPLY FILTER -->

            <asp:Button
                ID="btnApplyFilters"
                runat="server"
                Text="Apply Filters"
                CssClass="filter-btn"
                CausesValidation="false"
                OnClick="btnApplyFilters_Click" />

        </div>



        <!-- =====================================
             CATEGORY CARD
        ====================================== -->

        <div class="categories-card">


            <!-- CARD HEADER -->

            <div class="categories-card-header">

                <div>

                    <h3>
                        Civic Categories
                    </h3>

                    <p>
                        Categories available for citizen complaints.
                    </p>

                </div>


                <span class="record-count">

                    <asp:Label
                        ID="lblRecordCount"
                        runat="server"
                        Text="0">
                    </asp:Label>

                    Categories

                </span>

            </div>



            <!-- =====================================
                 TABLE
            ====================================== -->

            <div class="categories-table-wrapper">

                <table class="categories-table">

                    <thead>

                        <tr>

                            <th>
                                CATEGORY
                            </th>

                            <th>
                                DESCRIPTION
                            </th>

                            <th>
                                COMPLAINTS
                            </th>

                            <th>
                                CREATED
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
                            ID="rptCategories"
                            runat="server"
                            OnItemCommand="rptCategories_ItemCommand">

                            <ItemTemplate>

                                <tr>


                                    <!-- CATEGORY -->

                                    <td>

                                        <div class="category-cell">

                                            <div class='category-icon <%# GetIconClass(Eval("CategoryName").ToString()) %>'>

                                                <%#
                                                    GetCategoryIcon(
                                                        Eval("CategoryName").ToString()
                                                    )
                                                %>

                                            </div>

                                            <div>

                                                <strong>
                                                    <%#
                                                        Server.HtmlEncode(
                                                            Eval("CategoryName").ToString()
                                                        )
                                                    %>
                                                </strong>

                                                <span>
                                                    Category ID:
                                                    #<%# Eval("CategoryID") %>
                                                </span>

                                            </div>

                                        </div>

                                    </td>



                                    <!-- DESCRIPTION -->

                                    <td>

                                        <span class="category-description">

                                            <%#
                                                Server.HtmlEncode(
                                                    Eval("Description") == DBNull.Value
                                                    ? ""
                                                    : Eval("Description").ToString()
                                                )
                                            %>

                                        </span>

                                    </td>



                                    <!-- COMPLAINT COUNT -->

                                    <td>

                                        <strong class="complaint-count">

                                            <%# Eval("ComplaintCount") %>

                                        </strong>

                                    </td>



                                    <!-- CREATED -->

                                    <td>

                                        <%#
                                            Convert.ToDateTime(
                                                Eval("CreatedDate")
                                            ).ToString("dd MMM yyyy")
                                        %>

                                    </td>



                                    <!-- STATUS -->

                                    <td>

                                        <span class='category-status
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

                                        <div class="category-actions">


                                            <!-- EDIT -->

                                            <asp:LinkButton
                                                ID="btnEdit"
                                                runat="server"
                                                CssClass="edit-category-btn"
                                                CommandName="EditCategory"
                                                CommandArgument='<%# Eval("CategoryID") %>'
                                                CausesValidation="false">

                                                Edit

                                            </asp:LinkButton>



                                            <!-- VIEW -->

                                            <asp:LinkButton
                                                ID="btnView"
                                                runat="server"
                                                CssClass="view-category-btn"
                                                CommandName="ViewCategory"
                                                CommandArgument='<%# Eval("CategoryID") %>'
                                                CausesValidation="false">

                                                View

                                            </asp:LinkButton>



                                            <!-- TOGGLE -->

                                            <asp:LinkButton
                                                ID="btnToggle"
                                                runat="server"
                                                CssClass='<%#
                                                    Convert.ToBoolean(Eval("IsActive"))
                                                    ? "deactivate-category-btn"
                                                    : "activate-category-btn"
                                                %>'
                                                CommandName="ToggleCategory"
                                                CommandArgument='<%# Eval("CategoryID") %>'
                                                CausesValidation="false">

                                                <%#
                                                    Convert.ToBoolean(Eval("IsActive"))
                                                    ? "Deactivate"
                                                    : "Activate"
                                                %>

                                            </asp:LinkButton>



                                            <!-- DELETE -->

                                            <asp:LinkButton
                                                ID="btnDelete"
                                                runat="server"
                                                CssClass="delete-category-btn"
                                                CommandName="DeleteCategory"
                                                CommandArgument='<%# Eval("CategoryID") %>'
                                                CausesValidation="false"
                                                OnClientClick="return confirm('Are you sure you want to delete this category?');">

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

                                    <div class="categories-empty">

                                        <div>
                                            #
                                        </div>

                                        <h4>
                                            No Categories Found
                                        </h4>

                                        <p>
                                            No categories match your current search or filter.
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
             ADD / EDIT CATEGORY MODAL
        ====================================== -->

        <asp:Panel
            ID="pnlCategoryModal"
            runat="server"
            CssClass="category-modal-overlay"
            Visible="false">


            <div class="category-modal">


                <!-- MODAL HEADER -->

                <div class="category-modal-header">

                    <div>

                        <span>
                            JANVOICE ADMINISTRATION
                        </span>

                        <h2>

                            <asp:Label
                                ID="lblModalTitle"
                                runat="server"
                                Text="Add Category">
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



                <!-- MODAL BODY -->

                <div class="category-modal-body">


                    <asp:HiddenField
                        ID="hfCategoryID"
                        runat="server"
                        Value="0" />



                    <!-- CATEGORY NAME -->

                    <div class="form-group">

                        <label>
                            Category Name
                            <span>*</span>
                        </label>

                        <asp:TextBox
                            ID="txtCategoryName"
                            runat="server"
                            CssClass="category-form-input"
                            MaxLength="100"
                            placeholder="e.g. Roads & Potholes">
                        </asp:TextBox>

                    </div>



                    <!-- DESCRIPTION -->

                    <div class="form-group">

                        <label>
                            Description
                        </label>

                        <asp:TextBox
                            ID="txtCategoryDescription"
                            runat="server"
                            CssClass="category-form-input category-textarea"
                            TextMode="MultiLine"
                            Rows="4"
                            MaxLength="500"
                            placeholder="Describe the type of civic issues covered by this category...">
                        </asp:TextBox>

                    </div>



                    <!-- STATUS -->

                    <div
                        id="categoryStatusGroup"
                        runat="server"
                        class="form-group">

                        <label>
                            Status
                        </label>

                        <asp:DropDownList
                            ID="ddlModalStatus"
                            runat="server"
                            CssClass="category-form-input">

                            <asp:ListItem
                                Text="Active"
                                Value="1" />

                            <asp:ListItem
                                Text="Inactive"
                                Value="0" />

                        </asp:DropDownList>

                    </div>


                </div>



                <!-- MODAL FOOTER -->

                <div class="category-modal-footer">

                    <asp:Button
                        ID="btnCancelModal"
                        runat="server"
                        Text="Cancel"
                        CssClass="modal-cancel-btn"
                        CausesValidation="false"
                        OnClick="btnCloseModal_Click" />


                    <asp:Button
                        ID="btnSaveCategory"
                        runat="server"
                        Text="Save Category"
                        CssClass="modal-save-btn"
                        CausesValidation="false"
                        OnClick="btnSaveCategory_Click" />

                </div>


            </div>

        </asp:Panel>



        <!-- =====================================
             VIEW CATEGORY MODAL
        ====================================== -->

        <asp:Panel
            ID="pnlViewModal"
            runat="server"
            CssClass="category-modal-overlay"
            Visible="false">


            <div class="category-modal view-modal">


                <div class="category-modal-header">

                    <div>

                        <span>
                            CATEGORY DETAILS
                        </span>

                        <h2>
                            <asp:Label
                                ID="lblViewCategoryName"
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



                <div class="category-view-body">


                    <div class="view-category-icon">

                        <asp:Label
                            ID="lblViewIcon"
                            runat="server">
                        </asp:Label>

                    </div>


                    <div class="view-category-info">


                        <div class="view-info-item">

                            <span>
                                Category ID
                            </span>

                            <strong>
                                #<asp:Label
                                    ID="lblViewCategoryID"
                                    runat="server">
                                </asp:Label>
                            </strong>

                        </div>


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



                <div class="category-modal-footer">

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