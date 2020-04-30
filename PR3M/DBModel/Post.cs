namespace PR3M.DBModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Post")]
    public partial class Post
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Post()
        {
            Materials = new HashSet<Material>();
        }

        public int PostId { get; set; }

        [Required]
        public string PostTitle { get; set; }

        public string PostEngTitle { get; set; }

        public string PostHashRealFolder { get; set; }

        public DateTime LaunchedDate { get; set; }

        [Required]
        [StringLength(50)]
        public string CreateBy { get; set; }

        public bool IsDelete { get; set; }

        public bool IsHide { get; set; }

        public bool IsPublic { get; set; }

        public bool IsInLogoPost { get; set; }

        public int Position { get; set; }

        public int PRSystemId { get; set; }

        public DateTime? DeleteTime { get; set; }

        public virtual LogoAvartarImage LogoAvartarImage { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Material> Materials { get; set; }

        public virtual PRSystem PRSystem { get; set; }

        public virtual User User { get; set; }
    }
}
