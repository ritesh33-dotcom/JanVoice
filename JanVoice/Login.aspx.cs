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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       

        protected void loginButton_Click(object sender, EventArgs e)
        {
            // Validate Email
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(),
                    "msg",
                    "alert('Please enter your email.');",
                    true);
                return;
            }

            // Validate Password
            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(),
                    "msg",
                    "alert('Please enter your password.');",
                    true);
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"SELECT UserID,
                                FullName,
                                Email,
                                RoleID,
                                WardID
                         FROM Users
                         WHERE Email=@Email
                         AND PasswordHash=@Password
                         AND IsActive=1";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    Session["UserID"] = reader["UserID"];
                    Session["FullName"] = reader["FullName"];
                    Session["Email"] = reader["Email"];
                    Session["RoleID"] = reader["RoleID"];
                    Session["WardID"] = reader["WardID"];

                    int roleID = Convert.ToInt32(reader["RoleID"]);

                    // Officer session
                    if (roleID == 2)
                    {
                        Session["OfficerID"] = reader["UserID"];
                    }

                    reader.Close();

                    string returnUrl = Request.QueryString["ReturnUrl"];

                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        Response.Redirect(returnUrl);
                        return;
                    }

                    if (roleID == 1)
                    {
                        Response.Redirect("~/Citizen/Dashboard.aspx");
                    }
                    else if (roleID == 2)
                    {
                        Response.Redirect("~/Officer/Dashboard.aspx");
                    }
                    else if (roleID == 3)
                    {
                        Response.Redirect("~/Admin/Dashboard.aspx");
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(),
                            "msg",
                            "alert('Invalid user role.');",
                            true);
                    }
                }
                else
                {
                    reader.Close();

                    ClientScript.RegisterStartupScript(this.GetType(),
                        "msg",
                        "alert('Invalid Email or Password.');",
                        true);
                }
            }
        }


    }
}