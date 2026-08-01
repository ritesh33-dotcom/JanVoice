document.addEventListener("DOMContentLoaded", function () {

    //=========================================
    // GET CONTROLS
    //=========================================

    const uploadBox = document.getElementById("uploadBox");

    const browseBtn = document.getElementById("browseBtn");

    const fileUpload = document.getElementById(window.reportIssueIds.fileUpload);

    const previewContainer = document.getElementById("imagePreview");

    const description = document.getElementById(window.reportIssueIds.description);

    const charCount = document.getElementById("charCount");

    const locationButton = document.getElementById("btnLocation");

    const locationStatus = document.getElementById("locationStatus");

    const latitude = document.getElementById(window.reportIssueIds.latitude);

    const longitude = document.getElementById(window.reportIssueIds.longitude);

    //=========================================
    // CHARACTER COUNTER
    //=========================================

    description.addEventListener("input", function () {

        charCount.innerHTML =
            description.value.length + " / 500 Characters";

    });

    //=========================================
    // BROWSE BUTTON
    //=========================================

    browseBtn.addEventListener("click", function (e) {

        e.preventDefault();

        fileUpload.click();

    });

    //=========================================
    // CLICK UPLOAD BOX
    //=========================================

    uploadBox.addEventListener("click", function () {

        fileUpload.click();

    });

    //=========================================
    // DRAG EVENTS
    //=========================================

    uploadBox.addEventListener("dragover", function (e) {

        e.preventDefault();

        uploadBox.style.borderColor = "#60A5FA";

        uploadBox.style.background = "#1E293B";

    });

    uploadBox.addEventListener("dragleave", function () {

        uploadBox.style.borderColor = "#3B82F6";

        uploadBox.style.background = "#111827";

    });

    uploadBox.addEventListener("drop", function (e) {

        e.preventDefault();

        uploadBox.style.borderColor = "#3B82F6";

        uploadBox.style.background = "#111827";

        fileUpload.files = e.dataTransfer.files;

        previewImages();

    });

    //=========================================
    // IMAGE SELECTION
    //=========================================

    fileUpload.addEventListener("change", previewImages);

    function previewImages() {

        previewContainer.innerHTML = "";

        if (fileUpload.files.length === 0)
            return;

        Array.from(fileUpload.files).forEach(function (file) {

            // File Type

            if (!file.type.startsWith("image/")) {

                alert(file.name + " is not an image.");

                return;

            }

            // Max Size 2MB

            if (file.size > 2 * 1024 * 1024) {

                alert(file.name + " exceeds 2MB.");

                return;

            }

            const reader = new FileReader();

            reader.onload = function (e) {

                const img = document.createElement("img");

                img.src = e.target.result;

                img.className = "preview-image";

                previewContainer.appendChild(img);

            };

            reader.readAsDataURL(file);

        });

    }

    //=========================================
    // CURRENT LOCATION
    //=========================================

    locationButton.addEventListener("click", function () {

        if (!navigator.geolocation) {

            locationStatus.innerHTML =
                "Geolocation is not supported.";

            return;

        }

        locationStatus.innerHTML =
            "Getting your location...";

        navigator.geolocation.getCurrentPosition(

            function (position) {

                latitude.value =
                    position.coords.latitude;

                longitude.value =
                    position.coords.longitude;

                locationStatus.innerHTML =
                    "✅ Location Captured Successfully";

            },

            function () {

                locationStatus.innerHTML =
                    "❌ Unable to fetch location.";

            }

        );

    });

});


//=========================================
// CLIENT VALIDATION
//=========================================

function validateComplaint() {

    const title =
        document.getElementById("<%= txtTitle.ClientID %>");

    const category =
        document.getElementById("<%= ddlCategory.ClientID %>");

    const ward =
        document.getElementById("<%= ddlWard.ClientID %>");

    const description =
        document.getElementById("<%= txtDescription.ClientID %>");

    if (title.value.trim() === "") {

        alert("Please enter Complaint Title.");

        title.focus();

        return false;

    }

    if (category.selectedIndex === 0) {

        alert("Please select Category.");

        category.focus();

        return false;

    }

    if (ward.selectedIndex === 0) {

        alert("Please select Ward.");

        ward.focus();

        return false;

    }

    if (description.value.trim() === "") {

        alert("Please enter Description.");

        description.focus();

        return false;

    }

    return true;

}