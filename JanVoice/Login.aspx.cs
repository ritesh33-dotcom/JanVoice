using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using JanVoice.Helpers;

namespace JanVoice
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }


        protected void loginButton_Click(object sender, EventArgs e)
        {
            // ============================================
            // 1. VALIDATE EMAIL
            // ============================================

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowMessage("Please enter your email.");
                return;
            }


            // ============================================
            // 2. VALIDATE PASSWORD
            // ============================================

            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                ShowMessage("Please enter your password.");
                return;
            }


            // ============================================
            // 3. GET DATABASE CONNECTION
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
                // 4. GET USER BY EMAIL
                // ============================================

                string query = @"
                    SELECT
                        UserID,
                        FullName,
                        Email,
                        PasswordHash,
                        RoleID,
                        WardID,
                        IsActive
                    FROM Users
                    WHERE Email = @Email";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Email",
                        txtEmail.Text.Trim()
                    );


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {

                        // ============================================
                        // 5. USER NOT FOUND
                        // ============================================

                        if (!reader.Read())
                        {
                            ShowMessage(
                                "Invalid Email or Password."
                            );

                            return;
                        }


                        // ============================================
                        // 6. CHECK ACCOUNT STATUS
                        // ============================================

                        bool isActive =
                            Convert.ToBoolean(
                                reader["IsActive"]
                            );


                        if (!isActive)
                        {
                            ShowMessage(
                                "Your account has been deactivated. Please contact the administrator."
                            );

                            return;
                        }


                        // ============================================
                        // 7. GET STORED PASSWORD HASH
                        // ============================================

                        string storedPasswordHash =
                            reader["PasswordHash"].ToString();


                        // ============================================
                        // 8. VERIFY PASSWORD
                        // ============================================

                        bool passwordValid =
                            AuthenticationHelper.VerifyPassword(
                                txtPassword.Text.Trim(),
                                storedPasswordHash
                            );


                        if (!passwordValid)
                        {
                            ShowMessage(
                                "Invalid Email or Password."
                            );

                            return;
                        }


                        // ============================================
                        // 9. STORE USER INFORMATION IN SESSION
                        // ============================================

                        Session["UserID"] =
                            reader["UserID"];

                        Session["FullName"] =
                            reader["FullName"];

                        Session["Email"] =
                            reader["Email"];

                        Session["RoleID"] =
                            reader["RoleID"];

                        Session["WardID"] =
                            reader["WardID"];


                        int roleID =
                            Convert.ToInt32(
                                reader["RoleID"]
                            );


                        // ============================================
                        // 10. OFFICER SESSION
                        // ============================================

                        if (roleID ==
                            AuthenticationHelper.OfficerRole)
                        {
                            Session["OfficerID"] =
                                reader["UserID"];
                        }


                        // ============================================
                        // 11. CLOSE READER
                        // ============================================

                        reader.Close();


                        // ============================================
                        // 12. RETURN URL
                        // ============================================

                        string returnUrl =
                            Request.QueryString["ReturnUrl"];


                        if (!string.IsNullOrEmpty(returnUrl))
                        {
                            Response.Redirect(
                                returnUrl
                            );

                            return;
                        }


                        // ============================================
                        // 13. ROLE-BASED REDIRECT
                        // ============================================

                        if (roleID ==
                            AuthenticationHelper.CitizenRole)
                        {
                            Response.Redirect(
                                "~/Citizen/Dashboard.aspx"
                            );
                        }
                        else if (roleID ==
                                 AuthenticationHelper.OfficerRole)
                        {
                            Response.Redirect(
                                "~/Officer/Dashboard.aspx"
                            );
                        }
                        else if (roleID ==
                                 AuthenticationHelper.AdminRole)
                        {
                            Response.Redirect(
                                "~/Admin/AdminDashboard.aspx"
                            );
                        }
                        else
                        {
                            ShowMessage(
                                "Invalid user role."
                            );
                        }
                    }
                }
            }
        }


        // ============================================
        // SHOW MESSAGE
        // ============================================

        private void ShowMessage(string message)
        {
            string safeMessage =
                message.Replace("'", "\\'");

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "msg",
                "alert('" + safeMessage + "');",
                true
            );
        }
    }
}