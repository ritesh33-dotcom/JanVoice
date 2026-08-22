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
    public partial class EmergencyContact : System.Web.UI.Page
    {
        // =========================================================
        // DATABASE CONNECTION
        // =========================================================

        string connectionString =
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
                LoadEmergencyContacts();
            }
        }


        // =========================================================
        // LOAD EMERGENCY CONTACTS
        // =========================================================

        private void LoadEmergencyContacts()
        {
            string query = @"
                SELECT
                    ContactID,
                    DepartmentName,
                    ContactPerson,
                    PhoneNumber,
                    Email,
                    Address,
                    IsAvailable24x7
                FROM EmergencyContacts
                WHERE IsActive = 1
                ORDER BY ContactID;
            ";


            DataTable dt = new DataTable();


            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();

                        using (SqlDataReader reader =
                               cmd.ExecuteReader())
                        {
                            dt.Load(reader);
                        }


                        // =====================================================
                        // CHECK DATA
                        // =====================================================

                        if (dt.Rows.Count > 0)
                        {
                            // Show Repeater
                            rptEmergencyContacts.Visible = true;

                            // Hide empty message
                            pnlNoEmergencyContacts.Visible = false;


                            // Bind database data
                            rptEmergencyContacts.DataSource = dt;

                            rptEmergencyContacts.DataBind();
                        }
                        else
                        {
                            // Hide Repeater
                            rptEmergencyContacts.Visible = false;

                            // Show empty message
                            pnlNoEmergencyContacts.Visible = true;
                        }
                    }
                    catch (Exception ex)
                    {
                        // =====================================================
                        // ERROR HANDLING
                        // =====================================================

                        System.Diagnostics.Debug.WriteLine(
                            "Emergency Contact Error: "
                            + ex.Message
                        );


                        // Hide Repeater
                        rptEmergencyContacts.Visible = false;

                        // Show empty message
                        pnlNoEmergencyContacts.Visible = true;
                    }
                }
            }
        }
    }
}