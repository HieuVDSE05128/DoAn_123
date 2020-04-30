using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PR3M.DBModel;

namespace PR3M.Controllers
{
    public class UsersController : Controller
    {
        private PRConnect db = new PRConnect();

        // GET: Users
        public ActionResult Index()
        {
            int? currentUserPRSystemId = ((User)Session["CurrentUserObject"]).PRSystemId;
            if (currentUserPRSystemId != null)
            {
                var users = db.Users.Where(u => u.PRSystemId == currentUserPRSystemId).Include(u => u.PRSystem).Include(u => u.Role);
                return View(users.ToList());
            }
            return RedirectToAction("Logout", "AccountController");
        }

        // GET: Users/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Users/Create
        public ActionResult Create()
        {
            int? currentUserPRSystemId = ((User)Session["CurrentUserObject"]).PRSystemId;
            //ViewBag.PRSystemId = new SelectList(db.PRSystems.Where(p => p.PRSystemId), "PRSystemId", "PRSystemName");
            if (currentUserPRSystemId != null)
            {
                PRSystem pr = db.PRSystems.Single(p => p.PRSystemId == currentUserPRSystemId);
                //Set to viewbag
                ViewBag.CurrentPRSystemId = pr.PRSystemId;
                ViewBag.CurrentPRSystemName = pr.PRSystemName;
                ViewBag.RoleId = new SelectList(db.Roles, "RoleId", "RoleName");
                ViewBag.PRSystemId = new SelectList(db.PRSystems, "PRSystemId", "PRSystemName");
                return View();
            }
            else
            {
                return RedirectToAction("Logout", "Account");
            }

        }

        // POST: Users/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "UsernameId,Email,FullName,IsActive,RoleId,PRSystemId")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.PRSystemId = new SelectList(db.PRSystems, "PRSystemId", "PRSystemName", user.PRSystemId);
            ViewBag.RoleId = new SelectList(db.Roles, "RoleId", "RoleName", user.RoleId);
            return View(user);
        }

        // GET: Users/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            ViewBag.PRSystemId = new SelectList(db.PRSystems, "PRSystemId", "PRSystemName", user.PRSystemId);
            ViewBag.RoleId = new SelectList(db.Roles, "RoleId", "RoleName", user.RoleId);
            return View(user);
        }

        // POST: Users/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "UsernameId,Email,FullName,IsActive,RoleId,PRSystemId")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.PRSystemId = new SelectList(db.PRSystems, "PRSystemId", "PRSystemName", user.PRSystemId);
            ViewBag.RoleId = new SelectList(db.Roles, "RoleId", "RoleName", user.RoleId);
            return View(user);
        }

        // GET: Users/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            User user = db.Users.Find(id);
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


        public ActionResult SearchUser(string userNameSearch)
        {
            userNameSearch = userNameSearch.Trim();
            IEnumerable<User> users = null;
            if (userNameSearch != null && userNameSearch.Length > 0)
            {
                users = db.Users.Where(u => u.FullName.Contains(userNameSearch)).Include(u => u.PRSystem).Include(u => u.Role);
            }
            else
            {
                users = db.Users.Include(u => u.PRSystem).Include(u => u.Role);
            }
            return PartialView("_DisplayUser", users);
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
