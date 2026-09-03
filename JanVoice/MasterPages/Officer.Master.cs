using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JanVoice.Helpers;

namespace JanVoice.MasterPages
{

    public partial class Officer : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!AuthenticationHelper.IsLoggedIn())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!AuthenticationHelper.IsOfficer())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }

        private void CheckOfficerLogin()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            if (Convert.ToInt32(Session["RoleID"]) != 2)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }

        private void LoadOfficerInfo()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
            SELECT
                U.FullName,
                U.Email,
                U.Mobile,
                W.WardName
            FROM Users U
            INNER JOIN Wards W
            ON U.WardID = W.WardID
            WHERE U.UserID = @UserID";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        if (dr.Read())
                        {
                            lblOfficerName.Text = dr["FullName"].ToString();

                            // Optional labels
                            // lblOfficerEmail.Text = dr["Email"].ToString();
                            // lblOfficerWard.Text = dr["WardName"].ToString();
                        }


                        dr.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message.Replace("'", "") + "');</script>");
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