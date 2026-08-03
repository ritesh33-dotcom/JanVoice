using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Citizen
{
    public partial class ComplaintDetails : System.Web.UI.Page
    {
        string connectionString =
ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int complaintID =
                        Convert.ToInt32(Request.QueryString["id"]);

                    LoadComplaintDetails(complaintID);
                    LoadTimeline(complaintID);
                    LoadComments(complaintID);
                    LoadStatistics(complaintID);
                }
                else
                {
                    Response.Redirect("MyComplaints.aspx");
                }
            }

        }

        private void LoadComplaintDetails(int complaintID)
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
                                    C.Priority,
                                    C.CreatedDate,
                                    C.Latitude,
                                    C.Longitude,
                                    C.Landmark,

                                    CAT.CategoryName,
                                    W.WardName,

                                    ISNULL
                                    (
                                    (
                                    SELECT TOP 1 ImagePath
                                    FROM ComplaintImages
                                    WHERE ComplaintID = C.ComplaintID
                                    ORDER BY ImageID DESC
                                    ),
                                    '~/Assets/Images/no-image.png'
                                    )
                                    AS ImagePath

                                    FROM Complaints C

                                    INNER JOIN Categories CAT
                                    ON C.CategoryID = CAT.CategoryID

                                    INNER JOIN Wards W
                                    ON C.WardID = W.WardID

                                    WHERE

                                    C.ComplaintID=@ComplaintID

                                    AND

                                    C.UserID=@UserID";

                                SqlCommand cmd =
                new SqlCommand(query, con);

                                cmd.Parameters.AddWithValue(
                                "@ComplaintID",
                                complaintID);

                                cmd.Parameters.AddWithValue(
                                "@UserID",
                                Session["UserID"]);

                                con.Open();

                                SqlDataReader dr =
                                cmd.ExecuteReader();

                if (dr.Read())
                {
                    imgComplaint.ImageUrl =
                                            dr["ImagePath"].ToString();

                    lblTitle.Text =
                    dr["Title"].ToString();

                    lblCategory.Text =
                    dr["CategoryName"].ToString();

                    lblWard.Text =
                    dr["WardName"].ToString();

                    lblStatus.Text =
                    dr["Status"].ToString();

                    lblPriority.Text =
                    dr["Priority"].ToString();

                    lblDescription.Text =
                    dr["Description"].ToString();

                    lblLandmark.Text =
                    dr["Landmark"].ToString();

                    string latitude = dr["Latitude"].ToString().Trim();
                    string longitude = dr["Longitude"].ToString().Trim();

                    if (!string.IsNullOrEmpty(latitude) &&
                        !string.IsNullOrEmpty(longitude))
                    {
                        mapFrame.Attributes["src"] =
                            $"https://maps.google.com/maps?q={latitude},{longitude}&z=16&output=embed";
                    }
                    else
                    {
                        mapFrame.Visible = false;
                    }


                    lblCreatedDate.Text =
                    Convert.ToDateTime(
                    dr["CreatedDate"])
                    .ToString("dd MMM yyyy hh:mm tt");

                }
                else
                {
                    Response.Redirect("MyComplaints.aspx");
                }

                dr.Close();
            }
        }

        private void LoadTimeline(int complaintID)
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"

                            SELECT

                            SH.OldStatus,
                            SH.NewStatus,
                            SH.Remarks,
                            SH.ChangeDate,

                            U.FullName,
                            R.RoleName

                            FROM StatusHistory SH

                            INNER JOIN Users U
                            ON SH.ChangedBy = U.UserID

                            INNER JOIN Roles R
                            ON U.RoleID = R.RoleID

                            WHERE SH.ComplaintID = @ComplaintID

                            ORDER BY SH.ChangeDate ASC";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@ComplaintID",
                    complaintID);

                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                rptTimeline.DataSource = dt;

                rptTimeline.DataBind();
            }
        }


        private void LoadComments(int complaintID)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"

                            SELECT

                        C.CommentID,
                        C.Comment,
                        C.CommentDate,
                        C.IsEdited,

                        U.FullName,
                        R.RoleName

                    FROM Comments C

                    INNER JOIN Users U
                    ON C.UserID = U.UserID

                    INNER JOIN Roles R
                    ON U.RoleID = R.RoleID

                    WHERE C.ComplaintID = @ComplaintID

                    ORDER BY C.CommentDate ASC";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@ComplaintID", complaintID);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rptComments.DataSource = dt;

                rptComments.DataBind();
            }
        }

        private void LoadStatistics(int complaintID)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"

                            SELECT

                            (SELECT COUNT(*)
                             FROM Supports
                             WHERE ComplaintID = @ComplaintID) AS SupportCount,

                            (SELECT COUNT(*)
                             FROM Comments
                             WHERE ComplaintID = @ComplaintID) AS CommentCount,

                            (SELECT COUNT(*)
                             FROM ComplaintImages
                             WHERE ComplaintID = @ComplaintID) AS ImageCount,

                            (SELECT COUNT(*)
                             FROM Followers
                             WHERE ComplaintID = @ComplaintID) AS FollowerCount";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@ComplaintID", complaintID);

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblSupports.Text = dr["SupportCount"].ToString();

                    lblComments.Text = dr["CommentCount"].ToString();

                    lblImages.Text = dr["ImageCount"].ToString();

                    lblFollowers.Text = dr["FollowerCount"].ToString();
                }

                dr.Close();
            }
        }

    }
}