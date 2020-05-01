using PR3M.DBModel;
using PR3M.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Web;

namespace PR3M.Common
{
    public class CommonOutput
    {
        public static string getFullFileWithBaseDirectory(string fileFullPath)
        {
            return CommonDataVariable.BaseDirectoryPath + fileFullPath;
        }

        public static string generateRandomString(int length)
        {
            // creating a StringBuilder object()
            StringBuilder str_build = new StringBuilder();
            Random random = new Random();
            char letter;
            for (int i = 0; i < length; i++)
            {
                double flt = random.NextDouble();
                int shift = Convert.ToInt32(Math.Floor(25 * flt));
                letter = Convert.ToChar(shift + 65);
                str_build.Append(letter);
            }
            return str_build.ToString();
        }

        public static string GetFullPathOfFile(int FileId)
        {
            string rtn = "";
            try
            {
                PRConnect db = new PRConnect();
                FileInDB file = db.FileInDBs.Find(FileId);
                string basePath = CommonDataVariable.BaseDirectoryOfFolderAndFile.Remove(0, 2);
                string fullPathFolder = GetFullPathFolder(file.FolderId);
                rtn = basePath + fullPathFolder + "/" + file.FileName + "." + file.MIMEType;
            }
            catch
            {

            }
            return rtn;
        }


        //generate full path of materials
        //Đệ quy full path post + material.Name
        public static string GetFullPathMaterial(int MaterialsId)
        {
            PRConnect db = null;
            try
            {
                db = new PRConnect();
                var material = db.Materials.Find(MaterialsId);
                if (material.Post.IsInLogoPost)
                {
                    return "Logo/" + material.Post.PostHashRealFolder + "/" + material.MaterialName + "." + material.MIMEType;
                }
                else
                {
                    return "Post/" + material.Post.PostHashRealFolder + "/" + material.MaterialName + "." + material.MIMEType;
                }
            }
            catch (Exception ex)
            {
                return "Something error: " + ex.Message;
            }
            finally
            {
                if (db != null)
                {
                    db = null;
                }
            }
        }

        public static string GetFullPathFile(int fileId)
        {
            PRConnect db = null;
            try
            {
                db = new PRConnect();
                var file = db.FileInDBs.Find(fileId);
                if(file != null)
                {
                    var path = getPathFolder(file.FolderId);

                    return $"{path}/{file.FileName}.{file.MIMEType}";
                }
                return "không tìm thấy file";
                
            }
            catch (Exception ex)
            {
                return "Something error: " + ex.Message;
            }
            finally
            {
                if (db != null)
                {
                    db = null;
                }
            }
        }
        public static string getPathFolder(int folderId)
        {

            PRConnect db = null;
            try
            {
                db = new PRConnect();
                var folder = db.Folders.Find(folderId);
                if (folder.ParrentId.HasValue)
                {
                    return getPathFolder(folder.ParrentId.Value) + "/" + folder.FolderName;
                }
                else
                {
                    return folder.FolderName;
                }
            }
            catch (Exception ex)
            {
                return "Something error: " + ex.Message;
            }
            finally
            {
                if (db != null)
                {
                    db = null;
                }
            }
        }

        /// <summary>
        /// Class <c>GetFullPathFolder</c> get full path of post (from root post) by post Id
        /// </summary>
        /// <param name="FolderId"></param>
        /// <returns></returns>
        public static string GetFullPathFolder(int FolderId)
        {
            PRConnect db = null;
            try
            {
                db = new PRConnect();
                var folder = db.Folders.Find(FolderId);
                string path = GetFullPathRecursive(db, folder.FolderId);
                return path;
            }
            catch (Exception ex)
            {
                return "Something error: " + ex.Message;
            }
            finally
            {
                if (db != null)
                {
                    db = null;
                }
            }
        }

        //Đệ quy full path post
        private static string GetFullPathRecursive(PRConnect db, int FolderId)
        {
            var Folder = db.Folders.Find(FolderId);
            if (Folder.FolderId != 0 && Folder.Folder2 != null)
            {

                return GetFullPathRecursive(db, Folder.Folder2.FolderId) + "/" + Folder.FolderName;
            }
            else
                return Folder.FolderName;
        }

        public static string getFullNameOfMaterial(string fileName, string MIMEType)
        {
            return "";
        }



        public static int typeOfMIME(string MIME)
        {
            /*
             * 1 Anh
             * 2 Video
             * 3 Document
             *
             */
            string fileType = MimeTypeMap.GetMimeType("." + MIME);
            string[] fileControlType = fileType.Split('/');
            switch (fileControlType[0])
            {
                case "image":
                    return 1;
                case "video":
                    return 2;
                case "application":
                    return 3;
            }
            return 4;
        }



        public static string typeOfFilter(int type)
        {
            switch (type)
            {
                case 1:
                    return "filterDiv Image";
                case 2:
                    return "filterDiv Video";
            }
            return "";
        }

        public static string RtnVideoControlType(string MIME)
        {
            return MimeTypeMap.GetMimeType("." + MIME);
        }

        public static List<FolderLinkViewModels> GetListLinkFolder(int currentFolderId)
        {
            PRConnect db = null;
            List<FolderLinkViewModels> listFolder = new List<FolderLinkViewModels>();
            try
            {
                db = new PRConnect();
                Folder f = db.Folders.Find(currentFolderId);
                // FHO/Image
                // Add vao list post hien tai
                // Kiem tra xem tren no la root chua
                // Neu chua thi chuyen len tren
                while (true)
                {
                    FolderLinkViewModels flvm = new FolderLinkViewModels
                    {
                        FolderId = f.FolderId,
                        FolderName = f.FolderName
                    };
                    listFolder.Add(flvm);
                    if (f.Folder2 != null && f.Folder2.FolderId != 0)
                    {
                        f = db.Folders.Find(f.ParrentId);
                    }
                    else
                    {
                        break;
                    }

                };
                listFolder.Reverse();
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                db.Dispose();
            }
            return listFolder;
        }


    }
}