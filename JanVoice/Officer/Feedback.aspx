<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="JanVoice.Officer.Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../CSS/Feedback.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- =========================================================
         FEEDBACK PAGE
    ========================================================== -->

    <section class="feedback-page">

        <div class="feedback-container">


            <!-- =====================================================
                 PAGE HERO
            ====================================================== -->

            <div class="feedback-hero">

                <div class="feedback-hero-content">

                    <span class="feedback-badge">

                        <i class="fa-solid fa-comment-dots"></i>

                        CITIZEN VOICE

                    </span>


                    <h1>Feedback & Suggestions
                    </h1>


                    <p>
                        Share your experience, suggestions and ideas
                        to help us improve JanVoice and deliver
                        better civic services.
                    </p>

                </div>


                <div class="feedback-hero-icon">

                    <i class="fa-solid fa-comments"></i>

                </div>

            </div>



            <!-- =====================================================
                 FEEDBACK NOTICE
            ====================================================== -->

            <div class="feedback-alert">

                <div class="feedback-alert-icon">

                    <i class="fa-solid fa-circle-info"></i>

                </div>


                <div class="feedback-alert-content">

                    <strong>Your Voice Matters
                    </strong>

                    <p>
                        Every genuine suggestion helps improve
                        the quality of public services and the
                        JanVoice experience.
                    </p>

                </div>

            </div>



            <!-- =====================================================
                 MAIN FEEDBACK GRID
            ====================================================== -->

            <div class="feedback-main-grid">


                <!-- =================================================
                     FEEDBACK FORM
                ================================================== -->

                <div class="feedback-card">


                    <div class="feedback-card-header">

                        <div>

                            <div class="feedback-card-title">

                                <i class="fa-solid fa-pen-to-square"></i>

                                Share Your Feedback

                            </div>


                            <p>
                                Tell us about your experience with
                                JanVoice.
                            </p>

                        </div>


                        <div class="feedback-card-header-icon">

                            <i class="fa-solid fa-message"></i>

                        </div>

                    </div>



                    <!-- =================================================
                         FORM
                    ================================================== -->

                    <div class="feedback-form">


                        <!-- NAME -->

                        <div class="feedback-form-group">

                            <label for="txtName">
                                Your Name

                                <span>*</span>

                            </label>


                            <div class="feedback-input-wrapper">

                                <i class="fa-solid fa-user"></i>

                                <asp:TextBox
                                    ID="txtName"
                                    runat="server"
                                    CssClass="feedback-input"
                                    placeholder="Enter your name">
                                </asp:TextBox>

                            </div>

                        </div>



                        <!-- EMAIL -->

                        <div class="feedback-form-group">

                            <label for="txtEmail">
                                Email Address

                                <span>*</span>

                            </label>


                            <div class="feedback-input-wrapper">

                                <i class="fa-solid fa-envelope"></i>

                                <asp:TextBox
                                    ID="txtEmail"
                                    runat="server"
                                    CssClass="feedback-input"
                                    TextMode="Email"
                                    placeholder="Enter your email address">
                                </asp:TextBox>

                            </div>

                        </div>



                        <!-- CATEGORY -->

                        <div class="feedback-form-group">

                            <label for="ddlFeedbackCategory">
                                Feedback Category

                                <span>*</span>

                            </label>


                            <div class="feedback-input-wrapper">

                                <i class="fa-solid fa-layer-group"></i>


                                <asp:DropDownList
                                    ID="ddlFeedbackCategory"
                                    runat="server"
                                    CssClass="feedback-input">

                                    <asp:ListItem
                                        Text="-- Select Category --"
                                        Value="">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Website Experience"
                                        Value="Website">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Complaint Service"
                                        Value="Complaint">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Officer Service"
                                        Value="Officer">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="Suggestion"
                                        Value="Suggestion">
                                    </asp:ListItem>

                                    <asp:ListItem
                                        Text="General Feedback"
                                        Value="General">
                                    </asp:ListItem>

                                </asp:DropDownList>

                            </div>

                        </div>



                        <!-- RATING -->

                        <div class="feedback-form-group">

                            <label>
                                Overall Experience

                                <span>*</span>

                            </label>


                            <div class="feedback-rating">

                                <label class="rating-option">

                                    <asp:RadioButton
                                        ID="rbVeryPoor"
                                        runat="server"
                                        GroupName="FeedbackRating"
                                        Text="1" />

                                    <span>Very Poor
                                    </span>

                                </label>


                                <label class="rating-option">

                                    <asp:RadioButton
                                        ID="rbPoor"
                                        runat="server"
                                        GroupName="FeedbackRating"
                                        Text="2" />

                                    <span>Poor
                                    </span>

                                </label>


                                <label class="rating-option">

                                    <asp:RadioButton
                                        ID="rbAverage"
                                        runat="server"
                                        GroupName="FeedbackRating"
                                        Text="3" />

                                    <span>Average
                                    </span>

                                </label>


                                <label class="rating-option">

                                    <asp:RadioButton
                                        ID="rbGood"
                                        runat="server"
                                        GroupName="FeedbackRating"
                                        Text="4" />

                                    <span>Good
                                    </span>

                                </label>


                                <label class="rating-option">

                                    <asp:RadioButton
                                        ID="rbExcellent"
                                        runat="server"
                                        GroupName="FeedbackRating"
                                        Text="5" />

                                    <span>Excellent
                                    </span>

                                </label>

                            </div>

                        </div>



                        <!-- SUBJECT -->

                        <div class="feedback-form-group">

                            <label for="txtSubject">
                                Subject

                                <span>*</span>

                            </label>


                            <div class="feedback-input-wrapper">

                                <i class="fa-solid fa-heading"></i>

                                <asp:TextBox
                                    ID="txtSubject"
                                    runat="server"
                                    CssClass="feedback-input"
                                    placeholder="Enter feedback subject">
                                </asp:TextBox>

                            </div>

                        </div>



                        <!-- MESSAGE -->

                        <div class="feedback-form-group">

                            <label for="txtMessage">
                                Your Feedback

                                <span>*</span>

                            </label>


                            <div class="feedback-input-wrapper textarea-wrapper">

                                <i class="fa-solid fa-comment"></i>


                                <asp:TextBox
                                    ID="txtMessage"
                                    runat="server"
                                    CssClass="feedback-input feedback-textarea"
                                    TextMode="MultiLine"
                                    Rows="6"
                                    placeholder="Write your feedback or suggestion here...">
                                </asp:TextBox>

                            </div>

                        </div>



                        <!-- BUTTONS -->

                        <div class="feedback-form-actions">




                            <asp:Button
                                ID="btnReset"
                                runat="server"
                                Text="Clear"
                                CssClass="feedback-reset-button"
                                CausesValidation="false"
                                OnClick="btnReset_Click" />


                            <asp:Label
                                ID="lblFeedbackMessage"
                                runat="server"
                                CssClass="feedback-message"
                                Visible="false">
                            </asp:Label>


                            <asp:Button
                                ID="btnSubmitFeedback"
                                runat="server"
                                Text="Submit Feedback"
                                CssClass="feedback-submit-button"
                                OnClick="btnSubmitFeedback_Click" />

                        </div>


                    </div>

                </div>



                <!-- =================================================
                     FEEDBACK INFORMATION
                ================================================== -->

                <div class="feedback-side">


                    <!-- WHY FEEDBACK -->

                    <div class="feedback-side-card">

                        <div class="feedback-side-icon">

                            <i class="fa-solid fa-lightbulb"></i>

                        </div>


                        <h2>Why Your Feedback Matters
                        </h2>


                        <p>
                            Your feedback helps JanVoice identify
                            areas that need improvement and build
                            better civic services.
                        </p>


                        <div class="feedback-benefit-list">


                            <div class="feedback-benefit-item">

                                <span>
                                    <i class="fa-solid fa-check"></i>
                                </span>

                                <p>
                                    Improve public services
                                </p>

                            </div>


                            <div class="feedback-benefit-item">

                                <span>
                                    <i class="fa-solid fa-check"></i>
                                </span>

                                <p>
                                    Improve citizen experience
                                </p>

                            </div>


                            <div class="feedback-benefit-item">

                                <span>
                                    <i class="fa-solid fa-check"></i>
                                </span>

                                <p>
                                    Identify service problems
                                </p>

                            </div>


                            <div class="feedback-benefit-item">

                                <span>
                                    <i class="fa-solid fa-check"></i>
                                </span>

                                <p>
                                    Build a better community
                                </p>

                            </div>

                        </div>

                    </div>



                    <!-- FEEDBACK GUIDELINES -->

                    <div class="feedback-side-card guidelines-card">

                        <div class="feedback-side-icon">

                            <i class="fa-solid fa-list-check"></i>

                        </div>


                        <h2>Feedback Guidelines
                        </h2>


                        <div class="feedback-guideline">

                            <span>01
                            </span>

                            <p>
                                Keep your feedback clear and
                                constructive.
                            </p>

                        </div>


                        <div class="feedback-guideline">

                            <span>02
                            </span>

                            <p>
                                Provide accurate information.
                            </p>

                        </div>


                        <div class="feedback-guideline">

                            <span>03
                            </span>

                            <p>
                                Avoid submitting duplicate feedback.
                            </p>

                        </div>


                        <div class="feedback-guideline">

                            <span>04
                            </span>

                            <p>
                                Do not share sensitive personal
                                information.
                            </p>

                        </div>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 FEEDBACK PROCESS
            ====================================================== -->

            <div class="feedback-process-card">


                <div class="feedback-process-header">

                    <span class="feedback-section-badge">

                        <i class="fa-solid fa-route"></i>

                        HOW IT WORKS

                    </span>


                    <h2>Your Feedback Journey
                    </h2>


                    <p>
                        Every submitted feedback contributes
                        to continuous improvement.
                    </p>

                </div>



                <div class="feedback-process-grid">


                    <div class="feedback-process-item">

                        <div class="process-number">
                            01
                        </div>


                        <div class="process-icon">

                            <i class="fa-solid fa-pen"></i>

                        </div>


                        <h3>Submit
                        </h3>


                        <p>
                            Share your experience or suggestion
                            with us.
                        </p>

                    </div>



                    <div class="feedback-process-item">

                        <div class="process-number">
                            02
                        </div>


                        <div class="process-icon">

                            <i class="fa-solid fa-magnifying-glass"></i>

                        </div>


                        <h3>Review
                        </h3>


                        <p>
                            Your feedback is reviewed by the
                            concerned team.
                        </p>

                    </div>



                    <div class="feedback-process-item">

                        <div class="process-number">
                            03
                        </div>


                        <div class="process-icon">

                            <i class="fa-solid fa-gears"></i>

                        </div>


                        <h3>Improve
                        </h3>


                        <p>
                            Useful feedback helps improve
                            civic services.
                        </p>

                    </div>



                    <div class="feedback-process-item">

                        <div class="process-number">
                            04
                        </div>


                        <div class="process-icon">

                            <i class="fa-solid fa-city"></i>

                        </div>


                        <h3>Better Community
                        </h3>


                        <p>
                            Together we create better public
                            services for everyone.
                        </p>

                    </div>

                </div>

            </div>



            <!-- =====================================================
                 INFORMATION FOOTER
            ====================================================== -->

            <div class="feedback-information">

                <div>

                    <i class="fa-solid fa-circle-info"></i>

                    Please provide honest and constructive
                    feedback.

                </div>


                <div>

                    <i class="fa-solid fa-shield-halved"></i>

                    JanVoice Citizen Feedback

                </div>

            </div>


        </div>

    </section>

</asp:Content>
