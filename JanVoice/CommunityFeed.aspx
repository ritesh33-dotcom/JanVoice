<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="CommunityFeed.aspx.cs" Inherits="JanVoice.CommunityFeed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link href="CSS/CommunityFeed.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- HERO -->

    <section class="community-hero">

        <div class="container">

            <div class="hero-content">

                <span class="hero-badge">
                    🌍 Community Driven Platform
                </span>

                <h1>
                    Together We Build
                    <span>Better Cities</span>
                </h1>

                <p>

                    Browse civic issues reported by citizens,
                    support important problems,
                    comment,
                    and track progress together.

                </p>

            </div>

        </div>

    </section>

    <!-- SEARCH -->

    <section class="search-section">

        <div class="container">

            <div class="search-box">

                <asp:TextBox
                    ID="txtSearch"
                    runat="server"
                    CssClass="search-input"
                    placeholder="Search complaints...">
                </asp:TextBox>

                <asp:DropDownList
                    ID="ddlCategory"
                    runat="server"
                    CssClass="dropdown">
                </asp:DropDownList>

                <asp:DropDownList
                    ID="ddlStatus"
                    runat="server"
                    CssClass="dropdown">
                </asp:DropDownList>

                <asp:Button
                    ID="btnSearch"
                    runat="server"
                    Text="Search"
                    CssClass="search-btn" />

            </div>

        </div>

    </section>

    <!-- FEED -->

    <section class="feed-section">

        <div class="container">

           <asp:Repeater ID="rptComplaints" runat="server">

    <ItemTemplate>

        <div class="issue-card">

            <!-- User Header -->

            <div class="issue-header">

                <div class="user-info">

                    <img src='<%# Eval("ProfilePhoto") %>'
                        class="user-avatar"
                        alt="User" />

                    <div>

                        <h5><%# Eval("FullName") %></h5>

                        <span>
                            📍 <%# Eval("WardName") %>
                        </span>

                    </div>

                </div>

                <span class="status pending">

                    <%# Eval("Status") %>

                </span>

            </div>

            <!-- Complaint Image -->

            <img src='<%# Eval("ImagePath") %>'
                class="issue-image"
                alt="Complaint Image" />

            <!-- Body -->

            <div class="issue-body">

                <div class="issue-top">

                    <span class="category">

                        <%# Eval("CategoryName") %>

                    </span>

                </div>

                <h3>

                    <%# Eval("Title") %>

                </h3>

                <p>

                    <%# Eval("Description") %>

                </p>

                <div class="issue-footer">

                    <span>

                        ❤️ <%# Eval("SupportCount") %>

                    </span>

                    <span>

                        💬 <%# Eval("CommentCount") %>

                    </span>

                </div>

                <div class="issue-buttons">

                    <button class="btn-support">

                        ❤️ Support

                    </button>

                    <button class="btn-comment">

                        💬 Comment

                    </button>

                    <a href='ComplaintDetails.aspx?id=<%# Eval("ComplaintID") %>'
                        class="btn-details">

                        View Details

                    </a>

                </div>

            </div>

        </div>

    </ItemTemplate>

</asp:Repeater>

        </div>

    </section>

    <!-- Floating Button -->

    <a href="ReportIssue.aspx"
        class="floating-report">

        +

    </a>



</asp:Content>
