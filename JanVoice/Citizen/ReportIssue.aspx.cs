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
    }
}