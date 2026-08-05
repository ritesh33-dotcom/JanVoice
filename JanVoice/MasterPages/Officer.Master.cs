using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.MasterPages
{

    public partial class Officer : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckOfficerLogin();
                LoadOfficerInfo();
            }
        }

        private void CheckOfficerLogin()
        {
            if (Session["OfficerID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        private void LoadOfficerInfo()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT FullName
                                     FROM Users
                                     WHERE UserID=@UserID";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@UserID",
                        Session["OfficerID"]);

                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        lblOfficerName.Text = dr["FullName"].ToString();
                    }

                    dr.Close();
                }
            }
            catch
            {
                lblOfficerName.Text = "Officer";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Session.Abandon();

            Response.Redirect("~/Login.aspx");
        }
    }
}