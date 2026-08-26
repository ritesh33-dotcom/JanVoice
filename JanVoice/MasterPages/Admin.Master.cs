using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JanVoice.Helpers;

namespace JanVoice.MasterPages
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!AuthenticationHelper.IsAdmin())
            {
                Response.Redirect("~/Login.aspx?ReturnUrl=" +
                    Server.UrlEncode(Request.RawUrl));
                return;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            AuthenticationHelper.Logout();

            Response.Redirect("~/Login.aspx");
        }
    }
}