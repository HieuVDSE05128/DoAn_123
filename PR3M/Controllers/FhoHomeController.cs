using PR3M.Common;
using PR3M.DBModel;
using PR3M.DBModel.DAO;
using PR3M.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace PR3M.Controllers
{
    public class FhoHomeController : Controller
    {
        private PRConnect db = new PRConnect();
        // GET: FhoHome
        public ActionResult Index()
        {
            HomeViewModels hvm = new HomeViewModels();
            //post ID = 0 is Logo Post
            ViewBag.Slider = db.Sliders;
            hvm.Posts = db.Posts.Where(p => p.IsInLogoPost == false && p.PostId > 0 && p.IsDelete == false).OrderBy(p => p.Position);
            hvm.LogoPost = db.Posts.Where(p => p.IsInLogoPost == true && p.IsDelete != true).OrderBy(p => p.Position);
            hvm.LogoImage = new List<LogoAvartarImage>();
            foreach (Post p in hvm.LogoPost)
            {
                if (db.LogoAvartarImages.Find(p.PostId) != null)
                {
                    hvm.LogoImage.Add(db.LogoAvartarImages.Find(p.PostId));
                }
                else
                {
                    hvm.LogoImage.Add(null);
                }
            }
            return View(hvm);
        }

        public ActionResult CreatePost()
        {
            ViewBag.currentUserId = Session["currentUser"].ToString();
            ViewBag.currentUser = Session["currentUserFullName"].ToString();
            ViewBag.PRSystemId = new SelectList(db.PRSystems, "PRSystemId", "PRSystemName");
            //
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreatePost(PostCreateViewModels post, HttpPostedFileBase[] fileInputReal, string[] displayNameFileInput)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction("Index");
            }
            if (post.PostTitle == null || post.PostTitle.Length < 0)
            {
                post.PostTitle = "";
            }
            if (post.PostEngTitle == null || post.PostEngTitle.Length < 0)
            {
                post.PostEngTitle = "";
            }
            if (Request.Files.Count > 0)
            {
                for (var i = 0; i < Request.Files.Count; i++)
                {
                    var hpf = Request.Files[i];
                    if (hpf != null && hpf.ContentLength > 0)
                    {
                        var savedFileName = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, Path.GetFileName(hpf.FileName));
                    }
                }
            }
            string currentUserId = Session["currentUser"].ToString();
            if (currentUserId != null)
            {
                User u = db.Users.Find(currentUserId);
                if (u != null)
                {
                    //Check create File
                    string postHashRealFolder = post.PostTitle;
                    string path = "";
                    while (true)
                    {
                        path = Server.MapPath("~/Content/Materials/Root/Post/" + postHashRealFolder);
                        if (!Directory.Exists(path))
                        {
                            Directory.CreateDirectory(path);
                            break;
                        }
                        else
                        {
                            postHashRealFolder += "_1";
                        }
                    }
                    int PositionGetFromDB = 0;
                    try
                    {
                        PositionGetFromDB = db.Posts.Where(p => p.IsInLogoPost == false).Max(p => p.Position);
                    }
                    catch
                    {
                        PositionGetFromDB = 0;
                    }
                    //insert into DB
                    Post postInsertToDB = new Post()
                    {
                        PostTitle = post.PostTitle,
                        PostEngTitle = post.PostEngTitle,
                        PostHashRealFolder = postHashRealFolder,
                        IsInLogoPost = false,
                        IsPublic = true,
                        IsHide = false,
                        IsDelete = false,
                        CreateBy = currentUserId,
                        Position = PositionGetFromDB + 1,
                        LaunchedDate = DateTime.Now,
                        PRSystemId = u.PRSystemId,
                    };
                    db.Posts.Add(postInsertToDB);
                    db.SaveChanges();

                    //insert file
                    if (fileInputReal.Count() > 0)
                    {
                        int size = fileInputReal.Count();
                        int positionInfolder = 0;
                        for (int i = 0; i < size; i++)
                        {
                            if (fileInputReal[i] != null && fileInputReal.Length > 0)
                            {
                                //Get name and mimetype
                                positionInfolder++;//each loop increase position of folder of file (file after has position > file before)
                                string fileNameRAW = fileInputReal[i].FileName;
                                string fileName = fileNameRAW;
                                string MIMEType = "";
                                if (fileNameRAW.Contains("."))
                                {
                                    string[] fileNameRAWSplit = fileNameRAW.Split('.');
                                    fileName = fileNameRAWSplit[0].ToString();
                                    MIMEType = fileNameRAWSplit[fileNameRAWSplit.Length - 1].ToString();
                                }

                                //input to real directory
                                if (!System.IO.File.Exists(path + "/" + fileNameRAW))
                                {
                                    fileInputReal[i].SaveAs(path + "/" + fileNameRAW);
                                }
                                else
                                {
                                    fileName += "_1";
                                    fileInputReal[i].SaveAs(path + "/" + fileName + "." + MIMEType);
                                }
                                string pathToSave = "~/Content/Materials/Root/Post/" + postHashRealFolder + "/" + fileName + "." + MIMEType;
                                //input to database
                                Material m = new Material()
                                {
                                    MaterialName = fileName,
                                    MaterialDisplayName = displayNameFileInput[i],
                                    PositionInFolder = positionInfolder,
                                    LaunchedDate = DateTime.Now,
                                    CreateBy = u.UsernameId,
                                    MIMEType = MIMEType,
                                    IsDelete = false,
                                    IsHilde = false,
                                    PostId = postInsertToDB.PostId,
                                    MaterialMD5Encrypt = EncodeMD5(path + "\\" + fileName + "." + MIMEType),
                                    MaterialType = "Post"
                                };
                                db.Materials.Add(m);
                                db.SaveChanges();
                            }
                        }
                    }
                }

                return RedirectToAction("Index");
            }
            return RedirectToAction("CreatePost");
        }

        public ActionResult LoadContentModalInsertPRSystem(string rtnLink)
        {
            ViewBag.rtnLink = rtnLink;
            return PartialView("_CreatePRSystem");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreatePRSystem(PRSystemCreateViewModels pcvm, string rtnLink)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction("Index");
            }
            PRSystem prsystem = new PRSystem()
            {
                PRSystemName = pcvm.PRSystemName,
                PRSystemVName = pcvm.PRSystemVName,
                PRSystemIndependent = pcvm.PRSystemIndependent
            };
            db.PRSystems.Add(prsystem);
            db.SaveChanges();
            return RedirectToAction(rtnLink);
        }





        // GET: EditPost/id = ? 
        public ActionResult EditPost(int? postId)
        {
            if (postId.HasValue)
            {
                var postPiblishEdit = db.Posts.Find(postId);
                PostEditViewModel pevm = new PostEditViewModel()
                {
                    PostId = postPiblishEdit.PostId,
                    PostTitle = postPiblishEdit.PostTitle,
                    PostEngTitle = postPiblishEdit.PostEngTitle,
                    IsPublic = postPiblishEdit.IsPublic,
                    Materials = postPiblishEdit.Materials,
                    IsLogo = postPiblishEdit.IsInLogoPost
                };
                ViewBag.index = postPiblishEdit.Materials.Count();
                return View(pevm);
            }
            else
            {
                return RedirectToAction("Index");
            }
        }

        //// POST: PostPublisheds/Edit/
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditPost(PostEditViewModel pevm, string[] ChangeStatus, int[] MaterialId, HttpPostedFileBase[] avatarImageInput)
        {
            if (ModelState.IsValid)
            {
                Post post = db.Posts.Find(pevm.PostId);
                if (post == null)
                {
                    ViewBag.ErrorMessage = "Không tìm thấy chủ đề của bạn";
                    return RedirectToAction("Index");
                }
                //save setting about title
                post.PostTitle = pevm.PostTitle;
                post.PostEngTitle = pevm.PostEngTitle;
                post.IsPublic = pevm.IsPublic;
                //db.Entry(post).State = EntityState.Modified;
                if (ChangeStatus != null && ChangeStatus.Length > 0)
                {
                    for (int i = 0; i < ChangeStatus.Length; i++)
                    {
                        if (ChangeStatus[i] != "Nothing")
                        {
                            var material = db.Materials.Find(MaterialId[i]);
                            if (ChangeStatus[i] == "Changed")
                            {
                                if (material != null)
                                {
                                    string path = Server.MapPath(CommonDataVariable.BaseDirectoryPathOfPostLogoAndMaterial + "/" + "Post/" + post.PostHashRealFolder + "/" + material.MaterialName + "." + avatarImageInput[i].FileName.Split('.')[1]);
                                    if (System.IO.File.Exists(path))
                                    {
                                        System.IO.File.Delete(path);
                                    }
                                    avatarImageInput[i].SaveAs(path);
                                    material.ImageAvatar = material.MaterialName + "." + avatarImageInput[i].FileName.Split('.')[1];
                                }
                                else
                                {
                                    ViewBag.ErrorMessage = "Không tìm thấy tài nguyên bạn chỉnh sửa";
                                    return RedirectToAction("Index");
                                }
                            } else
                            {
                                material.IsDelete = true;
                            }
                        }
                    }
                }

                //


                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ErrorText = "Something error, can not edit your post";
            return RedirectToAction("Index");
        }

        public ActionResult AddMaterial(int? postId)
        {
            ViewBag.postId = postId;
            return View();
        }


        [HttpPost]
        public JsonResult ChangePositionUp(int id)
        {
            var result = new PostDAO().ChangePostionUpOfPost(db, id);
            return Json(new
            {
                status = result
            });
        }

        [HttpPost]
        public JsonResult changePositionDown(int id)
        {
            var result = new PostDAO().ChangePostionDownOfPost(db, id);
            return Json(new
            {
                status = result
            });
        }

        public ActionResult AddMaterialToPost(int postId)
        {
            ViewBag.postId = postId;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddMaterialToPost(MaterialCreateViewModel mcvm, HttpPostedFileBase fileInput, HttpPostedFileBase fileAvatarImage)
        {
            if (fileInput != null)
            {

            }
            string currentUserId = Session["currentUser"].ToString();
            int positionInFolder;
            try
            {
                positionInFolder = db.Posts.Find(mcvm.PostId).Materials.Max(m => m.PositionInFolder);
                if (positionInFolder < 1)
                {
                    positionInFolder = 1;
                }
            }
            catch
            {
                positionInFolder = 1;
            }

            if (ModelState.IsValid)
            {
                //Upload file in real directory
                //check if exits another file has same name
                string path = "";
                Post p = db.Posts.Find(mcvm.PostId);
                do
                {
                    if (p.IsInLogoPost)
                    {
                        path = Server.MapPath(CommonDataVariable.BaseDirectoryPath + "Logo/" + p.PostHashRealFolder + "/" + mcvm.Name + "." + mcvm.MIMEType);
                    }
                    else
                    {
                        path = Server.MapPath(CommonDataVariable.BaseDirectoryPath + "Post/" + p.PostHashRealFolder + "/" + mcvm.Name + "." + mcvm.MIMEType);
                    }
                    if (!System.IO.File.Exists(path))
                    {
                        break;
                    }
                    else
                    {
                        mcvm.Name += "_1";
                    }
                } while (true);
                //save to real directory
                fileInput.SaveAs(path);
                //Create new material with user input and default value
                //string pathToSave = CommonDataVariable.BaseDirectoryPath + "Post/" + p.PostHashRealFolder + "/" + mcvm.Name + "." + mcvm.MIMEType;
                Material m = new Material()
                {
                    MaterialName = mcvm.Name,
                    MaterialDisplayName = mcvm.DisplayName,
                    FolderName = p.PostHashRealFolder,
                    CreateBy = currentUserId,
                    IsDelete = false,
                    IsHilde = false,
                    LaunchedDate = DateTime.Now,
                    MIMEType = mcvm.MIMEType,
                    PositionInFolder = positionInFolder + 1,
                    PostId = mcvm.PostId,
                    MaterialMD5Encrypt = EncodeMD5(path),
                    MaterialType = "Post",
                };
                db.Materials.Add(m);
                db.SaveChanges();

                //if file image != null
                if (fileAvatarImage != null && fileAvatarImage.ContentLength > 0)
                {
                    string imageName = CommonOutput.generateRandomString(32);
                    do
                    {
                        string[] fileNameImage = fileAvatarImage.FileName.Split('.');
                        imageName += "." + fileNameImage[fileNameImage.Length - 1];
                        if (p.IsInLogoPost)
                        {
                            path = Server.MapPath(CommonDataVariable.BaseDirectoryPath + "Logo/" + p.PostHashRealFolder + "/" + imageName);
                        }
                        else
                        {
                            path = Server.MapPath(CommonDataVariable.BaseDirectoryPath + "Post/" + p.PostHashRealFolder + "/" + imageName);
                        }
                        if (!System.IO.File.Exists(path))
                        {
                            break;
                        }
                        else
                        {
                            imageName = CommonOutput.generateRandomString(32);
                        }
                    } while (true);
                    fileAvatarImage.SaveAs(path);
                    m.ImageAvatar = imageName;
                }
                LogAction laMaterial = new LogAction()
                {
                    LogObjectId = m.MaterialId,
                    LogCreateBy = currentUserId,
                    LogObjectType = 2,
                    LogActionTypeId = 1,
                    LogActionTime = DateTime.Now
                };
                db.LogActions.Add(laMaterial);
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        //public async Task<ActionResult> CheckFile()
        //{

        //    var db = new PRConnect();
        //    List<string> listFile = new List<string>();
        //    bool kt = true;
        //    foreach (var item in db.Materials)
        //    {
        //        if (item.MaterialMD5Encrypt != null && item.MaterialPathFolder != null)
        //        {
        //            string pathFile = item.MaterialPathFolder;
        //            string oldMD5 = item.MaterialMD5Encrypt;
        //            string newMD5 = EncodeMD5(Server.MapPath(pathFile));
        //            if (!newMD5.Equals(oldMD5))
        //            {
        //                listFile.Add(pathFile);
        //                item.MaterialMD5Encrypt = newMD5;

        //            }
        //        }
        //    }
        //    db.SaveChanges();

        //    if (listFile.Count > 0) kt = false;
        //    if (!kt)
        //    {
        //        using (var smtp = new SmtpClient())
        //        {
        //            HttpCookie currentUser = Request.Cookies["currentUser"];
        //            var toEmail = currentUser.Value + "@fpt.edu.vn";
        //            var message = CreateMessageMD5(listFile, toEmail);
        //            await smtp.SendMailAsync(message);
        //        }
        //    }
        //    //ViewBag.Message = "Success";
        //    return RedirectToAction("Index", "PRMain", new { });
        //}
        public async Task<ActionResult> CheckFile()
        {

            var db = new PRConnect();
            List<string> listFile = new List<string>();
            bool kt = true;
            foreach (var item in db.Materials)
            {
                if (item.MaterialMD5Encrypt != null)
                {
                    string pathFile = "~/Content/Materials/Root/" + item.MaterialType + "/" + item.FolderName + "/" + item.MaterialName + "." + item.MIMEType;
                    string oldMD5 = item.MaterialMD5Encrypt;
                    string newMD5 = EncodeMD5(Server.MapPath(pathFile));
                    if (!newMD5.Equals(oldMD5))
                    {
                        listFile.Add(item.MaterialType + "/" + item.FolderName + "/" + item.MaterialDisplayName + "." + item.MIMEType);
                        item.MaterialMD5Encrypt = newMD5;

                    }
                }
            }
            db.SaveChanges();

            if (listFile.Count > 0) kt = false;
            if (!kt)
            {
                using (var smtp = new SmtpClient())
                {
                    HttpCookie currentUser = Request.Cookies["currentUser"];
                    string toEmail;
                    if (currentUser == null) toEmail = "manhpxse05116@fpt.edu.vn";
                    else toEmail = currentUser.Value + "@fpt.edu.vn";

                    var message = CreateMessageMD5(listFile, toEmail);
                    await smtp.SendMailAsync(message);
                }
            }
            //ViewBag.Message = "Success";
            return RedirectToAction("Index", "Menu", new { });
        }
        private string EncodeMD5(string FilePath)
        {
            //create object MD5
            MD5 encode = MD5.Create();

            //Read file by FilePath
            FileStream fs = new FileStream(FilePath, FileMode.Open, FileAccess.Read, FileShare.None);

            //encode fs
            byte[] arrCode = encode.ComputeHash(fs);

            fs.Close();

            //release fs
            fs.Dispose();

            string strMD5 = "";
            //change byte array to string
            foreach (byte element in arrCode)
            {
                strMD5 += element.ToString("x2");
            }
            return strMD5;
        }

        public MailMessage CreateMessageMD5(List<string> listFile, string toEmail)
        {
            var body = "<p>EMAIL FROM: {0} ({1})</p><p>MESSAGE:</p><p>{2}</p>";
            var message = new MailMessage();
            message.To.Add(new MailAddress(toEmail));
            message.Subject = "KIỂM TRA TÀI NGUYÊN";
            string fromName = "Quản trị viên trang tài nguyên thương hiệu FPT";
            string fromEmail = "pxman18011997@gmail.com";
            string fromMessage = "Chúng tôi phát hiện các file sau bị thay đổi và đã cập nhật lại: ";
            message.Body = string.Format(body, fromName, fromEmail, fromMessage);
            foreach (var item in listFile)
            {
                message.Body += "<br/>" + item;
            }
            message.IsBodyHtml = true;
            return message;
        }
        public ActionResult ChangePostLogoAvatarImage(int postId)
        {
            PostLogoChooseAvatarImageViewModel pcaivm = new PostLogoChooseAvatarImageViewModel();
            pcaivm.PostId = postId;
            pcaivm.ImageForLogoChoose = db.Posts.Find(postId).Materials.Where(m => m.IsDelete == false && (m.MIMEType == "jpg" || m.MIMEType == "png"));
            int count = pcaivm.ImageForLogoChoose.Count();
            pcaivm.MaterialChoose = -1;
            LogoAvartarImage logo = db.LogoAvartarImages.Find(postId);
            if (logo != null)
            {
                pcaivm.MaterialChoose = logo.MaterialId;
            }

            return PartialView("_ChangePostLogoAvatarImage", pcaivm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePostLogoAvatarImage(int PostId, int MaterialId)
        {
            try
            {
                LogoAvartarImage logo = db.LogoAvartarImages.Find(PostId);
                if (logo != null)
                {
                    logo.MaterialId = MaterialId;
                }
                else
                {
                    LogoAvartarImage logoInput = new LogoAvartarImage()
                    {
                        PostId = PostId,
                        MaterialId = MaterialId,
                        LastChangeTime = DateTime.Now,
                        LastChangeBy = Session["currentUser"].ToString()
                    };
                    db.LogoAvartarImages.Add(logoInput);
                }

                db.SaveChanges();
            }
            catch (Exception ex)
            {
                //return Json(new
                //{
                //    status = false,
                //    exception = ex.Message
                //});
            }
            return RedirectToAction("Index");
        }

        public ActionResult EditMaterialInPost(int MaterialId)
        {
            Material material = db.Materials.Find(MaterialId);
            MaterialEditViewModel mevm = new MaterialEditViewModel()
            {
                Id = material.MaterialId,
                DisplayName = material.MaterialDisplayName,
                Name = material.MaterialName,
                IsHide = material.IsHilde,
                MIMEType = material.MIMEType,
                ImageAvatar = material.ImageAvatar,
                FolderPath = material.Post.PostHashRealFolder,
                PostId = material.PostId
            };
            return View(mevm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditMaterialInPost(MaterialEditViewModel mevm, HttpPostedFileBase fileInput, HttpPostedFileBase fileAvatarImage)
        {
            Material m = db.Materials.Find(mevm.Id);
            m.MaterialDisplayName = mevm.DisplayName;
            m.IsHilde = mevm.IsHide;
            string path = "";
            Post p = db.Posts.Find(mevm.PostId);
            if (fileInput != null && fileInput.ContentLength > 0)
            {
                //create path of new file
                if (p.IsInLogoPost)
                {
                    path = Server.MapPath(CommonDataVariable.BaseDirectoryPath + "Logo/" + p.PostHashRealFolder + "/" + mevm.Name + "." + mevm.MIMEType);
                }
                else
                {
                    path = Server.MapPath(CommonDataVariable.BaseDirectoryPath + "Post/" + p.PostHashRealFolder + "/" + mevm.Name + "." + mevm.MIMEType);
                }
                //delete old file
                //if (System.IO.File.Exists(Server.MapPath("~/" + CommonDataVariable.BaseDirectoryPath + "Logo/" + p.PostHashRealFolder + "/" + m.MaterialName + "." + m.MIMEType)))
                //{
                //    System.IO.File.Delete(Server.MapPath("~/" + CommonDataVariable.BaseDirectoryPath + "Logo/" + p.PostHashRealFolder + "/" + m.MaterialName + "." + m.MIMEType));
                //}
                //Save new file
                fileInput.SaveAs(path);
                //Change in database
                m.MaterialName = mevm.Name;
                m.MIMEType = mevm.MIMEType;
            }
            if (fileAvatarImage != null && fileAvatarImage.ContentLength > 0)
            {
                string imageName = fileAvatarImage.FileName;
                do
                {
                    if (!System.IO.File.Exists(path + "\\" + imageName))
                    {
                        break;
                    }
                    else
                    {
                        imageName = "A" + imageName;
                    }
                } while (true);
                if (p.IsInLogoPost)
                {
                    path = Server.MapPath(CommonDataVariable.BaseDirectoryPath + "Logo/" + p.PostHashRealFolder + "/" + imageName);
                }
                else
                {
                    path = Server.MapPath(CommonDataVariable.BaseDirectoryPath + "Post/" + p.PostHashRealFolder + "/" + imageName);
                }
                fileAvatarImage.SaveAs(path);
                m.ImageAvatar = imageName;
            }
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult EditSlider()
        {
            SliderEditViewModel sevm = new SliderEditViewModel();
            try
            {
                ViewBag.maxId = db.Sliders.Max(s => s.SliderId);
            }
            catch
            {
                ViewBag.maxId = 0;
            }
            sevm.Sliders = db.Sliders;
            return View(sevm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditSlider(string[] Status, int[] SlideId, HttpPostedFileBase[] imageChange, string[] StatusCreateNew, HttpPostedFileBase[] NewImage)
        {
            List<Slider> sliders = new List<Slider>();
            string path = Server.MapPath("~/Content/Image/Slider");
            int key = 0;
            if (Status != null && Status.Length > 0)
            {
                for (int i = 0; i < Status.Length; i++)
                {
                    key++;
                    if (Status[i] == "Nothing")
                    {
                        sliders.Add(db.Sliders.Find(SlideId[i]));
                    }
                    else
                    {
                        if (imageChange[i] != null && imageChange[i].ContentLength > 0)
                        {
                            imageChange[i].SaveAs(path + "\\" + imageChange[i].FileName);
                            Slider slider = new Slider()
                            {
                                SliderId = key,
                                SliderName = imageChange[i].FileName,
                                IsDelete = false
                            };
                            sliders.Add(slider);
                        }
                    }
                }
            }

            if (StatusCreateNew != null && StatusCreateNew.Length > 0)
            {
                for (int i = 0; i < NewImage.Length; i++)
                {
                    key++;
                    if (NewImage[i] != null && NewImage[i].ContentLength > 0)
                    {
                        NewImage[i].SaveAs(path + "\\" + NewImage[i].FileName);
                        Slider slider = new Slider()
                        {
                            SliderId = key,
                            SliderName = NewImage[i].FileName,
                            IsDelete = false
                        };
                        sliders.Add(slider);
                    }
                }
            }

            //Delete all row in table
            var rows = from o in db.Sliders
                       select o;
            foreach (var row in rows)
            {
                db.Sliders.Remove(row);
            }
            db.SaveChanges();

            //Add new List to db
            foreach (Slider s in sliders)
            {
                db.Sliders.Add(s);
            }
            db.SaveChanges();

            return RedirectToAction("Index");
        }



        [HttpPost]
        public ActionResult DeletePost(int PostId)
        {
            User u = (User)Session["currentUserObject"];
            if (u.PRSystemId == 0 && u.RoleId == 0)
            {
                Post post = db.Posts.Find(PostId);
                if (post != null)
                {
                    //delete file in post
                    foreach (Material m in post.Materials)
                    {
                        m.IsDelete = true;
                        LogAction laMaterial = new LogAction()
                        {
                            LogObjectId = m.MaterialId,
                            LogCreateBy = u.UsernameId,
                            LogObjectType = 2,
                            LogActionTypeId = 3,
                            LogActionTime = DateTime.Now
                        };
                        db.LogActions.Add(laMaterial);
                        db.SaveChanges();
                    }
                    //delete post
                    post.IsDelete = true;
                    LogAction laPost = new LogAction()
                    {
                        LogObjectId = post.PostId,
                        LogCreateBy = u.UsernameId,
                        LogObjectType = 1,
                        LogActionTypeId = 3,
                        LogActionTime = DateTime.Now
                    };
                    db.LogActions.Add(laPost);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewData["ErrorText"] = "Dữ liệu không hợp lệ";
                }
            }
            else
            {
                ViewData["ErrorText"] = "Bạn không có quyền thực hiện điều này";
            }
            return RedirectToAction("Index");

        }

        [HttpPost]
        public ActionResult DeleteMaterial(int MaterialId)
        {
            User u = (User)Session["currentUserObject"];
            if (u.PRSystemId == 0 && u.RoleId == 0)
            {
                Material m = db.Materials.Find(MaterialId);
                if (m != null)
                {
                    m.IsDelete = true;
                    LogAction laMaterial = new LogAction()
                    {
                        LogObjectId = m.MaterialId,
                        LogCreateBy = u.UsernameId,
                        LogObjectType = 2,
                        LogActionTypeId = 3,
                        LogActionTime = DateTime.Now
                    };
                    db.LogActions.Add(laMaterial);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewData["ErrorText"] = "Dữ liệu không hợp lệ";
                }
            }
            else
            {
                ViewData["ErrorText"] = "Bạn không có quyền thực hiện điều này";
            }
            return RedirectToAction("Index");
        }

        public ActionResult CreateLogo()
        {
            ViewBag.currentUserId = Session["currentUser"].ToString();
            ViewBag.currentUser = Session["currentUserFullName"].ToString();
            ViewBag.PRSystemId = new SelectList(db.PRSystems, "PRSystemId", "PRSystemName");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateLogo(PostLogoCreateViewModels post, HttpPostedFileBase[] fileInputReal, string[] displayNameFileInput)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction("Index");
            }
            if (post.PostTitle == null || post.PostTitle.Length < 0)
            {
                post.PostTitle = "";
            }
            if (Request.Files.Count > 0)
            {
                for (var i = 0; i < Request.Files.Count; i++)
                {
                    var hpf = Request.Files[i];
                    if (hpf != null && hpf.ContentLength > 0)
                    {
                        var savedFileName = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, Path.GetFileName(hpf.FileName));
                    }
                }
            }
            string currentUserId = Session["currentUser"].ToString();
            if (currentUserId != null)
            {
                User u = db.Users.Find(currentUserId);
                if (u != null)
                {
                    string path = "";
                    //Check create File
                    while (true)
                    {
                        path = Server.MapPath("~/Content/Materials/Root/Logo/" + post.PostTitle);
                        if (!Directory.Exists(path))
                        {
                            Directory.CreateDirectory(path);
                            break;
                        }
                    }

                    //insert into DB
                    Post postInsertToDB = new Post()
                    {
                        PostTitle = post.PostTitle,
                        PostEngTitle = "",
                        PostHashRealFolder = post.PostTitle,
                        IsInLogoPost = true,
                        IsPublic = true,
                        IsHide = false,
                        IsDelete = false,
                        CreateBy = currentUserId,
                        Position = db.Posts.Where(p => p.IsInLogoPost == true).Max(p => p.Position) + 1,
                        LaunchedDate = DateTime.Now,
                        PRSystemId = u.PRSystemId,
                    };
                    db.Posts.Add(postInsertToDB);
                    db.SaveChanges();
                    //insert file
                    if (fileInputReal.Count() > 0)
                    {
                        int size = fileInputReal.Count();
                        int positionInfolder = 0;
                        for (int i = 0; i < size; i++)
                        {
                            if (fileInputReal[i] != null && fileInputReal.Length > 0)
                            {
                                //Get name and mimetype
                                positionInfolder++;//each loop increase position of folder of file (file after has position > file before)
                                string fileNameRAW = fileInputReal[i].FileName;
                                string fileName = fileNameRAW;
                                string MIMEType = "";
                                if (fileNameRAW.Contains("."))
                                {
                                    string[] fileNameRAWSplit = fileNameRAW.Split('.');
                                    fileName = fileNameRAWSplit[0].ToString();
                                    MIMEType = fileNameRAWSplit[fileNameRAWSplit.Length - 1].ToString();
                                }

                                //input to real directory
                                if (!System.IO.File.Exists(path + "/" + fileNameRAW))
                                {
                                    fileInputReal[i].SaveAs(path + "/" + fileNameRAW);
                                }
                                else
                                {
                                    fileName += "_1";
                                    fileInputReal[i].SaveAs(path + "/" + fileName + "." + MIMEType);
                                }
                                string pathToMD5 = "~/Content/Materials/Root/Logo/" + post.PostTitle + "/" + fileName + "." + MIMEType;
                                //input to database
                                Material m = new Material()
                                {
                                    MaterialName = fileName,
                                    MaterialDisplayName = displayNameFileInput[i],
                                    PositionInFolder = positionInfolder,
                                    LaunchedDate = DateTime.Now,
                                    CreateBy = u.UsernameId,
                                    MIMEType = MIMEType,
                                    IsDelete = false,
                                    IsHilde = false,
                                    PostId = postInsertToDB.PostId,
                                    MaterialMD5Encrypt = EncodeMD5(path + "\\" + fileName + "." + MIMEType),
                                    MaterialType = "Logo",
                                };
                                db.Materials.Add(m);
                                db.SaveChanges();
                            }
                        }
                    }
                }

                return RedirectToAction("Index");
            }
            return RedirectToAction("CreatePost");
        }

        [HttpPost]
        public JsonResult HideMaterial(int MaterialId)
        {
            Material m = db.Materials.Find(MaterialId);
            m.IsHilde = !m.IsHilde;
            db.SaveChanges();
            return Json(new { status = m.IsHilde });
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