using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PR3M.Controllers
{
    public class HomeLoggedController : Controller
    {
        // GET: HomeLogged
        public ActionResult Index()
        {
            return View();
        }
    }
}