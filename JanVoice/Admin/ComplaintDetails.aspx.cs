using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
namespace JanVoice.Admin
{
    public partial class ComplaintDetails : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComplaint();
                LoadAssignedOfficer();
                LoadStatusHistory();

                if (Request.QueryString["rejected"] == "1")
                {
                    ClientScript.RegisterStartupScript(
                        GetType(),
                        "RejectSuccess",
                        "alert('Complaint rejected successfully.');",
                        true
                    );
                }
            }
        }


        // ==========================================
        // LOAD COMPLAINT
        // ==========================================

        private void LoadComplaint()
        {
            string idValue = Request.QueryString["id"];

            int complaintID;

            if (!int.TryParse(idValue, out complaintID))
            {
                Response.Redirect("ManageComplaints.aspx");
                return;
            }


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        c.ComplaintID,
                        c.Title,
                        c.Description,
                        c.Landmark,
                        c.Status,
                        c.Priority,
                        c.CreatedDate,

                        u.FullName,
                        u.Email,
                        u.Mobile,

                        cat.CategoryName,

                        w.WardName

                    FROM Complaints c

                    INNER JOIN Users u
                        ON c.UserID = u.UserID

                    INNER JOIN Categories cat
                        ON c.CategoryID = cat.CategoryID

                    INNER JOIN Wards w
                        ON c.WardID = w.WardID

                    WHERE c.ComplaintID = @ComplaintID
                ";


                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@ComplaintID",
                        complaintID
                    );


                    con.Open();


                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            LoadComplaintData(reader);
                        }
                        else
                        {
                            Response.Redirect(
                                "ManageComplaints.aspx"
                            );
                        }
                    }
                }
            }
        }


        // ==========================================
        // DISPLAY COMPLAINT DATA
        // ==========================================

        private void LoadComplaintData(
            SqlDataReader reader)
        {
            // Complaint ID

            lblComplaintID.Text =
                reader["ComplaintID"].ToString();


            // Title

            lblTitle.Text =
                reader["Title"].ToString();


            // Description

            lblDescription.Text =
                reader["Description"].ToString();


            // Category

            lblCategory.Text =
                reader["CategoryName"].ToString();


            // Ward

            lblWard.Text =
                reader["WardName"].ToString();


            // Location

            string landmark =
                reader["Landmark"] == DBNull.Value
                    ? ""
                    : reader["Landmark"].ToString();

            lblLocation.Text =
                string.IsNullOrWhiteSpace(landmark)
                    ? "Location not specified"
                    : landmark;


            // Date

            DateTime createdDate =
                Convert.ToDateTime(
                    reader["CreatedDate"]
                );

            lblReportedDate.Text =
                createdDate.ToString(
                    "dd MMM yyyy"
                );


            // Status

            string status =
                reader["Status"].ToString();

            lblStatus.Text = status;

            lblStatus.CssClass =
                "status-badge "
                + GetStatusClass(status);


            // Priority

            string priority =
                reader["Priority"].ToString();

            lblPriority.Text =
                priority + " Priority";

            priorityDisplay.Attributes["class"] =
                "priority-display "
                + GetPriorityClass(priority);


            // Citizen

            string fullName =
                reader["FullName"].ToString();

            lblCitizenName.Text =
                fullName;

            lblCitizenInitial.Text =
                GetInitial(fullName);


            // Email

            lblCitizenEmail.Text =
                reader["Email"] == DBNull.Value
                    ? "-"
                    : reader["Email"].ToString();


            // Phone

            lblCitizenPhone.Text =
                reader["Mobile"] == DBNull.Value
                    ? "-"
                    : reader["Mobile"].ToString();


            // Priority description

            lblPriorityDescription.Text =
                GetPriorityDescription(priority);
        }


        // ==========================================
        // STATUS CLASS
        // ==========================================

        private string GetStatusClass(string status)
        {
            switch (status.ToLower().Trim())
            {
                case "pending":
                    return "pending";

                case "accepted":
                    return "accepted";

                case "in progress":
                    return "progress";

                case "resolved":
                    return "resolved";

                case "rejected":
                    return "rejected";

                default:
                    return "default";
            }
        }


        // ==========================================
        // PRIORITY CLASS
        // ==========================================

        private string GetPriorityClass(string priority)
        {
            switch (priority.ToLower().Trim())
            {
                case "high":
                    return "high";

                case "low":
                    return "low";

                default:
                    return "medium";
            }
        }


        // ==========================================
        // PRIORITY DESCRIPTION
        // ==========================================

        private string GetPriorityDescription(
            string priority)
        {
            switch (priority.ToLower().Trim())
            {
                case "high":
                    return "Requires immediate attention";

                case "low":
                    return "Low urgency complaint";

                default:
                    return "Normal attention required";
            }
        }


        // ==========================================
        // CITIZEN INITIAL
        // ==========================================

        private string GetInitial(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName))
                return "?";

            return fullName
                .Trim()
                .Substring(0, 1)
                .ToUpper();
        }
        // ==========================================
        // LOAD ASSIGNED OFFICER
        // ==========================================

        private void LoadAssignedOfficer()
        {
            string idValue = Request.QueryString["id"];

            int complaintID;

            if (!int.TryParse(idValue, out complaintID))
                return;


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
            SELECT
                u.FullName,
                u.Email,
                u.Mobile

            FROM Complaints c

            LEFT JOIN Users u
                ON c.AssignedOfficerID = u.UserID

            WHERE c.ComplaintID = @ComplaintID
        ";


                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@ComplaintID",
                        complaintID
                    );

                    con.Open();

                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (reader["FullName"] == DBNull.Value)
                            {
                                // No officer assigned

                                lblOfficerName.Text =
                                    "No Officer Assigned";

                                lblOfficerDetails.Text =
                                    "This complaint is waiting for assignment.";
                            }
                            else
                            {
                                string officerName =
                                    reader["FullName"].ToString();

                                lblOfficerName.Text =
                                    officerName;

                                string email =
                                    reader["Email"] == DBNull.Value
                                        ? ""
                                        : reader["Email"].ToString();

                                string phone =
                                    reader["Mobile"] == DBNull.Value
                                        ? ""
                                        : reader["Mobile"].ToString();


                                string details = "Officer";

                                if (!string.IsNullOrWhiteSpace(email))
                                {
                                    details +=
                                        " • " + email;
                                }

                                if (!string.IsNullOrWhiteSpace(phone))
                                {
                                    details +=
                                        " • " + phone;
                                }

                                lblOfficerDetails.Text =
                                    details;
                            }
                        }
                    }
                }
            }
        }
        // ==========================================
        // LOAD OFFICERS
        // ==========================================

        private void LoadOfficers()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
            SELECT
                UserID,
                FullName

            FROM Users

            WHERE RoleID = (
                SELECT RoleID
                FROM Roles
                WHERE RoleName = 'Officer'
            )

            AND IsActive = 1

            ORDER BY FullName
        ";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        ddlOfficers.DataSource = reader;

                        ddlOfficers.DataTextField =
                            "FullName";

                        ddlOfficers.DataValueField =
                            "UserID";

                        ddlOfficers.DataBind();
                    }
                }
            }

            ddlOfficers.Items.Insert(
                0,
                new System.Web.UI.WebControls.ListItem(
                    "-- Select Officer --",
                    ""
                )
            );
        }
        // ==========================================
        // LOAD STATUS HISTORY
        // ==========================================

        private void LoadStatusHistory()
        {
            string idValue = Request.QueryString["id"];

            int complaintID;

            if (!int.TryParse(idValue, out complaintID))
                return;


            DataTable dt =
                new DataTable();


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
            SELECT
                NewStatus,
                Remarks,
                ChangeDate

            FROM StatusHistory

            WHERE ComplaintID = @ComplaintID

            ORDER BY ChangeDate ASC
        ";


                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@ComplaintID",
                        complaintID
                    );


                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }


            rptStatusHistory.DataSource =
                dt;

            rptStatusHistory.DataBind();
        }
        // ==========================================
        // TIMELINE ITEM CLASS
        // ==========================================

        protected string GetTimelineItemClass(
            object status,
            int index)
        {
            string value =
                Convert.ToString(status)
                .ToLower()
                .Trim();


            if (index == 0)
                return "timeline-item completed";


            if (value == "resolved")
                return "timeline-item completed";


            if (value == "rejected")
                return "timeline-item current";


            return "timeline-item current";
        }
        // ==========================================
        // TIMELINE ICON
        // ==========================================

        protected string GetTimelineIcon(
            object status,
            int index)
        {
            string value =
                Convert.ToString(status)
                .ToLower()
                .Trim();


            if (index == 0)
                return "✓";


            if (value == "resolved")
                return "✓";


            if (value == "rejected")
                return "!";


            return "!";
        }

        // ==========================================
        // SHOW ASSIGN OFFICER PANEL
        // ==========================================

        protected void btnAssignOfficer_Click(
            object sender,
            EventArgs e)
        {
            LoadOfficers();

            pnlAssignOfficer.Visible = true;
        }

        // ==========================================
        // CANCEL ASSIGNMENT
        // ==========================================

        protected void btnCancelAssignment_Click(
            object sender,
            EventArgs e)
        {
            pnlAssignOfficer.Visible = false;

            ddlOfficers.Items.Clear();
        }
        // ==========================================
        // CONFIRM OFFICER ASSIGNMENT
        // ==========================================

        protected void btnConfirmAssignment_Click(
            object sender,
            EventArgs e)
        {
            // Validate officer selection

            if (string.IsNullOrWhiteSpace(ddlOfficers.SelectedValue))
            {
                ClientScript.RegisterStartupScript(
                    GetType(),
                    "NoOfficer",
                    "alert('Please select an officer.');",
                    true
                );

                return;
            }


            // Get Complaint ID

            string idValue =
                Request.QueryString["id"];

            int complaintID;

            if (!int.TryParse(idValue, out complaintID))
            {
                Response.Redirect("ManageComplaints.aspx");
                return;
            }


            // Selected Officer

            int officerID =
                Convert.ToInt32(
                    ddlOfficers.SelectedValue
                );


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                con.Open();

                SqlTransaction transaction =
                    con.BeginTransaction();

                bool transactionCompleted = false;

                try
                {
                    // ==================================
                    // GET CURRENT STATUS
                    // ==================================

                    string oldStatus = "";

                    string statusQuery = @"
                SELECT Status
                FROM Complaints
                WHERE ComplaintID = @ComplaintID
            ";

                    using (SqlCommand cmd =
                        new SqlCommand(
                            statusQuery,
                            con,
                            transaction))
                    {
                        cmd.Parameters.AddWithValue(
                            "@ComplaintID",
                            complaintID
                        );

                        object result =
                            cmd.ExecuteScalar();

                        if (result == null)
                        {
                            throw new Exception(
                                "Complaint not found."
                            );
                        }

                        oldStatus =
                            result.ToString();
                    }


                    // ==================================
                    // UPDATE COMPLAINT
                    // ==================================

                    string updateQuery = @"
                UPDATE Complaints
                SET
                    AssignedOfficerID = @OfficerID,
                    Status = 'Assigned',
                    UpdatedDate = GETDATE()
                WHERE ComplaintID = @ComplaintID
            ";

                    using (SqlCommand cmd =
                        new SqlCommand(
                            updateQuery,
                            con,
                            transaction))
                    {
                        cmd.Parameters.AddWithValue(
                            "@OfficerID",
                            officerID
                        );

                        cmd.Parameters.AddWithValue(
                            "@ComplaintID",
                            complaintID
                        );

                        cmd.ExecuteNonQuery();
                    }


                    // ==================================
                    // INSERT STATUS HISTORY
                    // ==================================

                    string historyQuery = @"
                INSERT INTO StatusHistory
                (
                    ComplaintID,
                    OldStatus,
                    NewStatus,
                    ChangedBy,
                    Remarks,
                    ChangeDate
                )
                VALUES
                (
                    @ComplaintID,
                    @OldStatus,
                    'Assigned',
                    @ChangedBy,
                    @Remarks,
                    GETDATE()
                )
            ";

                    using (SqlCommand cmd =
                        new SqlCommand(
                            historyQuery,
                            con,
                            transaction))
                    {
                        cmd.Parameters.AddWithValue(
                            "@ComplaintID",
                            complaintID
                        );

                        cmd.Parameters.AddWithValue(
                            "@OldStatus",
                            string.IsNullOrWhiteSpace(oldStatus)
                                ? (object)DBNull.Value
                                : oldStatus
                        );


                        // Logged-in Admin

                        int changedBy = 1;

                        if (Session["UserID"] != null)
                        {
                            changedBy =
                                Convert.ToInt32(
                                    Session["UserID"]
                                );
                        }

                        cmd.Parameters.AddWithValue(
                            "@ChangedBy",
                            changedBy
                        );

                        cmd.Parameters.AddWithValue(
                            "@Remarks",
                            "Complaint assigned to Officer."
                        );

                        cmd.ExecuteNonQuery();
                    }


                    // ==================================
                    // COMMIT TRANSACTION
                    // ==================================

                    transaction.Commit();

                    transactionCompleted = true;
                }
                catch (Exception ex)
                {
                    // Only rollback if transaction
                    // has NOT already completed.

                    if (!transactionCompleted)
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch
                        {
                            // Ignore rollback error
                            // because original error is more important.
                        }
                    }


                    ClientScript.RegisterStartupScript(
                        GetType(),
                        "AssignmentError",
                        "alert('Unable to assign officer.\\n\\n"
                        + ex.Message.Replace("'", "\\'")
                        + "');",
                        true
                    );

                    return;
                }
            }


            // ==================================
            // SUCCESS REDIRECT
            // ==================================

            Response.Redirect(
                "ComplaintDetails.aspx?id="
                + complaintID
                + "&assigned=1",
                false
            );

            Context.ApplicationInstance.CompleteRequest();
        }

        // ==========================================
        // SHOW CHANGE PRIORITY PANEL
        // ==========================================

        protected void btnChangePriority_Click(
            object sender,
            EventArgs e)
        {
            ddlPriority.SelectedValue = "";

            pnlChangePriority.Visible = true;
        }

        // ==========================================
        // CANCEL PRIORITY CHANGE
        // ==========================================

        protected void btnCancelPriority_Click(
            object sender,
            EventArgs e)
        {
            pnlChangePriority.Visible = false;

            ddlPriority.SelectedValue = "";
        }

        // ==========================================
        // CONFIRM PRIORITY CHANGE
        // ==========================================

        protected void btnConfirmPriority_Click(
            object sender,
            EventArgs e)
        {
            // Validate priority

            if (string.IsNullOrWhiteSpace(
                ddlPriority.SelectedValue))
            {
                ClientScript.RegisterStartupScript(
                    GetType(),
                    "NoPriority",
                    "alert('Please select a priority.');",
                    true
                );

                return;
            }


            // Get Complaint ID

            string idValue =
                Request.QueryString["id"];

            int complaintID;

            if (!int.TryParse(
                idValue,
                out complaintID))
            {
                Response.Redirect(
                    "ManageComplaints.aspx"
                );

                return;
            }


            string newPriority =
                ddlPriority.SelectedValue;


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                con.Open();

                SqlTransaction transaction =
                    con.BeginTransaction();

                bool transactionCompleted = false;

                try
                {
                    // ==================================
                    // UPDATE PRIORITY
                    // ==================================

                    string query = @"
                UPDATE Complaints

                SET
                    Priority = @Priority,
                    UpdatedDate = GETDATE()

                WHERE ComplaintID = @ComplaintID
            ";


                    using (SqlCommand cmd =
                        new SqlCommand(
                            query,
                            con,
                            transaction))
                    {
                        cmd.Parameters.AddWithValue(
                            "@Priority",
                            newPriority
                        );

                        cmd.Parameters.AddWithValue(
                            "@ComplaintID",
                            complaintID
                        );

                        int rowsAffected =
                            cmd.ExecuteNonQuery();


                        if (rowsAffected == 0)
                        {
                            throw new Exception(
                                "Complaint not found."
                            );
                        }
                    }


                    // ==================================
                    // COMMIT
                    // ==================================

                    transaction.Commit();

                    transactionCompleted = true;
                }
                catch (Exception ex)
                {
                    if (!transactionCompleted)
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch
                        {
                            // Ignore rollback error
                        }
                    }


                    ClientScript.RegisterStartupScript(
                        GetType(),
                        "PriorityError",
                        "alert('Unable to change priority.\\n\\n"
                        + ex.Message.Replace("'", "\\'")
                        + "');",
                        true
                    );

                    return;
                }
            }


            // ==================================
            // SUCCESS
            // ==================================

            Response.Redirect(
                "ComplaintDetails.aspx?id="
                + complaintID
                + "&priorityChanged=1",
                false
            );

            Context.ApplicationInstance.CompleteRequest();
        }

        // ==========================================
        // REJECT COMPLAINT
        // ==========================================

        protected void btnRejectComplaint_Click(
            object sender,
            EventArgs e)
        {
            string idValue = Request.QueryString["id"];

            int complaintID;

            if (!int.TryParse(idValue, out complaintID))
            {
                Response.Redirect("ManageComplaints.aspx");
                return;
            }


            // Get logged-in admin ID

            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            int adminID =
                Convert.ToInt32(Session["UserID"]);


            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                con.Open();


                SqlTransaction transaction =
                    con.BeginTransaction();


                bool committed = false;


                try
                {
                    // ==========================================
                    // GET CURRENT STATUS
                    // ==========================================

                    string oldStatus = null;


                    string getStatusQuery = @"
                SELECT Status
                FROM Complaints
                WHERE ComplaintID = @ComplaintID
            ";


                    using (SqlCommand cmd =
                        new SqlCommand(
                            getStatusQuery,
                            con,
                            transaction))
                    {
                        cmd.Parameters.AddWithValue(
                            "@ComplaintID",
                            complaintID
                        );


                        object result =
                            cmd.ExecuteScalar();


                        if (result == null ||
                            result == DBNull.Value)
                        {
                            throw new Exception(
                                "Complaint not found."
                            );
                        }


                        oldStatus =
                            result.ToString();
                    }



                    // ==========================================
                    // CHECK CURRENT STATUS
                    // ==========================================

                    if (oldStatus.Equals(
                        "Rejected",
                        StringComparison.OrdinalIgnoreCase))
                    {
                        transaction.Rollback();

                        ClientScript.RegisterStartupScript(
                            GetType(),
                            "AlreadyRejected",
                            "alert('This complaint is already rejected.');",
                            true
                        );

                        return;
                    }


                    if (oldStatus.Equals(
                        "Resolved",
                        StringComparison.OrdinalIgnoreCase))
                    {
                        transaction.Rollback();

                        ClientScript.RegisterStartupScript(
                            GetType(),
                            "AlreadyResolved",
                            "alert('A resolved complaint cannot be rejected.');",
                            true
                        );

                        return;
                    }



                    // ==========================================
                    // UPDATE COMPLAINT
                    // ==========================================

                    string updateQuery = @"
                UPDATE Complaints
                SET
                    Status = @NewStatus,
                    UpdatedDate = GETDATE()
                WHERE ComplaintID = @ComplaintID
            ";


                    using (SqlCommand cmd =
                        new SqlCommand(
                            updateQuery,
                            con,
                            transaction))
                    {
                        cmd.Parameters.AddWithValue(
                            "@NewStatus",
                            "Rejected"
                        );

                        cmd.Parameters.AddWithValue(
                            "@ComplaintID",
                            complaintID
                        );


                        cmd.ExecuteNonQuery();
                    }



                    // ==========================================
                    // INSERT STATUS HISTORY
                    // ==========================================

                    string historyQuery = @"
                INSERT INTO StatusHistory
                (
                    ComplaintID,
                    OldStatus,
                    NewStatus,
                    ChangedBy,
                    Remarks,
                    ChangeDate
                )
                VALUES
                (
                    @ComplaintID,
                    @OldStatus,
                    @NewStatus,
                    @ChangedBy,
                    @Remarks,
                    GETDATE()
                )
            ";


                    using (SqlCommand cmd =
                        new SqlCommand(
                            historyQuery,
                            con,
                            transaction))
                    {
                        cmd.Parameters.AddWithValue(
                            "@ComplaintID",
                            complaintID
                        );

                        cmd.Parameters.AddWithValue(
                            "@OldStatus",
                            oldStatus
                        );

                        cmd.Parameters.AddWithValue(
                            "@NewStatus",
                            "Rejected"
                        );

                        cmd.Parameters.AddWithValue(
                            "@ChangedBy",
                            adminID
                        );

                        cmd.Parameters.AddWithValue(
                            "@Remarks",
                            "Complaint rejected by administrator."
                        );


                        cmd.ExecuteNonQuery();
                    }



                    // ==========================================
                    // COMMIT
                    // ==========================================

                    transaction.Commit();

                    committed = true;
                }
                catch (Exception ex)
                {
                    // Rollback only if transaction
                    // has not already been committed.

                    if (!committed)
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch
                        {
                            // Ignore rollback failure
                        }
                    }


                    ClientScript.RegisterStartupScript(
                        GetType(),
                        "RejectError",
                        "alert('Unable to reject complaint: "
                        + HttpUtility.JavaScriptStringEncode(
                            ex.Message
                        )
                        + "');",
                        true
                    );

                    return;
                }
            }



            // ==========================================
            // SUCCESS
            // ==========================================

            Response.Redirect(
                "ComplaintDetails.aspx?id="
                + complaintID
                + "&rejected=1"
            );
        }
    }
}