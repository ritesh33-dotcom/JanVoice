using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace JanVoice.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        // Database connection
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadWards();
                LoadStatistics();
                LoadUsers();
            }
        }


        // ==========================================
        // LOAD WARDS
        // ==========================================

        private void LoadWards()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT WardID, WardName
                    FROM Wards
                    WHERE IsActive = 1
                    ORDER BY WardNumber";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlWard.DataSource = reader;
                        ddlWard.DataTextField = "WardName";
                        ddlWard.DataValueField = "WardID";

                        ddlWard.DataBind();
                    }
                }
            }

            // Add default option
            ddlWard.Items.Insert(0, new System.Web.UI.WebControls.ListItem(
                "All Wards", ""
            ));
        }


        // ==========================================
        // LOAD STATISTICS
        // ==========================================

        private void LoadStatistics()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        COUNT(*) AS TotalUsers,

                        SUM(CASE
                            WHEN IsActive = 1 THEN 1
                            ELSE 0
                        END) AS ActiveUsers,

                        SUM(CASE
                            WHEN IsActive = 0 THEN 1
                            ELSE 0
                        END) AS InactiveUsers,

                        SUM(CASE
                            WHEN CreatedDate >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
                            THEN 1
                            ELSE 0
                        END) AS RegisteredThisMonth

                    FROM Users

                    WHERE RoleID = 1;";


                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalUsers.Text =
                                reader["TotalUsers"].ToString();

                            lblActiveUsers.Text =
                                reader["ActiveUsers"].ToString();

                            lblInactiveUsers.Text =
                                reader["InactiveUsers"].ToString();

                            lblRegisteredThisMonth.Text =
                                reader["RegisteredThisMonth"].ToString();
                        }
                    }
                }
            }
        }


        // ==========================================
        // LOAD USERS
        // ==========================================

        private void LoadUsers()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT
                U.UserID,
                U.FullName,
                U.Email,
                U.Mobile,
                U.IsActive,
                U.CreatedDate,

                W.WardName,

                COUNT(C.ComplaintID) AS ComplaintCount

            FROM Users U

            INNER JOIN Wards W
                ON U.WardID = W.WardID

            LEFT JOIN Complaints C
                ON U.UserID = C.UserID

            WHERE U.RoleID = 1

            AND
            (
                @Search = ''
                OR U.FullName LIKE '%' + @Search + '%'
                OR U.Email LIKE '%' + @Search + '%'
            )

            AND
            (
                @WardID = ''
                OR U.WardID = CAST(@WardID AS INT)
            )

            AND
            (
                @Status = ''
                OR U.IsActive = CAST(@Status AS BIT)
            )

            GROUP BY
                U.UserID,
                U.FullName,
                U.Email,
                U.Mobile,
                U.IsActive,
                U.CreatedDate,
                W.WardName

            ORDER BY U.CreatedDate DESC;
        ";


                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Search
                    cmd.Parameters.AddWithValue(
                        "@Search",
                        txtSearch.Text.Trim()
                    );


                    // Ward
                    cmd.Parameters.AddWithValue(
                        "@WardID",
                        ddlWard.SelectedValue
                    );


                    // Status
                    cmd.Parameters.AddWithValue(
                        "@Status",
                        ddlStatus.SelectedValue
                    );


                    con.Open();


                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();

                        dt.Load(reader);


                        // Bind filtered users
                        rptUsers.DataSource = dt;
                        rptUsers.DataBind();


                        // Update record count
                        lblRecordCount.Text =
                            dt.Rows.Count.ToString();
                    }
                }
            }
        }


        // ==========================================
        // GET USER INITIALS
        // ==========================================

        protected string GetInitials(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName))
                return "?";

            string[] nameParts =
                fullName.Trim().Split(' ');

            if (nameParts.Length == 1)
                return nameParts[0].Substring(0, 1).ToUpper();

            string first =
                nameParts[0].Substring(0, 1);

            string last =
                nameParts[nameParts.Length - 1]
                .Substring(0, 1);

            return (first + last).ToUpper();
        }


        // ==========================================
        // APPLY FILTERS
        // ==========================================

        protected void btnApplyFilters_Click(
            object sender,
            EventArgs e)
        {
            // Filtering will be added in Part 4.
            LoadUsers();
        }
    }
}