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
                LoadComplaints();
            }

        }

        private void LoadComplaints()
        {
            string cs = ConfigurationManager
                .ConnectionStrings["JanVoiceDB"]
                .ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"

                        SELECT
                            C.ComplaintID,
                            C.Title,
                            C.Description,
                            C.Status,
                            C.CreatedDate,

                            U.FullName,
                            U.ProfilePhoto,

                            W.WardName,

                            CAT.CategoryName,
                            ISNULL(U.ProfilePhoto,'Images/user.png') AS ProfilePhoto,
                            ISNULL(CI.ImagePath,'Images/no-image.png') AS ImagePath,

                            ISNULL(S.SupportCount,0) AS SupportCount,

                            ISNULL(COM.CommentCount,0) AS CommentCount

                        FROM Complaints C

                        INNER JOIN Users U
                        ON C.UserID = U.UserID

                        INNER JOIN Categories CAT
                        ON C.CategoryID = CAT.CategoryID

                        INNER JOIN Wards W
                        ON C.WardID = W.WardID

                        LEFT JOIN ComplaintImages CI
                        ON C.ComplaintID = CI.ComplaintID

                        LEFT JOIN
                        (
                            SELECT
                                ComplaintID,
                                COUNT(*) SupportCount
                            FROM Supports
                            GROUP BY ComplaintID
                        ) S
                        ON C.ComplaintID = S.ComplaintID

                        LEFT JOIN
                        (
                            SELECT
                                ComplaintID,
                                COUNT(*) CommentCount
                            FROM Comments
                            GROUP BY ComplaintID
                        ) COM
                        ON C.ComplaintID = COM.ComplaintID

                        ORDER BY C.CreatedDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rptComplaints.DataSource = dt;

                rptComplaints.DataBind();
            }
        }

    }
}
