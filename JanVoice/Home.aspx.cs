using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace JanVoice
{
    public partial class Home : System.Web.UI.Page
    {
        // =========================================================
        // CONNECTION STRING
        // =========================================================

        private readonly string connectionString =
            ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;


        // =========================================================
        // HOME STATISTICS
        // =========================================================

        protected int TotalReports = 0;

        protected int ResolvedIssues = 0;

        protected int ActiveCitizens = 0;

        protected int SuccessRate = 0;



        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatistics();

                LoadCommunityFeed();

                LoadCategories();
            }
        }



        // =========================================================
        // LOAD STATISTICS
        // =========================================================

        private void LoadStatistics()
        {
            try
            {
                using (SqlConnection con =
                    new SqlConnection(connectionString))
                {
                    con.Open();


                    // =================================================
                    // TOTAL REPORTS
                    // =================================================

                    string totalQuery = @"
                        SELECT COUNT(*)
                        FROM Complaints";


                    using (SqlCommand cmd =
                        new SqlCommand(totalQuery, con))
                    {
                        TotalReports =
                            Convert.ToInt32(cmd.ExecuteScalar());
                    }



                    // =================================================
                    // RESOLVED ISSUES
                    // =================================================

                    string resolvedQuery = @"
                        SELECT COUNT(*)
                        FROM Complaints
                        WHERE Status = 'Resolved'";


                    using (SqlCommand cmd =
                        new SqlCommand(resolvedQuery, con))
                    {
                        ResolvedIssues =
                            Convert.ToInt32(cmd.ExecuteScalar());
                    }



                    // =================================================
                    // ACTIVE CITIZENS
                    //
                    // Citizen RoleID = 1
                    // IsActive = 1
                    // =================================================

                    string citizensQuery = @"
                        SELECT COUNT(*)
                        FROM Users
                        WHERE RoleID = 1
                        AND IsActive = 1";


                    using (SqlCommand cmd =
                        new SqlCommand(citizensQuery, con))
                    {
                        ActiveCitizens =
                            Convert.ToInt32(cmd.ExecuteScalar());
                    }



                    // =================================================
                    // SUCCESS RATE
                    // =================================================

                    if (TotalReports > 0)
                    {
                        SuccessRate =
                            (ResolvedIssues * 100) / TotalReports;
                    }
                    else
                    {
                        SuccessRate = 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    ex.ToString()
                );

                TotalReports = 0;

                ResolvedIssues = 0;

                ActiveCitizens = 0;

                SuccessRate = 0;
            }
        }



        // =========================================================
        // LOAD COMMUNITY FEED
        // =========================================================

        private void LoadCommunityFeed()
        {
            string query = @"

                SELECT TOP 3

                    c.ComplaintID,

                    c.Title,

                    c.Description,

                    c.Status,

                    c.Priority,

                    c.CreatedDate,

                    w.WardName,

                    cat.CategoryName,


                    -- SUPPORT COUNT
                    (
                        SELECT COUNT(*)
                        FROM Supports s
                        WHERE s.ComplaintID = c.ComplaintID
                    ) AS SupportCount,


                    -- COMMENT COUNT
                    (
                        SELECT COUNT(*)
                        FROM Comments cm
                        WHERE cm.ComplaintID = c.ComplaintID
                    ) AS CommentCount,


                    -- IMAGE COUNT
                    (
                        SELECT COUNT(*)
                        FROM ComplaintImages ci
                        WHERE ci.ComplaintID = c.ComplaintID
                    ) AS ImageCount


                FROM Complaints c


                LEFT JOIN Wards w
                    ON c.WardID = w.WardID


                LEFT JOIN Categories cat
                    ON c.CategoryID = cat.CategoryID


                ORDER BY c.CreatedDate DESC
            ";


            try
            {
                using (SqlConnection con =
                    new SqlConnection(connectionString))
                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                using (SqlDataAdapter da =
                    new SqlDataAdapter(cmd))
                {
                    DataTable dt =
                        new DataTable();

                    da.Fill(dt);


                    rptCommunityFeed.DataSource = dt;

                    rptCommunityFeed.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    ex.ToString()
                );
            }
        }



        // =========================================================
        // LOAD CATEGORIES
        // =========================================================

        private void LoadCategories()
        {
            string query = @"

                SELECT

                    cat.CategoryID,

                    cat.CategoryName,

                    cat.Icon,

                    cat.Description,

                    (

                        SELECT COUNT(*)

                        FROM Complaints c

                        WHERE c.CategoryID =
                              cat.CategoryID

                    ) AS IssueCount


                FROM Categories cat


                WHERE cat.IsActive = 1


                ORDER BY cat.CategoryID
            ";


            try
            {
                using (SqlConnection con =
                    new SqlConnection(connectionString))
                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                using (SqlDataAdapter da =
                    new SqlDataAdapter(cmd))
                {
                    DataTable dt =
                        new DataTable();

                    da.Fill(dt);


                    rptCategories.DataSource = dt;

                    rptCategories.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    ex.ToString()
                );
            }
        }



        // =========================================================
        // STATUS CSS CLASS
        // =========================================================

        protected string GetStatusCssClass(string status)
        {
            if (string.IsNullOrWhiteSpace(status))
            {
                return "status pending";
            }


            switch (status.Trim().ToLower())
            {
                case "resolved":

                    return "status resolved";


                case "in progress":

                    return "status progress";


                case "progress":

                    return "status progress";


                case "pending":

                    return "status pending";


                default:

                    return "status pending";
            }
        }



        // =========================================================
        // CATEGORY ICON
        // =========================================================

        protected string GetCategoryIcon(string categoryName)
        {
            if (string.IsNullOrWhiteSpace(categoryName))
            {
                return "fa-solid fa-circle";
            }


            switch (categoryName.Trim().ToLower())
            {
                case "garbage":

                    return "fa-solid fa-trash";


                case "road":

                    return "fa-solid fa-road";


                case "street light":

                    return "fa-solid fa-lightbulb";


                case "water leakage":

                    return "fa-solid fa-faucet-drip";


                case "drainage":

                    return "fa-solid fa-water";


                case "electricity":

                    return "fa-solid fa-bolt";


                case "traffic signal":

                    return "fa-solid fa-traffic-light";


                case "public toilet":

                    return "fa-solid fa-restroom";


                case "illegal dumping":

                    return "fa-solid fa-dumpster";


                case "other":

                    return "fa-solid fa-circle-question";


                default:

                    return "fa-solid fa-circle";
            }
        }
    }
}