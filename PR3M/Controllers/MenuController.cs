using PR3M.DBModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PR3M.Controllers
{
    public class MenuController : Controller
    {
        /// <summary>
        /// Class <c>GetMenuTitleById</c> trả về array menu theo id truyền vào
        /// <para>1 = Return menu manage file  
        /// <para/>2 = Return menu manage user
        /// <para/>3 = Return menu manage user for PRAdmin
        /// <para/>4 = Return menu manage system
        /// </para>
        /// </summary>
        /// <param name="id">Id menu truyền vào</param>
        /// <returns>Trả về dãy string menu theo id</returns>
        private string[] GetMenuTitleById(int id)
        {
            string[] rtnMenu = null;
            //array string is: title - menu 1 - menu 2 -...-menu n
            switch (id)
            {
                case 0:
                    
                    break;
                case 1:
                    rtnMenu = new string[] { "Quản lý tài nguyên thương hiệu", "Trang quản lý", "Quản lý trang chủ", "Thêm bài viết mới" };
                    break;
                case 2:
                    rtnMenu = new string[] { "Quản lý người dùng", "Xem danh sách người dùng", "Thêm người dùng mới" };
                    break;
                case 3:
                    rtnMenu = new string[] { "Dành cho PRAdmin", "Phê duyệt người dùng" };
                    break;
                case 4:
                    rtnMenu = new string[] { "Dành cho PRSystem", "Xem dashboard", "Xem log", "Chỉ định PRAdmin", "" };
                    break;
            }
            return rtnMenu;
        }

        private string[] GetMenuLinkById(int id)
        {
            string[] rtnLinkMenu = null;
            switch (id)
            {
                case 1:
                    rtnLinkMenu = new string[] {"","PRMain/Index", "FhoHome", "FhoHome/CreatePostMaterials" };
                    break;
                case 2:
                    rtnLinkMenu = new string[] {"","Users/Index","Users/Create"};
                    break;
                case 3:
                    rtnLinkMenu = new string[] {"","User/Edit" };
                    break;
                case 4:
                    rtnLinkMenu = new string[] {"","" };
                    break;
            }
            return rtnLinkMenu;
        }



        /// <summary>
        /// GET: Menu
        /// <para/>GET: Menu/Index
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            User CurrentUserObject = (User)Session["CurrentUserObject"];
            List<string[]> strList = new List<string[]>();
            List<string[]> strLinkList = new List<string[]>();
            //get user role id from database
            int? currentUserRoleId = CurrentUserObject.RoleId;
            //if user role id is valid
            if (currentUserRoleId != null)
            {
                // if user is super user
                if (currentUserRoleId == 0)
                {
                    strList.Add(GetMenuTitleById(1));
                    strLinkList.Add(GetMenuLinkById(1));
                    strList.Add(GetMenuTitleById(2));
                    strLinkList.Add(GetMenuLinkById(2));
                    strList.Add(GetMenuTitleById(3));
                    strLinkList.Add(GetMenuLinkById(3));
                }
                // if user is PR Admin
                if (currentUserRoleId == 1)
                {
                    // Menu Manage File + Return manage user + Return menu manage user for PRAdmin
                    strList.Add(GetMenuTitleById(1));
                    strLinkList.Add(GetMenuLinkById(1));
                    strList.Add(GetMenuTitleById(2));
                    strLinkList.Add(GetMenuLinkById(2));
                    strList.Add(GetMenuTitleById(3));
                    strLinkList.Add(GetMenuLinkById(3));
                }
                // if user is PR System Admin
                if (currentUserRoleId == 2)
                {
                    strList.Add(GetMenuTitleById(2));
                    strLinkList.Add(GetMenuLinkById(2));
                    strList.Add(GetMenuTitleById(3));
                    strLinkList.Add(GetMenuLinkById(3));
                    strList.Add(GetMenuTitleById(4));
                    strLinkList.Add(GetMenuLinkById(4));
                }
                // if user is PR Staff
                if (currentUserRoleId == 3)
                {
                    strList.Add(GetMenuTitleById(1));
                    strLinkList.Add(GetMenuLinkById(1));
                }
                ViewBag.strList = strList;
                ViewBag.strLinkList = strLinkList;
                return View();
            }
            return Redirect("Error");
        }
    }
}