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
    public partial class MyComplaints : System.Web.UI.Page
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
                LoadComplaints();
            }

        }

        private void LoadComplaints()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"

                            SELECT

                            C.ComplaintID,
                            C.Title,
                            C.Status,
                            C.Priority,
                            C.CreatedDate,

                            CAT.CategoryName,
                            W.WardName,

                            ISNULL(
                            (
                            SELECT TOP 1 ImagePath
                            FROM ComplaintImages
                            WHERE ComplaintID = C.ComplaintID
                            ORDER BY ImageID DESC
                            ),
                            '~/Images/no-image.png'
                            ) AS ImagePath

                            FROM Complaints C

                            INNER JOIN Categories CAT
                            ON C.CategoryID = CAT.CategoryID

                            INNER JOIN Wards W
                            ON C.WardID = W.WardID

                            WHERE C.UserID = @UserID

                            ORDER BY C.CreatedDate DESC";



                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@UserID",
                    Convert.ToInt32(Session["UserID"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptComplaints.DataSource = dt;
                    rptComplaints.DataBind();

                    divNoComplaint.Visible = false;
                }
                else
                {
                    rptComplaints.DataSource = null;
                    rptComplaints.DataBind();

                    divNoComplaint.Visible = true;
                }

            }
        }

        protected void btnView_Command(object sender, CommandEventArgs e)
        {
            int complaintID = Convert.ToInt32(e.CommandArgument);

            Response.Redirect(
                "ComplaintDetails.aspx?id=" + complaintID);
        }
    }
}