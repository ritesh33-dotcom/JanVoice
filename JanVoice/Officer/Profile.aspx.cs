using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Officer
{
    public partial class Profile : System.Web.UI.Page
    {
        // =========================================================
        // DATABASE CONNECTION
        // =========================================================

        private readonly string connectionString =
            ConfigurationManager
            .ConnectionStrings["JanVoiceDB"]
            .ConnectionString;


        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOfficerProfile();
            }
        }


        // =========================================================
        // LOAD OFFICER PROFILE
        // =========================================================

        private void LoadOfficerProfile()
        {
            string userId = Session["UserID"].ToString();

            string query = @"
                SELECT
                    U.UserID,
                    U.FullName,
                    U.Email,
                    U.Mobile,
                    U.Address,
                    U.WardID,
                    U.RoleID,
                    U.IsActive,
                    U.CreatedDate,
                    R.RoleName,
                    W.WardNumber,
                    W.WardName
                FROM Users U
                LEFT JOIN Roles R
                    ON U.RoleID = R.RoleID
                LEFT JOIN Wards W
                    ON U.WardID = W.WardID
                WHERE U.UserID = @UserID";


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@UserID",
                        SqlDbType.Int
                    ).Value = Convert.ToInt32(userId);


                    try
                    {
                        con.Open();

                        using (SqlDataReader reader =
                               cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // ==============================
                                // OFFICER ID
                                // ==============================

                                string officerID =
                                    GetValue(reader, "UserID");

                                lblOfficerID.Text =
                                    officerID;

                                lblAccountOfficerID.Text =
                                    officerID;


                                // ==============================
                                // PERSONAL DETAILS
                                // ==============================

                                lblFullName.Text =
                                    GetValue(reader, "FullName");

                                lblEmail.Text =
                                    GetValue(reader, "Email");

                                lblMobile.Text =
                                    GetValue(reader, "Mobile");

                                lblAddress.Text =
                                    GetValue(reader, "Address");


                                // ==============================
                                // USERNAME
                                // ==============================

                                lblUsername.Text =
                                    "Officer";


                                // ==============================
                                // ROLE
                                // ==============================

                                string roleName =
                                    GetValue(reader, "RoleName");

                                lblDesignation.Text =
                                    roleName;

                                lblDepartment.Text =
                                    roleName;


                                // ==============================
                                // ASSIGNED AREA
                                // ==============================

                                string wardNumber =
                                    GetValue(reader, "WardNumber");

                                string wardName =
                                    GetValue(reader, "WardName");


                                if (wardNumber != "Not Available" &&
                                    wardName != "Not Available")
                                {
                                    lblAssignedArea.Text =
                                        "Ward "
                                        + wardNumber
                                        + " - "
                                        + wardName;
                                }
                                else if (wardName != "Not Available")
                                {
                                    lblAssignedArea.Text =
                                        wardName;
                                }
                                else if (wardNumber != "Not Available")
                                {
                                    lblAssignedArea.Text =
                                        "Ward "
                                        + wardNumber;
                                }
                                else
                                {
                                    lblAssignedArea.Text =
                                        "Not Assigned";
                                }
                            }
                            else
                            {
                                ShowProfileUnavailable();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(
                            "Profile Load Error: "
                            + ex.Message
                        );

                        ShowProfileUnavailable();
                    }
                }
            }
        }


        // =========================================================
        // EDIT PROFILE
        // =========================================================

        protected void btnEditProfile_Click(
            object sender,
            EventArgs e)
        {
            // Load latest values
            LoadEditProfileData();


            // Hide View Mode
            pnlPersonalView.Visible =
                false;


            // Show Edit Mode
            pnlPersonalEdit.Visible =
                true;


            // Hide Edit Profile button
            btnEditProfile.Visible =
                false;


            // Clear old message
            lblPersonalMessage.Text =
                "";
        }


        // =========================================================
        // LOAD EDIT PROFILE DATA
        // =========================================================

        private void LoadEditProfileData()
        {
            string userId =
                Session["UserID"].ToString();


            string query = @"
                SELECT
                    FullName,
                    Email,
                    Mobile,
                    Address
                FROM Users
                WHERE UserID = @UserID";


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@UserID",
                        SqlDbType.Int
                    ).Value =
                        Convert.ToInt32(userId);


                    try
                    {
                        con.Open();

                        using (SqlDataReader reader =
                               cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtEditFullName.Text =
                                    GetEditValue(
                                        reader,
                                        "FullName"
                                    );


                                txtEditEmail.Text =
                                    GetEditValue(
                                        reader,
                                        "Email"
                                    );


                                txtEditMobile.Text =
                                    GetEditValue(
                                        reader,
                                        "Mobile"
                                    );


                                txtEditAddress.Text =
                                    GetEditValue(
                                        reader,
                                        "Address"
                                    );
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(
                            "Edit Profile Load Error: "
                            + ex.Message
                        );

                        ShowProfileMessage(
                            "Unable to load profile details.",
                            false
                        );
                    }
                }
            }
        }


        // =========================================================
        // SAVE PERSONAL DETAILS
        // =========================================================

        protected void btnSavePersonalDetails_Click(
            object sender,
            EventArgs e)
        {
            string userId =
                Session["UserID"].ToString();


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
                ShowProfileMessage(
                    "Please enter your full name.",
                    false
                );

                return;
            }


            if (string.IsNullOrWhiteSpace(email))
            {
                ShowProfileMessage(
                    "Please enter your email address.",
                    false
                );

                return;
            }


            if (string.IsNullOrWhiteSpace(mobile))
            {
                ShowProfileMessage(
                    "Please enter your mobile number.",
                    false
                );

                return;
            }


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


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@FullName",
                        SqlDbType.NVarChar
                    ).Value =
                        fullName;


                    cmd.Parameters.Add(
                        "@Email",
                        SqlDbType.NVarChar
                    ).Value =
                        email;


                    cmd.Parameters.Add(
                        "@Mobile",
                        SqlDbType.NVarChar
                    ).Value =
                        mobile;


                    cmd.Parameters.Add(
                        "@Address",
                        SqlDbType.NVarChar
                    ).Value =
                        string.IsNullOrWhiteSpace(address)
                        ? (object)DBNull.Value
                        : address;


                    cmd.Parameters.Add(
                        "@UserID",
                        SqlDbType.Int
                    ).Value =
                        Convert.ToInt32(userId);


                    try
                    {
                        con.Open();


                        int rowsAffected =
                            cmd.ExecuteNonQuery();


                        if (rowsAffected > 0)
                        {
                            // Reload updated data
                            LoadOfficerProfile();


                            // Switch to View Mode
                            pnlPersonalEdit.Visible =
                                false;

                            pnlPersonalView.Visible =
                                true;


                            // Show Edit button
                            btnEditProfile.Visible =
                                true;


                            // Success message
                            ShowProfileMessage(
                                "Profile updated successfully.",
                                true
                            );
                        }
                        else
                        {
                            ShowProfileMessage(
                                "Profile could not be updated.",
                                false
                            );
                        }
                    }
                    catch (SqlException ex)
                    {
                        System.Diagnostics.Debug.WriteLine(
                            "SQL Profile Update Error: "
                            + ex.Message
                        );

                        ShowProfileMessage(
                            "Unable to update profile. Please try again.",
                            false
                        );
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(
                            "Profile Update Error: "
                            + ex.Message
                        );

                        ShowProfileMessage(
                            "Something went wrong. Please try again.",
                            false
                        );
                    }
                }
            }
        }


        // =========================================================
        // CANCEL PERSONAL EDIT
        // =========================================================

        protected void btnCancelPersonalEdit_Click(
            object sender,
            EventArgs e)
        {
            // Hide edit mode
            pnlPersonalEdit.Visible =
                false;


            // Show view mode
            pnlPersonalView.Visible =
                true;


            // Show Edit Profile button
            btnEditProfile.Visible =
                true;


            // Clear message
            lblPersonalMessage.Text =
                "";
        }

        // =========================================================
