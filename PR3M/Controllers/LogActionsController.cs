using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PR3M.DBModel;
using PR3M.Models;

namespace PR3M.Controllers
{
    public class LogActionsController : Controller
    {
        private PRConnect db = new PRConnect();

        // GET: LogActions
        public ActionResult Index(string sortOrder, string currentFilter, string searchString, int? page)
        {
            var logActions = db.LogActions.Include(l => l.LogActionType);
            List<LogViewModels> logs = new List<LogViewModels>();
            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }
            switch (sortOrder)
            {
                default:

                    break;
            }
            foreach(LogAction la in logActions)
            {
                string ObjectName = "";
                string ObjectType = "";
                /**
                 * 1 is Post 
                 * 2 is Material
                 */
                switch (la.LogObjectType)
                {
                    case 1:
                        ObjectName = db.Posts.Find(la.LogObjectId).PostTitle;
                        ObjectType = "Tài nguyên - Chủ đề";
                        break;
                    case 2:
                        ObjectName = db.Materials.Find(la.LogObjectId).MaterialDisplayName;
                        ObjectType = "Tài nguyên - File";
                        break;
                }
                LogViewModels lvm = new LogViewModels()
                {
                    LogId = la.LogActionId,
                    UsernameId = la.LogCreateBy,
                    UserFullName = db.Users.Find(la.LogCreateBy).FullName,
                    ActionName = la.LogActionType.LogActionTypeName,
                    ObjectName = ObjectName,
                    ObjectType = ObjectType,
                    ActionTime = la.LogActionTime,
                };
                logs.Add(lvm);
            }
            return View(logs);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
