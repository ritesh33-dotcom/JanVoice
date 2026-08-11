using JanVoice.Helpers;
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
    public partial class ResolutionDetails : System.Web.UI.Page
    {
        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckOfficerLogin();

            if (!IsPostBack)
            {
                LoadComplaintDetails();
                LoadComplaintImage();
                LoadStatusHistory();
            }
        }


        // =========================================================
        // CHECK OFFICER LOGIN
        // =========================================================

        private void CheckOfficerLogin()
        {
            if (Session["OfficerID"] == null)
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
            if (Session["UserID"] == null ||
                Session["RoleID"] == null ||
                Convert.ToInt32(Session["RoleID"]) != 2)
            {
                Response.Redirect("~/Login.aspx");
                return 0;
            }

            return Convert.ToInt32(Session["UserID"]);
        }


        // =========================================================
        // GET COMPLAINT ID
        // =========================================================

        private int GetComplaintID()
        {
            if (Request.QueryString["ComplaintID"] == null)
            {
                Response.Redirect(
                    "~/Officer/AssignedComplaints.aspx"
                );

                return 0;
            }

            int complaintID;

            if (!int.TryParse(
                Request.QueryString["ComplaintID"],
                out complaintID))
            {
                Response.Redirect(
                    "~/Officer/AssignedComplaints.aspx"
                );

                return 0;
            }

            return complaintID;
        }


        // =========================================================
        // LOAD COMPLAINT DETAILS
        // =========================================================

        private void LoadComplaintDetails()
        {
            int officerID = GetOfficerID();
            int complaintID = GetComplaintID();

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;
            string query = @"
            SELECT
            C.ComplaintID,
            C.Title,
            C.Description,
            C.Priority,
            C.Status,
            C.CreatedDate,
            C.UpdatedDate,

            U.FullName AS CitizenName,
            U.Email AS CitizenEmail,
            U.Mobile AS CitizenPhone,

            CAT.CategoryName,

            W.WardName,

            C.Latitude,
            C.Longitude,
            C.Landmark

        FROM dbo.Complaints C

        INNER JOIN dbo.Users U
            ON C.UserID = U.UserID

        INNER JOIN dbo.Categories CAT
            ON C.CategoryID = CAT.CategoryID

        INNER JOIN dbo.Wards W
            ON C.WardID = W.WardID

        WHERE
            C.ComplaintID = @ComplaintID
            AND C.AssignedOfficerID = @OfficerID;
    ";

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.Add(
                    "@ComplaintID",
                    SqlDbType.Int
                ).Value = complaintID;

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
                        lblComplaintID.Text =
                            reader["ComplaintID"].ToString();

                        lblComplaintTitle.Text =
                        reader["Title"].ToString();

                        lblDescription.Text =
                            reader["Description"].ToString();

                        lblCitizenName.Text =
                            reader["CitizenName"].ToString();

                        lblCitizenEmail.Text =
                            reader["CitizenEmail"].ToString();

                        lblCitizenPhone.Text =
                            reader["CitizenPhone"].ToString();

                        lblCategory.Text =
                            reader["CategoryName"].ToString();

                        lblWard.Text =
                            reader["WardName"].ToString();

                        lblPriority.Text =
                            reader["Priority"].ToString();

                        lblStatus.Text =
                            reader["Status"].ToString();


                        // =====================================================
                        // PART 5: DYNAMIC RESOLUTION CONTROLS
                        // =====================================================

                        string currentStatus =
                            reader["Status"].ToString();

                        if (currentStatus == "Resolved")
                        {
                            btnMarkResolved.Visible = false;

                            txtResolutionRemarks.Visible = false;
                        }
                        else
                        {
                            btnMarkResolved.Visible = true;

                            txtResolutionRemarks.Visible = true;
                        }


                        lblLandmark.Text =
                            reader["Landmark"].ToString();

                        lblLatitude.Text =
                            reader["Latitude"].ToString();

                        lblLongitude.Text =
                            reader["Longitude"].ToString();

                        lblCreatedDate.Text =
                            Convert.ToDateTime(
                                reader["CreatedDate"]
                            ).ToString(
                                "dd MMM yyyy, hh:mm tt"
                            );

                        if (reader["UpdatedDate"] != DBNull.Value)
                        {
                            lblUpdatedDate.Text =
                                Convert.ToDateTime(
                                    reader["UpdatedDate"]
                                ).ToString(
                                    "dd MMM yyyy, hh:mm tt"
                                );
                        }
                        else
                        {
                            lblUpdatedDate.Text = "-";
                        }
                    }
                    else
                    {
                        Response.Redirect(
                            "~/Officer/AssignedComplaints.aspx"
                        );
                    }
                }
            }
        }


        // =========================================================
        // LOAD COMPLAINT IMAGE
        // =========================================================

        private void LoadComplaintImage()
        {
            int complaintID = GetComplaintID();

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;

            string query = @"
                SELECT TOP 1
                    ImagePath

                FROM ComplaintImages

                WHERE ComplaintID = @ComplaintID

                ORDER BY UploadDate DESC;
            ";

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.Add(
                    "@ComplaintID",
                    SqlDbType.Int
                ).Value = complaintID;

                con.Open();

                object result =
                    cmd.ExecuteScalar();

                if (result != null &&
                    result != DBNull.Value)
                {
                    imgComplaint.ImageUrl =
                        result.ToString();

                    imgComplaint.Visible = true;
                }
                else
                {
                    imgComplaint.Visible = false;
                }
            }
        }


        // =========================================================
        // LOAD STATUS HISTORY
        // =========================================================

        private void LoadStatusHistory()
        {
            int complaintID = GetComplaintID();

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;

            string query = @"
                SELECT
                    SH.OldStatus,
                    SH.NewStatus,
                    U.FullName AS ChangedByName,
                    SH.Remarks,
                    SH.ChangeDate

                FROM StatusHistory SH

                LEFT JOIN Users U
                    ON SH.ChangedBy = U.UserID

                WHERE SH.ComplaintID = @ComplaintID

                ORDER BY SH.ChangeDate ASC;
            ";

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                cmd.Parameters.Add(
                    "@ComplaintID",
                    SqlDbType.Int
                ).Value = complaintID;

                using (SqlDataAdapter da =
                       new SqlDataAdapter(cmd))
                {
                    DataTable dt =
                        new DataTable();

                    da.Fill(dt);

                    gvStatusHistory.DataSource = dt;

                    gvStatusHistory.DataBind();
                }
            }
        }


        // =========================================================
        // MARK COMPLAINT AS RESOLVED
        // =========================================================

        protected void btnMarkResolved_Click(
            object sender,
            EventArgs e)
        {
            int officerID = GetOfficerID();

            int complaintID = GetComplaintID();

            string remarks =
                txtResolutionRemarks.Text.Trim();


            // =====================================================
            // VALIDATE REMARKS
            // =====================================================

            if (string.IsNullOrWhiteSpace(remarks))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "resolutionError",
                    "alert('Please enter resolution remarks.');",
                    true
                );

                return;
            }


            string connectionString =
                ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();

                SqlTransaction transaction =
                    con.BeginTransaction();


                try
                {
                    // =============================================
                    // STEP 1: GET CURRENT COMPLAINT STATUS
                    // =============================================

                    string statusQuery = @"
                        SELECT Status

                        FROM Complaints

                        WHERE ComplaintID = @ComplaintID
                        AND AssignedOfficerID = @OfficerID;
                    ";

                    string oldStatus = "";


                    using (SqlCommand statusCmd =
                           new SqlCommand(
                               statusQuery,
                               con,
                               transaction))
                    {
                        statusCmd.Parameters.Add(
                            "@ComplaintID",
                            SqlDbType.Int
                        ).Value = complaintID;

                        statusCmd.Parameters.Add(
                            "@OfficerID",
                            SqlDbType.Int
                        ).Value = officerID;


                        object result =
                            statusCmd.ExecuteScalar();


                        if (result == null)
                        {
                            transaction.Rollback();

                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "accessError",
                                "alert('Complaint not found or not assigned to you.');",
                                true
                            );

                            return;
                        }


                        oldStatus =
                            result.ToString();
                    }


                    // =============================================
                    // STEP 2: CHECK ALREADY RESOLVED
                    // =============================================

                    if (oldStatus == "Resolved")
                    {
                        transaction.Rollback();

                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "alreadyResolved",
                            "alert('This complaint is already resolved.');",
                            true
                        );

                        return;
                    }


                    // =============================================
                    // STEP 3: UPDATE COMPLAINT
                    // =============================================

                    string updateQuery = @"
                        UPDATE Complaints

                        SET
                            Status = 'Resolved',
                            UpdatedDate = GETDATE()

                        WHERE ComplaintID = @ComplaintID
                        AND AssignedOfficerID = @OfficerID;
                    ";


                    using (SqlCommand updateCmd =
                           new SqlCommand(
                               updateQuery,
                               con,
                               transaction))
                    {
                        updateCmd.Parameters.Add(
                            "@ComplaintID",
                            SqlDbType.Int
                        ).Value = complaintID;

                        updateCmd.Parameters.Add(
                            "@OfficerID",
                            SqlDbType.Int
                        ).Value = officerID;


                        updateCmd.ExecuteNonQuery();
                    }


                    // =============================================
                    // STEP 4: INSERT STATUS HISTORY
                    // =============================================

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
                            'Resolved',
                            @ChangedBy,
                            @Remarks,
                            GETDATE()
                        );
                    ";


                    using (SqlCommand historyCmd =
                           new SqlCommand(
                               historyQuery,
                               con,
                               transaction))
                    {
                        historyCmd.Parameters.Add(
                            "@ComplaintID",
                            SqlDbType.Int
                        ).Value = complaintID;


                        historyCmd.Parameters.Add(
                            "@OldStatus",
                            SqlDbType.NVarChar,
                            50
                        ).Value = oldStatus;


                        historyCmd.Parameters.Add(
                            "@ChangedBy",
                            SqlDbType.Int
                        ).Value = officerID;


                        historyCmd.Parameters.Add(
                            "@Remarks",
                            SqlDbType.NVarChar
                        ).Value = remarks;


                        historyCmd.ExecuteNonQuery();
                    }


                    // =============================================
                    // STEP 5: GET CITIZEN ID
                    // =============================================

                    int citizenID = 0;


                    string citizenQuery = @"
                        SELECT UserID

                        FROM Complaints

                        WHERE ComplaintID = @ComplaintID;
                    ";


                    using (SqlCommand citizenCmd =
                           new SqlCommand(
                               citizenQuery,
                               con,
                               transaction))
                    {
                        citizenCmd.Parameters.Add(
                            "@ComplaintID",
                            SqlDbType.Int
                        ).Value = complaintID;


                        object citizenResult =
                            citizenCmd.ExecuteScalar();


                        if (citizenResult != null &&
                            citizenResult != DBNull.Value)
                        {
                            citizenID =
                                Convert.ToInt32(
                                    citizenResult
                                );
                        }
                    }


                    // =============================================
                    // STEP 6: COMMIT TRANSACTION
                    // =============================================

                    transaction.Commit();


                    // =============================================
                    // STEP 7: SEND NOTIFICATION TO CITIZEN
                    // =============================================

                    if (citizenID > 0)
                    {
                        NotificationHelper.AddNotification(
                            citizenID,
                            complaintID,
                            "Complaint Resolved",
                            "Your complaint has been resolved successfully by the assigned officer.",
                            "Complaint"
                        );
                    }


                    // =============================================
                    // STEP 8: SUCCESS MESSAGE
                    // =============================================

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "success",
                        "alert('Complaint marked as resolved successfully.');" +
                        "window.location='ResolutionDetails.aspx?ComplaintID="
                        + complaintID
                        + "';",
                        true
                    );
                }
                catch
                {
                    try
                    {
                        transaction.Rollback();
                    }
                    catch
                    {
                        // Ignore rollback error
                    }


                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "error",
                        "alert('Something went wrong while resolving the complaint.');",
                        true
                    );
                }
            }
        }


        // =========================================================
        // CANCEL BUTTON
        // =========================================================

        protected void btnCancel_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "~/Officer/AssignedComplaints.aspx"
            );
        }
    }
}