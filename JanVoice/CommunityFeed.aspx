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


        <!-- Community Statistics -->

<section class="community-stats">

    <div class="container">

        <div class="stats-grid">

            <div class="stat-card">

                <h2>
                    <asp:Label
                        ID="lblComplaints"
                        runat="server"
                        Text="0">
                    </asp:Label>
                </h2>

                <p>📄 Complaints</p>

            </div>

            <div class="stat-card">

                <h2>
                    <asp:Label
                        ID="lblSupports"
                        runat="server"
                        Text="0">
                    </asp:Label>
                </h2>

                <p>❤️ Supports</p>

            </div>

            <div class="stat-card">

                <h2>
                    <asp:Label
                        ID="lblComments"
                        runat="server"
                        Text="0">
                    </asp:Label>
                </h2>

                <p>💬 Comments</p>

            </div>

            <div class="stat-card">

                <h2>
                    <asp:Label
                        ID="lblCitizens"
                        runat="server"
                        Text="0">
                    </asp:Label>
                </h2>

                <p>👥 Citizens</p>

            </div>

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
                                        <%# ShortDescription(Eval("Description")) %>
                                    </p>

                                </div>

                                <!-- Footer -->

                                <div class="issue-footer">

                                    <span>❤️ <%# Eval("SupportCount") %> Supports
                                    </span>

                                    <span>💬 <%# Eval("CommentCount") %> Comments
                                    </span>

                                    <span>🕒 <%# GetTimeAgo(Eval("CreatedDate")) %>
                                    </span>

                                </div>

                                <!-- Buttons -->

                                <div class="issue-buttons">

                                    <asp:Button
                                        ID="btnSupport"
                                        runat="server"
                                        CssClass='<%# GetSupportClass(Eval("IsSupported")) %>'
                                        Text='<%# GetSupportText(Eval("IsSupported")) %>'
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

                    <asp:Panel
                        ID="pnlNoData"
                        runat="server"
                        CssClass="no-data"
                        Visible="false">

                        <img
                            src="Images/no-data.png"
                            alt="No Data" />

                        <h2>No Complaints Found</h2>

                        <p>
                            We couldn't find any complaints matching your search.
                            Try changing the filters or be the first to report an issue.
                        </p>

                    </asp:Panel>

                </div>

            </div>

        </section>

        <!-- Floating Report Button -->

        <a href="Citizen/ReportIssue.aspx"
            class="floating-report">+

        </a>

    </div>



    <!--==========================================
            COMMENT MODAL
===========================================-->

    <div id="commentModal" class="comment-modal">

        <div class="comment-container">

            <div class="comment-header">

                <h2>💬 Comments</h2>

                <button
                    type="button"
                    class="close-modal"
                    onclick="closeCommentModal()">
                    &times;

                </button>

            </div>

            <!-- Comments -->
            <div class="comment-list">

                <asp:Repeater
                    ID="rptComments"
                    runat="server">

                    <ItemTemplate>

                        <div class="comment-item">

                            <div class="comment-user">

                                <img
                                    src='<%# Eval("ProfilePhoto") %>'
                                    class="comment-avatar" />

                                <div>

                                    <h5>

                                        <%# Eval("FullName") %>

                                    </h5>

                                    <span>🕒 <%# GetTimeAgo(Eval("CommentDate")) %>

                                    </span>

                                </div>

                            </div>

                            <p class="comment-text">

                                <%# Eval("Comment") %>
                            </p>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

            <!-- Write Comment -->
            <div class="comment-input-area">

                <asp:TextBox
                    ID="txtComment"
                    runat="server"
                    CssClass="comment-input"
                    TextMode="MultiLine"
                    Rows="3"
                    placeholder="Write your comment...">
                </asp:TextBox>



                <asp:HiddenField
                    ID="hfComplaintID"
                    runat="server" />
                <asp:Button
                    ID="Button1"
                    runat="server"
                    Text="Post Comment"
                    CssClass="btn-post-comment"
                    OnClick="btnPostComment_Click" />

            </div>




        </div>

    </div>

    <script>

        function openCommentModal() {

            document
                .getElementById("commentModal")
                .style.display = "flex";

        }

        function closeCommentModal() {

            document
                .getElementById("commentModal")
                .style.display = "none";

        }

    </script>


</asp:Content>
