using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Data.SqlClient;
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
    
            // Step 1: Validate Input

            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(),
                    "msg",
                    "alert('Please enter your name.');",
                    true);
                return;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(),
                    "msg",
                    "alert('Please enter your email.');",
                    true);
                return;
            }

            //if (ddlWard.SelectedIndex == 0)
            //{
            //    ClientScript.RegisterStartupScript(this.GetType(),
            //        "msg",
            //        "alert('Please select a ward.');",
            //        true);
            //    return;
            //}

            if (!chkTerms.Checked)
            {
                ClientScript.RegisterStartupScript(this.GetType(),
                    "msg",
                    "alert('Please accept the Terms & Conditions.');",
                    true);
                return;
            }

            if (txtMobile.Text.Trim().Length != 10)
            {
                ClientScript.RegisterStartupScript(this.GetType(),
                    "msg",
                    "alert('Enter a valid 10-digit mobile number.');",
                    true);
                return;
            }

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
                         Mobile,
                         PasswordHash,
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

                cmd.Parameters.AddWithValue("@WardID", Convert.ToInt32(ddlWard.SelectedValue));

                cmd.Parameters.AddWithValue("@IsActive", true);

                cmd.ExecuteNonQuery();

               

                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Registered Successfully..!','','success');", true);


            }
        }
    }
}