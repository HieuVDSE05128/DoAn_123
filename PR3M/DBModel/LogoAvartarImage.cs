namespace PR3M.DBModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LogoAvartarImage")]
    public partial class LogoAvartarImage
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int PostId { get; set; }

        public int MaterialId { get; set; }

        public DateTime LastChangeTime { get; set; }

        [Required]
        [StringLength(50)]
        public string LastChangeBy { get; set; }

        public virtual Material Material { get; set; }

        public virtual Post Post { get; set; }

        public virtual User User { get; set; }
    }
}
