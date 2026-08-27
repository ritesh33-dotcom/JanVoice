using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class ManageOfficers : System.Web.UI.Page
    {
        // ==========================================
        // DATABASE CONNECTION
        // ==========================================

        private readonly string connectionString =
            ConfigurationManager
            .ConnectionStrings["JanVoiceDB"]
            .ConnectionString;



        // ==========================================
        // PAGE LOAD
        // ==========================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadWards();
                LoadOfficerWards();

                LoadStatistics();
                LoadOfficers();
            }
        }



        // ==========================================
        // LOAD WARDS
        // ==========================================

        private void LoadWards()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        WardID,
                        WardName
                    FROM Wards
                    WHERE IsActive = 1
                    ORDER BY WardNumber;
                ";

                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        ddlWard.DataSource = reader;

                        ddlWard.DataTextField =
                            "WardName";

                        ddlWard.DataValueField =
                            "WardID";

                        ddlWard.DataBind();
                    }
                }
            }

            ddlWard.Items.Insert(
                0,
                new ListItem(
                    "All Wards",
                    ""
                )
            );
        }



        // ==========================================
        // LOAD WARDS FOR ADD OFFICER
        // ==========================================

        private void LoadOfficerWards()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        WardID,
                        WardName
                    FROM Wards
                    WHERE IsActive = 1
                    ORDER BY WardNumber;
                ";

                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        ddlOfficerWard.DataSource = reader;

                        ddlOfficerWard.DataTextField =
                            "WardName";

                        ddlOfficerWard.DataValueField =
                            "WardID";

                        ddlOfficerWard.DataBind();
                    }
                }
            }

            ddlOfficerWard.Items.Insert(
                0,
                new ListItem(
                    "Select Ward",
                    ""
                )
            );
        }



        // ==========================================
        // LOAD STATISTICS
        // ==========================================

        private void LoadStatistics()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        COUNT(*) AS TotalOfficers,

                        COALESCE(
                            SUM(
                                CASE
                                    WHEN IsActive = 1
                                    THEN 1
                                    ELSE 0
                                END
                            ), 0
                        ) AS ActiveOfficers,

                        COALESCE(
                            SUM(
                                CASE
                                    WHEN IsActive = 0
                                    THEN 1
                                    ELSE 0
                                END
                            ), 0
                        ) AS InactiveOfficers

                    FROM Users

                    WHERE RoleID = 2;


                    SELECT

                        COUNT(*) AS ActiveComplaints

                    FROM Complaints

                    WHERE AssignedOfficerID IS NOT NULL

                    AND Status NOT IN
                    (
                        'Resolved',
                        'Closed'
                    );

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalOfficers.Text =
                                reader["TotalOfficers"]
                                .ToString();

                            lblActiveOfficers.Text =
                                reader["ActiveOfficers"]
                                .ToString();

                            lblInactiveOfficers.Text =
                                reader["InactiveOfficers"]
                                .ToString();
                        }


                        if (reader.NextResult())
                        {
                            if (reader.Read())
                            {
                                lblActiveComplaints.Text =
                                    reader["ActiveComplaints"]
                                    .ToString();
                            }
                        }
                    }
                }
            }
        }



        // ==========================================
        // LOAD OFFICERS
        // ==========================================

        private void LoadOfficers()
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
                        U.IsActive,
                        U.CreatedDate,

                        W.WardName,

                        COUNT(
                            CASE
                                WHEN C.Status NOT IN
                                (
                                    'Resolved',
                                    'Closed'
                                )
                                THEN C.ComplaintID
                            END
                        ) AS ActiveComplaintCount

                    FROM Users U

                    INNER JOIN Wards W
                        ON U.WardID = W.WardID

                    LEFT JOIN Complaints C
                        ON U.UserID =
                           C.AssignedOfficerID

                    WHERE U.RoleID = 2


                    AND
                    (
                        @Search = ''

                        OR U.FullName LIKE
                           '%' + @Search + '%'

                        OR U.Email LIKE
                           '%' + @Search + '%'
                    )


                    AND
                    (
                        @WardID = ''

                        OR U.WardID =
                           CAST(@WardID AS INT)
                    )


                    AND
                    (
                        @Status = ''

                        OR U.IsActive =
                           CAST(@Status AS BIT)
                    )


                    GROUP BY

                        U.UserID,
                        U.FullName,
                        U.Email,
                        U.Mobile,
                        U.IsActive,
                        U.CreatedDate,
                        W.WardName


                    ORDER BY
                        U.CreatedDate DESC;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@Search",
                        SqlDbType.NVarChar,
                        100
                    ).Value =
                        txtSearch.Text.Trim();


                    cmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.NVarChar,
                        20
                    ).Value =
                        ddlWard.SelectedValue;


                    cmd.Parameters.Add(
                        "@Status",
                        SqlDbType.NVarChar,
                        10
                    ).Value =
                        ddlStatus.SelectedValue;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        DataTable dt =
                            new DataTable();

                        dt.Load(reader);


                        rptOfficers.DataSource =
                            dt;

                        rptOfficers.DataBind();


                        lblRecordCount.Text =
                            dt.Rows.Count.ToString();


                        // Show empty state

                        phEmpty.Visible =
                            dt.Rows.Count == 0;
                    }
                }
            }
        }



        // ==========================================
        // GET INITIALS
        // ==========================================

        protected string GetInitials(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName))
                return "?";


            string[] nameParts =
                fullName
                .Trim()
                .Split(
                    new char[] { ' ' },
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



        // ==========================================
        // APPLY FILTERS
        // ==========================================

        protected void btnApplyFilters_Click(
            object sender,
            EventArgs e)
        {
            LoadOfficers();
        }



        // ==========================================
        // ADD NEW OFFICER
        // ==========================================

        protected void btnAddOfficer_Click(
            object sender,
            EventArgs e)
        {
            if (!Page.IsValid)
                return;


            string fullName =
                txtOfficerName.Text.Trim();

            string email =
                txtOfficerEmail.Text.Trim();

            string phone =
                txtOfficerPhone.Text.Trim();

            string password =
                txtOfficerPassword.Text;

            int wardID;


            if (!int.TryParse(
                ddlOfficerWard.SelectedValue,
                out wardID))
            {
                ShowMessage(
                    "Please select a valid ward.",
                    false
                );

                return;
            }


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // ======================================
                // CHECK EMAIL
                // ======================================

                string checkQuery = @"

                    SELECT COUNT(*)

                    FROM Users

                    WHERE Email = @Email;

                ";


                using (SqlCommand checkCmd =
                       new SqlCommand(
                           checkQuery,
                           con))
                {
                    checkCmd.Parameters.Add(
                        "@Email",
                        SqlDbType.NVarChar,
                        150
                    ).Value = email;


                    int existingUser =
                        Convert.ToInt32(
                            checkCmd.ExecuteScalar()
                        );


                    if (existingUser > 0)
                    {
                        ShowMessage(
                            "An account with this email already exists.",
                            false
                        );

                        return;
                    }
                }



                // ======================================
                // HASH PASSWORD
                // ======================================

                string passwordHash =
                    HashPassword(password);



                // ======================================
                // INSERT OFFICER
                // ======================================

                string insertQuery = @"

                    INSERT INTO Users
                    (
                        FullName,
                        Email,
                        Mobile,
                        PasswordHash,
                        RoleID,
                        WardID,
                        IsActive,
                        CreatedDate
                    )

                    VALUES
                    (
                        @FullName,
                        @Email,
                        @Phone,
                        @Password,
                        2,
                        @WardID,
                        1,
                        GETDATE()
                    );

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           insertQuery,
                           con))
                {
                    cmd.Parameters.Add(
                        "@FullName",
                        SqlDbType.NVarChar,
                        150
                    ).Value = fullName;


                    cmd.Parameters.Add(
                        "@Email",
                        SqlDbType.NVarChar,
                        150
                    ).Value = email;


                    cmd.Parameters.Add(
                        "@Phone",
                        SqlDbType.NVarChar,
                        20
                    ).Value =
                        string.IsNullOrWhiteSpace(phone)
                        ? (object)DBNull.Value
                        : phone;


                    cmd.Parameters.Add(
                        "@Password",
                        SqlDbType.NVarChar,
                        500
                    ).Value = passwordHash;


                    cmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value = wardID;


                    cmd.ExecuteNonQuery();
                }
            }


            // Clear form

            ClearOfficerForm();


            ShowMessage(
                "Officer account created successfully.",
                true
            );


            LoadStatistics();
            LoadOfficers();
        }



        // ==========================================
        // PASSWORD HASHING
        // ==========================================

        private string HashPassword(
            string password)
        {
            using (SHA256 sha256 =
                   SHA256.Create())
            {
                byte[] bytes =
                    Encoding.UTF8.GetBytes(password);


                byte[] hash =
                    sha256.ComputeHash(bytes);


                StringBuilder builder =
                    new StringBuilder();


                foreach (byte b in hash)
                {
                    builder.Append(
                        b.ToString("x2")
                    );
                }


                return builder.ToString();
            }
        }



        // ==========================================
        // REPEATER ACTIONS
        // ==========================================

        protected void rptOfficers_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            int userID;


            if (!int.TryParse(
                e.CommandArgument.ToString(),
                out userID))
            {
                return;
            }



            // ======================================
            // TOGGLE STATUS
            // ======================================

            if (e.CommandName ==
                "ToggleStatus")
            {
                ToggleOfficerStatus(userID);

                LoadStatistics();
                LoadOfficers();

                return;
            }



            // ======================================
            // DELETE OFFICER
            // ======================================

            if (e.CommandName ==
                "DeleteOfficer")
            {
                DeleteOfficer(userID);

                LoadStatistics();
                LoadOfficers();

                return;
            }
        }



        // ==========================================
        // ACTIVATE / DEACTIVATE
        // ==========================================

        private void ToggleOfficerStatus(
            int userID)
        {
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
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@UserID",
                        SqlDbType.Int
                    ).Value = userID;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }



        // ==========================================
        // DELETE OFFICER
        // ==========================================

        private void DeleteOfficer(
            int userID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // ======================================
                // CHECK ASSIGNED COMPLAINTS
                // ======================================

                string checkQuery = @"

                    SELECT COUNT(*)

                    FROM Complaints

                    WHERE AssignedOfficerID =
                          @UserID;

                ";


                using (SqlCommand checkCmd =
                       new SqlCommand(
                           checkQuery,
                           con))
                {
                    checkCmd.Parameters.Add(
                        "@UserID",
                        SqlDbType.Int
                    ).Value = userID;


                    int complaintCount =
                        Convert.ToInt32(
                            checkCmd.ExecuteScalar()
                        );


                    if (complaintCount > 0)
                    {
                        ShowMessage(
                            "This officer cannot be deleted because complaints are assigned to this account. Deactivate the officer instead.",
                            false
                        );

                        return;
                    }
                }



                // ======================================
                // DELETE
                // ======================================

                try
                {
                    string deleteQuery = @"

                        DELETE FROM Users

                        WHERE UserID = @UserID

                        AND RoleID = 2;

                    ";


                    using (SqlCommand cmd =
                           new SqlCommand(
                               deleteQuery,
                               con))
                    {
                        cmd.Parameters.Add(
                            "@UserID",
                            SqlDbType.Int
                        ).Value = userID;


                        int rows =
                            cmd.ExecuteNonQuery();


                        if (rows > 0)
                        {
                            ShowMessage(
                                "Officer account deleted successfully.",
                                true
                            );
                        }
                        else
                        {
                            ShowMessage(
                                "Officer account could not be deleted.",
                                false
                            );
                        }
                    }
                }
                catch (SqlException)
                {
                    ShowMessage(
                        "This officer cannot be deleted because the account is referenced by other records. Deactivate the officer instead.",
                        false
                    );
                }
            }
        }



        // ==========================================
        // CLEAR ADD OFFICER FORM
        // ==========================================

        private void ClearOfficerForm()
        {
            txtOfficerName.Text = "";
            txtOfficerEmail.Text = "";
            txtOfficerPhone.Text = "";

            txtOfficerPassword.Text = "";
            txtOfficerConfirmPassword.Text = "";

            if (ddlOfficerWard.Items.Count > 0)
            {
                ddlOfficerWard.SelectedIndex = 0;
            }
        }



        // ==========================================
        // SHOW MESSAGE
        // ==========================================

        private void ShowMessage(
            string message,
            bool success)
        {
            pnlMessage.Visible = true;

            lblMessage.Text = message;


            if (success)
            {
                pnlMessage.CssClass =
                    "officer-message success";
            }
            else
            {
                pnlMessage.CssClass =
                    "officer-message error";
            }
        }
    }
}