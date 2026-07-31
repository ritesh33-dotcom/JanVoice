document.addEventListener("DOMContentLoaded", function () {

    const menu = document.getElementById("menuToggle");

    const sidebar = document.querySelector(".sidebar");

    menu.addEventListener("click", function () {

        sidebar.classList.toggle("showSidebar");

    });

});