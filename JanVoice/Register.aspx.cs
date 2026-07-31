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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {

            string connectionString =
                ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Check Email Already Exists

                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email=@Email";

                SqlCommand checkCmd = new SqlCommand(checkQuery, con);

                checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (count > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(),
                        "msg",
                        "alert('Email already exists.');",
                        true);

                    return;
                }

                // Insert User

                string query = @"INSERT INTO Users
                        (FullName,
                         Email,
                         Phone,
                         Password,
                         RoleID,
                         WardID,
                         IsActive)

                         VALUES

                        (@FullName,
                         @Email,
                         @Phone,
                         @Password,
                         @RoleID,
                         @WardID,
                         @IsActive)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@FullName", txtName.Text.Trim());

                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                cmd.Parameters.AddWithValue("@Phone", txtMobile.Text.Trim());

                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                cmd.Parameters.AddWithValue("@RoleID", 1);

                cmd.Parameters.AddWithValue("@WardID", ddlWard.SelectedIndex);

                cmd.Parameters.AddWithValue("@IsActive", true);

                cmd.ExecuteNonQuery();

                ClientScript.RegisterStartupScript(this.GetType(),
                    "success",
                    "alert('Registration Successful!');window.location='Login.aspx';",
                    true);
            }
        }
    }
}