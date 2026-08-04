using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Citizen
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connectionString =
    ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                lblName.Text = Session["FullName"].ToString();

                LoadDashboardCounts();
                LoadRecentComplaints();
            }
        }
        private void LoadDashboardCounts()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"

                                SELECT

                                (SELECT COUNT(*)
                                 FROM Complaints
                                 WHERE UserID=@UserID)
                                 AS TotalComplaints,

                                (SELECT COUNT(*)
                                 FROM Complaints
                                 WHERE UserID=@UserID
                                 AND Status='Pending')
                                 AS PendingComplaints,

                                (SELECT COUNT(*)
                                 FROM Complaints
                                 WHERE UserID=@UserID
                                 AND Status='Resolved')
                                 AS ResolvedComplaints,

                                (SELECT COUNT(*)
                                 FROM Notifications
                                 WHERE UserID=@UserID
                                 AND IsRead=0)
                                 AS UnreadNotifications";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@UserID",
                    Session["UserID"]);

                con.Open();

                SqlDataReader dr =
                    cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblTotalComplaints.Text =
                        dr["TotalComplaints"].ToString();

                    lblPending.Text =
                        dr["PendingComplaints"].ToString();

                    lblResolved.Text =
                        dr["ResolvedComplaints"].ToString();

                    lblNotifications.Text =
                        dr["UnreadNotifications"].ToString();
                }

                dr.Close();
            }
        }

        private void LoadRecentComplaints()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"

                                SELECT TOP 5

                                ComplaintID,
                                Title,
                                Status,
                                CreatedDate

                                FROM Complaints

                                WHERE UserID=@UserID

                                ORDER BY CreatedDate DESC";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@UserID",
                    Session["UserID"]);

                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                rptRecentComplaints.DataSource = dt;
                rptRecentComplaints.DataBind();
            }
        }
    }
}