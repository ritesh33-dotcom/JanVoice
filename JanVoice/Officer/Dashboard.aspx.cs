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
    public partial class Dashboard : Page
    {
        string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckLogin();

                LoadDashboardStatistics();

                LoadOfficerProfile();

                LoadRecentComplaints();

                LoadNotifications();

                LoadRecentActivity();
            }
        }

        private void CheckLogin()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
        }
        private void LoadDashboardStatistics()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"

SELECT

COUNT(*) TotalAssigned,

SUM(CASE WHEN Status='Pending' THEN 1 ELSE 0 END) Pending,

SUM(CASE WHEN Status='In Progress' THEN 1 ELSE 0 END) InProgress,

SUM(CASE WHEN Status='Resolved' THEN 1 ELSE 0 END) Resolved,

SUM(CASE WHEN Priority='High' THEN 1 ELSE 0 END) HighPriority,

SUM(CASE
WHEN CAST(CreatedDate AS DATE)=CAST(GETDATE() AS DATE)
THEN 1
ELSE 0
END) TodayComplaint

FROM Complaints

WHERE AssignedOfficerID=@OfficerID";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@OfficerID",
                    Convert.ToInt32(Session["UserID"]));

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblTotalAssigned.Text = dr["TotalAssigned"].ToString();

                    lblPending.Text = dr["Pending"] == DBNull.Value ? "0" : dr["Pending"].ToString();

                    lblInProgress.Text = dr["InProgress"] == DBNull.Value ? "0" : dr["InProgress"].ToString();

                    lblResolved.Text = dr["Resolved"] == DBNull.Value ? "0" : dr["Resolved"].ToString();

                    lblHighPriority.Text = dr["HighPriority"] == DBNull.Value ? "0" : dr["HighPriority"].ToString();

                    lblToday.Text = dr["TodayComplaint"] == DBNull.Value ? "0" : dr["TodayComplaint"].ToString();

                    hfPending.Value = lblPending.Text;

                    hfInProgress.Value = lblInProgress.Text;

                    hfResolved.Value = lblResolved.Text;
                }

                dr.Close();
            }
        }
        private void LoadOfficerProfile()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"

SELECT

U.FullName,

U.Email,

U.Mobile,

W.WardName,

(

SELECT COUNT(*)

FROM Complaints

WHERE AssignedOfficerID=U.UserID

AND Status='Resolved'

) TotalResolved

FROM Users U

INNER JOIN Wards W

ON U.WardID=W.WardID

WHERE U.UserID=@UserID";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@UserID",
                    Convert.ToInt32(Session["UserID"]));

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblOfficerName.Text = dr["FullName"].ToString();

                    lblOfficer.Text = dr["FullName"].ToString();

                    lblEmail.Text = dr["Email"].ToString();

                    lblMobile.Text = dr["Mobile"].ToString();

                    lblWard.Text = dr["WardName"].ToString();

                    lblDepartment.Text = "Ward Officer";

                    lblOfficerResolved.Text = dr["TotalResolved"].ToString();
                }

                dr.Close();
            }
        }
        private void LoadRecentComplaints()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"

SELECT TOP 10

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

                cmd.Parameters.AddWithValue("@OfficerID",
                    Convert.ToInt32(Session["UserID"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvRecentComplaints.DataSource = dt;

                gvRecentComplaints.DataBind();
            }
        }
        private void LoadNotifications()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"

SELECT TOP 5

Message,

CreatedDate

FROM Notifications

WHERE UserID=@UserID

ORDER BY CreatedDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@UserID",
                    Convert.ToInt32(Session["UserID"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rptNotifications.DataSource = dt;

                rptNotifications.DataBind();
            }
        }
        private void LoadRecentActivity()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"

SELECT TOP 5

NewStatus,

Remarks,

ChangeDate

FROM StatusHistory

WHERE ChangedBy=@OfficerID

ORDER BY ChangeDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@OfficerID",
                    Convert.ToInt32(Session["UserID"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rptRecentActivity.DataSource = dt;

                rptRecentActivity.DataBind();
            }
        }
    }
}