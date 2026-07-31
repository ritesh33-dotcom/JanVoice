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

            <!-- LEFT SIDE -->

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

                <img src="Assets/Images/login-hero.png"
                    alt="Login Illustration"
                    class="login-image"/>

            </div>

            <!-- RIGHT SIDE -->

            <div class="login-card">

                <h2>

                    Sign In

                </h2>

                <p>

                    Welcome back! Please login to your account.

                </p>

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
            placeholder="      Enter your email">
        </asp:TextBox>

        <i class="fa-solid fa-circle-check success-icon"></i>

    </div>

    <small class="error-text" id="emailError">

    </small>

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
            placeholder="      Enter your password">
        </asp:TextBox>

        <i class="fa-solid fa-eye toggle-password"
           id="togglePassword">
        </i>

    </div>

    <small class="error-text" id="passwordError">

    </small>

</div>

                <!-- Remember -->

                <div class="login-options">

                    <label>

                        <asp:CheckBox
                            ID="chkRemember"
                            runat="server"/>

                        Remember Me

                    </label>

                    <a href="ForgotPassword.aspx">

                        Forgot Password?

                    </a>

                </div>

                <!-- Login Button -->
<asp:Button
    ID="loginButton"
    runat="server"
    CssClass="login-btn"
    Text="Sign In"
    OnClick="loginButton_Click"
/>

                <!-- Register -->

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





    <script>

document.addEventListener("DOMContentLoaded",function(){

const txtEmail=document.getElementById("<%= txtEmail.ClientID %>");

const txtPassword=document.getElementById("<%= txtPassword.ClientID %>");

const emailError=document.getElementById("emailError");

const passwordError=document.getElementById("passwordError");

const toggle=document.getElementById("togglePassword");

const loader=document.getElementById("loader");

const button=document.getElementById("loginButton");

const buttonText=document.getElementById("buttonText");

/* Show / Hide Password */

toggle.onclick=function(){

if(txtPassword.type==="password"){

txtPassword.type="text";

toggle.classList.replace("fa-eye","fa-eye-slash");

}
else{

txtPassword.type="password";

toggle.classList.replace("fa-eye-slash","fa-eye");

}

};

/* Validation */

function validate(){

let valid=true;

emailError.textContent="";

passwordError.textContent="";

if(txtEmail.value.trim()===""){

emailError.textContent="Please enter your email.";

valid=false;

}

if(txtPassword.value.trim()===""){

passwordError.textContent="Please enter your password.";

valid=false;

}

return valid;

}

/* Enter Key */

document.addEventListener("keydown",function(e){

if(e.key==="Enter"){

button.click();

}

});


/* Temporary demo */

setTimeout(function(){

loader.style.display="none";

buttonText.style.display="inline";

button.disabled=false;

},2000);

};

});

</script>

</asp:Content>
