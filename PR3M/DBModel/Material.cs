namespace PR3M.DBModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Material")]
    public partial class Material
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Material()
        {
            LogoAvartarImages = new HashSet<LogoAvartarImage>();
        }

        public int MaterialId { get; set; }

        [Required]
        [StringLength(100)]
        public string MaterialName { get; set; }

        [Required]
        [StringLength(100)]
        public string MaterialDisplayName { get; set; }

        public DateTime LaunchedDate { get; set; }

        [Required]
        [StringLength(50)]
        public string CreateBy { get; set; }

        public bool IsDelete { get; set; }

        public bool IsHilde { get; set; }

        public bool IsPublic { get; set; }

        public int PositionInFolder { get; set; }

        [StringLength(50)]
        public string MaterialType { get; set; }

        public string FolderName { get; set; }

        public string MaterialMD5Encrypt { get; set; }

        public int PostId { get; set; }

        [Required]
        [StringLength(10)]
        public string MIMEType { get; set; }

        public DateTime? DeleteTime { get; set; }

        public string ImageAvatar { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<LogoAvartarImage> LogoAvartarImages { get; set; }

        public virtual Post Post { get; set; }

        public virtual User User { get; set; }
    }
}
