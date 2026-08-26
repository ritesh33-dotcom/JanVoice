<%@ Page Title="Complaint Details"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="ComplaintDetails.aspx.cs"
    Inherits="JanVoice.Admin.ComplaintDetails" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/AdminComplaintDetails.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">


    <div class="complaint-details-page">


        <!-- =====================================
             BACK BUTTON
        ====================================== -->

        <div class="details-back">

            <a href="ManageComplaints.aspx">← Back to Complaints
            </a>

        </div>


        <!-- =====================================
             PAGE HEADER
        ====================================== -->

        <div class="details-header">

            <div>

                <span class="page-label">COMPLAINT MANAGEMENT
                </span>

                <h1>Complaint Details
                </h1>

                <p>
                    Review the complete information and activity
                    associated with this civic complaint.
                </p>

            </div>


            <div class="header-status">
                <asp:Label
                    ID="lblStatus"
                    runat="server"
                    CssClass="status-badge pending"
                    Text="Pending">
                </asp:Label>
            </div>

        </div>



        <!-- =====================================
             MAIN GRID
        ====================================== -->

        <div class="details-grid">


            <!-- =================================
                 LEFT COLUMN
            ================================== -->

            <div class="details-main">


                <!-- COMPLAINT INFORMATION -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Complaint Information
                            </h3>

                            <p>
                                Details submitted by the citizen.
                            </p>

                        </div>

                        <span class="complaint-number">#<asp:Label
                            ID="lblComplaintID"
                            runat="server"
                            Text="0">
                        </asp:Label>
                        </span>

                    </div>


                    <div class="complaint-content">


                        <asp:Label
                            ID="lblCategory"
                            runat="server"
                            CssClass="category-badge"
                            Text="Category">
                        </asp:Label>


                        <h2>
                            <asp:Label
                                ID="lblTitle"
                                runat="server"
                                Text="Complaint Title">
                            </asp:Label>
                        </h2>

                        <p class="complaint-description">
                            <asp:Label
                                ID="lblDescription"
                                runat="server"
                                Text="Complaint description">
                            </asp:Label>
                        </p>


                        <!-- IMAGE -->

                        <div class="complaint-image">

                            <img src="../Images/#"
                                alt="Complaint Image" />

                        </div>


                        <!-- META -->

                        <div class="complaint-meta">


                            <div class="meta-item">

                                <span>📍
                                </span>

                                <div>

                                    <small>Location
                                    </small>

                                    <strong>
                                        <asp:Label
                                            ID="lblLocation"
                                            runat="server"
                                            Text="Not specified">
                                        </asp:Label>
                                    </strong>

                                </div>

                            </div>


                            <div class="meta-item">

                                <span>🏘
                                </span>

                                <div>

                                    <small>Ward
                                    </small>

                                    <strong>
                                        <asp:Label
                                            ID="lblWard"
                                            runat="server"
                                            Text="Not specified">
                                        </asp:Label>
                                    </strong>

                                </div>

                            </div>


                            <div class="meta-item">

                                <span>📅
                                </span>

                                <div>

                                    <small>Reported On
                                    </small>

                                    <strong>
                                        <asp:Label
                                            ID="lblReportedDate"
                                            runat="server"
                                            Text="-">
                                        </asp:Label>
                                    </strong>
                                </div>

                            </div>


                        </div>


                    </div>

                </div>



                <!-- =================================
                     STATUS HISTORY
                ================================== -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Status History
                            </h3>

                            <p>
                                Track the progress of this complaint.
                            </p>

                        </div>

                    </div>


                    <div class="timeline">

                        <asp:Repeater
                            ID="rptStatusHistory"
                            runat="server">

                            <ItemTemplate>

                                <div class='<%# GetTimelineItemClass(
                            Eval("NewStatus"),
                            Container.ItemIndex) %>'>

                                    <div class="timeline-dot">

                                        <%# GetTimelineIcon(
                            Eval("NewStatus"),
                            Container.ItemIndex) %>
                                    </div>

                                    <div class="timeline-content">

                                        <strong>
                                            <%# Eval("NewStatus") %>
                                        </strong>

                                        <span>
                                            <%# Eval("Remarks") %>
                                        </span>

                                        <small>
                                            <%# Convert.ToDateTime(
                                Eval("ChangeDate")
                            ).ToString("dd MMM yyyy • hh:mm tt") %>
                                        </small>

                                    </div>

                                </div>

                            </ItemTemplate>

                        </asp:Repeater>

                    </div>

                </div>


            </div>



            <!-- =================================
                 RIGHT COLUMN
            ================================== -->

            <div class="details-sidebar">


                <!-- CITIZEN -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Reported By
                            </h3>

                        </div>

                    </div>


                    <div class="citizen-profile">


                        <div class="large-avatar">
                            <asp:Label
                                ID="lblCitizenInitial"
                                runat="server"
                                Text="?">
                            </asp:Label>
                        </div>


                        <div>

                            <strong>
                                <asp:Label
                                    ID="lblCitizenName"
                                    runat="server"
                                    Text="Citizen">
                                </asp:Label>
                            </strong>

                            <span>Citizen
                            </span>

                        </div>

                    </div>


                    <div class="profile-details">

                        <div>

                            <span>Email
                            </span>

                            <strong>
                                <asp:Label
                                    ID="lblCitizenEmail"
                                    runat="server"
                                    Text="-">
                                </asp:Label>
                            </strong>

                        </div>


                        <div>

                            <span>Phone
                            </span>

                            <strong>
                                <asp:Label
                                    ID="lblCitizenPhone"
                                    runat="server"
                                    Text="-">
                                </asp:Label>
                            </strong>

                        </div>

                    </div>

                </div>



                <!-- PRIORITY -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Complaint Priority
                            </h3>

                            <p>
                                Current priority level.
                            </p>

                        </div>

                    </div>


                    <div id="priorityDisplay" runat="server" class="priority-display high">

                        <span>!
                        </span>

                        <div>

                            <strong>
                                <asp:Label
                                    ID="lblPriority"
                                    runat="server"
                                    Text="Medium Priority">
                                </asp:Label>
                            </strong>

                            <small>
                                <asp:Label
                                    ID="lblPriorityDescription"
                                    runat="server"
                                    Text="Normal attention">
                                </asp:Label>
                            </small>
                        </div>

                    </div>

                </div>



                <!-- ASSIGNED OFFICER -->

                <div class="details-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Assigned Officer
                            </h3>

                            <p>
                                Officer responsible for this complaint.
                            </p>

                        </div>

                    </div>


                    <asp:Panel
                        ID="pnlOfficer"
                        runat="server"
                        CssClass="officer-empty">

                        <div class="officer-icon">
                            👨‍💼
                        </div>

                        <strong>
                            <asp:Label
                                ID="lblOfficerName"
                                runat="server"
                                Text="No Officer Assigned">
                            </asp:Label>
                        </strong>

                        <span>
                            <asp:Label
                                ID="lblOfficerDetails"
                                runat="server"
                                Text="This complaint is waiting for assignment.">
                            </asp:Label>
                        </span>

                    </asp:Panel>

                    <asp:Button
                        ID="btnAssignOfficer"
                        runat="server"
                        Text="Assign Officer"
                        CssClass="assign-btn"
                        CausesValidation="false"
                        OnClick="btnAssignOfficer_Click" />

                    <asp:Panel
                        ID="pnlAssignOfficer"
                        runat="server"
                        CssClass="assign-officer-panel"
                        Visible="false">

                        <div class="assign-panel-header">

                            <strong>Select Officer</strong>

                            <span>Choose an officer to handle this complaint.
                            </span>

                        </div>


                        <asp:DropDownList
                            ID="ddlOfficers"
                            runat="server"
                            CssClass="officer-select">
                        </asp:DropDownList>


                        <div class="assign-panel-actions">

                            <asp:Button
                                ID="btnConfirmAssignment"
                                runat="server"
                                Text="Confirm Assignment"
                                CssClass="confirm-assign-btn"
                                CausesValidation="false"
                                OnClick="btnConfirmAssignment_Click" />

                            <asp:Button
                                ID="btnCancelAssignment"
                                runat="server"
                                Text="Cancel"
                                CssClass="cancel-assign-btn"
                                CausesValidation="false"
                                OnClick="btnCancelAssignment_Click" />

                        </div>

                    </asp:Panel>

                </div>



                <!-- ADMIN ACTIONS -->

                <div class="details-card admin-actions-card">


                    <div class="details-card-header">

                        <div>

                            <h3>Admin Actions
                            </h3>

                            <p>
                                Manage this complaint.
                            </p>

                        </div>

                    </div>


                    <div class="admin-actions">





                        <asp:Button
                            ID="btnChangePriority"
                            runat="server"
                            Text="Change Priority"
                            CssClass="action-btn warning"
                            CausesValidation="false"
                            OnClick="btnChangePriority_Click" />

                        <asp:Panel
                            ID="pnlChangePriority"
                            runat="server"
                            CssClass="change-priority-panel"
                            Visible="false">

                            <div class="priority-panel-header">

                                <strong>Change Complaint Priority
                                </strong>

                                <span>Select the new priority level.
                                </span>

                            </div>


                            <asp:DropDownList
                                ID="ddlPriority"
                                runat="server"
                                CssClass="priority-select">

                                <asp:ListItem
                                    Text="-- Select Priority --"
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


                            <div class="priority-panel-actions">

                                <asp:Button
                                    ID="btnConfirmPriority"
                                    runat="server"
                                    Text="Update Priority"
                                    CssClass="confirm-priority-btn"
                                    CausesValidation="false"
                                    OnClick="btnConfirmPriority_Click" />

                                <asp:Button
                                    ID="btnCancelPriority"
                                    runat="server"
                                    Text="Cancel"
                                    CssClass="cancel-priority-btn"
                                    CausesValidation="false"
                                    OnClick="btnCancelPriority_Click" />

                            </div>

                        </asp:Panel>


                        <asp:Button
                            ID="btnRejectComplaint"
                            runat="server"
                            Text="Reject Complaint"
                            CssClass="action-btn danger"
                            CausesValidation="false"
                            OnClick="btnRejectComplaint_Click"
                            OnClientClick="return confirm('Are you sure you want to reject this complaint?');" />

                    </div>

                </div>


            </div>


        </div>


    </div>


</asp:Content>
