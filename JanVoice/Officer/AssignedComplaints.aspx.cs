using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Officer
{
    public partial class AssignedComplaints : System.Web.UI.Page
    {
        string connectionString =
    ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                CheckLogin();

                LoadAssignedComplaints();

                SearchAssignedComplaints();

            }

        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchAssignedComplaints();
        }


        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";

            ddlStatus.SelectedIndex = 0;

            ddlPriority.SelectedIndex = 0;

            LoadAssignedComplaints();
        }


        protected void gvAssignedComplaints_PageIndexChanging(
    object sender,
    GridViewPageEventArgs e)
{
    gvAssignedComplaints.PageIndex = e.NewPageIndex;

    SearchAssignedComplaints();
}



        private void CheckLogin()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }
        private void LoadAssignedComplaints()
        {
            int officerID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                        SELECT
                        C.ComplaintID,
                        C.Title,
                        C.Description,
                        U.FullName AS CitizenName,
                        CAT.CategoryName,
                        W.WardName,
                        C.Priority,
                        C.Status,
                        C.CreatedDate
                    FROM Complaints C

                    INNER JOIN Users U
                        ON C.UserID = U.UserID

                    INNER JOIN Categories CAT
                        ON C.CategoryID = CAT.CategoryID

                    INNER JOIN Wards W
                        ON C.WardID = W.WardID
                    

                    WHERE C.AssignedOfficerID = @OfficerID

                    ORDER BY C.CreatedDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@OfficerID", SqlDbType.Int).Value = officerID;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        gvAssignedComplaints.DataSource = dt;
                        gvAssignedComplaints.DataBind();
                    }
                }
            }
        }
        private void SearchAssignedComplaints()
        {
            int officerID = Convert.ToInt32(Session["UserID"]);

            string searchText = txtSearch.Text.Trim();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT
                C.ComplaintID,
                C.Title,
                C.Description,
                U.FullName AS CitizenName,
                CAT.CategoryName,
                W.WardName,
                C.Priority,
                C.Status,
                C.CreatedDate

            FROM Complaints C

            INNER JOIN Users U
                ON C.UserID = U.UserID

            INNER JOIN Categories CAT
                ON C.CategoryID = CAT.CategoryID

            INNER JOIN Wards W
                ON C.WardID = W.WardID

            WHERE C.AssignedOfficerID = @OfficerID

            AND
            (
                @Search = ''
                OR CAST(C.ComplaintID AS VARCHAR(20)) LIKE @SearchLike
                OR C.Title LIKE @SearchLike
            )

            AND
            (
                @Status = ''
                OR C.Status = @Status
            )

            AND
            (
                @Priority = ''
                OR C.Priority = @Priority
            )

            ORDER BY C.CreatedDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@OfficerID", SqlDbType.Int)
                        .Value = officerID;

                    cmd.Parameters.Add("@Search", SqlDbType.NVarChar, 200)
                        .Value = searchText;

                    cmd.Parameters.Add("@SearchLike", SqlDbType.NVarChar, 200)
                        .Value = "%" + searchText + "%";

                    cmd.Parameters.Add("@Status", SqlDbType.NVarChar, 50)
                        .Value = ddlStatus.SelectedValue;

                    cmd.Parameters.Add("@Priority", SqlDbType.NVarChar, 50)
                        .Value = ddlPriority.SelectedValue;

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        gvAssignedComplaints.DataSource = dt;

                        gvAssignedComplaints.DataBind();
                    }
                }
            }
        }


    }
}