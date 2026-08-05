<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="CommunityFeed.aspx.cs" Inherits="JanVoice.CommunityFeed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link href="CSS/CommunityFeed.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="community-page">

        <!-- Hero Section -->
        <section class="community-hero">

            <div class="container">

                <div class="hero-content">

                    <span class="hero-badge">🌍 Community Driven Platform
                    </span>

                    <h1>Together We Build
                    <span>Better Cities</span>
                    </h1>

                    <p>
                        Explore civic issues reported by citizens,
                    support important problems,
                    comment on discussions,
                    and track complaint progress together.
                    </p>

                </div>

            </div>

        </section>

        <!-- Search & Filter -->

        <section class="community-search">

            <div class="container">

                <div class="search-wrapper">

                    <asp:TextBox
                        ID="txtSearch"
                        runat="server"
                        CssClass="search-box"
                        placeholder="Search complaints...">
                    </asp:TextBox>

                    <asp:DropDownList
                        ID="ddlCategory"
                        runat="server"
                        CssClass="filter-box">
                    </asp:DropDownList>

                    <asp:DropDownList
                        ID="ddlWard"
                        runat="server"
                        CssClass="filter-box">
                    </asp:DropDownList>

                    <asp:DropDownList
                        ID="ddlStatus"
                        runat="server"
                        CssClass="filter-box">
                    </asp:DropDownList>

                    <asp:Button
                        ID="btnSearch"
                        runat="server"
                        Text="Search"
                        CssClass="search-btn"
                        OnClick="btnSearch_Click" />

                </div>

            </div>

        </section>

        <!-- Complaint Feed -->

        <section class="community-feed">

            <div class="container">

                <div class="feed-grid">

                    <!-- Complaint Cards will come here -->

                    <asp:Repeater
                        ID="rptComplaints"
                        runat="server"
                        OnItemCommand="rptComplaints_ItemCommand">

                        <ItemTemplate>

                            <div class="issue-card">

                                <!-- Header -->

                                <div class="issue-header">

                                    <div class="user-info">
                                        <asp:Image
                                            ID="Image1"
                                            runat="server"
                                            CssClass="user-avatar"
                                            ImageUrl='<%# Eval("ProfilePhoto") %>'
                                            AlternateText="User" />



                                        <div>

                                            <h4>
                                                <%# Eval("FullName") %>
                                            </h4>

                                            <span>📍 <%# Eval("WardName") %>
                                            </span>

                                        </div>

                                    </div>

                                    <span class='status <%# GetStatusClass(Eval("Status").ToString()) %>'>

                                        <%# Eval("Status") %>

                                    </span>

                                </div>

                                <!-- Complaint Image -->

                                <asp:Image
                                    ID="imgComplaint"
                                    runat="server"
                                    CssClass="complaint-image"
                                    ImageUrl='<%# Eval("ImagePath") %>'
                                    AlternateText="Complaint Image" />

                                <!-- Body -->

                                <div class="issue-body">

                                    <span class="category">
                                        <%# Eval("CategoryName") %>
                                    </span>

                                    <h3>
                                        <%# Eval("Title") %>
                                    </h3>

                                    <p>
                                        <%# Eval("Description") %>
                                    </p>

                                </div>

                                <!-- Footer -->

                                <div class="issue-footer">

                                    <span>❤️ <%# Eval("SupportCount") %> Supports
                                    </span>

                                    <span>💬 <%# Eval("CommentCount") %> Comments
                                    </span>

                                    <span>🕒 <%# Eval("CreatedDate") %>
                                    </span>

                                </div>

                                <!-- Buttons -->

                                <div class="issue-buttons">

                                    <asp:Button
                                        ID="btnSupport"
                                        runat="server"
                                        Text="❤️ Support"
                                        CssClass="btn-support"
                                        CommandName="Support"
                                        CommandArgument='<%# Eval("ComplaintID") %>' />

                                    <asp:Button
                                        ID="btnComment"
                                        runat="server"
                                        Text="💬 Comment"
                                        CssClass="btn-comment"
                                        CommandName="Comment"
                                        CommandArgument='<%# Eval("ComplaintID") %>' />

                                    <asp:HyperLink
                                        ID="lnkDetails"
                                        runat="server"
                                        CssClass="btn-details"
                                        NavigateUrl='<%# "~/ComplaintDetails.aspx?id=" + Eval("ComplaintID") %>'>

                    👁 View Details

                                    </asp:HyperLink>

                                </div>

                            </div>

                        </ItemTemplate>

                    </asp:Repeater>


                </div>

            </div>

        </section>

        <!-- Floating Report Button -->

        <a href="Citizen/ReportIssue.aspx"
            class="floating-report">+

        </a>

    </div>



</asp:Content>
