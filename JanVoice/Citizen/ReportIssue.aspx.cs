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

        string connectionString = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;
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

        protected void btnSubmitComplaint_Click(object sender, EventArgs e)
        {
            if (txtTitle.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please enter Complaint Title.');",
                    true);

                return;
            }

            if (ddlCategory.SelectedIndex == 0)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please select Category.');",
                    true);

                return;
            }

            if (ddlWard.SelectedIndex == 0)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please select Ward.');",
                    true);

                return;
            }

            if (txtDescription.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please enter Description.');",
                    true);

                return;
            }

            if (!fuComplaintImage.HasFile)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please upload a complaint image.');",
                    true);

                return;
            }

            string extension =
    Path.GetExtension(fuComplaintImage.FileName).ToLower();

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

            if (fuComplaintImage.PostedFile.ContentLength > 2 * 1024 * 1024)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Maximum file size is 2 MB.');",
                    true);

                return;
            }

            string fileName =
    Guid.NewGuid().ToString() + extension;

            string imagePath =
    "~/Uploads/ComplaintImages/" + fileName;

            string folderPath = Server.MapPath("~/Uploads/ComplaintImages/");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fullPath = Path.Combine(folderPath, fileName);
            fuComplaintImage.SaveAs(fullPath);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                int assignedOfficerID = 0;

                string officerQuery = @"
                SELECT TOP 1 UserID
                FROM Users
                WHERE WardID = @WardID
                AND RoleID = 2";

                using (SqlCommand officerCmd = new SqlCommand(officerQuery, con))
                {
                    officerCmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value = Convert.ToInt32(ddlWard.SelectedValue);

                    object result = officerCmd.ExecuteScalar();

                    if (assignedOfficerID == 0)
                    {
                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "officerError",
                            "alert('No officer is assigned to the selected ward.');",
                            true
                        );

                        return;
                    }

                    assignedOfficerID = Convert.ToInt32(result);
                }
            }
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
                                @Priority,
                                @Status,
                                GETDATE()
                                )
                            SELECT CAST(SCOPE_IDENTITY() AS INT);
                            ";


            SqlCommand cmd = new SqlCommand(query, con);


            cmd.Parameters.Add("@UserID", SqlDbType.Int)
 .Value = Convert.ToInt32(Session["UserID"]);

            cmd.Parameters.Add("@CategoryID", SqlDbType.Int)
                .Value = Convert.ToInt32(ddlCategory.SelectedValue);

            cmd.Parameters.Add("@WardID", SqlDbType.Int)
                .Value = Convert.ToInt32(ddlWard.SelectedValue);

            cmd.Parameters.Add("@AssignedOfficerID", SqlDbType.Int)
                .Value = assignedOfficerID;

            cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 200)
                .Value = txtTitle.Text.Trim();

            cmd.Parameters.Add("@Description", SqlDbType.NVarChar)
                .Value = txtDescription.Text.Trim();

            cmd.Parameters.Add("@Latitude", SqlDbType.NVarChar, 50)
                .Value = hfLatitude.Value;

            cmd.Parameters.Add("@Longitude", SqlDbType.NVarChar, 50)
                .Value = hfLongitude.Value;

            cmd.Parameters.Add("@Landmark", SqlDbType.NVarChar, 250)
                .Value = txtLandmark.Text.Trim();

            cmd.Parameters.Add("@Status", SqlDbType.NVarChar, 50)
                .Value = "Pending";

            cmd.Parameters.Add("@Priority", SqlDbType.NVarChar, 50)
                .Value = "Medium";


            int complaintID = Convert.ToInt32(cmd.ExecuteScalar());

            //-------------------------------------
            // Save Uploaded Image
            //-------------------------------------

            if (fuComplaintImage.HasFile)
            {


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
                            )";
                SqlCommand imageCmd =
new SqlCommand(imageQuery, con);

                imageCmd.Parameters.AddWithValue(
                    "@ComplaintID",
                    complaintID);
                imageCmd.Parameters.AddWithValue(
                        "@UploadedBy",
                        Session["UserID"]);
                imageCmd.Parameters.AddWithValue(
                    "@ImagePath",
                    imagePath);


                imageCmd.Parameters.AddWithValue(
                    "@ImageType",
                    extension);

                imageCmd.ExecuteNonQuery();


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
                            )";

                SqlCommand historyCmd = new SqlCommand(historyQuery, con);

                historyCmd.Parameters.AddWithValue("@ComplaintID", complaintID);

                historyCmd.Parameters.AddWithValue("@OldStatus", DBNull.Value);

                historyCmd.Parameters.AddWithValue("@NewStatus", "Pending");

                historyCmd.Parameters.AddWithValue("@ChangedBy", Session["UserID"]);

                historyCmd.Parameters.AddWithValue("@Remarks",
                    "Complaint submitted successfully.");

                historyCmd.ExecuteNonQuery();



                NotificationHelper.AddNotification(
                    Convert.ToInt32(Session["UserID"]),
                    complaintID,
                    "Complaint Submitted",
                    "Your complaint has been submitted successfully.",
                    "Complaint");
                NotificationHelper.AddNotification(
assignedOfficerID,
complaintID,
"New Complaint Assigned",
"You have received a new complaint.",
"Complaint");




                ClientScript.RegisterStartupScript(
this.GetType(),
"success",
"alert('Complaint submitted successfully.');",
true);

                txtTitle.Text = "";
                txtDescription.Text = "";
                txtLandmark.Text = "";
                ddlCategory.SelectedIndex = 0;
                ddlWard.SelectedIndex = 0;
                hfLatitude.Value = "";
                hfLongitude.Value = "";

            }



        }




    }



























        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT CategoryID, CategoryName FROM Categories WHERE IsActive=1";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlCategory.DataSource = dt;

                ddlCategory.DataTextField = "CategoryName";

                ddlCategory.DataValueField = "CategoryID";

                ddlCategory.DataBind();

                ddlCategory.Items.Insert(0, "-- Select Category --");
            }
        }

        private void LoadWards()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT WardID, WardName FROM Wards";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlWard.DataSource = dt;

                ddlWard.DataTextField = "WardName";

                ddlWard.DataValueField = "WardID";

                ddlWard.DataBind();

                ddlWard.Items.Insert(0, "-- Select Ward --");
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click1(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click2(object sender, EventArgs e)
        {

        }
    }
}