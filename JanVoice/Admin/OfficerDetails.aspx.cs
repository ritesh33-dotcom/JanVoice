using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class OfficerDetails : System.Web.UI.Page
    {
        // ==========================================
        // DATABASE CONNECTION
        // ==========================================

        private readonly string connectionString =
            ConfigurationManager
            .ConnectionStrings["JanVoiceDB"]
            .ConnectionString;



        // ==========================================
        // OFFICER ID
        // ==========================================

        private int OfficerID
        {
            get
            {
                int userID;

                if (int.TryParse(
                    Request.QueryString["UserID"],
                    out userID))
                {
                    return userID;
                }

                return 0;
            }
        }



        // ==========================================
        // PAGE LOAD
        // ==========================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (OfficerID <= 0)
                {
                    Response.Redirect(
                        "ManageOfficers.aspx"
                    );

                    return;
                }

                LoadOfficerDetails();
                LoadComplaintStatistics();
                LoadAssignedComplaints();
            }
        }



        // ==========================================
        // LOAD OFFICER DETAILS
        // ==========================================

        private void LoadOfficerDetails()
        {
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

                    AND U.RoleID = 2;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@UserID",
                        OfficerID
                    );

                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            Response.Redirect(
                                "ManageOfficers.aspx"
                            );

                            return;
                        }


                        // ==================================
                        // BASIC INFORMATION
                        // ==================================

                        string fullName =
                            reader["FullName"].ToString();

                        bool isActive =
                            Convert.ToBoolean(
                                reader["IsActive"]
                            );


                        lblUserID.Text =
                            reader["UserID"].ToString();

                        lblFullName.Text =
                            fullName;

                        lblInfoName.Text =
                            fullName;

                        lblEmail.Text =
                            reader["Email"].ToString();

                        lblMobile.Text =
                            reader["Mobile"].ToString();

                        lblWard.Text =
                            reader["WardName"].ToString();


                        // Address

                        if (reader["Address"] != DBNull.Value &&
                            !string.IsNullOrWhiteSpace(
                                reader["Address"].ToString()))
                        {
                            lblAddress.Text =
                                reader["Address"].ToString();
                        }
                        else
                        {
                            lblAddress.Text =
                                "Not provided";
                        }


                        // Created date

                        lblCreatedDate.Text =
                            Convert.ToDateTime(
                                reader["CreatedDate"]
                            ).ToString(
                                "dd MMM yyyy"
                            );


                        // Initials

                        lblInitials.Text =
                            GetInitials(fullName);


                        // ==================================
                        // STATUS
                        // ==================================

                        SetStatus(
                            isActive
                        );
                    }
                }
            }
        }



        // ==========================================
        // LOAD COMPLAINT STATISTICS
        // ==========================================

        private void LoadComplaintStatistics()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        COUNT(*) AS TotalComplaints,

                        SUM(
                            CASE
                                WHEN Status NOT IN
                                (
                                    'Resolved',
                                    'Closed'
                                )
                                THEN 1
                                ELSE 0
                            END
                        ) AS ActiveComplaints,

                        SUM(
                            CASE
                                WHEN Status = 'Resolved'
                                THEN 1
                                ELSE 0
                            END
                        ) AS ResolvedComplaints

                    FROM Complaints

                    WHERE AssignedOfficerID = @OfficerID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@OfficerID",
                        OfficerID
                    );

                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalComplaints.Text =
                                reader["TotalComplaints"]
                                .ToString();

                            lblActiveComplaints.Text =
                                reader["ActiveComplaints"]
                                .ToString();

                            lblResolvedComplaints.Text =
                                reader["ResolvedComplaints"]
                                .ToString();
                        }
                    }
                }
            }
        }



        // ==========================================
        // LOAD ASSIGNED COMPLAINTS
        // ==========================================

        private void LoadAssignedComplaints()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT TOP 10

                        C.ComplaintID,
                        C.Title,
                        C.Status,
                        C.Priority,
                        C.CreatedDate,

                        Cat.CategoryName

                    FROM Complaints C

                    INNER JOIN Categories Cat
                        ON C.CategoryID =
                           Cat.CategoryID

                    WHERE C.AssignedOfficerID =
                          @OfficerID

                    ORDER BY
                        C.CreatedDate DESC;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@OfficerID",
                        OfficerID
                    );

                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        DataTable dt =
                            new DataTable();

                        dt.Load(reader);


                        rptComplaints.DataSource =
                            dt;

                        rptComplaints.DataBind();


                        lblComplaintCount.Text =
                            dt.Rows.Count.ToString();
                    }
                }
            }
        }



        // ==========================================
        // SET ACCOUNT STATUS
        // ==========================================

        private void SetStatus(bool isActive)
        {
            if (isActive)
            {
                lblStatus.Text =
                    "Active";

                lblStatus.CssClass =
                    "detail-status active";

                lblAccountStatus.Text =
                    "Active";

                lblAccountStatus.CssClass =
                    "mini-status active";

                btnToggleStatus.Text =
                    "Deactivate Officer";

                btnToggleStatus.CssClass =
                    "toggle-status-btn deactivate";
            }
            else
            {
                lblStatus.Text =
                    "Inactive";

                lblStatus.CssClass =
                    "detail-status inactive";

                lblAccountStatus.Text =
                    "Inactive";

                lblAccountStatus.CssClass =
                    "mini-status inactive";

                btnToggleStatus.Text =
                    "Activate Officer";

                btnToggleStatus.CssClass =
                    "toggle-status-btn activate";
            }
        }



        // ==========================================
        // ACTIVATE / DEACTIVATE
        // ==========================================

        protected void btnToggleStatus_Click(
            object sender,
            EventArgs e)
        {
            if (OfficerID <= 0)
            {
                Response.Redirect(
                    "ManageOfficers.aspx"
                );

                return;
            }


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    UPDATE Users

                    SET IsActive =
                        CASE
                            WHEN IsActive = 1
                            THEN 0
                            ELSE 1
                        END

                    WHERE UserID = @UserID

                    AND RoleID = 2;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@UserID",
                        OfficerID
                    );

                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }


            // Reload complete page data

            LoadOfficerDetails();
            LoadComplaintStatistics();
            LoadAssignedComplaints();
        }



        // ==========================================
        // GET INITIALS
        // ==========================================

        protected string GetInitials(
            string fullName)
        {
            if (string.IsNullOrWhiteSpace(
                fullName))
            {
                return "?";
            }


            string[] nameParts =
                fullName.Trim().Split(
                    new[] { ' ' },
                    StringSplitOptions.RemoveEmptyEntries
                );


            if (nameParts.Length == 1)
            {
                return nameParts[0]
                    .Substring(0, 1)
                    .ToUpper();
            }


            string first =
                nameParts[0]
                .Substring(0, 1);


            string last =
                nameParts[nameParts.Length - 1]
                .Substring(0, 1);


            return (
                first + last
            ).ToUpper();
        }
    }
}