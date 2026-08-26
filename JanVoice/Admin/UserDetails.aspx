<%@ Page Title="User Details"
    Language="C#"
    MasterPageFile="~/MasterPages/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="UserDetails.aspx.cs"
    Inherits="JanVoice.Admin.UserDetails" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link href="../CSS/UserDetails.css" rel="stylesheet" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="user-details-page">

        <!-- PAGE HEADER -->

        <div class="details-header">

            <div>

                <span class="page-label">
                    JANVOICE ADMINISTRATION
                </span>

                <h1>
                    User Details
                </h1>

                <p>
                    View citizen information and complaint history.
                </p>

            </div>


            <a href="ManageUsers.aspx"
               class="back-btn">

                ← Back to Users

            </a>

        </div>



        <!-- USER PROFILE -->

        <div class="user-profile-card">

            <div class="profile-avatar">

                <asp:Label
                    ID="lblInitials"
                    runat="server" />

            </div>


            <div class="profile-main">

                <h2>

                    <asp:Label
                        ID="lblFullName"
                        runat="server" />

                </h2>

                <span>
                    User ID: #
                    <asp:Label
                        ID="lblUserID"
                        runat="server" />
                </span>

            </div>


            <div class="profile-status">

                <asp:Label
                    ID="lblStatus"
                    runat="server"
                    CssClass="user-status active" />

            </div>

        </div>



        <!-- PERSONAL INFORMATION -->

        <div class="details-card">

            <div class="details-card-header">

                <h3>
                    Personal Information
                </h3>

            </div>


            <div class="details-grid">


                <div class="detail-item">

                    <span>
                        Full Name
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblName"
                            runat="server" />
                    </strong>

                </div>



                <div class="detail-item">

                    <span>
                        Email
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblEmail"
                            runat="server" />
                    </strong>

                </div>



                <div class="detail-item">

                    <span>
                        Mobile
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblMobile"
                            runat="server" />
                    </strong>

                </div>



                <div class="detail-item">

                    <span>
                        Ward
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblWard"
                            runat="server" />
                    </strong>

                </div>



                <div class="detail-item">

                    <span>
                        Address
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblAddress"
                            runat="server" />
                    </strong>

                </div>



                <div class="detail-item">

                    <span>
                        Registered On
                    </span>

                    <strong>
                        <asp:Label
                            ID="lblCreatedDate"
                            runat="server" />
                    </strong>

                </div>

            </div>

        </div>



        <!-- COMPLAINT HISTORY -->

        <div class="details-card">

            <div class="details-card-header">

                <div>

                    <h3>
                        Complaint History
                    </h3>

                    <p>
                        Complaints submitted by this citizen.
                    </p>

                </div>


                <span class="record-count">

                    <asp:Label
                        ID="lblComplaintCount"
                        runat="server"
                        Text="0" />

                    Complaints

                </span>

            </div>


            <div class="complaints-table-wrapper">

                <asp:GridView
                    ID="gvComplaints"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="complaints-table"
                    EmptyDataText="This citizen has not submitted any complaints yet.">

                    <Columns>

                        <asp:BoundField
                            DataField="ComplaintID"
                            HeaderText="ID" />


                        <asp:BoundField
                            DataField="Title"
                            HeaderText="COMPLAINT" />


                        <asp:BoundField
                            DataField="CategoryName"
                            HeaderText="CATEGORY" />


                        <asp:BoundField
                            DataField="Status"
                            HeaderText="STATUS" />


                        <asp:BoundField
                            DataField="Priority"
                            HeaderText="PRIORITY" />


                        <asp:BoundField
                            DataField="CreatedDate"
                            HeaderText="DATE"
                            DataFormatString="{0:dd MMM yyyy}" />

                    </Columns>

                </asp:GridView>

            </div>

        </div>

    </div>

</asp:Content>