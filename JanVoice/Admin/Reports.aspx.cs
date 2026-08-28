using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace JanVoice.Admin
{
    public partial class Reports : System.Web.UI.Page
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
                LoadCategories();

                LoadReports();
            }
        }



        // ==========================================
        // LOAD WARDS
        // ==========================================

        private void LoadWards()
        {
            ddlWard.Items.Clear();

            ddlWard.Items.Add(
                new ListItem(
                    "All Wards",
                    ""
                )
            );


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        WardID,
                        WardNumber,
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
                        while (reader.Read())
                        {
                            ddlWard.Items.Add(
                                new ListItem(
                                    "Ward " +
                                    reader["WardNumber"] +
                                    " - " +
                                    reader["WardName"],
                                    reader["WardID"].ToString()
                                )
                            );
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
            ddlCategory.Items.Clear();

            ddlCategory.Items.Add(
                new ListItem(
                    "All Categories",
                    ""
                )
            );


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        CategoryID,
                        CategoryName
                    FROM Categories
                    WHERE IsActive = 1
                    ORDER BY CategoryName;
                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ddlCategory.Items.Add(
                                new ListItem(
                                    reader["CategoryName"]
                                    .ToString(),

                                    reader["CategoryID"]
                                    .ToString()
                                )
                            );
                        }
                    }
                }
            }
        }



        // ==========================================
        // LOAD ALL REPORTS
        // ==========================================

        private void LoadReports()
        {
            DateTime? startDate;
            DateTime? endDate;

            GetReportPeriod(
                out startDate,
                out endDate
            );


            lblSelectedPeriod.Text =
                ddlPeriod.SelectedItem.Text;


            LoadSummaryStatistics(
                startDate,
                endDate
            );


            LoadStatusReport(
                startDate,
                endDate
            );


            LoadCategoryReport(
                startDate,
                endDate
            );


            LoadWardPerformance(
                startDate,
                endDate
            );


            LoadAdditionalInsights(
                startDate,
                endDate
            );
        }



        // ==========================================
        // REPORT PERIOD
        // ==========================================

        private void GetReportPeriod(
            out DateTime? startDate,
            out DateTime? endDate)
        {
            DateTime today =
                DateTime.Today;


            startDate = null;
            endDate = null;


            switch (ddlPeriod.SelectedValue)
            {
                case "ThisMonth":

                    startDate =
                        new DateTime(
                            today.Year,
                            today.Month,
                            1
                        );

                    endDate =
                        today.AddDays(1);

                    break;



                case "LastMonth":

                    DateTime lastMonth =
                        today.AddMonths(-1);

                    startDate =
                        new DateTime(
                            lastMonth.Year,
                            lastMonth.Month,
                            1
                        );

                    endDate =
                        new DateTime(
                            today.Year,
                            today.Month,
                            1
                        );

                    break;



                case "Last3Months":

                    startDate =
                        today.AddMonths(-3);

                    endDate =
                        today.AddDays(1);

                    break;



                case "ThisYear":

                    startDate =
                        new DateTime(
                            today.Year,
                            1,
                            1
                        );

                    endDate =
                        today.AddDays(1);

                    break;



                case "AllTime":

                    startDate = null;
                    endDate = null;

                    break;
            }
        }



        // ==========================================
        // SUMMARY STATISTICS
        // ==========================================

        private void LoadSummaryStatistics(
            DateTime? startDate,
            DateTime? endDate)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        COUNT(*) AS TotalComplaints,

                        SUM(
                            CASE
                                WHEN Status = 'Pending'
                                THEN 1
                                ELSE 0
                            END
                        ) AS Pending,

                        SUM(
                            CASE
                                WHEN Status = 'In Progress'
                                THEN 1
                                ELSE 0
                            END
                        ) AS InProgress,

                        SUM(
                            CASE
                                WHEN Status = 'Resolved'
                                THEN 1
                                ELSE 0
                            END
                        ) AS Resolved

                    FROM Complaints

                    WHERE
                        (@StartDate IS NULL
                         OR CreatedDate >= @StartDate)

                    AND
                        (@EndDate IS NULL
                         OR CreatedDate < @EndDate)

                    AND
                        (@WardID = ''
                         OR WardID = @WardID)

                    AND
                        (@CategoryID = ''
                         OR CategoryID = @CategoryID);

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    AddReportParameters(
                        cmd,
                        startDate,
                        endDate
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

                            lblPending.Text =
                                reader["Pending"]
                                .ToString();

                            lblInProgress.Text =
                                reader["InProgress"]
                                .ToString();

                            lblResolved.Text =
                                reader["Resolved"]
                                .ToString();
                        }
                    }
                }
            }
        }



        // ==========================================
        // STATUS REPORT
        // ==========================================

        private void LoadStatusReport(
            DateTime? startDate,
            DateTime? endDate)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        Status,

                        COUNT(*) AS Count,

                        CAST(
                            COUNT(*) * 100.0 /
                            NULLIF(
                                SUM(COUNT(*))
                                OVER(),
                                0
                            )
                            AS DECIMAL(5,1)
                        ) AS Percentage

                    FROM Complaints

                    WHERE
                        (@StartDate IS NULL
                         OR CreatedDate >= @StartDate)

                    AND
                        (@EndDate IS NULL
                         OR CreatedDate < @EndDate)

                    AND
                        (@WardID = ''
                         OR WardID = @WardID)

                    AND
                        (@CategoryID = ''
                         OR CategoryID = @CategoryID)

                    GROUP BY Status

                    ORDER BY Count DESC;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    AddReportParameters(
                        cmd,
                        startDate,
                        endDate
                    );


                    con.Open();


                    DataTable dt =
                        new DataTable();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }


                    rptStatusReport.DataSource =
                        dt;

                    rptStatusReport.DataBind();
                }
            }
        }



        // ==========================================
        // CATEGORY REPORT
        // ==========================================

        private void LoadCategoryReport(
            DateTime? startDate,
            DateTime? endDate)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        C.CategoryName,

                        COUNT(Co.ComplaintID)
                            AS ComplaintCount,

                        CAST(
                            COUNT(Co.ComplaintID) * 100.0 /
                            NULLIF(
                                SUM(
                                    COUNT(Co.ComplaintID)
                                ) OVER(),
                                0
                            )
                            AS DECIMAL(5,1)
                        ) AS Percentage

                    FROM Categories C

                    INNER JOIN Complaints Co
                        ON C.CategoryID =
                           Co.CategoryID

                    WHERE
                        (@StartDate IS NULL
                         OR Co.CreatedDate >= @StartDate)

                    AND
                        (@EndDate IS NULL
                         OR Co.CreatedDate < @EndDate)

                    AND
                        (@WardID = ''
                         OR Co.WardID = @WardID)

                    AND
                        (@CategoryID = ''
                         OR Co.CategoryID = @CategoryID)

                    GROUP BY
                        C.CategoryName

                    ORDER BY
                        ComplaintCount DESC;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    AddReportParameters(
                        cmd,
                        startDate,
                        endDate
                    );


                    con.Open();


                    DataTable dt =
                        new DataTable();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }


                    rptCategoryReport.DataSource =
                        dt;

                    rptCategoryReport.DataBind();
                }
            }
        }



        // ==========================================
        // WARD PERFORMANCE
        // ==========================================

        private void LoadWardPerformance(
            DateTime? startDate,
            DateTime? endDate)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        W.WardName,

                        COUNT(C.ComplaintID)
                            AS TotalComplaints,

                        SUM(
                            CASE
                                WHEN C.Status = 'Pending'
                                THEN 1
                                ELSE 0
                            END
                        ) AS Pending,

                        SUM(
                            CASE
                                WHEN C.Status = 'Resolved'
                                THEN 1
                                ELSE 0
                            END
                        ) AS Resolved,

                        CAST(

                            ISNULL(
                                SUM(
                                    CASE
                                        WHEN C.Status =
                                             'Resolved'
                                        THEN 1
                                        ELSE 0
                                    END
                                ) * 100.0
                                /
                                NULLIF(
                                    COUNT(C.ComplaintID),
                                    0
                                ),
                                0
                            )

                            AS DECIMAL(5,1)

                        ) AS ResolutionRate

                    FROM Wards W

                    LEFT JOIN Complaints C
                        ON W.WardID =
                           C.WardID

                    AND
                        (@StartDate IS NULL
                         OR C.CreatedDate >= @StartDate)

                    AND
                        (@EndDate IS NULL
                         OR C.CreatedDate < @EndDate)

                    AND
                        (@CategoryID = ''
                         OR C.CategoryID =
                            @CategoryID)

                    WHERE
                        (@WardID = ''
                         OR W.WardID =
                            @WardID)

                    GROUP BY

                        W.WardID,
                        W.WardName

                    ORDER BY
                        W.WardName;

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    AddReportParameters(
                        cmd,
                        startDate,
                        endDate
                    );


                    con.Open();


                    DataTable dt =
                        new DataTable();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }


                    rptWardPerformance.DataSource =
                        dt;

                    rptWardPerformance.DataBind();
                }
            }
        }



        // ==========================================
        // ADDITIONAL INSIGHTS
        // ==========================================

        private void LoadAdditionalInsights(
            DateTime? startDate,
            DateTime? endDate)
        {
            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"

                    SELECT

                        COUNT(
                            DISTINCT UserID
                        ) AS ActiveCitizens,

                        SUM(
                            CASE
                                WHEN Priority = 'High'
                                THEN 1
                                ELSE 0
                            END
                        ) AS HighPriority,

                        ISNULL(

                            AVG(

                                CASE

                                    WHEN Status =
                                         'Resolved'

                                    THEN
                                        DATEDIFF(
                                            DAY,
                                            CreatedDate,
                                            UpdatedDate
                                        )

                                END

                            ),

                            0

                        ) AS AverageResolution

                    FROM Complaints

                    WHERE
                        (@StartDate IS NULL
                         OR CreatedDate >= @StartDate)

                    AND
                        (@EndDate IS NULL
                         OR CreatedDate < @EndDate)

                    AND
                        (@WardID = ''
                         OR WardID = @WardID)

                    AND
                        (@CategoryID = ''
                         OR CategoryID = @CategoryID);

                ";


                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    AddReportParameters(
                        cmd,
                        startDate,
                        endDate
                    );


                    con.Open();


                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblActiveCitizens.Text =
                                reader["ActiveCitizens"]
                                .ToString();


                            lblHighPriority.Text =
                                reader["HighPriority"]
                                .ToString();


                            lblAverageResolution.Text =
                                reader["AverageResolution"]
                                .ToString()
                                + " Days";
                        }
                    }
                }
            }
        }



        // ==========================================
        // COMMON PARAMETERS
        // ==========================================

        private void AddReportParameters(
            SqlCommand cmd,
            DateTime? startDate,
            DateTime? endDate)
        {
            cmd.Parameters.Add(
                "@StartDate",
                SqlDbType.DateTime
            ).Value =
                startDate.HasValue
                ? (object)startDate.Value
                : DBNull.Value;


            cmd.Parameters.Add(
                "@EndDate",
                SqlDbType.DateTime
            ).Value =
                endDate.HasValue
                ? (object)endDate.Value
                : DBNull.Value;


            cmd.Parameters.Add(
                "@WardID",
                SqlDbType.NVarChar,
                20
            ).Value =
                ddlWard.SelectedValue;


            cmd.Parameters.Add(
                "@CategoryID",
                SqlDbType.NVarChar,
                20
            ).Value =
                ddlCategory.SelectedValue;
        }



        // ==========================================
        // APPLY FILTERS
        // ==========================================

        protected void btnApplyFilters_Click(
            object sender,
            EventArgs e)
        {
            LoadReports();
        }



        // ==========================================
        // STATUS DOT CLASS
        // ==========================================

        protected string GetStatusDotClass(
            object status)
        {
            string value =
                status.ToString();


            switch (value)
            {
                case "Pending":
                    return "status-dot pending-dot";

                case "Accepted":
                    return "status-dot accepted-dot";

                case "In Progress":
                    return "status-dot progress-dot";

                case "Resolved":
                    return "status-dot resolved-dot";

                default:
                    return "status-dot";
            }
        }



        // ==========================================
        // STATUS BAR CLASS
        // ==========================================

        protected string GetStatusFillClass(
            object status)
        {
            string value =
                status.ToString();


            switch (value)
            {
                case "Pending":
                    return "status-fill pending-fill";

                case "Accepted":
                    return "status-fill accepted-fill";

                case "In Progress":
                    return "status-fill progress-fill";

                case "Resolved":
                    return "status-fill resolved-fill";

                default:
                    return "status-fill";
            }
        }



        // ==========================================
        // PERFORMANCE CLASS
        // ==========================================

        protected string GetPerformanceClass(
            object value)
        {
            decimal rate;


            if (!decimal.TryParse(
                value.ToString(),
                out rate))
            {
                return "performance average";
            }


            if (rate >= 60)
            {
                return "performance good";
            }


            return "performance average";
        }



        // ==========================================
        // PERFORMANCE TEXT
        // ==========================================

        protected string GetPerformanceText(
            object value)
        {
            decimal rate;


            if (!decimal.TryParse(
                value.ToString(),
                out rate))
            {
                return "Average";
            }


            if (rate >= 60)
            {
                return "Good";
            }


            return "Average";
        }
    }
}