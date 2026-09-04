document.addEventListener("DOMContentLoaded", function () {

    // =========================================
    // GET CONTROLS
    // =========================================

    const uploadBox =
        document.getElementById("uploadBox");

    const browseBtn =
        document.getElementById("browseBtn");

    const fileUpload =
        document.getElementById(
            window.reportIssueIds.fileUpload
        );

    const previewContainer =
        document.getElementById("imagePreview");

    const description =
        document.getElementById(
            window.reportIssueIds.description
        );

    const charCount =
        document.getElementById("charCount");

    const locationButton =
        document.getElementById("btnLocation");

    const locationStatus =
        document.getElementById("locationStatus");

    const latitude =
        document.getElementById(
            window.reportIssueIds.latitude
        );

    const longitude =
        document.getElementById(
            window.reportIssueIds.longitude
        );


    // =========================================
    // CHARACTER COUNTER
    // =========================================

    if (description && charCount) {

        description.addEventListener("input", function () {

            charCount.innerHTML =
                description.value.length +
                " / 500 Characters";

        });

    }


    // =========================================
    // BROWSE BUTTON
    // =========================================

    if (browseBtn && fileUpload) {

        browseBtn.addEventListener("click", function (e) {

            e.preventDefault();

            fileUpload.click();

        });

    }


    // =========================================
    // CLICK UPLOAD BOX
    // =========================================

    if (uploadBox && fileUpload) {

        uploadBox.addEventListener("click", function () {

            fileUpload.click();

        });

    }


    // =========================================
    // DRAG OVER
    // =========================================

    if (uploadBox) {

        uploadBox.addEventListener("dragover", function (e) {

            e.preventDefault();

            uploadBox.style.borderColor = "#60A5FA";

            uploadBox.style.background = "#1E293B";

        });


        // =========================================
        // DRAG LEAVE
        // =========================================

        uploadBox.addEventListener("dragleave", function () {

            uploadBox.style.borderColor = "#3B82F6";

            uploadBox.style.background = "#111827";

        });


        // =========================================
        // DROP IMAGE
        // =========================================

        uploadBox.addEventListener("drop", function (e) {

            e.preventDefault();

            uploadBox.style.borderColor = "#3B82F6";

            uploadBox.style.background = "#111827";

            if (fileUpload) {

                fileUpload.files =
                    e.dataTransfer.files;

                previewImages();

            }

        });

    }


    // =========================================
    // IMAGE SELECTION
    // =========================================

    if (fileUpload) {

        fileUpload.addEventListener(
            "change",
            previewImages
        );

    }


    function previewImages() {

        if (!previewContainer || !fileUpload) {
            return;
        }

        previewContainer.innerHTML = "";

        if (fileUpload.files.length === 0) {
            return;
        }


        Array.from(fileUpload.files).forEach(
            function (file) {


                // =====================================
                // FILE TYPE VALIDATION
                // =====================================

                const allowedTypes = [
                    "image/jpeg",
                    "image/png"
                ];


                if (!allowedTypes.includes(file.type)) {

                    alert(
                        file.name +
                        " is not a valid image. " +
                        "Only JPG, JPEG and PNG are allowed."
                    );

                    return;

                }


                // =====================================
                // FILE SIZE VALIDATION
                // =====================================

                if (
                    file.size >
                    2 * 1024 * 1024
                ) {

                    alert(
                        file.name +
                        " exceeds the maximum size of 2 MB."
                    );

                    return;

                }


                // =====================================
                // IMAGE PREVIEW
                // =====================================

                const reader =
                    new FileReader();


                reader.onload =
                    function (e) {

                        const img =
                            document.createElement("img");

                        img.src =
                            e.target.result;

                        img.className =
                            "preview-image";

                        previewContainer.appendChild(
                            img
                        );

                    };


                reader.readAsDataURL(file);

            }
        );

    }


    // =========================================
    // CURRENT LOCATION
    // =========================================

    if (locationButton) {

        locationButton.addEventListener(
            "click",
            function () {


                // =====================================
                // CHECK GEOLOCATION SUPPORT
                // =====================================

                if (!navigator.geolocation) {

                    if (locationStatus) {

                        locationStatus.innerHTML =
                            "❌ Geolocation is not supported by your browser.";

                    }

                    return;

                }


                // =====================================
                // SHOW LOADING MESSAGE
                // =====================================

                if (locationStatus) {

                    locationStatus.innerHTML =
                        "Getting your location...";

                }


                // =====================================
                // GET CURRENT POSITION
                // =====================================

                navigator.geolocation.getCurrentPosition(

                    function (position) {


                        // =================================
                        // SAVE LATITUDE
                        // =================================

                        if (latitude) {

                            latitude.value =
                                position.coords.latitude;

                        }


                        // =================================
                        // SAVE LONGITUDE
                        // =================================

                        if (longitude) {

                            longitude.value =
                                position.coords.longitude;

                        }


                        // =================================
                        // SUCCESS MESSAGE
                        // =================================

                        if (locationStatus) {

                            locationStatus.innerHTML =
                                "✅ Location Captured Successfully";

                        }

                    },


                    function (error) {

                        if (!locationStatus) {
                            return;
                        }


                        switch (error.code) {

                            case error.PERMISSION_DENIED:

                                locationStatus.innerHTML =
                                    "❌ Location permission denied.";

                                break;


                            case error.POSITION_UNAVAILABLE:

                                locationStatus.innerHTML =
                                    "❌ Location information unavailable.";

                                break;


                            case error.TIMEOUT:

                                locationStatus.innerHTML =
                                    "❌ Location request timed out.";

                                break;


                            default:

                                locationStatus.innerHTML =
                                    "❌ Unable to fetch location.";

                                break;

                        }

                    },

                    {
                        enableHighAccuracy: true,
                        timeout: 10000,
                        maximumAge: 0
                    }

                );

            }
        );

    }

});


// =========================================
// CLIENT VALIDATION
// =========================================

function validateComplaint() {

    // =========================================
    // GET CONTROLS
    // =========================================

    const title =
        document.getElementById(
            window.reportIssueIds.title
        );


    const category =
        document.getElementById(
            window.reportIssueIds.category
        );


    const description =
        document.getElementById(
            window.reportIssueIds.description
        );


    // =========================================
    // TITLE VALIDATION
    // =========================================

    if (!title || title.value.trim() === "") {

        alert(
            "Please enter Complaint Title."
        );

        if (title) {
            title.focus();
        }

        return false;

    }


    // =========================================
    // CATEGORY VALIDATION
    // =========================================

    if (
        !category ||
        category.selectedIndex === 0 ||
        category.value === ""
    ) {

        alert(
            "Please select Category."
        );

        if (category) {
            category.focus();
        }

        return false;

    }

 // =========================================
    // DESCRIPTION VALIDATION
    // =========================================

    if (
        !description ||
        description.value.trim() === ""
    ) {

        alert(
            "Please enter Description."
        );

        if (description) {
            description.focus();
        }

        return false;

    }


    // =========================================
    // ALL VALIDATIONS PASSED
    // =========================================

    return true;

}