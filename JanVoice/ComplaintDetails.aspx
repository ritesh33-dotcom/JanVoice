<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ComplaintDetails.aspx.cs" Inherits="JanVoice.ComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="CSS/PublicComplaintDetails.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="complaint-details-page">

        <!-- =========================
             TOP NAVIGATION
        ========================== -->

        <section class="details-top">

            <div class="container">

                <a href="CommunityFeed.aspx"
                    class="back-community">← Back to Community

                </a>

            </div>

        </section>


        <!-- =========================
             MAIN CONTENT
        ========================== -->

        <section class="details-content">

            <div class="container">

                <div class="details-layout">

                    <!-- LEFT SIDE -->

                    <div class="details-card complaint-header-card">

                        <!-- Category + Status -->

                        <div class="details-top-row">

                            <asp:Label
                                ID="lblCategory"
                                runat="server"
                                CssClass="details-category">
                            </asp:Label>

                            <asp:Label
                                ID="lblStatus"
                                runat="server"
                                CssClass="details-status">
                            </asp:Label>

                        </div>


                        <!-- Title -->

                        <h1 class="complaint-title">

                            <asp:Label
                                ID="lblTitle"
                                runat="server">
                            </asp:Label>

                        </h1>


                        <!-- Reporter -->

                        <div class="complaint-reporter">

                            <asp:Image
                                ID="imgProfile"
                                runat="server"
                                CssClass="details-avatar"
                                AlternateText="User" />

                            <div>

                                <h4>

                                    <asp:Label
                                        ID="lblFullName"
                                        runat="server">
                                    </asp:Label>

                                </h4>

                                <span>📍

                <asp:Label
                    ID="lblWard"
                    runat="server">
                </asp:Label>

                                    &nbsp; • &nbsp;

                <asp:Label
                    ID="lblCreatedDate"
                    runat="server">
                </asp:Label>

                                </span>

                            </div>

                        </div>


                        <!-- Complaint Image -->

                        <div class="details-image-wrapper">

                            <asp:Image
                                ID="imgComplaint"
                                runat="server"
                                CssClass="details-complaint-image"
                                AlternateText="Complaint Image" />

                        </div>


                        <!-- Description -->

                        <div class="description-section">

                            <h3>Complaint Description
                            </h3>

                            <asp:Label
                                ID="lblDescription"
                                runat="server"
                                CssClass="complaint-description">
                            </asp:Label>

                        </div>

                    </div>

                    <!-- RIGHT SIDE -->

                    <aside class="details-sidebar">

                        <div class="details-card">

                            <h3>Complaint Information
                            </h3>


                            <div class="info-item">

                                <span>Complaint ID</span>

                                <strong>#<asp:Label
                                    ID="lblComplaintID"
                                    runat="server">
                                </asp:Label>
                                </strong>

                            </div>


                            <div class="info-item">

                                <span>Category</span>

                                <strong>

                                    <asp:Label
                                        ID="lblSideCategory"
                                        runat="server">
                                    </asp:Label>

                                </strong>

                            </div>


                            <div class="info-item">

                                <span>Ward</span>

                                <strong>

                                    <asp:Label
                                        ID="lblSideWard"
                                        runat="server">
                                    </asp:Label>

                                </strong>

                            </div>


                            <div class="info-item">

                                <span>Status</span>

                                <strong>

                                    <asp:Label
                                        ID="lblSideStatus"
                                        runat="server">
                                    </asp:Label>

                                </strong>

                            </div>


                            <div class="info-item">

                                <span>Landmark</span>

                                <strong>

                                    <asp:Label
                                        ID="lblLandmark"
                                        runat="server">
                                    </asp:Label>

                                </strong>

                            </div>

                        </div>

                    </aside>

                </div>

            </div>

        </section>

    </div>
</asp:Content>
