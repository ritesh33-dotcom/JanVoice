using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace JanVoice
{
    public partial class IssueMap : System.Web.UI.Page
    {
        public DataTable dtComplaints = new DataTable();

        public string ComplaintJson = "[]";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComplaints();
                LoadStatistics();
                LoadCategories();
            }
        }
        private void LoadComplaints(string keyword = "", String category = "", String status = "")
        {
            string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT ComplaintID,
                               Title,
                               Description,
                               Latitude,
                               Longitude,
                               Landmark,
                               Status,
                               CreatedDate
                        FROM Complaints
                        WHERE
                        (@Keyword='' OR Title LIKE '%' + @Keyword + '%' OR Landmark LIKE '%' + @Keyword + '%')

                        AND

                        (@Category='' OR CategoryID=@Category)

                        AND

                        (@Status='' OR Status=@Status)";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                da.SelectCommand.Parameters.AddWithValue("@Keyword", keyword);
                da.SelectCommand.Parameters.AddWithValue("@Category", category);
                da.SelectCommand.Parameters.AddWithValue("@Status", status);

                da.Fill(dtComplaints);

                ComplaintJson = Newtonsoft.Json.JsonConvert.SerializeObject(dtComplaints);
            }
        }
        private void LoadStatistics()
        {
            string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(@"
            SELECT
                COUNT(*) AS TotalIssues,
                SUM(CASE WHEN Status='Resolved' THEN 1 ELSE 0 END) AS Resolved,
                SUM(CASE WHEN Status='In Progress' THEN 1 ELSE 0 END) AS InProgress,
                SUM(CASE WHEN Status='Pending' THEN 1 ELSE 0 END) AS Pending
            FROM Complaints", con);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblTotalIssues.Text = dr["TotalIssues"].ToString();
                    lblResolved.Text = dr["Resolved"].ToString();
                    lblProgress.Text = dr["InProgress"].ToString();
                    lblPending.Text = dr["Pending"].ToString();
                }

                dr.Close();
            }
        }

        private void LoadCategories()
        {
            string cs = ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT CategoryID, CategoryName FROM Categories", con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlCategory.DataSource = dt;

                ddlCategory.DataTextField = "CategoryName";

                ddlCategory.DataValueField = "CategoryID";

                ddlCategory.DataBind();

                ddlCategory.Items.Insert(0,
                    new ListItem("All Categories", ""));
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();

            string category = ddlCategory.SelectedValue;

            string status = ddlStatus.SelectedValue;

            LoadComplaints(keyword, category, status);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadComplaints(txtSearch.Text.Trim());
        }
    }
}
