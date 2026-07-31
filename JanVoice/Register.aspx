<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="JanVoice.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!--==================================
        REGISTER SECTION
===================================-->

    <section class="register-section">

        <div class="container">

            <div class="register-wrapper">

                <!-- Left Side -->

                <div class="register-left">

                    <span class="section-badge">🚀 Join JanVoice

                </span>

                    <h1>Become Part of a
                   
                        <span>Smarter Community</span>

                    </h1>

                    <p>
                        Join thousands of citizens working together
                    to report civic issues, support their
                    neighborhood, and create cleaner, safer,
                    smarter communities.

               
                    </p>

                    <img src="Assets/Images/register-hero.png"
                        class="register-image"
                        alt="Register Illustration" />

                </div>

                <!-- Right Side -->

                <div class="register-card">

                    <h2>Create Account

                </h2>

                    <p>
                        Start your civic journey today.

               
                    </p>

                    <!-- Progress -->

                    <div class="progress-area">

                        <div class="progress-bar">

                            <div class="progress-fill" id="progressFill">
                            </div>

                        </div>

                        <span>Complete your profile

                    </span>

                    </div>

                    <!-- Name -->

                    <div class="input-group">

                        <label>Full Name</label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-user input-icon"></i>

                            <asp:TextBox
                                ID="txtName"
                                runat="server"
                                CssClass="input-box"
                                placeholder="Enter your full name">
                            </asp:TextBox>

                            <i class="fa-solid fa-circle-check success-icon"></i>

                        </div>

                        <small id="nameError" class="error-text"></small>

                    </div>

                    <!-- Email -->

                    <div class="input-group">

                        <label>Email Address</label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-envelope input-icon"></i>

                            <asp:TextBox
                                ID="txtEmail"
                                runat="server"
                                CssClass="input-box"
                                TextMode="Email"
                                placeholder="Enter your email">
                            </asp:TextBox>

                            <i class="fa-solid fa-circle-check success-icon"></i>

                        </div>

                        <small id="emailError" class="error-text"></small>

                    </div>

                    <!-- Mobile -->
                    <div class="input-group">

                        <label>Mobile Number</label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-phone input-icon"></i>

                            <asp:TextBox
                                ID="txtMobile"
                                runat="server"
                                CssClass="input-box"
                                MaxLength="10"
                                placeholder="Enter mobile number">
                            </asp:TextBox>

                            <i class="fa-solid fa-circle-check success-icon"></i>

                        </div>

                        <small id="mobileError" class="error-text"></small>

                    </div>
                    <!-- Ward -->

                    <div class="input-group">

                        <label>
                            Select Ward

                   
                        </label>

                        <asp:DropDownList
                            ID="ddlWard"
                            runat="server"
                            CssClass="input-box">

                            <asp:ListItem>
                            Select Ward
                        </asp:ListItem>

                            <asp:ListItem>
                            Ward 1
                        </asp:ListItem>

                            <asp:ListItem>
                            Ward 2
                        </asp:ListItem>

                            <asp:ListItem>
                            Ward 3
                        </asp:ListItem>

                        </asp:DropDownList>

                    </div>

                    <!-- Password -->

                    <div class="input-group">

                        <label>Password</label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-lock input-icon"></i>

                            <asp:TextBox
                                ID="txtPassword"
                                runat="server"
                                CssClass="input-box"
                                TextMode="Password"
                                placeholder="Create Password">
                            </asp:TextBox>

                            <i class="fa-solid fa-eye toggle-password"
                                id="togglePassword"></i>

                        </div>

                        <div class="strength-meter">

                            <div id="strengthBar"></div>

                        </div>

                        <small id="passwordStrength">Password Strength

                        </small>

                        <small id="passwordError" class="error-text"></small>

                    </div>

                    <!-- Confirm Password -->

                    <div class="input-group">

                        <label>
                            Confirm Password

                        </label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-lock input-icon"></i>

                            <asp:TextBox
                                ID="txtConfirmPassword"
                                runat="server"
                                CssClass="input-box"
                                TextMode="Password"
                                placeholder="Confirm Password">
                            </asp:TextBox>

                            <i class="fa-solid fa-eye"
                                id="toggleConfirm"></i>

                        </div>

                        <small id="confirmError"
                            class="error-text"></small>

                    </div>

                    <!-- Terms -->

                    <div class="terms">

                        <asp:CheckBox
                            ID="chkTerms"
                            runat="server" />

                        I agree to the

                   

                        <a href="#">Terms & Conditions

                    </a>

                    </div>

                    <!-- Button -->

                    <asp:Button
                        ID="btnRegister"
                        runat="server"
                        Text="Create Account"
                        CssClass="register-btn"
                        OnClick="btnRegister_Click" />

                    <!-- Login -->

                    <div class="login-link">
                        Already have an account?

                   

                        <a href="Login.aspx">Sign In

                    </a>

                    </div>

                </div>

            </div>

        </div>

    </section>

    <script>

        document.addEventListener("DOMContentLoaded", function () {

            const name = document.getElementById("<%= txtName.ClientID %>");
    const email = document.getElementById("<%= txtEmail.ClientID %>");
    const mobile = document.getElementById("<%= txtMobile.ClientID %>");
    const password = document.getElementById("<%= txtPassword.ClientID %>");
    const confirm = document.getElementById("<%= txtConfirmPassword.ClientID %>");

    const togglePassword = document.getElementById("togglePassword");
    const toggleConfirm = document.getElementById("toggleConfirm");

    const progress = document.getElementById("progressFill");

    const strength = document.getElementById("passwordStrength");
    const strengthBar = document.getElementById("strengthBar");

    const loader = document.getElementById("loader");
    const btn = document.getElementById("registerButton");
    const btnText = document.getElementById("btnText");

    /*==========================
    SHOW PASSWORD
    ==========================*/

    togglePassword.onclick = function () {

        if (password.type === "password") {

            password.type = "text";

            this.classList.replace("fa-eye", "fa-eye-slash");

        }

        else {

            password.type = "password";

            this.classList.replace("fa-eye-slash", "fa-eye");

        }

    };

    toggleConfirm.onclick = function () {

        if (confirm.type === "password") {

            confirm.type = "text";

            this.classList.replace("fa-eye", "fa-eye-slash");

        }

        else {

            confirm.type = "password";

            this.classList.replace("fa-eye-slash", "fa-eye");

        }

    };

    /*==========================
    PASSWORD STRENGTH
    ==========================*/

    password.addEventListener("keyup", function () {

        let value = password.value;

        let score = 0;

        if (value.length >= 8) score++;

        if (/[A-Z]/.test(value)) score++;

        if (/[0-9]/.test(value)) score++;

        if (/[^A-Za-z0-9]/.test(value)) score++;

        if (score == 1) {

            strength.innerHTML = "Weak Password";

            strength.style.color = "#EF4444";

            strengthBar.style.width = "25%";

            strengthBar.style.background = "#EF4444";

        }

        else if (score == 2) {

            strength.innerHTML = "Fair Password";

            strength.style.color = "#F59E0B";

            strengthBar.style.width = "50%";

            strengthBar.style.background = "#F59E0B";

        }

        else if (score == 3) {

            strength.innerHTML = "Good Password";

            strength.style.color = "#3B82F6";

            strengthBar.style.width = "75%";

            strengthBar.style.background = "#3B82F6";

        }

        else if (score == 4) {

            strength.innerHTML = "Strong Password";

            strength.style.color = "#22C55E";

            strengthBar.style.width = "100%";

            strengthBar.style.background = "#22C55E";

        }

    });

    /*==========================
    CONFIRM PASSWORD
    ==========================*/

    confirm.addEventListener("keyup", function () {

        const error = document.getElementById("confirmError");

        if (confirm.value !== password.value) {

            error.innerHTML = "Passwords do not match";

        }

        else {

            error.innerHTML = "";

        }

    });

    /*==========================
    EMAIL VALIDATION
    ==========================*/

    email.addEventListener("blur", function () {

        const error = document.getElementById("emailError");

        const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (email.value != "" && !pattern.test(email.value)) {

            error.innerHTML = "Invalid email address";

        }

        else {

            error.innerHTML = "";

        }

    });

    /*==========================
    MOBILE
    ==========================*/

    mobile.addEventListener("keyup", function () {

        const error = document.getElementById("mobileError");

        if (mobile.value.length > 0 && mobile.value.length < 10) {

            error.innerHTML = "Enter 10 digit mobile number";

        }

        else {

            error.innerHTML = "";

        }

    });

    /*==========================
    PROGRESS BAR
    ==========================*/

    function updateProgress() {

        let total = 6;

        let filled = 0;

        if (name.value != "") filled++;
        if (email.value != "") filled++;
        if (mobile.value != "") filled++;
        if (password.value != "") filled++;
        if (confirm.value != "") filled++;
        if (document.getElementById("<%= chkTerms.ClientID %>").checked) filled++;

        progress.style.width = (filled / total * 100) + "%";

    }

    document.querySelectorAll("input").forEach(function (input) {

        input.addEventListener("keyup", updateProgress);

        input.addEventListener("change", updateProgress);

    });

    /*==========================
    REGISTER BUTTON
    ==========================*/

    btn.onclick = function () {

        btn.disabled = true;

        btnText.style.display = "none";

        loader.style.display = "inline-block";

        setTimeout(function () {

            loader.style.display = "none";

            btnText.style.display = "inline";

            btn.disabled = false;

            alert("Registration UI Completed ✅");

        }, 2000);

    };

    /*==========================
    ENTER KEY
    ==========================*/

    document.addEventListener("keydown", function (e) {

        if (e.key === "Enter") {

            btn.click();

        }

    });

});

    </script>




</asp:Content>
