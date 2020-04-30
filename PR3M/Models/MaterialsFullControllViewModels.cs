using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PR3M.DBModel;
namespace PR3M.Models
{
    public class MaterialsFullControllViewModels
    {

        public User Users { get; set; }
        public IEnumerable<Folder> FoldersInside { get; set; }
        public Folder CurrentFolder { get; set; }
    }

    public class MaterialCreateViewModel
    {
        public string Name { get; set; }

        public string DisplayName { get; set; }

        public int PostId { get; set; }

        public string MIMEType { get; set; }

    }

    public class MaterialEditViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string DisplayName { get; set; }
        public bool IsHide { get; set; }
        public string MIMEType { get; set; }
        public string ImageAvatar { get; set; }
        public string FolderPath { get; set; }

        public int PostId { get; set; }
    }


}