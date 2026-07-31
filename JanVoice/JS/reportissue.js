document.addEventListener("DOMContentLoaded", function () {

    const uploadBox = document.getElementById("uploadBox");

    const browseBtn = document.getElementById("browseBtn");

    const fileUpload = document.getElementById("<%= fuComplaintImage.ClientID %>");

    const preview = document.getElementById("imagePreview");

    const description = document.getElementById("<%= txtDescription.ClientID %>");

    const counter = document.getElementById("charCount");

    /* Browse Button */

    browseBtn.addEventListener("click", function () {

        fileUpload.click();

    });

    /* Click Upload Box */

    uploadBox.addEventListener("click", function () {

        fileUpload.click();

    });

    /* Character Counter */

    description.addEventListener("input", function () {

        counter.innerHTML =

            description.value.length + " / 500 Characters";

    });

    /* Image Preview */

    fileUpload.addEventListener("change", function () {

        preview.innerHTML = "";

        Array.from(fileUpload.files).forEach(file => {

            if (!file.type.startsWith("image/")) {

                alert("Only image files are allowed.");

                return;

            }

            if (file.size > 2 * 1024 * 1024) {

                alert(file.name + " exceeds 2MB.");

                return;

            }

            const reader = new FileReader();

            reader.onload = function (e) {

                const img = document.createElement("img");

                img.src = e.target.result;

                img.className = "preview-image";

                preview.appendChild(img);

            };

            reader.readAsDataURL(file);

        });

    });

});



const fileUpload = document.getElementById(window.reportIssueIds.fileUpload);
const description = document.getElementById(window.reportIssueIds.description);