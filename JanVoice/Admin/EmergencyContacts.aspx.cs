using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class EmergencyContacts : System.Web.UI.Page
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
                LoadContacts();
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
                        COUNT(*) AS TotalContacts,

                        SUM(
                            CASE
                                WHEN IsActive = 1
                                THEN 1
                                ELSE 0
                            END
                        ) AS ActiveContacts,

                        COUNT(
                            DISTINCT DepartmentName
                        ) AS Departments,

                        SUM(
                            CASE
                                WHEN CreatedDate >= DATEADD(DAY, -30, GETDATE())
                                THEN 1
                                ELSE 0
                            END
                        ) AS RecentContacts

                    FROM EmergencyContacts;

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
                            lblTotalContacts.Text =
                                reader["TotalContacts"]
                                .ToString();

                            lblActiveContacts.Text =
                                reader["ActiveContacts"]
                                .ToString();

                            lblDepartments.Text =
                                reader["Departments"]
                                .ToString();

                            lblRecentContacts.Text =
                                reader["RecentContacts"]
                                .ToString();
                        }
                    }
                }
            }
        }



        // ==========================================
        // LOAD CONTACTS
        // ==========================================

        private void LoadContacts()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT
                        ContactID,
                        DepartmentName,
                        ContactPerson,
                        PhoneNumber,
                        Email,
                        Address,
                        IsAvailable24x7,
                        IsActive,
                        CreatedDate

                    FROM EmergencyContacts

                    WHERE
                    (
                        @Search = ''

                        OR DepartmentName LIKE
                           '%' + @Search + '%'

                        OR ContactPerson LIKE
                           '%' + @Search + '%'

                        OR PhoneNumber LIKE
                           '%' + @Search + '%'

                        OR Email LIKE
                           '%' + @Search + '%'
                    )

                    AND
                    (
                        @Status = ''

                        OR IsActive =
                           CAST(@Status AS BIT)
                    )

                    AND
                    (
                        @Category = ''

                        OR
                        (
                            @Category = 'Police'
                            AND
                            (
                                DepartmentName LIKE '%Police%'
                                OR DepartmentName LIKE '%Police Station%'
                            )
                        )

                        OR
                        (
                            @Category = 'Medical'
                            AND
                            (
                                DepartmentName LIKE '%Hospital%'
                                OR DepartmentName LIKE '%Medical%'
                                OR DepartmentName LIKE '%Ambulance%'
                                OR DepartmentName LIKE '%Health%'
                            )
                        )

                        OR
                        (
                            @Category = 'Fire'
                            AND
                            (
                                DepartmentName LIKE '%Fire%'
                                OR DepartmentName LIKE '%Rescue%'
                            )
                        )

                        OR
                        (
                            @Category = 'Other'
                            AND NOT
                            (
                                DepartmentName LIKE '%Police%'
                                OR DepartmentName LIKE '%Hospital%'
                                OR DepartmentName LIKE '%Medical%'
                                OR DepartmentName LIKE '%Ambulance%'
                                OR DepartmentName LIKE '%Health%'
                                OR DepartmentName LIKE '%Fire%'
                                OR DepartmentName LIKE '%Rescue%'
                            )
                        )
                    )

                    ORDER BY
                        IsActive DESC,
                        CreatedDate DESC;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@Search",
                        SqlDbType.NVarChar,
                        150
                    ).Value =
                        txtSearch.Text.Trim();


                    cmd.Parameters.Add(
                        "@Status",
                        SqlDbType.NVarChar,
                        10
                    ).Value =
                        ddlStatus.SelectedValue;


                    cmd.Parameters.Add(
                        "@Category",
                        SqlDbType.NVarChar,
                        20
                    ).Value =
                        ddlCategory.SelectedValue;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        DataTable dt =
                            new DataTable();

                        dt.Load(reader);


                        rptContacts.DataSource =
                            dt;

                        rptContacts.DataBind();


                        lblRecordCount.Text =
                            dt.Rows.Count.ToString();


                        pnlEmpty.Visible =
                            dt.Rows.Count == 0;
                    }
                }
            }
        }



        // ==========================================
        // APPLY FILTERS
        // ==========================================

        protected void btnApplyFilters_Click(
            object sender,
            EventArgs e)
        {
            LoadContacts();
        }



        // ==========================================
        // ADD CONTACT
        // ==========================================

        protected void btnAddContact_Click(
            object sender,
            EventArgs e)
        {
            ClearContactForm();


            lblModalTitle.Text =
                "Add Emergency Contact";


            btnSaveContact.Text =
                "Save Contact";


            pnlModalStatus.Visible =
                false;


            pnlContactModal.Visible =
                true;
        }



        // ==========================================
        // CLEAR FORM
        // ==========================================

        private void ClearContactForm()
        {
            hfContactID.Value =
                "0";


            txtDepartmentName.Text =
                "";


            txtContactPerson.Text =
                "";


            txtPhoneNumber.Text =
                "";


            txtEmail.Text =
                "";


            txtAddress.Text =
                "";


            chk24x7.Checked =
                true;


            ddlModalStatus.SelectedValue =
                "1";
        }



        // ==========================================
        // SAVE / UPDATE CONTACT
        // ==========================================

        protected void btnSaveContact_Click(
            object sender,
            EventArgs e)
        {
            // --------------------------------------
            // VALIDATION
            // --------------------------------------

            string departmentName =
                txtDepartmentName.Text.Trim();


            string contactPerson =
                txtContactPerson.Text.Trim();


            string phoneNumber =
                txtPhoneNumber.Text.Trim();


            string email =
                txtEmail.Text.Trim();


            string address =
                txtAddress.Text.Trim();


            if (string.IsNullOrWhiteSpace(
                departmentName))
            {
                ShowMessage(
                    "Please enter the department name.",
                    false
                );

                pnlContactModal.Visible =
                    true;

                return;
            }


            if (string.IsNullOrWhiteSpace(
                phoneNumber))
            {
                ShowMessage(
                    "Please enter the phone number.",
                    false
                );

                pnlContactModal.Visible =
                    true;

                return;
            }



            // --------------------------------------
            // GET CONTACT ID
            // --------------------------------------

            int contactID = 0;

            int.TryParse(
                hfContactID.Value,
                out contactID
            );



            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // ==================================
                // ADD
                // ==================================

                if (contactID == 0)
                {
                    string checkQuery = @"

                        SELECT COUNT(*)

                        FROM EmergencyContacts

                        WHERE
                            LOWER(DepartmentName)
                            =
                            LOWER(@DepartmentName)

                        AND PhoneNumber =
                            @PhoneNumber;

                    ";


                    using (SqlCommand checkCmd =
                           new SqlCommand(
                               checkQuery,
                               con))
                    {
                        checkCmd.Parameters.Add(
                            "@DepartmentName",
                            SqlDbType.NVarChar,
                            150
                        ).Value =
                            departmentName;


                        checkCmd.Parameters.Add(
                            "@PhoneNumber",
                            SqlDbType.NVarChar,
                            20
                        ).Value =
                            phoneNumber;


                        int exists =
                            Convert.ToInt32(
                                checkCmd.ExecuteScalar()
                            );


                        if (exists > 0)
                        {
                            ShowMessage(
                                "This emergency contact already exists.",
                                false
                            );

                            pnlContactModal.Visible =
                                true;

                            return;
                        }
                    }



                    // --------------------------------
                    // INSERT
                    // --------------------------------

                    string insertQuery = @"

                        INSERT INTO EmergencyContacts
                        (
                            DepartmentName,
                            ContactPerson,
                            PhoneNumber,
                            Email,
                            Address,
                            IsAvailable24x7,
                            IsActive,
                            CreatedDate
                        )

                        VALUES
                        (
                            @DepartmentName,
                            @ContactPerson,
                            @PhoneNumber,
                            @Email,
                            @Address,
                            @IsAvailable24x7,
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
                            "@DepartmentName",
                            SqlDbType.NVarChar,
                            150
                        ).Value =
                            departmentName;


                        cmd.Parameters.Add(
                            "@ContactPerson",
                            SqlDbType.NVarChar,
                            100
                        ).Value =
                            string.IsNullOrWhiteSpace(
                                contactPerson)
                            ? (object)DBNull.Value
                            : contactPerson;


                        cmd.Parameters.Add(
                            "@PhoneNumber",
                            SqlDbType.NVarChar,
                            20
                        ).Value =
                            phoneNumber;


                        cmd.Parameters.Add(
                            "@Email",
                            SqlDbType.NVarChar,
                            150
                        ).Value =
                            string.IsNullOrWhiteSpace(email)
                            ? (object)DBNull.Value
                            : email;


                        cmd.Parameters.Add(
                            "@Address",
                            SqlDbType.NVarChar,
                            500
                        ).Value =
                            string.IsNullOrWhiteSpace(address)
                            ? (object)DBNull.Value
                            : address;


                        cmd.Parameters.Add(
                            "@IsAvailable24x7",
                            SqlDbType.Bit
                        ).Value =
                            chk24x7.Checked;


                        cmd.ExecuteNonQuery();
                    }


                    pnlContactModal.Visible =
                        false;


                    ShowMessage(
                        "Emergency contact added successfully.",
                        true
                    );
                }



                // ==================================
                // UPDATE
                // ==================================

                else
                {
                    // ------------------------------
                    // DUPLICATE CHECK
                    // ------------------------------

                    string checkQuery = @"

                        SELECT COUNT(*)

                        FROM EmergencyContacts

                        WHERE
                            LOWER(DepartmentName)
                            =
                            LOWER(@DepartmentName)

                        AND PhoneNumber =
                            @PhoneNumber

                        AND ContactID <>
                            @ContactID;

                    ";


                    using (SqlCommand checkCmd =
                           new SqlCommand(
                               checkQuery,
                               con))
                    {
                        checkCmd.Parameters.Add(
                            "@DepartmentName",
                            SqlDbType.NVarChar,
                            150
                        ).Value =
                            departmentName;


                        checkCmd.Parameters.Add(
                            "@PhoneNumber",
                            SqlDbType.NVarChar,
                            20
                        ).Value =
                            phoneNumber;


                        checkCmd.Parameters.Add(
                            "@ContactID",
                            SqlDbType.Int
                        ).Value =
                            contactID;


                        int exists =
                            Convert.ToInt32(
                                checkCmd.ExecuteScalar()
                            );


                        if (exists > 0)
                        {
                            ShowMessage(
                                "Another emergency contact with the same department and phone number already exists.",
                                false
                            );

                            pnlContactModal.Visible =
                                true;

                            return;
                        }
                    }



                    // ------------------------------
                    // UPDATE
                    // ------------------------------

                    string updateQuery = @"

                        UPDATE EmergencyContacts

                        SET
                            DepartmentName =
                                @DepartmentName,

                            ContactPerson =
                                @ContactPerson,

                            PhoneNumber =
                                @PhoneNumber,

                            Email =
                                @Email,

                            Address =
                                @Address,

                            IsAvailable24x7 =
                                @IsAvailable24x7,

                            IsActive =
                                @IsActive

                        WHERE
                            ContactID =
                            @ContactID;

                    ";


                    using (SqlCommand cmd =
                           new SqlCommand(
                               updateQuery,
                               con))
                    {
                        cmd.Parameters.Add(
                            "@DepartmentName",
                            SqlDbType.NVarChar,
                            150
                        ).Value =
                            departmentName;


                        cmd.Parameters.Add(
                            "@ContactPerson",
                            SqlDbType.NVarChar,
                            100
                        ).Value =
                            string.IsNullOrWhiteSpace(
                                contactPerson)
                            ? (object)DBNull.Value
                            : contactPerson;


                        cmd.Parameters.Add(
                            "@PhoneNumber",
                            SqlDbType.NVarChar,
                            20
                        ).Value =
                            phoneNumber;


                        cmd.Parameters.Add(
                            "@Email",
                            SqlDbType.NVarChar,
                            150
                        ).Value =
                            string.IsNullOrWhiteSpace(email)
                            ? (object)DBNull.Value
                            : email;


                        cmd.Parameters.Add(
                            "@Address",
                            SqlDbType.NVarChar,
                            500
                        ).Value =
                            string.IsNullOrWhiteSpace(address)
                            ? (object)DBNull.Value
                            : address;


                        cmd.Parameters.Add(
                            "@IsAvailable24x7",
                            SqlDbType.Bit
                        ).Value =
                            chk24x7.Checked;


                        cmd.Parameters.Add(
                            "@IsActive",
                            SqlDbType.Bit
                        ).Value =
                            ddlModalStatus.SelectedValue == "1";


                        cmd.Parameters.Add(
                            "@ContactID",
                            SqlDbType.Int
                        ).Value =
                            contactID;


                        cmd.ExecuteNonQuery();
                    }


                    pnlContactModal.Visible =
                        false;


                    ShowMessage(
                        "Emergency contact updated successfully.",
                        true
                    );
                }
            }


            LoadStatistics();
            LoadContacts();
        }



        // ==========================================
        // REPEATER COMMANDS
        // ==========================================

        protected void rptContacts_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            int contactID;


            if (!int.TryParse(
                e.CommandArgument.ToString(),
                out contactID))
            {
                return;
            }


            switch (e.CommandName)
            {
                case "ViewContact":

                    OpenViewContact(contactID);

                    break;


                case "EditContact":

                    OpenEditContact(contactID);

                    break;


                case "ToggleContact":

                    ToggleContact(contactID);

                    break;


                case "DeleteContact":

                    DeleteContact(contactID);

                    break;
            }
        }



        // ==========================================
        // OPEN EDIT CONTACT
        // ==========================================

        private void OpenEditContact(
            int contactID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT
                        ContactID,
                        DepartmentName,
                        ContactPerson,
                        PhoneNumber,
                        Email,
                        Address,
                        IsAvailable24x7,
                        IsActive

                    FROM EmergencyContacts

                    WHERE ContactID =
                          @ContactID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@ContactID",
                        SqlDbType.Int
                    ).Value =
                        contactID;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfContactID.Value =
                                reader["ContactID"]
                                .ToString();


                            txtDepartmentName.Text =
                                reader["DepartmentName"]
                                .ToString();


                            txtContactPerson.Text =
                                reader["ContactPerson"] ==
                                DBNull.Value
                                ? ""
                                : reader["ContactPerson"]
                                  .ToString();


                            txtPhoneNumber.Text =
                                reader["PhoneNumber"]
                                .ToString();


                            txtEmail.Text =
                                reader["Email"] ==
                                DBNull.Value
                                ? ""
                                : reader["Email"]
                                  .ToString();


                            txtAddress.Text =
                                reader["Address"] ==
                                DBNull.Value
                                ? ""
                                : reader["Address"]
                                  .ToString();


                            chk24x7.Checked =
                                Convert.ToBoolean(
                                    reader["IsAvailable24x7"]
                                );


                            ddlModalStatus.SelectedValue =
                                Convert.ToBoolean(
                                    reader["IsActive"]
                                )
                                ? "1"
                                : "0";


                            lblModalTitle.Text =
                                "Edit Emergency Contact";


                            btnSaveContact.Text =
                                "Update Contact";


                            pnlModalStatus.Visible =
                                true;


                            pnlContactModal.Visible =
                                true;
                        }
                    }
                }
            }
        }



        // ==========================================
        // OPEN VIEW CONTACT
        // ==========================================

        private void OpenViewContact(
            int contactID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT
                        ContactID,
                        DepartmentName,
                        ContactPerson,
                        PhoneNumber,
                        Email,
                        Address,
                        IsAvailable24x7,
                        IsActive,
                        CreatedDate

                    FROM EmergencyContacts

                    WHERE ContactID =
                          @ContactID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@ContactID",
                        SqlDbType.Int
                    ).Value =
                        contactID;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string department =
                                reader["DepartmentName"]
                                .ToString();


                            lblViewDepartment.Text =
                                department;


                            lblViewCategory.Text =
                                GetCategory(
                                    department
                                );


                            lblViewContactPerson.Text =
                                reader["ContactPerson"] ==
                                DBNull.Value
                                ? "Not specified"
                                : reader["ContactPerson"]
                                  .ToString();


                            lblViewPhone.Text =
                                reader["PhoneNumber"]
                                .ToString();


                            lblViewEmail.Text =
                                reader["Email"] ==
                                DBNull.Value
                                ? "Not specified"
                                : reader["Email"]
                                  .ToString();


                            lblViewAddress.Text =
                                reader["Address"] ==
                                DBNull.Value
                                ? "Address not specified"
                                : reader["Address"]
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
                                ? "view-status active"
                                : "view-status inactive";


                            bool is24x7 =
                                Convert.ToBoolean(
                                    reader["IsAvailable24x7"]
                                );


                            lblViewAvailability.Text =
                                is24x7
                                ? "Available 24x7"
                                : "Limited Availability";


                            lblViewID.Text =
                                reader["ContactID"]
                                .ToString();


                            lblViewCreatedDate.Text =
                                Convert.ToDateTime(
                                    reader["CreatedDate"]
                                ).ToString(
                                    "dd MMM yyyy"
                                );


                            viewIcon.Attributes["class"] =
                                "view-contact-icon "
                                + GetContactIconClass(
                                    department
                                );


                            viewIcon.InnerText =
                                GetContactIcon(
                                    department
                                );


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
            pnlContactModal.Visible =
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
        // TOGGLE ACTIVE / INACTIVE
        // ==========================================

        private void ToggleContact(
            int contactID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    UPDATE EmergencyContacts

                    SET
                        IsActive =
                        CASE
                            WHEN IsActive = 1
                            THEN 0
                            ELSE 1
                        END

                    WHERE ContactID =
                          @ContactID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@ContactID",
                        SqlDbType.Int
                    ).Value =
                        contactID;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }


            ShowMessage(
                "Emergency contact status updated successfully.",
                true
            );


            LoadStatistics();
            LoadContacts();
        }



        // ==========================================
        // DELETE CONTACT
        // ==========================================

        private void DeleteContact(
            int contactID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    DELETE FROM EmergencyContacts

                    WHERE ContactID =
                          @ContactID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@ContactID",
                        SqlDbType.Int
                    ).Value =
                        contactID;


                    con.Open();


                    int rowsAffected =
                        cmd.ExecuteNonQuery();


                    if (rowsAffected == 0)
                    {
                        ShowMessage(
                            "Emergency contact was not found.",
                            false
                        );

                        return;
                    }
                }
            }


            ShowMessage(
                "Emergency contact removed successfully.",
                true
            );


            LoadStatistics();
            LoadContacts();
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
                ? "emergency-message success"
                : "emergency-message error";
        }



        // ==========================================
        // DISPLAY VALUE
        // ==========================================

        protected string GetDisplayValue(
            object value)
        {
            if (value == null ||
                value == DBNull.Value)
            {
                return "-";
            }


            string text =
                value.ToString().Trim();


            return string.IsNullOrWhiteSpace(text)
                ? "-"
                : text;
        }



        // ==========================================
        // CONTACT PERSON
        // ==========================================

        protected string GetContactPerson(
            object value)
        {
            if (value == null ||
                value == DBNull.Value)
            {
                return "Emergency Service";
            }


            string text =
                value.ToString().Trim();


            return string.IsNullOrWhiteSpace(text)
                ? "Emergency Service"
                : text;
        }



        // ==========================================
        // ADDRESS
        // ==========================================

        protected string GetDisplayAddress(
            object value)
        {
            if (value == null ||
                value == DBNull.Value)
            {
                return "Address not specified";
            }


            string text =
                value.ToString().Trim();


            if (string.IsNullOrWhiteSpace(text))
            {
                return "Address not specified";
            }


            return text;
        }



        // ==========================================
        // CATEGORY
        // ==========================================

        protected string GetCategory(
            object department)
        {
            if (department == null ||
                department == DBNull.Value)
            {
                return "Other";
            }


            return GetCategory(
                department.ToString()
            );
        }


        private string GetCategory(
            string department)
        {
            if (string.IsNullOrWhiteSpace(
                department))
            {
                return "Other";
            }


            string name =
                department.ToLower();


            if (name.Contains("police"))
            {
                return "Police";
            }


            if (name.Contains("hospital") ||
                name.Contains("medical") ||
                name.Contains("ambulance") ||
                name.Contains("health"))
            {
                return "Medical";
            }


            if (name.Contains("fire") ||
                name.Contains("rescue"))
            {
                return "Fire & Rescue";
            }


            return "Other";
        }



        // ==========================================
        // CATEGORY CLASS
        // ==========================================

        protected string GetCategoryClass(
            object department)
        {
            string category =
                GetCategory(department);


            switch (category)
            {
                case "Police":
                    return "police-badge";

                case "Medical":
                    return "medical-badge";

                case "Fire & Rescue":
                    return "fire-badge";

                default:
                    return "other-badge";
            }
        }



        // ==========================================
        // ICON
        // ==========================================

        protected string GetContactIcon(
            object department)
        {
            if (department == null ||
                department == DBNull.Value)
            {
                return "☎";
            }


            string name =
                department.ToString()
                          .ToLower();


            if (name.Contains("police"))
            {
                return "⚠";
            }


            if (name.Contains("hospital") ||
                name.Contains("medical") ||
                name.Contains("ambulance") ||
                name.Contains("health"))
            {
                return "+";
            }


            if (name.Contains("fire") ||
                name.Contains("rescue"))
            {
                return "🔥";
            }


            return "☎";
        }



        // ==========================================
        // ICON CLASS
        // ==========================================

        protected string GetContactIconClass(
            object department)
        {
            string category =
                GetCategory(department);


            switch (category)
            {
                case "Police":
                    return "police";

                case "Medical":
                    return "medical";

                case "Fire & Rescue":
                    return "fire";

                default:
                    return "other";
            }
        }



        // ==========================================
        // STATUS CLASS
        // ==========================================

        protected string GetStatusClass(
            object value)
        {
            bool active =
                Convert.ToBoolean(value);


            return active
                ? "active"
                : "inactive";
        }



        // ==========================================
        // STATUS TEXT
        // ==========================================

        protected string GetStatusText(
            object value)
        {
            bool active =
                Convert.ToBoolean(value);


            return active
                ? "Active"
                : "Inactive";
        }



        // ==========================================
        // TOGGLE TEXT
        // ==========================================

        protected string GetToggleText(
            object value)
        {
            bool active =
                Convert.ToBoolean(value);


            return active
                ? "Disable"
                : "Enable";
        }



        // ==========================================
        // AVAILABILITY
        // ==========================================

        protected string GetAvailabilityText(
            object value)
        {
            bool available =
                Convert.ToBoolean(value);


            return available
                ? "24x7"
                : "Limited";
        }
    }
}