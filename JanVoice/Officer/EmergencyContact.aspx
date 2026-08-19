<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Officer.Master" AutoEventWireup="true" CodeBehind="EmergencyContact.aspx.cs" Inherits="JanVoice.Officer.EmergencyContact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../CSS/EmergencyContact.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- =========================================================
         EMERGENCY CONTACT PAGE
    ========================================================== -->

    <section class="emergency-page">

        <div class="emergency-container">


            <!-- =====================================================
                 PAGE HERO
            ====================================================== -->

            <div class="emergency-hero">

                <div class="emergency-hero-content">

                    <span class="emergency-badge">

                        <i class="fa-solid fa-phone-volume"></i>

                        EMERGENCY SERVICES

                    </span>


                    <h1>Emergency Contacts
                    </h1>


                    <p>
                        Quickly access important emergency departments
                        and essential public services when immediate
                        assistance is required.
                    </p>

                </div>


                <div class="emergency-hero-icon">

                    <i class="fa-solid fa-triangle-exclamation"></i>

                </div>

            </div>



            <!-- =====================================================
                 EMERGENCY NOTICE
            ====================================================== -->

            <div class="emergency-alert">

                <div class="emergency-alert-icon">

                    <i class="fa-solid fa-circle-exclamation"></i>

                </div>


                <div class="emergency-alert-content">

                    <strong>Emergency Assistance
                    </strong>

                    <p>
                        Use these contacts only for genuine emergencies
                        or situations requiring immediate assistance.
                    </p>

                </div>

            </div>



            <!-- =====================================================
                 QUICK EMERGENCY NUMBERS
            ====================================================== -->

            <div class="emergency-section-header">

                <div>

                    <span class="emergency-section-badge">

                        <i class="fa-solid fa-bolt"></i>

                        QUICK ACCESS

                    </span>


                    <h2>Emergency Helplines
                    </h2>


                    <p>
                        Important emergency numbers for immediate
                        assistance.
                    </p>

                </div>

            </div>



            <!-- =====================================================
                 EMERGENCY CONTACT GRID
            ====================================================== -->

            <div class="emergency-contact-grid">


                <!-- =================================================
                     POLICE
                ================================================== -->

                <div class="emergency-contact-card police-card">

                    <div class="emergency-contact-top">

                        <div class="emergency-contact-icon">

                            <i class="fa-solid fa-shield-halved"></i>

                        </div>


                        <span class="emergency-status">

                            <span class="status-dot"></span>

                            Available

                        </span>

                    </div>


                    <div class="emergency-contact-content">

                        <span class="emergency-department">LAW & ORDER
                        </span>


                        <h3>Police
                        </h3>


                        <p>
                            For crimes, public safety threats,
                            accidents and immediate security assistance.
                        </p>

                    </div>


                    <div class="emergency-contact-number">

                        <span>Emergency Number
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblPoliceNumber"
                                runat="server"
                                Text="112">
                            </asp:Label>
                        </strong>

                    </div>


                    <a
                        href="tel:112"
                        class="emergency-call-button">

                        <i class="fa-solid fa-phone"></i>

                        Call Now

                    </a>

                </div>



                <!-- =================================================
                     AMBULANCE
                ================================================== -->

                <div class="emergency-contact-card ambulance-card">

                    <div class="emergency-contact-top">

                        <div class="emergency-contact-icon">

                            <i class="fa-solid fa-truck-medical"></i>

                        </div>


                        <span class="emergency-status">

                            <span class="status-dot"></span>

                            Available

                        </span>

                    </div>


                    <div class="emergency-contact-content">

                        <span class="emergency-department">MEDICAL EMERGENCY
                        </span>


                        <h3>Ambulance
                        </h3>


                        <p>
                            For medical emergencies, accidents and
                            urgent patient transportation.
                        </p>

                    </div>


                    <div class="emergency-contact-number">

                        <span>Emergency Number
                        </span>

                        <strong>
                            <asp:Label
                                ID="lblAmbulanceNumber"
                                runat="server"
                                Text="108">
                            </asp:Label>
                        </strong>

                    </div>


                    <a
                        href="tel:108"
                        class="emergency-call-button">

                        <i class="fa-solid fa-phone"></i>

                        Call Now

                    </a>

                </div>



                <!-- =================================================
                     FIRE & RESCUE
                ================================================== -->

                <div class="emergency-contact-card fire-card">

                    <div class="emergency-contact-top">

                        <div class="emergency-contact-icon">

                            <i class="fa-solid fa-fire-extinguisher"></i>

                        </div>


                        <span class="emergency-status">

                            <span class="status-dot"></span>

                            Available

                        </span>

                    </div>


                    <div class="emergency-contact-content">

                        <span class="emergency-department">FIRE & RESCUE
                        </span>


                        <h3>Fire & Rescue
                        </h3>


                        <p>
                            For fire incidents, rescue operations
                            and hazardous emergency situations.
                        </p>

                    </div>


                    <div class="emergency-contact-number">

                        <span>Emergency Number
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblFireNumber"
                                runat="server"
                                Text="101">
                            </asp:Label>

                        </strong>

                    </div>


                    <a
                        href="tel:101"
                        class="emergency-call-button">

                        <i class="fa-solid fa-phone"></i>

                        Call Now

                    </a>

                </div>



                <!-- =================================================
                     DISASTER MANAGEMENT
                ================================================== -->

                <div class="emergency-contact-card disaster-card">

                    <div class="emergency-contact-top">

                        <div class="emergency-contact-icon">

                            <i class="fa-solid fa-house-flood-water"></i>

                        </div>


                        <span class="emergency-status">

                            <span class="status-dot"></span>

                            Available

                        </span>

                    </div>


                    <div class="emergency-contact-content">

                        <span class="emergency-department">DISASTER RESPONSE
                        </span>


                        <h3>Disaster Management
                        </h3>


                        <p>
                            For floods, earthquakes, natural disasters
                            and large-scale emergency situations.
                        </p>

                    </div>


                    <div class="emergency-contact-number">

                        <span>Emergency Number
                        </span>

                        <strong>

                            <asp:Label
                                ID="lblDisasterNumber"
                                runat="server"
                                Text="1078">
                            </asp:Label>

                        </strong>

                    </div>


                    <a
                        href="tel:1078"
                        class="emergency-call-button">

                        <i class="fa-solid fa-phone"></i>

                        Call Now

                    </a>

                </div>


            </div>



            <!-- =====================================================
                 PUBLIC SERVICES
            ====================================================== -->

            <div class="emergency-section-header services-header">

                <div>

                    <span class="emergency-section-badge">

                        <i class="fa-solid fa-building"></i>

                        PUBLIC SERVICES

                    </span>


                    <h2>Essential Department Contacts
                    </h2>


                    <p>
                        Contact information for important civic
                        and public service departments.
                    </p>

                </div>

            </div>



            <!-- =====================================================
                 PUBLIC SERVICE CONTACT GRID
            ====================================================== -->

            <div class="service-contact-grid">


                <!-- =================================================
                     MUNICIPAL CORPORATION
                ================================================== -->

                <div class="service-contact-card">

                    <div class="service-contact-icon">

                        <i class="fa-solid fa-city"></i>

                    </div>


                    <div class="service-contact-content">

                        <span>CIVIC ADMINISTRATION
                        </span>


                        <h3>Municipal Corporation
                        </h3>


                        <p>
                            Civic complaints, sanitation, roads,
                            public infrastructure and municipal services.
                        </p>


                        <strong>

                            <asp:Label
                                ID="lblMunicipalNumber"
                                runat="server"
                                Text="1800-103-0222">
                            </asp:Label>

                        </strong>

                    </div>


                    <a
                        href="tel:18001030222"
                        class="service-call-button">

                        <i class="fa-solid fa-phone"></i>

                    </a>

                </div>



                <!-- =================================================
                     ELECTRICITY
                ================================================== -->

                <div class="service-contact-card">

                    <div class="service-contact-icon">

                        <i class="fa-solid fa-bolt"></i>

                    </div>


                    <div class="service-contact-content">

                        <span>ELECTRICITY SERVICES
                        </span>


                        <h3>Electricity Emergency
                        </h3>


                        <p>
                            Power failures, electrical hazards,
                            damaged lines and electricity emergencies.
                        </p>


                        <strong>

                            <asp:Label
                                ID="lblElectricityNumber"
                                runat="server"
                                Text="1912">
                            </asp:Label>

                        </strong>

                    </div>


                    <a
                        href="tel:1912"
                        class="service-call-button">

                        <i class="fa-solid fa-phone"></i>

                    </a>

                </div>



                <!-- =================================================
                     WATER
                ================================================== -->

                <div class="service-contact-card">

                    <div class="service-contact-icon">

                        <i class="fa-solid fa-droplet"></i>

                    </div>


                    <div class="service-contact-content">

                        <span>WATER SERVICES
                        </span>


                        <h3>Water Department
                        </h3>


                        <p>
                            Water supply issues, pipeline problems,
                            leakage and emergency water services.
                        </p>


                        <strong>

                            <asp:Label
                                ID="lblWaterNumber"
                                runat="server"
                                Text="1800-121-4545">
                            </asp:Label>

                        </strong>

                    </div>


                    <a
                        href="tel:18001214545"
                        class="service-call-button">

                        <i class="fa-solid fa-phone"></i>

                    </a>

                </div>



                <!-- =================================================
                     HOSPITAL
                ================================================== -->

                <div class="service-contact-card">

                    <div class="service-contact-icon">

                        <i class="fa-solid fa-hospital"></i>

                    </div>


                    <div class="service-contact-content">

                        <span>HEALTH SERVICES
                        </span>


                        <h3>Emergency Hospital
                        </h3>


                        <p>
                            Emergency medical care, trauma services
                            and urgent healthcare assistance.
                        </p>


                        <strong>

                            <asp:Label
                                ID="lblHospitalNumber"
                                runat="server"
                                Text="108">
                            </asp:Label>

                        </strong>

                    </div>


                    <a
                        href="tel:108"
                        class="service-call-button">

                        <i class="fa-solid fa-phone"></i>

                    </a>

                </div>


            </div>



            <!-- =====================================================
                 EMERGENCY GUIDELINES
            ====================================================== -->

            <div class="emergency-guidelines">


                <div class="guidelines-header">

                    <div class="guidelines-icon">

                        <i class="fa-solid fa-lightbulb"></i>

                    </div>


                    <div>

                        <h2>Emergency Guidelines
                        </h2>

                        <p>
                            Keep these important points in mind
                            during an emergency.
                        </p>

                    </div>

                </div>



                <div class="guidelines-grid">


                    <div class="guideline-item">

                        <span class="guideline-number">01
                        </span>

                        <div>

                            <strong>Stay Calm
                            </strong>

                            <p>
                                Stay calm and clearly explain the
                                emergency to the responding department.
                            </p>

                        </div>

                    </div>



                    <div class="guideline-item">

                        <span class="guideline-number">02
                        </span>

                        <div>

                            <strong>Share Your Location
                            </strong>

                            <p>
                                Provide your exact location or nearest
                                landmark to help responders reach you.
                            </p>

                        </div>

                    </div>



                    <div class="guideline-item">

                        <span class="guideline-number">03
                        </span>

                        <div>

                            <strong>Give Accurate Information
                            </strong>

                            <p>
                                Clearly describe what happened and
                                provide only accurate information.
                            </p>

                        </div>

                    </div>



                    <div class="guideline-item">

                        <span class="guideline-number">04
                        </span>

                        <div>

                            <strong>Follow Instructions
                            </strong>

                            <p>
                                Follow the instructions provided by
                                emergency response personnel.
                            </p>

                        </div>

                    </div>


                </div>

            </div>



            <!-- =====================================================
                 INFORMATION FOOTER
            ====================================================== -->

            <div class="emergency-information">

                <div>

                    <i class="fa-solid fa-circle-info"></i>

                    Emergency contacts should be used only
                    when immediate assistance is required.

                </div>


                <div>

                    <i class="fa-solid fa-shield-halved"></i>

                    JanVoice Emergency Services

                </div>

            </div>


        </div>

    </section>

</asp:Content>
