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
            // Check Officer Login
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // Load profile only first time
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

                WHERE U.UserID = @UserID
            ";


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
                                // =============================================
                                // OFFICER ID
                                // =============================================

                                string officerID =
                                    GetValue(reader, "UserID");

                                lblOfficerID.Text =
                                    officerID;

                                lblAccountOfficerID.Text =
                                    officerID;


                                // =============================================
                                // FULL NAME
                                // =============================================

                                lblFullName.Text =
                                    GetValue(reader, "FullName");


                                // =============================================
                                // EMAIL
                                // =============================================

                                lblEmail.Text =
                                    GetValue(reader, "Email");


                                // =============================================
                                // MOBILE
                                // =============================================

                                lblMobile.Text =
                                    GetValue(reader, "Mobile");


                                // =============================================
                                // ADDRESS
                                // =============================================

                                lblAddress.Text =
                                    GetValue(reader, "Address");


                                // =============================================
                                // USERNAME
                                // =============================================

                                // Users table currently does not have
                                // a Username column.

                                lblUsername.Text =
                                    "Officer";


                                // =============================================
                                // ROLE
                                // =============================================

                                string roleName =
                                    GetValue(reader, "RoleName");

                                lblDesignation.Text =
                                    roleName;


                                // =============================================
                                // DEPARTMENT
                                // =============================================

                                // Current database has RoleName but
                                // no Department column.

                                lblDepartment.Text =
                                    roleName;


                                // =============================================
                                // ASSIGNED WARD
                                // =============================================

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
        // EDIT PROFILE BUTTON
        // =========================================================

        protected void btnEditProfile_Click(
            object sender,
            EventArgs e)
        {
            // Load latest database values
            LoadEditProfileData();


            // Hide view
            pnlPersonalView.Visible = false;


            // Show edit form
            pnlEditProfile.Visible = true;


            // Hide Edit Profile button
            btnEditProfile.Visible = false;


            // Clear previous message
            lblProfileMessage.Text = "";
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
                WHERE UserID = @UserID
            ";


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
                                    GetValue(
                                        reader,
                                        "FullName"
                                    );


                                txtEditEmail.Text =
                                    GetValue(
                                        reader,
                                        "Email"
                                    );


                                txtEditMobile.Text =
                                    GetValue(
                                        reader,
                                        "Mobile"
                                    );


                                txtEditAddress.Text =
                                    GetValue(
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
        // SAVE PROFILE
        // =========================================================

        protected void btnSaveProfile_Click(
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
            // UPDATE DATABASE
            // =====================================================

            string query = @"
                UPDATE Users
                SET
                    FullName = @FullName,
                    Email = @Email,
                    Mobile = @Mobile,
                    Address = @Address
                WHERE UserID = @UserID
            ";


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
                            // =========================================
                            // DATABASE UPDATED
                            // =========================================

                            // Reload latest profile
                            LoadOfficerProfile();


                            // Switch to VIEW mode
                            pnlEditProfile.Visible =
                                false;


                            pnlPersonalView.Visible =
                                true;


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
        // CANCEL EDIT
        // =========================================================

        protected void btnCancelEdit_Click(
     object sender,
     EventArgs e)
        {
            pnlEditProfile.Visible = false;
            pnlPersonalView.Visible = true;
            btnEditProfile.Visible = true;
            lblProfileMessage.Text = "";
        }


        // =========================================================
        // PROFILE MESSAGE
        // =========================================================

        private void ShowProfileMessage(
            string message,
            bool success)
        {
            lblProfileMessage.Text =
                message;


            if (success)
            {
                lblProfileMessage.CssClass =
                    "profile-message profile-success";
            }
            else
            {
                lblProfileMessage.CssClass =
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
        // PROFILE NOT AVAILABLE
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

            lblAssignedArea.Text =s
                "Not Assigned";

            lblAddress.Text =
                "Not Available";
        }
    }
}