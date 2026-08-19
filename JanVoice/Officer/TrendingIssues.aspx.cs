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
    public partial class TrendingIssues : Page
    {
        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckOfficerLogin();

            if (!IsPostBack)
            {
                LoadTrendingStatistics();
                LoadMostReportedIssues();
                LoadHighPriorityIssues();
                LoadActiveIssues();
                LoadCategoryAnalysis();
            }
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
        // CHECK OFFICER LOGIN
        // =========================================================

        private void CheckOfficerLogin()
        {
            if (Session["UserID"] == null ||
                Session["RoleID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int roleID;

            if (!int.TryParse(
                Session["RoleID"].ToString(),
                out roleID))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // RoleID 2 = Officer
            if (roleID != 2)
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
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return 0;
            }

            int officerID;

            if (!int.TryParse(
                Session["UserID"].ToString(),
                out officerID))
            {
                Response.Redirect("~/Login.aspx");
                return 0;
            }

            return officerID;
        }


        // =========================================================
        // LOAD TRENDING STATISTICS
        // =========================================================

        private void LoadTrendingStatistics()
        {
            int officerID = GetOfficerID();

            if (officerID <= 0)
            {
                return;
            }

            string query = @"
                SELECT

                    COUNT(*) AS TotalIssues,

                    SUM(
                        CASE
                            WHEN Priority = 'High'
                            THEN 1
                            ELSE 0
                        END
                    ) AS HighPriorityIssues,

                    SUM(
                        CASE
                            WHEN Status <> 'Resolved'
                            THEN 1
                            ELSE 0
                        END
                    ) AS ActiveIssues

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
                        // =================================================
                        // TOTAL ISSUES
                        // =================================================

                        lblTotalIssues.Text =
                            reader["TotalIssues"] != DBNull.Value
                            ? reader["TotalIssues"].ToString()
                            : "0";


                        // =================================================
                        // HIGH PRIORITY
                        // =================================================

                        lblHighPriority.Text =
                            reader["HighPriorityIssues"] != DBNull.Value
                            ? reader["HighPriorityIssues"].ToString()
                            : "0";


                        // =================================================
                        // ACTIVE ISSUES
                        // =================================================

                        lblActiveIssues.Text =
                            reader["ActiveIssues"] != DBNull.Value
                            ? reader["ActiveIssues"].ToString()
                            : "0";
                    }
                }
            }


            // =========================================================
            // LOAD TOP ISSUE
            // =========================================================

            LoadTopIssue();
        }


        // =========================================================
        // LOAD TOP ISSUE
        // =========================================================

        private void LoadTopIssue()
        {
            int officerID = GetOfficerID();

            if (officerID <= 0)
            {
                return;
            }

            string query = @"
                SELECT TOP 1

                    ISNULL(CAT.CategoryName, 'Uncategorized')
                    AS CategoryName,

                    COUNT(*) AS IssueCount

                FROM Complaints C

                LEFT JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                WHERE C.AssignedOfficerID = @OfficerID

                GROUP BY
                    CAT.CategoryName

                ORDER BY
                    COUNT(*) DESC,
                    CAT.CategoryName ASC;
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
                        lblTopIssue.Text =
                            reader["CategoryName"].ToString();
                    }
                    else
                    {
                        lblTopIssue.Text =
                            "No Data";
                    }
                }
            }
        }


        // =========================================================
        // MOST REPORTED ISSUES
        // =========================================================

        private void LoadMostReportedIssues()
        {
            int officerID = GetOfficerID();

            if (officerID <= 0)
            {
                return;
            }

            string query = @"
                SELECT TOP 5

                    ISNULL(CAT.CategoryName, 'Uncategorized')
                    AS CategoryName,

                    COUNT(*) AS IssueCount

                FROM Complaints C

                LEFT JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                WHERE C.AssignedOfficerID = @OfficerID

                GROUP BY
                    CAT.CategoryName

                ORDER BY
                    COUNT(*) DESC,
                    CAT.CategoryName ASC;
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


                    // =================================================
                    // NO DATA
                    // =================================================

                    if (dt.Rows.Count == 0)
                    {
                        rptMostReported.DataSource = null;
                        rptMostReported.DataBind();

                        pnlNoReportedIssues.Visible = true;

                        return;
                    }


                    // =================================================
                    // DATA AVAILABLE
                    // =================================================

                    pnlNoReportedIssues.Visible = false;

                    rptMostReported.DataSource = dt;

                    rptMostReported.DataBind();
                }
            }
        }


        // =========================================================
        // HIGH PRIORITY ISSUES
        // =========================================================

        private void LoadHighPriorityIssues()
        {
            int officerID = GetOfficerID();

            if (officerID <= 0)
            {
                return;
            }

            string query = @"
                SELECT TOP 10

                    C.ComplaintID,

                    C.Title,

                    ISNULL(
                        CAT.CategoryName,
                        'Uncategorized'
                    ) AS CategoryName,

                    C.Priority,

                    C.Status,

                    C.CreatedDate

                FROM Complaints C

                LEFT JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                WHERE
                    C.AssignedOfficerID = @OfficerID

                    AND C.Priority = 'High'

                    AND C.Status <> 'Resolved'

                ORDER BY
                    C.CreatedDate DESC;
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


                    // =================================================
                    // NO HIGH PRIORITY ISSUES
                    // =================================================

                    if (dt.Rows.Count == 0)
                    {
                        rptHighPriority.DataSource = null;
                        rptHighPriority.DataBind();

                        pnlNoHighPriority.Visible = true;

                        return;
                    }


                    // =================================================
                    // DATA AVAILABLE
                    // =================================================

                    pnlNoHighPriority.Visible = false;

                    rptHighPriority.DataSource = dt;

                    rptHighPriority.DataBind();
                }
            }
        }


        // =========================================================
        // ACTIVE ISSUES
        // =========================================================

        private void LoadActiveIssues()
        {
            int officerID = GetOfficerID();

            if (officerID <= 0)
            {
                return;
            }

            string query = @"
                SELECT TOP 10

                    C.ComplaintID,

                    C.Title,

                    C.Status,

                    C.CreatedDate,

                    ISNULL(
                        CAT.CategoryName,
                        'Uncategorized'
                    ) AS CategoryName

                FROM Complaints C

                LEFT JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                WHERE
                    C.AssignedOfficerID = @OfficerID

                    AND C.Status <> 'Resolved'

                ORDER BY
                    C.CreatedDate DESC;
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


                    // =================================================
                    // NO ACTIVE ISSUES
                    // =================================================

                    if (dt.Rows.Count == 0)
                    {
                        rptActiveIssues.DataSource = null;
                        rptActiveIssues.DataBind();

                        pnlNoActiveIssues.Visible = true;

                        return;
                    }


                    // =================================================
                    // DATA AVAILABLE
                    // =================================================

                    pnlNoActiveIssues.Visible = false;

                    rptActiveIssues.DataSource = dt;

                    rptActiveIssues.DataBind();
                }
            }
        }


        // =========================================================
        // CATEGORY-WISE ANALYSIS
        // =========================================================

        private void LoadCategoryAnalysis()
        {
            int officerID = GetOfficerID();

            if (officerID <= 0)
            {
                return;
            }

            string query = @"
                SELECT

                    ISNULL(
                        CAT.CategoryName,
                        'Uncategorized'
                    ) AS CategoryName,

                    COUNT(*) AS TotalIssues,

                    SUM(
                        CASE
                            WHEN C.Status <> 'Resolved'
                            THEN 1
                            ELSE 0
                        END
                    ) AS ActiveIssues,

                    SUM(
                        CASE
                            WHEN C.Status = 'Resolved'
                            THEN 1
                            ELSE 0
                        END
                    ) AS ResolvedIssues,

                    SUM(
                        CASE
                            WHEN C.Priority = 'High'
                            THEN 1
                            ELSE 0
                        END
                    ) AS HighPriorityIssues

                FROM Complaints C

                LEFT JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                WHERE
                    C.AssignedOfficerID = @OfficerID

                GROUP BY
                    CAT.CategoryName

                ORDER BY
                    COUNT(*) DESC;
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


                    gvCategoryIssues.DataSource = dt;

                    gvCategoryIssues.DataBind();
                }
            }
        }
    }
}