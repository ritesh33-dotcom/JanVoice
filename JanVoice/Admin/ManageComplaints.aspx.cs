using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class ManageComplaints : System.Web.UI.Page
    {
        private readonly string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

        private const int PageSize = 10;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CurrentPage = 1;

                LoadCategories();
                LoadWards();

                LoadSummary();
                LoadComplaints();
            }
        }


        // ==========================================
        // CURRENT PAGE
        // ==========================================

        private int CurrentPage
        {
            get
            {
                return ViewState["CurrentPage"] == null
                    ? 1
                    : Convert.ToInt32(ViewState["CurrentPage"]);
            }

            set
            {
                ViewState["CurrentPage"] = value;
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
                    SELECT CategoryID, CategoryName
                    FROM Categories
                    WHERE IsActive = 1
                    ORDER BY CategoryName
                ";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        ddlCategory.DataSource = reader;

                        ddlCategory.DataTextField =
                            "CategoryName";

                        ddlCategory.DataValueField =
                            "CategoryID";

                        ddlCategory.DataBind();
                    }
                }
            }

            ddlCategory.Items.Insert(
                0,
                new ListItem("All Categories", "")
            );
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
                    SELECT WardID, WardName
                    FROM Wards
                    WHERE IsActive = 1
                    ORDER BY WardNumber
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
                new ListItem("All Wards", "")
            );
        }



        // ==========================================
        // LOAD SUMMARY
        // ==========================================

        private void LoadSummary()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                con.Open();


                // Total

                string totalQuery =
                    "SELECT COUNT(*) FROM Complaints";

                using (SqlCommand cmd =
                    new SqlCommand(totalQuery, con))
                {
                    lblTotalComplaints.Text =
                        Convert.ToInt32(
                            cmd.ExecuteScalar()
                        ).ToString();
                }



                // Pending

                string pendingQuery = @"
                    SELECT COUNT(*)
                    FROM Complaints
                    WHERE Status = @Status
                ";

                using (SqlCommand cmd =
                    new SqlCommand(pendingQuery, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Status",
                        "Pending"
                    );

                    lblPendingComplaints.Text =
                        Convert.ToInt32(
                            cmd.ExecuteScalar()
                        ).ToString();
                }



                // Resolved

                string resolvedQuery = @"
                    SELECT COUNT(*)
                    FROM Complaints
                    WHERE Status = @Status
                ";

                using (SqlCommand cmd =
                    new SqlCommand(resolvedQuery, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@Status",
                        "Resolved"
                    );

                    lblResolvedComplaints.Text =
                        Convert.ToInt32(
                            cmd.ExecuteScalar()
                        ).ToString();
                }
            }
        }



        // ==========================================
        // LOAD COMPLAINTS
        // ==========================================

        private void LoadComplaints()
        {
            DataTable dt =
                GetComplaints();

            int totalRecords =
                dt.Rows.Count;

            int totalPages =
                (int)Math.Ceiling(
                    (double)totalRecords / PageSize
                );


            // Prevent invalid page

            if (totalPages == 0)
            {
                CurrentPage = 1;
            }
            else if (CurrentPage > totalPages)
            {
                CurrentPage = totalPages;
            }



            // Page data

            DataTable pageTable =
                dt.Clone();

            int startIndex =
                (CurrentPage - 1) * PageSize;

            int endIndex =
                Math.Min(
                    startIndex + PageSize,
                    totalRecords
                );


            for (int i = startIndex; i < endIndex; i++)
            {
                pageTable.ImportRow(dt.Rows[i]);
            }



            // Bind complaints

            rptComplaints.DataSource =
                pageTable;

            rptComplaints.DataBind();



            // Empty state

            pnlNoComplaints.Visible =
                totalRecords == 0;



            // Record count

            lblRecordCount.Text =
                totalRecords == 1
                    ? "1 Complaint"
                    : totalRecords + " Complaints";



            // Showing text

            if (totalRecords == 0)
            {
                lblShowing.Text =
                    "Showing 0 of 0 complaints";
            }
            else
            {
                int showingFrom =
                    startIndex + 1;

                int showingTo =
                    endIndex;

                lblShowing.Text =
                    "Showing "
                    + showingFrom
                    + "–"
                    + showingTo
                    + " of "
                    + totalRecords
                    + " complaints";
            }



            // Pagination

            LoadPagination(totalPages);


            btnPrevious.Enabled =
                CurrentPage > 1;

            btnNext.Enabled =
                CurrentPage < totalPages;


            if (!btnPrevious.Enabled)
            {
                btnPrevious.CssClass =
                    "page-btn disabled";
            }
            else
            {
                btnPrevious.CssClass =
                    "page-btn";
            }


            if (!btnNext.Enabled)
            {
                btnNext.CssClass =
                    "page-btn disabled";
            }
            else
            {
                btnNext.CssClass =
                    "page-btn";
            }
        }



        // ==========================================
        // GET COMPLAINTS
        // ==========================================

        private DataTable GetComplaints()
        {
            DataTable dt =
                new DataTable();

            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        c.ComplaintID,
                        c.Title,
                        c.Description,
                        c.Priority,
                        c.Status,
                        c.CreatedDate,

                        u.FullName,

                        cat.CategoryName,

                        w.WardName

                    FROM Complaints c

                    INNER JOIN Users u
                        ON c.UserID = u.UserID

                    INNER JOIN Categories cat
                        ON c.CategoryID = cat.CategoryID

                    INNER JOIN Wards w
                        ON c.WardID = w.WardID

                    WHERE 1 = 1
                ";


                // SEARCH

                if (!string.IsNullOrWhiteSpace(txtSearch.Text))
                {
                    query += @"
                        AND
                        (
                            c.Title LIKE @Search
                            OR CAST(c.ComplaintID AS NVARCHAR(20))
                               LIKE @Search
                        )
                    ";
                }



                // STATUS

                if (!string.IsNullOrWhiteSpace(ddlStatus.SelectedValue))
                {
                    query +=
                        " AND c.Status = @Status ";
                }



                // CATEGORY

                if (!string.IsNullOrWhiteSpace(ddlCategory.SelectedValue))
                {
                    query +=
                        " AND c.CategoryID = @CategoryID ";
                }



                // WARD

                if (!string.IsNullOrWhiteSpace(ddlWard.SelectedValue))
                {
                    query +=
                        " AND c.WardID = @WardID ";
                }



                query += @"
                    ORDER BY c.CreatedDate DESC,
                             c.ComplaintID DESC
                ";



                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    if (!string.IsNullOrWhiteSpace(txtSearch.Text))
                    {
                        cmd.Parameters.AddWithValue(
                            "@Search",
                            "%" + txtSearch.Text.Trim() + "%"
                        );
                    }


                    if (!string.IsNullOrWhiteSpace(ddlStatus.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue(
                            "@Status",
                            ddlStatus.SelectedValue
                        );
                    }


                    if (!string.IsNullOrWhiteSpace(ddlCategory.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue(
                            "@CategoryID",
                            Convert.ToInt32(
                                ddlCategory.SelectedValue
                            )
                        );
                    }


                    if (!string.IsNullOrWhiteSpace(ddlWard.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue(
                            "@WardID",
                            Convert.ToInt32(
                                ddlWard.SelectedValue
                            )
                        );
                    }


                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }



        // ==========================================
        // APPLY FILTER
        // ==========================================

        protected void btnFilter_Click(
            object sender,
            EventArgs e)
        {
            CurrentPage = 1;

            LoadComplaints();
        }



        // ==========================================
        // PREVIOUS PAGE
        // ==========================================

        protected void btnPrevious_Click(
            object sender,
            EventArgs e)
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;

                LoadComplaints();
            }
        }



        // ==========================================
        // NEXT PAGE
        // ==========================================

        protected void btnNext_Click(
            object sender,
            EventArgs e)
        {
            DataTable dt =
                GetComplaints();

            int totalPages =
                (int)Math.Ceiling(
                    (double)dt.Rows.Count / PageSize
                );


            if (CurrentPage < totalPages)
            {
                CurrentPage++;

                LoadComplaints();
            }
        }



        // ==========================================
        // PAGE NUMBER
        // ==========================================

        protected void rptPages_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                CurrentPage =
                    Convert.ToInt32(
                        e.CommandArgument
                    );

                LoadComplaints();
            }
        }



        // ==========================================
        // LOAD PAGINATION
        // ==========================================

        private void LoadPagination(int totalPages)
        {
            DataTable pages =
                new DataTable();

            pages.Columns.Add(
                "PageNumber",
                typeof(int)
            );


            for (int i = 1; i <= totalPages; i++)
            {
                pages.Rows.Add(i);
            }


            rptPages.DataSource =
                pages;

            rptPages.DataBind();
        }


        // ==========================================
        // PAGE BUTTON CLASS
        // ==========================================

        protected string GetPageButtonClass(
            object pageNumber)
        {
            int page =
                Convert.ToInt32(pageNumber);

            return page == CurrentPage
                ? "page-btn active"
                : "page-btn";
        }



        // ==========================================
        // PRIORITY CLASS
        // ==========================================

        protected string GetPriorityClass(
            object priority)
        {
            string value =
                Convert.ToString(priority)
                .ToLower()
                .Trim();


            if (value == "high")
                return "high";

            if (value == "low")
                return "low";

            return "medium";
        }



        // ==========================================
        // STATUS CLASS
        // ==========================================

        protected string GetStatusClass(
            object status)
        {
            string value =
                Convert.ToString(status)
                .ToLower()
                .Trim();


            switch (value)
            {
                case "pending":
                    return "pending";

                case "accepted":
                    return "accepted";

                case "in progress":
                    return "progress";

                case "resolved":
                    return "resolved";

                case "rejected":
                    return "rejected";

                default:
                    return "default";
            }
        }



        // ==========================================
        // CITIZEN INITIAL
        // ==========================================

        protected string GetInitial(
            object fullName)
        {
            string name =
                Convert.ToString(fullName).Trim();


            if (string.IsNullOrEmpty(name))
                return "?";


            return name.Substring(0, 1).ToUpper();
        }



        // ==========================================
        // ITEM DATA BOUND
        // ==========================================

        protected void rptComplaints_ItemDataBound(
            object sender,
            RepeaterItemEventArgs e)
        {
            // Reserved for future row-level functionality.
        }
    }
}