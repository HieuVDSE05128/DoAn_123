using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PR3M.Controllers
{
    public class ErrorController : Controller
    {
        // GET: Error
        public ActionResult Index(string Error)
        {
            ViewBag.Error = Error;
            return View();
        }
    }
}