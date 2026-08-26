using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace JanVoice.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connectionString =ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardStatistics();
                LoadComplaintOverview();
                LoadRecentComplaints();
            }
        }



        // ==========================================
        // DASHBOARD STATISTICS
        // ==========================================

        private void LoadDashboardStatistics()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                con.Open();


                // Total Citizens

                string citizenQuery =
                    "SELECT COUNT(*) FROM Users " +
                    "WHERE RoleID = 1 AND IsActive = 1";

                using (SqlCommand cmd =
                    new SqlCommand(citizenQuery, con))
                {
                    lblTotalCitizens.Text =
                        Convert.ToInt32(cmd.ExecuteScalar()).ToString();
                }



                // Total Complaints

                string complaintQuery =
                    "SELECT COUNT(*) FROM Complaints";

                using (SqlCommand cmd =
                    new SqlCommand(complaintQuery, con))
                {
                    lblTotalComplaints.Text =
                        Convert.ToInt32(cmd.ExecuteScalar()).ToString();
                }



                // Pending Complaints

                string pendingQuery =
                    "SELECT COUNT(*) FROM Complaints " +
                    "WHERE Status = @Status";

                using (SqlCommand cmd =
                    new SqlCommand(pendingQuery, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Status", "Pending");

                    lblPendingComplaints.Text =
                        Convert.ToInt32(cmd.ExecuteScalar()).ToString();
                }



                // Resolved Complaints

                string resolvedQuery =
                    "SELECT COUNT(*) FROM Complaints " +
                    "WHERE Status = @Status";

                using (SqlCommand cmd =
                    new SqlCommand(resolvedQuery, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Status", "Resolved");

                    lblResolvedComplaints.Text =
                        Convert.ToInt32(cmd.ExecuteScalar()).ToString();
                }
            }
        }



        // ==========================================
        // COMPLAINT OVERVIEW
        // ==========================================

        private void LoadComplaintOverview()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                con.Open();


                // Pending

                lblPendingOverview.Text =
                    GetComplaintCount(con, "Pending")
                    .ToString();


                // Accepted

                lblAcceptedOverview.Text =
                    GetComplaintCount(con, "Accepted")
                    .ToString();


                // In Progress

                lblProgressOverview.Text =
                    GetComplaintCount(con, "In Progress")
                    .ToString();


                // Resolved

                lblResolvedOverview.Text =
                    GetComplaintCount(con, "Resolved")
                    .ToString();
            }
        }



        // ==========================================
        // GET COMPLAINT COUNT
        // ==========================================

        private int GetComplaintCount(
            SqlConnection con,
            string status)
        {
            string query =
                "SELECT COUNT(*) FROM Complaints " +
                "WHERE Status = @Status";


            using (SqlCommand cmd =
                new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue(
                    "@Status", status);

                return Convert.ToInt32(
                    cmd.ExecuteScalar());
            }
        }



        // ==========================================
        // RECENT COMPLAINTS
        // ==========================================

        private void LoadRecentComplaints()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT TOP 5
                        c.ComplaintID,
                        c.Title,
                        cat.CategoryName,
                        w.WardName,
                        c.Status,
                        c.CreatedDate

                    FROM Complaints c

                    INNER JOIN Categories cat
                        ON c.CategoryID = cat.CategoryID

                    INNER JOIN Wards w
                        ON c.WardID = w.WardID

                    ORDER BY c.CreatedDate DESC
                ";


                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        DataTable dt =
                            new DataTable();

                        da.Fill(dt);

                        gvRecentComplaints.DataSource = dt;

                        gvRecentComplaints.DataBind();
                    }
                }
            }
        }
    }
}