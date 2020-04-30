using ICSharpCode.SharpZipLib.Zip;
using PR3M.DBModel;
using PR3M.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Data.Entity;
using PR3M.Common;

namespace PR3M.Controllers
{
    public class HomeController : Controller
    {
        /// <summary>
        /// DB Connection and DAO 
        /// </summary>
        private PRConnect db = new PRConnect();

        /// <summary>
        /// Index of Home page
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            HomeViewModels hvm = new HomeViewModels();
            //post ID = 0 is Logo Post
            ViewBag.Slider = db.Sliders;
            ViewBag.TimeChangeSlide = Convert.ToInt32(WebConfigurationManager.AppSettings["timeChangeSlide"]);
            hvm.Posts = db.Posts.Where(p => p.IsInLogoPost == false && p.PostId > 0 && p.IsDelete != true).OrderBy(p => p.Position);
            hvm.LogoPost = db.Posts.Where(p => p.IsInLogoPost == true && p.IsDelete != true).OrderBy(p => p.Position);
            if (hvm.LogoPost != null)
            {
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
            else
            {
                return Redirect("Error");
            }
        }

        public ActionResult Search(string SearchText)
        {

            if (SearchText != null && SearchText.Trim().Length > 0)
            {
                SearchText = SearchText.Trim();
                ViewBag.search = SearchText;
                List<HomeSearchViewModels> hsvmList = new List<HomeSearchViewModels>();
                foreach (Post p in db.Posts.Where(p => p.IsDelete == false && p.IsHide == false && p.IsPublic == true && p.IsInLogoPost == true))
                {
                    if (p.PostTitle.ToLower().Contains(SearchText.ToLower()))
                    {
                        HomeSearchViewModels hsvm = new HomeSearchViewModels()
                        {
                            ObjectSearchId = p.PostId,
                            ObjectSearchDisplayName = p.PostTitle,
                            ObjectSearchType = 1,
                            ObjectSearchImageDisplay = GetFullLinkOfLogoImage(p.PostId, db)
                        };
                        hsvmList.Add(hsvm);
                    }
                }

                foreach (Material m in db.Materials.Where(m => m.IsDelete == false && m.IsHilde == false && m.IsPublic == true))
                {
                    if (m.MaterialDisplayName.ToLower().Contains(SearchText.ToLower()))
                    {
                        HomeSearchViewModels hsvm = new HomeSearchViewModels()
                        {
                            ObjectSearchId = m.MaterialId,
                            ObjectSearchDisplayName = m.MaterialDisplayName,
                            ObjectSearchType = 2,
                            ObjectSearchImageDisplay = GetFullLinkOfMaterialImage(m)
                        };
                        hsvmList.Add(hsvm);
                    }
                }
                GFG gg = new GFG();
                hsvmList.Sort(gg);

                return View(hsvmList);

            }
            return RedirectToAction("Index");
        }

        private string GetFullLinkOfLogoImage(int LogoPostId, PRConnect db)
        {
            Post p = db.Posts.Find(LogoPostId);
            if (p.LogoAvartarImage != null)
            {
                Material m = p.LogoAvartarImage.Material;
                string path = CommonDataVariable.BaseDirectoryPathWithoutSpecialCharacter + "Logo/" + p.PostHashRealFolder + "/" + m.MaterialName + "." + m.MIMEType;
                return path;
            }
            return "Content/Image/Icon/BasicLogo.png";
        }

        private string GetFullLinkOfMaterialImage(Material material)
        {
            if (!isImage(material.MIMEType))
            {
                if (material.ImageAvatar != null)
                {
                    if (material.Post.IsInLogoPost)
                    {
                        return CommonDataVariable.BaseDirectoryPathWithoutSpecialCharacter + "Logo/" + material.Post.PostHashRealFolder + "/" + material.ImageAvatar;
                    }
                    else
                    {
                        return CommonDataVariable.BaseDirectoryPathWithoutSpecialCharacter + "Post/" + material.Post.PostHashRealFolder + "/" + material.ImageAvatar;
                    }
                }
                return "Content/Image/Icon/" + material.MIMEType + ".png";
            }
            else
            {
                if (material.Post.IsInLogoPost)
                {
                    return CommonDataVariable.BaseDirectoryPathWithoutSpecialCharacter + "Logo/" + material.Post.PostHashRealFolder + "/" + material.MaterialName + "." + material.MIMEType;
                }
                else
                {
                    return CommonDataVariable.BaseDirectoryPathWithoutSpecialCharacter + "Post/" + material.Post.PostHashRealFolder + "/" + material.MaterialName + "." + material.MIMEType;
                }
            }
            return "Content/Image/Icon/file.png";
        }

