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
        if (!IsPostBack)
            {
                LoadFeed();
            }
    }

private void LoadFeed()
{
    string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

    using (SqlConnection con = new SqlConnection(cs))
        {
        string query = @"

                        SELECT

                        C.ComplaintID,
                        C.Title,
                        C.Description,
                        C.Status,
                        U.FullName,
                        W.WardName,
                        CAT.CategoryName,

                        ISNULL(CI.ImagePath,'Assets/Images/demo1.jpg') AS ImagePath

                        FROM Complaints C

                        INNER JOIN Users U
                        ON C.UserID=U.UserID

                        INNER JOIN Categories CAT
                        ON C.CategoryID=CAT.CategoryID

                        INNER JOIN Wards W
                        ON C.WardID=W.WardID

                        LEFT JOIN ComplaintImages CI
                        ON C.ComplaintID=CI.ComplaintID

                        ORDER BY C.CreatedDate DESC";

                        SqlDataAdapter da = new SqlDataAdapter(query, con);

                                    DataTable dt = new DataTable();

                                    da.Fill(dt);

                                    rptComplaints.DataSource = dt;

                                    rptComplaints.DataBind();
         }
     }
}
