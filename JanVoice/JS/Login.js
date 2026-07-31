const password = document.getElementById("togglePassword");

const txtPassword = document.getElementById("<%= txtPassword.ClientID %>");

password.addEventListener("click", () => {

    if (txtPassword.type === "password") {

        txtPassword.type = "text";

        password.classList.remove("fa-eye");

        password.classList.add("fa-eye-slash");

    }

    else {

        txtPassword.type = "password";

        password.classList.remove("fa-eye-slash");

        password.classList.add("fa-eye");

    }

});