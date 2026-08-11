using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace JanVoice.Officer
{
    public partial class AssignedComplaints : Page
    {
        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckOfficerLogin();

            if (!IsPostBack)
            {
                LoadStatistics();
                LoadAssignedComplaints();
            }
        }


        // =========================================================
        // CHECK OFFICER LOGIN
        // =========================================================

        private void CheckOfficerLogin()
        {
            if (Session["OfficerID"] == null &&
                Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }


        // =========================================================
        // GET OFFICER ID
        // =========================================================

        private int GetOfficerID()
        {
            // First preference:
            // If OfficerID is already stored in session
            if (Session["OfficerID"] != null)
            {
                return Convert.ToInt32(Session["OfficerID"]);
            }


            // Because Citizen / Officer / Admin
            // use the SAME LOGIN PAGE,
            // Officer may have UserID in session.
            if (Session["UserID"] != null)
            {
                return Convert.ToInt32(Session["UserID"]);
            }


            // No login session
            Response.Redirect("~/Login.aspx");

            return 0;
        }


        // =========================================================
        // DATABASE CONNECTION
        // =========================================================

        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;
        }


        // =========================================================
        // LOAD STATISTICS
        // =========================================================

        private void LoadStatistics()
        {
            int officerID = GetOfficerID();

            string query = @"
                SELECT
                    COUNT(*) AS TotalAssigned,

                    COUNT(
                        CASE
                            WHEN Status = 'Pending'
                            THEN 1
                        END
                    ) AS PendingCount,

                    COUNT(
                        CASE
                            WHEN Status = 'In Progress'
                            THEN 1
                        END
                    ) AS InProgressCount,

                    COUNT(
                        CASE
                            WHEN Status = 'Resolved'
                            THEN 1
                        END
                    ) AS ResolvedCount

                FROM Complaints

                WHERE AssignedOfficerID = @OfficerID;
            ";


            using (SqlConnection con =
                   new SqlConnection(GetConnectionString()))
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
                            reader["TotalAssigned"]
                            .ToString();

                        lblPending.Text =
                            reader["PendingCount"]
                            .ToString();

                        lblInProgress.Text =
                            reader["InProgressCount"]
                            .ToString();

                        lblResolved.Text =
                            reader["ResolvedCount"]
                            .ToString();
                    }
                }
            }
        }


        // =========================================================
        // LOAD ASSIGNED COMPLAINTS
        // =========================================================

        private void LoadAssignedComplaints()
        {
            int officerID = GetOfficerID();


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

                LEFT JOIN Users U
                    ON C.UserID = U.UserID

                LEFT JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                LEFT JOIN Wards W
                    ON C.WardID = W.WardID

                WHERE C.AssignedOfficerID = @OfficerID

                ORDER BY C.CreatedDate DESC;
            ";


            using (SqlConnection con =
                   new SqlConnection(GetConnectionString()))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.Add(
                    "@OfficerID",
                    SqlDbType.Int
                ).Value = officerID;


                using (SqlDataAdapter da =
                       new SqlDataAdapter(cmd))
                {
                    DataTable dt =
                        new DataTable();


                    da.Fill(dt);


                    gvAssignedComplaints.DataSource =
                        dt;

                    gvAssignedComplaints.DataBind();
                }
            }
        }


        // =========================================================
        // SEARCH + FILTER ASSIGNED COMPLAINTS
        // =========================================================

        private void SearchAssignedComplaints()
        {
            int officerID = GetOfficerID();


            string searchText =
                txtSearch.Text.Trim();

            string status =
                ddlStatus.SelectedValue;

            string priority =
                ddlPriority.SelectedValue;


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

                LEFT JOIN Users U
                    ON C.UserID = U.UserID

                LEFT JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                LEFT JOIN Wards W
                    ON C.WardID = W.WardID

                WHERE C.AssignedOfficerID = @OfficerID

                AND
                (
                    @Search = ''

                    OR CAST(
                        C.ComplaintID AS VARCHAR(50)
                    ) LIKE '%' + @Search + '%'

                    OR C.Title LIKE '%' + @Search + '%'

                    OR U.FullName LIKE '%' + @Search + '%'

                    OR CAT.CategoryName LIKE '%' + @Search + '%'
                )

                AND
                (
                    @Status = ''
                    OR @Status = 'All'
                    OR C.Status = @Status
                )

                AND
                (
                    @Priority = ''
                    OR @Priority = 'All'
                    OR C.Priority = @Priority
                )

                ORDER BY C.CreatedDate DESC;
            ";


            using (SqlConnection con =
                   new SqlConnection(GetConnectionString()))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.Add(
                    "@OfficerID",
                    SqlDbType.Int
                ).Value = officerID;


                cmd.Parameters.Add(
                    "@Search",
                    SqlDbType.NVarChar,
                    200
                ).Value = searchText;


                cmd.Parameters.Add(
                    "@Status",
                    SqlDbType.NVarChar,
                    50
                ).Value = status;


                cmd.Parameters.Add(
                    "@Priority",
                    SqlDbType.NVarChar,
                    50
                ).Value = priority;


                using (SqlDataAdapter da =
                       new SqlDataAdapter(cmd))
                {
                    DataTable dt =
                        new DataTable();


                    da.Fill(dt);


                    gvAssignedComplaints.DataSource =
                        dt;

                    gvAssignedComplaints.DataBind();
                }
            }
        }


        // =========================================================
        // SEARCH BUTTON
        // =========================================================

        protected void btnSearch_Click(
            object sender,
            EventArgs e)
        {
            gvAssignedComplaints.PageIndex = 0;

            SearchAssignedComplaints();
        }


        // =========================================================
        // RESET BUTTON
        // =========================================================

        protected void btnReset_Click(
            object sender,
            EventArgs e)
        {
            txtSearch.Text = "";


            if (ddlStatus.Items.Count > 0)
            {
                ddlStatus.SelectedIndex = 0;
            }


            if (ddlPriority.Items.Count > 0)
            {
                ddlPriority.SelectedIndex = 0;
            }


            gvAssignedComplaints.PageIndex = 0;


            LoadStatistics();

            LoadAssignedComplaints();
        }


        // =========================================================
        // GRIDVIEW PAGING
        // =========================================================

        protected void gvAssignedComplaints_PageIndexChanging(
            object sender,
            GridViewPageEventArgs e)
        {
            gvAssignedComplaints.PageIndex =
                e.NewPageIndex;


            bool hasSearch =
                !string.IsNullOrWhiteSpace(
                    txtSearch.Text);


            bool hasStatus =
                !string.IsNullOrEmpty(
                    ddlStatus.SelectedValue) &&
                ddlStatus.SelectedValue != "All";


            bool hasPriority =
                !string.IsNullOrEmpty(
                    ddlPriority.SelectedValue) &&
                ddlPriority.SelectedValue != "All";


            if (hasSearch ||
                hasStatus ||
                hasPriority)
            {
                SearchAssignedComplaints();
            }
            else
            {
                LoadAssignedComplaints();
            }
        }
    }
}