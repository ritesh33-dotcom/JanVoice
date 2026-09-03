using JanVoice.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JanVoice.MasterPages
{
    public partial class Citizen : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!AuthenticationHelper.IsLoggedIn())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!AuthenticationHelper.IsCitizen())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Session.Abandon();

            Response.Redirect("~/Login.aspx");


        }
    }
}