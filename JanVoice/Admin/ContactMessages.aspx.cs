using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class ContactMessages : System.Web.UI.Page
    {
        // ==========================================
        // DATABASE CONNECTION
        // ==========================================

        private readonly string connectionString =
            ConfigurationManager
            .ConnectionStrings["JanVoiceDB"]
            .ConnectionString;



        // ==========================================
        // PAGE LOAD
        // ==========================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatistics();
                LoadMessages();
            }
        }



        // ==========================================
        // LOAD STATISTICS
        // ==========================================

        private void LoadStatistics()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT
                        COUNT(*) AS TotalMessages,

                        SUM(
                            CASE
                                WHEN IsRead = 0
                                THEN 1
                                ELSE 0
                            END
                        ) AS UnreadMessages,

                        SUM(
                            CASE
                                WHEN IsRead = 1
                                THEN 1
                                ELSE 0
                            END
                        ) AS ReadMessages

                    FROM ContactMessages;


                    SELECT
                        COUNT(*) AS MonthMessages

                    FROM ContactMessages

                    WHERE
                        SubmittedDate >=
                        DATEFROMPARTS(
                            YEAR(GETDATE()),
                            MONTH(GETDATE()),
                            1
                        );

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalMessages.Text =
                                reader["TotalMessages"]
                                .ToString();

                            lblUnreadMessages.Text =
                                reader["UnreadMessages"]
                                .ToString();

                            lblReadMessages.Text =
                                reader["ReadMessages"]
                                .ToString();
                        }


                        if (reader.NextResult())
                        {
                            if (reader.Read())
                            {
                                lblMonthMessages.Text =
                                    reader["MonthMessages"]
                                    .ToString();
                            }
                        }
                    }
                }
            }
        }



        // ==========================================
        // LOAD MESSAGES
        // ==========================================

        private void LoadMessages()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        MessageID,
                        FullName,
                        Email,
                        Mobile,
                        Subject,
                        Message,
                        IsRead,
                        IsReplied,
                        SubmittedDate

                    FROM ContactMessages

                    WHERE

                    (
                        @Search = ''

                        OR FullName LIKE
                           '%' + @Search + '%'

                        OR Email LIKE
                           '%' + @Search + '%'

                        OR Subject LIKE
                           '%' + @Search + '%'
                    )

                    AND

                    (
                        @Status = ''

                        OR IsRead =
                           CAST(@Status AS BIT)
                    )

                    AND

                    (
                        @Time = ''

                        OR
                        (
                            @Time = 'Today'
                            AND CAST(
                                SubmittedDate AS DATE
                            ) = CAST(
                                GETDATE() AS DATE
                            )
                        )

                        OR
                        (
                            @Time = 'Week'
                            AND SubmittedDate >=
                                DATEADD(
                                    DAY,
                                    -7,
                                    GETDATE()
                                )
                        )

                        OR
                        (
                            @Time = 'Month'
                            AND SubmittedDate >=
                                DATEADD(
                                    MONTH,
                                    -1,
                                    GETDATE()
                                )
                        )
                    )

                    ORDER BY
                        SubmittedDate DESC;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@Search",
                        SqlDbType.NVarChar,
                        150
                    ).Value =
                        txtSearch.Text.Trim();


                    cmd.Parameters.Add(
                        "@Status",
                        SqlDbType.NVarChar,
                        10
                    ).Value =
                        ddlStatus.SelectedValue;


                    cmd.Parameters.Add(
                        "@Time",
                        SqlDbType.NVarChar,
                        20
                    ).Value =
                        ddlTime.SelectedValue;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        DataTable dt =
                            new DataTable();

                        dt.Load(reader);


                        rptMessages.DataSource =
                            dt;

                        rptMessages.DataBind();


                        lblRecordCount.Text =
                            dt.Rows.Count.ToString();
                    }
                }
            }
        }



        // ==========================================
        // MESSAGE COMMANDS
        // ==========================================

        protected void rptMessages_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            int messageID;


            if (!int.TryParse(
                e.CommandArgument.ToString(),
                out messageID))
            {
                return;
            }


            switch (e.CommandName)
            {
                case "ViewMessage":

                    OpenMessage(messageID);

                    break;


                case "ToggleRead":

                    ToggleRead(messageID);

                    break;
            }
        }



        // ==========================================
        // OPEN MESSAGE
        // ==========================================

        private void OpenMessage(int messageID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        MessageID,
                        FullName,
                        Email,
                        Mobile,
                        Subject,
                        Message,
                        IsRead,
                        IsReplied,
                        SubmittedDate

                    FROM ContactMessages

                    WHERE MessageID = @MessageID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@MessageID",
                        SqlDbType.Int
                    ).Value =
                        messageID;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblViewName.Text =
                                reader["FullName"]
                                .ToString();

                            lblViewEmail.Text =
                                reader["Email"]
                                .ToString();

                            lblViewMobile.Text =
                                reader["Mobile"] == DBNull.Value
                                ? "Not provided"
                                : reader["Mobile"].ToString();

                            lblViewSubject.Text =
                                reader["Subject"]
                                .ToString();

                            lblViewMessage.Text =
                                reader["Message"]
                                .ToString();

                            lblViewDate.Text =
                                Convert.ToDateTime(
                                    reader["SubmittedDate"]
                                ).ToString(
                                    "dd MMM yyyy, hh:mm tt"
                                );

                            hfMessageID.Value =
                                messageID.ToString();

                            btnMarkReplied.Text =
                                Convert.ToBoolean(
                                    reader["IsReplied"]
                                )
                                ? "Mark as Not Replied"
                                : "Mark as Replied";

                            pnlViewMessage.Visible =
                                true;
                        }
                    }
                }
            }



            // Automatically mark as read

            MarkAsRead(messageID);

            LoadStatistics();
            LoadMessages();
        }



        // ==========================================
        // MARK AS READ
        // ==========================================

        private void MarkAsRead(int messageID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    UPDATE ContactMessages

                    SET IsRead = 1

                    WHERE MessageID = @MessageID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@MessageID",
                        SqlDbType.Int
                    ).Value =
                        messageID;

                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }



        // ==========================================
        // TOGGLE READ
        // ==========================================

        private void ToggleRead(int messageID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    UPDATE ContactMessages

                    SET IsRead =
                        CASE
                            WHEN IsRead = 1
                            THEN 0
                            ELSE 1
                        END

                    WHERE MessageID = @MessageID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@MessageID",
                        SqlDbType.Int
                    ).Value =
                        messageID;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }


            LoadStatistics();
            LoadMessages();
        }



        // ==========================================
        // MARK REPLIED
        // ==========================================

        protected void btnMarkReplied_Click(
            object sender,
            EventArgs e)
        {
            int messageID;


            if (!int.TryParse(
                hfMessageID.Value,
                out messageID))
            {
                return;
            }


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    UPDATE ContactMessages

                    SET IsReplied =
                        CASE
                            WHEN IsReplied = 1
                            THEN 0
                            ELSE 1
                        END

                    WHERE MessageID = @MessageID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@MessageID",
                        SqlDbType.Int
                    ).Value =
                        messageID;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }


            pnlViewMessage.Visible =
                false;


            LoadStatistics();
            LoadMessages();
        }



        // ==========================================
        // CLOSE MODAL
        // ==========================================

        protected void btnCloseMessage_Click(
            object sender,
            EventArgs e)
        {
            pnlViewMessage.Visible =
                false;
        }



        // ==========================================
        // APPLY FILTERS
        // ==========================================

        protected void btnApplyFilters_Click(
            object sender,
            EventArgs e)
        {
            LoadMessages();
        }



        // ==========================================
        // GET INITIAL
        // ==========================================

        protected string GetInitial(object name)
        {
            if (name == null ||
                name == DBNull.Value)
            {
                return "?";
            }


            string value =
                name.ToString().Trim();


            if (value.Length == 0)
            {
                return "?";
            }


            return value.Substring(0, 1)
                .ToUpper();
        }



        // ==========================================
        // AVATAR COLOR
        // ==========================================

        protected string GetAvatarClass(object name)
        {
            if (name == null ||
                name == DBNull.Value)
            {
                return "";
            }


            string value =
                name.ToString();


            int hash =
                Math.Abs(value.GetHashCode());


            switch (hash % 3)
            {
                case 1:
                    return "purple";

                case 2:
                    return "green";

                default:
                    return "";
            }
        }



        // ==========================================
        // MESSAGE PREVIEW
        // ==========================================

        protected string GetMessagePreview(
            object message)
        {
            if (message == null ||
                message == DBNull.Value)
            {
                return "";
            }


            string text =
                message.ToString().Trim();


            if (text.Length > 55)
            {
                return text.Substring(0, 55)
                    + "...";
            }


            return text;
        }
    }
}