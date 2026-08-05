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
    public partial class CommunityFeed : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadWards();
                LoadStatus();

                LoadComplaints();
            }

        }


        private void LoadComplaints()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        C.ComplaintID,
                        C.Title,
                        C.Description,
                        C.Status,
                        C.CreatedDate,

                        U.FullName,
                        ISNULL(U.ProfilePhoto,'Images/user.png') AS ProfilePhoto,

                        W.WardName,
                        CAT.CategoryName,

                        ISNULL(CI.ImagePath,'Images/no-image.png') AS ImagePath,

                        ISNULL(S.SupportCount,0) AS SupportCount,
                        ISNULL(COM.CommentCount,0) AS CommentCount

                    FROM Complaints C

                    INNER JOIN Users U
                    ON C.UserID = U.UserID

                    INNER JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                    INNER JOIN Wards W
                    ON C.WardID = W.WardID

                    LEFT JOIN ComplaintImages CI
                    ON C.ComplaintID = CI.ComplaintID

                    LEFT JOIN
                    (
                        SELECT ComplaintID,
                               COUNT(*) SupportCount
                        FROM Supports
                        GROUP BY ComplaintID
                    ) S
                    ON C.ComplaintID = S.ComplaintID

                    LEFT JOIN
                    (
                        SELECT ComplaintID,
                               COUNT(*) CommentCount
                        FROM Comments
                        GROUP BY ComplaintID
                    ) COM
                    ON C.ComplaintID = COM.ComplaintID

                    WHERE 1=1";

                if (!string.IsNullOrWhiteSpace(txtSearch.Text))
                {
                    query += @" AND
                             (
                                C.Title LIKE @Search
                                OR
                                C.Description LIKE @Search
                            )";
                }

                if (ddlCategory.SelectedValue != "0")
                {
                    query += " AND C.CategoryID=@CategoryID";
                }

                if (ddlWard.SelectedValue != "0")
                {
                    query += " AND C.WardID=@WardID";
                }

                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                {
                    query += " AND C.Status=@Status";
                }

                query += " ORDER BY C.CreatedDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);

                if (!string.IsNullOrWhiteSpace(txtSearch.Text))
                {
                    cmd.Parameters.AddWithValue(
                        "@Search",
                        "%" + txtSearch.Text.Trim() + "%");
                }

                if (ddlCategory.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue(
                        "@CategoryID",
                        ddlCategory.SelectedValue);
                }

                if (ddlWard.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue(
                        "@WardID",
                        ddlWard.SelectedValue);
                }

                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                {
                    cmd.Parameters.AddWithValue(
                        "@Status",
                        ddlStatus.SelectedValue);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rptComplaints.DataSource = dt;

                rptComplaints.DataBind();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();

                ddlCategory.Items.Insert(0, new ListItem("All Categories", "0"));
            }
        }

        private void LoadWards()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT WardID, WardName FROM Wards ORDER BY WardName";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlWard.DataSource = dt;
                ddlWard.DataTextField = "WardName";
                ddlWard.DataValueField = "WardID";
                ddlWard.DataBind();

                ddlWard.Items.Insert(0, new ListItem("All Wards", "0"));
            }
        }

        private void LoadStatus()
        {
            ddlStatus.Items.Clear();

            ddlStatus.Items.Add(new ListItem("All Status", ""));
            ddlStatus.Items.Add(new ListItem("Pending", "Pending"));
            ddlStatus.Items.Add(new ListItem("Accepted", "Accepted"));
            ddlStatus.Items.Add(new ListItem("In Progress", "In Progress"));
            ddlStatus.Items.Add(new ListItem("Resolved", "Resolved"));
            ddlStatus.Items.Add(new ListItem("Rejected", "Rejected"));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadComplaints();
        }

        protected void rptComplaints_ItemCommand(object source,RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Support")
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                int complaintID =
                    Convert.ToInt32(e.CommandArgument);

                int userID =
                    Convert.ToInt32(Session["UserID"]);

            }
        }

        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "pending":
                    return "pending";

                case "accepted":
                case "in progress":
                    return "accepted";

                case "resolved":
                    return "resolved";

                case "rejected":
                    return "rejected";

                default:
                    return "pending";
            }
        }

    }
}
