<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Citizen.Master" AutoEventWireup="true" CodeBehind="ComplaintDetails.aspx.cs" Inherits="JanVoice.Citizen.ComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../CSS/complaintdetails.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="details-page">

        <!-- Header -->

        <div class="page-header">

            <h1>Complaint Details</h1>

            <p>
                View complete information about your reported issue.
            </p>

        </div>

        <div class="stats-container">

            <div class="stat-card">

                <div class="stat-number">

                    <asp:Label
                        ID="lblSupports"
                        runat="server"
                        Text="0" />

                </div>

                <div class="stat-title">
                    Supports

                </div>

            </div>

            <div class="stat-card">

                <div class="stat-number">

                    <asp:Label
                        ID="lblComments"
                        runat="server"
                        Text="0" />

                </div>

                <div class="stat-title">
                    Comments

                </div>

            </div>

            <div class="stat-card">

                <div class="stat-number">

                    <asp:Label
                        ID="lblImages"
                        runat="server"
                        Text="0" />

                </div>

                <div class="stat-title">
                    Images

                </div>

            </div>

            <div class="stat-card">

                <div class="stat-number">

                    <asp:Label
                        ID="lblFollowers"
                        runat="server"
                        Text="0" />

                </div>

                <div class="stat-title">
                    Followers

                </div>

            </div>

        </div>


        <!-- Main Card -->

        <div class="details-card">

            <!-- Image -->

            <div class="image-section">

                <asp:Image
                    ID="imgComplaint"
                    runat="server"
                    CssClass="complaint-image"
                    AlternateText="Complaint Image" />

            </div>

            <!-- Information -->

            <div class="info-section">

                <h2>

                    <asp:Label
                        ID="lblTitle"
                        runat="server" />

                </h2>

                <div class="info-grid">

                    <div>

                        <strong>Category</strong>

                        <asp:Label
                            ID="lblCategory"
                            runat="server" />

                    </div>

                    <div>

                        <strong>Ward</strong>

                        <asp:Label
                            ID="lblWard"
                            runat="server" />

                    </div>

                    <div>

                        <strong>Status</strong>

                        <asp:Label
                            ID="lblStatus"
                            runat="server"
                            CssClass="status-badge" />

                    </div>

                    <div>

                        <strong>Priority</strong>

                        <asp:Label
                            ID="lblPriority"
                            runat="server"
                            CssClass="priority-badge" />

                    </div>

                    <div>

                        <strong>Submitted On</strong>

                        <asp:Label
                            ID="lblCreatedDate"
                            runat="server" />

                    </div>

                    <div>

                        <strong>Landmark</strong>

                        <asp:Label
                            ID="lblLandmark"
                            runat="server" />

                    </div>

                </div>

            </div>

        </div>

        <div class="description-card">

            <h3>Description</h3>

            <asp:Label
                ID="lblDescription"
                runat="server" />

        </div>


        <div class="location-card">

            <h3>Complaint Location</h3>

            <iframe
                id="mapFrame"
                runat="server"
                class="location-map"
                loading="lazy"></iframe>

        </div>


        <div class="timeline-card">

            <h3>Status History</h3>
            <asp:Repeater ID="rptTimeline" runat="server">

                <ItemTemplate>

                    <div class="timeline-item">

                        <div class="timeline-dot"></div>

                        <div class="timeline-content">
                            <div class="timeline-status">

                                <strong>
                                    <%#
                                Convert.IsDBNull(Eval("OldStatus"))
                                ? "Complaint Submitted"
                                : Eval("OldStatus") + " → " + Eval("NewStatus")
                                    %>
                                </strong>

                            </div>

                            <p>

                                <%# Eval("Remarks") %>
                            </p>

                            <small>Changed By :
                                <strong>

                                    <%# Eval("RoleName") %>

                                </strong>

                                -

                                <%# Eval("FullName") %>

                                <br />

                                <%# Eval("ChangeDate","{0:dd MMM yyyy hh:mm tt}") %>

                            </small>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </div>
        <div class="comments-card">

            <h3>Comments</h3>

            <asp:Repeater
                ID="rptComments"
                runat="server">

                <ItemTemplate>

                    <div class="comment-item">

                        <div class="comment-header">

                            <div class="comment-user">

                                <span class='<%# Eval("RoleName").ToString().ToLower() %>'>

                                    <%# Eval("RoleName") %>

                                </span>

                                •

                        <strong>

                            <%# Eval("FullName") %>

                        </strong>

                            </div>

                            <span class="comment-date">

                                <%# Eval("CommentDate","{0:dd MMM yyyy hh:mm tt}") %>

                            </span>

                        </div>

                        <div class="comment-text">

                            <%# Eval("Comment") %>
                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

        </div>



        <div
            id="divNoData"
            runat="server"
            class="empty-message"
            visible="false">

            <h2>Complaint Not Found</h2>

            <p>
                The complaint you are looking for does not exist.
            </p>
        </div>
    </div>
</asp:Content>
