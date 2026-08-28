using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Citizen
{
    public partial class Profile : System.Web.UI.Page
    {
        // =========================================================
        // DATABASE CONNECTION
        // =========================================================

        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsUserLoggedIn())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }


        // =========================================================
        // CHECK LOGIN
        // =========================================================

        private bool IsUserLoggedIn()
        {
            return Session["UserID"] != null;
        }


        // =========================================================
        // GET CURRENT USER ID
        // =========================================================

        private int GetCurrentUserID()
        {
            return Convert.ToInt32(Session["UserID"]);
        }


        // =========================================================
        // LOAD PROFILE
        // =========================================================

        private void LoadProfile()
        {
            int userID = GetCurrentUserID();

            string query = @"
                SELECT
                    UserID,
                    FullName,
                    Email,
                    Mobile,
                    Address,
                    ProfilePhoto,
                    IsActive,
                    CreatedDate
                FROM Users
                WHERE UserID = @UserID";


            using (SqlConnection con =
                new SqlConnection(connectionString))
            using (SqlCommand cmd =
                new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userID);

                con.Open();

                using (SqlDataReader reader =
                    cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // =================================================
                        // BASIC INFORMATION
                        // =================================================

                        string fullName =
                            reader["FullName"] == DBNull.Value
                                ? ""
                                : reader["FullName"].ToString();

                        string email =
                            reader["Email"] == DBNull.Value
                                ? ""
                                : reader["Email"].ToString();

                        string mobile =
                            reader["Mobile"] == DBNull.Value
                                ? ""
                                : reader["Mobile"].ToString();

                        string address =
                            reader["Address"] == DBNull.Value
                                ? ""
                                : reader["Address"].ToString();


                        // =================================================
                        // PROFILE SUMMARY
                        // =================================================

                        lblSummaryName.Text = fullName;

                        // Database mein separate Username column nahi hai.
                        // Isliye email ko username/display identifier ke
                        // roop mein show kar rahe hain.

                        lblSummaryUsername.Text = email;

                        lblCitizenID.Text =
                            reader["UserID"].ToString();


                        // =================================================
                        // PERSONAL DETAILS
                        // =================================================

                        lblFullName.Text = fullName;

                        lblEmail.Text = email;

                        lblMobile.Text = mobile;

                        lblAddress.Text =
                            string.IsNullOrWhiteSpace(address)
                                ? "Not Available"
                                : address;


                        // =================================================
                        // ACCOUNT INFORMATION
                        // =================================================

                        lblAccountCitizenID.Text =
                            reader["UserID"].ToString();


                        // =================================================
                        // JOINED DATE
                        // =================================================

                        if (reader["CreatedDate"] != DBNull.Value)
                        {
                            DateTime createdDate =
                                Convert.ToDateTime(
                                    reader["CreatedDate"]);

                            lblJoinedDate.Text =
                                createdDate.ToString("dd MMM yyyy");
                        }
                        else
                        {
                            lblJoinedDate.Text =
                                "Not Available";
                        }


                        // =================================================
                        // ACCOUNT STATUS
                        // =================================================

                        bool isActive =
                            reader["IsActive"] != DBNull.Value &&
                            Convert.ToBoolean(
                                reader["IsActive"]);

                        lblAccountStatus.Text =
                            isActive
                                ? "Active"
                                : "Inactive";


                        // =================================================
                        // PROFILE PHOTO
                        // =================================================

                        if (reader["ProfilePhoto"] != DBNull.Value &&
                            !string.IsNullOrWhiteSpace(
                                reader["ProfilePhoto"].ToString()))
                        {
                            string photoPath =
                                reader["ProfilePhoto"].ToString();

                            imgCitizenProfile.ImageUrl =
                                photoPath;
                        }
                        else
                        {
                            imgCitizenProfile.ImageUrl =
                                "../Images/default-user.png";
                        }


                        // =================================================
                        // LOAD EDIT FIELDS
                        // =================================================

                        LoadEditFields(
                            fullName,
                            email,
                            mobile,
                            address
                        );
                    }
                }
            }
        }


        // =========================================================
        // LOAD EDIT FIELDS
        // =========================================================

        private void LoadEditFields(
            string fullName,
            string email,
            string mobile,
            string address)
        {
            txtEditFullName.Text = fullName;

            txtEditEmail.Text = email;

            txtEditMobile.Text = mobile;

            txtEditAddress.Text = address;
        }


        // =========================================================
        // EDIT PROFILE BUTTON
        // =========================================================

        protected void btnEditProfile_Click(
            object sender,
            EventArgs e)
        {
            pnlPersonalView.Visible = false;

            pnlPersonalEdit.Visible = true;

            pnlChangePassword.Visible = false;

            lblPersonalMessage.Text = "";

            // Latest database values edit form mein load karenge.
            LoadProfile();
        }


        // =========================================================
        // CANCEL EDIT
        // =========================================================

        protected void btnCancelPersonalEdit_Click(
            object sender,
            EventArgs e)
        {
            pnlPersonalEdit.Visible = false;

            pnlPersonalView.Visible = true;

            lblPersonalMessage.Text = "";

            LoadProfile();
        }


        // =========================================================
        // SAVE PERSONAL DETAILS
        // =========================================================

        protected void btnSavePersonalDetails_Click(
            object sender,
            EventArgs e)
        {
            string fullName =
                txtEditFullName.Text.Trim();

            string email =
                txtEditEmail.Text.Trim();

            string mobile =
                txtEditMobile.Text.Trim();

            string address =
                txtEditAddress.Text.Trim();


            // =====================================================
            // VALIDATION
            // =====================================================

            if (string.IsNullOrWhiteSpace(fullName))
            {
                ShowPersonalError(
                    "Please enter your full name.");

                return;
            }


            if (string.IsNullOrWhiteSpace(email))
            {
                ShowPersonalError(
                    "Please enter your email address.");

                return;
            }


            int userID = GetCurrentUserID();


            // =====================================================
            // UPDATE QUERY
            // =====================================================

            string query = @"
                UPDATE Users
                SET
                    FullName = @FullName,
                    Email = @Email,
                    Mobile = @Mobile,
                    Address = @Address
                WHERE UserID = @UserID";


            try
            {
                using (SqlConnection con =
                    new SqlConnection(connectionString))
                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@FullName",
                        fullName);


                    cmd.Parameters.AddWithValue(
                        "@Email",
                        email);


                    cmd.Parameters.AddWithValue(
                        "@Mobile",
                        string.IsNullOrWhiteSpace(mobile)
                            ? (object)DBNull.Value
                            : mobile);


                    cmd.Parameters.AddWithValue(
                        "@Address",
                        string.IsNullOrWhiteSpace(address)
                            ? (object)DBNull.Value
                            : address);


                    cmd.Parameters.AddWithValue(
                        "@UserID",
                        userID);


                    con.Open();


                    int rowsAffected =
                        cmd.ExecuteNonQuery();


                    // =================================================
                    // SUCCESS
                    // =================================================

                    if (rowsAffected > 0)
                    {
                        pnlPersonalEdit.Visible = false;

                        pnlPersonalView.Visible = true;

                        lblPersonalMessage.Text =
                            "Profile updated successfully.";

                        lblPersonalMessage.CssClass =
                            "profile-message profile-success";


                        // Updated values screen par load karenge.
                        LoadProfile();
                    }
                    else
                    {
                        ShowPersonalError(
                            "Profile could not be updated.");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowPersonalError(
                    "An error occurred while updating your profile.");

                System.Diagnostics.Debug.WriteLine(
                    ex.ToString());
            }
        }


        // =========================================================
        // PERSONAL SUCCESS / ERROR
        // =========================================================

        private void ShowPersonalError(
            string message)
        {
            lblPersonalMessage.Text =
                message;

            lblPersonalMessage.CssClass =
                "profile-message profile-error";
        }


        // =========================================================
        // PROFILE PHOTO UPLOAD
        // =========================================================

        protected void btnUploadPhoto_Click(
            object sender,
            EventArgs e)
        {
            if (!fuProfilePhoto.HasFile)
            {
                ShowPhotoError(
                    "Please select a profile photo.");

                return;
            }


            // =====================================================
            // FILE EXTENSION
            // =====================================================

            string extension =
                Path.GetExtension(
                    fuProfilePhoto.FileName)
                .ToLower();


            string[] allowedExtensions =
            {
                ".jpg",
                ".jpeg",
                ".png",
                ".webp"
            };


            bool validExtension = false;


            foreach (string allowed in allowedExtensions)
            {
                if (extension == allowed)
                {
                    validExtension = true;

                    break;
                }
            }


            if (!validExtension)
            {
                ShowPhotoError(
                    "Only JPG, JPEG, PNG or WEBP images are allowed.");

                return;
            }


            // =====================================================
            // FILE SIZE
            // =====================================================

            if (fuProfilePhoto.PostedFile.ContentLength >
                2 * 1024 * 1024)
            {
                ShowPhotoError(
                    "Profile photo must be smaller than 2 MB.");

                return;
            }


            try
            {
                int userID =
                    GetCurrentUserID();


                // =================================================
                // UPLOAD FOLDER
                // =================================================

                string folderPath =
                    Server.MapPath(
                        "~/Uploads/ProfilePhotos/");


                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(
                        folderPath);
                }


                // =================================================
                // FILE NAME
                // =================================================

                string fileName =
                    "Citizen_" +
                    userID +
                    "_" +
                    DateTime.Now.ToString(
                        "yyyyMMddHHmmss") +
                    extension;


                string fullPath =
                    Path.Combine(
                        folderPath,
                        fileName);


                // =================================================
                // SAVE FILE
                // =================================================

                fuProfilePhoto.SaveAs(
                    fullPath);


                // =================================================
                // DATABASE PATH
                // =================================================

                string databasePath =
                    "~/Uploads/ProfilePhotos/" +
                    fileName;


                // =================================================
                // UPDATE DATABASE
                // =================================================

                string query = @"
                    UPDATE Users
                    SET ProfilePhoto = @ProfilePhoto
                    WHERE UserID = @UserID";


                using (SqlConnection con =
                    new SqlConnection(connectionString))
                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@ProfilePhoto",
                        databasePath);


                    cmd.Parameters.AddWithValue(
                        "@UserID",
                        userID);


                    con.Open();


                    int rowsAffected =
                        cmd.ExecuteNonQuery();


                    if (rowsAffected > 0)
                    {
                        imgCitizenProfile.ImageUrl =
                            databasePath;


                        ShowPhotoSuccess(
                            "Profile photo updated successfully.");
                    }
                    else
                    {
                        ShowPhotoError(
                            "Profile photo could not be updated.");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowPhotoError(
                    "An error occurred while uploading the photo.");

                System.Diagnostics.Debug.WriteLine(
                    ex.ToString());
            }
        }


        // =========================================================
        // PHOTO SUCCESS MESSAGE
        // =========================================================

        private void ShowPhotoSuccess(
            string message)
        {
            lblPhotoMessage.Text =
                message;

            lblPhotoMessage.CssClass =
                "profile-message profile-success";
        }


        // =========================================================
        // PHOTO ERROR MESSAGE
        // =========================================================

        private void ShowPhotoError(
            string message)
        {
            lblPhotoMessage.Text =
                message;

            lblPhotoMessage.CssClass =
                "profile-message profile-error";
        }


        // =========================================================
        // CHANGE PASSWORD BUTTON
        // =========================================================

        protected void btnChangePassword_Click(
            object sender,
            EventArgs e)
        {
            pnlPersonalEdit.Visible = false;

            pnlPersonalView.Visible = true;

            pnlChangePassword.Visible = true;

            lblPasswordMessage.Text = "";

            // Old password fields clear.
            txtCurrentPassword.Text = "";

            txtNewPassword.Text = "";

            txtConfirmPassword.Text = "";
        }


        // =========================================================
        // CANCEL PASSWORD
        // =========================================================

        protected void btnCancelPassword_Click(
            object sender,
            EventArgs e)
        {
            pnlChangePassword.Visible = false;

            txtCurrentPassword.Text = "";

            txtNewPassword.Text = "";

            txtConfirmPassword.Text = "";

            lblPasswordMessage.Text = "";
        }


        // =========================================================
        // SAVE PASSWORD
        // =========================================================

        protected void btnSavePassword_Click(
            object sender,
            EventArgs e)
        {
            lblPasswordMessage.Text =
                "Password functionality will be connected after verifying your existing password hashing system.";

            lblPasswordMessage.CssClass =
                "profile-message profile-error";
        }
    }
}