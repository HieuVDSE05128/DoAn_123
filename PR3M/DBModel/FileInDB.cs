namespace PR3M.DBModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("FileInDB")]
    public partial class FileInDB
    {
        [Key]
        public int FileId { get; set; }

        [Required]
        public string FileName { get; set; }

        [Required]
        [StringLength(10)]
        public string MIMEType { get; set; }

        public string Description { get; set; }

        public bool IsHide { get; set; }

        public bool IsDelete { get; set; }

        public bool IsPublic { get; set; }

        [Required]
        [StringLength(50)]
        public string LaunchedBy { get; set; }

        public DateTime LaunchedDate { get; set; }

        [Required]
        [StringLength(50)]
        public string LastEditBy { get; set; }

        public DateTime LastEditTime { get; set; }

        public int FolderId { get; set; }

        public virtual Folder Folder { get; set; }

        public virtual User User { get; set; }

        public virtual User User1 { get; set; }
    }
}
