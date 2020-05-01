using PR3M.Common;
using PR3M.DBModel;
using PR3M.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PR3M.Controllers
{
    public class PRMainController : Controller
    {
        private PRConnect db = new PRConnect();
        // GET: PRMain
        public ActionResult Index(int? FolderId, bool? ViewHidden, string gsearch)
        {
            MaterialsFullControllViewModels m = new MaterialsFullControllViewModels();
            string username = Session["currentUser"].ToString();
            m.Users = db.Users.Find(username);
            Session["currentUserFullName"] = m.Users.FullName;
            Session["FirstTimeCreateFolder"] = false;
            if (FolderId == null || FolderId == 0)
            {
                //Lay ra folder goc theo PRSystemID cua nguoi dung
                m.CurrentFolder = db.Folders.Single(p => p.ParrentId == 0 && p.PRSystemId == m.Users.PRSystemId);

                //Lay ra cac thu muc con trong thu muc hien tai
                m.FoldersInside = db.Folders.Where(p => p.ParrentId == m.CurrentFolder.FolderId);

                Session["ParentId"] = m.CurrentFolder.FolderId;
            }
            else
            {
                //Lay ra folder hien tai ma nguoi dung truy cap vao
                m.CurrentFolder = db.Folders.Single(p => p.FolderId == FolderId && p.PRSystemId == m.Users.PRSystemId);

                //Lay ra cac thu muc con trong thu muc hien tai
                m.FoldersInside = db.Folders.Where(p => p.ParrentId == FolderId && p.PRSystemId == m.Users.PRSystemId);

                Session["ParentId"] = FolderId;
            }
            if (gsearch != null && gsearch.Length > 0)
            {
                Session["gsearch"] = gsearch;
                var FileInDBs = m.CurrentFolder.FileInDBs.ToList();
                m.CurrentFolder.FileInDBs = FileInDBs.Where(x => (x.FileName + "." + x.MIMEType).ToLower().Contains(gsearch.Trim().ToLower()) || x.User.FullName.ToLower().Contains(gsearch.Trim().ToLower())).ToList();
            }
            else
            {
                Session["gsearch"] = "";
            }
            if (ViewHidden != null)
            {
                ViewBag.ViewHidden = ViewHidden;
            }
            else
            {
                ViewBag.ViewHidden = false;
            }
            Session["SystemId"] = m.Users.PRSystemId;
            return View(m);
            //return null;
        }

        public ActionResult DataPartial(int? FolderId, bool? ViewHidden, string gsearch)
        {
            MaterialsFullControllViewModels m = new MaterialsFullControllViewModels();
            string username = Session["currentUser"].ToString();
            m.Users = db.Users.Find(username);
            Session["currentUserFullName"] = m.Users.FullName;
            Session["FirstTimeCreateFolder"] = false;
            if (FolderId == null || FolderId == 0)
            {
                //Lay ra folder goc theo PRSystemID cua nguoi dung
                m.CurrentFolder = db.Folders.Single(p => p.ParrentId == 0 && p.PRSystemId == m.Users.PRSystemId);

                //Lay ra cac thu muc con trong thu muc hien tai
                m.FoldersInside = db.Folders.Where(p => p.ParrentId == m.CurrentFolder.FolderId);

                Session["ParentId"] = m.CurrentFolder.FolderId;
            }
            else
            {
                //Lay ra folder hien tai ma nguoi dung truy cap vao
                m.CurrentFolder = db.Folders.Single(p => p.FolderId == FolderId && p.PRSystemId == m.Users.PRSystemId);

                //Lay ra cac thu muc con trong thu muc hien tai
                m.FoldersInside = db.Folders.Where(p => p.ParrentId == FolderId && p.PRSystemId == m.Users.PRSystemId);

                Session["ParentId"] = FolderId;
            }
            if (gsearch != null && gsearch.Length > 0)
            {
                Session["gsearch"] = gsearch;
                var FileInDBs = m.CurrentFolder.FileInDBs.ToList();
                m.CurrentFolder.FileInDBs = FileInDBs.Where(x => (x.FileName + "." + x.MIMEType).ToLower().Contains(gsearch.Trim().ToLower()) || x.User.FullName.ToLower().Contains(gsearch.Trim().ToLower())).ToList();
            }
            else
            {
                Session["gsearch"] = "";
            }
            if (ViewHidden != null)
            {
                ViewBag.ViewHidden = ViewHidden;
            }
            else
            {
                ViewBag.ViewHidden = false;
            }
            Session["SystemId"] = m.Users.PRSystemId;
            m.CurrentFolder.FileInDBs = m.CurrentFolder.FileInDBs.Where(x => x.IsDelete == false).ToList();
            return PartialView("DataPartial", m);
        }

        //public ActionResult PostDisplayAll(int? PostId, int? route, bool? ViewHidden, bool isSubfolder)
        //{
        //    MaterialsFullControllViewModels m = new MaterialsFullControllViewModels();
        //    string username = Session["currentUser"].ToString();
        //    m.Users = db.Users.Find(username);
        //    Session["currentUserFullName"] = m.Users.FullName;
        //    Session["FirstTimeCreateFolder"] = false;
        //    var materials = new List<Material>();
        //    if (!route.HasValue)
        //    {
        //        if (PostId.HasValue)
        //        {
        //            m.post = db.Posts.Find(PostId);
        //            m.Posts = db.Posts.Where(p => p.IsInLogoPost == m.post.IsInLogoPost);
        //        }
        //        else
        //        {
        //            return RedirectToAction("Index");
        //        }
        //    }
        //    else if (route == 1)
        //    {
        //        m.post = new Post();
        //        m.Posts = isSubfolder ? db.Posts.Where(p => p.IsInLogoPost == false && p.PostId != 0 && p.PostId == PostId && p.IsDelete == false)
        //            : db.Posts.Where(p => p.IsInLogoPost == false && p.PostId != 0 && p.IsDelete == false);
        //        if (ViewHidden == false || ViewHidden == null)
        //        {
        //            foreach (var item in m.Posts)
        //            {
        //                var materialList = db.Materials.Where(t => t.PostId == item.PostId && t.IsDelete == false && t.IsHilde == false).ToList();
        //                materials.AddRange(materialList);
        //            }
        //        }
        //        else
        //        {
        //            foreach (var item in m.Posts)
        //            {
        //                var materialList = db.Materials.Where(t => t.PostId == item.PostId && t.IsDelete == false && t.IsHilde == true).ToList();
        //                materials.AddRange(materialList);
        //            }
        //        }
        //    }
        //    else if (route == 2)
        //    {
        //        m.post = new Post();
        //        m.Posts = isSubfolder ? db.Posts.Where(p => p.IsInLogoPost == true && p.PostId == PostId && p.PostId != 0 && p.IsDelete == false)
        //            : db.Posts.Where(p => p.IsInLogoPost == true && p.PostId != 0 && p.IsDelete == false);
        //        if (ViewHidden == false || ViewHidden == null)
        //        {
        //            foreach (var item in m.Posts)
        //            {
        //                var materialList = db.Materials.Where(t => t.PostId == item.PostId && t.IsDelete == false && t.IsHilde == false).ToList();
        //                materials.AddRange(materialList);
        //            }
        //        }
        //        else
        //        {
        //            foreach (var item in m.Posts)
        //            {
        //                var materialList = db.Materials.Where(t => t.PostId == item.PostId && t.IsDelete == false && t.IsHilde == true).ToList();
        //                materials.AddRange(materialList);
        //            }

        //        }
        //    }
        //    if (ViewHidden == null)
        //    {
        //        ViewBag.ViewHidden = false;
        //    }
        //    else
        //    {
        //        if (ViewHidden == true)
        //        {
        //            ViewBag.ViewHidden = false;
        //        }
        //        else
        //        {
        //            ViewBag.ViewHidden = true;
        //        }
        //    }

        //    if (isSubfolder)
        //    {
        //        m.Posts = null;
        //    }

        //    ViewBag.PostId = PostId;
        //    ViewBag.Route = route;
        //    ViewBag.Materials = materials;
        //    ViewBag.IsSubFolder = isSubfolder;
        //    Session["SystemId"] = m.Users.PRSystemId;

        //    return View(m);
        //}

        //[HttpPost]
        //public ActionResult SearchFile(int? PostId, string searchKey, int route, bool isSubfolder)
        //{
        //    MaterialsFullControllViewModels m = new MaterialsFullControllViewModels();
        //    string username = Session["currentUser"].ToString();
        //    m.Users = db.Users.Find(username);
        //    searchKey = searchKey.Trim();
        //    var materials = new List<Material>();
        //    if (route == 1)
        //    {
        //        m.post = new Post();
        //        m.Posts = isSubfolder ? db.Posts.Where(p => p.IsInLogoPost == false && p.PostId != 0 && p.PostId == PostId && p.IsDelete == false)
        //            : db.Posts.Where(p => p.IsInLogoPost == false && p.PostId != 0 && p.IsDelete == false);
        //        if (string.IsNullOrWhiteSpace(searchKey))
        //        {
        //            foreach (var item in m.Posts)
        //            {
        //                var materialList = db.Materials.Where(t => t.PostId == item.PostId && t.IsDelete == false && t.IsHilde == false).ToList();
        //                materials.AddRange(materialList);
        //            }
        //        }
        //        else
        //        {
        //            foreach (var item in m.Posts)
        //            {
        //                var materialList = db.Materials.Where(t => t.PostId == item.PostId && t.IsDelete == false && t.IsHilde == false && t.MaterialDisplayName.ToLower().Contains(searchKey.ToLower())).ToList();
        //                materials.AddRange(materialList);
        //            }
        //        }
        //    }
        //    else
        //    {
        //        m.post = new Post();
        //        m.Posts = isSubfolder ? db.Posts.Where(p => p.IsInLogoPost == true && p.PostId == PostId && p.PostId != 0 && p.IsDelete == false)
        //            : db.Posts.Where(p => p.IsInLogoPost == true && p.PostId != 0 && p.IsDelete == false);
        //        if (string.IsNullOrWhiteSpace(searchKey))
        //        {
        //            foreach (var item in m.Posts)
        //            {
        //                var materialList = db.Materials.Where(t => t.PostId == item.PostId && t.IsDelete == false && t.IsHilde == false).ToList();
        //                materials.AddRange(materialList);
        //            }
        //        }
        //        else
        //        {
        //            foreach (var item in m.Posts)
        //            {
        //                var materialList = db.Materials.Where(t => t.PostId == item.PostId && t.IsDelete == false && t.IsHilde == false && t.MaterialDisplayName.ToLower().Contains(searchKey.ToLower())).ToList();
        //                materials.AddRange(materialList);
        //            }
        //        }
        //    }

        //    ViewBag.ViewHidden = false;

        //    if (isSubfolder)
        //    {
        //        m.Posts = null;
        //    }

        //    ViewBag.PostId = PostId;
        //    ViewBag.Route = route;
        //    ViewBag.Materials = materials;
        //    ViewBag.IsSubFolder = isSubfolder;
        //    Session["SystemId"] = m.Users.PRSystemId;
        //    TempData["searchResult"] = true;
        //    TempData["searchKey"] = searchKey;

        //    return View("PostDisplayAll", m);
        //}

        public FileResult Download(int MaterialsId)
        {
            string MaterialFullPath = CommonOutput.GetFullPathFile(MaterialsId);
            var FileVirualPath = CommonDataVariable.BaseDirectoryOfFolderAndFile + MaterialFullPath;
            return File(FileVirualPath, "application/force- download", Path.GetFileName(FileVirualPath));
        }

        public ActionResult Hide(int materialId, int postId, int route, bool isSubFolder)
        {
            var material = db.Materials.FirstOrDefault(t => t.MaterialId == materialId);
            material.IsHilde = true;
            db.Entry(material).State = EntityState.Modified;
            db.SaveChanges();

            return RedirectToAction("PostDisplayAll", new { PostId = postId, route = route, isSubfolder = isSubFolder });
        }

        //public ActionResult CreateFolder(string folderNameInput, int route)
        //{
        //    //---Add information to Database
        //    //1.1 Get current user send request create post
        //    //string user = Session["currentUser"].ToString();
        //    string username = Session["currentUser"].ToString();
        //    User u = db.Users.Find(username);
        //    folderNameInput = folderNameInput.Trim();
        //    //1.2 Check if exits post has same name or not
        //    if (db.Posts.Any(t => t.PostTitle.ToLower().Equals(folderNameInput.ToLower())))
        //    {
        //        TempData["errorMessage"] = "Thư mục này đã tồn tại!";
        //        return RedirectToAction("Index");
        //    }
        //    var post = new Post
        //    {
        //        PostTitle = folderNameInput,
        //        CreateBy = username,
        //        PRSystemId = u.PRSystemId,
        //        PostHashRealFolder = folderNameInput,
        //        LaunchedDate = DateTime.Now,
        //        IsDelete = false,
        //        IsHide = false,
        //        IsPublic = true,
        //        IsInLogoPost = route == 2,
        //        Position = route == 2 ? db.Posts.Where(t => t.IsInLogoPost).OrderByDescending(t => t.PostId).Select(t => t.Position).FirstOrDefault() + 1
        //                                : db.Posts.Where(t => t.IsInLogoPost == false).OrderByDescending(t => t.PostId).Select(t => t.Position).FirstOrDefault() + 1,
        //    };
        //    db.Posts.Add(post);
        //    db.SaveChanges();
        //    //LogActionDAO logActionDAO = new LogActionDAO();
        //    //logActionDAO.SaveLogFolder(currentFolderId, "Add post", DateTime.Now, username);
        //    //logActionDAO.SaveLogFolder(post.FolderId, "Create", DateTime.Now, username);
        //    //2.1 Get full path from Root -> to Directory
        //    //string path = CommonOutput.GetFullPathFolder(currentFolderId);
        //    //2.2 Get full path from Content -> Root
        //    //path = CommonDataVariable.BaseDirectoryPath + path;
        //    //2.3 Get full path from Local Disk to  Project and to Content
        //    //path = Server.MapPath("~/" + path);
        //    //Directory.CreateDirectory(path + "/" + folderNameInput);
        //    //if (folderNameInput != null && currentFolderId > 0 && userCreateId != null)
        //    //{
        //    //    Folder f = new Folder()
        //    //    {

        //    //    }
        //    //}

        //    TempData["message"] = "Tạo thư mục mới thành công!";

        //    return RedirectToAction("PostDisplayAll", new { route = route, isSubFolder = false });
        //}

        [HttpPost]
        public ActionResult CreateFolder(string folderNameInput, int currentFolderId)
        {
            //check if folderNameInput == null
            if (folderNameInput == null)
            {
                ViewBag.Message = "Null";
                return Redirect("Index?FolderId=" + currentFolderId);
            }
            //---Create new folder in directory

            //1.1 Get current user send request create folder
            //string user = Session["currentUser"].ToString();
            string username = Session["currentUser"].ToString();
            User u = db.Users.Find(username);

            //2.1 Get full path from Root -> to Directory
            string path = CommonOutput.GetFullPathFolder(currentFolderId);
            //2.2 Get full path from Content -> Root
            path = CommonDataVariable.BaseDirectoryOfFolderAndFile + path;
            //2.3 Get full path from Local Disk to  Project and to Content
            path = Server.MapPath(path);
            Directory.CreateDirectory(path + "\\" + folderNameInput);

            //---Add information to Database
            //1.2 Check if exits folder has same name or not
            var Folders = db.Folders.Where(p => p.PRSystemId == u.PRSystemId);
            if (Folders.Any(f => f.FolderName == folderNameInput))
            {
                //if exists
                return Redirect("Index?FolderId=" + currentFolderId);
            }
            else
            {
                //if not exitst => create new folder
                Folder folder = new Folder
                {
                    FolderId = 0,
                    FolderName = folderNameInput,
                    CreateBy = username,
                    CreateTime = DateTime.Now,
                    IsDelete = false,
                    PRSystemId = u.PRSystemId,
                    ParrentId = currentFolderId
                };
                db.Folders.Add(folder);
                db.SaveChanges();
            }
            TempData["message"] = "Tạo folder mới thành công!";
            return Redirect("Index?FolderId=" + currentFolderId);
        }

        [HttpPost]
        public ActionResult UploadFile(int currentFolderId, IEnumerable<HttpPostedFileBase> fileInput)
        {
            if (fileInput.Count() > 0)
            {
                bool uploadSuccess = false;
                Folder f = db.Folders.Single(p => p.FolderId == currentFolderId);
                var folderName = f.FolderName;

                var savedPath = Server.MapPath(CommonDataVariable.BaseDirectoryOfFolderAndFile + CommonOutput.GetFullPathFolder(f.FolderId) + "/");
                foreach (var item in fileInput)
                {
                    if (item == null) continue;
                    var filePath = Path.Combine(savedPath, item.FileName);
                    item.SaveAs(filePath);
                    FileInfo file = new FileInfo(filePath);
                    if (!string.IsNullOrEmpty(file.Extension))
                    {
                        string username = Session["currentUser"].ToString();
                        FileInDB newMaterial = new FileInDB()
                        {
                            FileName = file.Name.Replace(file.Extension, ""),
                            FolderId = currentFolderId,
                            LaunchedDate = DateTime.Now,
                            IsHide = false,
                            IsDelete = false,
                            MIMEType = file.Extension.Replace(".", ""),
                            LaunchedBy = username,
                            LastEditBy = username,
                            LastEditTime = DateTime.Now,

                        };
                        db.FileInDBs.Add(newMaterial);
                        db.SaveChanges();
                        uploadSuccess = true;
                    }
                }

                if (uploadSuccess)
                    TempData["message"] = "Tải file mới thành công!";
                else
                    TempData["ErrorMessage"] = "chưa nhập file";
            }
            else
            {
                TempData["ErrorMessage"] = "chưa nhập file";
            }


            return RedirectToAction("Index", new { FolderId = currentFolderId });
        }

        [HttpPost]
        public ActionResult EditFile(int fileId, HttpPostedFileBase fileInput)
        {
            var file = db.FileInDBs.Find(fileId);
            if (fileInput != null && fileInput.ContentLength > 0 && file != null)
            {


                Folder f = db.Folders.Single(p => p.FolderId == file.FolderId);
                var folderName = f.FolderName;

                var savedPath = Server.MapPath(CommonDataVariable.BaseDirectoryOfFolderAndFile + CommonOutput.GetFullPathFolder(f.FolderId) + "/");
                var filePath = Path.Combine(savedPath, fileInput.FileName);
                fileInput.SaveAs(filePath);

                System.IO.File.Delete(savedPath + file.FileName + "." + file.MIMEType);

                FileInfo FileInServer = new FileInfo(filePath);
                file.FileName = FileInServer.Name.Split('.').First();
                file.MIMEType = FileInServer.Extension.Split('.').Last();
                db.Entry(file).State = EntityState.Modified;
                db.SaveChanges();
                TempData["message"] = "Tải file mới thành công!";
            }
            else
            {
                TempData["ErrorMessage"] = "chưa nhập file";
            }


            return RedirectToAction("Index", new { FolderId = file.FolderId });
        }

        ////---------------Interactive with post
        public void UploadFolder(HttpPostedFileBase uploadFolder)
        {
            try
            {
                if (uploadFolder != null && uploadFolder.ContentLength > 0)
                {
                    var route = Convert.ToInt32(Session["route"]);
                    var folderLocation = uploadFolder.FileName;
                    var folderName = folderLocation.Split('/')[0].Trim();
                    var fileName = folderLocation.Split('/')[1].Trim();
                    //đường dẫn file trong post mới
                    var savedPath = "";
                    if (route == 2)
                    {
                        if (!Directory.Exists(Server.MapPath("~/Content/Materials/Root/Logo/" + folderName)))
                        {
                            Directory.CreateDirectory(Server.MapPath("~/Content/Materials/Root/Logo/" + folderName));
                        }
                        savedPath = Server.MapPath("~/Content/Materials/Root/Logo/" + folderLocation);
                    }
                    else
                    {
                        if (!Directory.Exists(Server.MapPath("~/Content/Materials/Root/Post/" + folderName)))
                        {
                            Directory.CreateDirectory(Server.MapPath("~/Content/Materials/Root/Post/" + folderName));
                        }
                        savedPath = Server.MapPath("~/Content/Materials/Root/Post/" + folderLocation);
                    }
                    var actionUsername = Session["currentUser"].ToString();
                    //var parentId = Convert.ToInt32(Session["ParentId"]);

                    //Thêm folder vào db
                    var isExistFolder = db.Posts.Any(t => t.PostTitle.ToLower().Equals(folderName.ToLower()));
                    if (!isExistFolder)
                    {
                        bool isLogo = route == 2;
                        int position = isLogo
                            ? db.Posts.Where(t => t.IsInLogoPost).OrderByDescending(t => t.PostId).Select(t => t.Position).FirstOrDefault() + 1
                            : db.Posts.Where(t => !t.IsInLogoPost).OrderByDescending(t => t.PostId).Select(t => t.Position).FirstOrDefault() + 1;
                        var newFolder = new Post()
                        {
                            PostTitle = folderName,
                            PostHashRealFolder = folderName,
                            CreateBy = actionUsername,
                            PRSystemId = Convert.ToInt32(Session["SystemId"]),
                            LaunchedDate = DateTime.Now,
                            IsDelete = false,
                            IsHide = false,
                            IsPublic = true,
                            IsInLogoPost = isLogo,
                            Position = position
                        };

                        db.Posts.Add(newFolder);
                        db.SaveChanges();
                    }

                    uploadFolder.SaveAs(savedPath);
                    //Thêm material vào db
                    FileInfo file = new FileInfo(savedPath);
                    if (!string.IsNullOrEmpty(file.Extension))
                    {
                        int lastFolderId = db.Posts.OrderByDescending(t => t.PostId).Select(t => t.PostId).FirstOrDefault();
                        int materialPosition = 1;
                        var newPost = db.Materials.Any(t => t.PostId == lastFolderId);
                        if (newPost)
                        {
                            materialPosition = Convert.ToInt32(db.Materials.Where(t => t.PostId == lastFolderId)
                                .OrderByDescending(t => t.PositionInFolder).Select(t => t.PositionInFolder).FirstOrDefault() + 1);
                        }
                        var newMaterial = new Material()
                        {
                            MaterialName = file.Name.Replace(file.Extension, ""),
                            PostId = lastFolderId,
                            LaunchedDate = DateTime.Now,
                            IsHilde = false,
                            IsDelete = false,
                            MIMEType = file.Extension.Replace(".", ""),
                            CreateBy = actionUsername,
                            PositionInFolder = materialPosition,
                            MaterialDisplayName = file.Name
                        };

                        db.Materials.Add(newMaterial);
                        db.SaveChanges();
                    }

                    TempData["message"] = "Tải thư mục mới thành công!";
                }
            }
            catch (Exception ex)
            {
                using (var writer = System.IO.File.AppendText(Server.MapPath("~/LogError/logfile.txt")))
                {
                    writer.WriteLine(ex.Message + "Time: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"));

                }
            }
        }

        public string GetFolderName(int postId)
        {
            return db.Posts.Where(t => t.PostId == postId).Select(t => t.PostTitle).FirstOrDefault();
        }

        [HttpPost]
        public ActionResult DeleteFolder(int postId, int route)
        {
            try
            {
                //Xoá tất cả file trong post
                var files = db.Materials.Where(t => t.PostId == postId).ToList();
                foreach (var item in files)
                {
                    item.IsDelete = true;
                    db.Entry(item).State = EntityState.Modified;
                }
                db.SaveChanges();

                //Xoá folder
                var folder = db.Posts.FirstOrDefault(t => t.PostId == postId);
                if (folder != null)
                {
                    folder.IsDelete = true;
                    db.Entry(folder).State = EntityState.Modified;
                    db.SaveChanges();
                }

                TempData["message"] = "Xóa folder thành công!";
            }
            catch (Exception ex)
            {
                using (var writer = System.IO.File.AppendText(Server.MapPath("~/LogError/logfile.txt")))
                {
                    writer.WriteLine(ex.Message);
                }
            }

            return RedirectToAction("PostDisplayAll", new { route = route, isSubFolder = false });
        }


        [HttpPost]
        public ActionResult DeleteMaterial(int MaterialId, int currentFolderId, int route, bool viewHidden, bool isSubFolder)
        {
            //Get material
            Material m = db.Materials.Find(MaterialId);
            m.IsDelete = true;
            db.Entry(m).State = EntityState.Modified;
            db.SaveChanges();

            TempData["message"] = "Xóa file thành công!";

            return RedirectToAction("PostDisplayAll", new { PostId = currentFolderId, route = route, ViewHidden = viewHidden, isSubfolder = isSubFolder });
        }
        [HttpGet]
        public bool DeleteFile(int fileId)
        {
            var file = db.FileInDBs.Find(fileId);
            if (file == null) return false;

            file.IsDelete = true;
            db.Entry(file).State = EntityState.Modified;
            db.SaveChanges();

            var serverPath = Server.MapPath(CommonDataVariable.BaseDirectoryOfFolderAndFile + CommonOutput.GetFullPathFolder(file.FolderId) + "/");
            System.IO.File.Delete(serverPath + file.FileName + "." + file.MIMEType);
            return true;
        }
        [HttpGet]
        public bool UpdateHideFile(int fileId, bool isHide)
        {
            var file = db.FileInDBs.Find(fileId);
            if (file == null) return false;

            file.IsHide = isHide;
            db.Entry(file).State = EntityState.Modified;
            db.SaveChanges();
            return true;
        }
    }
}