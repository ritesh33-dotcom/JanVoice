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
    public partial class CommunityLeaderboard : Page
    {
        // =========================================================
        // CONNECTION STRING
        // =========================================================

        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckOfficerLogin();

            if (!IsPostBack)
            {
                LoadLeaderboard();
            }
        }


        // =========================================================
        // CHECK OFFICER LOGIN
        // =========================================================

        private void CheckOfficerLogin()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (Session["RoleID"] == null)
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
        // MAIN LEADERBOARD LOADER
        // =========================================================

        private void LoadLeaderboard()
        {
            try
            {
                DataTable dt = GetLeaderboardData();

                if (dt.Rows.Count == 0)
                {
                    SetEmptyLeaderboard();
                    return;
                }

                // -------------------------------------------------
                // CALCULATE CONTRIBUTION SCORE
                // -------------------------------------------------

                foreach (DataRow row in dt.Rows)
                {
                    int reports = 0;
                    int resolved = 0;
                    int supports = 0;

                    if (row["ReportsCount"] != DBNull.Value)
                    {
                        reports =
                            Convert.ToInt32(row["ReportsCount"]);
                    }

                    if (row["ResolvedCount"] != DBNull.Value)
                    {
                        resolved =
                            Convert.ToInt32(row["ResolvedCount"]);
                    }

                    if (row["SupportsCount"] != DBNull.Value)
                    {
                        supports =
                            Convert.ToInt32(row["SupportsCount"]);
                    }


                    // -------------------------------------------------
                    // CONTRIBUTION SCORE
                    // -------------------------------------------------
                    //
                    // Reported Issue  = 10 points
                    // Resolved Issue  = 20 points
                    // Support        = 2 points
                    //

                    int score =
                        (reports * 10)
                        +
                        (resolved * 20)
                        +
                        (supports * 2);


                    row["ContributionScore"] = score;


                    // -------------------------------------------------
                    // BADGE
                    // -------------------------------------------------

                    string badge;

                    if (score >= 200)
                    {
                        badge = "Champion";
                    }
                    else if (score >= 120)
                    {
                        badge = "Gold";
                    }
                    else if (score >= 70)
                    {
                        badge = "Silver";
                    }
                    else if (score >= 30)
                    {
                        badge = "Bronze";
                    }
                    else
                    {
                        badge = "Member";
                    }


                    row["Badge"] = badge;
                }


                // =================================================
                // SORT BY CONTRIBUTION SCORE
                // =================================================

                DataView view = dt.DefaultView;

                view.Sort =
                    "ContributionScore DESC, ReportsCount DESC";


                DataTable sortedTable =
                    view.ToTable();


                // =================================================
                // FULL LEADERBOARD
                // =================================================

                gvLeaderboard.DataSource = sortedTable;

                gvLeaderboard.DataBind();


                // =================================================
                // STATISTICS
                // =================================================

                LoadStatistics();


                // =================================================
                // TOP CONTRIBUTOR
                // =================================================

                LoadTopContributor(sortedTable);


                // =================================================
                // TOP THREE
                // =================================================

                LoadTopThree(sortedTable);


                // =================================================
                // CONTRIBUTION BREAKDOWN
                // =================================================

                LoadContributionBreakdown();
            }
            catch (Exception)
            {
                SetEmptyLeaderboard();

                // Development ke time agar exact database error
                // dekhna ho to neeche wala code temporarily use
                // kar sakte ho.
                //
                // Response.Write(ex.Message);
            }
        }


        // =========================================================
        // GET LEADERBOARD DATA
        // =========================================================

        private DataTable GetLeaderboardData()
        {
            DataTable dt = new DataTable();


            string query = @"
                SELECT
                    U.UserID,
                    U.FullName AS CitizenName,

                    COUNT(DISTINCT C.ComplaintID)
                        AS ReportsCount,

                    COUNT(
                        DISTINCT
                        CASE
                            WHEN C.Status = 'Resolved'
                            THEN C.ComplaintID
                        END
                    ) AS ResolvedCount,

                    COUNT(DISTINCT S.SupportID)
                        AS SupportsCount,

                    CAST(0 AS INT)
                        AS ContributionScore,

                    CAST('Member' AS NVARCHAR(50))
                        AS Badge

                FROM Users U

                LEFT JOIN Complaints C
                    ON U.UserID = C.UserID

                LEFT JOIN Supports S
                    ON U.UserID = S.UserID

                WHERE U.RoleID <> 2

                GROUP BY
                    U.UserID,
                    U.FullName

                HAVING
                    COUNT(DISTINCT C.ComplaintID) > 0
                    OR
                    COUNT(DISTINCT S.SupportID) > 0

                ORDER BY
                    ReportsCount DESC;
            ";


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            using (SqlDataAdapter da =
                   new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }


            return dt;
        }


        // =========================================================
        // LOAD STATISTICS
        // =========================================================

        private void LoadStatistics()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // -------------------------------------------------
                // TOTAL PARTICIPANTS
                // -------------------------------------------------

                string participantQuery = @"
                    SELECT COUNT(DISTINCT U.UserID)

                    FROM Users U

                    LEFT JOIN Complaints C
                        ON U.UserID = C.UserID

                    LEFT JOIN Supports S
                        ON U.UserID = S.UserID

                    WHERE U.RoleID <> 2

                    AND
                    (
                        C.ComplaintID IS NOT NULL
                        OR
                        S.SupportID IS NOT NULL
                    );
                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           participantQuery,
                           con))
                {
                    object result =
                        cmd.ExecuteScalar();

                    lblTotalParticipants.Text =
                        result == null ||
                        result == DBNull.Value
                            ? "0"
                            : result.ToString();
                }


                // -------------------------------------------------
                // TOTAL REPORTS
                // -------------------------------------------------

                string reportsQuery = @"
                    SELECT COUNT(*)
                    FROM Complaints;
                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           reportsQuery,
                           con))
                {
                    object result =
                        cmd.ExecuteScalar();

                    lblTotalReports.Text =
                        result == null ||
                        result == DBNull.Value
                            ? "0"
                            : result.ToString();
                }


                // -------------------------------------------------
                // TOTAL SUPPORTS
                // -------------------------------------------------

                string supportsQuery = @"
                    SELECT COUNT(*)
                    FROM Supports;
                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           supportsQuery,
                           con))
                {
                    object result =
                        cmd.ExecuteScalar();

                    lblTotalSupports.Text =
                        result == null ||
                        result == DBNull.Value
                            ? "0"
                            : result.ToString();
                }
            }
        }


        // =========================================================
        // TOP CONTRIBUTOR
        // =========================================================

        private void LoadTopContributor(DataTable dt)
        {
            if (dt == null ||
                dt.Rows.Count == 0)
            {
                lblTopContributor.Text = "No Data";
                return;
            }


            lblTopContributor.Text =
                dt.Rows[0]["CitizenName"].ToString();
        }


        // =========================================================
        // LOAD TOP THREE
        // =========================================================

        private void LoadTopThree(DataTable dt)
        {
            // -----------------------------------------------------
            // FIRST PLACE
            // -----------------------------------------------------

            if (dt.Rows.Count >= 1)
            {
                lblFirstPlace.Text =
                    dt.Rows[0]["CitizenName"].ToString();

                lblFirstScore.Text =
                    dt.Rows[0]["ContributionScore"].ToString();
            }
            else
            {
                lblFirstPlace.Text = "-";
                lblFirstScore.Text = "0";
            }


            // -----------------------------------------------------
            // SECOND PLACE
            // -----------------------------------------------------

            if (dt.Rows.Count >= 2)
            {
                lblSecondPlace.Text =
                    dt.Rows[1]["CitizenName"].ToString();

                lblSecondScore.Text =
                    dt.Rows[1]["ContributionScore"].ToString();
            }
            else
            {
                lblSecondPlace.Text = "-";
                lblSecondScore.Text = "0";
            }


            // -----------------------------------------------------
            // THIRD PLACE
            // -----------------------------------------------------

            if (dt.Rows.Count >= 3)
            {
                lblThirdPlace.Text =
                    dt.Rows[2]["CitizenName"].ToString();

                lblThirdScore.Text =
                    dt.Rows[2]["ContributionScore"].ToString();
            }
            else
            {
                lblThirdPlace.Text = "-";
                lblThirdScore.Text = "0";
            }
        }


        // =========================================================
        // CONTRIBUTION BREAKDOWN
        // =========================================================

        private void LoadContributionBreakdown()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // -------------------------------------------------
                // TOTAL REPORTS
                // -------------------------------------------------

                string reportsQuery = @"
                    SELECT COUNT(*)
                    FROM Complaints;
                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           reportsQuery,
                           con))
                {
                    object result =
                        cmd.ExecuteScalar();

                    lblContributionReports.Text =
                        result == null ||
                        result == DBNull.Value
                            ? "0"
                            : result.ToString();
                }


                // -------------------------------------------------
                // TOTAL SUPPORTS
                // -------------------------------------------------

                string supportsQuery = @"
                    SELECT COUNT(*)
                    FROM Supports;
                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           supportsQuery,
                           con))
                {
                    object result =
                        cmd.ExecuteScalar();

                    lblContributionSupports.Text =
                        result == null ||
                        result == DBNull.Value
                            ? "0"
                            : result.ToString();
                }


                // -------------------------------------------------
                // TOTAL RESOLVED
                // -------------------------------------------------

                string resolvedQuery = @"
                    SELECT COUNT(*)
                    FROM Complaints
                    WHERE Status = 'Resolved';
                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           resolvedQuery,
                           con))
                {
                    object result =
                        cmd.ExecuteScalar();

                    lblContributionResolved.Text =
                        result == null ||
                        result == DBNull.Value
                            ? "0"
                            : result.ToString();
                }


                // -------------------------------------------------
                // ACTIVE CITIZENS
                // -------------------------------------------------

                string citizensQuery = @"
                    SELECT COUNT(DISTINCT UserID)
                    FROM Complaints;
                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           citizensQuery,
                           con))
                {
                    object result =
                        cmd.ExecuteScalar();

                    lblContributionCitizens.Text =
                        result == null ||
                        result == DBNull.Value
                            ? "0"
                            : result.ToString();
                }
            }
        }


        // =========================================================
        // EMPTY DATA
        // =========================================================

        private void SetEmptyLeaderboard()
        {
            // -----------------------------------------------------
            // STATISTICS
            // -----------------------------------------------------

            lblTotalParticipants.Text = "0";

            lblTotalReports.Text = "0";

            lblTopContributor.Text = "No Data";

            lblTotalSupports.Text = "0";


            // -----------------------------------------------------
            // TOP THREE
            // -----------------------------------------------------

            lblFirstPlace.Text = "-";
            lblFirstScore.Text = "0";

            lblSecondPlace.Text = "-";
            lblSecondScore.Text = "0";

            lblThirdPlace.Text = "-";
            lblThirdScore.Text = "0";


            // -----------------------------------------------------
            // CONTRIBUTION
            // -----------------------------------------------------

            lblContributionReports.Text = "0";

            lblContributionSupports.Text = "0";

            lblContributionResolved.Text = "0";

            lblContributionCitizens.Text = "0";


            // -----------------------------------------------------
            // GRID
            // -----------------------------------------------------

            gvLeaderboard.DataSource = null;

            gvLeaderboard.DataBind();
        }
    }
}