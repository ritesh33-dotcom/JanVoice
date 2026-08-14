<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="CommunityLeaderboard.aspx.cs" Inherits="JanVoice.Officer.CommunityLeaderboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/CommunityLeaderboard.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


        <!-- =========================================================
         COMMUNITY LEADERBOARD PAGE
    ========================================================== -->

    <section class="leaderboard-page">

        <div class="leaderboard-container">


            <!-- =====================================================
                 PAGE HERO
            ====================================================== -->

            <div class="leaderboard-hero">

                <div class="leaderboard-hero-content">

                    <span class="leaderboard-badge">

                        <i class="fa-solid fa-trophy"></i>

                        COMMUNITY ENGAGEMENT

                    </span>


                    <h1>
                        Community Leaderboard
                    </h1>


                    <p>
                        Recognize and monitor citizens who actively
                        contribute to improving their community.
                    </p>

                </div>


                <div class="leaderboard-hero-icon">

                    <i class="fa-solid fa-ranking-star"></i>

                </div>

            </div>



            <!-- =====================================================
                 LEADERBOARD STATISTICS
            ====================================================== -->

            <div class="leaderboard-stats-grid">


                <!-- TOTAL PARTICIPANTS -->

                <div class="leader-stat-card">

                    <div class="leader-stat-icon blue">

                        <i class="fa-solid fa-users"></i>

                    </div>


                    <div class="leader-stat-content">

                        <span class="leader-stat-label">
                            Total Participants
                        </span>


                        <strong>

                            <asp:Label
                                ID="lblTotalParticipants"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>


                        <small>
                            Active community members
                        </small>

                    </div>

                </div>



                <!-- TOTAL REPORTS -->

                <div class="leader-stat-card">

                    <div class="leader-stat-icon purple">

                        <i class="fa-solid fa-file-circle-plus"></i>

                    </div>


                    <div class="leader-stat-content">

                        <span class="leader-stat-label">
                            Issues Reported
                        </span>


                        <strong>

                            <asp:Label
                                ID="lblTotalReports"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>


                        <small>
                            Community complaints
                        </small>

                    </div>

                </div>



                <!-- TOP CONTRIBUTOR -->

                <div class="leader-stat-card">

                    <div class="leader-stat-icon gold">

                        <i class="fa-solid fa-crown"></i>

                    </div>


                    <div class="leader-stat-content">

                        <span class="leader-stat-label">
                            Top Contributor
                        </span>


                        <strong
                            class="leader-stat-title">

                            <asp:Label
                                ID="lblTopContributor"
                                runat="server"
                                Text="No Data">
                            </asp:Label>

                        </strong>


                        <small>
                            Highest contribution
                        </small>

                    </div>

                </div>



                <!-- TOTAL SUPPORTS -->

                <div class="leader-stat-card">

                    <div class="leader-stat-icon green">

                        <i class="fa-solid fa-thumbs-up"></i>

                    </div>


                    <div class="leader-stat-content">

                        <span class="leader-stat-label">
                            Community Supports
                        </span>


                        <strong>

                            <asp:Label
                                ID="lblTotalSupports"
                                runat="server"
                                Text="0">
                            </asp:Label>

                        </strong>


                        <small>
                            Supports received
                        </small>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 TOP THREE PODIUM
            ====================================================== -->

            <div class="leaderboard-card podium-card">


                <div class="leaderboard-card-header">

                    <div>

                        <div class="leaderboard-card-title">

                            <i class="fa-solid fa-medal"></i>

                            Top Community Contributors

                        </div>


                        <p>
                            Citizens with the highest community
                            contribution scores.
                        </p>

                    </div>


                    <div class="leaderboard-card-header-icon">

                        <i class="fa-solid fa-ranking-star"></i>

                    </div>

                </div>



                <div class="podium-container">


                    <!-- SECOND PLACE -->

                    <div class="podium-item second-place">

                        <div class="podium-medal">

                            <i class="fa-solid fa-medal"></i>

                        </div>


                        <div class="podium-avatar">

                            <i class="fa-solid fa-user"></i>

                        </div>


                        <strong>

                            <asp:Label
                                ID="lblSecondPlace"
                                runat="server"
                                Text="Loading...">
                            </asp:Label>

                        </strong>


                        <span>
                            2nd Place
                        </span>


                        <small>

                            <asp:Label
                                ID="lblSecondScore"
                                runat="server"
                                Text="0">
                            </asp:Label>

                            Points

                        </small>

                    </div>



                    <!-- FIRST PLACE -->

                    <div class="podium-item first-place">

                        <div class="podium-crown">

                            <i class="fa-solid fa-crown"></i>

                        </div>


                        <div class="podium-avatar">

                            <i class="fa-solid fa-user"></i>

                        </div>


                        <strong>

                            <asp:Label
                                ID="lblFirstPlace"
                                runat="server"
                                Text="Loading...">
                            </asp:Label>

                        </strong>


                        <span>
                            1st Place
                        </span>


                        <small>

                            <asp:Label
                                ID="lblFirstScore"
                                runat="server"
                                Text="0">
                            </asp:Label>

                            Points

                        </small>

                    </div>



                    

                    <div class="podium-item third-place">

                        <div class="podium-medal">

                            <i class="fa-solid fa-medal"></i>

                        </div>


                        <div class="podium-avatar">

                            <i class="fa-solid fa-user"></i>

                        </div>


                        <strong>

                            <asp:Label
                                ID="lblThirdPlace"
                                runat="server"
                                Text="Loading...">
                            </asp:Label>

                        </strong>


                        <span>
                            3rd Place
                        </span>


                        <small>

                            <asp:Label
                                ID="lblThirdScore"
                                runat="server"
                                Text="0">
                            </asp:Label>

                            Points

                        </small>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 FULL LEADERBOARD
            ====================================================== -->

            <div class="leaderboard-card">


                <div class="leaderboard-card-header">

                    <div>

                        <div class="leaderboard-card-title">

                            <i class="fa-solid fa-list-ol"></i>

                            Community Rankings

                        </div>


                        <p>
                            Complete ranking based on citizen
                            participation and contribution.
                        </p>

                    </div>


                    <div class="leaderboard-card-header-icon">

                        <i class="fa-solid fa-chart-simple"></i>

                    </div>

                </div>



                <div class="leaderboard-table-wrapper">


                    <asp:GridView
                        ID="gvLeaderboard"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="leaderboard-table"
                        GridLines="None"
                        EmptyDataText="No community leaderboard data available.">


                        <Columns>


                            

                            <asp:TemplateField
                                HeaderText="Rank">

                                <ItemTemplate>

                                    <div class="leader-rank">

                                        <%#
                                            Container.DataItemIndex + 1
                                        %>

                                    </div>

                                </ItemTemplate>

                            </asp:TemplateField>



                            

                            <asp:BoundField
                                DataField="CitizenName"
                                HeaderText="Citizen" />



                            

                            <asp:BoundField
                                DataField="ReportsCount"
                                HeaderText="Issues Reported" />



                            

                            <asp:BoundField
                                DataField="ResolvedCount"
                                HeaderText="Resolved" />



                           

                            <asp:BoundField
                                DataField="SupportsCount"
                                HeaderText="Supports" />



                           

                            <asp:TemplateField
                                HeaderText="Contribution Score">

                                <ItemTemplate>

                                    <span class="leader-score">

                                        <%#
                                            Eval("ContributionScore")
                                        %>

                                    </span>

                                </ItemTemplate>

                            </asp:TemplateField>



                          

                            <asp:TemplateField
                                HeaderText="Badge">

                                <ItemTemplate>

                                    <span class="leader-badge">

                                        <i class="fa-solid fa-award"></i>

                                        <%#
                                            Eval("Badge")
                                        %>

                                    </span>

                                </ItemTemplate>

                            </asp:TemplateField>


                        </Columns>

                    </asp:GridView>


                </div>

            </div>



            <!-- =====================================================
                 CONTRIBUTION BREAKDOWN
            ====================================================== -->

            <div class="leaderboard-card">


                <div class="leaderboard-card-header">

                    <div>

                        <div class="leaderboard-card-title">

                            <i class="fa-solid fa-chart-pie"></i>

                            Community Contribution

                        </div>


                        <p>
                            Overview of how citizens contribute
                            to JanVoice.
                        </p>

                    </div>

                </div>



                <div class="contribution-grid">


                    <!-- REPORT ISSUES -->

                    <div class="contribution-item">

                        <div class="contribution-icon blue">

                            <i class="fa-solid fa-file-circle-plus"></i>

                        </div>


                        <div>

                            <strong>
                                Issues Reported
                            </strong>


                            <span>

                                <asp:Label
                                    ID="lblContributionReports"
                                    runat="server"
                                    Text="0">
                                </asp:Label>

                                reports

                            </span>

                        </div>

                    </div>



                    <!-- SUPPORT ISSUES -->

                    <div class="contribution-item">

                        <div class="contribution-icon green">

                            <i class="fa-solid fa-thumbs-up"></i>

                        </div>


                        <div>

                            <strong>
                                Issues Supported
                            </strong>


                            <span>

                                <asp:Label
                                    ID="lblContributionSupports"
                                    runat="server"
                                    Text="0">
                                </asp:Label>

                                supports

                            </span>

                        </div>

                    </div>



                    <!-- RESOLVED -->

                    <div class="contribution-item">

                        <div class="contribution-icon purple">

                            <i class="fa-solid fa-circle-check"></i>

                        </div>


                        <div>

                            <strong>
                                Issues Resolved
                            </strong>


                            <span>

                                <asp:Label
                                    ID="lblContributionResolved"
                                    runat="server"
                                    Text="0">
                                </asp:Label>

                                resolved

                            </span>

                        </div>

                    </div>



                    <!-- PARTICIPANTS -->

                    <div class="contribution-item">

                        <div class="contribution-icon orange">

                            <i class="fa-solid fa-users"></i>

                        </div>


                        <div>

                            <strong>
                                Active Citizens
                            </strong>


                            <span>

                                <asp:Label
                                    ID="lblContributionCitizens"
                                    runat="server"
                                    Text="0">
                                </asp:Label>

                                participants

                            </span>

                        </div>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 INFORMATION FOOTER
            ====================================================== -->

            <div class="leaderboard-information">

                <div>

                    <i class="fa-solid fa-circle-info"></i>

                    Community rankings are calculated from
                    citizen participation data.

                </div>


                <div>

                    <i class="fa-solid fa-shield-halved"></i>

                    JanVoice Community Analytics

                </div>

            </div>


        </div>

    </section>

</asp:Content>
