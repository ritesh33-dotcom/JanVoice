using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice
{
    public partial class ComplaintDetails : System.Web.UI.Page
    {

        string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string complaintID = Request.QueryString["id"];

                if (string.IsNullOrEmpty(complaintID))
                {
                    Response.Redirect("~/CommunityFeed.aspx");
                    return;
                }

                LoadComplaint(complaintID);
            }

        }

        private void LoadComplaint(string complaintID)
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
            SELECT
                C.ComplaintID,
                C.Title,
                C.Description,
                C.Status,
                C.CreatedDate,
                C.Landmark,

                U.FullName,
                ISNULL(U.ProfilePhoto,'Images/user.png')
                    AS ProfilePhoto,

                W.WardName,

                CAT.CategoryName,

                ISNULL(CI.ImagePath,'Images/no-image.png')
                    AS ImagePath

            FROM Complaints C

            INNER JOIN Users U
                ON C.UserID = U.UserID

            INNER JOIN Categories CAT
                ON C.CategoryID = CAT.CategoryID

            INNER JOIN Wards W
                ON C.WardID = W.WardID

            LEFT JOIN ComplaintImages CI
                ON C.ComplaintID = CI.ComplaintID

            WHERE C.ComplaintID = @ComplaintID";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@ComplaintID",
                    complaintID);

                con.Open();

                SqlDataReader reader =
                    cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblComplaintID.Text =
                        reader["ComplaintID"].ToString();

                    lblTitle.Text =
                        reader["Title"].ToString();

                    lblDescription.Text =
                        reader["Description"].ToString();

                    lblStatus.Text =
                        reader["Status"].ToString();

                    lblSideStatus.Text =
                        reader["Status"].ToString();

                    lblFullName.Text =
                        reader["FullName"].ToString();

                    lblWard.Text =
                        reader["WardName"].ToString();

                    lblSideWard.Text =
                        reader["WardName"].ToString();

                    lblCategory.Text =
                        reader["CategoryName"].ToString();

                    lblSideCategory.Text =
                        reader["CategoryName"].ToString();

                    lblLandmark.Text =
                        reader["Landmark"].ToString();

                    imgProfile.ImageUrl =
                        reader["ProfilePhoto"].ToString();

                    imgComplaint.ImageUrl =
                        reader["ImagePath"].ToString();

                    lblCreatedDate.Text =
                        Convert.ToDateTime(
                            reader["CreatedDate"])
                            .ToString("dd MMM yyyy");
                }
                else
                {
                    Response.Redirect("~/CommunityFeed.aspx");
                }
            }
        }
    }
}