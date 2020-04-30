using PR3M.DBModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PR3M.Controllers
{
    public class BaseController : Controller
    {
        protected User CurrentUser
        {
            get; set;
            //get
            //{
            //    if (!IsActive) return null;
            //    using (var contextDb = new PRconnect())
            //    {
            //        return contextDb.Users.FirstOrDefault(m => m.UsernameId.Equals(Session["currentUser"]));
            //    }
            //}

        }

        protected bool IsActive => Session["currentUser"] != null;


        public BaseController() : base()
        {

        }
    }
}