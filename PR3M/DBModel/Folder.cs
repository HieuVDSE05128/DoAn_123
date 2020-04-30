namespace PR3M.DBModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Folder")]
    public partial class Folder
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Folder()
        {
            FileInDBs = new HashSet<FileInDB>();
            Folder1 = new HashSet<Folder>();
        }

        public int FolderId { get; set; }

        [Required]
        public string FolderName { get; set; }

        public bool IsDelete { get; set; }

        [Required]
        [StringLength(50)]
        public string CreateBy { get; set; }

        public DateTime CreateTime { get; set; }

        public int PRSystemId { get; set; }

        public int? ParrentId { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FileInDB> FileInDBs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Folder> Folder1 { get; set; }

        public virtual Folder Folder2 { get; set; }

        public virtual PRSystem PRSystem { get; set; }

        public virtual User User { get; set; }
    }
}
