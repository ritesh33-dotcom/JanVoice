using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace JanVoice.Admin
{
    public partial class UserDetails : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager
            .ConnectionStrings["JanVoiceDB"]
            .ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserDetails();
            }
        }


        // ==========================================
        // LOAD USER DETAILS
        // ==========================================

        private void LoadUserDetails()
        {
            int userID;

            // Get UserID from URL
            if (!int.TryParse(
                Request.QueryString["UserID"],
                out userID))
            {
                Response.Redirect("ManageUsers.aspx");
                return;
            }


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        U.UserID,
                        U.FullName,
                        U.Email,
                        U.Mobile,
                        U.Address,
                        U.IsActive,
                        U.CreatedDate,
                        W.WardName
                    FROM Users U

                    INNER JOIN Wards W
                        ON U.WardID = W.WardID

                    WHERE U.UserID = @UserID
                    AND U.RoleID = 1";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@UserID",
                        userID
                    );


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string fullName =
                                reader["FullName"].ToString();


                            // Basic information

                            lblUserID.Text =
                                reader["UserID"].ToString();


                            lblFullName.Text =
                                fullName;


                            lblName.Text =
                                fullName;


                            lblEmail.Text =
                                reader["Email"].ToString();


                            lblMobile.Text =
                                reader["Mobile"].ToString();


                            lblWard.Text =
                                reader["WardName"].ToString();


                            lblAddress.Text =
                                reader["Address"].ToString();


                            lblCreatedDate.Text =
                                Convert.ToDateTime(
                                    reader["CreatedDate"])
                                .ToString("dd MMM yyyy");


                            // Status

                            bool isActive =
                                Convert.ToBoolean(
                                    reader["IsActive"]);


                            lblStatus.Text =
                                isActive
                                ? "Active"
                                : "Inactive";


                            lblStatus.CssClass =
                                isActive
                                ? "user-status active"
                                : "user-status inactive";


                            // Avatar initials

                            lblInitials.Text =
                                GetInitials(fullName);
                        }
                        else
                        {
                            Response.Redirect(
                                "ManageUsers.aspx"
                            );

                            return;
                        }
                    }
                }
            }


            // Load complaints after user exists

            LoadComplaintHistory(userID);
        }



        // ==========================================
        // LOAD COMPLAINT HISTORY
        // ==========================================

        private void LoadComplaintHistory(int userID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        C.ComplaintID,
                        C.Title,
                        C.Status,
                        C.Priority,
                        C.CreatedDate,
                        CA.CategoryName

                    FROM Complaints C

                    INNER JOIN Categories CA
                        ON C.CategoryID = CA.CategoryID

                    WHERE C.UserID = @UserID

                    ORDER BY C.CreatedDate DESC";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@UserID",
                        userID
                    );


                    using (SqlDataAdapter da =
                           new SqlDataAdapter(cmd))
                    {
                        DataTable dt =
                            new DataTable();


                        da.Fill(dt);


                        gvComplaints.DataSource =
                            dt;

                        gvComplaints.DataBind();


                        lblComplaintCount.Text =
                            dt.Rows.Count.ToString();
                    }
                }
            }
        }



        // ==========================================
        // GET INITIALS
        // ==========================================

        private string GetInitials(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName))
                return "?";


            string[] parts =
                fullName.Trim().Split(' ');


            if (parts.Length == 1)
            {
                return parts[0]
                    .Substring(0, 1)
                    .ToUpper();
            }


            string first =
                parts[0]
                .Substring(0, 1);


            string last =
                parts[parts.Length - 1]
                .Substring(0, 1);


            return (
                first + last
            ).ToUpper();
        }
    }
}