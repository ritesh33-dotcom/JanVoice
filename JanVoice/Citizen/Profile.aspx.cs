using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.Citizen
{
    public partial class Profile : System.Web.UI.Page
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
                LoadWards();
                LoadProfile();
                LoadStatistics();
            }

        }
        private void LoadProfile()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"

                            SELECT

                            U.FullName,
                            U.Email,
                            U.Mobile,
                            U.Address,
                            U.ProfilePhoto,
                            U.IsActive,
                            U.CreatedDate,
                            U.WardID,

                            R.RoleName,
                            W.WardName

                            FROM Users U

                            INNER JOIN Roles R
                            ON U.RoleID = R.RoleID

                            LEFT JOIN Wards W
                            ON U.WardID = W.WardID

                            WHERE U.UserID=@UserID";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@UserID",
                    Session["UserID"]);

                con.Open();

                SqlDataReader dr =
                    cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblFullName.Text =
                        dr["FullName"].ToString();

                    lblName.Text =
                        dr["FullName"].ToString();

                    lblEmail.Text =
                        dr["Email"].ToString();

                    lblMobile.Text =
                        dr["Mobile"].ToString();

                    lblWard.Text =
                        dr["WardName"].ToString();

                    lblAddress.Text =
                        dr["Address"].ToString();

                    lblRole.Text =
                        dr["RoleName"].ToString();

                    lblRole2.Text =
                        dr["RoleName"].ToString();

                    lblCreatedDate.Text =
                        Convert.ToDateTime(dr["CreatedDate"])
                        .ToString("dd MMM yyyy");

                    lblRegistered.Text =
                        Convert.ToDateTime(dr["CreatedDate"])
                        .ToString("dd MMM yyyy");

                    lblStatus.Text =
                        Convert.ToBoolean(dr["IsActive"])
                        ? "Active"
                        : "Inactive";

                    if (dr["ProfilePhoto"] != DBNull.Value &&
                        dr["ProfilePhoto"].ToString() != "")
                    {
                        imgProfile.ImageUrl =
                            dr["ProfilePhoto"].ToString();
                    }
                    else
                    {
                        imgProfile.ImageUrl =
                            "~/Images/default-user.png";
                    }
                }

                txtFullName.Text =
                         dr["FullName"].ToString();

                txtMobile.Text =
                    dr["Mobile"].ToString();

                txtAddress.Text =
                    dr["Address"].ToString();

                ddlWard.SelectedValue =
                    dr["WardID"].ToString();

                dr.Close();
            }
            

        }

        private void LoadStatistics()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query = @"

                            SELECT

                            COUNT(*) AS TotalComplaints,

                            SUM(CASE
                            WHEN Status='Pending'
                            THEN 1 ELSE 0 END) AS Pending,

                            SUM(CASE
                            WHEN Status='In Progress'
                            THEN 1 ELSE 0 END) AS InProgress,

                            SUM(CASE
                            WHEN Status='Resolved'
                            THEN 1 ELSE 0 END) AS Resolved

                            FROM Complaints

                            WHERE UserID=@UserID";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                cmd.Parameters.AddWithValue(
                    "@UserID",
                    Session["UserID"]);

                con.Open();

                SqlDataReader dr =
                    cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblTotal.Text =
                        dr["TotalComplaints"].ToString();

                    lblPending.Text =
                        dr["Pending"] == DBNull.Value
                        ? "0"
                        : dr["Pending"].ToString();

                    lblProgress.Text =
                        dr["InProgress"] == DBNull.Value
                        ? "0"
                        : dr["InProgress"].ToString();

                    lblResolved.Text =
                        dr["Resolved"] == DBNull.Value
                        ? "0"
                        : dr["Resolved"].ToString();
                }

                dr.Close();
            }
        }

        private void LoadWards()
        {
            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                string query =
                    "SELECT WardID, WardName FROM Wards";

                SqlCommand cmd =
                    new SqlCommand(query, con);

                con.Open();

                ddlWard.DataSource =
                    cmd.ExecuteReader();

                ddlWard.DataTextField = "WardName";
                ddlWard.DataValueField = "WardID";
                ddlWard.DataBind();
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (txtFullName.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please enter Full Name.');",
                    true);

                return;
            }

            if (txtMobile.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please enter Mobile Number.');",
                    true);

                return;
            }

            if (txtAddress.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please enter Address.');",
                    true);

                return;
            }

            if (ddlWard.SelectedIndex == -1)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please select Ward.');",
                    true);

                return;
            }

            string photoPath = imgProfile.ImageUrl;

            if (fuProfile.HasFile)
            {
                string extension =
                    Path.GetExtension(fuProfile.FileName).ToLower();

                string[] allowed =
                {
        ".jpg",
        ".jpeg",
        ".png"
    };

                if (!allowed.Contains(extension))
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "alert",
                        "alert('Only JPG, JPEG and PNG files are allowed.');",
                        true);

                    return;
                }

                if (fuProfile.PostedFile.ContentLength > 2 * 1024 * 1024)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "alert",
                        "alert('Maximum image size is 2 MB.');",
                        true);

                    return;
                }

                string fileName =
                    Guid.NewGuid().ToString() + extension;

                string folder =
                    Server.MapPath("~/Uploads/ProfileImages/");

                if (!Directory.Exists(folder))
                {
                    Directory.CreateDirectory(folder);
                }

                fuProfile.SaveAs(Path.Combine(folder, fileName));

                photoPath =
                    "~/Uploads/ProfileImages/" + fileName;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"

                            UPDATE Users

                            SET

                            FullName = @FullName,
                            Mobile = @Mobile,
                            Address = @Address,
                            WardID = @WardID,
                            ProfilePhoto = @ProfilePhoto

                            WHERE UserID = @UserID";

                                SqlCommand cmd = new SqlCommand(query, con);

                                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());

                                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());

                                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());

                                cmd.Parameters.AddWithValue("@WardID", ddlWard.SelectedValue);

                                cmd.Parameters.AddWithValue("@ProfilePhoto", photoPath);

                                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                                con.Open();

                                cmd.ExecuteNonQuery();
                    ClientScript.RegisterStartupScript(
                           this.GetType(),
                           "success",
                           "alert('Profile updated successfully.');",
                           true);
                }

                LoadProfile();

               
            }

        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCurrentPassword.Text) ||
    string.IsNullOrWhiteSpace(txtNewPassword.Text) ||
    string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please fill all password fields.');",
                    true);

                return;
            }
            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('New Password and Confirm Password do not match.');",
                    true);

                return;
            }
            if (txtCurrentPassword.Text == txtNewPassword.Text)
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('New password must be different from current password.');",
                    true);

                return;
            }
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"

        SELECT PasswordHash

        FROM Users

        WHERE UserID=@UserID";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                con.Open();

                string currentPassword =
                    Convert.ToString(cmd.ExecuteScalar());

                if (currentPassword != txtCurrentPassword.Text)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "alert",
                        "alert('Current password is incorrect.');",
                        true);

                    return;
                }
                query = @"

                            UPDATE Users

                            SET PasswordHash=@Password

                            WHERE UserID=@UserID";

                cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Password", txtNewPassword.Text);

                cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                cmd.ExecuteNonQuery();
            }

            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "success",
                "alert('Password updated successfully.');",
                true);
        }
    }
}