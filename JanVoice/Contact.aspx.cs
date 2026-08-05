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
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (txtName.Text.Trim() == "" ||
                txtEmail.Text.Trim() == "" ||
                txtPhone.Text.Trim() == "" ||
                txtSubject.Text.Trim() == "" ||
                txtMessage.Text.Trim() == "")
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please fill all fields.";
                return;
            }

            try
            {
                string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO ContactMessages
                            (FullName,
                             Email,
                             Mobile,
                             Subject,
                             Message,
                             IsReplied,
                             SubmittedDate)

                             VALUES

                            (@FullName,
                             @Email,
                             @Mobile,
                             @Subject,
                             @Message,
                             @IsReplied,
                             GETDATE())";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@FullName", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Mobile", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                    cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                    cmd.Parameters.AddWithValue("@IsReplied", false);

                    con.Open();

                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.LimeGreen;
                        lblMessage.Text = "✅ Your message has been sent successfully.";

                        txtName.Text = "";
                        txtEmail.Text = "";
                        txtPhone.Text = "";
                        txtSubject.Text = "";
                        txtMessage.Text = "";
                    }
                    else
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = "❌ Failed to send message.";
                    }

                    con.Close();

                    lblMessage.ForeColor = System.Drawing.Color.LimeGreen;
                    lblMessage.Text = "Message sent successfully.";

                    txtName.Text = "";
                    txtEmail.Text = "";
                    txtPhone.Text = "";
                    txtSubject.Text = "";
                    txtMessage.Text = "";
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = ex.Message;
            }
        }
    }
}
