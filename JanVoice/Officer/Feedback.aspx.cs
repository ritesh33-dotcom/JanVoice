using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Officer
{
    public partial class Feedback : System.Web.UI.Page
    {
        // =========================================================
        // DATABASE CONNECTION
        // =========================================================

        private readonly string connectionString =
            ConfigurationManager
            .ConnectionStrings["JanVoiceDB"]
            .ConnectionString;


        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            // Officer login check
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblFeedbackMessage.Visible = false;
            }
        }


        // =========================================================
        // SUBMIT FEEDBACK
        // =========================================================

        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {
            lblFeedbackMessage.Visible = false;


            // =====================================================
            // GET FORM VALUES
            // =====================================================

            string name = txtName.Text.Trim();

            string email = txtEmail.Text.Trim();

            string category =
                ddlFeedbackCategory.SelectedValue.Trim();

            string subject =
                txtSubject.Text.Trim();

            string message =
                txtMessage.Text.Trim();


            // =====================================================
            // VALIDATION
            // =====================================================

            if (string.IsNullOrWhiteSpace(name))
            {
                ShowError("Please enter your name.");
                return;
            }

            if (string.IsNullOrWhiteSpace(email))
            {
                ShowError("Please enter your email address.");
                return;
            }

            if (string.IsNullOrWhiteSpace(category))
            {
                ShowError("Please select a feedback category.");
                return;
            }

            if (string.IsNullOrWhiteSpace(subject))
            {
                ShowError("Please enter the feedback subject.");
                return;
            }

            if (string.IsNullOrWhiteSpace(message))
            {
                ShowError("Please enter your feedback.");
                return;
            }


            // =====================================================
            // GET RATING
            // =====================================================

            int rating = GetSelectedRating();

            if (rating == 0)
            {
                ShowError("Please select your overall experience.");
                return;
            }


            // =====================================================
            // GET USER ID
            // =====================================================

            object userID = DBNull.Value;

            int parsedUserID;

            if (Session["UserID"] != null &&
                int.TryParse(
                    Session["UserID"].ToString(),
                    out parsedUserID))
            {
                userID = parsedUserID;
            }


            // =====================================================
            // INSERT QUERY
            // =====================================================

            string query = @"
                INSERT INTO dbo.Feedback
                (
                    UserID,
                    Name,
                    Email,
                    FeedbackCategory,
                    Rating,
                    Subject,
                    Message,
                    Status,
                    FeedbackDate
                )
                VALUES
                (
                    @UserID,
                    @Name,
                    @Email,
                    @FeedbackCategory,
                    @Rating,
                    @Subject,
                    @Message,
                    @Status,
                    GETDATE()
                );
            ";


            // =====================================================
            // DATABASE CONNECTION
            // =====================================================

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    // -------------------------------------------------
                    // PARAMETERS
                    // -------------------------------------------------

                    cmd.Parameters.Add(
                        "@UserID",
                        SqlDbType.Int
                    ).Value = userID;


                    cmd.Parameters.Add(
                        "@Name",
                        SqlDbType.NVarChar,
                        150
                    ).Value = name;


                    cmd.Parameters.Add(
                        "@Email",
                        SqlDbType.NVarChar,
                        200
                    ).Value = email;


                    cmd.Parameters.Add(
                        "@FeedbackCategory",
                        SqlDbType.NVarChar,
                        50
                    ).Value = category;


                    cmd.Parameters.Add(
                        "@Rating",
                        SqlDbType.Int
                    ).Value = rating;


                    cmd.Parameters.Add(
                        "@Subject",
                        SqlDbType.NVarChar,
                        250
                    ).Value = subject;


                    cmd.Parameters.Add(
                        "@Message",
                        SqlDbType.NVarChar
                    ).Value = message;


                    cmd.Parameters.Add(
                        "@Status",
                        SqlDbType.NVarChar,
                        30
                    ).Value = "Pending";


                    // =================================================
                    // EXECUTE
                    // =================================================

                    try
                    {
                        con.Open();

                        int result =
                            cmd.ExecuteNonQuery();


                        // =================================================
                        // SUCCESS
                        // =================================================

                        if (result > 0)
                        {
                            ShowSuccess(
                                "Feedback submitted successfully! Thank you for your valuable feedback."
                            );

                            ClearFeedbackForm();
                        }
                        else
                        {
                            ShowError(
                                "Feedback could not be submitted."
                            );
                        }
                    }
                    catch (SqlException ex)
                    {
                        // =============================================
                        // DATABASE ERROR
                        // =============================================

                        System.Diagnostics.Debug.WriteLine(
                            "FEEDBACK SQL ERROR: "
                            + ex.ToString()
                        );

                        ShowError(
                            "Database error: "
                            + ex.Message
                        );
                    }
                    catch (Exception ex)
                    {
                        // =============================================
                        // GENERAL ERROR
                        // =============================================

                        System.Diagnostics.Debug.WriteLine(
                            "FEEDBACK ERROR: "
                            + ex.ToString()
                        );

                        ShowError(
                            "Error: "
                            + ex.Message
                        );
                    }
                }
            }
        }


        // =========================================================
        // GET SELECTED RATING
        // =========================================================

        private int GetSelectedRating()
        {
            if (rbVeryPoor.Checked)
                return 1;

            if (rbPoor.Checked)
                return 2;

            if (rbAverage.Checked)
                return 3;

            if (rbGood.Checked)
                return 4;

            if (rbExcellent.Checked)
                return 5;

            return 0;
        }


        // =========================================================
        // CLEAR FORM
        // =========================================================

        private void ClearFeedbackForm()
        {
            txtName.Text = "";

            txtEmail.Text = "";

            ddlFeedbackCategory.SelectedIndex = 0;

            rbVeryPoor.Checked = false;

            rbPoor.Checked = false;

            rbAverage.Checked = false;

            rbGood.Checked = false;

            rbExcellent.Checked = false;

            txtSubject.Text = "";

            txtMessage.Text = "";
        }


        // =========================================================
        // SUCCESS MESSAGE
        // =========================================================

        private void ShowSuccess(string message)
        {
            lblFeedbackMessage.Text = message;

            lblFeedbackMessage.CssClass =
                "feedback-message feedback-success";

            lblFeedbackMessage.Visible = true;
        }


        // =========================================================
        // ERROR MESSAGE
        // =========================================================

        private void ShowError(string message)
        {
            lblFeedbackMessage.Text = message;

            lblFeedbackMessage.CssClass =
                "feedback-message feedback-error";

            lblFeedbackMessage.Visible = true;
        }


        // =========================================================
        // RESET BUTTON
        // =========================================================

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearFeedbackForm();

            lblFeedbackMessage.Visible = false;
        }
    }
}