// CHANGE PASSWORD BUTTON
// =========================================================

protected void btnChangePassword_Click(
    object sender,
    EventArgs e)
{
    // Show Change Password panel
    pnlChangePassword.Visible = true;

    // Clear previous values
    txtCurrentPassword.Text = "";
    txtNewPassword.Text = "";
    txtConfirmPassword.Text = "";

    // Clear previous message
    lblPasswordMessage.Text = "";

    // Hide profile action buttons
    btnEditProfile.Visible = false;
    btnChangePassword.Visible = false;
}


// =========================================================
// SAVE NEW PASSWORD
// =========================================================

protected void btnSavePassword_Click(
    object sender,
    EventArgs e)
{
    // =====================================================
    // CHECK LOGIN
    // =====================================================

    if (Session["UserID"] == null)
    {
        Response.Redirect("~/Login.aspx");
        return;
    }


    string userId =
        Session["UserID"].ToString();


    // =====================================================
    // GET PASSWORD VALUES
    // =====================================================

    string currentPassword =
        txtCurrentPassword.Text.Trim();

    string newPassword =
        txtNewPassword.Text.Trim();

    string confirmPassword =
        txtConfirmPassword.Text.Trim();


    // =====================================================
    // VALIDATION
    // =====================================================

    if (string.IsNullOrWhiteSpace(currentPassword))
    {
        ShowPasswordMessage(
            "Please enter your current password.",
            false
        );

        return;
    }


    if (string.IsNullOrWhiteSpace(newPassword))
    {
        ShowPasswordMessage(
            "Please enter your new password.",
            false
        );

        return;
    }


    if (string.IsNullOrWhiteSpace(confirmPassword))
    {
        ShowPasswordMessage(
            "Please confirm your new password.",
            false
        );

        return;
    }


    // =====================================================
    // PASSWORD LENGTH
    // =====================================================

    if (newPassword.Length < 6)
    {
        ShowPasswordMessage(
            "New password must be at least 6 characters long.",
            false
        );

        return;
    }


    // =====================================================
    // CONFIRM PASSWORD
    // =====================================================

    if (newPassword != confirmPassword)
    {
        ShowPasswordMessage(
            "New password and confirm password do not match.",
            false
        );

        return;
    }


    // =====================================================
    // PREVENT SAME PASSWORD
    // =====================================================

    if (currentPassword == newPassword)
    {
        ShowPasswordMessage(
            "New password must be different from your current password.",
            false
        );

        return;
    }


    // =====================================================
    // UPDATE PASSWORD
    // =====================================================

    string query = @"
        UPDATE Users
        SET PasswordHash = @NewPassword
        WHERE UserID = @UserID
        AND PasswordHash = @CurrentPassword";


    using (SqlConnection con =
           new SqlConnection(connectionString))
    {
        using (SqlCommand cmd =
               new SqlCommand(query, con))
        {
            cmd.Parameters.Add(
                "@NewPassword",
                SqlDbType.NVarChar
            ).Value =
                newPassword;


            cmd.Parameters.Add(
                "@CurrentPassword",
                SqlDbType.NVarChar
            ).Value =
                currentPassword;


            cmd.Parameters.Add(
                "@UserID",
                SqlDbType.Int
            ).Value =
                Convert.ToInt32(userId);


            try
            {
                con.Open();


                int rowsAffected =
                    cmd.ExecuteNonQuery();


                // =================================================
                // PASSWORD UPDATED
                // =================================================

                if (rowsAffected > 0)
                {
                    ShowPasswordMessage(
                        "Password changed successfully.",
                        true
                    );


                    // Clear password fields
                    txtCurrentPassword.Text = "";
                    txtNewPassword.Text = "";
                    txtConfirmPassword.Text = "";


                    // Optional:
                    // Keep panel open so user can see success message.
                }
                else
                {
                    // =================================================
                    // WRONG CURRENT PASSWORD
                    // =================================================

                    ShowPasswordMessage(
                        "Current password is incorrect.",
                        false
                    );
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    "SQL Change Password Error: "
                    + ex.Message
                );


                ShowPasswordMessage(
                    "Unable to change password. Please try again.",
                    false
                );
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    "Change Password Error: "
                    + ex.Message
                );


                ShowPasswordMessage(
                    "Something went wrong. Please try again.",
                    false
                );
            }
        }
    }
}


