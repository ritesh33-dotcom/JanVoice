<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="JanVoice.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/Contact.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <!--==================================
        CONTACT PAGE
===================================-->

    <section class="contact-section">

        <div class="container">

            <!-- Hero Section -->

            <div class="contact-header">

                <span class="section-badge">📞 Contact JanVoice</span>

                <h1>We'd Love To
                <span>Hear From You</span>
                </h1>

                <p>
                    Have questions, suggestions or need help regarding your complaint?
                Our team is always ready to assist you.
                </p>

            </div>

            <!-- Contact Cards -->

            <div class="contact-info">

                <div class="contact-card">

                    <div class="icon">📍</div>

                    <h3>Office Address</h3>

                    <p>
                        JanVoice Office<br />
                        Pune, Maharashtra<br />
                        India
                    </p>

                </div>

                <div class="contact-card">

                    <div class="icon">📞</div>

                    <h3>Phone</h3>

                    <p>
                        +91 9876543210
                    </p>

                </div>

                <div class="contact-card">

                    <div class="icon">📧</div>

                    <h3>Email</h3>

                    <p>
                        support@janvoice.in
                    </p>

                </div>

                <div class="contact-card">

                    <div class="icon">🕒</div>

                    <h3>Working Hours</h3>

                    <p>
                        Monday - Saturday<br />
                        9:00 AM - 6:00 PM
                    </p>

                </div>

            </div>

            <!-- Contact Form -->

            <div class="contact-container">

                <div class="contact-form">

                    <h2>Send Us A Message</h2>

                    <asp:TextBox
                        ID="txtName"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Full Name">
                    </asp:TextBox>

                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Email"
                        placeholder="Email Address">
                    </asp:TextBox>

                    <asp:TextBox
                        ID="txtPhone"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Phone Number">
                    </asp:TextBox>

                    <asp:TextBox
                        ID="txtSubject"
                        runat="server"
                        CssClass="form-control"
                        placeholder="Subject">
                    </asp:TextBox>

                    <asp:TextBox
                        ID="txtMessage"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="6"
                        placeholder="Write your message here...">
                    </asp:TextBox>

                    <asp:Button
                        ID="btnSend"
                        runat="server"
                        Text="Send Message"
                        CssClass="send-btn"
                        OnClick="btnSend_Click" />
                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="message-label">
                    </asp:Label>

                </div>

                <!-- Google Map -->

                <div class="contact-map">

                    <iframe
                        src="https://www.google.com/maps?q=Pune&output=embed"
                        loading="lazy"></iframe>

                </div>

            </div>

            <!-- FAQ -->

            <div class="faq-section">

                <h2>Frequently Asked Questions</h2>

                <div class="faq-item">
                    <h4>How can I report an issue?</h4>
                    <p>Go to the Report Issue page and submit your complaint with location and image.</p>
                </div>

                <div class="faq-item">
                    <h4>How can I track my complaint?</h4>
                    <p>Login to your account and open your dashboard to view complaint status.</p>
                </div>

                <div class="faq-item">
                    <h4>Who resolves complaints?</h4>
                    <p>Concerned government officers are responsible for resolving civic complaints.</p>
                </div>

            </div>

        </div>

    </section>



</asp:Content>
