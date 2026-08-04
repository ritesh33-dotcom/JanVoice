using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice
{
    public partial class CommunityFeed : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadStatus();
                LoadCommunityFeed();
            }

        }
        private void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                        SELECT CategoryID, CategoryName
                        FROM Categories
                        ORDER BY CategoryName";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();

                ddlCategory.Items.Insert(0,
                    new System.Web.UI.WebControls.ListItem(
                        "All Categories", "0"));
            }
        }
        private void LoadStatus()
        {
            ddlStatus.Items.Clear();

            ddlStatus.Items.Add("All Status");
            ddlStatus.Items.Add("Pending");
            ddlStatus.Items.Add("Accepted");
            ddlStatus.Items.Add("In Progress");
            ddlStatus.Items.Add("Resolved");
            ddlStatus.Items.Add("Rejected");
        }

        private void LoadCommunityFeed()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                String query = @"SELECT

                        C.ComplaintID,

                        C.Title,

                        C.Description,

                        C.Status,

                        U.FullName,
                        ISNULL(U.ProfilePhoto,'Images/user.png') AS ProfilePhoto,

                        W.WardName,

                        CAT.CategoryName,

                        ISNULL
                        (
                        NULLIF(U.ProfilePhoto,''),

                        'Images/user.png'
                        )
                        AS ProfilePhoto,

                        ISNULL
                        (
                        (
                        SELECT TOP 1 ImagePath
                        FROM ComplaintImages
                        WHERE ComplaintID=C.ComplaintID
                        ORDER BY ImageID DESC
                        ),

                        'Images/no-image.png'
                        )
                        AS ImagePath,

                        ISNULL
                        (
                        (
                        SELECT COUNT(*)
                        FROM Supports S
                        WHERE S.ComplaintID=C.ComplaintID
                        ),
                        0
                        )
                        AS SupportCount,

                        ISNULL
                        (
                        (
                        SELECT COUNT(*)
                        FROM Comments CM
                        WHERE CM.ComplaintID=C.ComplaintID
                        ),
                        0
                        )
                        AS CommentCount

                        FROM Complaints C

                        INNER JOIN Users U
                        ON C.UserID=U.UserID

                        INNER JOIN Categories CAT
                        ON C.CategoryID=CAT.CategoryID

                        INNER JOIN Wards W
                        ON C.WardID=W.WardID

                        ORDER BY C.CreatedDate DESC";

                SqlDataAdapter da =
                 new SqlDataAdapter(query, con);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                rptComplaints.DataSource = dt;

                rptComplaints.DataBind();

            }
        }
    }
}
