using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace JanVoice.Officer
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardCards();
                LoadRecentComplaints();


            }

        }
        private void LoadDashboardCards()
        {
            try
            {
                int officerID = Convert.ToInt32(Session["UserID"]);

                string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
                                    SELECT

                                    COUNT(*) AS TotalAssigned,

                                    ISNULL(SUM(CASE
                                        WHEN Status='Pending'
                                        THEN 1
                                        ELSE 0
                                    END),0) AS Pending,

                                    ISNULL(SUM(CASE
                                        WHEN Status='In Progress'
                                        THEN 1
                                        ELSE 0
                                    END),0) AS InProgress,

                                    ISNULL(SUM(CASE
                                        WHEN Status='Resolved'
                                        THEN 1
                                        ELSE 0
                                    END),0) AS Resolved,

                                    ISNULL(SUM(CASE
                                        WHEN Priority='High'
                                        THEN 1
                                        ELSE 0
                                    END),0) AS HighPriority,

                                    ISNULL(SUM(CASE
                                        WHEN CAST(CreatedDate AS DATE)=CAST(GETDATE() AS DATE)
                                        THEN 1
                                        ELSE 0
                                    END),0) AS TodayComplaints

                                    FROM Complaints

                                    WHERE AssignedOfficerID=@OfficerID";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@OfficerID", officerID);

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            lblTotalAssigned.Text = Convert.ToString(dr["TotalAssigned"]);

                            lblPending.Text = Convert.ToString(dr["Pending"]);

                            lblInProgress.Text = Convert.ToString(dr["InProgress"]);

                            lblResolved.Text = Convert.ToString(dr["Resolved"]);

                            lblHighPriority.Text = Convert.ToString(dr["HighPriority"]);

                            lblToday.Text = Convert.ToString(dr["TodayComplaints"]);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message.Replace("'", "") + "');</script>");
            }
        }
            private void LoadRecentComplaints()
        {
            try
            {
                int officerID = Convert.ToInt32(Session["UserID"]);

                string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"

            SELECT TOP 5

                C.ComplaintID,

                C.Title,

                U.FullName AS CitizenName,

                CAT.CategoryName,

                C.Priority,

                C.Status,

                C.CreatedDate

            FROM Complaints C

            INNER JOIN Users U

                ON C.UserID = U.UserID

            INNER JOIN Categories CAT

                ON C.CategoryID = CAT.CategoryID

            WHERE C.AssignedOfficerID = @OfficerID

            ORDER BY C.CreatedDate DESC";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@OfficerID", officerID);

                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    gvRecentComplaints.DataSource = dr;

                    gvRecentComplaints.DataBind();

                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message.Replace("'", "") + "');</script>");
            }
        }
        private void LoadComplaintChart()
        {
            try
            {
                int officerID = Convert.ToInt32(Session["UserID"]);

                string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"

            SELECT

            ISNULL(SUM(CASE WHEN Status='Pending'
            THEN 1 ELSE 0 END),0) AS Pending,

            ISNULL(SUM(CASE WHEN Status='In Progress'
            THEN 1 ELSE 0 END),0) AS InProgress,

            ISNULL(SUM(CASE WHEN Status='Resolved'
            THEN 1 ELSE 0 END),0) AS Resolved

            FROM Complaints

            WHERE AssignedOfficerID=@OfficerID";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@OfficerID", officerID);

                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        hfPending.Value = dr["Pending"].ToString();

                        hfInProgress.Value = dr["InProgress"].ToString();

                        hfResolved.Value = dr["Resolved"].ToString();
                    }

                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message.Replace("'", "") + "');</script>");
            }
        }
    }
    
}
       