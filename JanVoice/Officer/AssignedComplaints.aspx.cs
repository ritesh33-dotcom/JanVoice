using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Officer
{
    public partial class AssignedComplaints : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblTotalAssigned.Text = "888";
        }

        // =========================================================
        // CHECK OFFICER LOGIN
        // =========================================================

        private void CheckOfficerLogin()
        {
            if (Session["OfficerID"] == null)
            {
                Response.Redirect("~/Officer/OfficerLogin.aspx");
                return;
            }
        }


        // =========================================================
        // GET OFFICER ID
        // =========================================================

        private int GetOfficerID()
        {
            if (Session["OfficerID"] == null)
            {
                Response.Redirect("~/Officer/OfficerLogin.aspx");
                return 0;
            }

            return Convert.ToInt32(Session["OfficerID"]);
        }


        // =========================================================
        // LOAD STATISTICS
        // =========================================================

        // =========================================================
        // LOAD STATISTICS
        // =========================================================

        private void LoadStatistics()
        {
            int officerID = GetOfficerID();

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;

            string query = @"
        SELECT
            COUNT(*) AS TotalAssigned,

            COUNT(CASE
                WHEN Status = 'Pending'
                THEN 1
            END) AS PendingCount,

            COUNT(CASE
                WHEN Status = 'In Progress'
                THEN 1
            END) AS InProgressCount,

            COUNT(CASE
                WHEN Status = 'Resolved'
                THEN 1
            END) AS ResolvedCount

        FROM Complaints

        WHERE AssignedOfficerID = @OfficerID;
    ";

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.Add(
                    "@OfficerID",
                    SqlDbType.Int
                ).Value = officerID;

                con.Open();

                using (SqlDataReader reader =
                       cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblTotalAssigned.Text =
                            Convert.ToInt32(
                                reader["TotalAssigned"]
                            ).ToString();

                        lblPending.Text =
                            Convert.ToInt32(
                                reader["PendingCount"]
                            ).ToString();

                        lblInProgress.Text =
                            Convert.ToInt32(
                                reader["InProgressCount"]
                            ).ToString();

                        lblResolved.Text =
                            Convert.ToInt32(
                                reader["ResolvedCount"]
                            ).ToString();
                    }
                }
            }
        }

        // Neeche tumhara existing code same rahega...

        // existing code below


        // =========================================================
        // LOAD ASSIGNED COMPLAINTS
        // =========================================================

        private void LoadAssignedComplaints()
        {
            int officerID = GetOfficerID();

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;

            string query = @"
                SELECT
                    C.ComplaintID,
                    C.Title,
                    U.FullName AS CitizenName,
                    CAT.CategoryName,
                    W.WardName,
                    C.Priority,
                    C.Status,
                    C.CreatedDate

                FROM Complaints C

                INNER JOIN Users U
                    ON C.UserID = U.UserID

                INNER JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                INNER JOIN Wards W
                    ON C.WardID = W.WardID

                WHERE C.AssignedOfficerID = @OfficerID

                ORDER BY C.CreatedDate DESC;
            ";


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue(
                    "@OfficerID",
                    officerID
                );

                using (SqlDataAdapter da =
                       new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    gvAssignedComplaints.DataSource = dt;

                    gvAssignedComplaints.DataBind();
                }
            }
        }


        // =========================================================
        // SEARCH ASSIGNED COMPLAINTS
        // =========================================================

        private void SearchAssignedComplaints()
        {
            int officerID = GetOfficerID();

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;

            string query = @"
                SELECT
                    C.ComplaintID,
                    C.Title,
                    U.FullName AS CitizenName,
                    CAT.CategoryName,
                    W.WardName,
                    C.Priority,
                    C.Status,
                    C.CreatedDate

                FROM Complaints C

                INNER JOIN Users U
                    ON C.UserID = U.UserID

                INNER JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                INNER JOIN Wards W
                    ON C.WardID = W.WardID

                WHERE C.AssignedOfficerID = @OfficerID

                AND
                (
                    @Search = ''
                    OR CAST(
                        C.ComplaintID AS VARCHAR(50)
                    ) LIKE '%' + @Search + '%'

                    OR C.Title LIKE '%' + @Search + '%'
                )

                AND
                (
                    @Status = ''
                    OR C.Status = @Status
                )

                AND
                (
                    @Priority = ''
                    OR C.Priority = @Priority
                )

                ORDER BY C.CreatedDate DESC;
            ";


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue(
                    "@OfficerID",
                    officerID
                );

                cmd.Parameters.AddWithValue(
                    "@Search",
                    txtSearch.Text.Trim()
                );

                cmd.Parameters.AddWithValue(
                    "@Status",
                    ddlStatus.SelectedValue
                );

                cmd.Parameters.AddWithValue(
                    "@Priority",
                    ddlPriority.SelectedValue
                );


                using (SqlDataAdapter da =
                       new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    gvAssignedComplaints.DataSource = dt;

                    gvAssignedComplaints.DataBind();
                }
            }
        }


        // =========================================================
        // SEARCH BUTTON
        // =========================================================

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvAssignedComplaints.PageIndex = 0;
            SearchAssignedComplaints();
        }


        // =========================================================
        // RESET BUTTON
        // =========================================================

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";

            ddlStatus.SelectedIndex = 0;
            ddlPriority.SelectedIndex = 0;

            gvAssignedComplaints.PageIndex = 0;

            LoadAssignedComplaints();
        }


        // =========================================================
        // GRIDVIEW PAGING
        // =========================================================

        protected void gvAssignedComplaints_PageIndexChanging(
    object sender,
    GridViewPageEventArgs e)
        {
            gvAssignedComplaints.PageIndex = e.NewPageIndex;

            if (string.IsNullOrWhiteSpace(txtSearch.Text) &&
                string.IsNullOrEmpty(ddlStatus.SelectedValue) &&
                string.IsNullOrEmpty(ddlPriority.SelectedValue))
            {
                LoadAssignedComplaints();
            }
            else
            {
                SearchAssignedComplaints();
            }
        }
    }
}