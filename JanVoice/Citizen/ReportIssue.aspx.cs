using JanVoice.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Citizen
{
    public partial class ReportIssue : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadCategories();
                LoadWards();
            }
        }


        // =========================================================
        // SUBMIT COMPLAINT
        // =========================================================

        protected void btnSubmitComplaint_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();


                // =====================================================
                // FIND OFFICER FOR SELECTED WARD
                // =====================================================

                int assignedOfficerID = 0;

                string officerQuery = @"
                    SELECT TOP 1 UserID
                    FROM Users
                    WHERE WardID = @WardID
                    AND RoleID = 2
                    ORDER BY UserID;
                ";

                using (SqlCommand officerCmd =
                       new SqlCommand(officerQuery, con))
                {
                    officerCmd.Parameters.Add("@WardID", SqlDbType.Int)
                        .Value = Convert.ToInt32(ddlWard.SelectedValue);

                    object result = officerCmd.ExecuteScalar();

                    if (result == null || result == DBNull.Value)
                    {
                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "officerError",
                            "alert('No officer is assigned to the selected ward.');",
                            true);

                        return;
                    }

                    assignedOfficerID = Convert.ToInt32(result);
                }


                // =====================================================
                // IMAGE VALIDATION
                // =====================================================

                string extension = Path.GetExtension(
                    fuComplaintImage.FileName
                ).ToLower();

                string[] allowed =
                {
                    ".jpg",
                    ".jpeg",
                    ".png"
                };


                if (!allowed.Contains(extension))
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "alert",
                        "alert('Only JPG, JPEG and PNG files are allowed.');",
                        true);

                    return;
                }


                if (fuComplaintImage.PostedFile.ContentLength >
                    2 * 1024 * 1024)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "alert",
                        "alert('Maximum file size is 2 MB.');",
                        true);

                    return;
                }


                // =====================================================
                // SAVE IMAGE
                // =====================================================

                string fileName =
                    Guid.NewGuid().ToString() + extension;

                string imagePath =
                    "~/Uploads/ComplaintImages/" + fileName;

                string folderPath =
                    Server.MapPath("~/Uploads/ComplaintImages/");


                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }


                string fullPath =
                    Path.Combine(folderPath, fileName);


                fuComplaintImage.SaveAs(fullPath);


                // =====================================================
                // AUTOMATIC PRIORITY DETECTION
                // =====================================================

                string complaintPriority =
                    DeterminePriority(
                        txtTitle.Text.Trim(),
                        txtDescription.Text.Trim(),
                        ddlCategory.SelectedItem.Text.Trim()
                    );


                // =====================================================
                // INSERT COMPLAINT
                // =====================================================

                string query = @"
                    INSERT INTO Complaints
                    (
                        UserID,
                        CategoryID,
                        WardID,
                        AssignedOfficerID,
                        Title,
                        Description,
                        Latitude,
                        Longitude,
                        Landmark,
                        Priority,
                        Status,
                        CreatedDate
                    )
                    VALUES
                    (
                        @UserID,
                        @CategoryID,
                        @WardID,
                        @AssignedOfficerID,
                        @Title,
                        @Description,
                        @Latitude,
                        @Longitude,
                        @Landmark,
                        @Priority,
                        @Status,
                        GETDATE()
                    );

                    SELECT CAST(SCOPE_IDENTITY() AS INT);
                ";


                int complaintID;


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@UserID", SqlDbType.Int)
                        .Value =
                        Convert.ToInt32(Session["UserID"]);


                    cmd.Parameters.Add("@CategoryID", SqlDbType.Int)
                        .Value =
                        Convert.ToInt32(ddlCategory.SelectedValue);


                    cmd.Parameters.Add("@WardID", SqlDbType.Int)
                        .Value =
                        Convert.ToInt32(ddlWard.SelectedValue);


                    cmd.Parameters.Add("@AssignedOfficerID", SqlDbType.Int)
                        .Value =
                        assignedOfficerID;


                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 200)
                        .Value =
                        txtTitle.Text.Trim();


                    cmd.Parameters.Add("@Description", SqlDbType.NVarChar)
                        .Value =
                        txtDescription.Text.Trim();


                    cmd.Parameters.Add("@Latitude", SqlDbType.NVarChar, 50)
                        .Value =
                        hfLatitude.Value;


                    cmd.Parameters.Add("@Longitude", SqlDbType.NVarChar, 50)
                        .Value =
                        hfLongitude.Value;


                    cmd.Parameters.Add("@Landmark", SqlDbType.NVarChar, 250)
                        .Value =
                        txtLandmark.Text.Trim();


                    // =================================================
                    // AUTOMATIC PRIORITY
                    // =================================================

                    cmd.Parameters.Add("@Priority", SqlDbType.NVarChar, 50)
                        .Value =
                        complaintPriority;


                    cmd.Parameters.Add("@Status", SqlDbType.NVarChar, 50)
                        .Value =
                        "Pending";


                    complaintID =
                        Convert.ToInt32(
                            cmd.ExecuteScalar()
                        );
                }


                // =====================================================
                // SAVE COMPLAINT IMAGE
                // =====================================================

                string imageQuery = @"
                    INSERT INTO ComplaintImages
                    (
                        ComplaintID,
                        UploadedBy,
                        ImagePath,
                        ImageType,
                        UploadDate
                    )
                    VALUES
                    (
                        @ComplaintID,
                        @UploadedBy,
                        @ImagePath,
                        @ImageType,
                        GETDATE()
                    );
                ";


                using (SqlCommand imageCmd =
                       new SqlCommand(imageQuery, con))
                {
                    imageCmd.Parameters.Add("@ComplaintID", SqlDbType.Int)
                        .Value = complaintID;


                    imageCmd.Parameters.Add("@UploadedBy", SqlDbType.Int)
                        .Value =
                        Convert.ToInt32(Session["UserID"]);


                    imageCmd.Parameters.Add("@ImagePath", SqlDbType.NVarChar, 500)
                        .Value =
                        imagePath;


                    imageCmd.Parameters.Add("@ImageType", SqlDbType.NVarChar, 50)
                        .Value =
                        extension;


                    imageCmd.ExecuteNonQuery();
                }


                // =====================================================
                // SAVE STATUS HISTORY
                // =====================================================

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
                    );
                ";


                using (SqlCommand historyCmd =
                       new SqlCommand(historyQuery, con))
                {
                    historyCmd.Parameters.Add("@ComplaintID", SqlDbType.Int)
                        .Value = complaintID;


                    historyCmd.Parameters.Add("@OldStatus", SqlDbType.NVarChar, 50)
                        .Value = DBNull.Value;


                    historyCmd.Parameters.Add("@NewStatus", SqlDbType.NVarChar, 50)
                        .Value = "Pending";


                    historyCmd.Parameters.Add("@ChangedBy", SqlDbType.Int)
                        .Value =
                        Convert.ToInt32(Session["UserID"]);


                    historyCmd.Parameters.Add("@Remarks", SqlDbType.NVarChar, 500)
                        .Value =
                        "Complaint submitted successfully.";


                    historyCmd.ExecuteNonQuery();
                }


                // =====================================================
                // NOTIFICATIONS
                // =====================================================

                NotificationHelper.AddNotification(
                    Convert.ToInt32(Session["UserID"]),
                    complaintID,
                    "Complaint Submitted",
                    "Your complaint has been submitted successfully.",
                    "Complaint"
                );


                NotificationHelper.AddNotification(
                    assignedOfficerID,
                    complaintID,
                    "New Complaint Assigned",
                    "You have received a new complaint.",
                    "Complaint"
                );


                // =====================================================
                // SUCCESS MESSAGE
                // =====================================================

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "success",
                    "alert('Complaint submitted successfully.');",
                    true
                );


                // =====================================================
                // CLEAR FORM
                // =====================================================

                txtTitle.Text = "";
                txtDescription.Text = "";
                txtLandmark.Text = "";

                ddlCategory.SelectedIndex = 0;
                ddlWard.SelectedIndex = 0;

                hfLatitude.Value = "";
                hfLongitude.Value = "";
            }
        }


        // =========================================================
        // AUTOMATIC PRIORITY DETECTION
        // =========================================================

        private string DeterminePriority(
            string title,
            string description,
            string category)
        {
            string text =
                (
                    title + " " +
                    description + " " +
                    category
                ).ToLower();


            // =====================================================
            // HIGH PRIORITY KEYWORDS
            // =====================================================

            string[] highPriorityKeywords =
            {
                "accident",
                "fire",
                "gas leak",
                "gas leakage",
                "electric shock",
                "electric wire",
                "live wire",
                "exposed wire",
                "short circuit",
                "dangerous",
                "danger",
                "life threatening",
                "life threat",
                "emergency",
                "open manhole",
                "manhole open",
                "sewage overflow",
                "sewage leakage",
                "major leakage",
                "major water leakage",
                "road blocked",
                "roadblock",
                "building collapse",
                "wall collapse",
                "tree fallen",
                "fallen tree",
                "electric pole fallen",
                "pole fallen",
                "transformer",
                "water contamination",
                "contaminated water",
                "toxic",
                "smoke",
                "explosion",
                "flood",
                "flooded road"
            };


            foreach (string keyword in highPriorityKeywords)
            {
                if (text.Contains(keyword))
                {
                    return "High";
                }
            }


            // =====================================================
            // MEDIUM PRIORITY KEYWORDS
            // =====================================================

            string[] mediumPriorityKeywords =
            {
                "pothole",
                "road damage",
                "damaged road",
                "garbage",
                "waste",
                "street light",
                "streetlight",
                "drainage",
                "drain blocked",
                "water leakage",
                "water leak",
                "water problem",
                "traffic",
                "broken footpath",
                "footpath",
                "broken road",
                "road damaged",
                "dirty",
                "sanitation",
                "public toilet",
                "stray dogs",
                "dog",
                "noise",
                "parking",
                "dust",
                "construction",
                "drain",
                "sewer"
            };


            foreach (string keyword in mediumPriorityKeywords)
            {
                if (text.Contains(keyword))
                {
                    return "Medium";
                }
            }


            // =====================================================
            // DEFAULT PRIORITY
            // =====================================================

            return "Low";
        }


        // =========================================================
        // LOAD CATEGORIES
        // =========================================================

        private void LoadCategories()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query =
                    "SELECT CategoryID, CategoryName " +
                    "FROM Categories " +
                    "WHERE IsActive=1";


                SqlDataAdapter da =
                    new SqlDataAdapter(query, con);


                DataTable dt =
                    new DataTable();


                da.Fill(dt);


                ddlCategory.DataSource = dt;

                ddlCategory.DataTextField =
                    "CategoryName";

                ddlCategory.DataValueField =
                    "CategoryID";


                ddlCategory.DataBind();


                ddlCategory.Items.Insert(
                    0,
                    "-- Select Category --"
                );
            }
        }


        // =========================================================
        // LOAD WARDS
        // =========================================================

        private void LoadWards()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query =
                    "SELECT WardID, WardName FROM Wards ";


                SqlDataAdapter da =
                    new SqlDataAdapter(query, con);


                DataTable dt =
                    new DataTable();


                da.Fill(dt);


                ddlWard.DataSource =
                    dt;


                ddlWard.DataTextField =
                    "WardName";


                ddlWard.DataValueField =
                    "WardID";


                ddlWard.DataBind();


                ddlWard.Items.Insert(
                    0,
                    "-- Select Ward --"
                );
            }
        }


        // =========================================================
        // RESET BUTTON
        // =========================================================

        protected void btnReset_Click(
            object sender,
            EventArgs e)
        {
        }


        protected void btnReset_Click1(
            object sender,
            EventArgs e)
        {
        }


        protected void btnReset_Click2(
            object sender,
            EventArgs e)
        {
        }
    }
}