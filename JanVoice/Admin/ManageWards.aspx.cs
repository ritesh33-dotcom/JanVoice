using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class ManageWards : System.Web.UI.Page
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
                LoadStatistics();
                LoadWards();
            }
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

                        COUNT(*) AS TotalWards,

                        SUM(
                            CASE
                                WHEN IsActive = 1
                                THEN 1
                                ELSE 0
                            END
                        ) AS ActiveWards

                    FROM Wards;


                    SELECT
                        COUNT(DISTINCT U.UserID)
                            AS AssignedOfficers

                    FROM Users U

                    INNER JOIN Roles R
                        ON U.RoleID = R.RoleID

                    WHERE
                        R.RoleName = 'Officer'
                        AND U.WardID IS NOT NULL;


                    SELECT
                        COUNT(*) AS TotalComplaints

                    FROM Complaints;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        // -----------------------------
                        // WARD STATISTICS
                        // -----------------------------

                        if (reader.Read())
                        {
                            lblTotalWards.Text =
                                reader["TotalWards"]
                                .ToString();

                            lblActiveWards.Text =
                                reader["ActiveWards"]
                                .ToString();
                        }


                        // -----------------------------
                        // OFFICERS
                        // -----------------------------

                        if (reader.NextResult())
                        {
                            if (reader.Read())
                            {
                                lblAssignedOfficers.Text =
                                    reader["AssignedOfficers"]
                                    .ToString();
                            }
                        }


                        // -----------------------------
                        // COMPLAINTS
                        // -----------------------------

                        if (reader.NextResult())
                        {
                            if (reader.Read())
                            {
                                lblTotalComplaints.Text =
                                    reader["TotalComplaints"]
                                    .ToString();
                            }
                        }
                    }
                }
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

                        W.WardID,
                        W.WardNumber,
                        W.WardName,
                        W.Description,
                        W.IsActive,
                        W.CreatedDate,

                        COUNT(
                            DISTINCT
                            CASE
                                WHEN R.RoleName = 'Officer'
                                THEN U.UserID
                            END
                        ) AS OfficerCount,

                        COUNT(
                            DISTINCT C.ComplaintID
                        ) AS ComplaintCount

                    FROM Wards W

                    LEFT JOIN Users U
                        ON W.WardID = U.WardID

                    LEFT JOIN Roles R
                        ON U.RoleID = R.RoleID

                    LEFT JOIN Complaints C
                        ON W.WardID = C.WardID

                    WHERE

                    (
                        @Search = ''

                        OR W.WardName LIKE
                           '%' + @Search + '%'

                        OR CAST(W.WardNumber AS NVARCHAR(20))
                           LIKE '%' + @Search + '%'
                    )

                    AND

                    (
                        @Status = ''

                        OR W.IsActive =
                           CAST(@Status AS BIT)
                    )

                    GROUP BY

                        W.WardID,
                        W.WardNumber,
                        W.WardName,
                        W.Description,
                        W.IsActive,
                        W.CreatedDate

                    ORDER BY
                        W.WardNumber ASC;

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


                        rptWards.DataSource =
                            dt;

                        rptWards.DataBind();


                        lblRecordCount.Text =
                            dt.Rows.Count.ToString();


                        pnlEmpty.Visible =
                            dt.Rows.Count == 0;
                    }
                }
            }
        }



        // ==========================================
        // ADD WARD
        // ==========================================

        protected void btnAddWard_Click(
            object sender,
            EventArgs e)
        {
            ClearWardForm();


            lblModalTitle.Text =
                "Add New Ward";


            btnSaveWard.Text =
                "Save Ward";


            wardStatusGroup.Visible =
                false;


            pnlWardModal.Visible =
                true;
        }



        // ==========================================
        // CLEAR WARD FORM
        // ==========================================

        private void ClearWardForm()
        {
            hfWardID.Value =
                "0";


            txtWardNumber.Text =
                "";


            txtWardName.Text =
                "";


            txtWardDescription.Text =
                "";


            ddlModalStatus.SelectedValue =
                "1";
        }



        // ==========================================
        // EDIT / VIEW / TOGGLE / DELETE
        // ==========================================

        protected void rptWards_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            int wardID;


            if (!int.TryParse(
                e.CommandArgument.ToString(),
                out wardID))
            {
                return;
            }


            switch (e.CommandName)
            {
                case "EditWard":

                    OpenEditWard(wardID);

                    break;


                case "ViewWard":

                    OpenViewWard(wardID);

                    break;


                case "ToggleWard":

                    ToggleWard(wardID);

                    break;


                case "DeleteWard":

                    DeleteWard(wardID);

                    break;
            }
        }



        // ==========================================
        // OPEN EDIT WARD
        // ==========================================

        private void OpenEditWard(
            int wardID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        WardID,
                        WardNumber,
                        WardName,
                        Description,
                        IsActive

                    FROM Wards

                    WHERE WardID = @WardID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value =
                        wardID;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfWardID.Value =
                                reader["WardID"]
                                .ToString();


                            txtWardNumber.Text =
                                reader["WardNumber"]
                                .ToString();


                            txtWardName.Text =
                                reader["WardName"]
                                .ToString();


                            txtWardDescription.Text =
                                reader["Description"] ==
                                DBNull.Value
                                ? ""
                                : reader["Description"]
                                  .ToString();


                            ddlModalStatus.SelectedValue =
                                Convert.ToBoolean(
                                    reader["IsActive"]
                                )
                                ? "1"
                                : "0";


                            lblModalTitle.Text =
                                "Edit Ward";


                            btnSaveWard.Text =
                                "Update Ward";


                            wardStatusGroup.Visible =
                                true;


                            pnlWardModal.Visible =
                                true;
                        }
                    }
                }
            }
        }



        // ==========================================
        // SAVE / UPDATE WARD
        // ==========================================

        protected void btnSaveWard_Click(
            object sender,
            EventArgs e)
        {
            string wardNumberText =
                txtWardNumber.Text.Trim();


            string wardName =
                txtWardName.Text.Trim();


            string description =
                txtWardDescription.Text.Trim();



            // ==================================
            // VALIDATE WARD NUMBER
            // ==================================

            int wardNumber;


            if (!int.TryParse(
                wardNumberText,
                out wardNumber))
            {
                ShowMessage(
                    "Please enter a valid ward number.",
                    false
                );


                pnlWardModal.Visible =
                    true;


                return;
            }


            if (wardNumber <= 0)
            {
                ShowMessage(
                    "Ward number must be greater than 0.",
                    false
                );


                pnlWardModal.Visible =
                    true;


                return;
            }



            // ==================================
            // VALIDATE WARD NAME
            // ==================================

            if (string.IsNullOrWhiteSpace(
                wardName))
            {
                ShowMessage(
                    "Please enter a ward name.",
                    false
                );


                pnlWardModal.Visible =
                    true;


                return;
            }


            if (wardName.Length < 3)
            {
                ShowMessage(
                    "Ward name must contain at least 3 characters.",
                    false
                );


                pnlWardModal.Visible =
                    true;


                return;
            }



            int wardID =
                Convert.ToInt32(
                    hfWardID.Value
                );



            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // ==================================
                // ADD
                // ==================================

                if (wardID == 0)
                {
                    string checkQuery = @"

                        SELECT COUNT(*)

                        FROM Wards

                        WHERE WardNumber =
                              @WardNumber;

                    ";


                    using (SqlCommand checkCmd =
                           new SqlCommand(
                               checkQuery,
                               con))
                    {
                        checkCmd.Parameters.Add(
                            "@WardNumber",
                            SqlDbType.Int
                        ).Value =
                            wardNumber;


                        int exists =
                            Convert.ToInt32(
                                checkCmd.ExecuteScalar()
                            );


                        if (exists > 0)
                        {
                            ShowMessage(
                                "A ward with this ward number already exists.",
                                false
                            );


                            pnlWardModal.Visible =
                                true;


                            return;
                        }
                    }



                    // -----------------------------
                    // INSERT
                    // -----------------------------

                    string insertQuery = @"

                        INSERT INTO Wards
                        (
                            WardNumber,
                            WardName,
                            Description,
                            IsActive,
                            CreatedDate
                        )

                        VALUES
                        (
                            @WardNumber,
                            @WardName,
                            @Description,
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
                            "@WardNumber",
                            SqlDbType.Int
                        ).Value =
                            wardNumber;


                        cmd.Parameters.Add(
                            "@WardName",
                            SqlDbType.NVarChar,
                            100
                        ).Value =
                            wardName;


                        cmd.Parameters.Add(
                            "@Description",
                            SqlDbType.NVarChar,
                            250
                        ).Value =
                            string.IsNullOrWhiteSpace(
                                description)
                            ? (object)DBNull.Value
                            : description;


                        cmd.ExecuteNonQuery();
                    }


                    pnlWardModal.Visible =
                        false;


                    ShowMessage(
                        "Ward added successfully.",
                        true
                    );
                }



                // ==================================
                // UPDATE
                // ==================================

                else
                {
                    string checkQuery = @"

                        SELECT COUNT(*)

                        FROM Wards

                        WHERE

                            WardNumber =
                            @WardNumber

                        AND WardID <> @WardID;

                    ";


                    using (SqlCommand checkCmd =
                           new SqlCommand(
                               checkQuery,
                               con))
                    {
                        checkCmd.Parameters.Add(
                            "@WardNumber",
                            SqlDbType.Int
                        ).Value =
                            wardNumber;


                        checkCmd.Parameters.Add(
                            "@WardID",
                            SqlDbType.Int
                        ).Value =
                            wardID;


                        int exists =
                            Convert.ToInt32(
                                checkCmd.ExecuteScalar()
                            );


                        if (exists > 0)
                        {
                            ShowMessage(
                                "Another ward with this ward number already exists.",
                                false
                            );


                            pnlWardModal.Visible =
                                true;


                            return;
                        }
                    }



                    string updateQuery = @"

                        UPDATE Wards

                        SET

                            WardNumber =
                                @WardNumber,

                            WardName =
                                @WardName,

                            Description =
                                @Description,

                            IsActive =
                                @IsActive

                        WHERE WardID =
                              @WardID;

                    ";


                    using (SqlCommand cmd =
                           new SqlCommand(
                               updateQuery,
                               con))
                    {
                        cmd.Parameters.Add(
                            "@WardNumber",
                            SqlDbType.Int
                        ).Value =
                            wardNumber;


                        cmd.Parameters.Add(
                            "@WardName",
                            SqlDbType.NVarChar,
                            100
                        ).Value =
                            wardName;


                        cmd.Parameters.Add(
                            "@Description",
                            SqlDbType.NVarChar,
                            250
                        ).Value =
                            string.IsNullOrWhiteSpace(
                                description)
                            ? (object)DBNull.Value
                            : description;


                        cmd.Parameters.Add(
                            "@IsActive",
                            SqlDbType.Bit
                        ).Value =
                            ddlModalStatus.SelectedValue
                            == "1";


                        cmd.Parameters.Add(
                            "@WardID",
                            SqlDbType.Int
                        ).Value =
                            wardID;


                        cmd.ExecuteNonQuery();
                    }


                    pnlWardModal.Visible =
                        false;


                    ShowMessage(
                        "Ward updated successfully.",
                        true
                    );
                }
            }


            LoadStatistics();
            LoadWards();
        }



        // ==========================================
        // TOGGLE ACTIVE / INACTIVE
        // ==========================================

        private void ToggleWard(
            int wardID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    UPDATE Wards

                    SET IsActive =
                        CASE

                            WHEN IsActive = 1
                            THEN 0

                            ELSE 1

                        END

                    WHERE WardID =
                          @WardID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value =
                        wardID;


                    con.Open();


                    cmd.ExecuteNonQuery();
                }
            }


            ShowMessage(
                "Ward status updated successfully.",
                true
            );


            LoadStatistics();
            LoadWards();
        }



        // ==========================================
        // DELETE WARD
        // ==========================================

        private void DeleteWard(
            int wardID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // ==================================
                // CHECK COMPLAINTS
                // ==================================

                string checkQuery = @"

                    SELECT COUNT(*)

                    FROM Complaints

                    WHERE WardID =
                          @WardID;

                ";


                int complaintCount;


                using (SqlCommand checkCmd =
                       new SqlCommand(
                           checkQuery,
                           con))
                {
                    checkCmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value =
                        wardID;


                    complaintCount =
                        Convert.ToInt32(
                            checkCmd.ExecuteScalar()
                        );
                }



                // ==================================
                // DO NOT DELETE USED WARD
                // ==================================

                if (complaintCount > 0)
                {
                    ShowMessage(
                        "This ward cannot be deleted because it is already used by "
                        + complaintCount
                        + " complaint(s). Deactivate it instead.",
                        false
                    );


                    return;
                }



                // ==================================
                // DELETE
                // ==================================

                string deleteQuery = @"

                    DELETE FROM Wards

                    WHERE WardID =
                          @WardID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           deleteQuery,
                           con))
                {
                    cmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value =
                        wardID;


                    cmd.ExecuteNonQuery();
                }
            }


            ShowMessage(
                "Ward deleted successfully.",
                true
            );


            LoadStatistics();
            LoadWards();
        }



        // ==========================================
        // VIEW WARD
        // ==========================================

        private void OpenViewWard(
            int wardID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        W.WardID,
                        W.WardNumber,
                        W.WardName,
                        W.Description,
                        W.IsActive,
                        W.CreatedDate,

                        COUNT(
                            DISTINCT
                            CASE
                                WHEN R.RoleName = 'Officer'
                                THEN U.UserID
                            END
                        ) AS OfficerCount,

                        COUNT(
                            DISTINCT C.ComplaintID
                        ) AS ComplaintCount

                    FROM Wards W

                    LEFT JOIN Users U
                        ON W.WardID = U.WardID

                    LEFT JOIN Roles R
                        ON U.RoleID = R.RoleID

                    LEFT JOIN Complaints C
                        ON W.WardID = C.WardID

                    WHERE W.WardID =
                          @WardID

                    GROUP BY

                        W.WardID,
                        W.WardNumber,
                        W.WardName,
                        W.Description,
                        W.IsActive,
                        W.CreatedDate;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@WardID",
                        SqlDbType.Int
                    ).Value =
                        wardID;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblViewWardName.Text =
                                reader["WardName"]
                                .ToString();


                            lblViewWardNumber.Text =
                                reader["WardNumber"]
                                .ToString();


                            lblViewWardID.Text =
                                reader["WardID"]
                                .ToString();


                            lblViewDescription.Text =
                                reader["Description"] ==
                                DBNull.Value
                                ? "No description available."
                                : reader["Description"]
                                  .ToString();


                            bool isActive =
                                Convert.ToBoolean(
                                    reader["IsActive"]
                                );


                            lblViewStatus.Text =
                                isActive
                                ? "Active"
                                : "Inactive";


                            lblViewStatus.CssClass =
                                isActive
                                ? "view-status-active"
                                : "view-status-inactive";


                            lblViewCreatedDate.Text =
                                Convert.ToDateTime(
                                    reader["CreatedDate"]
                                ).ToString(
                                    "dd MMM yyyy"
                                );


                            lblViewOfficerCount.Text =
                                reader["OfficerCount"]
                                .ToString();


                            lblViewComplaintCount.Text =
                                reader["ComplaintCount"]
                                .ToString();


                            lblViewWardIcon.Text =
                                "W" +
                                reader["WardNumber"]
                                .ToString();


                            pnlViewModal.Visible =
                                true;
                        }
                    }
                }
            }
        }



        // ==========================================
        // CLOSE ADD / EDIT MODAL
        // ==========================================

        protected void btnCloseModal_Click(
            object sender,
            EventArgs e)
        {
            pnlWardModal.Visible =
                false;
        }



        // ==========================================
        // CLOSE VIEW MODAL
        // ==========================================

        protected void btnCloseViewModal_Click(
            object sender,
            EventArgs e)
        {
            pnlViewModal.Visible =
                false;
        }



        // ==========================================
        // APPLY FILTERS
        // ==========================================

        protected void btnApplyFilters_Click(
            object sender,
            EventArgs e)
        {
            LoadWards();
        }



        // ==========================================
        // SHOW MESSAGE
        // ==========================================

        private void ShowMessage(
            string message,
            bool success)
        {
            pnlMessage.Visible =
                true;


            lblMessage.Text =
                message;


            pnlMessage.CssClass =
                success
                ? "ward-message success"
                : "ward-message error";
        }



        // ==========================================
        // WARD ICON
        // ==========================================

        protected string GetWardIcon(
            object wardNumber)
        {
            if (wardNumber == null ||
                wardNumber == DBNull.Value)
            {
                return "W";
            }


            return "W" +
                   wardNumber.ToString();
        }



        // ==========================================
        // WARD ICON COLOR
        // ==========================================

        protected string GetWardIconClass(
            object wardNumber)
        {
            if (wardNumber == null ||
                wardNumber == DBNull.Value)
            {
                return "";
            }


            int number;


            if (!int.TryParse(
                wardNumber.ToString(),
                out number))
            {
                return "";
            }


            switch (number % 4)
            {
                case 0:
                    return "purple";

                case 1:
                    return "";

                case 2:
                    return "cyan";

                case 3:
                    return "emerald";

                default:
                    return "";
            }
        }
    }
}