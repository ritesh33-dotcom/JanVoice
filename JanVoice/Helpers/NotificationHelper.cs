using System;
using System.Configuration;
using System.Data.SqlClient;

namespace JanVoice.Helpers
{
    public class NotificationHelper
    {
        public static void AddNotification(
            int userID,
            int complaintID,
            string title,
            string message,
            string notificationType)
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["JanVoiceDB"].ConnectionString;

            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"

                    INSERT INTO Notifications
                    (
                        UserID,
                        ComplaintID,
                        Title,
                        Message,
                        NotificationType,
                        IsRead,
                        CreatedDate
                    )

                    VALUES
                    (
                        @UserID,
                        @ComplaintID,
                        @Title,
                        @Message,
                        @NotificationType,
                        0,
                        GETDATE()
                    )";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@UserID", userID);

                cmd.Parameters.AddWithValue("@ComplaintID", complaintID);

                cmd.Parameters.AddWithValue("@Title", title);

                cmd.Parameters.AddWithValue("@Message", message);

                cmd.Parameters.AddWithValue("@NotificationType", notificationType);

                con.Open();

                cmd.ExecuteNonQuery();
            }
        }
    }
}