using System;
using System.Configuration;
using System.Data.SqlClient;
using JanVoice.Helpers;

namespace JanVoice
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }


        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // ============================================
            // STEP 1: VALIDATE INPUT
            // ============================================

            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                ShowMessage("Please enter your name.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowMessage("Please enter your email.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                ShowMessage("Please enter your password.");
                return;
            }

            if (txtMobile.Text.Trim().Length != 10)
            {
                ShowMessage("Enter a valid 10-digit mobile number.");
                return;
            }

            if (ddlWard.SelectedIndex == 0)
            {
                ShowMessage("Please select a ward.");
                return;
            }

            if (!chkTerms.Checked)
            {
                ShowMessage("Please accept the Terms & Conditions.");
                return;
            }


            // ============================================
            // STEP 2: CONNECTION
            // ============================================

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // ============================================
                // STEP 3: CHECK EMAIL
                // ============================================

                string checkQuery =
                    "SELECT COUNT(*) FROM Users WHERE Email=@Email";

                using (SqlCommand checkCmd =
                       new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue(
                        "@Email",
                        txtEmail.Text.Trim()
                    );

                    int count =
                        Convert.ToInt32(
                            checkCmd.ExecuteScalar()
                        );

                    if (count > 0)
                    {
                        ShowMessage("Email already exists.");
                        return;
                    }
                }


                // ============================================
                // STEP 4: HASH PASSWORD
                // ============================================

                string hashedPassword =
                    AuthenticationHelper.HashPassword(
                        txtPassword.Text.Trim()
                    );


                // ============================================
                // STEP 5: INSERT USER
                // ============================================

                string query = @"
                    INSERT INTO Users
                    (
                        FullName,
                        Email,
                        Mobile,
                        PasswordHash,
                        RoleID,
                        WardID,
                        IsActive
                    )
                    VALUES
                    (
                        @FullName,
                        @Email,
                        @Mobile,
                        @PasswordHash,
                        @RoleID,
                        @WardID,
                        @IsActive
                    )";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@FullName",
                        txtName.Text.Trim()
                    );

                    cmd.Parameters.AddWithValue(
                        "@Email",
                        txtEmail.Text.Trim()
                    );

                    cmd.Parameters.AddWithValue(
                        "@Mobile",
                        txtMobile.Text.Trim()
                    );

                    // IMPORTANT:
                    // Store HASHED password, NOT plain password.
                    cmd.Parameters.AddWithValue(
                        "@PasswordHash",
                        hashedPassword
                    );

                    // New registrations are Citizens
                    cmd.Parameters.AddWithValue(
                        "@RoleID",
                        AuthenticationHelper.CitizenRole
                    );

                    cmd.Parameters.AddWithValue(
                        "@WardID",
                        Convert.ToInt32(
                            ddlWard.SelectedValue
                        )
                    );

                    cmd.Parameters.AddWithValue(
                        "@IsActive",
                        true
                    );

                    cmd.ExecuteNonQuery();
                }


                // ============================================
                // STEP 6: CLEAR FORM
                // ============================================

                txtName.Text = "";
                txtEmail.Text = "";
                txtMobile.Text = "";
                txtPassword.Text = "";
                ddlWard.SelectedIndex = 0;
                chkTerms.Checked = false;


                // ============================================
                // STEP 7: SUCCESS MESSAGE
                // ============================================

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "Success",
                    "swal('Registered Successfully..!','','success');",
                    true
                );
            }
        }


        // ============================================
        // SHOW MESSAGE
        // ============================================

        private void ShowMessage(string message)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "msg",
                "alert('" + message + "');",
                true
            );
        }
    }
}