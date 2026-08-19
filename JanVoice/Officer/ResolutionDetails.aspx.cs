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
    public partial class ResolutionDetails : Page
    {
        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckOfficerLogin();

            if (!IsPostBack)
            {
                string complaintValue =
                    Request.QueryString["ComplaintID"];

                int complaintID;

                // -------------------------------------------------
                // CHECK COMPLAINT ID
                // -------------------------------------------------

                if (string.IsNullOrWhiteSpace(complaintValue) ||
                    !int.TryParse(complaintValue, out complaintID) ||
                    complaintID <= 0)
                {
                    ShowMessageAndRedirect(
                        "Complaint ID is missing. Please open Resolution Details from Assigned Complaints.",
                        "~/Officer/AssignedComplaints.aspx"
                    );

                    return;
                }

                // -------------------------------------------------
                // LOAD PAGE DATA
                // -------------------------------------------------

                LoadComplaintDetails(complaintID);
                LoadComplaintImages(complaintID);
                LoadStatusHistory(complaintID);
                LoadLatestResolution(complaintID);
            }
        }


        // =========================================================
        // CONNECTION STRING
        // =========================================================

        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;
        }


        // =========================================================
        // LOGIN CHECK
        // =========================================================

        private void CheckOfficerLogin()
        {
            if (Session["UserID"] == null ||
                Session["RoleID"] == null)
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
        // GET OFFICER ID
        // =========================================================

        private int GetOfficerID()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return 0;
            }

            int officerID;

            if (!int.TryParse(
                Session["UserID"].ToString(),
                out officerID))
            {
                Response.Redirect("~/Login.aspx");
                return 0;
            }

            return officerID;
        }


        // =========================================================
        // MESSAGE + REDIRECT
        // =========================================================

        private void ShowMessageAndRedirect(
            string message,
            string url)
        {
            string safeMessage =
                message.Replace(
                    "'",
                    "\\'"
                );

            string safeUrl =
                ResolveUrl(url);

            ClientScript.RegisterStartupScript(
                this.GetType(),
                Guid.NewGuid().ToString(),
                "alert('" +
                safeMessage +
                "'); window.location.href='" +
                safeUrl +
                "';",
                true
            );
        }


        // =========================================================
        // LOAD COMPLAINT DETAILS
        // =========================================================

        private void LoadComplaintDetails(int complaintID)
        {
            int officerID = GetOfficerID();

            string query = @"
                SELECT
                    C.ComplaintID,
                    C.Title,
                    C.Description,
                    C.Priority,
                    C.Status,
                    C.CreatedDate,
                    C.UpdatedDate,

                    C.Latitude,
                    C.Longitude,
                    C.Landmark,

                    U.FullName AS CitizenName,
                    U.Email AS CitizenEmail,
                    U.Mobile AS CitizenPhone,

                    CAT.CategoryName,

                    W.WardName

                FROM Complaints C

                LEFT JOIN Users U
                    ON C.UserID = U.UserID

                LEFT JOIN Categories CAT
                    ON C.CategoryID = CAT.CategoryID

                LEFT JOIN Wards W
                    ON C.WardID = W.WardID

                WHERE
                    C.ComplaintID = @ComplaintID
                    AND C.AssignedOfficerID = @OfficerID;
            ";

            using (SqlConnection con =
                   new SqlConnection(
                       GetConnectionString()))
            using (SqlCommand cmd =
                   new SqlCommand(
                       query,
                       con))
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
                    if (!reader.Read())
                    {
                        ShowMessageAndRedirect(
                            "Complaint not found or this complaint is not assigned to you.",
                            "~/Officer/AssignedComplaints.aspx"
                        );

                        return;
                    }


                    // -------------------------------------------------
                    // COMPLAINT INFORMATION
                    // -------------------------------------------------

                    lblComplaintID.Text =
                        reader["ComplaintID"].ToString();

                    lblComplaintTitle.Text =
                        reader["Title"] != DBNull.Value
                        ? reader["Title"].ToString()
                        : "-";

                    lblDescription.Text =
                        reader["Description"] != DBNull.Value
                        ? reader["Description"].ToString()
                        : "No description available.";

                    lblCategory.Text =
                        reader["CategoryName"] != DBNull.Value
                        ? reader["CategoryName"].ToString()
                        : "-";

                    lblWard.Text =
                        reader["WardName"] != DBNull.Value
                        ? reader["WardName"].ToString()
                        : "-";

                    lblPriority.Text =
                        reader["Priority"] != DBNull.Value
                        ? reader["Priority"].ToString()
                        : "-";

                    lblStatus.Text =
                        reader["Status"] != DBNull.Value
                        ? reader["Status"].ToString()
                        : "-";


                    // -------------------------------------------------
                    // CITIZEN INFORMATION
                    // -------------------------------------------------

                    lblCitizenName.Text =
                        reader["CitizenName"] != DBNull.Value
                        ? reader["CitizenName"].ToString()
                        : "-";

                    lblCitizenEmail.Text =
                        reader["CitizenEmail"] != DBNull.Value
                        ? reader["CitizenEmail"].ToString()
                        : "-";

                    lblCitizenPhone.Text =
                        reader["CitizenPhone"] != DBNull.Value
                        ? reader["CitizenPhone"].ToString()
                        : "-";


                    // -------------------------------------------------
                    // LOCATION
                    // -------------------------------------------------

                    lblLandmark.Text =
                        reader["Landmark"] != DBNull.Value
                        ? reader["Landmark"].ToString()
                        : "-";

                    lblLatitude.Text =
                        reader["Latitude"] != DBNull.Value
                        ? reader["Latitude"].ToString()
                        : "-";

                    lblLongitude.Text =
                        reader["Longitude"] != DBNull.Value
                        ? reader["Longitude"].ToString()
                        : "-";


                    // -------------------------------------------------
                    // CREATED DATE
                    // -------------------------------------------------

                    if (reader["CreatedDate"] != DBNull.Value)
                    {
                        lblCreatedDate.Text =
                            Convert.ToDateTime(
                                reader["CreatedDate"]
                            ).ToString(
                                "dd MMM yyyy, hh:mm tt"
                            );
                    }
                    else
                    {
                        lblCreatedDate.Text = "-";
                    }


                    // -------------------------------------------------
                    // UPDATED DATE
                    // -------------------------------------------------

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


                    // -------------------------------------------------
                    // RESOLUTION CONTROL
                    // -------------------------------------------------

                    string status =
                        reader["Status"] != DBNull.Value
                        ? reader["Status"].ToString()
                        : "";

                    if (status.Equals(
                        "Resolved",
                        StringComparison.OrdinalIgnoreCase))
                    {
                        btnMarkResolved.Visible = false;

                        txtResolutionRemarks.Visible = false;

                        txtResolutionDate.Visible = false;
                    }
                    else
                    {
                        btnMarkResolved.Visible = true;

                        txtResolutionRemarks.Visible = true;

                        txtResolutionDate.Visible = true;

                        txtResolutionDate.Text =
                            DateTime.Now.ToString(
                                "yyyy-MM-dd"
                            );
                    }
                }
            }
        }


        // =========================================================
        // LOAD COMPLAINT IMAGES
        // =========================================================

        private void LoadComplaintImages(int complaintID)
        {
            string query = @"
                SELECT
                    ImageID,
                    ImagePath,
                    ImageType,
                    UploadDate

                FROM ComplaintImages

                WHERE ComplaintID = @ComplaintID

                ORDER BY UploadDate DESC;
            ";

            using (SqlConnection con =
                   new SqlConnection(
                       GetConnectionString()))
            using (SqlCommand cmd =
                   new SqlCommand(
                       query,
                       con))
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

                    if (dt.Rows.Count == 0)
                    {
                        imgComplaint.Visible = false;

                        lblNoImage.Visible = true;

                        return;
                    }

                    DataRow row =
                        dt.Rows[0];

                    string imagePath =
                        row["ImagePath"] != DBNull.Value
                        ? row["ImagePath"].ToString()
                        : "";

                    if (!string.IsNullOrWhiteSpace(
                        imagePath))
                    {
                        imgComplaint.ImageUrl =
                            ResolveUrl(imagePath);

                        imgComplaint.Visible = true;

                        lblNoImage.Visible = false;
                    }
                    else
                    {
                        imgComplaint.Visible = false;

                        lblNoImage.Visible = true;
                    }
                }
            }
        }


        // =========================================================
        // LOAD STATUS HISTORY
        // =========================================================

        private void LoadStatusHistory(int complaintID)
        {
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

                WHERE
                    SH.ComplaintID = @ComplaintID

                ORDER BY
                    SH.ChangeDate ASC;
            ";

            using (SqlConnection con =
                   new SqlConnection(
                       GetConnectionString()))
            using (SqlCommand cmd =
                   new SqlCommand(
                       query,
                       con))
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

                    gvStatusHistory.DataSource =
                        dt;

                    gvStatusHistory.DataBind();
                }
            }
        }


        // =========================================================
        // LOAD LATEST RESOLUTION
        // =========================================================

        private void LoadLatestResolution(int complaintID)
        {
            string query = @"
                SELECT TOP 1
                    Remarks,
                    ChangeDate

                FROM StatusHistory

                WHERE
                    ComplaintID = @ComplaintID
                    AND NewStatus = 'Resolved'

                ORDER BY
                    ChangeDate DESC;
            ";

            using (SqlConnection con =
                   new SqlConnection(
                       GetConnectionString()))
            using (SqlCommand cmd =
                   new SqlCommand(
                       query,
                       con))
            {
                cmd.Parameters.Add(
                    "@ComplaintID",
                    SqlDbType.Int
                ).Value = complaintID;

                con.Open();

                using (SqlDataReader reader =
                       cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtResolutionRemarks.Text =
                            reader["Remarks"] != DBNull.Value
                            ? reader["Remarks"].ToString()
                            : "";

                        if (reader["ChangeDate"] != DBNull.Value)
                        {
                            txtResolutionDate.Text =
                                Convert.ToDateTime(
                                    reader["ChangeDate"]
                                ).ToString(
                                    "yyyy-MM-dd"
                                );
                        }
                    }
                }
            }
        }


        // =========================================================
        // MARK AS RESOLVED
        // =========================================================

        protected void btnMarkResolved_Click(
            object sender,
            EventArgs e)
        {
            int officerID =
                GetOfficerID();

            string complaintValue =
                Request.QueryString["ComplaintID"];

            int complaintID;

            if (!int.TryParse(
                complaintValue,
                out complaintID) ||
                complaintID <= 0)
            {
                ShowMessageAndRedirect(
                    "Complaint ID is missing.",
                    "~/Officer/AssignedComplaints.aspx"
                );

                return;
            }


            // -------------------------------------------------
            // REMARKS
            // -------------------------------------------------

            string remarks =
                txtResolutionRemarks.Text.Trim();

            if (string.IsNullOrWhiteSpace(
                remarks))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "remarksError",
                    "alert('Please enter resolution remarks.');",
                    true
                );

                return;
            }


            // -------------------------------------------------
            // RESOLUTION DATE
            // -------------------------------------------------

            DateTime resolutionDate =
                DateTime.Now;

            DateTime parsedDate;

            if (DateTime.TryParse(
                txtResolutionDate.Text,
                out parsedDate))
            {
                resolutionDate =
                    parsedDate;
            }


            // -------------------------------------------------
            // DATABASE TRANSACTION
            // -------------------------------------------------

            using (SqlConnection con =
                   new SqlConnection(
                       GetConnectionString()))
            {
                con.Open();

                SqlTransaction transaction =
                    con.BeginTransaction();

                try
                {
                    string oldStatus = "";


                    // -------------------------------------------------
                    // GET CURRENT STATUS
                    // -------------------------------------------------

                    string statusQuery = @"
                        SELECT Status

                        FROM Complaints

                        WHERE
                            ComplaintID = @ComplaintID
                            AND AssignedOfficerID = @OfficerID;
                    ";

                    using (SqlCommand cmd =
                           new SqlCommand(
                               statusQuery,
                               con,
                               transaction))
                    {
                        cmd.Parameters.Add(
                            "@ComplaintID",
                            SqlDbType.Int
                        ).Value = complaintID;

                        cmd.Parameters.Add(
                            "@OfficerID",
                            SqlDbType.Int
                        ).Value = officerID;

                        object result =
                            cmd.ExecuteScalar();

                        if (result == null)
                        {
                            transaction.Rollback();

                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "notFound",
                                "alert('Complaint not found or not assigned to you.');",
                                true
                            );

                            return;
                        }

                        oldStatus =
                            result.ToString();
                    }


                    // -------------------------------------------------
                    // ALREADY RESOLVED
                    // -------------------------------------------------

                    if (oldStatus.Equals(
                        "Resolved",
                        StringComparison.OrdinalIgnoreCase))
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


                    // -------------------------------------------------
                    // UPDATE COMPLAINT
                    // -------------------------------------------------

                    string updateQuery = @"
                        UPDATE Complaints

                        SET
                            Status = 'Resolved',
                            UpdatedDate = @ResolutionDate

                        WHERE
                            ComplaintID = @ComplaintID
                            AND AssignedOfficerID = @OfficerID;
                    ";

                    using (SqlCommand cmd =
                           new SqlCommand(
                               updateQuery,
                               con,
                               transaction))
                    {
                        cmd.Parameters.Add(
                            "@ComplaintID",
                            SqlDbType.Int
                        ).Value = complaintID;

                        cmd.Parameters.Add(
                            "@OfficerID",
                            SqlDbType.Int
                        ).Value = officerID;

                        cmd.Parameters.Add(
                            "@ResolutionDate",
                            SqlDbType.DateTime
                        ).Value = resolutionDate;

                        cmd.ExecuteNonQuery();
                    }


                    // -------------------------------------------------
                    // INSERT STATUS HISTORY
                    // -------------------------------------------------

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
                            @ChangeDate
                        );
                    ";

                    using (SqlCommand cmd =
                           new SqlCommand(
                               historyQuery,
                               con,
                               transaction))
                    {
                        cmd.Parameters.Add(
                            "@ComplaintID",
                            SqlDbType.Int
                        ).Value = complaintID;

                        cmd.Parameters.Add(
                            "@OldStatus",
                            SqlDbType.NVarChar,
                            50
                        ).Value = oldStatus;

                        cmd.Parameters.Add(
                            "@ChangedBy",
                            SqlDbType.Int
                        ).Value = officerID;

                        cmd.Parameters.Add(
                            "@Remarks",
                            SqlDbType.NVarChar,
                            -1
                        ).Value = remarks;

                        cmd.Parameters.Add(
                            "@ChangeDate",
                            SqlDbType.DateTime
                        ).Value = resolutionDate;

                        cmd.ExecuteNonQuery();
                    }


                    // -------------------------------------------------
                    // COMMIT
                    // -------------------------------------------------

                    transaction.Commit();


                    // -------------------------------------------------
                    // SUCCESS
                    // -------------------------------------------------

                    string redirectUrl =
                        ResolveUrl(
                            "~/Officer/ResolutionDetails.aspx?ComplaintID="
                            + complaintID
                        );

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "success",
                        "alert('Complaint marked as resolved successfully.');" +
                        "window.location.href='" +
                        redirectUrl +
                        "';",
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
        // BACK BUTTON
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