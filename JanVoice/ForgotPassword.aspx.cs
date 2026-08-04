using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string connectionString =
                ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please enter your registered email.');",
                    true);

                return;
            }

            if (txtNewPassword.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please enter new password.');",
                    true);

                return;
            }

            if (txtConfirmPassword.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please confirm your password.');",
                    true);

                return;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Passwords do not match.');",
                    true);

                return;
            }
            using (SqlConnection con =
    new SqlConnection(connectionString))
            {
                string query = @"

        SELECT COUNT(*)

        FROM Users

        WHERE Email=@Email";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@Email",
                    txtEmail.Text.Trim());

                con.Open();

                int count =
                    Convert.ToInt32(cmd.ExecuteScalar());

                if (count == 0)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "alert",
                        "alert('No account found with this email.');",
                        true);

                    return;
                }
                query = @"

                        UPDATE Users

                        SET PasswordHash=@Password

                        WHERE Email=@Email";

                cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@Password",
                    txtNewPassword.Text.Trim());

                cmd.Parameters.AddWithValue(
                    "@Email",
                    txtEmail.Text.Trim());

                cmd.ExecuteNonQuery();

            }

            ClientScript.RegisterStartupScript(
    this.GetType(),
    "success",
    "alert('Password reset successfully.');window.location='Login.aspx';",
    true);

        }
    }
}