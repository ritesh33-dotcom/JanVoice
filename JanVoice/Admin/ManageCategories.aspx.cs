using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class ManageCategories : System.Web.UI.Page
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
                LoadCategories();
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

                        COUNT(*) AS TotalCategories,

                        SUM(
                            CASE
                                WHEN IsActive = 1
                                THEN 1
                                ELSE 0
                            END
                        ) AS ActiveCategories,

                        SUM(
                            CASE
                                WHEN IsActive = 0
                                THEN 1
                                ELSE 0
                            END
                        ) AS InactiveCategories

                    FROM Categories;


                    SELECT
                        COUNT(*) AS CategorizedComplaints

                    FROM Complaints

                    WHERE CategoryID IS NOT NULL;

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
                            lblTotalCategories.Text =
                                reader["TotalCategories"]
                                .ToString();

                            lblActiveCategories.Text =
                                reader["ActiveCategories"]
                                .ToString();

                            lblInactiveCategories.Text =
                                reader["InactiveCategories"]
                                .ToString();
                        }


                        if (reader.NextResult())
                        {
                            if (reader.Read())
                            {
                                lblCategorizedComplaints.Text =
                                    reader["CategorizedComplaints"]
                                    .ToString();
                            }
                        }
                    }
                }
            }
        }



        // ==========================================
        // LOAD CATEGORIES
        // ==========================================

        private void LoadCategories()
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        C.CategoryID,
                        C.CategoryName,
                        C.Description,
                        C.IsActive,
                        C.CreatedDate,

                        COUNT(Com.ComplaintID)
                            AS ComplaintCount

                    FROM Categories C

                    LEFT JOIN Complaints Com
                        ON C.CategoryID =
                           Com.CategoryID

                    WHERE

                    (
                        @Search = ''

                        OR C.CategoryName LIKE
                           '%' + @Search + '%'

                        OR C.Description LIKE
                           '%' + @Search + '%'
                    )

                    AND

                    (
                        @Status = ''

                        OR C.IsActive =
                           CAST(@Status AS BIT)
                    )

                    GROUP BY

                        C.CategoryID,
                        C.CategoryName,
                        C.Description,
                        C.IsActive,
                        C.CreatedDate

                    ORDER BY
                        C.CreatedDate DESC;

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


                        rptCategories.DataSource =
                            dt;

                        rptCategories.DataBind();


                        lblRecordCount.Text =
                            dt.Rows.Count.ToString();


                        pnlEmpty.Visible =
                            dt.Rows.Count == 0;
                    }
                }
            }
        }



        // ==========================================
        // ADD CATEGORY
        // ==========================================

        protected void btnAddCategory_Click(
            object sender,
            EventArgs e)
        {
            ClearCategoryForm();

            lblModalTitle.Text =
                "Add Category";

            btnSaveCategory.Text =
                "Save Category";

            categoryStatusGroup.Visible =
                false;

            pnlCategoryModal.Visible =
                true;
        }



        // ==========================================
        // CLEAR CATEGORY FORM
        // ==========================================

        private void ClearCategoryForm()
        {
            hfCategoryID.Value =
                "0";

            txtCategoryName.Text =
                "";

            txtCategoryDescription.Text =
                "";

            ddlModalStatus.SelectedValue =
                "1";
        }



        // ==========================================
        // EDIT / VIEW / TOGGLE / DELETE
        // ==========================================

        protected void rptCategories_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            int categoryID;

            if (!int.TryParse(
                e.CommandArgument.ToString(),
                out categoryID))
            {
                return;
            }


            switch (e.CommandName)
            {
                case "EditCategory":

                    OpenEditCategory(categoryID);

                    break;


                case "ViewCategory":

                    OpenViewCategory(categoryID);

                    break;


                case "ToggleCategory":

                    ToggleCategory(categoryID);

                    break;


                case "DeleteCategory":

                    DeleteCategory(categoryID);

                    break;
            }
        }



        // ==========================================
        // OPEN EDIT CATEGORY
        // ==========================================

        private void OpenEditCategory(
            int categoryID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT
                        CategoryID,
                        CategoryName,
                        Description,
                        IsActive

                    FROM Categories

                    WHERE CategoryID = @CategoryID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@CategoryID",
                        SqlDbType.Int
                    ).Value =
                        categoryID;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfCategoryID.Value =
                                reader["CategoryID"]
                                .ToString();


                            txtCategoryName.Text =
                                reader["CategoryName"]
                                .ToString();


                            txtCategoryDescription.Text =
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
                                "Edit Category";


                            btnSaveCategory.Text =
                                "Update Category";


                            categoryStatusGroup.Visible =
                                true;


                            pnlCategoryModal.Visible =
                                true;
                        }
                    }
                }
            }
        }



        // ==========================================
        // SAVE / UPDATE CATEGORY
        // ==========================================

        protected void btnSaveCategory_Click(
            object sender,
            EventArgs e)
        {
            string categoryName =
                txtCategoryName.Text.Trim();

            string description =
                txtCategoryDescription.Text.Trim();


            // ------------------------------
            // BASIC VALIDATION
            // ------------------------------

            if (string.IsNullOrWhiteSpace(
                categoryName))
            {
                ShowMessage(
                    "Please enter a category name.",
                    false
                );

                pnlCategoryModal.Visible =
                    true;

                return;
            }


            if (categoryName.Length < 3)
            {
                ShowMessage(
                    "Category name must contain at least 3 characters.",
                    false
                );

                pnlCategoryModal.Visible =
                    true;

                return;
            }



            int categoryID =
                Convert.ToInt32(
                    hfCategoryID.Value
                );



            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // ==================================
                // ADD
                // ==================================

                if (categoryID == 0)
                {
                    string checkQuery = @"

                        SELECT COUNT(*)

                        FROM Categories

                        WHERE
                            LOWER(CategoryName) =
                            LOWER(@CategoryName);

                    ";


                    using (SqlCommand checkCmd =
                           new SqlCommand(
                               checkQuery,
                               con))
                    {
                        checkCmd.Parameters.Add(
                            "@CategoryName",
                            SqlDbType.NVarChar,
                            100
                        ).Value =
                            categoryName;


                        int exists =
                            Convert.ToInt32(
                                checkCmd.ExecuteScalar()
                            );


                        if (exists > 0)
                        {
                            ShowMessage(
                                "A category with this name already exists.",
                                false
                            );

                            pnlCategoryModal.Visible =
                                true;

                            return;
                        }
                    }



                    string insertQuery = @"

                        INSERT INTO Categories
                        (
                            CategoryName,
                            Description,
                            IsActive,
                            CreatedDate
                        )

                        VALUES
                        (
                            @CategoryName,
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
                            "@CategoryName",
                            SqlDbType.NVarChar,
                            100
                        ).Value =
                            categoryName;


                        cmd.Parameters.Add(
                            "@Description",
                            SqlDbType.NVarChar,
                            500
                        ).Value =
                            string.IsNullOrWhiteSpace(
                                description)
                            ? (object)DBNull.Value
                            : description;


                        cmd.ExecuteNonQuery();
                    }


                    pnlCategoryModal.Visible =
                        false;


                    ShowMessage(
                        "Category added successfully.",
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

                        FROM Categories

                        WHERE

                            LOWER(CategoryName) =
                            LOWER(@CategoryName)

                        AND CategoryID <> @CategoryID;

                    ";


                    using (SqlCommand checkCmd =
                           new SqlCommand(
                               checkQuery,
                               con))
                    {
                        checkCmd.Parameters.Add(
                            "@CategoryName",
                            SqlDbType.NVarChar,
                            100
                        ).Value =
                            categoryName;


                        checkCmd.Parameters.Add(
                            "@CategoryID",
                            SqlDbType.Int
                        ).Value =
                            categoryID;


                        int exists =
                            Convert.ToInt32(
                                checkCmd.ExecuteScalar()
                            );


                        if (exists > 0)
                        {
                            ShowMessage(
                                "Another category with this name already exists.",
                                false
                            );

                            pnlCategoryModal.Visible =
                                true;

                            return;
                        }
                    }



                    string updateQuery = @"

                        UPDATE Categories

                        SET

                            CategoryName =
                                @CategoryName,

                            Description =
                                @Description,

                            IsActive =
                                @IsActive

                        WHERE CategoryID =
                              @CategoryID;

                    ";


                    using (SqlCommand cmd =
                           new SqlCommand(
                               updateQuery,
                               con))
                    {
                        cmd.Parameters.Add(
                            "@CategoryName",
                            SqlDbType.NVarChar,
                            100
                        ).Value =
                            categoryName;


                        cmd.Parameters.Add(
                            "@Description",
                            SqlDbType.NVarChar,
                            500
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
                            "@CategoryID",
                            SqlDbType.Int
                        ).Value =
                            categoryID;


                        cmd.ExecuteNonQuery();
                    }


                    pnlCategoryModal.Visible =
                        false;


                    ShowMessage(
                        "Category updated successfully.",
                        true
                    );
                }
            }


            LoadStatistics();
            LoadCategories();
        }



        // ==========================================
        // TOGGLE ACTIVE / INACTIVE
        // ==========================================

        private void ToggleCategory(
            int categoryID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    UPDATE Categories

                    SET IsActive =
                        CASE
                            WHEN IsActive = 1
                            THEN 0
                            ELSE 1
                        END

                    WHERE CategoryID =
                          @CategoryID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@CategoryID",
                        SqlDbType.Int
                    ).Value =
                        categoryID;


                    con.Open();

                    cmd.ExecuteNonQuery();
                }
            }


            ShowMessage(
                "Category status updated successfully.",
                true
            );


            LoadStatistics();
            LoadCategories();
        }



        // ==========================================
        // DELETE CATEGORY
        // ==========================================

        private void DeleteCategory(
            int categoryID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                con.Open();


                // ----------------------------------
                // CHECK COMPLAINTS
                // ----------------------------------

                string checkQuery = @"

                    SELECT COUNT(*)

                    FROM Complaints

                    WHERE CategoryID =
                          @CategoryID;

                ";


                int complaintCount;


                using (SqlCommand checkCmd =
                       new SqlCommand(
                           checkQuery,
                           con))
                {
                    checkCmd.Parameters.Add(
                        "@CategoryID",
                        SqlDbType.Int
                    ).Value =
                        categoryID;


                    complaintCount =
                        Convert.ToInt32(
                            checkCmd.ExecuteScalar()
                        );
                }



                // ----------------------------------
                // DO NOT DELETE USED CATEGORY
                // ----------------------------------

                if (complaintCount > 0)
                {
                    ShowMessage(
                        "This category cannot be deleted because it is already used by "
                        + complaintCount
                        + " complaint(s). Deactivate it instead.",
                        false
                    );

                    return;
                }



                // ----------------------------------
                // DELETE
                // ----------------------------------

                string deleteQuery = @"

                    DELETE FROM Categories

                    WHERE CategoryID =
                          @CategoryID;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           deleteQuery,
                           con))
                {
                    cmd.Parameters.Add(
                        "@CategoryID",
                        SqlDbType.Int
                    ).Value =
                        categoryID;


                    cmd.ExecuteNonQuery();
                }
            }


            ShowMessage(
                "Category deleted successfully.",
                true
            );


            LoadStatistics();
            LoadCategories();
        }



        // ==========================================
        // VIEW CATEGORY
        // ==========================================

        private void OpenViewCategory(
            int categoryID)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        C.CategoryID,
                        C.CategoryName,
                        C.Description,
                        C.IsActive,
                        C.CreatedDate,

                        COUNT(Com.ComplaintID)
                            AS ComplaintCount

                    FROM Categories C

                    LEFT JOIN Complaints Com
                        ON C.CategoryID =
                           Com.CategoryID

                    WHERE C.CategoryID =
                          @CategoryID

                    GROUP BY

                        C.CategoryID,
                        C.CategoryName,
                        C.Description,
                        C.IsActive,
                        C.CreatedDate;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(
                           query,
                           con))
                {
                    cmd.Parameters.Add(
                        "@CategoryID",
                        SqlDbType.Int
                    ).Value =
                        categoryID;


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string categoryName =
                                reader["CategoryName"]
                                .ToString();


                            lblViewCategoryID.Text =
                                reader["CategoryID"]
                                .ToString();


                            lblViewCategoryName.Text =
                                categoryName;


                            lblViewIcon.Text =
                                GetCategoryIcon(
                                    categoryName
                                );


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


                            lblViewComplaintCount.Text =
                                reader["ComplaintCount"]
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
            pnlCategoryModal.Visible =
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
        // APPLY FILTER
        // ==========================================

        protected void btnApplyFilters_Click(
            object sender,
            EventArgs e)
        {
            LoadCategories();
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
                ? "category-message success"
                : "category-message error";
        }



        // ==========================================
        // CATEGORY ICON
        // ==========================================

        protected string GetCategoryIcon(
            string categoryName)
        {
            if (string.IsNullOrWhiteSpace(
                categoryName))
            {
                return "📋";
            }


            string name =
                categoryName.ToLower();


            if (name.Contains("road")
                || name.Contains("pothole"))
                return "🛣️";


            if (name.Contains("light")
                || name.Contains("electric"))
                return "💡";


            if (name.Contains("garbage")
                || name.Contains("waste")
                || name.Contains("clean"))
                return "🗑️";


            if (name.Contains("water")
                || name.Contains("drain"))
                return "💧";


            if (name.Contains("traffic"))
                return "🚦";


            if (name.Contains("park")
                || name.Contains("garden"))
                return "🌳";


            if (name.Contains("sewage")
                || name.Contains("sanitation"))
                return "🚰";


            if (name.Contains("street"))
                return "🏙️";


            return "📋";
        }



        // ==========================================
        // ICON COLOR CLASS
        // ==========================================

        protected string GetIconClass(
            string categoryName)
        {
            if (string.IsNullOrWhiteSpace(
                categoryName))
                return "";


            string name =
                categoryName.ToLower();


            if (name.Contains("light")
                || name.Contains("electric"))
                return "purple";


            if (name.Contains("garbage")
                || name.Contains("waste")
                || name.Contains("clean"))
                return "green";


            if (name.Contains("water")
                || name.Contains("drain"))
                return "cyan";


            if (name.Contains("park")
                || name.Contains("garden"))
                return "emerald";


            return "";
        }
    }
}