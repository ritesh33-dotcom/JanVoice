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

        string connectionString =ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;
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

                string query = @"
                            INSERT INTO Complaints
                            (
                                UserID,
                                CategoryID,
                                WardID,
                                Title,
                                Description,
                                Latitude,
                                Longitude,
                                Landmark,
                                Status,
                                Priority,
                                CreatedDate
                            )
                            VALUES
                            (
                                @UserID,
                                @CategoryID,
                                @WardID,
                                @Title,
                                @Description,
                                @Latitude,
                                @Longitude,
                                @Landmark,
                                @Status,
                                @Priority,
                                GETDATE()
                            );

                            SELECT CAST(SCOPE_IDENTITY() AS INT);
                            ";


                SqlCommand cmd = new SqlCommand(query, con);


                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                cmd.Parameters.AddWithValue("@CategoryID", ddlCategory.SelectedValue);

                cmd.Parameters.AddWithValue("@WardID", ddlWard.SelectedValue);

                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());

                cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());

                cmd.Parameters.AddWithValue("@Latitude", hfLatitude.Value);

                cmd.Parameters.AddWithValue("@Longitude", hfLongitude.Value);

                cmd.Parameters.AddWithValue("@Landmark", txtLandmark.Text.Trim());

                cmd.Parameters.AddWithValue("@Status", "Pending");

                cmd.Parameters.AddWithValue("@Priority", "Medium");


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
    }
}