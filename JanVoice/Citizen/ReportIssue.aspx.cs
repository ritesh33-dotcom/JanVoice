using JanVoice.Helpers;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
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
            // User must be logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // Load data only first time
            if (!IsPostBack)
            {
                LoadCategories();
                LoadUserWard();
            }
        }


        // =========================================================
        // SUBMIT COMPLAINT
        // =========================================================

        protected void btnSubmitComplaint_Click(object sender, EventArgs e)
        {
            // =====================================================
            // 1. CHECK USER LOGIN
            // =====================================================

            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }


            // =====================================================
            // 2. GET USER'S WARD FROM SESSION
            // =====================================================

            int userWardID;

            if (Session["WardID"] == null ||
                !int.TryParse(
                    Session["WardID"].ToString(),
                    out userWardID))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "wardError",
                    "alert('Your ward is not assigned to your account. Please contact the administrator.');",
                    true
                );

                return;
            }


            // =====================================================
            // 3. BASIC VALIDATION
            // =====================================================

            if (string.IsNullOrWhiteSpace(txtTitle.Text))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "titleError",
                    "alert('Please enter complaint title.');",
                    true
                );

                return;
            }


            if (ddlCategory.SelectedValue == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "categoryError",
                    "alert('Please select a category.');",
                    true
                );

                return;
            }


            if (string.IsNullOrWhiteSpace(txtDescription.Text))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "descriptionError",
                    "alert('Please describe the complaint.');",
                    true
                );

                return;
            }


            // =====================================================
            // 4. OPTIONAL IMAGE
            // =====================================================

            string extension = "";
            string imagePath = "";

            bool hasImage = fuComplaintImage.HasFile;


            // =====================================================
            // 5. IMAGE VALIDATION
            //    ONLY IF USER UPLOADED IMAGE
            // =====================================================

            if (hasImage)
            {
                extension =
                    Path.GetExtension(
                        fuComplaintImage.FileName
                    ).ToLower();


                string[] allowedExtensions =
                {
                    ".jpg",
                    ".jpeg",
                    ".png"
                };


                // Check extension
                if (!allowedExtensions.Contains(extension))
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "imageTypeError",
                        "alert('Only JPG, JPEG and PNG files are allowed.');",
                        true
                    );

                    return;
                }


                // Check file size
                if (fuComplaintImage.PostedFile.ContentLength >
                    2 * 1024 * 1024)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "imageSizeError",
                        "alert('Maximum image size is 2 MB.');",
                        true
                    );

                    return;
                }
            }


            // =====================================================
            // 6. AUTOMATIC PRIORITY DETECTION
            // =====================================================

            string complaintPriority =
                DeterminePriority(
                    txtTitle.Text.Trim(),
                    txtDescription.Text.Trim(),
                    ddlCategory.SelectedItem.Text.Trim()
                );


            // =====================================================
            // 7. DATABASE CONNECTION
            // =====================================================

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // =================================================
                // 8. INSERT COMPLAINT
                // =================================================
                // IMPORTANT:
                // AssignedOfficerID = NULL
                //
                // Citizen does NOT select officer.
                // Admin will assign officer later.
                // =================================================

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
                        NULL,
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
                    // User
                    cmd.Parameters.Add(
                        "@UserID",
                        SqlDbType.Int
                    ).Value =
                        Convert.ToInt32(
                            Session["UserID"]
                        );


                    // Category
                    cmd.Parameters.Add(
                        "@CategoryID",
                        SqlDbType.Int
                    ).Value =
                        Convert.ToInt32(
                            ddlCategory.SelectedValue
                        );


                    // IMPORTANT:
                    // Ward comes from logged-in user's account
                    cmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value = userWardID;


                    // Complaint title
                    cmd.Parameters.Add(
                        "@Title",
                        SqlDbType.NVarChar,
                        200
                    ).Value =
                        txtTitle.Text.Trim();


                    // Description
                    cmd.Parameters.Add(
                        "@Description",
                        SqlDbType.NVarChar
                    ).Value =
                        txtDescription.Text.Trim();


                    // Latitude
                    cmd.Parameters.Add(
                        "@Latitude",
                        SqlDbType.NVarChar,
                        50
                    ).Value =
                        string.IsNullOrWhiteSpace(
                            hfLatitude.Value)
                            ? (object)DBNull.Value
                            : hfLatitude.Value;


                    // Longitude
                    cmd.Parameters.Add(
                        "@Longitude",
                        SqlDbType.NVarChar,
                        50
                    ).Value =
                        string.IsNullOrWhiteSpace(
                            hfLongitude.Value)
                            ? (object)DBNull.Value
                            : hfLongitude.Value;


                    // Landmark
                    cmd.Parameters.Add(
                        "@Landmark",
                        SqlDbType.NVarChar,
                        250
                    ).Value =
                        string.IsNullOrWhiteSpace(
                            txtLandmark.Text)
                            ? (object)DBNull.Value
                            : txtLandmark.Text.Trim();


                    // Priority
                    cmd.Parameters.Add(
                        "@Priority",
                        SqlDbType.NVarChar,
                        50
                    ).Value =
                        complaintPriority;


                    // Status
                    cmd.Parameters.Add(
                        "@Status",
                        SqlDbType.NVarChar,
                        50
                    ).Value =
                        "Pending";


                    // Execute complaint insert
                    complaintID =
                        Convert.ToInt32(
                            cmd.ExecuteScalar()
                        );
                }


                // =================================================
                // 9. SAVE IMAGE ONLY IF USER PROVIDED IMAGE
                // =================================================

                if (hasImage)
                {
                    // Generate unique filename
                    string fileName =
                        Guid.NewGuid().ToString()
                        + extension;


                    imagePath =
                        "~/Uploads/ComplaintImages/"
                        + fileName;


                    string folderPath =
                        Server.MapPath(
                            "~/Uploads/ComplaintImages/"
                        );


                    // Create folder if it does not exist
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }


                    // Full physical path
                    string fullPath =
                        Path.Combine(
                            folderPath,
                            fileName
                        );


                    // Save image to server
                    fuComplaintImage.SaveAs(
                        fullPath
                    );


                    // Insert image information into database
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
                           new SqlCommand(
                               imageQuery,
                               con))
                    {
                        imageCmd.Parameters.Add(
                            "@ComplaintID",
                            SqlDbType.Int
                        ).Value =
                            complaintID;


                        imageCmd.Parameters.Add(
                            "@UploadedBy",
                            SqlDbType.Int
                        ).Value =
                            Convert.ToInt32(
                                Session["UserID"]
                            );


                        imageCmd.Parameters.Add(
                            "@ImagePath",
                            SqlDbType.NVarChar,
                            500
                        ).Value =
                            imagePath;


                        imageCmd.Parameters.Add(
                            "@ImageType",
                            SqlDbType.NVarChar,
                            50
                        ).Value =
                            extension;


                        imageCmd.ExecuteNonQuery();
                    }
                }


                // =================================================
                // 10. SAVE STATUS HISTORY
                // =================================================

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
                       new SqlCommand(
                           historyQuery,
                           con))
                {
                    historyCmd.Parameters.Add(
                        "@ComplaintID",
                        SqlDbType.Int
                    ).Value =
                        complaintID;


                    historyCmd.Parameters.Add(
                        "@OldStatus",
                        SqlDbType.NVarChar,
                        50
                    ).Value =
                        DBNull.Value;


                    historyCmd.Parameters.Add(
                        "@NewStatus",
                        SqlDbType.NVarChar,
                        50
                    ).Value =
                        "Pending";


                    historyCmd.Parameters.Add(
                        "@ChangedBy",
                        SqlDbType.Int
                    ).Value =
                        Convert.ToInt32(
                            Session["UserID"]
                        );


                    historyCmd.Parameters.Add(
                        "@Remarks",
                        SqlDbType.NVarChar,
                        500
                    ).Value =
                        "Complaint submitted successfully.";


                    historyCmd.ExecuteNonQuery();
                }


                // =================================================
                // 11. CITIZEN NOTIFICATION
                // =================================================

                NotificationHelper.AddNotification(
                    Convert.ToInt32(
                        Session["UserID"]
                    ),
                    complaintID,
                    "Complaint Submitted",
                    "Your complaint has been submitted successfully.",
                    "Complaint"
                );


                // =================================================
                // IMPORTANT:
                // NO OFFICER NOTIFICATION HERE
                //
                // Because admin has NOT assigned an officer yet.
                // Officer notification will happen when Admin assigns
                // the complaint.
                // =================================================


                // =================================================
                // 12. SUCCESS MESSAGE
                // =================================================

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "success",
                    "alert('Complaint submitted successfully.');",
                    true
                );


                // =================================================
                // 13. CLEAR FORM
                // =================================================

                txtTitle.Text = "";

                txtDescription.Text = "";

                txtLandmark.Text = "";

                ddlCategory.SelectedIndex = 0;

                hfLatitude.Value = "";

                hfLongitude.Value = "";


                // Restore user's ward
                LoadUserWard();
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
            // If no keyword is detected,
            // default priority is MEDIUM.
            // =====================================================

            return "Medium";
        }


        // =========================================================
        // LOAD CATEGORIES
        // =========================================================

        private void LoadCategories()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        CategoryID,
                        CategoryName
                    FROM Categories
                    WHERE IsActive = 1
                    ORDER BY CategoryName;
                ";


                SqlDataAdapter da =
                    new SqlDataAdapter(
                        query,
                        con
                    );


                DataTable dt =
                    new DataTable();


                da.Fill(dt);


                ddlCategory.DataSource =
                    dt;


                ddlCategory.DataTextField =
                    "CategoryName";


                ddlCategory.DataValueField =
                    "CategoryID";


                ddlCategory.DataBind();


                ddlCategory.Items.Insert(
                    0,
                    new ListItem(
                        "-- Select Category --",
                        ""
                    )
                );
            }
        }


        // =========================================================
        // LOAD USER'S WARD
        // =========================================================

        private void LoadUserWard()
        {
            // =====================================================
            // CHECK SESSION WARD
            // =====================================================

            if (Session["WardID"] == null ||
                Session["WardID"] == DBNull.Value)
            {
                ddlWard.Items.Clear();


                ddlWard.Items.Add(
                    new ListItem(
                        "Ward not assigned",
                        ""
                    )
                );


                ddlWard.Enabled = false;


                return;
            }


            // =====================================================
            // CONVERT WARD ID
            // =====================================================

            int wardID;


            if (!int.TryParse(
                Session["WardID"].ToString(),
                out wardID))
            {
                ddlWard.Items.Clear();


                ddlWard.Items.Add(
                    new ListItem(
                        "Ward not assigned",
                        ""
                    )
                );


                ddlWard.Enabled = false;


                return;
            }


            // =====================================================
            // GET WARD NAME
            // =====================================================

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        WardID,
                        WardName
                    FROM Wards
                    WHERE WardID = @WardID;
                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value =
                        wardID;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        ddlWard.Items.Clear();


                        if (reader.Read())
                        {
                            ddlWard.Items.Add(
                                new ListItem(
                                    reader["WardName"].ToString(),
                                    reader["WardID"].ToString()
                                )
                            );


                            ddlWard.SelectedValue =
                                reader["WardID"].ToString();


                            // Citizen cannot change ward
                            ddlWard.Enabled = false;
                        }
                        else
                        {
                            ddlWard.Items.Add(
                                new ListItem(
                                    "Ward not found",
                                    ""
                                )
                            );


                            ddlWard.Enabled = false;
                        }
                    }
                }
            }
        }


        // =========================================================
        // RESET BUTTON
        // =========================================================

        protected void btnReset_Click(
            object sender,
            EventArgs e)
        {
            txtTitle.Text = "";

            txtDescription.Text = "";

            txtLandmark.Text = "";

            hfLatitude.Value = "";

            hfLongitude.Value = "";

            ddlCategory.SelectedIndex = 0;

            LoadUserWard();
        }
    }
}