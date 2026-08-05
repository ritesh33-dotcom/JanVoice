using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

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
                LoadStatistics();
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

                        ISNULL(COM.CommentCount,0) AS CommentCount,

                                CASE
                                    WHEN EXISTS
                                    (
                                        SELECT 1
                                        FROM Supports SP
                                        WHERE SP.ComplaintID = C.ComplaintID
                                        AND SP.UserID = @CurrentUserID
                                    )
                                    THEN 1
                                    ELSE 0
                                END AS IsSupported

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

                if (Session["UserID"] != null)
                {
                    cmd.Parameters.AddWithValue(
                        "@CurrentUserID",
                        Convert.ToInt32(Session["UserID"]));
                }
                else
                {
                    cmd.Parameters.AddWithValue(
                        "@CurrentUserID",
                        0);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rptComplaints.DataSource = dt;

                rptComplaints.DataBind();

                if (dt.Rows.Count == 0)
                {
                    pnlNoData.Visible = true;
                }
                else
                {
                    pnlNoData.Visible = false;
                }

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

        private void LoadStatistics()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Total Complaints
                SqlCommand cmdComplaints = new SqlCommand(
                    "SELECT COUNT(*) FROM Complaints", con);

                lblComplaints.Text =
                    cmdComplaints.ExecuteScalar().ToString();

                // Total Supports
                SqlCommand cmdSupports = new SqlCommand(
                    "SELECT COUNT(*) FROM Supports", con);

                lblSupports.Text =
                    cmdSupports.ExecuteScalar().ToString();

                // Total Comments
                SqlCommand cmdComments = new SqlCommand(
                    "SELECT COUNT(*) FROM Comments", con);

                lblComments.Text =
                    cmdComments.ExecuteScalar().ToString();

                // Total Citizens
                SqlCommand cmdCitizens = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE RoleID = 1", con);

                lblCitizens.Text =
                    cmdCitizens.ExecuteScalar().ToString();
            }
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
                    Response.Redirect("~/Login.aspx?ReturnUrl=CommunityFeed.aspx");

                    return;
                }

                int complaintID =
                    Convert.ToInt32(e.CommandArgument);

                int userID =
                    Convert.ToInt32(Session["UserID"]);
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                         string checkQuery = @"
                        SELECT COUNT(*)
                        FROM Supports
                        WHERE ComplaintID = @ComplaintID
                        AND UserID = @UserID";

                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);

                    checkCmd.Parameters.AddWithValue("@ComplaintID", complaintID);
                    checkCmd.Parameters.AddWithValue("@UserID", userID);

                    int count = Convert.ToInt32(checkCmd.ExecuteScalar());
                    if (count > 0)
                    {
                         string deleteQuery = @"
                        DELETE FROM Supports
                        WHERE ComplaintID = @ComplaintID
                        AND UserID = @UserID";

                        SqlCommand deleteCmd = new SqlCommand(deleteQuery, con);

                        deleteCmd.Parameters.AddWithValue("@ComplaintID", complaintID);
                        deleteCmd.Parameters.AddWithValue("@UserID", userID);

                        deleteCmd.ExecuteNonQuery();
                    }
                    else
                    {
                               string insertQuery = @"
                                INSERT INTO Supports
                                (
                                    ComplaintID,
                                    UserID,
                                    SupportDate
                                )
                                VALUES
                                (
                                    @ComplaintID,
                                    @UserID,
                                    GETDATE()
                                )";

                        SqlCommand insertCmd = new SqlCommand(insertQuery, con);

                        insertCmd.Parameters.AddWithValue("@ComplaintID", complaintID);
                        insertCmd.Parameters.AddWithValue("@UserID", userID);

                        insertCmd.ExecuteNonQuery();

                        string ownerQuery = @"
                                            SELECT UserID
                                            FROM Complaints
                                            WHERE ComplaintID=@ComplaintID";

                        SqlCommand ownerCmd = new SqlCommand(ownerQuery, con);

                        ownerCmd.Parameters.AddWithValue("@ComplaintID", complaintID);

                        int ownerID = Convert.ToInt32(ownerCmd.ExecuteScalar());

                        if (ownerID != userID)
                        {
                            string nameQuery = @"
                                                SELECT FullName
                                                FROM Users
                                                WHERE UserID=@UserID";

                            SqlCommand nameCmd =
                                new SqlCommand(nameQuery, con);

                            nameCmd.Parameters.AddWithValue("@UserID", userID);

                            string supporterName =
                                nameCmd.ExecuteScalar().ToString();

                            string notificationQuery = @"

                                            INSERT INTO Notifications
                                            (
                                                UserID,
                                                ComplaintID,
                                                Title,
                                                Message,
                                                NotificationType,
                                                IsRead,
                                                CreatedDate
                                            )

                                            VALUES
                                            (
                                                @OwnerID,
                                                @ComplaintID,
                                                @Title,
                                                @Message,
                                                @Type,
                                                0,
                                                GETDATE()
                                            )";

                            SqlCommand notificationCmd =
                                new SqlCommand(notificationQuery, con);

                            notificationCmd.Parameters.AddWithValue("@OwnerID", ownerID);

                            notificationCmd.Parameters.AddWithValue("@ComplaintID", complaintID);

                            notificationCmd.Parameters.AddWithValue("@Title", "❤️ New Support");

                            notificationCmd.Parameters.AddWithValue(
                                "@Message",
                                supporterName + " supported your complaint.");

                            notificationCmd.Parameters.AddWithValue(
                                "@Type",
                                "Support");

                            notificationCmd.ExecuteNonQuery();
                        }



                    }
                }

                LoadComplaints();

            }
            else if (e.CommandName == "Comment")
            {
                int complaintID =
                    Convert.ToInt32(e.CommandArgument);

                hfComplaintID.Value = complaintID.ToString();

                LoadComments(complaintID);

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "OpenComment",
                    "openCommentModal();",
                    true);
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

        protected string GetSupportText(object value)
        {
            if (Convert.ToInt32(value) == 1)
            {
                return "❤️ Supported";
            }

            return "❤️ Support";
        }

        protected string GetSupportClass(object value)
        {
            if (Convert.ToInt32(value) == 1)
            {
                return "btn-supported";
            }

            return "btn-support";
        }

        protected string GetTimeAgo(object date)
        {
            DateTime createdDate = Convert.ToDateTime(date);

            TimeSpan span = DateTime.Now - createdDate;

            if (span.TotalSeconds < 60)
                return "Just now";

            if (span.TotalMinutes < 60)
                return $"{(int)span.TotalMinutes} minute(s) ago";

            if (span.TotalHours < 24)
                return $"{(int)span.TotalHours} hour(s) ago";

            if (span.TotalDays < 2)
                return "Yesterday";

            if (span.TotalDays < 7)
                return $"{(int)span.TotalDays} days ago";

            if (span.TotalDays < 30)
                return $"{(int)(span.TotalDays / 7)} week(s) ago";

            if (span.TotalDays < 365)
                return $"{(int)(span.TotalDays / 30)} month(s) ago";

            return $"{(int)(span.TotalDays / 365)} year(s) ago";
        }

        protected string ShortDescription(object description)
        {
            string text = description.ToString();

            if (text.Length <= 120)
                return text;

            return text.Substring(0, 120) + "...";
        }

        private void LoadComments(int complaintID)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"

                                SELECT

                                    C.Comment,

                                    C.CommentDate,

                                    U.FullName,

                                    ISNULL(U.ProfilePhoto,'Images/user.png')
                                    AS ProfilePhoto

                                FROM Comments C

                                INNER JOIN Users U
                                ON C.UserID = U.UserID

                                WHERE C.ComplaintID=@ComplaintID

                                ORDER BY C.CommentDate DESC";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@ComplaintID",
                    complaintID);

                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                rptComments.DataSource = dt;

                rptComments.DataBind();
            }
        }
        protected void btnPostComment_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx?ReturnUrl=CommunityFeed.aspx");
                return;
            }

            int complaintID =
    Convert.ToInt32(hfComplaintID.Value);

            int userID =
                Convert.ToInt32(Session["UserID"]);

            string comment =
                txtComment.Text.Trim();

            if (string.IsNullOrWhiteSpace(comment))
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "msg",
                    "alert('Please enter a comment.');",
                    true);

                return;
            }
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string insertQuery = @"
                                    INSERT INTO Comments
                                    (
                                        ComplaintID,
                                        UserID,
                                        Comment,
                                        CommentDate,
                                        IsEdited
                                    )
                                    VALUES
                                    (
                                        @ComplaintID,
                                        @UserID,
                                        @Comment,
                                        GETDATE(),
                                        0
                                    )";

                SqlCommand insertCmd = new SqlCommand(insertQuery, con);

                insertCmd.Parameters.AddWithValue("@ComplaintID", complaintID);
                insertCmd.Parameters.AddWithValue("@UserID", userID);
                insertCmd.Parameters.AddWithValue("@Comment", comment);

                insertCmd.ExecuteNonQuery();

                string ownerQuery = @"
        SELECT UserID
        FROM Complaints
        WHERE ComplaintID=@ComplaintID";

                SqlCommand ownerCmd = new SqlCommand(ownerQuery, con);

                ownerCmd.Parameters.AddWithValue("@ComplaintID", complaintID);

                int ownerID = Convert.ToInt32(ownerCmd.ExecuteScalar());

                if (ownerID != userID)
                {
                    string nameQuery = @"
            SELECT FullName
            FROM Users
            WHERE UserID=@UserID";

                    SqlCommand nameCmd = new SqlCommand(nameQuery, con);

                    nameCmd.Parameters.AddWithValue("@UserID", userID);

                    string commenterName = nameCmd.ExecuteScalar().ToString();

                    string notificationQuery = @"
                                                    INSERT INTO Notifications
                                                    (
                                                        UserID,
                                                        ComplaintID,
                                                        Title,
                                                        Message,
                                                        NotificationType,
                                                        IsRead,
                                                        CreatedDate
                                                    )
                                                    VALUES
                                                    (
                                                        @OwnerID,
                                                        @ComplaintID,
                                                        @Title,
                                                        @Message,
                                                        @Type,
                                                        0,
                                                        GETDATE()
                                                    )";

                    SqlCommand notificationCmd =
                        new SqlCommand(notificationQuery, con);

                    notificationCmd.Parameters.AddWithValue("@OwnerID", ownerID);
                    notificationCmd.Parameters.AddWithValue("@ComplaintID", complaintID);
                    notificationCmd.Parameters.AddWithValue("@Title", "💬 New Comment");
                    notificationCmd.Parameters.AddWithValue("@Message",
                        commenterName + " commented on your complaint.");
                    notificationCmd.Parameters.AddWithValue("@Type", "Comment");

                    notificationCmd.ExecuteNonQuery();
                }

            }

            txtComment.Text = "";

            LoadComments(complaintID);

            LoadComplaints();

            hfComplaintID.Value = complaintID.ToString();

            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "OpenCommentModal",
                "openCommentModal();",
                true);
        }
        }
}
