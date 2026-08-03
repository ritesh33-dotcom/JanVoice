using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Citizen
{
    public partial class Notifications : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadNotifications();
            }

        }

        private void LoadNotifications()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"

            SELECT

                NotificationID,
                ComplaintID,
                Title,
                Message,
                NotificationType,
                IsRead,
                CreatedDate

            FROM Notifications

            WHERE UserID=@UserID

            ORDER BY CreatedDate DESC";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@UserID",
                    Convert.ToInt32(Session["UserID"]));

                SqlDataAdapter da =
                    new SqlDataAdapter(cmd);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptNotifications.DataSource = dt;
                    rptNotifications.DataBind();

                    divNoNotification.Visible = false;
                }
                else
                {
                    rptNotifications.DataSource = null;
                    rptNotifications.DataBind();

                    divNoNotification.Visible = true;
                }
            }
        }


        protected void btnOpen_Command(object sender, CommandEventArgs e)
        {
            string[] values = e.CommandArgument.ToString().Split('|');

            int notificationID = Convert.ToInt32(values[0]);

            int complaintID = Convert.ToInt32(values[1]);

            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"

            UPDATE Notifications

            SET IsRead = 1

            WHERE NotificationID = @NotificationID";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@NotificationID",
                    notificationID);

                con.Open();

                cmd.ExecuteNonQuery();
            }

            Response.Redirect(
                "ComplaintDetails.aspx?id=" + complaintID);
        }
    }
}