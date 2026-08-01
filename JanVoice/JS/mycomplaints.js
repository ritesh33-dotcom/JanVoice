// ===========================================
// JANVOICE - MY COMPLAINTS
// ===========================================

document.addEventListener("DOMContentLoaded", function () {

    //-----------------------------
    // Controls
    //-----------------------------

    const searchBox =
        document.getElementById("<%= txtSearch.ClientID %>");

    const statusFilter =
        document.getElementById("<%= ddlStatus.ClientID %>");

    const cards =
        document.querySelectorAll(".complaint-card");

    //-----------------------------
    // Search + Filter
    //-----------------------------

    function filterComplaints() {

        const keyword =
            searchBox.value.toLowerCase();

        const status =
            statusFilter.value.toLowerCase();

        cards.forEach(function (card) {

            const title =
                card.querySelector("h3").innerText.toLowerCase();

            const description =
                card.querySelector(".description").innerText.toLowerCase();

            const badge =
                card.querySelector(".status-badge").innerText.toLowerCase();

            const matchSearch =
                title.includes(keyword) ||
                description.includes(keyword);

            const matchStatus =
                status === "" || badge === status;

            if (matchSearch && matchStatus) {

                card.style.display = "flex";

            }
            else {

                card.style.display = "none";

            }

        });

    }

    searchBox.addEventListener("keyup", filterComplaints);

    statusFilter.addEventListener("change", filterComplaints);

    //-----------------------------
    // Counter Animation
    //-----------------------------

    const counters =
        document.querySelectorAll(".stat-card h2");

    counters.forEach(function (counter) {

        const target =
            parseInt(counter.innerText);

        let current = 0;

        const speed = 20;

        const timer = setInterval(function () {

            current++;

            counter.innerText = current;

            if (current >= target) {

                clearInterval(timer);

            }

        }, speed);

    });

    //-----------------------------
    // Card Hover Animation
    //-----------------------------

    cards.forEach(function (card) {

        card.addEventListener("mouseenter", function () {

            card.style.transform = "translateY(-8px)";

        });

        card.addEventListener("mouseleave", function () {

            card.style.transform = "";

        });

    });

});