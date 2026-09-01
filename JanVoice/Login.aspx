<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="JanVoice.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <!--==================================
            LOGIN SECTION
    ===================================-->

    <section class="login-section">

        <div class="container">

            <div class="login-wrapper">

                <!--==================================
                        LEFT SIDE
                ===================================-->

                <div class="login-left">

                    <span class="section-badge">
                        🔐 Welcome Back
                    </span>

                    <h1>
                        Login to Continue
                        <span>Your Civic Journey</span>
                    </h1>

                    <p>
                        Access your JanVoice account to report civic
                        issues, support your community and track
                        complaint progress in real time.
                    </p>

                   

                </div>


                <!--==================================
                        RIGHT SIDE
                ===================================-->

                <div class="login-card">

                    <h2>
                        Sign In
                    </h2>

                    <p>
                        Welcome back! Please login to your account.
                    </p>


                    <!--==================================
                            EMAIL
                    ===================================-->

                    <div class="input-group">

                        <label for="<%= txtEmail.ClientID %>">
                            Email Address
                        </label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-envelope input-icon"></i>

                            <asp:TextBox
                                ID="txtEmail"
                                runat="server"
                                CssClass="input-box"
                                TextMode="Email"
                                placeholder="Enter your email">
                            </asp:TextBox>

                            <i class="fa-solid fa-circle-check success-icon"
                               id="emailSuccess">
                            </i>

                        </div>

                        <small class="error-text"
                               id="emailError">
                        </small>

                    </div>


                    <!--==================================
                            PASSWORD
                    ===================================-->

                    <div class="input-group">

                        <label for="<%= txtPassword.ClientID %>">
                            Password
                        </label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-lock input-icon"></i>

                            <asp:TextBox
                                ID="txtPassword"
                                runat="server"
                                CssClass="input-box"
                                TextMode="Password"
                                placeholder="Enter your password">
                            </asp:TextBox>

                            <!-- Show / Hide Password -->

                            <i class="fa-solid fa-eye toggle-password"
                               id="togglePassword"
                               title="Show password">
                            </i>

                        </div>

                        <small class="error-text"
                               id="passwordError">
                        </small>

                    </div>


                    <!--==================================
                            REMEMBER + FORGOT PASSWORD
                    ===================================-->

                    <div class="login-options">

                        <label>

                            <asp:CheckBox
                                ID="chkRemember"
                                runat="server" />

                            Remember Me

                        </label>

                        <a href="ForgotPassword.aspx">
                            Forgot Password?
                        </a>

                    </div>


                    <!--==================================
                            LOGIN BUTTON
                    ===================================-->

                    <asp:Button
                        ID="loginButton"
                        runat="server"
                        CssClass="login-btn"
                        Text="Sign In"
                        OnClick="loginButton_Click" />


                    <!--==================================
                            REGISTER LINK
                    ===================================-->

                    <div class="register-link">

                        Don't have an account?

                        <a href="Register.aspx">
                            Create Account
                        </a>

                    </div>

                </div>

            </div>

        </div>

    </section>


    <!--==================================
            LOGIN JAVASCRIPT
    ===================================-->

    <script>

        document.addEventListener("DOMContentLoaded", function () {

            /* ==========================================
               GET ELEMENTS
            ========================================== */

            const txtEmail =
                document.getElementById("<%= txtEmail.ClientID %>");

            const txtPassword =
                document.getElementById("<%= txtPassword.ClientID %>");

            const togglePassword =
                document.getElementById("togglePassword");

            const emailError =
                document.getElementById("emailError");

            const passwordError =
                document.getElementById("passwordError");

            const loginButton =
                document.getElementById("<%= loginButton.ClientID %>");


            /* ==========================================
               SHOW / HIDE PASSWORD
            ========================================== */

            if (togglePassword) {

                togglePassword.addEventListener("click", function () {

                    if (txtPassword.type === "password") {

                        /* Show password */

                        txtPassword.type = "text";

                        togglePassword.classList.remove("fa-eye");

                        togglePassword.classList.add("fa-eye-slash");

                        togglePassword.setAttribute(
                            "title",
                            "Hide password"
                        );

                    }

                    else {

                        /* Hide password */

                        txtPassword.type = "password";

                        togglePassword.classList.remove("fa-eye-slash");

                        togglePassword.classList.add("fa-eye");

                        togglePassword.setAttribute(
                            "title",
                            "Show password"
                        );

                    }

                });

            }


            /* ==========================================
               EMAIL VALIDATION
            ========================================== */

            txtEmail.addEventListener("input", function () {

                if (txtEmail.value.trim() === "") {

                    emailError.textContent =
                        "Please enter your email.";

                }

                else {

                    const emailPattern =
                        /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                    if (!emailPattern.test(txtEmail.value.trim())) {

                        emailError.textContent =
                            "Please enter a valid email address.";

                    }

                    else {

                        emailError.textContent = "";

                    }

                }

            });


            /* ==========================================
               PASSWORD VALIDATION
            ========================================== */

            txtPassword.addEventListener("input", function () {

                if (txtPassword.value.trim() === "") {

                    passwordError.textContent =
                        "Please enter your password.";

                }

                else {

                    passwordError.textContent = "";

                }

            });


            /* ==========================================
               ENTER KEY
            ========================================== */

            document.addEventListener("keydown", function (e) {

                if (e.key === "Enter") {

                    /*
                       Prevent accidental double submission
                       if the button is already disabled.
                    */

                    if (!loginButton.disabled) {

                        loginButton.click();

                    }

                }

            });


            /* ==========================================
               INITIAL STATE
            ========================================== */

            if (txtPassword) {

                txtPassword.type = "password";

            }

        });

    </script>


</asp:Content>