// =========================================================
// CANCEL CHANGE PASSWORD
// =========================================================

protected void btnCancelPassword_Click(
    object sender,
    EventArgs e)
{
    // Hide password panel
    pnlChangePassword.Visible = false;


    // Clear fields
    txtCurrentPassword.Text = "";
    txtNewPassword.Text = "";
    txtConfirmPassword.Text = "";


    // Clear message
    lblPasswordMessage.Text = "";


    // Show profile buttons
    btnEditProfile.Visible = true;
    btnChangePassword.Visible = true;
}


// =========================================================
// PASSWORD MESSAGE
// =========================================================

private void ShowPasswordMessage(
    string message,
    bool success)
{
    lblPasswordMessage.Text =
        message;


    if (success)
    {
        lblPasswordMessage.CssClass =
            "profile-message profile-success";
    }
    else
    {
        lblPasswordMessage.CssClass =
            "profile-message profile-error";
    }
}


        // =========================================================
        // PROFILE MESSAGE
        // =========================================================

        private void ShowProfileMessage(
            string message,
            bool success)
        {
            lblPersonalMessage.Text =
                message;


            if (success)
            {
                lblPersonalMessage.CssClass =
                    "profile-message profile-success";
            }
            else
            {
                lblPersonalMessage.CssClass =
                    "profile-message profile-error";
            }
        }


        // =========================================================
        // SAFE DATABASE VALUE
        // =========================================================

        private string GetValue(
            SqlDataReader reader,
            string columnName)
        {
            if (reader[columnName] == DBNull.Value)
            {
                return "Not Available";
            }


            string value =
                reader[columnName]
                .ToString()
                .Trim();


            if (string.IsNullOrEmpty(value))
            {
                return "Not Available";
            }


            return value;
        }


        // =========================================================
        // EDIT FORM VALUE
        // =========================================================

        private string GetEditValue(
            SqlDataReader reader,
            string columnName)
        {
            if (reader[columnName] == DBNull.Value)
            {
                return "";
            }


            return reader[columnName]
                .ToString()
                .Trim();
        }


        // =========================================================
        // PROFILE UNAVAILABLE
        // =========================================================

        private void ShowProfileUnavailable()
        {
            lblOfficerID.Text =
                "Not Available";


            lblAccountOfficerID.Text =
                "Not Available";


            lblFullName.Text =
                "Not Available";


            lblEmail.Text =
                "Not Available";


            lblMobile.Text =
                "Not Available";


            lblUsername.Text =
                "Officer";


            lblDepartment.Text =
                "Not Available";


            lblDesignation.Text =
                "Not Available";


            lblAssignedArea.Text =
                "Not Assigned";


            lblAddress.Text =
                "Not Available";
        }
    }
}