        private bool isImage(string MIMEType)
        {
            string[] imageType = { "apng", "bmp", "gif", "ico", "cur", "jpg", "jpeg", "jfif", "pjpeg", "pjp", "png", "svg", "tif", "tiff", "webp" };
            foreach (string img in imageType)
            {
                if (img.Contains(MIMEType))
                {
                    return true;
                }
            }
            return false;
        }

        private class GFG : IComparer<HomeSearchViewModels>
        {
            public int Compare(HomeSearchViewModels x, HomeSearchViewModels y)
            {
                if (x == null || y == null)
                    return 0;
                return x.ObjectSearchDisplayName.CompareTo(y.ObjectSearchDisplayName);
            }
        }

        public FileResult Download(int MaterialId)
        {
            Material m = db.Materials.Find(MaterialId);
            var FileVirualPath = "~/Content/Materials/Root/";
            if (m.Post.IsInLogoPost != true)
            {
                FileVirualPath += "Post/" + m.Post.PostHashRealFolder + "/" + m.MaterialName + "." + m.MIMEType;
            }
            else
            {
                FileVirualPath += "Logo/" + m.Post.PostHashRealFolder + "/" + m.MaterialName + "." + m.MIMEType;
            }
            return File(FileVirualPath, "application/force- download", Path.GetFileName(FileVirualPath));
        }

        public FileResult DownloadZipFile(int PostId)
        {
            var fileName = string.Format("{0}_LogoFiles.zip", DateTime.Today.Date.ToString("dd-MM-yyyy") + "_1");
            var tempOutPutPath = Server.MapPath("~/Content/Materials/Root/") + fileName;
            var Post = db.Posts.Find(PostId);
            using (ZipOutputStream s = new ZipOutputStream(System.IO.File.Create(tempOutPutPath)))
            {
                s.SetLevel(9); // 0-9, 9 being the highest compression  

                byte[] buffer = new byte[4096];

                var FileList = new List<string>();

                foreach (Material m in Post.Materials)
                {
                    FileList.Add(Server.MapPath("~/Content/Materials/Root/Logo/" + Post.PostHashRealFolder + "/" + m.MaterialName + "." + m.MIMEType));
                }
                for (int i = 0; i < FileList.Count; i++)
                {
                    ZipEntry entry = new ZipEntry(Path.GetFileName(FileList[i]));
                    entry.DateTime = DateTime.Now;
                    entry.IsUnicodeText = true;
                    s.PutNextEntry(entry);

                    using (FileStream fs = System.IO.File.OpenRead(FileList[i]))
                    {
                        int sourceBytes;
                        do
                        {
                            sourceBytes = fs.Read(buffer, 0, buffer.Length);
                            s.Write(buffer, 0, sourceBytes);
                        } while (sourceBytes > 0);
                    }
                }
                s.Finish();
                s.Flush();
                s.Close();

            }

            byte[] finalResult = System.IO.File.ReadAllBytes(tempOutPutPath);
            if (System.IO.File.Exists(tempOutPutPath))
                System.IO.File.Delete(tempOutPutPath);

            if (finalResult == null || !finalResult.Any())
                throw new Exception(String.Format("No Files found with Image"));

            return File(finalResult, "application/zip", fileName);

        }

        public ActionResult LoadContentModal(int id)
        {
            HomePartialViewModels hpvm = new HomePartialViewModels();

            //var modal = tempList.FirstOrDefault(t => t.Id == id);
            hpvm.Materials = db.Materials.Where(m => m.PostId == id && m.IsDelete != true);
            hpvm.Post = db.Posts.Find(id);
            return PartialView("_LogoFolderDisplayModal", hpvm);
        }

    }
}