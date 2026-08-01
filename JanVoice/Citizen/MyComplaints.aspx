<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="MyComplaints.aspx.cs" Inherits="JanVoice.Citizen.MyComplaints" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/mycomplaints.css" rel="stylesheet" />



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="complaints-page">

    <!-- PAGE HEADER -->

    <div class="page-header">

        <div>

            <h1>My Complaints</h1>

            <p>
                Track every civic issue you've reported and monitor its progress.
            </p>

        </div>

        <a href="ReportIssue.aspx" class="report-btn">

            <i class="fa-solid fa-plus"></i>

            Report New Issue

        </a>

    </div>

    <!-- STATISTICS -->

    <div class="stats-grid">

        <div class="stat-card">

            <i class="fa-solid fa-file-circle-check stat-icon"></i>

            <h2>

                <asp:Label
                    ID="lblTotal"
                    runat="server"
                    Text="0">
                </asp:Label>

            </h2>

            <span>Total Complaints</span>

        </div>

        <div class="stat-card pending">

            <i class="fa-solid fa-clock stat-icon"></i>

            <h2>

                <asp:Label
                    ID="lblPending"
                    runat="server"
                    Text="0">
                </asp:Label>

            </h2>

            <span>Pending</span>

        </div>


         <div class="stat-card progress">

     <i class="fa-solid fa-spinner stat-icon"></i>

     <h2>

         <asp:Label
             ID="lblProgress"
             runat="server"
             Text="0">
         </asp:Label>

     </h2>

     <span>In Progress</span>

 </div>



       

        <div class="stat-card resolved">

            <i class="fa-solid fa-circle-check stat-icon"></i>

            <h2>

                <asp:Label
                    ID="lblResolved"
                    runat="server"
                    Text="0">
                </asp:Label>

            </h2>

            <span>Resolved</span>

        </div>

    </div>

    <!-- SEARCH + FILTER -->

    <div class="toolbar">

        <div class="search-box">

            <i class="fa-solid fa-magnifying-glass"></i>

            <asp:TextBox
                ID="txtSearch"
                runat="server"
                CssClass="search-input"
                placeholder="Search complaint...">
            </asp:TextBox>

        </div>

        <asp:DropDownList
            ID="ddlStatus"
            runat="server"
            CssClass="status-filter">

            <asp:ListItem Text="All Status" Value=""></asp:ListItem>

            <asp:ListItem Text="Pending"></asp:ListItem>

            <asp:ListItem Text="In Progress"></asp:ListItem>

            <asp:ListItem Text="Resolved"></asp:ListItem>

            <asp:ListItem Text="Rejected"></asp:ListItem>

        </asp:DropDownList>

    </div>

    <!-- COMPLAINTS -->

    <div class="complaints-container">

        <asp:Repeater
            ID="rptComplaints"
            runat="server">

            <ItemTemplate>

                <div class="complaint-card">

                    <!-- IMAGE -->

                    <div class="card-image">

                        <img src='<%# Eval("ImagePath") %>'
                             alt="Complaint Image"/>

                    </div>

                    <!-- BODY -->

                    <div class="card-body">

                        <div class="card-top">

                            <h3>

                                <%# Eval("Title") %>

                            </h3>

                            <span class="status-badge">

                                <%# Eval("Status") %>

                            </span>

                        </div>

                        <p class="description">

                            <%# Eval("Description") %>

                        </p>

                        <div class="card-info">

                            <span>

                                <i class="fa-solid fa-layer-group"></i>

                                <%# Eval("CategoryName") %>

                            </span>

                            <span>

                                <i class="fa-solid fa-location-dot"></i>

                                <%# Eval("WardName") %>

                            </span>

                            <span>

                                <i class="fa-solid fa-calendar"></i>

                                <%# Eval("CreatedDate","{0:dd MMM yyyy}") %>

                            </span>

                        </div>

                        <div class="card-footer">

                            <span class="priority">

                                Priority :
                                <%# Eval("Priority") %>

                            </span>

                            <asp:HyperLink
                                ID="lnkDetails"
                                runat="server"
                                NavigateUrl='<%# "ComplaintDetails.aspx?id="+Eval("ComplaintID") %>'
                                CssClass="details-btn">

                                View Details

                            </asp:HyperLink>

                        </div>

                    </div>

                </div>

            </ItemTemplate>

        </asp:Repeater>

    </div>

    <!-- EMPTY STATE -->

    <asp:Panel
        ID="pnlEmpty"
        runat="server"
        Visible="false"
        CssClass="empty-state">

        <i class="fa-regular fa-folder-open empty-icon"></i>

        <h2>No Complaints Found</h2>

        <p>

            You haven't reported any civic issues yet.

        </p>

        <a href="ReportIssue.aspx"
           class="report-btn">

            Report Your First Issue

        </a>

    </asp:Panel>

</div>

<script src="../JS/mycomplaints.js"></script>

</asp:Content>
