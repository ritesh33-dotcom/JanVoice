using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class Notifications : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        // =========================================================
        // CURRENT ADMIN USER ID
        // =========================================================

        private int CurrentAdminID
        {
            get
            {
                if (Session["UserID"] == null)
                    return 0;

                int userID;

                if (int.TryParse(
                    Session["UserID"].ToString(),
                    out userID))
                {
                    return userID;
                }

                return 0;
            }
        }



        // =========================================================
        // CURRENT TAB
        // =========================================================

        private string CurrentTab
        {
            get
            {
                if (ViewState["CurrentTab"] == null)
                    return "All";

                return ViewState["CurrentTab"].ToString();
            }

            set
            {
                ViewState["CurrentTab"] = value;
            }
        }



        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
             * Admin.Master should already protect the Admin section.
             * This check additionally prevents the page from working
             * without a valid logged-in UserID.
             */

            if (CurrentAdminID <= 0)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }


            if (!IsPostBack)
            {
                CurrentTab = "All";

                LoadNotificationTypes();

                LoadNotificationStatistics();

                LoadNotifications();

                SetActiveTab();
            }
        }



        // =========================================================
        // LOAD NOTIFICATION TYPES
        // =========================================================

        private void LoadNotificationTypes()
        {
            string selectedValue =
                ddlNotificationType.SelectedValue;


            ddlNotificationType.Items.Clear();


            ddlNotificationType.Items.Add(
                new ListItem("All Types", ""));


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT DISTINCT NotificationType
                    FROM Notifications
                    WHERE UserID = @AdminUserID
                      AND NotificationType IS NOT NULL
                      AND LTRIM(RTRIM(NotificationType)) <> ''
                    ORDER BY NotificationType;
                ";


                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@AdminUserID",
                        SqlDbType.Int).Value =
                        CurrentAdminID;


                    con.Open();


                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string type =
                                Convert.ToString(
                                    reader["NotificationType"]);


                            ddlNotificationType.Items.Add(
                                new ListItem(type, type));
                        }
                    }
                }
            }


            if (!string.IsNullOrWhiteSpace(selectedValue) &&
                ddlNotificationType.Items.FindByValue(
                    selectedValue) != null)
            {
                ddlNotificationType.SelectedValue =
                    selectedValue;
            }
        }



        // =========================================================
        // LOAD STATISTICS
        // =========================================================

        private void LoadNotificationStatistics()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT

                        COUNT(*) AS TotalNotifications,

                        COALESCE(
                            SUM(
                                CASE
                                    WHEN IsRead = 0
                                    THEN 1
                                    ELSE 0
                                END
                            ),
                            0
                        ) AS UnreadNotifications,

                        COALESCE(
                            SUM(
                                CASE
                                    WHEN
                                        LOWER(
                                            ISNULL(
                                                NotificationType,
                                                ''
                                            )
                                        ) IN
                                        (
                                            'important',
                                            'warning',
                                            'alert'
                                        )

                                        OR

                                        LOWER(
                                            ISNULL(
                                                Title,
                                                ''
                                            )
                                        ) LIKE '%priority%'

                                        OR

                                        LOWER(
                                            ISNULL(
                                                Title,
                                                ''
                                            )
                                        ) LIKE '%urgent%'

                                        OR

                                        LOWER(
                                            ISNULL(
                                                Title,
                                                ''
                                            )
                                        ) LIKE '%critical%'

                                    THEN 1
                                    ELSE 0
                                END
                            ),
                            0
                        ) AS ImportantNotifications

                    FROM Notifications

                    WHERE UserID = @AdminUserID;
                ";


                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@AdminUserID",
                        SqlDbType.Int).Value =
                        CurrentAdminID;


                    con.Open();


                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalNotifications.Text =
                                Convert.ToInt32(
                                    reader["TotalNotifications"])
                                .ToString();


                            lblUnreadNotifications.Text =
                                Convert.ToInt32(
                                    reader["UnreadNotifications"])
                                .ToString();


                            lblImportantNotifications.Text =
                                Convert.ToInt32(
                                    reader["ImportantNotifications"])
                                .ToString();
                        }
                    }
                }
            }
        }



        // =========================================================
        // LOAD NOTIFICATIONS
        // =========================================================

        private void LoadNotifications()
        {
            DataTable dt =
                new DataTable();


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        NotificationID,
                        UserID,
                        ComplaintID,
                        Title,
                        Message,
                        NotificationType,
                        IsRead,
                        CreatedDate

                    FROM Notifications

                    WHERE UserID = @AdminUserID
                ";



                // =================================================
                // TAB FILTER
                // =================================================

                if (CurrentTab == "Unread")
                {
                    query += @"
                        AND IsRead = 0
                    ";
                }


                if (CurrentTab == "Important")
                {
                    query += @"
                        AND
                        (
                            LOWER(
                                ISNULL(
                                    NotificationType,
                                    ''
                                )
                            ) IN
                            (
                                'important',
                                'warning',
                                'alert'
                            )

                            OR

                            LOWER(
                                ISNULL(
                                    Title,
                                    ''
                                )
                            ) LIKE '%priority%'

                            OR

                            LOWER(
                                ISNULL(
                                    Title,
                                    ''
                                )
                            ) LIKE '%urgent%'

                            OR

                            LOWER(
                                ISNULL(
                                    Title,
                                    ''
                                )
                            ) LIKE '%critical%'
                        )
                    ";
                }



                // =================================================
                // SEARCH
                // =================================================

                if (!string.IsNullOrWhiteSpace(txtSearch.Text))
                {
                    query += @"
                        AND
                        (
                            Title LIKE @Search
                            OR Message LIKE @Search
                            OR NotificationType LIKE @Search
                        )
                    ";
                }



                // =================================================
                // TYPE FILTER
                // =================================================

                if (!string.IsNullOrWhiteSpace(
                    ddlNotificationType.SelectedValue))
                {
                    query += @"
                        AND NotificationType = @NotificationType
                    ";
                }



                // =================================================
                // ORDER
                // =================================================

                query += @"
                    ORDER BY CreatedDate DESC;
                ";



                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@AdminUserID",
                        SqlDbType.Int).Value =
                        CurrentAdminID;


                    if (!string.IsNullOrWhiteSpace(
                        txtSearch.Text))
                    {
                        cmd.Parameters.Add(
                            "@Search",
                            SqlDbType.NVarChar,
                            100).Value =
                            "%" +
                            txtSearch.Text.Trim() +
                            "%";
                    }


                    if (!string.IsNullOrWhiteSpace(
                        ddlNotificationType.SelectedValue))
                    {
                        cmd.Parameters.Add(
                            "@NotificationType",
                            SqlDbType.NVarChar,
                            50).Value =
                            ddlNotificationType.SelectedValue;
                    }


                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }



            // =====================================================
            // BIND DATA
            // =====================================================

            rptNotifications.DataSource =
                dt;

            rptNotifications.DataBind();



            // =====================================================
            // EMPTY STATE
            // =====================================================

            pnlEmpty.Visible =
                dt.Rows.Count == 0;



            // =====================================================
            // COUNT
            // =====================================================

            lblNotificationCount.Text =
                dt.Rows.Count +
                (
                    dt.Rows.Count == 1
                        ? " Notification"
                        : " Notifications"
                );
        }



        // =========================================================
        // APPLY FILTER
        // =========================================================

        protected void btnApplyFilter_Click(
            object sender,
            EventArgs e)
        {
            LoadNotifications();
        }



        // =========================================================
        // NOTIFICATION TAB
        // =========================================================

        protected void NotificationTab_Click(
            object sender,
            EventArgs e)
        {
            LinkButton button =
                sender as LinkButton;


            if (button == null)
                return;


            CurrentTab =
                button.CommandArgument;


            SetActiveTab();

            LoadNotifications();
        }



        // =========================================================
        // ACTIVE TAB
        // =========================================================

        private void SetActiveTab()
        {
            btnAll.CssClass =
                "notification-tab";

            btnUnread.CssClass =
                "notification-tab";

            btnImportant.CssClass =
                "notification-tab";


            switch (CurrentTab)
            {
                case "Unread":

                    btnUnread.CssClass =
                        "notification-tab active";

                    break;


                case "Important":

                    btnImportant.CssClass =
                        "notification-tab active";

                    break;


                default:

                    btnAll.CssClass =
                        "notification-tab active";

                    break;
            }
        }



        // =========================================================
        // MARK ALL AS READ
        // =========================================================

        protected void btnMarkAllRead_Click(
            object sender,
            EventArgs e)
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
                    UPDATE Notifications

                    SET IsRead = 1

                    WHERE UserID = @AdminUserID
                      AND IsRead = 0;
                ";


                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@AdminUserID",
                        SqlDbType.Int).Value =
                        CurrentAdminID;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }


            LoadNotificationStatistics();

            LoadNotifications();
        }



        // =========================================================
        // REPEATER ITEM DATABOUND
        // =========================================================

        protected void rptNotifications_ItemDataBound(
            object sender,
            RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType !=
                    ListItemType.Item &&
                e.Item.ItemType !=
                    ListItemType.AlternatingItem)
            {
                return;
            }


            DataRowView row =
                e.Item.DataItem as DataRowView;


            if (row == null)
                return;


            HyperLink lnkView =
                e.Item.FindControl("lnkView")
                as HyperLink;


            if (lnkView == null)
                return;


            int complaintID = 0;


            if (row["ComplaintID"] != DBNull.Value)
            {
                complaintID =
                    Convert.ToInt32(
                        row["ComplaintID"]);
            }


            string notificationType =
                Convert.ToString(
                    row["NotificationType"]);


            lnkView.NavigateUrl =
                GetViewUrl(
                    notificationType,
                    complaintID);
        }



        // =========================================================
        // GET VIEW URL
        // =========================================================

        private string GetViewUrl(
            string notificationType,
            int complaintID)
        {
            // Complaint-related notifications
            if (complaintID > 0)
            {
                if (
                    notificationType.Equals(
                        "Complaint",
                        StringComparison.OrdinalIgnoreCase)
                    ||
                    notificationType.Equals(
                        "Support",
                        StringComparison.OrdinalIgnoreCase)
                    ||
                    notificationType.Equals(
                        "Comment",
                        StringComparison.OrdinalIgnoreCase)
                    ||
                    notificationType.Equals(
                        "Follow",
                        StringComparison.OrdinalIgnoreCase)
                )
                {
                    return
                        "ManageComplaints.aspx?ComplaintID="
                        + complaintID;
                }
            }



            // User-related notifications
            if (
                notificationType.Equals(
                    "User",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return "ManageUsers.aspx";
            }



            // Officer-related notifications
            if (
                notificationType.Equals(
                    "Officer",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return "ManageOfficers.aspx";
            }



            // System / unknown notification
            return "Notifications.aspx";
        }



        // =========================================================
        // NOTIFICATION ITEM CLASS
        // =========================================================

        protected string GetNotificationItemClass(
            object isRead)
        {
            bool read =
                Convert.ToBoolean(isRead);


            if (!read)
            {
                return
                    "notification-item unread-item";
            }


            return
                "notification-item";
        }



        // =========================================================
        // NOTIFICATION ICON CLASS
        // =========================================================

        protected string GetNotificationIconClass(
            object notificationType)
        {
            string type =
                Convert.ToString(
                    notificationType);


            if (
                type.Equals(
                    "Complaint",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Support",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Comment",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Follow",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return
                    "notification-icon complaint-notification";
            }


            if (
                type.Equals(
                    "User",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return
                    "notification-icon user-notification";
            }


            if (
                type.Equals(
                    "Officer",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return
                    "notification-icon officer-notification";
            }


            if (
                type.Equals(
                    "Important",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Warning",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Alert",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return
                    "notification-icon warning-notification";
            }


            if (
                type.Equals(
                    "Success",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return
                    "notification-icon success-notification";
            }


            return
                "notification-icon system-notification";
        }



        // =========================================================
        // NOTIFICATION ICON
        // =========================================================

        protected string GetNotificationIcon(
            object notificationType)
        {
            string type =
                Convert.ToString(
                    notificationType);


            if (
                type.Equals(
                    "Complaint",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Support",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Comment",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Follow",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return "📋";
            }


            if (
                type.Equals(
                    "User",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return "👤";
            }


            if (
                type.Equals(
                    "Officer",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return "👨‍💼";
            }


            if (
                type.Equals(
                    "Important",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Warning",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Alert",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return "⚠";
            }


            if (
                type.Equals(
                    "Success",
                    StringComparison.OrdinalIgnoreCase)
            )
            {
                return "✓";
            }


            return "🔔";
        }



        // =========================================================
        // UNREAD DOT
        // =========================================================

        protected string GetUnreadDot(
            object isRead)
        {
            bool read =
                Convert.ToBoolean(isRead);


            if (read)
                return "";


            return
                "<span class=\"unread-dot\"></span>";
        }



        // =========================================================
        // IMPORTANT BADGE
        // =========================================================

        protected string GetImportantBadge(
            object notificationType,
            object title)
        {
            string type =
                Convert.ToString(
                    notificationType);


            string notificationTitle =
                Convert.ToString(
                    title);


            bool important =
                type.Equals(
                    "Important",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Warning",
                    StringComparison.OrdinalIgnoreCase)
                ||
                type.Equals(
                    "Alert",
                    StringComparison.OrdinalIgnoreCase)
                ||
                notificationTitle.IndexOf(
                    "priority",
                    StringComparison.OrdinalIgnoreCase) >= 0
                ||
                notificationTitle.IndexOf(
                    "urgent",
                    StringComparison.OrdinalIgnoreCase) >= 0
                ||
                notificationTitle.IndexOf(
                    "critical",
                    StringComparison.OrdinalIgnoreCase) >= 0;


            if (!important)
                return "";


            return
                "<span class=\"important-badge\">Important</span>";
        }



        // =========================================================
        // TIME AGO
        // =========================================================

        protected string GetTimeAgo(
            object createdDate)
        {
            if (
                createdDate == null ||
                createdDate == DBNull.Value
            )
            {
                return "";
            }


            DateTime date =
                Convert.ToDateTime(
                    createdDate);


            TimeSpan difference =
                DateTime.Now - date;


            if (difference.TotalSeconds < 60)
            {
                return "Just now";
            }


            if (difference.TotalMinutes < 60)
            {
                int minutes =
                    (int)difference.TotalMinutes;


                return minutes +
                    (
                        minutes == 1
                            ? " minute ago"
                            : " minutes ago"
                    );
            }


            if (difference.TotalHours < 24)
            {
                int hours =
                    (int)difference.TotalHours;


                return hours +
                    (
                        hours == 1
                            ? " hour ago"
                            : " hours ago"
                    );
            }


            if (difference.TotalDays < 7)
            {
                int days =
                    (int)difference.TotalDays;


                return days +
                    (
                        days == 1
                            ? " day ago"
                            : " days ago"
                    );
            }


            if (difference.TotalDays < 30)
            {
                int weeks =
                    (int)(
                        difference.TotalDays / 7
                    );


                return weeks +
                    (
                        weeks == 1
                            ? " week ago"
                            : " weeks ago"
                    );
            }


            return date.ToString("dd MMM yyyy");
        }
    }
}